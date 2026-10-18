import { CanvasSource, Container, Rectangle, Sprite, Texture } from 'pixi.js';
import type { CharDef, SwfLibrary } from './library';
import { initFields } from '@/as3/runtime';

const GUTTER = 2;
const RES = 2;

function toNum(v: unknown): number | null {
  if (v === null || v === undefined || v === '') return null;
  const n = typeof v === 'number' ? v : Number(String(v).trim());
  return Number.isNaN(n) ? null : n;
}

function toBool(v: unknown): boolean | null {
  if (v === null || v === undefined || v === '') return null;
  if (typeof v === 'boolean') return v;
  const s = String(v).trim().toLowerCase();
  return s === 'true' || s === '1';
}

export class TextFormat {
  font: string | null;
  size: number | null;
  color: number | null;
  bold: boolean | null;
  italic: boolean | null;
  underline: boolean | null;
  url: string | null;
  target: string | null;
  align: string | null;
  leftMargin: number | null;
  rightMargin: number | null;
  indent: number | null;
  leading: number | null;
  letterSpacing: number | null = null;
  kerning: boolean | null = null;

  constructor(font: unknown = null, size: unknown = null, color: unknown = null, bold: unknown = null,
    italic: unknown = null, underline: unknown = null, url: unknown = null, target: unknown = null,
    align: unknown = null, leftMargin: unknown = null, rightMargin: unknown = null, indent: unknown = null,
    leading: unknown = null) {
    this.font = font ? String(font) : null;
    this.size = toNum(size);
    this.color = toNum(color);
    this.bold = toBool(bold);
    this.italic = toBool(italic);
    this.underline = toBool(underline);
    this.url = url ? String(url) : null;
    this.target = target ? String(target) : null;
    this.align = align ? String(align) : null;
    this.leftMargin = toNum(leftMargin);
    this.rightMargin = toNum(rightMargin);
    this.indent = toNum(indent);
    this.leading = toNum(leading);
  }

  clone(): TextFormat { return Object.assign(new TextFormat(), this); }

  mergeFrom(other: TextFormat | null): this {
    if (!other) return this;
    for (const k of Object.keys(other) as (keyof TextFormat)[]) {
      const v = other[k];
      if (v !== null && v !== undefined && typeof v !== 'function') (this as any)[k] = v;
    }
    return this;
  }
}

function baseFormat(): TextFormat {
  const f = new TextFormat('Times New Roman', 12, 0, false, false, false, '', '', 'left', 0, 0, 0, 0);
  f.letterSpacing = 0;
  return f;
}

const FONT_FALLBACK: Record<string, string> = {
  arial: 'Arial, "Liberation Sans", Helvetica, sans-serif',
  tahoma: 'Tahoma, Verdana, sans-serif',
  verdana: 'Verdana, sans-serif',
  'times new roman': '"Times New Roman", Times, serif',
  simsun: 'SimSun, "Songti SC", serif',
  '宋体': 'SimSun, "Songti SC", serif',
  '微软雅黑': '"Microsoft YaHei", "PingFang SC", sans-serif',
  'microsoft yahei': '"Microsoft YaHei", "PingFang SC", sans-serif',
};

function cssFont(f: TextFormat): string {
  const fam = FONT_FALLBACK[(f.font ?? 'Arial').toLowerCase()] ?? `"${f.font}", Arial, sans-serif`;
  return `${f.italic ? 'italic ' : ''}${f.bold ? 'bold ' : ''}${f.size ?? 12}px ${fam}`;
}

function cssColor(c: number | null): string {
  return '#' + ((c ?? 0) & 0xffffff).toString(16).padStart(6, '0');
}

interface Run { text: string; fmt: TextFormat }

const ENTITIES: Record<string, string> = { lt: '<', gt: '>', amp: '&', quot: '"', apos: "'", nbsp: ' ' };

