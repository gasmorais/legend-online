import type { Container, FederatedPointerEvent, Graphics } from 'pixi.js';
import { listen, mousePosition, trackPointer } from '@/flash/events';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { Component } from '../core/Component';
import { InteractiveEvent } from '../events';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { rectShape, toInt, toNum } from '../utils/DisplayUtils';
import type { BaseButton } from './BaseButton';
import { BoundedRangeModel } from './BoundedRangeModel';

export class Silder extends Component {
  static readonly P_bar = 'bar';
  static readonly P_maskShowAreaInnerRect = 'maskShowAreaInnerRect';
  static readonly P_maximum = 'maximum';
  static readonly P_minimum = 'minimum';
  static readonly P_orientation = 'orientation';
  static readonly P_progressBar = 'progressBar';
  static readonly P_thumb = 'thumb';
  static readonly P_thumbShowInnerRect = 'thumbShowInnerRect';
  static readonly P_value = 'value';
  protected _bar: Container | null = null;
  protected _barStyle = '';
  protected _isDragging = false;
  protected _maskShape!: Graphics;
  protected _model!: BoundedRangeModel;
  protected _maskShowAreaInnerRect: InnerRectangle | null = null;
  protected _maskShowAreaInnerRectString = '';
  protected _orientation = -1;
  protected _progressBar: Container | null = null;
  protected _progressBarStyle = '';
  protected _thumb: BaseButton | null = null;
  protected _thumbDownOffset = 0;
  protected _thumbShowInnerRect: InnerRectangle | null = null;
  protected _thumbShowInnerRectString = '';
  protected _thumbStyle = '';
  protected _value = NaN;

  set bar(v: Container | null) {
    if (this._bar === v) return;
    this._bar = v;
    this.onPropertiesChanged('bar');
  }
  get bar(): Container | null { return this._bar; }

  get barStyle(): string { return this._barStyle; }
  set barStyle(v: string) {
    if (this._barStyle === v) return;
    this._barStyle = v;
    this.bar = ComponentFactory.Instance.creat(this._barStyle);
  }

  override dispose(): void {
    this.off('pointertap', this.__onSilderClick, this);
    this.unbindDrag();
    if (this._thumb) this._thumb.off('pointerdown', this.__onThumbMouseDown, this);
    disposeObject(this._thumb);
    disposeObject(this._bar);
    disposeObject(this._progressBar);
    this._maskShape?.destroy();
    super.dispose();
  }

  getModel(): BoundedRangeModel { return this._model; }
  isVertical(): boolean { return this._orientation === 0; }

  get maskShowAreaInnerRectString(): string { return this._maskShowAreaInnerRectString; }
  set maskShowAreaInnerRectString(v: string) {
    if (this._maskShowAreaInnerRectString === v) return;
    this._maskShowAreaInnerRectString = v;
    this._maskShowAreaInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('maskShowAreaInnerRect');
  }

  get maximum(): number { return this.getModel().getMaximum(); }
  set maximum(v: number) {
    v = toInt(v);
    if (this.getModel().getMaximum() === v) return;
    this.getModel().setMaximum(v);
    this.onPropertiesChanged('maximum');
  }

  get minimum(): number { return this.getModel().getMinimum(); }
  set minimum(v: number) {
    v = toInt(v);
    if (this.getModel().getMinimum() === v) return;
    this.getModel().setMinimum(v);
    this.onPropertiesChanged('minimum');
  }

  get orientation(): number { return this._orientation; }
  set orientation(v: number) {
    v = toInt(v);
    if (this._orientation === v) return;
    this._orientation = v;
    this.onPropertiesChanged('orientation');
  }

  set progressBar(v: Container | null) {
    if (this._progressBar === v) return;
    this._progressBar = v;
    this.onPropertiesChanged('progressBar');
  }
  get progressBar(): Container | null { return this._progressBar; }

  get progressBarStyle(): string { return this._progressBarStyle; }
  set progressBarStyle(v: string) {
    if (this._progressBarStyle === v) return;
    this._progressBarStyle = v;
    this.progressBar = ComponentFactory.Instance.creat(this._progressBarStyle);
  }

  addStateListener(fn: (...a: any[]) => void, context?: unknown): void { listen(this, InteractiveEvent.STATE_CHANGED, fn, context); }
  removeStateListener(fn: (...a: any[]) => void, context?: unknown): void { this.off(InteractiveEvent.STATE_CHANGED, fn, context); }

  setupModel(model: BoundedRangeModel): void {
    if (this._model) this._model.removeStateListener(this.__onModelChange, this);
    else this._model = model;
    this._model.addStateListener(this.__onModelChange, 0, false, this);
  }

  set thumb(v: BaseButton | null) {
    if (this._thumb === v) return;
    if (this._thumb) {
      disposeObject(this._thumb);
      this._thumb.off('pointerdown', this.__onThumbMouseDown, this);
    }
    this._thumb = v;
    if (v) listen(v, 'pointerdown', this.__onThumbMouseDown, this);
    this.onPropertiesChanged('thumb');
  }
  get thumb(): BaseButton | null { return this._thumb; }

  getThumb(): BaseButton | null { return this._thumb; }

  get thumbShowInnerRectString(): string { return this._thumbShowInnerRectString; }
  set thumbShowInnerRectString(v: string) {
    if (this._thumbShowInnerRectString === v) return;
    this._thumbShowInnerRectString = v;
    this._thumbShowInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('thumbShowInnerRect');
  }

