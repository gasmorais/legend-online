import type { Container } from 'pixi.js';
import { setFlashFilters } from '@/flash/display';
import { Event } from '@/flash/events';
import type { FlashFilterDef } from '@/flash/filters';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils, toBool } from '../utils/DisplayUtils';
import { SelectedButton } from './SelectedButton';

export class SelectedIconButton extends SelectedButton {
  static readonly P_icon = 'icon';
  static readonly P_iconInnerRect = 'iconInnerRect';
  protected _selectedIcon: Container | null = null;
  protected _selectedIconInnerRect: InnerRectangle | null = null;
  protected _selectedIconInnerRectString = '';
  protected _selectedIconStyle = '';
  protected _unselectedIcon: Container | null = null;
  protected _unselectedIconInnerRect: InnerRectangle | null = null;
  protected _unselectedIconInnerRectString = '';
  protected _unselectedIconStyle = '';

  override dispose(): void {
    disposeObject(this._unselectedIcon);
    disposeObject(this._selectedIcon);
    this._selectedIcon = null;
    this._unselectedIcon = null;
    super.dispose();
  }

  override get selected(): boolean { return this._selected; }
  override set selected(v: boolean) {
    this._selected = toBool(v);
    if (this._selectedButton) this._selectedButton.visible = this._selected;
    if (this._unSelectedButton) this._unSelectedButton.visible = !this._selected;
    if (this._selectedIcon) this._selectedIcon.visible = this._selected;
    if (this._unselectedIcon) this._unselectedIcon.visible = !this._selected;
    this.dispatchEvent(new Event(Event.SELECT));
    this.drawHitArea();
  }

  get selectedIcon(): Container | null { return this._selectedIcon; }
  set selectedIcon(v: Container | null) {
    if (this._selectedIcon === v) return;
    disposeObject(this._selectedIcon);
    this._selectedIcon = v;
    this.onPropertiesChanged('icon');
  }

  get selectedIconInnerRectString(): string { return this._selectedIconInnerRectString; }
  set selectedIconInnerRectString(v: string) {
    if (this._selectedIconInnerRectString === v) return;
    this._selectedIconInnerRectString = v;
    this._selectedIconInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('iconInnerRect');
  }

  get selectedIconStyle(): string { return this._selectedIconStyle; }
  set selectedIconStyle(v: string) {
    if (this._selectedIconStyle === v) return;
    this._selectedIconStyle = v;
    this.selectedIcon = ComponentFactory.Instance.creat(this._selectedIconStyle);
  }

  get unSelectedIcon(): Container | null { return this._unselectedIcon; }
  get unselectedIcon(): Container | null { return this._unselectedIcon; }
  set unselectedIcon(v: Container | null) {
    if (this._unselectedIcon === v) return;
    disposeObject(this._unselectedIcon);
    this._unselectedIcon = v;
    this.onPropertiesChanged('icon');
  }

  get unselectedIconInnerRectString(): string { return this._unselectedIconInnerRectString; }
  set unselectedIconInnerRectString(v: string) {
    if (this._unselectedIconInnerRectString === v) return;
    this._unselectedIconInnerRectString = v;
    this._unselectedIconInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('iconInnerRect');
  }

  get unselectedIconStyle(): string { return this._unselectedIconStyle; }
  set unselectedIconStyle(v: string) {
    if (this._unselectedIconStyle === v) return;
    this._unselectedIconStyle = v;
    this.unselectedIcon = ComponentFactory.Instance.creat(this._unselectedIconStyle);
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._selectedIcon) this.addChild(this._selectedIcon);
    if (this._unselectedIcon) this.addChild(this._unselectedIcon);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.width || ch.height || ch.iconInnerRect || ch.icon) this.updateIconPos();
  }

  override setFrame(frame: number): void {
    super.setFrame(frame);
    DisplayUtils.setFrame(this._selectedIcon, frame);
    DisplayUtils.setFrame(this._unselectedIcon, frame);
  }

  protected updateIconPos(): void {
    if (this._unselectedIcon && this._unselectedIconInnerRect) {
      DisplayUtils.layoutDisplayWithInnerRect(this._unselectedIcon, this._unselectedIconInnerRect, this._width, this._height);
    }
    if (this._selectedIcon && this._selectedIconInnerRect) {
      DisplayUtils.layoutDisplayWithInnerRect(this._selectedIcon, this._selectedIconInnerRect, this._width, this._height);
    }
  }

  setImageFilter(filters: FlashFilterDef[] | null): void {
    for (const o of [this._selectedIcon, this._unselectedIcon, this._selectedButton, this._unSelectedButton]) {
      if (o) setFlashFilters(o, filters);
    }
  }
}

Domain.registerClass('com.pickgliss.ui.controls.SelectedIconButton', SelectedIconButton);
