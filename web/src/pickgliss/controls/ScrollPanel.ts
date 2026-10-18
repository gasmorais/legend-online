import type { Container, FederatedWheelEvent, Rectangle } from 'pixi.js';
import { listen, wheelDelta } from '@/flash/events';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { Component } from '../core/Component';
import { InnerRectangle } from '../geom/InnerRectangle';
import { IntDimension, IntPoint, IntRectangle } from '../geom/IntGeom';
import { disposeObject } from '../ObjectUtils';
import { DisplayUtils, toInt, unionRect } from '../utils/DisplayUtils';
import { DisplayObjectViewport, type IViewprot } from './DisplayObjectViewport';
import type { Scrollbar } from './Scrollbar';

export class ScrollPanel extends Component {
  static readonly AUTO = 1;
  static readonly OFF = 2;
  static readonly ON = 0;
  static readonly P_backgound = 'backgound';
  static readonly P_backgoundInnerRect = 'backgoundInnerRect';
  static readonly P_hScrollProxy = 'hScrollProxy';
  static readonly P_hScrollbar = 'vScrollbar';
  static readonly P_hScrollbarInnerRect = 'hScrollbarInnerRect';
  static readonly P_vScrollProxy = 'vScrollProxy';
  static readonly P_vScrollbar = 'vScrollbar';
  static readonly P_vScrollbarInnerRect = 'vScrollbarInnerRect';
  static readonly P_viewSource = 'viewSource';
  static readonly P_viewportInnerRect = 'viewportInnerRect';
  protected _backgound: Container | null = null;
  protected _backgoundInnerRect: InnerRectangle | null = null;
  protected _backgoundInnerRectString = '';
  protected _backgoundStyle = '';
  protected _hScrollProxy = 0;
  protected _hScrollbar: Scrollbar | null = null;
  protected _hScrollbarInnerRect: InnerRectangle | null = null;
  protected _hScrollbarInnerRectString = '';
  protected _hScrollbarStyle = '';
  protected _vScrollProxy = 0;
  protected _vScrollbar: Scrollbar | null = null;
  protected _vScrollbarInnerRect: InnerRectangle | null = null;
  protected _vScrollbarInnerRectString = '';
  protected _vScrollbarStyle = '';
  protected _viewSource: IViewprot | null = null;
  protected _viewportInnerRect: InnerRectangle | null = null;
  protected _viewportInnerRectString = '';

  constructor(createViewport: unknown = true) {
    super();
    if (createViewport === true || createViewport === 'true') {
      this._viewSource = new DisplayObjectViewport();
      this._viewSource.addStateListener(this.__onViewportStateChanged, 0, false, this);
    }
  }

  get backgound(): Container | null { return this._backgound; }
  set backgound(v: Container | null) {
    if (this._backgound === v) return;
    if (this._backgound) disposeObject(this._backgound);
    this._backgound = v;
    this.onPropertiesChanged('backgound');
  }

  get backgoundInnerRectString(): string { return this._backgoundInnerRectString; }
  set backgoundInnerRectString(v: string) {
    if (this._backgoundInnerRectString === v) return;
    this._backgoundInnerRectString = v;
    this._backgoundInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('backgoundInnerRect');
  }

  get backgoundStyle(): string { return this._backgoundStyle; }
  set backgoundStyle(v: string) {
    if (this._backgoundStyle === v) return;
    this._backgoundStyle = v;
    this.backgound = ComponentFactory.Instance.creat(this._backgoundStyle);
  }

  get displayObjectViewport(): DisplayObjectViewport {
    return this._viewSource as DisplayObjectViewport;
  }

  override dispose(): void {
    if (this._vScrollbar) {
      this._vScrollbar.removeStateListener(this.__onScrollValueChange, this);
      disposeObject(this._vScrollbar);
    }
    this._vScrollbar = null;
    if (this._hScrollbar) {
      this._hScrollbar.removeStateListener(this.__onScrollValueChange, this);
      disposeObject(this._hScrollbar);
    }
    this._hScrollbar = null;
    if (this._backgound) disposeObject(this._backgound);
    this._backgound = null;
    if (this._viewSource) disposeObject(this._viewSource);
    this._viewSource = null;
    this.off('wheel', this.__onMouseWheel, this);
    super.dispose();
  }

  getShowHScrollbarExtendHeight(): number {
    if (this._height === 0 || !this._hScrollbarInnerRect || !this._viewportInnerRect) return 0;
    const vr = this._viewportInnerRect.getInnerRect(this._width, this._height);
    const hr = this._hScrollbarInnerRect.getInnerRect(this._width, this._height);
    const u = unionRect(vr, hr);
    return vr.height - u.height;
  }

  getVisibleRect(): IntRectangle {
    const size = this._viewSource!.getViewSize();
    let x: number, w: number, y: number, h: number;
    if (!this._hScrollbar) { x = 0; w = size.width; } else { x = this._hScrollbar.scrollValue; w = this._hScrollbar.visibleAmount; }
    if (!this._vScrollbar) { y = 0; h = size.height; } else { y = this._vScrollbar.scrollValue; h = this._vScrollbar.visibleAmount; }
    return new IntRectangle(x, y, w, h);
  }