function decodeEntities(s: string): string {
  return s.replace(/&(#x?[0-9a-f]+|\w+);/gi, (m, e: string) => {
    if (e[0] === '#') return String.fromCodePoint(e[1] === 'x' || e[1] === 'X' ? parseInt(e.slice(2), 16) : parseInt(e.slice(1), 10));
    return ENTITIES[e.toLowerCase()] ?? m;
  });
}

function attr(tag: string, name: string): string | null {
  const m = new RegExp(`${name}\\s*=\\s*("([^"]*)"|'([^']*)'|([^\\s>]+))`, 'i').exec(tag);
  return m ? (m[2] ?? m[3] ?? m[4] ?? null) : null;
}

function parseHtml(html: string, base: TextFormat): Run[] {
  const runs: Run[] = [];
  const stack: TextFormat[] = [base.clone()];
  const re = /<[^>]*>|[^<]+/g;
  let m: RegExpExecArray | null;
  while ((m = re.exec(html))) {
    const tok = m[0];
    const top = stack[stack.length - 1];
    if (tok[0] !== '<') { runs.push({ text: decodeEntities(tok), fmt: top }); continue; }
    const closing = tok[1] === '/';
    const name = (/^<\/?\s*([a-z]+)/i.exec(tok)?.[1] ?? '').toLowerCase();
    if (name === 'br') { runs.push({ text: '\n', fmt: top }); continue; }
    if (closing) {
      if (['font', 'b', 'i', 'u', 'a', 'p', 'textformat', 'span'].includes(name) && stack.length > 1) stack.pop();
      if (name === 'p') runs.push({ text: '\n', fmt: top });
      continue;
    }
    const f = top.clone();
    if (name === 'b') f.bold = true;
    else if (name === 'i') f.italic = true;
    else if (name === 'u') f.underline = true;
    else if (name === 'font') {
      const color = attr(tok, 'color');
      if (color) f.color = parseInt(color.replace('#', ''), 16);
      const size = attr(tok, 'size');
      if (size) f.size = /^[+-]/.test(size) ? (f.size ?? 12) + Number(size) : Number(size);
      const face = attr(tok, 'face');
      if (face) f.font = face;
      const ls = attr(tok, 'letterSpacing');
      if (ls) f.letterSpacing = Number(ls);
    } else if (name === 'p') {
      const align = attr(tok, 'align');
      if (align) f.align = align.toLowerCase();
    } else if (name === 'a') {
      f.url = attr(tok, 'href');
    } else if (name === 'textformat') {
      const lead = attr(tok, 'leading');
      if (lead) f.leading = Number(lead);
    } else if (!['span', 'li', 'img'].includes(name)) {
      continue;
    }
    if (!tok.endsWith('/>')) stack.push(f);
  }
  return runs;
}

let measureCtx: CanvasRenderingContext2D | null = null;
function ctx2d(): CanvasRenderingContext2D {
  if (!measureCtx) measureCtx = document.createElement('canvas').getContext('2d')!;
  return measureCtx;
}

interface Piece { text: string; fmt: TextFormat; w: number }
interface Line { pieces: Piece[]; w: number; ascent: number; descent: number; leading: number; align: string; indent: number }

function fontMetrics(f: TextFormat): { ascent: number; descent: number } {
  const c = ctx2d();
  c.font = cssFont(f);
  const m = c.measureText('Ág');
  const size = f.size ?? 12;
  return {
    ascent: m.fontBoundingBoxAscent ?? size * 0.905,
    descent: m.fontBoundingBoxDescent ?? size * 0.212,
  };
}

function measure(text: string, f: TextFormat): number {
  const c = ctx2d();
  c.font = cssFont(f);
  (c as any).letterSpacing = `${f.letterSpacing ?? 0}px`;
  return c.measureText(text).width;
}

