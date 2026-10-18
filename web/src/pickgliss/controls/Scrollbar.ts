import { Rectangle, type Container, type FederatedPointerEvent } from 'pixi.js';
import { listen, mousePosition, Timer, trackPointer } from '@/flash/events';
import { MovieClip } from '@/flash/display';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { ComponentSetting } from '../ComponentSetting';
import { Component } from '../core/Component';
import { InteractiveEvent } from '../events';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils, toBool, toInt } from '../utils/DisplayUtils';
import type { BaseButton } from './BaseButton';
import { BoundedRangeModel } from './BoundedRangeModel';

const int = (v: number): number => v | 0;

export class Scrollbar extends Component {
  static readonly HORIZONTAL = 1;
  static readonly VERTICAL = 0;
  static readonly P_decreaseButton = 'decreaseButton';
  static readonly P_decreaseButtonInnerRect = 'decreaseButtonInnerRect';
  static readonly P_increaseButton = 'increaseButton';
  static readonly P_increaseButtonInnerRect = 'increaseButtonInnerRect';
  static readonly P_maximum = 'maximum';
  static readonly P_minimum = 'minimum';
  static readonly P_orientation = 'orientation';
  static readonly P_scrollValue = 'scrollValue';
  static readonly P_thumb = 'thumb';
  static readonly P_thumbAreaInnerRect = 'thumbAreaInnerRect';
  static readonly P_thumbMinSize = 'thumbMinSize';
  static readonly P_track = 'track';
  static readonly P_trackInnerRect = 'trackInnerRect';
  static readonly P_valueIsAdjusting = 'valueIsAdjusting';
  static readonly P_visibleAmount = 'visibleAmount';

  protected _blockIncrement = 20;
  protected _currentTrackClickDirction = 0;
  protected _decreaseButton: BaseButton | null = null;
  protected _decreaseButtonInnerRect: InnerRectangle | null = null;
  protected _decreaseButtonInnerRectString = '';
  protected _decreaseButtonStyle = '';
  protected _increaseButton: BaseButton | null = null;
  protected _increaseButtonInnerRect: InnerRectangle | null = null;
  protected _increaseButtonInnerRectString = '';
  protected _increaseButtonStyle = '';
  protected _isDragging = false;
  protected _model!: BoundedRangeModel;
  protected _thumbRect!: Rectangle;
  protected _trackClickTimer!: Timer;
  protected _orientation = 0;
  protected _thumb: BaseButton | null = null;
  protected _thumbAreaInnerRect: InnerRectangle | null = null;
  protected _thumbAreaInnerRectString = '';
  protected _thumbDownOffset = 0;
  protected _thumbMinSize = 0;
  protected _thumbStyle = '';
  protected _track: Container | null = null;
  protected _trackInnerRect: InnerRectangle | null = null;
  protected _trackInnerRectString = '';
  protected _trackStyle = '';
  protected _unitIncrement = 2;
  private _autoSizeThumb = true;

  addStateListener(fn: (...a: any[]) => void, _priority = 0, _useWeak = false, context?: unknown): void {
    this.on(InteractiveEvent.STATE_CHANGED, fn, context);
  }

  removeStateListener(fn: (...a: any[]) => void, context?: unknown): void {
    this.off(InteractiveEvent.STATE_CHANGED, fn, context);
  }

  get blockIncrement(): number { return this._blockIncrement; }
  set blockIncrement(v: number) { this._blockIncrement = toInt(v); }

  set decreaseButton(v: BaseButton | null) {
    if (this._decreaseButton === v) return;
    if (this._decreaseButton) this._decreaseButton.off('change', this.__increaseButtonClicked, this);
    disposeObject(this._decreaseButton);
    this._decreaseButton = v;
    if (this._decreaseButton) this._decreaseButton.pressEnable = true;
    if (this._decreaseButton) listen(this._decreaseButton, 'change', this.__increaseButtonClicked, this);
    this.onPropertiesChanged('decreaseButton');
  }
  get decreaseButton(): BaseButton | null { return this._decreaseButton; }

