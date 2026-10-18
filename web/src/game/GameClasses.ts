import { Container } from 'pixi.js';
import { Bitmap } from '@/flash/display';
import { BitmapData, Domain } from '@/flash/library';
import { Sprite } from '@/flash/sprite';
import { ComponentFactory, createdBy } from '@/pickgliss/ComponentFactory';
import { LanguageMgr } from './LanguageMgr';

export type Expr =
  | ['num', number] | ['str', string] | ['bool', boolean] | ['null']
  | ['ref', string, string | null] | ['tr', string, Expr[]]
  | ['add', Expr, Expr] | ['sub', Expr, Expr] | ['raw', string];

export type Op =
  | { op: 'create'; v: string; how: string; name: string; args?: Expr[]; c?: 1 }
  | { op: 'add'; p: string; v: string; how: string; i?: number; c?: 1 }
  | { op: 'set'; v: string; k: string; e: Expr; c?: 1 }
  | { op: 'call'; v: string; m: string; a: Expr[]; c?: 1 };

export interface ClassRecord { extends: string | null; ops: Op[]; super?: Expr[] }

export interface OpLog { cls: string; op: Op; ok: boolean; error?: string; stack?: string }

export const RuntimeOptions = {
  includeConditional: false,
  log: [] as OpLog[],
  maxDepth: 6,
};

export const instanceVars = new WeakMap<object, Map<string, unknown>>();
export const instanceClass = new WeakMap<object, string>();

class GameClassRegistry {
  private index = new Map<string, string>();
  private records = new Map<string, ClassRecord>();
  private loadedModules = new Map<string, Promise<void>>();
  private classStyles = new Map<string, string[]>();
  private depth = 0;

  async init(): Promise<void> {
    const [idx, cs] = await Promise.all([
      fetch('/layout/index.json').then((r) => r.json()),
      fetch('/layout/class-styles.json').then((r) => r.json()),
    ]);
    for (const [k, v] of Object.entries(idx as Record<string, string>)) this.index.set(k, v);
    for (const [k, v] of Object.entries(cs as Record<string, string[]>)) this.classStyles.set(k, v);
  }

  moduleOf(cls: string): string | undefined { return this.index.get(cls); }
  record(cls: string): ClassRecord | undefined { return this.records.get(cls); }
  stylesOf(cls: string): string[] { return this.classStyles.get(cls) ?? []; }
  get classes(): string[] { return [...this.index.keys()]; }

  ownStyle(cls: string): string | undefined {
    const list = this.stylesOf(cls);
    const simple = cls.split('.').pop()!;
    return list.find((s) => s === cls) ?? list.find((s) => s.endsWith('.' + simple)) ?? list[0];
  }

  private loadModule(mod: string): Promise<void> {
    let p = this.loadedModules.get(mod);
    if (!p) {
      p = fetch(`/layout/${mod}.json`).then((r) => r.json()).then((data: Record<string, ClassRecord>) => {
        for (const [cls, rec] of Object.entries(data)) {
          this.records.set(cls, rec);
          this.register(cls);
        }
      });
      this.loadedModules.set(mod, p);
    }
    return p;
  }

  async prepare(cls: string, withOwnStyle = true): Promise<void> {
    const names = new Set<string>();
    const own = withOwnStyle ? this.ownStyle(cls) : undefined;
    if (own) names.add(own);
    const seen = new Set<string>();
    let queue = [cls];
    while (queue.length) {
      const mods = new Set(queue.map((c) => this.moduleOf(c)).filter((m): m is string => !!m));
      await Promise.all([...mods].map((m) => this.loadModule(m)));
      const next: string[] = [];
      for (const c of queue) {
        if (seen.has(c)) continue;
        seen.add(c);
        const rec = this.records.get(c);
        if (!rec) continue;
        if (rec.extends && this.index.has(rec.extends)) next.push(rec.extends);
        for (const op of rec.ops) {
          if (op.op !== 'create' || (op.c && !RuntimeOptions.includeConditional)) continue;
          if (op.how === 'new') { if (this.index.has(op.name)) next.push(op.name); } else names.add(op.name);
        }
      }
      queue = next;
    }
    await ComponentFactory.Instance.preload(names);
    const viaStyle: string[] = [];
    for (const n of names) {
      const cn = ComponentFactory.Instance.getComponentStyle(n)?.find(([k]) => k === 'classname')?.[1]
        ?? ComponentFactory.Instance.model.getCustomObjectStyle(n)?.attrs.find(([k]) => k === 'classname')?.[1];
      if (cn && this.index.has(cn) && !seen.has(cn)) viaStyle.push(cn);
    }
    for (const c of viaStyle) await this.prepare(c, false);
  }

  private baseClass(cls: string): new (...a: any[]) => any {
    const parent = this.records.get(cls)?.extends ?? 'flash.display.Sprite';
    if (this.index.has(parent) && this.records.has(parent)) {
      this.register(parent);
      return Domain.getClass(parent)! as new (...a: any[]) => any;
    }
    return (Domain.getClass(parent) ?? Sprite) as new (...a: any[]) => any;
  }

  private register(cls: string): void {
    if (Domain.isClass(cls)) return;
    const registry = this;
    const Base = this.baseClass(cls);
    const GameView = class extends Base {
      constructor(...args: any[]) {
        const rec = registry.records.get(cls);
        const superArgs = rec?.super ? rec.super.map((e) => evalExpr(e, new Map(), args)) : [];
        super(...superArgs);
        instanceClass.set(this, cls);
        if (rec) registry.run(this, cls, rec.ops, args);
      }
    };
    Object.defineProperty(GameView, 'name', { value: cls.split('.').pop() });
    Domain.registerClass(cls, GameView);
  }

