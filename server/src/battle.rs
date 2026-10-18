use crate::game::{now_ms, Outgoing, Shared};
use crate::packet::build;
use serde_json::{json, Map, Value};
use std::collections::HashMap;
use std::sync::{Arc, Mutex, OnceLock};
use std::time::{Duration, Instant};

const FRAME_MS: u64 = 40;
const FPS: u64 = 25;

#[derive(Clone, Default)]
struct SkillTpl {
    name: String,
    use_way: i64,
    accept: i64,
    action: i64,
    cost: i64,
    p1: i64,
    cooldown: u64,
    son_type: i64,
    magic: bool,
}

#[derive(Clone, Copy)]
struct ActionTpl {
    hits: usize,
    finish: u64,
    melee: bool,
}

#[derive(Clone, Default)]
struct UnitTpl {
    name: String,
    job: i64,
    default_skill: i64,
    ai: i64,
    skills: Vec<i64>,
    live: i64,
    attack: i64,
    defence: i64,
    mattack: i64,
    mdefence: i64,
    force_hit: i64,
    parry: i64,
    magic: bool,
    res: String,
}

struct Templates {
    skills: HashMap<i64, SkillTpl>,
    actions: HashMap<i64, ActionTpl>,
    heroes: HashMap<i64, UnitTpl>,
    pawns: HashMap<i64, UnitTpl>,
    ais: HashMap<i64, Vec<i64>>,
}

fn each_tag(text: &str, tag: &str, mut f: impl FnMut(&HashMap<&str, &str>)) {
    let open = format!("<{tag} ");
    let mut rest = text;
    while let Some(i) = rest.find(&open) {
        let body = &rest[i + open.len()..];
        let end = body.find("/>").unwrap_or(body.len());
        f(&attrs(&body[..end]));
        rest = &body[end..];
    }
}

fn attrs(s: &str) -> HashMap<&str, &str> {
    let mut m = HashMap::new();
    let mut rest = s;
    while let Some(eq) = rest.find("=\"") {
        let key = rest[..eq].trim();
        let after = &rest[eq + 2..];
        let Some(close) = after.find('"') else { break };
        m.insert(key, &after[..close]);
        rest = &after[close + 1..];
    }
    m
}

fn num(a: &HashMap<&str, &str>, k: &str) -> i64 {
    a.get(k).and_then(|v| v.trim().parse().ok()).unwrap_or(0)
}

fn text(a: &HashMap<&str, &str>, k: &str) -> String {
    a.get(k).map(|s| s.to_string()).unwrap_or_default()
}

fn csv(s: &str) -> Vec<i64> {
    s.split(',').filter_map(|x| x.trim().parse().ok()).filter(|&x| x != 0).collect()
}

fn templates() -> &'static Templates {
    static T: OnceLock<Templates> = OnceLock::new();
    T.get_or_init(|| {
        let t0 = Instant::now();
        let dir = crate::root().join("raw/xml/tempinfos");
        let read = |f: &str| {
            std::fs::read_to_string(dir.join(f)).unwrap_or_else(|e| {
                eprintln!("[battle] template {f}: {e}");
                String::new()
            })
        };
        let mut skills = HashMap::new();
        each_tag(&read("SkillTempInfos.xml"), "SkillTempInfo", |a| {
            let desc = text(a, "Description").to_lowercase();
            skills.entry(num(a, "TemplateId")).or_insert_with(|| SkillTpl {
                name: text(a, "TemplateName"),
                use_way: num(a, "UseWay"),
                accept: num(a, "AcceptObject"),
                action: num(a, "ActionId"),
                cost: num(a, "Cost"),
                p1: num(a, "Parameter1"),
                cooldown: num(a, "CoolDown").max(0) as u64,
                son_type: num(a, "SonType"),
                magic: desc.contains("mágic") || desc.contains("magia"),
            });
        });
        let mut raw: HashMap<i64, (usize, usize, u64, bool)> = HashMap::new();
        each_tag(&read("ActionInfos.xml"), "ActionInfo", |a| {
            let e = raw.entry(num(a, "ActionId")).or_insert((0, 0, 0, false));
            match num(a, "ActionType") {
                3 if num(a, "Sex") != 1 => e.0 += 1,
                11 | 12 if num(a, "Sex") != 0 => e.1 += 1,
                99 => e.2 = e.2.max(num(a, "Frame").max(0) as u64),
                0 => e.3 = true,
                _ => {}
            }
        });
        let actions: HashMap<i64, ActionTpl> = raw
            .into_iter()
            .map(|(k, (dmg, shots, finish, melee))| {
                let hits = if dmg > 0 { dmg } else { shots.max(1) };
                (k, ActionTpl { hits, finish, melee })
            })
            .collect();
        let mut heroes = HashMap::new();
        each_tag(&read("GameHeroTemp.xml"), "GameHeroTempInfo", |a| {
            heroes.entry(num(a, "TemplateId")).or_insert_with(|| UnitTpl {
                name: text(a, "TemplateName"),
                job: num(a, "Job"),
                default_skill: num(a, "DefaultSkill"),
                ai: num(a, "AI"),
                skills: csv(&text(a, "SkillScript")),
                live: num(a, "Live"),
                attack: num(a, "Attack"),
                defence: num(a, "Defence"),
                mattack: num(a, "MagicAttack"),
                mdefence: num(a, "MagicDefence"),
                force_hit: num(a, "ForceHit"),
                parry: num(a, "Parry"),
                magic: num(a, "Job") == 3,
                res: text(a, "ResPath"),
            });
        });
        let mut pawns = HashMap::new();
        each_tag(&read("PawnTempInfos.xml"), "PawnTempInfo", |a| {
            pawns.entry(num(a, "TemplateId")).or_insert_with(|| UnitTpl {
                name: text(a, "PawnName"),
                job: 0,
                default_skill: num(a, "DefaultSkill"),
                ai: num(a, "AI"),
                skills: Vec::new(),
                live: num(a, "Live"),
                attack: num(a, "Attack"),
                defence: num(a, "Defence"),
                mattack: num(a, "MagicAttack"),
                mdefence: num(a, "MagicDefence"),
                force_hit: num(a, "ForceHit"),
                parry: num(a, "Parry"),
                magic: num(a, "AttackType") == 2,
                res: text(a, "Swf"),
            });
        });
        let mut ais = HashMap::new();
        each_tag(&read("HeroAis.xml"), "HeroAi", |a| {
            ais.entry(num(a, "ID")).or_insert_with(|| csv(&text(a, "Skills")));
        });
        eprintln!(
            "[battle] templates: {} skills, {} actions, {} heroes, {} pawns, {} ais ({} ms)",
            skills.len(),
            actions.len(),
            heroes.len(),
            pawns.len(),
            ais.len(),
            t0.elapsed().as_millis()
        );
        Templates { skills, actions, heroes, pawns, ais }
    })
}

