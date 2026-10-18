import type { Renderer } from 'pixi.js';

export const FlashMode = {
  interactive: false,
  renderer: null as Renderer | null,
};

export function withInteractive<T>(v: boolean, fn: () => T): T {
  const prev = FlashMode.interactive;
  FlashMode.interactive = v;
  try { return fn(); } finally { FlashMode.interactive = prev; }
}
