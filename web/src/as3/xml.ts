import { $ } from './runtime';

type Item = Element | Attr | Text;

const parser = () => new DOMParser();

function wrapItem(n: Item): any { return makeXML(n); }

function listOf(items: Item[]): any { return makeList(items); }

function textOf(n: Item): string {
  if (n instanceof Attr) return n.value;
  return n.textContent ?? '';
}

function simple(n: Item): boolean {
  return !(n instanceof Element) || !Array.from(n.childNodes).some((c) => c.nodeType === 1);
}

function serialize(n: Item): string {
  if (n instanceof Attr) return n.value;
  if (n instanceof Text) return n.data;
  return new XMLSerializer().serializeToString(n);
}

function childElements(n: Item, name?: string): Element[] {
  if (!(n instanceof Element)) return [];
  return Array.from(n.children).filter((c) => !name || name === '*' || c.localName === name || c.tagName === name);
}

function descendants(n: Item, name: string): Element[] {
  if (!(n instanceof Element)) return [];
  const all = Array.from(n.getElementsByTagName('*'));
  return name === '*' ? all : all.filter((c) => c.localName === name || c.tagName === name);
}

class XMLImpl {
  __isXML = true;
  constructor(public node: Item) {}
  name(): any { return this.node instanceof Element ? this.node.tagName : this.node instanceof Attr ? this.node.name : null; }
  localName(): any { return this.node instanceof Element ? this.node.localName : this.name(); }
  nodeKind(): string { return this.node instanceof Element ? 'element' : this.node instanceof Attr ? 'attribute' : 'text'; }
  attributes(): any { return listOf(this.node instanceof Element ? Array.from(this.node.attributes) : []); }
  attribute(n: string): any {
    const a = this.node instanceof Element ? this.node.getAttributeNode(String(n).replace(/^@/, '')) : null;
    return listOf(a ? [a] : []);
  }
  children(): any {
    if (!(this.node instanceof Element)) return listOf([]);
    return listOf(Array.from(this.node.childNodes).filter((c) => c.nodeType === 1 || (c.nodeType === 3 && (c as Text).data.trim())) as Item[]);
  }
  child(n: string | number): any { return typeof n === 'number' ? this.children()[n] : listOf(childElements(this.node, n)); }
  elements(n = '*'): any { return listOf(childElements(this.node, n)); }
  descendants(n = '*'): any { return listOf(descendants(this.node, n)); }
  $descendants(n: string): any { return this.descendants(n); }
  text(): any {
    if (!(this.node instanceof Element)) return listOf([]);
    return listOf(Array.from(this.node.childNodes).filter((c) => c.nodeType === 3 || c.nodeType === 4) as Item[]);
  }
  parent(): any { const p = this.node instanceof Attr ? this.node.ownerElement : this.node.parentNode; return p && p.nodeType === 1 ? wrapItem(p as Element) : undefined; }
  length(): number { return 1; }
  hasSimpleContent(): boolean { return simple(this.node); }
  hasComplexContent(): boolean { return !simple(this.node); }
  copy(): any { return wrapItem(this.node.cloneNode(true) as Item); }
  appendChild(x: any): any {
    if (this.node instanceof Element) {
      const nodes: Item[] = x?.__items ?? (x?.node ? [x.node] : [parser().parseFromString(String(x), 'text/xml').documentElement]);
      for (const n of nodes) this.node.appendChild(this.node.ownerDocument.importNode(n, true));
    }
    return this.proxy;
  }
  setName(n: string): void {
    if (!(this.node instanceof Element)) return;
    const e = this.node.ownerDocument.createElement(n);
    for (const a of Array.from(this.node.attributes)) e.setAttribute(a.name, a.value);
    while (this.node.firstChild) e.appendChild(this.node.firstChild);
    this.node.replaceWith(e);
    this.node = e;
  }
  hasOwnProperty(k: string): boolean {
    if (!(this.node instanceof Element)) return false;
    if (k.startsWith('@')) return this.node.hasAttribute(k.slice(1));
    return childElements(this.node, k).length > 0;
  }
  toString(): string { return simple(this.node) ? textOf(this.node) : serialize(this.node); }
  valueOf(): string { return this.toString(); }
  toXMLString(): string { return serialize(this.node); }
  $values(): any[] { return [this.proxy]; }
  $filter(fn: (x: any) => boolean): any { return listOf(fn(this.proxy) ? [this.node] : []); }
  proxy: any;
}

