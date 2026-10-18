import { initFields } from '../runtime';

const n = (v: unknown, d = 0): number => (v === undefined || v === null ? d : Number(v));

export class Point {
  x: number;
  y: number;
  constructor(x: unknown = 0, y: unknown = 0) {
    initFields(this, new.target);
    this.x = n(x);
    this.y = n(y);
  }
  get length(): number { return Math.sqrt(this.x * this.x + this.y * this.y); }
  add(v: Point): Point { return new Point(this.x + v.x, this.y + v.y); }
  subtract(v: Point): Point { return new Point(this.x - v.x, this.y - v.y); }
  clone(): Point { return new Point(this.x, this.y); }
  copyFrom(p: Point): void { this.x = p.x; this.y = p.y; }
  equals(p: Point | null): boolean { return !!p && p.x === this.x && p.y === this.y; }
  normalize(thickness: number): void {
    const len = this.length;
    if (len > 0) { const s = n(thickness) / len; this.x *= s; this.y *= s; }
  }
  offset(dx: number, dy: number): void { this.x += n(dx); this.y += n(dy); }
  setTo(x: number, y: number): void { this.x = n(x); this.y = n(y); }
  set(x = 0, y = x): void { this.x = x; this.y = y; }
  toString(): string { return `(x=${this.x}, y=${this.y})`; }
  static distance(a: Point, b: Point): number { return Math.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2); }
  static interpolate(a: Point, b: Point, f: number): Point {
    return new Point(b.x + (a.x - b.x) * f, b.y + (a.y - b.y) * f);
  }
  static polar(len: number, angle: number): Point { return new Point(len * Math.cos(angle), len * Math.sin(angle)); }
}

export class Rectangle {
  x: number;
  y: number;
  width: number;
  height: number;
  constructor(x: unknown = 0, y: unknown = 0, width: unknown = 0, height: unknown = 0) {
    initFields(this, new.target);
    this.x = n(x);
    this.y = n(y);
    this.width = n(width);
    this.height = n(height);
  }
  get left(): number { return this.x; }
  set left(v: number) { this.width -= v - this.x; this.x = v; }
  get right(): number { return this.x + this.width; }
  set right(v: number) { this.width = v - this.x; }
  get top(): number { return this.y; }
  set top(v: number) { this.height -= v - this.y; this.y = v; }
  get bottom(): number { return this.y + this.height; }
  set bottom(v: number) { this.height = v - this.y; }
  get topLeft(): Point { return new Point(this.x, this.y); }
  set topLeft(p: Point) { this.left = p.x; this.top = p.y; }
  get bottomRight(): Point { return new Point(this.right, this.bottom); }
  set bottomRight(p: Point) { this.right = p.x; this.bottom = p.y; }
  get size(): Point { return new Point(this.width, this.height); }
  set size(p: Point) { this.width = p.x; this.height = p.y; }

