import { Rectangle, type Container } from 'pixi.js';
import { EventDispatcher, Event, trackPointer } from '@/flash/events';

class StageReferanceClass {
  keyBoardEnable = true;
  isDebug = false;
  private _stage: Container | null = null;
  private _stageWidth = 0;
  private _stageHeight = 0;
  private readonly dispatcher = new EventDispatcher();
  focus: unknown = null;

  get stage(): Container | null { return this._stage; }
  get stageWidth(): number { return this._stageWidth; }
  get stageHeight(): number { return this._stageHeight; }
  get gameStageWidth(): number { return this._stageWidth < 800 ? 800 : this._stageWidth; }
  get gameStageHeight(): number { return this._stageHeight < 480 ? 480 : this._stageHeight; }

  setup(stage: Container, width = 1000, height = 600, isDebug = false): void {
    if (this._stage) return;
    this.isDebug = isDebug;
    this._stage = stage;
    stage.eventMode = 'static';
    stage.hitArea = new Rectangle(0, 0, width, height);
    stage.on('globalpointermove', trackPointer);
    stage.on('pointerdown', trackPointer);
    this.resize(width, height);
  }

  resize(width: number, height: number): void {
    if (width === this._stageWidth && height === this._stageHeight) return;
    this._stageWidth = width;
    this._stageHeight = height;
    if (this._stage) this._stage.hitArea = new Rectangle(0, 0, width, height);
    this.dispatcher.dispatchEvent(new Event('resize'));
  }

  addEventListener(type: string, fn: (...a: any[]) => void, context?: unknown): void { this.dispatcher.on(type, fn, context); }
  removeEventListener(type: string, fn: (...a: any[]) => void, context?: unknown): void { this.dispatcher.off(type, fn, context); }
}

export const StageReferance = new StageReferanceClass();
