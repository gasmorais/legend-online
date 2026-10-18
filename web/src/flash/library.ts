import { Assets, Texture } from 'pixi.js';
import type { Container } from 'pixi.js';
import { BitmapData } from './bitmapdata';

export { BitmapData };

export interface PlaceOp {
  op: 'place';
  d: number;
  c?: number;
  m?: [number, number, number, number, number, number];
  cx?: number[];
  r?: number;
  n?: string;
  clip?: number;
  f?: Record<string, unknown>[];
  bl?: string;
  cab?: number;
  v?: number;
  move?: number;
  cls?: string;
}
export interface RemoveOp { op: 'remove'; d: number }
export type TimelineOp = PlaceOp | RemoveOp;

export interface CharDef {
  kind: 'bitmap' | 'shape' | 'morph' | 'text' | 'edit' | 'sprite' | 'button' | 'font' | 'sound' | 'binary';
  src?: string;
  x?: number; y?: number; w?: number; h?: number;
  frames?: number;
  labels?: Record<string, number>;
  timeline?: TimelineOp[][];
  records?: { states: string[]; c: number; d: number; m: number[]; cx?: number[]; f?: Record<string, unknown>[]; bl?: string }[];
  scripts?: Record<string, string[]>;
  [k: string]: unknown;
}

export interface LibraryData {
  stage: { x: number; y: number; w: number; h: number };
  fps: number;
  linkage: Record<string, number>;
  chars: Record<string, CharDef>;
  main: { frames: number; labels: Record<string, number>; timeline: TimelineOp[][] };
}

const MAX_LOADS = 16;
let active = 0;
const waiting: (() => void)[] = [];
async function throttled<T>(fn: () => Promise<T>): Promise<T> {
  if (active >= MAX_LOADS) await new Promise<void>((r) => waiting.push(r));
  active++;
  try { return await fn(); } finally { active--; waiting.shift()?.(); }
}

export class SwfLibrary {
  readonly textures = new Map<number, Texture>();
  private pending = new Map<number, Promise<Texture>>();
  constructor(public readonly name: string, public readonly data: LibraryData) {}

  get fps(): number { return this.data.fps || 24; }

  char(id: number): CharDef | undefined { return this.data.chars[String(id)]; }

  static async load(name: string): Promise<SwfLibrary> {
    const res = await fetch(`/lib/${name}/library.json`);
    if (!res.ok) throw new Error(`biblioteca ${name}: HTTP ${res.status}`);
    return new SwfLibrary(name, (await res.json()) as LibraryData);
  }

  static skipTextures = false;

  texture(id: number): Promise<Texture> {
    if (SwfLibrary.skipTextures) return Promise.resolve(Texture.EMPTY);
    const ready = this.textures.get(id);
    if (ready) return Promise.resolve(ready);
    let p = this.pending.get(id);
    if (!p) {
      const c = this.char(id);
      if (!c?.src) return Promise.resolve(Texture.EMPTY);
      const url = `/lib/${this.name}/${c.src}`;
      const isSvg = url.endsWith('.svg');
      p = throttled(() => Assets.load(isSvg ? { src: url, data: { resolution: 2 } } : url) as Promise<Texture>)
        .then((tex) => { this.textures.set(id, tex); return tex; })
        .catch((err) => { console.warn('[lib] falha ao carregar', url, err); return Texture.EMPTY; });
      this.pending.set(id, p);
    }
    return p;
  }

  bitmapData(id: number): BitmapData {
    const c = this.char(id);
    const ready = this.textures.get(id);
    return ready ? new BitmapData(ready, c?.w, c?.h) : new BitmapData(this.texture(id), c?.w ?? 0, c?.h ?? 0);
  }
}

type Ctor = new (...args: any[]) => unknown;
type SymbolFactory = (lib: SwfLibrary, id: number, name: string) => unknown;

class DomainClass {
  readonly libs = new Map<string, SwfLibrary>();
  private loading = new Map<string, Promise<SwfLibrary>>();
  private classes = new Map<string, Ctor>();
  private symbolIndex = new Map<string, [string, number]>();
  factories: Partial<Record<CharDef['kind'], SymbolFactory>> = {};

  async init(): Promise<void> {
    const res = await fetch('/lib/linkage.json');
    const data = (await res.json()) as Record<string, [string, number]>;
    for (const [k, v] of Object.entries(data)) this.symbolIndex.set(k, v);
  }

  registerClass(name: string, ctor: Ctor): void { this.classes.set(name, ctor); }

  libraryOf(name: string): string | undefined { return this.symbolIndex.get(name)?.[0]; }

  async ensure(names: Iterable<string>): Promise<void> {
    await Promise.all([...new Set(names)].map((n) => this.loadLibrary(n)));
  }

  loadLibrary(name: string): Promise<SwfLibrary> {
    const ready = this.libs.get(name);
    if (ready) return Promise.resolve(ready);
    let p = this.loading.get(name);
    if (!p) {
      p = SwfLibrary.load(name).then((lib) => { this.libs.set(name, lib); return lib; });
      this.loading.set(name, p);
    }
    return p;
  }

  classNames(): string[] { return [...this.classes.keys()]; }

  symbolOf(name: string): [SwfLibrary, number] | undefined { return this.findSymbol(name); }

  hasSymbolIndex(name: string): boolean { return this.symbolIndex.has(name); }

  private findSymbol(name: string): [SwfLibrary, number] | undefined {
    const idx = this.symbolIndex.get(name);
    if (idx) {
      const lib = this.libs.get(idx[0]);
      if (lib) return [lib, idx[1]];
    }
    for (const lib of this.libs.values()) {
      const id = lib.data.linkage[name];
      if (id !== undefined) return [lib, id];
    }
    return undefined;
  }

  missingPlaceholder: ((name: string) => unknown) | null = null;
  readonly missingLogged = new Set<string>();

  codeResolver: ((name: string) => Ctor | undefined) | null = null;

  hasDefinition(name: string): boolean {
    return this.classes.has(name) || this.findSymbol(name) !== undefined || !!this.codeResolver?.(name);
  }

  isClass(name: string): boolean { return this.classes.has(name); }

  getClass(name: string): Ctor | undefined { return this.classes.get(name); }

  symbolKind(name: string): CharDef['kind'] | undefined {
    const s = this.findSymbol(name);
    return s ? s[0].char(s[1])?.kind : undefined;
  }

  createInstance<T = any>(name: string, args: unknown[] = []): T {
    const ctor = this.classes.get(name) ?? this.codeResolver?.(name);
    if (ctor) return new ctor(...args) as T;
    const sym = this.findSymbol(name);
    if (!sym) {
      if (this.missingPlaceholder) {
        if (!this.missingLogged.has(name)) { this.missingLogged.add(name); console.warn(`[domain] símbolo ausente (placeholder): ${name}`); }
        return this.missingPlaceholder(name) as T;
      }
      throw new Error(`classe não encontrada: "${name}"`);
    }
    return this.createChar(sym[0], sym[1], name) as T;
  }

  createChar(lib: SwfLibrary, id: number, name = ''): unknown {
    const def = lib.char(id);
    if (!def) throw new Error(`char ${id} ausente em ${lib.name}`);
    const make = this.factories[def.kind];
    if (!make) throw new Error(`sem fábrica para ${def.kind} (${lib.name}:${id})`);
    return make(lib, id, name);
  }
}

export const Domain = new DomainClass();

export const symbolName = new WeakMap<Container, string>();
