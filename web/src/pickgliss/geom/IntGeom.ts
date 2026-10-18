import { Point, Rectangle } from 'pixi.js';
import { Domain } from '@/flash/library';

const int = (v: unknown): number => Number(v) | 0;

export class IntPoint {
  x: number;
  y: number;
  constructor(x: unknown = 0, y: unknown = 0) { this.x = int(x); this.y = int(y); }
  static creatWithPoint(p: { x: number; y: number }): IntPoint { return new IntPoint(p.x, p.y); }
  toPoint(): Point { return new Point(this.x, this.y); }
  setWithPoint(p: { x: number; y: number }): void { this.x = int(p.x); this.y = int(p.y); }
  setLocation(p: IntPoint): void { this.x = int(p.x); this.y = int(p.y); }
  setLocationXY(x = 0, y = 0): void { this.x = int(x); this.y = int(y); }
  move(dx: number, dy: number): IntPoint { this.x = int(this.x + dx); this.y = int(this.y + dy); return this; }
  moveRadians(dir: number, dist: number): IntPoint {
    this.x = int(this.x + Math.round(Math.cos(dir) * dist));
    this.y = int(this.y + Math.round(Math.sin(dir) * dist));
    return this;
  }
  nextPoint(dir: number, dist: number): IntPoint { return new IntPoint(this.x + Math.cos(dir) * dist, this.y + Math.sin(dir) * dist); }
  distanceSq(p: IntPoint): number { const dx = this.x - p.x, dy = this.y - p.y; return int(dx * dx + dy * dy); }
  distance(p: IntPoint): number { return int(Math.sqrt(this.distanceSq(p))); }
  equals(o: unknown): boolean { return o instanceof IntPoint && this.x === o.x && this.y === o.y; }
  clone(): IntPoint { return new IntPoint(this.x, this.y); }
  toString(): string { return `IntPoint[${this.x},${this.y}]`; }
}

export class IntDimension {
  width: number;
  height: number;
  constructor(w: unknown = 0, h: unknown = 0) { this.width = int(w); this.height = int(h); }
  static createBigDimension(): IntDimension { return new IntDimension(100000, 100000); }
  setSize(d: IntDimension): void { this.width = d.width; this.height = d.height; }
  setSizeWH(w: number, h: number): void { this.width = int(w); this.height = int(h); }
  increaseSize(d: IntDimension): IntDimension { this.width += d.width; this.height += d.height; return this; }
  decreaseSize(d: IntDimension): IntDimension { this.width -= d.width; this.height -= d.height; return this; }
  change(dw: number, dh: number): IntDimension { this.width = int(this.width + dw); this.height = int(this.height + dh); return this; }
  changedSize(w: number, h: number): IntDimension { return new IntDimension(w, h); }
  combine(d: IntDimension): IntDimension {
    this.width = Math.max(this.width, d.width);
    this.height = Math.max(this.height, d.height);
    return this;
  }
  combineSize(d: IntDimension): IntDimension { return this.clone().combine(d); }
  getBounds(x = 0, y = 0): IntRectangle { return new IntRectangle(x, y, this.width, this.height); }
  equals(o: unknown): boolean { return o instanceof IntDimension && this.width === o.width && this.height === o.height; }
  clone(): IntDimension { return new IntDimension(this.width, this.height); }
  toString(): string { return `IntDimension[${this.width},${this.height}]`; }
}

export class IntRectangle {
  x = 0;
  y = 0;
  width = 0;
  height = 0;
  constructor(x: unknown = 0, y: unknown = 0, w: unknown = 0, h: unknown = 0) { this.setRectXYWH(x, y, w, h); }
  static creatWithRectangle(r: Rectangle): IntRectangle { return new IntRectangle(r.x, r.y, r.width, r.height); }
  toRectangle(): Rectangle { return new Rectangle(this.x, this.y, this.width, this.height); }
  setWithRectangle(r: Rectangle): void { this.setRectXYWH(r.x, r.y, r.width, r.height); }
  setRect(r: IntRectangle): void { this.setRectXYWH(r.x, r.y, r.width, r.height); }
  setRectXYWH(x: unknown, y: unknown, w: unknown, h: unknown): void {
    this.x = int(x); this.y = int(y); this.width = int(w); this.height = int(h);
  }
  setLocation(p: IntPoint): void { this.x = p.x; this.y = p.y; }
  setSize(d: IntDimension): void { this.width = d.width; this.height = d.height; }
  getSize(): IntDimension { return new IntDimension(this.width, this.height); }
  getLocation(): IntPoint { return new IntPoint(this.x, this.y); }
  union(r: IntRectangle): IntRectangle {
    const x0 = Math.min(this.x, r.x), x1 = Math.max(this.x + this.width, r.x + r.width);
    const y0 = Math.min(this.y, r.y), y1 = Math.max(this.y + this.height, r.y + r.height);
    return new IntRectangle(x0, y0, x1 - x0, y1 - y0);
  }
  grow(h: number, v: number): void { this.x -= h; this.y -= v; this.width += h * 2; this.height += v * 2; }
  move(dx: number, dy: number): void { this.x += dx; this.y += dy; }
  resize(dw = 0, dh = 0): void { this.width += dw; this.height += dh; }
  leftTop(): IntPoint { return new IntPoint(this.x, this.y); }
  rightTop(): IntPoint { return new IntPoint(this.x + this.width, this.y); }
  leftBottom(): IntPoint { return new IntPoint(this.x, this.y + this.height); }
  rightBottom(): IntPoint { return new IntPoint(this.x + this.width, this.y + this.height); }
  containsPoint(p: IntPoint): boolean {
    return !(p.x < this.x || p.y < this.y || p.x > this.x + this.width || p.y > this.y + this.height);
  }
  equals(o: unknown): boolean {
    return o instanceof IntRectangle && this.x === o.x && this.y === o.y && this.width === o.width && this.height === o.height;
  }
  clone(): IntRectangle { return new IntRectangle(this.x, this.y, this.width, this.height); }
  toString(): string { return `IntRectangle[x:${this.x},y:${this.y}, width:${this.width},height:${this.height}]`; }
}

Domain.registerClass('com.pickgliss.geom.IntPoint', IntPoint);
Domain.registerClass('com.pickgliss.geom.IntDimension', IntDimension);
Domain.registerClass('com.pickgliss.geom.IntRectangle', IntRectangle);