export class TextField extends Container {
  private _runs: Run[] = [];
  private _html = false;
  private _defaultFormat = baseFormat();
  private _fieldW = 100;
  private _fieldH = 100;
  private _autoSize = 'none';
  private _wordWrap = false;
  private _multiline = false;
  private _textW = 0;
  private _textH = 0;
  private _lines: Line[] = [];
  private sprite = new Sprite(Texture.EMPTY);
  private dirty = true;
  border = false;
  borderColor = 0;
  background = false;
  backgroundColor = 0xffffff;
  selectable = true;
  embedFonts = false;
  maxChars = 0;
  displayAsPassword = false;
  condenseWhite = false;
  antiAliasType = 'normal';
  sharpness = 0;
  thickness = 0;
  restrict: string | null = null;
  private _type = 'dynamic';
  mouseWheelEnabled = true;
  scrollV = 1;

  constructor() {
    super();
    initFields(this, new.target);
    (this.sprite as any).__flInternal = true;
    this.addChild(this.sprite);
    this.onRender = () => { if (this.dirty) this.render(); };
  }

  static fromSwf(def: CharDef, _lib: SwfLibrary): TextField {
    const tf = new TextField();
    const fmt = baseFormat();
    fmt.font = 'Arial';
    if (def.size) fmt.size = def.size as number;
    if (def.color) fmt.color = parseInt(String(def.color).slice(1, 7), 16);
    if (def.align) fmt.align = def.align as string;
    if (def.leading !== undefined) fmt.leading = def.leading as number;
    if (def.leftMargin !== undefined) fmt.leftMargin = def.leftMargin as number;
    if (def.rightMargin !== undefined) fmt.rightMargin = def.rightMargin as number;
    if (def.indent !== undefined) fmt.indent = def.indent as number;
    tf._defaultFormat = fmt;
    tf.position.set(def.x ?? 0, def.y ?? 0);
    tf._fieldW = def.w ?? 100;
    tf._fieldH = def.h ?? 100;
    tf._wordWrap = !!def.wordWrap;
    tf._multiline = !!def.multiline;
    tf.border = !!def.border;
    tf.selectable = def.selectable !== false;
    const txt = (def.text as string) ?? '';
    if (def.html) tf.htmlText = txt; else tf.text = txt;
    return tf;
  }

  get text(): string { return this._runs.map((r) => r.text).join(''); }
  set text(v: string) {
    this._html = false;
    this._runs = [{ text: String(v ?? '').replace(/\r\n?/g, '\n'), fmt: this._defaultFormat.clone() }];
    this.invalidate();
  }

  get htmlText(): string { return this.text; }
  set htmlText(v: string) {
    this._html = true;
    const src = String(v ?? '');
    this._runs = parseHtml(this.condenseWhite ? src.replace(/\s+/g, ' ') : src.replace(/\r\n?/g, '\n'), this._defaultFormat);
    this.invalidate();
  }

  appendText(v: string): void {
    this._runs.push({ text: v, fmt: this._defaultFormat.clone() });
    this.invalidate();
  }

  get length(): number { return this.text.length; }

  get defaultTextFormat(): TextFormat { return this._defaultFormat.clone(); }
  set defaultTextFormat(f: TextFormat) { this._defaultFormat = baseFormat().mergeFrom(this._defaultFormat).mergeFrom(f); }

  setTextFormat(f: TextFormat | null, begin = -1, end = -1): void {
    if (!f) return;
    if (begin < 0) {
      for (const r of this._runs) r.fmt = r.fmt.clone().mergeFrom(f);
    } else {
      const stop = end < 0 ? begin + 1 : end;
      const out: Run[] = [];
      let pos = 0;
      for (const r of this._runs) {
        const a = pos, b = pos + r.text.length;
        pos = b;
        const s = Math.max(a, begin), e = Math.min(b, stop);
        if (s >= e) { out.push(r); continue; }
        if (s > a) out.push({ text: r.text.slice(0, s - a), fmt: r.fmt });
        out.push({ text: r.text.slice(s - a, e - a), fmt: r.fmt.clone().mergeFrom(f) });
        if (e < b) out.push({ text: r.text.slice(e - a), fmt: r.fmt });
      }
      this._runs = out;
    }
    this.invalidate();
  }

