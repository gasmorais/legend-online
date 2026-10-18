import { CanvasSource, Container, Matrix as PixiMatrix, Texture } from 'pixi.js';
import { initFields } from '@/as3/runtime';
import { ArgumentError } from '@/as3/flash/errors';
import { Point, Rectangle } from '@/as3/flash/geom';
import { ByteArray } from '@/as3/flash/bytearray';
import { FlashMode } from './mode';

type MatrixLike = { a: number; b: number; c: number; d: number; tx: number; ty: number };
type CxLike = { redMultiplier: number; greenMultiplier: number; blueMultiplier: number; alphaMultiplier: number;
  redOffset: number; greenOffset: number; blueOffset: number; alphaOffset: number };

function isThenable(v: unknown): v is Promise<Texture> { return !!v && typeof (v as any).then === 'function'; }

const clamp255 = (v: number) => (v < 0 ? 0 : v > 255 ? 255 : v | 0);

export class BitmapData {
  static symbolResolver: ((ctor: Function) => BitmapData | null) | null = null;

  ready!: Promise<Texture>;
  width = 0;
  height = 0;
  transparent = true;
  private _texture: Texture | null = null;
  private _canvas: HTMLCanvasElement | null = null;
  private _ctx: CanvasRenderingContext2D | null = null;
  private _canvasTex: Texture | null = null;
  private _img: ImageData | null = null;
  private _imgDirty = false;
  private _flushQueued = false;
  private _locked = false;
  private _disposed = false;
  private _observers = new Set<() => void>();

  constructor(a0?: unknown, a1?: unknown, a2?: unknown, a3?: unknown) {
    initFields(this, new.target);
    if (a0 instanceof Texture || isThenable(a0)) {
      this.adoptTexture(a0, Number(a1) || 0, Number(a2) || 0);
      return;
    }
    const sym = new.target !== BitmapData ? BitmapData.symbolResolver?.(new.target) : null;
    if (sym) {
      this.width = sym.width;
      this.height = sym.height;
      this.adoptTexture(sym._texture ?? sym.ready, sym.width, sym.height);
      return;
    }
    const w = Number(a0) | 0, h = Number(a1) | 0;
    if (w <= 0 || h <= 0 || w > 16384 || h > 16384) throw new ArgumentError('Error #2015: Invalid BitmapData.', 2015);
    this.width = w;
    this.height = h;
    this.transparent = a2 !== false;
    const fill = a3 === undefined || a3 === null ? 0xffffffff : Number(a3) >>> 0;
    this.ready = Promise.resolve(Texture.EMPTY);
    this.makeCanvas();
    this.fillRaw(0, 0, w, h, fill);
    this.ready = Promise.resolve(this._canvasTex!);
  }

  private adoptTexture(t: Texture | Promise<Texture>, w: number, h: number): void {
    if (t instanceof Texture) {
      this._texture = t;
      this.width = w || t.width;
      this.height = h || t.height;
      this.ready = Promise.resolve(t);
    } else {
      this._texture = null;
      this.width = w;
      this.height = h;
      this.ready = t.then((tex) => {
        this._texture = tex;
        if (!this.width) this.width = tex.width;
        if (!this.height) this.height = tex.height;
        if (this._canvas) { this.drawLibraryUnder(tex); }
        return this._canvasTex ?? tex;
      });
    }
  }

  get texture(): Texture { return this._canvasTex ?? this._texture ?? Texture.EMPTY; }
  get loaded(): boolean { return this._canvas !== null || this._texture !== null; }
  get rect(): Rectangle { return new Rectangle(0, 0, this.width, this.height); }

  onChange(fn: () => void): () => void { this._observers.add(fn); return () => this._observers.delete(fn); }
  private notify(): void { for (const f of [...this._observers]) f(); }

