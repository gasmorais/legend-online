import { $, initFields } from '../runtime';
import { Event, EventDispatcher, flDispatchSafe } from '@/flash/events';
import { Domain } from '@/flash/library';
import { BitmapData } from '@/flash/bitmapdata';
import { MovieClip, SimpleButton } from '@/flash/display';
import { ByteArray } from './bytearray';
import { appInstance, Loader } from './display';
import { cursorState } from './mouse';

const loadedBundles = new Set<string>();
const synthesized = new Map<string, Function>();

export function trackBundles(): void {
  const rt = $ as any;
  if (rt.__flTracked) return;
  rt.__flTracked = true;
  const lb = rt.loadBundle;
  rt.loadBundle = (m: string) => Promise.resolve(lb(m)).then((v: unknown) => { loadedBundles.add(m); return v; });
  const ld = rt.load;
  rt.load = (fqn: string) => Promise.resolve(ld(fqn)).then((v: unknown) => { const m = rt.moduleOf(fqn); if (m) loadedBundles.add(m); return v; });
}

const natives = new Map<string, unknown>();
export function noteNative(fqn: string, v: unknown): void { natives.set(fqn, v); }

function norm(name: string): string { return String(name).replace('::', '.'); }

function codeAvailable(fqn: string): boolean {
  const m = $.moduleOf(fqn);
  return !!m && loadedBundles.has(m);
}

function symbolClass(fqn: string): Function | null {
  let c = synthesized.get(fqn);
  if (c) return c;
  const kind = Domain.symbolKind(fqn);
  if (!kind) return null;
  switch (kind) {
    case 'sprite': c = class extends MovieClip {}; break;
    case 'bitmap': c = class extends BitmapData {}; break;
    case 'button': {
      const make = () => Domain.createInstance(fqn);
      c = function SymbolButton() { return make(); } as unknown as Function;
      Object.setPrototypeOf(c.prototype, SimpleButton.prototype);
      break;
    }
    case 'binary': c = class extends ByteArray {}; break;
    default: {
      const make = () => Domain.createInstance(fqn);
      c = function SymbolInstance() { return make(); } as unknown as Function;
    }
  }
  Object.defineProperty(c, '__fqn', { value: fqn, configurable: true, writable: true });
  Object.defineProperty(c, 'name', { value: fqn.split('.').pop() });
  synthesized.set(fqn, c);
  return c;
}

export class ApplicationDomain {
  static readonly MIN_DOMAIN_MEMORY_LENGTH = 1024;
  private static _current: ApplicationDomain | null = null;
  static get currentDomain(): ApplicationDomain { return (ApplicationDomain._current ??= new ApplicationDomain(null, true)); }

  readonly parentDomain: ApplicationDomain | null;
  domainMemory: ByteArray | null = null;

  constructor(parentDomain: ApplicationDomain | null = null, _root = false) {
    initFields(this, new.target);
    this.parentDomain = _root ? null : (parentDomain ?? ApplicationDomain._current ?? null);
  }

  hasDefinition(name: string): boolean {
    const fqn = norm(name);
    return natives.has(fqn) || Domain.hasDefinition(fqn) || codeAvailable(fqn);
  }

  getDefinition(name: string): any {
    const fqn = norm(name);
    if (natives.has(fqn)) return natives.get(fqn);
    if (codeAvailable(fqn)) return $.C(fqn);
    const cls = Domain.getClass(fqn);
    if (cls) return cls;
    const sym = symbolClass(fqn);
    if (sym) return sym;
    throw new ReferenceError(`Error #1065: Variable ${String(name).split(/[.:]/).pop()} is not defined.`);
  }

  getQualifiedDefinitionNames(): string[] { return [...natives.keys(), ...Domain.classNames()]; }
}

export function getDefinitionByName(name: string): any { return ApplicationDomain.currentDomain.getDefinition(name); }

export class SecurityDomain {
  private static _current: SecurityDomain | null = null;
  static get currentDomain(): SecurityDomain { return (SecurityDomain._current ??= new SecurityDomain()); }
  get domainID(): string { return location.host; }
}

