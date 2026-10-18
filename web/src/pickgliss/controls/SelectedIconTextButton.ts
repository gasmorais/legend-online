import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import type { FilterFrameText } from '../text/FilterFrameText';
import { toBool } from '../utils/DisplayUtils';
import { SelectedIconButton } from './SelectedIconButton';

export class SelectedIconTextButton extends SelectedIconButton {
  static readonly P_textStyle = 'textStyle';
  protected _textStyle = '';
  protected _text: FilterFrameText | null = null;

  get textStyle(): string { return this._textStyle; }
  set textStyle(v: string) {
    if (this._textStyle === v) return;
    this._textStyle = v;
    this.onPropertiesChanged('textStyle');
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    if (this._changedPropeties.textStyle) this._text = ComponentFactory.Instance.creatComponentByStylename(this._textStyle);
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._text) this.addChild(this._text);
  }

  get text(): string { return this._text?.text ?? ''; }
  set text(v: string) {
    if (this._text) this._text.text = v;
  }

  override get selected(): boolean { return this._selected; }
  override set selected(v: boolean) {
    v = toBool(v);
    super.selected = v;
    if (!this._text) return;
    this._text.setFrame(v ? 2 : 1);
  }
}

Domain.registerClass('com.pickgliss.ui.controls.SelectedIconTextButton', SelectedIconTextButton);
