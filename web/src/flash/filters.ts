import {
  BlurFilter,
  ColorMatrixFilter,
  defaultFilterVert,
  Filter,
  FilterSystem,
  GlProgram,
  RenderSurface,
  Texture,
  TexturePool,
  UniformGroup,
} from 'pixi.js';

export type FlashFilterDef =
  | { type: 'glow'; color: number; alpha: number; blurX: number; blurY: number; strength: number;
      quality: number; inner: boolean; knockout: boolean }
  | { type: 'dropShadow'; color: number; alpha: number; blurX: number; blurY: number; strength: number;
      quality: number; inner: boolean; knockout: boolean; angle: number; distance: number; hideObject: boolean }
  | { type: 'blur'; blurX: number; blurY: number; quality: number }
  | { type: 'colorMatrix'; matrix: number[] }
  | { type: 'bevel' | 'gradientGlow' | 'gradientBevel' | 'convolution'; [k: string]: unknown };

const colorizeFrag = `
in vec2 vTextureCoord;
out vec4 finalColor;
uniform sampler2D uTexture;
uniform vec4 uColor;
void main(void) {
  float a = texture(uTexture, vTextureCoord).a;
  finalColor = vec4(uColor.rgb * a, a);
}`;

const compositeFrag = `
in vec2 vTextureCoord;
out vec4 finalColor;
uniform sampler2D uTexture;
uniform sampler2D uGlowTexture;
uniform vec4 uColor;
uniform highp vec4 uInputSize;
uniform highp vec4 uInputClamp;
uniform vec2 uOffset;
uniform float uStrength;
uniform float uAlpha;
uniform float uInner;
uniform float uKnockout;
uniform float uHide;
void main(void) {
  vec4 src = texture(uTexture, vTextureCoord);
  vec2 uv = clamp(vTextureCoord - uOffset * uInputSize.zw, uInputClamp.xy, uInputClamp.zw);
  float blurA = texture(uGlowTexture, uv).a;
  if (uInner > 0.5) {
    float g = clamp((1.0 - blurA) * uStrength, 0.0, 1.0) * uAlpha * src.a;
    if (uKnockout > 0.5) {
      finalColor = vec4(uColor.rgb * g, g);
    } else {
      vec3 rgb = src.rgb * (1.0 - g) + uColor.rgb * g;
      finalColor = vec4(rgb, src.a);
    }
  } else {
    float g = clamp(blurA * uStrength, 0.0, 1.0) * uAlpha;
    vec4 glow = vec4(uColor.rgb * g, g);
    if (uKnockout > 0.5) {
      finalColor = glow * (1.0 - src.a);
    } else if (uHide > 0.5) {
      finalColor = glow;
    } else {
      finalColor = src + glow * (1.0 - src.a);
    }
  }
}`;

function rgb(color: number): [number, number, number] {
  return [((color >> 16) & 255) / 255, ((color >> 8) & 255) / 255, (color & 255) / 255];
}

function blurStrength(px: number): number {
  return Math.max(0, px) / 2;
}

class ColorizeFilter extends Filter {
  constructor() {
    super({
      glProgram: GlProgram.from({ vertex: defaultFilterVert, fragment: colorizeFrag, name: 'flash-colorize' }),
      resources: { colorUniforms: new UniformGroup({ uColor: { value: new Float32Array([1, 1, 1, 1]), type: 'vec4<f32>' } }) },
    });
  }
}

export class FlashGlowFilter extends Filter {
  private colorize = new ColorizeFilter();
  private blur: BlurFilter;
  readonly def: Extract<FlashFilterDef, { type: 'glow' | 'dropShadow' }>;

  constructor(def: Extract<FlashFilterDef, { type: 'glow' | 'dropShadow' }>) {
    const [r, g, b] = rgb(def.color);
    const angle = def.type === 'dropShadow' ? def.angle : 0;
    const dist = def.type === 'dropShadow' ? def.distance : 0;
    const rad = (angle * Math.PI) / 180;
    super({
      glProgram: GlProgram.from({ vertex: defaultFilterVert, fragment: compositeFrag, name: 'flash-glow' }),
      resources: {
        glowUniforms: new UniformGroup({
          uColor: { value: new Float32Array([r, g, b, 1]), type: 'vec4<f32>' },
          uOffset: { value: new Float32Array([Math.cos(rad) * dist, Math.sin(rad) * dist]), type: 'vec2<f32>' },
          uStrength: { value: def.strength, type: 'f32' },
          uAlpha: { value: def.alpha, type: 'f32' },
          uInner: { value: def.inner ? 1 : 0, type: 'f32' },
          uKnockout: { value: def.knockout ? 1 : 0, type: 'f32' },
          uHide: { value: def.type === 'dropShadow' && def.hideObject ? 1 : 0, type: 'f32' },
        }),
        uGlowTexture: Texture.EMPTY.source,
      },
    });
    this.def = def;
    (this.colorize.resources.colorUniforms as UniformGroup).uniforms.uColor = new Float32Array([r, g, b, 1]);
    this.blur = new BlurFilter({
      strengthX: blurStrength(def.blurX),
      strengthY: blurStrength(def.blurY),
      quality: Math.max(1, Math.min(def.quality || 1, 4)) * 2,
    });
    this.padding = Math.ceil(Math.max(def.blurX, def.blurY) + dist + 2);
  }

