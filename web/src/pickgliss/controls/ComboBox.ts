import { Graphics, Point, Ticker, type Container, type FederatedPointerEvent } from 'pixi.js';
import { listen } from '@/flash/events';
import { Domain } from '@/flash/library';
import type { TextField } from '@/flash/text';
import { ComponentFactory } from '../ComponentFactory';
import { ComponentSetting } from '../ComponentSetting';
import { Component } from '../core/Component';
import { InteractiveEvent, type ListItemEvent } from '../events';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';
import { StageReferance } from '../toplevel/StageReferance';
import { DisplayUtils, toBool, toInt } from '../utils/DisplayUtils';
import type { BaseButton } from './BaseButton';
import type { ListPanel } from './ListPanel';

class YTween {
  private static active = new Map<Container, YTween>();
  private elapsed = 0;
  private from: number;

  private constructor(private target: Container, private seconds: number, private to: number,
    private ease: (t: number) => number, private onComplete?: () => void) {
    this.from = target.y;
  }

  static kill(target: Container): void {
    const t = YTween.active.get(target);
    if (t) t.stop();
  }

  static to(target: Container, seconds: number, y: number, ease: (t: number) => number, onComplete?: () => void): void {
    YTween.kill(target);
    const tw = new YTween(target, seconds, y, ease, onComplete);
    if (seconds <= 0) {
      target.y = y;
      onComplete?.();
      return;
    }
    YTween.active.set(target, tw);
    Ticker.shared.add(tw.tick, tw);
  }

  private stop(): void {
    Ticker.shared.remove(this.tick, this);
    YTween.active.delete(this.target);
  }

  private tick(ticker: Ticker): void {
    this.elapsed += ticker.deltaMS / 1000;
    const t = Math.min(1, this.elapsed / this.seconds);
    if (this.target.destroyed) { this.stop(); return; }
    this.target.y = this.from + (this.to - this.from) * this.ease(t);
    if (t >= 1) {
      this.stop();
      this.onComplete?.();
    }
  }
}

export class ComboBox extends Component {
  static readonly P_button = 'button';
  static readonly P_defaultShowState = 'currentShowState';
  static readonly P_listInnerRect = 'listInnerRect';
  static readonly P_listPanel = 'listPanel';
  static readonly P_textField = 'textField';
  static readonly P_textInnerRect = 'textInnerRect';
  static readonly P_snapItemHeight = 'snapItemHeight';
  protected static readonly COMBOX_HIDE_STATE = 0;
  protected static readonly COMBOX_SHOW_STATE = 1;
  protected static HIDE = 0;
  protected static SHOW = 1;
  protected _button: BaseButton | null = null;
  protected _buttonStyle = '';
  protected _comboboxZeroPos: Point = new Point();
  protected _currentSelectedCellValue: any = null;
  protected _currentSelectedIndex = -1;
  protected _currentSelectedItem: any = null;
  protected _defaultShowState = 0;
  protected _listInnerRect: InnerRectangle | null = null;
  protected _listInnerRectString = '';
  protected _listPanel: ListPanel | null = null;
  protected _listPanelStyle = '';
  protected _maskExtends = 10;
  protected _maskShape!: Graphics;
  protected _selctedPropName: string | null = null;
  protected _state = 0;
  protected _textField: TextField | null = null;
  protected _textInnerRect: InnerRectangle | null = null;
  protected _textRectString = 'textRectString';
  protected _textStyle = '';
  enableHtml = false;
  direction = 1;
  protected _snapItemHeight = false;
  private _stageBound: Container | null = null;

  set button(v: BaseButton | null) {
    if (this._button === v) return;
    disposeObject(this._button);
    this._button = v;
    this.onPropertiesChanged('button');
  }
  get button(): BaseButton | null { return this._button; }

  get buttonStyle(): string { return this._buttonStyle; }
  set buttonStyle(v: string) {
    if (this._buttonStyle === v) return;
    this._buttonStyle = v;
    this.button = ComponentFactory.Instance.creat(this._buttonStyle);
  }

  get currentSelectedCellValue(): any { return this._currentSelectedCellValue; }
  get currentSelectedIndex(): number { return this._currentSelectedIndex; }
  get currentSelectedItem(): any { return this._currentSelectedItem; }

  get defaultShowState(): number { return this._defaultShowState; }
  set defaultShowState(v: number) {
    v = toInt(v);
    if (this._defaultShowState === v) return;
    this._defaultShowState = v;
    this.onPropertiesChanged('currentShowState');
  }

  override dispose(): void {}

