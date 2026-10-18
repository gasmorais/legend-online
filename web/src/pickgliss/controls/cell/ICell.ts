import type { Container } from 'pixi.js';
import type { List } from '../list/List';

export interface ICell extends Container {
  getCellValue(): any;
  setCellValue(v: any): void;
}

export interface IListCell extends ICell {
  setListCellStatus(list: List, selected: boolean, index: number): void;
}

export interface IListCellFactory {
  createNewCell(): IListCell;
  getCellHeight(): number;
  getViewWidthNoCount(): number;
  isAllCellHasSameHeight(): boolean;
  isShareCells(): boolean;
}

export interface INotSameHeightListCellData {
  getCellHeight(): number;
}
