import { EventDispatcher } from '@/flash/events';
import { Domain } from '@/flash/library';
import { ComponentSetting } from '../ComponentSetting';
import { InteractiveEvent } from '../events';

type Fn = ((...a: any[]) => unknown) | null;

export class AlertInfo extends EventDispatcher {
  static readonly CANCEL_LABEL = '取消';
  static readonly SUBMIT_LABEL = '确定';
  private _customPos: { x: number; y: number } | null = null;
  private _autoButtonGape = true;
  private _autoDispose = false;
  private _smallTip = '';
  private _smallTipCall: Fn = null;
  private _bottomGap = 0;
  private _buttonGape = ComponentSetting.ALERT_BUTTON_GAPE;
  private _cancelLabel = '取消';
  private _data: unknown = null;
  private _enableHtml = false;
  private _enterEnable = true;
  private _escEnable = true;
  private _frameCenter = true;
  private _moveEnable = true;
  private _mutiline = false;
  private _showCancel = true;
  private _showSubmit = true;
  private _submitLabel = '确定';
  private _textShowHeight = 0;
  private _textShowWidth = 0;
  private _title = '';
  private _closeSoundFunc: Fn = null;
  private _submitSoundFunc: Fn = null;
  private _useBindTip = '';
  extraData: unknown = null;
  choiceString = '';

  constructor(title = '', submitLabel = '确定', cancelLabel = '取消', showSubmit = true, showCancel = true, data: unknown = null,
    frameCenter = true, moveEnable = true, enterEnable = true, escEnable = true, bottomGap = 0, buttonGape = 30,
    autoDispose = false, smallTip = '', smallTipCall: Fn = null, choiceString = '') {
    super();
    this.title = title;
    this.submitLabel = submitLabel;
    this.cancelLabel = cancelLabel;
    this.showSubmit = showSubmit;
    this.showCancel = showCancel;
    this.data = data;
    this.frameCenter = frameCenter;
    this.moveEnable = moveEnable;
    this.enterEnable = enterEnable;
    this.escEnable = escEnable;
    this.bottomGap = bottomGap;
    this.buttonGape = buttonGape;
    this.autoDispose = autoDispose;
    this.smallTip = smallTip;
    this.smallTipCall = smallTipCall;
    this.choiceString = choiceString;
  }

  private set<K extends keyof this>(key: K, v: this[K]): void {
    if (this[key] === v) return;
    this[key] = v;
    this.fireChange();
  }

  get autoButtonGape(): boolean { return this._autoButtonGape; }
  set autoButtonGape(v: boolean) { this.set('_autoButtonGape' as any, v as any); }
  get autoDispose(): boolean { return this._autoDispose; }
  set autoDispose(v: boolean) { this.set('_autoDispose' as any, v as any); }
  get smallTip(): string { return this._smallTip; }
  set smallTip(v: string) { this.set('_smallTip' as any, v as any); }
  get smallTipCall(): Fn { return this._smallTipCall; }
  set smallTipCall(v: Fn) { this.set('_smallTipCall' as any, v as any); }
  get bottomGap(): number { return this._bottomGap; }
  set bottomGap(v: number) { this.set('_bottomGap' as any, (Number(v) | 0) as any); }
  get buttonGape(): number { return this._buttonGape; }
  set buttonGape(v: number) { this.set('_buttonGape' as any, (Number(v) | 0) as any); }
  get cancelLabel(): string { return this._cancelLabel; }
  set cancelLabel(v: string) { this.set('_cancelLabel' as any, v as any); }
  get data(): unknown { return this._data; }
  set data(v: unknown) { this.set('_data' as any, v as any); }
  get enableHtml(): boolean { return this._enableHtml; }
  set enableHtml(v: boolean) { this.set('_enableHtml' as any, v as any); }
  get enterEnable(): boolean { return this._enterEnable; }
  set enterEnable(v: boolean) { this.set('_enterEnable' as any, v as any); }
  get escEnable(): boolean { return this._escEnable; }
  set escEnable(v: boolean) { this.set('_escEnable' as any, v as any); }
  get frameCenter(): boolean { return this._frameCenter; }
  set frameCenter(v: boolean) { this.set('_frameCenter' as any, v as any); }
  get moveEnable(): boolean { return this._moveEnable; }
  set moveEnable(v: boolean) { this.set('_moveEnable' as any, v as any); }
  get mutiline(): boolean { return this._mutiline; }
  set mutiline(v: boolean) { this.set('_mutiline' as any, v as any); }
  get showCancel(): boolean { return this._showCancel; }
  set showCancel(v: boolean) { this.set('_showCancel' as any, v as any); }
  get showSubmit(): boolean { return this._showSubmit; }
  set showSubmit(v: boolean) { this.set('_showSubmit' as any, v as any); }
  get submitLabel(): string { return this._submitLabel; }
  set submitLabel(v: string) { this.set('_submitLabel' as any, v as any); }
  get textShowHeight(): number { return this._textShowHeight; }
  set textShowHeight(v: number) { this.set('_textShowHeight' as any, (Number(v) | 0) as any); }
  get textShowWidth(): number { return this._textShowWidth; }
  set textShowWidth(v: number) { this.set('_textShowWidth' as any, (Number(v) | 0) as any); }
  get title(): string { return this._title; }
  set title(v: string) { this.set('_title' as any, v as any); }
  get closeSoundFunc(): Fn { return this._closeSoundFunc; }
  set closeSoundFunc(v: Fn) { this.set('_closeSoundFunc' as any, v as any); }
  get submitSoundFunc(): Fn { return this._submitSoundFunc; }
  set submitSoundFunc(v: Fn) { this.set('_submitSoundFunc' as any, v as any); }
  get customPos(): { x: number; y: number } | null { return this._customPos; }
  set customPos(v: { x: number; y: number } | null) { this._customPos = v; }
  get useBindTip(): string { return this._useBindTip; }
  set useBindTip(v: string) { this.set('_useBindTip' as any, v as any); }

  private fireChange(): void { this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED)); }
}

Domain.registerClass('com.pickgliss.ui.vo.AlertInfo', AlertInfo);
