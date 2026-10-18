import { Container, EventBoundary, type Application, type FederatedPointerEvent } from 'pixi.js';
import { flDispatchSafe, flParent, listenerCount, syntheticMouseHook, syntheticPointer, trackPointer, wheelDelta, Event } from '@/flash/events';
import { currentStage, hitShape } from './display';
import { KeyboardEvent, MouseEvent, TouchEvent } from './events';

const EBP = EventBoundary.prototype as any;

export const cursorState = { override: null as string | null, hidden: false };

const FLASH_CURSOR: Record<string, string> = { arrow: 'default', button: 'pointer', hand: 'grab', ibeam: 'text', auto: '' };

let overTarget: Container | null = null;
let lastClick: { target: Container; time: number } | null = null;
let lastPixiTarget: Container | null = null;

function isEnabled(n: any): boolean {
  return n === currentStage() || n.eventMode === 'static' || n.eventMode === 'dynamic';
}

function flashTarget(pixiTarget: Container | null | undefined): Container | null {
  const stage = currentStage();
  if (!pixiTarget) return stage;
  const path: Container[] = [];
  for (let n: Container | null = pixiTarget; n; n = flParent(n)) path.push(n);
  let target: Container | null = pixiTarget;
  for (let i = path.length - 1; i > 0; i--) {
    if ((path[i] as any).__flMC === false) { target = path[i]; break; }
  }
  while (target && !isEnabled(target)) target = flParent(target);
  return target ?? stage;
}

function stageXY(e: { global: { x: number; y: number } }): { x: number; y: number } {
  const st = currentStage();
  return st ? st.toLocal(e.global) : { x: e.global.x, y: e.global.y };
}

function makeEvent(type: string, e: any, related: Container | null = null, bubbles = true, delta = 0): MouseEvent {
  const ev = new MouseEvent(type, bubbles, false, NaN, NaN, related, !!e?.ctrlKey, !!e?.altKey, !!e?.shiftKey,
    ((e?.buttons ?? 0) & 1) === 1, delta, !!e?.metaKey, !!e?.ctrlKey, e?.detail ?? 0);
  if (e?.global) {
    const p = stageXY(e);
    ev.__stageX = p.x;
    ev.__stageY = p.y;
  }
  ev.__fromPixi = true;
  return ev;
}

function fire(target: Container | null, ev: Event): void {
  if (!target || (target as any).destroyed) return;
  flDispatchSafe(target, ev);
}

function rollChain(t: Container | null): Container[] {
  const out: Container[] = [];
  const st = currentStage();
  for (let n = t; n && n !== st; n = flParent(n)) out.push(n);
  return out;
}

function updateOver(next: Container | null, e: any): void {
  if (next === overTarget) return;
  const prev = overTarget && !(overTarget as any).destroyed ? overTarget : null;
  overTarget = next;
  const oldChain = rollChain(prev), newChain = rollChain(next);
  if (prev) fire(prev, makeEvent('mouseOut', e, next));
  if ((listenerCount.get('rollOut') ?? 0) > 0) {
    for (const n of oldChain) if (!newChain.includes(n)) fire(n, makeEvent('rollOut', e, next, false));
  }
  if (next) fire(next, makeEvent('mouseOver', e, prev));
  if ((listenerCount.get('rollOver') ?? 0) > 0) {
    for (let i = newChain.length - 1; i >= 0; i--) if (!oldChain.includes(newChain[i])) fire(newChain[i], makeEvent('rollOver', e, prev, false));
  }
}

function touchEvent(type: string, e: any, target: Container): void {
  if ((listenerCount.get(type) ?? 0) === 0) return;
  const p = stageXY(e);
  const ev = new TouchEvent(type, true, false, e.pointerId ?? 0, !!e.isPrimary, NaN, NaN, e.width ?? NaN, e.height ?? NaN,
    e.pressure ?? NaN, null, !!e.ctrlKey, !!e.altKey, !!e.shiftKey);
  ev.stageX = p.x;
  ev.stageY = p.y;
  const l = target.toLocal(e.global);
  ev.localX = l.x;
  ev.localY = l.y;
  fire(target, ev);
}

function flashMouse(boundary: any, e: any, type: string): void {
  trackPointer(e);
  const pixiTarget: Container | null = e.target ?? boundary.rootTarget ?? null;
  const target = flashTarget(pixiTarget);
  if (!target) return;
  const btn = e.button ?? 0;
  const isTouch = e.pointerType === 'touch';
  switch (type) {
    case 'pointerdown':
      fire(target, makeEvent(btn === 2 ? 'rightMouseDown' : btn === 1 ? 'middleMouseDown' : 'mouseDown', e));
      if (isTouch) touchEvent('touchBegin', e, target);
      break;
    case 'pointerup':
      fire(target, makeEvent(btn === 2 ? 'rightMouseUp' : btn === 1 ? 'middleMouseUp' : 'mouseUp', e));
      if (isTouch) touchEvent('touchEnd', e, target);
      break;
    case 'pointertap': {
      if (btn === 2) { fire(target, makeEvent('rightClick', e)); break; }
      if (btn === 1) { fire(target, makeEvent('middleClick', e)); break; }
      const now = performance.now();
      if (lastClick && lastClick.target === target && now - lastClick.time < 500 && (target as any).doubleClickEnabled === true) {
        lastClick = null;
        fire(target, makeEvent('doubleClick', e));
      } else {
        lastClick = { target, time: now };
        fire(target, makeEvent('click', e));
      }
      if (isTouch) touchEvent('touchTap', e, target);
      break;
    }
    case 'pointermove':
      lastPixiTarget = pixiTarget;
      updateOver(target, e);
      fire(target, makeEvent('mouseMove', e));
      if (isTouch) touchEvent('touchMove', e, target);
      break;
    case 'pointerover':
      lastPixiTarget = pixiTarget;
      updateOver(target, e);
      break;
    case 'wheel':
      fire(target, makeEvent('mouseWheel', e, null, true, wheelDelta(e)));
      break;
    default:
      break;
  }
}

