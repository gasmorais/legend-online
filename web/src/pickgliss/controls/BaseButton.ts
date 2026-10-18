import type { Container, FederatedPointerEvent } from 'pixi.js';
import { setFlashFilters } from '@/flash/display';
import { buttonDown, Event, getTimer, listen, Timer, trackPointer } from '@/flash/events';
import type { FlashFilterDef } from '@/flash/filters';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { ComponentSetting } from '../ComponentSetting';
import { Component } from '../core/Component';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils, toBool, toInt } from '../utils/DisplayUtils';

type Handler = (e: any) => void;

export class BaseButton extends Component {
  static readonly P_backStyle = 'backStyle';
  static readonly P_backgoundRotation = 'backgoundRotation';
  static readonly P_pressEnable = 'pressEnable';
  static readonly P_transparentEnable = 'transparentEnable';
  static readonly P_autoSizeAble = 'autoSizeAble';
  static readonly P_lockStyle = 'lockStyle';

  private _offsetCount = 0;
  protected _PNGHitArea: Container | null = null;
  protected _back: Container | null = null;
  protected _backStyle = '';
  protected _backgoundRotation = 0;
  protected _currentFrameIndex = 1;
  protected _enable = true;
  protected _filterString = '';
  protected _frameFilter: (FlashFilterDef[] | null)[] | null = null;
  protected _pressEnable = false;
  private _displacementEnable = true;
  private _pressStartTimer: Timer | null = null;
  private _pressStepTimer: Timer | null = null;
  private _transparentEnable = false;
  protected _autoSizeAble = true;
  protected _enableMouseAble = false;
  protected _lockStyle = '';
  protected _lockBit: Container | null = null;
  protected _lock = false;
  private _clickHandle: Handler | null = null;
  private _supportTipsWhenGray = false;
  private _preClickTime = 0;
  private _delayClick = false;
  private _delayClickTime = 200;
  private _mouseUpBound = false;
  autoHideTip = true;

  constructor() {
    super();
    this.init();
    this.addEvent();
  }

  get frameFilter(): (FlashFilterDef[] | null)[] | null { return this._frameFilter; }
  set frameFilter(v: (FlashFilterDef[] | null)[] | null) { this._frameFilter = v; }

  get enableMouseAble(): boolean { return this._enableMouseAble; }
  set enableMouseAble(v: boolean) { this._enableMouseAble = toBool(v); }

  get autoSizeAble(): boolean { return this._autoSizeAble; }
  set autoSizeAble(v: boolean) {
    v = toBool(v);
    if (this._autoSizeAble === v) return;
    this._autoSizeAble = v;
    this.onPropertiesChanged('autoSizeAble');
  }

  get backStyle(): string { return this._backStyle; }
  set backStyle(v: string) {
    if (v === this._backStyle) return;
    this._backStyle = v;
    this.backgound = ComponentFactory.Instance.creat(this._backStyle);
    this.onPropertiesChanged('backStyle');
  }

  get backgound(): Container | null { return this._back; }
  set backgound(v: Container | null) {
    if (this._back === v) return;
    disposeObject(this._back);
    this._back = v;
    this.onPropertiesChanged('backStyle');
  }

  get backgoundRotation(): number { return this._backgoundRotation; }
  set backgoundRotation(v: number) {
    v = toInt(v);
    if (this._backgoundRotation === v) return;
    this._backgoundRotation = v;
    this.onPropertiesChanged('backgoundRotation');
  }

  get displacement(): boolean { return this._displacementEnable; }
  set displacement(v: boolean) { this._displacementEnable = toBool(v); }

  override dispose(): void {
    this.removeEvent();
    if (this._clickHandle) {
      this.off('pointertap', this._clickHandle);
      this._clickHandle = null;
    }
    if (this._back) setFlashFilters(this._back, null);
    disposeObject(this._back);
    disposeObject(this._PNGHitArea);
    disposeObject(this._lockBit);
    this._lockBit = null;
    this._PNGHitArea = null;
    this._back = null;
    this._frameFilter = null;
    this._pressStepTimer?.stop();
    this._pressStartTimer?.stop();
    this._pressStepTimer = null;
    this._pressStartTimer = null;
    super.dispose();
  }

