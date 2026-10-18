package setting
{
   import battle.events.BattleEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.Silder;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.DesktopManager;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.BaseManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SettingFrame extends Frame
   {
      
      private var _back1:MovieClip;
      
      private var _back2:ScaleLeftRightImage;
      
      private var _musicSetTxt:Bitmap;
      
      private var _displaySetTxt:Bitmap;
      
      private var _backMusicBtn:SelectedIconButton;
      
      private var _smallTxt1:ScaleBitmapImage;
      
      private var _bigTxt1:ScaleBitmapImage;
      
      private var _backMusicSilder:Silder;
      
      private var _musicEffectBtn:SelectedIconButton;
      
      private var _smallTxt2:ScaleBitmapImage;
      
      private var _bigTxt2:ScaleBitmapImage;
      
      private var _musicEffectSilder:Silder;
      
      private var _sceneEffectBtn:SelectedIconButton;
      
      private var _attacedEffectBtn:SelectedIconButton;
      
      private var _refuseInviteBtn:SelectedIconButton;
      
      private var _buildingNameBtn:SelectedIconButton;
      
      private var _shadowEffectBtn:SelectedIconButton;
      
      private var _refuseFriendBtn:SelectedButton;
      
      private var _refuseInvitationBtn:SelectedButton;
      
      private var _refuseTeamInviteBtn:SelectedButton;
      
      private var _hideOthersBtn:SelectedIconButton;
      
      private var _fullScreenBtn:SelectedIconButton;
      
      private var _oneKeyBtn:TextButton;
      
      private var _resourceBtn:TextButton;
      
      private var _clearanceBtn:TextButton;
      
      private var _confirmBtn:SelectedCheckButton;
      
      private var _canelBtn:SelectedCheckButton;
      
      private var _filter:IFilterFormat;
      
      private var _oldAllowMusic:Boolean;
      
      private var _oldAllowSound:Boolean;
      
      private var _oldAllowSceneEffect:Boolean;
      
      private var _oldAllowAttactedEffect:Boolean;
      
      private var _oldMusicVolumn:Number;
      
      private var _oldSoundVolumn:Number;
      
      private var _isSubmit:Boolean;
      
      private var _buildingName:Boolean;
      
      private var _shadowEffect:Boolean;
      
      private var _refuseInvite:Boolean;
      
      private var _refuseFriend:Boolean;
      
      private var _refuseTeamInvite:Boolean;
      
      private var _refuseInviteTemp:Boolean;
      
      private var _refuseFriendTemp:Boolean;
      
      private var _refuseTeamInviteTemp:Boolean;
      
      public function SettingFrame()
      {
         super();
         initView();
         initData();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creat("asset.setting.Background");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("setting.Back2");
         _musicSetTxt = ComponentFactory.Instance.creatBitmap("asset.setting.SoundSetTxt");
         _displaySetTxt = ComponentFactory.Instance.creatBitmap("asset.setting.DisplaySetTxt");
         _backMusicBtn = ComponentFactory.Instance.creatComponentByStylename("setting.BackMusicBtn");
         _smallTxt1 = ComponentFactory.Instance.creatComponentByStylename("setting.SmallTxt1");
         _bigTxt1 = ComponentFactory.Instance.creatComponentByStylename("setting.BigTxt1");
         _backMusicSilder = ComponentFactory.Instance.creatComponentByStylename("setting.BackMusicSilder");
         _musicEffectBtn = ComponentFactory.Instance.creatComponentByStylename("setting.MusicEffectBtn");
         _smallTxt2 = ComponentFactory.Instance.creatComponentByStylename("setting.SmallTxt2");
         _bigTxt2 = ComponentFactory.Instance.creatComponentByStylename("setting.BigTxt2");
         _musicEffectSilder = ComponentFactory.Instance.creatComponentByStylename("setting.MusicEffectSilder");
         _sceneEffectBtn = ComponentFactory.Instance.creatComponentByStylename("setting.SceneEffectBtn");
         _attacedEffectBtn = ComponentFactory.Instance.creatComponentByStylename("setting.AttacedEffectBtn");
         _refuseInviteBtn = ComponentFactory.Instance.creatComponentByStylename("setting.refuseInviteBtn");
         _buildingNameBtn = ComponentFactory.Instance.creatComponentByStylename("setting.BuildingNameBtn");
         _shadowEffectBtn = ComponentFactory.Instance.creatComponentByStylename("setting.ShadowEffectBtn");
         _refuseFriendBtn = ComponentFactory.Instance.creatComponentByStylename("setting.RefuseFriendBtn");
         _hideOthersBtn = ComponentFactory.Instance.creatComponentByStylename("setting.HideOthersBtn");
         _refuseInvitationBtn = ComponentFactory.Instance.creatComponentByStylename("setting.AllowInvitationBtn");
         _refuseTeamInviteBtn = ComponentFactory.Instance.creatComponentByStylename("setting.refuseTeamInviteBtn");
         _fullScreenBtn = ComponentFactory.Instance.creatComponentByStylename("setting.fullScreenBtn");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("setting.ConfirmBtn");
         _canelBtn = ComponentFactory.Instance.creatComponentByStylename("setting.CancelBtn");
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_musicSetTxt);
         addToContent(_displaySetTxt);
         addToContent(_backMusicBtn);
         addToContent(_smallTxt1);
         addToContent(_bigTxt1);
         addToContent(_backMusicSilder);
         addToContent(_musicEffectBtn);
         addToContent(_smallTxt2);
         addToContent(_bigTxt2);
         addToContent(_musicEffectSilder);
         addToContent(_sceneEffectBtn);
         addToContent(_attacedEffectBtn);
         addToContent(_refuseInviteBtn);
         addToContent(_buildingNameBtn);
         addToContent(_shadowEffectBtn);
         addToContent(_refuseFriendBtn);
         addToContent(_refuseInvitationBtn);
         addToContent(_refuseTeamInviteBtn);
         addToContent(_fullScreenBtn);
         addToContent(_confirmBtn);
         addToContent(_canelBtn);
         _filter = new UIFilter();
         _oneKeyBtn = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameBtn");
         _oneKeyBtn.text = LanguageMgr.GetTranslation("setting.SettingFrame.oneKeyBtn.text");
         _oneKeyBtn.x = 142;
         _oneKeyBtn.y = 261;
         _resourceBtn = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameBtn");
         _resourceBtn.text = LanguageMgr.GetTranslation("setting.SettingFrame.resourceBtn.text");
         _resourceBtn.x = 232;
         _resourceBtn.y = 261;
         _clearanceBtn = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameBtn");
         _clearanceBtn.text = "";
         _clearanceBtn.x = 142;
         _clearanceBtn.y = 290;
         _titleText = LanguageMgr.GetTranslation("setting.SettingFrame.title");
      }
      
      protected function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _musicEffectBtn.addEventListener("click",__musicEffectBtnClick);
         _backMusicBtn.addEventListener("click",__backMusicBtnClick);
         _backMusicSilder.addEventListener("stateChange",__backSilderHandler);
         _musicEffectSilder.addEventListener("stateChange",__effectilderHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4193,__uRefusefriend);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4194,__uRefuseInvite);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4635,__uRefuseTeamInvite);
         _refuseInviteBtn.addEventListener("click",__refuseInviteClick);
         _buildingNameBtn.addEventListener("click",__buildingNameClick);
         _shadowEffectBtn.addEventListener("click",__shadowEffectClick);
         _refuseFriendBtn.addEventListener("click",__refuseFriendClick);
         _refuseInvitationBtn.addEventListener("click",___allowInvitationClick);
         _refuseTeamInviteBtn.addEventListener("click",___allowTeamInviteClick);
         _confirmBtn.addEventListener("click",__confirmClick);
         _canelBtn.addEventListener("click",__cancelClick);
         _attacedEffectBtn.addEventListener("click",__attackEffectClick);
         _sceneEffectBtn.addEventListener("click",__sceneEffectClick);
         _clearanceBtn.addEventListener("click",__onClearanceClick);
         _hideOthersBtn.addEventListener("click",__hideOthersClick);
         _fullScreenBtn.addEventListener("click",__fullScreenClick);
         StageReferance.stage.addEventListener("fullScreen",__fullScreenHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4193,__uRefusefriend);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4194,__uRefuseInvite);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4635,__uRefuseTeamInvite);
         removeEventListener("response",__frameResponse);
         _backMusicSilder.removeEventListener("stateChange",__backSilderHandler);
         _musicEffectSilder.removeEventListener("stateChange",__effectilderHandler);
         _musicEffectBtn.removeEventListener("click",__musicEffectBtnClick);
         _backMusicBtn.removeEventListener("click",__backMusicBtnClick);
         _refuseInviteBtn.removeEventListener("click",__refuseInviteClick);
         _buildingNameBtn.removeEventListener("click",__buildingNameClick);
         _shadowEffectBtn.removeEventListener("click",__shadowEffectClick);
         _refuseFriendBtn.removeEventListener("click",__refuseFriendClick);
         _refuseInvitationBtn.removeEventListener("click",___allowInvitationClick);
         _refuseTeamInviteBtn.removeEventListener("click",___allowTeamInviteClick);
         _confirmBtn.removeEventListener("click",__confirmClick);
         _canelBtn.removeEventListener("click",__cancelClick);
         _attacedEffectBtn.removeEventListener("click",__attackEffectClick);
         _sceneEffectBtn.removeEventListener("click",__sceneEffectClick);
         _clearanceBtn.removeEventListener("click",__onClearanceClick);
         _hideOthersBtn.removeEventListener("click",__hideOthersClick);
         _fullScreenBtn.removeEventListener("click",__fullScreenClick);
         StageReferance.stage.removeEventListener("fullScreen",__fullScreenHandler);
      }
      
      private function __fullScreenClick(param1:MouseEvent) : void
      {
         if(DesktopManager.Instance.isDesktop)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("setting.SettingFrame.fullScreenBtn.Tips"));
            return;
         }
         if(StageReferance.stage.displayState == "fullScreenInteractive")
         {
            StageReferance.stage.displayState = "normal";
         }
         else if(StageReferance.stage.displayState == "normal")
         {
            StageReferance.stage.displayState = "fullScreenInteractive";
         }
         setScreenBtnVisible();
      }
      
      private function __fullScreenHandler(param1:Event) : void
      {
         setScreenBtnVisible();
      }
      
      private function setScreenBtnVisible() : void
      {
         if(StageReferance.stage.displayState == "fullScreenInteractive")
         {
            _fullScreenBtn.selected = true;
         }
         else if(StageReferance.stage.displayState == "normal")
         {
            _fullScreenBtn.selected = false;
         }
      }
      
      private function __onClearanceClick(param1:MouseEvent) : void
      {
      }
      
      private function __uRefusefriend(param1:SLGSocketEvent) : void
      {
         _refuseFriendBtn.selected = PlayerManager.instance.currentPlayerModel.playerInfo.refuseFriend;
      }
      
      private function __uRefuseInvite(param1:SLGSocketEvent) : void
      {
         _refuseInviteBtn.selected = PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite;
      }
      
      private function __uRefuseTeamInvite(param1:SLGSocketEvent) : void
      {
         _refuseTeamInviteBtn.selected = PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite;
      }
      
      private function initData() : void
      {
         _backMusicSilder.minimum = 0;
         _backMusicSilder.maximum = 100;
         _musicEffectSilder.minimum = 0;
         _musicEffectSilder.maximum = 100;
         _oldAllowMusic = _backMusicBtn.selected = SharedManager.instance.allowMusic;
         _oldAllowSound = _musicEffectBtn.selected = SharedManager.instance.allowSound;
         _oldAllowSceneEffect = _sceneEffectBtn.selected = SharedManager.instance.allowSceneEffect;
         _oldAllowAttactedEffect = _attacedEffectBtn.selected = SharedManager.instance.allowAttactedEffect;
         _buildingName = _buildingNameBtn.selected = SharedManager.instance.buildingName;
         _shadowEffect = _shadowEffectBtn.selected = SharedManager.instance.shadowEffect;
         _refuseInvitationBtn.selected = SharedManager.instance.refuseInvitation;
         _hideOthersBtn.selected = SharedManager.instance.hideOthers;
         _refuseInvite = _refuseInviteBtn.selected = PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite;
         _refuseFriend = _refuseFriendBtn.selected = PlayerManager.instance.currentPlayerModel.playerInfo.refuseFriend;
         _refuseTeamInvite = _refuseTeamInviteBtn.selected = PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite;
         _oldMusicVolumn = _backMusicSilder.value = SharedManager.instance.musicVolumn;
         _oldSoundVolumn = _musicEffectSilder.value = SharedManager.instance.soundVolumn;
         setScreenBtnVisible();
         setEnable(_smallTxt1,_bigTxt1,_backMusicSilder,_oldAllowMusic);
         setEnable(_smallTxt2,_bigTxt2,_musicEffectSilder,_oldAllowSound);
         _refuseInviteTemp = _refuseInvite;
         _refuseFriendTemp = _refuseFriend;
         _refuseTeamInviteTemp = _refuseTeamInvite;
      }
      
      private function setEnable(param1:DisplayObject, param2:DisplayObject, param3:Silder, param4:Boolean) : void
      {
         param3.mouseEnabled = param4;
         param3.mouseChildren = param4;
         if(param4)
         {
            _filter.setNormalFilter(param1);
            _filter.setNormalFilter(param2);
            _filter.setNormalFilter(param3);
         }
         else
         {
            _filter.setGrayFilter(param1);
            _filter.setGrayFilter(param2);
            _filter.setGrayFilter(param3);
         }
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _isSubmit = true;
         dispose();
      }
      
      private function __cancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _isSubmit = false;
         dispose();
      }
      
      private function __backMusicSilderchange(param1:InteractiveEvent) : void
      {
      }
      
      private function __musicEffectSilderchange(param1:InteractiveEvent) : void
      {
      }
      
      private function __musicEffectBtnClick(param1:MouseEvent) : void
      {
         SharedManager.instance.allowSound = _musicEffectBtn.selected;
         SoundManager.instance.allowSound = _musicEffectBtn.selected;
         NotificationManager.instance.dispatchEvent(new BattleEvent("battleMusicOnOff",null));
         setEnable(_smallTxt2,_bigTxt2,_musicEffectSilder,_musicEffectBtn.selected);
      }
      
      private function __backMusicBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.allowMusic = _backMusicBtn.selected;
         setEnable(_smallTxt1,_bigTxt1,_backMusicSilder,_backMusicBtn.selected);
      }
      
      private function __attackEffectClick(param1:MouseEvent) : void
      {
         SharedManager.instance.allowAttactedEffect = _attacedEffectBtn.selected;
      }
      
      private function __sceneEffectClick(param1:MouseEvent) : void
      {
         if(SharedManager.instance.allowSceneEffect != _sceneEffectBtn.selected)
         {
            SharedManager.instance.allowSceneEffect = _sceneEffectBtn.selected;
            NotificationManager.instance.dispatchEvent(new BattleEvent("sceneEffectClose",null));
         }
      }
      
      private function __sceneEffectBtnClick(param1:MouseEvent) : void
      {
      }
      
      private function __attactedEffectBtnClick(param1:MouseEvent) : void
      {
      }
      
      private function __refuseInviteClick(param1:MouseEvent) : void
      {
         SocketSendManager.instance.sendRefuseInvite();
         _refuseInviteTemp = !_refuseInviteTemp;
      }
      
      private function __buildingNameClick(param1:MouseEvent) : void
      {
         BuildingManager.instance.isShowBuildingName = _buildingNameBtn.selected;
      }
      
      private function __shadowEffectClick(param1:MouseEvent) : void
      {
         SharedManager.instance.shadowEffect = _shadowEffectBtn.selected;
      }
      
      private function __refuseFriendClick(param1:MouseEvent) : void
      {
         SocketSendManager.instance.sendFriendRefuse();
         _refuseFriendTemp = !_refuseFriendTemp;
      }
      
      private function __hideOthersClick(param1:MouseEvent) : void
      {
         if(SharedManager.instance.hideOthers != _hideOthersBtn.selected)
         {
            SharedManager.instance.hideOthers = _hideOthersBtn.selected;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",null));
         }
      }
      
      private function ___allowInvitationClick(param1:MouseEvent) : void
      {
      }
      
      private function ___allowTeamInviteClick(param1:MouseEvent) : void
      {
         SocketSendManager.instance.sendRefuseTeamInvite();
         _refuseTeamInviteTemp = !_refuseTeamInviteTemp;
      }
      
      private function __backSilderHandler(param1:Event) : void
      {
         SharedManager.instance.musicVolumn = int(_backMusicSilder.value);
         SharedManager.instance.allowSound = _musicEffectBtn.selected;
         SharedManager.instance.allowMusic = _backMusicBtn.selected;
         SharedManager.instance.save();
      }
      
      private function __effectilderHandler(param1:Event) : void
      {
         SharedManager.instance.soundVolumn = int(_musicEffectSilder.value);
         SharedManager.instance.allowSound = _musicEffectBtn.selected;
         SharedManager.instance.allowMusic = _backMusicBtn.selected;
         SharedManager.instance.save();
      }
      
      private function submit() : void
      {
         BaseManager.isMusicOn = _backMusicBtn.selected;
         BaseManager.isSoundOn = _musicEffectBtn.selected;
         SharedManager.instance.musicVolumn = int(_backMusicSilder.value);
         SharedManager.instance.soundVolumn = int(_musicEffectSilder.value);
         SharedManager.instance.allowSound = _musicEffectBtn.selected;
         SharedManager.instance.allowMusic = _backMusicBtn.selected;
         if(SharedManager.instance.allowSceneEffect != _sceneEffectBtn.selected)
         {
            SharedManager.instance.allowSceneEffect = _sceneEffectBtn.selected;
            NotificationManager.instance.dispatchEvent(new BattleEvent("sceneEffectClose",null));
         }
         SharedManager.instance.allowAttactedEffect = _attacedEffectBtn.selected;
         SharedManager.instance.buildingName = _buildingNameBtn.selected;
         SharedManager.instance.shadowEffect = _shadowEffectBtn.selected;
         SharedManager.instance.refuseInvitation = _refuseInvitationBtn.selected;
         SharedManager.instance.save();
      }
      
      private function revert() : void
      {
         SharedManager.instance.musicVolumn = _oldMusicVolumn;
         SharedManager.instance.soundVolumn = _oldSoundVolumn;
         SharedManager.instance.allowSound = _oldAllowSound;
         SharedManager.instance.allowMusic = _oldAllowMusic;
         if(SharedManager.instance.allowSceneEffect != _oldAllowSceneEffect)
         {
            SharedManager.instance.allowSceneEffect = _oldAllowSceneEffect;
            NotificationManager.instance.dispatchEvent(new BattleEvent("sceneEffectClose",null));
         }
         SharedManager.instance.allowSceneEffect = _oldAllowSceneEffect;
         SharedManager.instance.allowAttactedEffect = _oldAllowAttactedEffect;
         SharedManager.instance.buildingName = _buildingName;
         BuildingManager.instance.isShowBuildingName = _buildingName;
         SharedManager.instance.shadowEffect = _shadowEffect;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite != _refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.refuseFriend != _refuseFriend)
         {
            SocketSendManager.instance.sendFriendRefuse();
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite != _refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
         SharedManager.instance.save();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(!_isSubmit)
         {
            revert();
         }
         else
         {
            submit();
         }
         uninit();
         super.dispose();
      }
   }
}

