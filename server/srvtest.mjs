const KEY = [174, 191, 86, 120, 171, 205, 239, 241];
const enc = (key, d) => { for (let i = 0; i < d.length; i++) { if (i > 0) { const k = i % 8; key[k] = ((key[k] + d[i - 1]) & 255) ^ (i & 255); d[i] = ((d[i] ^ key[k]) + d[i - 1]) & 255; } else d[0] ^= key[0]; } return d; };
const dec = (key, r) => { const o = new Uint8Array(r.length); for (let i = 0; i < r.length; i++) { if (i > 0) { const k = i % 8; key[k] = ((key[k] + r[i - 1]) & 255) ^ (i & 255); o[i] = ((r[i] - r[i - 1]) & 255) ^ key[k]; } else o[0] = r[0] ^ key[0]; } return o; };
const varint = (n) => { const b = []; do { let x = n & 127; n = Math.floor(n / 128); if (n) x |= 128; b.push(x); } while (n); return b; };
function packet(code, body) {
  const len = 20 + body.length, b = new Uint8Array(len), v = new DataView(b.buffer);
  v.setUint16(0, 29099); v.setUint16(2, len); v.setUint16(6, code); v.setUint32(8, 1); b.set(body, 20);
  let s = 119; for (let i = 6; i < len; i++) s += b[i]; v.setUint16(4, s & 0x7f7f); return b;
}
const ekeys = [11, 22, 33, 44, 55, 66, 77, 88];
const body = [0x12, 5, ...Buffer.from('local')]; for (const e of ekeys) body.push(0x18, ...varint(e));
const sendKey = [...KEY], recvKey = [...ekeys];
const ws = new WebSocket('ws://localhost:8787/socket'); ws.binaryType = 'arraybuffer';
ws.onopen = () => { ws.send(enc(sendKey, packet(20001, Uint8Array.from(body)))); };
ws.onmessage = (e) => {
  const raw = new Uint8Array(e.data); const p = dec(recvKey, raw); const v = new DataView(p.buffer);
  let s = 119; for (let i = 6; i < p.length; i++) s += p[i];
  console.log('recebido opcode', v.getUint16(6), 'len', v.getUint16(2), 'magic ok', v.getUint16(0) === 29099, 'checksum ok', (s & 0x7f7f) === v.getUint16(4),
    'nick:', Buffer.from(p.slice(20)).toString('latin1').match(/Jogador/) ? 'Jogador' : '?');
  ws.close();
};
ws.onerror = (e) => { console.log('erro', e.message); };
