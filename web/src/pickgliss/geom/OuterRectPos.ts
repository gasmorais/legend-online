import { Point } from 'pixi.js';
import { Domain } from '@/flash/library';

export class OuterRectPos {
  private _posX: number;
  private _posY: number;
  private _lockDirection: number;

  constructor(posX: unknown = 0, posY: unknown = 0, lock: unknown = 0) {
    this._posX = Number(posX) | 0;
    this._posY = Number(posY) | 0;
    this._lockDirection = Number(lock) | 0;
  }

  getPos(w: number, _h: number, outerW: number, _outerH: number): Point {
    const p = new Point();
    w |= 0;
    outerW |= 0;
    if (this._lockDirection === 1) {
      p.x = (outerW - w) / 2 + this._posX;
      p.y = this._posY;
    } else if (this._lockDirection === 5) {
      p.x = this._posX;
      p.y = this._posY;
    }
    return p;
  }

  static parse(s: string | null | undefined): OuterRectPos | null {
    if (!s) return null;
    return new OuterRectPos(...s.split(',').map((x) => x.trim()));
  }
}

Domain.registerClass('com.pickgliss.geom.OuterRectPos', OuterRectPos);