pub fn preload() {
    std::thread::spawn(|| {
        templates();
    });
}

struct Unit {
    id: i64,
    side: i64,
    pos: i64,
    hero: bool,
    kind: i64,
    user_id: i64,
    name: String,
    hp: i64,
    max_hp: i64,
    sp: i64,
    sp_max: i64,
    patk: i64,
    pdef: i64,
    matk: i64,
    mdef: i64,
    crit: i64,
    parry: i64,
    magic: bool,
    default_skill: i64,
    skills: Vec<i64>,
    ai: Vec<i64>,
    ai_idx: usize,
    cd: HashMap<i64, u64>,
    busy_until: u64,
    next_act: u64,
    interval: u64,
    pending: Option<i64>,
}

impl Unit {
    fn alive(&self) -> bool {
        self.hp > 0
    }
    fn col(&self) -> i64 {
        (self.pos - 1).rem_euclid(3)
    }
    fn row(&self) -> i64 {
        (self.pos - 1).div_euclid(3)
    }
    fn tag(&self) -> String {
        format!("{}#{}", self.name, self.id)
    }
}

#[derive(Clone, Copy, PartialEq)]
enum Phase {
    Fight,
    Ending { at: u64, winner: i64 },
    Report { at: u64, winner: i64 },
    Done,
}

pub struct Battle {
    shared: Arc<Shared>,
    pid: u32,
    id: String,
    battle_type: i64,
    count_down: u64,
    self_id: i64,
    self_side: i64,
    units: Vec<Unit>,
    started: bool,
    start: Option<Instant>,
    frame: u64,
    auto: bool,
    aborted: bool,
    phase: Phase,
    report_win: Value,
    report_lose: Value,
    rng: u64,
    seq: i64,
}

fn gi(c: &Value, k: &str) -> Option<i64> {
    c.get(k).and_then(|v| v.as_i64().or_else(|| v.as_f64().map(|f| f as i64)).or_else(|| v.as_str().and_then(|s| s.trim().parse().ok())))
}

fn list(v: Option<&Value>) -> Option<Vec<i64>> {
    match v {
        Some(Value::Array(a)) => Some(a.iter().filter_map(|x| x.as_i64()).filter(|&x| x != 0).collect()),
        Some(Value::String(s)) => Some(csv(s)),
        _ => None,
    }
}

fn pick(c: &Value, k: &str, fallback: i64, default: i64) -> i64 {
    gi(c, k).unwrap_or(if fallback > 0 { fallback } else { default })
}

fn self_only(accept: i64) -> bool {
    matches!(accept, 4 | 18 | 24 | 26 | 27)
}

const UNIT_KEYS: [&str; 7] = ["skills", "ai", "default_skill", "interval", "magic", "skill_script", "spMax"];

