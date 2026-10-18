import { Container, Graphics, Text } from 'pixi.js';
import { setColorTransform } from '@/flash/display';
import { creat } from './assets';

const BALL = 93;

class VesselBall extends Container {
  private line: Container;
  private ballMask = new Graphics();
  private ball: Container;
  constructor(private max: number, private cur: number, ballName: string, tint?: number[]) {
    super({ label: 'VesselBallComp' });
    const content = new Container();
    const circle = new Graphics().circle(BALL / 2, BALL / 2, BALL / 2).fill(0x000000);
    this.addChild(content, circle);
    content.mask = circle;
    this.line = creat<Container>('asset.battle.VesselPoolLineMC');
    this.line.alpha = 0.6;
    if (tint) setColorTransform(this.line, tint);
    this.ball = creat<Container>(ballName);
    this.ball.position.set(BALL / 2, BALL / 2);
    content.addChild(this.ball, this.line, this.ballMask);
    this.ball.mask = this.ballMask;
    this.set(cur);
  }

  set(v: number): void {
    this.cur = v;
    let y = (BALL * (this.max - v)) / this.max;
    if (y <= 0) y = -10;
    if (y > BALL) y = BALL;
    this.line.y = y;
    this.line.visible = v > 0;
    this.ballMask.clear().rect(0, -BALL, BALL, BALL).fill(0x000000);
    this.ballMask.y = BALL;
    this.ballMask.height = BALL - y;
  }

  tick(): void { this.ball.angle += 1; }
}

export interface HudState { W: number; H: number; auto: boolean; hideOthers: boolean; hp: number; maxHp: number; sp: number; spMax: number }

export class BattleHud extends Container {
  private bottomBar = new Container({ label: '_bottomBar (BottomBar)' });
  private hpBall!: VesselBall;
  private spBall!: VesselBall;
  private hpNum = new Text({ text: '', style: { fontFamily: 'Arial', fontSize: 13, fill: 0xffffff, fontWeight: 'bold' } });
  private spNum = new Text({ text: '', style: { fontFamily: 'Arial', fontSize: 13, fill: 0xffffff, fontWeight: 'bold' } });
  private autoFightBtn: any;
  private autoFightFlag: Container;
  private hideOthersBg: any;
  private hideOthersBtn: any;
  private teamStrip1: Container;
  private teamStrip2: Container;
  private topPanel = new Container({ label: '_roleShowII (RoleShowViewII, provisório)' });
  onToggleAuto: (() => void) | null = null;
  onToggleHide: (() => void) | null = null;

  constructor(private st: HudState) {
    super({ label: 'BattleUIView (pré-visualização)' });
    this.buildBottomBar();
    this.addChild(this.topPanel);
    this.teamStrip1 = creat<Container>('battle.teamStripContainer1', 'style');
    this.teamStrip2 = creat<Container>('battle.teamStripContainer2', 'style');
    this.autoFightFlag = creat<Container>('asset.battle.AutoFightFlagAsset', 'bitmap');
    this.autoFightBtn = creat<any>('battle.AutoFightBtn2', 'style');
    this.hideOthersBg = creat<any>('battle.HideOthersBg', 'style');
    this.hideOthersBtn = creat<any>('battle.HideOthersBtn', 'style');
    this.addChild(this.autoFightFlag, this.autoFightBtn, this.hideOthersBg, this.hideOthersBtn, this.teamStrip1, this.teamStrip2);
    for (const [btn, fn] of [[this.autoFightBtn, () => this.onToggleAuto?.()], [this.hideOthersBtn, () => this.onToggleHide?.()]] as const) {
      btn.eventMode = 'static';
      btn.cursor = 'pointer';
      btn.on('pointertap', fn);
    }
    this.layout(st);
  }

  private buildBottomBar(): void {
    const back = creat<any>('asset.battle.BottomBack');
    back.gotoAndStop?.(1);
    back.x = -back.width * 0.5;
    back.y = -back.height;
    this.bottomBar.addChild(back);
    this.hpBall = new VesselBall(this.st.maxHp, this.st.hp, 'asset.battle.BloodPoolBallMC', [0.7, 0, 0, 1, 0, 0, 0, 0]);
    this.hpBall.position.set(-338, -116);
    this.spBall = new VesselBall(this.st.spMax, this.st.sp, 'asset.battle.AngerPoolBallMC');
    this.spBall.position.set(246, -115);
    this.bottomBar.addChildAt(this.spBall, 0);
    this.bottomBar.addChildAt(this.hpBall, 0);
    const skills = new Container({ label: '_skillList (provisório)' });
    for (let i = 0; i < 8; i++) {
      const slot = creat<Container>('asset.battle.SkillBg', 'bitmap');
      slot.x = i * 58;
      skills.addChild(slot);
    }
    skills.position.set(-235, -65);
    this.bottomBar.addChild(skills);
    for (const dx of [154, 745]) {
      const tb = creat<Container>('asset.battle.BottomTextBack', 'bitmap');
      tb.position.set(back.x + dx, back.y + 178);
      this.bottomBar.addChild(tb);
    }
    this.hpNum.anchor.set(0.5, 0);
    this.hpNum.position.set(-340 + 44, -14 - 5);
    this.spNum.anchor.set(0.5, 0);
    this.spNum.position.set(248 + 44, -14 - 5);
    this.bottomBar.addChild(this.hpNum, this.spNum);
    const setting = creat<Container>('battle.settingBtn', 'style');
    this.bottomBar.addChild(setting);
    this.addChild(this.bottomBar);
  }

  layout(st: HudState): void {
    this.st = st;
    const { W, H } = st;
    const s = 0.85 + (0.15 * (W - 1000)) / 300;
    this.bottomBar.position.set(W * 0.5, H);
    this.bottomBar.scale.set(s);
    const btn = this.autoFightBtn;
    btn.position.set(this.bottomBar.x + 500 * s + 10, H - 63);
    this.hideOthersBg.position.set(btn.x + btn.width, H - 50);
    this.hideOthersBtn.position.set(btn.x + btn.width + 12, H - 45);
    this.teamStrip2.x = W - 190;
    btn.selected = !st.auto;
    this.autoFightFlag.visible = st.auto;
    this.autoFightFlag.position.set((W - this.autoFightFlag.width) * 0.5, 137 * (W / 1500));
    this.hideOthersBtn.selected = st.hideOthers;
    this.hpBall.set(st.hp);
    this.spBall.set(st.sp);
    this.hpNum.text = String(st.hp);
    this.spNum.text = String(st.sp);
    this.drawTopPanel(W);
  }

  private drawTopPanel(W: number): void {
    this.topPanel.removeChildren().forEach((c) => c.destroy());
    const g = new Graphics().roundRect(0, 0, 360, 56, 6).fill({ color: 0x000000, alpha: 0.35 }).stroke({ color: 0xd8b26a, width: 1, alpha: 0.6 });
    const t = new Text({ text: 'RoleShowViewII (painel do alvo) — provisório', style: { fontFamily: 'Arial', fontSize: 12, fill: 0xf0e0b0 } });
    t.position.set(10, 20);
    this.topPanel.addChild(g, t);
    this.topPanel.position.set((W - 360) / 2, 8);
  }

  tick(): void { this.hpBall.tick(); this.spBall.tick(); }
}
