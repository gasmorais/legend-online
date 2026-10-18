import { Bounds, Container, Graphics, getLocalBounds, Matrix as PixiMatrix, Point as PixiPoint, type Application } from 'pixi.js';
import type { Filter } from 'pixi.js';
import 'pixi.js/events';
import { initFields } from '../runtime';
import {
  Event, flAddListener, flDispatch, flDispatchAtTarget, flDispatchSafe, flHasListener, flParent, flRemoveListener, flWillTrigger,
  listenerCount, listenerHooks, pointerGlobal, EventDispatcher,
} from '@/flash/events';
import { FlashClock } from '@/flash/clock';
import { FlashMode, withInteractive } from '@/flash/mode';
import {
  getMouseChildren, getMouseEnabled, setMouseChildren, setMouseEnabled, Sprite as BaseSprite, FlashShape, FlashGraphics,
} from '@/flash/sprite';
import {
  Bitmap, getColorTransform, getFlashFilters, MorphShape, MovieClip, rawChildren, setBlend, setColorTransform, setFlashFilters,
  setPixiFilters, Shape as SvgShape, SimpleButton, timelineHooks,
} from '@/flash/display';
import { TextField as BaseTextField } from '@/flash/text';
import { BitmapData } from '@/flash/bitmapdata';
import { Domain, type CharDef, type SwfLibrary } from '@/flash/library';
import { ColorTransform, Matrix, Point, Rectangle } from './geom';
import { ArgumentError, IllegalOperationError } from './errors';
import { filterFromDef } from './filters';
import { ByteArray } from './bytearray';

const P = Container.prototype as any;
const RAD = Math.PI / 180;

let stageObj: Container | null = null;
let appRef: Application | null = null;

export function currentStage(): Container | null { return stageObj; }

function isOnStage(c: any): boolean {
  if (!stageObj) return false;
  for (let n = c; n; n = n.parent) if (n === stageObj) return true;
  return false;
}

const isInternal = (c: any) => c?.__flInternal === true;

function lead(p: Container): number {
  const ch = p.children;
  let i = 0;
  while (i < ch.length && isInternal(ch[i])) i++;
  return i;
}

export function flChildren(p: Container): Container[] {
  const out: Container[] = [];
  for (const c of p.children) {
    if (isInternal(c)) continue;
    if ((c as any).__clipGroup) { for (const g of c.children) if (!isInternal(g)) out.push(g); } else out.push(c);
  }
  return out;
}

const simple = (p: any) => !p.__hasClip;

function numChildrenOf(p: Container): number {
  return simple(p) ? p.children.length - lead(p) : flChildren(p).length;
}

function childAt(p: Container, i: number): Container {
  const n = numChildrenOf(p);
  if (!(i >= 0 && i < n)) throw new RangeError('Error #2006: The supplied index is out of bounds.');
  return simple(p) ? p.children[i + lead(p)] : flChildren(p)[i];
}

function holderOf(p: Container, c: Container): Container | null {
  const h = c.parent;
  if (h === p) return p;
  if (h && (h as any).__clipGroup && h.parent === p) return h;
  return null;
}

function indexOfChild(p: Container, c: Container): number {
  if (!holderOf(p, c)) return -1;
  if (simple(p)) return p.children.indexOf(c) - lead(p);
  return flChildren(p).indexOf(c);
}

function markChanged(p: any): void {
  const rg = p.renderGroup || p.parentRenderGroup;
  if (rg) rg.structureDidChange = true;
  p._didContainerChangeTick++;
}

function rawMove(holder: Container, c: Container, raw: number): void {
  const arr = holder.children;
  const from = arr.indexOf(c);
  if (from < 0 || from === raw) return;
  arr.splice(from, 1);
  arr.splice(Math.min(raw, arr.length), 0, c);
  markChanged(holder);
}

function walkSubtree(c: Container, fn: (n: Container) => void): void {
  fn(c);
  for (const k of [...c.children]) {
    if (isInternal(k)) continue;
    walkSubtree(k, fn);
  }
}

function dispatchAdded(c: Container): void {
  (c as any).__flTouched = true;
  if ((listenerCount.get('added') ?? 0) > 0) flDispatch(c, new Event('added', true));
  if ((listenerCount.get('addedToStage') ?? 0) > 0 && isOnStage(c)) {
    walkSubtree(c, (n) => { if (!(n as any).__clipGroup) flDispatch(n, new Event('addedToStage')); });
  }
}

function dispatchRemoving(c: Container): void {
  if ((listenerCount.get('removed') ?? 0) > 0) flDispatch(c, new Event('removed', true));
  if ((listenerCount.get('removedFromStage') ?? 0) > 0 && isOnStage(c)) {
    walkSubtree(c, (n) => { if (!(n as any).__clipGroup) flDispatch(n, new Event('removedFromStage')); });
  }
}

function flAddChild(p: Container, c: Container, holder: Container, raw?: number): Container {
  if (c === null || c === undefined) throw new TypeError('Error #2007: Parameter child must be non-null.');
  if ((c as any) === p) throw new ArgumentError('Error #2024: An object cannot be added as a child of itself.', 2024);
  for (let n: any = p; n; n = n.parent) {
    if (n === c) throw new ArgumentError('Error #2150: An object cannot be added as a child to one of it\'s children (or children\'s children, etc.).', 2150);
  }
  if (isInternal(c)) {
    rawChildren.addChildAt.call(holder, c, raw ?? 0);
    return c;
  }
  if (c.parent === holder) {
    rawMove(holder, c, raw ?? holder.children.length - 1);
    return c;
  }
  if (c.parent) {
    const fp = flParent(c);
    if (fp) flRemoveChild(fp, c); else rawChildren.removeChild.call(c.parent, c);
  }
  if (c.parent) return c;
  if (raw === undefined || raw >= holder.children.length) rawChildren.addChild.call(holder, c);
  else rawChildren.addChildAt.call(holder, c, raw);
  dispatchAdded(c);
  return c;
}

function flRemoveChild(p: Container, c: Container): Container {
  if (!c) return c;
  const h = holderOf(p, c);
  if (!h) return c;
  dispatchRemoving(c);
  if (c.parent) rawChildren.removeChild.call(c.parent, c);
  return c;
}

timelineHooks.added = (c) => dispatchAdded(c);
timelineHooks.removing = (c) => dispatchRemoving(c);

const tmpBounds = new Bounds();

function relMatrix(from: Container, to: Container | null): PixiMatrix {
  const m = from.getGlobalTransform(new PixiMatrix(), false);
  if (to) {
    const inv = to.getGlobalTransform(new PixiMatrix(), false).invert();
    m.prepend(inv);
  }
  return m;
}

