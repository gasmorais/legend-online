import { Point, type Container, type FederatedPointerEvent } from 'pixi.js';
import { listen, trackPointer } from '@/flash/events';
import { Domain } from '@/flash/library';
import { Sprite } from '@/flash/sprite';
import { TextField } from '@/flash/text';
import { ComponentFactory } from '../ComponentFactory';
import { Component } from '../core/Component';
import { ComponentEvent, FrameEvent } from '../events';
import { InnerRectangle } from '../geom/InnerRectangle';
import { OuterRectPos } from '../geom/OuterRectPos';
import { disposeObject } from '../ObjectUtils';
import { FilterFrameText } from '../text/FilterFrameText';
import { StageReferance } from '../toplevel/StageReferance';
import { disposeAllChildren, DisplayUtils, toBool, toNum } from '../utils/DisplayUtils';
import type { BaseButton } from './BaseButton';

export interface FrameKeyboardEvent {
  keyCode: number;
  stopImmediatePropagation(): void;
  stopPropagation(): void;
  readonly propagationStopped: boolean;
}

let keyboardInstalled = false;

function installKeyboard(): void {
  if (keyboardInstalled || typeof window === 'undefined') return;
  keyboardInstalled = true;
  window.addEventListener('keydown', (ev) => {
    const code = ev.keyCode || (ev.key === 'Enter' ? 13 : ev.key === 'Escape' ? 27 : 0);
    if (code !== 13 && code !== 27) return;
    let stopped = false;
    const ke: FrameKeyboardEvent = {
      keyCode: code,
      stopImmediatePropagation() { stopped = true; },
      stopPropagation() { stopped = true; },
      get propagationStopped() { return stopped; },
    };
    let o = StageReferance.focus as Container | null;
    while (o && !stopped) {
      if (o instanceof Frame && o.listensKeyboard && !o.isDie) o.handleKeyDown(ke);
      o = o.parent;
    }
  });
}

export class Frame extends Component {
  static readonly P_backgound = 'backgound';
  static readonly P_closeButton = 'closeButton';
  static readonly P_closeButton_Enable = 'P_closeButton_Enable';
  static readonly P_closeInnerRect = 'closeInnerRect';
  static readonly P_containerX = 'containerX';
  static readonly P_containerY = 'containerY';
  static readonly P_disposeChildren = 'disposeChildren';
  static readonly P_moveEnable = 'moveEnable';
  static readonly P_moveInnerRect = 'moveInnerRect';
  static readonly P_title = 'title';
  static readonly P_titleText = 'titleText';
  static readonly P_titleOuterRectPos = 'titleOuterRectPos';
  static readonly P_escEnable = 'escEnable';
  static readonly P_enterEnable = 'enterEnable';
  static closeSoundFunc: (() => void) | null = null;
  static submitSoundFunc: (() => void) | null = null;
  private static _openCount = 0;

  frameType = 0;
  protected _backStyle = '';
  protected _backgound: Container | null = null;
  protected _closeButton: BaseButton | null = null;
  protected _closeButtonEnable = false;
  protected _closeInnerRect: InnerRectangle | null = null;
  protected _closeInnerRectString = '';
  protected _closestyle = '';
  protected _container!: Sprite;
  protected _moveRect!: Sprite;
  protected _containerPosString = '';
  protected _containerX = NaN;
  protected _containerY = NaN;
  protected _moveEnable = false;
  protected _moveInnerRect: InnerRectangle | null = null;
  protected _moveInnerRectString = '';
  protected _title: TextField | null = null;
  protected _titleStyle = '';
  protected _titleText = '';
  protected _disposeChildren = true;
  protected _titleOuterRectPosString = '';
  protected _titleOuterRectPos: OuterRectPos | null = null;
  protected _escEnable = false;
  protected _enterEnable = false;
  private _keyListening = false;
  private _dragOffset: Point | null = null;

  constructor() {
    super();
    installKeyboard();
    this.on('added', this.__onAddToStage, this);
    this.on('pointerdown', this.__onMouseClickSetFocus, this);
  }

