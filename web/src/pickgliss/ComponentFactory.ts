import { BitmapData } from '@/flash/bitmapdata';
import { Domain } from '@/flash/library';
import { filterDefs } from '@/flash/builtins';
import type { FlashFilterDef } from '@/flash/filters';
import { ComponentModel, getAttr, parasArgs, type Attrs, type StyleNode } from './ComponentModel';
import { combineXML, copyPorpertiesByXML } from './ObjectUtils';
import { CustomBitmap } from './image/CustomBitmap';
import { Component } from './core/Component';

export const createdBy = new WeakMap<object, string>();

const REF_ATTR = /(Style|resourceLink|Link)$/;

class ComponentFactoryClass {
  readonly model = new ComponentModel();
  private counter = 0;
  private all = new Map<number, unknown>();
  private styleIndex = new Map<string, string>();
  private fileLoads = new Map<string, Promise<void>>();

  static parasArgs = parasArgs;

  async init(): Promise<void> {
    const res = await fetch('/lib/style-index.json');
    const idx = (await res.json()) as Record<string, string>;
    for (const [k, v] of Object.entries(idx)) this.styleIndex.set(k, v);
    await Promise.all([this.loadStyleFile('core.xml'), Domain.ensure(['core', 'core2'])]);
  }

  get componentID(): number { return this.counter++; }

  fileOf(name: string): string | undefined { return this.styleIndex.get(name); }

  loadStyleFile(file: string): Promise<void> {
    let p = this.fileLoads.get(file);
    if (!p) {
      p = (async () => {
        const res = await fetch(`/ui/xml/${file}`);
        if (!res.ok) throw new Error(`estilo ${file}: HTTP ${res.status}`);
        const doc = new DOMParser().parseFromString(await res.text(), 'text/xml');
        const source = doc.documentElement.getAttribute('source') ?? '';
        const swf = /swf\/([^/]+)\.swf$/i.exec(source)?.[1];
        if (swf) await Domain.loadLibrary(swf).catch((e) => console.warn('[factory] lib', swf, e));
        this.model.addComponentSet(file, doc);
      })();
      this.fileLoads.set(file, p);
    }
    return p;
  }

  async preload(names: Iterable<string>): Promise<void> {
    const seen = new Set<string>();
    let queue = [...names];
    while (queue.length) {
      const files = new Set<string>();
      const libs = new Set<string>();
      for (const n of queue) {
        if (!n || seen.has(n)) continue;
        seen.add(n);
        const f = this.fileOf(n);
        if (f && !this.model.loaded.has(f.replace(/\.xml$/, ''))) files.add(f);
        const lib = Domain.libraryOf(n);
        if (lib) libs.add(lib);
      }
      await Promise.all([...[...files].map((f) => this.loadStyleFile(f)), Domain.ensure(libs)]);
      const next: string[] = [];
      for (const n of queue) {
        const node = this.model.describe(n);
        if (!node) continue;
        for (const [k, v] of node.attrs) {
          if (k === 'parentStyle' || REF_ATTR.test(k) || k === 'filterString' || k === 'textFormatStyle') {
            for (const item of v.split(/[,|]/)) if (item.trim() && !seen.has(item.trim())) next.push(item.trim());
          }
        }
      }
      queue = next;
    }
  }

  private mergedStyle(node: StyleNode | undefined, get: (n: string) => StyleNode | undefined): Attrs | undefined {
    if (!node) return undefined;
    let attrs = node.attrs;
    let parent = getAttr(attrs, 'parentStyle');
    const guard = new Set<string>();
    while (parent && !guard.has(parent)) {
      guard.add(parent);
      attrs = combineXML(attrs.filter(([k]) => k !== 'parentStyle'), get(parent)?.attrs);
      parent = getAttr(attrs, 'parentStyle');
    }
    return attrs.filter(([k]) => k !== 'parentStyle');
  }

  getComponentStyle(name: string): Attrs | undefined {
    return this.mergedStyle(this.model.getComonentStyle(name), (n) => this.model.getComonentStyle(n));
  }

