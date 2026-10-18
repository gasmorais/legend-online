import { deflate, deflateRaw, inflate, inflateRaw } from 'pako';
import { initFields } from '../runtime';
import { EOFError, IOError, ArgumentError } from './errors';
import { readAMF3, writeAMF3, AMF0Reader, AMF0Writer } from './amf';

export const Endian = { BIG_ENDIAN: 'bigEndian', LITTLE_ENDIAN: 'littleEndian' } as const;
export const CompressionAlgorithm = { DEFLATE: 'deflate', ZLIB: 'zlib', LZMA: 'lzma' } as const;
export const ObjectEncoding = { AMF0: 0, AMF3: 3, DEFAULT: 3, dynamicPropertyWriter: null as unknown } as const;

const utf8enc = new TextEncoder();
const decoders = new Map<string, TextDecoder>();
function decoder(charset: string): TextDecoder {
  let cs = String(charset || 'utf-8').toLowerCase();
  if (cs === 'gb2312' || cs === 'cn-gb' || cs === 'gb' || cs === 'x-gbk') cs = 'gbk';
  if (cs === 'unicode') cs = 'utf-16le';
  let d = decoders.get(cs);
  if (!d) {
    try { d = new TextDecoder(cs); } catch { d = new TextDecoder('utf-8'); }
    decoders.set(cs, d);
  }
  return d;
}

const RAW = Symbol.for('flash.bytearray.raw');
const nativeMethods = new Set<unknown>();

function isIndex(p: string | symbol): p is string {
  if (typeof p !== 'string' || p.length === 0) return false;
  const c = p.charCodeAt(0);
  return c >= 48 && c <= 57 && String(+p >>> 0) === p;
}

export class ByteArray {
  static defaultObjectEncoding = 3;
  private _buf: Uint8Array = new Uint8Array(16);
  private _view: DataView = new DataView(this._buf.buffer);
  private _len = 0;
  private _pos = 0;
  private _le = false;
  objectEncoding = ByteArray.defaultObjectEncoding;
  shareable = false;
  private _bound?: Map<PropertyKey, Function>;

  constructor() {
    initFields(this, new.target);
    const target = this;
    const proxy = new Proxy(this, {
      get(t, p) {
        if (isIndex(p)) { const i = +p; return i < t._len ? t._buf[i] : undefined; }
        if (p === RAW) return t;
        const v = Reflect.get(t, p, t);
        if (typeof v === 'function' && nativeMethods.has(v)) {
          let b = (t._bound ??= new Map()).get(p);
          if (!b) { b = v.bind(t); t._bound.set(p, b!); }
          return b;
        }
        return v;
      },
      set(t, p, v) {
        if (isIndex(p)) { t.setByte(+p, v); return true; }
        return Reflect.set(t, p, v, t);
      },
      has(t, p) { return isIndex(p) ? +p < t._len : p in t; },
    });
    Object.defineProperty(target, '__proxy', { value: proxy });
    return proxy;
  }

  static raw(b: ByteArray): ByteArray { return ((b as any)?.[RAW] as ByteArray) ?? b; }

  private setByte(i: number, v: unknown): void {
    if (i >= this._len) { this.ensure(i + 1); this._len = i + 1; }
    this._buf[i] = Number(v) & 255;
  }

  get length(): number { return this._len; }
  set length(n: number) {
    n = Number(n) >>> 0;
    if (n > this._len) { this.ensure(n); this._buf.fill(0, this._len, n); }
    this._len = n;
    if (this._pos > n) this._pos = n;
  }
  get position(): number { return this._pos; }
  set position(p: number) { this._pos = Number(p) >>> 0; }
  get bytesAvailable(): number { return Math.max(0, this._len - this._pos); }
  get endian(): string { return this._le ? Endian.LITTLE_ENDIAN : Endian.BIG_ENDIAN; }
  set endian(v: string) {
    if (v === Endian.LITTLE_ENDIAN) this._le = true;
    else if (v === Endian.BIG_ENDIAN) this._le = false;
    else throw new ArgumentError('Error #2008: Parameter endian must be one of the accepted values.', 2008);
  }

  get bytes(): Uint8Array { return this._buf.subarray(0, this._len); }

