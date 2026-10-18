import { setFlashFilters } from '@/flash/display';
import type { FlashFilterDef } from '@/flash/filters';
import { Sprite } from '@/flash/sprite';

export const GRAY_FILTER: FlashFilterDef = {
  type: 'colorMatrix',
  matrix: [0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0],
};

export class Component extends Sprite {
  static P_height = 'height';
  static P_width = 'width';
  isDie = false;
  id = -1;
  stylename = '';
  protected _changeCount = 0;
  protected _changedPropeties: Record<string, boolean> = {};
  protected _height = 0;
  protected _width = 0;
  protected _tipData: unknown = null;
  protected _tipDirction = '';
  protected _tipGapV = 0;
  protected _tipGapH = 0;
  protected _tipStyle = '';
  protected _isFollowMouse = true;
  protected _disabled = false;
  protected _initX = NaN;
  protected _initY = NaN;

  constructor() {
    super();
    this.init();
  }

  get groups(): unknown[] { return []; }

  beginChanges(): void { this._changeCount++; }
  commitChanges(): void { this._changeCount--; this.invalidate(); }

  dispose(): void {
    this.isDie = true;
    this.parent?.removeChild(this);
  }

  draw(): void {
    this.onProppertiesUpdate();
    this.addChildren();
    this.addTopChildren();
    this.emit('propertiesChanged', this._changedPropeties);
    this._changedPropeties = {};
  }

  override get height(): number { return this._height; }
  override set height(v: number) {
    v = Number(v);
    if (v === this._height) return;
    this._height = v;
    this.onPropertiesChanged('height');
  }

  override get width(): number { return this._width; }
  override set width(v: number) {
    v = Number(v);
    if (v === this._width) return;
    this._width = v;
    this.onPropertiesChanged('width');
  }

  override get x(): number { return this.position.x; }
  override set x(v: number) {
    this.position.x = Math.round(Number(v));
    if (Number.isNaN(this._initX)) this._initX = this.position.x;
    this.onPosChanged();
  }

  override get y(): number { return this.position.y; }
  override set y(v: number) {
    this.position.y = Math.round(Number(v));
    if (Number.isNaN(this._initY)) this._initY = this.position.y;
    this.onPosChanged();
  }

  move(x: number, y: number): void { this.x = x; this.y = y; }

  get tipData(): unknown { return this._tipData; }
  set tipData(v: unknown) { if (this._tipData === v) return; this._tipData = v; this.onPropertiesChanged('tipData'); }
  get tipDirctions(): string { return this._tipDirction; }
  set tipDirctions(v: string) { if (this._tipDirction === v) return; this._tipDirction = v; this.onPropertiesChanged('tipDirction'); }
  get tipGapV(): number { return this._tipGapV; }
  set tipGapV(v: number) { if (this._tipGapV === v) return; this._tipGapV = Number(v); this.onPropertiesChanged('tipGap'); }
  get tipGapH(): number { return this._tipGapH; }
  set tipGapH(v: number) { if (this._tipGapH === v) return; this._tipGapH = Number(v); this.onPropertiesChanged('tipGap'); }
  get tipStyle(): string { return this._tipStyle; }
  set tipStyle(v: string) { if (this._tipStyle === v) return; this._tipStyle = v; this.onPropertiesChanged('tipStyle'); }
  get isFollowMouse(): boolean { return this._isFollowMouse; }
  set isFollowMouse(v: boolean) { this._isFollowMouse = v === true || (v as unknown) === 'true'; }

  get displayWidth(): number { return Math.abs(this.scale.x) * this.getLocalBounds().width; }
  get displayHeight(): number { return Math.abs(this.scale.y) * this.getLocalBounds().height; }

  get disabled(): boolean { return this._disabled; }
  set disabled(v: boolean) {
    if (this._disabled === v) return;
    this._disabled = v;
    this.mouseEnabled = !v;
    setFlashFilters(this, v ? [GRAY_FILTER] : []);
  }

  override removeFromParent(dispose = false): void {
    this.parent?.removeChild(this);
    if (dispose) this.dispose();
  }

  protected addChildren(): void {}
  protected addTopChildren(): void {}
  protected init(): void { this.addChildren(); }
  protected onPosChanged(): void {}

  protected invalidate(): void {
    if (this._changeCount <= 0 && !this.isDie) {
      this._changeCount = 0;
      this.draw();
    }
  }

  protected onPropertiesChanged(name: string | null = null): void {
    if (!this._changedPropeties || (name && this._changedPropeties[name])) return;
    if (name) this._changedPropeties[name] = true;
    this.invalidate();
  }

  protected onProppertiesUpdate(): void {}
}

import { Domain } from '@/flash/library';
Domain.registerClass('com.pickgliss.ui.core.Component', Component);
