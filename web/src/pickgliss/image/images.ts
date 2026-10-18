import { Container, NineSliceSprite, Rectangle, TilingSprite, Texture } from 'pixi.js';
import { Bitmap, MovieClip, setFlashFilters } from '@/flash/display';
import type { FlashFilterDef } from '@/flash/filters';
import { BitmapData, Domain } from '@/flash/library';
import { Sprite } from '@/flash/sprite';
import { ComponentFactory } from '../ComponentFactory';
import { parasArgs } from '../ComponentModel';
import { Component } from '../core/Component';
import { InnerRectangle } from '../geom/InnerRectangle';
import { disposeObject } from '../ObjectUtils';

function F() { return ComponentFactory.Instance; }

export class Image extends Component {
  static BITMAP_IMAGE = 1;
  static COMPONENT_IMAGE = 0;
  private _isFirst = true;
  protected _display!: Container | null;
  protected _filterString = '';
  protected _frameFilter: (FlashFilterDef[] | null)[] | null = null;
  protected _resourceLink = '';
  protected _scaleGridArgs: string[] | null = null;
  protected _scaleGridString = '';

  get display(): Container | null { return this._display; }

  override dispose(): void {
    disposeObject(this._display);
    this._display = null;
    this._frameFilter = null;
    super.dispose();
  }

  get filterString(): string { return this._filterString; }
  set filterString(v: string) {
    if (this._filterString === v) return;
    this._filterString = v;
    this.frameFilters = F().creatFrameFilters(v);
  }

  get frameFilters(): (FlashFilterDef[] | null)[] | null { return this._frameFilter; }
  set frameFilters(v: (FlashFilterDef[] | null)[] | null) {
    if (this._frameFilter === v) return;
    this._frameFilter = v;
    this.onPropertiesChanged('frameFilters');
  }

  get resourceLink(): string { return this._resourceLink; }
  set resourceLink(v: string) {
    if (v === this._resourceLink) return;
    this._resourceLink = v;
    this.onPropertiesChanged('resourceLink');
  }

  get scaleGridString(): string { return this._scaleGridString; }
  set scaleGridString(v: string) {
    if (v === this._scaleGridString) return;
    this._scaleGridString = v;
    this._scaleGridArgs = parasArgs(v);
    this.onPropertiesChanged('scale9Grid');
  }

  setFrame(frame: number): void {
    if (!this._frameFilter || frame <= 0 || frame > this._frameFilter.length) return;
    setFlashFilters(this, this._frameFilter[frame - 1]);
  }

  protected override addChildren(): void {
    if (this._display) this.addChild(this._display);
  }

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    if (this._changedPropeties.resourceLink) this.resetDisplay();
    this.updateSize();
    if (this._changedPropeties.scale9Grid) this.updateScale9Grid();
    if (this._changedPropeties.frameFilters || this._changedPropeties.resourceLink) this.setFilters();
  }

  protected resetDisplay(): void {
    if (this._display) this.removeChild(this._display);
    const made = F().creat(this._resourceLink);
    this._display = made instanceof BitmapData ? new Bitmap(made) : made;
  }

  protected setFilters(): void {
    if (this._frameFilter && this._display) setFlashFilters(this._display, this._frameFilter[0]);
  }

  protected updateScale9Grid(): void {
    const d = this._display;
    const a = this._scaleGridArgs;
    if (!(d instanceof ScaleBitmap) || !a) return;
    d.scale9Grid = new Rectangle(Number(a[0]), Number(a[1]), Number(a[2]) - Number(a[0]), Number(a[3]) - Number(a[1]));
  }

  protected updateSize(): void {
    const d = this._display;
    if (this._isFirst) {
      this._isFirst = false;
      if (this._width === 0 && d) { this._width = d.width; this._changedPropeties.height = true; }
      if (this._height === 0 && d) { this._height = d.height; this._changedPropeties.width = true; }
    }
    if (!d) return;
    if (this._changedPropeties.width) d.width = this._width;
    if (this._changedPropeties.height) d.height = this._height;
  }
}

export class ScaleBitmap extends Container {
  private nine: NineSliceSprite | null = null;
  private plain: Bitmap;
  private _w: number;
  private _h: number;
  private _grid: Rectangle | null = null;

