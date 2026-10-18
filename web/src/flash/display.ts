import { Container, FillGradient, Graphics, Matrix, Rectangle, Sprite, Texture } from 'pixi.js';
import type { BLEND_MODES, Filter } from 'pixi.js';
import { initFields } from '@/as3/runtime';
import { FlashClock, type Tickable } from './clock';
import { ColorTransformFilter, fromSwfFilters, isIdentityCx, toPixiFilters, type FlashFilterDef } from './filters';
import { BitmapData, Domain, SwfLibrary, symbolName, type CharDef, type PlaceOp, type TimelineOp } from './library';
import { FlashMode, withInteractive } from './mode';
import { Sprite as FlashSprite } from './sprite';
import { TextField } from './text';

const PIXI_FILTERS = Object.getOwnPropertyDescriptor(Container.prototype, 'filters')!;
export function setPixiFilters(obj: Container, list: Filter[] | null): void { PIXI_FILTERS.set!.call(obj, list); }

interface Fx { cx?: number[]; filters: Filter[]; flashFilters: FlashFilterDef[]; ownsAlpha?: boolean }
const fxState = new WeakMap<Container, Fx>();

function fx(obj: Container): Fx {
  let s = fxState.get(obj);
  if (!s) { s = { filters: [], flashFilters: [] }; fxState.set(obj, s); }
  return s;
}

function refreshFx(obj: Container): void {
  const s = fx(obj);
  const list: Filter[] = [...s.filters];
  let alpha = 1;
  if (s.cx && !isIdentityCx(s.cx)) {
    const [r, g, b, a, ra, ga, ba, aa] = s.cx;
    if (r === 1 && g === 1 && b === 1 && !ra && !ga && !ba && !aa) alpha = a;
    else list.push(new ColorTransformFilter(s.cx));
  }
  if (s.cx || s.ownsAlpha) {
    obj.alpha = alpha * ((obj as any).__userAlpha ?? 1);
    s.ownsAlpha = !!s.cx;
  }
  setPixiFilters(obj, list.length ? list : null);
}

export function setFlashFilters(obj: Container, defs: FlashFilterDef[] | null): void {
  const s = fx(obj);
  s.flashFilters = defs ?? [];
  s.filters = toPixiFilters(defs);
  refreshFx(obj);
}

export function getFlashFilters(obj: Container): FlashFilterDef[] { return fxState.get(obj)?.flashFilters ?? []; }

export function getColorTransform(obj: Container): number[] | undefined { return fxState.get(obj)?.cx; }

export function setColorTransform(obj: Container, cx: number[] | undefined): void {
  fx(obj).cx = cx;
  refreshFx(obj);
}

const BLEND: Record<string, BLEND_MODES> = {
  normal: 'normal', layer: 'normal', multiply: 'multiply', screen: 'screen', lighten: 'lighten',
  darken: 'darken', difference: 'difference', add: 'add', subtract: 'subtract', invert: 'normal',
  alpha: 'normal', erase: 'erase', overlay: 'overlay', hardlight: 'hard-light',
} as Record<string, BLEND_MODES>;

export function setBlend(obj: Container, mode?: string): void {
  obj.blendMode = (mode && BLEND[mode]) || 'normal';
}

export function setMatrix(obj: Container, m?: number[]): void {
  if (!m) { obj.setFromMatrix(new Matrix()); return; }
  obj.setFromMatrix(new Matrix(m[0], m[1], m[2], m[3], m[4], m[5]));
}

export class Bitmap extends Container {
  private __bmSprite: Sprite;
  private __bmData: BitmapData | null = null;
  private __bmUnobserve: (() => void) | null = null;
  pixelSnapping: string;
  private __bmSmoothing = false;

  constructor(bitmapData: BitmapData | null = null, pixelSnapping = 'auto', smoothing = false) {
    super();
    initFields(this, new.target);
    this.pixelSnapping = pixelSnapping;
    this.__bmSmoothing = !!smoothing;
    this.__bmSprite = new Sprite(Texture.EMPTY);
    (this.__bmSprite as any).__flInternal = true;
    this.addChild(this.__bmSprite);
    this.bitmapData = bitmapData;
  }