  clone(): Rectangle { return new Rectangle(this.x, this.y, this.width, this.height); }
  contains(x: number, y: number): boolean {
    return x >= this.x && y >= this.y && x < this.x + this.width && y < this.y + this.height;
  }
  containsPoint(p: Point): boolean { return this.contains(p.x, p.y); }
  containsRect(r: Rectangle): boolean {
    if (r.width <= 0 || r.height <= 0) {
      return r.x > this.x && r.y > this.y && r.right < this.right && r.bottom < this.bottom;
    }
    return r.x >= this.x && r.y >= this.y && r.right <= this.right && r.bottom <= this.bottom;
  }
  copyFrom(r: Rectangle): void { this.x = r.x; this.y = r.y; this.width = r.width; this.height = r.height; }
  equals(r: Rectangle | null): boolean {
    return !!r && r.x === this.x && r.y === this.y && r.width === this.width && r.height === this.height;
  }
  inflate(dx: number, dy: number): void { this.x -= dx; this.width += 2 * dx; this.y -= dy; this.height += 2 * dy; }
  inflatePoint(p: Point): void { this.inflate(p.x, p.y); }
  intersection(r: Rectangle): Rectangle {
    if (this.isEmpty() || r.isEmpty()) return new Rectangle();
    const x0 = Math.max(this.x, r.x), y0 = Math.max(this.y, r.y);
    const x1 = Math.min(this.right, r.right), y1 = Math.min(this.bottom, r.bottom);
    if (x1 <= x0 || y1 <= y0) return new Rectangle();
    return new Rectangle(x0, y0, x1 - x0, y1 - y0);
  }
  intersects(r: Rectangle): boolean {
    if (this.isEmpty() || r.isEmpty()) return false;
    return Math.max(this.x, r.x) < Math.min(this.right, r.right) && Math.max(this.y, r.y) < Math.min(this.bottom, r.bottom);
  }
  isEmpty(): boolean { return !(this.width > 0) || !(this.height > 0); }
  offset(dx: number, dy: number): void { this.x += n(dx); this.y += n(dy); }
  offsetPoint(p: Point): void { this.offset(p.x, p.y); }
  setEmpty(): void { this.x = this.y = this.width = this.height = 0; }
  setTo(x: number, y: number, w: number, h: number): void { this.x = n(x); this.y = n(y); this.width = n(w); this.height = n(h); }
  union(r: Rectangle): Rectangle {
    if (this.isEmpty()) return r.clone();
    if (r.isEmpty()) return this.clone();
    const x0 = Math.min(this.x, r.x), y0 = Math.min(this.y, r.y);
    return new Rectangle(x0, y0, Math.max(this.right, r.right) - x0, Math.max(this.bottom, r.bottom) - y0);
  }
  toString(): string { return `(x=${this.x}, y=${this.y}, w=${this.width}, h=${this.height})`; }
}

