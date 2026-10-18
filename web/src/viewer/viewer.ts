import { Application, Container, Graphics, Rectangle } from 'pixi.js';
import { FlashClock } from '@/flash/clock';
import { Bitmap, MovieClip } from '@/flash/display';
import { BitmapData, Domain, SwfLibrary, symbolName } from '@/flash/library';
import { ComponentFactory, createdBy } from '@/pickgliss/ComponentFactory';
import { GameClasses, instanceClass, instanceVars, openScreen, RuntimeOptions } from '@/game/GameClasses';

interface ScreenEntry { cls: string; title: string | null; kind: string; module: string; size: string | null; n: number }

const STAGE_W = 1000;
const STAGE_H = 620;

function el<K extends keyof HTMLElementTagNameMap>(tag: K, props: Partial<HTMLElementTagNameMap[K]> & { cls?: string } = {},
  ...kids: (Node | string)[]): HTMLElementTagNameMap[K] {
  const e = document.createElement(tag);
  const { cls, ...rest } = props;
  if (cls) e.className = cls;
  Object.assign(e, rest);
  e.append(...kids);
  return e;
}

export class Viewer {
  private app!: Application;
  private screens: ScreenEntry[] = [];
  private kinds = new Set(['frame', 'scene', 'tip']);
  private query = '';
  private current: ScreenEntry | null = null;
  private root = new Container();
  private overlay = new Graphics();
  private screenObj: Container | null = null;
  private selected: Container | null = null;
  private listEl!: HTMLElement;
  private treeEl!: HTMLElement;
  private propsEl!: HTMLElement;
  private logEl!: HTMLElement;
  private statusEl!: HTMLElement;
  private titleEl!: HTMLElement;
  private stageEl!: HTMLElement;
  private showBounds = true;
  private tab: 'tree' | 'log' = 'tree';

  async start(app: Application, host: HTMLElement): Promise<void> {
    this.app = app;
    this.screens = await (await fetch('/layout/screens.json')).json();
    this.buildDom(host);
    this.stageEl.prepend(app.canvas);
    app.stage.addChild(this.root, this.overlay);
    app.renderer.on('resize', () => this.fit());
    const ro = new ResizeObserver(() => { app.renderer.resize(this.stageEl.clientWidth, this.stageEl.clientHeight); this.fit(); });
    ro.observe(this.stageEl);
    app.ticker.add(() => this.drawOverlay());
    this.renderList();
    const route = () => {
      const h = decodeURIComponent(location.hash.slice(1));
      if (h.startsWith('sym:')) { this.openSymbol(h.slice(4)); return; }
      if (h.startsWith('battle:')) { this.openBattle(h.slice(7)); return; }
      const s = this.screens.find((x) => x.cls === h);
      if (s && s !== this.current) this.open(s);
    };
    window.addEventListener('hashchange', route);
    if (new URLSearchParams(location.search).get('triage')) { this.runTriage(); return; }
    route();
  }

