import { initFields } from '../runtime';
import type { FlashFilterDef } from '@/flash/filters';

const num = (v: unknown, d: number) => (v === undefined || v === null || v === '' || Number.isNaN(Number(v)) ? d : Number(v));
const bool = (v: unknown, d = false) => (v === undefined || v === null ? d : v === true || v === 'true');

export const BitmapFilterQuality = { LOW: 1, MEDIUM: 2, HIGH: 3 } as const;
export const BitmapFilterType = { FULL: 'full', INNER: 'inner', OUTER: 'outer' } as const;
export const DisplacementMapFilterMode = { CLAMP: 'clamp', COLOR: 'color', IGNORE: 'ignore', WRAP: 'wrap' } as const;

export abstract class BitmapFilter {
  constructor() { initFields(this, new.target); }
  abstract get def(): FlashFilterDef;
  abstract clone(): BitmapFilter;
}

export class GlowFilter extends BitmapFilter {
  color: number; alpha: number; blurX: number; blurY: number; strength: number; quality: number; inner: boolean; knockout: boolean;
  constructor(color?: unknown, alpha?: unknown, blurX?: unknown, blurY?: unknown, strength?: unknown, quality?: unknown,
    inner?: unknown, knockout?: unknown) {
    super();
    this.color = num(color, 0xff0000) >>> 0 & 0xffffff;
    this.alpha = num(alpha, 1);
    this.blurX = num(blurX, 6);
    this.blurY = num(blurY, 6);
    this.strength = num(strength, 2);
    this.quality = num(quality, 1);
    this.inner = bool(inner);
    this.knockout = bool(knockout);
  }
  get def(): FlashFilterDef {
    return { type: 'glow', color: this.color, alpha: this.alpha, blurX: this.blurX, blurY: this.blurY, strength: this.strength,
      quality: this.quality, inner: this.inner, knockout: this.knockout };
  }
  clone(): GlowFilter {
    return new GlowFilter(this.color, this.alpha, this.blurX, this.blurY, this.strength, this.quality, this.inner, this.knockout);
  }
}

export class DropShadowFilter extends BitmapFilter {
  distance: number; angle: number; color: number; alpha: number; blurX: number; blurY: number; strength: number;
  quality: number; inner: boolean; knockout: boolean; hideObject: boolean;
  constructor(distance?: unknown, angle?: unknown, color?: unknown, alpha?: unknown, blurX?: unknown, blurY?: unknown,
    strength?: unknown, quality?: unknown, inner?: unknown, knockout?: unknown, hideObject?: unknown) {
    super();
    this.distance = num(distance, 4);
    this.angle = num(angle, 45);
    this.color = num(color, 0) >>> 0 & 0xffffff;
    this.alpha = num(alpha, 1);
    this.blurX = num(blurX, 4);
    this.blurY = num(blurY, 4);
    this.strength = num(strength, 1);
    this.quality = num(quality, 1);
    this.inner = bool(inner);
    this.knockout = bool(knockout);
    this.hideObject = bool(hideObject);
  }
  get def(): FlashFilterDef {
    return { type: 'dropShadow', distance: this.distance, angle: this.angle, color: this.color, alpha: this.alpha,
      blurX: this.blurX, blurY: this.blurY, strength: this.strength, quality: this.quality, inner: this.inner,
      knockout: this.knockout, hideObject: this.hideObject };
  }
  clone(): DropShadowFilter {
    return new DropShadowFilter(this.distance, this.angle, this.color, this.alpha, this.blurX, this.blurY, this.strength,
      this.quality, this.inner, this.knockout, this.hideObject);
  }
}

export class BlurFilter extends BitmapFilter {
  blurX: number; blurY: number; quality: number;
  constructor(blurX?: unknown, blurY?: unknown, quality?: unknown) {
    super();
    this.blurX = num(blurX, 4);
    this.blurY = num(blurY, 4);
    this.quality = num(quality, 1);
  }
  get def(): FlashFilterDef { return { type: 'blur', blurX: this.blurX, blurY: this.blurY, quality: this.quality }; }
  clone(): BlurFilter { return new BlurFilter(this.blurX, this.blurY, this.quality); }
}

