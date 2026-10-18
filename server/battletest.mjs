import { readFileSync } from 'node:fs';

const PORT = Number(process.env.LG_PORT || 8787);
const RULE = process.argv[2] || 'battle';
const MAX_SKILLS = Number(process.env.SKILLS || 6);
const AUTO = process.env.AUTO === '1';
const schema = JSON.parse(readFileSync(new URL('../protocol/proto.json', import.meta.url)));
const skillNames = new Map();
for (const m of readFileSync(new URL('../raw/xml/tempinfos/SkillTempInfos.xml', import.meta.url), 'utf8').matchAll(/<SkillTempInfo TemplateId="(\d+)" TemplateName="([^"]*)"/g)) {
  if (!skillNames.has(Number(m[1]))) skillNames.set(Number(m[1]), m[2]);
}

const KEY = [174, 191, 86, 120, 171, 205, 239, 241];
const enc = (key, d) => { for (let i = 0; i < d.length; i++) { if (i > 0) { const k = i % 8; key[k] = ((key[k] + d[i - 1]) & 255) ^ (i & 255); d[i] = ((d[i] ^ key[k]) + d[i - 1]) & 255; } else d[0] ^= key[0]; } return d; };
const dec = (key, r) => { const o = new Uint8Array(r.length); for (let i = 0; i < r.length; i++) { if (i > 0) { const k = i % 8; key[k] = ((key[k] + r[i - 1]) & 255) ^ (i & 255); o[i] = ((r[i] - r[i - 1]) & 255) ^ key[k]; } else o[0] = r[0] ^ key[0]; } return o; };

const varint = (n) => { const b = []; let v = BigInt.asUintN(64, BigInt(n)); do { let x = Number(v & 127n); v >>= 7n; if (v) x |= 128; b.push(x); } while (v); return b; };
function encode(msg, obj) {
  const out = [];
  for (const f of schema[msg].fields) {
    const v = obj[f.name];
    if (v === undefined) continue;
    for (const item of f.repeated ? v : [v]) {
      if (f.type === 'STRING') { const b = [...Buffer.from(String(item))]; out.push(...varint((f.num << 3) | 2), ...varint(b.length), ...b); }
      else if (f.type === 'MESSAGE') { const b = encode(f.msg, item); out.push(...varint((f.num << 3) | 2), ...varint(b.length), ...b); }
      else if (f.type === 'BOOL') out.push(...varint(f.num << 3), item ? 1 : 0);
      else out.push(...varint(f.num << 3), ...varint(item));
    }
  }
  return out;
}
function readVarint(b, p) { let n = 0n, s = 0n; for (;;) { const x = b[p++]; n |= BigInt(x & 127) << s; s += 7n; if (!(x & 128)) break; } return [n, p]; }
function decode(msg, b) {
  const fields = schema[msg]?.fields || [];
  const o = {};
  let p = 0;
  while (p < b.length) {
    let k; [k, p] = readVarint(b, p);
    const num = Number(k >> 3n), wire = Number(k & 7n);
    const f = fields.find((x) => x.num === num);
    const name = f ? f.name : `#${num}`;
    let val;
    if (wire === 0) {
      let n; [n, p] = readVarint(b, p);
      val = f?.type === 'BOOL' ? n !== 0n : Number(BigInt.asIntN(64, n));
    } else if (wire === 2) {
      let len; [len, p] = readVarint(b, p);
      const sub = b.subarray(p, p + Number(len)); p += Number(len);
      if (f?.type === 'STRING') val = Buffer.from(sub).toString('utf8');
      else if (f?.type === 'MESSAGE') val = decode(f.msg, sub);
      else { const arr = []; let q = 0; while (q < sub.length) { let n; [n, q] = readVarint(sub, q); arr.push(Number(BigInt.asIntN(64, n))); } val = arr; }
    } else if (wire === 5) { p += 4; val = null; } else if (wire === 1) { p += 8; val = null; } else break;
    if (f?.repeated) { o[name] ??= []; Array.isArray(val) && f.type !== 'MESSAGE' && f.type !== 'STRING' ? o[name].push(...val) : o[name].push(val); }
    else o[name] = val;
  }
  return o;
}
function packet(code, body) {
  const len = 20 + body.length, b = new Uint8Array(len), v = new DataView(b.buffer);
  v.setUint16(0, 29099); v.setUint16(2, len); v.setUint16(6, code); v.setUint32(8, 1); b.set(body, 20);
  let s = 119; for (let i = 6; i < len; i++) s += b[i]; v.setUint16(4, s & 0x7f7f); return b;
}