export class Matrix {
  a: number;
  b: number;
  c: number;
  d: number;
  tx: number;
  ty: number;
  constructor(a: unknown = 1, b: unknown = 0, c: unknown = 0, d: unknown = 1, tx: unknown = 0, ty: unknown = 0) {
    initFields(this, new.target);
    this.a = n(a, 1);
    this.b = n(b);
    this.c = n(c);
    this.d = n(d, 1);
    this.tx = n(tx);
    this.ty = n(ty);
  }
  clone(): Matrix { return new Matrix(this.a, this.b, this.c, this.d, this.tx, this.ty); }
  concat(m: Matrix): void {
    const { a, b, c, d, tx, ty } = this;
    this.a = a * m.a + b * m.c;
    this.b = a * m.b + b * m.d;
    this.c = c * m.a + d * m.c;
    this.d = c * m.b + d * m.d;
    this.tx = tx * m.a + ty * m.c + m.tx;
    this.ty = tx * m.b + ty * m.d + m.ty;
  }
  copyFrom(m: Matrix): void { this.a = m.a; this.b = m.b; this.c = m.c; this.d = m.d; this.tx = m.tx; this.ty = m.ty; }
  createBox(scaleX: number, scaleY: number, rotation = 0, tx = 0, ty = 0): void {
    const cos = Math.cos(rotation), sin = Math.sin(rotation);
    this.a = cos * scaleX;
    this.b = sin * scaleY;
    this.c = -sin * scaleX;
    this.d = cos * scaleY;
    this.tx = tx;
    this.ty = ty;
  }
  createGradientBox(width: number, height: number, rotation = 0, tx = 0, ty = 0): void {
    const cos = Math.cos(rotation), sin = Math.sin(rotation);
    this.a = (cos * width) / 1638.4;
    this.b = (sin * height) / 1638.4;
    this.c = (-sin * width) / 1638.4;
    this.d = (cos * height) / 1638.4;
    this.tx = tx + width / 2;
    this.ty = ty + height / 2;
  }
  deltaTransformPoint(p: Point): Point { return new Point(this.a * p.x + this.c * p.y, this.b * p.x + this.d * p.y); }
  identity(): void { this.a = this.d = 1; this.b = this.c = this.tx = this.ty = 0; }
  invert(): void {
    const { a, b, c, d, tx, ty } = this;
    const det = a * d - b * c;
    if (det === 0) {
      this.a = this.b = this.c = this.d = 0;
      this.tx = -tx;
      this.ty = -ty;
      return;
    }
    this.a = d / det;
    this.b = -b / det;
    this.c = -c / det;
    this.d = a / det;
    this.tx = (c * ty - d * tx) / det;
    this.ty = (b * tx - a * ty) / det;
  }
  rotate(angle: number): void {
    const cos = Math.cos(angle), sin = Math.sin(angle);
    const { a, b, c, d, tx, ty } = this;
    this.a = a * cos - b * sin;
    this.b = a * sin + b * cos;
    this.c = c * cos - d * sin;
    this.d = c * sin + d * cos;
    this.tx = tx * cos - ty * sin;
    this.ty = tx * sin + ty * cos;
  }
  scale(sx: number, sy: number): void {
    this.a *= sx; this.b *= sy; this.c *= sx; this.d *= sy; this.tx *= sx; this.ty *= sy;
  }
  translate(dx: number, dy: number): void { this.tx += n(dx); this.ty += n(dy); }
  setTo(a: number, b: number, c: number, d: number, tx: number, ty: number): void {
    this.a = a; this.b = b; this.c = c; this.d = d; this.tx = tx; this.ty = ty;
  }
  transformPoint(p: Point): Point {
    return new Point(this.a * p.x + this.c * p.y + this.tx, this.b * p.x + this.d * p.y + this.ty);
  }
  copyColumnFrom(col: number, v: Vector3D): void {
    if (col === 0) { this.a = v.x; this.b = v.y; } else if (col === 1) { this.c = v.x; this.d = v.y; } else { this.tx = v.x; this.ty = v.y; }
  }
  copyColumnTo(col: number, v: Vector3D): void {
    if (col === 0) { v.x = this.a; v.y = this.b; v.z = 0; } else if (col === 1) { v.x = this.c; v.y = this.d; v.z = 0; } else { v.x = this.tx; v.y = this.ty; v.z = 1; }
  }
  copyRowFrom(row: number, v: Vector3D): void {
    if (row === 0) { this.a = v.x; this.c = v.y; this.tx = v.z; } else if (row === 1) { this.b = v.x; this.d = v.y; this.ty = v.z; }
  }
  copyRowTo(row: number, v: Vector3D): void {
    if (row === 0) { v.x = this.a; v.y = this.c; v.z = this.tx; } else if (row === 1) { v.x = this.b; v.y = this.d; v.z = this.ty; } else { v.x = 0; v.y = 0; v.z = 1; }
  }
  toString(): string { return `(a=${this.a}, b=${this.b}, c=${this.c}, d=${this.d}, tx=${this.tx}, ty=${this.ty})`; }
}