impl Battle {
    pub fn new(shared: Arc<Shared>, cfg: &Value, player: &Value) -> (Battle, Vec<Outgoing>) {
        let t = templates();
        let pid = player["player_id"].as_u64().unwrap_or(1) as u32;
        let self_side = gi(cfg, "side").unwrap_or(1);
        let hero_iv = gi(cfg, "interval_hero").unwrap_or(20).max(1) as u64;
        let pawn_iv = gi(cfg, "interval_soldier").unwrap_or(30).max(1) as u64;
        let mut units = Vec::new();
        let mut heros = Vec::new();
        let mut soldiers = Vec::new();
        let mut pawn_temps: Vec<i64> = Vec::new();
        let hero_cfgs = cfg.get("heroes").or_else(|| cfg.get("heros")).and_then(|v| v.as_array()).cloned().unwrap_or_default();
        for (i, c) in hero_cfgs.iter().enumerate() {
            let temp = gi(c, "temp_id").unwrap_or(1);
            let tpl = t.heroes.get(&temp).cloned().unwrap_or_default();
            let kind = gi(c, "type").unwrap_or(1);
            let max_hp = gi(c, "max_hp").or_else(|| gi(c, "hp")).unwrap_or(if tpl.live > 0 { tpl.live } else { 1000 }).max(1);
            let skills = list(c.get("skills")).or_else(|| list(c.get("skill_script"))).unwrap_or_else(|| if kind == 3 { Vec::new() } else { tpl.skills.clone() });
            let ai = list(c.get("ai")).unwrap_or_else(|| t.ais.get(&tpl.ai).cloned().unwrap_or_default());
            let u = Unit {
                id: gi(c, "living_id").unwrap_or(i as i64 + 1),
                side: gi(c, "side").unwrap_or(if i == 0 { self_side } else { 3 - self_side }),
                pos: gi(c, "pos").unwrap_or(2),
                hero: true,
                kind,
                user_id: gi(c, "user_id").unwrap_or(0),
                name: c.get("nick_name").and_then(|v| v.as_str()).map(str::to_string).unwrap_or(tpl.name.clone()),
                hp: gi(c, "hp").unwrap_or(max_hp).clamp(0, max_hp),
                max_hp,
                sp: gi(c, "sp").unwrap_or(0),
                sp_max: gi(c, "spMax").unwrap_or(100),
                patk: pick(c, "phy_attack", tpl.attack, 300),
                pdef: pick(c, "phy_defence", tpl.defence, 100),
                matk: pick(c, "mag_attack", tpl.mattack, 300),
                mdef: pick(c, "mag_defence", tpl.mdefence, 100),
                crit: pick(c, "force_hit", tpl.force_hit, 0),
                parry: pick(c, "parry", tpl.parry, 0),
                magic: c.get("magic").and_then(|v| v.as_bool()).unwrap_or(tpl.magic),
                default_skill: pick(c, "default_skill", tpl.default_skill, 10000),
                skills,
                ai,
                ai_idx: 0,
                cd: HashMap::new(),
                busy_until: 0,
                next_act: 0,
                interval: gi(c, "interval").map(|v| v.max(1) as u64).unwrap_or(hero_iv),
                pending: None,
            };
            heros.push(Self::hero_msg(&u, c, &tpl, temp));
            units.push(u);
        }
        let soldier_cfgs = cfg.get("soldiers").and_then(|v| v.as_array()).cloned().unwrap_or_default();
        for (i, c) in soldier_cfgs.iter().enumerate() {
            let temp = gi(c, "temp_id").unwrap_or(2006);
            let tpl = t.pawns.get(&temp).cloned().unwrap_or_default();
            if !pawn_temps.contains(&temp) {
                pawn_temps.push(temp);
            }
            let max_hp = gi(c, "init_hp").or_else(|| gi(c, "hp")).unwrap_or(800).max(1);
            let u = Unit {
                id: gi(c, "living_id").unwrap_or(100 + i as i64),
                side: gi(c, "side").unwrap_or(self_side),
                pos: gi(c, "pos").unwrap_or(1),
                hero: false,
                kind: gi(c, "type").unwrap_or(1),
                user_id: 0,
                name: tpl.name.clone(),
                hp: gi(c, "hp").unwrap_or(max_hp).clamp(0, max_hp),
                max_hp,
                sp: 0,
                sp_max: 0,
                patk: pick(c, "phy_attack", tpl.attack, 60),
                pdef: pick(c, "phy_defence", tpl.defence, 10),
                matk: pick(c, "mag_attack", tpl.mattack, 60),
                mdef: pick(c, "mag_defence", tpl.mdefence, 10),
                crit: pick(c, "force_hit", tpl.force_hit, 0),
                parry: pick(c, "parry", tpl.parry, 0),
                magic: c.get("magic").and_then(|v| v.as_bool()).unwrap_or(tpl.magic),
                default_skill: pick(c, "default_skill", tpl.default_skill, 10),
                skills: Vec::new(),
                ai: list(c.get("ai")).unwrap_or_else(|| t.ais.get(&tpl.ai).cloned().unwrap_or_default()),
                ai_idx: 0,
                cd: HashMap::new(),
                busy_until: 0,
                next_act: 0,
                interval: gi(c, "interval").map(|v| v.max(1) as u64).unwrap_or(pawn_iv),
                pending: None,
            };
            let mut m = c.as_object().cloned().unwrap_or_default();
            for k in UNIT_KEYS {
                m.remove(k);
            }
            m.insert("living_id".into(), json!(u.id));
            m.insert("temp_id".into(), json!(temp));
            m.insert("type".into(), json!(u.kind));
            m.insert("side".into(), json!(u.side));
            m.insert("pos".into(), json!(u.pos));
            m.insert("init_hp".into(), json!(u.max_hp));
            m.insert("hp".into(), json!(u.hp));
            m.entry("army_pawn_id").or_insert(json!(u.id));
            m.entry("grade").or_insert(json!(1));
            m.insert("phy_attack".into(), json!(u.patk));
            m.insert("phy_defence".into(), json!(u.pdef));
            m.insert("mag_attack".into(), json!(u.matk));
            m.insert("mag_defence".into(), json!(u.mdef));
            m.insert("skillId".into(), json!(Self::all_skills(&u)));
            soldiers.push(Value::Object(m));
            units.push(u);
        }
        let self_id = units
            .iter()
            .find(|u| u.hero && u.kind != 3 && u.side == self_side && u.user_id == pid as i64)
            .or_else(|| units.iter().find(|u| u.hero && u.side == self_side))
            .map(|u| u.id)
            .unwrap_or(-1);
        let start_delay = gi(cfg, "start_delay").unwrap_or(25).max(1) as u64;
        let mut order: Vec<usize> = (0..units.len()).collect();
        order.sort_by_key(|&i| (units[i].col(), units[i].row(), units[i].side));
        for (n, &i) in order.iter().enumerate() {
            units[i].next_act = start_delay + n as u64 * 7;
        }
        let id = cfg.get("battle_id").and_then(|v| v.as_str()).unwrap_or("B1").to_string();
        let battle_type = gi(cfg, "battle_type").unwrap_or(1);
        let count_down = gi(cfg, "count_down").unwrap_or(180).max(0) as u64;
        let seed = gi(cfg, "seed").map(|s| s as u64).unwrap_or_else(now_ms);
        let b = Battle {
            shared,
            pid,
            id: id.clone(),
            battle_type,
            count_down,
            self_id,
            self_side,
            units,
            started: false,
            start: None,
            frame: 0,
            auto: cfg.get("auto").and_then(|v| v.as_bool()).unwrap_or(matches!(battle_type, 16 | 35 | 307)),
            aborted: false,
            phase: Phase::Fight,
            report_win: cfg.get("report").cloned().unwrap_or(json!({})),
            report_lose: cfg.get("report_defeat").cloned().unwrap_or(json!({})),
            rng: seed.wrapping_mul(0x9E37_79B9_7F4A_7C15) | 1,
            seq: 0,
        };
        let mut out = Vec::new();
        let fast = match cfg.get("fast_key") {
            Some(Value::Bool(false)) => None,
            Some(Value::String(s)) => Some(s.clone()),
            _ => b.auto_fast_key(),
        };
        if let Some(fk) = fast {
            out.push(b.pkt(64, "HeroFastKeyMsg", &json!({"fast_key": fk, "set_result": true}), 0, format!("fast_key={fk}")));
        }
        let mut prep = json!({
            "battle_id": id,
            "battle_type": battle_type,
            "map_temp_id": gi(cfg, "map").or_else(|| gi(cfg, "map_temp_id")).unwrap_or(1),
            "need_animation": false,
            "side": self_side,
            "has_assault": true,
            "use_way": 0,
            "attack_model": 2,
            "count_down": count_down,
            "battle_capity": 1,
            "battle_from": 0,
            "page": 1,
            "total_page": 1,
            "heros": heros,
            "soldiers": soldiers,
            "soldierTemplated": pawn_temps,
        });
        if let (Some(extra), Some(obj)) = (cfg.get("prepare").and_then(|v| v.as_object()), prep.as_object_mut()) {
            for (k, v) in extra {
                obj.insert(k.clone(), v.clone());
            }
        }
        let summary = b.units.iter().map(|u| format!("{}(side {} pos {} hp {})", u.tag(), u.side, u.pos, u.hp)).collect::<Vec<_>>().join(", ");
        eprintln!("[battle] {} type {} self #{}: {}", b.id, battle_type, self_id, summary);
        out.push(b.pkt(157, "BattlePrepareMsg", &prep, 0, format!("{} units", b.units.len())));
        (b, out)
    }

