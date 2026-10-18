import { Bitmap } from '@/flash/display';
import { Domain } from '@/flash/library';
import { TextField } from '@/flash/text';
import { toBool, toNum } from '../utils/DisplayUtils';
import { AbstractTextButton } from './AbstractTextButton';

export class TextButton extends AbstractTextButton {
  protected _autoCenter = true;
  protected _offSetX = 0;
  protected _offSetY = 0;

  protected override onProppertiesUpdate(): void {
    super.onProppertiesUpdate();
    this.updataOtherPropperties();
  }

  protected updataOtherPropperties(): void {
    const back = this._back;
    if (!back) return;
    if (this._textField instanceof TextField && this._autoCenter && back instanceof Bitmap) {
      const tf = this._textField;
      tf.autoSize = 'left';
      back.x = 0;
      back.y = 0;
      tf.x = (back.width - tf.width) / 2;
      tf.y = (back.height - tf.textHeight) / 2 - 2;
      tf.x += this._offSetX;
      tf.y += this._offSetY;
    }
  }

  get autoCenter(): boolean { return this._autoCenter; }
  set autoCenter(v: boolean) {
    this._autoCenter = toBool(v);
    this.updataOtherPropperties();
  }

  get offSetX(): number { return this._offSetX; }
  set offSetX(v: number) {
    this._offSetX = toNum(v);
    this.updataOtherPropperties();
  }

  get offSetY(): number { return this._offSetY; }
  set offSetY(v: number) {
    this._offSetY = toNum(v);
    this.updataOtherPropperties();
  }
}

Domain.registerClass('com.pickgliss.ui.controls.TextButton', TextButton);
