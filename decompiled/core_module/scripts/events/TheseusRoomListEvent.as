package events
{
   import flash.events.Event;
   
   public class TheseusRoomListEvent extends Event
   {
      
      public static const TheseusREFRESH_ROOM_LIST:String = "TheseusREFRESH_ROOM_LIST";
      
      public static const TheseusREFRESH_PLAYER_LIST:String = "TheseusREFRESH_PLAYER_LIST";
      
      public function TheseusRoomListEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