export class LoaderContext {
  checkPolicyFile: boolean;
  applicationDomain: ApplicationDomain | null;
  securityDomain: SecurityDomain | null;
  allowCodeImport = true;
  allowLoadBytesCodeExecution = true;
  imageDecodingPolicy = 'onDemand';
  parameters: Record<string, string> | null = null;
  requestedContentParent: unknown = null;
  constructor(checkPolicyFile = false, applicationDomain: ApplicationDomain | null = null, securityDomain: SecurityDomain | null = null) {
    initFields(this, new.target);
    this.checkPolicyFile = !!checkPolicyFile;
    this.applicationDomain = applicationDomain;
    this.securityDomain = securityDomain;
  }
}
export class JPEGLoaderContext extends LoaderContext {
  deblockingFilter = 0;
}
export const ImageDecodingPolicy = { ON_DEMAND: 'onDemand', ON_LOAD: 'onLoad' } as const;
Loader.defaultDomain = ApplicationDomain.currentDomain;

const ua = navigator.userAgent;
const osName = /Windows NT 10/.test(ua) ? 'Windows 10' : /Windows/.test(ua) ? 'Windows 7' : /Mac OS X/.test(ua) ? 'Mac OS 10.15.7'
  : /Android/.test(ua) ? 'Linux' : /Linux/.test(ua) ? 'Linux' : 'Windows 10';
const platform = /Mac/.test(osName) ? 'MAC' : /Linux/.test(osName) ? 'LNX' : 'WIN';

export class Capabilities {
  static readonly version = `${platform} 32,0,0,465`;
  static readonly playerType = 'PlugIn';
  static readonly isDebugger = false;
  static readonly os = osName;
  static readonly manufacturer = `Adobe ${platform === 'MAC' ? 'Macintosh' : platform === 'LNX' ? 'Linux' : 'Windows'}`;
  static get language(): string { const l = navigator.language || 'pt'; return /^zh/i.test(l) ? (/(TW|HK)/i.test(l) ? 'zh-TW' : 'zh-CN') : l.split('-')[0]; }
  static get languages(): string[] { return [...(navigator.languages ?? [navigator.language])]; }
  static get screenResolutionX(): number { return Math.round(screen.width * (devicePixelRatio || 1)); }
  static get screenResolutionY(): number { return Math.round(screen.height * (devicePixelRatio || 1)); }
  static get screenDPI(): number { return Math.round(96 * (devicePixelRatio || 1)); }
  static readonly pixelAspectRatio = 1;
  static readonly screenColor = 'color';
  static readonly hasIME = true;
  static readonly hasAudio = true;
  static readonly hasMP3 = true;
  static readonly hasAudioEncoder = false;
  static readonly hasVideoEncoder = false;
  static readonly hasStreamingAudio = true;
  static readonly hasStreamingVideo = false;
  static readonly hasEmbeddedVideo = true;
  static readonly hasAccessibility = false;
  static readonly hasPrinting = true;
  static readonly hasScreenBroadcast = false;
  static readonly hasScreenPlayback = false;
  static readonly hasTLS = true;
  static readonly avHardwareDisable = true;
  static readonly localFileReadDisable = true;
  static readonly isEmbeddedInAcrobat = false;
  static readonly supports32BitProcesses = true;
  static readonly supports64BitProcesses = true;
  static readonly touchscreenType = 'none';
  static readonly cpuArchitecture = 'x86';
  static readonly maxLevelIDC = '5.1';
  static readonly externalInterfaceAvailable = true;
  static get serverString(): string {
    return `A=t&SA=t&SV=t&EV=t&MP3=t&AE=f&VE=f&ACC=f&PR=t&SP=f&SB=f&DEB=f&V=${encodeURIComponent(Capabilities.version)}`
      + `&M=${encodeURIComponent(Capabilities.manufacturer)}&R=${Capabilities.screenResolutionX}x${Capabilities.screenResolutionY}`
      + `&COL=color&AR=1.0&OS=${encodeURIComponent(osName)}&L=${Capabilities.language}&IME=t&PT=PlugIn&AVD=t&LFD=t&WD=f&TLS=t&ML=5.1&DP=72`;
  }
  static hasMultiChannelAudio(_type: string): boolean { return false; }
}

const perfMem = () => (performance as any).memory as { usedJSHeapSize: number; totalJSHeapSize: number } | undefined;