  getTextFormat(begin = -1, _end = -1): TextFormat {
    if (!this._runs.length) return this._defaultFormat.clone();
    let pos = 0;
    for (const r of this._runs) {
      if (begin < 0 || begin < pos + r.text.length) return r.fmt.clone();
      pos += r.text.length;
    }
    return this._runs[this._runs.length - 1].fmt.clone();
  }

  get autoSize(): string { return this._autoSize; }
  set autoSize(v: string) { this._autoSize = String(v || 'none').toLowerCase(); this.invalidate(); }
  get wordWrap(): boolean { return this._wordWrap; }
  set wordWrap(v: boolean) { this._wordWrap = v === true || (v as unknown) === 'true'; this.invalidate(); }
  get multiline(): boolean { return this._multiline; }
  set multiline(v: boolean) { this._multiline = v === true || (v as unknown) === 'true'; this.invalidate(); }
  get type(): string { return this._type; }
  set type(v: string) { this._type = v; }

  override get width(): number { this.layoutNow(); return this._fieldW * Math.abs(this.scale.x); }
  override set width(v: number) { this._fieldW = Number(v) / (Math.abs(this.scale.x) || 1); this.invalidate(); }
  override get height(): number { this.layoutNow(); return this._fieldH * Math.abs(this.scale.y); }
  override set height(v: number) { this._fieldH = Number(v) / (Math.abs(this.scale.y) || 1); this.invalidate(); }

  get textColor(): number { return this._defaultFormat.color ?? 0; }
  set textColor(v: number) {
    const f = new TextFormat();
    f.color = Number(v);
    this.setTextFormat(f);
    this._defaultFormat.color = Number(v);
  }

  private _fieldRect?: Rectangle;
  fieldBounds(): Rectangle {
    this.layoutNow();
    const r = (this._fieldRect ??= new Rectangle());
    r.x = 0;
    r.y = 0;
    r.width = Math.max(0, this._fieldW);
    r.height = Math.max(0, this._fieldH);
    return r;
  }

  get textWidth(): number { this.layoutNow(); return this._textW; }
  get textHeight(): number { this.layoutNow(); return this._textH; }
  get numLines(): number { this.layoutNow(); return Math.max(1, this._lines.length); }
  get maxScrollV(): number { return 1; }
  get bottomScrollV(): number { return this.numLines; }

  getCharIndexAtPoint(x: number, _y: number): number {
    this.layoutNow();
    let pos = 0;
    let acc = GUTTER;
    for (const p of this._lines[0]?.pieces ?? []) {
      for (const ch of p.text) {
        const w = measure(ch, p.fmt);
        if (acc + w > x) return pos;
        acc += w;
        pos++;
      }
    }
    return pos;
  }

  caretIndex = 0;
  selectionBeginIndex = 0;
  selectionEndIndex = 0;
  scrollH = 0;
  alwaysShowSelection = false;
  useRichTextClipboard = false;
  styleSheet: unknown = null;
  gridFitType = 'pixel';
  textInteractionMode = 'normal';
  get maxScrollH(): number { this.layoutNow(); return Math.max(0, Math.ceil(this._textW + GUTTER * 2 - this._fieldW)); }

