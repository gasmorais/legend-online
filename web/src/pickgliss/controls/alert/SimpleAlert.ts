import { Domain } from '@/flash/library';
import type { TextField } from '@/flash/text';
import { ComponentFactory } from '../../ComponentFactory';
import { InnerRectangle } from '../../geom/InnerRectangle';
import { disposeObject } from '../../ObjectUtils';
import type { FilterFrameText } from '../../text/FilterFrameText';
import { DisplayUtils, toInt, toNum } from '../../utils/DisplayUtils';
import { BaseAlerFrame } from './BaseAlerFrame';

export class SimpleAlert extends BaseAlerFrame {
  static readonly P_frameInnerRect = 'frameInnerRect';
  static readonly P_frameMiniH = 'frameMiniH';
  static readonly P_frameMiniW = 'frameMiniW';
  static readonly P_textField = 'textFieldStyle';
  static readonly P_smallTip = 'smallTipStyle';
  protected _frameMiniH = -2147483648;
  protected _frameMiniW = -2147483648;
  protected _textField: TextField | null = null;
  protected _textFieldStyle = '';
  protected _smallTipTxt: FilterFrameText | null = null;
  protected _smallTipStyle = '';
  protected _frameInnerRect: InnerRectangle | null = null;
  private _frameInnerRectString = '';
  protected _maxTextWidth = 0;

  override dispose(): void {
    if (this._textField) disposeObject(this._textField);
    this._textField = null;
    this._frameInnerRect = null;
    if (this._smallTipTxt) {
      this._smallTipTxt.off('link', this.__tipLinkHandler, this);
      disposeObject(this._smallTipTxt);
      this._smallTipTxt = null;
    }
    super.dispose();
  }

  get frameInnerRectString(): string { return this._frameInnerRectString; }
  set frameInnerRectString(v: string) {
    if (this._frameInnerRectString === v) return;
    this._frameInnerRectString = v;
    this._frameInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('frameInnerRect');
  }

  get frameMiniH(): number { return this._frameMiniH; }
  set frameMiniH(v: number) {
    v = toInt(v);
    if (this._frameMiniH === v) return;
    this._frameMiniH = v;
    this.onPropertiesChanged('frameMiniH');
  }

  get frameMiniW(): number { return this._frameMiniW; }
  set frameMiniW(v: number) {
    v = toInt(v);
    if (this._frameMiniW === v) return;
    this._frameMiniW = v;
    this.onPropertiesChanged('frameMiniW');
  }

  get textStyle(): string { return this._textFieldStyle; }
  set textStyle(v: string) {
    if (this._textFieldStyle === v) return;
    if (this._textField) disposeObject(this._textField);
    this._textFieldStyle = v;
    this._textField = ComponentFactory.Instance.creat(this._textFieldStyle);
    this.onPropertiesChanged('textFieldStyle');
  }

  get smallTipStyle(): string { return this._smallTipStyle; }
  set smallTipStyle(v: string) {
    if (this._smallTipStyle === v) return;
    this._smallTipStyle = v;
    if (this._smallTipTxt) {
      this._smallTipTxt.off('link', this.__tipLinkHandler, this);
      disposeObject(this._smallTipTxt);
      this._smallTipTxt = null;
    }
    this._smallTipTxt = ComponentFactory.Instance.creat(this._smallTipStyle);
    this._smallTipTxt?.on('link', this.__tipLinkHandler, this);
    this.onPropertiesChanged('smallTipStyle');
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._textField) this.addChild(this._textField);
    if (this._smallTipTxt) this.addChild(this._smallTipTxt);
  }

  get maxTextWidth(): number { return this._maxTextWidth; }
  set maxTextWidth(v: number) {
    this.beginChanges();
    this._maxTextWidth = toNum(v);
    this._changedPropeties.info = true;
    this.commitChanges();
  }

  protected layoutFrameRect(): void {
    const tf = this._textField!;
    const fr = this._frameInnerRect!;
    if (this._maxTextWidth > 0 && tf.width > this._maxTextWidth) tf.width = this._maxTextWidth;
    const r = fr.getInnerRect(tf.width, tf.height);
    if (r.width > this._frameMiniW) {
      tf.x = fr.para1;
      this._width = r.width;
    } else {
      tf.x = fr.para1 + (this._frameMiniW - r.width) / 2;
      this._width = this._frameMiniW;
    }
    tf.y = 30;
    const h = tf.numLines * 23 + 114;
    this._height = h > this._frameMiniH ? h : this._frameMiniH;
    if (this._smallTipTxt) {
      this._smallTipTxt.width = tf.width;
      this._smallTipTxt.x = tf.x + (tf.width - this._smallTipTxt.width) / 2;
      this._smallTipTxt.y = tf.y + tf.height - 5;
    }
  }

  protected override onProppertiesUpdate(): void {
    if (this._changedPropeties.info) {
      this.updateMsg();
      if (this._frameInnerRect) {
        this.layoutFrameRect();
        this._changedPropeties.width = true;
        this._changedPropeties.height = true;
      }
    }
    super.onProppertiesUpdate();
  }

  protected updateMsg(): void {
    const tf = this._textField;
    const info = this._info;
    if (!tf || !info) return;
    tf.autoSize = 'left';
    if (info.mutiline) {
      tf.multiline = true;
      if (!info.enableHtml) tf.wordWrap = true;
      if (info.textShowWidth > 0) tf.width = info.textShowWidth;
      else tf.width = DisplayUtils.getTextFieldMaxLineWidth(String(info.data), tf.defaultTextFormat, info.enableHtml);
    }
    if (info.enableHtml) tf.htmlText = String(info.data) + '';
    else tf.text = String(info.data);
    if (this._smallTipTxt) {
      this._smallTipTxt.width = tf.width;
      this._smallTipTxt.htmlText = info.smallTip;
    }
  }

  protected __tipLinkHandler(): void {
    if (this._info && this._info.smallTipCall) {
      this._info.smallTipCall();
      this.dispose();
    }
  }
}

Domain.registerClass('com.pickgliss.ui.controls.alert.SimpleAlert', SimpleAlert);