  static get hasOpenFrame(): boolean { return Frame._openCount > 0; }
  static set hasOpenFrame(v: boolean) {
    if (v) Frame._openCount++;
    else Frame._openCount--;
    if (Frame._openCount < 0) Frame._openCount = 0;
  }

  protected __onMouseClickSetFocus(e: FederatedPointerEvent): void {
    trackPointer(e);
    StageReferance.focus = e.target;
  }

  addToContent(child: Container): void { this._container.addChild(child); }
  addToContentAt(child: Container, index: number): void { this._container.addChildAt(child, index); }

  get backStyle(): string { return this._backStyle; }
  set backStyle(v: string) {
    if (this._backStyle === v) return;
    this._backStyle = v;
    this.backgound = ComponentFactory.Instance.creat(this._backStyle);
  }

  get backgound(): Container | null { return this._backgound; }
  set backgound(v: Container | null) {
    if (this._backgound === v) return;
    disposeObject(this._backgound);
    this._backgound = v;
    if (v && 'mouseEnabled' in v) (v as any).mouseEnabled = true;
    this.onPropertiesChanged('backgound');
  }

  get closeButton(): BaseButton | null { return this._closeButton; }
  set closeButton(v: BaseButton | null) {
    if (this._closeButton === v) return;
    if (this._closeButton) this._closeButton.off('pointertap', this.__onCloseClick, this);
    disposeObject(this._closeButton);
    this._closeButton = v;
    this.onPropertiesChanged('closeButton');
  }

  get closeInnerRectString(): string { return this._closeInnerRectString; }
  set closeInnerRectString(v: string) {
    if (this._closeInnerRectString === v) return;
    this._closeInnerRectString = v;
    this._closeInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('closeInnerRect');
  }

  get closestyle(): string { return this._closestyle; }
  set closestyle(v: string) {
    if (this._closestyle === v) return;
    this._closestyle = v;
    this.closeButton = ComponentFactory.Instance.creat(this._closestyle);
  }

  get containerX(): number { return this._containerX; }
  set containerX(v: number) {
    v = toNum(v);
    if (this._containerX === v) return;
    this._containerX = v;
    this.onPropertiesChanged('containerX');
  }

  get containerY(): number { return this._containerY; }
  set containerY(v: number) {
    v = toNum(v);
    if (this._containerY === v) return;
    this._containerY = v;
    this.onPropertiesChanged('containerY');
  }

  get titleOuterRectPosString(): string { return this._titleOuterRectPosString; }
  set titleOuterRectPosString(v: string) {
    if (this._titleOuterRectPosString === v) return;
    this._titleOuterRectPosString = v;
    this._titleOuterRectPos = OuterRectPos.parse(v);
    this.onPropertiesChanged('titleOuterRectPos');
  }

  override dispose(): void {
    const focus = StageReferance.focus as Container | null;
    if (focus && DisplayUtils.isTargetOrContain(focus, this)) StageReferance.focus = null;
    this.stopDrag();
    this._keyListening = false;
    this.off('pointerdown', this.__onMouseClickSetFocus, this);
    this.off('added', this.__onAddToStage, this);
    if (this.parent) Frame.hasOpenFrame = false;
    if (this._backgound) disposeObject(this._backgound);
    this._backgound = null;
    if (this._closeButton) {
      this._closeButton.off('pointertap', this.__onCloseClick, this);
      disposeObject(this._closeButton);
    }
    this._closeButton = null;
    if (this._title) disposeObject(this._title);
    this._title = null;
    if (this._disposeChildren) disposeAllChildren(this._container);
    if (this._container) disposeObject(this._container);
    (this as any)._container = null;
    if (this._moveRect) this._moveRect.off('pointerdown', this.__onFrameMoveStart, this);
    disposeObject(this._moveRect);
    (this as any)._moveRect = null;
    super.dispose();
  }

  get disposeChildren(): boolean { return this._disposeChildren; }
  set disposeChildren(v: boolean) {
    v = toBool(v);
    if (this._disposeChildren === v) return;
    this._disposeChildren = v;
    this.onPropertiesChanged('disposeChildren');
  }