  private lineTexts(): string[] { this.layoutNow(); return this._lines.map((l) => l.pieces.map((p) => p.text).join('')); }
  getLineText(i: number): string {
    const t = this.lineTexts();
    if (i < 0 || i >= Math.max(1, t.length)) throw new RangeError('Error #2006: The supplied index is out of bounds.');
    return t[i] ?? '';
  }
  getLineLength(i: number): number { return this.getLineText(i).length; }
  getLineOffset(i: number): number { return this.lineTexts().slice(0, i).reduce((a, s) => a + s.length, 0); }
  getLineIndexOfChar(ci: number): number {
    let acc = 0;
    const t = this.lineTexts();
    for (let i = 0; i < t.length; i++) { acc += t[i].length; if (ci < acc) return i; }
    return -1;
  }
  getLineIndexAtPoint(_x: number, y: number): number {
    this.layoutNow();
    let top = GUTTER;
    for (let i = 0; i < this._lines.length; i++) {
      const l = this._lines[i];
      const h = l.ascent + l.descent + l.leading;
      if (y >= top && y < top + h) return i;
      top += h;
    }
    return -1;
  }
  getLineMetrics(i: number): { x: number; width: number; height: number; ascent: number; descent: number; leading: number } {
    this.layoutNow();
    const l = this._lines[i];
    if (!l) {
      const m = fontMetrics(this._defaultFormat);
      return { x: GUTTER, width: 0, height: m.ascent + m.descent, ascent: m.ascent, descent: m.descent, leading: 0 };
    }
    return { x: GUTTER + l.indent, width: l.w, height: l.ascent + l.descent + l.leading, ascent: l.ascent, descent: l.descent, leading: l.leading };
  }
  getCharBoundaries(ci: number): Rectangle | null {
    this.layoutNow();
    let idx = 0, top = GUTTER;
    for (const l of this._lines) {
      let x = GUTTER + l.indent;
      for (const p of l.pieces) {
        for (const ch of p.text) {
          const w = measure(ch, p.fmt);
          if (idx === ci) return new Rectangle(x, top, w, l.ascent + l.descent);
          x += w;
          idx++;
        }
      }
      top += l.ascent + l.descent + l.leading;
    }
    return null;
  }
  getFirstCharInParagraph(ci: number): number { const t = this.text; const k = t.lastIndexOf('\n', ci - 1); return k + 1; }
  getParagraphLength(ci: number): number {
    const t = this.text;
    const a = this.getFirstCharInParagraph(ci);
    const b = t.indexOf('\n', a);
    return (b < 0 ? t.length : b + 1) - a;
  }
  setSelection(begin: number, end: number): void { this.selectionBeginIndex = begin; this.selectionEndIndex = end; this.caretIndex = end; }
  replaceText(begin: number, end: number, newText: string): void {
    const t = this.text;
    this.text = t.slice(0, begin) + String(newText ?? '') + t.slice(end);
  }
  replaceSelectedText(v: string): void { this.replaceText(this.selectionBeginIndex, this.selectionEndIndex, v); }
  getRawText(): string { return this.text; }
  getImageReference(_id: string): unknown { return null; }
  getTextRuns(): unknown[] { return []; }
  insertXMLText(): void {}
  copyRichText(): string { return this.text; }
  pasteRichText(_s: string): boolean { return false; }
  static isFontCompatible(): boolean { return true; }

  private invalidate(): void { this.dirty = true; this.laidOut = false; }
  private laidOut = false;

  private layoutNow(): void {
    if (this.laidOut) return;
    this.layout();
    this.laidOut = true;
  }

