import { Container, Graphics } from 'pixi.js';
import { ComponentFactory } from '@/pickgliss/ComponentFactory';

export const BATTLE_ASSETS = [
  'asset.battle.PawnBottomAsset', 'asset.battle.BottomHpStripAsset', 'asset.battle.BossBottomStripAsset',
  'battle.HeroNameTxt', 'asset.battle.RoleShadeMC', 'asset.battle.BottomBack', 'asset.battle.BottomTextBack',
  'asset.battle.BloodPoolBallMC', 'asset.battle.AngerPoolBallMC', 'asset.battle.VesselPoolLineMC',
  'battle.AutoFightBtn2', 'battle.autoFightStrip', 'battle.HideOthersBtn', 'battle.HideOthersBg',
  'asset.battle.AutoFightFlagAsset', 'battle.settingBtn', 'asset.battle.SkillBg', 'battle.teamStripContainer1',
  'battle.teamStripContainer2', 'asset.battle.BloodUpdateAsset', 'asset.battle.BloodUpdateRage',
  'battle.RedNumberAssetSp.text', 'battle.GreenNumberAssetSp.text', 'battle.DamageNumberAssetSp.text',
  'battle.SelfCauseNumberAssetSp.text', 'battle.CriticalDamageNumAssetSp', 'asset.battle.CriticalDamageAsset',
  'asset.battle.ParryAsset', 'asset.battle.SelfHpNumAsset', 'battle.BattleBackGround',
];

export const failures: string[] = [];

export async function preloadBattleAssets(): Promise<void> {
  await ComponentFactory.Instance.preload(BATTLE_ASSETS);
}

export function creat<T = any>(name: string, kind: 'creat' | 'style' | 'custom' | 'bitmap' = 'creat'): T {
  const F = ComponentFactory.Instance;
  try {
    switch (kind) {
      case 'style': return F.creatComponentByStylename(name);
      case 'custom': return F.creatCustomObject(name);
      case 'bitmap': return F.creatBitmap(name) as T;
      default: return F.creat(name);
    }
  } catch (err) {
    failures.push(`${name}: ${(err as Error).message}`);
    const g = new Graphics().rect(0, 0, 40, 16).fill({ color: 0xff00ff, alpha: 0.5 });
    g.label = `faltando ${name}`;
    return g as unknown as T;
  }
}

export function named(obj: any, name: string): Container | undefined {
  return obj?.[name] ?? obj?.getChildByName?.(name, true) ?? undefined;
}
