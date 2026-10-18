import { Ticker } from 'pixi.js';

export interface Tickable {
  advanceFrame(): void;
  destroyed: boolean;
}

class FrameClock {
  fps = 24;
  private items = new Set<Tickable>();
  readonly before: (() => void)[] = [];
  readonly after: (() => void)[] = [];
  private acc = 0;
  paused = false;

  start(ticker: Ticker): void {
    ticker.add(() => {
      if (this.paused) return;
      this.acc += ticker.deltaMS;
      const step = 1000 / this.fps;
      let n = 0;
      while (this.acc >= step && n < 4) {
        this.acc -= step;
        this.tick();
        n++;
      }
      if (n === 4) this.acc = 0;
    });
  }

  tick(): void {
    for (const h of this.before) h();
    for (const it of [...this.items]) {
      if (it.destroyed) this.items.delete(it);
      else {
        try { it.advanceFrame(); } catch (err) { console.error('[clock] erro em script de quadro', err); }
      }
    }
    for (const h of this.after) h();
  }

  add(it: Tickable): void { this.items.add(it); }
  remove(it: Tickable): void { this.items.delete(it); }
  get size(): number { return this.items.size; }
}

export const FlashClock = new FrameClock();