    fn hero_msg(u: &Unit, c: &Value, tpl: &UnitTpl, temp: i64) -> Value {
        let mut m: Map<String, Value> = c.as_object().cloned().unwrap_or_default();
        for k in UNIT_KEYS {
            m.remove(k);
        }
        m.entry("hero_id").or_insert(json!(u.id));
        m.insert("living_id".into(), json!(u.id));
        m.insert("temp_id".into(), json!(temp));
        m.insert("type".into(), json!(u.kind));
        m.insert("side".into(), json!(u.side));
        m.insert("pos".into(), json!(u.pos));
        m.insert("nick_name".into(), json!(u.name));
        m.insert("max_hp".into(), json!(u.max_hp));
        m.entry("init_hp").or_insert(json!(u.max_hp));
        m.insert("hp".into(), json!(u.hp));
        m.insert("sp".into(), json!(u.sp));
        m.insert("spMax".into(), json!(u.sp_max));
        m.entry("grade").or_insert(json!(1));
        m.entry("job").or_insert(json!(tpl.job));
        if u.kind == 3 && !tpl.res.is_empty() {
            m.entry("res").or_insert(json!(tpl.res));
        }
        m.insert("phy_attack".into(), json!(u.patk));
        m.insert("phy_defence".into(), json!(u.pdef));
        m.insert("mag_attack".into(), json!(u.matk));
        m.insert("mag_defence".into(), json!(u.mdef));
        m.insert("force_hit".into(), json!(u.crit));
        m.insert("parry".into(), json!(u.parry));
        m.insert("skillId".into(), json!(Self::all_skills(u)));
        Value::Object(m)
    }

