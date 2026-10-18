package events
{
   import flash.events.Event;
   
   public class RoomEvent extends Event
   {
      
      public static const UPDATE_ROOM_MAP:String = "UPDATE_ROOM_MAP";
      
      public static const UPDATE_ROOM_BASE_DATA:String = "UPDATE_ROOM_BASE_DATA";
      
      public static const UPDATE_ROOM_PLAYER_DATA:String = "UPDATE_ROOM_PLAYER_DATA";
      
      public static const UPDATE_TEAM_FIGHT_POS:String = "UPDATE_TEAM_FIGHT_POS";
      
      public static const EDIT_TEAM_FIGHT_POS:String = "EDIT_TEAM_FIGHT_POS";
      
      public static const ADD_PLAYER_ROOM:String = "ADD_PLAYER_ROOM";
      
      public static const REMOVE_PLAYER_ROOM:String = "REMOVE_PLAYER_ROOM";
      
      public static const ROOM_HOUSEOWNER_CHANGE:String = "room_HouseOwner_change";
      
      public static const PLAYER_READY:String = "player_ready";
      
      public static const PLAYER_CENCEL:String = "player_cancel";
      
      public static const ROOM_LIST_PLAYER:String = "ROOM_LIST_PLAYER";
      
      public static const RANK_INFO_LIST:String = "rankInfoList";
      
      public static const ROOM_PLACE_STATE_CHANGE:String = "ROOM_PLACE_STATE_CHANGE";
      
      public static const REFRESH_ROOM_LIST:String = "REFRESH_ROOM_LIST";
      
      public var data:Object;
      
      public function RoomEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

