import type { FederatedPointerEvent } from 'pixi.js';
import { listen } from '@/flash/events';
import { Domain } from '@/flash/library';
import { ComponentFactory } from '../../ComponentFactory';
import { FrameEvent } from '../../events';
import { disposeObject } from '../../ObjectUtils';
import { StageReferance } from '../../toplevel/StageReferance';
import { DisplayUtils, toInt } from '../../utils/DisplayUtils';
import type { AlertInfo } from '../../vo/AlertInfo';
import type { BaseButton } from '../BaseButton';
import { Frame, type FrameKeyboardEvent } from '../Frame';
import { SelectedCheckButton } from '../SelectedCheckButton';
import { SelectedTextButton } from '../SelectedTextButton';
import { TextButton } from '../TextButton';

type Fn = ((...a: any[]) => unknown) | null;

export class BaseAlerFrame extends Frame {
  static readonly P_buttonToBottom = 'buttonToBottom';
  static readonly P_cancelButton = 'submitButton';
  static readonly P_info = 'info';
  static readonly P_submitButton = 'submitButton';
  protected _buttonToBottom = 0;
  protected _cancelButton: BaseButton | null = null;
  protected _cancelButtonStyle = '';
  protected _info: AlertInfo | null = null;
  protected _closeSoundFunc: Fn = null;
  protected _submitSoundFunc: Fn = null;
  protected _submitButton: BaseButton | null = null;
  protected _submitButtonStyle = '';

  get buttonToBottom(): number { return this._buttonToBottom; }
  set buttonToBottom(v: number) {
    v = toInt(v);
    if (this._buttonToBottom === v) return;
    this._buttonToBottom = v;
    this.onPropertiesChanged('buttonToBottom');
  }

  set cancelButtonEnable(v: boolean) { if (this._cancelButton) this._cancelButton.enable = v; }

  get cancelButtonStyle(): string { return this._cancelButtonStyle; }
  set cancelButtonStyle(v: string) {
    if (this._cancelButtonStyle === v) return;
    this._cancelButtonStyle = v;
    this._cancelButton = ComponentFactory.Instance.creat(this._cancelButtonStyle);
    this.onPropertiesChanged('submitButton');
  }

  override dispose(): void {
    const focus = StageReferance.focus;
    if (focus && DisplayUtils.isTargetOrContain(focus, this)) StageReferance.focus = null;
    if (this._submitButton) {
      this._submitButton.off('pointertap', this.__onSubmitClick, this);
      disposeObject(this._submitButton);
      this._submitButton = null;
    }
    if (this._cancelButton) {
      this._cancelButton.off('pointertap', this.__onCancelClick, this);
      disposeObject(this._cancelButton);
      this._cancelButton = null;
    }
    if (this._info) this._info.off('stateChange', this.__onInfoChanged, this);
    this._info = null;
    super.dispose();
  }

  get info(): AlertInfo | null { return this._info; }
  set info(v: AlertInfo | null) {
    if (this._info === v) return;
    if (this._info) this._info.off('stateChange', this.__onInfoChanged, this);
    this._info = v;
    this._info?.on('stateChange', this.__onInfoChanged, this);
    this.onPropertiesChanged('info');
  }

  set submitButtonEnable(v: boolean) { if (this._submitButton) this._submitButton.enable = v; }

  get submitButtonStyle(): string { return this._submitButtonStyle; }
  set submitButtonStyle(v: string) {
    if (this._submitButtonStyle === v) return;
    this._submitButtonStyle = v;
    this._submitButton = ComponentFactory.Instance.creat(this._submitButtonStyle);
    this.onPropertiesChanged('submitButton');
  }

  protected __onCancelClick(e: FederatedPointerEvent): void {
    if (this._closeSoundFunc) this._closeSoundFunc();
    this.onResponse(FrameEvent.CANCEL_CLICK);
    e?.stopPropagation?.();
  }

  protected override __onCloseClick(e?: unknown): void {
    if (this._closeSoundFunc) this._closeSoundFunc();
    super.__onCloseClick(e);
    (e as FederatedPointerEvent | undefined)?.stopPropagation?.();
  }

