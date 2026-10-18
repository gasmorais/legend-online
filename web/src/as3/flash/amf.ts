import { $ } from '../runtime';
import { ByteArray } from './bytearray';
import { Dictionary } from './dictionary';

const aliasToClass = new Map<string, any>();
const classToAlias = new Map<any, string>();

export function registerClassAlias(alias: string, cls: any): void {
  if (alias === null || alias === undefined || !cls) throw new TypeError('Error #2007: Parameter aliasName must be non-null.');
  aliasToClass.set(String(alias), cls);
  classToAlias.set(cls, String(alias));
}

export function getClassByAlias(alias: string): any {
  const c = aliasToClass.get(String(alias));
  if (!c) throw new ReferenceError(`Error #1014: Class ${alias} could not be found.`);
  return c;
}

function aliasOf(v: any): string {
  return classToAlias.get(v?.constructor) ?? '';
}

function sealedMembers(v: any): string[] {
  const out = new Set<string>();
  for (const k of Object.keys(v)) if (!k.startsWith('_') && typeof v[k] !== 'function') out.add(k);
  for (let p = Object.getPrototypeOf(v); p && p !== Object.prototype; p = Object.getPrototypeOf(p)) {
    if (p.constructor && !p.constructor.__fqn) break;
    for (const k of Object.getOwnPropertyNames(p)) {
      const d = Object.getOwnPropertyDescriptor(p, k);
      if (d && d.get && d.set && !k.startsWith('_')) out.add(k);
    }
  }
  return [...out];
}

function isPlain(v: any): boolean {
  const p = Object.getPrototypeOf(v);
  return p === Object.prototype || p === null || v?.constructor === $.Object;
}

class AMF3Reader {
  strings: string[] = [];
  objects: unknown[] = [];
  traits: { name: string; ext: boolean; dyn: boolean; members: string[] }[] = [];
  private view: DataView;
  constructor(public data: Uint8Array, public pos: number) { this.view = new DataView(data.buffer, data.byteOffset, data.byteLength); }

  u8(): number {
    if (this.pos >= this.data.length) throw new RangeError('Error #2030: End of file was encountered.');
    return this.data[this.pos++];
  }
  u29(): number {
    let v = 0;
    for (let i = 0; i < 3; i++) {
      const b = this.u8();
      v = (v << 7) | (b & 0x7f);
      if (!(b & 0x80)) return v;
    }
    return ((v << 8) | this.u8()) >>> 0;
  }
  i29(): number { const v = this.u29(); return v & 0x10000000 ? v - 0x20000000 : v; }
  double(): number { const v = this.view.getFloat64(this.pos); this.pos += 8; return v; }
  utf(n: number): string {
    const s = new TextDecoder().decode(this.data.subarray(this.pos, this.pos + n));
    this.pos += n;
    return s;
  }
  string(): string {
    const ref = this.u29();
    if (!(ref & 1)) return this.strings[ref >> 1];
    const s = this.utf(ref >> 1);
    if (s) this.strings.push(s);
    return s;
  }

  read(): unknown {
    const m = this.u8();
    switch (m) {
      case 0x00: return undefined;
      case 0x01: return null;
      case 0x02: return false;
      case 0x03: return true;
      case 0x04: return this.i29();
      case 0x05: return this.double();
      case 0x06: return this.string();
      case 0x07:
      case 0x0b: {
        const ref = this.u29();
        if (!(ref & 1)) return this.objects[ref >> 1];
        const s = this.utf(ref >> 1);
        const x = $.XML ? new $.XML(s) : s;
        this.objects.push(x);
        return x;
      }
      case 0x08: {
        const ref = this.u29();
        if (!(ref & 1)) return this.objects[ref >> 1];
        const d = new Date(this.double());
        this.objects.push(d);
        return d;
      }
      case 0x09: return this.array();
      case 0x0a: return this.object();
      case 0x0c: {
        const ref = this.u29();
        if (!(ref & 1)) return this.objects[ref >> 1];
        const n = ref >> 1;
        const ba = ByteArray.fromBytes(this.data.slice(this.pos, this.pos + n));
        this.pos += n;
        this.objects.push(ba);
        return ba;
      }
      case 0x0d: case 0x0e: case 0x0f: case 0x10: {
        const ref = this.u29();
        if (!(ref & 1)) return this.objects[ref >> 1];
        const n = ref >> 1;
        this.u8();
        const out: unknown[] = [];
        this.objects.push(out);
        if (m === 0x10) {
          this.string();
          for (let i = 0; i < n; i++) out.push(this.read());
        } else {
          for (let i = 0; i < n; i++) {
            if (m === 0x0d) out.push(this.view.getInt32(this.pos));
            else if (m === 0x0e) out.push(this.view.getUint32(this.pos));
            else out.push(this.view.getFloat64(this.pos));
            this.pos += m === 0x0f ? 8 : 4;
          }
        }
        return out;
      }
      case 0x11: {
        const ref = this.u29();
        if (!(ref & 1)) return this.objects[ref >> 1];
        const n = ref >> 1;
        const weak = this.u8() !== 0;
        const d: any = new Dictionary(weak);
        this.objects.push(d);
        for (let i = 0; i < n; i++) {
          const k = this.read();
          const v = this.read();
          if (k !== null && (typeof k === 'object' || typeof k === 'function')) setObjKey(d, k, v);
          else d[String(k)] = v;
        }
        return d;
      }
      default:
        throw new RangeError(`AMF3: marcador desconhecido 0x${m.toString(16)} em ${this.pos - 1}`);
    }
  }

