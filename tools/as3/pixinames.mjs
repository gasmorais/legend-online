const P = await import(new URL('../../web/node_modules/pixi.js/lib/index.mjs', import.meta.url).href);
const names = new Set();
for (const C of [P.Container, P.Sprite, P.Graphics, P.Text, P.TilingSprite, P.Mesh]) {
  let o; try { o = new C(); } catch (e) { o = null; }
  if (o) for (const k of Object.getOwnPropertyNames(o)) names.add(k);
  for (let p = C.prototype; p && p !== Object.prototype; p = Object.getPrototypeOf(p)) for (const k of Object.getOwnPropertyNames(p)) names.add(k);
}
console.log(JSON.stringify([...names].sort()));
