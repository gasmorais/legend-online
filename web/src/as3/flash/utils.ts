import { $, initFields } from '../runtime';

function guard(fn: (...a: any[]) => unknown, args: unknown[]): () => void {
  return () => {
    try { fn(...args); } catch (err) { console.error('[flash.utils] erro em timer', err); }
  };
}

export function getTimer(): number { return Math.floor(performance.now()); }

export function setTimeout(closure: (...a: any[]) => unknown, delay: number, ...args: unknown[]): number {
  if (typeof closure !== 'function') throw new TypeError('Error #2007: Parameter closure must be non-null.');
  return window.setTimeout(guard(closure, args), Math.max(0, Number(delay) || 0)) >>> 0;
}
export function clearTimeout(id: number): void { window.clearTimeout(id); }
export function setInterval(closure: (...a: any[]) => unknown, delay: number, ...args: unknown[]): number {
  if (typeof closure !== 'function') throw new TypeError('Error #2007: Parameter closure must be non-null.');
  return window.setInterval(guard(closure, args), Math.max(1, Number(delay) || 0)) >>> 0;
}
export function clearInterval(id: number): void { window.clearInterval(id); }

export function getQualifiedClassName(v: unknown): string {
  if (v === null) return 'null';
  if (v === undefined) return 'void';
  switch (typeof v) {
    case 'number': return Number.isInteger(v) ? (v >= -2147483648 && v <= 2147483647 ? 'int' : 'Number') : 'Number';
    case 'string': return 'String';
    case 'boolean': return 'Boolean';
    default: break;
  }
  if (Array.isArray(v)) return 'Array';
  if (v instanceof Date) return 'Date';
  if (typeof v === 'function' && !(v as any).__fqn && !/^class\b/.test(Function.prototype.toString.call(v)) && !(v as any).prototype) return 'Function';
  const c: any = typeof v === 'function' ? v : (v as any).constructor;
  if (c === Object || !c) return 'Object';
  const fqn: string = c.__fqn ?? String(c.name ?? 'Object').replace(/^_+/, '');
  const i = fqn.lastIndexOf('.');
  return i < 0 ? fqn : `${fqn.slice(0, i)}::${fqn.slice(i + 1)}`;
}

export function getQualifiedSuperclassName(v: unknown): string | null {
  const c: any = typeof v === 'function' ? v : (v as any)?.constructor;
  if (!c || c === Object) return null;
  const p = Object.getPrototypeOf(c);
  if (!p || p === Function.prototype) return 'Object';
  return getQualifiedClassName(p);
}

const escapeXml = (s: string) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

function members(proto: any, stopAtNative: boolean): { accessors: string[]; methods: string[]; owners: Map<string, string> } {
  const accessors: string[] = [], methods: string[] = [];
  const owners = new Map<string, string>();
  for (let p = proto; p && p !== Object.prototype; p = Object.getPrototypeOf(p)) {
    const owner = p.constructor;
    if (stopAtNative && owner && !owner.__fqn) break;
    const ownerName = getQualifiedClassName(owner);
    for (const k of Object.getOwnPropertyNames(p)) {
      if (k === 'constructor' || k.startsWith('__') || owners.has(k)) continue;
      const d = Object.getOwnPropertyDescriptor(p, k)!;
      owners.set(k, ownerName);
      if (d.get || d.set) accessors.push(k);
      else if (typeof d.value === 'function') methods.push(k);
    }
  }
  return { accessors, methods, owners };
}