  protected override __onKeyDown(e: FrameKeyboardEvent): void {
    if (e.keyCode === 27 && this._closeSoundFunc) this._closeSoundFunc();
    if (e.keyCode === 13 && this._submitSoundFunc) this._submitSoundFunc(true);
    super.__onKeyDown(e);
  }

  protected __onSubmitClick(e: FederatedPointerEvent): void {
    if (this._submitSoundFunc) this._submitSoundFunc();
    this.onResponse(FrameEvent.SUBMIT_CLICK);
    e?.stopPropagation?.();
  }

  protected override addChildren(): void {
    super.addChildren();
    if (this._submitButton) this.addChild(this._submitButton);
    if (this._cancelButton) this.addChild(this._cancelButton);
  }

  protected override onProppertiesUpdate(): void {
    const ch = this._changedPropeties;
    const info = this._info;
    if (ch.info && info) {
      this._closeSoundFunc = info.closeSoundFunc;
      this._submitSoundFunc = info.submitSoundFunc;
      this._escEnable = info.escEnable;
      this._enterEnable = info.enterEnable;
      this._titleText = info.title;
      ch.titleText = true;
      this._moveEnable = info.moveEnable;
      ch.moveEnable = true;
    }
    super.onProppertiesUpdate();
    if (ch.info || ch.submitButton) {
      if (this._cancelButton && info) {
        this._cancelButton.visible = info.showCancel;
        this.setLabel(this._cancelButton, info.cancelLabel);
        if (this._cancelButton.visible) listen(this._cancelButton, 'pointertap', this.__onCancelClick, this);
      }
      if (this._submitButton && info) {
        this._submitButton.visible = info.showSubmit;
        this.setLabel(this._submitButton, info.submitLabel);
        if (this._submitButton.visible) listen(this._submitButton, 'pointertap', this.__onSubmitClick, this);
      }
    }
    if (ch.info || ch.height || ch.width || ch.buttonToBottom) this.updatePos();
  }

  private setLabel(btn: BaseButton, label: string): void {
    if (btn instanceof TextButton) btn.text = label;
    if (btn instanceof SelectedCheckButton) btn.text = label;
    if (btn instanceof SelectedTextButton) btn.text = label;
  }

  protected override onResponse(code: number, obj = true): void {
    if (this._info?.autoDispose) this.dispose();
    super.onResponse(code, obj);
  }

  protected updatePos(): void {
    const info = this._info;
    if (!info) return;
    const submit = this._submitButton, cancel = this._cancelButton;
    if (info.bottomGap) this._buttonToBottom = info.bottomGap;
    if (submit) submit.y = this._height - submit.height - this._buttonToBottom;
    if (cancel) cancel.y = this._height - cancel.height - this._buttonToBottom;
    if (!(info.showCancel || info.showSubmit)) return;
    if (info.customPos) {
      if (submit) {
        submit.x = info.customPos.x;
        if (cancel) {
          cancel.x = info.customPos.x + cancel.width + info.buttonGape;
          cancel.y = info.customPos.y;
        }
        submit.y = info.customPos.y;
      } else if (cancel) {
        cancel.x = info.customPos.x;
        cancel.y = info.customPos.y;
      }
      return;
    }
    if (info.autoButtonGape && submit && cancel) {
      info.buttonGape = (this._width - submit.width - cancel.width) / 2;
    }
    if (!info.showCancel && submit) {
      submit.x = (this._width - submit.width) / 2;
    } else if (!info.showSubmit && cancel) {
      cancel.x = (this._width - cancel.width) / 2;
    } else if (cancel && submit) {
      submit.x = (this._width - submit.width - cancel.width - info.buttonGape) / 2;
      cancel.x = submit.x + submit.width + info.buttonGape;
    }
  }

  get submitButton(): BaseButton | null { return this._submitButton; }

  private __onInfoChanged(): void { this.onPropertiesChanged('info'); }
}

Domain.registerClass('com.pickgliss.ui.controls.alert.BaseAlerFrame', BaseAlerFrame);