const IDENTITY = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];

export class ColorMatrixFilter extends BitmapFilter {
  private __m: number[] = IDENTITY.slice();
  constructor(matrix?: unknown) {
    super();
    if (Array.isArray(matrix)) this.matrix = matrix;
  }
  get matrix(): number[] { return this.__m.slice(); }
  set matrix(v: number[]) {
    const m = IDENTITY.slice();
    if (Array.isArray(v)) for (let i = 0; i < 20; i++) m[i] = num(v[i], 0);
    this.__m = m;
  }
  get def(): FlashFilterDef { return { type: 'colorMatrix', matrix: this.__m.slice() }; }
  clone(): ColorMatrixFilter { return new ColorMatrixFilter(this.__m); }
}

export class BevelFilter extends BitmapFilter {
  distance: number; angle: number; highlightColor: number; highlightAlpha: number; shadowColor: number; shadowAlpha: number;
  blurX: number; blurY: number; strength: number; quality: number; type: string; knockout: boolean;
  constructor(distance?: unknown, angle?: unknown, highlightColor?: unknown, highlightAlpha?: unknown, shadowColor?: unknown,
    shadowAlpha?: unknown, blurX?: unknown, blurY?: unknown, strength?: unknown, quality?: unknown, type?: unknown, knockout?: unknown) {
    super();
    this.distance = num(distance, 4);
    this.angle = num(angle, 45);
    this.highlightColor = num(highlightColor, 0xffffff);
    this.highlightAlpha = num(highlightAlpha, 1);
    this.shadowColor = num(shadowColor, 0);
    this.shadowAlpha = num(shadowAlpha, 1);
    this.blurX = num(blurX, 4);
    this.blurY = num(blurY, 4);
    this.strength = num(strength, 1);
    this.quality = num(quality, 1);
    this.type = type ? String(type) : 'inner';
    this.knockout = bool(knockout);
  }
  get def(): FlashFilterDef { return { ...this, bevelType: this.type, type: 'bevel' } as unknown as FlashFilterDef; }
  clone(): BevelFilter {
    return new BevelFilter(this.distance, this.angle, this.highlightColor, this.highlightAlpha, this.shadowColor, this.shadowAlpha,
      this.blurX, this.blurY, this.strength, this.quality, this.type, this.knockout);
  }
}

export class GradientGlowFilter extends BitmapFilter {
  distance: number; angle: number; colors: number[]; alphas: number[]; ratios: number[]; blurX: number; blurY: number;
  strength: number; quality: number; type: string; knockout: boolean;
  constructor(distance?: unknown, angle?: unknown, colors?: unknown, alphas?: unknown, ratios?: unknown, blurX?: unknown,
    blurY?: unknown, strength?: unknown, quality?: unknown, type?: unknown, knockout?: unknown) {
    super();
    this.distance = num(distance, 4);
    this.angle = num(angle, 45);
    this.colors = Array.isArray(colors) ? colors.map(Number) : [];
    this.alphas = Array.isArray(alphas) ? alphas.map(Number) : [];
    this.ratios = Array.isArray(ratios) ? ratios.map(Number) : [];
    this.blurX = num(blurX, 4);
    this.blurY = num(blurY, 4);
    this.strength = num(strength, 1);
    this.quality = num(quality, 1);
    this.type = type ? String(type) : 'inner';
    this.knockout = bool(knockout);
  }
  get def(): FlashFilterDef {
    const i = Math.max(0, this.colors.length - 1);
    return { type: 'glow', color: this.colors[i] ?? 0xffffff, alpha: this.alphas[i] ?? 1, blurX: this.blurX, blurY: this.blurY,
      strength: this.strength, quality: this.quality, inner: this.type === 'inner', knockout: this.knockout };
  }
  clone(): GradientGlowFilter {
    return new GradientGlowFilter(this.distance, this.angle, this.colors, this.alphas, this.ratios, this.blurX, this.blurY,
      this.strength, this.quality, this.type, this.knockout);
  }
}

