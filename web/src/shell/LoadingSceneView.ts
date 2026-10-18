import type { Container } from 'pixi.js';
import { MovieClip } from '@/flash/display';
import { ComponentFactory } from '@/pickgliss/ComponentFactory';
import { Component } from '@/pickgliss/core/Component';
import { LayerManager } from '@/pickgliss/LayerManager';
import { child } from './Shell';

export class LoadingSceneView extends Component {
  private static _instance: LoadingSceneView | null = null;
  static get instance(): LoadingSceneView { return (this._instance ??= new LoadingSceneView()); }

  private loadingMc!: MovieClip;
  private closeBtn!: Container;
  private num = 0;
  private showing = false;
  private closeCall: (() => void) | null = null;

  protected override init(): void {
    super.init();
    const F = ComponentFactory.Instance;
    this.loadingMc = F.creatCustomObject('core.loading.LoadingMapAsset.shenqu') as MovieClip;
    child(this.loadingMc, 'bg1')?.gotoAndStop(1);
    child(this.loadingMc, 'bg2')?.gotoAndStop(1);
    this.loadingMc.stop();
    this.addChild(this.loadingMc);
    this.closeBtn = F.creatComponentByStylename('core.loadingCloseBtn') as Container;
    this.closeBtn.on('pointertap', () => { this.closeCall?.(); this.hide(); });
  }

  isShowing(): boolean { return this.showing; }

  show(closable = false, onClose: (() => void) | null = null): void {
    this.showing = true;
    this.closeCall = onClose;
    if (!this.parent) {
      LayerManager.Instance.addToLayer(this, LayerManager.STAGE_TOP_LAYER, true, LayerManager.ALPHA_BLOCKGOUND, true);
      this.update(1);
    }
    if (closable) this.addChild(this.closeBtn);
    else this.closeBtn.parent?.removeChild(this.closeBtn);
  }

  update(p: number): void {
    const back = this.num - p;
    if (back > 0 && back < 8) return;
    this.num = p;
    this.loadingMc.gotoAndStop(Math.max(1, Math.trunc(p >= 100 ? 99 : p)));
  }

  hide(): void {
    this.showing = false;
    if (this.parent) {
      this.num = 0;
      this.parent.removeChild(this);
      this.emit('close');
    }
  }
}