const ekeys = [11, 22, 33, 44, 55, 66, 77, 88];
let sendKey = [...KEY];
const recvKey = [...ekeys];
const ws = new WebSocket(`ws://localhost:${PORT}/socket`);
ws.binaryType = 'arraybuffer';
const send = (code, msg, obj) => { ws.send(enc(sendKey, packet(code, Uint8Array.from(msg ? encode(msg, obj) : [])))); };

const units = new Map();
let battleId = '', selfId = -1, startAt = 0, skillsUsed = 0, pendingSkill = 0, skillTimer = null, rotation = [], rotIdx = 0;
const stats = { attacks: 0, orders: 0, accepted: 0, rejected: 0 };
const nm = (id) => { const u = units.get(id); return u ? `${u.name}#${id}` : `#${id}`; };
const sk = (id) => `${skillNames.get(id) || '?'}(${id})`;
const clock = () => `+${((Date.now() - startAt) / 1000).toFixed(1).padStart(5)}s`;
const log = (s) => console.log(startAt ? `${clock()} ${s}` : s);

function scheduleSkill(ms) {
  clearTimeout(skillTimer);
  if (AUTO || skillsUsed >= MAX_SKILLS || !rotation.length) return;
  skillTimer = setTimeout(() => {
    const skill = rotation[rotIdx++ % rotation.length];
    pendingSkill = skill;
    stats.orders++;
    log(`--> 10008 U_B_HERO_ORDER hero ${nm(selfId)} skill ${sk(skill)}`);
    send(10008, 'UseSkillMsg', { battle_id: battleId, hero_id: selfId, skill_id: skill });
    if (stats.orders === 1) {
      log(`--> 10008 U_B_HERO_ORDER hero ${nm(selfId)} skill ${sk(skill)} (duplicate, expect rejection)`);
      stats.orders++;
      send(10008, 'UseSkillMsg', { battle_id: battleId, hero_id: selfId, skill_id: skill });
    }
  }, ms);
}