class XMLListImpl {
  __isXML = true;
  constructor(public __items: Item[]) {}
  length(): number { return this.__items.length; }
  toString(): string {
    if (this.__items.length === 1) return wrapItem(this.__items[0]).toString();
    if (this.__items.every((n) => n instanceof Attr || n instanceof Text)) return this.__items.map(textOf).join('');
    return this.__items.map(serialize).join('\n');
  }
  valueOf(): string { return this.toString(); }
  toXMLString(): string { return this.__items.map(serialize).join('\n'); }
  children(): any { return listOf(this.__items.flatMap((n) => childElements(n))); }
  child(n: string): any { return listOf(this.__items.flatMap((x) => childElements(x, n))); }
  elements(n = '*'): any { return this.child(n); }
  attributes(): any { return listOf(this.__items.flatMap((n) => (n instanceof Element ? Array.from(n.attributes) : []))); }
  attribute(n: string): any {
    return listOf(this.__items.flatMap((x) => { const a = x instanceof Element ? x.getAttributeNode(String(n).replace(/^@/, '')) : null; return a ? [a] : []; }));
  }
  descendants(n = '*'): any { return listOf(this.__items.flatMap((x) => descendants(x, n))); }
  $descendants(n: string): any { return this.descendants(n); }
  text(): any { return listOf(this.__items.flatMap((x) => (x instanceof Element ? Array.from(x.childNodes).filter((c) => c.nodeType === 3) as Item[] : []))); }
  name(): any { return this.__items.length === 1 ? wrapItem(this.__items[0]).name() : null; }
  localName(): any { return this.name(); }
  parent(): any { return this.__items[0] ? wrapItem(this.__items[0]).parent() : undefined; }
  copy(): any { return listOf(this.__items.map((n) => n.cloneNode(true) as Item)); }
  hasSimpleContent(): boolean { return this.__items.length <= 1 && (!this.__items[0] || simple(this.__items[0])); }
  hasComplexContent(): boolean { return !this.hasSimpleContent(); }
  hasOwnProperty(k: string): boolean { return this.__items.length === 1 && wrapItem(this.__items[0]).hasOwnProperty(k); }
  $values(): any[] { return this.__items.map(wrapItem); }
  $filter(fn: (x: any) => boolean): any { return listOf(this.__items.filter((n) => fn(wrapItem(n)))); }
  [Symbol.iterator](): Iterator<any> { return this.$values()[Symbol.iterator](); }
}

function getProp(items: Item[], key: string): any {
  if (/^\d+$/.test(key)) { const n = items[Number(key)]; return n ? wrapItem(n) : undefined; }
  if (key.startsWith('@')) {
    const name = key.slice(1);
    return listOf(items.flatMap((n) => {
      if (!(n instanceof Element)) return [];
      if (name === '*') return Array.from(n.attributes);
      const a = n.getAttributeNode(name);
      return a ? [a] : [];
    }));
  }
  return listOf(items.flatMap((n) => childElements(n, key)));
}

function setProp(items: Item[], key: string, value: unknown): void {
  const el = items[0];
  if (!(el instanceof Element)) return;
  const v = value && typeof value === 'object' && '__isXML' in (value as object) ? String(value) : String(value);
  if (key.startsWith('@')) { el.setAttribute(key.slice(1), v); return; }
  let c = childElements(el, key)[0];
  if (!c) { c = el.ownerDocument.createElement(key); el.appendChild(c); }
  c.textContent = v;
}

function delProp(items: Item[], key: string): void {
  for (const n of items) {
    if (!(n instanceof Element)) continue;
    if (key.startsWith('@')) n.removeAttribute(key.slice(1));
    else for (const c of childElements(n, key)) c.remove();
  }
}

function makeXML(node: Item): any {
  const impl = new XMLImpl(node);
  const proxy: any = new Proxy(impl, {
    get(t: any, k) {
      if (typeof k === 'symbol' || k in t) { const v = t[k]; return typeof v === 'function' ? v.bind(t) : v; }
      return getProp([t.node], k);
    },
    set(t: any, k, v) { if (typeof k === 'symbol' || k in t) t[k] = v; else setProp([t.node], k, v); return true; },
    deleteProperty(t: any, k) { if (typeof k === 'string') delProp([t.node], k); return true; },
    has(t: any, k) { return typeof k === 'string' && (k in t || t.hasOwnProperty(k)); },
  });
  impl.proxy = proxy;
  return proxy;
}

function makeList(items: Item[]): any {
  const impl = new XMLListImpl(items);
  return new Proxy(impl, {
    get(t: any, k) {
      if (typeof k === 'symbol' || k in t) { const v = t[k]; return typeof v === 'function' ? v.bind(t) : v; }
      return getProp(t.__items, k);
    },
    set(t: any, k, v) { if (typeof k === 'symbol' || k in t) t[k] = v; else setProp(t.__items, k, v); return true; },
    deleteProperty(t: any, k) { if (typeof k === 'string') delProp(t.__items, k); return true; },
    has(t: any, k) { return typeof k === 'string' && (k in t || /^\d+$/.test(k) && Number(k) < t.__items.length); },
    ownKeys(t: any) { return t.__items.map((_: unknown, i: number) => String(i)); },
    getOwnPropertyDescriptor(t: any, k) {
      return typeof k === 'string' && /^\d+$/.test(k) && Number(k) < t.__items.length ? { enumerable: true, configurable: true } : undefined;
    },
  });
}

export function XML(this: unknown, value?: unknown): any {
  if (value && typeof value === 'object' && '__isXML' in (value as object)) {
    const v: any = value;
    return v.__items ? (v.__items[0] ? makeXML(v.__items[0]) : makeXML(parser().parseFromString('<x/>', 'text/xml').documentElement)) : v;
  }
  if (value instanceof Element) return makeXML(value);
  const src = value === undefined || value === null ? '' : String(value).trim();
  if (!src) return makeXML(document.createTextNode(''));
  if (!src.startsWith('<')) return makeXML(document.createTextNode(src));
  const doc = parser().parseFromString(src, 'text/xml');
  return makeXML(doc.documentElement);
}

export function XMLList(this: unknown, value?: unknown): any {
  if (value && typeof value === 'object' && '__items' in (value as object)) return value;
  if (value && typeof value === 'object' && '__isXML' in (value as object)) return makeList([(value as any).node]);
  const src = value === undefined || value === null ? '' : String(value).trim();
  if (!src) return makeList([]);
  const doc = parser().parseFromString(`<__root>${src}</__root>`, 'text/xml');
  return makeList(Array.from(doc.documentElement.children));
}

(XML as any).ignoreWhitespace = true;
(XML as any).ignoreComments = true;
(XML as any).prettyPrinting = true;

$.XML = XML;
$.XMLList = XMLList;