  private makeCanvas(): void {
    const c = document.createElement('canvas');
    c.width = Math.max(1, this.width);
    c.height = Math.max(1, this.height);
    this._canvas = c;
    this._ctx = c.getContext('2d', { willReadFrequently: true })!;
    this._ctx.imageSmoothingEnabled = true;
    this._canvasTex = new Texture({ source: new CanvasSource({ resource: c }) });
  }

  canvas(): HTMLCanvasElement {
    if (this._disposed) throw new ArgumentError('Error #2015: Invalid BitmapData.', 2015);
    if (!this._canvas) {
      this.makeCanvas();
      if (this._texture) this.drawTexture(this._ctx!, this._texture, 0, 0);
      this.ready = Promise.resolve(this._canvasTex!);
      this.notify();
    }
    this.flushImg();
    return this._canvas!;
  }
  private ctx(): CanvasRenderingContext2D { this.canvas(); this._img = null; return this._ctx!; }

  private drawLibraryUnder(tex: Texture): void {
    const ctx = this.ctx();
    ctx.save();
    ctx.globalCompositeOperation = 'destination-over';
    this.drawTexture(ctx, tex, 0, 0);
    ctx.restore();
    this.changed();
  }

  private drawTexture(ctx: CanvasRenderingContext2D, tex: Texture, dx: number, dy: number, sr?: Rectangle): void {
    const src = BitmapData.imageOf(tex);
    if (!src) return;
    const res = tex.source.resolution || 1;
    const f = tex.frame;
    const sx = sr ? sr.x : 0, sy = sr ? sr.y : 0;
    const sw = sr ? sr.width : f.width, sh = sr ? sr.height : f.height;
    ctx.drawImage(src, (f.x + sx) * res, (f.y + sy) * res, sw * res, sh * res, dx, dy, sw, sh);
  }

  static imageOf(tex: Texture): CanvasImageSource | null {
    const r: any = tex.source?.resource;
    if (r && (r instanceof HTMLImageElement || r instanceof HTMLCanvasElement || r instanceof ImageBitmap
      || (typeof OffscreenCanvas !== 'undefined' && r instanceof OffscreenCanvas) || r instanceof HTMLVideoElement)) return r;
    const renderer = FlashMode.renderer;
    if (renderer && tex !== Texture.EMPTY) {
      try { return renderer.extract.canvas(tex) as HTMLCanvasElement; } catch { return null; }
    }
    return null;
  }

  private sourceImage(): { img: CanvasImageSource; scale: number; ox: number; oy: number } | null {
    if (this._canvas) { this.flushImg(); return { img: this._canvas, scale: 1, ox: 0, oy: 0 }; }
    const tex = this._texture;
    if (!tex) return null;
    const img = BitmapData.imageOf(tex);
    if (!img) return null;
    const res = tex.source.resolution || 1;
    return { img, scale: res, ox: tex.frame.x, oy: tex.frame.y };
  }

  private changed(): void {
    if (this._canvasTex) this._canvasTex.source.update();
  }

  private pixels(): ImageData {
    this.canvas();
    if (!this._img) this._img = this._ctx!.getImageData(0, 0, this.width, this.height);
    return this._img;
  }
  private pixelsChanged(): void {
    this._imgDirty = true;
    if (!this._locked && !this._flushQueued) {
      this._flushQueued = true;
      queueMicrotask(() => { this._flushQueued = false; this.flushImg(); });
    }
  }
  private flushImg(): void {
    if (this._imgDirty && this._img && this._ctx) {
      this._ctx.putImageData(this._img, 0, 0);
      this._imgDirty = false;
      this.changed();
    }
  }

  private fillRaw(x: number, y: number, w: number, h: number, argb: number): void {
    const ctx = this._ctx!;
    const a = this.transparent ? ((argb >>> 24) & 255) / 255 : 1;
    ctx.clearRect(x, y, w, h);
    if (a > 0) {
      ctx.fillStyle = `rgba(${(argb >> 16) & 255},${(argb >> 8) & 255},${argb & 255},${a})`;
      ctx.fillRect(x, y, w, h);
    }
    this._img = null;
    this.changed();
  }