export class System {
  static useCodePage = false;
  static ime: unknown = null;
  static get totalMemory(): number { return perfMem()?.usedJSHeapSize ?? 64 * 1024 * 1024; }
  static get totalMemoryNumber(): number { return System.totalMemory; }
  static get privateMemory(): number { return perfMem()?.totalJSHeapSize ?? 96 * 1024 * 1024; }
  static get freeMemory(): number { const m = perfMem(); return m ? m.totalJSHeapSize - m.usedJSHeapSize : 16 * 1024 * 1024; }
  static readonly processCPUUsage = 0;
  static readonly vmVersion = '1.4.0';
  static setClipboard(s: string): void {
    const text = String(s ?? '');
    navigator.clipboard?.writeText(text).catch(() => {
      const ta = document.createElement('textarea');
      ta.value = text;
      document.body.appendChild(ta);
      ta.select();
      try { document.execCommand('copy'); } catch { }
      ta.remove();
    });
  }
  static gc(): void {}
  static pause(): void {}
  static resume(): void {}
  static exit(_code = 0): void {}
  static disposeXML(_x: unknown): void {}
  static pauseForGCIfCollectionImminent(_f = 0.75): void {}
}

export class Security {
  static readonly APPLICATION = 'application';
  static readonly LOCAL_TRUSTED = 'localTrusted';
  static readonly LOCAL_WITH_FILE = 'localWithFile';
  static readonly LOCAL_WITH_NETWORK = 'localWithNetwork';
  static readonly REMOTE = 'remote';
  static readonly sandboxType = 'remote';
  static exactSettings = true;
  static disableAVM1Loading = false;
  static readonly pageDomain = location.hostname;
  static allowDomain(..._d: string[]): void {}
  static allowInsecureDomain(..._d: string[]): void {}
  static loadPolicyFile(_url: string): void {}
  static showSettings(_panel = 'default'): void {}
}
export const SecurityPanel = { CAMERA: 'camera', DEFAULT: 'default', DISPLAY: 'display', LOCAL_STORAGE: 'localStorage', MICROPHONE: 'microphone', PRIVACY: 'privacy', SETTINGS_MANAGER: 'settingsManager' } as const;

export const IMEConversionMode = { ALPHANUMERIC_FULL: 'ALPHANUMERIC_FULL', ALPHANUMERIC_HALF: 'ALPHANUMERIC_HALF', CHINESE: 'CHINESE', JAPANESE_HIRAGANA: 'JAPANESE_HIRAGANA', JAPANESE_KATAKANA_FULL: 'JAPANESE_KATAKANA_FULL', JAPANESE_KATAKANA_HALF: 'JAPANESE_KATAKANA_HALF', KOREAN: 'KOREAN', UNKNOWN: 'UNKNOWN' } as const;

export class IME {
  static enabled = true;
  static conversionMode = 'UNKNOWN';
  static readonly isSupported = true;
  static setCompositionString(_s: string): void {}
  static doConversion(): void {}
  static compositionSelectionChanged(_a: number, _b: number): void {}
  static compositionAbandoned(): void {}
  static addEventListener(): void {}
  static removeEventListener(): void {}
}

export function fscommand(command: string, args = ''): void {
  if (command === 'quit') return;
  const fn = (window as any)[`fscommand_${command}`];
  if (typeof fn === 'function') fn(args);
}

export const TouchscreenType = { FINGER: 'finger', NONE: 'none', STYLUS: 'stylus' } as const;

function resolvePath(path: string): { fn: any; ctx: any } {
  const parts = String(path).split('.');
  let ctx: any = window;
  let fn: any = window;
  for (const p of parts) { ctx = fn; fn = fn?.[p]; }
  return { fn, ctx };
}

export class ExternalInterface {
  static readonly available = true;
  static marshallExceptions = false;
  static get objectID(): string { return 'flashContent'; }
  static call(functionName: string, ...args: unknown[]): unknown {
    const { fn, ctx } = resolvePath(functionName);
    if (typeof fn !== 'function') return null;
    try { return fn.apply(ctx, args) ?? null; } catch (err) {
      if (ExternalInterface.marshallExceptions) throw err;
      console.warn('[ExternalInterface]', functionName, err);
      return null;
    }
  }
  static addCallback(functionName: string, closure: ((...a: unknown[]) => unknown) | null): void {
    if (closure) (window as any)[functionName] = (...a: unknown[]) => closure(...a);
    else delete (window as any)[functionName];
  }
}