  run(self: any, cls: string, ops: Op[], args: unknown[]): void {
    if (this.depth > RuntimeOptions.maxDepth) return;
    this.depth++;
    let vars = instanceVars.get(self);
    if (!vars) { vars = new Map(); instanceVars.set(self, vars); }
    const env = vars;
    const get = (name: string): any => (name === 'this' ? self : env.get(name) ?? self[name]);
    try {
      for (const op of ops) {
        if (op.c && !RuntimeOptions.includeConditional) continue;
        try {
          execOp(op, self, env, get, args);
          RuntimeOptions.log.push({ cls, op, ok: true });
        } catch (err) {
          RuntimeOptions.log.push({ cls, op, ok: false, error: String((err as Error)?.message ?? err),
            stack: (err as Error)?.stack?.split('\n').slice(1, 5).join(' | ') });
        }
      }
    } finally {
      this.depth--;
    }
  }
}

function evalExpr(e: Expr, env: Map<string, unknown>, args: unknown[]): any {
  switch (e[0]) {
    case 'num': return e[1];
    case 'str': return e[1];
    case 'bool': return e[1];
    case 'null': return null;
    case 'tr': return LanguageMgr.GetTranslation(e[1], ...e[2].map((a) => evalExpr(a, env, args)));
    case 'ref': {
      const m = /^param(\d+)$/.exec(e[1]);
      const base: any = m ? args[Number(m[1]) - 1] : env.get(e[1]);
      if (base === undefined || base === null) return undefined;
      return e[2] ? base[e[2]] : base;
    }
    case 'add': {
      const a = evalExpr(e[1], env, args), b = evalExpr(e[2], env, args);
      return a === undefined || b === undefined ? undefined : a + b;
    }
    case 'sub': {
      const a = evalExpr(e[1], env, args), b = evalExpr(e[2], env, args);
      return a === undefined || b === undefined ? undefined : a - b;
    }
    default: return undefined;
  }
}

export function makeStub(name: string): any {
  const target: Record<string | symbol, unknown> = { __stub__: name };
  const fn = () => proxy;
  const proxy: any = new Proxy(target, {
    get: (t, k) => (k in t ? t[k] : k === Symbol.toPrimitive ? () => '' : k === 'then' ? undefined : fn),
    set: (t, k, v) => { t[k] = v; return true; },
  });
  return proxy;
}

function asDisplay(obj: unknown): Container {
  if (obj instanceof Container) return obj;
  if (obj instanceof BitmapData) return new Bitmap(obj);
  throw new Error('não é DisplayObject');
}

function execOp(op: Op, self: any, env: Map<string, unknown>, get: (n: string) => any, args: unknown[]): void {
  const F = ComponentFactory.Instance;
  switch (op.op) {
    case 'create': {
      const a = op.args?.map((x) => evalExpr(x, env, args));
      let obj: unknown;
      switch (op.how) {
        case 'style': obj = F.creatComponentByStylename(op.name, a); break;
        case 'bitmap': obj = F.creatBitmap(op.name); break;
        case 'custom': obj = F.creatCustomObject(op.name, a); break;
        case 'bitmapData': obj = F.creatBitmapData(op.name); break;
        case 'creat': obj = F.creat(op.name, a); break;
        case 'new':
          if (!Domain.hasDefinition(op.name)) {
            if (op.name.startsWith('flash.') || op.name.startsWith('com.pickgliss.')) throw new Error(`classe sem port: ${op.name}`);
            obj = makeStub(op.name);
            break;
          }
          obj = Domain.createInstance(op.name, a ?? []);
          if (obj && typeof obj === 'object') createdBy.set(obj, 'new ' + op.name);
          break;
        default: throw new Error(`create desconhecido: ${op.how}`);
      }
      env.set(op.v, obj);
      if (obj && typeof obj === 'object' && op.v.startsWith('_') && !(op.v in self)) {
        try { self[op.v] = obj; } catch { }
      }
      return;
    }
    case 'add': {
      const parent = get(op.p);
      const child = get(op.v);
      if (!parent) throw new Error(`pai indefinido: ${op.p}`);
      if (child === undefined || child === null) throw new Error(`filho indefinido: ${op.v}`);
      const disp = asDisplay(child);
      if (op.how === 'addToContent' && typeof parent.addToContent === 'function') parent.addToContent(disp);
      else if (op.how === 'addChildAt' && op.i !== undefined) parent.addChildAt(disp, Math.min(op.i, parent.children.length));
      else parent.addChild(disp);
      return;
    }
    case 'set': {
      const target = get(op.v);
      if (!target) throw new Error(`alvo indefinido: ${op.v}`);
      const value = evalExpr(op.e, env, args);
      if (value === undefined) throw new Error(`valor não resolvido: ${JSON.stringify(op.e)}`);
      if (op.k === 'scaleX') target.scale.x = value;
      else if (op.k === 'scaleY') target.scale.y = value;
      else if (op.k === 'rotation') target.angle = value;
      else target[op.k] = value;
      return;
    }
    case 'call': {
      const target = get(op.v);
      if (!target || typeof target[op.m] !== 'function') throw new Error(`método ausente: ${op.v}.${op.m}`);
      const a = op.a.map((x) => {
        const v = evalExpr(x, env, args);
        return x[0] === 'ref' && v === undefined ? get(x[1]) : v;
      });
      target[op.m](...a);
      return;
    }
  }
}

export const GameClasses = new GameClassRegistry();

export async function openScreen(cls: string): Promise<Container> {
  await GameClasses.prepare(cls);
  const style = GameClasses.ownStyle(cls);
  RuntimeOptions.log = [];
  const obj = style
    ? ComponentFactory.Instance.creatComponentByStylename(style)
    : Domain.createInstance(cls);
  return asDisplay(obj);
}