    fn all_skills(u: &Unit) -> Vec<i64> {
        let mut v = vec![u.default_skill];
        for &s in u.skills.iter().chain(u.ai.iter()) {
            if !v.contains(&s) {
                v.push(s);
            }
        }
        v
    }

    fn auto_fast_key(&self) -> Option<String> {
        let t = templates();
        let u = self.units.iter().find(|u| u.id == self.self_id && u.kind != 3)?;
        let mut keys: Vec<String> = u.skills.iter().filter_map(|s| t.skills.get(s)).filter(|s| s.use_way == 1 && s.son_type > 0).map(|s| s.son_type.to_string()).take(5).collect();
        if keys.is_empty() {
            return None;
        }
        while keys.len() < 5 {
            keys.push("-1".into());
        }
        Some(format!("{},", keys.join(",")))
    }

    fn pkt(&self, code: u16, msg: &str, data: &Value, ext2: u64, label: String) -> Outgoing {
        let body = self.shared.schema.encode(msg, data);
        let name = self.shared.opcode_names.get(&("accept".to_string(), code)).cloned().unwrap_or_else(|| "?".into());
        Outgoing { delay_ms: 0, code, plain: build(code, self.pid, 0, ext2 as u32, &body), label: format!("{name} {msg} {label}") }
    }

    pub fn active(&self) -> bool {
        self.started && !self.aborted && self.phase != Phase::Done
    }

    pub fn pending_start(&self) -> bool {
        !self.started && !self.aborted
    }

    pub fn mark_started(&mut self) {
        self.started = true;
    }

    pub fn abort(&mut self) {
        self.aborted = true;
    }

    pub fn set_auto(&mut self, on: bool) {
        self.auto = on;
        eprintln!("[battle] {} auto fight {}", self.id, if on { "on" } else { "off" });
    }

    fn now(&self) -> u64 {
        self.start.map(|s| s.elapsed().as_millis() as u64 / FRAME_MS).unwrap_or(0)
    }

    fn rand(&mut self, n: u64) -> u64 {
        self.rng ^= self.rng << 13;
        self.rng ^= self.rng >> 7;
        self.rng ^= self.rng << 17;
        if n == 0 { 0 } else { self.rng % n }
    }

    fn idx(&self, id: i64) -> Option<usize> {
        self.units.iter().position(|u| u.id == id)
    }

    fn begin(&mut self) -> Vec<Outgoing> {
        self.start = Some(Instant::now());
        self.frame = 0;
        eprintln!("[battle] {} start", self.id);
        let data = json!({"frame": 0, "mainType": self.battle_type, "count_down": self.count_down});
        vec![self.pkt(156, "BattleStartMsg", &data, 0, "frame 0".into())]
    }

    fn advance(&mut self) -> (Vec<Outgoing>, bool) {
        if self.aborted {
            return (Vec::new(), true);
        }
        let now = self.now();
        let mut outs = Vec::new();
        while self.frame < now && self.phase != Phase::Done {
            self.frame += 1;
            self.step(self.frame, &mut outs);
        }
        (outs, self.phase == Phase::Done)
    }

