import { initFields } from '../runtime';

let lastObj: object | null = null;
let lastStr: string | null = null;

function ordinaryToPrimitive(o: any, hint: string): unknown {
  const order = hint === 'string' ? ['toString', 'valueOf'] : ['valueOf', 'toString'];
  for (const m of order) {
    const f = o[m];
    if (typeof f === 'function') {
      const r = f.call(o);
      if (r === null || (typeof r !== 'object' && typeof r !== 'function')) return r;
    }
  }
  throw new TypeError('Cannot convert object to primitive value');
}

let hookInstalled = false;
export function installKeyHook(): void {
  if (hookInstalled) return;
  hookInstalled = true;
  const existing = Object.getOwnPropertyDescriptor(Object.prototype, Symbol.toPrimitive);
  if (existing) return;
  Object.defineProperty(Object.prototype, Symbol.toPrimitive, {
    configurable: true,
    writable: true,
    enumerable: false,
    value: function (this: any, hint: string) {
      const r = ordinaryToPrimitive(this, hint);
      if (hint === 'string' && typeof r === 'string' && !this.__isXML) {
        lastObj = this;
        lastStr = r;
      } else {
        lastObj = null;
        lastStr = null;
      }
      return r;
    },
  });
}

const TOKEN = '\u0001dict:';
const STORE = Symbol.for('flash.dictionary.store');
let tokenSeq = 0;
const tokenOf = new WeakMap<object, string>();
const objOfToken = new Map<string, WeakRef<object>>();

function token(o: object): string {
  let t = tokenOf.get(o);
  if (!t) {
    t = TOKEN + ++tokenSeq;
    tokenOf.set(o, t);
    objOfToken.set(t, new WeakRef(o));
  }
  return t;
}

interface Store { map: Map<unknown, unknown> }

function resolveKey(prop: string | symbol): unknown {
  if (typeof prop === 'symbol') return prop;
  if (lastObj !== null && prop === lastStr) {
    const o = lastObj;
    lastObj = null;
    lastStr = null;
    return o;
  }
  if (prop.startsWith(TOKEN)) {
    const o = objOfToken.get(prop)?.deref();
    if (o) return o;
  }
  return prop;
}

export class Dictionary {
  readonly weakKeys: boolean;

  constructor(weakKeys: unknown = false) {
    initFields(this, new.target);
    this.weakKeys = !!weakKeys;
    installKeyHook();
    const store: Store = { map: new Map() };
    Object.defineProperty(this, STORE, { value: store, configurable: true });
    const map = store.map;
    return new Proxy(this, {
      get(t, p, r) {
        if (typeof p === 'symbol') return Reflect.get(t, p, r);
        const k = resolveKey(p);
        if (map.has(k)) return map.get(k);
        if (typeof k === 'string' && k in t) return Reflect.get(t, k, r);
        return undefined;
      },
      set(t, p, v, r) {
        if (typeof p === 'symbol') return Reflect.set(t, p, v, r);
        const k = resolveKey(p);
        if (typeof k === 'string' && !map.has(k) && k in t) return Reflect.set(t, k, v, r);
        map.set(k, v);
        return true;
      },
      has(t, p) {
        if (typeof p === 'symbol') return p in t;
        const k = resolveKey(p);
        return map.has(k) || (typeof k === 'string' && k in t);
      },
      deleteProperty(t, p) {
        if (typeof p === 'symbol') return Reflect.deleteProperty(t, p);
        const k = resolveKey(p);
        if (map.has(k)) { map.delete(k); return true; }
        return Reflect.deleteProperty(t, p);
      },
      ownKeys() {
        const out: string[] = [];
        for (const k of map.keys()) out.push(typeof k === 'object' || typeof k === 'function' ? token(k as object) : String(k));
        return out;
      },
      getOwnPropertyDescriptor(t, p) {
        if (typeof p === 'symbol') return Reflect.getOwnPropertyDescriptor(t, p);
        const k = resolveKey(p);
        if (map.has(k)) return { value: map.get(k), writable: true, enumerable: true, configurable: true };
        return undefined;
      },
      defineProperty(t, p, d) { return Reflect.defineProperty(t, p, d); },
    });
  }

  $values(): IterableIterator<unknown> { return (this as any)[STORE].map.values(); }
  $keys(): unknown[] { return [...(this as any)[STORE].map.keys()]; }
  $entries(): [unknown, unknown][] { return [...(this as any)[STORE].map.entries()]; }

  hasOwnProperty(k: unknown): boolean { return (this as any)[STORE].map.has(k) || (typeof k === 'string' && (this as any)[STORE].map.has(resolveKey(k))); }
  propertyIsEnumerable(k: unknown): boolean { return this.hasOwnProperty(k); }
  toJSON(): Record<string, unknown> { return {}; }
  toString(): string { return '[object Dictionary]'; }

  static keyOf(_dict: unknown, k: unknown): unknown {
    return typeof k === 'string' && k.startsWith(TOKEN) ? (objOfToken.get(k)?.deref() ?? k) : k;
  }
  static isDictionary(v: unknown): v is Dictionary { return !!v && typeof v === 'object' && STORE in (v as object); }
}
