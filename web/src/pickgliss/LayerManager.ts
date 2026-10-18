import { Container, Ticker } from 'pixi.js';
import { Sprite } from '@/flash/sprite';
import { Frame } from './controls/Frame';
import { StageReferance } from './toplevel/StageReferance';

export class SpriteLayer extends Sprite {
  private blackList: Container[] = [];
  private alphaList: Container[] = [];
  private _black: Sprite | null = null;
  private _alpha: Sprite | null = null;
  autoClickTotop = false;

  constructor(mouse = false) {
    super();
    this.eventMode = mouse ? 'static' : 'passive';
  }

  private ground(alpha: number): Sprite {
    const s = new Sprite();
    const w = StageReferance.stageWidth || 1000, h = StageReferance.stageHeight || 600;
    s.graphics.beginFill(0, alpha);
    s.graphics.drawRect(-1000, -500, w + 2000, h + 1000);
    s.graphics.endFill();
    s.eventMode = 'static';
    return s;
  }

  addTolayer(obj: Container, block: number, slot = 0): void {
    const list = block === 1 ? this.blackList : block === 2 ? this.alphaList : null;
    if (list) {
      const i = list.indexOf(obj);
      if (i !== -1) list.splice(i, 1);
      list.push(obj);
    }
    const onRemoved = () => {
      obj.off('removed', onRemoved);
      for (const l of [this.blackList, this.alphaList]) { const i = l.indexOf(obj); if (i !== -1) l.splice(i, 1); }
      LayerManager.Instance.settingMap.delete(obj);
      this.arrangeBlockGound();
    };
    obj.on('removed', onRemoved);
    if (this.autoClickTotop) obj.on('pointerdown', () => this.addToContainer(obj, 0));
    this.addToContainer(obj, slot);
    this.arrangeBlockGound();
  }

  protected addToContainer(obj: Container, _slot = 0): void { this.addChild(obj); }

  private arrangeBlockGound(): void {
    this._black?.parent?.removeChild(this._black);
    this._alpha?.parent?.removeChild(this._alpha);
    const lastBlack = this.blackList[this.blackList.length - 1];
    if (lastBlack && lastBlack.parent === this) {
      this._black ??= this.ground(0.6);
      this.addChildAt(this._black, this.getChildIndex(lastBlack));
    }
    const lastAlpha = this.alphaList[this.alphaList.length - 1];
    if (lastAlpha && lastAlpha.parent === this) {
      this._alpha ??= this.ground(0.001);
      this.addChildAt(this._alpha, this.getChildIndex(lastAlpha));
    }
  }

  onResize(): void {
    for (const c of this.children) {
      if (LayerManager.Instance.settingMap.get(c as Container)) {
        c.x = (StageReferance.stageWidth - c.width) / 2;
        c.y = (StageReferance.stageHeight - c.height) / 2;
      }
    }
  }
}

export class UISpriteLayer extends SpriteLayer {
  static UP_CONTAINER = 0;
  static RIGHT_CONTAINER = 1;
  static DOWN_CONTAINER = 2;
  static LEFT_CONTAINER = 3;
  readonly up = new SpriteLayer();
  readonly right = new SpriteLayer();
  readonly down = new SpriteLayer();
  readonly left = new SpriteLayer();

  constructor() {
    super();
    this.eventMode = 'passive';
    this.addChild(this.down, this.right, this.up, this.left);
  }

  protected override addToContainer(obj: Container, slot = 0): void {
    [this.up, this.right, this.down, this.left][slot]?.addChild(obj) ?? this.up.addChild(obj);
  }
}

class LayerManagerClass {
  static STAGE_TOP_LAYER = 0;
  static STAGE_DYANMIC_LAYER = 1;
  static GAME_TOP_LAYER = 2;
  static GAME_DYNAMIC_LAYER = 3;
  static GAME_UI_LAYER = 4;
  static GAME_BASE_LAYER = 5;
  static GAME_BOTTOM_LAYER = 6;
  static GAME_MENU_LAYER = 7;
  static STAGE_BOTTOM_LAYER = 8;
  static GAME_DYNAMIC_LAYER2 = 9;
  static NONE_BLOCKGOUND = 0;
  static BLCAK_BLOCKGOUND = 1;
  static ALPHA_BLOCKGOUND = 2;

  readonly settingMap = new Map<Container, boolean>();
  private layers: SpriteLayer[] = [];

  setup(stage: Container): void {
    const L = (mouse = false) => new SpriteLayer(mouse);
    const stageTop = L(), stageDynamic = L(), stageBottom = L();
    const gameTop = L(), gameDynamic = L(), gameDynamic2 = L(), gameMenu = L(), gameUI = new UISpriteLayer();
    const gameBase = L(), gameBottom = L();
    for (const l of [stageBottom, stageDynamic, stageTop]) stage.addChild(l);
    gameDynamic.autoClickTotop = true;
    stageBottom.addChild(gameBottom, gameBase, gameUI, gameDynamic, gameDynamic2, gameMenu, gameTop);
    this.layers = [stageTop, stageDynamic, gameTop, gameDynamic, gameUI, gameBase, gameBottom, gameMenu, stageBottom, gameDynamic2];
    for (const l of this.layers) l.label = `layer:${this.layers.indexOf(l)}`;
  }

  getLayerByType(type: number): SpriteLayer | null {
    if (type === 7) for (const c of [...this.layers[7].children]) (c as any).dispose?.() ?? c.destroy();
    return this.layers[type] ?? null;
  }

  cleanLayerByType(type: number): void {
    const l = this.layers[type];
    if (l) for (const c of [...l.children]) (c as any).dispose?.() ?? c.destroy();
  }

  centerToStage(obj: Container): void {
    const b = obj.getLocalBounds();
    const w = obj instanceof Frame ? obj.width : b.width * obj.scale.x;
    const h = obj instanceof Frame ? obj.height : b.height * obj.scale.y;
    obj.x = Math.round((StageReferance.gameStageWidth - w) / 2);
    obj.y = Math.round((StageReferance.gameStageHeight - h) / 2);
  }

  addToLayer(obj: Container, type: number, center = false, block = 0, keepCentered = false, slot = 0, _visibleSize = false,
    effect = 0): void {
    const layer = this.layers[type];
    if (!layer) return;
    this.settingMap.set(obj, keepCentered);
    if (center) this.centerToStage(obj);
    if (type === 7) {
      if (obj.x + obj.width > StageReferance.gameStageWidth) obj.x = StageReferance.gameStageWidth - obj.width;
      if (obj.y + obj.height > StageReferance.gameStageHeight) obj.y = StageReferance.gameStageHeight - obj.height;
    }
    layer.addTolayer(obj, block, slot);
    if (obj instanceof Frame || effect === 1) fadeIn(obj, 0.5);
  }

  onResize(): void { for (const l of this.layers) l.onResize(); }
}

function fadeIn(obj: Container, seconds: number): void {
  obj.alpha = 0;
  let t = 0;
  const tick = (tk: Ticker) => {
    t += tk.deltaMS / 1000;
    obj.alpha = Math.min(1, t / seconds);
    if (t >= seconds || obj.destroyed) Ticker.shared.remove(tick);
  };
  Ticker.shared.add(tick);
}

export const LayerManager = Object.assign(LayerManagerClass, { Instance: new LayerManagerClass() });
