import type { Application } from 'pixi.js';
import { $ } from '../runtime';
import '@/pickgliss';
import { ComponentFactory } from '@/pickgliss/ComponentFactory';
import { StageReferance } from '@/pickgliss/toplevel/StageReferance';
import { Domain } from '@/flash/library';
import { FlashClock } from '@/flash/clock';
import { Timer } from '@/flash/events';
import { Sprite as BaseSprite, FlashGraphics } from '@/flash/sprite';
import { TextFormat } from '@/flash/text';
import { BitmapData } from '@/flash/bitmapdata';
import { MovieClip } from '@/flash/display';
import * as errors from './errors';
import * as geom from './geom';
import * as events from './events';
import * as display from './display';
import * as filters from './filters';
import * as net from './net';
import * as system from './system';
import * as text from './text';
import * as utils from './utils';
import { ByteArray, CompressionAlgorithm, Endian, ObjectEncoding } from './bytearray';
import { Dictionary, installKeyHook } from './dictionary';
import { installKeyboard, installMouse, patchBoundaryInstance } from './mouse';
import { initFields } from '../runtime';

export * from './display';
export { ByteArray, Dictionary, Endian };
export { Loader } from './display';
export { Socket, URLLoader, NetConnection, SharedObject, navigation, webSocketTransport } from './net';
export { ApplicationDomain } from './system';

const registered = new Set<string>();

function reg(fqn: string, value: unknown): void {
  if (typeof value === 'function' && !Object.prototype.hasOwnProperty.call(value, '__fqn')) {
    try { Object.defineProperty(value, '__fqn', { value: fqn, configurable: true, writable: true }); } catch { }
  }
  $.registerNative(fqn, value);
  system.noteNative(fqn, value);
  registered.add(fqn);
}

function regAll(pkg: string, mod: Record<string, unknown>, names: string[]): void {
  for (const n of names) {
    const v = mod[n];
    if (v === undefined) { console.warn('[flash] nativo ausente:', `${pkg}.${n}`); continue; }
    reg(`${pkg}.${n}`, v);
  }
}

class AS3Array extends Array {
  constructor(...a: unknown[]) {
    super(...(a as []));
    initFields(this, new.target);
  }
  static override [Symbol.hasInstance](v: unknown): boolean {
    if (this === AS3Array) return Array.isArray(v);
    return Function.prototype[Symbol.hasInstance].call(this, v);
  }
}

function pkgProxy(prefix: string): unknown {
  return new Proxy(Object.create(null), {
    get(_t, k) {
      if (typeof k !== 'string') return undefined;
      const fqn = `${prefix}.${k}`;
      if (registered.has(fqn) || Domain.getClass(fqn) || $.moduleOf(fqn)) return $.C(fqn);
      return pkgProxy(fqn);
    },
  });
}

let done = false;