  get smoothing(): boolean { return this.__bmSmoothing; }
  set smoothing(v: boolean) { this.__bmSmoothing = !!v; }

  get bitmapData(): BitmapData | null { return this.__bmData; }
  set bitmapData(bd: BitmapData | null) {
    this.__bmUnobserve?.();
    this.__bmUnobserve = null;
    this.__bmData = bd ?? null;
    this.syncTexture();
    if (bd) {
      this.__bmUnobserve = bd.onChange(() => this.syncTexture());
      if (!bd.loaded) {
        bd.ready.then(() => { if (this.__bmData === bd && !this.destroyed) this.syncTexture(); });
      }
    }
  }

  private syncTexture(): void {
    if (this.destroyed) return;
    const bd = this.__bmData;
    const t = bd?.texture ?? Texture.EMPTY;
    this.__bmSprite.texture = t;
    if (bd) this.__bmSprite.setSize(bd.width || t.width, bd.height || t.height);
  }

  override destroy(options?: Parameters<Container['destroy']>[0]): void {
    this.__bmUnobserve?.();
    this.__bmUnobserve = null;
    super.destroy(options);
  }
}

export class Shape extends Container {
  constructor(lib: SwfLibrary, id: number, def: CharDef) {
    super();
    if (!def.src) return;
    const sp = new Sprite(lib.textures.get(id) ?? Texture.EMPTY);
    sp.position.set(def.x ?? 0, def.y ?? 0);
    sp.setSize(def.w ?? 1, def.h ?? 1);
    this.addChild(sp);
    if (!lib.textures.has(id)) {
      lib.texture(id).then((t) => {
        if (sp.destroyed) return;
        sp.texture = t;
        sp.setSize(def.w ?? t.width, def.h ?? t.height);
      });
    }
  }
}

interface SlotState {
  char: number;
  serial: number;
  m?: number[];
  cx?: number[];
  r?: number;
  n?: string;
  clip?: number;
  f?: Record<string, unknown>[];
  bl?: string;
  v?: number;
}

interface Slot { state: SlotState; inst: Container }

function applyOps(state: Map<number, SlotState>, ops: TimelineOp[], frameIdx: number): void {
  ops.forEach((op, i) => {
    if (op.op === 'remove') { state.delete(op.d); return; }
    const p = op as PlaceOp;
    const cur = state.get(p.d);
    if (p.move && cur) {
      const next: SlotState = { ...cur };
      if (p.c !== undefined && p.c !== cur.char) { next.char = p.c; next.serial = frameIdx * 4096 + i; }
      for (const k of ['m', 'cx', 'r', 'n', 'clip', 'f', 'bl', 'v'] as const) {
        if (p[k] !== undefined) (next as any)[k] = p[k];
      }
      state.set(p.d, next);
    } else if (p.c !== undefined) {
      state.set(p.d, { char: p.c, serial: frameIdx * 4096 + i, m: p.m, cx: p.cx, r: p.r, n: p.n, clip: p.clip, f: p.f, bl: p.bl, v: p.v });
    }
  });
}

export const rawChildren = {
  addChild: Container.prototype.addChild,
  addChildAt: Container.prototype.addChildAt,
  removeChild: Container.prototype.removeChild,
  removeChildren: Container.prototype.removeChildren,
  getChildIndex: Container.prototype.getChildIndex,
  setChildIndex: Container.prototype.setChildIndex,
  getChildByName: (Container.prototype as any).getChildByName as (name: string, deep?: boolean) => Container | null,
};

export const timelineHooks: {
  added: ((child: Container) => void) | null;
  removing: ((child: Container) => void) | null;
} = { added: null, removing: null };

function rawDetach(child: Container): void {
  if (child.parent) rawChildren.removeChild.call(child.parent, child);
}

export class MovieClip extends FlashSprite implements Tickable {
  static symbolResolver: ((ctor: Function) => { lib: SwfLibrary; def: CharDef } | null) | null = null;

