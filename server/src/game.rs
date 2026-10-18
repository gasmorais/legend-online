use crate::battle::Battle;
use crate::packet::{build, Cipher, Packet, Reader};
use crate::proto::Schema;
use serde_json::{json, Map, Value};
use std::collections::HashMap;
use std::path::PathBuf;
use std::sync::{Arc, Mutex};

pub struct Shared {
    pub schema: Schema,
    pub opcode_names: HashMap<(String, u16), String>,
    pub flows_path: PathBuf,
    pub live: tokio::sync::Mutex<Vec<(Arc<tokio::sync::Mutex<Session>>, tokio::sync::mpsc::UnboundedSender<crate::Out>)>>,
}

pub struct Outgoing {
    pub delay_ms: u64,
    pub code: u16,
    pub plain: Vec<u8>,
    pub label: String,
}

pub struct Session {
    pub reader: Reader,
    shared: Arc<Shared>,
    vars: Map<String, Value>,
    seq: i64,
    pub new_send_key: Option<[u8; 8]>,
    battle: Option<Arc<Mutex<Battle>>>,
    pub battle_start: Option<Arc<Mutex<Battle>>>,
}

impl Session {
    pub fn new(shared: Arc<Shared>) -> Self {
        Self { reader: Reader::new(), shared, vars: Map::new(), seq: 1000, new_send_key: None, battle: None, battle_start: None }
    }

    pub fn name(&self, dir: &str, code: u16) -> String {
        self.shared.opcode_names.get(&(dir.to_string(), code)).cloned().unwrap_or_else(|| "?".into())
    }

    fn flows(&self) -> Value {
        let parse = |path: &std::path::Path| -> Value {
            let text = std::fs::read_to_string(path).unwrap_or_else(|_| "{}".into());
            serde_json::from_str(&text).unwrap_or_else(|e| {
                eprintln!("[flows] invalid JSON in {}: {e}", path.display());
                json!({})
            })
        };
        let mut main = parse(&self.shared.flows_path);
        let dir = self.shared.flows_path.with_file_name("flows");
        let mut extra: Vec<PathBuf> = std::fs::read_dir(&dir)
            .map(|rd| rd.filter_map(|e| e.ok().map(|e| e.path())).filter(|p| p.extension().is_some_and(|x| x == "json")).collect())
            .unwrap_or_default();
        extra.sort();
        let mut rules = main.get("rules").and_then(|r| r.as_array()).cloned().unwrap_or_default();
        for p in extra {
            if let Some(r) = parse(&p).get("rules").and_then(|r| r.as_array()) {
                rules.extend(r.iter().cloned());
            }
        }
        main["rules"] = Value::Array(rules);
        main
    }

    pub fn on_bytes(&mut self, data: &[u8]) -> Vec<Outgoing> {
        let packets = self.reader.push(data);
        let mut out = Vec::new();
        for p in packets {
            out.extend(self.on_packet(&p));
        }
        out
    }

    pub fn push(&mut self, name: &str) -> Vec<Outgoing> {
        let flows = self.flows();
        let player = flows.get("player").cloned().unwrap_or(json!({}));
        let rules = flows.get("rules").and_then(|r| r.as_array()).cloned().unwrap_or_default();
        let key = format!("push:{name}");
        let Some(rule) = rules.iter().find(|r| r["on"].as_str() == Some(key.as_str())) else {
            eprintln!("[debug] regra inexistente: {key}");
            return vec![];
        };
        eprintln!("[debug] {key}");
        self.run_rule(rule, json!({}), &player)
    }

    fn run_rule(&mut self, rule: &Value, req: Value, player: &Value) -> Vec<Outgoing> {
        let ctx = json!({"player": player, "req": req, "var": Value::Object(self.vars.clone())});
        if let Some(set) = rule["set"].as_object() {
            for (k, v) in set {
                let val = self.subst(v, &ctx);
                self.vars.insert(k.clone(), val);
            }
        }
        let ctx = json!({"player": player, "req": ctx["req"], "var": Value::Object(self.vars.clone())});
        let mut out = Vec::new();
        for item in rule["send"].as_array().cloned().unwrap_or_default() {
            let code = item["code"].as_u64().unwrap_or(0) as u16;
            let msg = item["msg"].as_str().unwrap_or("");
            let data = self.subst(&item["data"], &ctx);
            let body = if msg.is_empty() { Vec::new() } else { self.shared.schema.encode(msg, &data) };
            let ext1 = self.subst(&item["extend1"], &ctx).as_u64().unwrap_or(0) as u32;
            let ext2 = self.subst(&item["extend2"], &ctx).as_u64().unwrap_or(0) as u32;
            let pid = player["player_id"].as_u64().unwrap_or(1) as u32;
            out.push(Outgoing {
                delay_ms: item["delay"].as_u64().unwrap_or(0),
                code,
                plain: build(code, pid, ext1, ext2, &body),
                label: format!("{} {}", self.name("accept", code), msg),
            });
        }
        if let Some(cfg) = rule.get("battle").filter(|v| v.is_object()) {
            let cfg = self.subst(cfg, &ctx);
            if let Some(old) = self.battle.take() {
                if let Ok(mut g) = old.lock() {
                    g.abort();
                }
            }
            let (b, outs) = Battle::new(self.shared.clone(), &cfg, player);
            out.extend(outs);
            self.battle = Some(Arc::new(Mutex::new(b)));
        }
        out
    }

    pub fn close(&mut self) {
        if let Some(b) = self.battle.take() {
            if let Ok(mut g) = b.lock() {
                g.abort();
            }
        }
    }

