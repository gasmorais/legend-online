import { Application, Container, Rectangle } from 'pixi.js';
import { Bitmap, MovieClip } from '@/flash/display';
import { BitmapData, Domain } from '@/flash/library';
import { TextField } from '@/flash/text';
import { ComponentFactory } from '@/pickgliss/ComponentFactory';
import { LayerManager } from '@/pickgliss/LayerManager';
import { StageReferance } from '@/pickgliss/toplevel/StageReferance';
import { GameClasses, instanceVars, RuntimeOptions } from '@/game/GameClasses';
import { FrameOpener } from './FrameOpener';

const F = () => ComponentFactory.Instance;

export function child(root: Container | null | undefined, path: string): any {
  let cur: any = root;
  for (const part of path.split('.')) {
    if (!cur) return null;
    cur = cur instanceof MovieClip ? cur.getChildByName(part) : cur.getChildByName?.(part) ?? cur[part];
  }
  return cur;
}

const STARTUP_LIBS = ['core', 'core2', 'common', 'smallmap', 'resourcesbar', 'maintoolbar', 'tasktracebar', 'toptoolbar',
  'framebg', 'chat', 'queuebar', 'castlemap1', 'castle'];
const STARTUP_STYLES = ['resourcesbar.xml', 'smallmap.xml', 'maintoolbar.xml', 'tasktracebar.xml', 'toptoolbar.xml',
  'chat.xml', 'queuebar.xml', 'castle.xml', 'framebg.xml', 'common.xml'];
const HUD_CLASSES = ['ui.resourcebar.ResourcesBar', 'ui.toptoolbar.TopToolsBar', 'mainBar.SmallMapBar', 'ui.tasktracebar.TaskTraceBar',
  'ui.queuebar.QueueBar', 'ui.maintoolbar.MainToolBar', 'mainBar.ChatBar', 'mainBar.TipsBar'];

class MaxLoadingView extends Container {
  private mc: MovieClip;
  private back = new Container();

  constructor() {
    super();
    const g = new (Domain.getClass('flash.display.Sprite') as any)();
    g.graphics.beginFill(0, 1);
    g.graphics.drawRect(-200, -200, 1900, 1300);
    this.back = g;
    this.mc = Domain.createInstance<MovieClip>('asset.loading.MainLoadingAsset');
    this.addChild(this.back, this.mc);
    const notice = child(this.mc, 'notice');
    if (notice) notice.visible = false;
    const tips = child(this.mc, 'netTips');
    if (tips) tips.visible = false;
    this.setProgress(1);
    this.setItem(0, '');
    this.layout();
  }

  layout(): void {
    const W = StageReferance.stageWidth, H = StageReferance.stageHeight;
    this.mc.position.set(Math.round((W - 1000) / 2), Math.round((H - 600) / 2));
    this.back.scale.set(Math.max(1, W / 1500), Math.max(1, H / 900));
  }

  setProgress(p: number): void {
    child(this.mc, 'progressBarMc.pro')?.gotoAndStop(Math.max(1, Math.round(p)));
    const t = child(this.mc, 'loadPro');
    if (t instanceof TextField) t.text = `Progresso Total   ${Math.round(p)}%`;
  }

  setItem(ratio: number, name: string): void {
    const v = Math.round(ratio * 100);
    child(this.mc, 'childProgressBarMc.pro')?.gotoAndStop(Math.max(1, v));
    const t = child(this.mc, 'childLoadPro');
    if (t instanceof TextField) t.text = name ? `${name}     Progresso${v}%` : `     Progresso${v}%`;
  }
}

export class Shell {
  private scene: Container | null = null;
  private hud = new Map<string, Container>();
  private full: Bitmap[] = [];
  readonly frames: FrameOpener;

  constructor(private app: Application) {
    this.frames = new FrameOpener();
  }

  async start(): Promise<void> {
    const app = this.app;
    const W = () => app.screen.width, H = () => app.screen.height;
    StageReferance.setup(app.stage, W(), H());
    app.stage.hitArea = new Rectangle(0, 0, 1e5, 1e5);
    LayerManager.Instance.setup(app.stage);
    app.renderer.on('resize', () => { StageReferance.resize(W(), H()); LayerManager.Instance.onResize(); this.layout(); });

    await Domain.ensure(['mainloading']);
    const loading = new MaxLoadingView();
    app.stage.addChild(loading);
    const onResize = () => loading.layout();
    app.renderer.on('resize', onResize);
    const steps: [string, () => Promise<unknown>][] = [
      ...STARTUP_LIBS.map((l) => [`${l}.swf`, () => Domain.loadLibrary(l)] as [string, () => Promise<unknown>]),
      ...STARTUP_STYLES.map((f) => [f, () => F().loadStyleFile(f).catch(() => null)] as [string, () => Promise<unknown>]),
      ...[...HUD_CLASSES, 'castle.CastleSceneView'].map((c) => [c.split('.').pop()!, () => GameClasses.prepare(c)] as [string, () => Promise<unknown>]),
    ];
    for (let i = 0; i < steps.length; i++) {
      const [name, run] = steps[i];
      loading.setItem(0, name);
      await run();
      loading.setItem(1, name);
      loading.setProgress(((i + 1) / steps.length) * 100);
    }
    await new Promise((r) => setTimeout(r, 300));
    app.renderer.off('resize', onResize);
    loading.destroy({ children: true });

    RuntimeOptions.log = [];
    this.enterCastle();
    this.showHud();
    this.layout();
    Object.assign(window as any, { __shell: this });
  }