function localRect(obj: Container): { x: number; y: number; w: number; h: number } | null {
  const b = getLocalBounds(obj, tmpBounds, PixiMatrix.IDENTITY);
  if (!b.isValid || (b.width === 0 && b.height === 0)) return null;
  return { x: b.minX, y: b.minY, w: b.width, h: b.height };
}

function transformRect(r: { x: number; y: number; w: number; h: number }, m: PixiMatrix): Rectangle {
  const xs: number[] = [], ys: number[] = [];
  for (const [px, py] of [[r.x, r.y], [r.x + r.w, r.y], [r.x, r.y + r.h], [r.x + r.w, r.y + r.h]]) {
    xs.push(m.a * px + m.c * py + m.tx);
    ys.push(m.b * px + m.d * py + m.ty);
  }
  const x0 = Math.min(...xs), y0 = Math.min(...ys);
  return new Rectangle(x0, y0, Math.max(...xs) - x0, Math.max(...ys) - y0);
}

export function boundsIn(obj: Container, space: Container | null): Rectangle {
  const r = localRect(obj);
  if (!r) return new Rectangle(0, 0, 0, 0);
  if (space === obj) return new Rectangle(r.x, r.y, r.w, r.h);
  return transformRect(r, relMatrix(obj, space));
}

function parentSpaceBounds(obj: Container): Rectangle {
  const r = localRect(obj);
  if (!r) return new Rectangle(0, 0, 0, 0);
  obj.updateLocalTransform();
  return transformRect(r, obj.localTransform);
}

function toStage(obj: Container, x: number, y: number): Point {
  const g = obj.toGlobal({ x, y });
  if (stageObj && isOnStage(obj)) { const p = stageObj.toLocal(g); return new Point(p.x, p.y); }
  return new Point(g.x, g.y);
}

function fromStage(obj: Container, x: number, y: number): Point {
  let g: { x: number; y: number } = { x, y };
  if (stageObj && isOnStage(obj)) g = stageObj.toGlobal(g);
  const p = obj.toLocal(g);
  return new Point(p.x, p.y);
}

export function hitShape(obj: Container, gx: number, gy: number): boolean {
  if (!obj.visible) return false;
  const anyObj = obj as any;
  if (anyObj.mask && !hitShape(anyObj.mask, gx, gy) && !anyObj.__flScrollMask) return false;
  if (typeof anyObj.containsPoint === 'function' && anyObj.renderPipeId) {
    const p = obj.toLocal({ x: gx, y: gy });
    if (anyObj.containsPoint(p)) return true;
  }
  for (const c of obj.children) {
    if (c === anyObj.__flScrollMask) continue;
    if (hitShape(c, gx, gy)) return true;
  }
  return false;
}

export class Transform {
  constructor(private readonly obj: Container) { initFields(this, new.target); }
  get matrix(): Matrix {
    const o = this.obj;
    o.updateLocalTransform();
    const m = o.localTransform;
    return new Matrix(m.a, m.b, m.c, m.d, o.position.x, o.position.y);
  }
  set matrix(m: Matrix) {
    if (!m) return;
    this.obj.setFromMatrix(new PixiMatrix(m.a, m.b, m.c, m.d, m.tx, m.ty));
  }
  get colorTransform(): ColorTransform {
    const cx = getColorTransform(this.obj);
    const ct = ColorTransform.fromArray(cx, this.obj.alpha);
    if (!cx || (cx[0] === 1 && cx[1] === 1 && cx[2] === 1 && !cx[4] && !cx[5] && !cx[6] && !cx[7])) ct.alphaMultiplier = this.obj.alpha;
    return ct;
  }
  set colorTransform(ct: ColorTransform) {
    if (!ct) throw new TypeError('Error #2007: Parameter colorTransform must be non-null.');
    const a = [ct.redMultiplier, ct.greenMultiplier, ct.blueMultiplier, ct.alphaMultiplier, ct.redOffset, ct.greenOffset, ct.blueOffset,
      ct.alphaOffset].map(Number);
    if (a[0] === 1 && a[1] === 1 && a[2] === 1 && !a[4] && !a[5] && !a[6] && !a[7]) {
      setColorTransform(this.obj, undefined);
      this.obj.alpha = Math.max(0, Math.min(1, a[3]));
    } else {
      setColorTransform(this.obj, a);
    }
  }
  get concatenatedMatrix(): Matrix {
    const m = relMatrix(this.obj, isOnStage(this.obj) ? stageObj : null);
    return new Matrix(m.a, m.b, m.c, m.d, m.tx, m.ty);
  }
  get concatenatedColorTransform(): ColorTransform {
    const ct = new ColorTransform();
    for (let n: any = this.obj; n; n = n.parent) ct.concat(new Transform(n).colorTransform);
    return ct;
  }
  get pixelBounds(): Rectangle { return boundsIn(this.obj, stageObj); }
  get matrix3D(): null { return null; }
  set matrix3D(_v: unknown) {}
  get perspectiveProjection(): null { return null; }
  set perspectiveProjection(_v: unknown) {}
  getRelativeMatrix3D(): null { return null; }
}

function def(name: string, desc: PropertyDescriptor): void {
  Object.defineProperty(P, name, { configurable: true, enumerable: false, ...desc });
}
function data(name: string, value: unknown): void {
  Object.defineProperty(P, name, { configurable: true, enumerable: false, writable: true, value });
}

const ORIG = {
  rotation: Object.getOwnPropertyDescriptor(P, 'rotation')!,
  mask: Object.getOwnPropertyDescriptor(P, 'mask')!,
  filters: Object.getOwnPropertyDescriptor(P, 'filters')!,
  blendMode: Object.getOwnPropertyDescriptor(P, 'blendMode')!,
  width: Object.getOwnPropertyDescriptor(P, 'width')!,
  height: Object.getOwnPropertyDescriptor(P, 'height')!,
  getBounds: P.getBounds as Function,
  addEventListener: P.addEventListener as Function,
  removeEventListener: P.removeEventListener as Function,
  dispatchEvent: P.dispatchEvent as Function,
  destroy: P.destroy as Function,
};

const FLASH_BLEND: Record<string, string> = {
  normal: 'normal', layer: 'normal', multiply: 'multiply', screen: 'screen', lighten: 'lighten', darken: 'darken',
  difference: 'difference', add: 'add', subtract: 'subtract', invert: 'normal', alpha: 'normal', erase: 'erase',
  overlay: 'overlay', hardlight: 'hard-light', shader: 'normal',
};