function refreshCursor(): void {
  const app = appInstance();
  if (!app) return;
  const ev = app.renderer.events;
  if (cursorState.hidden) ev.setCursor('none');
  else if (cursorState.override) ev.setCursor(({ arrow: 'default', button: 'pointer', hand: 'grab', ibeam: 'text' } as Record<string, string>)[cursorState.override] ?? 'default');
  else ev.setCursor(ev.rootBoundary.cursor ?? 'default');
}

export class Mouse {
  static readonly supportsCursor = true;
  static readonly supportsNativeCursor = true;
  static get cursor(): string { return cursorState.override ?? 'auto'; }
  static set cursor(v: string) { cursorState.override = !v || v === 'auto' ? null : String(v); refreshCursor(); }
  static hide(): void { cursorState.hidden = true; refreshCursor(); }
  static show(): void { cursorState.hidden = false; refreshCursor(); }
  static registerCursor(_name: string, _data: unknown): void {}
  static unregisterCursor(_name: string): void {}
}
export const MouseCursor = { ARROW: 'arrow', AUTO: 'auto', BUTTON: 'button', HAND: 'hand', IBEAM: 'ibeam' } as const;
export class MouseCursorData {
  data: BitmapData[] | null = null;
  frameRate = 0;
  hotSpot: unknown = null;
}

export const MultitouchInputMode = { GESTURE: 'gesture', NONE: 'none', TOUCH_POINT: 'touchPoint' } as const;
export class Multitouch {
  static inputMode = 'gesture';
  static mapTouchToMouse = true;
  static get maxTouchPoints(): number { return navigator.maxTouchPoints ?? 0; }
  static get supportsTouchEvents(): boolean { return 'ontouchstart' in window || (navigator.maxTouchPoints ?? 0) > 0; }
  static readonly supportsGestureEvents = false;
  static readonly supportedGestures: string[] | null = null;
}

export class ContextMenuBuiltInItems {
  forwardAndBack = true;
  loop = true;
  play = true;
  print = true;
  quality = true;
  rewind = true;
  save = true;
  zoom = true;
  clone(): ContextMenuBuiltInItems { return Object.assign(new ContextMenuBuiltInItems(), this); }
}
export class ContextMenuClipboardItems {
  clear = false; copy = false; cut = false; paste = false; selectAll = true;
  clone(): ContextMenuClipboardItems { return Object.assign(new ContextMenuClipboardItems(), this); }
}
export class ContextMenuItem extends EventDispatcher {
  caption: string;
  separatorBefore: boolean;
  enabled: boolean;
  visible: boolean;
  constructor(caption: string, separatorBefore = false, enabled = true, visible = true) {
    super();
    this.caption = caption;
    this.separatorBefore = separatorBefore;
    this.enabled = enabled;
    this.visible = visible;
  }
  clone(): ContextMenuItem { return new ContextMenuItem(this.caption, this.separatorBefore, this.enabled, this.visible); }
  select(owner: unknown = null): void { flDispatchSafe(this, Object.assign(new Event('menuItemSelect'), { mouseTarget: owner, contextMenuOwner: owner })); }
}
export class ContextMenu extends EventDispatcher {
  static readonly isSupported = false;
  customItems: ContextMenuItem[] = [];
  builtInItems = new ContextMenuBuiltInItems();
  clipboardMenu = false;
  clipboardItems = new ContextMenuClipboardItems();
  link: unknown = null;
  get items(): ContextMenuItem[] { return this.customItems; }
  get numItems(): number { return this.customItems.length; }
  hideBuiltInItems(): void {
    const b = this.builtInItems;
    b.forwardAndBack = b.loop = b.play = b.print = b.quality = b.rewind = b.save = b.zoom = false;
  }
  clone(): ContextMenu {
    const c = new ContextMenu();
    c.customItems = this.customItems.map((i) => i.clone());
    c.builtInItems = this.builtInItems.clone();
    return c;
  }
  addItem(i: ContextMenuItem): ContextMenuItem { this.customItems.push(i); return i; }
  removeAllItems(): void { this.customItems = []; }
  display(): void {}
}

export const KeyLocation = { D_PAD: 4, LEFT: 1, NUM_PAD: 3, RIGHT: 2, STANDARD: 0 } as const;