  constructor(public readonly bitmapData: BitmapData) {
    super();
    this.plain = new Bitmap(bitmapData);
    this._w = bitmapData.width;
    this._h = bitmapData.height;
    this.addChild(this.plain);
  }

  get scale9Grid(): Rectangle | null { return this._grid; }
  set scale9Grid(r: Rectangle | null) {
    this._grid = r;
    if (!r) return;
    if (!this.bitmapData.loaded) {
      this.bitmapData.ready.then(() => { if (!this.destroyed && this._grid === r) this.scale9Grid = r; });
      return;
    }
    this.nine?.destroy();
    const tex = this.bitmapData.texture;
    const bw = this.bitmapData.width, bh = this.bitmapData.height;
    this.nine = new NineSliceSprite({
      texture: tex,
      leftWidth: r.x, topHeight: r.y, rightWidth: bw - (r.x + r.width), bottomHeight: bh - (r.y + r.height),
      width: this._w, height: this._h,
    });
    this.removeChildren();
    this.addChild(this.nine);
  }

  override get width(): number { return this._w; }
  override set width(v: number) {
    this._w = Number(v);
    if (this.nine) this.nine.width = this._w; else this.plain.width = this._w;
  }

  override get height(): number { return this._h; }
  override set height(v: number) {
    this._h = Number(v);
    if (this.nine) this.nine.height = this._h; else this.plain.height = this._h;
  }
}

export class ScaleBitmapImage extends Image {
  protected override resetDisplay(): void {
    disposeObject(this._display);
    if (this._display) this.removeChild(this._display);
    const bd = Domain.createInstance<BitmapData>(this._resourceLink, [this._width, this._height]);
    this._display = new ScaleBitmap(bd);
  }
}

export class MutipleImage extends Image {
  static P_imageRect = 'imagesRect';
  private _imageLinks: string[] = [];
  private _imageRectString = '';
  private _images: Container[] | null = null;
  private _imagesRect: (InnerRectangle | null)[] | null = null;

  protected override init(): void {
    this._display = new Sprite();
    super.init();
  }

  get imageRectString(): string { return this._imageRectString; }
  set imageRectString(v: string) {
    if (this._imageRectString === v) return;
    this._imageRectString = v;
    this._imagesRect = parasArgs(v).map((s) => (s === '' ? null : new InnerRectangle(...s.split('|'))));
    this.onPropertiesChanged('imagesRect');
  }

  protected override addChildren(): void {
    super.addChildren();
    if (!this._images) return;
    for (const img of this._images) (this._display as Container).addChild(img);
  }

  protected override resetDisplay(): void {
    if (!this._display) this._display = new Sprite();
    this._imageLinks = parasArgs(this._resourceLink);
    this.removeImages();
    this._images = this._imageLinks.map((l) => {
      const made = F().creat(l.split('|')[0]);
      return made instanceof BitmapData ? new Bitmap(made) : made;
    });
  }

  protected override updateSize(): void {
    if (!this._images) return;
    if (this._changedPropeties.width || this._changedPropeties.height || this._changedPropeties.imagesRect) {
      this._images.forEach((img, i) => {
        const r = this._imagesRect?.[i];
        if (r) {
          const rect = r.getInnerRect(this._width, this._height);
          img.x = rect.x;
          img.y = rect.y;
          if (rect.height > 0) img.height = rect.height;
          if (rect.width > 0) img.width = rect.width;
        } else {
          img.width = this._width;
          img.height = this._height;
        }
      });
    }
  }

  private removeImages(): void {
    for (const img of this._images ?? []) { img.parent?.removeChild(img); disposeObject(img); }
    this._images = null;
  }

  setChildVisible(i: number, v: boolean): void { if (this._images?.[i]) this._images[i].visible = v; }
  setChildSize(i: number, w: number, h: number): void { const o = this._images?.[i]; if (o) { o.width = w; o.height = h; } }
  setChildPos(i: number, x: number, y: number): void { const o = this._images?.[i]; if (o) { o.x = x; o.y = y; } }
  showImg(i: number): void {
    if (i === -1) return;
    for (const o of this._images ?? []) o.visible = false;
    if (this._images?.[i]) this._images[i].visible = true;
  }
  get images(): Container[] { return this._images ?? []; }
}

