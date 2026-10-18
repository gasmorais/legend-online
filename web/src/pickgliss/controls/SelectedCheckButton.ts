import type { Container } from 'pixi.js';
import { MovieClip } from '@/flash/display';
import { Domain } from '@/flash/library';
import { TextField } from '@/flash/text';
import { ComponentFactory } from '../ComponentFactory';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils, toBool, toNum } from '../utils/DisplayUtils';
import { SelectedButton } from './SelectedButton';

abstract class CheckButtonBase extends SelectedButton {
  static readonly P_fieldX = 'fieldX';
  static readonly P_fieldY = 'fieldY';
  static readonly P_text = 'text';
  static readonly P_textField = 'textField';
  protected _field: Container | null = null;
  protected _fieldX = NaN;
  protected _fieldY = NaN;
  protected _text: string | null = null;
  protected _textStyle = '';
  protected abstract readonly useHtml: boolean;

  override get selected(): boolean { return this._selected; }
  override set selected(v: boolean) {
    super.selected = toBool(v);
    if (this.selected) {
      DisplayUtils.setFrame(this._field, 3);
      this.stop();
    } else {
      DisplayUtils.setFrame(this._field, 1);
    }
  }

  override dispose(): void {
    if (this._field) disposeObject(this._field);
    this._field = null;
    this.graphics.clear();
    super.dispose();
  }

  get fieldX(): number { return this._fieldX; }
  set fieldX(v: number) {
    v = toNum(v);
    if (this._fieldX === v) return;
    this._fieldX = v;
    this.onPropertiesChanged('fieldX');
  }

  get fieldY(): number { return this._fieldY; }
  set fieldY(v: number) {
    v = toNum(v);
    if (this._fieldY === v) return;
    this._fieldY = v;
    this.onPropertiesChanged('fieldY');
  }

  get text(): string | null { return this._text; }
  set text(v: string | null) {
    if (this._text === v) return;
    this._text = v;
    this.onPropertiesChanged('text');
  }

  get textField(): Container | null { return this._field; }
  set textField(v: Container | null) {
    if (this._field === v) return;
    disposeObject(this._field);
    this._field = v;
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
    if (this._field) this.addChild(this._field);
  }

  protected drawClickArea(): void {
    this.graphics.beginFill(0xff00ff, 0);
    this.graphics.drawRect(0, 0, this._width, this._height);
    this.graphics.endFill();
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.fieldX || ch.fieldY) {
      if (this._field) {
        this._field.x = this._fieldX;
        this._field.y = this._fieldY + 2;
      }
    }
    if (ch.text) {
      if (this._field) {
        if (this._field instanceof TextField) {
          if (this.useHtml) this._field.htmlText = this._text ?? '';
          else this._field.text = this._text ?? '';
        }
        this._width = this._field.x + this._field.width;
        this._height = Math.max(this._field.height, this._selectedButton?.height ?? 0);
        this.drawClickArea();
      }
    }
    if (ch.height || ch.width) this.drawClickArea();
  }

  play(): void {
    if (this.selected) return;
    if (this._field instanceof MovieClip) this._field.play();
  }

  stop(): void {
    if (this._field instanceof MovieClip) this._field.gotoAndStop(1);
  }
}

export class SelectedCheckButton extends CheckButtonBase {
  protected readonly useHtml = false;
}

export class SelectedCheckHtmlButton extends CheckButtonBase {
  protected readonly useHtml = true;
}

Domain.registerClass('com.pickgliss.ui.controls.SelectedCheckButton', SelectedCheckButton);
Domain.registerClass('com.pickgliss.ui.controls.SelectedCheckHtmlButton', SelectedCheckHtmlButton);