  get decreaseButtonInnerRectString(): string { return this._decreaseButtonInnerRectString; }
  set decreaseButtonInnerRectString(v: string) {
    if (this._decreaseButtonInnerRectString === v) return;
    this._decreaseButtonInnerRectString = v;
    this._decreaseButtonInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('decreaseButtonInnerRect');
  }

  get decreaseButtonStyle(): string { return this._decreaseButtonStyle; }
  set decreaseButtonStyle(v: string) {
    if (this._decreaseButtonStyle === v) return;
    this._decreaseButtonStyle = v;
    this.decreaseButton = ComponentFactory.Instance.creat(this._decreaseButtonStyle);
  }

  override dispose(): void {
    if (this._thumb) this._thumb.off('pointerdown', this.__onThumbDown, this);
    this.unbindThumbDrag();
    disposeObject(this._thumb);
    this._thumb = null;
    if (this._decreaseButton) this._decreaseButton.off('change', this.__decreaseButtonClicked, this);
    disposeObject(this._decreaseButton);
    this._decreaseButton = null;
    if (this._increaseButton) this._increaseButton.off('change', this.__increaseButtonClicked, this);
    disposeObject(this._increaseButton);
    this._increaseButton = null;
    if (this._track) {
      this.unbindTrack(true);
      this._trackClickTimer.stop();
      this._trackClickTimer.off('timer', this.__onTrackPressed, this);
    }
    disposeObject(this._track);
    this._track = null;
    super.dispose();
  }

  get downButtonStyle(): string { return this._decreaseButtonStyle; }
  set downButtonStyle(v: string) {
    if (this._decreaseButtonStyle === v) return;
    this._decreaseButtonStyle = v;
    this.increaseButton = ComponentFactory.Instance.creat(this._decreaseButtonStyle);
  }

  getModel(): BoundedRangeModel { return this._model; }

  getThumbVisible(): boolean { return this._thumb?.visible ?? false; }

  set increaseButton(v: BaseButton | null) {
    if (this._increaseButton === v) return;
    if (this._increaseButton) this._increaseButton.off('change', this.__decreaseButtonClicked, this);
    disposeObject(this._increaseButton);
    this._increaseButton = v;
    if (this._increaseButton) this._increaseButton.pressEnable = true;
    if (this._increaseButton) listen(this._increaseButton, 'change', this.__decreaseButtonClicked, this);
    this.onPropertiesChanged('increaseButton');
  }
  get increaseButton(): BaseButton | null { return this._increaseButton; }

  get increaseButtonInnerRectString(): string { return this._increaseButtonInnerRectString; }
  set increaseButtonInnerRectString(v: string) {
    if (this._increaseButtonInnerRectString === v) return;
    this._increaseButtonInnerRectString = v;
    this._increaseButtonInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('increaseButtonInnerRect');
  }

  get increaseButtonStyle(): string { return this._increaseButtonStyle; }
  set increaseButtonStyle(v: string) {
    if (this._increaseButtonStyle === v) return;
    this._increaseButtonStyle = v;
    this.increaseButton = ComponentFactory.Instance.creat(this._increaseButtonStyle);
  }

  isVertical(): boolean { return this._orientation === 0; }

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

  get scrollValue(): number { return this.getModel().getValue(); }
  set scrollValue(v: number) {
    this.getModel().setValue(toInt(v));
    this.onPropertiesChanged('scrollValue');
  }

  setupModel(model: BoundedRangeModel): void {
    if (this._model) this._model.removeStateListener(this.__onModelChange, this);
    else this._model = model;
    this._model.addStateListener(this.__onModelChange, 0, false, this);
  }

  get thumb(): BaseButton | null { return this._thumb; }
  set thumb(v: BaseButton | null) {
    if (this._thumb === v) return;
    if (this._thumb) this._thumb.off('pointerdown', this.__onThumbDown, this);
    disposeObject(this._thumb);
    this._thumb = v;
    if (this._thumb) listen(this._thumb, 'pointerdown', this.__onThumbDown, this);
    this.onPropertiesChanged('thumb');
  }