  get enable(): boolean { return this._enable; }
  set enable(v: boolean) {
    v = toBool(v);
    if (this._enable === v) return;
    this._enable = v;
    if (this._supportTipsWhenGray) {
      this.mouseEnabled = true;
      if (!this._enable) {
        listen(this, 'pointertap', this.__onMouseClick, this);
        this.off('pointerdown', this.__onMousedown, this);
        if (this._clickHandle) listen(this, 'pointertap', this._clickHandle);
      } else {
        this.off('pointertap', this.__onMouseClick, this);
        listen(this, 'pointerdown', this.__onMousedown, this);
        if (this._clickHandle) this.off('pointertap', this._clickHandle);
      }
    } else {
      this.mouseEnabled = this._enable;
      if (this._enable) listen(this, 'pointerdown', this.__onMousedown, this);
      else this.off('pointerdown', this.__onMousedown, this);
    }
    if (this._enable) {
      this.buttonMode = true;
      this.setFrame(1);
    } else {
      this.buttonMode = false;
      this.setFrame(4);
    }
    if (this._enableMouseAble) this.mouseEnabled = true;
    this.updatePosition();
  }

  get supportTipsWhenGray(): boolean { return this._supportTipsWhenGray; }
  set supportTipsWhenGray(v: boolean) { this._supportTipsWhenGray = toBool(v); }

  setClickHandle(fn: Handler): void {
    this._clickHandle = fn;
    if (this._enable) listen(this, 'pointertap', this._clickHandle);
  }

  removeClickHandle(_fn?: Handler): void {
    if (this._clickHandle) this.off('pointertap', this._clickHandle);
    this._clickHandle = null;
  }

  private updatePosition(): void {
    this.x += ComponentSetting.DISPLACEMENT_OFFSET * -this._offsetCount;
    this.y += ComponentSetting.DISPLACEMENT_OFFSET * -this._offsetCount;
    this._offsetCount = 0;
  }

  get filterString(): string { return this._filterString; }
  set filterString(v: string) {
    if (this._filterString === v) return;
    this._filterString = v;
    this._frameFilter = ComponentFactory.Instance.creatFrameFilters(this._filterString);
  }

  get pressEnable(): boolean { return this._pressEnable; }
  set pressEnable(v: boolean) {
    v = toBool(v);
    if (this._pressEnable === v) return;
    this._pressEnable = v;
    this.onPropertiesChanged('pressEnable');
  }

  get transparentEnable(): boolean { return this._transparentEnable; }
  set transparentEnable(v: boolean) {
    v = toBool(v);
    if (this._transparentEnable === v) return;
    this._transparentEnable = v;
    this.onPropertiesChanged('transparentEnable');
  }

  protected __onMouseClick(e: FederatedPointerEvent): void {
    if (this._delayClick) {
      const now = getTimer();
      if (now - this._preClickTime < this._delayClickTime) e.stopImmediatePropagation();
      this._preClickTime = now;
    }
    if (!this._enable) e.stopImmediatePropagation();
  }

  get delayClick(): boolean { return this._delayClick; }
  set delayClick(v: boolean) { this._delayClick = toBool(v); }
  get delayClickTime(): number { return this._delayClickTime; }
  set delayClickTime(v: number) { this._delayClickTime = toInt(v); }

  protected adaptHitArea(): void {
    if (!this._PNGHitArea || !this._back) return;
    this._PNGHitArea.x = this._back.x;
    this._PNGHitArea.y = this._back.y;
  }

  protected override addChildren(): void {
    if (this._back) this.addChild(this._back);
  }

  protected override addTopChildren(): void {
    if (this._lockBit) this.addChild(this._lockBit);
  }

  protected addEvent(): void {
    listen(this, 'pointertap', this.__onMouseClick, this);
    listen(this, 'pointerover', this.__onMouseRollover, this);
    listen(this, 'pointerout', this.__onMouseRollout, this);
    listen(this, 'pointerdown', this.__onMousedown, this);
  }

  protected drawHitArea(): void {
    if (this._PNGHitArea && this._PNGHitArea.parent === this) this.removeChild(this._PNGHitArea);
  }

