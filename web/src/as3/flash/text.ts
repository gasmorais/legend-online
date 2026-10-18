import { CanvasSource, Container, Sprite as PixiSprite, Texture } from 'pixi.js';
import { initFields } from '../runtime';
import { EventDispatcher, flAddListener } from '@/flash/events';
import { TextFormat } from '@/flash/text';
import { Sprite } from '@/flash/sprite';
import { Rectangle } from './geom';
import { MouseEvent } from './events';

export const TextFieldAutoSize = { CENTER: 'center', LEFT: 'left', NONE: 'none', RIGHT: 'right' } as const;
export const TextFormatAlign = { CENTER: 'center', END: 'end', JUSTIFY: 'justify', LEFT: 'left', RIGHT: 'right', START: 'start' } as const;
export const AntiAliasType = { ADVANCED: 'advanced', NORMAL: 'normal' } as const;
export const GridFitType = { NONE: 'none', PIXEL: 'pixel', SUBPIXEL: 'subpixel' } as const;
export const TextFieldType = { DYNAMIC: 'dynamic', INPUT: 'input' } as const;
export const TextDisplayMode = { CRT: 'crt', DEFAULT: 'default', LCD: 'lcd' } as const;
export const TextColorType = { DARK_COLOR: 'dark', LIGHT_COLOR: 'light' } as const;
export const TextFormatDisplay = { BLOCK: 'block', INLINE: 'inline' } as const;
export const TextInteractionMode = { NORMAL: 'normal', SELECTION: 'selection' } as const;
export const FontStyle = { BOLD: 'bold', BOLD_ITALIC: 'boldItalic', ITALIC: 'italic', REGULAR: 'regular' } as const;
export const FontType = { DEVICE: 'device', EMBEDDED: 'embedded', EMBEDDED_CFF: 'embeddedCFF' } as const;

export class TextLineMetrics {
  constructor(public x = 0, public width = 0, public height = 0, public ascent = 0, public descent = 0, public leading = 0) { initFields(this, new.target); }
}

export class TextRenderer {
  static antiAliasType = 'normal';
  static displayMode = 'default';
  static maxLevel = 4;
  static setAdvancedAntiAliasingTable(): void {}
}

export class TextSnapshot {
  readonly charCount = 0;
  findText(): number { return -1; }
  getSelected(): boolean { return false; }
  getSelectedText(): string { return ''; }
  getText(): string { return ''; }
  getTextRunInfo(): unknown[] { return []; }
  hitTestTextNearPos(): number { return -1; }
  setSelectColor(): void {}
  setSelected(): void {}
}

export class Font {
  private static registered: Font[] = [];
  fontName: string | null = null;
  fontStyle: string | null = 'regular';
  fontType: string | null = 'device';
  constructor() { initFields(this, new.target); }
  hasGlyphs(_s: string): boolean { return true; }
  static enumerateFonts(_device = false): Font[] { return Font.registered.slice(); }
  static registerFont(cls: new () => Font): void {
    try { const f = new cls(); Font.registered.push(f); } catch { }
  }
}

