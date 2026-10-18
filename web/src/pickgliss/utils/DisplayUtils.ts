import { Container, Graphics, Rectangle } from 'pixi.js';
import { MovieClip } from '@/flash/display';
import { TextField, type TextFormat } from '@/flash/text';
import { Component, GRAY_FILTER } from '../core/Component';
import type { InnerRectangle } from '../geom/InnerRectangle';
import { Image } from '../image/images';
import { disposeObject } from '../ObjectUtils';
import { FilterFrameText } from '../text/FilterFrameText';

export const DisplayUtils = {
  get grayFilter() { return GRAY_FILTER; },

  setFrame(obj: unknown, frame: number): void {
    if (obj instanceof Image) obj.setFrame(frame);
    else if (obj instanceof MovieClip) obj.gotoAndStop(frame);
    else if (obj instanceof FilterFrameText) obj.setFrame(frame);
  },

  layoutDisplayWithInnerRect(obj: Container | null | undefined, rect: InnerRectangle | null | undefined, w: number, h: number): void {
    if (!obj || !rect) return;
    if (obj instanceof Component) obj.beginChanges();
    const r = rect.getInnerRect(w, h);
    obj.x = r.x;
    obj.y = r.y;
    if (r.width !== 0) obj.width = r.width;
    if (r.height !== 0) obj.height = r.height;
    if (obj instanceof Component) obj.commitChanges();
  },

  setDisplayObjectNotEnable(obj: Container | null | undefined): void {
    if (!obj) return;
    const o = obj as any;
    if ('mouseChildren' in o) o.mouseChildren = false;
    obj.eventMode = 'passive';
  },

  isTargetOrContain(target: unknown, container: unknown): boolean {
    if (!target || !container) return false;
    if (target === container) return true;
    let p = (target as Container).parent;
    while (p) {
      if (p === container) return true;
      p = p.parent;
    }
    return false;
  },

  getPointFromObject(p: { x: number; y: number }, from: Container, to: Container | null): { x: number; y: number } {
    const g = from.toGlobal(p);
    return to ? to.toLocal(g) : g;
  },

  drawRectShape(w: number, h: number, shape: Graphics | null = null): Graphics {
    const s = shape ?? new Graphics();
    s.clear();
    if (w > 0 && h > 0) s.rect(0, 0, w, h).fill({ color: 0xff0000, alpha: 1 });
    return s;
  },

  getTextFieldMaxLineWidth(text: string, format: TextFormat, html: boolean): number {
    const tf = new TextField();
    tf.autoSize = 'left';
    if (html) text = text.replace(/<br>/i, '\n');
    let max = 0;
    for (const line of text.split('\n')) {
      if (html) tf.htmlText = line;
      else { tf.text = line; tf.setTextFormat(format); }
      max = Math.min(800, Math.max(max, tf.width));
    }
    tf.destroy({ children: true });
    return max + 2;
  },

  getTextFieldLineHeight(tf: TextField): number {
    return tf.numLines > 0 ? Math.floor(tf.textHeight / tf.numLines) : 0;
  },

  handleDisplay(visible: boolean, ...objs: (Container | null | undefined)[]): void {
    for (const o of objs) if (o) o.visible = visible;
  },
};

export function getObjectWidth(o: Container): number {
  const a = o as any;
  if (a.viewRectangle instanceof Rectangle || (a.viewRectangle && typeof a.viewRectangle.width === 'number')) return a.viewRectangle.width;
  if (typeof a.manualWidth === 'number') return a.manualWidth;
  if (o instanceof Component) return o.displayWidth;
  return o.width;
}

export function getObjectHeight(o: Container): number {
  const a = o as any;
  if (a.viewRectangle && typeof a.viewRectangle.height === 'number') return a.viewRectangle.height;
  if (typeof a.manualHeight === 'number') return a.manualHeight;
  if (o instanceof Component) return o.displayHeight;
  return o.height;
}

export function disposeAllChildren(c: Container | null | undefined): void {
  if (!c) return;
  while (c.children.length > 0) {
    const child: Container = c.children[0];
    disposeObject(child);
    if (child.parent === c) c.removeChild(child);
  }
}

export function unionRect(a: Rectangle, b: Rectangle | null | undefined): Rectangle {
  if (!b || b.width <= 0 || b.height <= 0) return a.clone();
  if (a.width <= 0 || a.height <= 0) return b.clone();
  const x0 = Math.min(a.x, b.x), y0 = Math.min(a.y, b.y);
  const x1 = Math.max(a.x + a.width, b.x + b.width), y1 = Math.max(a.y + a.height, b.y + b.height);
  return new Rectangle(x0, y0, x1 - x0, y1 - y0);
}

export function rectShape(color: number, alpha: number, w = 100, h = 100): Graphics {
  return new Graphics().rect(0, 0, w, h).fill({ color, alpha });
}

export const toNum = (v: unknown): number => (typeof v === 'number' ? v : Number(v));
export const toInt = (v: unknown): number => Number(v) | 0;
export const toBool = (v: unknown): boolean => v === true || v === 'true' || (typeof v === 'number' && v !== 0);
