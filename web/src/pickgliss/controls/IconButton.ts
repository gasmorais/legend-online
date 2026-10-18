import type { Container } from 'pixi.js';
import { Bitmap } from '@/flash/display';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils, toBool, toNum } from '../utils/DisplayUtils';
import { AbstractTextButton } from './AbstractTextButton';

export class IconButton extends AbstractTextButton {
  static readonly P_icon = 'icon';
  static readonly P_iconInnerRect = 'iconInnerRect';
  iconFrameChange = true;
  protected _icon: Container | null = null;
  protected _iconInnerRect: InnerRectangle | null = null;
  protected _iconInnerRectString = '';
  protected _iconStyle = '';
  protected _autoCenter = true;
  protected _offSetX = 0;
  protected _offSetY = 0;

  override dispose(): void {
    if (this._icon) disposeObject(this._icon);
    this._icon = null;
    super.dispose();
  }

  get icon(): Container | null { return this._icon; }
  set icon(v: Container | null) {
    if (this._icon === v) return;
    disposeObject(this._icon);
    this._icon = v;
    this.onPropertiesChanged('icon');
  }

  get iconInnerRectString(): string { return this._iconInnerRectString; }
  set iconInnerRectString(v: string) {
    if (this._iconInnerRectString === v) return;
    this._iconInnerRectString = v;
    this._iconInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('iconInnerRect');
  }

  get iconStyle(): string { return this._iconStyle; }
  set iconStyle(v: string) {
    if (this._iconStyle === v) return;
    this._iconStyle = v;
    this.icon = ComponentFactory.Instance.creat(this._iconStyle);
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._icon) this.addChild(this._icon);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.width || ch.height || ch.iconInnerRect || ch.icon) this.updataOtherPropperties();
  }

  protected updataOtherPropperties(): void {
    if (this._autoCenter) this.autoDisplayCenter();
    else this.updateIconPos();
  }

  protected updateIconPos(): void {
    if (this._icon && this._iconInnerRect) DisplayUtils.layoutDisplayWithInnerRect(this._icon, this._iconInnerRect, this._width, this._height);
  }

  override setFrame(frame: number): void {
    super.setFrame(frame);
    if (this.iconFrameChange) DisplayUtils.setFrame(this._icon, frame);
  }

  protected autoDisplayCenter(): void {
    const back = this._back;
    const icon = this._icon;
    if (!back || !icon) return;
    if (icon instanceof Bitmap && back.width > 0 && back.height > 0) {
      icon.scale.set(1, 1);
      back.x = 0;
      back.y = 0;
      icon.x = (back.width - icon.width) / 2;
      icon.y = (back.height - icon.height) / 2;
      icon.x += this._offSetX;
      icon.y += this._offSetY;
    }
  }

  get autoCenter(): boolean { return this._autoCenter; }
  set autoCenter(v: boolean) {
    this._autoCenter = toBool(v);
    this.updataOtherPropperties();
  }

  get offSetX(): number { return this._offSetX; }
  set offSetX(v: number) {
    this._offSetX = toNum(v);
    this.updataOtherPropperties();
  }

  get offSetY(): number { return this._offSetY; }
  set offSetY(v: number) {
    this._offSetY = toNum(v);
    this.updataOtherPropperties();
  }
}

Domain.registerClass('com.pickgliss.ui.controls.IconButton', IconButton);
