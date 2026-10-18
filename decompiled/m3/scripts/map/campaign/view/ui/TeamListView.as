package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.internals.event.OuterCityEvent;
   import mvc.module.room.RoomInfo;
   import ui.resourcebar.ResourcesBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class TeamListView extends Sprite
   {
      
      private var _items:Dictionary;
      
      private var _leaderMask:Image;
      
      private var _exitCampaignBtn:TextButton;
      
      private var _inviteBtn:TextButton;
      
      private var _captainFlag:Bitmap;
      
      private var _vBox:VBox;
      
      private var _visibleList:Array = [];
      
      private var _ubVisibleList:Array = [];
      
      public function TeamListView()
      {
         super();
         init();
         initList();
         initEvent();
         initData();
      }
      
      private function init() : void
      {
         _leaderMask = ComponentFactory.Instance.creatComponentByStylename("campaign.room.UpTeamMask");
         _captainFlag = ComponentFactory.Instance.creatBitmap("asset.core.CaptainIcon");
         _captainFlag.x = -2;
         _captainFlag.y = -6;
         _items = new Dictionary(true);
         _vBox = new VBox();
         addChild(_vBox);
         x = 0;
         y = 200;
         setCaptainFlag();
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TeamItemView = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new TeamItemView();
            _ubVisibleList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function initData() : void
      {
         var _loc1_:TeamItemView = null;
         var _loc3_:Dictionary = CampaignManager.instance.mapModel.allUserArmy;
         for each(var _loc2_:CampaignArmy in _loc3_)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.userId != _loc2_.userId)
            {
               _loc1_ = new TeamItemView();
               _loc1_.data = _loc2_;
               _items[_loc2_.userId] = _loc1_;
               _vBox.addChild(_loc1_);
            }
         }
         _vBox.refreshChildPos();
      }
      
      private function cleanData() : void
      {
         _vBox.removeAllChild();
         for each(var _loc1_:TeamItemView in _items)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
      
      private function refreshPos() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _ubVisibleList)
         {
            _loc1_.y = 0;
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         var _loc2_:int = 0;
         for each(_loc1_ in _visibleList)
         {
            _loc1_.y = _loc2_ * _loc1_.height;
            _loc2_++;
            addChild(_loc1_);
         }
      }
      
      private function initEvent() : void
      {
         CampaignManager.instance.mapModel.addEventListener("addGarrison",__addArmyHandler);
         CampaignManager.instance.mapModel.addEventListener("REMOVE_ARMY",__removeArmyHandler);
         if(roomInfo)
         {
            roomInfo.addEventListener("room_HouseOwner_change",__houseownerChangeHandler);
         }
         NotificationManager.instance.addEventListener("UI_OUT_SCENE",__outSceneHandler);
      }
      
      private function removeEvent() : void
      {
         if(CampaignManager.instance.mapModel)
         {
            CampaignManager.instance.mapModel.removeEventListener("addGarrison",__addArmyHandler);
            CampaignManager.instance.mapModel.removeEventListener("REMOVE_ARMY",__removeArmyHandler);
         }
         if(roomInfo)
         {
            roomInfo.removeEventListener("room_HouseOwner_change",__houseownerChangeHandler);
         }
         NotificationManager.instance.removeEventListener("UI_OUT_SCENE",__outSceneHandler);
      }
      
      private function __houseownerChangeHandler(param1:RoomEvent) : void
      {
         cleanData();
         initData();
         setCaptainFlag();
      }
      
      private function __outSceneHandler(param1:NotificationEvent) : void
      {
         if(_captainFlag && _captainFlag.parent)
         {
            _captainFlag.parent.removeChild(_captainFlag);
         }
      }
      
      private function setCaptainFlag() : void
      {
         if(roomInfo && roomInfo.houseOwnerId == playerInfo.userId && checkIsPve)
         {
            ResourcesBar.instance.addChild(_captainFlag);
         }
         else if(_captainFlag && _captainFlag.parent)
         {
            _captainFlag.parent.removeChild(_captainFlag);
         }
      }
      
      private function get checkIsPve() : Boolean
      {
         var _loc2_:String = SceneManager.instance.currentType;
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc2_ == "CAMPAIGN_MAP_SCENE" && _loc1_ && _loc1_.campaignTemplate && _loc1_.campaignTemplate.Capacity > 1 && _loc1_.campaignTemplate.Types == 0)
         {
            return true;
         }
         return false;
      }
      
      private function __removeArmyHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc2_)
         {
            removeItem(_loc2_);
         }
      }
      
      private function __addArmyHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:CampaignArmy = null;
         if(param1.isSwitchMap)
         {
            return;
         }
         var _loc3_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc3_ && _loc3_.campaignTemplate.Capacity > 1)
         {
            _loc2_ = param1.data as CampaignArmy;
            if(_loc2_)
            {
               addItem(_loc2_);
            }
         }
      }
      
      private function removeItem(param1:CampaignArmy) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TeamItemView = null;
         _loc3_ = 0;
         while(_loc3_ < _vBox.numChildren)
         {
            _loc2_ = _vBox.getChildAt(_loc3_) as TeamItemView;
            if(_loc2_ && _loc2_.data && _loc2_.data == param1)
            {
               _vBox.removeChild(_loc2_);
            }
            _loc3_++;
         }
         _vBox.refreshChildPos();
      }
      
      private function addItem(param1:CampaignArmy) : void
      {
         var _loc2_:TeamItemView = new TeamItemView();
         _loc2_.data = param1;
         _vBox.addChild(_loc2_);
         _vBox.refreshChildPos();
      }
      
      private function getItemViewByUserid(param1:int) : TeamItemView
      {
         for each(var _loc2_:TeamItemView in _visibleList)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return _ubVisibleList.pop() as TeamItemView;
      }
      
      private function get selfUserId() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      public function dispose() : void
      {
         var _loc2_:TeamItemView = null;
         removeEvent();
         for each(var _loc1_:TeamItemView in _items)
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
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_inviteBtn)
         {
            _inviteBtn.dispose();
         }
         _inviteBtn = null;
         if(_exitCampaignBtn)
         {
            _exitCampaignBtn.dispose();
         }
         _exitCampaignBtn = null;
         if(_leaderMask)
         {
            _leaderMask.dispose();
         }
         _leaderMask = null;
         if(_captainFlag)
         {
            _captainFlag.bitmapData.dispose();
            if(_captainFlag.parent)
            {
               _captainFlag.parent.removeChild(_captainFlag);
            }
         }
         _captainFlag = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

