package mediator
{
   import com.pickgliss.toplevel.StageReferance;
   import events.RoomEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import managers.RoomManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.room.RoomInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   
   public class RoomTimeMediator implements IMediator
   {
      
      private static const Single:int = 11;
      
      private static const House_Reader:int = 12;
      
      private static const House_Wait:int = 13;
      
      private static const Wait:int = 14;
      
      private var _curState:int;
      
      private var _isMouseDown:Boolean;
      
      private var _timeId:int;
      
      public function RoomTimeMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         roomInfo.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         StageReferance.stage.addEventListener("mouseDown",__mouseDownHandler);
         __updateRoomInfoHanlder(null);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         if(roomInfo)
         {
            roomInfo.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         }
         StageReferance.stage.removeEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         _isMouseDown = true;
         _curState = -1;
         __updateRoomInfoHanlder(null);
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function __updateRoomInfoHanlder(param1:RoomEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!roomInfo)
         {
            return;
         }
         var _loc2_:int = roomInfo.playerCount;
         if(_loc2_ == 1)
         {
            _loc3_ = 11;
         }
         else if(roomInfo.houseOwnerId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            if(roomInfo.roomState != 2)
            {
               _loc3_ = roomInfo.allPlayerReader && roomInfo.checkRoomPlayerCount() ? 12 : 13;
            }
            else
            {
               _loc3_ = 2;
            }
         }
         else
         {
            _loc3_ = 14;
         }
         if(roomInfo.roomState == 2)
         {
            if(_timeId > 0)
            {
               clearInterval(_timeId);
            }
            _timeId = 0;
            return;
         }
         if(_loc3_ == _curState)
         {
            return;
         }
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         switch(_loc3_ - 11)
         {
            case 0:
               _loc4_ = 5;
               break;
            case 1:
               _loc4_ = 1;
               break;
            case 2:
               _loc4_ = 20;
         }
         _loc4_ = _loc4_ * 60 * 1000;
         if(_loc4_ > 0)
         {
            _timeId = setInterval(killSelf,_loc4_);
         }
         _curState = _loc3_;
      }
      
      private function get selfRoomInfo() : CampaignArmy
      {
         var _loc1_:String = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         return roomInfo.getPlayerByArmyId(ArmyManager.instance.army.id,_loc1_);
      }
      
      private function killSelf() : void
      {
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         CampaignSocketOutManager.instance.sendReturnCampaignRoom(ArmyManager.instance.army.id,true);
      }
   }
}

