package events
{
   import flash.events.Event;
   
   public class PVPRoomListEvent extends Event
   {
      
      public static const REFRESH_ROOM_LIST:String = "REFRESH_ROOM_LIST";
      
      public static const REFRESH_PLAYER_LIST:String = "REFRESH_PLAYER_LIST";
      
      public static const GROUP_ROOMLIST_UPDATE:String = "PVPRoomListEvent.GROUP_ROOMLIST_UPDATE";
      
      public static const GROUP_TEAM_UPDATE:String = "PVPRoomListEvent.GROUP_ROOM_UPDATE";
      
      public function PVPRoomListEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