export class ScaleFrameImage extends Image {
  static P_fillAlphaRect = 'fillAlphaRect';
  private _autoHCenter = false;
  private _autoVCenter = false;
  private _flag: boolean;
  private _currentFrame = 0;
  private _fillAlphaRect = false;
  private _imageLinks: string[] = [];
  private _images: (Container | null)[] | null = null;

  constructor(flag: unknown = false) {
    super();
    this._flag = flag === true || flag === 'true';
  }

  get fillAlphaRect(): boolean { return this._fillAlphaRect; }
  set fillAlphaRect(v: boolean) { if (this._fillAlphaRect === v) return; this._fillAlphaRect = v; this.onPropertiesChanged('fillAlphaRect'); }
  get autoVCenter(): boolean { return this._autoVCenter; }
  set autoVCenter(v: boolean) { if (this._autoVCenter === v) return; this._autoVCenter = v; this.onPropertiesChanged('autoVCenter'); }
  get autoHCenter(): boolean { return this._autoHCenter; }
  set autoHCenter(v: boolean) { if (this._autoHCenter === v) return; this._autoHCenter = v; this.onPropertiesChanged('autoHCenter'); }
  get currentFrame(): number { return this._currentFrame; }

  override setFrame(frame: number): void {
    if (!this._images) return;
    super.setFrame(frame);
    this._currentFrame = frame;
    this._images.forEach((img, i) => {
      if (!img) return;
      if (this._autoHCenter) img.x = -img.width * 0.5;
      if (this._autoVCenter) img.y = -img.height * 0.5;
      const on = frame - 1 === i;
      img.visible = on;
      const mc = img instanceof MovieClip ? img : img instanceof MovieImage ? img.movie : null;
      if (mc) { if (on) mc.play(); else mc.gotoAndStop(1); }
    });
    if (this._fillAlphaRect) {
      this.graphics.clear();
      this.graphics.beginFill(0xff00ff, 0);
      this.graphics.drawRect(0, 0, this._width, this._height);
    }
  }

  protected override resetDisplay(): void {
    this._imageLinks = parasArgs(this._resourceLink);
    for (const img of this._images ?? []) img?.parent?.removeChild(img);
    this._images = this._imageLinks.map((l) => {
      if (!l) return null;
      const made = F().creat(l);
      const img: Container = made instanceof BitmapData ? new Bitmap(made) : made;
      this._width = Math.max(this._width, img.width);
      this._height = Math.max(this._height, img.height);
      this.addChild(img);
      return img;
    });
  }

  protected override addChildren(): void {
  }

  protected override updateSize(): void {
    if (!this._images || this._flag) return;
    if (this._changedPropeties.width || this._changedPropeties.height) {
      for (const img of this._images) if (img) { img.width = this._width; img.height = this._height; }
    }
    const cur = this._images[this._currentFrame - 1];
    if (cur && this._autoHCenter) cur.x = -cur.width * 0.5;
    if (cur && this._autoVCenter) cur.y = -cur.height * 0.5;
  }

  getFrameImage(i: number): Container | null { return this._images?.[i] ?? null; }
  get totalFrames(): number { return this._images?.length ?? 0; }
}

function bitmapOf(made: unknown): BitmapData {
  if (made instanceof BitmapData) return made;
  if (made instanceof Bitmap && made.bitmapData) return made.bitmapData;
  return new BitmapData(Texture.EMPTY, 0, 0);
}

function tile(bd: BitmapData, x: number, y: number, w: number, h: number, ox = 0, oy = 0): TilingSprite {
  const t = new TilingSprite({ texture: bd.texture, width: Math.max(0, w), height: Math.max(0, h) });
  t.position.set(x, y);
  t.tilePosition.set(ox - x, oy - y);
  if (!bd.loaded) bd.ready.then((tex) => { if (!t.destroyed) t.texture = tex; });
  return t;
}

export class Scale9CornerImage extends Image {
  private _imageLinks: string[] = [];
  private _bd!: BitmapData[];
  private _corners!: Bitmap[];
  private _fills!: Container;

  protected override init(): void {
    this._bd = [];
    this._corners = [];
    this._fills = new Container();
    super.init();
  }

  protected override addChildren(): void {
    if (!this._corners?.length) return;
    this.addChild(this._fills);
    for (const i of [0, 1, 2, 3]) this.addChild(this._corners[i]);
  }

