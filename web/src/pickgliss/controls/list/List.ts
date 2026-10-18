import type { Container, FederatedPointerEvent, Graphics } from 'pixi.js';
import { emitClick, listen } from '@/flash/events';
import { Domain } from '@/flash/library';
import { Sprite } from '@/flash/sprite';
import { ComponentSetting } from '../../ComponentSetting';
import { Component } from '../../core/Component';
import { InteractiveEvent, ListItemEvent } from '../../events';
import { IntDimension, IntPoint, type IntRectangle } from '../../geom/IntGeom';
import { disposeObject } from '../../ObjectUtils';
import { rectShape, toInt } from '../../utils/DisplayUtils';
import type { IListCell, IListCellFactory } from '../cell/ICell';
import type { IViewprot } from '../DisplayObjectViewport';
import { type IListModel, type ListDataEvent, type ListDataListener, VectorListModel } from './VectorListModel';

export class List extends Component implements IViewprot, ListDataListener {
  static readonly AUTO_INCREMENT = -2147483648;
  static readonly P_cellFactory = 'cellFactory';
  static readonly P_horizontalBlockIncrement = 'horizontalBlockIncrement';
  static readonly P_horizontalUnitIncrement = 'horizontalUnitIncrement';
  static readonly P_model = 'model';
  static readonly P_verticalBlockIncrement = 'verticalBlockIncrement';
  static readonly P_verticalUnitIncrement = 'verticalUnitIncrement';
  static readonly P_viewPosition = 'viewPosition';
  static readonly P_viewSize = 'viewSize';
  protected _cells!: IListCell[];
  protected _cellsContainer!: Sprite;
  protected _maskShape!: Graphics;
  protected _mouseActiveObjectShape!: Graphics;
  protected _viewPosition!: IntPoint;
  protected _firstVisibleIndex!: number;
  protected _firstVisibleIndexOffset!: number;
  protected _lastVisibleIndex!: number;
  protected _lastVisibleIndexOffset!: number;
  protected _visibleRowCount!: number;
  protected _visibleCellWidth!: number;
  protected _model!: IListModel;
  protected _factory: IListCellFactory | null = null;
  protected _horizontalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
  protected _horizontalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
  protected _verticalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
  protected _verticalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
  protected _viewHeight = 0;
  protected _viewWidth = 0;
  protected _viewWidthNoCount = 0;
  protected _currentSelectedIndex = -1;

  addStateListener(fn: (...a: any[]) => void, _priority = 0, _useWeak = false, context?: unknown): void {
    listen(this, InteractiveEvent.STATE_CHANGED, fn, context);
  }

  removeStateListener(fn: (...a: any[]) => void, context?: unknown): void {
    this.off(InteractiveEvent.STATE_CHANGED, fn, context);
  }

  get cellFactory(): IListCellFactory | null { return this._factory; }
  set cellFactory(v: IListCellFactory | null) {
    if (this._factory === v) return;
    this._factory = v;
    this.onPropertiesChanged('cellFactory');
  }

  contentsChanged(e: ListDataEvent): void {
    if ((e.getIndex0() >= this._firstVisibleIndex && e.getIndex0() <= this._lastVisibleIndex)
      || (e.getIndex1() >= this._firstVisibleIndex && e.getIndex1() <= this._lastVisibleIndex)
      || this._lastVisibleIndex === -1) {
      this.updateListView();
    }
  }

  override dispose(): void {
    this._mouseActiveObjectShape?.destroy();
    this._maskShape?.destroy();
    this.removeAllCell();
    if (this._model) this._model.removeListDataListener(this);
    super.dispose();
  }

  getExtentSize(): IntDimension { return new IntDimension(this._width, this._height); }
  getViewSize(): IntDimension { return new IntDimension(this._viewWidth, this._viewHeight); }
  getViewportPane(): Component { return this; }

  get horizontalBlockIncrement(): number { return this._horizontalBlockIncrement; }
  set horizontalBlockIncrement(v: number) {
    v = toInt(v);
    if (this._horizontalBlockIncrement === v) return;
    this._horizontalBlockIncrement = v;
    this.onPropertiesChanged('horizontalBlockIncrement');
  }

