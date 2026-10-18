import type { Container } from 'pixi.js';
import { ComponentFactory } from '@/pickgliss/ComponentFactory';
import { LayerManager } from '@/pickgliss/LayerManager';
import { GameClasses, instanceVars, RuntimeOptions } from '@/game/GameClasses';
import { LanguageMgr } from '@/game/LanguageMgr';
import { LoadingSceneView } from './LoadingSceneView';

interface ControllerInfo { controller: string; frame: string | null; byType: Record<string, string> }

const BUTTON_KEYS: Record<string, Record<string, string | [string, string]>> = {
  'mainBar.SmallMapBar': {
    _outercityBtn: 'worldmap', _dayGuideBtn: 'newactiveleed', _setBtn: 'setting', _mailBtn: 'email',
    _funPreviewBtn: 'funpreview', _guideTaskBtn: 'guidetask', _customerServiceBtn: 'customerservice', _rankingBtn: 'sort',
  },
  'ui.maintoolbar.MainToolBar': {
    _payBtn: 'firstpay', _shopBtn: 'shop', _bagBtn: ['army', 'EQUIP_PANEL'], _petBtn: 'pet', _armyBtn: 'child',
    _mountBtn: 'mounts', _starBtn: 'star', _skillBtn: ['army', 'SKILL_PANEL'], _storeBtn: 'store',
    _archaeologyBtn: 'archaeology', _consortiaBtn: 'consortia', _friendsBtn: ['friends', '1'], _campaignBtn: 'selectcampaign',
    _dragonTalkerBtn: 'dragontalker', _poptipBtn: 'consortiagroupchat',
  },
  'ui.resourcebar.ResourcesBar': {},
};

export class FrameOpener {
  private controllers: Record<string, ControllerInfo> = {};
  private ready: Promise<void>;
  onTip: (msg: string) => void = (m) => console.info('[tip]', m);

  constructor() {
    this.ready = fetch('/layout/controllers.json').then((r) => r.json()).then((d) => { this.controllers = d; });
  }

  wire(cls: string, bar: Container): void {
    const map = BUTTON_KEYS[cls];
    const vars = instanceVars.get(bar);
    if (!map || !vars) return;
    for (const [field, key] of Object.entries(map)) {
      const btn = vars.get(field) as Container | undefined;
      if (!btn || typeof (btn as any).on !== 'function') continue;
      btn.eventMode = 'static';
      btn.cursor = 'pointer';
      btn.on('pointertap', () => {
        const [k, t] = Array.isArray(key) ? key : [key, undefined];
        void this.open(k, t);
      });
    }
  }

  async open(key: string, openType?: string): Promise<Container | null> {
    await this.ready;
    const info = this.controllers[key];
    const style = info ? (openType && info.byType[openType]) || info.frame : null;
    if (!style) {
      this.onTip(`${key}: ${LanguageMgr.GetTranslation('public.resourceLoading')} (sem frame mapeado)`);
      return null;
    }
    return this.openStyle(style);
  }

  async openStyle(style: string): Promise<Container | null> {
    const F = ComponentFactory.Instance;
    const loading = LoadingSceneView.instance;
    loading.show(true);
    loading.update(1);
    await F.preload([style]);
    loading.update(40);
    const attrs = F.getComponentStyle(style);
    const cls = attrs?.find(([k]) => k === 'classname')?.[1] ?? style;
    if (GameClasses.moduleOf(cls)) await GameClasses.prepare(cls, false);
    loading.update(100);
    loading.hide();
    RuntimeOptions.log = [];
    let frame: Container;
    try {
      frame = attrs ? F.creatComponentByStylename(style) : F.creat(style);
    } catch (err) {
      this.onTip(`não foi possível abrir ${style}: ${(err as Error).message}`);
      return null;
    }
    LayerManager.Instance.addToLayer(frame, LayerManager.GAME_DYNAMIC_LAYER, true, LayerManager.BLCAK_BLOCKGOUND, true);
    frame.on('response', (e: { responseCode?: number }) => {
      if (e?.responseCode === 0 || e?.responseCode === 1 || e?.responseCode === 4) {
        frame.parent?.removeChild(frame);
        (frame as any).dispose?.();
      }
    });
    return frame;
  }
}