export class StyleSheet extends EventDispatcher {
  private __styles = new Map<string, Record<string, string>>();
  get styleNames(): string[] { return [...this.__styles.keys()]; }
  clear(): void { this.__styles.clear(); }
  getStyle(name: string): Record<string, string> { return { ...(this.__styles.get(String(name).toLowerCase()) ?? {}) }; }
  setStyle(name: string, style: Record<string, unknown> | null): void {
    const k = String(name).toLowerCase();
    if (!style) { this.__styles.delete(k); return; }
    const out: Record<string, string> = {};
    for (const [p, v] of Object.entries(style)) out[p.replace(/-([a-z])/g, (_, c: string) => c.toUpperCase())] = String(v);
    this.__styles.set(k, out);
  }
  parseCSS(css: string): void {
    const re = /([^{]+)\{([^}]*)\}/g;
    let m: RegExpExecArray | null;
    while ((m = re.exec(String(css).replace(/\/\*[\s\S]*?\*\//g, '')))) {
      const decl: Record<string, string> = {};
      for (const part of m[2].split(';')) {
        const i = part.indexOf(':');
        if (i < 0) continue;
        decl[part.slice(0, i).trim()] = part.slice(i + 1).trim().replace(/^["']|["']$/g, '');
      }
      for (const sel of m[1].split(',')) this.setStyle(sel.trim(), decl);
    }
  }
  transform(style: Record<string, string> | null): TextFormat | null {
    if (!style) return null;
    const f = new TextFormat();
    if (style.fontFamily) f.font = style.fontFamily.split(',')[0].trim();
    if (style.fontSize) f.size = parseFloat(style.fontSize);
    if (style.color) f.color = parseInt(style.color.replace('#', ''), 16);
    if (style.fontWeight) f.bold = style.fontWeight === 'bold';
    if (style.fontStyle) f.italic = style.fontStyle === 'italic';
    if (style.textDecoration) f.underline = style.textDecoration === 'underline';
    if (style.textAlign) f.align = style.textAlign;
    if (style.leading) f.leading = parseFloat(style.leading);
    if (style.letterSpacing) f.letterSpacing = parseFloat(style.letterSpacing);
    if (style.marginLeft) f.leftMargin = parseFloat(style.marginLeft);
    if (style.marginRight) f.rightMargin = parseFloat(style.marginRight);
    if (style.textIndent) f.indent = parseFloat(style.textIndent);
    return f;
  }
}

export const FontWeight = { BOLD: 'bold', NORMAL: 'normal' } as const;
export const FontPosture = { ITALIC: 'italic', NORMAL: 'normal' } as const;
export const FontLookup = { DEVICE: 'device', EMBEDDED_CFF: 'embeddedCFF' } as const;
export const RenderingMode = { CFF: 'cff', NORMAL: 'normal' } as const;
export const CFFHinting = { HORIZONTAL_STEM: 'horizontalStem', NONE: 'none' } as const;
export const TextBaseline = { ASCENT: 'ascent', DESCENT: 'descent', IDEOGRAPHIC_BOTTOM: 'ideographicBottom', IDEOGRAPHIC_CENTER: 'ideographicCenter', IDEOGRAPHIC_TOP: 'ideographicTop', ROMAN: 'roman', USE_DOMINANT_BASELINE: 'useDominantBaseline' } as const;
export const BreakOpportunity = { ALL: 'all', ANY: 'any', AUTO: 'auto', NONE: 'none' } as const;
export const Kerning = { AUTO: 'auto', OFF: 'off', ON: 'on' } as const;
export const TextRotation = { AUTO: 'auto', ROTATE_0: 'rotate0', ROTATE_180: 'rotate180', ROTATE_270: 'rotate270', ROTATE_90: 'rotate90' } as const;
export const TextLineValidity = { INVALID: 'invalid', POSSIBLY_INVALID: 'possiblyInvalid', STATIC: 'static', VALID: 'valid' } as const;
export const TextLineCreationResult = { COMPLETE: 'complete', EMERGENCY: 'emergency', INSUFFICIENT_WIDTH: 'insufficientWidth', SUCCESS: 'success' } as const;
export const LineJustification = { ALL_BUT_LAST: 'allButLast', ALL_BUT_MANDATORY_BREAK: 'allButMandatoryBreak', ALL_INCLUDING_LAST: 'allIncludingLast', UNJUSTIFIED: 'unjustified' } as const;
export const DigitCase = { DEFAULT: 'default', LINING: 'lining', OLD_STYLE: 'oldStyle' } as const;
export const DigitWidth = { DEFAULT: 'default', PROPORTIONAL: 'proportional', TABULAR: 'tabular' } as const;
export const LigatureLevel = { COMMON: 'common', EXOTIC: 'exotic', MINIMUM: 'minimum', NONE: 'none', UNCOMMON: 'uncommon' } as const;
export const TypographicCase = { CAPS: 'caps', CAPS_AND_SMALL_CAPS: 'capsAndSmallCaps', DEFAULT: 'default', LOWERCASE: 'lowercase', SMALL_CAPS: 'smallCaps', TITLE: 'title', UPPERCASE: 'uppercase' } as const;
export const TabAlignment = { CENTER: 'center', DECIMAL: 'decimal', END: 'end', START: 'start' } as const;

export class FontDescription {
  fontName: string;
  fontWeight: string;
  fontPosture: string;
  fontLookup: string;
  renderingMode: string;
  cffHinting: string;
  locked = false;
  constructor(fontName = '_serif', fontWeight = 'normal', fontPosture = 'normal', fontLookup = 'device', renderingMode = 'cff',
    cffHinting = 'horizontalStem') {
    initFields(this, new.target);
    this.fontName = fontName;
    this.fontWeight = fontWeight;
    this.fontPosture = fontPosture;
    this.fontLookup = fontLookup;
    this.renderingMode = renderingMode;
    this.cffHinting = cffHinting;
  }
  clone(): FontDescription {
    return new FontDescription(this.fontName, this.fontWeight, this.fontPosture, this.fontLookup, this.renderingMode, this.cffHinting);
  }
  static isFontCompatible(): boolean { return true; }
  static isDeviceFontCompatible(): boolean { return true; }
}

export class FontMetrics {
  constructor(public emBox: Rectangle, public strikethroughOffset: number, public strikethroughThickness: number,
    public underlineOffset: number, public underlineThickness: number, public subscriptOffset: number, public subscriptScale: number,
    public superscriptOffset: number, public superscriptScale: number, public lineGap = 0) {}
}

export class ElementFormat {
  fontDescription: FontDescription;
  fontSize: number;
  color: number;
  alpha: number;
  textRotation: string;
  dominantBaseline: string;
  alignmentBaseline: string;
  baselineShift: number;
  kerning: string;
  trackingRight: number;
  trackingLeft: number;
  locale: string;
  breakOpportunity: string;
  digitCase: string;
  digitWidth: string;
  ligatureLevel: string;
  typographicCase: string;
  locked = false;
  constructor(fontDescription: FontDescription | null = null, fontSize = 12, color = 0, alpha = 1, textRotation = 'auto',
    dominantBaseline = 'roman', alignmentBaseline = 'useDominantBaseline', baselineShift = 0, kerning = 'on', trackingRight = 0,
    trackingLeft = 0, locale = 'en', breakOpportunity = 'auto', digitCase = 'default', digitWidth = 'default',
    ligatureLevel = 'common', typographicCase = 'default') {
    initFields(this, new.target);
    this.fontDescription = fontDescription ?? new FontDescription();
    this.fontSize = Number(fontSize);
    this.color = Number(color);
    this.alpha = Number(alpha);
    this.textRotation = textRotation;
    this.dominantBaseline = dominantBaseline;
    this.alignmentBaseline = alignmentBaseline;
    this.baselineShift = Number(baselineShift);
    this.kerning = kerning;
    this.trackingRight = Number(trackingRight);
    this.trackingLeft = Number(trackingLeft);
    this.locale = locale;
    this.breakOpportunity = breakOpportunity;
    this.digitCase = digitCase;
    this.digitWidth = digitWidth;
    this.ligatureLevel = ligatureLevel;
    this.typographicCase = typographicCase;
  }
  clone(): ElementFormat {
    return new ElementFormat(this.fontDescription?.clone() ?? null, this.fontSize, this.color, this.alpha, this.textRotation,
      this.dominantBaseline, this.alignmentBaseline, this.baselineShift, this.kerning, this.trackingRight, this.trackingLeft, this.locale,
      this.breakOpportunity, this.digitCase, this.digitWidth, this.ligatureLevel, this.typographicCase);
  }
  getFontMetrics(): FontMetrics {
    const m = metrics(this);
    return new FontMetrics(new Rectangle(0, -m.ascent, this.fontSize, m.ascent + m.descent), -m.ascent / 3, 1, m.descent / 2, 1,
      this.fontSize / 3, 0.6, -this.fontSize / 2, 0.6, 0);
  }
}

const FONT_ALIAS: Record<string, string> = {
  _serif: '"Times New Roman", serif', _sans: 'Arial, sans-serif', _typewriter: '"Courier New", monospace',
  arial: 'Arial, "Liberation Sans", Helvetica, sans-serif', tahoma: 'Tahoma, Verdana, sans-serif', simsun: 'SimSun, "Songti SC", serif',
  '宋体': 'SimSun, "Songti SC", serif', '微软雅黑': '"Microsoft YaHei", "PingFang SC", sans-serif',
};

function cssFont(f: ElementFormat): string {
  const fd = f.fontDescription;
  const name = fd?.fontName ?? '_serif';
  const fam = FONT_ALIAS[name.toLowerCase()] ?? FONT_ALIAS[name] ?? `"${name}", Arial, sans-serif`;
  return `${fd?.fontPosture === 'italic' ? 'italic ' : ''}${fd?.fontWeight === 'bold' ? 'bold ' : ''}${f.fontSize}px ${fam}`;
}

let mctx: CanvasRenderingContext2D | null = null;
function ctx2d(): CanvasRenderingContext2D { return (mctx ??= document.createElement('canvas').getContext('2d')!); }

function metrics(f: ElementFormat): { ascent: number; descent: number } {
  const c = ctx2d();
  c.font = cssFont(f);
  const m = c.measureText('Ág');
  return { ascent: m.fontBoundingBoxAscent ?? f.fontSize * 0.88, descent: m.fontBoundingBoxDescent ?? f.fontSize * 0.12 };
}

export class ContentElement {
  static readonly GRAPHIC_ELEMENT = 0xfdef;
  elementFormat: ElementFormat | null;
  eventMirror: EventDispatcher | null;
  textRotation: string;
  userData: unknown = null;
 __group: GroupElement | null = null;
 __block: TextBlock | null = null;
  constructor(elementFormat: ElementFormat | null = null, eventMirror: EventDispatcher | null = null, textRotation = 'rotate0') {
    initFields(this, new.target);
    this.elementFormat = elementFormat;
    this.eventMirror = eventMirror;
    this.textRotation = textRotation;
  }
  get text(): string | null { return ''; }
  get rawText(): string | null { return this.text; }
  get groupElement(): GroupElement | null { return this.__group; }
  get textBlock(): TextBlock | null { return this.__block ?? this.__group?.textBlock ?? null; }
  get textBlockBeginIndex(): number {
    const g = this.__group;
    if (!g) return 0;
    let i = g.textBlockBeginIndex;
    for (const e of g.__elements) { if (e === this) break; i += (e.text ?? '').length; }
    return i;
  }
  __leaves(fmt: ElementFormat | null, mirror: EventDispatcher | null, out: Leaf[]): void { void fmt; void mirror; void out; }
}

interface Leaf { element: ContentElement; text?: string; graphic?: Container | null; w?: number; h?: number; fmt: ElementFormat; mirror: EventDispatcher | null }

export class TextElement extends ContentElement {
  private __text: string | null;
  constructor(text: string | null = null, elementFormat: ElementFormat | null = null, eventMirror: EventDispatcher | null = null,
    textRotation = 'rotate0') {
    super(elementFormat, eventMirror, textRotation);
    this.__text = text === null || text === undefined ? null : String(text);
  }
  override get text(): string | null { return this.__text; }
  override set text(v: string | null) { this.__text = v === null || v === undefined ? null : String(v); }
  replaceText(begin: number, end: number, newText: string | null): void {
    const t = this.__text ?? '';
    this.__text = t.slice(0, begin) + (newText ?? '') + t.slice(end);
  }
  override __leaves(fmt: ElementFormat | null, mirror: EventDispatcher | null, out: Leaf[]): void {
    const f = this.elementFormat ?? fmt ?? new ElementFormat();
    if (this.__text) out.push({ element: this, text: this.__text, fmt: f, mirror: this.eventMirror ?? mirror });
  }
}

export class GraphicElement extends ContentElement {
  graphic: Container | null;
  elementWidth: number;
  elementHeight: number;
  constructor(graphic: Container | null = null, elementWidth = 15, elementHeight = 15, elementFormat: ElementFormat | null = null,
    eventMirror: EventDispatcher | null = null, textRotation = 'rotate0') {
    super(elementFormat, eventMirror, textRotation);
    this.graphic = graphic;
    this.elementWidth = Number(elementWidth);
    this.elementHeight = Number(elementHeight);
  }
  override get text(): string | null { return String.fromCharCode(ContentElement.GRAPHIC_ELEMENT); }
  override __leaves(fmt: ElementFormat | null, mirror: EventDispatcher | null, out: Leaf[]): void {
    out.push({ element: this, graphic: this.graphic, w: this.elementWidth, h: this.elementHeight,
      fmt: this.elementFormat ?? fmt ?? new ElementFormat(), mirror: this.eventMirror ?? mirror });
  }
}

export class GroupElement extends ContentElement {
 __elements: ContentElement[] = [];
  constructor(elements: ContentElement[] | null = null, elementFormat: ElementFormat | null = null, eventMirror: EventDispatcher | null = null,
    textRotation = 'rotate0') {
    super(elementFormat, eventMirror, textRotation);
    if (elements) this.setElements(elements);
  }
  get elementCount(): number { return this.__elements.length; }
  override get text(): string | null { return this.__elements.map((e) => e.text ?? '').join(''); }
  getElementAt(i: number): ContentElement | null { return this.__elements[i] ?? null; }
  getElementIndex(e: ContentElement): number { return this.__elements.indexOf(e); }
  getElementAtCharIndex(ci: number): ContentElement | null {
    let i = 0;
    for (const e of this.__elements) {
      const n = (e.text ?? '').length;
      if (ci < i + n) return e instanceof GroupElement ? e.getElementAtCharIndex(ci - i) : e;
      i += n;
    }
    return null;
  }
  setElements(v: ContentElement[] | null): void {
    for (const e of this.__elements) e.__group = null;
    this.__elements = [...(v ?? [])];
    for (const e of this.__elements) e.__group = this;
  }
  replaceElements(begin: number, end: number, newElements: ContentElement[] | null): ContentElement[] {
    const removed = this.__elements.splice(begin, end - begin, ...(newElements ?? []));
    for (const e of removed) e.__group = null;
    for (const e of newElements ?? []) e.__group = this;
    return removed;
  }
  groupElements(begin: number, end: number): GroupElement {
    const g = new GroupElement(this.__elements.slice(begin, end));
    this.replaceElements(begin, end, [g]);
    return g;
  }
  ungroupElements(index: number): void {
    const g = this.__elements[index];
    if (g instanceof GroupElement) this.replaceElements(index, index + 1, g.__elements.slice());
  }
  mergeTextElements(begin: number, end: number): TextElement {
    const parts = this.__elements.slice(begin, end + 1) as TextElement[];
    const t = new TextElement(parts.map((p) => p.text ?? '').join(''), parts[0]?.elementFormat ?? null, parts[0]?.eventMirror ?? null);
    this.replaceElements(begin, end + 1, [t]);
    return t;
  }
  splitTextElement(index: number, splitIndex: number): TextElement {
    const e = this.__elements[index] as TextElement;
    const t = e.text ?? '';
    const a = new TextElement(t.slice(0, splitIndex), e.elementFormat, e.eventMirror);
    const b = new TextElement(t.slice(splitIndex), e.elementFormat, e.eventMirror);
    this.replaceElements(index, index + 1, [a, b]);
    return b;
  }
  override __leaves(fmt: ElementFormat | null, mirror: EventDispatcher | null, out: Leaf[]): void {
    const f = this.elementFormat ?? fmt;
    const m = this.eventMirror ?? mirror;
    for (const e of this.__elements) e.__leaves(f, m, out);
  }
}

interface Atom { leaf: Leaf; ch: string; w: number; isGraphic: boolean; space: boolean; cjk: boolean }

const CJK = /[⺀-鿿가-힯豈-﫿＀-￯　-〿]/;

export class TabStop {
  constructor(public alignment = 'start', public position = 0, public decimalAlignmentToken = '') {}
}
export class TextJustifier {
  constructor(public locale = 'en', public lineJustification = 'unjustified') {}
  clone(): TextJustifier { return new TextJustifier(this.locale, this.lineJustification); }
  static getJustifierForLocale(locale: string): TextJustifier { return new SpaceJustifier(locale); }
}
export class SpaceJustifier extends TextJustifier {
  letterSpacing = false;
  minimumSpacing = 0.5;
  optimumSpacing = 1;
  maximumSpacing = 1.5;
}
export class EastAsianJustifier extends TextJustifier {
  justificationStyle = 'pushInKinsoku';
  composeTrailingIdeographicSpaces = false;
}

export class TextBlock {
  content: ContentElement | null;
  tabStops: TabStop[] | null;
  textJustifier: TextJustifier;
  lineRotation: string;
  baselineZero: string;
  bidiLevel: number;
  applyNonLinearFontScaling: boolean;
  baselineFontDescription: FontDescription | null;
  baselineFontSize: number;
  userData: unknown = null;
  textLineCreationResult: string | null = null;
  private __lines: TextLine[] = [];

  constructor(content: ContentElement | null = null, tabStops: TabStop[] | null = null, textJustifier: TextJustifier | null = null,
    lineRotation = 'rotate0', baselineZero = 'roman', bidiLevel = 0, applyNonLinearFontScaling = true,
    baselineFontDescription: FontDescription | null = null, baselineFontSize = 12) {
    initFields(this, new.target);
    this.content = content;
    this.tabStops = tabStops;
    this.textJustifier = textJustifier ?? new SpaceJustifier();
    this.lineRotation = lineRotation;
    this.baselineZero = baselineZero;
    this.bidiLevel = bidiLevel;
    this.applyNonLinearFontScaling = applyNonLinearFontScaling;
    this.baselineFontDescription = baselineFontDescription;
    this.baselineFontSize = baselineFontSize;
  }

  get firstLine(): TextLine | null { return this.__lines[0] ?? null; }
  get lastLine(): TextLine | null { return this.__lines[this.__lines.length - 1] ?? null; }
  get firstInvalidLine(): TextLine | null { return null; }

  private atoms(): Atom[] {
    const leaves: Leaf[] = [];
    if (this.content) {
      this.content.__block = this;
      this.content.__leaves(null, null, leaves);
    }
    const out: Atom[] = [];
    const c = ctx2d();
    for (const leaf of leaves) {
      if (leaf.graphic !== undefined) {
        out.push({ leaf, ch: '﷯', w: leaf.w ?? 0, isGraphic: true, space: false, cjk: true });
        continue;
      }
      c.font = cssFont(leaf.fmt);
      for (const ch of leaf.text ?? '') {
        const w = c.measureText(ch).width + leaf.fmt.trackingLeft + leaf.fmt.trackingRight;
        out.push({ leaf, ch, w, isGraphic: false, space: /\s/.test(ch), cjk: CJK.test(ch) });
      }
    }
    return out;
  }

  createTextLine(previousLine: TextLine | null = null, width = 1000000, lineOffset = 0, fitSomething = false): TextLine | null {
    void lineOffset;
    const atoms = this.atoms();
    const start = previousLine ? previousLine.textBlockBeginIndex + previousLine.rawTextLength : 0;
    if (start >= atoms.length) { this.textLineCreationResult = 'complete'; return null; }
    let x = 0, end = start, lastBreak = -1;
    for (let i = start; i < atoms.length; i++) {
      const a = atoms[i];
      if (a.ch === '\n' || a.ch === ' ') { end = i + 1; lastBreak = -2; break; }
      if (x + a.w > width && i > start) {
        if (!a.space && lastBreak > start) end = lastBreak;
        else end = a.space ? i + 1 : i;
        lastBreak = -2;
        break;
      }
      x += a.w;
      end = i + 1;
      const br = a.leaf.fmt.breakOpportunity;
      if (a.space || a.cjk || a.isGraphic || br === 'any' || br === 'all') lastBreak = i + 1;
    }
    if (end === start) {
      if (!fitSomething && atoms[start].w > width) { this.textLineCreationResult = 'insufficientWidth'; return null; }
      end = start + 1;
    }
    const line = new TextLine(this, atoms.slice(start, end), start, width);
    if (previousLine) { line.__prev = previousLine; previousLine.__next = line; }
    const i = previousLine ? this.__lines.indexOf(previousLine) : -1;
    this.__lines.splice(i + 1, this.__lines.length, line);
    this.textLineCreationResult = 'success';
    return line;
  }

  recreateTextLine(textLine: TextLine, previousLine: TextLine | null = null, width = 1000000, lineOffset = 0, fitSomething = false): TextLine | null {
    textLine.parent?.removeChild(textLine);
    return this.createTextLine(previousLine, width, lineOffset, fitSomething);
  }
  releaseLines(first: TextLine, last: TextLine): void {
    const a = this.__lines.indexOf(first), b = this.__lines.indexOf(last);
    if (a < 0 || b < 0) return;
    for (const l of this.__lines.splice(a, b - a + 1)) l.__block = null;
  }
  releaseLineCreationData(): void {}
  findNextAtomBoundary(i: number): number { return i + 1; }
  findPreviousAtomBoundary(i: number): number { return Math.max(0, i - 1); }
  findNextWordBoundary(i: number): number {
    const t = this.content?.text ?? '';
    const m = /\s/.exec(t.slice(i + 1));
    return m ? i + 1 + m.index : t.length;
  }
  findPreviousWordBoundary(i: number): number {
    const t = (this.content?.text ?? '').slice(0, i);
    const k = t.search(/\s\S*$/);
    return k < 0 ? 0 : k + 1;
  }
  getTextLineAtCharIndex(ci: number): TextLine | null {
    return this.__lines.find((l) => ci >= l.textBlockBeginIndex && ci < l.textBlockBeginIndex + l.rawTextLength) ?? null;
  }
  dump(): string { return ''; }
}

export class TextLineMirrorRegion {
  constructor(public textLine: TextLine, public element: ContentElement, public mirror: EventDispatcher, public bounds: Rectangle) {}
  nextRegion: TextLineMirrorRegion | null = null;
  previousRegion: TextLineMirrorRegion | null = null;
}

const RES = 2;

export class TextLine extends Sprite {
  static readonly MAX_LINE_WIDTH = 1000000;
 __block: TextBlock | null;
 __prev: TextLine | null = null;
 __next: TextLine | null = null;
  readonly textBlockBeginIndex: number;
  readonly rawTextLength: number;
  readonly specifiedWidth: number;
  readonly ascent: number;
  readonly descent: number;
  readonly textWidth: number;
  readonly unjustifiedTextWidth: number;
  readonly atomCount: number;
  readonly mirrorRegions: TextLineMirrorRegion[] = [];
  userData: unknown = null;
  validity = 'valid';
  private __atomX: number[] = [];
  private __atoms: Atom[];

  constructor(block: TextBlock, atoms: Atom[], begin: number, width: number) {
    super();
    this.__block = block;
    this.__atoms = atoms;
    this.textBlockBeginIndex = begin;
    this.rawTextLength = atoms.length;
    this.specifiedWidth = width;
    this.atomCount = atoms.length;
    let asc = 0, desc = 0, x = 0;
    for (const a of atoms) {
      this.__atomX.push(x);
      x += a.w;
      if (a.isGraphic) { asc = Math.max(asc, (a.leaf.h ?? 0) - a.leaf.fmt.baselineShift); }
      else { const m = metrics(a.leaf.fmt); asc = Math.max(asc, m.ascent); desc = Math.max(desc, m.descent); }
    }
    let tw = x;
    for (let i = atoms.length - 1; i >= 0 && atoms[i].space; i--) tw -= atoms[i].w;
    this.textWidth = tw;
    this.unjustifiedTextWidth = tw;
    const zero = block.baselineZero;
    const shift = zero === 'ideographicCenter' ? -(asc - desc) / 2 : zero === 'ideographicTop' || zero === 'ascent' ? -asc
      : zero === 'ideographicBottom' || zero === 'descent' ? desc : 0;
    this.ascent = asc + shift;
    this.descent = desc - shift;
    this.render(asc, desc, shift);
  }

  get textBlock(): TextBlock | null { return this.__block; }
  get nextLine(): TextLine | null { return this.__next; }
  get previousLine(): TextLine | null { return this.__prev; }
  get textHeight(): number { return this.ascent + this.descent; }
  get totalAscent(): number { return this.ascent; }
  get totalDescent(): number { return this.descent; }
  get totalHeight(): number { return this.ascent + this.descent; }
  get hasGraphicElement(): boolean { return this.__atoms.some((a) => a.isGraphic); }
  get hasTabs(): boolean { return this.__atoms.some((a) => a.ch === '\t'); }

  getAtomBounds(i: number): Rectangle { return new Rectangle(this.__atomX[i] ?? 0, -this.ascent, this.__atoms[i]?.w ?? 0, this.textHeight); }
  getAtomCenter(i: number): number { return (this.__atomX[i] ?? 0) + (this.__atoms[i]?.w ?? 0) / 2; }
  getAtomGraphic(i: number): Container | null { return this.__atoms[i]?.leaf.graphic ?? null; }
  getAtomIndexAtCharIndex(ci: number): number { const k = ci - this.textBlockBeginIndex; return k >= 0 && k < this.atomCount ? k : -1; }
  getAtomIndexAtPoint(sx: number, _sy: number): number {
    const p = (this as any).globalToLocal({ x: sx, y: _sy });
    for (let i = 0; i < this.atomCount; i++) if (p.x >= this.__atomX[i] && p.x < this.__atomX[i] + this.__atoms[i].w) return i;
    return -1;
  }
  getAtomTextBlockBeginIndex(i: number): number { return this.textBlockBeginIndex + i; }
  getAtomTextBlockEndIndex(i: number): number { return this.textBlockBeginIndex + i + 1; }
  getAtomTextRotation(_i: number): string { return 'rotate0'; }
  getAtomWordBoundaryOnLeft(i: number): boolean { return i === 0 || this.__atoms[i - 1].space; }
  getAtomBidiLevel(_i: number): number { return 0; }
  getBaselinePosition(baseline: string): number {
    if (baseline === 'ascent' || baseline === 'ideographicTop') return -this.ascent;
    if (baseline === 'descent' || baseline === 'ideographicBottom') return this.descent;
    if (baseline === 'ideographicCenter') return (this.descent - this.ascent) / 2;
    return 0;
  }
  getMirrorRegion(mirror: EventDispatcher): TextLineMirrorRegion | null { return this.mirrorRegions.find((r) => r.mirror === mirror) ?? null; }
  flushAtomData(): void {}
  dump(): string { return ''; }

  private render(asc: number, desc: number, shift: number): void {
    const w = Math.max(1, Math.ceil(this.__atomX.length ? this.__atomX[this.__atomX.length - 1] + this.__atoms[this.__atoms.length - 1].w : 1));
    const h = Math.max(1, Math.ceil(asc + desc));
    const canvas = document.createElement('canvas');
    canvas.width = w * RES;
    canvas.height = h * RES;
    const c = canvas.getContext('2d')!;
    c.scale(RES, RES);
    c.textBaseline = 'alphabetic';
    let drewText = false;
    type Region = { mirror: EventDispatcher; element: ContentElement; x0: number; x1: number };
    let region: Region | null = null as Region | null;
    const regions: Region[] = [];
    this.__atoms.forEach((a, i) => {
      const x = this.__atomX[i];
      const fmt = a.leaf.fmt;
      if (a.isGraphic) {
        const g = a.leaf.graphic;
        if (g) {
          g.position.set(x, -(a.leaf.h ?? 0) + fmt.baselineShift - shift);
          this.addChild(g);
        }
      } else if (!a.space) {
        c.font = cssFont(fmt);
        c.globalAlpha = fmt.alpha;
        c.fillStyle = '#' + ((fmt.color >>> 0) & 0xffffff).toString(16).padStart(6, '0');
        c.fillText(a.ch, x + fmt.trackingLeft, asc + fmt.baselineShift);
        drewText = true;
      }
      const m = a.leaf.mirror;
      if (m) {
        if (region && region.mirror === m && region.element === a.leaf.element) region.x1 = x + a.w;
        else { region = { mirror: m, element: a.leaf.element, x0: x, x1: x + a.w }; regions.push(region); }
      } else region = null;
    });
    if (drewText) {
      const sp = new PixiSprite(new Texture({ source: new CanvasSource({ resource: canvas, resolution: RES }) }));
      sp.position.set(0, -asc - shift);
      (sp as any).__flInternal = true;
      sp.eventMode = 'none';
      this.addChildAt(sp, 0);
    }
    let prev: TextLineMirrorRegion | null = null;
    for (const r of regions) {
      const bounds = new Rectangle(r.x0, -this.ascent, r.x1 - r.x0, this.textHeight);
      const mr = new TextLineMirrorRegion(this, r.element, r.mirror, bounds);
      if (prev) { prev.nextRegion = mr; mr.previousRegion = prev; }
      prev = mr;
      this.mirrorRegions.push(mr);
      const hit = new Sprite();
      hit.eventMode = 'static';
      hit.graphics.beginFill(0, 0);
      hit.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
      hit.graphics.endFill();
      (hit as any).__flInternal = true;
      for (const t of ['click', 'mouseDown', 'mouseUp', 'mouseMove', 'mouseOver', 'mouseOut', 'rollOver', 'rollOut', 'doubleClick']) {
        flAddListener(hit, t, (e: MouseEvent) => {
          const copy = new MouseEvent(e.type, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey,
            e.shiftKey, e.buttonDown, e.delta);
          copy.__stageX = e.__stageX;
          copy.__stageY = e.__stageY;
          r.mirror.dispatchEvent(copy);
        });
      }
      this.addChild(hit);
    }
  }
}