function onPacket(code, ext2, body) {
  switch (code) {
    case 64: {
      const m = decode('HeroFastKeyMsg', body);
      log(`<-- 64 HeroFastKeyMsg fast_key="${m.fast_key}"`);
      break;
    }
    case 157: {
      const m = decode('BattlePrepareMsg', body);
      battleId = m.battle_id;
      log(`<-- 157 U_B_PREPARE battle ${m.battle_id} type ${m.battle_type} map ${m.map_temp_id} side ${m.side} count_down ${m.count_down}`);
      for (const h of m.heros || []) {
        units.set(h.living_id, { name: h.nick_name, side: h.side, hp: h.hp, max: h.max_hp, sp: h.sp ?? 0, hero: true });
        if (h.user_id === Number(process.env.PLAYER_ID || 1) && h.type !== 3) selfId = h.living_id;
        log(`      hero    ${nm(h.living_id)} side ${h.side} pos ${h.pos} type ${h.type} hp ${h.hp}/${h.max_hp} sp ${h.sp ?? 0} skills [${(h.skillId || []).join(',')}]`);
      }
      for (const s of m.soldiers || []) {
        units.set(s.living_id, { name: `Soldado${s.temp_id}`, side: s.side, hp: s.hp, max: s.init_hp, sp: 0 });
        log(`      soldier ${nm(s.living_id)} side ${s.side} pos ${s.pos} hp ${s.hp}/${s.init_hp} skills [${(s.skillId || []).join(',')}]`);
      }
      const me = (m.heros || []).find((h) => h.living_id === selfId);
      rotation = (me?.skillId || []).slice(1);
      setTimeout(() => {
        log(`--> 10007 U_B_USER_LOADOVER battle ${battleId}`);
        send(10007, 'LoadOverMsg', { army_id: 1, battle_id: battleId, server_name: 'Local' });
      }, 300);
      break;
    }
    case 156: {
      const m = decode('BattleStartMsg', body);
      startAt = Date.now();
      log(`<-- 156 U_B_START frame ${m.frame ?? 0} mainType ${m.mainType} count_down ${m.count_down}`);
      if (AUTO) { log('--> 10020 auto fight on'); send(10020, 'AttackModeMsg', { battle_id: battleId, mode: 1 }); }
      scheduleSkill(1500);
      break;
    }
    case 75: {
      const m = decode('HeroOrderMsg', body);
      const ok = (m.result ?? 0) === 0;
      ok ? stats.accepted++ : stats.rejected++;
      log(`<-- 75 U_B_HERO_ORDER hero ${nm(m.hero_index_id)} skill ${sk(m.skill_id)} result ${m.result ?? 0} ${ok ? 'OK' : 'REJECTED'} targets [${(m.targetIndexs || []).map(nm).join(', ')}]`);
      if (!ok && pendingSkill === m.skill_id && stats.accepted === 0) scheduleSkill(1200);
      break;
    }
    case 153: {
      const m = decode('AttackOrderMsg', body);
      stats.attacks++;
      const a = units.get(m.living_id);
      const parts = [];
      const byTarget = new Map();
      for (const d of m.damages || []) {
        const e = byTarget.get(d.living_id) || { sum: 0, left: 0, crit: false, parry: false, hits: 0 };
        e.sum += d.damage_value ?? 0; e.left = d.left_value ?? 0; e.crit ||= ((d.extra_data ?? 0) & 1) === 1; e.parry ||= !!d.parry; e.hits++;
        byTarget.set(d.living_id, e);
      }
      for (const [id, e] of byTarget) {
        const u = units.get(id);
        if (u) u.hp = e.left;
        parts.push(`${nm(id)} -${e.sum}${e.hits > 1 ? ` (${e.hits} hits)` : ''}${e.crit ? ' CRIT' : ''}${e.parry ? ' PARRY' : ''} left ${e.left}${e.left === 0 ? ' DEAD' : ''}`);
      }
      let spNote = '';
      if (a?.hero) { spNote = ` sp ${a.sp}->${m.sp ?? 0}`; a.sp = m.sp ?? 0; }
      log(`<-- 153 f=${String(m.frame ?? 0).padStart(4)} ext2=${ext2} ${nm(m.living_id)} ${sk(m.order_id)}${spNote} -> ${parts.join(', ') || '(no damage)'}`);
      if (m.living_id === selfId && m.order_id === pendingSkill) {
        skillsUsed++;
        pendingSkill = 0;
        scheduleSkill(2200);
      }
      break;
    }
    case 154: {
      const m = decode('PrepareOverMsg', body);
      log(`<-- 154 U_B_PREPARE_OVER frame ${m.frame} ${(m.prepareOverLivings || []).map((l) => `${nm(l.living_id)}:${l.calc_type === 3 ? 'Victory' : 'Failed'}`).join(' ')}`);
      break;
    }
    case 4103: {
      const m = decode('BattleReportMsg', body);
      log(`<-- 4103 U_BATTLE_REPORT ${m.battle_result === 1 ? 'VICTORY' : 'DEFEAT'} ${JSON.stringify(m)}`);
      log(`summary: ${stats.attacks} attack orders, ${stats.orders} skill requests (${stats.accepted} accepted, ${stats.rejected} rejected)`);
      for (const [id, u] of units) log(`      ${nm(id).padEnd(26)} side ${u.side} hp ${u.hp}/${u.max}${u.hero ? ` sp ${u.sp}` : ''}`);
      clearTimeout(skillTimer);
      ws.close();
      process.exit(0);
    }
    default:
      if (!startAt) log(`<-- ${code} (${body.length} bytes)`);
  }
}

ws.onopen = () => {
  send(20001, 'LoginReqMsg', { key: 'local', ekeys });
  sendKey = [...ekeys];
  setTimeout(async () => {
    if (/^\d+$/.test(RULE)) {
      log(`--> ${RULE} (empty body)`);
      send(Number(RULE), null);
      return;
    }
    const r = await fetch(`http://localhost:${PORT}/debug/${RULE}`);
    log(`GET /debug/${RULE}: ${await r.text()}`);
  }, 800);
};
ws.onmessage = (e) => {
  const p = dec(recvKey, new Uint8Array(e.data));
  const v = new DataView(p.buffer);
  onPacket(v.getUint16(6), v.getUint32(16), p.subarray(20));
};
ws.onerror = (e) => { console.log('socket error', e.message || e); process.exit(1); };
setTimeout(() => { console.log('timeout: no battle report'); process.exit(2); }, Number(process.env.TIMEOUT || 240000));