export class Keyboard {
  static readonly BACKSPACE = 8; static readonly TAB = 9; static readonly ENTER = 13; static readonly COMMAND = 15;
  static readonly SHIFT = 16; static readonly CONTROL = 17; static readonly ALTERNATE = 18; static readonly CAPS_LOCK = 20;
  static readonly NUMPAD = 21; static readonly ESCAPE = 27; static readonly SPACE = 32; static readonly PAGE_UP = 33;
  static readonly PAGE_DOWN = 34; static readonly END = 35; static readonly HOME = 36; static readonly LEFT = 37;
  static readonly UP = 38; static readonly RIGHT = 39; static readonly DOWN = 40; static readonly INSERT = 45;
  static readonly DELETE = 46; static readonly NUMBER_0 = 48; static readonly NUMBER_1 = 49; static readonly NUMBER_2 = 50;
  static readonly NUMBER_3 = 51; static readonly NUMBER_4 = 52; static readonly NUMBER_5 = 53; static readonly NUMBER_6 = 54;
  static readonly NUMBER_7 = 55; static readonly NUMBER_8 = 56; static readonly NUMBER_9 = 57; static readonly A = 65;
  static readonly B = 66; static readonly C = 67; static readonly D = 68; static readonly E = 69; static readonly F = 70;
  static readonly G = 71; static readonly H = 72; static readonly I = 73; static readonly J = 74; static readonly K = 75;
  static readonly L = 76; static readonly M = 77; static readonly N = 78; static readonly O = 79; static readonly P = 80;
  static readonly Q = 81; static readonly R = 82; static readonly S = 83; static readonly T = 84; static readonly U = 85;
  static readonly V = 86; static readonly W = 87; static readonly X = 88; static readonly Y = 89; static readonly Z = 90;
  static readonly NUMPAD_0 = 96; static readonly NUMPAD_1 = 97; static readonly NUMPAD_2 = 98; static readonly NUMPAD_3 = 99;
  static readonly NUMPAD_4 = 100; static readonly NUMPAD_5 = 101; static readonly NUMPAD_6 = 102; static readonly NUMPAD_7 = 103;
  static readonly NUMPAD_8 = 104; static readonly NUMPAD_9 = 105; static readonly NUMPAD_MULTIPLY = 106; static readonly NUMPAD_ADD = 107;
  static readonly NUMPAD_ENTER = 108; static readonly NUMPAD_SUBTRACT = 109; static readonly NUMPAD_DECIMAL = 110;
  static readonly NUMPAD_DIVIDE = 111; static readonly F1 = 112; static readonly F2 = 113; static readonly F3 = 114;
  static readonly F4 = 115; static readonly F5 = 116; static readonly F6 = 117; static readonly F7 = 118; static readonly F8 = 119;
  static readonly F9 = 120; static readonly F10 = 121; static readonly F11 = 122; static readonly F12 = 123; static readonly F13 = 124;
  static readonly F14 = 125; static readonly F15 = 126; static readonly SEMICOLON = 186; static readonly EQUAL = 187;
  static readonly COMMA = 188; static readonly MINUS = 189; static readonly PERIOD = 190; static readonly SLASH = 191;
  static readonly BACKQUOTE = 192; static readonly LEFTBRACKET = 219; static readonly BACKSLASH = 220; static readonly RIGHTBRACKET = 221;
  static readonly QUOTE = 222;
  static capsLock = false;
  static numLock = false;
  static readonly hasVirtualKeyboard = false;
  static readonly physicalKeyboardType = 'alphanumeric';
  static isAccessible(): boolean { return true; }
}

export class SoundTransform {
  volume: number;
  pan: number;
  leftToLeft = 1;
  leftToRight = 0;
  rightToLeft = 0;
  rightToRight = 1;
  constructor(vol = 1, panning = 0) { initFields(this, new.target); this.volume = Number(vol); this.pan = Number(panning); }
}

export class SoundChannel extends EventDispatcher {
  soundTransform = new SoundTransform();
  readonly leftPeak = 0;
  readonly rightPeak = 0;
  private __start = performance.now();
  private __stopped = false;
  private __pos = 0;
  constructor(startTime = 0) { super(); this.__pos = startTime; }
  get position(): number { return this.__stopped ? this.__pos : this.__pos + (performance.now() - this.__start); }
  stop(): void { if (!this.__stopped) { this.__pos = this.position; this.__stopped = true; } }
}

export class ID3Info {
  album: string | null = null; artist: string | null = null; comment: string | null = null; genre: string | null = null;
  songName: string | null = null; track: string | null = null; year: string | null = null;
}

