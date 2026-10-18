import { Event, EventDispatcher } from '@/flash/events';
import { Domain } from '@/flash/library';
import { disposeObject } from '../ObjectUtils';
import type { ISelectable } from './SelectedButton';

export class SelectedButtonGroup extends EventDispatcher {
  private _canUnSelect: boolean;
  private _currentSelecetdIndex = -1;
  private _items: ISelectable[] = [];
  private _lastSelectedButton: ISelectable | null = null;
  private _mutiSelectCount: number;

  constructor(canUnSelect = false, mutiSelectCount = 1) {
    super();
    this._mutiSelectCount = mutiSelectCount;
    this._canUnSelect = canUnSelect;
  }

  addSelectItem(item: ISelectable): void {
    item.on('pointertap', this.__onItemClicked, this);
    item.autoSelect = false;
    this._items.push(item);
  }

  removeAllItem(): void {
    for (const it of this._items) {
      it.off('pointertap', this.__onItemClicked, this);
      it.selected = false;
    }
    this._items.splice(0, this._items.length);
  }

  dispose(): void {
    while (this._items.length > 0) this.removeItemByIndex(0);
    this.lastSelectedButton = null;
    this.removeAllListeners();
  }

  getSelectIndexByItem(item: ISelectable): number { return this._items.indexOf(item); }

  getSelectedItem<T extends ISelectable = ISelectable>(): T | null {
    if (this.selectIndex === -1) return null;
    return this._items[this.selectIndex] as T;
  }

  get itemLength(): number { return this._items.length; }

  removeItemByIndex(index: number): void {
    if (index !== -1) {
      this._items[index].off('pointertap', this.__onItemClicked, this);
      disposeObject(this._items[index]);
      this._items.splice(index, 1);
    }
  }

  removeSelectItem(item: ISelectable): void { this.removeItemByIndex(this._items.indexOf(item)); }

  get selectIndex(): number { return this._lastSelectedButton ? this._items.indexOf(this._lastSelectedButton) : -1; }

  getIndexByItem(item: ISelectable): number { return this._items.indexOf(item); }

  set selectIndex(index: number) {
    const changed = this._currentSelecetdIndex !== index;
    if (index === -1) {
      if (this.lastSelectedButton && this.selectedCount === this._mutiSelectCount) this.lastSelectedButton.selected = false;
      this._currentSelecetdIndex = index;
      this.lastSelectedButton = null;
    } else {
      const item = this._items[index];
      if (!item.selected) {
        if (this.lastSelectedButton && this.selectedCount === this._mutiSelectCount) this.lastSelectedButton.selected = false;
        item.selected = true;
        this._currentSelecetdIndex = index;
        this.lastSelectedButton = item;
      } else if (this._canUnSelect) {
        item.selected = false;
      }
    }
    if (changed) this.dispatchEvent(new Event(Event.CHANGE));
  }

  get selectedCount(): number {
    let n = 0;
    for (const it of this._items) if (it.selected) n++;
    return n;
  }
  set selectedCount(v: number) { this._mutiSelectCount = v; }

  private __onItemClicked(e: { stopPropagation(): void; currentTarget: unknown }): void {
    e.stopPropagation();
    this.selectIndex = this._items.indexOf(e.currentTarget as ISelectable);
  }

  get lastSelectedButton(): ISelectable | null { return this._lastSelectedButton; }
  set lastSelectedButton(v: ISelectable | null) { this._lastSelectedButton = v; }
}

Domain.registerClass('com.pickgliss.ui.controls.SelectedButtonGroup', SelectedButtonGroup);