  private ensure(n: number): void {
    if (n <= this._buf.length) return;
    let cap = this._buf.length || 16;
    while (cap < n) cap *= 2;
    const nb = new Uint8Array(cap);
    nb.set(this._buf.subarray(0, this._len));
    this._buf = nb;
    this._view = new DataView(nb.buffer);
  }
  private need(n: number): number {
    if (this._pos + n > this._len) {
      throw new EOFError('Error #2030: End of file was encountered.', 2030);
    }
    const p = this._pos;
    this._pos += n;
    return p;
  }
  private grow(n: number): number {
    const p = this._pos;
    const end = p + n;
    this.ensure(end);
    if (end > this._len) this._len = end;
    this._pos = end;
    return p;
  }

  clear(): void { this._buf = new Uint8Array(16); this._view = new DataView(this._buf.buffer); this._len = 0; this._pos = 0; }

  readBoolean(): boolean { const p = this.need(1); return this._buf[p] !== 0; }
  readByte(): number { return this._view.getInt8(this.need(1)); }
  readUnsignedByte(): number { const p = this.need(1); return this._buf[p]; }
  readShort(): number { return this._view.getInt16(this.need(2), this._le); }
  readUnsignedShort(): number { return this._view.getUint16(this.need(2), this._le); }
  readInt(): number { return this._view.getInt32(this.need(4), this._le); }
  readUnsignedInt(): number { return this._view.getUint32(this.need(4), this._le); }
  readFloat(): number { return this._view.getFloat32(this.need(4), this._le); }
  readDouble(): number { return this._view.getFloat64(this.need(8), this._le); }
  readUTF(): string { return this.readUTFBytes(this.readUnsignedShort()); }
  readUTFBytes(length: number): string {
    const n = Number(length) >>> 0;
    const p = this.need(n);
    let s = decoder('utf-8').decode(this._buf.subarray(p, p + n));
    if (s.charCodeAt(0) === 0xfeff) s = s.slice(1);
    const z = s.indexOf('\0');
    return z >= 0 ? s.slice(0, z) : s;
  }
  readMultiByte(length: number, charSet: string): string {
    const n = Number(length) >>> 0;
    const p = this.need(n);
    const s = decoder(charSet).decode(this._buf.subarray(p, p + n));
    const z = s.indexOf('\0');
    return z >= 0 ? s.slice(0, z) : s;
  }
  readBytes(dest: ByteArray, offset = 0, length = 0): void {
    let n = Number(length) >>> 0;
    if (n === 0) n = this.bytesAvailable;
    const p = this.need(n);
    const d = ByteArray.raw(dest);
    const off = Number(offset) >>> 0;
    d.ensure(off + n);
    d._buf.set(this._buf.subarray(p, p + n), off);
    if (off + n > d._len) d._len = off + n;
  }
  readObject(): unknown {
    if (this.objectEncoding === 0) {
      const r = new AMF0Reader(this._buf.subarray(0, this._len), this._pos);
      const v = r.read();
      this._pos = r.pos;
      return v;
    }
    const [v, pos] = readAMF3(this._buf.subarray(0, this._len), this._pos);
    this._pos = pos;
    return v;
  }