  private array(): unknown {
    const ref = this.u29();
    if (!(ref & 1)) return this.objects[ref >> 1];
    const n = ref >> 1;
    const arr: any = [];
    this.objects.push(arr);
    for (;;) {
      const k = this.string();
      if (!k) break;
      arr[k] = this.read();
    }
    for (let i = 0; i < n; i++) arr[i] = this.read();
    return arr;
  }

  private object(): unknown {
    const ref = this.u29();
    if (!(ref & 1)) return this.objects[ref >> 1];
    let tr: AMF3Reader['traits'][number];
    if (!(ref & 2)) {
      tr = this.traits[ref >> 2];
    } else {
      const ext = !!(ref & 4);
      const dyn = !!(ref & 8);
      const count = ref >> 4;
      const name = this.string();
      const members: string[] = [];
      for (let i = 0; i < count; i++) members.push(this.string());
      tr = { name, ext, dyn, members };
      this.traits.push(tr);
    }
    let obj: any;
    const cls = tr.name ? aliasToClass.get(tr.name) : undefined;
    if (cls) {
      try { obj = new cls(); } catch { obj = Object.create(cls.prototype); }
    } else if (tr.name === 'flex.messaging.io.ArrayCollection' || tr.name === 'flex.messaging.io.ObjectProxy') {
      obj = {};
    } else {
      obj = {};
    }
    this.objects.push(obj);
    if (tr.ext) {
      if (typeof obj.readExternal === 'function') {
        const ba = ByteArray.fromBytes(this.data.subarray(this.pos));
        obj.readExternal(ba);
        this.pos += (ba as any).position;
      } else if (tr.name.startsWith('flex.messaging.io.')) {
        const inner = this.read();
        if (tr.name.endsWith('ArrayCollection')) { this.objects[this.objects.indexOf(obj)] = inner; return inner; }
        Object.assign(obj, inner);
      } else {
        throw new RangeError(`AMF3: classe externalizável sem alias registrado: ${tr.name}`);
      }
      return obj;
    }
    for (const k of tr.members) obj[k] = this.read();
    if (tr.dyn) {
      for (;;) {
        const k = this.string();
        if (!k) break;
        obj[k] = this.read();
      }
    }
    return obj;
  }
}

function setObjKey(d: any, k: object, v: unknown): void {
  d[k as any] = v;
}

export function readAMF3(data: Uint8Array, pos: number): [unknown, number] {
  const r = new AMF3Reader(data, pos);
  const v = r.read();
  return [v, r.pos];
}

class AMF3Writer {
  private out: number[] = [];
  private strings = new Map<string, number>();
  private objects = new Map<unknown, number>();
  private traits = new Map<string, number>();

