import { listen } from '@/flash/events';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { DisplayObjectViewport } from '../controls/DisplayObjectViewport';
import { ScrollPanel } from '../controls/ScrollPanel';
import { IntPoint } from '../geom/IntGeom';
import { disposeObject } from '../ObjectUtils';
import { StageReferance } from '../toplevel/StageReferance';
import { toBool, toInt } from '../utils/DisplayUtils';
import type { FilterFrameText } from './FilterFrameText';

export class TextArea extends ScrollPanel {
  static readonly P_textField = 'textField';
  protected _currentTextHeight = 0;
  protected _enable = true;
  protected _textField: FilterFrameText | null = null;
  protected _textStyle = '';
  protected _limitLines = 2147483647;
  textString = '';

  constructor() {
    super();
    const vs = this._viewSource!;
    vs.on('pointertap', this.__onTextAreaClick, this);
    vs.on('pointerover', this.__onTextAreaOver, this);
    vs.on('pointerout', this.__onTextAreaOut, this);
  }

  override dispose(): void {
    const vs = this._viewSource;
    if (vs) {
      vs.cursor = 'default';
      vs.off('pointertap', this.__onTextAreaClick, this);
      vs.off('pointerover', this.__onTextAreaOver, this);
      vs.off('pointerout', this.__onTextAreaOut, this);
    }
    disposeObject(this._textField);
    this._textField = null;
    super.dispose();
  }

  get editable(): boolean { return this._textField?.type === 'input'; }
  set editable(v: boolean) {
    const vs = this._viewSource!;
    if (!this._textField) return;
    if (toBool(v)) {
      this._textField.type = 'input';
      listen(vs, 'pointerover', this.__onTextAreaOver, this);
      listen(vs, 'pointerout', this.__onTextAreaOut, this);
    } else {
      this._textField.type = 'dynamic';
      vs.off('pointerover', this.__onTextAreaOver, this);
      vs.off('pointerout', this.__onTextAreaOut, this);
    }
  }

  get enable(): boolean { return this._enable; }
  set enable(v: boolean) {
    this._enable = toBool(v);
    const vs = this._viewSource!;
    if (this._textField) this._textField.mouseEnabled = this._enable;
    vs.off('pointerover', this.__onTextAreaOver, this);
    vs.off('pointerout', this.__onTextAreaOut, this);
    if (this._enable) {
      vs.on('pointerover', this.__onTextAreaOver, this);
      vs.on('pointerout', this.__onTextAreaOut, this);
    }
  }

  get maxChars(): number { return this._textField?.maxChars ?? 0; }
  set maxChars(v: number) { if (this._textField) this._textField.maxChars = toInt(v); }

  get limitChars(): number { return this._limitLines; }
  set limitChars(v: number) { this._limitLines = toInt(v); }

  get text(): string { return this._textField?.text ?? ''; }
  set text(v: string) {
    if (this._textField) this._textField.text = v;
    (this._viewSource as DisplayObjectViewport).invalidateView();
  }

  get htmlText(): string { return this._textField?.htmlText ?? ''; }
  set htmlText(v: string) {
    if (this._textField) this._textField.htmlText = v;
    (this._viewSource as DisplayObjectViewport).invalidateView();
  }

  get textField(): FilterFrameText | null { return this._textField; }
  set textField(v: FilterFrameText | null) {
    if (this._textField === v) return;
    if (this._textField) disposeObject(this._textField);
    this._textField = v;
    if (v) v.multiline = true;
    this.onPropertiesChanged('textField');
  }

  get textStyle(): string { return this._textStyle; }
  set textStyle(v: string) {
    if (this._textStyle === v) return;
    this._textStyle = v;
    this.textField = ComponentFactory.Instance.creat(this._textStyle);
  }

  protected override layoutComponent(): void {
    super.layoutComponent();
    if (!this._textField || !this._viewportInnerRect || !this._viewSource) return;
    const r = this._viewportInnerRect.getInnerRect(this._width, this._height);
    this._textField.x = r.x;
    this._textField.y = r.y;
    this._textField.width = this._viewSource.width;
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    if (this._changedPropeties.textField && this._textField) {
      (this._viewSource as DisplayObjectViewport).setView(this._textField);
    }
  }

  private __onTextAreaClick(): void { StageReferance.focus = this._textField; }
  private __onTextAreaOut(): void { if (this._viewSource) this._viewSource.cursor = 'default'; }
  private __onTextAreaOver(): void { if (this._viewSource) this._viewSource.cursor = 'text'; }

  protected upScrollArea(): void {
    (this._viewSource as DisplayObjectViewport).invalidateView();
    if (!this._textField || this._textField.text.length === 0) this.viewPort!.viewPosition = new IntPoint(0, 0);
  }
}

Domain.registerClass('com.pickgliss.ui.text.TextArea', TextArea);
