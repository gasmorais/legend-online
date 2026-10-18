import { Event } from '@/flash/events';

export class ComponentEvent extends Event {
  static readonly PROPERTIES_CHANGED = 'propertiesChanged';
  static readonly GROUP_CONFLICT = 'GROUP_CONFLICT';
  static readonly FRAME_MOVE_COMPLETE = 'FRAME_MOVE_COMPLETE';
  private _changedProperties: Record<string, boolean> | null;

  constructor(type: string, changed: Record<string, boolean> | null = null) {
    super(type);
    this._changedProperties = changed;
  }

  get changedProperties(): Record<string, boolean> { return this._changedProperties ?? {}; }
}

export class FrameEvent extends Event {
  static readonly CANCEL_CLICK = 4;
  static readonly CLOSE_CLICK = 0;
  static readonly ENTER_CLICK = 2;
  static readonly ESC_CLICK = 1;
  static readonly RESPONSE = 'response';
  static readonly SUBMIT_CLICK = 3;
  obj: boolean;
  responseCode = -1;

  constructor(responseCode: number, obj = true) {
    super(FrameEvent.RESPONSE);
    this.responseCode = responseCode;
    this.obj = obj;
  }
}

export class InteractiveEvent extends Event {
  static readonly STATE_CHANGED = 'stateChange';
  static readonly CLICK = 'interactive_click';
  static readonly DOUBLE_CLICK = 'interactive_double_click';
  ctrlKey = false;
}

export class ListItemEvent extends Event {
  static readonly LIST_ITEM_CLICK = 'listItemClick';
  static readonly LIST_ITEM_DOUBLE_CLICK = 'listItemDoubleclick';
  static readonly LIST_ITEM_MOUSE_DOWN = 'listItemMouseDown';
  static readonly LIST_ITEM_MOUSE_UP = 'listItemMouseUp';
  static readonly LIST_ITEM_ROLL_OVER = 'listItemRollOver';
  static readonly LIST_ITEM_ROLL_OUT = 'listItemRollOut';
  cell: any;
  cellValue: any;
  index: number;
  sourceEvent: unknown;

  constructor(cell: any, cellValue: any, type: string, index: number, sourceEvent: unknown = null) {
    super(type);
    this.cell = cell;
    this.cellValue = cellValue;
    this.index = index;
    this.sourceEvent = sourceEvent;
  }

  override clone(): ListItemEvent { return new ListItemEvent(this.cell, this.cellValue, this.type, this.index, this.sourceEvent); }
}

export class ModelEvent {
  private _source: unknown;
  constructor(source: unknown) { this._source = source; }
  getSource(): unknown { return this._source; }
}

export function changedPropertiesOf(e: unknown): Record<string, boolean> {
  if (!e || typeof e !== 'object') return {};
  const cp = (e as { changedProperties?: Record<string, boolean> }).changedProperties;
  return cp ?? (e as Record<string, boolean>);
}
