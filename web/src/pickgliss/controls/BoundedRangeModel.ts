import { EventDispatcher } from '@/flash/events';
import { Domain } from '@/flash/library';
import { InteractiveEvent } from '../events';

const int = (v: unknown): number => Number(v) | 0;

export class BoundedRangeModel extends EventDispatcher {
  private value: number;
  private extent: number;
  private min: number;
  private max: number;
  private isAdjusting = false;

  constructor(value = 0, extent = 0, min = 0, max = 100) {
    super();
    value = int(value); extent = int(extent); min = int(min); max = int(max);
    if (max >= min && value >= min && value + extent >= value && value + extent <= max) {
      this.value = value;
      this.extent = extent;
      this.min = min;
      this.max = max;
      return;
    }
    throw new RangeError('invalid range properties');
  }

  getValue(): number { return this.value; }
  getExtent(): number { return this.extent; }
  getMinimum(): number { return this.min; }
  getMaximum(): number { return this.max; }

  setValue(v: number): void {
    v = Math.min(int(v), this.max - this.extent);
    const nv = Math.max(v, this.min);
    this.setRangeProperties(nv, this.extent, this.min, this.max, this.isAdjusting);
  }

  setExtent(v: number): void {
    let e = Math.max(0, int(v));
    if (this.value + e > this.max) e = this.max - this.value;
    this.setRangeProperties(this.value, e, this.min, this.max, this.isAdjusting);
  }

  setMinimum(v: number): void {
    v = int(v);
    const nmax = Math.max(v, this.max);
    const nval = Math.max(v, this.value);
    const next = Math.min(nmax - nval, this.extent);
    this.setRangeProperties(nval, next, v, nmax, this.isAdjusting);
  }

  setMaximum(v: number): void {
    v = int(v);
    const nmin = Math.min(v, this.min);
    const next = Math.min(v - nmin, this.extent);
    const nval = Math.min(v - next, this.value);
    this.setRangeProperties(nval, next, nmin, v, this.isAdjusting);
  }

  setValueIsAdjusting(b: boolean): void {
    this.setRangeProperties(this.value, this.extent, this.min, this.max, b);
  }

  getValueIsAdjusting(): boolean { return this.isAdjusting; }

  setRangeProperties(value: number, extent: number, min: number, max: number, adjusting: boolean): void {
    value = int(value); extent = int(extent); min = int(min); max = int(max);
    if (min > max) min = max;
    if (value > max) max = value;
    if (value < min) min = value;
    if (extent + value > max) extent = max - value;
    if (extent < 0) extent = 0;
    const changed = value !== this.value || extent !== this.extent || min !== this.min || max !== this.max || adjusting !== this.isAdjusting;
    if (changed) {
      this.value = value;
      this.extent = extent;
      this.min = min;
      this.max = max;
      this.isAdjusting = adjusting;
      this.fireStateChanged();
    }
  }

  addStateListener(fn: (...a: any[]) => void, _priority = 0, _useWeak = false, context?: unknown): void {
    this.on(InteractiveEvent.STATE_CHANGED, fn, context);
  }

  removeStateListener(fn: (...a: any[]) => void, context?: unknown): void {
    this.off(InteractiveEvent.STATE_CHANGED, fn, context);
  }

  protected fireStateChanged(): void { this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED)); }

  override toString(): string {
    return `BoundedRangeModel[value=${this.value}, extent=${this.extent}, min=${this.min}, max=${this.max}, adj=${this.isAdjusting}]`;
  }
}

Domain.registerClass('com.pickgliss.ui.controls.BoundedRangeModel', BoundedRangeModel);