  bytes(): Uint8Array { return Uint8Array.from(this.out); }
  u8(b: number): void { this.out.push(b & 255); }
  u29(v: number): void {
    v &= 0x1fffffff;
    if (v < 0x80) this.u8(v);
    else if (v < 0x4000) { this.u8((v >> 7) | 0x80); this.u8(v & 0x7f); }
    else if (v < 0x200000) { this.u8((v >> 14) | 0x80); this.u8((v >> 7) | 0x80); this.u8(v & 0x7f); }
    else { this.u8((v >> 22) | 0x80); this.u8((v >> 15) | 0x80); this.u8((v >> 8) | 0x80); this.u8(v & 0xff); }
  }
  double(v: number): void {
    const b = new Uint8Array(8);
    new DataView(b.buffer).setFloat64(0, v);
    for (const x of b) this.out.push(x);
  }
  raw(b: Uint8Array): void { for (const x of b) this.out.push(x); }
  string(s: string): void {
    if (s === '') { this.u29(1); return; }
    const ref = this.strings.get(s);
    if (ref !== undefined) { this.u29(ref << 1); return; }
    this.strings.set(s, this.strings.size);
    const b = new TextEncoder().encode(s);
    this.u29((b.length << 1) | 1);
    this.raw(b);
  }
  private ref(v: unknown): boolean {
    const r = this.objects.get(v);
    if (r !== undefined) { this.u29(r << 1); return true; }
    this.objects.set(v, this.objects.size);
    return false;
  }

  write(v: any): void {
    if (v === undefined) { this.u8(0x00); return; }
    if (v === null) { this.u8(0x01); return; }
    if (v === false) { this.u8(0x02); return; }
    if (v === true) { this.u8(0x03); return; }
    if (typeof v === 'number') {
      if (Number.isInteger(v) && v >= -0x10000000 && v <= 0x0fffffff && !Object.is(v, -0)) { this.u8(0x04); this.u29(v); }
      else { this.u8(0x05); this.double(v); }
      return;
    }
    if (typeof v === 'string') { this.u8(0x06); this.string(v); return; }
    if (typeof v === 'function') { this.u8(0x00); return; }
    if (v.__isXML) {
      this.u8(0x0b);
      if (this.ref(v)) return;
      const b = new TextEncoder().encode(typeof v.toXMLString === 'function' ? v.toXMLString() : String(v));
      this.u29((b.length << 1) | 1);
      this.raw(b);
      return;
    }
    if (v instanceof Date) { this.u8(0x08); if (this.ref(v)) return; this.u29(1); this.double(v.getTime()); return; }
    if (v instanceof ByteArray) {
      this.u8(0x0c);
      if (this.ref(v)) return;
      const b = ByteArray.raw(v).bytes;
      this.u29((b.length << 1) | 1);
      this.raw(b);
      return;
    }
    if (Dictionary.isDictionary(v)) {
      this.u8(0x11);
      if (this.ref(v)) return;
      const entries = (v as Dictionary).$entries();
      this.u29((entries.length << 1) | 1);
      this.u8((v as Dictionary).weakKeys ? 1 : 0);
      for (const [k, val] of entries) { this.write(k); this.write(val); }
      return;
    }
    if (Array.isArray(v)) {
      this.u8(0x09);
      if (this.ref(v)) return;
      const n = v.length;
      this.u29((n << 1) | 1);
      for (const k of Object.keys(v)) {
        if (/^\d+$/.test(k) && +k < n) continue;
        this.string(k);
        this.write((v as any)[k]);
      }
      this.string('');
      for (let i = 0; i < n; i++) this.write(v[i]);
      return;
    }
    this.u8(0x0a);
    if (this.ref(v)) return;
    const alias = aliasOf(v);
    if (typeof v.writeExternal === 'function' && alias) {
      this.traitsHeader(alias, true, false, []);
      const ba = new ByteArray();
      v.writeExternal(ba);
      this.raw(ByteArray.raw(ba).bytes);
      return;
    }
    if (alias || !isPlain(v)) {
      const members = sealedMembers(v);
      this.traitsHeader(alias, false, !alias, alias ? members : []);
      if (alias) for (const k of members) this.write(v[k]);
      else {
        for (const k of members) { this.string(k); this.write(v[k]); }
        this.string('');
      }
      return;
    }
    this.traitsHeader('', false, true, []);
    for (const k of Object.keys(v)) {
      if (k === '__fieldsInit' || typeof v[k] === 'function') continue;
      this.string(k);
      this.write(v[k]);
    }
    this.string('');
  }

  private traitsHeader(name: string, ext: boolean, dyn: boolean, members: string[]): void {
    const key = `${name}|${ext}|${dyn}|${members.join(',')}`;
    const ref = this.traits.get(key);
    if (ref !== undefined) { this.u29((ref << 2) | 1); return; }
    this.traits.set(key, this.traits.size);
    this.u29((members.length << 4) | (dyn ? 8 : 0) | (ext ? 4 : 0) | 3);
    this.string(name);
    for (const m of members) this.string(m);
  }
}

