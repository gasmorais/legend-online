import { Domain } from '@/flash/library';
import { ComponentFactory } from '../../ComponentFactory';
import type { IListCell, IListCellFactory } from './ICell';

export class SimpleListCellFactory implements IListCellFactory {
  private _ViewWidthNoCount: number;
  private _allCellHasSameHeight: boolean;
  private _cellHeight: number;
  private _cellStyle: string;
  private _shareCells: boolean;

  constructor(cellStyle: string, cellHeight: unknown, viewWidthNoCount: unknown = -1, allSameHeight: unknown = 'true', shareCells: unknown = 'true') {
    this._cellStyle = cellStyle;
    this._allCellHasSameHeight = String(allSameHeight) === 'true';
    this._shareCells = String(shareCells) === 'true';
    this._cellHeight = Number(cellHeight) | 0;
    this._ViewWidthNoCount = Number(viewWidthNoCount) | 0;
  }

  createNewCell(): IListCell { return ComponentFactory.Instance.creat(this._cellStyle); }
  getCellHeight(): number { return this._cellHeight; }
  getViewWidthNoCount(): number { return this._ViewWidthNoCount; }
  isAllCellHasSameHeight(): boolean { return this._allCellHasSameHeight; }
  isShareCells(): boolean { return this._shareCells; }
}

Domain.registerClass('com.pickgliss.ui.controls.cell.SimpleListCellFactory', SimpleListCellFactory);