  private buildDom(host: HTMLElement): void {
    const search = el('input', { type: 'search', placeholder: 'Buscar tela (título, classe, módulo)…' });
    search.addEventListener('input', () => { this.query = search.value.toLowerCase(); this.renderList(); });
    const chips = el('div', { cls: 'row' });
    for (const k of ['frame', 'scene', 'tip']) {
      const c = el('span', { cls: 'chip on', textContent: k });
      c.onclick = () => {
        if (this.kinds.has(k)) this.kinds.delete(k); else this.kinds.add(k);
        c.classList.toggle('on');
        this.renderList();
      };
      chips.append(c);
    }
    this.listEl = el('div', { cls: 'list' });
    const left = el('aside', { cls: 'panel' },
      el('header', {}, el('h1', {}, 'Legend Online ', el('small', { textContent: '· telas H5' })), search, chips),
      this.listEl);

    this.stageEl = el('section', { cls: 'stage' });
    this.titleEl = el('span', { cls: 'title', textContent: 'Selecione uma tela' });
    const btn = (label: string, fn: () => void, title = '') => { const b = el('button', { textContent: label, title }); b.onclick = fn; return b; };
    const cond = btn('condicionais: não', () => {
      RuntimeOptions.includeConditional = !RuntimeOptions.includeConditional;
      cond.textContent = `condicionais: ${RuntimeOptions.includeConditional ? 'sim' : 'não'}`;
      if (this.current) this.open(this.current);
    }, 'Executar também as instruções dentro de if/else/laços (dependem de dados do servidor)');
    const bounds = btn('limites', () => { this.showBounds = !this.showBounds; });
    const pause = btn('⏸', () => { FlashClock.paused = !FlashClock.paused; pause.textContent = FlashClock.paused ? '▶' : '⏸'; }, 'Pausar animações');
    const step = btn('+1 quadro', () => FlashClock.tick());
    const reload = btn('recarregar', () => this.current && this.open(this.current));
    this.stageEl.append(el('div', { cls: 'toolbar' }, this.titleEl, el('span', { cls: 'spacer' }), cond, bounds, pause, step, reload));
    this.statusEl = el('div', { cls: 'status', textContent: '' });
    this.stageEl.append(this.statusEl);

    this.treeEl = el('div', { cls: 'tree' });
    this.logEl = el('div', { cls: 'log' });
    this.propsEl = el('div', { cls: 'props' });
    const tabTree = el('button', { cls: 'on', textContent: 'Árvore' });
    const tabLog = el('button', { textContent: 'Operações' });
    tabTree.onclick = () => { this.tab = 'tree'; tabTree.classList.add('on'); tabLog.classList.remove('on'); this.renderSide(); };
    tabLog.onclick = () => { this.tab = 'log'; tabLog.classList.add('on'); tabTree.classList.remove('on'); this.renderSide(); };
    const right = el('aside', { cls: 'panel right' }, el('div', { cls: 'tabs' }, tabTree, tabLog), this.treeEl, this.logEl, this.propsEl);
    host.append(left, this.stageEl, right);

    this.app.stage.eventMode = 'static';
    this.app.stage.hitArea = new Rectangle(-1e5, -1e5, 2e5, 2e5);
    this.app.stage.on('pointerdown', (e) => {
      if (!this.screenObj || !e.altKey) return;
      const hit = this.pick(this.screenObj, e.global.x, e.global.y);
      if (hit) this.select(hit);
    });
  }

  private filtered(): ScreenEntry[] {
    const q = this.query;
    return this.screens.filter((s) => this.kinds.has(s.kind) &&
      (!q || s.cls.toLowerCase().includes(q) || (s.title ?? '').toLowerCase().includes(q) || s.module.toLowerCase().includes(q)));
  }

  private renderList(): void {
    const items = this.filtered();
    const frag = document.createDocumentFragment();
    let mod = '';
    for (const s of items.sort((a, b) => a.module.localeCompare(b.module) || (a.title ?? a.cls).localeCompare(b.title ?? b.cls))) {
      if (s.module !== mod) {
        mod = s.module;
        frag.append(el('div', { cls: 'group', textContent: `${mod} · ${items.filter((x) => x.module === mod).length}` }));
      }
      const it = el('div', { cls: 'item' + (this.current === s ? ' sel' : '') },
        el('span', { cls: 'k', textContent: `${s.kind}${s.size ? ' · ' + s.size : ''}` }),
        el('span', { cls: 't', textContent: s.title ?? s.cls.split('.').pop()! }),
        el('span', { cls: 'c', textContent: s.cls }));
      it.onclick = () => this.open(s);
      frag.append(it);
    }
    this.listEl.replaceChildren(frag);
  }

  async open(s: ScreenEntry): Promise<void> {
    this.current = s;
    location.hash = encodeURIComponent(s.cls);
    this.renderList();
    this.titleEl.textContent = `${s.title ?? ''}  ${s.cls}`;
    this.statusEl.textContent = 'carregando…';
    this.screenObj?.destroy({ children: true });
    this.screenObj = null;
    this.selected = null;
    const t0 = performance.now();
    try {
      const obj = await openScreen(s.cls);
      this.screenObj = obj;
      this.root.addChild(obj);
      this.fit();
      const errors = RuntimeOptions.log.filter((l) => !l.ok).length;
      this.statusEl.innerHTML = `${RuntimeOptions.log.length} operações · <span class="${errors ? 'err' : 'okc'}">${errors} falhas</span>` +
        ` · ${Math.round(performance.now() - t0)} ms · ${FlashClock.size} clipes animados`;
    } catch (err) {
      console.error(err);
      this.statusEl.innerHTML = `<span class="err">erro: ${(err as Error).message}</span>`;
    }
    this.renderSide();
  }