  get thumbStyle(): string { return this._thumbStyle; }
  set thumbStyle(v: string) {
    if (this._thumbStyle === v) return;
    this._thumbStyle = v;
    this.thumb = ComponentFactory.Instance.creat(this._thumbStyle);
  }

  get value(): number { return this.getModel().getValue(); }
  set value(v: number) {
    v = toNum(v);
    if (this._value === v) return;
    this._value = v;
    this.getModel().setValue(this._value);
    this.onPropertiesChanged('value');
  }

  protected __onModelChange(): void { this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED)); }

  protected __onSilderClick(e: FederatedPointerEvent): void {
    trackPointer(e);
    this.scrollThumbToCurrentMousePosition();
  }

  protected getMousePosition(): { x: number; y: number } { return mousePosition(this); }

  protected __onThumbMouseDown(e: FederatedPointerEvent): void {
    trackPointer(e);
    const p = this.getMousePosition();
    if (this.isVertical()) this._thumbDownOffset = toInt(p.y) - this._thumb!.y;
    else this._thumbDownOffset = toInt(p.x) - this._thumb!.x;
    this._isDragging = true;
    const t = this._thumb!;
    listen(t, 'globalpointermove', this.__onThumbMouseMoved, this);
    listen(t, 'pointerup', this.__onThumbMouseUp, this);
    listen(t, 'pointerupoutside', this.__onThumbMouseUp, this);
  }

  protected __onThumbMouseMoved(e: FederatedPointerEvent): void {
    trackPointer(e);
    this.scrollThumbToCurrentMousePosition();
  }

  protected __onThumbMouseUp(): void { this.unbindDrag(); }

  private unbindDrag(): void {
    const t = this._thumb;
    if (!t) return;
    t.off('globalpointermove', this.__onThumbMouseMoved, this);
    t.off('pointerup', this.__onThumbMouseUp, this);
    t.off('pointerupoutside', this.__onThumbMouseUp, this);
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._bar) this.addChild(this._bar);
    if (this._progressBar) {
      this.addChild(this._progressBar);
      this.addChild(this._maskShape);
    }
    if (this._thumb) this.addChild(this._thumb);
  }

  protected override init(): void {
    this.setupModel(new BoundedRangeModel());
    this.setupMask();
    this.eventMode = 'static';
    this.on('pointertap', this.__onSilderClick, this);
    super.init();
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.width || ch.height) this.updateSize();
    if (ch.value || ch.thumbShowInnerRect || ch.maskShowAreaInnerRect || ch.width || ch.height || ch.maximum || ch.minimum) {
      this.updateThumbPos();
      this.updateMask();
      if (this._bar) {
        this._bar.width = this._width;
        this._bar.height = this._height;
      }
    }
  }

  protected scrollThumbToCurrentMousePosition(): void {
    if (!this._thumbShowInnerRect) return;
    const p = this.getMousePosition();
    const mx = toInt(p.x), my = toInt(p.y);
    const r = this._thumbShowInnerRect.getInnerRect(this._width, this._height);
    let min: number, max: number, pos: number;
    if (this.isVertical()) {
      min = toInt(r.y);
      max = toInt(r.y + r.height);
      pos = toInt(Math.min(max, Math.max(min, my - this._thumbDownOffset)));
    } else {
      min = toInt(r.x);
      max = toInt(r.x + r.width);
      pos = toInt(Math.min(max, Math.max(min, mx - this._thumbDownOffset)));
    }
    this.value = this.getValueWithThumbMaxMinPos(min, max, pos);
  }

  protected setupMask(): void { this._maskShape = rectShape(0xff0000, 1); }

  protected updateMask(): void {
    if (!this._maskShowAreaInnerRect) return;
    const r = this._maskShowAreaInnerRect.getInnerRect(this._width, this._height);
    this._maskShape.x = r.x;
    this._maskShape.y = r.y;
    const ratio = this._value / (this.maximum - this.minimum);
    if (this.isVertical()) {
      this._maskShape.height = r.height * ratio;
      this._maskShape.width = r.width;
    } else {
      this._maskShape.width = r.width * ratio;
      this._maskShape.height = r.height;
    }
    if (this._progressBar) this._progressBar.mask = this._maskShape;
  }

  protected updateSize(): void {
    if (!this._bar) return;
    this._bar.width = this._width;
    this._bar.height = this._height;
  }

  protected updateThumbPos(): void {
    if (!this._thumbShowInnerRect || !this._thumb) return;
    const r = this._thumbShowInnerRect.getInnerRect(this._width, this._height);
    const ratio = this.maximum === this.minimum ? 1 : (this._value - this.minimum) / (this.maximum - this.minimum);
    if (this.isVertical()) {
      this._thumb.x = r.x;
      this._thumb.y = Math.round(ratio * toInt(r.height)) + toInt(r.y);
    } else {
      this._thumb.y = r.y;
      this._thumb.x = Math.round(ratio * toInt(r.width)) + toInt(r.x);
    }
  }

  private getValueWithThumbMaxMinPos(min: number, max: number, pos: number): number {
    const span = max - min;
    const t = (pos - min) / span;
    return t * (this.maximum - this.minimum) + this.minimum;
  }
}

Domain.registerClass('com.pickgliss.ui.controls.Silder', Silder);
