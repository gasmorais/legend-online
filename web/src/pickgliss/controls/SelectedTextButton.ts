import type { Container } from 'pixi.js';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { SelectedButton } from './SelectedButton';

export class SelectedTextButton extends SelectedButton {
  static readonly P_backgoundInnerRect = 'backgoundInnerRect';
  static readonly P_text = 'text';
  static readonly P_textField = 'textField';
  protected _textField: Container | null = null;
  protected _text = '';
  protected _textStyle = '';
  protected _backgoundInnerRect: InnerRectangle = new InnerRectangle(0, 0, 0, 0, -1);
  protected _backgoundInnerRectString = '';

  get backgoundInnerRectString(): string { return this._backgoundInnerRectString; }
  set backgoundInnerRectString(v: string) {
    if (this._backgoundInnerRectString === v) return;
    this._backgoundInnerRectString = v;
    this._backgoundInnerRect = InnerRectangle.parse(v) ?? new InnerRectangle(0, 0, 0, 0, -1);
    this.onPropertiesChanged('backgoundInnerRect');
  }

  override dispose(): void {
    if (this._textField) disposeObject(this._textField);
    this._textField = null;
    super.dispose();
  }

  get text(): string { return this._text; }
  set text(v: string) {
    v = v == null ? '' : String(v);
    if (this._text === v) return;
    this._text = v;
    this.onPropertiesChanged('text');
  }

  get textField(): Container | null { return this._textField; }
  set textField(v: Container | null) {
    if (this._textField === v) return;
    disposeObject(this._textField);
    this._textField = v;
    this.onPropertiesChanged('textField');
  }

  get textStyle(): string { return this._textStyle; }
  set textStyle(v: string) {
    if (this._textStyle === v) return;
    this._textStyle = v;
    this.textField = ComponentFactory.Instance.creat(this._textStyle);
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._textField) this.addChild(this._textField);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const tf = this._textField as any;
    if (!tf) return;
    tf.text = this._text;
    const sel = this._selectedButton, unsel = this._unSelectedButton;
    if (this._autoSizeAble) {
      const r = this._backgoundInnerRect.getInnerRect(tf.width, tf.height);
      if (unsel) unsel.width = r.width;
      if (sel) sel.width = r.width;
      this._width = r.width;
      if (unsel) unsel.height = r.height;
      this._height = r.height;
      tf.x = this._backgoundInnerRect.para1;
      tf.y = this._backgoundInnerRect.para3;
    } else {
      if (unsel) unsel.width = this._width;
      if (sel) sel.width = this._width;
      if (unsel) unsel.height = this._height;
      if (sel) sel.height = this._height;
      tf.x = (this._width - tf.width) / 2;
      tf.y = (this._height - tf.height) / 2;
    }
  }
}

Domain.registerClass('com.pickgliss.ui.controls.SelectedTextButton', SelectedTextButton);