export function applyEventApi(): void {
  P.addEventListener = function (this: any, type: string, listener: any, useCapture?: any, priority = 0, _weak = false) {
    if (useCapture !== null && typeof useCapture === 'object') return ORIG.addEventListener.call(this, type, listener, useCapture);
    flAddListener(this, type, listener, useCapture === true, priority);
  };
  P.removeEventListener = function (this: any, type: string, listener: any, useCapture?: any) {
    if (useCapture !== null && typeof useCapture === 'object') return ORIG.removeEventListener.call(this, type, listener, useCapture);
    flRemoveListener(this, type, listener, useCapture === true);
  };
  P.hasEventListener = function (this: any, type: string) { return flHasListener(this, type); };
  P.willTrigger = function (this: any, type: string) { return flWillTrigger(this, type); };
  P.dispatchEvent = function (this: any, e: any) {
    if (e && typeof e === 'object' && 'nativeEvent' in e && 'manager' in e) return ORIG.dispatchEvent.call(this, e);
    return flDispatch(this, e);
  };

  def('hitArea', {
    get(this: any) { return this.__flHitArea ?? null; },
    set(this: any, v: unknown) { this.__flHitArea = v ?? null; },
  });
}

let instanceSeq = 0;
let installed = false;

export function installDisplayApi(): void {
  if (installed) return;
  installed = true;

  applyEventApi();

  def('name', {
    get(this: any) { return this.label || (this.__flName ??= 'instance' + ++instanceSeq); },
    set(this: any, v: unknown) { this.label = v === null || v === undefined ? '' : String(v); },
  });
  def('stage', { get(this: any) { return isOnStage(this) ? stageObj : null; } });
  def('root', {
    get(this: any) {
      if (this === stageObj) return stageObj;
      if (!isOnStage(this)) {
        let n = this;
        while (n.parent) n = n.parent;
        return n.__flRoot ? n : null;
      }
      let n = this;
      while (n.parent && n.parent !== stageObj) n = n.parent;
      return n;
    },
  });
  def('loaderInfo', {
    get(this: any) {
      for (let n = this; n; n = n.parent) if (n.__flLoaderInfo) return n.__flLoaderInfo;
      return mainLoaderInfo();
    },
  });
  def('mouseX', { get(this: any) { const g = pointerGlobal(); return this.toLocal(g).x; } });
  def('mouseY', { get(this: any) { const g = pointerGlobal(); return this.toLocal(g).y; } });

  def('numChildren', { get(this: Container) { return numChildrenOf(this); } });
  P.getChildAt = function (this: Container, i: number) { return childAt(this, Number(i) | 0); };
  P.getChildIndex = function (this: Container, c: Container) {
    const i = indexOfChild(this, c);
    if (i < 0) throw new ArgumentError('Error #2025: The supplied DisplayObject must be a child of the caller.', 2025);
    return i;
  };
  P.addChild = function (this: Container, ...cs: Container[]) {
    for (const c of cs) flAddChild(this, c, this);
    return cs[0];
  };
  P.addChildAt = function (this: Container, c: Container, index: number) {
    index = Number(index) | 0;
    if (isInternal(c)) return flAddChild(this, c, this, index);
    const cur = indexOfChild(this, c);
    const n = numChildrenOf(this) - (cur >= 0 ? 1 : 0);
    if (index < 0 || index > n) throw new RangeError('Error #2006: The supplied index is out of bounds.');
    if (simple(this)) {
      if (cur >= 0) { rawMove(this, c, index + lead(this)); return c; }
      return flAddChild(this, c, this, index + lead(this));
    }
    const list = flChildren(this).filter((x) => x !== c);
    if (index >= list.length) {
      if (cur >= 0) flRemoveChild(this, c);
      return flAddChild(this, c, this);
    }
    const before = list[index];
    const h = before.parent!;
    if (c.parent === h) { rawMove(h, c, h.children.indexOf(before) - (h.children.indexOf(c) < h.children.indexOf(before) ? 1 : 0)); return c; }
    return flAddChild(this, c, h, h.children.indexOf(before));
  };
  P.removeChild = function (this: Container, ...cs: Container[]) {
    for (const c of cs) {
      if ((this as any).__flDestroying || isInternal(c) || (c && c.parent === this && (this as any).__clipGroup)) {
        if (c && c.parent === this) rawChildren.removeChild.call(this, c);
      } else flRemoveChild(this, c);
    }
    return cs[0];
  };
  P.removeChildAt = function (this: Container, i: number) { return flRemoveChild(this, childAt(this, Number(i) | 0)); };
  P.removeChildren = function (this: any, begin = 0, end = 0x7fffffff) {
    if (this.__flDestroying) return rawChildren.removeChildren.call(this, begin, end === 0x7fffffff ? undefined : end);
    const list = flChildren(this);
    begin = Number(begin) | 0;
    end = Math.min(Number(end) | 0, list.length - 1);
    if (list.length === 0) return [];
    if (begin < 0 || begin > end) throw new RangeError('Error #2006: The supplied index is out of bounds.');
    const out = list.slice(begin, end + 1);
    for (const c of out) flRemoveChild(this, c);
    return out;
  };
  P.setChildIndex = function (this: Container, c: Container, index: number) {
    index = Number(index) | 0;
    const cur = indexOfChild(this, c);
    if (cur < 0) throw new ArgumentError('Error #2025: The supplied DisplayObject must be a child of the caller.', 2025);
    if (index < 0 || index >= numChildrenOf(this)) throw new RangeError('Error #2006: The supplied index is out of bounds.');
    if (cur === index) return;
    if (simple(this)) { rawMove(this, c, index + lead(this)); return; }
    const list = flChildren(this);
    list.splice(cur, 1);
    list.splice(index, 0, c);
    const target = list[index + 1] ?? null;
    const h = c.parent!;
    if (target && target.parent === h) rawMove(h, c, h.children.indexOf(target) - (h.children.indexOf(c) < h.children.indexOf(target) ? 1 : 0));
    else if (!target && h === this) rawMove(h, c, h.children.length - 1);
  };
  P.swapChildren = function (this: Container, a: Container, b: Container) {
    const ia = indexOfChild(this, a), ib = indexOfChild(this, b);
    if (ia < 0 || ib < 0) throw new ArgumentError('Error #2025: The supplied DisplayObject must be a child of the caller.', 2025);
    if (a === b) return;
    const ha = a.parent!, hb = b.parent!;
    const ra = ha.children.indexOf(a), rb = hb.children.indexOf(b);
    ha.children[ra] = b;
    hb.children[rb] = a;
    if (ha !== hb) { (a as any).parent = hb; (b as any).parent = ha; }
    markChanged(ha);
    if (hb !== ha) markChanged(hb);
  };
  P.swapChildrenAt = function (this: Container, i: number, j: number) { this.swapChildren(childAt(this, i), childAt(this, j)); };
  P.contains = function (this: Container, c: Container) {
    for (let n: any = c; n; n = flParent(n)) if (n === this) return true;
    return false;
  };
  P.getChildByName = function (this: Container, name: string, deep = false) {
    if (deep || typeof name !== 'string') return rawChildren.getChildByName.call(this, name, deep);
    for (const c of flChildren(this)) if (c.label === name) return c;
    return null;
  };
  P.getObjectsUnderPoint = function (this: Container, pt: Point) {
    const g = stageObj ? stageObj.toGlobal(pt) : pt;
    const out: Container[] = [];
    const visit = (n: Container) => {
      for (const c of flChildren(n)) {
        if (!c.visible) continue;
        const anyC = c as any;
        if (anyC.renderPipeId && typeof anyC.containsPoint === 'function' && anyC.containsPoint(c.toLocal(g))) out.push(c);
        else if (c.children.length && hitShape(c, g.x, g.y)) {
          if (c instanceof Bitmap || c instanceof BaseTextField || c instanceof SvgShape) out.push(c);
          else visit(c);
        }
      }
    };
    visit(this);
    return out;
  };
  P.areInaccessibleObjectsUnderPoint = function () { return false; };

  P.destroy = function (this: any, options?: unknown) {
    this.__flDestroying = true;
    return ORIG.destroy.call(this, options);
  };

  def('scaleX', { get(this: Container) { return this.scale.x; }, set(this: Container, v: number) { this.scale.x = Number(v); } });
  def('scaleY', { get(this: Container) { return this.scale.y; }, set(this: Container, v: number) { this.scale.y = Number(v); } });
  def('scaleZ', { get() { return 1; }, set() {} });
  def('z', { get() { return 0; }, set() {} });
  def('rotationX', { get() { return 0; }, set() {} });
  def('rotationY', { get() { return 0; }, set() {} });
  def('rotation', {
    get(this: Container) {
      const d = (ORIG.rotation.get!.call(this) as number) / RAD;
      const r = ((((d + 180) % 360) + 360) % 360) - 180;
      return r === -180 && d > 0 ? 180 : r;
    },
    set(this: Container, v: number) { const n = Number(v); if (Number.isFinite(n)) ORIG.rotation.set!.call(this, n * RAD); },
  });
  def('rotationZ', Object.getOwnPropertyDescriptor(P, 'rotation')!);
  def('angle', {
    get(this: Container) { return (ORIG.rotation.get!.call(this) as number) / RAD; },
    set(this: Container, v: number) { ORIG.rotation.set!.call(this, Number(v) * RAD); },
  });
  P.setFromMatrix = function (this: any, m: PixiMatrix) {
    const t = { position: { x: 0, y: 0 }, scale: { x: 1, y: 1 }, pivot: { x: 0, y: 0 }, skew: { x: 0, y: 0 }, rotation: 0 };
    m.decompose(t as any);
    this.position.set(t.position.x, t.position.y);
    this.scale.set(t.scale.x, t.scale.y);
    this.skew.set(t.skew.x, t.skew.y);
    ORIG.rotation.set!.call(this, t.rotation);
  };
  def('width', {
    get(this: Container) { return parentSpaceBounds(this).width; },
    set(this: Container, v: number) {
      const n = Number(v);
      if (!Number.isFinite(n)) return;
      const lb = this.getLocalBounds();
      if (lb.width === 0) return;
      const sign = this.scale.x < 0 ? -1 : 1;
      this.scale.x = (n / lb.width) * sign;
    },
  });
  def('height', {
    get(this: Container) { return parentSpaceBounds(this).height; },
    set(this: Container, v: number) {
      const n = Number(v);
      if (!Number.isFinite(n)) return;
      const lb = this.getLocalBounds();
      if (lb.height === 0) return;
      const sign = this.scale.y < 0 ? -1 : 1;
      this.scale.y = (n / lb.height) * sign;
    },
  });
  def('transform', {
    get(this: any) { return (this.__flTransform ??= new Transform(this)); },
    set(this: any, t: Transform) {
      if (!t) return;
      const tr = this.transform as Transform;
      tr.matrix = t.matrix;
      tr.colorTransform = t.colorTransform;
    },
  });

  P.getBounds = function (this: Container, target?: unknown, bounds?: unknown) {
    if (target === undefined || typeof target === 'boolean') return ORIG.getBounds.call(this, target, bounds);
    return boundsIn(this, (target as Container) ?? this);
  };
  P.getRect = function (this: Container, target: Container | null) { return boundsIn(this, target ?? this); };
  P.localToGlobal = function (this: Container, p: { x: number; y: number }) { return toStage(this, Number(p.x), Number(p.y)); };
  P.globalToLocal = function (this: Container, p: { x: number; y: number }) { return fromStage(this, Number(p.x), Number(p.y)); };
  P.local3DToGlobal = function (this: Container, v: { x: number; y: number }) { return toStage(this, v.x, v.y); };
  P.globalToLocal3D = function (this: Container, p: { x: number; y: number }) { const l = fromStage(this, p.x, p.y); return { x: l.x, y: l.y, z: 0, w: 0 }; };
  P.hitTestPoint = function (this: Container, x: number, y: number, shapeFlag = false) {
    let g: { x: number; y: number } = { x: Number(x), y: Number(y) };
    if (stageObj) g = stageObj.toGlobal(g);
    if (!shapeFlag) {
      const r = boundsIn(this, null);
      return g.x >= r.x && g.x <= r.right && g.y >= r.y && g.y <= r.bottom && (r.width > 0 || r.height > 0);
    }
    return hitShape(this, g.x, g.y);
  };
  P.hitTestObject = function (this: Container, o: Container) {
    if (!o) return false;
    const a = boundsIn(this, null), b = boundsIn(o, null);
    return a.intersects(b);
  };

  def('blendMode', {
    get(this: any) { return this.__flBlend ?? 'normal'; },
    set(this: any, v: string) {
      const s = String(v ?? 'normal');
      if (s in FLASH_BLEND) { this.__flBlend = s; ORIG.blendMode.set!.call(this, FLASH_BLEND[s]); } else { this.__flBlend = s; ORIG.blendMode.set!.call(this, s); }
    },
  });
  def('filters', {
    get(this: Container) {
      const defs = getFlashFilters(this);
      if (defs.length) return defs.map((d) => filterFromDef(d)).filter((f) => f !== null);
      const raw = ORIG.filters.get!.call(this) as readonly Filter[] | null | undefined;
      return raw && raw.length ? [...raw] : [];
    },
    set(this: Container, v: unknown) {
      const list = v === null || v === undefined ? [] : Array.isArray(v) ? v : [v];
      if (list.length && list.every((f) => f && typeof f === 'object' && 'def' in (f as object))) {
        setFlashFilters(this, list.map((f) => (f as any).def));
      } else if (list.length && list.some((f) => f && typeof f === 'object' && !('def' in (f as object)))) {
        setFlashFilters(this, null);
        setPixiFilters(this, list as Filter[]);
      } else {
        setFlashFilters(this, null);
      }
    },
  });
  def('mask', {
    get(this: any) {
      if (this.__flUserMask !== undefined) return this.__flUserMask;
      const m = ORIG.mask.get!.call(this);
      return m && m === this.__flScrollMask ? null : (m ?? null);
    },
    set(this: any, v: Container | null) {
      this.__flUserMask = v ?? null;
      ORIG.mask.set!.call(this, v ?? this.__flScrollMask ?? null);
    },
  });
  def('scrollRect', {
    get(this: any) { return this.__flScrollRect ? this.__flScrollRect.clone() : null; },
    set(this: any, r: Rectangle | null) {
      if (!r) {
        if (this.__flScrollRect) {
          const old = this.__flScrollRect as Rectangle;
          this.pivot.set(0, 0);
          this.__flScrollRect = null;
          void old;
        }
        const g: Graphics | undefined = this.__flScrollMask;
        if (g) {
          if (ORIG.mask.get!.call(this) === g) ORIG.mask.set!.call(this, this.__flUserMask ?? null);
          rawChildren.removeChild.call(this, g);
          g.destroy();
          this.__flScrollMask = null;
        }
        return;
      }
      const rect = new Rectangle(r.x, r.y, r.width, r.height);
      this.__flScrollRect = rect;
      this.pivot.set(rect.x, rect.y);
      let g: Graphics | undefined = this.__flScrollMask;
      if (!g) {
        g = new Graphics();
        (g as any).__flInternal = true;
        this.__flScrollMask = g;
        rawChildren.addChildAt.call(this, g, 0);
      }
      g.clear().rect(rect.x, rect.y, Math.max(0, rect.width), Math.max(0, rect.height)).fill({ color: 0xffffff });
      if (!this.__flUserMask) ORIG.mask.set!.call(this, g);
    },
  });
  def('cacheAsBitmap', { get(this: any) { return !!this.__flCache; }, set(this: any, v: unknown) { this.__flCache = !!v; } });
  data('cacheAsBitmapMatrix', null);
  data('opaqueBackground', null);
  data('scale9Grid', null);
  data('accessibilityProperties', null);
  data('accessibilityImplementation', null);
  data('metaData', null);

  def('mouseEnabled', { get(this: Container) { return getMouseEnabled(this); }, set(this: Container, v: unknown) { setMouseEnabled(this, v); } });
  def('mouseChildren', { get(this: Container) { return getMouseChildren(this); }, set(this: Container, v: unknown) { setMouseChildren(this, v); } });
  data('doubleClickEnabled', false);
  data('tabEnabled', false);
  data('tabIndex', -1);
  data('tabChildren', true);
  data('focusRect', null);
  data('contextMenu', null);
  data('needsSoftKeyboard', false);
  data('softKeyboardInputAreaOfInterest', null);
  data('soundTransform', null);
  P.requestSoftKeyboard = function () { return false; };

  P.startDrag = function (this: Container, lockCenter = false, bounds: Rectangle | null = null) { startDrag(this, lockCenter, bounds); };
  P.stopDrag = function (this: Container) { if (drag?.obj === this) drag = null; };

  P.toString = function (this: any) {
    const c = this.constructor;
    const n: string = c?.__fqn ? c.__fqn.split('.').pop() : (c?.name ?? 'DisplayObject').replace(/^_+/, '');
    return `[object ${n}]`;
  };

  listenerHooks.added.push((obj, type) => {
    if (BROADCAST.has(type)) broadcast(type).add(obj);
    if (obj instanceof Container && MOUSE_TYPES.has(type) && obj.eventMode === 'passive' && (obj as any).__flME === undefined
      && !(obj instanceof Bitmap) && !(obj instanceof SvgShape) && !(obj instanceof FlashShape)) {
      obj.eventMode = 'static';
    }
  });
  listenerHooks.removed.push((obj, type) => {
    if (BROADCAST.has(type) && !flHasListener(obj, type)) broadcast(type).delete(obj);
  });
}

