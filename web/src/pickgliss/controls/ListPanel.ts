import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { parasArgs } from '../ComponentModel';
import type { IListCellFactory } from './cell/ICell';
import { List } from './list/List';
import type { IListModel, VectorListModel } from './list/VectorListModel';
import { ScrollPanel } from './ScrollPanel';

export class ListPanel extends ScrollPanel {
  static readonly P_factory = 'factory';
  protected _factory: IListCellFactory | null = null;
  protected _factoryStrle = '';
  protected _listStyle = '';

  constructor() {
    super(false);
  }

  override dispose(): void {
    this._factory = null;
    super.dispose();
  }

  get factoryStyle(): string { return this._factoryStrle; }
  set factoryStyle(v: string) {
    if (this._factoryStrle === v) return;
    this._factoryStrle = v;
    const parts = v.split('|');
    this._factory = Domain.createInstance(parts[0], parasArgs(parts[1]));
    this.onPropertiesChanged('factory');
  }

  set updateItemWidth(v: number) { if (this._viewSource) (this._viewSource as any).updateItemWidth = v; }

  get list(): List { return this._viewSource as List; }
  get listModel(): IListModel { return this.list.model; }

  get listStyle(): string { return this._listStyle; }
  set listStyle(v: string) {
    if (this._listStyle === v) return;
    this._listStyle = v;
    this.viewPort = ComponentFactory.Instance.creat(this._listStyle);
  }

  get vectorListModel(): VectorListModel { return this.list.model as VectorListModel; }

  selectFirst(): void {
    if (this._vScrollbar) {
      this.beginChanges();
      this._vScrollbar.scrollValue = 0;
      this.commitChanges();
    }
    this.list.defaultSelectItemByCellValue = this.vectorListModel.first();
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if ((ch.factory || ch.viewSource) && this.list instanceof List) this.list.cellFactory = this._factory;
  }
}

Domain.registerClass('com.pickgliss.ui.controls.ListPanel', ListPanel);