export class SoundLoaderContext {
  bufferTime: number;
  checkPolicyFile: boolean;
  constructor(bufferTime = 1000, checkPolicyFile = false) { initFields(this, new.target); this.bufferTime = bufferTime; this.checkPolicyFile = checkPolicyFile; }
}

export class Sound extends EventDispatcher {
  static player: ((s: Sound, startTime: number, loops: number, t: SoundTransform | null) => SoundChannel | null) | null = null;
  url: string | null = null;
  bytesLoaded = 0;
  bytesTotal = 0;
  isBuffering = false;
  isURLInaccessible = false;
  length = 0;
  id3 = new ID3Info();
  constructor(stream: { url?: string } | null = null, _context: SoundLoaderContext | null = null) {
    super();
    if (stream) this.load(stream);
  }
  load(stream: { url?: string }, _context: SoundLoaderContext | null = null): void {
    this.url = stream?.url ?? null;
    setTimeout(() => {
      flDispatchSafe(this, new Event('open'));
      this.bytesLoaded = this.bytesTotal = 1;
      flDispatchSafe(this, new Event('complete'));
    }, 0);
  }
  loadCompressedDataFromByteArray(_b: ByteArray, _len: number): void {}
  loadPCMFromByteArray(): void {}
  play(startTime = 0, loops = 0, sndTransform: SoundTransform | null = null): SoundChannel {
    const ch = Sound.player?.(this, startTime, loops, sndTransform) ?? new SoundChannel(startTime);
    if (sndTransform) ch.soundTransform = sndTransform;
    return ch;
  }
  close(): void {}
  extract(_target: ByteArray, _length: number, _startPosition = -1): number { return 0; }
}

export class SoundMixer {
  static soundTransform = new SoundTransform();
  static bufferTime = 0;
  static audioPlaybackMode = 'media';
  static useSpeakerphoneForVoice = false;
  static stopAll(): void {}
  static computeSpectrum(_out: ByteArray, _fft = false, _stretch = 0): void {}
  static areSoundsInaccessible(): boolean { return false; }
}

export class Camera extends EventDispatcher {
  static readonly isSupported = false;
  static readonly names: string[] = [];
  static getCamera(_name: string | null = null): Camera | null { return null; }
}
export class Microphone extends EventDispatcher {
  static readonly isSupported = false;
  static readonly names: string[] = [];
  static getMicrophone(_index = -1): Microphone | null { return null; }
  static getEnhancedMicrophone(_index = -1): Microphone | null { return null; }
}

export const DateTimeStyle = { CUSTOM: 'custom', LONG: 'long', MEDIUM: 'medium', NONE: 'none', SHORT: 'short' } as const;
export const LastOperationStatus = { NO_ERROR: 'noError', USING_DEFAULT_WARNING: 'usingDefaultWarning', USING_FALLBACK_WARNING: 'usingFallbackWarning' } as const;
export const LocaleID = { DEFAULT: 'i-default' } as const;
export const DateTimeNameStyle = { FULL: 'full', LONG_ABBREVIATION: 'longAbbreviation', SHORT_ABBREVIATION: 'shortAbbreviation' } as const;
export const DateTimeNameContext = { FORMAT: 'format', STANDALONE: 'standalone' } as const;

const pad = (n: number, w = 2) => String(n).padStart(w, '0');