  get thumbAreaInnerRectString(): string { return this._thumbAreaInnerRectString; }
  set thumbAreaInnerRectString(v: string) {
    if (this._thumbAreaInnerRectString === v) return;
    this._thumbAreaInnerRectString = v;
    this._thumbAreaInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('thumbAreaInnerRect');
  }

  get thumbMinSize(): number { return this._thumbMinSize; }
  set thumbMinSize(v: number) {
    v = toInt(v);
    if (this._thumbMinSize === v) return;
    this._thumbMinSize = v;
    this.onPropertiesChanged('thumbMinSize');
  }

  get thumbStyle(): string { return this._thumbStyle; }
  set thumbStyle(v: string) {
    if (this._thumbStyle === v) return;
    this._thumbStyle = v;
    this.thumb = ComponentFactory.Instance.creat(this._thumbStyle);
  }

  get track(): Container | null { return this._track; }
  set track(v: Container | null) {
    if (this._track === v) return;
    if (this._track) this.unbindTrack(true);
    disposeObject(this._track);
    this._track = v;
    if (!v) return;
    if ('mouseEnabled' in v || v instanceof MovieClip) v.eventMode = 'static';
    listen(v, 'pointerdown', this.__onTrackClickStart, this);
    listen(v, 'pointerup', this.__onTrackClickStop, this);
    listen(v, 'pointerout', this.__onTrackClickStop, this);
    this.onPropertiesChanged('track');
  }

  private unbindTrack(all: boolean): void {
    const t = this._track;
    if (!t) return;
    if (all) t.off('pointerdown', this.__onTrackClickStart, this);
    t.off('pointerup', this.__onTrackClickStop, this);
    t.off('pointerout', this.__onTrackClickStop, this);
    t.off('globalpointermove', trackPointer);
  }

  get trackInnerRectString(): string { return this._trackInnerRectString; }
  set trackInnerRectString(v: string) {
    if (this._trackInnerRectString === v) return;
    this._trackInnerRectString = v;
    this._trackInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('trackInnerRect');
  }

  get trackStyle(): string { return this._trackStyle; }
  set trackStyle(v: string) {
    if (this._trackStyle === v) return;
    this._trackStyle = v;
    this.track = ComponentFactory.Instance.creat(this._trackStyle);
  }

  get unitIncrement(): number { return this._unitIncrement; }
  set unitIncrement(v: number) { this._unitIncrement = toInt(v); }

  get valueIsAdjusting(): boolean { return this.getModel().getValueIsAdjusting(); }
  set valueIsAdjusting(v: boolean) {
    v = toBool(v);
    if (this.getModel().getValueIsAdjusting() === v) return;
    this.getModel().setValueIsAdjusting(v);
    this.onPropertiesChanged('valueIsAdjusting');
  }

  get visibleAmount(): number { return this.getModel().getExtent(); }
  set visibleAmount(v: number) {
    v = toInt(v);
    if (this.getModel().getExtent() === v) return;
    this.getModel().setExtent(v);
    this.onPropertiesChanged('visibleAmount');
  }

  protected __decreaseButtonClicked(): void { this.scrollByIncrement(this._unitIncrement); }
  protected __increaseButtonClicked(): void { this.scrollByIncrement(-this._unitIncrement); }

