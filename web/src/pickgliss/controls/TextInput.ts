import type { Container } from 'pixi.js';
import { setFlashFilters } from '@/flash/display';
import type { FlashFilterDef } from '@/flash/filters';
import { Domain } from '@/flash/library';
import type { TextField } from '@/flash/text';
import { ComponentFactory } from '../ComponentFactory';
import { Component } from '../core/Component';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { StageReferance } from '../toplevel/StageReferance';
import { DisplayUtils, toBool, toNum } from '../utils/DisplayUtils';

export class TextInput extends Component {
  static readonly P_back = 'back';
  static readonly P_focusBack = 'focusBack';
  static readonly P_focusBackgoundInnerRect = 'focusBackOuterRect';
  static readonly P_textField = 'textField';
  static readonly P_textInnerRect = 'textInnerRect';
  static readonly P_backgroundColor = 'backgroundColor';
  static readonly P_enable = 'enable';
  protected _back: Container | null = null;
  protected _backStyle = '';
  protected _focusBack: Container | null = null;
  protected _focusBackgoundInnerRect: InnerRectangle | null = null;
  protected _focusBackgoundInnerRectString = '';
  protected _focusBackStyle = '';
  protected _textField: TextField | null = null;
  protected _textInnerRect: InnerRectangle | null = null;
  protected _textInnerRectString = '';
  protected _textStyle = '';
  protected _backgroundColor = 0;
  protected _filterString = '';
  protected _frameFilter: (FlashFilterDef[] | null)[] | null = null;
  protected _enable = true;
  protected _currentFrameIndex = 1;

  set back(v: Container | null) {
    if (this._back === v) return;
    disposeObject(this._back);
    this._back = v;
    this.onPropertiesChanged('back');
  }
  get back(): Container | null { return this._back; }

  get backStyle(): string { return this._backStyle; }
  set backStyle(v: string) {
    if (this._backStyle === v) return;
    this._backStyle = v;
    this.back = ComponentFactory.Instance.creat(this._backStyle);
  }

  get backgroundColor(): number { return this._backgroundColor; }
  set backgroundColor(v: number) {
    v = toNum(v) >>> 0;
    if (this._back || !v) return;
    this._backgroundColor = v;
    this.onPropertiesChanged('backgroundColor');
  }

  get filterString(): string { return this._filterString; }
  set filterString(v: string) {
    if (this._filterString === v) return;
    this._filterString = v;
    this._frameFilter = ComponentFactory.Instance.creatFrameFilters(this._filterString);
  }

  get enable(): boolean { return this._enable; }
  set enable(v: boolean) {
    v = toBool(v);
    if (this._enable === v) return;
    this._enable = v;
    this.onPropertiesChanged('enable');
  }

  protected setFrame(frame: number): void {
    this._currentFrameIndex = frame;
    DisplayUtils.setFrame(this._back, this._currentFrameIndex);
    if (!this._frameFilter || frame <= 0 || frame > this._frameFilter.length) return;
    setFlashFilters(this, this._frameFilter[frame - 1]);
  }

  override dispose(): void {
    disposeObject(this._back);
    this._back = null;
    disposeObject(this._focusBack);
    this._focusBack = null;
    disposeObject(this._textField);
    this._textField = null;
    this.graphics.clear();
    super.dispose();
  }

  set focusBack(v: Container | null) {
    if (this._focusBack === v) return;
    disposeObject(this._focusBack);
    this._focusBack = v;
    if (v) v.visible = false;
    this.onPropertiesChanged();
  }
  get focusBack(): Container | null { return this._focusBack; }

  get focusBackgoundInnerRectString(): string { return this._focusBackgoundInnerRectString; }
  set focusBackgoundInnerRectString(v: string) {
    if (this._focusBackgoundInnerRectString === v) return;
    this._focusBackgoundInnerRectString = v;
    this._focusBackgoundInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('focusBackOuterRect');
  }

  get focusBackStyle(): string { return this._focusBackStyle; }
  set focusBackStyle(v: string) {
    if (this._focusBackStyle === v) return;
    this._focusBackStyle = v;
    this.focusBack = ComponentFactory.Instance.creat(this._focusBackStyle);
  }

  get textField(): TextField | null { return this._textField; }
  set textField(v: TextField | null) {
    if (this._textField === v) return;
    disposeObject(this._textField);
    this._textField = v;
    this.onPropertiesChanged('textField');
  }

  get textInnerRectString(): string { return this._textInnerRectString; }
  set textInnerRectString(v: string) {
    if (this._textInnerRectString === v) return;
    this._textInnerRectString = v;
    this._textInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('textInnerRect');
  }

  get textStyle(): string { return this._textStyle; }
  set textStyle(v: string) {
    if (this._textStyle === v) return;
    this._textStyle = v;
    this.textField = ComponentFactory.Instance.creat(this._textStyle);
  }

  protected __onFocusText(e: { type: string }): void {
    if (this._focusBack) this._focusBack.visible = e.type === 'focusIn';
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._back) this.addChild(this._back);
    if (this._focusBack) this.addChild(this._focusBack);
    if (this._textField) this.addChild(this._textField);
  }

  get displayAsPassword(): boolean { return this._textField?.displayAsPassword ?? false; }
  set displayAsPassword(v: boolean) { if (this._textField) this._textField.displayAsPassword = toBool(v); }
  get multiline(): boolean { return this._textField?.multiline ?? false; }
  set multiline(v: boolean) { if (this._textField) this._textField.multiline = v; }
  get maxChars(): number { return this._textField?.maxChars ?? 0; }
  set maxChars(v: number) { if (this._textField) this._textField.maxChars = toNum(v) | 0; }
  get autoSize(): string { return this._textField?.autoSize ?? 'none'; }
  set autoSize(v: string) { if (this._textField) this._textField.autoSize = v; }
  get text(): string { return this._textField?.text ?? ''; }
  set text(v: string) { if (this._textField) this._textField.text = v; }

  setFocus(): void { StageReferance.focus = this._textField; }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    const tf = this._textField;
    if (ch.textField && tf) {
      tf.type = 'input';
      tf.wordWrap = true;
    }
    if (tf) {
      if (this._back) {
        this._back.width = this._width;
        this._back.height = this._height;
        if (this._textInnerRect) {
          const r = this._textInnerRect.getInnerRect(this._width, this._height);
          tf.width = r.width;
          tf.height = r.height;
          tf.x = r.x;
          tf.y = r.y;
        }
        if (this._focusBack) {
          DisplayUtils.layoutDisplayWithInnerRect(this._focusBack, this._focusBackgoundInnerRect, this._width, this._height);
        }
      } else {
        tf.width = this._width;
        tf.height = this._height;
      }
    }
    if (ch.backgroundColor) {
      this.graphics.beginFill(this._backgroundColor);
      this.graphics.drawRect(0, 0, this._width, this._height);
      this.graphics.endFill();
    }
    if (ch.enable) {
      this.mouseChildren = this.mouseEnabled = this._enable;
      this.setFrame(this._enable ? 1 : 2);
    }
  }
}

Domain.registerClass('com.pickgliss.ui.controls.TextInput', TextInput);