const MOUSE_TYPES = new Set(['click', 'doubleClick', 'mouseDown', 'mouseUp', 'mouseMove', 'mouseOver', 'mouseOut', 'rollOver',
  'rollOut', 'mouseWheel', 'rightClick', 'rightMouseDown', 'rightMouseUp', 'middleClick', 'middleMouseDown', 'middleMouseUp']);

const BROADCAST = new Set(['enterFrame', 'exitFrame', 'frameConstructed', 'render', 'activate', 'deactivate']);
const broadcasts = new Map<string, Set<any>>();
function broadcast(type: string): Set<any> {
  let s = broadcasts.get(type);
  if (!s) { s = new Set(); broadcasts.set(type, s); }
  return s;
}
export function dispatchBroadcast(type: string): void {
  const s = broadcasts.get(type);
  if (!s || s.size === 0) return;
  for (const obj of [...s]) {
    if (obj.destroyed) { s.delete(obj); continue; }
    flDispatchAtTarget(obj, new Event(type));
  }
}

let renderPending = false;
export function invalidateStage(): void { renderPending = true; }

let drag: { obj: Container; dx: number; dy: number; bounds: Rectangle | null } | null = null;
function startDrag(obj: Container, lockCenter: boolean, bounds: Rectangle | null): void {
  const parent = obj.parent;
  const g = pointerGlobal();
  let dx = 0, dy = 0;
  if (parent && !lockCenter) {
    const p = parent.toLocal(g);
    dx = obj.x - p.x;
    dy = obj.y - p.y;
  }
  drag = { obj, dx, dy, bounds: bounds ? new Rectangle(bounds.x, bounds.y, bounds.width, bounds.height) : null };
  updateDrag();
}
export function updateDrag(): void {
  if (!drag) return;
  const { obj, dx, dy, bounds } = drag;
  if (obj.destroyed || !obj.parent) { drag = null; return; }
  const p = obj.parent.toLocal(pointerGlobal());
  let x = p.x + dx, y = p.y + dy;
  if (bounds) {
    x = Math.max(bounds.left, Math.min(bounds.right, x));
    y = Math.max(bounds.top, Math.min(bounds.bottom, y));
  }
  obj.position.set(x, y);
}

