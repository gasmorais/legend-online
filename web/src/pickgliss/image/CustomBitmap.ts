import { Bitmap } from '@/flash/display';
import type { BitmapData } from '@/flash/library';

export class CustomBitmap extends Bitmap {
  constructor(bitmapData: BitmapData | null = null, pixelSnapping = 'auto', smoothing = false) {
    super(bitmapData, pixelSnapping, smoothing);
  }

  get btimapData(): BitmapData | null { return this.bitmapData; }

  dispose(): void { this.parent?.removeChild(this); }
}

import { Domain } from '@/flash/library';
Domain.registerClass('com.pickgliss.ui.image.CustomBitmap', CustomBitmap);
