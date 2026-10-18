import { Container, FederatedEvent, FillGradient, Graphics, Matrix } from 'pixi.js';
import { initFields } from '@/as3/runtime';
import { dispatchFlashEvent, type Event as FlashEvent } from './events';
import type { BitmapData } from './library';

type MatrixLike = { a: number; b: number; c: number; d: number; tx: number; ty: number };
type Fill =
  | { color: number; alpha: number }
  | { bitmap: BitmapData; matrix?: Matrix; repeat: boolean }
  | { gradient: FillGradient }
  | null;
interface LineStyle { width: number; color: number; alpha: number; cap: 'round' | 'butt' | 'square'; join: 'round' | 'bevel' | 'miter'; miter: number }
type Seg = ['M', number, number] | ['L', number, number] | ['Q', number, number, number, number] | ['C', number, number, number, number, number, number];

const num = (v: unknown, d = 0) => (v === undefined || v === null || Number.isNaN(Number(v)) ? d : Number(v));

function toMatrix(m?: MatrixLike | null): Matrix | undefined {
  return m ? new Matrix(m.a, m.b, m.c, m.d, m.tx, m.ty) : undefined;
}

function flashGradient(type: string, colors: number[], alphas: number[], ratios: number[], m?: MatrixLike | null): FillGradient {
  const mm = m ?? { a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0 };
  const tp = (x: number, y: number) => ({ x: mm.a * x + mm.c * y + mm.tx, y: mm.b * x + mm.d * y + mm.ty });
  const colorStops = colors.map((c, i) => {
    const a = Math.max(0, Math.min(1, num(alphas?.[i], 1)));
    const col = Number(c) >>> 0;
    return {
      offset: Math.max(0, Math.min(1, num(ratios?.[i], (i / Math.max(1, colors.length - 1)) * 255) / 255)),
      color: `rgba(${(col >> 16) & 255},${(col >> 8) & 255},${col & 255},${a.toFixed(3)})`,
    };
  });
  if (type === 'radial') {
    const center = tp(0, 0);
    const radius = 819.2 * Math.hypot(mm.a, mm.b);
    return new FillGradient({ type: 'radial', center, innerRadius: 0, outerCenter: center, outerRadius: radius, colorStops,
      textureSpace: 'global' });
  }
  return new FillGradient({ type: 'linear', start: tp(-819.2, 0), end: tp(819.2, 0), colorStops, textureSpace: 'global' });
}

export class FlashGraphics {
  readonly g = new Graphics();
  private fill: Fill = null;
  private line: LineStyle | null = null;
  private path: { seg: Seg; line: LineStyle | null }[] = [];
  private cx = 0;
  private cy = 0;
  private cmds: [string, unknown[]][] = [];
  private replaying = false;

  constructor() { (this.g as any).__flInternal = true; }

  private rec(name: string, args: unknown[]): void {
    if (!this.replaying) this.cmds.push([name, args]);
  }

  private replay(): void {
    if (this.g.destroyed) return;
    const cmds = this.cmds;
    this.g.clear();
    this.fill = null;
    this.line = null;
    this.path = [];
    this.cx = this.cy = 0;
    this.replaying = true;
    for (const [name, args] of cmds) (this as any)[name](...args);
    this.replaying = false;
  }

  clear(): void {
    this.g.clear();
    this.fill = null;
    this.line = null;
    this.path = [];
    this.cx = this.cy = 0;
    if (!this.replaying) this.cmds = [];
  }

  beginFill(color: unknown = 0, alpha: unknown = 1): void {
    this.rec('beginFill', [color, alpha]);
    this.flush();
    this.fill = { color: num(color) >>> 0 & 0xffffff, alpha: Math.max(0, Math.min(1, num(alpha, 1))) };
  }
  beginBitmapFill(bitmap: BitmapData, matrix?: MatrixLike | null, repeat = true, _smooth = false): void {
    this.rec('beginBitmapFill', [bitmap, matrix, repeat]);
    this.flush();
    if (!bitmap) { this.fill = null; return; }
    if (!bitmap.loaded && !this.replaying) bitmap.ready.then(() => this.replay());
    this.fill = { bitmap, matrix: toMatrix(matrix), repeat: repeat !== false };
  }
  beginGradientFill(type: string, colors: number[], alphas: number[], ratios: number[], matrix?: MatrixLike | null): void {
    this.rec('beginGradientFill', [type, colors, alphas, ratios, matrix]);
    this.flush();
    this.fill = { gradient: flashGradient(String(type), colors ?? [], alphas ?? [], ratios ?? [], matrix) };
  }
  endFill(): void { this.rec('endFill', []); this.flush(); this.fill = null; }

