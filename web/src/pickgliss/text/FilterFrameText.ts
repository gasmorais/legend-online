import { setFlashFilters } from '@/flash/display';
import type { FlashFilterDef } from '@/flash/filters';
import { Domain } from '@/flash/library';
import { TextField, TextFormat } from '@/flash/text';
import { ComponentFactory } from '../ComponentFactory';
import { parasArgs } from '../ComponentModel';

export class FilterFrameText extends TextField {
  static P_frameFilters = 'frameFilters';
  id = -1;
  stylename = '';
  protected _currentFrameIndex = 1;
  protected _filterString = '';
  protected _frameFilter: (FlashFilterDef[] | null)[] | null = null;
  protected _frameTextFormat: TextFormat[] = [];
  protected _isAutoFitLength = false;
  protected _fw = NaN;
  protected _fh = NaN;
  protected _isHaveMaxWidth = false;
  protected _isHaveMaxHeight = false;
  protected _autoDisplay = true;
  protected _textFormatStyle = '';

  constructor() {
    super();
    this.autoSize = 'left';
    this.eventMode = 'passive';
  }

  get totalFrame(): number { return this._frameTextFormat.length; }

  dispose(): void {
    this._frameFilter = null;
    this.parent?.removeChild(this);
    ComponentFactory.Instance.removeComponent(this.id);
  }

  get filterString(): string { return this._filterString; }
  set filterString(v: string) {
    if (this._filterString === v) return;
    this._filterString = v;
    this._frameFilter = ComponentFactory.Instance.creatFrameFilters(v);
    this.setFrame(1);
  }

  get frameFilters(): (FlashFilterDef[] | null)[] | null { return this._frameFilter; }
  set frameFilters(v: (FlashFilterDef[] | null)[] | null) { this._frameFilter = v; }

  get isAutoFitLength(): boolean { return this._isAutoFitLength; }
  set isAutoFitLength(v: boolean) { this._isAutoFitLength = v === true || (v as unknown) === 'true'; }
  get autoDisplay(): boolean { return this._autoDisplay; }
  set autoDisplay(v: boolean) { this._autoDisplay = v === true || (v as unknown) === 'true'; }
  get mouseEnabled(): boolean { return this.eventMode !== 'passive' && this.eventMode !== 'none'; }
  set mouseEnabled(v: boolean) { this.eventMode = v ? 'static' : 'passive'; }

  setFrame(frame: number): void {
    this._currentFrameIndex = frame;
    if (this._frameFilter && this._frameFilter.length >= frame) setFlashFilters(this, this._frameFilter[frame - 1]);
    if (this._frameTextFormat.length >= frame) this.applyFormat(this._frameTextFormat[frame - 1]);
  }

  protected applyFormat(f: TextFormat): void {
    this.setTextFormat(f);
    this.defaultTextFormat = f;
  }

  get textFormatStyle(): string { return this._textFormatStyle; }
  set textFormatStyle(v: string) {
    if (this._textFormatStyle === v) return;
    this._textFormatStyle = v;
    this._frameTextFormat = parasArgs(v)
      .map((n) => ComponentFactory.Instance.model.getSet(n))
      .filter((f): f is TextFormat => f instanceof TextFormat);
    this.setFrame(1);
  }

  override get text(): string { return super.text; }
  override set text(v: string) {
    if (this.text === v) return;
    super.text = v ?? '';
    this.afterText();
  }

  override get htmlText(): string { return super.htmlText; }
  override set htmlText(v: string) {
    super.htmlText = v ?? '';
    this.afterText();
  }

  private afterText(): void {
    if (this._isAutoFitLength && this.textWidth > this.width) {
      const idx = this.getCharIndexAtPoint(this.width - 22, 5);
      super.text = this.text.substring(0, idx) + '...';
    }
    if ((this._fw > 0 || this._fh > 0) && this.wordWrap) super.width = this._fw;
    if (this._autoDisplay && this.type !== 'input') {
      if (!this._isHaveMaxWidth && !this.wordWrap && !this.multiline && this.textWidth > this.width) {
        super.width = this.textWidth + 8;
        this._isHaveMaxWidth = true;
      }
      if (!this._isHaveMaxHeight && this.textHeight > this.height) {
        super.height = this.textHeight + 8;
        this._isHaveMaxHeight = true;
      }
    }
    this.setFrame(this._currentFrameIndex);
  }

  override get width(): number { return super.width; }
  override set width(v: number) { this._fw = Number(v); super.width = v; }
  override get height(): number { return super.height; }
  override set height(v: number) { this._fh = Number(v); super.height = v; }

  override get type(): string { return super.type; }
  override set type(v: string) {
    if (v === 'input') this.mouseEnabled = true;
    super.type = v;
  }

  override removeFromParent(dispose = false): void {
    this.parent?.removeChild(this);
    if (dispose) this.dispose();
  }
}

Domain.registerClass('com.pickgliss.ui.text.FilterFrameText', FilterFrameText);