  get horizontalUnitIncrement(): number { return this._horizontalUnitIncrement; }
  set horizontalUnitIncrement(v: number) {
    v = toInt(v);
    if (this._horizontalUnitIncrement === v) return;
    this._horizontalUnitIncrement = v;
    this.onPropertiesChanged('horizontalUnitIncrement');
  }

  intervalAdded(e: ListDataEvent): void {
    this.refreshViewSize();
    this.onPropertiesChanged('viewSize');
    if (e.getIndex1() <= this._lastVisibleIndex || this._lastVisibleIndex === -1 || this._viewHeight < this._height) this.updateListView();
  }

  intervalRemoved(e: ListDataEvent): void {
    this.refreshViewSize();
    this.onPropertiesChanged('viewSize');
    if (e.getIndex1() <= this._lastVisibleIndex || this._lastVisibleIndex === -1 || this._viewHeight < this._height) this.updateListView();
  }

  isSelectedIndex(i: number): boolean { return this._currentSelectedIndex === i; }

  get model(): IListModel { return this._model; }
  set model(v: IListModel) {
    if (v !== this._model) {
      if (this._model) this._model.removeListDataListener(this);
      this._model = v;
      this._model.addListDataListener(this);
      this.onPropertiesChanged('model');
    }
  }

  scrollRectToVisible(r: IntRectangle): void { this.viewPosition = new IntPoint(r.x, r.y); }

  scrollToIndex(i: number): void {
    if (i < 0 || i >= this.model.getSize() || !this._factory) return;
    const p = new IntPoint();
    p.x = 0;
    p.y = i * this._factory.getCellHeight();
    this.viewPosition = p;
  }

  setListData(arr: any[]): void { this.model = new VectorListModel(arr); }

  setViewportTestSize(_d: IntDimension): void {}

  updateListView(): void {
    if (!this._factory) return;
    this.createCells();
    this.updateShowMask();
    this.updatePos();
  }

  get verticalBlockIncrement(): number { return this._verticalBlockIncrement; }
  set verticalBlockIncrement(v: number) {
    v = toInt(v);
    if (this._verticalBlockIncrement === v) return;
    this._verticalBlockIncrement = v;
    this.onPropertiesChanged('verticalBlockIncrement');
  }

  get verticalUnitIncrement(): number { return this._verticalUnitIncrement; }
  set verticalUnitIncrement(v: number) {
    v = toInt(v);
    if (this._verticalUnitIncrement === v) return;
    this._verticalUnitIncrement = v;
    this.onPropertiesChanged('verticalUnitIncrement');
  }

  get viewPosition(): IntPoint { return this._viewPosition; }
  set viewPosition(p: IntPoint) {
    if (this._viewPosition.equals(this.restrictionViewPos(p))) return;
    this._viewPosition.setLocation(p);
    this.onPropertiesChanged('viewPosition');
  }

  protected __onItemInteractive(e: FederatedPointerEvent, kind: string): void {
    const cell = e.currentTarget as unknown as IListCell;
    const index = this._model.indexOf(cell.getCellValue());
    let type = '';
    switch (kind) {
      case 'click':
        type = ListItemEvent.LIST_ITEM_CLICK;
        this._currentSelectedIndex = index;
        this.updateListView();
        break;
      case 'mouseDown': type = ListItemEvent.LIST_ITEM_MOUSE_DOWN; break;
      case 'mouseUp': type = ListItemEvent.LIST_ITEM_MOUSE_UP; break;
      case 'rollOver': type = ListItemEvent.LIST_ITEM_ROLL_OVER; break;
      case 'rollOut': type = ListItemEvent.LIST_ITEM_ROLL_OUT; break;
    }
    this.dispatchEvent(new ListItemEvent(cell, cell.getCellValue(), type, index, e));
  }

  private __onItemClick(e: FederatedPointerEvent): void { this.__onItemInteractive(e, 'click'); }
  private __onItemDown(e: FederatedPointerEvent): void { this.__onItemInteractive(e, 'mouseDown'); }
  private __onItemUp(e: FederatedPointerEvent): void { this.__onItemInteractive(e, 'mouseUp'); }
  private __onItemOver(e: FederatedPointerEvent): void { this.__onItemInteractive(e, 'rollOver'); }
  private __onItemOut(e: FederatedPointerEvent): void { this.__onItemInteractive(e, 'rollOut'); }

