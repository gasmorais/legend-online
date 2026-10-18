// @ts-nocheck -- classes dinâmicas ($.C) simulando código gerado
import { Container } from 'pixi.js';
import { $ } from './runtime';
import { currentStage } from './flash/display';

type Result = { name: string; ok: boolean; error?: string };

export async function runSelfTest(): Promise<{ passed: number; failed: number; results: Result[] }> {
  const results: Result[] = [];
  const test = async (name: string, fn: () => void | Promise<void>) => {
    try { await fn(); results.push({ name, ok: true }); } catch (err) {
      results.push({ name, ok: false, error: String((err as Error)?.stack ?? err) });
    }
  };
  const eq = (a: unknown, b: unknown, msg = '') => {
    if (!(a === b || (typeof a === 'number' && typeof b === 'number' && Math.abs(a - b) < 1e-6))) {
      throw new Error(`${msg} esperado ${JSON.stringify(b)}, obtido ${JSON.stringify(a)}`);
    }
  };
  const ok = (v: unknown, msg = '') => { if (!v) throw new Error(`falhou: ${msg}`); };
  const C = (n: string) => $.C(n);
  if (!currentStage() && (window as any).__app) (await import('./flash')).getStage((window as any).__app);

  await test('Dictionary: chaves objeto/primitivo, delete, in, for-in, values', () => {
    const Dictionary = C('flash.utils.Dictionary');
    const d: any = new Dictionary();
    const a: any = { id: 1 }, b: any = { id: 2 }, f: any = () => 0;
    d[a] = 'A';
    d[b] = 'B';
    d[f] = 'F';
    d['x'] = 1;
    d[5] = 'cinco';
    eq(d[a], 'A', 'd[a]');
    eq(d[b], 'B', 'd[b]');
    eq(d[f], 'F', 'd[f]');
    eq(d['5'], 'cinco', 'chave numérica');
    ok(a in d, 'a in d');
    ok(!(({} as any) in d), '{} in d');
    let n = 0;
    for (const k in d) { n++; ok(d[k] !== undefined, `d[${k}] via token`); }
    eq(n, 5, 'for-in');
    delete d[a];
    eq(d[a], undefined, 'delete');
    eq([...$.values(d)].length, 4, '$.values');
    ok(Dictionary.keyOf(d, Object.keys(d)[0]) === b, 'keyOf(token)');
    ok($.is(d, Dictionary), 'is Dictionary');
  });

  await test('ByteArray: tipos, endian, índice, UTF, EOF', () => {
    const BA = C('flash.utils.ByteArray');
    const ba: any = new BA();
    ba.writeByte(-2); ba.writeShort(-300); ba.writeInt(-70000); ba.writeUnsignedInt(0xfffffff0);
    ba.writeFloat(1.5); ba.writeDouble(Math.PI); ba.writeBoolean(true); ba.writeUTF('ação'); ba.writeUTFBytes('漢字');
    eq(ba[0], 254, 'ba[0]');
    eq(ba.readByte === undefined, false);
    ba.position = 0;
    eq(ba.readByte(), -2); eq(ba.readShort(), -300); eq(ba.readInt(), -70000); eq(ba.readUnsignedInt(), 0xfffffff0);
    eq(ba.readFloat(), 1.5); eq(ba.readDouble(), Math.PI); eq(ba.readBoolean(), true); eq(ba.readUTF(), 'ação');
    eq(ba.readUTFBytes(6), '漢字');
    eq(ba.bytesAvailable, 0);
    let threw = false;
    try { ba.readByte(); } catch (e) { threw = $.is(e, C('flash.errors.EOFError')); }
    ok(threw, 'EOFError');
    const le: any = new BA();
    le.endian = 'littleEndian';
    le.writeInt(1);
    eq(le[0], 1, 'little endian');
    le[10] = 7;
    eq(le.length, 11, 'escrita por índice cresce');
  });

  await test('ByteArray: compress/uncompress (zlib e deflate), readMultiByte', () => {
    const BA = C('flash.utils.ByteArray');
    const ba: any = new BA();
    for (let i = 0; i < 200; i++) ba.writeUTFBytes('abc');
    const len = ba.length;
    ba.compress();
    ok(ba.length < len, 'comprimiu');
    ba.uncompress();
    eq(ba.length, len);
    eq(ba.position, 0);
    eq(ba.readUTFBytes(3), 'abc');
    ba.deflate(); ba.inflate();
    eq(ba.length, len, 'deflate/inflate');
    const g: any = new BA();
    for (const b of [0xc4, 0xe3, 0xba, 0xc3]) g.writeByte(b);
    g.position = 0;
    eq(g.readMultiByte(4, 'gb2312'), '你好', 'gb2312');
  });

  await test('ByteArray: AMF3 writeObject/readObject + registerClassAlias', () => {
    const BA = C('flash.utils.ByteArray');
    class Vo { name = ''; level = 0; tags: string[] = []; }
    C('flash.net.registerClassAlias')('test.Vo', Vo);
    const v = new Vo();
    v.name = 'herói'; v.level = 42; v.tags = ['a', 'b'];
    const inner: any = new BA();
    inner.writeInt(7);
    const src = { n: 1.25, i: -5, big: 2 ** 40, s: 'x', arr: [1, 'two', null, true], d: new Date(1700000000000), vo: v, bytes: inner, nested: { a: { b: 1 } } };
    const ba: any = new BA();
    ba.writeObject(src);
    ba.writeObject(src);
    ba.position = 0;
    const r: any = ba.readObject();
    eq(r.n, 1.25); eq(r.i, -5); eq(r.big, 2 ** 40); eq(r.s, 'x');
    eq(r.arr.length, 4); eq(r.arr[1], 'two'); eq(r.arr[3], true);
    eq(r.d.getTime(), 1700000000000);
    ok(r.vo instanceof Vo, 'classe por alias');
    eq(r.vo.name, 'herói'); eq(r.vo.tags[1], 'b');
    eq(r.bytes.readInt(), 7);
    eq(r.nested.a.b, 1);
    const r2: any = ba.readObject();
    eq(r2.vo.level, 42, 'segundo objeto (referências)');
  });

  await test('Rectangle/Point/Matrix/ColorTransform', () => {
    const R = C('flash.geom.Rectangle'), P = C('flash.geom.Point'), M = C('flash.geom.Matrix'), CT = C('flash.geom.ColorTransform');
    const a = new R(0, 0, 10, 10), b = new R(5, 5, 10, 10);
    ok(a.intersects(b));
    const i = a.intersection(b);
    eq(i.x, 5); eq(i.width, 5);
    const u = a.union(b);
    eq(u.width, 15); eq(u.bottom, 15);
    ok(a.contains(0, 0) && !a.contains(10, 10), 'contains exclusivo na borda');
    ok(a.containsRect(new R(1, 1, 2, 2)));
    a.inflate(1, 2);
    eq(a.x, -1); eq(a.height, 14);
    a.offset(1, 1);
    eq(a.topLeft.x, 0);
    ok(new R().isEmpty());
    a.setEmpty();
    ok(a.isEmpty());
    eq(P.distance(new P(0, 0), new P(3, 4)), 5);
    const ip = P.interpolate(new P(10, 10), new P(0, 0), 0.25);
    eq(ip.x, 2.5);
    const pp = P.polar(2, Math.PI / 2);
    eq(pp.y, 2);
    const p = new P(3, 4); p.normalize(1);
    eq(p.length, 1);
    const m = new M();
    m.scale(2, 3); m.rotate(Math.PI / 2); m.translate(10, 0);
    const t = m.transformPoint(new P(1, 1));
    eq(t.x, 7); eq(t.y, 2);
    const inv = m.clone(); inv.invert();
    const back = inv.transformPoint(t);
    eq(back.x, 1); eq(back.y, 1);
    const ct = new CT();
    ct.color = 0xff8000;
    eq(ct.redOffset, 255); eq(ct.greenMultiplier, 0);
    const c2 = new CT(0.5, 1, 1, 1, 10);
    c2.concat(new CT(1, 1, 1, 1, 10));
    eq(c2.redOffset, 15);
  });

  await test('initFields: campos antes do construtor-base (Sprite, EventDispatcher, Event, Error, ByteArray)', () => {
    const Sprite = C('flash.display.Sprite');
    let seenInBase: unknown = 'nada';
    class Base extends Sprite {
      static $fields(self: any) { self.a = 1; }
      constructor() { super(); seenInBase = (this as any).b; }
    }
    class Derived extends Base {
      static $fields(self: any) { self.b = (self as any).a + 1; }
      c: number;
      constructor() { super(); this.c = (this as any).a; }
    }
    const d: any = new Derived();
    eq(d.a, 1); eq(d.b, 2); eq(d.c, 1);
    eq(seenInBase, 2, 'campo da derivada visível no construtor da base');
    for (const n of ['flash.events.EventDispatcher', 'flash.events.Event', 'flash.utils.ByteArray', 'Error', 'flash.geom.Point', 'flash.utils.Timer']) {
      const B = C(n);
      class X extends B { static $fields(self: any) { self.f = 9; } }
      const x: any = n === 'flash.events.Event' ? new X('t') : n === 'flash.utils.Timer' ? new X(10) : new X();
      eq(x.f, 9, n);
    }
  });

  await test('Display: filhos, graphics fora da contagem, índices Flash, removeChildren inclusivo', () => {
    const Sprite = C('flash.display.Sprite'), Shape = C('flash.display.Shape');
    const p: any = new Sprite();
    p.graphics.beginFill(0xff0000); p.graphics.drawRect(0, 0, 10, 10); p.graphics.endFill();
    const a: any = new Sprite(), b: any = new Shape(), c: any = new Sprite();
    a.name = 'a'; b.name = 'b'; c.name = 'c';
    p.addChild(a); p.addChild(b); p.addChildAt(c, 0);
    eq(p.numChildren, 3);
    eq(p.getChildAt(0), c); eq(p.getChildIndex(a), 1);
    p.setChildIndex(c, 2);
    eq(p.getChildAt(2), c);
    p.swapChildren(a, c);
    eq(p.getChildAt(0), c);
    eq(p.getChildByName('b'), b);
    ok(p.contains(b) && p.contains(p) && !b.contains(p));
    p.addChild(b);
    eq(p.getChildIndex(b), 2, 'addChild de filho existente vai ao topo');
    let threw = false;
    try { p.getChildAt(5); } catch (e) { threw = e instanceof RangeError; }
    ok(threw, 'RangeError');
    const removed = p.removeChildren(0, 1);
    eq(removed.length, 2, 'removeChildren inclusivo');
    eq(p.numChildren, 1);
    ok(p.graphics, 'graphics continua');
    ok($.is(p, C('flash.display.DisplayObjectContainer')) && !$.is(b, C('flash.display.DisplayObjectContainer')), 'is DOC');
    ok($.is(new Container(), C('flash.display.DisplayObject')), 'Container is DisplayObject');
  });

  await test('Display: added/addedToStage/removedFromStage, captura, bolha, prioridade, stopPropagation', () => {
    const stage: any = currentStage();
    if (!stage) throw new Error('sem stage (chame getStage(app) no boot)');
    const Sprite = C('flash.display.Sprite'), Event = C('flash.events.Event');
    const root: any = new Sprite(), child: any = new Sprite(), leaf: any = new Sprite();
    root.addChild(child); child.addChild(leaf);
    const log: string[] = [];
    leaf.addEventListener('addedToStage', () => log.push('leaf+stage'));
    root.addEventListener('addedToStage', (e: any) => log.push('root+stage:' + (e.target === root)));
    root.addEventListener('added', (e: any) => { if (e.target === root) log.push('root+added'); });
    stage.addChild(root);
    eq(log.join(','), 'root+added,root+stage:true,leaf+stage', 'ordem de eventos de adição');
    eq(leaf.stage, stage); eq(leaf.root, root);
    const order: string[] = [];
    root.addEventListener('ping', () => order.push('cap'), true);
    root.addEventListener('ping', () => order.push('bubble'));
    leaf.addEventListener('ping', () => order.push('t1'), false, 0);
    leaf.addEventListener('ping', () => order.push('t2'), false, 10);
    leaf.dispatchEvent(new Event('ping', true));
    eq(order.join(','), 'cap,t2,t1,bubble', 'fases e prioridade');
    order.length = 0;
    child.addEventListener('ping', (e: any) => e.stopPropagation());
    leaf.dispatchEvent(new Event('ping', true));
    eq(order.join(','), 'cap,t2,t1', 'stopPropagation');
    ok(leaf.willTrigger('ping') && leaf.hasEventListener('ping'));
    let removedFlag = false;
    leaf.addEventListener('removedFromStage', () => { removedFlag = !!leaf.stage; });
    stage.removeChild(root);
    ok(removedFlag, 'removedFromStage antes de sair (stage ainda acessível)');
    eq(leaf.stage, null);
  });

  await test('Display: coordenadas, bounds, rotation em graus, width, scrollRect, hitTestPoint', () => {
    const stage: any = currentStage();
    const Sprite = C('flash.display.Sprite');
    const s: any = new Sprite();
    s.graphics.beginFill(0); s.graphics.drawRect(0, 0, 100, 50); s.graphics.endFill();
    s.x = 10; s.y = 20;
    stage?.addChild(s);
    const g = s.localToGlobal({ x: 5, y: 5 });
    eq(g.x, 15); eq(g.y, 25);
    const l = s.globalToLocal(g);
    eq(l.x, 5);
    const b = s.getBounds(s.parent ?? s);
    eq(b.width, 100); eq(b.x, s.parent ? 10 : 0);
    s.rotation = 90;
    eq(s.rotation, 90);
    s.rotation = 270;
    eq(s.rotation, -90, 'normalização [-180, 180]');
    s.rotation = 0;
    s.width = 50;
    eq(s.scaleX, 0.5); eq(s.width, 50);
    s.scaleX = 1;
    if (stage) {
      ok(s.hitTestPoint(15, 25, true), 'hitTestPoint dentro');
      ok(!s.hitTestPoint(200, 25, true), 'hitTestPoint fora');
    }
    s.scrollRect = new (C('flash.geom.Rectangle'))(20, 0, 30, 30);
    eq(s.scrollRect.width, 30);
    eq(Math.round(s.width), 30, 'largura com scrollRect');
    s.scrollRect = null;
    eq(s.width, 100);
    const GlowFilter = C('flash.filters.GlowFilter');
    s.filters = [new GlowFilter(0xff0000, 1, 4, 4)];
    eq(s.filters.length, 1);
    ok($.is(s.filters[0], GlowFilter));
    s.filters = null;
    eq(s.filters.length, 0);
    const CT = C('flash.geom.ColorTransform');
    s.transform.colorTransform = new CT(1, 1, 1, 0.5);
    eq(s.alpha, 0.5);
    s.blendMode = 'hardlight';
    eq(s.blendMode, 'hardlight');
    stage?.removeChild(s);
  });

  await test('Eventos: MouseEvent sintético, EventDispatcher, Timer, KeyboardEvent', async () => {
    const Sprite = C('flash.display.Sprite'), MouseEvent = C('flash.events.MouseEvent'), ED = C('flash.events.EventDispatcher');
    const s: any = new Sprite();
    let got: any = null;
    s.addEventListener('click', (e: any) => { got = e; });
    s.dispatchEvent(new MouseEvent('click', true, false, 3, 4));
    ok(got && got.target === s && got.localX === 3, 'click');
    const target = { tag: 1 };
    const ed: any = new ED(target);
    let tgt: unknown = null;
    ed.addEventListener('x', (e: any) => { tgt = e.target; });
    ed.dispatchEvent(new (C('flash.events.Event'))('x'));
    eq(tgt, target, 'EventDispatcher(target)');
    const Timer = C('flash.utils.Timer');
    const t: any = new Timer(5, 2);
    let ticks = 0;
    await new Promise<void>((res) => {
      t.addEventListener('timer', () => ticks++);
      t.addEventListener('timerComplete', () => res());
      t.start();
    });
    eq(ticks, 2, 'timer');
    ok(!t.running);
  });

  await test('Erros e sistema: ArgumentError, ApplicationDomain, URLVariables, SharedObject, describeType', () => {
    const AE = C('ArgumentError');
    const e = new AE('x', 2025);
    ok(e instanceof Error && $.is(e, C('Error')) && e.errorID === 2025 && e.name === 'ArgumentError');
    const AD = C('flash.system.ApplicationDomain');
    ok(AD.currentDomain.hasDefinition('flash.display.Sprite'));
    ok(AD.currentDomain.getDefinition('flash.display::MovieClip') === C('flash.display.MovieClip'));
    let threw = false;
    try { AD.currentDomain.getDefinition('nao.Existe'); } catch (err) { threw = err instanceof ReferenceError; }
    ok(threw, 'ReferenceError');
    const UV = C('flash.net.URLVariables');
    const v: any = new UV('a=1&b=x%20y');
    eq(v.b, 'x y');
    v.c = 'á';
    ok(String(v).includes('c=%C3%A1'), 'URLVariables.toString');
    const SO = C('flash.net.SharedObject');
    const so: any = SO.getLocal('__selftest');
    so.data.n = 5; so.data.list = [1, 2];
    eq(so.flush(), 'flushed');
    so.clear();
    eq(C('flash.utils.getQualifiedClassName')(new (C('flash.display.Sprite'))()), 'flash.display::Sprite');
    const dt = C('flash.utils.describeType')(new (C('flash.geom.Point'))());
    ok(String(dt?.toXMLString?.() ?? dt).includes('flash.geom::Point'), 'describeType');
  });

  await test('PickGliss: classes do port acessíveis por $.C', () => {
    const cf = C('com.pickgliss.ui.ComponentFactory');
    ok(cf && cf.Instance, 'ComponentFactory.Instance');
    ok(C('com.pickgliss.ui.LayerManager').Instance, 'LayerManager.Instance');
    ok(typeof C('com.pickgliss.ui.core.Component') === 'function', 'Component');
    ok(!$.missing.has('com.pickgliss.ui.core.Component'));
  });

  await test('FTE: TextBlock quebra linhas', () => {
    const TB = C('flash.text.engine.TextBlock'), TE = C('flash.text.engine.TextElement'), EF = C('flash.text.engine.ElementFormat');
    const tb: any = new TB(new TE('palavra '.repeat(20), new EF(null, 12)));
    let line = tb.createTextLine(null, 100);
    let n = 0, chars = 0;
    while (line) { n++; chars += line.rawTextLength; ok(line.textWidth <= 100.5, 'cabe na largura'); line = tb.createTextLine(line, 100); }
    ok(n > 1, 'várias linhas');
    eq(chars, 160, 'todo o texto');
  });

  const failed = results.filter((r) => !r.ok);
  console.table(results.map((r) => ({ teste: r.name, ok: r.ok, erro: r.error?.split('\n')[0] ?? '' })));
  for (const f of failed) console.error('[as3selftest]', f.name, f.error);
  return { passed: results.length - failed.length, failed: failed.length, results };
}
