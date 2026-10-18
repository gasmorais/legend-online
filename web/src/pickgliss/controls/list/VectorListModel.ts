import { Domain } from '@/flash/library';
import { ModelEvent } from '../../events';

export interface ListDataListener {
  intervalAdded(e: ListDataEvent): void;
  intervalRemoved(e: ListDataEvent): void;
  contentsChanged(e: ListDataEvent): void;
}

export interface IListModel {
  addListDataListener(l: ListDataListener): void;
  getElementAt(i: number): any;
  getSize(): number;
  removeListDataListener(l: ListDataListener): void;
  indexOf(v: any): number;
  getCellPosFromIndex(i: number): number;
  getAllCellHeight(): number;
  getStartIndexByPosY(y: number): number;
}

export interface IMutableListModel extends IListModel {
  insertElementAt(v: any, i: number): void;
  removeElementAt(i: number): void;
}

export class ListDataEvent extends ModelEvent {
  private index0: number;
  private index1: number;
  private removedItems: any[];

  constructor(source: unknown, index0: number, index1: number, removed: any[]) {
    super(source);
    this.index0 = index0 | 0;
    this.index1 = index1 | 0;
    this.removedItems = removed.concat();
  }

  getIndex0(): number { return this.index0; }
  getIndex1(): number { return this.index1; }
  getRemovedItems(): any[] { return this.removedItems.concat(); }
}

export class BaseListModel {
  private listeners: ListDataListener[] = [];

  addListDataListener(l: ListDataListener): void { this.listeners.push(l); }

  removeListDataListener(l: ListDataListener): void {
    const i = this.listeners.indexOf(l);
    if (i >= 0) this.listeners.splice(i, 1);
  }

  protected fireContentsChanged(source: unknown, i0: number, i1: number, removed: any[]): void {
    const e = new ListDataEvent(source, i0, i1, removed);
    for (let i = this.listeners.length - 1; i >= 0; i--) this.listeners[i].contentsChanged(e);
  }

  protected fireIntervalAdded(source: unknown, i0: number, i1: number): void {
    const e = new ListDataEvent(source, i0, i1, []);
    for (let i = this.listeners.length - 1; i >= 0; i--) this.listeners[i].intervalAdded(e);
  }

  protected fireIntervalRemoved(source: unknown, i0: number, i1: number, removed: any[]): void {
    const e = new ListDataEvent(source, i0, i1, removed);
    for (let i = this.listeners.length - 1; i >= 0; i--) this.listeners[i].intervalRemoved(e);
  }
}

const CASEINSENSITIVE = 1, DESCENDING = 2, UNIQUESORT = 4, RETURNINDEXEDARRAY = 8, NUMERIC = 16;

function compareBy(opts: number): (a: any, b: any) => number {
  return (a, b) => {
    let r: number;
    if (opts & NUMERIC) r = Number(a) - Number(b);
    else {
      let sa = String(a), sb = String(b);
      if (opts & CASEINSENSITIVE) { sa = sa.toLowerCase(); sb = sb.toLowerCase(); }
      r = sa < sb ? -1 : sa > sb ? 1 : 0;
    }
    return opts & DESCENDING ? -r : r;
  };
}

export class VectorListModel extends BaseListModel implements IMutableListModel {
  static readonly CASEINSENSITIVE = CASEINSENSITIVE;
  static readonly DESCENDING = DESCENDING;
  static readonly NUMERIC = NUMERIC;
  static readonly RETURNINDEXEDARRAY = RETURNINDEXEDARRAY;
  static readonly UNIQUESORT = UNIQUESORT;
  protected _elements: any[];

  constructor(arr: any[] | null = null) {
    super();
    this._elements = arr ? arr.concat() : [];
  }

  append(v: any, index = -1): void {
    if (index === -1) {
      index = this._elements.length;
      this._elements.push(v);
    } else {
      this._elements.splice(index, 0, v);
    }
    this.fireIntervalAdded(this, index, index);
  }

  appendAll(arr: any[] | null, index = -1): void {
    if (!arr || arr.length <= 0) return;
    if (index === -1) index = this._elements.length;
    if (index === 0) this._elements = arr.concat(this._elements);
    else if (index === this._elements.length) this._elements = this._elements.concat(arr);
    else {
      const tail = this._elements.splice(index);
      this._elements = this._elements.concat(arr).concat(tail);
    }
    this.fireIntervalAdded(this, index, index + arr.length - 1);
  }

  appendList(list: { toArray(): any[] }, index = -1): void { this.appendAll(list.toArray(), index); }

