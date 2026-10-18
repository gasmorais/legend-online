import { EventEmitter, FederatedEvent, Point } from 'pixi.js';
import type { Container, FederatedPointerEvent, FederatedWheelEvent } from 'pixi.js';
import { initFields } from '@/as3/runtime';

export class Event {
  static readonly ACTIVATE = 'activate';
  static readonly ADDED = 'added';
  static readonly ADDED_TO_STAGE = 'addedToStage';
  static readonly BROWSER_ZOOM_CHANGE = 'browserZoomChange';
  static readonly CANCEL = 'cancel';
  static readonly CHANGE = 'change';
  static readonly CHANNEL_MESSAGE = 'channelMessage';
  static readonly CHANNEL_STATE = 'channelState';
  static readonly CLEAR = 'clear';
  static readonly CLOSE = 'close';
  static readonly COMPLETE = 'complete';
  static readonly CONNECT = 'connect';
  static readonly CONTEXT3D_CREATE = 'context3DCreate';
  static readonly COPY = 'copy';
  static readonly CUT = 'cut';
  static readonly DEACTIVATE = 'deactivate';
  static readonly ENTER_FRAME = 'enterFrame';
  static readonly EXIT_FRAME = 'exitFrame';
  static readonly FRAME_CONSTRUCTED = 'frameConstructed';
  static readonly FRAME_LABEL = 'frameLabel';
  static readonly FULLSCREEN = 'fullScreen';
  static readonly ID3 = 'id3';
  static readonly INIT = 'init';
  static readonly MOUSE_LEAVE = 'mouseLeave';
  static readonly OPEN = 'open';
  static readonly PASTE = 'paste';
  static readonly REMOVED = 'removed';
  static readonly REMOVED_FROM_STAGE = 'removedFromStage';
  static readonly RENDER = 'render';
  static readonly RESIZE = 'resize';
  static readonly SCROLL = 'scroll';
  static readonly SELECT = 'select';
  static readonly SELECT_ALL = 'selectAll';
  static readonly SOUND_COMPLETE = 'soundComplete';
  static readonly SUSPEND = 'suspend';
  static readonly TAB_CHILDREN_CHANGE = 'tabChildrenChange';
  static readonly TAB_ENABLED_CHANGE = 'tabEnabledChange';
  static readonly TAB_INDEX_CHANGE = 'tabIndexChange';
  static readonly TEXT_INTERACTION_MODE_CHANGE = 'textInteractionModeChange';
  static readonly UNLOAD = 'unload';
  static readonly VIDEO_FRAME = 'videoFrame';
  static readonly WORKER_STATE = 'workerState';

  type: string;
  bubbles: boolean;
  cancelable: boolean;
  target: any = null;
  currentTarget: any = null;
  eventPhase = 0;
  defaultPrevented = false;
  propagationStopped = false;
  propagationImmediatelyStopped = false;

  constructor(type: string, bubbles = false, cancelable = false) {
    initFields(this, new.target);
    this.type = String(type);
    this.bubbles = !!bubbles;
    this.cancelable = !!cancelable;
  }

  stopPropagation(): void { this.propagationStopped = true; }
  stopImmediatePropagation(): void { this.propagationStopped = true; this.propagationImmediatelyStopped = true; }
  preventDefault(): void { if (this.cancelable) this.defaultPrevented = true; }
  isDefaultPrevented(): boolean { return this.defaultPrevented; }
  clone(): Event { return new Event(this.type, this.bubbles, this.cancelable); }
  formatToString(className: string, ...args: string[]): string {
    const parts = args.map((k) => {
      const v = (this as any)[k];
      return `${k}=${typeof v === 'string' ? `"${v}"` : String(v)}`;
    });
    return `[${className}${parts.length ? ' ' + parts.join(' ') : ''}]`;
  }
  toString(): string { return this.formatToString('Event', 'type', 'bubbles', 'cancelable', 'eventPhase'); }
}

export const EventPhase = { CAPTURING_PHASE: 1, AT_TARGET: 2, BUBBLING_PHASE: 3 } as const;

export class TimerEvent extends Event {
  static readonly TIMER = 'timer';
  static readonly TIMER_COMPLETE = 'timerComplete';
  constructor(type: string, bubbles = false, cancelable = false) { super(type, bubbles, cancelable); }
  override clone(): Event { return new TimerEvent(this.type, this.bubbles, this.cancelable); }
  override toString(): string { return this.formatToString('TimerEvent', 'type', 'bubbles', 'cancelable', 'eventPhase'); }
  updateAfterEvent(): void { }
}