    fn step(&mut self, f: u64, outs: &mut Vec<Outgoing>) {
        match self.phase {
            Phase::Fight => {
                if self.count_down > 0 && f >= self.count_down * FPS {
                    let w = self.timeout_winner();
                    eprintln!("[battle] {} time over at frame {f}", self.id);
                    self.finish(w, f + FPS);
                    return;
                }
                loop {
                    let next = (0..self.units.len())
                        .filter(|&i| {
                            let u = &self.units[i];
                            u.alive() && ((u.pending.is_some() && f >= u.busy_until) || f >= u.next_act)
                        })
                        .min_by_key(|&i| (self.units[i].pending.is_none(), self.units[i].next_act, self.units[i].id));
                    let Some(i) = next else { break };
                    let dur = self.act(i, f, outs);
                    if let Some(w) = self.winner() {
                        self.finish(w, f + dur + FPS);
                        break;
                    }
                }
            }
            Phase::Ending { at, winner } if f >= at => {
                outs.push(self.prepare_over(winner, f));
                self.phase = Phase::Report { at: f + 2 * FPS, winner };
            }
            Phase::Report { at, winner } if f >= at => {
                outs.push(self.report(winner));
                self.phase = Phase::Done;
            }
            _ => {}
        }
    }

    fn finish(&mut self, winner: i64, at: u64) {
        eprintln!("[battle] {} side {winner} wins, ending at frame {at}", self.id);
        self.phase = Phase::Ending { at, winner };
    }

    fn winner(&self) -> Option<i64> {
        let alive = |s: i64| self.units.iter().any(|u| u.side == s && u.alive());
        let enemy = 3 - self.self_side;
        if !alive(enemy) {
            Some(self.self_side)
        } else if !alive(self.self_side) {
            Some(enemy)
        } else {
            None
        }
    }

    fn timeout_winner(&self) -> i64 {
        let ratio = |s: i64| {
            let (hp, max) = self.units.iter().filter(|u| u.side == s).fold((0i64, 0i64), |a, u| (a.0 + u.hp, a.1 + u.max_hp));
            hp as f64 / max.max(1) as f64
        };
        if ratio(self.self_side) > ratio(3 - self.self_side) { self.self_side } else { 3 - self.self_side }
    }

    fn usable(u: &Unit, s: i64, f: u64) -> bool {
        match templates().skills.get(&s) {
            Some(st) => f >= *u.cd.get(&s).unwrap_or(&0) && (!u.hero || u.sp + st.cost >= 0),
            None => false,
        }
    }

    fn choose(&mut self, i: usize, f: u64) -> i64 {
        let t = templates();
        let auto = self.auto;
        let self_id = self.self_id;
        let u = &mut self.units[i];
        if let Some(s) = u.pending.take() {
            if Self::usable(u, s, f) {
                return s;
            }
        }
        if u.hero && u.kind != 3 {
            if u.id != self_id || auto {
                let mut cands: Vec<i64> = u.skills.iter().copied().filter(|s| t.skills.get(s).is_some_and(|st| st.use_way == 1)).collect();
                cands.sort_by_key(|s| t.skills[s].cost);
                if let Some(s) = cands.into_iter().find(|&s| Self::usable(u, s, f)) {
                    return s;
                }
            }
            return u.default_skill;
        }
        let n = u.ai.len();
        for _ in 0..n {
            let s = u.ai[u.ai_idx % n];
            u.ai_idx += 1;
            if Self::usable(u, s, f) {
                return s;
            }
        }
        u.default_skill
    }

    fn enemies(&self, i: usize) -> Vec<usize> {
        let side = self.units[i].side;
        (0..self.units.len()).filter(|&j| self.units[j].side != side && self.units[j].alive()).collect()
    }

    fn random_n(&mut self, mut pool: Vec<usize>, n: usize) -> Vec<usize> {
        let mut out = Vec::new();
        while out.len() < n && !pool.is_empty() {
            let k = self.rand(pool.len() as u64) as usize;
            out.push(pool.swap_remove(k));
        }
        out.sort_by_key(|&j| self.units[j].pos);
        out
    }

    fn nearest_in_col(&self, i: usize, pool: &[usize], col: i64) -> Vec<usize> {
        let row = self.units[i].row();
        pool.iter().copied().filter(|&j| self.units[j].col() == col).min_by_key(|&j| ((self.units[j].row() - row).abs(), self.units[j].row())).into_iter().collect()
    }