export class LoaderInfo extends EventDispatcher {
  url: string | null = null;
  loaderURL: string = location.href;
  bytesLoaded = 0;
  bytesTotal = 0;
  bytes: ByteArray | null = null;
  content: Container | null = null;
  loader: Loader | null = null;
  applicationDomain: unknown = null;
  contentType: string | null = null;
  frameRate = 25;
  width = 0;
  height = 0;
  swfVersion = 32;
  actionScriptVersion = 3;
  sameDomain = true;
  childAllowsParent = true;
  parentAllowsChild = true;
  isURLInaccessible = false;
  parameters: Record<string, string> = {};
  readonly sharedEvents = new EventDispatcher();
  readonly uncaughtErrorEvents = new EventDispatcher();
  childSandboxBridge: unknown = null;
  parentSandboxBridge: unknown = null;
  static getLoaderInfoByDefinition(_o: unknown): LoaderInfo | null { return null; }
}

let mainInfo: LoaderInfo | null = null;
export function mainLoaderInfo(): LoaderInfo {
  if (!mainInfo) {
    mainInfo = new LoaderInfo();
    mainInfo.url = location.href;
    mainInfo.parameters = Object.fromEntries(new URLSearchParams(location.search));
    mainInfo.bytesLoaded = mainInfo.bytesTotal = 1;
  }
  return mainInfo;
}

