import { Graphics, type Container } from 'pixi.js';
import { listen } from '@/flash/events';
import { Domain } from '@/flash/library';
import { Sprite } from '@/flash/sprite';
import { ComponentSetting } from '../ComponentSetting';
import { Component } from '../core/Component';
import { changedPropertiesOf, InteractiveEvent } from '../events';
import { IntDimension, IntPoint, type IntRectangle } from '../geom/IntGeom';
import { disposeObject } from '../ObjectUtils';
import { rectShape, toBool, toInt } from '../utils/DisplayUtils';

export interface IViewprot extends Container {
  verticalUnitIncrement: number;
  verticalBlockIncrement: number;
  horizontalUnitIncrement: number;
  horizontalBlockIncrement: number;
  viewPosition: IntPoint;
  setViewportTestSize(d: IntDimension): void;
  getExtentSize(): IntDimension;
  getViewSize(): IntDimension;
  scrollRectToVisible(r: IntRectangle): void;
  addStateListener(fn: (...a: any[]) => void, priority?: number, useWeak?: boolean, context?: unknown): void;
  removeStateListener(fn: (...a: any[]) => void, context?: unknown): void;
  getViewportPane(): Component;
  dispose?(): void;
}

export class DisplayObjectViewport extends Component implements IViewprot {
  static readonly P_horizontalBlockIncrement = 'horizontalBlockIncrement';
  static readonly P_horizontalUnitIncrement = 'horizontalUnitIncrement';
  static readonly P_verticalBlockIncrement = 'verticalBlockIncrement';
  static readonly P_verticalUnitIncrement = 'verticalUnitIncrement';
  static readonly P_view = 'view';
  static readonly P_viewPosition = 'viewPosition';
  protected _horizontalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
  protected _horizontalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
  protected _maskShape!: Graphics;
  protected _mouseActiveObjectShape!: Graphics;
  protected _viewContainer!: Sprite;
  protected _viewPosition!: IntPoint;
  protected _verticalBlockIncrement = ComponentSetting.SCROLL_BLOCK_INCREMENT;
  protected _verticalUnitIncrement = ComponentSetting.SCROLL_UINT_INCREMENT;
  protected _viewHeight = 0;
  protected _viewWidth = 0;
  private _view: Container | null = null;
  private _isAllDirection = false;

  addStateListener(fn: (...a: any[]) => void, _priority = 0, _useWeak = false, context?: unknown): void {
    this.on(InteractiveEvent.STATE_CHANGED, fn, context);
  }

  removeStateListener(fn: (...a: any[]) => void, context?: unknown): void {
    this.off(InteractiveEvent.STATE_CHANGED, fn, context);
  }

  override dispose(): void {
    if (this._view instanceof Component) this._view.off('propertiesChanged', this.__onResize, this);
    disposeObject(this._view);
    this._view = null;
    if (this._mouseActiveObjectShape) this._mouseActiveObjectShape.destroy();
    if (this._maskShape) this._maskShape.destroy();
    super.dispose();
  }

  getExtentSize(): IntDimension { return new IntDimension(this._width, this._height); }
  getViewSize(): IntDimension { return new IntDimension(this._viewWidth, this._viewHeight); }
  getViewportPane(): Component { return this; }

  get isAllDirection(): boolean { return this._isAllDirection; }
  set isAllDirection(v: boolean) { this._isAllDirection = toBool(v); }

  get horizontalBlockIncrement(): number { return this._horizontalBlockIncrement; }
  set horizontalBlockIncrement(v: number) {
    v = toInt(v);
    if (this._horizontalBlockIncrement === v) return;
    this._horizontalBlockIncrement = v;
    this.onPropertiesChanged('horizontalBlockIncrement');
  }

  get horizontalUnitIncrement(): number { return this._horizontalUnitIncrement; }
  set horizontalUnitIncrement(v: number) {
    v = toInt(v);
    if (this._horizontalUnitIncrement === v) return;
    this._horizontalUnitIncrement = v;
    this.onPropertiesChanged('horizontalUnitIncrement');
  }

