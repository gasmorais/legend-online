import { Graphics, type Container, type ContainerChild } from 'pixi.js';
import { listen } from '@/flash/events';
import { Domain } from '@/flash/library';
import { Component } from '../../core/Component';
import { changedPropertiesOf } from '../../events';
import { disposeAllChildren, toBool, toNum } from '../../utils/DisplayUtils';

export class BoxContainer extends Component {
  static readonly P_childRefresh = 'childRefresh';
  static readonly P_childResize = 'childResize';
  static readonly P_isReverAdd = 'isReverAdd';
  static readonly P_spacing = 'spacing';
  static readonly P_strictWidth = 'strictWidth';
  static readonly P_strictHeight = 'strictHeight';
  static readonly P_direction = 'direction';
  protected _childrenList: Container[] | null = [];
  protected _isReverAdd = false;
  protected _spacing = 0;
  protected _strictWidth = -1;
  protected _strictHeight = -1;
  protected _direction = -1;

  protected override init(): void {
    this.eventMode = 'static';
    super.init();
  }

  override addChild<U extends ContainerChild[]>(...children: U): U[0] {
    for (const c of children) this.addOneChild(c as Container);
    return children[0];
  }

  protected addOneChild(child: Container): Container | null {
    if (child instanceof Graphics || !this._childrenList) return child instanceof Graphics ? super.addChild(child) : null;
    if (this._childrenList.indexOf(child) >= 0) return null;
    if (!this._isReverAdd) this._childrenList.push(super.addChild(child));
    else this._childrenList.unshift(super.addChildAt(child, 0));
    listen(child, 'propertiesChanged', this.__onResize, this);
    this.onPropertiesChanged('childRefresh');
    return child;
  }

  override addChildAt<U extends ContainerChild>(child: U, index: number): U {
    if (child instanceof Graphics || !this._childrenList) return super.addChildAt(child, index);
    const list = this._childrenList;
    const at = list.indexOf(child as Container);
    if (at >= 0) list.splice(at, 1);
    list.splice(index, 0, super.addChildAt(child, index) as Container);
    listen(child as Container, 'propertiesChanged', this.__onResize, this);
    this.onPropertiesChanged('childRefresh');
    return child;
  }

  override dispose(): void {
    this.removeAllEvent();
    super.dispose();
    this._childrenList = null;
  }

  removeAllChild(): void {
    while (this.children.length > 0) {
      const c = this.children[0];
      this.removeChild(c);
      c.x = 0;
      c.off('propertiesChanged', this.__onResize, this);
    }
  }

  protected refreshDirection(_child: Container): void {}

  disposeAllChildren(): void {
    this.removeAllEvent();
    disposeAllChildren(this);
  }

  get isReverAdd(): boolean { return this._isReverAdd; }
  set isReverAdd(v: boolean) {
    v = toBool(v);
    if (this._isReverAdd === v) return;
    this._isReverAdd = v;
    this.onPropertiesChanged('isReverAdd');
  }

  removeAllEvent(): void {
    for (const c of this.children) c.off('propertiesChanged', this.__onResize, this);
  }

  refreshChildPos(): void { this.onPropertiesChanged('childResize'); }

  override removeChild<U extends ContainerChild[]>(...children: U): U[0] {
    for (const c of children) this.removeOneChild(c as Container);
    return children[0];
  }

  protected removeOneChild(child: Container): Container | null {
    if (child instanceof Graphics) return super.removeChild(child);
    if (!this._childrenList) {
      super.removeChild(child);
      return null;
    }
    child.off('propertiesChanged', this.__onResize, this);
    const i = this._childrenList.indexOf(child);
    if (i >= 0) this._childrenList.splice(i, 1);
    super.removeChild(child);
    this.onPropertiesChanged('childRefresh');
    return child;
  }

  override removeChildren(beginIndex = 0, endIndex?: number): ContainerChild[] {
    const removed = super.removeChildren(beginIndex, endIndex);
    let changed = false;
    for (const c of removed) {
      if (c instanceof Graphics) continue;
      c.off('propertiesChanged', this.__onResize, this);
      const i = this._childrenList?.indexOf(c as Container) ?? -1;
      if (i >= 0) this._childrenList!.splice(i, 1);
      changed = true;
    }
    if (changed) this.onPropertiesChanged('childRefresh');
    return removed;
  }

  override removeChildAt<U extends ContainerChild>(index: number): U {
    const c = this.getChildAt(index) as U;
    this.removeChild(c);
    return c;
  }

  reverChildren(): void {
    const tmp: Container[] = [];
    while (this.children.length > 0) tmp.push(this.removeChildAt(0));
    for (const c of tmp) this.addChild(c);
  }

  get spacing(): number { return this._spacing; }
  set spacing(v: number) {
    v = toNum(v);
    if (this._spacing === v) return;
    this._spacing = v;
    this.onPropertiesChanged('spacing');
  }

  get strictWidth(): number { return this._strictWidth; }
  set strictWidth(v: number) {
    v = toNum(v);
    if (this._strictWidth === v) return;
    this._strictWidth = v;
    this.onPropertiesChanged('strictWidth');
  }

  get strictHeight(): number { return this._strictHeight; }
  set strictHeight(v: number) {
    v = toNum(v);
    if (this._strictHeight === v) return;
    this._strictHeight = v;
    this.onPropertiesChanged('strictHeight');
  }

  get direction(): number { return this._direction; }
  set direction(v: number) {
    v = toNum(v);
    if (this._direction === v) return;
    this._direction = v;
    this.onPropertiesChanged('direction');
  }

  arrange(): void {}

  protected get isStrictWidth(): boolean { return this._strictWidth > 0; }
  protected set isStrictWidth(_v: boolean) {}
  protected get isStrictHeight(): boolean { return this._strictHeight > 0; }
  protected set isStrictHeight(_v: boolean) {}

  protected override onProppertiesUpdate(): void { this.arrange(); }

  protected __onResize(e: unknown): void {
    const cp = changedPropertiesOf(e);
    if (cp.height || cp.width) this.onPropertiesChanged('childRefresh');
  }
}

Domain.registerClass('com.pickgliss.ui.controls.container.BoxContainer', BoxContainer);
