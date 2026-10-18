import { Container } from 'pixi.js';
import { MovieClip } from '@/flash/display';
import { creat, named } from './assets';

export interface DamageOpts { value: number; crit?: boolean; heal?: boolean; selfCause?: boolean; parry?: boolean }

export function createDamageNum(o: DamageOpts): Container {
  const type = o.crit ? 2 : 1;
  const anim = creat<MovieClip>(type === 2 ? 'asset.battle.BloodUpdateRage' : 'asset.battle.BloodUpdateAsset');
  const numSp = new Container({ label: '_numSp' });
  const txt = String(Math.abs(o.value));
  if (o.heal) {
    const t = creat<any>('battle.GreenNumberAssetSp.text', 'style');
    t.text = txt;
    numSp.addChild(t);
  } else if (type === 1) {
    const style = o.parry ? 'battle.SelfCauseNumberAssetSp.text' : o.selfCause ? 'battle.DamageNumberAssetSp.text' : 'battle.RedNumberAssetSp.text';
    const t = creat<any>(style, 'style');
    t.text = txt;
    numSp.addChild(t);
    if (o.parry) t.scale.set(0.6);
  } else {
    const box = creat<any>('battle.CriticalDamageNumAssetSp', 'custom');
    const tf = named(box, 'txt') as any;
    if (tf) tf.text = txt;
    numSp.addChild(box);
  }
  const b = numSp.getLocalBounds();
  numSp.x = -b.width / 2;
  numSp.y = -b.height / 2 - (o.heal ? 20 : 0);
  const holder = named(anim, 'container') ?? anim;
  holder.addChild(numSp);
  anim.gotoAndPlay?.(1);
  const wrap = new Container({ label: 'DamageNumView' });
  wrap.addChild(anim);
  return wrap;
}

export function damageFinished(wrap: Container): boolean {
  const mc = wrap.children[0] as MovieClip | undefined;
  return !mc || !(mc instanceof MovieClip) || mc.currentFrame >= mc.totalFrames;
}