  async runTriage(): Promise<void> {
    SwfLibrary.skipTextures = true;
    const byCause = new Map<string, { n: number; screens: Set<string> }>();
    const perScreen: { cls: string; ops: number; fails: number; error?: string; ms: number }[] = [];
    let i = 0;
    for (const s of this.screens) {
      i++;
      this.statusEl.textContent = `triagem ${i}/${this.screens.length} · ${s.cls}`;
      const t0 = performance.now();
      let error: string | undefined;
      try {
        const obj = await openScreen(s.cls);
        obj.destroy({ children: true });
      } catch (err) {
        error = String((err as Error).message ?? err);
      }
      const fails = RuntimeOptions.log.filter((l) => !l.ok);
      for (const f of fails) {
        const cause = (f.error ?? '').slice(0, 120);
        const e = byCause.get(cause) ?? { n: 0, screens: new Set<string>() };
        e.n++;
        e.screens.add(s.cls);
        byCause.set(cause, e);
      }
      if (error) {
        const e = byCause.get('ABERTURA: ' + error.slice(0, 100)) ?? { n: 0, screens: new Set<string>() };
        e.n++;
        e.screens.add(s.cls);
        byCause.set('ABERTURA: ' + error.slice(0, 100), e);
      }
      perScreen.push({ cls: s.cls, ops: RuntimeOptions.log.length, fails: fails.length, error, ms: Math.round(performance.now() - t0) });
      if (i % 25 === 0) await new Promise((r) => setTimeout(r, 0));
    }
    const causes = [...byCause.entries()].sort((a, b) => b[1].screens.size - a[1].screens.size)
      .map(([cause, v]) => ({ cause, ops: v.n, screens: v.screens.size, example: [...v.screens][0] }));
    const clean = perScreen.filter((p) => !p.fails && !p.error).length;
    const totalOps = perScreen.reduce((a, p) => a + p.ops, 0);
    const failedOps = perScreen.reduce((a, p) => a + p.fails, 0);
    (window as any).__triage = { causes, perScreen, clean, totalOps, failedOps };
    this.statusEl.textContent = `triagem: ${clean}/${perScreen.length} telas sem falha · ${totalOps - failedOps}/${totalOps} operações ok`;
    this.tab = 'log';
    this.logEl.replaceChildren(...causes.slice(0, 200).map((c) =>
      el('div', { textContent: `${c.screens} telas · ${c.ops} ops · ${c.cause} (ex.: ${c.example})` })));
    this.treeEl.style.display = 'none';
    this.logEl.style.display = '';
  }

  async openSymbol(name: string): Promise<void> {
    this.current = null;
    this.titleEl.textContent = `símbolo ${name}`;
    this.screenObj?.destroy({ children: true });
    this.screenObj = null;
    const lib = Domain.libraryOf(name);
    if (!lib) { this.statusEl.innerHTML = `<span class="err">símbolo não encontrado: ${escapeHtml(name)}</span>`; return; }
    await Domain.loadLibrary(lib);
    const inst = Domain.createInstance(name);
    const obj = inst instanceof BitmapData ? new Bitmap(inst) : (inst as Container);
    this.screenObj = obj;
    this.root.addChild(obj);
    this.fit();
    const mc = obj instanceof MovieClip ? obj : null;
    this.statusEl.textContent = mc ? `MovieClip ${mc.totalFrames} quadros · rótulos: ${Object.keys(mc.labels).join(', ') || '—'}` : lib;
    this.renderSide();
  }

