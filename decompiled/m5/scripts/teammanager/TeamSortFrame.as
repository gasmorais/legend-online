package teammanager
{
   import army.net.ArmySocketSendManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.army.ArmyFightPosEditMsg;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import managers.RoomSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.armyII.UserArmy;
   import mvc.module.room.RoomInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class TeamSortFrame extends Frame
   {
      
      private var _bg3:Bitmap;
      
      private var _itemList:SimpleDictionary;
      
      private var _posList:Array = [3,1,6,4,9,7,12,10];
      
      private var isHouseOwner:Boolean;
      
      public function TeamSortFrame()
      {
         super();
         TeamSortCell;
         initView();
         addEvent();
         if(roominfo && roominfo.isCross)
         {
            RoomSocketOutManager.sendRequestCrossTeamPos(playerInfo.serviceName);
         }
         else
         {
            RoomSocketOutManager.sendRequestTeamPos();
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TeamSortItem = null;
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("teammanager.pve.TeamSortFrame.title");
         _bg3 = ComponentFactory.Instance.creatBitmap("asset.teammanger.teamBg");
         addToContent(_bg3);
         _itemList = new SimpleDictionary();
         isHouseOwner = roominfo.houseOwnerId == userArmy.userId;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new TeamSortItem();
            addToContent(_loc1_);
            _loc1_.x = 10;
            _loc1_.y = -15 + _loc2_ * 105;
            _loc1_.index = _loc2_ + 1;
            _loc1_.dragEnable = isHouseOwner;
            _itemList[_loc2_ + 1] = _loc1_;
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         RoomManager.instance.roomInfo.addEventListener("room_HouseOwner_change",__ownerChangeHandler);
         RoomManager.instance.roomInfo.addEventListener("UPDATE_TEAM_FIGHT_POS",__updateView);
         for each(var _loc1_:TeamSortItem in _itemList)
         {
            _loc1_.iconCell.addEventListener("EDIT_TEAM_FIGHT_POS",__editTeamFightPos);
         }
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.removeEventListener("room_HouseOwner_change",__ownerChangeHandler);
            RoomManager.instance.roomInfo.removeEventListener("UPDATE_TEAM_FIGHT_POS",__updateView);
         }
         for each(var _loc1_:TeamSortItem in _itemList)
         {
            _loc1_.iconCell.removeEventListener("EDIT_TEAM_FIGHT_POS",__editTeamFightPos);
         }
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
      }
      
      private function __ownerChangeHandler(param1:RoomEvent) : void
      {
         var _loc2_:TeamSortItem = null;
         var _loc3_:int = 0;
         isHouseOwner = roominfo.houseOwnerId == userArmy.userId;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = _itemList[_loc3_ + 1];
            if(_loc2_)
            {
               _loc2_.iconCell.dragEnable = isHouseOwner;
            }
            _loc3_++;
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:TeamSortItem in _itemList)
         {
            _loc2_.iconCell.setCellStatus(false);
         }
      }
      
      private function __updateView(param1:RoomEvent) : void
      {
         var _loc6_:CampaignArmy = null;
         var _loc4_:int = 0;
         clean();
         var _loc3_:Array = roominfo.armyFightPos;
         var _loc5_:Array = [];
         for each(var _loc2_:ArmyFightPosEditMsg in _loc3_)
         {
            _loc6_ = RoomManager.instance.roomInfo.getPlayerByUserId(_loc2_.userId,_loc2_.serverName);
            if(_loc6_ && _loc2_.heroPos != 0)
            {
               if(_loc2_.heroPos % 3 == 0)
               {
                  if(_itemList[_loc2_.heroPos / 3])
                  {
                     _itemList[_loc2_.heroPos / 3].pos = _loc2_.heroPos;
                     _itemList[_loc2_.heroPos / 3].serverName = _loc2_.serverName;
                     _itemList[_loc2_.heroPos / 3].data = _loc6_.baseHero;
                     _loc5_.push(_loc2_.heroPos / 3);
                  }
               }
               else if(_itemList[(_loc2_.heroPos + 2) / 3])
               {
                  _itemList[(_loc2_.heroPos + 2) / 3].pos = _loc2_.heroPos;
                  _itemList[(_loc2_.heroPos + 2) / 3].serverName = _loc2_.serverName;
                  _itemList[(_loc2_.heroPos + 2) / 3].data = _loc6_.baseHero;
                  _loc5_.push((_loc2_.heroPos + 2) / 3);
               }
            }
         }
         _loc4_ = 1;
         while(_loc4_ <= 4)
         {
            if(_loc5_.indexOf(_loc4_) == -1)
            {
               _itemList[_loc4_].pos = 0;
               _itemList[_loc4_].serverName = "";
               _itemList[_loc4_].data = null;
            }
            _loc4_++;
         }
      }
      
      private function clean() : void
      {
         for each(var _loc1_:TeamSortItem in _itemList)
         {
            _loc1_.data = null;
            _loc1_.pos = 0;
         }
      }
      
      private function __editTeamFightPos(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc4_:Array = [];
         for each(var _loc3_:TeamSortItem in _itemList)
         {
            if(_loc3_.iconCell && _loc3_.data)
            {
               _loc2_ = {};
               _loc2_.serverName = _loc3_.serverName;
               _loc2_.userId = _loc3_.data.userId;
               _loc2_.heroPos = _loc3_.iconCell.pos;
               _loc4_.push(_loc2_);
            }
         }
         ArmySocketSendManager.sendEditTeamPos(_loc4_,playerInfo.serviceName);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode != 2)
         {
            dispose();
         }
      }
      
      private function get roominfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         DragManager.getInstance().stopDrag();
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         _bg3 = null;
         for each(var _loc1_:TeamSortItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