  protected get listLayer(): Container | null {
    if (ComponentSetting.COMBOX_LIST_LAYER) return ComponentSetting.COMBOX_LIST_LAYER;
    if (StageReferance.stage) return StageReferance.stage;
    let root: Container = this;
    while (root.parent) root = root.parent;
    return root === this ? null : root;
  }

  doHide(): void {
    if (this._state === ComboBox.HIDE || !this._listPanel) return;
    if (this._listPanel.vectorListModel.getSize() === 0) return;
    this._defaultShowState = 0;
    YTween.to(this._listPanel, ComponentSetting.COMBOBOX_HIDE_TIME,
      this._comboboxZeroPos.y - this.direction * this._listPanel.height,
      ComponentSetting.COMBOBOX_HIDE_EASE_FUNCTION, () => this.onHideComplete());
    this._state = ComboBox.HIDE;
  }

  doShow(): void {
    if (this._state === ComboBox.SHOW || !this._listPanel) return;
    if (this._listPanel.vectorListModel.getSize() === 0) return;
    this.onPosChanged();
    this._defaultShowState = 1;
    const layer = this.listLayer;
    if (layer) {
      layer.addChild(this._listPanel);
      layer.addChild(this._maskShape);
    }
    YTween.to(this._listPanel, ComponentSetting.COMBOBOX_SHOW_TIME,
      this.direction * (this._comboboxZeroPos.y + (this._listInnerRect?.para2 ?? 0)),
      ComponentSetting.COMBOBOX_SHOW_EASE_FUNCTION);
    this._state = ComboBox.SHOW;
  }

  set listInnerRect(v: InnerRectangle | null) {
    if (this._listInnerRect && this._listInnerRect.equals(v)) return;
    this._listInnerRect = v;
    this.onPropertiesChanged('listInnerRect');
  }
  get listInnerRect(): InnerRectangle | null { return this._listInnerRect; }

  get listInnerRectString(): string { return this._listInnerRectString; }
  set listInnerRectString(v: string) {
    if (this._listInnerRectString === v) return;
    this._listInnerRectString = v;
    this.listInnerRect = InnerRectangle.parse(v);
  }

  get listPanel(): ListPanel | null { return this._listPanel; }
  set listPanel(v: ListPanel | null) {
    if (this._listPanel === v) return;
    if (this._listPanel) {
      this._listPanel.list.off('listItemClick', this.__onItemChanged, this);
      this._listPanel.off('pointertap', this.__onListPanelClick, this);
    }
    disposeObject(this._listPanel);
    this._listPanel = v;
    if (v) {
      listen(v.list, 'listItemClick', this.__onItemChanged, this);
      listen(v, 'pointertap', this.__onListPanelClick, this);
    }
    this.onPropertiesChanged('listPanel');
  }

  get listPanelStyle(): string { return this._listPanelStyle; }
  set listPanelStyle(v: string) {
    if (this._listPanelStyle === v) return;
    this._listPanelStyle = v;
    this.listPanel = ComponentFactory.Instance.creat(this._listPanelStyle);
  }

  get selctedPropName(): string | null { return this._selctedPropName; }
  set selctedPropName(v: string | null) {
    if (this._selctedPropName === v) return;
    this._selctedPropName = v;
  }

  get textField(): TextField | null { return this._textField; }
  set textField(v: TextField | null) {
    if (this._textField === v) return;
    this._textField = v;
    this.onPropertiesChanged('textField');
  }

  set textInnerRect(v: InnerRectangle | null) {
    if (this._textInnerRect && this._textInnerRect.equals(v)) return;
    this._textInnerRect = v;
    this.onPropertiesChanged('textInnerRect');
  }
  get textInnerRect(): InnerRectangle | null { return this._textInnerRect; }

  get textInnerRectString(): string { return this._textRectString; }
  set textInnerRectString(v: string) {
    if (this._textRectString === v) return;
    this._textRectString = v;
    this.textInnerRect = InnerRectangle.parse(v);
  }

  get textStyle(): string { return this._textStyle; }
  set textStyle(v: string) {
    if (this._textStyle === v) return;
    this._textStyle = v;
    this.textField = ComponentFactory.Instance.creat(this._textStyle);
  }