  async openBattle(arg: string): Promise<void> {
    const { BattlePreview, FIXTURES, SIZES } = await import('@/battle/BattlePreview');
    const [rest, groundArg] = arg.split('!');
    const [id, size] = rest.split('@');
    const wh = (size?.split('x').map(Number) ?? SIZES[0]) as [number, number];
    this.current = null;
    this.screenObj?.destroy({ children: true });
    this.screenObj = null;
    this.titleEl.textContent = `batalha (pré-visualização) · ${id || FIXTURES[0].id}`;
    const p = await BattlePreview.create(id || FIXTURES[0].id, wh, this.app.ticker, groundArg ? Number(groundArg) : undefined);
    this.screenObj = p;
    this.root.addChild(p);
    this.fit();
    const go = (fid: string, w: number, h: number, g: string) => { location.hash = encodeURIComponent(`battle:${fid}@${w}x${h}!${g}`); };
    const map = el('select', {}, ...Array.from({ length: 17 }, (_, i) => el('option', { value: String(i + 1), textContent: `mapa ${i + 1}`, selected: p.ground === i + 1 })));
    const sel = el('select', {}, ...FIXTURES.map((f) => el('option', { value: f.id, textContent: f.title, selected: f.id === p.fixtureInfo.id })));
    const sz = el('select', {}, ...SIZES.map(([w, h]) => el('option', { value: `${w}x${h}`, textContent: `${w}×${h}`, selected: w === p.W && h === p.H })));
    const change = () => { const [w, h] = sz.value.split('x').map(Number); go(sel.value, w, h, map.value); };
    sel.onchange = change;
    sz.onchange = change;
    map.onchange = change;
    const b = (label: string, fn: () => void) => { const x = el('button', { textContent: label }); x.onclick = fn; return x; };
    const auto = b('dano automático: sim', () => { p.autoDamage = !p.autoDamage; auto.textContent = `dano automático: ${p.autoDamage ? 'sim' : 'não'}`; });
    const grid = b('grade: sim', () => { p.showGrid = !p.showGrid; grid.textContent = `grade: ${p.showGrid ? 'sim' : 'não'}`; });
    this.statusEl.replaceChildren(sel, sz, map, auto, grid, b('dano', () => p.hit('normal')), b('crítico', () => p.hit('crit')),
      b('cura', () => p.hit('heal')), b('aparar', () => p.hit('parry')),
      el('span', { textContent: `${p.assetFailures.length ? ` · ${p.assetFailures.length} assets de UI faltando` : ' · UI ok'}` +
        ` · mapa ${p.ground ?? 'provisório'} · ${p.realUnits} unidades com SWF real` }));
    this.renderSide();
  }

  private fit(): void {
    if (!this.screenObj) return;
    const W = this.stageEl.clientWidth, H = this.stageEl.clientHeight;
    if (W < 50 || H < 50) return;
    const b = this.screenObj.getLocalBounds();
    const w = Math.max(b.width, 1), h = Math.max(b.height, 1);
    const scale = Math.max(0.1, Math.min(1, (W - 40) / Math.max(w, STAGE_W * 0.3), (H - 80) / Math.max(h, STAGE_H * 0.3)));
    this.root.scale.set(scale);
    this.root.position.set(Math.round((W - w * scale) / 2 - b.x * scale), Math.round((H - h * scale) / 2 - b.y * scale + 10));
  }

  private label(o: Container): { v?: string; s?: string; h: string } {
    let v: string | undefined;
    const p = o.parent;
    for (let a: Container | null = p; a && !v; a = a.parent) {
      const vars = instanceVars.get(a);
      if (vars) for (const [k, val] of vars) if (val === o) { v = k; break; }
    }
    const s = createdBy.get(o) ?? instanceClass.get(o) ?? symbolName.get(o) ?? (o.label || undefined);
    const type = instanceClass.get(o)?.split('.').pop() ?? o.constructor.name;
    return { v, s, h: type };
  }

