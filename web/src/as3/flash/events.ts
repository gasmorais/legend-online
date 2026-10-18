import { Event, EventDispatcher, EventPhase, TimerEvent } from '@/flash/events';

export { Event, EventDispatcher, EventPhase, TimerEvent };

const nan = (v: unknown) => (v === undefined || v === null ? NaN : Number(v));

export class MouseEvent extends Event {
  static readonly CLICK = 'click';
  static readonly CONTEXT_MENU = 'contextMenu';
  static readonly DOUBLE_CLICK = 'doubleClick';
  static readonly MIDDLE_CLICK = 'middleClick';
  static readonly MIDDLE_MOUSE_DOWN = 'middleMouseDown';
  static readonly MIDDLE_MOUSE_UP = 'middleMouseUp';
  static readonly MOUSE_DOWN = 'mouseDown';
  static readonly MOUSE_MOVE = 'mouseMove';
  static readonly MOUSE_OUT = 'mouseOut';
  static readonly MOUSE_OVER = 'mouseOver';
  static readonly MOUSE_UP = 'mouseUp';
  static readonly MOUSE_WHEEL = 'mouseWheel';
  static readonly RELEASE_OUTSIDE = 'releaseOutside';
  static readonly RIGHT_CLICK = 'rightClick';
  static readonly RIGHT_MOUSE_DOWN = 'rightMouseDown';
  static readonly RIGHT_MOUSE_UP = 'rightMouseUp';
  static readonly ROLL_OUT = 'rollOut';
  static readonly ROLL_OVER = 'rollOver';

  relatedObject: any;
  ctrlKey: boolean;
  altKey: boolean;
  shiftKey: boolean;
  buttonDown: boolean;
  delta: number;
  commandKey: boolean;
  controlKey: boolean;
  clickCount: number;
  movementX = 0;
  movementY = 0;
  isRelatedObjectInaccessible = false;
  __stageX = NaN;
  __stageY = NaN;
  private __localX: number;
  private __localY: number;
  __fromPixi = false;

  constructor(type: string, bubbles = true, cancelable = false, localX?: unknown, localY?: unknown, relatedObject: unknown = null,
    ctrlKey = false, altKey = false, shiftKey = false, buttonDown = false, delta = 0, commandKey = false, controlKey = false,
    clickCount = 0) {
    super(type, bubbles, cancelable);
    this.__localX = nan(localX);
    this.__localY = nan(localY);
    this.relatedObject = relatedObject;
    this.ctrlKey = !!ctrlKey;
    this.altKey = !!altKey;
    this.shiftKey = !!shiftKey;
    this.buttonDown = !!buttonDown;
    this.delta = Number(delta) | 0;
    this.commandKey = !!commandKey;
    this.controlKey = !!controlKey;
    this.clickCount = Number(clickCount) | 0;
  }

  get localX(): number {
    if (!Number.isNaN(this.__localX)) return this.__localX;
    if (!Number.isNaN(this.__stageX) && this.target?.globalToLocal) return this.target.globalToLocal({ x: this.__stageX, y: this.__stageY }).x;
    return NaN;
  }
  set localX(v: number) { this.__localX = Number(v); }
  get localY(): number {
    if (!Number.isNaN(this.__localY)) return this.__localY;
    if (!Number.isNaN(this.__stageY) && this.target?.globalToLocal) return this.target.globalToLocal({ x: this.__stageX, y: this.__stageY }).y;
    return NaN;
  }
  set localY(v: number) { this.__localY = Number(v); }
  get stageX(): number {
    if (!Number.isNaN(this.__stageX)) return this.__stageX;
    if (!Number.isNaN(this.__localX) && this.target?.localToGlobal) return this.target.localToGlobal({ x: this.__localX, y: this.__localY }).x;
    return NaN;
  }
  get stageY(): number {
    if (!Number.isNaN(this.__stageY)) return this.__stageY;
    if (!Number.isNaN(this.__localY) && this.target?.localToGlobal) return this.target.localToGlobal({ x: this.__localX, y: this.__localY }).y;
    return NaN;
  }

  updateAfterEvent(): void { }