  protected __onModelChange(): void { this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED)); }

  protected __onScrollValueChange(): void {
    if (!this._isDragging) this.updatePosByScrollvalue();
  }

  protected getMousePosition(): { x: number; y: number } { return mousePosition(this); }

  protected __onThumbDown(e: FederatedPointerEvent): void {
    trackPointer(e);
    this.valueIsAdjusting = true;
    const p = this.getMousePosition();
    const mx = int(p.x), my = int(p.y);
    if (this.isVertical()) this._thumbDownOffset = my - this._thumb!.y;
    else this._thumbDownOffset = mx - this._thumb!.x;
    this._isDragging = true;
    const t = this._thumb!;
    listen(t, 'globalpointermove', this.__onThumbMoved, this);
    listen(t, 'pointerup', this.__onThumbUp, this);
    listen(t, 'pointerupoutside', this.__onThumbUp, this);
  }

  protected __onThumbMoved(e: FederatedPointerEvent): void {
    trackPointer(e);
    this.scrollThumbToCurrentMousePosition();
  }

  protected __onThumbUp(): void {
    this._isDragging = false;
    this.unbindThumbDrag();
  }

  private unbindThumbDrag(): void {
    const t = this._thumb;
    if (!t) return;
    t.off('globalpointermove', this.__onThumbMoved, this);
    t.off('pointerup', this.__onThumbUp, this);
    t.off('pointerupoutside', this.__onThumbUp, this);
  }

  protected __onTrackClickStart(e: FederatedPointerEvent): void {
    trackPointer(e);
    this._currentTrackClickDirction = this.getValueWithPosition(this.getMousePosition()) > this.scrollValue ? 1 : -1;
    this.scrollToAimPoint(this.getMousePosition());
    listen(this._trackClickTimer, 'timer', this.__onTrackPressed, this);
    const t = this._track!;
    listen(t, 'pointerup', this.__onTrackClickStop, this);
    listen(t, 'pointerout', this.__onTrackClickStop, this);
    listen(t, 'globalpointermove', trackPointer);
    this._trackClickTimer.start();
  }

  protected __onTrackClickStop(): void {
    this._trackClickTimer.stop();
    this._trackClickTimer.off('timer', this.__onTrackPressed, this);
    this.unbindTrack(false);
  }

  protected __onTrackPressed(): void { this.scrollToAimPoint(this.getMousePosition()); }

  protected override addChildren(): void {
    super.addChildren();
    if (this._track) this.addChild(this._track);
    if (this._increaseButton) this.addChild(this._increaseButton);
    if (this._decreaseButton) this.addChild(this._decreaseButton);
    if (this._thumb) this.addChild(this._thumb);
  }

  protected getValueWithPosition(p: { x: number; y: number }): number {
    const mx = int(p.x), my = int(p.y);
    const r = this._thumbAreaInnerRect!.getInnerRect(this._width, this._height);
    let min: number, max: number, pos: number;
    if (this.isVertical()) {
      min = int(r.y);
      max = int(r.y + r.height - this._thumbRect.height);
      pos = my;
    } else {
      min = int(r.x);
      max = int(r.x + r.width - this._thumbRect.width);
      pos = mx;
    }
    return this.getValueWithThumbMaxMinPos(min, max, pos);
  }

  protected override init(): void {
    this.setupModel(new BoundedRangeModel());
    this._thumbRect = new Rectangle();
    this._trackClickTimer = new Timer(ComponentSetting.BUTTON_PRESS_STEP_TIME);
    this.addStateListener(this.__onScrollValueChange, 0, false, this);
    this.eventMode = 'static';
    super.init();
  }

  protected layoutComponent(): void {
    DisplayUtils.layoutDisplayWithInnerRect(this._increaseButton, this._increaseButtonInnerRect, this._width, this._height);
    DisplayUtils.layoutDisplayWithInnerRect(this._decreaseButton, this._decreaseButtonInnerRect, this._width, this._height);
    DisplayUtils.layoutDisplayWithInnerRect(this._track, this._trackInnerRect, this._width, this._height);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.height || ch.width || ch.decreaseButtonInnerRect || ch.increaseButtonInnerRect || ch.trackInnerRect || ch.thumbAreaInnerRect) {
      this.layoutComponent();
    }
    if (ch.maximum || ch.minimum || ch.scrollValue || ch.valueIsAdjusting || ch.visibleAmount || ch.thumbAreaInnerRect
      || ch.thumbMinSize || ch.thumb) {
      this.updatePosByScrollvalue();
    }
  }

  protected scrollByIncrement(inc: number): void { this.scrollValue += inc; }

  protected scrollThumbToCurrentMousePosition(): void {
    const p = this.getMousePosition();
    const mx = int(p.x), my = int(p.y);
    const r = this._thumbAreaInnerRect!.getInnerRect(this._width, this._height);
    let min: number, max: number, pos: number;
    if (this.isVertical()) {
      min = int(r.y);
      max = int(r.y + r.height - this._thumbRect.height);
      pos = int(Math.min(max, Math.max(min, my - this._thumbDownOffset)));
      this.setThumbPosAndSize(this._thumbRect.x, pos, this._thumbRect.width, this._thumbRect.height);
    } else {
      min = int(r.x);
      max = int(r.x + r.width - this._thumbRect.width);
      pos = int(Math.min(max, Math.max(min, mx - this._thumbDownOffset)));
      this.setThumbPosAndSize(pos, this._thumbRect.y, this._thumbRect.width, this._thumbRect.height);
    }
    this.scrollValue = this.getValueWithThumbMaxMinPos(min, max, pos);
  }

  protected scrollToAimPoint(p: { x: number; y: number }): void {
    const target = this.getValueWithPosition(p);
    let inc: number;
    if (target > this.scrollValue && this._currentTrackClickDirction > 0) {
      inc = this.blockIncrement;
    } else {
      if (!(target < this.scrollValue && this._currentTrackClickDirction < 0)) return;
      inc = -this.blockIncrement;
    }
    this.scrollByIncrement(inc);
  }

  protected setThumbPosAndSize(x: number, y: number, w: number, h: number): void {
    const t = this._thumb!;
    this._thumbRect.x = t.x = int(x);
    this._thumbRect.y = t.y = int(y);
    this._thumbRect.width = int(w);
    this._thumbRect.height = int(h);
    if (this._autoSizeThumb) {
      t.width = int(w);
      t.height = int(h);
    }
  }

  protected updatePosByScrollvalue(): void {
    const thumb = this._thumb;
    if (!thumb || !this._thumbAreaInnerRect) return;
    const min = this.minimum;
    const extent = this.visibleAmount;
    const range = int(this.maximum - min);
    const value = this.scrollValue;
    const r = this._thumbAreaInnerRect.getInnerRect(this._width, this._height);
    if (range <= 0) {
      thumb.visible = false;
      return;
    }
    let len: number, size: number;
    if (this.isVertical()) {
      len = int(r.height);
      size = int(Math.floor(len * (extent / range)));
      thumb.visible = size < r.height;
    } else {
      len = int(r.width);
      size = int(Math.floor(len * (extent / range)));
      thumb.visible = size < r.width;
    }
    this.setButtonsMouse(thumb.visible);
    if (len > this.thumbMinSize) {
      size = Math.max(size, this.thumbMinSize);
      this.setButtonsMouse(thumb.visible);
      const free = int(len - size);
      const pos = range - extent === 0 ? 0 : int(Math.round(free * ((value - min) / (range - extent))));
      if (this.isVertical()) this.setThumbPosAndSize(r.x, pos + r.y, r.width, size);
      else this.setThumbPosAndSize(r.x + pos, r.y, size, r.height);
      return;
    }
    thumb.visible = false;
  }

  private setButtonsMouse(v: boolean): void {
    if (this._increaseButton) this._increaseButton.mouseEnabled = v;
    if (this._decreaseButton) this._decreaseButton.mouseEnabled = v;
  }

  private getValueWithThumbMaxMinPos(min: number, max: number, pos: number): number {
    const m = this._model;
    if (pos >= max) return int(m.getMaximum() - m.getExtent());
    const top = int(m.getMaximum() - m.getExtent());
    const span = int(top - m.getMinimum());
    const off = int(pos - min);
    const len = int(max - min);
    return int(Math.round((off / len) * span) + m.getMinimum());
  }

  get autoSizeThumb(): boolean { return this._autoSizeThumb; }
  set autoSizeThumb(v: boolean) { this._autoSizeThumb = toBool(v); }
}

Domain.registerClass('com.pickgliss.ui.controls.Scrollbar', Scrollbar);