export const MouseEvent = {
  CLICK: 'pointertap',
  DOUBLE_CLICK: 'doubleClick',
  MOUSE_DOWN: 'pointerdown',
  MOUSE_UP: 'pointerup',
  MOUSE_MOVE: 'pointermove',
  MOUSE_OVER: 'pointerover',
  MOUSE_OUT: 'pointerout',
  ROLL_OVER: 'pointerover',
  ROLL_OUT: 'pointerout',
  MOUSE_WHEEL: 'wheel',
  RIGHT_CLICK: 'rightclick',
  RIGHT_MOUSE_DOWN: 'rightdown',
  RIGHT_MOUSE_UP: 'rightup',
  RELEASE_OUTSIDE: 'pointerupoutside',
  GLOBAL_MOUSE_MOVE: 'globalpointermove',
} as const;

export const KeyboardEvent = { KEY_DOWN: 'keyDown', KEY_UP: 'keyUp' } as const;
export const FocusEvent = { FOCUS_IN: 'focusIn', FOCUS_OUT: 'focusOut' } as const;
export const TextEvent = { LINK: 'link', TEXT_INPUT: 'textInput' } as const;

const FLASH_TO_PIXI: Record<string, string> = {
  click: 'pointertap',
  mouseDown: 'pointerdown',
  mouseUp: 'pointerup',
  mouseMove: 'pointermove',
  mouseOver: 'pointerover',
  mouseOut: 'pointerout',
  rollOver: 'pointerover',
  rollOut: 'pointerout',
  mouseWheel: 'wheel',
  rightClick: 'rightclick',
  rightMouseDown: 'rightdown',
  rightMouseUp: 'rightup',
  addedToStage: 'added',
  removedFromStage: 'removed',
};

export function toPixiEventType(flashType: string): string {
  return FLASH_TO_PIXI[flashType] ?? flashType;
}

export const FLASH_MOUSE_TYPES = new Set([
  'click', 'doubleClick', 'mouseDown', 'mouseUp', 'mouseMove', 'mouseOver', 'mouseOut', 'rollOver', 'rollOut',
  'mouseWheel', 'rightClick', 'rightMouseDown', 'rightMouseUp', 'middleClick', 'middleMouseDown', 'middleMouseUp',
  'releaseOutside', 'contextMenu',
]);

const PIXI_RESERVED = new Set(['added', 'removed', 'childAdded', 'childRemoved', 'destroyed', 'visibleChanged']);

export function buttonDown(e: { buttons?: number } | null | undefined): boolean {
  return !!e && ((e.buttons ?? 0) & 1) === 1;
}

export function wheelDelta(e: FederatedWheelEvent | WheelEvent | { deltaY?: number }): number {
  const dy = (e as { deltaY?: number }).deltaY ?? 0;
  if (dy === 0) return 0;
  return -Math.sign(dy) * 3;
}

export function getTimer(): number { return Math.floor(performance.now()); }

const lastPointer = new Point(0, 0);

export function trackPointer(e: { global?: { x: number; y: number } } | null | undefined): void {
  if (e?.global) lastPointer.set(e.global.x, e.global.y);
}

export function pointerGlobal(): Point { return lastPointer.clone(); }

export function mousePosition(obj: Container): Point {
  return obj.toLocal(lastPointer);
}

const LISTENERS = Symbol.for('flash.listeners');
const BRIDGES = Symbol.for('flash.bridges');
const CAP = '\u0001';

interface Listener { fn: (e: any) => unknown; prio: number }
type Registry = Map<string, Listener[]>;

export const listenerHooks: {
  added: ((obj: any, type: string, capture: boolean) => void)[];
  removed: ((obj: any, type: string, capture: boolean) => void)[];
} = { added: [], removed: [] };

export const listenerCount = new Map<string, number>();

function registry(obj: any, create: boolean): Registry | undefined {
  let r: Registry | undefined = obj[LISTENERS];
  if (!r && create) {
    r = new Map();
    Object.defineProperty(obj, LISTENERS, { value: r, configurable: true });
  }
  return r;
}

export function flAddListener(obj: any, type: string, fn: (e: any) => unknown, useCapture = false, priority = 0): void {
  if (typeof fn !== 'function') throw new TypeError('Error #2007: Parameter listener must be non-null.');
  type = String(type);
  const capture = !!useCapture;
  const key = capture ? CAP + type : type;
  const reg = registry(obj, true)!;
  const old = reg.get(key) ?? [];
  if (old.some((l) => l.fn === fn)) return;
  const prio = Number(priority) | 0;
  const list = old.slice();
  let i = list.length;
  while (i > 0 && list[i - 1].prio < prio) i--;
  list.splice(i, 0, { fn, prio });
  reg.set(key, list);
  listenerCount.set(type, (listenerCount.get(type) ?? 0) + 1);
  if (!capture) ensureBridge(obj, type);
  for (const h of listenerHooks.added) h(obj, type, capture);
}