  get moveEnable(): boolean { return this._moveEnable; }
  set moveEnable(v: boolean) {
    v = toBool(v);
    if (this._moveEnable === v) return;
    this._moveEnable = v;
    this.onPropertiesChanged('moveEnable');
  }

  get moveInnerRectString(): string { return this._moveInnerRectString; }
  set moveInnerRectString(v: string) {
    if (this._moveInnerRectString === v) return;
    this._moveInnerRectString = v;
    this._moveInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('moveInnerRect');
  }

  get title(): TextField | null { return this._title; }
  set title(v: TextField | null) {
    if (this._title === v) return;
    this._title = v;
    this.onPropertiesChanged('title');
  }

  get titleStyle(): string { return this._titleStyle; }
  set titleStyle(v: string) {
    if (this._titleStyle === v) return;
    this._titleStyle = v;
    this.title = ComponentFactory.Instance.creat(this._titleStyle);
  }

  get titleText(): string { return this._titleText; }
  set titleText(v: string) {
    v = v == null ? '' : String(v);
    if (this._titleText === v) return;
    this._titleText = v;
    this.onPropertiesChanged('titleText');
  }

  protected __onAddToStage(): void {
    Frame.hasOpenFrame = true;
    if (!this.checkInputTxt()) StageReferance.focus = this;
  }

  private checkInputTxt(): boolean {
    const f = StageReferance.focus;
    return f instanceof FilterFrameText && f.type === 'input';
  }

  protected __onCloseClick(_e?: unknown): void {
    if (Frame.closeSoundFunc) Frame.closeSoundFunc();
    this.onResponse(FrameEvent.CLOSE_CLICK);
  }

  handleKeyDown(e: FrameKeyboardEvent): void { this.__onKeyDown(e); }
  get listensKeyboard(): boolean { return this._keyListening; }

  protected __onKeyDown(e: FrameKeyboardEvent): void {
    if (!StageReferance.keyBoardEnable) return;
    const focus = StageReferance.focus as Container | null;
    if (!DisplayUtils.isTargetOrContain(focus, this)) return;
    if (e.keyCode === 13 && this.enterEnable) {
      if (Frame.submitSoundFunc) Frame.submitSoundFunc();
      if (focus instanceof TextField && focus.type === 'input' && focus.multiline) return;
      this.onResponse(FrameEvent.ENTER_CLICK);
      e.stopImmediatePropagation();
    } else if (e.keyCode === 27 && this.escEnable) {
      if (Frame.closeSoundFunc) Frame.closeSoundFunc();
      this.onResponse(FrameEvent.ESC_CLICK);
      e.stopImmediatePropagation();
    }
  }

  get escEnable(): boolean { return this._escEnable; }
  set escEnable(v: boolean) {
    v = toBool(v);
    if (this._escEnable === v) return;
    this._escEnable = v;
    this.onPropertiesChanged('escEnable');
  }

  get enterEnable(): boolean { return this._enterEnable; }
  set enterEnable(v: boolean) {
    v = toBool(v);
    if (this._enterEnable === v) return;
    this._enterEnable = v;
    this.onPropertiesChanged('enterEnable');
  }

  protected onResponse(code: number, obj = true): void {
    this.dispatchEvent(new FrameEvent(code, obj));
  }

  protected __onFrameMoveStart(e: FederatedPointerEvent): void {
    trackPointer(e);
    const parent = this.parent;
    if (!parent) return;
    const p = parent.toLocal(e.global);
    this._dragOffset = new Point(p.x - this.x, p.y - this.y);
    this._moveRect.on('globalpointermove', this.__onMoveWindow, this);
    this._moveRect.on('pointerup', this.__onFrameMoveStop, this);
    this._moveRect.on('pointerupoutside', this.__onFrameMoveStop, this);
  }

  protected __onFrameMoveStop(_e?: unknown): void {
    this.dispatchEvent(new ComponentEvent(ComponentEvent.FRAME_MOVE_COMPLETE));
    this.stopDrag();
  }