  lineStyle(thickness?: unknown, color: unknown = 0, alpha: unknown = 1, _pixelHinting = false, _scaleMode = 'normal',
    caps: string | null = null, joints: string | null = null, miterLimit: unknown = 3): void {
    this.rec('lineStyle', [thickness, color, alpha, _pixelHinting, _scaleMode, caps, joints, miterLimit]);
    if (thickness === undefined || thickness === null || Number.isNaN(Number(thickness))) { this.line = null; return; }
    this.line = {
      width: Math.max(1, Number(thickness)), color: num(color) >>> 0 & 0xffffff, alpha: Math.max(0, Math.min(1, num(alpha, 1))),
      cap: caps === 'none' ? 'butt' : caps === 'square' ? 'square' : 'round',
      join: joints === 'bevel' ? 'bevel' : joints === 'miter' ? 'miter' : 'round',
      miter: num(miterLimit, 3),
    };
  }
  lineGradientStyle(_type: string, colors: number[], alphas: number[]): void {
    if (this.line && colors?.length) { this.line.color = Number(colors[0]) & 0xffffff; this.line.alpha = num(alphas?.[0], 1); }
  }
  lineBitmapStyle(): void { }

  private fillStyle(): unknown {
    const f = this.fill;
    if (!f) return null;
    if ('bitmap' in f) {
      if (!f.bitmap.loaded) return null;
      if (f.repeat) f.bitmap.texture.source.style.addressMode = 'repeat';
      return { texture: f.bitmap.texture, matrix: f.matrix ?? new Matrix(), textureSpace: 'global' };
    }
    if ('gradient' in f) return f.gradient;
    return { color: f.color, alpha: f.alpha };
  }

  private strokeStyle(l: LineStyle): Parameters<Graphics['stroke']>[0] {
    return { width: l.width, color: l.color, alpha: l.alpha, cap: l.cap, join: l.join, miterLimit: l.miter };
  }

  private paint(): void {
    const fs = this.fillStyle();
    if (fs) this.g.fill(fs as any);
    if (this.line) this.g.stroke(this.strokeStyle(this.line));
  }

  private flush(): void {
    const path = this.path;
    if (!path.length) return;
    this.path = [];
    const fs = this.fillStyle();
    const g = this.g;
    if (fs) {
      let started = false;
      for (const { seg } of path) {
        if (seg[0] === 'M') { g.moveTo(seg[1], seg[2]); started = true; }
        else if (!started) { g.moveTo(0, 0); started = true; }
        if (seg[0] === 'L') g.lineTo(seg[1], seg[2]);
        else if (seg[0] === 'Q') g.quadraticCurveTo(seg[1], seg[2], seg[3], seg[4]);
        else if (seg[0] === 'C') g.bezierCurveTo(seg[1], seg[2], seg[3], seg[4], seg[5], seg[6]);
      }
      g.closePath().fill(fs as any);
    }
    let px = 0, py = 0;
    for (const { seg, line } of path) {
      if (seg[0] === 'M') { px = seg[1]; py = seg[2]; continue; }
      const ex = seg[0] === 'L' ? seg[1] : seg[0] === 'Q' ? seg[3] : seg[5];
      const ey = seg[0] === 'L' ? seg[2] : seg[0] === 'Q' ? seg[4] : seg[6];
      if (line) {
        g.moveTo(px, py);
        if (seg[0] === 'L') g.lineTo(seg[1], seg[2]);
        else if (seg[0] === 'Q') g.quadraticCurveTo(seg[1], seg[2], seg[3], seg[4]);
        else g.bezierCurveTo(seg[1], seg[2], seg[3], seg[4], seg[5], seg[6]);
        g.stroke(this.strokeStyle(line));
      }
      px = ex; py = ey;
    }
  }

