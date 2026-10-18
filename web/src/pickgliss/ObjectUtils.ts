import type { Container } from 'pixi.js';
import type { Attrs } from './ComponentModel';

const NUMERIC = new Set(['x', 'y', 'width', 'height', 'alpha', 'rotation', 'scaleX', 'scaleY', 'leading', 'letterSpacing',
  'size', 'color', 'indent', 'leftMargin', 'rightMargin', 'spacing', 'containerX', 'containerY', 'maxChars', 'hSpace', 'vSpace']);

function hasProperty(obj: object, name: string): boolean {
  if (name in obj) return true;
  return Object.prototype.hasOwnProperty.call(obj, '_' + name);
}

export function coerce(obj: any, name: string, value: string | boolean): unknown {
  if (value === false) return false;
  let current: unknown;
  try { current = obj[name]; } catch { current = undefined; }
  if (typeof current === 'number' || NUMERIC.has(name)) {
    const v = String(value).trim();
    const n = /^0x/i.test(v) ? parseInt(v, 16) : Number(v);
    return Number.isNaN(n) ? value : n;
  }
  if (typeof current === 'boolean') return value === 'true' || value === true;
  return value;
}

export function setProperty(obj: any, name: string, value: string | boolean): void {
  const v = coerce(obj, name, value);
  if (name === 'scaleX') (obj as Container).scale.x = v as number;
  else if (name === 'scaleY') (obj as Container).scale.y = v as number;
  else if (name === 'rotation' && typeof obj.angle === 'number') obj.angle = v;
  else obj[name] = v;
}

export function copyPorpertiesByXML(obj: any, attrs: Attrs): void {
  if (!obj || typeof obj !== 'object') return;
  if (typeof obj.beginChanges === 'function') obj.beginChanges();
  for (const [name, raw] of attrs) {
    if (name === 'classname' || name === 'stylename' || name === 'type' && !('_type' in obj)) continue;
    if (!hasProperty(obj, name) && name !== 'scaleX' && name !== 'scaleY') continue;
    setProperty(obj, name, raw === 'false' ? false : raw);
  }
  if (typeof obj.commitChanges === 'function') obj.commitChanges();
}

export function combineXML(child: Attrs, parent: Attrs | undefined): Attrs {
  if (!parent) return child;
  const have = new Set(child.map(([k]) => k));
  return [...child, ...parent.filter(([k]) => !have.has(k))];
}

export function disposeObject(obj: any): void {
  if (!obj) return;
  if (typeof obj.dispose === 'function' && !obj.__disposing) {
    obj.__disposing = true;
    obj.dispose();
  } else if (typeof obj.destroy === 'function' && !obj.destroyed) {
    obj.parent?.removeChild(obj);
  }
}
