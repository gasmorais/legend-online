import { Container, Graphics, Ticker } from 'pixi.js';
import { cameraTransform, defaultCamera, rolePointByPos, sceneSize, type CameraState } from './grid';
import { fixtureById, FIXTURES, type Fixture } from './fixtures';
import { UnitView, sortByDepth, gridOverlay, gridLabels } from './units';
import { BattleHud, type HudState } from './hud';
import { createDamageNum, damageFinished } from './damage';
import { creat, failures, preloadBattleAssets } from './assets';
import { createBattleMap } from './swfAssets';

export const SIZES: [number, number][] = [[1000, 600], [1300, 750], [1500, 900]];

interface Layer { obj: Container; coef: number }

export class BattlePreview extends Container {
  readonly W: number;
  readonly H: number;
  private cam: CameraState;
  private map = new Container({ label: '_map (BattleMapView)' });
  private layers: Layer[] = [];
  private roles = new Container({ label: '_rolesContainer' });
  private effectLayer = new Container({ label: '_effectContainer' });
  private gridLayer = new Container({ label: 'grade' });
  private units: UnitView[] = [];
  private hud!: BattleHud;
  private hudState!: HudState;
  private ticker: Ticker;
  private timer = 0;
  private fixture: Fixture;
  autoDamage = true;

  private constructor(fixtureId: string, size: [number, number], ticker: Ticker) {
    super({ label: 'BattleSceneView (pré-visualização)' });
    const s = sceneSize(size[0], size[1]);
    this.W = s.w;
    this.H = s.h;
    this.cam = defaultCamera(this.W, this.H);
    this.fixture = fixtureById(fixtureId);
    this.ticker = ticker;
  }

  ground: number | null = null;
  realUnits = 0;

  static async create(fixtureId: string, size: [number, number], ticker: Ticker, ground?: number): Promise<BattlePreview> {
    await preloadBattleAssets();
    const p = new BattlePreview(fixtureId, size, ticker);
    p.build();
    await p.loadReal(ground ?? p.fixture.ground);
    return p;
  }

  private async loadReal(ground: number): Promise<void> {
    const map = await createBattleMap(ground);
    if (map) {
      this.ground = ground;
      for (const l of this.layers.splice(0, 2)) l.obj.destroy();
      const layer = new Container({ label: `RepeatBackGroundLayer (map${ground}.swf)` });
      layer.addChild(map);
      this.map.addChildAt(layer, 0);
      this.layers.unshift({ obj: layer, coef: 0 });
    }
    const loaded = await Promise.all(this.units.map((u) => u.loadMovie()));
    this.realUnits = loaded.filter(Boolean).length;
    this.applyCamera();
  }

  private build(): void {
    const { W, H } = this;
    const backdrop = creat<Container>('battle.BattleBackGround', 'custom');
    backdrop.position.set(W >> 1, H >> 1);
    this.addChild(backdrop);
    const stageClip = new Graphics().rect(0, 0, W, H).fill(0xffffff);
    this.addChild(stageClip);
    backdrop.mask = stageClip;

    const view = new Container({ label: '_view (BattleView)' });
    const clip = new Graphics().rect(0, 0, W, H).fill(0xffffff);
    view.addChild(clip);
    view.mask = clip;
    this.addChild(view);

    const sky = new Graphics().rect(-400, 0, 2300, 520).fill({ color: 0x24324a }).rect(-400, 300, 2300, 220).fill({ color: 0x2f4260, alpha: 0.8 });
    sky.label = 'cenário fundo (placeholder, coef 0,2)';
    const ground = new Graphics();
    ground.label = 'cenário chão (placeholder, coef 1)';
    ground.rect(-400, 500, 2300, 400).fill(0x3b4a33);
    for (let x = -400; x <= 1900; x += 100) ground.moveTo(x, 500).lineTo(x + (x - 750) * 0.25, 900).stroke({ color: 0x4d5f43, width: 1 });
    this.addLayer(sky, 0.2);
    this.addLayer(ground, 1);
    this.addLayer(new Container({ label: '_roleBackContainer' }), 0);
    this.addLayer(new Container({ label: '_profoundContainer' }), 0);
    this.addLayer(this.gridLayer, 0);
    this.addLayer(this.roles, 0);
    this.addLayer(this.effectLayer, 0);
    this.addLayer(new Container({ label: '_gasEffectContainer' }), 0);
    view.addChild(this.map);
    view.addChild(new Container({ label: '_profoundLayer' }));

    this.gridLayer.addChild(gridOverlay(), gridLabels());
    this.spawnUnits();

    const self = this.units.find((u) => u.info.self);
    this.hudState = { W, H, auto: true, hideOthers: false, hp: self?.hp ?? 1, maxHp: self?.info.maxHp ?? 1, sp: 40, spMax: 100 };
    this.hud = new BattleHud(this.hudState);
    this.hud.onToggleAuto = () => this.setHud({ auto: !this.hudState.auto });
    this.hud.onToggleHide = () => this.setHud({ hideOthers: !this.hudState.hideOthers });
    view.addChild(this.hud);
    view.addChild(new Container({ label: '_redScreenEffect' }));

    this.applyCamera();
    this.ticker.add(this.update, this);
    this.on('destroyed', () => this.ticker.remove(this.update, this));
  }

