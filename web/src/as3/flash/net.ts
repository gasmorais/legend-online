import { initFields } from '../runtime';
import { Event, EventDispatcher, flDispatchSafe } from '@/flash/events';
import { ByteArray, Endian } from './bytearray';
import { AMF0Reader, AMF0Writer, readAMF3, writeAMF3 } from './amf';
import { EOFError, IOError, ArgumentError } from './errors';
import { DataEvent, HTTPStatusEvent, IOErrorEvent, NetStatusEvent, ProgressEvent, SecurityErrorEvent, StatusEvent } from './events';

export { registerClassAlias, getClassByAlias } from './amf';

const later = (fn: () => void) => { setTimeout(fn, 0); };

export const URLRequestMethod = { DELETE: 'DELETE', GET: 'GET', HEAD: 'HEAD', OPTIONS: 'OPTIONS', POST: 'POST', PUT: 'PUT' } as const;
export const URLLoaderDataFormat = { BINARY: 'binary', TEXT: 'text', VARIABLES: 'variables' } as const;

export class URLRequestHeader {
  name: string;
  value: string;
  constructor(name = '', value = '') { initFields(this, new.target); this.name = name; this.value = value; }
}

export class URLRequest {
  url: string | null;
  method = 'GET';
  data: unknown = null;
  contentType: string | null = null;
  requestHeaders: URLRequestHeader[] = [];
  digest: string | null = null;
  followRedirects = true;
  cacheResponse = true;
  useCache = true;
  manageCookies = true;
  idleTimeout = 0;
  authenticate = true;
  userAgent = navigator.userAgent;
  constructor(url: string | null = null) {
    initFields(this, new.target);
    this.url = url === null || url === undefined ? null : String(url);
  }
}

export class URLVariables {
  constructor(source: string | null = null) {
    initFields(this, new.target);
    delete (this as any).__fieldsInit;
    Object.defineProperty(this, '__fieldsInit', { value: true, enumerable: false });
    if (source) this.decode(source);
  }
  decode(source: string): void {
    for (const part of String(source).split('&')) {
      if (!part) continue;
      const i = part.indexOf('=');
      if (i < 0) throw new Error('Error #2101: The String passed to URLVariables.decode() must be a URL-encoded query string containing name/value pairs.');
      const k = unescapeAS(part.slice(0, i));
      const v = unescapeAS(part.slice(i + 1));
      const self = this as any;
      if (k in self && Object.prototype.hasOwnProperty.call(self, k)) {
        self[k] = Array.isArray(self[k]) ? [...self[k], v] : [self[k], v];
      } else self[k] = v;
    }
  }
  toString(): string {
    const out: string[] = [];
    for (const [k, v] of Object.entries(this)) {
      if (typeof v === 'function') continue;
      if (Array.isArray(v)) for (const x of v) out.push(`${escapeAS(k)}=${escapeAS(String(x))}`);
      else out.push(`${escapeAS(k)}=${escapeAS(String(v))}`);
    }
    return out.join('&');
  }
}

