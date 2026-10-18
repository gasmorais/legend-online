import { Domain } from '@/flash/library';
import { AbstractTextButton } from '../AbstractTextButton';
import type { List } from '../list/List';
import type { IListCell } from './ICell';

export class TextButtonListCellAdapter extends AbstractTextButton implements IListCell {
  getCellValue(): any { return this._text; }
  setCellValue(v: any): void { this.text = v; }
  setListCellStatus(_list: List, _selected: boolean, _index: number): void {}
}

Domain.registerClass('com.pickgliss.ui.controls.cell.TextButtonListCellAdapter', TextButtonListCellAdapter);
