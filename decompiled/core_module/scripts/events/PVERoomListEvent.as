package events
{
   import flash.events.Event;
   
   public class PVERoomListEvent extends Event
   {
      
      public static const REFRESH_ROOM_LIST:String = "REFRESH_ROOM_LIST";
      
      public static const REFRESH_PLAYER_LIST:String = "REFRESH_PLAYER_LIST";
      
      public function PVERoomListEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