  protected override init(): void {
    super.init();
    this.mouseChildren = false;
    this.buttonMode = true;
    this.eventMode = 'static';
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.pressEnable) {
      if (this._pressEnable) {
        this._pressStartTimer = new Timer(ComponentSetting.BUTTON_PRESS_START_TIME, 1);
        this._pressStepTimer = new Timer(ComponentSetting.BUTTON_PRESS_STEP_TIME);
      }
    }
    if (ch.width || ch.height) {
      if (this._back) {
        this._back.width = this._width;
        this._back.height = this._height;
      }
    }
    if (ch.backStyle && this._autoSizeAble) {
      if (this._back && (this._back.width > 0 || this._back.height > 0)) {
        this._width = this._back.width;
        this._height = this._back.height;
      }
    }
    if (ch.backgoundRotation) {
      if (this._back) {
        this._back.angle = this._backgoundRotation;
        const b = this._back.getBounds();
        const p = this.toLocal({ x: b.x, y: b.y });
        this._back.x -= p.x;
        this._back.y -= p.y;
      }
    }
    if (ch.width || ch.height || ch.backStyle || ch.backgoundRotation || ch.transparentEnable) this.drawHitArea();
    this.setFrame(this._currentFrameIndex);
  }

  protected removeEvent(): void {
    this.off('pointertap', this.__onMouseClick, this);
    this.off('pointerover', this.__onMouseRollover, this);
    this.off('pointerout', this.__onMouseRollout, this);
    this.off('pointerdown', this.__onMousedown, this);
    this.unbindMouseUp();
    this._pressStartTimer?.off('timer', this.__onPressedStart, this);
    this._pressStepTimer?.off('timer', this.__onPressStepTimer, this);
  }

  setFrame(frame: number): void {
    this._currentFrameIndex = frame;
    DisplayUtils.setFrame(this._back, this._currentFrameIndex);
    if (this._frameFilter === null || frame <= 0 || frame > this._frameFilter.length) return;
    setFlashFilters(this, this._frameFilter[frame - 1]);
  }

  protected __onMouseRollout(e: FederatedPointerEvent): void {
    if (this._enable && !buttonDown(e)) this.setFrame(1);
    if (this._pressEnable) this.stopPressTimers();
  }

  protected __onMouseRollover(e: FederatedPointerEvent): void {
    if (this._enable && !buttonDown(e)) this.setFrame(2);
  }

  protected __onMousedown(e: FederatedPointerEvent): void {
    trackPointer(e);
    if (this._enable) this.setFrame(3);
    if (this._displacementEnable && this._offsetCount < 1) {
      this.x += ComponentSetting.DISPLACEMENT_OFFSET;
      this.y += ComponentSetting.DISPLACEMENT_OFFSET;
      this._offsetCount++;
    }
    this.bindMouseUp();
    if (this._pressEnable && this._pressStartTimer) {
      this.__onPressStepTimer();
      listen(this._pressStartTimer, 'timer', this.__onPressedStart, this);
      this._pressStartTimer.start();
    }
  }

  private bindMouseUp(): void {
    if (this._mouseUpBound) return;
    this._mouseUpBound = true;
    listen(this, 'pointerup', this.__onMouseupInside, this);
    listen(this, 'pointerupoutside', this.__onMouseupOutside, this);
  }

  private unbindMouseUp(): void {
    if (!this._mouseUpBound) return;
    this._mouseUpBound = false;
    this.off('pointerup', this.__onMouseupInside, this);
    this.off('pointerupoutside', this.__onMouseupOutside, this);
  }

  private __onMouseupInside(e: FederatedPointerEvent): void { this.__onMouseup(e, true); }
  private __onMouseupOutside(e: FederatedPointerEvent): void { this.__onMouseup(e, false); }

  protected __onMouseup(_e: FederatedPointerEvent | null, onThis: boolean): void {
    this.unbindMouseUp();
    if (!this._enable) return;
    if (this._displacementEnable && this._offsetCount > -1) {
      this.x -= ComponentSetting.DISPLACEMENT_OFFSET;
      this.y -= ComponentSetting.DISPLACEMENT_OFFSET;
      this._offsetCount--;
    }
    this.setFrame(onThis ? 2 : 1);
    if (this._pressEnable) this.stopPressTimers();
  }

  private stopPressTimers(): void {
    this._pressStartTimer?.stop();
    this._pressStepTimer?.stop();
    this._pressStepTimer?.off('timer', this.__onPressStepTimer, this);
  }

  private __onPressStepTimer(): void {
    this.dispatchEvent(new Event(Event.CHANGE));
  }

  private __onPressedStart(): void {
    const start = this._pressStartTimer!;
    start.off('timer', this.__onPressedStart, this);
    start.reset();
    start.stop();
    this._pressStepTimer!.start();
    listen(this._pressStepTimer!, 'timer', this.__onPressStepTimer, this);
  }

  override get height(): number { return this.displayHeight; }
  override set height(v: number) { super.height = v; }
  override get width(): number { return this.displayWidth; }
  override set width(v: number) { super.width = v; }

  get lockStyle(): string { return this._lockStyle; }
  set lockStyle(v: string) {
    if (this._lockStyle === v) return;
    this._lockStyle = v;
    this._lockBit = ComponentFactory.Instance.creat(this._lockStyle);
    if (this._lockBit) this._lockBit.visible = false;
    this.onPropertiesChanged('lockStyle');
  }

  get lock(): boolean { return this._lock; }
  set lock(v: boolean) {
    this._lock = toBool(v);
    if (this._lockBit) {
      this._lockBit.visible = this._lock;
      this.enable = !this._lock;
    }
  }
}

Domain.registerClass('com.pickgliss.ui.controls.BaseButton', BaseButton);