  private renderSide(): void {
    this.treeEl.style.display = this.tab === 'tree' ? '' : 'none';
    this.logEl.style.display = this.tab === 'log' ? '' : 'none';
    if (this.tab === 'log') {
      const frag = document.createDocumentFragment();
      for (const l of RuntimeOptions.log) {
        const o = l.op as any;
        const d = el('div', { cls: l.ok ? '' : 'err' });
        d.textContent = `${l.ok ? '✓' : '✗'} ${l.cls.split('.').pop()} ${o.op} ${o.v ?? ''} ${o.name ?? o.k ?? o.m ?? o.how ?? ''}${l.error ? ' — ' + l.error : ''}`;
        frag.append(d);
      }
      this.logEl.replaceChildren(frag);
      return;
    }
    const frag = document.createDocumentFragment();
    const walk = (o: Container, depth: number) => {
      if (depth > 14) return;
      const { v, s, h } = this.label(o);
      const n = el('div', { cls: 'node' + (o === this.selected ? ' sel' : '') });
      n.style.paddingLeft = `${8 + depth * 12}px`;
      if (v) n.append(el('span', { cls: 'v', textContent: v + ' ' }));
      n.append(el('span', { cls: 'h', textContent: h + ' ' }));
      if (s) n.append(el('span', { cls: 's', textContent: s }));
      n.onclick = (e) => { e.stopPropagation(); this.select(o); };
      frag.append(n);
      for (const c of o.children) if ((c as Container).children !== undefined && c.visible !== undefined) walk(c as Container, depth + 1);
    };
    if (this.screenObj) walk(this.screenObj, 0);
    this.treeEl.replaceChildren(frag);
    this.renderProps();
  }

  private select(o: Container): void {
    this.selected = o;
    this.renderSide();
  }

  private renderProps(): void {
    const o = this.selected;
    if (!o) { this.propsEl.innerHTML = '<span class="h">Clique num nó (ou Alt+clique no palco).</span>'; return; }
    const b = o.getBounds();
    const rows: [string, string][] = [
      ['classe', instanceClass.get(o) ?? o.constructor.name],
      ['estilo / origem', createdBy.get(o) ?? '—'],
      ['x, y', `${Math.round(o.x)}, ${Math.round(o.y)}`],
      ['largura × altura', `${Math.round(o.width)} × ${Math.round(o.height)}`],
      ['bounds (palco)', `${Math.round(b.x)}, ${Math.round(b.y)} ${Math.round(b.width)}×${Math.round(b.height)}`],
      ['visível / alpha', `${o.visible} / ${o.alpha.toFixed(2)}`],
      ['filtros', String((o.filters as unknown[] | null)?.length ?? 0)],
    ];
    if (o instanceof MovieClip) rows.push(['quadro', `${o.currentFrame}/${o.totalFrames} ${o.currentLabel ?? ''}`]);
    if ('text' in o && typeof (o as any).text === 'string') rows.push(['texto', (o as any).text]);
    const style = createdBy.get(o);
    const node = style ? ComponentFactory.Instance.model.describe(style) : undefined;
    let html = '<table>' + rows.map(([k, v]) => `<tr><td>${k}</td><td>${escapeHtml(v)}</td></tr>`).join('') + '</table>';
    if (node) {
      html += `<h3>${node.tag} · ${node.file}</h3><table>` +
        node.attrs.map(([k, v]) => `<tr><td>${k}</td><td>${escapeHtml(v)}</td></tr>`).join('') + '</table>';
    }
    this.propsEl.innerHTML = html;
  }

  private pick(o: Container, x: number, y: number): Container | null {
    for (let i = o.children.length - 1; i >= 0; i--) {
      const c = o.children[i] as Container;
      if (!c.visible) continue;
      const hit = this.pick(c, x, y);
      if (hit) return hit;
    }
    if (o === this.screenObj) return null;
    const b = o.getBounds();
    return b.containsPoint(x, y) && o.children.length === 0 ? o : null;
  }

  private drawOverlay(): void {
    const g = this.overlay;
    g.clear();
    if (!this.showBounds || !this.screenObj) return;
    const b = this.screenObj.getBounds();
    g.rect(b.x, b.y, b.width, b.height).stroke({ width: 1, color: 0x666677, alpha: 0.6 });
    if (this.selected && !this.selected.destroyed) {
      const s = this.selected.getBounds();
      g.rect(s.x, s.y, s.width, s.height).fill({ color: 0xe0a446, alpha: 0.12 }).stroke({ width: 1.5, color: 0xe0a446 });
    }
  }
}

function escapeHtml(s: string): string {
  return s.replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[c]!);
}

export { GameClasses };
