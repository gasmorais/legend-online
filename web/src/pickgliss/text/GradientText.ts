import { Color, FillGradient, Graphics, type Sprite } from 'pixi.js';
import { setFlashFilters } from '@/flash/display';
import type { FlashFilterDef } from '@/flash/filters';
import { Domain } from '@/flash/library';
import { TextFormat, type TextField } from '@/flash/text';
import { ComponentFactory } from '../ComponentFactory';
import { Component } from '../core/Component';
import { disposeObject } from '../ObjectUtils';
import { toInt, toNum } from '../utils/DisplayUtils';

export class GradientText extends Component {
  static readonly P_alpha = 'alpha';
  static readonly P_color = 'color';
  static readonly P_frameFilters = 'frameFilters';
  static readonly P_ratio = 'ratio';
  static readonly P_textField = 'textField';
  static readonly P_size = 'textSize';
  protected _filterString = '';
  protected _frameFilter: (FlashFilterDef[] | null)[] | null = null;
  private _colorStyle = '';
  private _alphaStyle = '';
  private _ratioStyle = '';
  private _colors: string[][] = [];
  private _alphas: string[] = [];
  private _ratios: string[] = [];
  private _gradientRotation = 90;
  private _currentFrame = 1;
  private _gradientBox: Graphics | null = null;
  private _gradient: FillGradient | null = null;
  private _textField: TextField | null = null;
  private _textFieldStyle = '';
  private _textSize = 0;

  get gradientRotation(): number { return this._gradientRotation; }
  set gradientRotation(v: number) { this._gradientRotation = toNum(v); }

  get colors(): string { return this._colorStyle; }
  set colors(v: string) {
    if (v === this._colorStyle) return;
    this._colorStyle = v;
    this._colors = this._colorStyle.split('|').map((s) => s.split(','));
    this.onPropertiesChanged('color');
  }

  get alphas(): string { return this._alphaStyle; }
  set alphas(v: string) {
    if (v === this._alphaStyle) return;
    this._alphaStyle = v;
    this._alphas = this._alphaStyle.split(',');
    this.onPropertiesChanged('alpha');
  }

  get ratios(): string { return this._ratioStyle; }
  set ratios(v: string) {
    if (v === this._ratioStyle) return;
    this._ratioStyle = v;
    this._ratios = this._ratioStyle.split(',');
    this.onPropertiesChanged('ratio');
  }

  get filterString(): string { return this._filterString; }
  set filterString(v: string) {
    if (this._filterString === v) return;
    this._filterString = v;
    this.frameFilters = ComponentFactory.Instance.creatFrameFilters(this._filterString);
  }

  get frameFilters(): (FlashFilterDef[] | null)[] | null { return this._frameFilter; }
  set frameFilters(v: (FlashFilterDef[] | null)[] | null) {
    if (this._frameFilter === v) return;
    this._frameFilter = v;
    this.onPropertiesChanged('frameFilters');
  }

  get text(): string { return this._textField?.text ?? ''; }
  set text(v: string) {
    if (this._textField) this._textField.text = v;
    this.refreshBox();
  }

  get htmlText(): string { return this._textField?.htmlText ?? ''; }
  set htmlText(v: string) {
    if (this._textField) this._textField.htmlText = v;
    this.refreshBox();
  }

  get textSize(): number { return this._textSize; }
  set textSize(v: number) {
    v = toInt(v);
    if (this._textSize === v) return;
    this._textSize = v;
    this.onPropertiesChanged('textSize');
  }

  get textField(): TextField | null { return this._textField; }
  set textField(v: TextField | null) {
    if (this._textField === v) return;
    this._textField = v;
    this._textSize = toInt(v?.defaultTextFormat.size ?? 0);
    this.onPropertiesChanged('textField');
  }

  get textFieldStyle(): string { return this._textFieldStyle; }
  set textFieldStyle(v: string) {
    if (v === this._textFieldStyle) return;
    this._textFieldStyle = v;
    this.textField = ComponentFactory.Instance.creat(this._textFieldStyle);
  }

  protected override addChildren(): void {
    const tf = this._textField;
    if (tf) this.addChild(tf);
    if (this._gradientBox && tf) {
      this._gradientBox.x = tf.x;
      this._gradientBox.y = tf.y;
      this.addChild(this._gradientBox);
      const glyphs = (tf as unknown as { sprite?: Sprite }).sprite;
      this._gradientBox.mask = glyphs ?? tf;
    }
  }

  override get width(): number { return this._textField?.width ?? 0; }
  override set width(v: number) { super.width = v; }

  get textWidth(): number { return this._textField?.textWidth ?? 0; }

  getCharIndexAtPoint(x: number, y: number): number { return this._textField?.getCharIndexAtPoint(x, y) ?? -1; }

  setFrame(frame: number): void {
    if (this._currentFrame === frame) return;
    this._currentFrame = frame;
    this.refreshBox();
    setFlashFilters(this, this._frameFilter?.[frame - 1] ?? null);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.textField || ch.color || ch.alpha || ch.ratio || ch.textSize) this.refreshBox();
    if (ch.frameFilters) setFlashFilters(this, this._frameFilter?.[0] ?? null);
  }

  override dispose(): void {
    if (this._textField) disposeObject(this._textField);
    this._textField = null;
    if (this._gradientBox) {
      this._gradientBox.mask = null;
      this._gradientBox.parent?.removeChild(this._gradientBox);
      this._gradientBox.destroy();
    }
    this._gradientBox = null;
    this._gradient?.destroy();
    this._gradient = null;
    super.dispose();
  }

  private refreshBox(): void {
    const tf = this._textField;
    if (!tf) return;
    if (this._textSize > 0) {
      const fmt = new TextFormat();
      fmt.size = this._textSize;
      tf.setTextFormat(fmt);
    }
    if (tf.textWidth > tf.width) {
      tf.width = tf.textWidth + 8;
      this._width = tf.width;
    }
    if (!this._gradientBox) this._gradientBox = new Graphics();
    const colors = this._colors[this._currentFrame - 1] ?? [];
    const stops = colors.map((c, i) => {
      const n = /^0x/i.test(c.trim()) ? parseInt(c.trim(), 16) : Number(c);
      const a = Number(this._alphas[i] ?? 1);
      const r = Number(this._ratios[i] ?? (colors.length > 1 ? (255 * i) / (colors.length - 1) : 0));
      return { offset: Math.min(1, Math.max(0, r / 255)), color: new Color(n || 0).setAlpha(Number.isNaN(a) ? 1 : a) };
    });
    const old = this._gradient;
    this._gradient = stops.length
      ? new FillGradient({ type: 'linear', start: { x: 0, y: 0 }, end: { x: 0, y: 1 }, colorStops: stops, textureSpace: 'local' })
      : null;
    const g = this._gradientBox;
    g.clear();
    old?.destroy();
    const w = tf.width, h = tf.height;
    if (w > 0 && h > 0) {
      g.rect(0, 0, w, h);
      if (this._gradient) g.fill(this._gradient);
      else g.fill({ color: 0xffffff });
    }
  }
}

Domain.registerClass('com.pickgliss.ui.text.GradientText', GradientText);