export class DateTimeFormatter {
  readonly requestedLocaleIDName: string;
  lastOperationStatus = 'noError';
  private __pattern: string | null = null;
  private __dateStyle: string;
  private __timeStyle: string;
  constructor(requestedLocaleIDName: string, dateStyle = 'long', timeStyle = 'long') {
    initFields(this, new.target);
    this.requestedLocaleIDName = requestedLocaleIDName;
    this.__dateStyle = dateStyle;
    this.__timeStyle = timeStyle;
  }
  get actualLocaleIDName(): string { return this.locale(); }
  private locale(): string {
    const l = this.requestedLocaleIDName;
    return !l || l === 'i-default' ? navigator.language : l.replace('_', '-');
  }
  static getAvailableLocaleIDNames(): string[] { return [navigator.language]; }
  setDateTimePattern(pattern: string): void { this.__pattern = pattern; }
  getDateTimePattern(): string { return this.__pattern ?? 'yyyy-MM-dd HH:mm:ss'; }
  setDateTimeStyles(dateStyle: string, timeStyle: string): void { this.__dateStyle = dateStyle; this.__timeStyle = timeStyle; this.__pattern = null; }
  getDateStyle(): string { return this.__dateStyle; }
  getTimeStyle(): string { return this.__timeStyle; }
  getFirstWeekday(): number { return 0; }
  getMonthNames(style = 'full', _ctx = 'standalone'): string[] {
    const f = new Intl.DateTimeFormat(this.locale(), { month: style === 'full' ? 'long' : 'short' });
    return Array.from({ length: 12 }, (_, i) => f.format(new Date(2000, i, 1)));
  }
  getWeekdayNames(style = 'full', _ctx = 'standalone'): string[] {
    const f = new Intl.DateTimeFormat(this.locale(), { weekday: style === 'full' ? 'long' : 'short' });
    return Array.from({ length: 7 }, (_, i) => f.format(new Date(2000, 0, 2 + i)));
  }
  format(d: Date): string { return this.fmt(d, false); }
  formatUTC(d: Date): string { return this.fmt(d, true); }
  private fmt(d: Date, utc: boolean): string {
    if (!(d instanceof Date)) return '';
    if (!this.__pattern) {
      const map: Record<string, 'full' | 'long' | 'medium' | 'short' | undefined> = { long: 'long', medium: 'medium', short: 'short', none: undefined };
      return new Intl.DateTimeFormat(this.locale(), { dateStyle: map[this.__dateStyle], timeStyle: map[this.__timeStyle], timeZone: utc ? 'UTC' : undefined }).format(d);
    }
    const g = (k: 'FullYear' | 'Month' | 'Date' | 'Hours' | 'Minutes' | 'Seconds' | 'Day' | 'Milliseconds') =>
      (utc ? (d as any)[`getUTC${k}`]() : (d as any)[`get${k}`]()) as number;
    const months = this.getMonthNames('full'), monthsS = this.getMonthNames('short');
    const days = this.getWeekdayNames('full'), daysS = this.getWeekdayNames('short');
    return this.__pattern.replace(/'([^']*)'|y{1,4}|M{1,4}|d{1,2}|E{1,4}|H{1,2}|h{1,2}|K{1,2}|k{1,2}|m{1,2}|s{1,2}|S{1,3}|a/g, (t, lit) => {
      if (lit !== undefined) return lit;
      switch (t[0]) {
        case 'y': return t.length === 2 ? pad(g('FullYear') % 100) : String(g('FullYear'));
        case 'M': return t.length >= 4 ? months[g('Month')] : t.length === 3 ? monthsS[g('Month')] : t.length === 2 ? pad(g('Month') + 1) : String(g('Month') + 1);
        case 'd': return t.length === 2 ? pad(g('Date')) : String(g('Date'));
        case 'E': return t.length >= 4 ? days[g('Day')] : daysS[g('Day')];
        case 'H': return t.length === 2 ? pad(g('Hours')) : String(g('Hours'));
        case 'k': return String(g('Hours') || 24);
        case 'K': return String(g('Hours') % 12);
        case 'h': { const h = g('Hours') % 12 || 12; return t.length === 2 ? pad(h) : String(h); }
        case 'm': return t.length === 2 ? pad(g('Minutes')) : String(g('Minutes'));
        case 's': return t.length === 2 ? pad(g('Seconds')) : String(g('Seconds'));
        case 'S': return pad(g('Milliseconds'), 3).slice(0, t.length);
        case 'a': return g('Hours') < 12 ? 'AM' : 'PM';
        default: return t;
      }
    });
  }
}