  getPixel(x: number, y: number): number { return this.getPixel32(x, y) & 0xffffff; }
  getPixel32(x: number, y: number): number {
    x |= 0; y |= 0;
    if (x < 0 || y < 0 || x >= this.width || y >= this.height || !this.loaded) return 0;
    const d = this.pixels().data, i = (y * this.width + x) * 4;
    return ((d[i + 3] << 24) | (d[i] << 16) | (d[i + 1] << 8) | d[i + 2]) >>> 0;
  }
  setPixel(x: number, y: number, rgb: number): void {
    x |= 0; y |= 0;
    if (x < 0 || y < 0 || x >= this.width || y >= this.height) return;
    const d = this.pixels().data, i = (y * this.width + x) * 4;
    d[i] = (rgb >> 16) & 255; d[i + 1] = (rgb >> 8) & 255; d[i + 2] = rgb & 255;
    if (!this.transparent) d[i + 3] = 255;
    this.pixelsChanged();
  }
  setPixel32(x: number, y: number, argb: number): void {
    x |= 0; y |= 0;
    if (x < 0 || y < 0 || x >= this.width || y >= this.height) return;
    const d = this.pixels().data, i = (y * this.width + x) * 4;
    d[i] = (argb >> 16) & 255; d[i + 1] = (argb >> 8) & 255; d[i + 2] = argb & 255;
    d[i + 3] = this.transparent ? (argb >>> 24) & 255 : 255;
    this.pixelsChanged();
  }
  fillRect(rect: Rectangle, color: number): void {
    this.canvas();
    this.fillRaw(rect.x, rect.y, rect.width, rect.height, Number(color) >>> 0);
  }
  floodFill(x: number, y: number, color: number): void {
    const img = this.pixels(), d = img.data, w = this.width, h = this.height;
    x |= 0; y |= 0;
    if (x < 0 || y < 0 || x >= w || y >= h) return;
    const target = this.getPixel32(x, y);
    const c = this.transparent ? color >>> 0 : (color | 0xff000000) >>> 0;
    if (target === c) return;
    const stack = [x, y];
    while (stack.length) {
      const py = stack.pop()!, px = stack.pop()!;
      if (px < 0 || py < 0 || px >= w || py >= h) continue;
      const i = (py * w + px) * 4;
      const cur = ((d[i + 3] << 24) | (d[i] << 16) | (d[i + 1] << 8) | d[i + 2]) >>> 0;
      if (cur !== target) continue;
      d[i] = (c >> 16) & 255; d[i + 1] = (c >> 8) & 255; d[i + 2] = c & 255; d[i + 3] = c >>> 24;
      stack.push(px + 1, py, px - 1, py, px, py + 1, px, py - 1);
    }
    this.pixelsChanged();
  }

  copyPixels(src: BitmapData, srcRect: Rectangle, destPoint: Point, alphaBitmapData: BitmapData | null = null,
    alphaPoint: Point | null = null, mergeAlpha = false): void {
    if (!src) return;
    void alphaBitmapData; void alphaPoint;
    if (!src.loaded) {
      const r = srcRect.clone(), p = new Point(destPoint.x, destPoint.y);
      src.ready.then(() => { if (!this._disposed) this.copyPixels(src, r, p, null, null, mergeAlpha); });
      return;
    }
    const s = src.sourceImage();
    if (!s) return;
    const ctx = this.ctx();
    const sx = Math.max(0, srcRect.x), sy = Math.max(0, srcRect.y);
    const w = Math.min(srcRect.width - (sx - srcRect.x), src.width - sx);
    const h = Math.min(srcRect.height - (sy - srcRect.y), src.height - sy);
    if (w <= 0 || h <= 0) return;
    const dx = destPoint.x + (sx - srcRect.x), dy = destPoint.y + (sy - srcRect.y);
    ctx.save();
    if (!mergeAlpha || !this.transparent) ctx.clearRect(dx, dy, w, h);
    ctx.drawImage(s.img, (s.ox + sx) * s.scale, (s.oy + sy) * s.scale, w * s.scale, h * s.scale, dx, dy, w, h);
    ctx.restore();
    this.changed();
  }