  private addLayer(obj: Container, coef: number): void {
    this.layers.push({ obj, coef });
    this.map.addChild(obj);
  }

  private spawnUnits(): void {
    const byId = new Map<number, UnitView>();
    for (const info of this.fixture.units.filter((u) => u.kind !== 'pet')) {
      const v = new UnitView(info);
      byId.set(info.livingId, v);
      this.units.push(v);
    }
    for (const info of this.fixture.units.filter((u) => u.kind === 'pet')) {
      this.units.push(new UnitView(info, info.owner ? byId.get(info.owner) : undefined));
    }
    for (const v of this.units) this.roles.addChild(v);
    sortByDepth(this.roles);
  }

  private applyCamera(): void {
    const t = cameraTransform(this.cam);
    for (const l of this.layers) l.obj.x = t.layerX(l.coef);
    this.map.scale.set(t.scale);
    this.map.position.set(t.sceneX, t.sceneY);
  }

  setHud(patch: Partial<HudState>): void {
    this.hudState = { ...this.hudState, ...patch };
    this.hud.layout(this.hudState);
    for (const u of this.units) u.visible = !(this.hudState.hideOthers && u.info.face === 2 && u.info.type !== 3);
  }

  set showGrid(v: boolean) { this.gridLayer.visible = v; }
  get showGrid(): boolean { return this.gridLayer.visible; }

  hit(kind: 'normal' | 'crit' | 'heal' | 'parry' = 'normal'): void {
    const targets = this.units.filter((u) => u.info.kind !== 'pet' && u.visible);
    const u = targets[Math.floor(Math.random() * targets.length)];
    if (!u) return;
    const value = Math.round((kind === 'crit' ? 0.12 : 0.05) * u.info.maxHp * (0.6 + Math.random() * 0.8));
    u.hp = kind === 'heal' ? Math.min(u.info.maxHp, u.hp + value) : Math.max(0, u.hp - value);
    if (u.hp === 0) u.hp = u.info.maxHp;
    u.updateStrip();
    if (kind !== 'heal') u.player?.play('Danny');
    const n = createDamageNum({ value, crit: kind === 'crit', heal: kind === 'heal', parry: kind === 'parry', selfCause: u.info.face === 2 });
    n.position.set(u.x, u.y - 130 - (kind === 'crit' ? 50 : 0));
    this.effectLayer.addChild(n);
    if (u.info.self) this.setHud({ hp: u.hp });
  }

  private update(): void {
    this.hud.tick();
    for (const u of this.units) u.player?.tick();
    for (const n of [...this.effectLayer.children]) if (damageFinished(n)) n.destroy({ children: true });
    if (!this.autoDamage) return;
    this.timer += this.ticker.deltaMS;
    if (this.timer > 700) {
      this.timer = 0;
      const r = Math.random();
      this.hit(r < 0.15 ? 'crit' : r < 0.25 ? 'heal' : r < 0.32 ? 'parry' : 'normal');
      this.setHud({ sp: (this.hudState.sp + 7) % (this.hudState.spMax + 1) });
    }
  }

  get fixtureInfo(): Fixture { return this.fixture; }
  get assetFailures(): string[] { return failures; }

  describe(): string {
    return this.units.map((u) => `${u.info.kind}@${u.info.pos}/${u.info.face} → (${rolePointByPos(u.info.pos, u.info.face).x}, ${rolePointByPos(u.info.pos, u.info.face).y})`).join('\n');
  }
}

export { FIXTURES };