  private layout(): void {
    const wrapWidth = this._fieldW - GUTTER * 2;
    const lines: Line[] = [];
    const runs = this.displayAsPassword ? this._runs.map((r) => ({ ...r, text: '*'.repeat(r.text.length) })) : this._runs;
    const newLine = (fmt: TextFormat): Line => {
      const m = fontMetrics(fmt);
      return { pieces: [], w: 0, ascent: m.ascent, descent: m.descent, leading: fmt.leading ?? 0,
        align: fmt.align ?? 'left', indent: (fmt.indent ?? 0) + (fmt.leftMargin ?? 0) };
    };
    let line = newLine(runs[0]?.fmt ?? this._defaultFormat);
    const push = (text: string, fmt: TextFormat) => {
      if (!text) return;
      const w = measure(text, fmt);
      const m = fontMetrics(fmt);
      line.ascent = Math.max(line.ascent, m.ascent);
      line.descent = Math.max(line.descent, m.descent);
      line.leading = Math.max(line.leading, fmt.leading ?? 0);
      const last = line.pieces[line.pieces.length - 1];
      if (last && last.fmt === fmt) { last.text += text; last.w += w; } else line.pieces.push({ text, fmt, w });
      line.w += w;
    };
    const breakLine = (fmt: TextFormat) => { lines.push(line); line = newLine(fmt); };
    const allowBreak = this._multiline || this._html;

    for (const run of runs) {
      const parts = run.text.split('\n');
      parts.forEach((part, pi) => {
        if (pi > 0) {
          if (allowBreak || this._wordWrap) breakLine(run.fmt);
        }
        if (!this._wordWrap) { push(part, run.fmt); return; }
        const tokens = part.match(/\S+\s*|\s+/g) ?? [];
        for (const tok of tokens) {
          const tw = measure(tok, run.fmt);
          const limit = wrapWidth - line.indent - (run.fmt.rightMargin ?? 0);
          if (line.w + tw > limit && line.w > 0) {
            breakLine(run.fmt);
            push(tok.replace(/^\s+/, ''), run.fmt);
          } else if (tw > limit) {
            for (const ch of tok) {
              if (line.w + measure(ch, run.fmt) > limit && line.w > 0) breakLine(run.fmt);
              push(ch, run.fmt);
            }
          } else {
            push(tok, run.fmt);
          }
        }
      });
    }
    lines.push(line);
    this._lines = lines;
    this._textW = Math.max(0, ...lines.map((l) => l.w + l.indent));
    let h = 0;
    lines.forEach((l, i) => { h += l.ascent + l.descent + (i < lines.length - 1 ? l.leading : 0); });
    this._textH = this.text.length ? h : 0;

    if (this._autoSize !== 'none') {
      const oldW = this._fieldW;
      if (!this._wordWrap) {
        this._fieldW = Math.ceil(this._textW + GUTTER * 2);
        if (this._autoSize === 'center') this.x += (oldW - this._fieldW) / 2;
        else if (this._autoSize === 'right') this.x += oldW - this._fieldW;
      }
      this._fieldH = Math.ceil(Math.max(this._textH, lines[0].ascent + lines[0].descent) + GUTTER * 2);
    }
  }

  override destroy(options?: Parameters<Container['destroy']>[0]): void {
    const tex = this.sprite.texture;
    super.destroy(options);
    if (tex && tex !== Texture.EMPTY) tex.destroy(true);
  }

  private render(): void {
    this.layoutNow();
    this.dirty = false;
    const w = Math.max(1, Math.ceil(this._fieldW));
    const h = Math.max(1, Math.ceil(this._fieldH));
    const canvas = document.createElement('canvas');
    canvas.width = w * RES;
    canvas.height = h * RES;
    const c = canvas.getContext('2d')!;
    c.scale(RES, RES);
    if (this.background) { c.fillStyle = cssColor(this.backgroundColor); c.fillRect(0, 0, w, h); }
    c.textBaseline = 'alphabetic';
    let y = GUTTER;
    for (const line of this._lines) {
      const avail = w - GUTTER * 2;
      let x = GUTTER + line.indent;
      if (line.align === 'center') x = GUTTER + (avail - line.w) / 2;
      else if (line.align === 'right') x = GUTTER + avail - line.w;
      const base = y + line.ascent;
      for (const p of line.pieces) {
        c.font = cssFont(p.fmt);
        (c as any).letterSpacing = `${p.fmt.letterSpacing ?? 0}px`;
        c.fillStyle = cssColor(p.fmt.color);
        c.fillText(p.text, x, base);
        if (p.fmt.underline) c.fillRect(x, base + 1, p.w, 1);
        x += p.w;
      }
      y += line.ascent + line.descent + line.leading;
    }
    if (this.border) { c.strokeStyle = cssColor(this.borderColor); c.lineWidth = 1; c.strokeRect(0.5, 0.5, w - 1, h - 1); }
    const old = this.sprite.texture;
    this.sprite.texture = new Texture({ source: new CanvasSource({ resource: canvas, resolution: RES }) });
    if (old !== Texture.EMPTY) old.destroy(true);
  }
}

Object.defineProperty(TextField.prototype, 'boundsArea', {
  configurable: true,
  get(this: TextField) { return this.fieldBounds(); },
  set(_v: unknown) { },
});