  __tlLib: SwfLibrary | null = null;
  __tlDef: CharDef = { kind: 'sprite' };
  private __tlFrame = 1;
  private __tlPlaying = true;
  private __tlState = new Map<number, SlotState>();
  private __tlSlots = new Map<number, Slot>();
  private __tlOrder = '';
  private __tlScripts: Record<string, string[]> = {};
  private __tlFrameScripts: Map<number, Function> | null = null;
  flashInteractive = false;
  enabled = true;
  trackAsMenu = false;

  constructor(lib?: SwfLibrary | null, def?: CharDef | null, name = '') {
    super();
    this.flashInteractive = FlashMode.interactive || !lib;
    if (this.flashInteractive) this.eventMode = 'static';
    if (lib && def) {
      if (name) symbolName.set(this, name);
      this.initTimeline(lib, def);
    } else if (new.target !== MovieClip && MovieClip.symbolResolver) {
      const sym = MovieClip.symbolResolver(new.target);
      if (sym) this.initTimeline(sym.lib, sym.def);
    }
  }

  initTimeline(lib: SwfLibrary, def: CharDef): void {
    this.__tlLib = lib;
    this.__tlDef = def;
    this.__tlScripts = def.scripts ?? {};
    this.__tlFrame = 0;
    this.goto(1);
    this.runScripts(1, true);
    if (this.totalFrames > 1) FlashClock.add(this);
  }

  get totalFrames(): number { return Math.max(1, this.__tlDef.timeline?.length ?? 1); }
  get framesLoaded(): number { return this.totalFrames; }
  get currentFrame(): number { return this.__tlFrame; }
  get isPlaying(): boolean { return this.__tlPlaying; }
  get labels(): Record<string, number> { return this.__tlDef.labels ?? {}; }

  get currentLabel(): string | null {
    let best: string | null = null;
    let bestF = 0;
    for (const [name, f] of Object.entries(this.labels)) {
      if (f <= this.__tlFrame && f >= bestF) { best = name; bestF = f; }
    }
    return best;
  }
  get currentFrameLabel(): string | null {
    for (const [name, f] of Object.entries(this.labels)) if (f === this.__tlFrame) return name;
    return null;
  }
  get currentLabels(): { name: string; frame: number }[] {
    return Object.entries(this.labels).sort((a, b) => a[1] - b[1]).map(([name, frame]) => MovieClip.makeLabel(name, frame));
  }
  static makeLabel: (name: string, frame: number) => { name: string; frame: number } = (name, frame) => ({ name, frame });
  get scenes(): { name: string; labels: { name: string; frame: number }[]; numFrames: number }[] {
    return [{ name: 'Scene 1', labels: this.currentLabels, numFrames: this.totalFrames }];
  }
  get currentScene(): { name: string; labels: { name: string; frame: number }[]; numFrames: number } { return this.scenes[0]; }

  play(): void { this.__tlPlaying = true; }
  stop(): void { this.__tlPlaying = false; }
  gotoAndStop(frame: number | string, _scene: string | null = null): void { this.__tlPlaying = false; this.seek(frame); }
  gotoAndPlay(frame: number | string, _scene: string | null = null): void { this.__tlPlaying = true; this.seek(frame); }
  nextFrame(): void { this.__tlPlaying = false; this.seek(Math.min(this.__tlFrame + 1, this.totalFrames)); }
  prevFrame(): void { this.__tlPlaying = false; this.seek(Math.max(this.__tlFrame - 1, 1)); }
  nextScene(): void {}
  prevScene(): void {}

  addFrameScript(...args: unknown[]): void {
    for (let i = 0; i + 1 < args.length; i += 2) {
      const frame = (Number(args[i]) | 0) + 1;
      const fn = args[i + 1];
      this.__tlFrameScripts ??= new Map();
      if (typeof fn === 'function') this.__tlFrameScripts.set(frame, fn);
      else this.__tlFrameScripts.delete(frame);
      if (frame === this.__tlFrame && typeof fn === 'function') {
        const at = frame;
        queueMicrotask(() => {
          if (this.__tlFrame === at && !this.destroyed && this.__tlFrameScripts?.get(at) === fn) fn.call(this);
        });
      }
    }
    if (this.totalFrames > 1) FlashClock.add(this);
  }

