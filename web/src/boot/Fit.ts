import type { Application } from 'pixi.js';

export const STAGE_W = 1000;
export const STAGE_H = 600;

export function fitStage(app: Application, host: HTMLElement = document.body): () => void {
  const canvas = app.canvas;
  Object.assign(host.style, {
    margin: '0', width: '100vw', height: '100dvh', overflow: 'hidden', background: '#000',
    display: 'flex', alignItems: 'center', justifyContent: 'center', touchAction: 'none',
    overscrollBehavior: 'none', userSelect: 'none', webkitUserSelect: 'none',
  } as Partial<CSSStyleDeclaration>);
  document.documentElement.style.background = '#000';
  canvas.style.touchAction = 'none';
  canvas.style.display = 'block';
  canvas.addEventListener('contextmenu', (e) => e.preventDefault());
  host.appendChild(canvas);

  let last = '';
  const apply = (): void => {
    const vw = window.visualViewport?.width ?? window.innerWidth;
    const vh = window.visualViewport?.height ?? window.innerHeight;
    const scale = Math.min(vw / STAGE_W, vh / STAGE_H);
    const dpr = window.devicePixelRatio || 1;
    const res = Math.max(1, Math.min(dpr * scale, 3));
    const key = `${scale.toFixed(4)}|${res.toFixed(3)}`;
    if (key === last) return;
    last = key;
    if (Math.abs(app.renderer.resolution - res) > 0.01) app.renderer.resolution = res;
    app.renderer.resize(STAGE_W, STAGE_H);
    canvas.style.width = `${Math.floor(STAGE_W * scale)}px`;
    canvas.style.height = `${Math.floor(STAGE_H * scale)}px`;
  };
  apply();
  window.addEventListener('resize', apply);
  window.visualViewport?.addEventListener('resize', apply);
  screen.orientation?.addEventListener?.('change', apply);
  return apply;
}