  override clone(): Event {
    const e = new MouseEvent(this.type, this.bubbles, this.cancelable, this.__localX, this.__localY, this.relatedObject,
      this.ctrlKey, this.altKey, this.shiftKey, this.buttonDown, this.delta, this.commandKey, this.controlKey, this.clickCount);
    e.__stageX = this.__stageX;
    e.__stageY = this.__stageY;
    return e;
  }
  override toString(): string {
    return this.formatToString('MouseEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'localX', 'localY', 'stageX', 'stageY',
      'relatedObject', 'ctrlKey', 'altKey', 'shiftKey', 'buttonDown', 'delta');
  }
}

export class KeyboardEvent extends Event {
  static readonly KEY_DOWN = 'keyDown';
  static readonly KEY_UP = 'keyUp';
  charCode: number;
  keyCode: number;
  keyLocation: number;
  ctrlKey: boolean;
  altKey: boolean;
  shiftKey: boolean;
  commandKey = false;
  controlKey = false;
  constructor(type: string, bubbles = true, cancelable = false, charCode = 0, keyCode = 0, keyLocation = 0, ctrlKey = false,
    altKey = false, shiftKey = false, controlKey = false, commandKey = false) {
    super(type, bubbles, cancelable);
    this.charCode = Number(charCode) >>> 0;
    this.keyCode = Number(keyCode) >>> 0;
    this.keyLocation = Number(keyLocation) >>> 0;
    this.ctrlKey = !!ctrlKey;
    this.altKey = !!altKey;
    this.shiftKey = !!shiftKey;
    this.controlKey = !!controlKey;
    this.commandKey = !!commandKey;
  }
  updateAfterEvent(): void {}
  override clone(): Event {
    return new KeyboardEvent(this.type, this.bubbles, this.cancelable, this.charCode, this.keyCode, this.keyLocation, this.ctrlKey,
      this.altKey, this.shiftKey, this.controlKey, this.commandKey);
  }
  override toString(): string {
    return this.formatToString('KeyboardEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'charCode', 'keyCode', 'keyLocation',
      'ctrlKey', 'altKey', 'shiftKey');
  }
}

export class FocusEvent extends Event {
  static readonly FOCUS_IN = 'focusIn';
  static readonly FOCUS_OUT = 'focusOut';
  static readonly KEY_FOCUS_CHANGE = 'keyFocusChange';
  static readonly MOUSE_FOCUS_CHANGE = 'mouseFocusChange';
  relatedObject: any;
  shiftKey: boolean;
  keyCode: number;
  isRelatedObjectInaccessible = false;
  constructor(type: string, bubbles = true, cancelable = false, relatedObject: unknown = null, shiftKey = false, keyCode = 0) {
    super(type, bubbles, cancelable);
    this.relatedObject = relatedObject;
    this.shiftKey = !!shiftKey;
    this.keyCode = Number(keyCode) >>> 0;
  }
  override clone(): Event { return new FocusEvent(this.type, this.bubbles, this.cancelable, this.relatedObject, this.shiftKey, this.keyCode); }
}

