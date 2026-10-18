import { Domain } from '@/flash/library';

type Ctor = (new (...a: any[]) => any) & { $fields?: (self: any) => void; __fqn?: string; __interfaces?: string[] };

const natives = new Map<string, unknown>();
const defined = new Map<string, unknown>();
type Bundle = { defs: Record<string, (rt: unknown) => unknown>; deps: Record<string, string[]> };
let bundleManifest: Promise<Record<string, string>> | null = null;
const loadManifest = (): Promise<Record<string, string>> =>
  (bundleManifest ??= fetch('/as3/bundles/manifest.json').then((r) => (r.ok ? r.json() : {})).catch(() => ({})));
const bundles = new Map<string, Promise<void>>();
let classmap: Record<string, string> | null = null;
const modules = new Map<string, { default: (rt: unknown) => unknown; deps: string[] }>();
const loading = new Map<string, Promise<void>>();
const staticInits = new Map<unknown, () => void>();
const interfaces = new Map<string, Ctor>();
const castWarned = new Set<unknown>();
const missing = new Set<string>();

async function ensureClassmap(): Promise<Record<string, string>> {
  if (!classmap) classmap = await (await fetch('/as3/classmap.json')).json();
  return classmap!;
}

function loadBundle(mod: string): Promise<void> {
  let p = bundles.get(mod);
  if (!p) {
    p = loadManifest().then(async (m) => {
      const file = m[mod];
      if (!file) return;
      const b: Bundle = await import(/* @vite-ignore */ `/as3/bundles/${file}`);
      for (const [fqn, def] of Object.entries(b.defs)) modules.set(fqn, { default: def, deps: b.deps[fqn] ?? [] });
    });
    bundles.set(mod, p);
  }
  return p;
}

const preHooks: { target: Function; fn: (self: any) => void }[] = [];
function runPre(self: any, target: Function): void {
  for (let i = 0; i < preHooks.length;) {
    if (preHooks[i].target === target) preHooks.splice(i, 1)[0].fn(self);
    else i++;
  }
}

export function initFields(self: any, target: Function | undefined): void {
  if (target && self.__fieldsInit && preHooks.length) runPre(self, target);
  if (!target || self.__fieldsInit) return;
  Object.defineProperty(self, '__fieldsInit', { value: true, enumerable: false, configurable: true });
  const chain: Ctor[] = [];
  for (let c: any = target; c && c !== Object; c = Object.getPrototypeOf(c)) {
    if (Object.prototype.hasOwnProperty.call(c, '$fields')) chain.push(c);
  }
  for (let i = chain.length - 1; i >= 0; i--) chain[i].$fields!(self);
  if (preHooks.length) runPre(self, target);
}

class AS3Object {
  constructor() { initFields(this, new.target); }
}

function stubClass(fqn: string): Ctor {
  const C = class extends AS3Object {
    constructor(..._a: unknown[]) {
      super();
      return new Proxy(this, {
        get: (t: any, k) => (k in t ? t[k] : typeof k === 'string' && k !== 'then' ? stubFn : undefined),
      });
    }
  } as unknown as Ctor;
  const stubFn: any = new Proxy(function () { return undefined; }, { get: () => stubFn });
  Object.defineProperty(C, 'name', { value: fqn.split('.').pop() });
  return new Proxy(C, { get: (t: any, k) => (k in t ? t[k] : typeof k === 'string' ? stubFn : undefined) }) as Ctor;
}

