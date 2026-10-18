import type { Container } from 'pixi.js';

export const ComponentSetting = {
  BUTTON_PRESS_START_TIME: 500,
  BUTTON_PRESS_STEP_TIME: 100,
  COMBOBOX_HIDE_TIME: 0,
  COMBOBOX_SHOW_TIME: 0.5,
  SIMPLE_ALERT_STYLE: 'SimpleAlert',
  FUNCTION_ALERT_STLE: 'FunctionAlert',
  SIMPLE_BITMAP_BUTTON_FILTER: 'null,lightFilter,null,grayFilter',
  ALERT_BUTTON_GAPE: 30,
  SCROLL_UINT_INCREMENT: 1,
  SCROLL_BLOCK_INCREMENT: 20,
  DISPLACEMENT_OFFSET: 1,
  COMBOX_LIST_LAYER: null as Container | null,
  COMBOBOX_HIDE_EASE_FUNCTION: (t: number): number => 1 - Math.cos((t * Math.PI) / 2),
  COMBOBOX_SHOW_EASE_FUNCTION: (t: number): number => -(Math.cos(Math.PI * t) - 1) / 2,
};