  private seek(frame: number | string): void {
    const n = typeof frame === 'string' ? (this.labels[frame] ?? Number(frame)) : Number(frame);
    if (!n || Number.isNaN(n)) return;
    const target = Math.min(Math.max(1, Math.floor(n)), this.totalFrames);
    if (target !== this.__tlFrame) {
      this.goto(target);
      this.runScripts(target);
    }
  }

  advanceFrame(): void {
    if (!this.__tlPlaying || this.totalFrames <= 1 || this.destroyed) return;
    const next = this.__tlFrame >= this.totalFrames ? 1 : this.__tlFrame + 1;
    this.goto(next);
    this.runScripts(next);
  }

  private runScripts(frame: number, constructing = false): void {
    const fs = this.__tlFrameScripts?.get(frame);
    if (fs) {
      if (!constructing) fs.call(this);
      return;
    }
    for (const action of this.__tlScripts[String(frame)] ?? []) {
      const [cmd, arg] = action.split(':');
      if (cmd === 'stop') this.__tlPlaying = false;
      else if (cmd === 'play') this.__tlPlaying = true;
      else if (cmd === 'gotoAndPlay' && arg) { this.__tlPlaying = true; this.goto(this.labels[arg] ?? Number(arg)); }
      else if (cmd === 'gotoAndStop' && arg) { this.__tlPlaying = false; this.goto(this.labels[arg] ?? Number(arg)); }
    }
  }

  private goto(target: number): void {
    if (!this.__tlLib) { this.__tlFrame = 1; return; }
    const tl = this.__tlDef.timeline ?? [];
    let state: Map<number, SlotState>;
    if (target > this.__tlFrame && this.__tlFrame > 0) {
      state = new Map(this.__tlState);
      for (let f = this.__tlFrame + 1; f <= target; f++) applyOps(state, tl[f - 1] ?? [], f);
    } else {
      state = new Map();
      for (let f = 1; f <= target; f++) applyOps(state, tl[f - 1] ?? [], f);
    }
    this.__tlState = state;
    this.__tlFrame = target;
    this.reconcile();
  }

  private assignInstance(name: string, inst: Container | null, old?: Container): void {
    const self = this as any;
    if (!(name in self)) { if (inst) self[name] = inst; return; }
    if (!Object.prototype.hasOwnProperty.call(self, name)) return;
    if (inst) self[name] = inst;
    else if (self[name] === old) self[name] = null;
  }

  private reconcile(): void {
    const lib = this.__tlLib!;
    const created: Container[] = [];
    for (const [depth, slot] of this.__tlSlots) {
      const s = this.__tlState.get(depth);
      if (!s || s.serial !== slot.state.serial) {
        this.__tlSlots.delete(depth);
        this.removeTimelineChild(slot);
      }
    }
    for (const [depth, s] of this.__tlState) {
      let slot = this.__tlSlots.get(depth);
      if (!slot) {
        const inst = withInteractive(this.flashInteractive, () => createDisplay(lib, s.char));
        (inst as any).__flTimeline = true;
        slot = { state: s, inst };
        this.__tlSlots.set(depth, slot);
        created.push(inst);
      }
      const prev = slot.state;
      slot.state = s;
      const inst = slot.inst;
      if (prev !== s || created.includes(inst)) {
        setMatrix(inst, s.m);
        if (s.n) inst.label = s.n;
        setBlend(inst, s.bl);
        inst.visible = s.v !== 0;
        const f = fx(inst);
        f.cx = s.cx;
        if (s.f) { f.flashFilters = fromSwfFilters(s.f); f.filters = toPixiFilters(f.flashFilters); }
        else if (prev.f) { f.flashFilters = []; f.filters = []; }
        refreshFx(inst);
        if (s.r !== undefined && inst instanceof MorphShape) inst.ratio = s.r;
      }
    }
    this.rebuildOrder();
    for (const inst of created) {
      const n = this.slotName(inst);
      if (n) this.assignInstance(n, inst);
      timelineHooks.added?.(inst);
    }
  }

  private slotName(inst: Container): string | undefined {
    for (const slot of this.__tlSlots.values()) if (slot.inst === inst) return slot.state.n;
    return undefined;
  }