  private segment(seg: Seg, ex: number, ey: number): void {
    if (this.fill) {
      if (!this.path.length) this.path.push({ seg: ['M', this.cx, this.cy], line: null });
      this.path.push({ seg, line: this.line });
    } else if (this.line) {
      const g = this.g;
      g.moveTo(this.cx, this.cy);
      if (seg[0] === 'L') g.lineTo(seg[1], seg[2]);
      else if (seg[0] === 'Q') g.quadraticCurveTo(seg[1], seg[2], seg[3], seg[4]);
      else if (seg[0] === 'C') g.bezierCurveTo(seg[1], seg[2], seg[3], seg[4], seg[5], seg[6]);
      g.stroke(this.strokeStyle(this.line));
    }
    this.cx = ex;
    this.cy = ey;
  }

  moveTo(x: number, y: number): void {
    this.rec('moveTo', [x, y]);
    x = num(x); y = num(y);
    if (this.fill) this.path.push({ seg: ['M', x, y], line: null });
    this.cx = x;
    this.cy = y;
  }
  lineTo(x: number, y: number): void {
    this.rec('lineTo', [x, y]);
    x = num(x); y = num(y);
    this.segment(['L', x, y], x, y);
  }
  curveTo(cx: number, cy: number, ax: number, ay: number): void {
    this.rec('curveTo', [cx, cy, ax, ay]);
    this.segment(['Q', num(cx), num(cy), num(ax), num(ay)], num(ax), num(ay));
  }
  cubicCurveTo(c1x: number, c1y: number, c2x: number, c2y: number, ax: number, ay: number): void {
    this.rec('cubicCurveTo', [c1x, c1y, c2x, c2y, ax, ay]);
    this.segment(['C', num(c1x), num(c1y), num(c2x), num(c2y), num(ax), num(ay)], num(ax), num(ay));
  }

  drawRect(x: number, y: number, w: number, h: number): void {
    this.rec('drawRect', [x, y, w, h]);
    this.flush();
    x = num(x); y = num(y); w = num(w); h = num(h);
    if (w < 0) { x += w; w = -w; }
    if (h < 0) { y += h; h = -h; }
    if (w > 0 || h > 0) { this.g.rect(x, y, w, h); this.paint(); }
    this.cx = x; this.cy = y;
  }
  drawRoundRect(x: number, y: number, w: number, h: number, ew: number, eh?: number): void {
    this.rec('drawRoundRect', [x, y, w, h, ew, eh]);
    this.flush();
    const r = Math.min(num(ew), num(eh, num(ew))) / 2;
    if (r <= 0) this.g.rect(num(x), num(y), num(w), num(h));
    else this.g.roundRect(num(x), num(y), num(w), num(h), r);
    this.paint();
  }
  drawRoundRectComplex(x: number, y: number, w: number, h: number, tl: number, tr: number, bl: number, br: number): void {
    this.rec('drawRoundRectComplex', [x, y, w, h, tl, tr, bl, br]);
    this.flush();
    const g = this.g;
    x = num(x); y = num(y); w = num(w); h = num(h);
    g.moveTo(x + tl, y).lineTo(x + w - tr, y).quadraticCurveTo(x + w, y, x + w, y + tr)
      .lineTo(x + w, y + h - br).quadraticCurveTo(x + w, y + h, x + w - br, y + h)
      .lineTo(x + bl, y + h).quadraticCurveTo(x, y + h, x, y + h - bl)
      .lineTo(x, y + tl).quadraticCurveTo(x, y, x + tl, y).closePath();
    this.paint();
  }
  drawCircle(x: number, y: number, r: number): void {
    this.rec('drawCircle', [x, y, r]);
    this.flush();
    this.g.circle(num(x), num(y), num(r));
    this.paint();
  }
  drawEllipse(x: number, y: number, w: number, h: number): void {
    this.rec('drawEllipse', [x, y, w, h]);
    this.flush();
    this.g.ellipse(num(x) + num(w) / 2, num(y) + num(h) / 2, num(w) / 2, num(h) / 2);
    this.paint();
  }
  drawPath(commands: ArrayLike<number>, data: ArrayLike<number>, _winding = 'evenOdd'): void {
    let k = 0;
    for (let i = 0; i < (commands?.length ?? 0); i++) {
      switch (commands[i]) {
        case 1: this.moveTo(data[k], data[k + 1]); k += 2; break;
        case 2: this.lineTo(data[k], data[k + 1]); k += 2; break;
        case 3: this.curveTo(data[k], data[k + 1], data[k + 2], data[k + 3]); k += 4; break;
        case 4: this.moveTo(data[k + 2], data[k + 3]); k += 4; break;
        case 5: this.lineTo(data[k + 2], data[k + 3]); k += 4; break;
        case 6: this.cubicCurveTo(data[k], data[k + 1], data[k + 2], data[k + 3], data[k + 4], data[k + 5]); k += 6; break;
        default: break;
      }
    }
  }
  drawTriangles(vertices: ArrayLike<number>, indices: ArrayLike<number> | null = null): void {
    const n = indices ? indices.length : vertices.length / 2;
    for (let t = 0; t + 2 < n; t += 3) {
      const id = (j: number) => (indices ? indices[t + j] : t + j);
      this.moveTo(vertices[id(0) * 2], vertices[id(0) * 2 + 1]);
      this.lineTo(vertices[id(1) * 2], vertices[id(1) * 2 + 1]);
      this.lineTo(vertices[id(2) * 2], vertices[id(2) * 2 + 1]);
      this.lineTo(vertices[id(0) * 2], vertices[id(0) * 2 + 1]);
    }
  }
  drawGraphicsData(): void { }
  readGraphicsData(): unknown[] { return []; }
  copyFrom(source: FlashGraphics): void {
    this.clear();
    for (const [name, args] of source.cmds) (this as any)[name](...args);
  }
}

