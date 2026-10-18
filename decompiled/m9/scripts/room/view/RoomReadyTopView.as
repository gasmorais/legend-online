package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RoomEvent;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.room.RoomInfo;
   
   public class RoomReadyTopView extends Sprite implements Disposeable
   {
      
      private var back:ScaleUpDownImage;
      
      private var readyNumText:GradientText;
      
      public function RoomReadyTopView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("RoomReadyTopView.back");
         readyNumText = ComponentFactory.Instance.creatComponentByStylename("RoomReadyTopView.readyNumText");
         addChild(back);
         addChild(readyNumText);
      }
      
      private function addEvent() : void
      {
         if(roomInfo)
         {
            roomInfo.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomPlayerStateHandler);
            roomInfo.addEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomPlayerStateHandler);
         }
      }
      
      private function __updateRoomPlayerStateHandler(param1:RoomEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(!roomInfo)
         {
            return;
         }
         var _loc2_:int = getReadyCount();
         var _loc1_:int = int(roomInfo.playerCount);
         readyNumText.text = LanguageMgr.GetTranslation("RoomReadyTopView.readyNumText.text",_loc2_,_loc1_);
      }
      
      private function getReadyCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:CampaignArmy in roomInfo.playerList)
         {
            if(_loc1_.userId != roomInfo.houseOwnerId)
            {
               if(_loc1_.roomState == 1)
               {
                  _loc2_++;
               }
            }
            else if(roomInfo.roomState == 2)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function removeEvent() : void
      {
         if(roomInfo)
         {
            roomInfo.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomPlayerStateHandler);
            roomInfo.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomPlayerStateHandler);
         }
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(readyNumText)
         {
            ObjectUtils.disposeObject(readyNumText);
         }
         readyNumText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

