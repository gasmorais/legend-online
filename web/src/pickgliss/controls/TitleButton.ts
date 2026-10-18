import type { Bitmap } from '@/flash/display';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../ComponentFactory';
import { Component } from '../core/Component';
import type { FilterFrameText } from '../text/FilterFrameText';

export class TitleButton extends Component {
  private _titleText!: FilterFrameText;
  private _bgUp!: Bitmap;
  private _bgDown!: Bitmap;

  constructor() {
    super();
    this.initView();
  }

  private initView(): void {
    this._titleText = ComponentFactory.Instance.creatComponentByStylename('auction.ListTitleText');
    this._bgUp = ComponentFactory.Instance.creatBitmap('asset.auction.arrowsUp');
    this._bgDown = ComponentFactory.Instance.creatBitmap('asset.auction.arrowsDown');
    this.addChild(this._titleText);
    this._titleText.mouseEnabled = false;
    this._titleText.selectable = false;
    this.mouseEnabled = true;
    this.mouseChildren = true;
    this.addChild(this._bgUp);
    this.addChild(this._bgDown);
    this.setFrame = 0;
  }

  override get width(): number { return this._width; }
  override set width(v: number) {
    v = Number(v);
    if (this._titleText) {
      this._titleText.width = v;
      this._bgUp.x = v - 18;
      this._bgDown.x = v - 18;
    }
    super.width = v;
  }

  override get height(): number { return this._height; }
  override set height(v: number) {
    v = Number(v);
    if (this._titleText) {
      this._titleText.height = v;
      this._bgUp.y = 3;
      this._bgDown.y = 3;
    }
    super.height = v;
  }

  set setFrame(v: number) {
    v = Number(v) | 0;
    this._bgUp.visible = false;
    this._bgDown.visible = false;
    this.setTitleColor(1);
    if (v === 1) {
      this._bgDown.visible = true;
      this.setTitleColor(2);
    } else if (v === 2) {
      this._bgUp.visible = true;
      this.setTitleColor(2);
    }
  }

  private setTitleColor(kind: number): void {
    this._titleText.textColor = kind === 1 ? 16378053 : 15982868;
  }

  addMouseEffect(): void {
    this.on('pointerover', this.onMouseOver, this);
    this.on('pointerout', this.onMouseOut, this);
  }

  private onMouseOut(): void {
    if (!this._bgUp.visible && !this._bgDown.visible) this.setTitleColor(1);
  }

  private onMouseOver(): void {
    if (!this._bgUp.visible && !this._bgDown.visible) this.setTitleColor(2);
  }

  set text(v: string) { this._titleText.text = v; }
  get text(): string { return this._titleText?.text ?? ''; }

  override dispose(): void {
    this.off('pointerover', this.onMouseOver, this);
    this.off('pointerout', this.onMouseOut, this);
    super.dispose();
  }
}

Domain.registerClass('com.pickgliss.ui.controls.TitleButton', TitleButton);