  draw(source: unknown, matrix: MatrixLike | null = null, colorTransform: CxLike | null = null, blendMode: string | null = null,
    clipRect: Rectangle | null = null, _smoothing = false): void {
    let img: CanvasImageSource | null = null;
    let ox = 0, oy = 0, sw = 0, sh = 0, scale = 1;
    if (source instanceof BitmapData) {
      if (!source.loaded) {
        source.ready.then(() => { if (!this._disposed) this.draw(source, matrix, colorTransform, blendMode, clipRect); });
        return;
      }
      const s = source.sourceImage();
      if (!s) return;
      img = s.img; scale = s.scale;
      sw = source.width; sh = source.height;
      ox = s.ox; oy = s.oy;
      ctxDraw(this, img, ox * scale, oy * scale, sw * scale, sh * scale, 0, 0, sw, sh, matrix, colorTransform, blendMode, clipRect);
      return;
    }
    if (source instanceof Container) {
      const renderer = FlashMode.renderer;
      if (!renderer) return;
      const b = source.getLocalBounds();
      if (b.width <= 0 || b.height <= 0) return;
      let canvas: HTMLCanvasElement;
      try {
        canvas = renderer.extract.canvas({ target: source, frame: undefined, resolution: 1, antialias: true }) as HTMLCanvasElement;
      } catch { return; }
      ctxDraw(this, canvas, 0, 0, canvas.width, canvas.height, b.x, b.y, b.width, b.height, matrix, colorTransform, blendMode, clipRect);
    }
  }
  drawWithQuality(source: unknown, matrix: MatrixLike | null = null, ct: CxLike | null = null, bm: string | null = null,
    clip: Rectangle | null = null, smoothing = false, _q: string | null = null): void { this.draw(source, matrix, ct, bm, clip, smoothing); }

  colorTransform(rect: Rectangle, ct: CxLike): void {
    const img = this.pixels(), d = img.data, w = this.width;
    const x0 = Math.max(0, rect.x | 0), y0 = Math.max(0, rect.y | 0);
    const x1 = Math.min(this.width, (rect.x + rect.width) | 0), y1 = Math.min(this.height, (rect.y + rect.height) | 0);
    for (let y = y0; y < y1; y++) for (let x = x0; x < x1; x++) {
      const i = (y * w + x) * 4;
      d[i] = clamp255(d[i] * ct.redMultiplier + ct.redOffset);
      d[i + 1] = clamp255(d[i + 1] * ct.greenMultiplier + ct.greenOffset);
      d[i + 2] = clamp255(d[i + 2] * ct.blueMultiplier + ct.blueOffset);
      if (this.transparent) d[i + 3] = clamp255(d[i + 3] * ct.alphaMultiplier + ct.alphaOffset);
    }
    this.pixelsChanged();
  }