export function installFlash(): void {
  if (done) return;
  done = true;
  installKeyHook();
  display.installDisplayApi();
  installMouse();
  system.trackBundles();
  BitmapData.symbolResolver = (ctor) => {
    const s = display.symbolFor(ctor);
    return s && s[2].kind === 'bitmap' ? s[0].bitmapData(s[1]) : null;
  };
  MovieClip.symbolResolver = (ctor) => {
    const s = display.symbolFor(ctor);
    return s && s[2].kind === 'sprite' ? { lib: s[0], def: s[2] } : null;
  };
  for (const [name, cls] of [['flash.display.Sprite', BaseSprite], ['flash.display.Graphics', FlashGraphics]] as const) {
    if (!Object.prototype.hasOwnProperty.call(cls, '__fqn')) Object.defineProperty(cls, '__fqn', { value: name, configurable: true, writable: true });
  }

  reg('Error', errors.AS3Error);
  for (const n of ['ArgumentError', 'DefinitionError', 'SecurityError', 'VerifyError', 'UninitializedError']) {
    reg(n, (errors as any)[n]);
    $.globals.set(n, (errors as any)[n]);
  }
  reg('Array', AS3Array);

  regAll('flash.errors', errors, ['IOError', 'EOFError', 'IllegalOperationError', 'InvalidSWFError', 'MemoryError',
    'ScriptTimeoutError', 'StackOverflowError', 'DRMManagerError', 'SQLError']);

  regAll('flash.geom', geom, ['Point', 'Rectangle', 'Matrix', 'ColorTransform', 'Vector3D', 'Matrix3D', 'PerspectiveProjection', 'Orientation3D']);
  reg('flash.geom.Transform', display.Transform);

  regAll('flash.events', events, ['Event', 'EventDispatcher', 'EventPhase', 'TimerEvent', 'MouseEvent', 'KeyboardEvent', 'FocusEvent',
    'TextEvent', 'ErrorEvent', 'IOErrorEvent', 'SecurityErrorEvent', 'AsyncErrorEvent', 'UncaughtErrorEvent', 'UncaughtErrorEvents',
    'ProgressEvent', 'HTTPStatusEvent', 'DataEvent', 'NetStatusEvent', 'StatusEvent', 'FullScreenEvent', 'ContextMenuEvent',
    'TouchEvent', 'IMEEvent', 'SampleDataEvent', 'ActivityEvent', 'SyncEvent', 'GestureEvent', 'TransformGestureEvent']);

  regAll('flash.display', display, ['DisplayObject', 'InteractiveObject', 'DisplayObjectContainer', 'Sprite', 'MovieClip', 'Shape',
    'Bitmap', 'BitmapData', 'SimpleButton', 'Stage', 'Loader', 'LoaderInfo', 'FrameLabel', 'Scene', 'Graphics', 'AVM1Movie', 'MorphShape',
    'StageAlign', 'StageScaleMode', 'StageQuality', 'StageDisplayState', 'BlendMode', 'PixelSnapping', 'GradientType', 'SpreadMethod',
    'InterpolationMethod', 'CapsStyle', 'JointStyle', 'LineScaleMode', 'GraphicsPathCommand', 'GraphicsPathWinding', 'TriangleCulling',
    'BitmapDataChannel', 'ColorCorrection', 'ActionScriptVersion', 'SWFVersion']);
  reg('flash.display.Stage3D', system.Stage3D);

  regAll('flash.filters', filters, ['BitmapFilter', 'GlowFilter', 'DropShadowFilter', 'BlurFilter', 'ColorMatrixFilter', 'BevelFilter',
    'GradientGlowFilter', 'GradientBevelFilter', 'ConvolutionFilter', 'DisplacementMapFilter', 'ShaderFilter', 'BitmapFilterQuality',
    'BitmapFilterType', 'DisplacementMapFilterMode']);

  reg('flash.utils.Dictionary', Dictionary);
  reg('flash.utils.ByteArray', ByteArray);
  reg('flash.utils.Timer', Timer);
  reg('flash.utils.Endian', Endian);
  reg('flash.utils.CompressionAlgorithm', CompressionAlgorithm);
  reg('flash.utils.Proxy', utils.FlashProxy);
  regAll('flash.utils', utils, ['getTimer', 'setTimeout', 'clearTimeout', 'setInterval', 'clearInterval', 'getQualifiedClassName',
    'getQualifiedSuperclassName', 'describeType', 'escapeMultiByte', 'unescapeMultiByte']);
  reg('flash.utils.getDefinitionByName', system.getDefinitionByName);
  reg('avmplus.getQualifiedClassName', utils.getQualifiedClassName);
  reg('avmplus.getQualifiedSuperclassName', utils.getQualifiedSuperclassName);
  reg('avmplus.describeType', utils.describeType);
  reg('avmplus.getDefinitionByName', system.getDefinitionByName);

  regAll('flash.net', net, ['URLRequest', 'URLVariables', 'URLLoader', 'URLStream', 'URLRequestMethod', 'URLRequestHeader',
    'URLLoaderDataFormat', 'navigateToURL', 'sendToURL', 'SharedObject', 'SharedObjectFlushStatus', 'Socket', 'XMLSocket',
    'NetConnection', 'Responder', 'NetStream', 'LocalConnection', 'FileReference', 'FileReferenceList', 'FileFilter',
    'registerClassAlias', 'getClassByAlias']);
  reg('flash.net.ObjectEncoding', ObjectEncoding);

  regAll('flash.system', system, ['ApplicationDomain', 'LoaderContext', 'JPEGLoaderContext', 'SecurityDomain', 'Capabilities', 'System',
    'Security', 'SecurityPanel', 'IME', 'IMEConversionMode', 'fscommand', 'TouchscreenType', 'ImageDecodingPolicy']);
  reg('flash.external.ExternalInterface', system.ExternalInterface);
  regAll('flash.ui', system, ['Mouse', 'MouseCursor', 'MouseCursorData', 'Multitouch', 'MultitouchInputMode', 'ContextMenu',
    'ContextMenuItem', 'ContextMenuBuiltInItems', 'ContextMenuClipboardItems', 'Keyboard', 'KeyLocation']);

  regAll('flash.media', system, ['Sound', 'SoundChannel', 'SoundTransform', 'SoundMixer', 'SoundLoaderContext', 'ID3Info', 'Camera', 'Microphone']);
  reg('flash.media.Video', display.Video);

  reg('flash.text.TextField', display.TextField);
  reg('flash.text.TextFormat', TextFormat);
  regAll('flash.text', text, ['TextFieldAutoSize', 'TextFormatAlign', 'AntiAliasType', 'GridFitType', 'TextFieldType', 'TextDisplayMode',
    'TextColorType', 'TextFormatDisplay', 'TextInteractionMode', 'FontStyle', 'FontType', 'TextLineMetrics', 'TextRenderer',
    'TextSnapshot', 'Font', 'StyleSheet']);
  regAll('flash.text.engine', text, ['FontWeight', 'FontPosture', 'FontLookup', 'RenderingMode', 'CFFHinting', 'TextBaseline',
    'BreakOpportunity', 'Kerning', 'TextRotation', 'TextLineValidity', 'TextLineCreationResult', 'LineJustification', 'DigitCase',
    'DigitWidth', 'LigatureLevel', 'TypographicCase', 'TabAlignment', 'FontDescription', 'FontMetrics', 'ElementFormat',
    'ContentElement', 'TextElement', 'GraphicElement', 'GroupElement', 'TabStop', 'TextJustifier', 'SpaceJustifier',
    'EastAsianJustifier', 'TextBlock', 'TextLine', 'TextLineMirrorRegion']);

  regAll('flash.globalization', system, ['DateTimeFormatter', 'DateTimeStyle', 'LastOperationStatus', 'LocaleID', 'DateTimeNameStyle',
    'DateTimeNameContext']);
  regAll('flash.display3D', system, ['Context3DBlendFactor', 'Context3DProgramType', 'Context3DTextureFormat', 'Context3DVertexBufferFormat',
    'Context3DTriangleFace', 'Context3DCompareMode', 'Context3DRenderMode', 'Context3DProfile', 'Context3DClearMask',
    'Context3DStencilAction', 'Context3DMipFilter', 'Context3DTextureFilter', 'Context3DWrapMode', 'Context3DBufferUsage',
    'Program3D', 'VertexBuffer3D', 'IndexBuffer3D', 'Context3D']);
  reg('flash.sampler.getSize', system.getSize);

  for (const name of Domain.classNames()) {
    if (!name.startsWith('com.pickgliss.') && !name.startsWith('flash.')) continue;
    if (registered.has(name)) continue;
    reg(name, Domain.getClass(name));
  }
  reg('com.pickgliss.ui.ComponentFactory', ComponentFactory);
  void StageReferance;
  for (const n of ['flash.geom.Point', 'flash.geom.Rectangle', 'flash.filters.GlowFilter', 'flash.filters.DropShadowFilter',
    'flash.filters.BlurFilter', 'flash.filters.ColorMatrixFilter']) {
    Domain.registerClass(n, $.C(n));
  }

  for (const root of ['flash', 'com', 'starling', 'avmplus', 'mx', 'org', 'fl']) $.globals.set(root, pkgProxy(root));
  for (const [k, v] of Object.entries({
    getTimer: utils.getTimer, setTimeout: utils.setTimeout, clearTimeout: utils.clearTimeout, setInterval: utils.setInterval,
    clearInterval: utils.clearInterval, getQualifiedClassName: utils.getQualifiedClassName, describeType: utils.describeType,
    getDefinitionByName: system.getDefinitionByName, navigateToURL: net.navigateToURL, registerClassAlias: net.registerClassAlias,
  })) if (!$.globals.has(k)) $.globals.set(k, v);

  Object.assign($, {
    getTimer: utils.getTimer, setTimeout: utils.setTimeout, clearTimeout: utils.clearTimeout, setInterval: utils.setInterval,
    clearInterval: utils.clearInterval, getQualifiedClassName: utils.getQualifiedClassName,
    getQualifiedSuperclassName: utils.getQualifiedSuperclassName, getDefinitionByName: system.getDefinitionByName,
    describeType: utils.describeType, navigateToURL: net.navigateToURL, fscommand: system.fscommand, sendToURL: net.sendToURL,
  });
}

export function getStage(app: Application, flashVars?: Record<string, string>): any {
  installFlash();
Object.assign(window as any, { __as3: { $, Domain, getStage, display, net, system } });
(window as any).__as3selftest = () => import('../selftest').then((m) => m.runSelfTest());
  display.applyEventApi();
  const st = display.setupStage(app, flashVars);
  patchBoundaryInstance(app.renderer.events.rootBoundary);
  installKeyboard(app);
  FlashClock.fps = 25;
  return st;
}

installFlash();
Object.assign(window as any, { __as3: { $, Domain, getStage, display, net, system } });
(window as any).__as3selftest = () => import('../selftest').then((m) => m.runSelfTest());