    fn select(&mut self, i: usize, accept: i64) -> Vec<usize> {
        if self_only(accept) {
            return vec![i];
        }
        let pool = self.enemies(i);
        if pool.is_empty() {
            return pool;
        }
        let min_col = pool.iter().map(|&j| self.units[j].col()).min().unwrap_or(0);
        let max_col = pool.iter().map(|&j| self.units[j].col()).max().unwrap_or(0);
        match accept {
            3 => pool,
            5 => pool.iter().copied().min_by(|&a, &b| {
                let (ua, ub) = (&self.units[a], &self.units[b]);
                (ua.hp as f64 / ua.max_hp as f64).total_cmp(&(ub.hp as f64 / ub.max_hp as f64))
            }).into_iter().collect(),
            7 => self.nearest_in_col(i, &pool, max_col),
            8 => pool.into_iter().filter(|&j| self.units[j].col() == min_col).collect(),
            9 => pool.into_iter().filter(|&j| self.units[j].col() == max_col).collect(),
            10 => {
                let k = self.rand(pool.len() as u64) as usize;
                let r = self.units[pool[k]].row();
                pool.into_iter().filter(|&j| self.units[j].row() == r).collect()
            }
            14 => {
                let k = self.rand(pool.len() as u64) as usize;
                let c = self.units[pool[k]].col();
                pool.into_iter().filter(|&j| self.units[j].col() == c).collect()
            }
            15 => {
                let k = self.rand(pool.len() as u64) as usize;
                let first = pool[k];
                let (r, c) = (self.units[first].row(), self.units[first].col());
                let mut v: Vec<usize> = vec![first];
                v.extend(pool.into_iter().filter(|&j| j != first && (self.units[j].row() - r).abs() + (self.units[j].col() - c).abs() == 1));
                v
            }
            2 | 12 => self.random_n(pool, 2),
            16 | 21 => {
                let n = 2 + self.rand(3) as usize;
                self.random_n(pool, n)
            }
            19 => {
                let n = 1 + self.rand(2) as usize;
                self.random_n(pool, n)
            }
            20 => {
                let n = 2 + self.rand(2) as usize;
                self.random_n(pool, n)
            }
            1 | 17 | 25 => self.random_n(pool, 1),
            _ => self.nearest_in_col(i, &pool, min_col),
        }
    }

    fn hit(&mut self, a: usize, t: usize, p1: i64, magic: bool) -> (i64, bool, bool) {
        let (atk, crit) = {
            let u = &self.units[a];
            ((if magic { u.matk } else { u.patk }).max(1), u.crit.max(0))
        };
        let (def, parry) = {
            let u = &self.units[t];
            ((if magic { u.mdef } else { u.pdef }).max(0), u.parry.max(0))
        };
        let base = atk * p1 / 100;
        let mut dmg = base * atk / (atk + def);
        dmg = dmg * (95 + self.rand(11) as i64) / 100;
        let is_crit = self.rand(1000) < (crit * 1000 / (crit + 200)).min(500) as u64;
        if is_crit {
            dmg = dmg * 3 / 2;
        }
        let is_parry = self.rand(1000) < (parry * 1000 / (parry + 200)).min(300) as u64;
        if is_parry {
            dmg /= 2;
        }
        (dmg.max(1), is_crit, is_parry)
    }

    fn act(&mut self, i: usize, f: u64, outs: &mut Vec<Outgoing>) -> u64 {
        let t = templates();
        let skill = self.choose(i, f);
        let st = t.skills.get(&skill).cloned().unwrap_or(SkillTpl { accept: 6, p1: 100, ..Default::default() });
        let at = t.actions.get(&st.action).copied().unwrap_or(ActionTpl { hits: 1, finish: 30, melee: false });
        let targets = self.select(i, st.accept);
        let magic = self.units[i].magic || st.magic;
        let hits = at.hits.max(1) as i64;
        let mut damages = Vec::new();
        let mut notes = Vec::new();
        if st.p1 > 0 && !self_only(st.accept) {
            for &tg in &targets {
                let (total, crit, parry) = self.hit(i, tg, st.p1, magic);
                let total = total.max(hits);
                let per = total / hits;
                let mut hp = self.units[tg].hp;
                for h in 0..hits {
                    let v = if h == hits - 1 { total - per * (hits - 1) } else { per };
                    hp = (hp - v).max(0);
                    damages.push(json!({
                        "living_id": self.units[tg].id,
                        "damage_type": 6,
                        "damage_value": v,
                        "left_value": hp,
                        "extra_data": if crit { 1 } else { 0 },
                        "parry": parry,
                    }));
                }
                self.units[tg].hp = hp;
                notes.push(format!(
                    "{} -{}{}{} hp {}/{}{}",
                    self.units[tg].tag(),
                    total,
                    if crit { " crit" } else { "" },
                    if parry { " parry" } else { "" },
                    hp,
                    self.units[tg].max_hp,
                    if hp == 0 { " DEAD" } else { "" }
                ));
            }
        } else if !targets.is_empty() {
            notes.push(format!("on {}", targets.iter().map(|&j| self.units[j].tag()).collect::<Vec<_>>().join(" ")));
        }
        let dur = at.finish.max(10) + if at.melee { 16 } else { 0 } + 4;
        let u = &mut self.units[i];
        let old_sp = u.sp;
        if u.hero {
            u.sp = (u.sp + st.cost).clamp(0, u.sp_max.max(0));
        }
        let sp_added = u.sp - old_sp;
        if st.cooldown > 0 {
            u.cd.insert(skill, f + st.cooldown / FRAME_MS);
        }
        u.busy_until = f + dur;
        u.next_act = u.busy_until + u.interval;
        let (uid, sp, tag) = (u.id, u.sp, u.tag());
        self.seq += 1;
        let data = json!({
            "battle_id": self.id,
            "frame": f,
            "order_id": skill,
            "is_passive": false,
            "living_id": uid,
            "sp": sp,
            "sp_added": sp_added,
            "damages": damages,
            "exec_frame": f,
            "attackOrderSeq": self.seq,
        });
        let sp_note = if self.units[i].hero { format!(" sp {old_sp}->{sp}") } else { String::new() };
        let label = format!("f={f} {tag} {}({skill}) x{hits}{sp_note} | {}", st.name, notes.join(", "));
        outs.push(self.pkt(153, "AttackOrderMsg", &data, f, label));
        dur
    }