function escapeAS(s: string): string { return encodeURIComponent(s).replace(/[!'()*]/g, (c) => '%' + c.charCodeAt(0).toString(16).toUpperCase()); }
function unescapeAS(s: string): string { try { return decodeURIComponent(s.replace(/\+/g, ' ')); } catch { return s; } }

export interface HttpRequest { url: string; method: string; headers: Record<string, string>; body: string | Uint8Array | null }
export type HttpResponseLike = Response | ArrayBuffer | Uint8Array | string | { status?: number; body: ArrayBuffer | Uint8Array | string };

function buildRequest(req: URLRequest): HttpRequest {
  let url = req.url ?? '';
  const method = String(req.method || 'GET').toUpperCase();
  const headers: Record<string, string> = {};
  for (const h of req.requestHeaders ?? []) if (h?.name) headers[h.name] = String(h.value);
  let body: string | Uint8Array | null = null;
  const data = req.data;
  if (data !== null && data !== undefined) {
    if (method === 'GET' || method === 'HEAD') {
      const q = data instanceof ByteArray ? new TextDecoder().decode(ByteArray.raw(data).bytes) : String(data);
      if (q) url += (url.includes('?') ? '&' : '?') + q;
    } else if (data instanceof ByteArray) {
      body = ByteArray.raw(data).bytes.slice();
      headers['Content-Type'] = req.contentType ?? 'application/octet-stream';
    } else {
      body = String(data);
      headers['Content-Type'] = req.contentType ?? 'application/x-www-form-urlencoded';
    }
  }
  return { url, method, headers, body };
}

async function performHttp(r: HttpRequest): Promise<{ status: number; bytes: Uint8Array; url: string; headers: [string, string][] }> {
  let res: HttpResponseLike | null = null;
  if (URLLoader.interceptor) res = (await URLLoader.interceptor(r)) ?? null;
  if (!res) {
    res = await fetch(r.url, { method: r.method, headers: r.headers, body: r.body as BodyInit | null, credentials: 'same-origin' });
  }
  if (res instanceof Response) {
    return { status: res.status, bytes: new Uint8Array(await res.arrayBuffer()), url: res.url || r.url, headers: [...res.headers.entries()] };
  }
  const toBytes = (b: ArrayBuffer | Uint8Array | string) =>
    typeof b === 'string' ? new TextEncoder().encode(b) : b instanceof Uint8Array ? b : new Uint8Array(b);
  if (typeof res === 'string' || res instanceof ArrayBuffer || res instanceof Uint8Array) return { status: 200, bytes: toBytes(res), url: r.url, headers: [] };
  return { status: res.status ?? 200, bytes: toBytes(res.body), url: r.url, headers: [] };
}

export class URLLoader extends EventDispatcher {
  static interceptor: ((req: HttpRequest) => HttpResponseLike | null | Promise<HttpResponseLike | null>) | null = null;

  data: unknown = undefined;
  dataFormat = 'text';
  bytesLoaded = 0;
  bytesTotal = 0;
  private __seq = 0;

  constructor(request: URLRequest | null = null) {
    super();
    if (request) this.load(request);
  }

  load(request: URLRequest): void {
    if (!request) throw new TypeError('Error #2007: Parameter request must be non-null.');
    const seq = ++this.__seq;
    const r = buildRequest(request);
    later(async () => {
      if (seq !== this.__seq) return;
      flDispatchSafe(this, new Event('open'));
      let resp;
      try {
        resp = await performHttp(r);
      } catch (err) {
        if (seq !== this.__seq) return;
        console.warn('[URLLoader] falha', r.url, err);
        flDispatchSafe(this, new HTTPStatusEvent('httpStatus', false, false, 0));
        flDispatchSafe(this, new IOErrorEvent('ioError', false, false, `Error #2032: Stream Error. URL: ${r.url}`, 2032));
        return;
      }
      if (seq !== this.__seq) return;
      this.bytesLoaded = this.bytesTotal = resp.bytes.length;
      const st = new HTTPStatusEvent('httpStatus', false, false, resp.status);
      st.responseURL = resp.url;
      st.responseHeaders = resp.headers.map(([n, v]) => new URLRequestHeader(n, v));
      flDispatchSafe(this, st);
      if (resp.status >= 400 || resp.status === 0) {
        flDispatchSafe(this, new IOErrorEvent('ioError', false, false, `Error #2032: Stream Error. URL: ${r.url}`, 2032));
        return;
      }
      flDispatchSafe(this, new ProgressEvent('progress', false, false, this.bytesLoaded, this.bytesTotal));
      try {
        if (this.dataFormat === 'binary') this.data = ByteArray.fromBytes(resp.bytes);
        else {
          const text = new TextDecoder().decode(resp.bytes).replace(/^﻿/, '');
          this.data = this.dataFormat === 'variables' ? new URLVariables(text) : text;
        }
      } catch (err) {
        flDispatchSafe(this, new IOErrorEvent('ioError', false, false, String((err as Error).message ?? err), 2101));
        return;
      }
      flDispatchSafe(this, new Event('complete'));
    });
  }

  close(): void { this.__seq++; }
}

abstract class DataPipe extends EventDispatcher {
  protected __in = new ByteArray();
  protected __out = new ByteArray();
  objectEncoding = 3;

  get endian(): string { return this.__in.endian; }
  set endian(v: string) { this.__in.endian = v; this.__out.endian = v; }
  get bytesAvailable(): number { return this.__in.bytesAvailable; }

  protected feed(data: Uint8Array): void {
    const b = this.__in;
    if (b.bytesAvailable === 0) { b.clear(); }
    const pos = b.position;
    b.position = b.length;
    ByteArray.raw(b).writeRaw(data);
    b.position = pos;
  }
  private need(n: number): void {
    if (this.__in.bytesAvailable < n) throw new EOFError('Error #2030: End of file was encountered.', 2030);
  }
  readBoolean(): boolean { this.need(1); return this.__in.readBoolean(); }
  readByte(): number { this.need(1); return this.__in.readByte(); }
  readUnsignedByte(): number { this.need(1); return this.__in.readUnsignedByte(); }
  readShort(): number { this.need(2); return this.__in.readShort(); }
  readUnsignedShort(): number { this.need(2); return this.__in.readUnsignedShort(); }
  readInt(): number { this.need(4); return this.__in.readInt(); }
  readUnsignedInt(): number { this.need(4); return this.__in.readUnsignedInt(); }
  readFloat(): number { this.need(4); return this.__in.readFloat(); }
  readDouble(): number { this.need(8); return this.__in.readDouble(); }
  readUTF(): string { return this.__in.readUTF(); }
  readUTFBytes(n: number): string { this.need(n); return this.__in.readUTFBytes(n); }
  readMultiByte(n: number, cs: string): string { this.need(n); return this.__in.readMultiByte(n, cs); }
  readBytes(dest: ByteArray, offset = 0, length = 0): void { this.__in.readBytes(dest, offset, length); }
  readObject(): unknown { this.__in.objectEncoding = this.objectEncoding; return this.__in.readObject(); }
}

export class URLStream extends DataPipe {
  private __seq = 0;
  private __connected = false;
  get connected(): boolean { return this.__connected; }
  load(request: URLRequest): void {
    const seq = ++this.__seq;
    const r = buildRequest(request);
    this.__in.clear();
    this.__connected = true;
    later(async () => {
      if (seq !== this.__seq) return;
      flDispatchSafe(this, new Event('open'));
      try {
        const resp = await performHttp(r);
        if (seq !== this.__seq) return;
        flDispatchSafe(this, new HTTPStatusEvent('httpStatus', false, false, resp.status));
        if (resp.status >= 400) throw new Error(String(resp.status));
        this.feed(resp.bytes);
        flDispatchSafe(this, new ProgressEvent('progress', false, false, resp.bytes.length, resp.bytes.length));
        this.__connected = false;
        flDispatchSafe(this, new Event('complete'));
      } catch {
        if (seq !== this.__seq) return;
        this.__connected = false;
        flDispatchSafe(this, new IOErrorEvent('ioError', false, false, `Error #2032: Stream Error. URL: ${r.url}`, 2032));
      }
    });
  }
  close(): void { this.__seq++; this.__connected = false; }
  stop(): void { this.close(); }
}

export interface SocketEndpoint {
  receive(data: Uint8Array): void;
  closed(): void;
  error(message?: string): void;
}
export interface SocketLink {
  send(data: Uint8Array): void;
  close(): void;
}
export type SocketTransport = (host: string, port: number, endpoint: SocketEndpoint) => SocketLink | Promise<SocketLink>;

export const webSocketTransport: SocketTransport = (host, port, endpoint) => new Promise<SocketLink>((resolve, reject) => {
  const ws = new WebSocket(Socket.wsUrl(host, port));
  ws.binaryType = 'arraybuffer';
  let open = false;
  ws.onopen = () => {
    open = true;
    resolve({ send: (d) => ws.send(d), close: () => ws.close() });
  };
  ws.onmessage = (m) => {
    if (m.data instanceof ArrayBuffer) endpoint.receive(new Uint8Array(m.data));
    else if (typeof m.data === 'string') endpoint.receive(new TextEncoder().encode(m.data));
  };
  ws.onerror = () => { if (!open) reject(new Error('websocket')); else endpoint.error('Error #2031: Socket Error.'); };
  ws.onclose = () => { if (open) endpoint.closed(); else reject(new Error('websocket fechado')); };
});

export class Socket extends DataPipe {
  static transport: SocketTransport | null = webSocketTransport;
  static wsUrl: (host: string, port: number) => string = (host, port) => `ws://${host}:${port}/socket`;

  timeout = 20000;
  private __link: SocketLink | null = null;
  private __connected = false;
  private __seq = 0;
  private __host: string | null = null;
  private __port = 0;
  private __flushQueued = false;

  constructor(host: string | null = null, port = 0) {
    super();
    if (host && port) this.connect(host, port);
  }

  get connected(): boolean { return this.__connected; }
  get remoteAddress(): string | null { return this.__host; }
  get remotePort(): number { return this.__port; }
  get localAddress(): string { return '127.0.0.1'; }
  get localPort(): number { return 0; }
  get bytesPending(): number { return this.__out.length; }

  connect(host: string, port: number): void {
    if (port < 0 || port > 65535) throw new RangeError('Error #2003: Invalid socket port number specified.');
    if (this.__link) this.closeLink();
    const seq = ++this.__seq;
    this.__host = String(host);
    this.__port = Number(port) | 0;
    this.__in.clear();
    this.__out.clear();
    const endpoint: SocketEndpoint = {
      receive: (data) => {
        if (seq !== this.__seq) return;
        this.feed(data);
        flDispatchSafe(this, new ProgressEvent('socketData', false, false, data.length, 0));
      },
      closed: () => {
        if (seq !== this.__seq) return;
        this.__connected = false;
        this.__link = null;
        flDispatchSafe(this, new Event('close'));
      },
      error: (msg) => {
        if (seq !== this.__seq) return;
        const was = this.__connected;
        this.__connected = false;
        this.__link = null;
        flDispatchSafe(this, new IOErrorEvent('ioError', false, false, msg ?? 'Error #2031: Socket Error.', 2031));
        if (was) flDispatchSafe(this, new Event('close'));
      },
    };
    const fail = () => {
      if (seq !== this.__seq) return;
      flDispatchSafe(this, new IOErrorEvent('ioError', false, false, `Error #2031: Socket Error. URL: ${host}`, 2031));
      flDispatchSafe(this, new SecurityErrorEvent('securityError', false, false,
        `Error #2048: Security sandbox violation: cannot load data from ${host}:${port}.`, 2048));
    };
    const transport = Socket.transport;
    if (!transport) { later(fail); return; }
    const timer = this.timeout > 0 ? setTimeout(() => { if (seq === this.__seq && !this.__connected) { this.__seq++; fail(); } }, this.timeout) : null;
    Promise.resolve()
      .then(() => transport(this.__host!, this.__port, endpoint))
      .then((link) => {
        if (timer) clearTimeout(timer);
        if (seq !== this.__seq) { link.close(); return; }
        this.__link = link;
        this.__connected = true;
        flDispatchSafe(this, new Event('connect'));
        if (this.__out.length) this.flush();
      }, (err) => {
        if (timer) clearTimeout(timer);
        console.warn('[Socket] falha ao conectar', host, port, err);
        fail();
      });
  }

  private closeLink(): void {
    const l = this.__link;
    this.__link = null;
    this.__connected = false;
    try { l?.close(); } catch { }
  }

  close(): void {
    if (!this.__connected && !this.__link) throw new IOError('Error #2002: Operation attempted on invalid socket.', 2002);
    this.__seq++;
    this.closeLink();
  }

  flush(): void {
    if (!this.__connected || !this.__link) {
      if (!this.__host) throw new IOError('Error #2002: Operation attempted on invalid socket.', 2002);
      return;
    }
    const raw = ByteArray.raw(this.__out);
    if (raw.length === 0) return;
    const data = raw.bytes.slice();
    this.__out.clear();
    this.__link.send(data);
  }

  private autoFlush(): void {
    if (this.__flushQueued) return;
    this.__flushQueued = true;
    later(() => { this.__flushQueued = false; if (this.__connected) this.flush(); });
  }

  private w(): ByteArray {
    if (!this.__connected && !this.__host) throw new IOError('Error #2002: Operation attempted on invalid socket.', 2002);
    this.autoFlush();
    return this.__out;
  }
  writeBoolean(v: unknown): void { this.w().writeBoolean(v); }
  writeByte(v: unknown): void { this.w().writeByte(v); }
  writeShort(v: unknown): void { this.w().writeShort(v); }
  writeInt(v: unknown): void { this.w().writeInt(v); }
  writeUnsignedInt(v: unknown): void { this.w().writeUnsignedInt(v); }
  writeFloat(v: unknown): void { this.w().writeFloat(v); }
  writeDouble(v: unknown): void { this.w().writeDouble(v); }
  writeUTF(v: unknown): void { this.w().writeUTF(v); }
  writeUTFBytes(v: unknown): void { this.w().writeUTFBytes(v); }
  writeMultiByte(v: unknown, cs: string): void { this.w().writeMultiByte(v, cs); }
  writeBytes(b: ByteArray, offset = 0, length = 0): void { this.w().writeBytes(b, offset, length); }
  writeObject(v: unknown): void { const o = this.w(); o.objectEncoding = this.objectEncoding; o.writeObject(v); }
}

export class XMLSocket extends EventDispatcher {
  timeout = 20000;
  private __sock = new Socket();
  private __buf: number[] = [];
  constructor(host: string | null = null, port = 0) {
    super();
    const s = this.__sock;
    s.addEventListener('connect', () => flDispatchSafe(this, new Event('connect')));
    s.addEventListener('close', () => flDispatchSafe(this, new Event('close')));
    s.addEventListener('ioError', (e: any) => flDispatchSafe(this, new IOErrorEvent('ioError', false, false, e.text, e.errorID)));
    s.addEventListener('securityError', (e: any) => flDispatchSafe(this, new SecurityErrorEvent('securityError', false, false, e.text, e.errorID)));
    s.addEventListener('socketData', () => {
      while (s.bytesAvailable) {
        const b = s.readUnsignedByte();
        if (b === 0) {
          const text = new TextDecoder().decode(Uint8Array.from(this.__buf));
          this.__buf = [];
          flDispatchSafe(this, new DataEvent('data', false, false, text));
        } else this.__buf.push(b);
      }
    });
    if (host && port) this.connect(host, port);
  }
  get connected(): boolean { return this.__sock.connected; }
  connect(host: string, port: number): void { this.__sock.connect(host, port); }
  send(obj: unknown): void {
    const s = obj && typeof (obj as any).toXMLString === 'function' ? (obj as any).toXMLString() : String(obj);
    this.__sock.writeUTFBytes(s);
    this.__sock.writeByte(0);
    this.__sock.flush();
  }
  close(): void { try { this.__sock.close(); } catch { } }
}

export class Responder {
  readonly __result: ((r: unknown) => void) | null;
  readonly __status: ((s: unknown) => void) | null;
  constructor(result: ((r: unknown) => void) | null, status: ((s: unknown) => void) | null = null) {
    initFields(this, new.target);
    this.__result = typeof result === 'function' ? result : null;
    this.__status = typeof status === 'function' ? status : null;
  }
}

export type NetConnectionTransport = (nc: NetConnection, command: string, args: unknown[]) => Promise<unknown>;

export class NetConnection extends EventDispatcher {
  static transport: NetConnectionTransport | null = null;
  static defaultObjectEncoding = 3;

  client: unknown = this;
  objectEncoding = NetConnection.defaultObjectEncoding;
  proxyType = 'none';
  maxPeerConnections = 8;
  private __uri: string | null = null;
  private __connected = false;
  private __seq = 0;
  private __headers: { name: string; mustUnderstand: boolean; data: unknown }[] = [];

  get uri(): string | null { return this.__uri; }
  get connected(): boolean { return this.__connected; }
  get connectedProxyType(): string { return 'none'; }
  get usingTLS(): boolean { return !!this.__uri?.startsWith('https'); }
  get protocol(): string { return this.__uri?.split(':')[0] ?? 'http'; }
  get farID(): string { return ''; }
  get nearID(): string { return ''; }

  connect(command: string | null, ..._args: unknown[]): void {
    this.__uri = command === null || command === undefined ? null : String(command);
    const http = !this.__uri || /^https?:/i.test(this.__uri);
    this.__connected = !this.__uri || !http ? true : false;
    if (!http || !this.__uri) {
      later(() => flDispatchSafe(this, new NetStatusEvent('netStatus', false, false, { code: 'NetConnection.Connect.Success', level: 'status' })));
    }
  }

  addHeader(operation: string, mustUnderstand = false, param: unknown = null): void {
    this.__headers = this.__headers.filter((h) => h.name !== operation);
    this.__headers.push({ name: operation, mustUnderstand, data: param });
  }

  call(command: string, responder: Responder | null, ...args: unknown[]): void {
    const id = ++this.__seq;
    const run = NetConnection.transport
      ? NetConnection.transport(this, command, args)
      : this.__uri ? amfRemoting(this.__uri, command, args, id, this.__headers, this.objectEncoding) : Promise.reject(new Error('sem uri'));
    run.then(
      (r) => { try { responder?.__result?.(r); } catch (err) { console.error('[NetConnection] onResult', err); } },
      (err) => {
        if (responder?.__status) {
          try { responder.__status(err?.status ?? { code: 'NetConnection.Call.Failed', level: 'error', description: String(err?.message ?? err) }); }
          catch (e) { console.error('[NetConnection] onStatus', e); }
        } else {
          flDispatchSafe(this, new NetStatusEvent('netStatus', false, false, { code: 'NetConnection.Call.Failed', level: 'error',
            description: String(err?.message ?? err), details: this.__uri }));
        }
      },
    );
  }

  close(): void {
    const was = this.__connected;
    this.__connected = false;
    if (was) later(() => flDispatchSafe(this, new NetStatusEvent('netStatus', false, false, { code: 'NetConnection.Connect.Closed', level: 'status' })));
  }
}

async function amfRemoting(uri: string, command: string, args: unknown[], id: number,
  headers: { name: string; mustUnderstand: boolean; data: unknown }[], encoding: number): Promise<unknown> {
  const out: number[] = [];
  const u16 = (v: number) => out.push((v >> 8) & 255, v & 255);
  const u32 = (v: number) => { u16(v >>> 16); u16(v & 0xffff); };
  const str = (s: string) => { const b = new TextEncoder().encode(s); u16(b.length); out.push(...b); };
  const value = (v: unknown) => {
    if (encoding === 3) { out.push(0x11); out.push(...writeAMF3(v)); } else { const w = new AMF0Writer(); w.write(v); out.push(...w.bytes()); }
  };
  u16(encoding === 3 ? 3 : 0);
  u16(headers.length);
  for (const h of headers) { str(h.name); out.push(h.mustUnderstand ? 1 : 0); u32(0xffffffff); value(h.data); }
  u16(1);
  str(command);
  str(`/${id}`);
  u32(0xffffffff);
  out.push(0x0a);
  u32(args.length);
  for (const a of args) value(a);
  const resp = await performHttp({ url: uri, method: 'POST', headers: { 'Content-Type': 'application/x-amf' }, body: Uint8Array.from(out) });
  if (resp.status >= 400) throw new Error(`HTTP ${resp.status}`);
  const d = resp.bytes;
  const view = new DataView(d.buffer, d.byteOffset, d.byteLength);
  let p = 2;
  const r16 = () => { const v = view.getUint16(p); p += 2; return v; };
  const rstr = () => { const n = r16(); const s = new TextDecoder().decode(d.subarray(p, p + n)); p += n; return s; };
  const hc = r16();
  for (let i = 0; i < hc; i++) { rstr(); p += 1 + 4; const rd = new AMF0Reader(d, p); rd.read(); p = rd.pos; }
  const mc = r16();
  for (let i = 0; i < mc; i++) {
    const target = rstr();
    rstr();
    p += 4;
    let v: unknown;
    if (d[p] === 0x11) { const [val, np] = readAMF3(d, p + 1); v = val; p = np; } else { const rd = new AMF0Reader(d, p); v = rd.read(); p = rd.pos; }
    if (target.startsWith(`/${id}/`)) {
      if (target.endsWith('onResult')) return v;
      throw Object.assign(new Error('onStatus'), { status: v });
    }
  }
  throw new Error('resposta AMF sem corpo para a chamada');
}

export class NetStream extends EventDispatcher {
  static readonly CONNECT_TO_FMS = 'connectToFMS';
  static readonly DIRECT_CONNECTIONS = 'directConnections';
  bufferTime = 0.1;
  client: unknown = this;
  soundTransform: unknown = null;
  time = 0;
  bytesLoaded = 0;
  bytesTotal = 0;
  checkPolicyFile = false;
  constructor(_conn: NetConnection, _peerID = 'connectToFMS') { super(); }
  play(..._a: unknown[]): void {
    later(() => flDispatchSafe(this, new NetStatusEvent('netStatus', false, false, { code: 'NetStream.Play.StreamNotFound', level: 'error' })));
  }
  pause(): void {}
  resume(): void {}
  togglePause(): void {}
  seek(_t: number): void {}
  close(): void {}
  dispose(): void {}
  appendBytes(_b: ByteArray): void {}
  appendBytesAction(_a: string): void {}
  attach(_c: unknown): void {}
  publish(): void {}
  receiveAudio(): void {}
  receiveVideo(): void {}
}

const SO_PREFIX = 'flashso:';
const soCache = new Map<string, SharedObject>();

function b64(bytes: Uint8Array): string {
  let s = '';
  for (let i = 0; i < bytes.length; i += 0x8000) s += String.fromCharCode(...bytes.subarray(i, i + 0x8000));
  return btoa(s);
}
function unb64(s: string): Uint8Array { return Uint8Array.from(atob(s), (c) => c.charCodeAt(0)); }

export class SharedObject extends EventDispatcher {
  static defaultObjectEncoding = 3;
  static persist = true;

  data: Record<string, unknown> = {};
  client: unknown = this;
  objectEncoding = 3;
  fps = 0;
  private __key = '';

  static getLocal(name: string, localPath: string | null = null, _secure = false): SharedObject {
    if (!name || /[~%&\\;:"',<>?#\s]/.test(name)) throw new Error(`Error #2134: Cannot create SharedObject. (${name})`);
    const key = `${SO_PREFIX}${localPath ?? location.pathname}/${name}`;
    let so = soCache.get(key);
    if (!so) {
      so = new SharedObject();
      so.__key = key;
      try {
        const raw = localStorage.getItem(key);
        if (raw) {
          const [v] = readAMF3(unb64(raw), 0);
          if (v && typeof v === 'object') so.data = v as Record<string, unknown>;
        }
      } catch (err) { console.warn('[SharedObject] dados corrompidos', key, err); }
      soCache.set(key, so);
    }
    return so;
  }
  static getRemote(name: string, _uri: string | null = null, _persistence: unknown = false): SharedObject {
    const so = new SharedObject();
    so.__key = `${SO_PREFIX}remote/${name}`;
    return so;
  }
  static deleteAll(url: string): number {
    let n = 0;
    try {
      for (let i = localStorage.length - 1; i >= 0; i--) {
        const k = localStorage.key(i);
        if (k?.startsWith(SO_PREFIX) && k.includes(url)) { localStorage.removeItem(k); n++; }
      }
    } catch { }
    return n;
  }
  static getDiskUsage(_url: string): number { return 0; }

  get size(): number { try { return writeAMF3(this.data).length; } catch { return 0; } }

  flush(_minDiskSpace = 0): string {
    if (!SharedObject.persist) return 'flushed';
    try {
      localStorage.setItem(this.__key, b64(writeAMF3(this.data)));
      return 'flushed';
    } catch (err) {
      console.warn('[SharedObject] flush falhou', err);
      throw new Error('Error #2130: Unable to flush SharedObject.');
    }
  }
  clear(): void {
    this.data = {};
    try { localStorage.removeItem(this.__key); } catch { }
  }
  close(): void {}
  connect(_nc: NetConnection, _params: string | null = null): void {}
  send(..._a: unknown[]): void {}
  setDirty(_name: string): void {}
  setProperty(name: string, value: unknown = null): void {
    if (value === null || value === undefined) delete this.data[name]; else this.data[name] = value;
  }
}

addEventListener('pagehide', () => { for (const so of soCache.values()) { try { so.flush(); } catch { } } });

export const SharedObjectFlushStatus = { FLUSHED: 'flushed', PENDING: 'pending' } as const;

const lcRegistry = new Map<string, LocalConnection>();

export class LocalConnection extends EventDispatcher {
  static readonly isSupported = true;
  client: any = this;
  isPerUser = false;
  private __name: string | null = null;
  get domain(): string { return location.hostname || 'localhost'; }
  connect(name: string): void {
    if (lcRegistry.has(name)) throw new ArgumentError('Error #2082: Connect failed because the object is already connected.', 2082);
    this.__name = name;
    lcRegistry.set(name, this);
  }
  send(name: string, method: string, ...args: unknown[]): void {
    later(() => {
      const target = lcRegistry.get(name);
      const fn = target?.client?.[method];
      if (typeof fn === 'function') {
        try { fn.apply(target!.client, args); } catch (err) { console.error('[LocalConnection]', err); }
        flDispatchSafe(this, new StatusEvent('status', false, false, null as unknown as string, 'status'));
      } else {
        flDispatchSafe(this, new StatusEvent('status', false, false, null as unknown as string, 'error'));
      }
    });
  }
  close(): void { if (this.__name) lcRegistry.delete(this.__name); this.__name = null; }
  allowDomain(..._d: string[]): void {}
  allowInsecureDomain(..._d: string[]): void {}
}

export class FileFilter {
  description: string;
  extension: string;
  macType: string | null;
  constructor(description: string, extension: string, macType: string | null = null) {
    initFields(this, new.target);
    this.description = description;
    this.extension = extension;
    this.macType = macType;
  }
}

function pickFiles(filters: FileFilter[] | null, multiple: boolean): Promise<File[]> {
  return new Promise((resolve) => {
    const input = document.createElement('input');
    input.type = 'file';
    input.multiple = multiple;
    if (filters?.length) input.accept = filters.map((f) => f.extension.split(';').map((e) => e.replace(/^\*/, '')).join(',')).join(',');
    input.onchange = () => resolve(input.files ? [...input.files] : []);
    addEventListener('focus', () => setTimeout(() => { if (!input.files?.length) resolve([]); }, 500), { once: true });
    input.click();
  });
}

function download(data: Uint8Array | string, name: string): void {
  const blob = new Blob([data as BlobPart]);
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = name || 'download';
  a.click();
  setTimeout(() => URL.revokeObjectURL(a.href), 1000);
}

export class FileReference extends EventDispatcher {
  private __file: File | null = null;
  data: ByteArray | null = null;
  get name(): string | null { return this.__file?.name ?? null; }
  get size(): number { return this.__file?.size ?? 0; }
  get type(): string | null { const n = this.__file?.name; return n && n.includes('.') ? '.' + n.split('.').pop() : null; }
  get extension(): string | null { const t = this.type; return t ? t.slice(1) : null; }
  get creationDate(): Date | null { return this.__file ? new Date(this.__file.lastModified) : null; }
  get modificationDate(): Date | null { return this.creationDate; }
  get creator(): string | null { return null; }

  setFile(f: File): void { this.__file = f; }

  browse(typeFilter: FileFilter[] | null = null): boolean {
    void pickFiles(typeFilter, false).then((files) => {
      if (!files.length) { flDispatchSafe(this, new Event('cancel')); return; }
      this.__file = files[0];
      this.data = null;
      flDispatchSafe(this, new Event('select'));
    });
    return true;
  }
  load(): void {
    const f = this.__file;
    if (!f) throw new Error('Error #2037: Functions called in incorrect sequence, or earlier call was unsuccessful.');
    flDispatchSafe(this, new Event('open'));
    f.arrayBuffer().then((buf) => {
      this.data = ByteArray.fromBytes(buf);
      flDispatchSafe(this, new ProgressEvent('progress', false, false, buf.byteLength, buf.byteLength));
      flDispatchSafe(this, new Event('complete'));
    }, () => flDispatchSafe(this, new IOErrorEvent('ioError', false, false, 'Error #2038: File I/O Error.', 2038)));
  }
  save(data: unknown, defaultFileName: string | null = null): void {
    const bytes = data instanceof ByteArray ? ByteArray.raw(data).bytes.slice() : String(data && typeof (data as any).toXMLString === 'function' ? (data as any).toXMLString() : data);
    download(bytes, defaultFileName ?? 'arquivo');
    later(() => { flDispatchSafe(this, new Event('select')); flDispatchSafe(this, new Event('complete')); });
  }
  upload(request: URLRequest, uploadDataFieldName = 'Filedata', _testUpload = false): void {
    const f = this.__file;
    if (!f) throw new Error('Error #2037: Functions called in incorrect sequence, or earlier call was unsuccessful.');
    const form = new FormData();
    if (request.data instanceof URLVariables) for (const [k, v] of Object.entries(request.data)) form.append(k, String(v));
    form.append('Filename', f.name);
    form.append(uploadDataFieldName, f, f.name);
    flDispatchSafe(this, new Event('open'));
    fetch(request.url ?? '', { method: 'POST', body: form }).then(async (res) => {
      flDispatchSafe(this, new HTTPStatusEvent('httpStatus', false, false, res.status));
      if (!res.ok) throw new Error(String(res.status));
      const text = await res.text();
      flDispatchSafe(this, new ProgressEvent('progress', false, false, f.size, f.size));
      flDispatchSafe(this, new Event('complete'));
      flDispatchSafe(this, new DataEvent('uploadCompleteData', false, false, text));
    }).catch(() => flDispatchSafe(this, new IOErrorEvent('ioError', false, false, 'Error #2038: File I/O Error.', 2038)));
  }
  download(request: URLRequest, defaultFileName: string | null = null): void {
    fetch(buildRequest(request).url).then(async (res) => {
      download(new Uint8Array(await res.arrayBuffer()), defaultFileName ?? request.url?.split('/').pop() ?? 'download');
      flDispatchSafe(this, new Event('complete'));
    }).catch(() => flDispatchSafe(this, new IOErrorEvent('ioError', false, false, 'Error #2038: File I/O Error.', 2038)));
  }
  cancel(): void {}
  requestPermission(): void {}
  static readonly permissionStatus = 'granted';
}

export class FileReferenceList extends EventDispatcher {
  fileList: FileReference[] | null = null;
  browse(typeFilter: FileFilter[] | null = null): boolean {
    void pickFiles(typeFilter, true).then((files) => {
      if (!files.length) { flDispatchSafe(this, new Event('cancel')); return; }
      this.fileList = files.map((f) => { const r = new FileReference(); r.setFile(f); return r; });
      flDispatchSafe(this, new Event('select'));
    });
    return true;
  }
}

export const navigation: { handler: ((url: string, target: string) => boolean) | null } = { handler: null };

export function navigateToURL(request: URLRequest, window_: string | null = null): void {
  if (!request) throw new TypeError('Error #2007: Parameter request must be non-null.');
  const r = buildRequest(request);
  const target = window_ ?? '_blank';
  if (navigation.handler?.(r.url, target)) return;
  if (!r.url) return;
  if (/^javascript:/i.test(r.url)) return;
  window.open(r.url, target);
}

export function sendToURL(request: URLRequest): void {
  const r = buildRequest(request);
  fetch(r.url, { method: r.method, headers: r.headers, body: r.body as BodyInit | null, mode: 'no-cors' }).catch(() => {});
}

export { Endian };