export function setupStage(app: Application, flashVars?: Record<string, string>): Container {
  appRef = app;
  FlashMode.renderer = app.renderer;
  const st = app.stage as any;
  if (flashVars) Object.assign(mainLoaderInfo().parameters, flashVars);
  if (stageObj === st) return st;
  stageObj = st;
  st.eventMode = 'static';
  let align = '';
  let scaleMode = 'showAll';
  let quality = 'HIGH';
  let displayState = 'normal';
  let focus: any = null;
  const size = () => ({ w: Math.round(appRef?.screen.width ?? 0), h: Math.round(appRef?.screen.height ?? 0) });
  Object.defineProperties(st, {
    stageWidth: { configurable: true, get: () => size().w, set: () => {} },
    stageHeight: { configurable: true, get: () => size().h, set: () => {} },
    fullScreenWidth: { configurable: true, get: () => screen.width },
    fullScreenHeight: { configurable: true, get: () => screen.height },
    fullScreenSourceRect: { configurable: true, writable: true, value: null },
    align: { configurable: true, get: () => align, set: (v: string) => { align = String(v ?? '').toUpperCase(); } },
    scaleMode: { configurable: true, get: () => scaleMode, set: (v: string) => { scaleMode = String(v); } },
    quality: { configurable: true, get: () => quality, set: (v: string) => { quality = String(v).toUpperCase(); } },
    displayState: {
      configurable: true,
      get: () => displayState,
      set: (v: string) => {
        displayState = String(v);
        try {
          if (v === 'normal') { if (document.fullscreenElement) void document.exitFullscreen(); }
          else void app.canvas.requestFullscreen?.();
        } catch { }
      },
    },
    frameRate: { configurable: true, get: () => FlashClock.fps, set: (v: number) => { if (Number(v) > 0) FlashClock.fps = Number(v); } },
    focus: {
      configurable: true,
      get: () => focus,
      set: (v: any) => {
        if (v === focus) return;
        const old = focus;
        focus = v ?? null;
        if (old && !old.destroyed) flDispatchSafe(old, Object.assign(new Event('focusOut', true), { relatedObject: focus }));
        if (focus && !focus.destroyed) flDispatchSafe(focus, Object.assign(new Event('focusIn', true), { relatedObject: old }));
      },
    },
    color: { configurable: true, get: () => app.renderer.background.color.toNumber(), set: (v: number) => { app.renderer.background.color = v; } },
    showDefaultContextMenu: { configurable: true, writable: true, value: true },
    stageFocusRect: { configurable: true, writable: true, value: true },
    colorCorrection: { configurable: true, writable: true, value: 'default' },
    colorCorrectionSupport: { configurable: true, value: 'unsupported' },
    allowsFullScreen: { configurable: true, value: true },
    allowsFullScreenInteractive: { configurable: true, value: true },
    contentsScaleFactor: { configurable: true, get: () => app.renderer.resolution },
    wmodeGPU: { configurable: true, value: true },
    stage3Ds: { configurable: true, value: [] },
    softKeyboardRect: { configurable: true, get: () => new Rectangle() },
    nativeWindow: { configurable: true, value: null },
    mouseLock: { configurable: true, writable: true, value: false },
    invalidate: { configurable: true, value: () => invalidateStage() },
    isFocusInaccessible: { configurable: true, value: () => false },
    assignFocus: { configurable: true, value: (o: any) => { st.focus = o; } },
    __flRoot: { configurable: true, value: true },
  });
  app.renderer.on('resize', () => flDispatchSafe(st, new Event('resize')));
  window.addEventListener('focus', () => dispatchBroadcast('activate'));
  window.addEventListener('blur', () => dispatchBroadcast('deactivate'));
  return st;
}

FlashClock.before.push(() => { updateDrag(); dispatchBroadcast('enterFrame'); });
FlashClock.after.push(() => {
  dispatchBroadcast('frameConstructed');
  dispatchBroadcast('exitFrame');
  if (renderPending) { renderPending = false; dispatchBroadcast('render'); }
});

function isContainerLike(v: unknown): v is Container { return v instanceof Container; }
function isNonInteractive(v: unknown): boolean {
  return v instanceof Bitmap || v instanceof SvgShape || v instanceof MorphShape || v instanceof FlashShape || v instanceof Graphics;
}
function isDOC(v: unknown): boolean {
  return isContainerLike(v) && !isNonInteractive(v) && !(v instanceof BaseTextField) && !(v instanceof SimpleButton);
}

function hasInstance(base: Function, test: (v: unknown) => boolean) {
  return function (this: Function, v: unknown): boolean {
    if (this === base) return test(v);
    return Function.prototype[Symbol.hasInstance].call(this, v);
  };
}

export class DisplayObject extends Container {
  constructor() { super(); initFields(this, new.target); }
}
Object.defineProperty(DisplayObject, Symbol.hasInstance, { value: hasInstance(DisplayObject, isContainerLike) });