  get hScrollProxy(): number { return this._hScrollProxy; }
  set hScrollProxy(v: number) {
    v = toInt(v);
    if (this._hScrollProxy === v) return;
    this._hScrollProxy = v;
    this.onPropertiesChanged('hScrollProxy');
  }

  get hScrollbar(): Scrollbar | null { return this._hScrollbar; }
  set hScrollbar(v: Scrollbar | null) {
    if (this._hScrollbar === v) return;
    if (this._hScrollbar) {
      this._hScrollbar.removeStateListener(this.__onScrollValueChange, this);
      disposeObject(this._hScrollbar);
    }
    this._hScrollbar = v;
    this._hScrollbar?.addStateListener(this.__onScrollValueChange, 0, false, this);
    this.onPropertiesChanged('vScrollbar');
  }

  get hScrollbarInnerRectString(): string { return this._hScrollbarInnerRectString; }
  set hScrollbarInnerRectString(v: string) {
    if (this._hScrollbarInnerRectString === v) return;
    this._hScrollbarInnerRectString = v;
    this._hScrollbarInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('hScrollbarInnerRect');
  }

  get hScrollbarStyle(): string { return this._hScrollbarStyle; }
  set hScrollbarStyle(v: string) {
    if (this._hScrollbarStyle === v) return;
    this._hScrollbarStyle = v;
    this.hScrollbar = ComponentFactory.Instance.creat(this._hScrollbarStyle);
  }

  get hUnitIncrement(): number { return this._viewSource?.horizontalUnitIncrement ?? 0; }
  set hUnitIncrement(v: number) { if (this._viewSource) this._viewSource.horizontalUnitIncrement = toInt(v); }

  invalidateViewport(toBottom = false): void {
    if (this._viewSource instanceof DisplayObjectViewport) {
      this.displayObjectViewport.invalidateView();
      if (toBottom) {
        const h = this.viewPort!.getViewSize().height;
        this.viewPort!.viewPosition = new IntPoint(0, h);
      }
    }
  }

  setView(view: Container, disableMouse = false): void {
    if (this._viewSource instanceof DisplayObjectViewport) {
      this.displayObjectViewport.setView(view);
      if (disableMouse) this.displayObjectViewport.mouseEnabled = false;
    }
  }

  get vScrollProxy(): number { return this._vScrollProxy; }
  set vScrollProxy(v: number) {
    v = toInt(v);
    if (this._vScrollProxy === v) return;
    this._vScrollProxy = v;
    this.onPropertiesChanged('vScrollProxy');
  }

  get vScrollbar(): Scrollbar | null { return this._vScrollbar; }
  set vScrollbar(v: Scrollbar | null) {
    if (this._vScrollbar === v) return;
    if (this._vScrollbar) {
      this._vScrollbar.removeStateListener(this.__onScrollValueChange, this);
      disposeObject(this._vScrollbar);
    }
    this._vScrollbar = v;
    this._vScrollbar?.addStateListener(this.__onScrollValueChange, 0, false, this);
    this.onPropertiesChanged('vScrollbar');
  }

  get vScrollbarInnerRectString(): string { return this._vScrollbarInnerRectString; }
  set vScrollbarInnerRectString(v: string) {
    if (this._vScrollbarInnerRectString === v) return;
    this._vScrollbarInnerRectString = v;
    this._vScrollbarInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('vScrollbarInnerRect');
  }

  get vScrollbarStyle(): string { return this._vScrollbarStyle; }
  set vScrollbarStyle(v: string) {
    if (this._vScrollbarStyle === v) return;
    this._vScrollbarStyle = v;
    this.vScrollbar = ComponentFactory.Instance.creat(this._vScrollbarStyle);
  }

  get vUnitIncrement(): number { return this._viewSource?.verticalUnitIncrement ?? 0; }
  set vUnitIncrement(v: number) { if (this._viewSource) this._viewSource.verticalUnitIncrement = toInt(v); }

  get viewPort(): IViewprot | null { return this._viewSource; }
  set viewPort(v: IViewprot | null) {
    if (this._viewSource === v) return;
    if (this._viewSource) {
      this._viewSource.removeStateListener(this.__onViewportStateChanged, this);
      disposeObject(this._viewSource);
    }
    this._viewSource = v;
    this._viewSource?.addStateListener(this.__onViewportStateChanged, 0, false, this);
    this.onPropertiesChanged('viewSource');
  }

  get viewportInnerRectString(): string { return this._viewportInnerRectString; }
  set viewportInnerRectString(v: string) {
    if (this._viewportInnerRectString === v) return;
    this._viewportInnerRectString = v;
    this._viewportInnerRect = InnerRectangle.parse(v);
    this.onPropertiesChanged('viewportInnerRect');
  }

