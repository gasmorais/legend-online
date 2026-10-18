import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { ComponentSetting } from '../ComponentSetting';
import { BaseButton } from './BaseButton';

export class SimpleBitmapButton extends BaseButton {
  constructor() {
    super();
    this._frameFilter = ComponentFactory.Instance.creatFrameFilters(ComponentSetting.SIMPLE_BITMAP_BUTTON_FILTER);
  }

  override get backStyle(): string { return this._backStyle; }
  override set backStyle(v: string) {
    if (v === this._backStyle) return;
    this._backStyle = v;
    this.backgound = ComponentFactory.Instance.creat(v);
    this._width = this._back?.width ?? 0;
    this._height = this._back?.height ?? 0;
    this.onPropertiesChanged('backStyle');
  }
}

Domain.registerClass('com.pickgliss.ui.controls.SimpleBitmapButton', SimpleBitmapButton);