function applyMouse(o: any): void {
  const me = o.__flME, mc = o.__flMC;
  if (me === true) o.eventMode = 'static';
  else if (me === false) o.eventMode = mc === false ? 'none' : 'passive';
}
export function getMouseEnabled(o: Container): boolean { const v = (o as any).__flME; return v ?? o.eventMode !== 'none'; }
export function setMouseEnabled(o: Container, v: unknown): void {
  (o as any).__flME = v === true || v === 'true';
  applyMouse(o);
}
export function getMouseChildren(o: Container): boolean { return (o as any).__flMC ?? true; }
export function setMouseChildren(o: Container, v: unknown): void {
  (o as any).__flMC = v === true || v === 'true';
  applyMouse(o);
}

export class Sprite extends Container {
  private __flGraphics?: FlashGraphics;
  private __flButtonMode = false;
  private __flUseHandCursor = true;

  constructor() {
    super();
    initFields(this, new.target);
  }

  get buttonMode(): boolean { return this.__flButtonMode; }
  set buttonMode(v: boolean) { this.__flButtonMode = v === true || (v as unknown) === 'true'; this.syncCursor(); }
  get useHandCursor(): boolean { return this.__flUseHandCursor; }
  set useHandCursor(v: boolean) { this.__flUseHandCursor = v === true || (v as unknown) === 'true'; this.syncCursor(); }
  private syncCursor(): void {
    if (this.__flButtonMode && this.__flUseHandCursor) this.cursor = 'pointer';
    else if (this.cursor === 'pointer') this.cursor = 'default';
  }

  override dispatchEvent(e: FederatedEvent | FlashEvent): boolean {
    if (e instanceof FederatedEvent) return super.dispatchEvent(e);
    return dispatchFlashEvent(this, e);
  }

  get graphics(): FlashGraphics {
    if (!this.__flGraphics) {
      this.__flGraphics = new FlashGraphics();
      this.addChildAt(this.__flGraphics.g, 0);
    }
    return this.__flGraphics;
  }

    get mouseEnabled(): boolean { return getMouseEnabled(this); }
  set mouseEnabled(v: boolean) { setMouseEnabled(this, v); }
  get mouseChildren(): boolean { return getMouseChildren(this); }
  set mouseChildren(v: boolean) { setMouseChildren(this, v); }

}

export class FlashShape extends Sprite {}