  override apply(filterManager: FilterSystem, input: Texture, output: RenderSurface, clearMode: boolean): void {
    const tmp = TexturePool.getSameSizeTexture(input);
    const tmp2 = TexturePool.getSameSizeTexture(input);
    filterManager.applyFilter(this.colorize, input, tmp, true);
    if (this.def.blurX > 0 || this.def.blurY > 0) {
      this.blur.apply(filterManager, tmp, tmp2, true);
    } else {
      filterManager.applyFilter(this.colorize, input, tmp2, true);
    }
    this.resources.uGlowTexture = tmp2.source;
    filterManager.applyFilter(this, input, output, clearMode);
    TexturePool.returnTexture(tmp);
    TexturePool.returnTexture(tmp2);
  }
}

const cxFrag = `
in vec2 vTextureCoord;
out vec4 finalColor;
uniform sampler2D uTexture;
uniform vec4 uMult;
uniform vec4 uAdd;
void main(void) {
  vec4 c = texture(uTexture, vTextureCoord);
  vec3 rgb = c.a > 0.0 ? c.rgb / c.a : vec3(0.0);
  vec4 o = clamp(vec4(rgb, c.a) * uMult + uAdd, 0.0, 1.0);
  finalColor = vec4(o.rgb * o.a, o.a);
}`;

export class ColorTransformFilter extends Filter {
  constructor(cx: number[]) {
    super({
      glProgram: GlProgram.from({ vertex: defaultFilterVert, fragment: cxFrag, name: 'flash-cxform' }),
      resources: {
        cxUniforms: new UniformGroup({
          uMult: { value: new Float32Array(cx.slice(0, 4)), type: 'vec4<f32>' },
          uAdd: { value: new Float32Array(cx.slice(4, 8).map((v) => v / 255)), type: 'vec4<f32>' },
        }),
      },
    });
  }
}

export function isIdentityCx(cx?: number[]): boolean {
  return !cx || (cx[0] === 1 && cx[1] === 1 && cx[2] === 1 && cx[3] === 1 && !cx[4] && !cx[5] && !cx[6] && !cx[7]);
}

export function colorMatrixFilter(m: number[]): ColorMatrixFilter {
  const f = new ColorMatrixFilter();
  const out = m.slice(0, 20);
  for (const i of [4, 9, 14, 19]) out[i] = (out[i] ?? 0) / 255;
  f.matrix = out as unknown as ColorMatrixFilter['matrix'];
  return f;
}

function hexColor(s: string): { color: number; alpha: number } {
  const h = s.replace('#', '');
  return { color: parseInt(h.slice(0, 6), 16), alpha: h.length >= 8 ? parseInt(h.slice(6, 8), 16) / 255 : 1 };
}

export function fromSwfFilters(list: Record<string, unknown>[]): FlashFilterDef[] {
  return list.map((f) => {
    const t = f.type as string;
    if (t === 'glow' || t === 'dropShadow') {
      const { color, alpha } = hexColor(f.color as string);
      return {
        type: t, color, alpha,
        blurX: f.blurX as number, blurY: f.blurY as number, strength: f.strength as number,
        quality: (f.passes as number) || 1, inner: !!f.inner, knockout: !!f.knockout,
        angle: (f.angle as number) ?? 0, distance: (f.distance as number) ?? 0, hideObject: false,
      } as FlashFilterDef;
    }
    if (t === 'blur') return { type: 'blur', blurX: f.blurX as number, blurY: f.blurY as number, quality: (f.passes as number) || 1 };
    if (t === 'colorMatrix') return { type: 'colorMatrix', matrix: f.matrix as number[] };
    return { ...(f as object), type: t } as FlashFilterDef;
  });
}

export function toPixiFilter(def: FlashFilterDef): Filter | null {
  switch (def.type) {
    case 'glow':
    case 'dropShadow':
      if (def.strength <= 0 || def.alpha <= 0) return null;
      return new FlashGlowFilter(def);
    case 'blur':
      if (def.blurX <= 1 && def.blurY <= 1) return null;
      return new BlurFilter({ strengthX: blurStrength(def.blurX), strengthY: blurStrength(def.blurY), quality: Math.max(1, def.quality) * 2 });
    case 'colorMatrix':
      return colorMatrixFilter(def.matrix);
    default:
      return null;
  }
}

export function toPixiFilters(defs: FlashFilterDef[] | null | undefined): Filter[] {
  return (defs ?? []).map(toPixiFilter).filter((f): f is Filter => f !== null);
}