  private removeTimelineChild(slot: Slot): void {
    const inst = slot.inst;
    const p = inst.parent;
    const ours = p === this || (p && (p as any).__clipGroup && p.parent === this);
    if (slot.state.n) this.assignInstance(slot.state.n, null, inst);
    if (!ours) return;
    timelineHooks.removing?.(inst);
    rawDetach(inst);
    if (!(inst as any).__flTouched) inst.destroy({ children: true });
  }

  private rebuildOrder(): void {
    const depths = [...this.__tlSlots.keys()].sort((a, b) => a - b);
    const key = depths.map((d) => `${d}:${this.__tlSlots.get(d)!.state.serial}:${this.__tlSlots.get(d)!.state.clip ?? ''}`).join(',');
    if (key === this.__tlOrder) return;
    this.__tlOrder = key;
    const timeline = new Set<Container>([...this.__tlSlots.values()].map((s) => s.inst));
    const internal: Container[] = [];
    const others: Container[] = [];
    for (const child of [...this.children]) {
      if ((child as any).__clipGroup) {
        for (const c of [...child.children]) if (!timeline.has(c)) others.push(c);
        for (const c of [...child.children]) rawChildren.removeChild.call(child, c);
        child.mask = null;
        rawChildren.removeChild.call(this, child);
        child.destroy();
      } else if ((child as any).__flInternal) internal.push(child);
      else if (!timeline.has(child)) others.push(child);
    }
    const order: Container[] = [...internal];
    let i = 0;
    while (i < depths.length) {
      const slot = this.__tlSlots.get(depths[i])!;
      if (slot.state.clip) {
        const group = new Container();
        (group as any).__clipGroup = true;
        rawDetach(slot.inst);
        rawChildren.addChild.call(group, slot.inst);
        group.mask = slot.inst;
        let j = i + 1;
        while (j < depths.length && depths[j] <= slot.state.clip) {
          const inst = this.__tlSlots.get(depths[j])!.inst;
          rawDetach(inst);
          rawChildren.addChild.call(group, inst);
          j++;
        }
        order.push(group);
        i = j;
      } else {
        order.push(slot.inst);
        i++;
      }
    }
    order.push(...others);
    for (const c of order) if (c.parent !== this) { rawDetach(c); rawChildren.addChild.call(this, c); }
    const arr = this.children;
    let changed = false;
    for (let k = 0; k < order.length; k++) if (arr[k] !== order[k]) { changed = true; break; }
    if (changed) {
      arr.length = 0;
      arr.push(...order);
      const rg = (this as any).renderGroup || (this as any).parentRenderGroup;
      if (rg) rg.structureDidChange = true;
      (this as any)._didContainerChangeTick++;
    }
    (this as any).__hasClip = order.some((c) => (c as any).__clipGroup);
  }

  override getChildByName(name: string | RegExp, deep = false): Container | null {
    if (typeof name === 'string') {
      for (const slot of this.__tlSlots.values()) if (slot.state.n === name && this.containsDeep(slot.inst)) return slot.inst;
    }
    return super.getChildByName(name, deep);
  }

  private containsDeep(c: Container): boolean {
    const p = c.parent;
    return p === this || (!!p && (p as any).__clipGroup && p.parent === this);
  }

  override destroy(options?: Parameters<Container['destroy']>[0]): void {
    FlashClock.remove(this);
    super.destroy(options);
  }
}

type Cmd = [string, ...number[]];
interface MorphDef extends CharDef {
  fills: { type: string; start?: string; end?: string; startMatrix?: number[]; endMatrix?: number[]; stops?: [number, string, number, string][] }[];
  lines: { startWidth: number; endWidth: number; start?: string; end?: string }[];
  paths: { fill?: number; line?: number; start: Cmd[]; end: Cmd[] }[];
  endBounds: { x: number; y: number; w: number; h: number };
}

const lerp = (a: number, b: number, t: number) => a + (b - a) * t;

