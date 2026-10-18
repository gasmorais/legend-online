package ui.tasktracebar.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.DesktopManager;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SelfHelpButtonView extends Sprite
   {
      
      private var _selfHelpButton:BaseButton;
      
      private var _fullScreenButton:BaseButton;
      
      private var _quitFullScreenButton:BaseButton;
      
      private var _shieldBtn:BaseButton;
      
      private var _cancelShieldBtn:BaseButton;
      
      public function SelfHelpButtonView()
      {
         super();
         initView();
         addEvent();
         setSelfHelpBtnVisible();
         setScreenBtnVisible();
         updateShieldBtnVisible();
      }
      
      private function initView() : void
      {
         _selfHelpButton = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.SelfHelpButton");
         _fullScreenButton = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.FullScreenButton");
         _quitFullScreenButton = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.QuitFullScreenButton");
         _shieldBtn = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.shieldBtn");
         _cancelShieldBtn = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.cancelShieldBtn");
         _selfHelpButton.tipData = LanguageMgr.GetTranslation("ui.tasktracebar.view.SelfHelpButtonView.BtnTip");
         _fullScreenButton.tipData = LanguageMgr.GetTranslation("ui.tasktracebar.view.SelfHelpButtonView.FullScreenBtnTip");
         _quitFullScreenButton.tipData = LanguageMgr.GetTranslation("ui.tasktracebar.view.SelfHelpButtonView.QuitFullScreenBtnTip");
         _shieldBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersHideBtnTipData");
         _cancelShieldBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersShowBtnTipData");
         addChild(_selfHelpButton);
         addChild(_shieldBtn);
         addChild(_cancelShieldBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_selfHelpButton);
         _selfHelpButton = null;
         ObjectUtils.disposeObject(_fullScreenButton);
         _fullScreenButton = null;
         ObjectUtils.disposeObject(_quitFullScreenButton);
         _quitFullScreenButton = null;
         ObjectUtils.disposeObject(_shieldBtn);
         _shieldBtn = null;
         ObjectUtils.disposeObject(_cancelShieldBtn);
         _cancelShieldBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _selfHelpButton.addEventListener("click",__selfHelpButtonClickHandler);
         _fullScreenButton.addEventListener("click",__screenButtonClickHandler);
         _quitFullScreenButton.addEventListener("click",__screenButtonClickHandler);
         _shieldBtn.addEventListener("click",__switchShieldHandler);
         _cancelShieldBtn.addEventListener("click",__switchShieldHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         StageReferance.stage.addEventListener("fullScreen",__fullScreenHandler);
         MsgMan.addObserver("CampaignEvent.PET_BOSS_SWITCH",null,__petlandBossHandler);
      }
      
      private function removeEvent() : void
      {
         _selfHelpButton.removeEventListener("click",__selfHelpButtonClickHandler);
         _fullScreenButton.removeEventListener("click",__screenButtonClickHandler);
         _quitFullScreenButton.removeEventListener("click",__screenButtonClickHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         StageReferance.stage.removeEventListener("fullScreen",__fullScreenHandler);
         MsgMan.removeObserver("CampaignEvent.PET_BOSS_SWITCH",null,__petlandBossHandler);
      }
      
      private function __selfHelpButtonClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("ui.tasktracebar.view.SelfHelpButtonView.TipTxt");
         MessageTipManager.instance().show(_loc2_);
         NotificationManager.instance.sendNotification("SELF_HELP_RESET_POSITION");
      }
      
      private function __screenButtonClickHandler(param1:MouseEvent) : void
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
            _fullScreenButton.visible = false;
            _quitFullScreenButton.visible = true;
         }
         else if(StageReferance.stage.displayState == "normal")
         {
            _fullScreenButton.visible = true;
            _quitFullScreenButton.visible = false;
         }
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         setSelfHelpBtnVisible();
         updateShieldBtnVisible();
      }
      
      private function __petlandBossHandler(param1:String, param2:Object) : void
      {
         updateShieldBtnVisible();
      }
      
      private function setSelfHelpBtnVisible() : void
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _selfHelpButton.visible = true;
         }
         else
         {
            _selfHelpButton.visible = false;
         }
      }
      
      private function updateShieldBtnVisible() : void
      {
         _shieldBtn.visible = false;
         _cancelShieldBtn.visible = false;
         var _loc1_:int = CampaignManager.instance.mapId;
         if(inPetLandBoss() || WorldBossHelper.checkConsortiaEmeDream(_loc1_))
         {
            if(SharedManager.instance.hideOthers)
            {
               _cancelShieldBtn.visible = true;
            }
            else
            {
               _shieldBtn.visible = true;
            }
         }
      }
      
      private function __switchShieldHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         updateShieldBtnVisible();
      }
      
      private function inPetLandBoss() : Boolean
      {
         var _loc1_:int = 0;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc1_ = CampaignManager.instance.mapId;
            if(WorldBossHelper.checkInPetBossFloor(_loc1_) && CampaignManager.instance.petBossModel.isOpen)
            {
               return true;
            }
         }
         return false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