export function describeType(value: unknown): unknown {
  const isClass = typeof value === 'function';
  const cls: any = isClass ? value : (value as any)?.constructor;
  const name = getQualifiedClassName(value);
  const base = isClass ? 'Class' : getQualifiedSuperclassName(value) ?? 'Object';
  const lines: string[] = [];
  const chain: string[] = [];
  for (let c = cls ? Object.getPrototypeOf(cls) : null; c && c !== Function.prototype; c = Object.getPrototypeOf(c)) chain.push(getQualifiedClassName(c));
  chain.push('Object');
  const body = (proto: any, inst: any) => {
    const out: string[] = [];
    for (const e of chain) out.push(`<extendsClass type="${escapeXml(e)}"/>`);
    for (let c = cls; c; c = Object.getPrototypeOf(c)) for (const i of (c.__interfaces ?? []) as string[]) out.push(`<implementsInterface type="${escapeXml(i.replace(/\.(\w+)$/, '::$1'))}"/>`);
    if (inst) for (const k of Object.keys(inst)) if (!k.startsWith('__')) out.push(`<variable name="${escapeXml(k)}" type="*"/>`);
    const m = members(proto, false);
    for (const k of m.accessors) out.push(`<accessor name="${escapeXml(k)}" access="readwrite" type="*" declaredBy="${escapeXml(m.owners.get(k)!)}"/>`);
    for (const k of m.methods) out.push(`<method name="${escapeXml(k)}" declaredBy="${escapeXml(m.owners.get(k)!)}" returnType="*"/>`);
    return out.join('');
  };
  if (isClass) {
    let sample: any = null;
    if (typeof cls.$fields === 'function') {
      sample = {};
      for (const c of [...protoChain(cls)].reverse()) if (Object.prototype.hasOwnProperty.call(c, '$fields')) c.$fields(sample);
    }
    lines.push(`<type name="${escapeXml(name)}" base="Class" isDynamic="true" isFinal="true" isStatic="true">`);
    lines.push('<extendsClass type="Class"/><extendsClass type="Object"/>');
    for (const k of Object.getOwnPropertyNames(cls)) {
      if (['length', 'name', 'prototype', '$fields', '__fqn', '__interfaces'].includes(k)) continue;
      const v = cls[k];
      lines.push(typeof v === 'function' ? `<method name="${escapeXml(k)}" declaredBy="${escapeXml(name)}" returnType="*"/>` : `<constant name="${escapeXml(k)}" type="*"/>`);
    }
    lines.push(`<factory type="${escapeXml(name)}">${body(cls.prototype, sample)}</factory></type>`);
  } else {
    lines.push(`<type name="${escapeXml(name)}" base="${escapeXml(base)}" isDynamic="false" isFinal="false" isStatic="false">`);
    lines.push(body(Object.getPrototypeOf(value as object), value), '</type>');
  }
  const xml = lines.join('');
  return $.XML ? new $.XML(xml) : xml;
}

function* protoChain(c: any): Generator<any> {
  for (let k = c; k && k !== Function.prototype; k = Object.getPrototypeOf(k)) yield k;
}

export function escapeMultiByte(s: string): string { return encodeURIComponent(String(s)); }
export function unescapeMultiByte(s: string): string { try { return decodeURIComponent(String(s)); } catch { return String(s); } }

export class FlashProxy {
  constructor() {
    initFields(this, new.target);
    return new Proxy(this, {
      get: (t: any, k) => {
        if (typeof k === 'symbol' || k in t) return t[k];
        return typeof t.getProperty === 'function' ? t.getProperty(k) : undefined;
      },
      set: (t: any, k, v) => {
        if (typeof k === 'symbol' || k in t) { t[k] = v; return true; }
        if (typeof t.setProperty === 'function') t.setProperty(k, v); else t[k] = v;
        return true;
      },
      has: (t: any, k) => (typeof k === 'symbol' || k in t ? true : typeof t.hasProperty === 'function' ? !!t.hasProperty(k) : false),
      deleteProperty: (t: any, k) => (typeof k !== 'symbol' && typeof t.deleteProperty === 'function' ? !!t.deleteProperty(k) : delete t[k]),
    });
  }
  getProperty(_name: unknown): unknown { return undefined; }
  setProperty(_name: unknown, _v: unknown): void {}
  hasProperty(_name: unknown): boolean { return false; }
  deleteProperty(_name: unknown): boolean { return false; }
  callProperty(_name: unknown, ..._a: unknown[]): unknown { return undefined; }
  getDescendants(_name: unknown): unknown { return undefined; }
  isAttribute(_name: unknown): boolean { return false; }
  nextName(_i: number): string { return ''; }
  nextNameIndex(_i: number): number { return 0; }
  nextValue(_i: number): unknown { return undefined; }
}
