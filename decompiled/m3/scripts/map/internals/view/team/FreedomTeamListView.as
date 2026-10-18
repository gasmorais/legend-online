package map.internals.view.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import events.FreedomTeamEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import managers.FreedomTeamManager;
   import managers.GroupfbManager;
   import managers.MarryManager;
   import map.campaign.CampaignManager;
   import map.internals.view.team.list.FreedomTeamListItemView;
   import map.space.view.frame.DivorceAlert;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.groupfb.GroupfbPlayerInfo;
   import mvc.module.team.FreedomTeamModel;
   import ui.resourcebar.ResourcesBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   
   public class FreedomTeamListView extends Sprite
   {
      
      private var _items:Dictionary;
      
      private var _exitCampaignBtn:TextButton;
      
      private var _inviteBtn:TextButton;
      
      private var _captainFlag:Bitmap;
      
      private var _vBox:VBox;
      
      private var _visibleList:Array = [];
      
      private var _ubVisibleList:Array = [];
      
      public function FreedomTeamListView()
      {
         super();
         initView();
         initList();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _captainFlag = ComponentFactory.Instance.creatBitmap("asset.core.CaptainIcon");
         _captainFlag.x = -2;
         _captainFlag.y = -6;
         _items = new Dictionary(true);
         _vBox = new VBox();
         addChild(_vBox);
         x = 315;
         y = 180;
         setCaptainFlag();
      }
      
      private function uninitView() : void
      {
         var _loc2_:FreedomTeamListItemView = null;
         for each(var _loc1_:FreedomTeamListItemView in _items)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _items = null;
         while(_ubVisibleList.length > 0)
         {
            _loc2_ = _ubVisibleList.pop();
            _loc2_.dispose();
         }
         _ubVisibleList = null;
         _loc2_ = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_exitCampaignBtn);
         _exitCampaignBtn = null;
         ObjectUtils.disposeObject(_captainFlag);
         _captainFlag = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FreedomTeamListItemView = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new FreedomTeamListItemView();
            _ubVisibleList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function initData() : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            setFreedomTeamView();
         }
         else if(groupfbModel.hasGroupTeam && Boolean(WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId)))
         {
            setGroupfbTeamView();
         }
      }
      
      private function setGroupfbTeamView() : void
      {
         var _loc1_:BaseArmy = null;
         var _loc3_:FreedomTeamListItemView = null;
         var _loc4_:int = 0;
         var _loc2_:Vector.<GroupfbPlayerInfo> = groupfbModel.selfTeam.getTeamList(groupfbModel.selfTeam.selfInfo.team);
         _vBox.disposeAllChildren();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_ = new BaseArmy();
            _loc1_.userId = _loc2_[_loc4_].userId;
            _loc1_.baseHero.userId = _loc2_[_loc4_].userId;
            _loc1_.nickName = _loc2_[_loc4_].nickName;
            _loc1_.baseHero.nickName = _loc2_[_loc4_].nickName;
            _loc1_.baseHero.grades = _loc2_[_loc4_].grades;
            _loc1_.baseHero.fightingCapacity = _loc2_[_loc4_].fightCapacity;
            _loc1_.baseHero.state = _loc2_[_loc4_].isOnline ? 7 : 0;
            _loc1_.baseHero.templateInfo.Job = _loc2_[_loc4_].job;
            _loc1_.baseHero.templateId = _loc2_[_loc4_].templateId;
            _loc1_.baseHero.headId = _loc2_[_loc4_].headID;
            if(_loc1_.userId != ArmyManager.instance.army.userId)
            {
               _loc3_ = new FreedomTeamListItemView();
               _loc3_.data = _loc1_;
               _items[_loc1_.userId] = _loc3_;
               _vBox.addChild(_loc3_);
            }
            _loc4_++;
         }
         _vBox.refreshChildPos();
      }
      
      private function setFreedomTeamView() : void
      {
         var _loc1_:BaseArmy = null;
         var _loc3_:FreedomTeamListItemView = null;
         var _loc4_:int = 0;
         var _loc2_:Array = FreedomTeamManager.instance.model.allMembers;
         _vBox.disposeAllChildren();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc4_] as BaseArmy;
            if(_loc1_.userId != ArmyManager.instance.army.userId)
            {
               _loc3_ = new FreedomTeamListItemView();
               _loc3_.data = _loc1_;
               _items[_loc1_.userId] = _loc3_;
               _vBox.addChild(_loc3_);
            }
            _loc4_++;
         }
         _vBox.refreshChildPos();
      }
      
      private function cleanData() : void
      {
         _vBox.removeAllChild();
         for each(var _loc1_:FreedomTeamListItemView in _items)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("UI_OUT_SCENE",__outSceneHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         NotificationManager.instance.addEventListener("HIDE_FREEDOMTEAMLIST",_hide);
         NotificationManager.instance.addEventListener("CONSULT_DIVORCE",__showDivorce);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UI_OUT_SCENE",__outSceneHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         NotificationManager.instance.removeEventListener("HIDE_FREEDOMTEAMLIST",_hide);
         NotificationManager.instance.removeEventListener("CONSULT_DIVORCE",__showDivorce);
      }
      
      private function __showDivorce(param1:NotificationEvent) : void
      {
         var _loc2_:DivorceAlert = ComponentFactory.Instance.creatComponentByStylename("Divorce.SimpleAlert",[93,true]);
         LayerManager.Instance.addToLayer(_loc2_,3,true,true,1);
      }
      
      private function _hide(param1:NotificationEvent) : void
      {
         var _loc2_:Boolean = param1.data as Boolean;
         if(MarryManager.instance.model.lockScreen)
         {
            visible = false;
         }
         else
         {
            visible = !_loc2_;
         }
      }
      
      private function __outSceneHandler(param1:NotificationEvent) : void
      {
         if(_captainFlag && _captainFlag.parent)
         {
            _captainFlag.parent.removeChild(_captainFlag);
         }
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         cleanData();
         initData();
         setCaptainFlag();
      }
      
      private function setCaptainFlag() : void
      {
         if(model && model.captainId == playerInfo.userId)
         {
            ResourcesBar.instance.addChild(_captainFlag);
         }
         else if(_captainFlag && _captainFlag.parent)
         {
            _captainFlag.parent.removeChild(_captainFlag);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : FreedomTeamModel
      {
         return FreedomTeamManager.instance.model;
      }
      
      private function get groupfbModel() : GroupfbModel
      {
         return GroupfbManager.instance.model;
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

