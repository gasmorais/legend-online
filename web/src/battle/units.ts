import { Container, Graphics, Text } from 'pixi.js';
import { rolePointByPos, type Pt } from './grid';
import { creat, named } from './assets';
import type { FixtureUnit } from './fixtures';
import { ActionPlayer, createUnitMovie } from './swfAssets';

const BODY: Record<FixtureUnit['kind'], { w: number; h: number; color: number }> = {
  hero: { w: 46, h: 104, color: 0x4f86c6 },
  npcHero: { w: 46, h: 104, color: 0xc6584f },
  boss: { w: 110, h: 190, color: 0x9b2f2f },
  pawn: { w: 22, h: 58, color: 0x6c8fb5 },
  pet: { w: 32, h: 28, color: 0x8bc34a },
  child: { w: 30, h: 66, color: 0x7e9be0 },
  monster: { w: 70, h: 90, color: 0x8d6e63 },
};

export class UnitView extends Container {
  readonly info: FixtureUnit;
  point: Pt;
  pointZ = 0;
  hp: number;
  private strip: any = null;
  private stripMaxW = 68;
  private readonly movieContainer = new Container({ label: '_movieContainer' });
  readonly roleInfoView: Container | null = null;
  player: ActionPlayer | null = null;

  constructor(info: FixtureUnit, owner?: UnitView) {
    super({ label: `${info.kind}#${info.pos}${info.face === 1 ? 'E' : 'D'}` });
    this.info = info;
    this.hp = info.hp;
    this.point = rolePointByPos(info.pos, info.face);

    const shade = creat<Container>('asset.battle.RoleShadeMC');
    shade.alpha = 0.7;
    if (info.kind === 'boss') shade.scale.set(2);
    this.addChild(shade);
    this.addChild(new Container({ label: '_backEffectContainer' }));
    this.addChild(this.movieContainer);
    this.movieContainer.addChild(this.placeholderBody());
    this.movieContainer.scale.x = info.face === 2 ? -1 : 1;

    if (info.kind === 'pet') {
      shade.visible = !info.flying;
      if (owner) this.point = { ...owner.point };
    } else {
      this.roleInfoView = this.buildInfoView();
    }
    this.syncPosition();
  }

  async loadMovie(): Promise<boolean> {
    if (!this.info.res) return false;
    const mc = await createUnitMovie(this.info.res);
    if (!mc || this.destroyed) return false;
    this.movieContainer.removeChildren().forEach((c) => c.destroy({ children: true }));
    this.movieContainer.addChild(mc);
    this.player = new ActionPlayer(mc);
    this.player.play('Stand');
    return true;
  }

  private placeholderBody(): Container {
    const { w, h, color } = BODY[this.info.kind];
    const c = new Container({ label: 'placeholder' });
    const g = new Graphics();
    const figures = this.info.kind === 'pawn' ? [[-26, -6], [0, 4], [26, -6]] : [[0, 0]];
    for (const [fx, fy] of figures) {
      g.roundRect(fx - w / 2, fy - h, w, h, Math.min(w, h) / 2).fill({ color, alpha: 0.92 }).stroke({ color: 0x10141c, width: 2 });
      g.poly([fx + w / 2 - 2, fy - h * 0.7, fx + w / 2 + 10, fy - h * 0.62, fx + w / 2 - 2, fy - h * 0.54]).fill(0xffffff);
    }
    c.addChild(g);
    const label = new Text({
      text: `${this.info.kind}\n${this.info.pos}`,
      style: { fontFamily: 'Arial', fontSize: this.info.kind === 'pawn' || this.info.kind === 'pet' ? 10 : 12, fill: 0xffffff, align: 'center', fontWeight: 'bold' },
    });
    label.anchor.set(0.5);
    label.position.set(0, -h / 2);
    label.scale.x = this.info.face === 2 ? -1 : 1;
    c.addChild(label);
    return c;
  }

  private buildInfoView(): Container {
    const roleInfo = creat<any>('asset.battle.PawnBottomAsset', 'custom');
    const name = creat<any>('battle.HeroNameTxt', 'style');
    try { name.setFrame?.(1); } catch { }
    name.filters = [];
    name.text = this.info.name;
    named(roleInfo, 'container')?.addChild(name);
    const isBossStrip = this.info.type === 3 && this.info.face === 2;
    this.strip = creat<any>(isBossStrip ? 'asset.battle.BossBottomStripAsset' : 'asset.battle.BottomHpStripAsset');
    if (isBossStrip) this.strip.width = 69;
    this.stripMaxW = named(this.strip, 'maskmc')?.width || 68;
    roleInfo.addChild(this.strip);
    const sp = named(roleInfo, 'strip_pos');
    if (sp) { this.strip.position.set(sp.x, sp.y); sp.visible = false; }
    const bg = named(roleInfo, 'bgMc');
    if (bg) bg.visible = true;
    roleInfo.y = -20;
    this.addChild(roleInfo);
    this.updateStrip();
    return roleInfo;
  }

  updateStrip(): void {
    const mask = named(this.strip, 'maskmc');
    if (!mask) return;
    const ratio = Math.max(0, Math.min(1, this.hp / this.info.maxHp));
    mask.width = Math.floor(ratio * this.stripMaxW);
  }

  get pointY(): number {
    return this.point.y + (this.info.self ? 1 : 0) + (this.info.kind === 'pet' ? 2 : 0);
  }

  syncPosition(): void {
    if (this.info.kind === 'pet') {
      this.x = this.point.x + (this.info.face === 2 ? 60 : -60);
      this.y = this.point.y - (this.info.flying ? 80 : 0);
      return;
    }
    this.x = this.point.x;
    this.y = this.point.y - this.pointZ;
  }
}

export function sortByDepth(container: Container): void {
  const kids = container.children as UnitView[];
  const sorted = [...kids].sort((a, b) => (a.pointY ?? 0) - (b.pointY ?? 0));
  sorted.forEach((k, i) => { if (container.getChildIndex(k) !== i) container.setChildIndex(k, i); });
}

export function gridOverlay(): Graphics {
  const g = new Graphics();
  g.label = 'grade (get9GridPos)';
  for (const face of [1, 2]) {
    for (let pos = 1; pos <= 12; pos++) {
      const p = rolePointByPos(pos, face);
      const front = (pos - 1) % 3 === 0;
      g.ellipse(p.x, p.y, 30, 12).stroke({ color: face === 1 ? 0x6fa8ff : 0xff7f6f, width: front ? 3 : 1.5, alpha: 0.9 });
    }
  }
  return g;
}

export function gridLabels(): Container {
  const c = new Container({ label: 'rótulos da grade' });
  for (const face of [1, 2]) {
    for (let pos = 1; pos <= 12; pos++) {
      const p = rolePointByPos(pos, face);
      const t = new Text({ text: String(pos), style: { fontFamily: 'Arial', fontSize: 13, fill: face === 1 ? 0xaed0ff : 0xffc2b8, fontWeight: 'bold' } });
      t.anchor.set(0.5);
      t.position.set(p.x, p.y + 20);
      c.addChild(t);
    }
  }
  return c;
}