  applyFilter(src: BitmapData, srcRect: Rectangle, destPoint: Point, filter: any): void {
    const def = filter?.def ?? filter;
    if (def?.type === 'blur') {
      const s = src.sourceImage();
      if (!s) return;
      const ctx = this.ctx();
      ctx.save();
      ctx.clearRect(destPoint.x, destPoint.y, srcRect.width, srcRect.height);
      ctx.filter = `blur(${Math.max(def.blurX, def.blurY) / 2}px)`;
      ctx.drawImage(s.img, (s.ox + srcRect.x) * s.scale, (s.oy + srcRect.y) * s.scale, srcRect.width * s.scale,
        srcRect.height * s.scale, destPoint.x, destPoint.y, srcRect.width, srcRect.height);
      ctx.restore();
      this.changed();
      return;
    }
    if (src !== this) this.copyPixels(src, srcRect, destPoint);
    if (def?.type === 'colorMatrix') {
      const m: number[] = def.matrix;
      const img = this.pixels(), d = img.data, w = this.width;
      const x0 = Math.max(0, destPoint.x | 0), y0 = Math.max(0, destPoint.y | 0);
      const x1 = Math.min(this.width, x0 + srcRect.width), y1 = Math.min(this.height, y0 + srcRect.height);
      for (let y = y0; y < y1; y++) for (let x = x0; x < x1; x++) {
        const i = (y * w + x) * 4;
        const r = d[i], g = d[i + 1], b = d[i + 2], a = d[i + 3];
        d[i] = clamp255(m[0] * r + m[1] * g + m[2] * b + m[3] * a + m[4]);
        d[i + 1] = clamp255(m[5] * r + m[6] * g + m[7] * b + m[8] * a + m[9]);
        d[i + 2] = clamp255(m[10] * r + m[11] * g + m[12] * b + m[13] * a + m[14]);
        d[i + 3] = clamp255(m[15] * r + m[16] * g + m[17] * b + m[18] * a + m[19]);
      }
      this.pixelsChanged();
    }
  }
  generateFilterRect(sourceRect: Rectangle, filter: any): Rectangle {
    const def = filter?.def ?? filter;
    const bx = Number(def?.blurX ?? 0), by = Number(def?.blurY ?? 0), dist = Number(def?.distance ?? 0);
    const r = sourceRect.clone();
    r.inflate(bx + Math.abs(dist), by + Math.abs(dist));
    return r;
  }

  copyChannel(src: BitmapData, srcRect: Rectangle, destPoint: Point, srcChannel: number, destChannel: number): void {
    const ch = (c: number) => (c === 1 ? 0 : c === 2 ? 1 : c === 4 ? 2 : 3);
    const s = src.pixels().data, d = this.pixels().data;
    const sc = ch(srcChannel), dc = ch(destChannel);
    for (let y = 0; y < srcRect.height; y++) for (let x = 0; x < srcRect.width; x++) {
      const sx = srcRect.x + x, sy = srcRect.y + y, dx = destPoint.x + x, dy = destPoint.y + y;
      if (sx < 0 || sy < 0 || sx >= src.width || sy >= src.height || dx < 0 || dy < 0 || dx >= this.width || dy >= this.height) continue;
      d[(dy * this.width + dx) * 4 + dc] = s[(sy * src.width + sx) * 4 + sc];
    }
    this.pixelsChanged();
  }

  merge(src: BitmapData, srcRect: Rectangle, destPoint: Point, rM: number, gM: number, bM: number, aM: number): void {
    const s = src.pixels().data, d = this.pixels().data;
    const mul = [rM, gM, bM, aM];
    for (let y = 0; y < srcRect.height; y++) for (let x = 0; x < srcRect.width; x++) {
      const sx = srcRect.x + x, sy = srcRect.y + y, dx = destPoint.x + x, dy = destPoint.y + y;
      if (sx < 0 || sy < 0 || sx >= src.width || sy >= src.height || dx < 0 || dy < 0 || dx >= this.width || dy >= this.height) continue;
      const si = (sy * src.width + sx) * 4, di = (dy * this.width + dx) * 4;
      for (let c = 0; c < 4; c++) d[di + c] = clamp255((s[si + c] * mul[c] + d[di + c] * (256 - mul[c])) / 256);
    }
    this.pixelsChanged();
  }