export class GradientBevelFilter extends GradientGlowFilter {
  override get def(): FlashFilterDef { return { ...this, bevelType: this.type, type: 'gradientBevel' } as unknown as FlashFilterDef; }
  override clone(): GradientBevelFilter {
    return new GradientBevelFilter(this.distance, this.angle, this.colors, this.alphas, this.ratios, this.blurX, this.blurY,
      this.strength, this.quality, this.type, this.knockout);
  }
}

export class ConvolutionFilter extends BitmapFilter {
  matrixX: number; matrixY: number; matrix: number[]; divisor: number; bias: number; preserveAlpha: boolean; clamp: boolean;
  color: number; alpha: number;
  constructor(matrixX?: unknown, matrixY?: unknown, matrix?: unknown, divisor?: unknown, bias?: unknown, preserveAlpha?: unknown,
    clamp?: unknown, color?: unknown, alpha?: unknown) {
    super();
    this.matrixX = num(matrixX, 0);
    this.matrixY = num(matrixY, 0);
    this.matrix = Array.isArray(matrix) ? matrix.map(Number) : [];
    this.divisor = num(divisor, 1);
    this.bias = num(bias, 0);
    this.preserveAlpha = bool(preserveAlpha, true);
    this.clamp = bool(clamp, true);
    this.color = num(color, 0);
    this.alpha = num(alpha, 0);
  }
  get def(): FlashFilterDef { return { type: 'convolution', ...this } as unknown as FlashFilterDef; }
  clone(): ConvolutionFilter {
    return new ConvolutionFilter(this.matrixX, this.matrixY, this.matrix, this.divisor, this.bias, this.preserveAlpha, this.clamp,
      this.color, this.alpha);
  }
}

export class DisplacementMapFilter extends BitmapFilter {
  mapBitmap: unknown; mapPoint: unknown; componentX: number; componentY: number; scaleX: number; scaleY: number;
  mode: string; color: number; alpha: number;
  constructor(mapBitmap: unknown = null, mapPoint: unknown = null, componentX?: unknown, componentY?: unknown, scaleX?: unknown,
    scaleY?: unknown, mode?: unknown, color?: unknown, alpha?: unknown) {
    super();
    this.mapBitmap = mapBitmap;
    this.mapPoint = mapPoint;
    this.componentX = num(componentX, 0);
    this.componentY = num(componentY, 0);
    this.scaleX = num(scaleX, 0);
    this.scaleY = num(scaleY, 0);
    this.mode = mode ? String(mode) : 'wrap';
    this.color = num(color, 0);
    this.alpha = num(alpha, 0);
  }
  get def(): FlashFilterDef { return { type: 'convolution' } as unknown as FlashFilterDef; }
  clone(): DisplacementMapFilter {
    return new DisplacementMapFilter(this.mapBitmap, this.mapPoint, this.componentX, this.componentY, this.scaleX, this.scaleY,
      this.mode, this.color, this.alpha);
  }
}

export class ShaderFilter extends BitmapFilter {
  shader: unknown;
  constructor(shader: unknown = null) { super(); this.shader = shader; }
  get def(): FlashFilterDef { return { type: 'convolution' } as unknown as FlashFilterDef; }
  clone(): ShaderFilter { return new ShaderFilter(this.shader); }
}

export function filterFromDef(d: FlashFilterDef): BitmapFilter | null {
  switch (d.type) {
    case 'glow': return new GlowFilter(d.color, d.alpha, d.blurX, d.blurY, d.strength, d.quality, d.inner, d.knockout);
    case 'dropShadow': return new DropShadowFilter(d.distance, d.angle, d.color, d.alpha, d.blurX, d.blurY, d.strength, d.quality,
      d.inner, d.knockout, d.hideObject);
    case 'blur': return new BlurFilter(d.blurX, d.blurY, d.quality);
    case 'colorMatrix': return new ColorMatrixFilter(d.matrix);
    default: return null;
  }
}
