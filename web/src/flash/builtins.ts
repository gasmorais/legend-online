import { Container } from 'pixi.js';
import type { FlashFilterDef } from './filters';
import { Domain } from './library';
import { Sprite, FlashShape } from './sprite';
import { TextField, TextFormat } from './text';
import { Bitmap, MovieClip } from './display';

import { BlurFilter, ColorMatrixFilter, DropShadowFilter, GlowFilter } from '@/as3/flash/filters';
import { Point, Rectangle as FlashRectangle } from '@/as3/flash/geom';

export { GlowFilter, DropShadowFilter, Point, FlashRectangle };
export { BlurFilter as BlurFilterDef, ColorMatrixFilter as ColorMatrixFilterDef };
const BlurFilterDef = BlurFilter;
const ColorMatrixFilterDef = ColorMatrixFilter;

export function filterDefs(list: unknown[] | null | undefined): FlashFilterDef[] {
  return (list ?? []).flatMap((f) => (f && typeof f === 'object' && 'def' in f ? [(f as { def: FlashFilterDef }).def] : []));
}

Domain.registerClass('flash.filters.GlowFilter', GlowFilter);
Domain.registerClass('flash.filters.DropShadowFilter', DropShadowFilter);
Domain.registerClass('flash.filters.BlurFilter', BlurFilterDef);
Domain.registerClass('flash.filters.ColorMatrixFilter', ColorMatrixFilterDef);
Domain.registerClass('flash.text.TextFormat', TextFormat);
Domain.registerClass('flash.text.TextField', TextField);
Domain.registerClass('flash.geom.Point', Point);
Domain.registerClass('flash.geom.Rectangle', FlashRectangle);
Domain.registerClass('flash.display.Sprite', Sprite);
Domain.registerClass('flash.display.Shape', FlashShape);
Domain.registerClass('flash.display.MovieClip', MovieClip);
Domain.registerClass('flash.display.Bitmap', Bitmap);
Domain.registerClass('flash.display.DisplayObjectContainer', Container);

export { MovieClip };