  scrollRectToVisible(r: IntRectangle): void { this.viewPosition = new IntPoint(r.x, r.y); }

  setView(view: Container | null): void {
    if (this._view === view) return;
    if (this._view instanceof Component) this._view.off('propertiesChanged', this.__onResize, this);
    if (this._view) disposeObject(view);
    this._view = view;
    if (this._view instanceof Component) listen(this._view, 'propertiesChanged', this.__onResize, this);
    this.onPropertiesChanged('view');
  }

  get view(): Container | null { return this._view; }

  setViewportTestSize(_d: IntDimension): void {}

  get verticalBlockIncrement(): number { return this._verticalBlockIncrement; }
  set verticalBlockIncrement(v: number) {
    v = toInt(v);
    if (this._verticalBlockIncrement === v) return;
    this._verticalBlockIncrement = v;
    this.onPropertiesChanged('verticalBlockIncrement');
  }

  get verticalUnitIncrement(): number { return this._verticalUnitIncrement; }
  set verticalUnitIncrement(v: number) {
    v = toInt(v);
    if (this._verticalUnitIncrement === v) return;
    this._verticalUnitIncrement = v;
    this.onPropertiesChanged('verticalUnitIncrement');
  }

  get viewPosition(): IntPoint { return this._viewPosition; }
  set viewPosition(p: IntPoint) {
    if (this._viewPosition.equals(p)) return;
    this._viewPosition.setLocation(p);
    this.onPropertiesChanged('viewPosition');
  }

  invalidateView(): void { this.onPropertiesChanged('view'); }

  protected override addChildren(): void {
    super.addChildren();
    this.addChild(this._mouseActiveObjectShape);
    this.addChild(this._maskShape);
    this.addChild(this._viewContainer);
  }

  protected creatMaskShape(): void {
    this._maskShape = rectShape(0xff0000, 1);
    this._mouseActiveObjectShape = rectShape(0xff0000, 0);
  }

  protected fireStateChanged(_programmatic = true): void {
    this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED));
  }

  protected getViewMaxPos(): IntPoint {
    const ext = this.getExtentSize();
    const view = this.getViewSize();
    const p = new IntPoint(view.width - ext.width, view.height - ext.height);
    if (p.x < 0) p.x = 0;
    if (p.y < 0) p.y = 0;
    return p;
  }

  protected override init(): void {
    this.creatMaskShape();
    this._viewContainer = new Sprite();
    this._viewPosition = new IntPoint(0, 0);
    this._viewContainer.mouseEnabled = false;
    this.eventMode = 'static';
    super.init();
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.height || ch.width) this.updateShowMask();
    if ((ch.view || ch.viewPosition) && this._view) {
      this._viewWidth = toInt(this._view.width);
      this._viewHeight = toInt(this._view.height);
      this._viewContainer.addChild(this._view);
      this._viewContainer.mask = this._maskShape;
      this.updatePos();
      this.fireStateChanged();
    }
  }

  protected restrictionViewPos(p: IntPoint): IntPoint {
    if (this._isAllDirection) return p;
    const max = this.getViewMaxPos();
    p.x = Math.max(0, Math.min(max.x, p.x));
    p.y = Math.max(0, Math.min(max.y, p.y));
    return p;
  }

  protected updatePos(): void {
    if (!this._view) return;
    this.restrictionViewPos(this._viewPosition);
    this._view.x = -this._viewPosition.x;
    this._view.y = -this._viewPosition.y;
  }

  protected updateShowMask(): void {
    this._mouseActiveObjectShape.width = this._maskShape.width = this._width;
    this._mouseActiveObjectShape.height = this._maskShape.height = this._height;
  }

  private __onResize(e: unknown): void {
    const cp = changedPropertiesOf(e);
    if (cp.height || cp.width) this.onPropertiesChanged('view');
  }
}

Domain.registerClass('com.pickgliss.ui.controls.DisplayObjectViewport', DisplayObjectViewport);