export const Context3DBlendFactor = {
  DESTINATION_ALPHA: 'destinationAlpha', DESTINATION_COLOR: 'destinationColor', ONE: 'one', ONE_MINUS_DESTINATION_ALPHA: 'oneMinusDestinationAlpha',
  ONE_MINUS_DESTINATION_COLOR: 'oneMinusDestinationColor', ONE_MINUS_SOURCE_ALPHA: 'oneMinusSourceAlpha', ONE_MINUS_SOURCE_COLOR: 'oneMinusSourceColor',
  SOURCE_ALPHA: 'sourceAlpha', SOURCE_COLOR: 'sourceColor', ZERO: 'zero',
} as const;
export const Context3DProgramType = { FRAGMENT: 'fragment', VERTEX: 'vertex' } as const;
export const Context3DTextureFormat = { BGRA: 'bgra', BGRA_PACKED: 'bgraPacked4444', BGR_PACKED: 'bgrPacked565', COMPRESSED: 'compressed', COMPRESSED_ALPHA: 'compressedAlpha', RGBA_HALF_FLOAT: 'rgbaHalfFloat' } as const;
export const Context3DVertexBufferFormat = { BYTES_4: 'bytes4', FLOAT_1: 'float1', FLOAT_2: 'float2', FLOAT_3: 'float3', FLOAT_4: 'float4' } as const;
export const Context3DTriangleFace = { BACK: 'back', FRONT: 'front', FRONT_AND_BACK: 'frontAndBack', NONE: 'none' } as const;
export const Context3DCompareMode = { ALWAYS: 'always', EQUAL: 'equal', GREATER: 'greater', GREATER_EQUAL: 'greaterEqual', LESS: 'less', LESS_EQUAL: 'lessEqual', NEVER: 'never', NOT_EQUAL: 'notEqual' } as const;
export const Context3DRenderMode = { AUTO: 'auto', SOFTWARE: 'software' } as const;
export const Context3DProfile = { BASELINE: 'baseline', BASELINE_CONSTRAINED: 'baselineConstrained', BASELINE_EXTENDED: 'baselineExtended', STANDARD: 'standard', STANDARD_CONSTRAINED: 'standardConstrained', STANDARD_EXTENDED: 'standardExtended' } as const;
export const Context3DClearMask = { ALL: 7, COLOR: 1, DEPTH: 2, STENCIL: 4 } as const;
export const Context3DStencilAction = { DECREMENT_SATURATE: 'decrementSaturate', DECREMENT_WRAP: 'decrementWrap', INCREMENT_SATURATE: 'incrementSaturate', INCREMENT_WRAP: 'incrementWrap', INVERT: 'invert', KEEP: 'keep', SET: 'set', ZERO: 'zero' } as const;
export const Context3DMipFilter = { MIPLINEAR: 'miplinear', MIPNEAREST: 'mipnearest', MIPNONE: 'mipnone' } as const;
export const Context3DTextureFilter = { ANISOTROPIC16X: 'anisotropic16x', ANISOTROPIC2X: 'anisotropic2x', ANISOTROPIC4X: 'anisotropic4x', ANISOTROPIC8X: 'anisotropic8x', LINEAR: 'linear', NEAREST: 'nearest' } as const;
export const Context3DWrapMode = { CLAMP: 'clamp', CLAMP_U_REPEAT_V: 'clamp_u_repeat_v', REPEAT: 'repeat', REPEAT_U_CLAMP_V: 'repeat_u_clamp_v' } as const;
export const Context3DBufferUsage = { DYNAMIC_DRAW: 'dynamicDraw', STATIC_DRAW: 'staticDraw' } as const;

export class Program3D { upload(): void {} dispose(): void {} }
export class VertexBuffer3D { uploadFromVector(): void {} uploadFromByteArray(): void {} dispose(): void {} }
export class IndexBuffer3D { uploadFromVector(): void {} uploadFromByteArray(): void {} dispose(): void {} }
export class Context3D extends EventDispatcher {
  static readonly supportsVideoTexture = false;
  readonly driverInfo = 'Disposed';
  enableErrorChecking = false;
  dispose(): void {}
}
export class Stage3D extends EventDispatcher {
  x = 0;
  y = 0;
  visible = true;
  readonly context3D: Context3D | null = null;
  requestContext3D(): void {
    setTimeout(() => flDispatchSafe(this, Object.assign(new Event('error'), { text: 'Error #3702: Context3D not available.', errorID: 3702 })), 0);
  }
  requestContext3DMatchingProfiles(): void { this.requestContext3D(); }
}

export function getSize(o: unknown): number {
  if (o === null || o === undefined) return 0;
  switch (typeof o) {
    case 'number': return 8;
    case 'boolean': return 4;
    case 'string': return 24 + o.length * 2;
    case 'function': return 64;
    default: {
      if (o instanceof ByteArray) return 40 + o.length;
      if (Array.isArray(o)) return 40 + o.length * 8;
      return 40 + Object.keys(o as object).length * 16;
    }
  }
}
