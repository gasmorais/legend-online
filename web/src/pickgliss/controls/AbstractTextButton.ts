import type { Container } from 'pixi.js';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils } from '../utils/DisplayUtils';
import { BaseButton } from './BaseButton';

export class AbstractTextButton extends BaseButton {
  static readonly P_backOuterRect = 'backOuterRect';
  static readonly P_text = 'text';
  static readonly P_textField = 'textField';
  enableHtml = false;
  textFrameChange = true;
  protected _backgoundInnerRect: InnerRectangle = new InnerRectangle(0, 0, 0, 0, -1);
  protected _backgoundInnerRectString = '';
  protected _text = '';
  protected _textField: Container | null = null;
  protected _textStyle = '';

  get backgoundInnerRectString(): string { return this._backgoundInnerRectString; }
  set backgoundInnerRectString(v: string) {
    if (this._backgoundInnerRectString === v) return;
    this._backgoundInnerRectString = v;
    this._backgoundInnerRect = InnerRectangle.parse(v) ?? new InnerRectangle(0, 0, 0, 0, -1);
    this.onPropertiesChanged('backOuterRect');
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
    if (this.enableHtml) tf.htmlText = this._text;
    else tf.text = this._text;
    if (this._autoSizeAble) {
      const r = this._backgoundInnerRect.getInnerRect(tf.width, tf.height);
      this._width = r.width;
      this._height = r.height;
    }
    tf.x = this._backgoundInnerRect.para1;
    tf.y = this._backgoundInnerRect.para3;
    if (this._back) {
      this._back.width = this._width;
      this._back.height = this._height;
    }
  }

  override setFrame(frame: number): void {
    super.setFrame(frame);
    if (this.textFrameChange) DisplayUtils.setFrame(this._textField, frame);
  }
}

Domain.registerClass('com.pickgliss.ui.controls.AbstractTextButton', AbstractTextButton);