  writeBoolean(v: unknown): void { const p = this.grow(1); this._buf[p] = v ? 1 : 0; }
  writeByte(v: unknown): void { const p = this.grow(1); this._buf[p] = Number(v) & 255; }
  writeShort(v: unknown): void { const p = this.grow(2); this._view.setInt16(p, Number(v) << 16 >> 16, this._le); }
  writeInt(v: unknown): void { const p = this.grow(4); this._view.setInt32(p, Number(v) | 0, this._le); }
  writeUnsignedInt(v: unknown): void { const p = this.grow(4); this._view.setUint32(p, Number(v) >>> 0, this._le); }
  writeFloat(v: unknown): void { const p = this.grow(4); this._view.setFloat32(p, Number(v), this._le); }
  writeDouble(v: unknown): void { const p = this.grow(8); this._view.setFloat64(p, Number(v), this._le); }
  writeUTF(v: unknown): void {
    const b = utf8enc.encode(String(v ?? ''));
    if (b.length > 65535) throw new RangeError('Error #2006: The supplied index is out of bounds.');
    this.writeShort(b.length);
    this.writeRaw(b);
  }
  writeUTFBytes(v: unknown): void { this.writeRaw(utf8enc.encode(String(v ?? ''))); }
  writeMultiByte(v: unknown, charSet: string): void {
    const cs = String(charSet || '').toLowerCase();
    const s = String(v ?? '');
    if (cs === 'unicode' || cs === 'utf-16' || cs === 'utf-16le') {
      const p = this.grow(s.length * 2);
      const view = this._view;
      for (let i = 0; i < s.length; i++) view.setUint16(p + i * 2, s.charCodeAt(i), true);
      return;
    }
    this.writeRaw(utf8enc.encode(s));
  }
  writeBytes(src: ByteArray, offset = 0, length = 0): void {
    const s = ByteArray.raw(src);
    const off = Number(offset) >>> 0;
    let n = Number(length) >>> 0;
    if (n === 0) n = Math.max(0, s._len - off);
    if (off + n > s._len) throw new RangeError('Error #2006: The supplied index is out of bounds.');
    this.writeRaw(s._buf.slice(off, off + n));
  }
  writeRaw(b: Uint8Array): void { const p = this.grow(b.length); this._buf.set(b, p); }
  writeObject(v: unknown): void {
    if (this.objectEncoding === 0) {
      const w = new AMF0Writer();
      w.write(v);
      this.writeRaw(w.bytes());
      return;
    }
    this.writeRaw(writeAMF3(v));
  }

  compress(algorithm = 'zlib'): void {
    if (this._len === 0) return;
    const data = this._buf.subarray(0, this._len);
    let out: Uint8Array;
    if (algorithm === 'deflate') out = deflateRaw(data);
    else if (algorithm === 'zlib' || !algorithm) out = deflate(data);
    else throw new IOError('Error #2058: There was an error decompressing the data.', 2058);
    this.setBytes(out);
    this._pos = this._len;
  }
  uncompress(algorithm = 'zlib'): void {
    if (this._len === 0) return;
    const data = this._buf.subarray(0, this._len);
    let out: Uint8Array;
    try {
      if (algorithm === 'deflate') out = inflateRaw(data);
      else if (algorithm === 'zlib' || !algorithm) out = inflate(data);
      else throw new Error('lzma');
    } catch {
      throw new IOError('Error #2058: There was an error decompressing the data.', 2058);
    }
    this.setBytes(out);
    this._pos = 0;
  }
  deflate(): void { this.compress('deflate'); }
  inflate(): void { this.uncompress('deflate'); }

  setBytes(b: Uint8Array | ArrayBuffer): void {
    const u = b instanceof Uint8Array ? b : new Uint8Array(b);
    this._buf = new Uint8Array(Math.max(16, u.length));
    this._buf.set(u);
    this._view = new DataView(this._buf.buffer);
    this._len = u.length;
    this._pos = 0;
  }

  toString(): string {
    let s = decoder('utf-8').decode(this._buf.subarray(0, this._len));
    if (s.charCodeAt(0) === 0xfeff) s = s.slice(1);
    return s;
  }
  toJSON(): unknown { return Array.from(this._buf.subarray(0, this._len)); }
  atomicCompareAndSwapIntAt(byteIndex: number, expected: number, newValue: number): number {
    const old = this._view.getInt32(byteIndex, this._le);
    if (old === expected) this._view.setInt32(byteIndex, newValue, this._le);
    return old;
  }
  atomicCompareAndSwapLength(expected: number, newLength: number): number {
    const old = this._len;
    if (old === expected) this.length = newLength;
    return old;
  }

  static fromBytes(b: Uint8Array | ArrayBuffer): ByteArray {
    const ba = new ByteArray();
    ByteArray.raw(ba).setBytes(b);
    return ba;
  }
}

for (const k of Object.getOwnPropertyNames(ByteArray.prototype)) {
  const d = Object.getOwnPropertyDescriptor(ByteArray.prototype, k);
  if (d && typeof d.value === 'function' && k !== 'constructor') nativeMethods.add(d.value);
}