const FLASH_TYPES = new Set(['pointerdown', 'pointerup', 'pointertap', 'pointermove', 'pointerover', 'wheel']);

function applyCursor(boundary: any): void {
  if (cursorState.hidden) { boundary.cursor = 'none'; return; }
  if (cursorState.override && FLASH_CURSOR[cursorState.override]) { boundary.cursor = FLASH_CURSOR[cursorState.override]; return; }
  let c: string | null = null;
  for (let n: any = lastPixiTarget; n; n = n.parent) {
    if (n.cursor && n.cursor !== 'inherit' && n.cursor !== 'default' && n.cursor !== 'auto') { c = n.cursor; break; }
    if (n.eventMode === 'none') break;
  }
  boundary.cursor = c;
}

let patched = false;

export function installMouse(): void {
  if (patched) return;
  patched = true;
  const origDispatch = EBP.dispatchEvent;
  EBP.dispatchEvent = function (this: any, e: any, type?: string) {
    origDispatch.call(this, e, type);
    const t = type || e.type;
    if (FLASH_TYPES.has(t) && !e.__synthetic) {
      try { flashMouse(this, e, t); } catch (err) { console.error('[flash] mouse', err); }
    }
  };
  const origMove = EBP.mapPointerMove;
  EBP.mapPointerMove = function (this: any, from: FederatedPointerEvent) {
    origMove.call(this, from);
    if (from.pointerType === 'mouse' || from.pointerType === 'pen') applyCursor(this);
  };
  const origOver = EBP.mapPointerOver;
  EBP.mapPointerOver = function (this: any, from: FederatedPointerEvent) {
    origOver.call(this, from);
    if (from.pointerType === 'mouse') applyCursor(this);
  };
  const origOut = EBP.mapPointerOut;
  EBP.mapPointerOut = function (this: any, from: FederatedPointerEvent) {
    origOut.call(this, from);
    updateOver(null, from);
    const st = currentStage();
    if (st) flDispatchSafe(st, new Event('mouseLeave'));
  };
  const origPrune = EBP.hitPruneFn;
  EBP.hitPruneFn = function (this: any, container: any, location: { x: number; y: number }) {
    const ha = container.hitArea;
    if (ha instanceof Container) {
      if (!hitShape(ha, location.x, location.y)) return true;
      for (const effect of container.effects ?? []) {
        if (effect.containsPoint && !effect.containsPoint(location, this.hitTestFn)) return true;
      }
      return false;
    }
    return origPrune.call(this, container, location);
  };

  const PIXI_NAME: Record<string, string> = {
    click: 'pointertap', mouseDown: 'pointerdown', mouseUp: 'pointerup', mouseMove: 'pointermove', mouseOver: 'pointerover',
    mouseOut: 'pointerout', rollOver: 'pointerover', rollOut: 'pointerout', mouseWheel: 'wheel', rightClick: 'rightclick',
  };
  syntheticMouseHook.emit = (node, ev) => {
    const name = PIXI_NAME[ev.type];
    if (!name || !node._events?.[name]) return;
    const fake: any = syntheticPointer(name, ev.target);
    fake.currentTarget = node;
    node.emit(name, fake);
  };
}

export function patchBoundaryInstance(b: any): void {
  if (!b || b.__flPatched) return;
  b.__flPatched = true;
  b.hitPruneFn = EBP.hitPruneFn.bind(b);
  b.hitTestFn = EBP.hitTestFn.bind(b);
  const maps: [string, string][] = [['pointerdown', 'mapPointerDown'], ['pointermove', 'mapPointerMove'], ['pointerout', 'mapPointerOut'],
    ['pointerleave', 'mapPointerOut'], ['pointerover', 'mapPointerOver'], ['pointerup', 'mapPointerUp'],
    ['pointerupoutside', 'mapPointerUpOutside'], ['wheel', 'mapWheel']];
  const seen = new Set<string>();
  for (const [, m] of maps) {
    if (seen.has(m)) continue;
    seen.add(m);
    const old = b[m];
    const neu = EBP[m].bind(b);
    b[m] = neu;
    for (const list of Object.values(b.mappingTable ?? {}) as { fn: unknown }[][]) for (const it of list) if (it.fn === old) it.fn = neu;
  }
}

function charCodeOf(e: globalThis.KeyboardEvent): number {
  if (e.key.length === 1) return e.key.charCodeAt(0);
  switch (e.key) {
    case 'Enter': return 13;
    case 'Backspace': return 8;
    case 'Tab': return 9;
    case 'Escape': return 27;
    case 'Delete': return 127;
    default: return 0;
  }
}

let keysInstalled = false;
export function installKeyboard(app: Application): void {
  if (keysInstalled) return;
  keysInstalled = true;
  void app;
  const handler = (type: string) => (e: globalThis.KeyboardEvent) => {
    const st: any = currentStage();
    if (!st) return;
    let target: any = st.focus;
    if (!target || target.destroyed || !target.stage) target = st;
    const ev = new KeyboardEvent(type, true, false, charCodeOf(e), e.keyCode, e.location, e.ctrlKey || e.metaKey, e.altKey,
      e.shiftKey, e.ctrlKey, e.metaKey);
    flDispatchSafe(target, ev);
  };
  window.addEventListener('keydown', handler('keyDown'));
  window.addEventListener('keyup', handler('keyUp'));
}