export class InteractiveObject extends DisplayObject {
  constructor() { super(); this.eventMode = 'static'; }
}
Object.defineProperty(InteractiveObject, Symbol.hasInstance, { value: hasInstance(InteractiveObject, (v) => isContainerLike(v) && !isNonInteractive(v)) });

export class DisplayObjectContainer extends InteractiveObject {}
Object.defineProperty(DisplayObjectContainer, Symbol.hasInstance, { value: hasInstance(DisplayObjectContainer, isDOC) });

export function symbolFor(ctor: Function): [SwfLibrary, number, CharDef] | null {
  for (let c: any = ctor; c && c !== Function.prototype; c = Object.getPrototypeOf(c)) {
    if (!Object.prototype.hasOwnProperty.call(c, '__fqn')) continue;
    const sym = Domain.symbolOf(c.__fqn);
    if (sym) {
      const d = sym[0].char(sym[1]);
      if (d) return [sym[0], sym[1], d];
    }
  }
  return null;
}

export class Sprite extends BaseSprite {
  constructor() {
    super();
    this.eventMode = 'static';
    if (new.target !== Sprite) {
      const sym = symbolFor(new.target);
      if (sym && sym[2].kind === 'sprite') attachSymbolContent(this, sym[0], sym[2]);
    }
  }
}
Object.defineProperty(Sprite, Symbol.hasInstance, {
  value: hasInstance(Sprite, (v) => (v instanceof BaseSprite && !(v instanceof FlashShape)) || (isDOC(v) && v !== stageObj && !(v instanceof Loader) && !(v as any).__clipGroup)),
});

function attachSymbolContent(target: Container, lib: SwfLibrary, def: CharDef): void {
  const mc = withInteractive(true, () => new MovieClip(lib, def));
  FlashClock.remove(mc);
  const kids = [...mc.children].filter((c) => !isInternal(c));
  for (const k of kids) {
    rawChildren.removeChild.call(mc, k);
    rawChildren.addChild.call(target, k);
    (k as any).__flTimeline = true;
  }
  (target as any).__hasClip = kids.some((k) => (k as any).__clipGroup);
  const self = target as any;
  for (const c of flChildren(target)) {
    const n = c.label;
    if (!n) continue;
    if (!(n in self) || Object.prototype.hasOwnProperty.call(self, n)) self[n] = c;
  }
}

export class Shape extends FlashShape {
  constructor() { super(); this.eventMode = 'passive'; }
}
Object.defineProperty(Shape, Symbol.hasInstance, {
  value: hasInstance(Shape, (v) => v instanceof FlashShape || v instanceof SvgShape || v instanceof MorphShape),
});

export class TextField extends BaseTextField {
  constructor() { super(); this.eventMode = 'static'; }
}
Object.defineProperty(TextField, Symbol.hasInstance, { value: hasInstance(TextField, (v) => v instanceof BaseTextField) });

export class Stage extends DisplayObjectContainer {
  constructor() { super(); throw new IllegalOperationError('Error #2012: Stage class cannot be instantiated.', 2012); }
}
Object.defineProperty(Stage, Symbol.hasInstance, { value: hasInstance(Stage, (v) => v !== null && v === stageObj) });

export class AVM1Movie extends DisplayObject {
  call(): unknown { return null; }
  addCallback(): void {}
}

export class Video extends DisplayObject {
  deblocking = 0;
  smoothing = false;
  readonly videoWidth = 0;
  readonly videoHeight = 0;
  constructor(width = 320, height = 240) {
    super();
    void width; void height;
  }
  attachNetStream(_ns: unknown): void {}
  attachCamera(_c: unknown): void {}
  clear(): void {}
}

export class FrameLabel extends EventDispatcher {
  constructor(public readonly name: string, public readonly frame: number) { super(); }
}
MovieClip.makeLabel = (name, frame) => new FrameLabel(name, frame);

export class Scene {
  constructor(public readonly name: string, public readonly labels: FrameLabel[], public readonly numFrames: number) { initFields(this, new.target); }
}

export interface LoaderResolveRequest {
  url: string | null;
  bytes: ByteArray | null;
  context: unknown;
  loader: Loader;
}
export interface LoaderResolveResult {
  content?: Container | null;
  applicationDomain?: unknown;
  width?: number;
  height?: number;
}

const IMAGE_RE = /\.(png|jpe?g|gif|bmp|webp)(\?|$)/i;

export class Loader extends DisplayObjectContainer {
  static resolver: ((req: LoaderResolveRequest) => LoaderResolveResult | null | Promise<LoaderResolveResult | null>) | null = null;
  static defaultDomain: unknown = null;

  readonly contentLoaderInfo: LoaderInfo;
  private __ldContent: Container | null = null;
  private __ldSeq = 0;
  readonly uncaughtErrorEvents = new EventDispatcher();

  constructor() {
    super();
    this.contentLoaderInfo = new LoaderInfo();
    this.contentLoaderInfo.loader = this;
  }

  get content(): Container | null { return this.__ldContent; }

  load(request: { url?: string } | null, context: unknown = null): void {
    if (!request) throw new TypeError('Error #2007: Parameter request must be non-null.');
    void this.start(request.url ?? null, null, context);
  }
  loadBytes(bytes: ByteArray, context: unknown = null): void {
    if (!bytes) throw new TypeError('Error #2007: Parameter bytes must be non-null.');
    void this.start(null, bytes, context);
  }
  close(): void { this.__ldSeq++; }
  unload(): void {
    this.__ldSeq++;
    if (this.__ldContent) {
      const c = this.__ldContent;
      this.__ldContent = null;
      this.contentLoaderInfo.content = null;
      if (c.parent === this) this.removeChild(c);
      flDispatchSafe(this.contentLoaderInfo, new Event('unload'));
    }
  }
  unloadAndStop(_gc = true): void { this.unload(); }

