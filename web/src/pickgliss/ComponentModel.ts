import { Domain } from '@/flash/library';
import { copyPorpertiesByXML } from './ObjectUtils';

export type Attrs = [string, string][];

export interface StyleNode {
  tag: string;
  attrs: Attrs;
  file: string;
}

export function attrsOf(el: Element): Attrs {
  return Array.from(el.attributes, (a) => [a.name, a.value] as [string, string]);
}

export function getAttr(attrs: Attrs, name: string): string | undefined {
  return attrs.find(([k]) => k === name)?.[1];
}

export function parasArgs(s: string | undefined | null): string[] {
  return String(s ?? '').split(',').map((x) => x.trim());
}

export class ComponentModel {
  readonly loaded = new Map<string, string>();
  private components = new Map<string, StyleNode>();
  private customs = new Map<string, StyleNode>();
  private bitmapSets = new Map<string, StyleNode>();
  private styleSets = new Map<string, unknown>();
  private setNodes = new Map<string, StyleNode>();

  addComponentSet(file: string, doc: Document): void {
    const root = doc.documentElement;
    const name = root.getAttribute('name') ?? file;
    if (this.loaded.has(name)) return;
    this.loaded.set(name, root.getAttribute('source') ?? '');
    for (const el of Array.from(root.getElementsByTagName('set'))) this.parasSet(el, file);
    for (const el of Array.from(root.getElementsByTagName('component'))) {
      const st = el.getAttribute('stylename');
      if (st) this.components.set(st, { tag: 'component', attrs: attrsOf(el), file });
    }
    for (const el of Array.from(root.getElementsByTagName('custom'))) {
      const st = el.getAttribute('stylename');
      if (st) this.customs.set(st, { tag: 'custom', attrs: attrsOf(el), file });
    }
    for (const tag of ['bitmapData', 'bitmap']) {
      for (const el of Array.from(root.getElementsByTagName(tag))) {
        const link = el.getAttribute('resourceLink');
        if (link) this.bitmapSets.set(link, { tag, attrs: attrsOf(el), file });
      }
    }
  }

  private parasSet(el: Element, file: string): void {
    const st = el.getAttribute('stylename');
    const type = el.getAttribute('type');
    if (!st || !type) return;
    const args = parasArgs(el.getAttribute('args'));
    this.setNodes.set(st, { tag: 'set', attrs: attrsOf(el), file });
    try {
      const obj = type === 'flash.filters.ColorMatrixFilter'
        ? Domain.createInstance(type, [args.map(Number)])
        : Domain.createInstance(type, el.getAttribute('args') === null ? [] : args);
      copyPorpertiesByXML(obj, attrsOf(el));
      this.styleSets.set(st, obj);
    } catch (err) {
      console.warn('[ComponentModel] set inválido', st, type, err);
    }
  }

  getComonentStyle(name: string): StyleNode | undefined { return this.components.get(name); }
  getCustomObjectStyle(name: string): StyleNode | undefined { return this.customs.get(name); }
  getBitmapSet(name: string): StyleNode | undefined { return this.bitmapSets.get(name); }
  addBitmapSet(name: string, node: StyleNode): void { this.bitmapSets.set(name, node); }
  getSet(name: string): unknown { return this.styleSets.get(name); }
  getSetNode(name: string): StyleNode | undefined { return this.setNodes.get(name); }

  describe(name: string): StyleNode | undefined {
    return this.components.get(name) ?? this.customs.get(name) ?? this.bitmapSets.get(name) ?? this.setNodes.get(name);
  }
}