export class TextEvent extends Event {
  static readonly LINK = 'link';
  static readonly TEXT_INPUT = 'textInput';
  text: string;
  constructor(type: string, bubbles = false, cancelable = false, text = '') {
    super(type, bubbles, cancelable);
    this.text = String(text ?? '');
  }
  override clone(): Event { return new TextEvent(this.type, this.bubbles, this.cancelable, this.text); }
  override toString(): string { return this.formatToString('TextEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'text'); }
}

export class ErrorEvent extends TextEvent {
  static readonly ERROR = 'error';
  readonly errorID: number;
  constructor(type: string, bubbles = false, cancelable = false, text = '', id = 0) {
    super(type, bubbles, cancelable, text);
    this.errorID = Number(id) | 0;
  }
  override clone(): Event { return new ErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.errorID); }
  override toString(): string { return this.formatToString('ErrorEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'text', 'errorID'); }
}

export class IOErrorEvent extends ErrorEvent {
  static readonly IO_ERROR = 'ioError';
  static readonly DISK_ERROR = 'diskError';
  static readonly NETWORK_ERROR = 'networkError';
  static readonly VERIFY_ERROR = 'verifyError';
  override clone(): Event { return new IOErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.errorID); }
  override toString(): string { return this.formatToString('IOErrorEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'text', 'errorID'); }
}

export class SecurityErrorEvent extends ErrorEvent {
  static readonly SECURITY_ERROR = 'securityError';
  override clone(): Event { return new SecurityErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.errorID); }
}

export class AsyncErrorEvent extends ErrorEvent {
  static readonly ASYNC_ERROR = 'asyncError';
  error: unknown;
  constructor(type: string, bubbles = false, cancelable = false, text = '', error: unknown = null) {
    super(type, bubbles, cancelable, text);
    this.error = error;
  }
  override clone(): Event { return new AsyncErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.error); }
}

export class UncaughtErrorEvent extends ErrorEvent {
  static readonly UNCAUGHT_ERROR = 'uncaughtError';
  readonly error: unknown;
  constructor(type = 'uncaughtError', bubbles = true, cancelable = true, error: unknown = null) {
    super(type, bubbles, cancelable, String((error as any)?.message ?? error ?? ''));
    this.error = error;
  }
  override clone(): Event { return new UncaughtErrorEvent(this.type, this.bubbles, this.cancelable, this.error); }
}

export class UncaughtErrorEvents extends EventDispatcher {}

export class ProgressEvent extends Event {
  static readonly PROGRESS = 'progress';
  static readonly SOCKET_DATA = 'socketData';
  static readonly STANDARD_ERROR_DATA = 'standardErrorData';
  static readonly STANDARD_INPUT_PROGRESS = 'standardInputProgress';
  static readonly STANDARD_OUTPUT_DATA = 'standardOutputData';
  bytesLoaded: number;
  bytesTotal: number;
  constructor(type: string, bubbles = false, cancelable = false, bytesLoaded = 0, bytesTotal = 0) {
    super(type, bubbles, cancelable);
    this.bytesLoaded = Number(bytesLoaded);
    this.bytesTotal = Number(bytesTotal);
  }
  override clone(): Event { return new ProgressEvent(this.type, this.bubbles, this.cancelable, this.bytesLoaded, this.bytesTotal); }
  override toString(): string {
    return this.formatToString('ProgressEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'bytesLoaded', 'bytesTotal');
  }
}

export class HTTPStatusEvent extends Event {
  static readonly HTTP_STATUS = 'httpStatus';
  static readonly HTTP_RESPONSE_STATUS = 'httpResponseStatus';
  status: number;
  redirected: boolean;
  responseURL: string | null = null;
  responseHeaders: unknown[] = [];
  constructor(type: string, bubbles = false, cancelable = false, status = 0, redirected = false) {
    super(type, bubbles, cancelable);
    this.status = Number(status) | 0;
    this.redirected = !!redirected;
  }
  override clone(): Event { return new HTTPStatusEvent(this.type, this.bubbles, this.cancelable, this.status, this.redirected); }
}

export class DataEvent extends TextEvent {
  static readonly DATA = 'data';
  static readonly UPLOAD_COMPLETE_DATA = 'uploadCompleteData';
  constructor(type: string, bubbles = false, cancelable = false, data = '') { super(type, bubbles, cancelable, data); }
  get data(): string { return this.text; }
  set data(v: string) { this.text = String(v); }
  override clone(): Event { return new DataEvent(this.type, this.bubbles, this.cancelable, this.text); }
}

export class NetStatusEvent extends Event {
  static readonly NET_STATUS = 'netStatus';
  info: Record<string, unknown>;
  constructor(type: string, bubbles = false, cancelable = false, info: Record<string, unknown> | null = null) {
    super(type, bubbles, cancelable);
    this.info = info ?? {};
  }
  override clone(): Event { return new NetStatusEvent(this.type, this.bubbles, this.cancelable, this.info); }
}

export class StatusEvent extends Event {
  static readonly STATUS = 'status';
  code: string;
  level: string;
  constructor(type: string, bubbles = false, cancelable = false, code = '', level = '') {
    super(type, bubbles, cancelable);
    this.code = code;
    this.level = level;
  }
  override clone(): Event { return new StatusEvent(this.type, this.bubbles, this.cancelable, this.code, this.level); }
}

export class FullScreenEvent extends Event {
  static readonly FULL_SCREEN = 'fullScreen';
  static readonly FULL_SCREEN_INTERACTIVE_ACCEPTED = 'fullScreenInteractiveAccepted';
  fullScreen: boolean;
  interactive: boolean;
  constructor(type: string, bubbles = false, cancelable = false, fullScreen = false, interactive = false) {
    super(type, bubbles, cancelable);
    this.fullScreen = !!fullScreen;
    this.interactive = !!interactive;
  }
  override clone(): Event { return new FullScreenEvent(this.type, this.bubbles, this.cancelable, this.fullScreen, this.interactive); }
}

export class ContextMenuEvent extends Event {
  static readonly MENU_ITEM_SELECT = 'menuItemSelect';
  static readonly MENU_SELECT = 'menuSelect';
  mouseTarget: unknown;
  contextMenuOwner: unknown;
  isMouseTargetInaccessible = false;
  constructor(type: string, bubbles = false, cancelable = false, mouseTarget: unknown = null, contextMenuOwner: unknown = null) {
    super(type, bubbles, cancelable);
    this.mouseTarget = mouseTarget;
    this.contextMenuOwner = contextMenuOwner;
  }
  override clone(): Event { return new ContextMenuEvent(this.type, this.bubbles, this.cancelable, this.mouseTarget, this.contextMenuOwner); }
}

export class TouchEvent extends Event {
  static readonly TOUCH_BEGIN = 'touchBegin';
  static readonly TOUCH_END = 'touchEnd';
  static readonly TOUCH_MOVE = 'touchMove';
  static readonly TOUCH_OUT = 'touchOut';
  static readonly TOUCH_OVER = 'touchOver';
  static readonly TOUCH_ROLL_OUT = 'touchRollOut';
  static readonly TOUCH_ROLL_OVER = 'touchRollOver';
  static readonly TOUCH_TAP = 'touchTap';
  touchPointID: number;
  isPrimaryTouchPoint: boolean;
  localX: number;
  localY: number;
  sizeX: number;
  sizeY: number;
  pressure: number;
  relatedObject: unknown;
  ctrlKey: boolean;
  altKey: boolean;
  shiftKey: boolean;
  stageX = NaN;
  stageY = NaN;
  constructor(type: string, bubbles = true, cancelable = false, touchPointID = 0, isPrimaryTouchPoint = false, localX = NaN,
    localY = NaN, sizeX = NaN, sizeY = NaN, pressure = NaN, relatedObject: unknown = null, ctrlKey = false, altKey = false,
    shiftKey = false) {
    super(type, bubbles, cancelable);
    this.touchPointID = touchPointID;
    this.isPrimaryTouchPoint = isPrimaryTouchPoint;
    this.localX = localX;
    this.localY = localY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.pressure = pressure;
    this.relatedObject = relatedObject;
    this.ctrlKey = ctrlKey;
    this.altKey = altKey;
    this.shiftKey = shiftKey;
  }
  updateAfterEvent(): void {}
}

export class IMEEvent extends TextEvent {
  static readonly IME_COMPOSITION = 'imeComposition';
  static readonly IME_START_COMPOSITION = 'imeStartComposition';
}

export class SampleDataEvent extends Event {
  static readonly SAMPLE_DATA = 'sampleData';
  position = 0;
  data: unknown = null;
}

export class ActivityEvent extends Event {
  static readonly ACTIVITY = 'activity';
  activating: boolean;
  constructor(type: string, bubbles = false, cancelable = false, activating = false) {
    super(type, bubbles, cancelable);
    this.activating = activating;
  }
}

export class SyncEvent extends Event {
  static readonly SYNC = 'sync';
  changeList: unknown[];
  constructor(type: string, bubbles = false, cancelable = false, changeList: unknown[] = []) {
    super(type, bubbles, cancelable);
    this.changeList = changeList;
  }
}

export class GestureEvent extends Event {
  static readonly GESTURE_TWO_FINGER_TAP = 'gestureTwoFingerTap';
}
export class TransformGestureEvent extends GestureEvent {
  static readonly GESTURE_PAN = 'gesturePan';
  static readonly GESTURE_ROTATE = 'gestureRotate';
  static readonly GESTURE_SWIPE = 'gestureSwipe';
  static readonly GESTURE_ZOOM = 'gestureZoom';
}
