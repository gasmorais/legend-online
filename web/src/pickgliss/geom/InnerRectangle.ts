import { Rectangle } from 'pixi.js';

export class InnerRectangle {
  para1: number;
  para2: number;
  para3: number;
  para4: number;
  lockDirection: number;

  constructor(p1: unknown = 0, p2: unknown = 0, p3: unknown = 0, p4: unknown = -9999, lock: unknown = 0) {
    this.para1 = Number(p1) | 0;
    this.para2 = Number(p2) | 0;
    this.para3 = Number(p3) | 0;
    this.para4 = p4 === undefined || p4 === '' ? -9999 : Number(p4) | 0;
    this.lockDirection = lock === undefined || lock === '' ? 0 : Number(lock) | 0;
    if (this.para4 === -9999 && this.lockDirection === 0) this.lockDirection = this.para3;
  }

  equals(o: InnerRectangle | null | undefined): boolean {
    if (!o) return false;
    return this.para4 === o.para4 && this.para1 === o.para1 && this.lockDirection === o.lockDirection
      && this.para2 === o.para2 && this.para3 === o.para3;
  }

  getInnerRect(W: number, H: number): Rectangle {
    W = Math.trunc(Number(W)) || 0;
    H = Math.trunc(Number(H)) || 0;
    const { para1: p1, para2: p2, para3: p3, para4: p4 } = this;
    const r = new Rectangle();
    switch (this.lockDirection) {
      case 0: r.x = p1; r.y = p3; r.width = W - p1 - p2; r.height = H - p3 - p4; break;
      case 1: r.x = p1; r.y = p3; r.width = W - p1 - p2; r.height = p4; break;
      case 2: r.x = p1; r.y = p3; r.width = p2; r.height = H - p3 - p4; break;
      case 3: r.x = W - p1 - p2; r.y = p3; r.width = p1; r.height = H - p3 - p4; break;
      case 4: r.x = p1; r.y = H - p3 - p4; r.width = W - p1 - p2; r.height = p3; break;
      case 5: r.x = p1; r.y = p2; r.width = W - p3; r.height = H - p4; break;
      case 9: r.x = (W - p1) / 2 + p4; r.y = p3; r.width = p1; r.height = p2; break;
      case 10: r.x = (W - p1) / 2 + p3; r.y = H - p4 - p2; r.width = p1; r.height = p2; break;
      case 11: r.x = p1; r.y = (H - p4) / 2 + p2; r.width = p3; r.height = p4; break;
      case 12: r.x = W - p2 - p3; r.y = (H - p3) / 2 + p1; r.width = p3; r.height = p4; break;
      case 13: r.x = p1; r.y = p3; r.width = p2; r.height = p4; break;
      case 14: r.x = W - p1 - p2; r.y = p3; r.width = p1; r.height = p4; break;
      case 15: r.x = p1; r.y = H - p4 - p3; r.width = p2; r.height = p3; break;
      case 16: r.x = W - p1 - p2; r.y = H - p4 - p3; r.width = p1; r.height = p3; break;
      case 17: r.x = (W - p2) / 2 + p1; r.y = (H - p4) / 2 + p3; r.width = p2; r.height = p4; break;
      case 18: r.x = p1; r.y = p2; r.width = W - p3; r.height = Math.abs(p4); break;
      case 19: r.x = p1; r.y = p2; r.width = 0; r.height = 0; break;
      case -1: r.x = -p1; r.y = -p3; r.width = W + p1 + p2; r.height = H + p4 + p3; break;
      default: break;
    }
    return r;
  }

  static parse(s: string | null | undefined): InnerRectangle | null {
    if (!s) return null;
    return new InnerRectangle(...s.split(','));
  }
}