export class ColorTransform {
  redMultiplier: number;
  greenMultiplier: number;
  blueMultiplier: number;
  alphaMultiplier: number;
  redOffset: number;
  greenOffset: number;
  blueOffset: number;
  alphaOffset: number;
  constructor(rM: unknown = 1, gM: unknown = 1, bM: unknown = 1, aM: unknown = 1, rO: unknown = 0, gO: unknown = 0, bO: unknown = 0, aO: unknown = 0) {
    initFields(this, new.target);
    this.redMultiplier = n(rM, 1);
    this.greenMultiplier = n(gM, 1);
    this.blueMultiplier = n(bM, 1);
    this.alphaMultiplier = n(aM, 1);
    this.redOffset = n(rO);
    this.greenOffset = n(gO);
    this.blueOffset = n(bO);
    this.alphaOffset = n(aO);
  }
  get color(): number { return ((this.redOffset << 16) | (this.greenOffset << 8) | this.blueOffset) >>> 0; }
  set color(v: number) {
    this.redMultiplier = this.greenMultiplier = this.blueMultiplier = 0;
    this.redOffset = (v >> 16) & 255;
    this.greenOffset = (v >> 8) & 255;
    this.blueOffset = v & 255;
  }
  concat(s: ColorTransform): void {
    this.redOffset += s.redOffset * this.redMultiplier;
    this.greenOffset += s.greenOffset * this.greenMultiplier;
    this.blueOffset += s.blueOffset * this.blueMultiplier;
    this.alphaOffset += s.alphaOffset * this.alphaMultiplier;
    this.redMultiplier *= s.redMultiplier;
    this.greenMultiplier *= s.greenMultiplier;
    this.blueMultiplier *= s.blueMultiplier;
    this.alphaMultiplier *= s.alphaMultiplier;
  }
  clone(): ColorTransform {
    return new ColorTransform(this.redMultiplier, this.greenMultiplier, this.blueMultiplier, this.alphaMultiplier,
      this.redOffset, this.greenOffset, this.blueOffset, this.alphaOffset);
  }
  toArray(): number[] {
    return [this.redMultiplier, this.greenMultiplier, this.blueMultiplier, this.alphaMultiplier,
      this.redOffset, this.greenOffset, this.blueOffset, this.alphaOffset];
  }
  static fromArray(a: number[] | undefined, alpha = 1): ColorTransform {
    if (!a) return new ColorTransform(1, 1, 1, alpha);
    return new ColorTransform(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
  }
  toString(): string {
    return `(redMultiplier=${this.redMultiplier}, greenMultiplier=${this.greenMultiplier}, blueMultiplier=${this.blueMultiplier}, alphaMultiplier=${this.alphaMultiplier}, redOffset=${this.redOffset}, greenOffset=${this.greenOffset}, blueOffset=${this.blueOffset}, alphaOffset=${this.alphaOffset})`;
  }
}

export class Vector3D {
  static readonly X_AXIS = new Vector3D(1, 0, 0);
  static readonly Y_AXIS = new Vector3D(0, 1, 0);
  static readonly Z_AXIS = new Vector3D(0, 0, 1);
  x: number; y: number; z: number; w: number;
  constructor(x: unknown = 0, y: unknown = 0, z: unknown = 0, w: unknown = 0) {
    initFields(this, new.target);
    this.x = n(x); this.y = n(y); this.z = n(z); this.w = n(w);
  }
  get length(): number { return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z); }
  get lengthSquared(): number { return this.x * this.x + this.y * this.y + this.z * this.z; }
  add(a: Vector3D): Vector3D { return new Vector3D(this.x + a.x, this.y + a.y, this.z + a.z); }
  subtract(a: Vector3D): Vector3D { return new Vector3D(this.x - a.x, this.y - a.y, this.z - a.z); }
  clone(): Vector3D { return new Vector3D(this.x, this.y, this.z, this.w); }
  crossProduct(a: Vector3D): Vector3D {
    return new Vector3D(this.y * a.z - this.z * a.y, this.z * a.x - this.x * a.z, this.x * a.y - this.y * a.x, 1);
  }
  dotProduct(a: Vector3D): number { return this.x * a.x + this.y * a.y + this.z * a.z; }
  normalize(): number {
    const l = this.length;
    if (l) { this.x /= l; this.y /= l; this.z /= l; }
    return l;
  }
  scaleBy(s: number): void { this.x *= s; this.y *= s; this.z *= s; }
  incrementBy(a: Vector3D): void { this.x += a.x; this.y += a.y; this.z += a.z; }
  decrementBy(a: Vector3D): void { this.x -= a.x; this.y -= a.y; this.z -= a.z; }
  negate(): void { this.x = -this.x; this.y = -this.y; this.z = -this.z; }
  project(): void { if (this.w) { this.x /= this.w; this.y /= this.w; this.z /= this.w; } }
  equals(a: Vector3D, all = false): boolean { return a.x === this.x && a.y === this.y && a.z === this.z && (!all || a.w === this.w); }
  nearEquals(a: Vector3D, tol: number, all = false): boolean {
    return Math.abs(a.x - this.x) < tol && Math.abs(a.y - this.y) < tol && Math.abs(a.z - this.z) < tol && (!all || Math.abs(a.w - this.w) < tol);
  }
  setTo(x: number, y: number, z: number): void { this.x = x; this.y = y; this.z = z; }
  copyFrom(a: Vector3D): void { this.x = a.x; this.y = a.y; this.z = a.z; }
  static distance(a: Vector3D, b: Vector3D): number { return a.subtract(b).length; }
  static angleBetween(a: Vector3D, b: Vector3D): number { return Math.acos(a.dotProduct(b) / (a.length * b.length)); }
  toString(): string { return `Vector3D(${this.x}, ${this.y}, ${this.z})`; }
}