export const $ = {
  Object: AS3Object,
  missing,

  registerNative(fqn: string, value: unknown): void { natives.set(fqn, value); },
  hasModule(fqn: string): boolean { return !!classmap?.[fqn]; },
  moduleOf(fqn: string): string | undefined { return classmap?.[fqn]; },
  loadBundle,

  load(fqn: string): Promise<void> {
    if (natives.has(fqn)) return Promise.resolve();
    let p = loading.get(fqn);
    if (!p) {
      p = (async () => {
        const map = await ensureClassmap();
        const seen = new Set<string>();
        let frontier = [fqn];
        while (frontier.length) {
          const mods = new Set(frontier.map((f) => map[f]).filter((m): m is string => !!m));
          await Promise.all([...mods].map(loadBundle));
          const next: string[] = [];
          for (const f of frontier) {
            if (seen.has(f)) continue;
            seen.add(f);
            for (const d of modules.get(f)?.deps ?? []) if (!seen.has(d) && !natives.has(d)) next.push(d);
          }
          frontier = next;
        }
      })();
      loading.set(fqn, p);
    }
    return p;
  },

  hasCode(fqn: string): boolean { return natives.has(fqn) || defined.has(fqn) && !missing.has(fqn) || modules.has(fqn); },

  C(fqn: string): any {
    if (natives.has(fqn)) return natives.get(fqn);
    const ported = Domain.getClass(fqn);
    if (ported) return ported;
    if (defined.has(fqn)) return defined.get(fqn);
    const mod = modules.get(fqn);
    if (!mod) {
      if (!missing.has(fqn)) { missing.add(fqn); console.warn('[as3] classe ausente (stub):', fqn); }
      const s = stubClass(fqn);
      defined.set(fqn, s);
      return s;
    }
    const cls = mod.default($);
    defined.set(fqn, cls);
    const init = staticInits.get(cls);
    if (init) { staticInits.delete(cls); init(); }
    return cls;
  },

  meta(cls: Ctor, fqn: string, impl: string[]): void {
    cls.__fqn = fqn;
    cls.__interfaces = impl;
  },

  statics(cls: unknown, fn: () => void): void { staticInits.set(cls, fn); },

  interface(fqn: string, parents: string[] = []): Ctor {
    let i = interfaces.get(fqn);
    if (i) { if (parents.length) (i as any).__parents = parents; }
    else {
      i = class {} as Ctor;
      i.__fqn = fqn;
      Object.defineProperty(i, 'name', { value: fqn.split('.').pop() });
      (i as any).__isInterface = true;
      (i as any).__parents = parents;
      interfaces.set(fqn, i);
      ifaceBySimple.set(fqn.split('.').pop()!, i);
    }
    return i;
  },

  is(v: any, T: any): boolean {
    if (v === null || v === undefined) return false;
    if (typeof T === 'string') {
      switch (T) {
        case 'int': return typeof v === 'number' && Number.isInteger(v) && v >= -2147483648 && v <= 2147483647;
        case 'uint': return typeof v === 'number' && Number.isInteger(v) && v >= 0 && v <= 4294967295;
        case 'Number': return typeof v === 'number';
        case 'String': return typeof v === 'string';
        case 'Boolean': return typeof v === 'boolean';
        case 'Array': return Array.isArray(v);
        case 'Function': return typeof v === 'function';
        case 'Object': case '*': return true;
        case 'Class': return typeof v === 'function';
        case 'XML': case 'XMLList': return !!v.__isXML;
        default:
          if (T.includes('.') || T.includes('::')) return $.is(v, $.C(T.replace('::', '.')));
          return false;
      }
    }
    if (!T) return false;
    if (T.__isInterface) return implementsIface(v, T.__fqn);
    try { return v instanceof T; } catch { return false; }
  },

  as(v: any, T: any): any { return $.is(v, T) ? v : null; },

  cast(T: any, v: any): any {
    if (v === null || v === undefined) return null;
    if (T && !$.is(v, T) && !castWarned.has(T)) {
      castWarned.add(T);
      console.warn(`[as3] cast para ${T.__fqn ?? T.name} de valor de outro tipo`, v);
    }
    return v;
  },

  pre(target: Function, fn: (self: any) => void): void { preHooks.push({ target, fn }); },
  preFlush(self: any, target: Function): void {
    if (!preHooks.length) return;
    initFields(self, target);
    runPre(self, target);
  },

  str(v: any): string | null { return v === null || v === undefined ? null : String(v); },

  int(v: any): number {
    const n = typeof v === 'string' ? (/^\s*0x/i.test(v) ? parseInt(v, 16) : Number(v)) : Number(v);
    return Number.isFinite(n) ? n | 0 : 0;
  },
  uint(v: any): number { return $.int(v) >>> 0; },

  values(x: any): Iterable<any> {
    if (x === null || x === undefined) return [];
    if (Array.isArray(x)) return x;
    if (x instanceof Map) return x.values();
    if (typeof x.$values === 'function') return x.$values();
    return Object.values(x);
  },

  bind(obj: any, name: string): any {
    const fn = obj?.[name];
    if (typeof fn !== 'function') return fn;
    let cache: Map<string, any> = obj.__bound;
    if (!cache) { cache = new Map(); Object.defineProperty(obj, '__bound', { value: cache }); }
    let b = cache.get(name);
    if (!b || b.__orig !== fn) {
      b = fn.bind(obj);
      b.__orig = fn;
      cache.set(name, b);
    }
    return b;
  },

  globals: new Map<string, unknown>(),
  g(name: string, self: any): any {
    if ($.globals.has(name)) return $.globals.get(name);
    if (self && name in self) return self[name];
    return undefined;
  },

  trace: (...a: unknown[]) => console.log('[trace]', ...a),
  getTimer: () => Math.floor(performance.now()),
  setTimeout: (fn: (...a: any[]) => void, ms: number, ...args: unknown[]) => window.setTimeout(fn, ms, ...args),
  clearTimeout: (id: number) => window.clearTimeout(id),
  setInterval: (fn: (...a: any[]) => void, ms: number, ...args: unknown[]) => window.setInterval(fn, ms, ...args),
  clearInterval: (id: number) => window.clearInterval(id),
  getQualifiedClassName(v: any): string {
    const c = typeof v === 'function' ? v : v?.constructor;
    const fqn: string = c?.__fqn ?? c?.name ?? 'Object';
    const i = fqn.lastIndexOf('.');
    return i < 0 ? fqn : fqn.slice(0, i) + '::' + fqn.slice(i + 1);
  },
  getQualifiedSuperclassName(v: any): string | null {
    const c = typeof v === 'function' ? v : v?.constructor;
    const p = c ? Object.getPrototypeOf(c) : null;
    return p ? $.getQualifiedClassName(p) : null;
  },
  getDefinitionByName(name: string): any { return $.C(name.replace('::', '.')); },
  describeType(): any { return null; },
  navigateToURL(req: { url?: string }): void { if (req?.url) window.open(req.url, '_blank'); },
  fscommand(): void {},
  sendToURL(): void {},
  escapeMultiByte: (s: string) => encodeURIComponent(s),
  unescapeMultiByte: (s: string) => decodeURIComponent(s),
  Class: Function,
  Namespace: class {},
  QName: class {},

  Vector: (function () {
    function V(this: unknown, length?: number) {
      if (!(this instanceof V)) return Array.from((length as unknown as ArrayLike<unknown>) ?? []);
      const a: unknown[] = [];
      if (typeof length === 'number') a.length = length;
      return a;
    }
    return V as unknown as any;
  })(),

  XML: null as any,
  XMLList: null as any,
};

const ifaceBySimple = new Map<string, Ctor>();
const simpleName = (n: string): string => n.split(/[.:]/).pop()!;

function ifaceExtends(name: string, want: string, seen = new Set<string>()): boolean {
  const s = simpleName(name);
  if (s === want) return true;
  if (seen.has(s)) return false;
  seen.add(s);
  const parents: string[] = (ifaceBySimple.get(s) as any)?.__parents ?? [];
  return parents.some((p) => ifaceExtends(p, want, seen));
}

function implementsIface(v: any, fqn: string): boolean {
  const want = simpleName(fqn);
  for (let c = v?.constructor; c && c !== Object; c = Object.getPrototypeOf(c)) {
    const impl: string[] | undefined = Object.prototype.hasOwnProperty.call(c, '__interfaces') ? c.__interfaces : undefined;
    if (impl?.some((i) => ifaceExtends(i, want))) return true;
  }
  return !!v?.__implements?.includes?.(fqn);
}

export type Runtime = typeof $;