  protected __onItemChanged(e: ListItemEvent): void {
    this._currentSelectedItem = e.cell;
    this._currentSelectedCellValue = e.cellValue;
    this._currentSelectedIndex = e.index;
    if (this._selctedPropName != null && this._textField) {
      if (this._currentSelectedItem) {
        const v = this._currentSelectedItem[this._selctedPropName];
        if (this.enableHtml) this._textField.htmlText = v;
        else this._textField.text = v;
      } else {
        this._textField.text = '';
      }
    }
    this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED));
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._button) this.addChild(this._button);
    if (this._textField) this.addChild(this._textField);
  }

  protected override init(): void {
    this._maskShape = new Graphics();
    this.eventMode = 'static';
    this.on('added', this.__onAddToStage, this);
    this.on('pointertap', this.__onSelfClick, this);
    super.init();
  }

  protected __onSelfClick(e: FederatedPointerEvent): void { this.toggleFor(e.target); }

  protected __onListPanelClick(e: FederatedPointerEvent): void { this.toggleFor(e.target); }

  private toggleFor(target: unknown): void {
    if (DisplayUtils.isTargetOrContain(target, this._button) || DisplayUtils.isTargetOrContain(target, this._listPanel?.list)
      || DisplayUtils.isTargetOrContain(target, this._textField)) {
      if (this._state === ComboBox.HIDE) this.doShow();
      else this.doHide();
    }
  }

  protected __onStageDown(e: FederatedPointerEvent): void {
    const t = e.target;
    if (DisplayUtils.isTargetOrContain(t, this._listPanel) || DisplayUtils.isTargetOrContain(t, this)) return;
    this.doHide();
  }

  protected onHideComplete(): void {
    if (this._listPanel?.parent) this._listPanel.parent.removeChild(this._listPanel);
    if (this._maskShape?.parent) this._maskShape.parent.removeChild(this._maskShape);
  }

  protected override onPosChanged(): void {
    if (!this._maskShape) return;
    const layer = this.listLayer;
    const p = DisplayUtils.getPointFromObject(new Point(0, 0), this, layer);
    this._comboboxZeroPos = new Point(p.x, p.y);
    this.updateListPos();
    this.updateMask();
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.listInnerRect || ch.height || ch.width || ch.currentShowState || ch.listPanel) {
      this.onPosChanged();
      this.updateListSize();
      if (this._listPanel) this._listPanel.list.addStateListener(this.updateListSize, 0, false, this);
    }
    if (ch.textInnerRect || ch.height || ch.width) {
      DisplayUtils.layoutDisplayWithInnerRect(this._textField, this._textInnerRect, this._width, this._height);
    }
    if (ch.height || ch.width) {
      if (this._button && this._button.autoSizeAble) {
        this._button.beginChanges();
        this._button.width = this._width;
        this._button.height = this._height;
        this._button.commitChanges();
      }
    }
  }

  protected updateListPos(): void {
    if (!this._listInnerRect || !this._listPanel) return;
    const r = this._listInnerRect.getInnerRect(this._width, this._height);
    this._listPanel.x = this._comboboxZeroPos.x + r.x;
    this._listPanel.y = this._comboboxZeroPos.y + r.y;
    if (this._defaultShowState === 0) this._listPanel.y = this._comboboxZeroPos.y - this._listPanel.height;
    else if (this._defaultShowState === 1) this._listPanel.y = this._comboboxZeroPos.y + this._listInnerRect.para2;
  }

  protected updateListSize(): void {
    if (!this._listPanel || !this._listInnerRect) return;
    const r = this._listInnerRect.getInnerRect(this._width, this._height);
    if (this._snapItemHeight) {
      this._listPanel.height = this._listPanel.list.getViewSize().height + this._listPanel.getShowHScrollbarExtendHeight();
    } else {
      this._listPanel.height = r.height;
    }
    this._listPanel.width = r.width;
    this._maskShape = DisplayUtils.drawRectShape(this._listPanel.width + 2 * this._maskExtends,
      this._listPanel.height + this._maskExtends * 2, this._maskShape);
    this.updateMask();
  }

  protected updateMask(): void {
    if (!this._listPanel) return;
    this._listPanel.mask = this._maskShape;
    this._maskShape.x = this._comboboxZeroPos.x - this._maskExtends;
    this._maskShape.y = this._comboboxZeroPos.y + this._height;
  }

  reset(): void {
    this._currentSelectedCellValue = null;
    this._currentSelectedIndex = -1;
    this._currentSelectedItem = null;
  }

  get snapItemHeight(): boolean { return this._snapItemHeight; }
  set snapItemHeight(v: boolean) {
    v = toBool(v);
    if (this._snapItemHeight === v) return;
    this._snapItemHeight = v;
    this.onPropertiesChanged('snapItemHeight');
  }

  protected __onAddToStage(): void {
    const stage = StageReferance.stage;
    if (stage && this._stageBound !== stage) {
      this._stageBound = stage;
      listen(stage, 'pointerdown', this.__onStageDown, this);
    }
    this.onPosChanged();
  }
}

Domain.registerClass('com.pickgliss.ui.controls.ComboBox', ComboBox);
