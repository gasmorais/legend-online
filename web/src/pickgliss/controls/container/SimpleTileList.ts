import { Point, type Container } from 'pixi.js';
import { Event, listen } from '@/flash/events';
import { Domain } from '@/flash/library';
import { getObjectHeight, getObjectWidth, toInt, toNum } from '../../utils/DisplayUtils';
import { BoxContainer } from './BoxContainer';

export class SimpleTileList extends BoxContainer {
  static readonly LIST_ITEM_CLICK = 'LIST_ITEM_CLICK';
  static readonly ALIGN_LEFT = 'align_left';
  static readonly ALIGN_RIGHT = 'align_right';
  startPos = new Point(0, 0);
  private _align: string;
  protected _column: number;
  protected _hSpace = NaN;
  protected _rowNum = 0;
  protected _vSpace = NaN;
  private _selectedIndex = -1;
  private _selectedItem: Container | null = null;

  constructor(column: unknown = 1, align = 'align_left') {
    super();
    this._column = toInt(column);
    this._align = align;
  }

  get align(): string { return this._align; }
  set align(v: string) { this._align = v; }

  get column(): number { return this._column; }
  set column(v: number) {
    this._column = toInt(v);
    this.refreshChildPos();
  }

  get selectedItem(): Container | null { return this._selectedItem; }
  get selectedIndex(): number { return this._selectedIndex; }
  set selectedIndex(v: number) {
    if (this._selectedIndex === v) return;
    this._selectedIndex = v;
    this._selectedItem = this.getChildAt(this._selectedIndex);
  }

  get hSpace(): number { return this._hSpace; }
  set hSpace(v: number) {
    this._hSpace = toNum(v);
    this.onProppertiesUpdate();
  }

  get vSpace(): number { return this._vSpace; }
  set vSpace(v: number) {
    this._vSpace = toNum(v);
    this.onProppertiesUpdate();
  }

  protected override addOneChild(child: Container): Container | null {
    listen(child, 'pointertap', this.__itemClick, this);
    super.addOneChild(child);
    return child;
  }

  private __itemClick(e: { currentTarget: unknown }): void {
    const item = e.currentTarget as Container;
    if (item.parent === this) {
      this._selectedIndex = this.getChildIndex(item);
      this._selectedItem = item;
      this.dispatchEvent(new Event(SimpleTileList.LIST_ITEM_CLICK));
    } else {
      this._selectedIndex = -1;
      this._selectedItem = null;
    }
  }

  resetArrange(): void { this.arrange(); }

  override arrange(): void {
    this.caculateRows();
    if (!Number.isFinite(this._rowNum)) return;
    const n = this.children.length;
    let idx = 0;
    let x = toInt(this.startPos.x);
    let y = toInt(this.startPos.y);
    let maxW = 0;
    let maxH = 0;
    for (let row = 0; row < this._rowNum; row++) {
      let rowH = 0;
      for (let col = 0; ; col++) {
        if (col >= this._column) {
          x = toInt(this.startPos.x);
          y = toInt(y + rowH + this._vSpace);
          break;
        }
        const item = this.getChildAt(idx++) as Container;
        const iw = getObjectWidth(item);
        const ih = getObjectHeight(item);
        if (this._align === 'align_left') item.x = x;
        else if (this._align === 'align_right') item.x = this.width - x - ih;
        item.y = y;
        maxW = Math.max(maxW, toInt(x + iw));
        maxH = Math.max(maxH, toInt(y + ih));
        x = toInt(x + iw + this._hSpace);
        if (rowH < ih) rowH = toInt(ih);
        if (idx >= n) {
          this.changeSize(maxW, maxH);
          return;
        }
      }
    }
    this.changeSize(maxW, maxH);
    this.dispatchEvent(new Event(Event.RESIZE));
  }

  private changeSize(w: number, h: number): void {
    if (w !== this._width || h !== this._height) {
      this.width = w;
      this.height = h;
    }
  }

  private caculateRows(): void {
    this._rowNum = Math.ceil(this.children.length / this._column);
  }

  get rowNum(): number { return this._rowNum; }

  override dispose(): void {
    for (const c of this.children) c.off('pointertap', this.__itemClick, this);
    super.dispose();
  }
}

Domain.registerClass('com.pickgliss.ui.controls.container.SimpleTileList', SimpleTileList);