  threshold(src: BitmapData, srcRect: Rectangle, destPoint: Point, operation: string, threshold: number, color = 0,
    mask = 0xffffffff, copySource = false): number {
    const s = src.pixels().data, d = this.pixels().data;
    const th = (threshold & mask) >>> 0;
    let count = 0;
    const test = (v: number): boolean => {
      switch (operation) {
        case '<': return v < th; case '<=': return v <= th; case '>': return v > th; case '>=': return v >= th;
        case '==': return v === th; case '!=': return v !== th; default: return false;
      }
    };
    for (let y = 0; y < srcRect.height; y++) for (let x = 0; x < srcRect.width; x++) {
      const sx = srcRect.x + x, sy = srcRect.y + y, dx = destPoint.x + x, dy = destPoint.y + y;
      if (sx < 0 || sy < 0 || sx >= src.width || sy >= src.height || dx < 0 || dy < 0 || dx >= this.width || dy >= this.height) continue;
      const si = (sy * src.width + sx) * 4, di = (dy * this.width + dx) * 4;
      const v = (((s[si + 3] << 24) | (s[si] << 16) | (s[si + 1] << 8) | s[si + 2]) & mask) >>> 0;
      if (test(v)) {
        count++;
        d[di] = (color >> 16) & 255; d[di + 1] = (color >> 8) & 255; d[di + 2] = color & 255; d[di + 3] = color >>> 24;
      } else if (copySource) {
        d[di] = s[si]; d[di + 1] = s[si + 1]; d[di + 2] = s[si + 2]; d[di + 3] = s[si + 3];
      }
    }
    this.pixelsChanged();
    return count;
  }

  getColorBoundsRect(mask: number, color: number, findColor = true): Rectangle {
    const d = this.pixels().data;
    let x0 = Infinity, y0 = Infinity, x1 = -1, y1 = -1;
    for (let y = 0; y < this.height; y++) for (let x = 0; x < this.width; x++) {
      const i = (y * this.width + x) * 4;
      const v = (((d[i + 3] << 24) | (d[i] << 16) | (d[i + 1] << 8) | d[i + 2]) & mask) >>> 0;
      if ((v === ((color & mask) >>> 0)) === findColor) {
        if (x < x0) x0 = x; if (y < y0) y0 = y; if (x > x1) x1 = x; if (y > y1) y1 = y;
      }
    }
    return x1 < 0 ? new Rectangle() : new Rectangle(x0, y0, x1 - x0 + 1, y1 - y0 + 1);
  }

  getPixels(rect: Rectangle): ByteArray {
    const ba = new ByteArray();
    this.copyPixelsToByteArray(rect, ba);
    ba.position = 0;
    return ba;
  }
  copyPixelsToByteArray(rect: Rectangle, data: ByteArray): void {
    for (let y = rect.y; y < rect.y + rect.height; y++) for (let x = rect.x; x < rect.x + rect.width; x++) data.writeUnsignedInt(this.getPixel32(x, y));
  }
  setPixels(rect: Rectangle, input: ByteArray): void {
    for (let y = rect.y; y < rect.y + rect.height; y++) for (let x = rect.x; x < rect.x + rect.width; x++) {
      if (input.bytesAvailable < 4) return;
      this.setPixel32(x, y, input.readUnsignedInt());
    }
  }
  getVector(rect: Rectangle): number[] {
    const out: number[] = [];
    for (let y = rect.y; y < rect.y + rect.height; y++) for (let x = rect.x; x < rect.x + rect.width; x++) out.push(this.getPixel32(x, y));
    return out;
  }
  setVector(rect: Rectangle, v: ArrayLike<number>): void {
    let k = 0;
    for (let y = rect.y; y < rect.y + rect.height; y++) for (let x = rect.x; x < rect.x + rect.width; x++) this.setPixel32(x, y, v[k++]);
  }
  histogram(rect: Rectangle | null = null): number[][] {
    const r = rect ?? this.rect;
    const h = [0, 1, 2, 3].map(() => new Array(256).fill(0));
    const d = this.pixels().data;
    for (let y = r.y; y < r.y + r.height; y++) for (let x = r.x; x < r.x + r.width; x++) {
      const i = (y * this.width + x) * 4;
      h[0][d[i]]++; h[1][d[i + 1]]++; h[2][d[i + 2]]++; h[3][d[i + 3]]++;
    }
    return h;
  }