  private enterCastle(): void {
    const scene = new Container();
    scene.label = 'CASTLE_SCENE';
    const bg = F().creatComponentByStylename('castle.InnerCityBg1') as Container;
    const map = new Container();
    map.addChild(bg);
    scene.addChild(map);
    let drag: { x: number; y: number; mx: number; my: number } | null = null;
    map.eventMode = 'static';
    map.cursor = 'grab';
    map.on('pointerdown', (e) => { drag = { x: map.x, y: map.y, mx: e.global.x, my: e.global.y }; });
    map.on('globalpointermove', (e) => {
      if (!drag) return;
      map.x = drag.x + e.global.x - drag.mx;
      map.y = drag.y + e.global.y - drag.my;
      this.clampMap(map);
    });
    const end = () => { drag = null; };
    map.on('pointerup', end);
    map.on('pointerupoutside', end);
    LayerManager.Instance.addToLayer(scene, LayerManager.GAME_BOTTOM_LAYER);
    this.scene = scene;
    this.clampMap(map);
  }

  private clampMap(map: Container): void {
    const W = StageReferance.stageWidth, H = StageReferance.stageHeight;
    const w = map.width, h = map.height;
    map.x = w <= W ? Math.round((W - w) / 2) : Math.min(0, Math.max(W - w, map.x));
    map.y = h <= H ? Math.round((H - h) / 2) : Math.min(0, Math.max(H - h, map.y));
  }

  private make(cls: string): Container | null {
    try {
      const obj = cls === 'ui.resourcebar.ResourcesBar'
        ? F().creatCustomObject('resoueceBar.ResourcesBar')
        : Domain.createInstance(cls);
      return obj instanceof Container ? obj : null;
    } catch (err) {
      console.warn('[shell] HUD', cls, err);
      return null;
    }
  }

  private showHud(): void {
    const slots: Record<string, number> = {
      'ui.resourcebar.ResourcesBar': 0, 'ui.toptoolbar.TopToolsBar': 0, 'mainBar.SmallMapBar': 0, 'ui.queuebar.QueueBar': 0,
      'ui.tasktracebar.TaskTraceBar': 1, 'ui.maintoolbar.MainToolBar': 2, 'mainBar.ChatBar': 2, 'mainBar.TipsBar': 2,
    };
    for (const cls of HUD_CLASSES) {
      const obj = this.make(cls);
      if (!obj) continue;
      obj.label = cls;
      this.hud.set(cls, obj);
      LayerManager.Instance.addToLayer(obj, LayerManager.GAME_UI_LAYER, false, 0, false, slots[cls]);
      this.frames.wire(cls, obj);
    }
    for (const name of ['resourcesBar.fullTopAsset', 'resourcesBar.fullRightAsset', 'resourcesBar.fullDownAsset', 'resourcesBar.fullLeftAsset']) {
      if (!Domain.hasDefinition(name)) continue;
      const bmp = new Bitmap(F().creatBitmapData(name) as BitmapData);
      this.full.push(bmp);
      LayerManager.Instance.getLayerByType(LayerManager.GAME_BASE_LAYER)?.addChild(bmp);
    }
  }

  private layoutModuleButtons(): void {
    const bar = this.hud.get('ui.maintoolbar.MainToolBar');
    const vars = bar ? instanceVars.get(bar) : undefined;
    if (!vars) return;
    const order = ['_returnBtn', '_consortiaBtn', '_archaeologyBtn', '_storeBtn', '_skillBtn', '_starBtn', '_mountBtn',
      '_dragonTalkerBtn', '_armyBtn', '_petBtn', '_bagBtn', '_shopBtn'];
    let i = 0;
    for (const name of order) {
      const btn = vars.get(name) as Container | undefined;
      if (btn?.parent && btn.visible) btn.x = 600 - 50 - i++ * 47;
    }
  }

  layout(): void {
    const W = StageReferance.stageWidth, H = StageReferance.stageHeight;
    const gW = StageReferance.gameStageWidth, gH = StageReferance.gameStageHeight;
    const at = (cls: string, x: number, y: number) => { const o = this.hud.get(cls); if (o) o.position.set(Math.round(x), Math.round(y)); };
    const w = (cls: string) => this.hud.get(cls)?.width ?? 0;
    at('ui.resourcebar.ResourcesBar', -5, -3);
    at('ui.toptoolbar.TopToolsBar', 332, 0);
    at('mainBar.SmallMapBar', Math.max(gW - 183, 627), -2);
    at('ui.tasktracebar.TaskTraceBar', Math.max(gW - w('ui.tasktracebar.TaskTraceBar'), 987 - w('ui.tasktracebar.TaskTraceBar')), 159);
    at('ui.queuebar.QueueBar', 20, 159);
    at('ui.maintoolbar.MainToolBar', Math.max(gW - 600, 800 - 600), gH - 315 - 3);
    at('mainBar.ChatBar', 0, gH);
    at('mainBar.TipsBar', W / 2, H - 100);
    this.layoutModuleButtons();
    const [top, right, down, left] = this.full;
    if (top) top.width = W;
    if (down) { down.width = W; down.y = H - down.height + 2; }
    if (right) { right.height = H; right.x = W - right.width + 2; }
    if (left) left.height = H;
    const map = this.scene?.children[0] as Container | undefined;
    if (map) this.clampMap(map);
  }
}