export function writeAMF3(v: unknown): Uint8Array {
  const w = new AMF3Writer();
  w.write(v);
  return w.bytes();
}

export class AMF0Reader {
  private view: DataView;
  private refs: unknown[] = [];
  constructor(public data: Uint8Array, public pos: number) { this.view = new DataView(data.buffer, data.byteOffset, data.byteLength); }
  private u8(): number { return this.data[this.pos++]; }
  private u16(): number { const v = this.view.getUint16(this.pos); this.pos += 2; return v; }
  private u32(): number { const v = this.view.getUint32(this.pos); this.pos += 4; return v; }
  private str(n: number): string { const s = new TextDecoder().decode(this.data.subarray(this.pos, this.pos + n)); this.pos += n; return s; }
  private props(obj: any): any {
    for (;;) {
      const k = this.str(this.u16());
      if (!k && this.data[this.pos] === 0x09) { this.pos++; break; }
      obj[k] = this.read();
    }
    return obj;
  }
  read(): unknown {
    const m = this.u8();
    switch (m) {
      case 0x00: { const v = this.view.getFloat64(this.pos); this.pos += 8; return v; }
      case 0x01: return this.u8() !== 0;
      case 0x02: return this.str(this.u16());
      case 0x03: { const o = {}; this.refs.push(o); return this.props(o); }
      case 0x05: return null;
      case 0x06: return undefined;
      case 0x07: return this.refs[this.u16()];
      case 0x08: { this.u32(); const o: any = []; this.refs.push(o); return this.props(o); }
      case 0x0a: { const n = this.u32(); const a: unknown[] = []; this.refs.push(a); for (let i = 0; i < n; i++) a.push(this.read()); return a; }
      case 0x0b: { const t = this.view.getFloat64(this.pos); this.pos += 10; return new Date(t); }
      case 0x0c: return this.str(this.u32());
      case 0x0f: return this.str(this.u32());
      case 0x10: {
        const name = this.str(this.u16());
        const cls = aliasToClass.get(name);
        const o = cls ? new cls() : {};
        this.refs.push(o);
        return this.props(o);
      }
      case 0x11: { const [v, p] = readAMF3(this.data, this.pos); this.pos = p; return v; }
      default: throw new RangeError(`AMF0: marcador desconhecido 0x${m.toString(16)}`);
    }
  }
}

export class AMF0Writer {
  private out: number[] = [];
  bytes(): Uint8Array { return Uint8Array.from(this.out); }
  private u8(b: number): void { this.out.push(b & 255); }
  private u16(v: number): void { this.u8(v >> 8); this.u8(v); }
  private u32(v: number): void { this.u16(v >>> 16); this.u16(v & 0xffff); }
  private utf(s: string, long = false): void {
    const b = new TextEncoder().encode(s);
    if (long) this.u32(b.length); else this.u16(b.length);
    for (const x of b) this.out.push(x);
  }
  write(v: any): void {
    if (v === undefined) { this.u8(0x06); return; }
    if (v === null) { this.u8(0x05); return; }
    if (typeof v === 'number') {
      this.u8(0x00);
      const b = new Uint8Array(8); new DataView(b.buffer).setFloat64(0, v); for (const x of b) this.out.push(x);
      return;
    }
    if (typeof v === 'boolean') { this.u8(0x01); this.u8(v ? 1 : 0); return; }
    if (typeof v === 'string') {
      const long = new TextEncoder().encode(v).length > 0xffff;
      this.u8(long ? 0x0c : 0x02);
      this.utf(v, long);
      return;
    }
    if (v instanceof Date) {
      this.u8(0x0b);
      const b = new Uint8Array(8); new DataView(b.buffer).setFloat64(0, v.getTime()); for (const x of b) this.out.push(x);
      this.u16(0);
      return;
    }
    if (Array.isArray(v)) { this.u8(0x0a); this.u32(v.length); for (const x of v) this.write(x); return; }
    if (typeof v === 'object') {
      const alias = aliasOf(v);
      if (alias) { this.u8(0x10); this.utf(alias); } else this.u8(0x03);
      for (const k of Object.keys(v)) {
        if (k === '__fieldsInit' || typeof v[k] === 'function') continue;
        this.utf(k);
        this.write(v[k]);
      }
      this.u16(0);
      this.u8(0x09);
      return;
    }
    this.u8(0x06);
  }
}