  protected override resetDisplay(): void {
    this._imageLinks = parasArgs(this._resourceLink);
    this._bd = this._imageLinks.map((l) => bitmapOf(F().creat(l)));
    this._corners = [0, 2, 6, 8].map((i) => new Bitmap(this._bd[i]));
  }

  protected override updateSize(): void {
    if ((this._changedPropeties.width || this._changedPropeties.height) && this._bd.length >= 9) this.drawImage();
  }

  private drawImage(): void {
    const b = this._bd, W = this._width, H = this._height;
    this._fills.removeChildren().forEach((c) => c.destroy());
    this._fills.addChild(
      tile(b[1], b[0].width, 0, W - b[0].width - b[2].width, b[1].height, b[0].width, 0),
      tile(b[3], 0, b[0].height, b[3].width, H - b[0].height - b[6].height, 0, b[0].height),
      tile(b[5], W - b[5].width, b[2].height, b[5].width, H - b[2].height - b[8].height, W - b[5].width, b[2].height),
      tile(b[7], b[6].width, H - b[7].height, W - b[6].width - b[8].width, b[7].height, b[6].width, H - b[7].height),
      tile(b[4], b[0].width, b[0].height, W - b[0].width - b[2].width, H - b[0].height - b[6].height, b[0].width, b[0].height),
    );
    const [c0, c2, c6, c8] = this._corners;
    c0.position.set(0, 0);
    c2.position.set(W - c2.width, 0);
    c6.position.set(0, H - c6.height);
    c8.position.set(W - c8.width, H - c8.height);
  }
}

export class ScaleLeftRightImage extends Image {
  protected _bd!: BitmapData[];
  protected _bitmaps!: Bitmap[];
  protected _fill!: TilingSprite | null;

  protected override init(): void {
    this._bd = [];
    this._bitmaps = [];
    this._fill = null;
    super.init();
  }

  protected override addChildren(): void {
    if (!this._bitmaps?.length) return;
    if (this._fill) this.addChild(this._fill);
    this.addChild(this._bitmaps[0]);
    this.addChild(this._bitmaps[2]);
  }

  protected override resetDisplay(): void {
    this._bd = parasArgs(this._resourceLink).map((l) => bitmapOf(F().creat(l)));
    this._bitmaps = this._bd.map((bd) => new Bitmap(bd));
  }

  protected override updateSize(): void {
    if (this._changedPropeties.width || this._changedPropeties.height) this.drawImage();
  }

  protected drawImage(): void {
    if (this._bd.length < 3) return;
    const [l, , r] = this._bitmaps;
    this._fill?.destroy();
    const lw = Math.trunc(l.width);
    this._fill = tile(this._bd[1], lw, 0, Math.trunc(this._width - l.width - r.width), this._height, 0, 0);
    this.addChildAt(this._fill, 0);
    r.x = Math.trunc(this._width - r.width);
    l.y = r.y = 0;
  }
}

export class ScaleUpDownImage extends ScaleLeftRightImage {
  protected override drawImage(): void {
    if (this._bd.length < 3) return;
    const [t, , b] = this._bitmaps;
    this._fill?.destroy();
    this._fill = tile(this._bd[1], 0, Math.trunc(t.height), this._width, Math.trunc(this._height - t.height - b.height), 0, 0);
    this.addChildAt(this._fill, 0);
    b.y = Math.trunc(this._height - b.height);
    t.x = b.x = 0;
  }
}

export class MovieImage extends Image {
  get movie(): MovieClip { return this._display as MovieClip; }
}

const NS = 'com.pickgliss.ui.image.';
Domain.registerClass(NS + 'Image', Image);
Domain.registerClass(NS + 'ScaleBitmapImage', ScaleBitmapImage);
Domain.registerClass(NS + 'MutipleImage', MutipleImage);
Domain.registerClass(NS + 'ScaleFrameImage', ScaleFrameImage);
Domain.registerClass(NS + 'Scale9CornerImage', Scale9CornerImage);
Domain.registerClass(NS + 'ScaleLeftRightImage', ScaleLeftRightImage);
Domain.registerClass(NS + 'ScaleUpDownImage', ScaleUpDownImage);
Domain.registerClass(NS + 'MovieImage', MovieImage);