    pub fn order(&mut self, hero: i64, skill: i64) -> Outgoing {
        let f = self.now();
        let reason = self.check_order(hero, skill, f);
        let mut aims = Vec::new();
        if reason.is_none() {
            if let Some(i) = self.idx(hero) {
                self.units[i].pending = Some(skill);
                let accept = templates().skills.get(&skill).map(|s| s.accept).unwrap_or(6);
                aims = self.select(i, accept).into_iter().map(|j| self.units[j].id).collect();
            }
        }
        let result = if reason.is_none() { 0 } else { 1 };
        eprintln!("[battle] {} f={f} order hero #{hero} skill {skill}: {}", self.id, reason.unwrap_or("accepted"));
        let data = json!({
            "battle_id": self.id,
            "hero_index_id": hero,
            "skill_id": skill,
            "result": result,
            "cast_time": 0,
            "qte_time": 0,
            "targetIndexs": aims,
        });
        self.pkt(75, "HeroOrderMsg", &data, 0, format!("hero #{hero} skill {skill} result {result}"))
    }

    fn check_order(&self, hero: i64, skill: i64, f: u64) -> Option<&'static str> {
        if !self.active() || self.phase != Phase::Fight {
            return Some("battle not running");
        }
        if hero != self.self_id {
            return Some("not the player hero");
        }
        let Some(i) = self.idx(hero) else { return Some("unknown hero") };
        let u = &self.units[i];
        if !u.alive() {
            return Some("hero is dead");
        }
        if u.pending.is_some() {
            return Some("another skill is pending");
        }
        let Some(st) = templates().skills.get(&skill) else { return Some("unknown skill") };
        if !u.skills.contains(&skill) || st.use_way != 1 {
            return Some("skill not on the hero bar");
        }
        if u.sp + st.cost < 0 {
            return Some("not enough sp");
        }
        if f < *u.cd.get(&skill).unwrap_or(&0) {
            return Some("cooldown");
        }
        None
    }

    fn prepare_over(&self, winner: i64, f: u64) -> Outgoing {
        let mut livings: Vec<Value> = Vec::new();
        for u in self.units.iter().filter(|u| u.alive() && u.hero) {
            livings.push(json!({"calc_type": if u.side == winner { 3 } else { 4 }, "living_id": u.id, "sp": u.sp}));
        }
        if !livings.iter().any(|v| v["calc_type"] == 3) {
            for u in self.units.iter().filter(|u| u.alive() && u.side == winner) {
                livings.push(json!({"calc_type": 3, "living_id": u.id, "sp": u.sp}));
            }
        }
        let data = json!({"frame": f, "prepareOverLivings": livings});
        self.pkt(154, "PrepareOverMsg", &data, f, format!("f={f} winner side {winner}"))
    }

    fn report(&self, winner: i64) -> Outgoing {
        let win = winner == self.self_side;
        let mut data = if win { self.report_win.clone() } else { self.report_lose.clone() };
        if !data.is_object() {
            data = json!({});
        }
        data["battle_result"] = json!(if win { 1 } else { 2 });
        self.pkt(4103, "BattleReportMsg", &data, 0, format!("{}", if win { "victory" } else { "defeat" }))
    }
}

pub async fn run(b: Arc<Mutex<Battle>>, tx: tokio::sync::mpsc::UnboundedSender<crate::Out>) {
    let first = match b.lock() {
        Ok(mut g) => g.begin(),
        Err(_) => return,
    };
    if !send(&tx, first) {
        return;
    }
    let mut iv = tokio::time::interval(Duration::from_millis(FRAME_MS));
    iv.set_missed_tick_behavior(tokio::time::MissedTickBehavior::Skip);
    loop {
        iv.tick().await;
        let (outs, done) = match b.lock() {
            Ok(mut g) => g.advance(),
            Err(_) => break,
        };
        if !send(&tx, outs) || done {
            break;
        }
    }
}

fn send(tx: &tokio::sync::mpsc::UnboundedSender<crate::Out>, outs: Vec<Outgoing>) -> bool {
    for o in outs {
        if tx.send(crate::Out::Pkt(o.plain, format!("{:5} {}", o.code, o.label))).is_err() {
            return false;
        }
    }
    true
}
