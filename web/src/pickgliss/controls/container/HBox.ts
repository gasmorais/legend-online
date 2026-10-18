import type { Container } from 'pixi.js';
import { Event } from '@/flash/events';
import { Domain } from '@/flash/library';
import { getObjectHeight, getObjectWidth } from '../../utils/DisplayUtils';
import { BoxContainer } from './BoxContainer';

export class HBox extends BoxContainer {
  autoCenter = false;

  override arrange(): void {
    const list = this._childrenList;
    if (!list) return;
    this._width = 0;
    this._height = 0;
    let x = 0;
    for (const child of list) {
      const w = this.getItemWidth(child);
      const h = this.getItemHeight(child);
      child.x = x;
      x += w;
      x += this._spacing;
      this._width += w;
      this._height = Math.max(this._height, h);
    }
    this._width += this._spacing * (this.children.length - 1);
    this._width = Math.max(0, this._width);
    if (this.autoCenter) {
      const off = (0.5 * this._width) | 0;
      for (const child of list) child.x -= off;
    }
    this.dispatchEvent(new Event(Event.RESIZE));
  }

  private getItemHeight(c: Container): number { return getObjectHeight(c); }

  private getItemWidth(c: Container): number {
    if (this.isStrictWidth) return this._strictWidth;
    return getObjectWidth(c);
  }
}

Domain.registerClass('com.pickgliss.ui.controls.container.HBox', HBox);