  protected __onMouseWheel(e: FederatedWheelEvent): void {
    if (!this._viewSource) return;
    const p = this._viewSource.viewPosition.clone();
    p.y -= wheelDelta(e) * this._viewSource.verticalUnitIncrement;
    this._viewSource.viewPosition = p;
  }

  scrollToTop(): void {
    if (this._viewSource) this._viewSource.viewPosition = new IntPoint();
  }

  protected __onScrollValueChange(): void {
    this.viewPort?.scrollRectToVisible(this.getVisibleRect());
  }

  protected __onViewportStateChanged(): void { this.syncScrollPaneWithViewport(); }

  protected override addChildren(): void {
    super.addChildren();
    if (this._backgound) this.addChild(this._backgound);
    if (this._viewSource) this.addChild(this._viewSource);
    if (this._vScrollbar) this.addChild(this._vScrollbar);
    if (this._hScrollbar) this.addChild(this._hScrollbar);
  }

  protected override init(): void {
    this.eventMode = 'static';
    this.initEvent();
    super.init();
  }

  protected initEvent(): void { listen(this, 'wheel', this.__onMouseWheel, this); }

  protected layoutComponent(): void {
    if (this._vScrollbar) DisplayUtils.layoutDisplayWithInnerRect(this._vScrollbar, this._vScrollbarInnerRect, this._width, this._height);
    if (this._hScrollbar) DisplayUtils.layoutDisplayWithInnerRect(this._hScrollbar, this._hScrollbarInnerRect, this._width, this._height);
    if (this._backgound) DisplayUtils.layoutDisplayWithInnerRect(this._backgound, this._backgoundInnerRect, this._width, this._height);
    if (this._viewSource) DisplayUtils.layoutDisplayWithInnerRect(this._viewSource, this._viewportInnerRect, this._width, this._height);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    const ch = this._changedPropeties;
    if (ch.height || ch.width || ch.vScrollbarInnerRect || ch.hScrollbarInnerRect || ch.vScrollbar || ch.viewportInnerRect || ch.viewSource) {
      this.layoutComponent();
    }
    if (ch.viewSource) this.syncScrollPaneWithViewport();
    if (ch.vScrollProxy || ch.hScrollProxy) {
      if (this._vScrollbar) this._vScrollbar.visible = this._vScrollProxy === 0;
      if (this._hScrollbar) this._hScrollbar.visible = this._hScrollProxy === 0;
    }
  }

  protected syncScrollPaneWithViewport(): void {
    const vs = this._viewSource;
    if (!vs) return;
    const ext: IntDimension = vs.getExtentSize();
    if (ext.width <= 0 || ext.height <= 0) return;
    const size = vs.getViewSize();
    const pos = vs.viewPosition;
    if (this._vScrollbar) {
      const extent = ext.height, max = size.height;
      const value = Math.max(0, Math.min(pos.y, max - extent));
      this._vScrollbar.unitIncrement = vs.verticalUnitIncrement;
      this._vScrollbar.blockIncrement = vs.verticalBlockIncrement;
      this._vScrollbar.getModel().setRangeProperties(value, extent, 0, max, false);
    }
    if (this._hScrollbar) {
      const extent = ext.width, max = size.width;
      const value = Math.max(0, Math.min(pos.x, max - extent));
      this._hScrollbar.unitIncrement = vs.horizontalUnitIncrement;
      this._hScrollbar.blockIncrement = vs.horizontalBlockIncrement;
      this._hScrollbar.getModel().setRangeProperties(value, extent, 0, max, false);
    }
    this.updateAutoHiddenScroll();
  }

  private updateAutoHiddenScroll(): void {
    const v = this._vScrollbar, h = this._hScrollbar;
    if (!v && !h) return;
    if (v) {
      if (this._vScrollProxy === 1) v.visible = v.getThumbVisible();
      if (this._vScrollProxy === 1 && v.maximum === 0) v.visible = false;
    }
    if (h) {
      if (this._hScrollProxy === 1) h.visible = h.getThumbVisible();
      if (this._hScrollProxy === 1 && h.maximum === 0) h.visible = false;
    }
    if ((this._vScrollProxy === 1 || this._hScrollProxy === 1) && this._viewportInnerRect && this._viewSource) {
      const vr = this._viewportInnerRect.getInnerRect(this._width, this._height);
      const vsr = this._vScrollbarInnerRect?.getInnerRect(this._width, this._height) ?? null;
      const hsr = this._hScrollbarInnerRect?.getInnerRect(this._width, this._height) ?? null;
      let r: Rectangle | null = null;
      if (v && (!v.getThumbVisible() || !v.visible)) r = unionRect(vr, vsr);
      if (h && (!h.getThumbVisible() || !h.visible)) r = r ? unionRect(r, hsr) : unionRect(vr, hsr);
      if (!r) r = vr;
      this._viewSource.x = r.x;
      this._viewSource.y = r.y;
      this._viewSource.width = r.width;
      this._viewSource.height = r.height;
    }
  }
}

Domain.registerClass('com.pickgliss.ui.controls.ScrollPanel', ScrollPanel);