export function flRemoveListener(obj: any, type: string, fn: (e: any) => unknown, useCapture = false): void {
  type = String(type);
  const capture = !!useCapture;
  const key = capture ? CAP + type : type;
  const reg = registry(obj, false);
  const old = reg?.get(key);
  if (!old) return;
  const i = old.findIndex((l) => l.fn === fn);
  if (i < 0) return;
  const list = old.slice();
  list.splice(i, 1);
  if (list.length) reg!.set(key, list); else reg!.delete(key);
  listenerCount.set(type, Math.max(0, (listenerCount.get(type) ?? 1) - 1));
  for (const h of listenerHooks.removed) h(obj, type, capture);
}

export function flHasListener(obj: any, type: string): boolean {
  const reg = registry(obj, false);
  if (reg && (reg.has(type) || reg.has(CAP + type))) return true;
  const ev = obj?._events?.[type];
  return !!ev && !(ev.fn && ev.fn.__flBridge) && !(Array.isArray(ev) && ev.every((l: any) => l.fn?.__flBridge));
}

export function flParent(obj: any): any {
  let p = obj?.parent;
  while (p && p.__clipGroup) p = p.parent;
  return p ?? null;
}

export function flWillTrigger(obj: any, type: string): boolean {
  for (let n = obj; n; n = flParent(n)) if (flHasListener(n, type)) return true;
  return false;
}

function prepare(ev: any): any {
  if (ev.target !== null && ev.target !== undefined) {
    const own = typeof ev.clone === 'function' && (ev.constructor === Event || ev.clone !== Event.prototype.clone);
    if (own) {
      const c = ev.clone();
      if (c && typeof c === 'object') ev = c;
    }
  }
  ev.propagationStopped = false;
  ev.propagationImmediatelyStopped = false;
  return ev;
}

export const syntheticMouseHook: { emit?: (node: any, ev: any) => void } = {};

function invoke(node: any, ev: any, phase: number): void {
  ev.currentTarget = node.__flTarget ?? node;
  ev.eventPhase = phase;
  const type: string = ev.type;
  const list = (node[LISTENERS] as Registry | undefined)?.get(phase === 1 ? CAP + type : type);
  if (list) {
    for (const l of list) {
      l.fn.call(undefined, ev);
      if (ev.propagationImmediatelyStopped) return;
    }
  }
  if (phase === 1 || typeof node.emit !== 'function') return;
  if (FLASH_MOUSE_TYPES.has(type)) {
    if (!ev.__fromPixi) syntheticMouseHook.emit?.(node, ev);
    return;
  }
  if (PIXI_RESERVED.has(type) || !node._events?.[type]) return;
  ev.__flEmitting = true;
  try { node.emit(type, ev); } finally { ev.__flEmitting = false; }
}

export function flDispatch(obj: any, e: Event | { type: string; [k: string]: any }): boolean {
  const ev = prepare(e);
  ev.target = obj.__flTarget ?? obj;
  const path: any[] = [];
  if (obj.parent !== undefined) for (let p = flParent(obj); p; p = flParent(p)) path.push(p);
  for (let i = path.length - 1; i >= 0; i--) {
    invoke(path[i], ev, 1);
    if (ev.propagationStopped) return !ev.defaultPrevented;
  }
  invoke(obj, ev, 2);
  if (ev.propagationStopped) return !ev.defaultPrevented;
  if (ev.bubbles) {
    for (const p of path) {
      invoke(p, ev, 3);
      if (ev.propagationStopped) break;
    }
  }
  return !ev.defaultPrevented;
}

export function flDispatchAtTarget(obj: any, ev: any): boolean {
  ev = prepare(ev);
  ev.target = obj.__flTarget ?? obj;
  try { invoke(obj, ev, 2); } catch (err) { console.error('[flash] erro em listener de', ev.type, err); }
  return !ev.defaultPrevented;
}

export function flDispatchSafe(obj: any, ev: any): boolean {
  try { return flDispatch(obj, ev); } catch (err) {
    console.error('[flash] erro em listener de', ev?.type, err);
    return false;
  }
}