  get currentSelectedIndex(): number { return this._currentSelectedIndex; }

  protected addCellToContainer(cell: IListCell): void {
    listen(cell, 'pointertap', this.__onItemClick, this);
    listen(cell, 'pointerdown', this.__onItemDown, this);
    listen(cell, 'pointerup', this.__onItemUp, this);
    listen(cell, 'pointerover', this.__onItemOver, this);
    listen(cell, 'pointerout', this.__onItemOut, this);
    this._cells.push(this._cellsContainer.addChild(cell));
  }

  set updateItemWidth(v: number) {
    for (const c of this._cells) (c as any).updateItemWidth = v;
  }

  protected override addChildren(): void {
    super.addChildren();
    this.addChild(this._mouseActiveObjectShape);
    this.addChild(this._maskShape);
    this.addChild(this._cellsContainer);
  }

  protected creatMaskShape(): void {
    this._maskShape = rectShape(0xff0000, 1);
    this._mouseActiveObjectShape = rectShape(0xff0000, 0);
  }

  protected createCells(): void {
    if (this._factory!.isShareCells()) this.createCellsWhenShareCells();
    else this.createCellsWhenNotShareCells();
  }

  protected createCellsWhenNotShareCells(): void {}

  protected createCellsWhenShareCells(): void {
    const f = this._factory!;
    const cellH = f.getCellHeight();
    const need = Math.floor(this._height / cellH) + 2;
    this._viewWidth = f.getViewWidthNoCount();
    if (f.isAllCellHasSameHeight()) this._viewHeight = this._model.getSize() * cellH;
    else this._viewHeight = toInt(this._model.getAllCellHeight());
    if (this._cells.length === need) return;
    if (this._cells.length < need) {
      const add = need - this._cells.length;
      for (let i = 0; i < add; i++) {
        const cell = this.createNewCell();
        if (cell) this.addCellToContainer(cell);
      }
    } else if (this._cells.length > need) {
      const removed = this._cells.splice(need, this._cells.length - need);
      for (const c of removed) this.removeCellFromContainer(c);
    }
  }

  protected createNewCell(): IListCell | null {
    if (!this._factory) return null;
    return this._factory.createNewCell();
  }