  private stopDrag(): void {
    this._dragOffset = null;
    if (!this._moveRect) return;
    this._moveRect.off('globalpointermove', this.__onMoveWindow, this);
    this._moveRect.off('pointerup', this.__onFrameMoveStop, this);
    this._moveRect.off('pointerupoutside', this.__onFrameMoveStop, this);
  }

  protected __onMoveWindow(e: FederatedPointerEvent): void {
    trackPointer(e);
    const sw = StageReferance.stageWidth, sh = StageReferance.stageHeight;
    if (sw > 0 && sh > 0 && (e.global.x < 0 || e.global.y < 0 || e.global.x > sw || e.global.y > sh)) {
      this.__onFrameMoveStop(null);
      return;
    }
    if (!this._dragOffset || !this.parent) return;
    const p = this.parent.toLocal(e.global);
    this.position.set(p.x - this._dragOffset.x, p.y - this._dragOffset.y);
  }

  protected override addChildren(): void {
    if (this._backgound) this.addChild(this._backgound);
    this.addChild(this._container);
    if (this._title) this.addChild(this._title);
    this.addChild(this._moveRect);
    if (this._closeButton) this.addChild(this._closeButton);
  }

  protected override init(): void {
    if (!this._container) this._container = new Sprite();
    if (!this._moveRect) this._moveRect = new Sprite();
    this.eventMode = 'static';
    this._container.eventMode = 'static';
    this._moveRect.eventMode = 'static';
    super.init();
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if ((ch.height || ch.width || ch.backgound) && this._backgound) {
      this._backgound.width = this._width;
      this._backgound.height = this._height;
      this.updateClosePos();
    }
    if (ch.height || ch.width || ch.moveInnerRect) this.updateMoveRect();
    if (ch.closeButton && this._closeButton) listen(this._closeButton, 'pointertap', this.__onCloseClick, this);
    if (ch.closeButton || ch.closeInnerRect) this.updateClosePos();
    if (ch.containerX || ch.containerY) this.updateContainerPos();
    if (ch.titleOuterRectPos || ch.titleText || ch.height || ch.width) {
      if (this._title) this._title.text = this._titleText;
      this.updateTitlePos();
    }
    if (ch.moveEnable) {
      if (this._moveEnable) listen(this._moveRect, 'pointerdown', this.__onFrameMoveStart, this);
      else this._moveRect.off('pointerdown', this.__onFrameMoveStart, this);
    }
    if (ch.P_closeButton_Enable && this._closeButton) this._closeButton.enable = this._closeButtonEnable;
    this._keyListening = this._escEnable || this._enterEnable;
  }

  protected updateClosePos(): void {
    if (this._closeButton && this._closeInnerRect) {
      DisplayUtils.layoutDisplayWithInnerRect(this._closeButton, this._closeInnerRect, this._width, this._height);
    }
  }

  protected updateContainerPos(): void {
    this._container.x = this._containerX;
    this._container.y = this._containerY;
  }

  protected updateMoveRect(): void {
    if (!this._moveInnerRect) return;
    const r = this._moveInnerRect.getInnerRect(this._width, this._height);
    this._moveRect.graphics.clear();
    this._moveRect.graphics.beginFill(0, 0);
    this._moveRect.graphics.drawRect(r.x, r.y, r.width, r.height);
    this._moveRect.graphics.endFill();
  }

  protected updateTitlePos(): void {
    if (!this._title || !this._titleOuterRectPos) return;
    const p = this._titleOuterRectPos.getPos(this._title.width, this._title.height, this._width, this._height);
    this._title.x = p.x;
    this._title.y = p.y;
  }

  get closeButtonEnable(): boolean { return this._closeButtonEnable; }
  set closeButtonEnable(v: boolean) {
    this._closeButtonEnable = toBool(v);
    this.onPropertiesChanged('P_closeButton_Enable');
  }
}

Domain.registerClass('com.pickgliss.ui.controls.Frame', Frame);
