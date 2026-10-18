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
const names = new Map(readFileSync(new URL('../protocol/opcodes.csv', import.meta.url), 'utf8').split('\n').filter((l) => l.startsWith('accept,')).map((l) => { const p = l.split(','); return [Number(p[1]), p[3]]; }));
const steps = JSON.parse(process.argv[2] || '[]');
const show = new Set((process.env.SHOW || '').split(',').filter(Boolean).map(Number));
const seen = [];
ws.onmessage = (e) => {
  const p = dec(recvKey, new Uint8Array(e.data));
  const v = new DataView(p.buffer);
  const code = v.getUint16(6);
  seen.push(code);
  const line = `<- ${code} ${names.get(code) || '?'}`;
  if (show.has(code)) {
    const msg = { 150: 'ArmyMsg', 4426: 'MountInfoMsg', 4427: 'MountAvatarMsg', 4595: 'RoomEnterMsg' }[code];
    const d = msg ? decode(msg, p.subarray(20)) : {};
    console.log(line, JSON.stringify(process.env.KEYS ? Object.fromEntries(process.env.KEYS.split(",").map((k) => [k, d[k]])) : d, (k, x) => (typeof x === "bigint" ? Number(x) : x)).slice(0, 400));
  } else console.log(line);
};
ws.onopen = async () => {
  send(20001, 'LoginReqMsg', { key: 'local', ekeys });
  sendKey = [...ekeys];
  const wait = (ms) => new Promise((r) => setTimeout(r, ms));
  await wait(400);
  for (const [code, msg, obj] of steps) {
    console.log(`-> ${code} ${JSON.stringify(obj || {})}`);
    send(code, msg, obj || {});
    await wait(700);
  }
  await wait(800);
  process.exit(0);
};