function lerpColor(a: string, b: string, t: number): { rgb: string; alpha: number } {
  const pa = [1, 3, 5, 7].map((i) => parseInt(a.slice(i, i + 2), 16));
  const pb = [1, 3, 5, 7].map((i) => parseInt(b.slice(i, i + 2), 16));
  const c = pa.map((v, i) => Math.round(lerp(v, pb[i], t)));
  return { rgb: `rgb(${c[0]},${c[1]},${c[2]})`, alpha: c[3] / 255 };
}

export class MorphShape extends Container {
  private g = new Graphics();
  private _ratio = -1;
  private def: MorphDef;

  constructor(_lib: SwfLibrary, _id: number, def: CharDef) {
    super();
    this.def = def as MorphDef;
    this.addChild(this.g);
    this.ratio = 0;
  }

  get ratio(): number { return this._ratio; }
  set ratio(r: number) {
    const v = Math.max(0, Math.min(65535, Number(r) || 0));
    if (v === this._ratio) return;
    this._ratio = v;
    this.redraw(v / 65535);
  }

  private redraw(t: number): void {
    const d = this.def;
    const g = this.g.clear();
    for (const p of d.paths) {
      p.start.forEach((c, i) => {
        const o = p.end[i] ?? c;
        const n = c.slice(1).map((v, j) => lerp(v as number, (o[j + 1] as number) ?? (v as number), t));
        if (c[0] === 'M') g.moveTo(n[0], n[1]);
        else if (c[0] === 'L') g.lineTo(n[0], n[1]);
        else if (c[0] === 'Q') g.quadraticCurveTo(n[0], n[1], n[2], n[3]);
      });
      if (p.fill !== undefined) {
        const f = d.fills[p.fill];
        if (f.type === 'solid') {
          const c = lerpColor(f.start!, f.end!, t);
          g.closePath().fill({ color: c.rgb, alpha: c.alpha });
        } else if (f.type === 'linear' || f.type === 'radial') {
          g.closePath().fill(gradient(f, t));
        }
      } else if (p.line !== undefined) {
        const l = d.lines[p.line];
        const lw = lerp(l.startWidth, l.endWidth, t);
        if (lw > 0 && l.start && l.end) {
          const c = lerpColor(l.start, l.end, t);
          g.stroke({ width: lw, color: c.rgb, alpha: c.alpha, cap: 'round', join: 'round' });
        }
      }
    }
  }
}

function gradient(f: MorphDef['fills'][number], t: number): FillGradient {
  const m = f.startMatrix!.map((v, k) => lerp(v, f.endMatrix![k], t));
  const tp = (x: number, y: number) => ({ x: m[0] * x + m[2] * y + m[4], y: m[1] * x + m[3] * y + m[5] });
  const colorStops = (f.stops ?? []).map(([r0, c0, r1, c1]) => {
    const c = lerpColor(c0, c1, t);
    return { offset: lerp(r0, r1, t) / 255, color: c.rgb.replace('rgb(', 'rgba(').replace(')', `,${c.alpha.toFixed(3)})`) };
  });
  if (f.type === 'linear') {
    return new FillGradient({ type: 'linear', start: tp(-819.2, 0), end: tp(819.2, 0), colorStops, textureSpace: 'global' });
  }
  const center = tp(0, 0);
  const radius = 819.2 * Math.hypot(m[0], m[1]);
  return new FillGradient({ type: 'radial', center, innerRadius: 0, outerCenter: center, outerRadius: radius, colorStops,
    textureSpace: 'global' });
}

export class SimpleButton extends Container {
  private __sbStates: Record<string, Container | null> = { up: null, over: null, down: null, hit: null };
  private __sbCurrent = 'up';
  private __sbEnabled = true;
  private __sbHand = true;
  trackAsMenu = false;
  soundTransform: unknown = null;