    fn battle_packet(&mut self, p: &Packet) -> Option<Vec<Outgoing>> {
        let b = self.battle.clone()?;
        let mut g = b.lock().ok()?;
        match p.code {
            10007 | 10018 if g.pending_start() => {
                let req = self.shared.schema.decode("LoadOverMsg", &p.body);
                eprintln!("[socket] <- {:5} {:30} {} (battle engine)", p.code, self.name("send", p.code), compact(&req));
                g.mark_started();
                drop(g);
                self.battle_start = Some(b);
                Some(Vec::new())
            }
            10008 if g.active() => {
                let req = self.shared.schema.decode("UseSkillMsg", &p.body);
                eprintln!("[socket] <- {:5} {:30} {} (battle engine)", p.code, self.name("send", p.code), compact(&req));
                let hero = req["hero_id"].as_i64().unwrap_or(0);
                let skill = req["skill_id"].as_i64().unwrap_or(0);
                Some(vec![g.order(hero, skill)])
            }
            10020 if g.active() => {
                let req = self.shared.schema.decode("AttackModeMsg", &p.body);
                eprintln!("[socket] <- {:5} {:30} {} (battle engine)", p.code, self.name("send", p.code), compact(&req));
                g.set_auto(req["mode"].as_i64() == Some(1));
                Some(Vec::new())
            }
            _ => None,
        }
    }

    fn on_packet(&mut self, p: &Packet) -> Vec<Outgoing> {
        let flows = self.flows();
        let player = flows.get("player").cloned().unwrap_or(json!({}));
        if p.code == 20001 {
            let req = self.shared.schema.decode("LoginReqMsg", &p.body);
            if let Some(ek) = req["ekeys"].as_array() {
                let mut key = [0u8; 8];
                for (i, v) in ek.iter().take(8).enumerate() {
                    key[i] = v.as_i64().unwrap_or(0) as u8;
                }
                self.reader.cipher = Cipher::new(key);
                self.new_send_key = Some(key);
                eprintln!("[socket] <- 20001 login  chaves trocadas {key:?}");
            }
        }
        if let Some(out) = self.battle_packet(p) {
            return out;
        }
        let rules = flows.get("rules").and_then(|r| r.as_array()).cloned().unwrap_or_default();
        let mut out = Vec::new();
        let mut matched = false;
        for rule in rules.iter().filter(|r| r["on"].as_u64() == Some(p.code as u64)) {
            let req = match rule["req"].as_str() {
                Some(m) => self.shared.schema.decode(m, &p.body),
                None => json!({}),
            };
            if let Some(cond) = rule["if"].as_object() {
                if !cond.iter().all(|(k, v)| req.get(k).unwrap_or(&Value::Null) == v || (v.is_null() && req.get(k).is_none())) {
                    continue;
                }
            }
            if let Some(cond) = rule["ifvar"].as_object() {
                if !cond.iter().all(|(k, v)| self.vars.get(k).unwrap_or(&Value::Null) == v) {
                    continue;
                }
            }
            matched = true;
            eprintln!("[socket] <- {:5} {:30} {}", p.code, self.name("send", p.code), compact(&req));
            out.extend(self.run_rule(rule, req, &player));
            if rule["stop"].as_bool().unwrap_or(true) {
                break;
            }
        }
        if !matched {
            eprintln!("[socket] <- {:5} {:30} (sem regra) {} bytes", p.code, self.name("send", p.code), p.body.len());
        }
        out
    }

    fn subst(&mut self, v: &Value, ctx: &Value) -> Value {
        match v {
            Value::String(s) if s.starts_with('$') => {
                match s.as_str() {
                    "$now" => return json!(now_ms() / 1000),
                    "$nowms" => return json!(now_ms()),
                    "$nowdt" => return json!(datetime(now_ms(), -3)),
                    "$seq" => {
                        self.seq += 1;
                        return json!(self.seq);
                    }
                    _ => {}
                }
                let path: Vec<&str> = s[1..].split('.').collect();
                let mut cur = ctx;
                for part in &path {
                    match cur.get(*part) {
                        Some(n) => cur = n,
                        None => return Value::Null,
                    }
                }
                cur.clone()
            }
            Value::Array(a) => Value::Array(a.iter().map(|x| self.subst(x, ctx)).collect()),
            Value::Object(o) => Value::Object(o.iter().map(|(k, x)| (k.clone(), self.subst(x, ctx))).collect()),
            other => other.clone(),
        }
    }
}

fn compact(v: &Value) -> String {
    let s = v.to_string();
    if s.len() > 160 { format!("{}…", &s[..160]) } else { s }
}

pub fn datetime(ms: u64, tz_hours: i64) -> String {
    let secs = (ms / 1000) as i64 + tz_hours * 3600;
    let (days, rem) = (secs.div_euclid(86400), secs.rem_euclid(86400));
    let z = days + 719468;
    let era = z.div_euclid(146097);
    let doe = z - era * 146097;
    let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
    let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    let mp = (5 * doy + 2) / 153;
    let d = doy - (153 * mp + 2) / 5 + 1;
    let m = if mp < 10 { mp + 3 } else { mp - 9 };
    let y = yoe + era * 400 + if m <= 2 { 1 } else { 0 };
    format!("{y:04}-{m:02}-{d:02} {:02}:{:02}:{:02}", rem / 3600, rem % 3600 / 60, rem % 60)
}

pub fn now_ms() -> u64 {
    std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).unwrap().as_millis() as u64
}

pub struct Writer {
    pub cipher: Cipher,
}

impl Writer {
    pub fn seal(&mut self, mut pkt: Vec<u8>) -> Vec<u8> {
        self.cipher.encrypt(&mut pkt);
        pkt
    }
}
