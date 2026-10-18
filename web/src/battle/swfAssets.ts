import type { Container } from 'pixi.js';
import { Domain, SwfLibrary } from '@/flash/library';
import { MovieClip } from '@/flash/display';

export interface BattleLibInfo { kind: 'map' | 'unit' | 'effect'; linkage: string[]; labels: Record<string, Record<string, number>>; fps: number }

let indexPromise: Promise<Record<string, BattleLibInfo>> | null = null;
const libs = new Map<string, Promise<SwfLibrary | null>>();

export function battleIndex(): Promise<Record<string, BattleLibInfo>> {
  indexPromise ??= fetch('/battle/index.json').then((r) => (r.ok ? r.json() : {})).catch(() => ({}));
  return indexPromise;
}

export function loadBattleLib(name: string): Promise<SwfLibrary | null> {
  let p = libs.get(name);
  if (!p) {
    p = SwfLibrary.load(`../battle/${name}`).catch(() => null);
    libs.set(name, p);
  }
  return p;
}

export function createSymbol(lib: SwfLibrary, cls: string): Container | null {
  const id = lib.data.linkage[cls];
  if (id === undefined) return null;
  return Domain.createChar(lib, id, cls) as Container;
}

export async function createBattleMap(ground: number): Promise<Container | null> {
  const lib = await loadBattleLib(`map${ground}`);
  if (!lib) return null;
  await Promise.all(Object.entries(lib.data.chars).filter(([, c]) => c.src).map(([id]) => lib.texture(Number(id))));
  return createSymbol(lib, 'ClassExport');
}

export async function createUnitMovie(res: string): Promise<MovieClip | null> {
  const lib = await loadBattleLib(res);
  if (!lib) return null;
  const cls = Object.keys(lib.data.linkage).find((k) => k.toLowerCase() === `slg.resource.movie.movieasset${res}`.toLowerCase())
    ?? Object.keys(lib.data.linkage).find((k) => k.startsWith('slg.resource.movie.MovieAsset'));
  const obj = cls ? createSymbol(lib, cls) : null;
  return obj instanceof MovieClip ? obj : null;
}

type Repeat = 'REPEAT' | 'STOP' | 'WAIT_AND_GOTO';

export class ActionPlayer {
  private type = '';
  private repeat: Repeat = 'REPEAT';
  private wait = -1;
  private readonly order: [string, number][];
  onEnd: ((type: string) => void) | null = null;

  constructor(readonly mc: MovieClip) {
    this.order = Object.entries(mc.labels).sort((a, b) => a[1] - b[1]);
  }

  has(type: string): boolean { return type in this.mc.labels; }
  get labels(): string[] { return this.order.map(([n]) => n); }
  get current(): string { return this.type; }

  private finalFrame(type: string): number {
    const i = this.order.findIndex(([n]) => n === type);
    if (i < 0) return this.mc.totalFrames;
    const start = this.order[i][1];
    const len = i + 1 < this.order.length ? this.order[i + 1][1] - start : this.mc.totalFrames + 1 - start;
    return start + len - 1;
  }

  play(type: string, repeat?: Repeat): void {
    if (!this.has(type)) type = this.has('Stand') ? 'Stand' : this.order[0]?.[0] ?? '';
    if (!type) return;
    this.type = type;
    this.repeat = repeat ?? (['Stand', 'Walk', 'Ready'].includes(type) ? 'REPEAT' : ['Victory', 'Failed'].includes(type) ? 'STOP' : 'WAIT_AND_GOTO');
    this.wait = -1;
    this.mc.gotoAndPlay(type);
  }

  tick(): void {
    if (!this.type) return;
    if (this.wait >= 0) {
      if (--this.wait < 0) { this.onEnd?.(this.type); this.play('Stand'); }
      return;
    }
    const end = this.finalFrame(this.type);
    const f = this.mc.currentFrame;
    const start = this.mc.labels[this.type] ?? 1;
    if (f >= end || f < start) {
      if (this.repeat === 'REPEAT') this.mc.gotoAndPlay(this.type);
      else if (this.repeat === 'STOP') this.mc.gotoAndStop(end);
      else { this.mc.gotoAndStop(end); this.wait = 5; }
    }
  }
}
