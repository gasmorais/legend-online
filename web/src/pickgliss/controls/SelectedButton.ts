import type { Container, FederatedPointerEvent } from 'pixi.js';
import { Event } from '@/flash/events';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils, toBool } from '../utils/DisplayUtils';
import { BaseButton } from './BaseButton';

export interface ISelectable extends Container {
  autoSelect: boolean;
  selected: boolean;
}

export class SelectedButton extends BaseButton implements ISelectable {
  static readonly P_frameFilters = 'frameFilters';
  static readonly P_selectedStyle = 'selectedStyle';
  static readonly P_unSelectedStyle = 'unSelectedStyle';
  protected _selected = false;
  protected _selectedButton: Container | null = null;
  protected _selectedStyle = '';
  protected _unSelectedButton: Container | null = null;
  protected _unSelectedStyle = '';
  private _autoSelect = true;

  get autoSelect(): boolean { return this._autoSelect; }
  set autoSelect(v: boolean) {
    v = toBool(v);
    if (this._autoSelect === v) return;
    this._autoSelect = v;
  }

  override dispose(): void {
    this.removeEvent();
    disposeObject(this._selectedButton);
    this._selectedButton = null;
    disposeObject(this._unSelectedButton);
    this._unSelectedButton = null;
    super.dispose();
  }

  get selected(): boolean { return this._selected; }
  set selected(v: boolean) {
    this._selected = toBool(v);
    if (this._selectedButton) this._selectedButton.visible = this._selected;
    if (this._unSelectedButton) this._unSelectedButton.visible = !this._selected;
    this.dispatchEvent(new Event(Event.SELECT));
    this.drawHitArea();
  }

  get selectedStyle(): string { return this._selectedStyle; }
  set selectedStyle(v: string) {
    if (this._selectedStyle === v) return;
    this._selectedStyle = v;
    this.onPropertiesChanged('selectedStyle');
  }

  setSelectedButton(v: Container | null): void {
    disposeObject(this._selectedButton);
    this._selectedButton = v;
    DisplayUtils.setDisplayObjectNotEnable(this._selectedButton);
    this.setFrame(1);
  }

  setUnselectedButton(v: Container | null): void {
    disposeObject(this._unSelectedButton);
    this._unSelectedButton = v;
    DisplayUtils.setDisplayObjectNotEnable(this._unSelectedButton);
    this.setFrame(1);
  }

  get unSelectedStyle(): string { return this._unSelectedStyle; }
  set unSelectedStyle(v: string) {
    if (this._unSelectedStyle === v) return;
    this._unSelectedStyle = v;
    this.onPropertiesChanged('unSelectedStyle');
  }

  protected override __onMouseClick(e: FederatedPointerEvent): void {
    super.__onMouseClick(e);
    if (this._autoSelect) this.selected = !this._selected;
  }

  protected override adaptHitArea(): void {
    if (!this._selectedButton || !this._unSelectedButton || !this._PNGHitArea) return;
    this._PNGHitArea.alpha = 0;
    this._PNGHitArea.x = this._selected ? this._selectedButton.x : this._unSelectedButton.x;
    this._PNGHitArea.y = this._selected ? this._selectedButton.y : this._unSelectedButton.y;
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._selectedButton) this.addChild(this._selectedButton);
    if (this._unSelectedButton) this.addChild(this._unSelectedButton);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.unSelectedStyle) {
      this.setUnselectedButton(ComponentFactory.Instance.creat(this._unSelectedStyle));
      this.selected = this._selected;
      if (this._selectedButton) {
        this._width = this._selectedButton.width;
        this._height = this._selectedButton.height;
      }
    }
    if (ch.selectedStyle) {
      this.setSelectedButton(ComponentFactory.Instance.creat(this._selectedStyle));
      this.selected = this._selected;
      if (this._unSelectedButton) {
        this._width = this._unSelectedButton.width;
        this._height = this._unSelectedButton.height;
      }
    }
  }

  override setFrame(frame: number): void {
    super.setFrame(frame);
    if (this._selectedButton) DisplayUtils.setFrame(this._selectedButton, this._currentFrameIndex);
    if (this._unSelectedButton) DisplayUtils.setFrame(this._unSelectedButton, this._currentFrameIndex);
  }
}

Domain.registerClass('com.pickgliss.ui.controls.SelectedButton', SelectedButton);
