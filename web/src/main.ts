import { Application } from 'pixi.js';
import 'pixi.js/advanced-blend-modes';
import { FlashClock } from './flash/clock';
import { Domain } from './flash/library';
import './flash/display';
import './as3/flash';
import { ComponentFactory } from './pickgliss';
import { StageReferance } from './pickgliss/toplevel/StageReferance';
import { GameClasses, RuntimeOptions } from './game/GameClasses';
import { LanguageMgr } from './game/LanguageMgr';
import { Viewer } from './viewer/viewer';

async function boot(): Promise<void> {
  const app = new Application();
  await app.init({ preference: 'webgl', background: 0x0b0b0e, antialias: true, autoDensity: true,
    resolution: Math.min(window.devicePixelRatio, 2), useBackBuffer: true });
  FlashClock.start(app.ticker);
  StageReferance.setup(app.stage, 1000, 600);
  if (new URLSearchParams(location.search).get('view') === 'stage') document.body.classList.add('stage-only');
  await Promise.all([Domain.init(), LanguageMgr.load(), GameClasses.init()]);
  await ComponentFactory.Instance.init();
  Object.assign(window as any, { __app: app, __Domain: Domain, __F: ComponentFactory.Instance, __G: GameClasses, __RT: RuntimeOptions });
  if (new URLSearchParams(location.search).has('boot')) {
    document.title = 'Legend Online';
    app.renderer.background.color = 0x0e0805;
    document.getElementById('app')!.remove();
    const { fitStage } = await import('./boot/Fit');
    fitStage(app);
    if (new URLSearchParams(location.search).has('drive')) {
      const w = new Worker(URL.createObjectURL(new Blob(['setInterval(() => postMessage(0), 40)'], { type: 'text/javascript' })));
      w.onmessage = () => { if (document.hidden) app.ticker.update(performance.now()); };
    }
    const { bootGame } = await import('./boot/Boot');
    await bootGame(app);
    return;
  }
  if (new URLSearchParams(location.search).has('play')) {
    document.body.classList.add('play');
    app.renderer.background.color = 0x0e0805;
    document.getElementById('app')!.replaceWith(app.canvas);
    app.resizeTo = window;
    const { Shell } = await import('./shell/Shell');
    await new Shell(app).start();
    return;
  }
  await new Viewer().start(app, document.getElementById('app')!);
}

boot().catch((err) => {
  console.error(err);
  document.body.insertAdjacentHTML('beforeend', `<pre style="color:#e5605a;padding:16px">${String(err?.stack ?? err)}</pre>`);
});