  hitTest(firstPoint: Point, firstAlphaThreshold: number, secondObject: any, secondPoint: Point | null = null,
    secondAlphaThreshold = 1): boolean {
    const alphaAt = (x: number, y: number) => this.getPixel32(x - firstPoint.x, y - firstPoint.y) >>> 24;
    if (secondObject instanceof Point) return alphaAt(secondObject.x, secondObject.y) >= firstAlphaThreshold;
    if (secondObject instanceof Rectangle) {
      for (let y = secondObject.y; y < secondObject.bottom; y++) for (let x = secondObject.x; x < secondObject.right; x++) {
        if (alphaAt(x, y) >= firstAlphaThreshold) return true;
      }
      return false;
    }
    if (secondObject instanceof BitmapData && secondPoint) {
      const r = new Rectangle(firstPoint.x, firstPoint.y, this.width, this.height)
        .intersection(new Rectangle(secondPoint.x, secondPoint.y, secondObject.width, secondObject.height));
      for (let y = r.y; y < r.bottom; y++) for (let x = r.x; x < r.right; x++) {
        if (alphaAt(x, y) >= firstAlphaThreshold
          && (secondObject.getPixel32(x - secondPoint.x, y - secondPoint.y) >>> 24) >= secondAlphaThreshold) return true;
      }
    }
    return false;
  }

  scroll(x: number, y: number): void {
    const c = this.canvas();
    const tmp = document.createElement('canvas');
    tmp.width = c.width; tmp.height = c.height;
    tmp.getContext('2d')!.drawImage(c, 0, 0);
    const ctx = this.ctx();
    ctx.drawImage(tmp, x, y);
    this.changed();
  }

  noise(randomSeed: number, low = 0, high = 255, channelOptions = 7, grayScale = false): void {
    let seed = (randomSeed >>> 0) || 1;
    const rnd = () => { seed = (seed * 16807) % 2147483647; return seed / 2147483647; };
    const d = this.pixels().data;
    for (let i = 0; i < d.length; i += 4) {
      const g = low + rnd() * (high - low);
      d[i] = channelOptions & 1 || grayScale ? (grayScale ? g : low + rnd() * (high - low)) : 0;
      d[i + 1] = channelOptions & 2 || grayScale ? (grayScale ? g : low + rnd() * (high - low)) : 0;
      d[i + 2] = channelOptions & 4 || grayScale ? (grayScale ? g : low + rnd() * (high - low)) : 0;
      d[i + 3] = channelOptions & 8 ? low + rnd() * (high - low) : 255;
    }
    this.pixelsChanged();
  }
  perlinNoise(baseX: number, baseY: number, _octaves: number, randomSeed: number, _stitch: boolean, _fractal: boolean,
    channelOptions = 7, grayScale = false): void {
    this.noise(randomSeed, 0, 255, channelOptions, grayScale);
    const ctx = this.ctx();
    ctx.save();
    ctx.filter = `blur(${Math.max(1, Math.min(baseX, baseY) / 4)}px)`;
    ctx.drawImage(this._canvas!, 0, 0);
    ctx.restore();
    this.changed();
  }
  paletteMap(src: BitmapData, srcRect: Rectangle, destPoint: Point, r: number[] | null = null, g: number[] | null = null,
    b: number[] | null = null, a: number[] | null = null): void {
    const s = src.pixels().data, d = this.pixels().data;
    for (let y = 0; y < srcRect.height; y++) for (let x = 0; x < srcRect.width; x++) {
      const sx = srcRect.x + x, sy = srcRect.y + y, dx = destPoint.x + x, dy = destPoint.y + y;
      if (sx < 0 || sy < 0 || sx >= src.width || sy >= src.height || dx < 0 || dy < 0 || dx >= this.width || dy >= this.height) continue;
      const si = (sy * src.width + sx) * 4, di = (dy * this.width + dx) * 4;
      const v = (r ? r[s[si]] : s[si] << 16) + (g ? g[s[si + 1]] : s[si + 1] << 8) + (b ? b[s[si + 2]] : s[si + 2])
        + (a ? a[s[si + 3]] : s[si + 3] * 0x1000000);
      d[di] = (v >> 16) & 255; d[di + 1] = (v >> 8) & 255; d[di + 2] = v & 255; d[di + 3] = (v >>> 24) & 255;
    }
    this.pixelsChanged();
  }
  compare(other: BitmapData): unknown {
    if (other === this) return 0;
    if (other.width !== this.width) return -3;
    if (other.height !== this.height) return -4;
    const a = this.pixels().data, b = other.pixels().data;
    for (let i = 0; i < a.length; i++) if (a[i] !== b[i]) return new BitmapData(this.width, this.height, true, 0);
    return 0;
  }
  encode(): ByteArray | null { return null; }