export class Matrix3D {
  rawData: number[];
  constructor(v: ArrayLike<number> | null = null) {
    initFields(this, new.target);
    this.rawData = v && v.length === 16 ? Array.from(v) : [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
  }
  get determinant(): number {
    const m = this.rawData;
    return m[0] * (m[5] * m[10] - m[9] * m[6]) - m[4] * (m[1] * m[10] - m[9] * m[2]) + m[8] * (m[1] * m[6] - m[5] * m[2]);
  }
  get position(): Vector3D { return new Vector3D(this.rawData[12], this.rawData[13], this.rawData[14]); }
  set position(v: Vector3D) { this.rawData[12] = v.x; this.rawData[13] = v.y; this.rawData[14] = v.z; }
  identity(): void { this.rawData = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]; }
  clone(): Matrix3D { return new Matrix3D(this.rawData); }
  copyFrom(m: Matrix3D): void { this.rawData = m.rawData.slice(); }
  copyRawDataFrom(v: ArrayLike<number>, index = 0, transpose = false): void {
    for (let i = 0; i < 16; i++) this.rawData[i] = v[index + i];
    if (transpose) this.transpose();
  }
  copyRawDataTo(v: number[], index = 0, transpose = false): void {
    const src = transpose ? this.transposed() : this.rawData;
    for (let i = 0; i < 16; i++) v[index + i] = src[i];
  }
  private transposed(): number[] {
    const m = this.rawData, o: number[] = new Array(16);
    for (let r = 0; r < 4; r++) for (let c = 0; c < 4; c++) o[c * 4 + r] = m[r * 4 + c];
    return o;
  }
  transpose(): void { this.rawData = this.transposed(); }
  append(lhs: Matrix3D): void { this.rawData = mul4(lhs.rawData, this.rawData); }
  prepend(rhs: Matrix3D): void { this.rawData = mul4(this.rawData, rhs.rawData); }
  appendTranslation(x: number, y: number, z: number): void { this.rawData[12] += x; this.rawData[13] += y; this.rawData[14] += z; }
  appendScale(x: number, y: number, z: number): void { this.append(new Matrix3D([x, 0, 0, 0, 0, y, 0, 0, 0, 0, z, 0, 0, 0, 0, 1])); }
  appendRotation(deg: number, axis: Vector3D, _pivot: Vector3D | null = null): void { this.append(rotation3D(deg, axis)); }
  prependTranslation(x: number, y: number, z: number): void { this.prepend(new Matrix3D([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x, y, z, 1])); }
  prependScale(x: number, y: number, z: number): void { this.prepend(new Matrix3D([x, 0, 0, 0, 0, y, 0, 0, 0, 0, z, 0, 0, 0, 0, 1])); }
  prependRotation(deg: number, axis: Vector3D, _pivot: Vector3D | null = null): void { this.prepend(rotation3D(deg, axis)); }
  invert(): boolean {
    const inv = invert4(this.rawData);
    if (!inv) return false;
    this.rawData = inv;
    return true;
  }
  transformVector(v: Vector3D): Vector3D {
    const m = this.rawData;
    return new Vector3D(m[0] * v.x + m[4] * v.y + m[8] * v.z + m[12], m[1] * v.x + m[5] * v.y + m[9] * v.z + m[13],
      m[2] * v.x + m[6] * v.y + m[10] * v.z + m[14], m[3] * v.x + m[7] * v.y + m[11] * v.z + m[15]);
  }
  deltaTransformVector(v: Vector3D): Vector3D {
    const m = this.rawData;
    return new Vector3D(m[0] * v.x + m[4] * v.y + m[8] * v.z, m[1] * v.x + m[5] * v.y + m[9] * v.z, m[2] * v.x + m[6] * v.y + m[10] * v.z);
  }
  transformVectors(vin: ArrayLike<number>, vout: number[]): void {
    for (let i = 0; i + 2 < vin.length; i += 3) {
      const r = this.transformVector(new Vector3D(vin[i], vin[i + 1], vin[i + 2]));
      vout[i] = r.x; vout[i + 1] = r.y; vout[i + 2] = r.z;
    }
  }
  copyColumnTo(c: number, v: Vector3D): void { const m = this.rawData; v.x = m[c * 4]; v.y = m[c * 4 + 1]; v.z = m[c * 4 + 2]; v.w = m[c * 4 + 3]; }
  copyColumnFrom(c: number, v: Vector3D): void { const m = this.rawData; m[c * 4] = v.x; m[c * 4 + 1] = v.y; m[c * 4 + 2] = v.z; m[c * 4 + 3] = v.w; }
  copyRowTo(r: number, v: Vector3D): void { const m = this.rawData; v.x = m[r]; v.y = m[r + 4]; v.z = m[r + 8]; v.w = m[r + 12]; }
  copyRowFrom(r: number, v: Vector3D): void { const m = this.rawData; m[r] = v.x; m[r + 4] = v.y; m[r + 8] = v.z; m[r + 12] = v.w; }
  copyToMatrix3D(d: Matrix3D): void { d.rawData = this.rawData.slice(); }
  decompose(): Vector3D[] {
    const m = this.rawData;
    const sx = Math.hypot(m[0], m[1], m[2]), sy = Math.hypot(m[4], m[5], m[6]), sz = Math.hypot(m[8], m[9], m[10]);
    const rx = Math.atan2(m[6] / sy, m[10] / sz), ry = Math.asin(-m[2] / sx), rz = Math.atan2(m[1] / sx, m[0] / sx);
    return [new Vector3D(m[12], m[13], m[14]), new Vector3D(rx, ry, rz), new Vector3D(sx, sy, sz)];
  }
  recompose(c: Vector3D[]): boolean {
    this.identity();
    this.appendScale(c[2].x, c[2].y, c[2].z);
    this.appendRotation((c[1].x * 180) / Math.PI, Vector3D.X_AXIS);
    this.appendRotation((c[1].y * 180) / Math.PI, Vector3D.Y_AXIS);
    this.appendRotation((c[1].z * 180) / Math.PI, Vector3D.Z_AXIS);
    this.appendTranslation(c[0].x, c[0].y, c[0].z);
    return true;
  }
  pointAt(): void {}
  interpolateTo(to: Matrix3D, p: number): void { this.rawData = this.rawData.map((v, i) => v + (to.rawData[i] - v) * p); }
  static interpolate(a: Matrix3D, b: Matrix3D, p: number): Matrix3D { const m = a.clone(); m.interpolateTo(b, p); return m; }
}

