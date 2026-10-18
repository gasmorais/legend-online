package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FreedomTeamEvent;
   import events.KingContractEvents;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.KingContractManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   
   public class ResourceExtraView extends Sprite implements Disposeable
   {
      
      private var _totalBox:HBox;
      
      private var _armyBtn:BaseButton;
      
      private var _teamBtn:BaseButton;
      
      private var _kingBtnMc:MovieClip;
      
      private var _kingBtn:TextButton;
      
      private var _filter:UIFilter;
      
      private var frame:Object;
      
      private var teamFrame:Object;
      
      public function ResourceExtraView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("resourceBar.ExtraTotalbox");
         _armyBtn = ComponentFactory.Instance.creatComponentByStylename("resourceBar.ArmyBtn");
         _teamBtn = ComponentFactory.Instance.creatComponentByStylename("resourceBar.ArmyBtn");
         _kingBtnMc = ComponentFactory.Instance.creatCustomObject("resourcesBar.kingBtnMc");
         _kingBtnMc.gotoAndStop(1);
         _armyBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.title");
         addChild(_totalBox);
      }
      
      private function initEvent() : void
      {
         _armyBtn.addEventListener("click",__armyBtnClick);
         _teamBtn.addEventListener("click",__onTeamClick);
         NotificationManager.instance.addEventListener("KingBuffItemShine",__shineKingBufferItem);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         ArmyManager.instance.thane.addEventListener("THANE_LEVEL_UPDATE",__onLevelUpHandler);
         NotificationManager.instance.addEventListener("HIDE_FREEDOMTEAMLIST",onChangeScene);
      }
      
      private function removeEvent() : void
      {
         if(_armyBtn)
         {
            _armyBtn.removeEventListener("click",__armyBtnClick);
         }
         if(_teamBtn)
         {
            _teamBtn.removeEventListener("click",__onTeamClick);
         }
         NotificationManager.instance.removeEventListener("KingBuffItemShine",__shineKingBufferItem);
         _kingBtn && _kingBtn.removeEventListener("click",__clickKingBufferItem);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         ArmyManager.instance.thane.removeEventListener("THANE_LEVEL_UPDATE",__onLevelUpHandler);
         NotificationManager.instance.removeEventListener("HIDE_FREEDOMTEAMLIST",onChangeScene);
      }
      
      protected function onChangeScene(param1:Event) : void
      {
         refreshTeamBtn();
      }
      
      private function __onLevelUpHandler(param1:PlayerEvent = null) : void
      {
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         refreshKingBtn();
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         refreshTeamBtn();
      }
      
      private function __shineKingBufferItem(param1:Event) : void
      {
         _kingBtnMc.gotoAndPlay(1);
      }
      
      private function __clickKingBufferItem(param1:MouseEvent) : void
      {
         _kingBtnMc.gotoAndStop(1);
         if(!VersionSwitch.KING_CONTRACT)
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("kingcontract");
      }
      
      private function __armyBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(frame)
         {
            frame.dispose();
            return;
         }
         if(SceneManager.instance.currentType == "PVP_ROOM_SCENE")
         {
            frame = ComponentFactory.Instance.creatComponentByStylename("core.PVPArmyManageFrame");
         }
         else
         {
            frame = ComponentFactory.Instance.creatComponentByStylename("core.ArmyManageFrame");
         }
         frame.addEventListener("dispose",__frameDispose);
         frame.show();
      }
      
      private function __frameDispose(param1:Event) : void
      {
         frame.removeEventListener("dispose",__frameDispose);
         frame = null;
      }
      
      private function __onTeamClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(teamFrame)
         {
            teamFrame.dispose();
            return;
         }
         teamFrame = ComponentFactory.Instance.creatComponentByStylename("core.FreedomTeamManageFrame");
         teamFrame.addEventListener("dispose",__teamFrameDispose);
         teamFrame.show();
      }
      
      private function __teamFrameDispose(param1:Event) : void
      {
         teamFrame.removeEventListener("dispose",__teamFrameDispose);
         teamFrame = null;
      }
      
      public function armyBtnEnable(param1:Boolean) : void
      {
         if(_armyBtn.enable == param1)
         {
            return;
         }
         if(param1)
         {
            _armyBtn.enable = true;
         }
         else
         {
            _armyBtn.enable = false;
            ObjectUtils.disposeObject(frame);
         }
      }
      
      public function refreshView() : void
      {
         var _loc3_:Array = null;
         var _loc1_:Object = null;
         _totalBox.removeAllChild();
         var _loc2_:Boolean = VersionSwitch.KING_CONTRACT;
         if(thane.grades >= 11 && _loc2_)
         {
            if(_kingBtn == null)
            {
               _loc3_ = KingContractManager.Instance.model.kingContractInfos.getList();
               _kingBtn = ComponentFactory.Instance.creatComponentByStylename("resourceBar.KingBtn");
               _kingBtn.addEventListener("click",__clickKingBufferItem);
               _loc1_ = {};
               _loc1_["title"] = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferTitle4");
               _loc1_["content"] = "";
               _kingBtn.tipStyle = "yishi.view.tips.ExtralKingTips";
               _kingBtn.isFollowMouse = false;
               _kingBtn.tipData = _loc3_;
               _kingBtnMc["pos"].addChild(_kingBtn);
               _kingBtn.x = -_kingBtnMc["pos"].x;
               _kingBtn.y = -4 - _kingBtnMc["pos"].y;
            }
            refreshKingBtn();
            _totalBox.addChild(_kingBtnMc);
         }
         if(checkScene())
         {
            _totalBox.addChild(_armyBtn);
         }
         refreshTeamBtn();
      }
      
      private function refreshTeamBtn() : void
      {
         if(FreedomTeamManager.instance.hasTeam && isAddTeamBtn())
         {
            _totalBox.addChild(_teamBtn);
         }
         else if(_teamBtn.parent)
         {
            _totalBox.removeChild(_teamBtn);
         }
      }
      
      private function isAddTeamBtn() : Boolean
      {
         var _loc1_:Boolean = WorldBossHelper.checkRapidMap(CampaignManager.instance.mapId);
         if(_loc1_)
         {
            return false;
         }
         return true;
      }
      
      private function isRapidThrough() : Boolean
      {
         return WorldBossHelper.checkRapidMap(CampaignManager.instance.mapId);
      }
      
      private function refreshKingBtn() : void
      {
         if(!_kingBtn || !_filter)
         {
            return;
         }
         if(KingContractManager.Instance.checkHasBuffById(2))
         {
            _kingBtn.text = "";
            _filter.setNormalFilter(_kingBtn);
         }
         else
         {
            _kingBtn.text = LanguageMgr.GetTranslation("public.clickopen");
            _filter.setGrayFilter(_kingBtn);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function checkScene() : Boolean
      {
         var _loc2_:String = SceneManager.instance.currentType;
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc2_ == "CAMPAIGN_MAP_SCENE" && _loc1_ && _loc1_.campaignTemplate && _loc1_.campaignTemplate.Capacity > 1 && (_loc1_.campaignTemplate.Types == 0 || _loc1_.campaignTemplate.Types == 13) || _loc2_ == "PVE_ROOM_SCENE" || _loc2_ == "PVP_ROOM_SCENE" || _loc2_ == "APEX_ROOM" || _loc2_ == "THESE_Double_PVP_SCENE")
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         if(_kingBtn)
         {
            _kingBtn.filters = [];
         }
         removeEvent();
         ObjectUtils.disposeObject(_armyBtn);
         _armyBtn = null;
         ObjectUtils.disposeObject(_teamBtn);
         _teamBtn = null;
         ObjectUtils.disposeObject(_totalBox);
         _totalBox = null;
         ObjectUtils.disposeObject(_kingBtn);
         _kingBtn = null;
         ObjectUtils.disposeObject(_kingBtnMc);
         _kingBtnMc = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