  clear(): void {
    const last = this.size() - 1;
    if (last >= 0) {
      const old = this.toArray();
      this._elements.splice(0);
      this.fireIntervalRemoved(this, 0, last, old);
    }
  }

  contains(v: any): boolean { return this.indexOf(v) >= 0; }
  first(): any { return this._elements[0]; }
  get(i: number): any { return this._elements[i]; }
  getElementAt(i: number): any { return this._elements[i]; }
  getSize(): number { return this.size(); }

  indexOf(v: any): number {
    for (let i = 0; i < this._elements.length; i++) if (this._elements[i] == v) return i;
    return -1;
  }

  insertElementAt(v: any, i: number): void { this.append(v, i); }
  isEmpty(): boolean { return this._elements.length <= 0; }
  last(): any { return this._elements[this._elements.length - 1]; }
  pop(): any { return this.size() > 0 ? this.removeAt(this.size() - 1) : null; }

  remove(v: any): any {
    const i = this.indexOf(v);
    return i >= 0 ? this.removeAt(i) : null;
  }

  removeAt(i: number): any {
    if (i < 0 || i >= this.size()) return null;
    const v = this._elements[i];
    this._elements.splice(i, 1);
    this.fireIntervalRemoved(this, i, i, [v]);
    return v;
  }

  removeElementAt(i: number): void { this.removeAt(i); }

  removeRange(from: number, to: number): any[] {
    if (this._elements.length > 0) {
      from = Math.max(0, from);
      to = Math.min(to, this._elements.length - 1);
      if (from > to) return [];
      const removed = this._elements.splice(from, to - from + 1);
      this.fireIntervalRemoved(this, from, to, removed);
      return removed;
    }
    return [];
  }

  replaceAt(i: number, v: any): any {
    if (i < 0 || i >= this.size()) return null;
    const old = this._elements[i];
    this._elements[i] = v;
    this.fireContentsChanged(this, i, i, [old]);
    return old;
  }

  shift(): any { return this.size() > 0 ? this.removeAt(0) : null; }
  size(): number { return this._elements.length; }

  sort(a?: unknown, b?: unknown): any[] {
    if (typeof a === 'function') {
      this._elements.sort(a as (x: any, y: any) => number);
      if (typeof b === 'number' && b & DESCENDING) this._elements.reverse();
    } else {
      this._elements.sort(compareBy(Number(a) || 0));
    }
    this.fireContentsChanged(this, 0, this._elements.length - 1, []);
    return this._elements;
  }

  sortOn(names: unknown, opts?: unknown): any[] {
    const fields = Array.isArray(names) ? names.map(String) : [String(names)];
    const optList = Array.isArray(opts) ? opts.map(Number) : fields.map(() => Number(opts) || 0);
    this._elements.sort((x, y) => {
      for (let i = 0; i < fields.length; i++) {
        const r = compareBy(optList[i] ?? 0)(x?.[fields[i]], y?.[fields[i]]);
        if (r !== 0) return r;
      }
      return 0;
    });
    this.fireContentsChanged(this, 0, this._elements.length - 1, []);
    return this._elements;
  }

  subArray(start: number, length: number): any[] {
    if (this.size() === 0 || length <= 0) return [];
    return this._elements.slice(start, Math.min(start + length, this.size()));
  }

  toArray(): any[] { return this._elements.concat(); }
  override toString(): string { return 'VectorListModel : ' + this._elements.toString(); }

  valueChanged(v: any): void { this.valueChangedAt(this.indexOf(v)); }
  valueChangedAt(i: number): void {
    if (i >= 0 && i < this._elements.length) this.fireContentsChanged(this, i, i, []);
  }
  valueChangedRange(from: number, to: number): void { this.fireContentsChanged(this, from, to, []); }

  get elements(): any[] { return this._elements; }

  getCellPosFromIndex(index: number): number {
    let pos = 0;
    const n = this.size();
    if (index > n) index = n;
    for (let i = 0; i < index; i++) pos += this.get(i).getCellHeight();
    return pos;
  }

  getAllCellHeight(): number {
    let h = 0;
    for (let i = 0; i < this.size(); i++) h += this.get(i).getCellHeight();
    return h;
  }

  getStartIndexByPosY(y: number): number {
    let acc = 0;
    for (let i = 0; i < this.size(); i++) {
      acc += this.get(i).getCellHeight();
      if (acc >= y) return i;
    }
    return 0;
  }
}

Domain.registerClass('com.pickgliss.ui.controls.list.VectorListModel', VectorListModel);
Domain.registerClass('com.pickgliss.ui.controls.list.BaseListModel', BaseListModel);