  protected fireStateChanged(_programmatic = true): void {
    this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED));
  }

  protected getListCellModelHeight(_i: number): number { return 0; }

  protected getViewMaxPos(): IntPoint {
    const ext = this.getExtentSize();
    const view = this.getViewSize();
    const p = new IntPoint(view.width - ext.width, view.height - ext.height);
    if (p.x < 0) p.x = 0;
    if (p.y < 0) p.y = 0;
    return p;
  }

  protected override init(): void {
    this.creatMaskShape();
    this._cellsContainer = new Sprite();
    this.addChild(this._cellsContainer);
    this._viewPosition = new IntPoint(0, 0);
    this._firstVisibleIndex = 0;
    this._lastVisibleIndex = -1;
    this._firstVisibleIndexOffset = 0;
    this._lastVisibleIndexOffset = 0;
    this._visibleRowCount = -1;
    this._visibleCellWidth = -1;
    this._cells = [];
    this.eventMode = 'static';
    super.init();
    this._model = new VectorListModel();
    this._model.addListDataListener(this);
  }

  protected layoutWhenShareCellsHasNotSameHeight(): void {
    this.createCellsWhenShareCells();
    this.restrictionViewPos(this._viewPosition);
    const vx = this._viewPosition.x, vy = this._viewPosition.y;
    const start = this._model.getStartIndexByPosY(vy);
    const size = this._model.getSize();
    const x = -vx;
    const h = this._height;
    if (size < 0) this._lastVisibleIndex = -1;
    for (let i = 0; i < this._cells.length; i++) {
      const cell = this._cells[i];
      const idx = start + i;
      if (idx < size) {
        cell.setCellValue(this._model.getElementAt(idx));
        cell.setListCellStatus(this, this.isSelectedIndex(idx), idx);
        cell.visible = true;
        cell.x = x;
        cell.y = toInt(this._model.getCellPosFromIndex(idx) - vy);
        if (cell.y < h) this._lastVisibleIndex = idx;
      } else {
        cell.visible = false;
      }
    }
    this._firstVisibleIndex = start;
  }

  protected layoutWhenShareCellsHasSameHeight(): void {
    this.createCellsWhenShareCells();
    this.restrictionViewPos(this._viewPosition);
    const vx = this._viewPosition.x, vy = this._viewPosition.y;
    const cellH = this._factory!.getCellHeight();
    const start = Math.floor(vy / cellH);
    let y = start * cellH - vy;
    const size = this._model.getSize();
    const x = -vx;
    const h = this._height;
    if (size < 0) this._lastVisibleIndex = -1;
    for (let i = 0; i < this._cells.length; i++) {
      const cell = this._cells[i];
      const idx = start + i;
      if (idx < size) {
        cell.setCellValue(this._model.getElementAt(idx));
        cell.setListCellStatus(this, this.isSelectedIndex(idx), idx);
        cell.visible = true;
        cell.x = x;
        cell.y = y;
        if (y < h) this._lastVisibleIndex = idx;
        y += cellH;
      } else {
        cell.visible = false;
      }
    }
    this._firstVisibleIndex = start;
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    this._cellsContainer.mask = this._maskShape;
    let update = false;
    if (ch.model || ch.cellFactory || ch.viewPosition || ch.width || ch.height) {
      if (ch.cellFactory) this.removeAllCell();
      update = true;
    }
    if (update) this.updateListView();
    if (ch.verticalBlockIncrement || ch.verticalUnitIncrement || ch.horizontalBlockIncrement || ch.horizontalUnitIncrement
      || ch.height || ch.width || ch.viewPosition || ch.viewSize) {
      this.fireStateChanged();
    }
  }

  protected refreshViewSize(): void {
    const f = this._factory;
    if (!f) return;
    if (f.isShareCells()) {
      this._viewWidth = f.getViewWidthNoCount();
      if (f.isAllCellHasSameHeight()) this._viewHeight = this._model.getSize() * f.getCellHeight();
      else this._viewHeight = toInt(this._model.getAllCellHeight());
    }
  }

  protected removeAllCell(): void {
    for (const c of this._cells) this.removeCellFromContainer(c);
    this._cells = [];
  }

  set defaultSelectItemByCellValue(v: any) {
    const index = this._model.indexOf(v);
    let cell = this.getItemByValue(v);
    if (!cell) {
      this.scrollToIndex(index);
      cell = this.getItemByValue(v);
    }
    if (cell) {
      this._currentSelectedIndex = index;
      emitClick(cell);
      return;
    }
    this.dispatchEvent(new ListItemEvent(null, null, ListItemEvent.LIST_ITEM_CLICK, -1));
  }

  getItemByValue(v: unknown): IListCell | null {
    for (const c of this._cells) if (c.getCellValue() == v) return c;
    return null;
  }

  protected removeCellFromContainer(cell: IListCell): void {
    cell.off('pointertap', this.__onItemClick, this);
    cell.off('pointerdown', this.__onItemDown, this);
    cell.off('pointerup', this.__onItemUp, this);
    cell.off('pointerover', this.__onItemOver, this);
    cell.off('pointerout', this.__onItemOut, this);
    disposeObject(cell);
    if (cell.parent) cell.parent.removeChild(cell as Container);
  }

  protected restrictionViewPos(p: IntPoint): IntPoint {
    const max = this.getViewMaxPos();
    p.x = Math.max(0, Math.min(max.x, p.x));
    p.y = Math.max(0, Math.min(max.y, p.y));
    return p;
  }

  protected updatePos(): void {
    const f = this._factory!;
    if (f.isShareCells()) {
      if (f.isAllCellHasSameHeight()) this.layoutWhenShareCellsHasSameHeight();
      else this.layoutWhenShareCellsHasNotSameHeight();
    }
  }

  protected updateShowMask(): void {
    this._mouseActiveObjectShape.width = this._maskShape.width = this._width;
    this._mouseActiveObjectShape.height = this._maskShape.height = this._height;
  }

  get viewHeight(): number { return this._viewHeight; }
}

Domain.registerClass('com.pickgliss.ui.controls.list.List', List);