  private async start(url: string | null, bytes: ByteArray | null, context: unknown): Promise<void> {
    if (this.__ldContent) this.unload();
    const seq = ++this.__ldSeq;
    const info = this.contentLoaderInfo;
    info.url = url;
    info.bytes = bytes;
    await Promise.resolve();
    if (seq !== this.__ldSeq) return;
    flDispatchSafe(info, new Event('open'));
    let result: LoaderResolveResult | null = null;
    try {
      result = (await Loader.resolver?.({ url, bytes, context, loader: this })) ?? null;
      if (!result && url && IMAGE_RE.test(url)) result = await loadImage(url);
      if (!result && bytes) {
        const mime = imageMime(bytes);
        if (mime) result = await loadImageBytes(bytes, mime);
      }
    } catch (err) {
      if (seq !== this.__ldSeq) return;
      const ev = Object.assign(new Event('ioError'), { text: `Error #2035: URL Not Found. URL: ${url}`, errorID: 2035 });
      console.warn('[Loader] falha', url, err);
      flDispatchSafe(info, ev);
      return;
    }
    if (seq !== this.__ldSeq) return;
    const content = result?.content ?? withInteractive(true, () => new MovieClip());
    (content as any).__flRoot = true;
    (content as any).__flLoaderInfo = info;
    this.__ldContent = content;
    info.content = content;
    info.applicationDomain = result?.applicationDomain ?? (context as any)?.applicationDomain ?? Loader.defaultDomain;
    info.width = result?.width ?? 0;
    info.height = result?.height ?? 0;
    info.bytesLoaded = info.bytesTotal = bytes ? bytes.length : 1;
    info.contentType = url && IMAGE_RE.test(url) ? 'image/png' : 'application/x-shockwave-flash';
    flDispatchSafe(info, Object.assign(new Event('progress'), { bytesLoaded: info.bytesLoaded, bytesTotal: info.bytesTotal }));
    rawAdd(this, content);
    flDispatchSafe(info, new Event('init'));
    flDispatchSafe(info, new Event('complete'));
  }
}
Object.defineProperty(Loader, Symbol.hasInstance, { value: hasInstance(Loader, (v) => Function.prototype[Symbol.hasInstance].call(Loader, v)) });

function rawAdd(p: Container, c: Container): void { flAddChild(p, c, p); }

function imageMime(bytes: ByteArray): string | null {
  const b = (i: number): number => (bytes as any)[i] ?? -1;
  if (b(0) === 0xff && b(1) === 0xd8) return 'image/jpeg';
  if (b(0) === 0x89 && b(1) === 0x50 && b(2) === 0x4e && b(3) === 0x47) return 'image/png';
  if (b(0) === 0x47 && b(1) === 0x49 && b(2) === 0x46) return 'image/gif';
  return null;
}

async function loadImageBytes(bytes: ByteArray, mime: string): Promise<LoaderResolveResult> {
  const n = bytes.length;
  const raw: Uint8Array | undefined = (bytes as any)._buf;
  const u8 = raw ? raw.slice(0, n) : Uint8Array.from({ length: n }, (_, i) => (bytes as any)[i]);
  const url = URL.createObjectURL(new Blob([u8], { type: mime }));
  try {
    return await loadImage(url);
  } finally {
    URL.revokeObjectURL(url);
  }
}

async function loadImage(url: string): Promise<LoaderResolveResult> {
  const img = new Image();
  img.crossOrigin = 'anonymous';
  await new Promise<void>((res, rej) => { img.onload = () => res(); img.onerror = () => rej(new Error('img')); img.src = url; });
  const bd = new BitmapData(img.naturalWidth || 1, img.naturalHeight || 1, true, 0);
  (bd as any).canvas().getContext('2d').drawImage(img, 0, 0);
  (bd as any).changed();
  return { content: new Bitmap(bd), width: img.naturalWidth, height: img.naturalHeight };
}

export const StageAlign = { BOTTOM: 'B', BOTTOM_LEFT: 'BL', BOTTOM_RIGHT: 'BR', LEFT: 'L', RIGHT: 'R', TOP: 'T', TOP_LEFT: 'TL', TOP_RIGHT: 'TR' } as const;
export const StageScaleMode = { EXACT_FIT: 'exactFit', NO_BORDER: 'noBorder', NO_SCALE: 'noScale', SHOW_ALL: 'showAll' } as const;
export const StageQuality = { BEST: 'best', HIGH: 'high', LOW: 'low', MEDIUM: 'medium', HIGH_8X8: '8x8', HIGH_8X8_LINEAR: '8x8linear', HIGH_16X16: '16x16', HIGH_16X16_LINEAR: '16x16linear' } as const;
export const StageDisplayState = { FULL_SCREEN: 'fullScreen', FULL_SCREEN_INTERACTIVE: 'fullScreenInteractive', NORMAL: 'normal' } as const;
export const BlendMode = { ADD: 'add', ALPHA: 'alpha', DARKEN: 'darken', DIFFERENCE: 'difference', ERASE: 'erase', HARDLIGHT: 'hardlight', INVERT: 'invert', LAYER: 'layer', LIGHTEN: 'lighten', MULTIPLY: 'multiply', NORMAL: 'normal', OVERLAY: 'overlay', SCREEN: 'screen', SHADER: 'shader', SUBTRACT: 'subtract' } as const;
export const PixelSnapping = { ALWAYS: 'always', AUTO: 'auto', NEVER: 'never' } as const;
export const GradientType = { LINEAR: 'linear', RADIAL: 'radial' } as const;
export const SpreadMethod = { PAD: 'pad', REFLECT: 'reflect', REPEAT: 'repeat' } as const;
export const InterpolationMethod = { LINEAR_RGB: 'linearRGB', RGB: 'rgb' } as const;
export const CapsStyle = { NONE: 'none', ROUND: 'round', SQUARE: 'square' } as const;
export const JointStyle = { BEVEL: 'bevel', MITER: 'miter', ROUND: 'round' } as const;
export const LineScaleMode = { HORIZONTAL: 'horizontal', NONE: 'none', NORMAL: 'normal', VERTICAL: 'vertical' } as const;
export const GraphicsPathCommand = { CUBIC_CURVE_TO: 6, CURVE_TO: 3, LINE_TO: 2, MOVE_TO: 1, NO_OP: 0, WIDE_LINE_TO: 5, WIDE_MOVE_TO: 4 } as const;
export const GraphicsPathWinding = { EVEN_ODD: 'evenOdd', NON_ZERO: 'nonZero' } as const;
export const TriangleCulling = { NEGATIVE: 'negative', NONE: 'none', POSITIVE: 'positive' } as const;
export const BitmapDataChannel = { ALPHA: 8, BLUE: 4, GREEN: 2, RED: 1 } as const;
export const ColorCorrection = { DEFAULT: 'default', OFF: 'off', ON: 'on' } as const;
export const ActionScriptVersion = { ACTIONSCRIPT2: 2, ACTIONSCRIPT3: 3 } as const;
export const SWFVersion = { FLASH1: 1, FLASH10: 10, FLASH11: 11, FLASH9: 9 } as const;

export { Bitmap, BitmapData, MovieClip, SimpleButton, FlashGraphics as Graphics, MorphShape, setBlend };

export function appInstance(): Application | null { return appRef; }
