export interface Pt { x: number; y: number }

export function get9GridPos(baseX: number, baseY: number, gap: number, isLeft: boolean): Pt[][] {
  const sign = isLeft ? 1 : -1;
  const offs = [0, -40, -80, -120];
  const grid: Pt[][] = [];
  for (let c = 0; c < 3; c++) {
    const col: Pt[] = [];
    for (let r = 0; r < 4; r++) col.push({ x: c * 150 + baseX + gap * c + offs[r] * sign, y: r * 60 + baseY });
    grid.push(col);
  }
  return grid;
}

export const POS_LEFT = get9GridPos(295, 570, 0, true);
export const POS_RIGHT = get9GridPos(905, 570, 0, false);

export function rolePointByPos(pos: number, face: number): Pt {
  if (pos < 1 || pos > 12) return { x: 0, y: 0 };
  const r = Math.floor((pos - 1) / 3);
  if (face === 1) return { ...POS_LEFT[2 - ((pos - 1) % 3)][r] };
  return { ...POS_RIGHT[(pos - 1) % 3][r] };
}

export function getPosition(side: number, pos: number): Pt {
  const c = (pos - 1) % 3;
  const r = Math.ceil(pos / 3) - 1;
  return { ...(side === 1 ? POS_LEFT : POS_RIGHT)[c][r] };
}

export function attackPointByPos(pos: number, face: number, dx = 1): Pt {
  const p = rolePointByPos(pos, face);
  return { x: face === 1 ? p.x + dx + 120 : p.x - dx - 120, y: p.y };
}

export const TEAM_CENTER_LEFT = POS_LEFT[1][1];
export const TEAM_CENTER_RIGHT = POS_RIGHT[1][1];

export const CAMERA_X = 650;

export function sceneSize(stageW: number, stageH: number): { w: number; h: number } {
  const clamp = (v: number, a: number, b: number) => Math.max(a, Math.min(b, v));
  return { w: clamp(stageW, 1000, 1500), h: clamp(stageH, 600, 900) };
}

export interface CameraState { w: number; h: number; cameraX: number; cameraY: number; zoom: number }

export function defaultCamera(w: number, h: number): CameraState {
  return { w, h, cameraX: CAMERA_X, cameraY: 900 - h * 0.5, zoom: 1 };
}

export function cameraTransform(c: CameraState): { sceneX: number; sceneY: number; scale: number; layerX: (coef: number) => number } {
  const cx = c.w / 2;
  const cy = c.h;
  return {
    scale: c.zoom,
    sceneY: -(c.cameraY * c.zoom - cy * 0.5),
    sceneX: -(750 - cx),
    layerX: (coef: number) => -(c.cameraX - cx) * coef,
  };
}