function mul4(a: number[], b: number[]): number[] {
  const o = new Array(16).fill(0);
  for (let c = 0; c < 4; c++) for (let r = 0; r < 4; r++) {
    let s = 0;
    for (let k = 0; k < 4; k++) s += a[k * 4 + r] * b[c * 4 + k];
    o[c * 4 + r] = s;
  }
  return o;
}

function rotation3D(deg: number, axis: Vector3D): Matrix3D {
  const a = (deg * Math.PI) / 180;
  const v = axis.clone();
  v.normalize();
  const c = Math.cos(a), s = Math.sin(a), t = 1 - c;
  const { x, y, z } = v;
  return new Matrix3D([
    t * x * x + c, t * x * y + s * z, t * x * z - s * y, 0,
    t * x * y - s * z, t * y * y + c, t * y * z + s * x, 0,
    t * x * z + s * y, t * y * z - s * x, t * z * z + c, 0,
    0, 0, 0, 1,
  ]);
}

function invert4(m: number[]): number[] | null {
  const inv = new Array(16);
  inv[0] = m[5] * m[10] * m[15] - m[5] * m[11] * m[14] - m[9] * m[6] * m[15] + m[9] * m[7] * m[14] + m[13] * m[6] * m[11] - m[13] * m[7] * m[10];
  inv[4] = -m[4] * m[10] * m[15] + m[4] * m[11] * m[14] + m[8] * m[6] * m[15] - m[8] * m[7] * m[14] - m[12] * m[6] * m[11] + m[12] * m[7] * m[10];
  inv[8] = m[4] * m[9] * m[15] - m[4] * m[11] * m[13] - m[8] * m[5] * m[15] + m[8] * m[7] * m[13] + m[12] * m[5] * m[11] - m[12] * m[7] * m[9];
  inv[12] = -m[4] * m[9] * m[14] + m[4] * m[10] * m[13] + m[8] * m[5] * m[14] - m[8] * m[6] * m[13] - m[12] * m[5] * m[10] + m[12] * m[6] * m[9];
  inv[1] = -m[1] * m[10] * m[15] + m[1] * m[11] * m[14] + m[9] * m[2] * m[15] - m[9] * m[3] * m[14] - m[13] * m[2] * m[11] + m[13] * m[3] * m[10];
  inv[5] = m[0] * m[10] * m[15] - m[0] * m[11] * m[14] - m[8] * m[2] * m[15] + m[8] * m[3] * m[14] + m[12] * m[2] * m[11] - m[12] * m[3] * m[10];
  inv[9] = -m[0] * m[9] * m[15] + m[0] * m[11] * m[13] + m[8] * m[1] * m[15] - m[8] * m[3] * m[13] - m[12] * m[1] * m[11] + m[12] * m[3] * m[9];
  inv[13] = m[0] * m[9] * m[14] - m[0] * m[10] * m[13] - m[8] * m[1] * m[14] + m[8] * m[2] * m[13] + m[12] * m[1] * m[10] - m[12] * m[2] * m[9];
  inv[2] = m[1] * m[6] * m[15] - m[1] * m[7] * m[14] - m[5] * m[2] * m[15] + m[5] * m[3] * m[14] + m[13] * m[2] * m[7] - m[13] * m[3] * m[6];
  inv[6] = -m[0] * m[6] * m[15] + m[0] * m[7] * m[14] + m[4] * m[2] * m[15] - m[4] * m[3] * m[14] - m[12] * m[2] * m[7] + m[12] * m[3] * m[6];
  inv[10] = m[0] * m[5] * m[15] - m[0] * m[7] * m[13] - m[4] * m[1] * m[15] + m[4] * m[3] * m[13] + m[12] * m[1] * m[7] - m[12] * m[3] * m[5];
  inv[14] = -m[0] * m[5] * m[14] + m[0] * m[6] * m[13] + m[4] * m[1] * m[14] - m[4] * m[2] * m[13] - m[12] * m[1] * m[6] + m[12] * m[2] * m[5];
  inv[3] = -m[1] * m[6] * m[11] + m[1] * m[7] * m[10] + m[5] * m[2] * m[11] - m[5] * m[3] * m[10] - m[9] * m[2] * m[7] + m[9] * m[3] * m[6];
  inv[7] = m[0] * m[6] * m[11] - m[0] * m[7] * m[10] - m[4] * m[2] * m[11] + m[4] * m[3] * m[10] + m[8] * m[2] * m[7] - m[8] * m[3] * m[6];
  inv[11] = -m[0] * m[5] * m[11] + m[0] * m[7] * m[9] + m[4] * m[1] * m[11] - m[4] * m[3] * m[9] - m[8] * m[1] * m[7] + m[8] * m[3] * m[5];
  inv[15] = m[0] * m[5] * m[10] - m[0] * m[6] * m[9] - m[4] * m[1] * m[10] + m[4] * m[2] * m[9] + m[8] * m[1] * m[6] - m[8] * m[2] * m[5];
  let det = m[0] * inv[0] + m[1] * inv[4] + m[2] * inv[8] + m[3] * inv[12];
  if (det === 0) return null;
  det = 1 / det;
  return inv.map((v: number) => v * det);
}

export class PerspectiveProjection {
  fieldOfView = 55;
  focalLength = 480;
  projectionCenter = new Point(250, 200);
  toMatrix3D(): Matrix3D { return new Matrix3D(); }
}

export const Orientation3D = { AXIS_ANGLE: 'axisAngle', EULER_ANGLES: 'eulerAngles', QUATERNION: 'quaternion' } as const;