  constructor(a?: unknown, b?: unknown, c?: unknown, d?: unknown) {
    super();
    initFields(this, new.target);
    if (a instanceof SwfLibrary) {
      const lib = a, def = b as CharDef;
      for (const name of ['up', 'over', 'down', 'hit']) {
        const st = new Container();
        for (const rec of [...(def.records ?? [])].sort((x, y) => x.d - y.d)) {
          if (!rec.states.includes(name)) continue;
          const inst = createDisplay(lib, rec.c);
          setMatrix(inst, rec.m);
          const f = fx(inst);
          f.cx = rec.cx;
          if (rec.f) { f.flashFilters = fromSwfFilters(rec.f); f.filters = toPixiFilters(f.flashFilters); }
          refreshFx(inst);
          setBlend(inst, rec.bl);
          st.addChild(inst);
        }
        this.__sbStates[name] = st;
      }
    } else {
      this.__sbStates.up = (a as Container) ?? null;
      this.__sbStates.over = (b as Container) ?? null;
      this.__sbStates.down = (c as Container) ?? null;
      this.__sbStates.hit = (d as Container) ?? null;
    }
    this.eventMode = 'static';
    this.cursor = 'pointer';
    this.on('pointerover', () => this.show('over'));
    this.on('pointerout', () => this.show('up'));
    this.on('pointerdown', () => this.show('down'));
    this.on('pointerup', () => this.show('over'));
    this.refresh();
  }

  get upState(): Container | null { return this.__sbStates.up; }
  set upState(v: Container | null) { this.__sbStates.up = v; this.refresh(); }
  get overState(): Container | null { return this.__sbStates.over; }
  set overState(v: Container | null) { this.__sbStates.over = v; this.refresh(); }
  get downState(): Container | null { return this.__sbStates.down; }
  set downState(v: Container | null) { this.__sbStates.down = v; this.refresh(); }
  get hitTestState(): Container | null { return this.__sbStates.hit; }
  set hitTestState(v: Container | null) { this.__sbStates.hit = v; this.refresh(); }
  get enabled(): boolean { return this.__sbEnabled; }
  set enabled(v: boolean) { this.__sbEnabled = !!v; if (!v) this.show('up'); this.syncCursor(); }
  get useHandCursor(): boolean { return this.__sbHand; }
  set useHandCursor(v: boolean) { this.__sbHand = !!v; this.syncCursor(); }
  private syncCursor(): void { this.cursor = this.__sbEnabled && this.__sbHand ? 'pointer' : 'default'; }

  private refresh(): void {
    const hit = this.__sbStates.hit;
    if (hit) {
      const r = hit.getLocalBounds();
      this.hitArea = new Rectangle(hit.x + r.x, hit.y + r.y, r.width * hit.scale.x, r.height * hit.scale.y);
    }
    const cur = this.__sbStates[this.__sbCurrent] ?? this.__sbStates.up;
    for (const child of [...this.children]) if (child !== cur) rawChildren.removeChild.call(this, child);
    if (cur && cur.parent !== this) { if (cur.parent) rawChildren.removeChild.call(cur.parent, cur); rawChildren.addChild.call(this, cur); }
  }

  private show(name: string): void {
    if (!this.__sbEnabled) name = 'up';
    if (name === this.__sbCurrent || !this.__sbStates[name]) return;
    this.__sbCurrent = name;
    this.refresh();
  }
}

export function createDisplay(lib: SwfLibrary, id: number): Container {
  const def = lib.char(id);
  if (!def) return new Container();
  switch (def.kind) {
    case 'bitmap': return new Bitmap(lib.bitmapData(id));
    case 'shape':
    case 'text': return new Shape(lib, id, def);
    case 'morph': return new MorphShape(lib, id, def);
    case 'sprite': return new MovieClip(lib, def);
    case 'button': return new SimpleButton(lib, def);
    case 'edit': {
      const tf = TextField.fromSwf(def, lib);
      if (FlashMode.interactive) tf.eventMode = 'static';
      return tf;
    }
    default: return new Container();
  }
}

Domain.factories = {
  bitmap: (lib, id) => lib.bitmapData(id),
  sprite: (lib, id, name) => new MovieClip(lib, lib.char(id)!, name),
  button: (lib, id) => new SimpleButton(lib, lib.char(id)!),
  shape: (lib, id) => createDisplay(lib, id),
  text: (lib, id) => createDisplay(lib, id),
  edit: (lib, id) => createDisplay(lib, id),
  morph: (lib, id) => new MorphShape(lib, id, lib.char(id)!),
  sound: () => ({ play() {} }),
  binary: () => new Uint8Array(),
  font: () => ({}),
};
