import type { Container } from 'pixi.js';
import { Event } from '@/flash/events';
import { Domain } from '@/flash/library';
import { getObjectHeight, getObjectWidth } from '../../utils/DisplayUtils';
import { BoxContainer } from './BoxContainer';

export class VBox extends BoxContainer {
  autoCenter = false;
  firstYPos = 0;

  override arrange(): void {
    const list = this._childrenList;
    if (!list) return;
    this._width = 0;
    this._height = 0;
    let y = this.firstYPos;
    for (const child of list) {
      child.y = y;
      const h = this.getItemHeight(child);
      const w = this.getItemWidth(child);
      y += h;
      y += this._spacing;
      this._height += h;
      this._width = Math.max(this._width, w);
      this.refreshDirection(child);
    }
    this._height += this._spacing * (this.children.length - 1);
    this._height = Math.max(0, this._height);
    if (this.autoCenter) {
      const off = (0.5 * this._height) | 0;
      for (const child of list) child.y -= off;
    }
    this.dispatchEvent(new Event(Event.RESIZE));
  }

  protected override refreshDirection(child: Container): void {
    if (this._direction === 2 && this.isStrictWidth) child.x = this._strictWidth - this.getItemWidth(child);
  }

  override removeAllChild(): void {
    const n = this.children.length;
    for (let i = 0; i < n; i++) {
      const c = this.children[0];
      this.removeChild(c);
      c.y = 0;
      c.off('propertiesChanged', this.__onResize, this);
    }
  }

  private getItemWidth(c: Container): number { return getObjectWidth(c); }

  private getItemHeight(c: Container): number {
    if (this.isStrictHeight) return this._strictHeight;
    return getObjectHeight(c);
  }
}

Domain.registerClass('com.pickgliss.ui.controls.container.VBox', VBox);