  lock(): void { this._locked = true; }
  unlock(_changeRect: Rectangle | null = null): void { this._locked = false; this.flushImg(); }

  clone(): BitmapData {
    if (!this._canvas) {
      const b = new BitmapData(this._texture ?? this.ready, this.width, this.height);
      b.transparent = this.transparent;
      return b;
    }
    const b = new BitmapData(this.width, this.height, this.transparent, 0);
    b.ctx().drawImage(this.canvas(), 0, 0);
    b.changed();
    return b;
  }

  dispose(): void {
    if (this._disposed) return;
    this._disposed = true;
    const tex = this._canvasTex;
    this._canvasTex = null;
    this._canvas = null;
    this._ctx = null;
    this._img = null;
    if (tex) {
      this._texture = null;
      this.notify();
      tex.destroy(true);
    }
  }
}

function ctxDraw(bd: BitmapData, img: CanvasImageSource, sx: number, sy: number, sw: number, sh: number,
  dx: number, dy: number, dw: number, dh: number, m: MatrixLike | null, ct: CxLike | null, blend: string | null,
  clip: Rectangle | null): void {
  const ctx = (bd as any).ctx() as CanvasRenderingContext2D;
  ctx.save();
  if (clip) { ctx.beginPath(); ctx.rect(clip.x, clip.y, clip.width, clip.height); ctx.clip(); }
  if (m) ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
  const ops: Record<string, GlobalCompositeOperation> = {
    multiply: 'multiply', screen: 'screen', lighten: 'lighten', darken: 'darken', difference: 'difference',
    add: 'lighter', overlay: 'overlay', hardlight: 'hard-light', erase: 'destination-out', alpha: 'destination-in',
  };
  if (blend && ops[blend]) ctx.globalCompositeOperation = ops[blend];
  if (ct && ct.alphaMultiplier !== 1) ctx.globalAlpha = Math.max(0, Math.min(1, ct.alphaMultiplier));
  ctx.drawImage(img, sx, sy, sw, sh, dx, dy, dw, dh);
  ctx.restore();
  if (ct && (ct.redMultiplier !== 1 || ct.greenMultiplier !== 1 || ct.blueMultiplier !== 1 || ct.redOffset || ct.greenOffset || ct.blueOffset)) {
    const tm = m ? new PixiMatrix(m.a, m.b, m.c, m.d, m.tx, m.ty) : new PixiMatrix();
    const p0 = tm.apply({ x: dx, y: dy }), p1 = tm.apply({ x: dx + dw, y: dy + dh });
    const r = new Rectangle(Math.min(p0.x, p1.x), Math.min(p0.y, p1.y), Math.abs(p1.x - p0.x), Math.abs(p1.y - p0.y));
    bd.colorTransform(r, { ...ct, alphaMultiplier: 1, alphaOffset: 0 });
  }
  (bd as any).changed();
}