  creat(name: string, args?: unknown[]): any {
    if (this.model.getComonentStyle(name)) return this.creatComponentByStylename(name, args);
    if (this.model.getBitmapSet(name) || Domain.symbolKind(name) === 'bitmap') return this.creatBitmap(name);
    if (this.model.getCustomObjectStyle(name)) return this.creatCustomObject(name, args);
    const inst = Domain.createInstance(name, args);
    if (inst && typeof inst === 'object') createdBy.set(inst, name);
    return inst;
  }

  creatComponentByStylename(name: string, args?: unknown[]): any {
    const attrs = this.getComponentStyle(name);
    if (!attrs) throw new Error(`estilo inexistente: ${name}`);
    const classname = getAttr(attrs, 'classname') ?? '';
    const inst: any = Domain.createInstance(classname, args);
    inst.id = this.componentID;
    this.all.set(inst.id, inst);
    createdBy.set(inst, name);
    if (inst instanceof Component) {
      inst.stylename = name;
      inst.beginChanges();
      copyPorpertiesByXML(inst, attrs);
      inst.commitChanges();
    } else {
      copyPorpertiesByXML(inst, attrs);
    }
    return inst;
  }

  creatBitmap(name: string): CustomBitmap {
    const node = this.model.getBitmapSet(name);
    let bmp: CustomBitmap;
    if (!node) {
      bmp = new CustomBitmap(Domain.createInstance(name, [0, 0]));
    } else {
      bmp = node.tag === 'bitmapData'
        ? new CustomBitmap(this.creatBitmapData(name), 'auto', getAttr(node.attrs, 'smoothing') === 'true')
        : Domain.createInstance(name);
      copyPorpertiesByXML(bmp, node.attrs.filter(([k]) => k !== 'resourceLink'));
    }
    createdBy.set(bmp, name);
    return bmp;
  }

  creatBitmapData(name: string): any {
    if (!Domain.hasDefinition(name) && Domain.missingPlaceholder) {
      Domain.createInstance(name);
      return new BitmapData(1, 1, true, 0);
    }
    return Domain.createInstance(name, [0, 0]);
  }

  creatCustomObject(name: string, args?: unknown[]): any {
    const attrs = this.mergedStyle(this.model.getCustomObjectStyle(name), (n) => this.model.getCustomObjectStyle(n));
    if (!attrs) throw new Error(`custom inexistente: ${name}`);
    const inst: any = Domain.createInstance(getAttr(attrs, 'classname') ?? '', args);
    copyPorpertiesByXML(inst, attrs);
    if (inst && typeof inst === 'object') createdBy.set(inst, name);
    return inst;
  }

  creatFrameFilters(s: string): (FlashFilterDef[] | null)[] {
    return parasArgs(s).map((part) => (part === 'null' ? null : this.creatFilters(part)));
  }

  creatFilters(s: string): FlashFilterDef[] {
    return filterDefs(s.split('|').map((n) => this.model.getSet(n.trim())));
  }

  setup(x: any): void {
    const el: Element | undefined = x?.node instanceof Element ? x.node : x instanceof Document ? x.documentElement : undefined;
    if (!el) return;
    const name = el.getAttribute('name') ?? 'anon';
    const file = `${name}.xml`;
    if (this.model.loaded.has(name)) return;
    const doc = el.ownerDocument.documentElement === el ? el.ownerDocument : new DOMParser().parseFromString(new XMLSerializer().serializeToString(el), 'text/xml');
    this.model.addComponentSet(file, doc);
    this.fileLoads.set(file, Promise.resolve());
  }

  private instances = new Map<string, unknown>();
  preStylename = '';

  createComponentGroupByStylename(name: string, _toggle = false, args?: unknown[]): any {
    const inst = this.creatComponentByStylename(name, args);
    this.preStylename = name;
    return inst;
  }

  getInstanceByStyleName(name: string): unknown { return this.instances.get(name); }
  addInstanceByStyleName(name: string, inst: unknown): void { this.instances.set(name, inst); }
  removeInstanceByStyleName(name: string): void { this.instances.delete(name); }

  getComponentByID(id: number): unknown { return this.all.get(id); }
  removeComponent(id: number): void { this.all.delete(id); }
}

export const ComponentFactory = { Instance: new ComponentFactoryClass(), parasArgs };