function ensureBridge(obj: any, type: string): void {
  if (typeof obj.on !== 'function' || FLASH_MOUSE_TYPES.has(type) || PIXI_RESERVED.has(type)) return;
  let set: Set<string> = obj[BRIDGES];
  if (!set) { set = new Set(); Object.defineProperty(obj, BRIDGES, { value: set, configurable: true }); }
  if (set.has(type)) return;
  set.add(type);
  const bridge = (arg: any) => {
    if (arg && arg.__flEmitting) return;
    if (arg instanceof FederatedEvent) return;
    const list = (obj[LISTENERS] as Registry | undefined)?.get(type);
    if (!list) return;
    const ev = arg instanceof Event ? arg : Object.assign(new Event(type), { data: arg });
    if (ev.target === null || ev.target === undefined) ev.target = obj.__flTarget ?? obj;
    ev.currentTarget = obj.__flTarget ?? obj;
    ev.eventPhase = 2;
    for (const l of list) {
      l.fn.call(undefined, ev);
      if (ev.propagationImmediatelyStopped) break;
    }
  };
  (bridge as any).__flBridge = true;
  obj.on(type, bridge);
}

interface Emitter { emit(type: string, ...args: unknown[]): boolean }

export function dispatchFlashEvent(obj: Emitter, e: Event | { type: string; [k: string]: any }): boolean {
  return flDispatch(obj, e);
}

export function listen(target: EventEmitter<any> | { on: Function; off: Function }, type: string,
  fn: (...a: any[]) => void, context?: unknown): void {
  const t = target as EventEmitter<any>;
  t.off(type, fn, context);
  t.on(type, fn, context);
}

export function isFederated(e: unknown): e is FederatedEvent { return e instanceof FederatedEvent; }

export class EventDispatcher extends EventEmitter {
  constructor(target: unknown = null) {
    super();
    initFields(this, new.target);
    if (target && target !== this) Object.defineProperty(this, '__flTarget', { value: target, configurable: true });
  }
  addEventListener(type: string, listener: (...a: any[]) => void, useCapture: unknown = false, priority = 0,
    _useWeakReference = false): void {
    flAddListener(this, type, listener, useCapture === true, priority);
  }
  removeEventListener(type: string, listener: (...a: any[]) => void, useCapture: unknown = false): void {
    flRemoveListener(this, type, listener, useCapture === true);
  }
  hasEventListener(type: string): boolean { return flHasListener(this, type); }
  willTrigger(type: string): boolean { return flHasListener(this, type); }
  dispatchEvent(e: Event | { type: string; [k: string]: any }): boolean { return flDispatch(this, e); }
  override toString(): string { return '[object EventDispatcher]'; }
}

export function syntheticPointer(type: string, target: Container): FederatedPointerEvent {
  const fake = {
    type, target, currentTarget: target, buttons: 0, button: 0, ctrlKey: false, shiftKey: false, altKey: false,
    global: lastPointer.clone(), cancelable: false, defaultPrevented: false, __synthetic: true,
    stopPropagation() {}, stopImmediatePropagation() {}, preventDefault() {},
    getLocalPosition(c: Container) { return c.toLocal(lastPointer); },
  };
  return fake as unknown as FederatedPointerEvent;
}

export function emitClick(target: Container): void {
  target.emit('pointertap', syntheticPointer('pointertap', target));
}

export class Timer extends EventDispatcher {
  private _delay = 0;
  private _repeatCount = 0;
  private _currentCount = 0;
  private _handle: ReturnType<typeof setInterval> | null = null;

  constructor(delay: number, repeatCount = 0) {
    super();
    const d = Number(delay);
    if (!(d >= 0) || !Number.isFinite(d)) throw new RangeError('Error #2066: The Timer delay specified is out of range.');
    this._delay = d;
    this._repeatCount = Number(repeatCount) | 0;
  }

  get delay(): number { return this._delay; }
  set delay(v: number) {
    const d = Number(v);
    if (!(d >= 0) || !Number.isFinite(d)) throw new RangeError('Error #2066: The Timer delay specified is out of range.');
    this._delay = d;
    if (this.running) { this.stopHandle(); this.startHandle(); }
  }
  get repeatCount(): number { return this._repeatCount; }
  set repeatCount(v: number) {
    this._repeatCount = Number(v) | 0;
    if (this._repeatCount > 0 && this._currentCount >= this._repeatCount) this.stop();
  }
  get running(): boolean { return this._handle !== null; }
  get currentCount(): number { return this._currentCount; }

  start(): void { if (this._handle === null) this.startHandle(); }
  stop(): void { this.stopHandle(); }
  reset(): void { this.stopHandle(); this._currentCount = 0; }

  private startHandle(): void { this._handle = setInterval(() => this.tick(), Math.max(1, this._delay)); }
  private stopHandle(): void {
    if (this._handle !== null) clearInterval(this._handle);
    this._handle = null;
  }

  private tick(): void {
    this._currentCount++;
    const done = this._repeatCount > 0 && this._currentCount >= this._repeatCount;
    if (done) this.stopHandle();
    flDispatchSafe(this, new TimerEvent(TimerEvent.TIMER));
    if (done) flDispatchSafe(this, new TimerEvent(TimerEvent.TIMER_COMPLETE));
  }
}
