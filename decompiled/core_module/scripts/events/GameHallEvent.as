package events
{
   import flash.events.Event;
   
   public class GameHallEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      public static const SELECTED_GAME_INFO_UPDATE:String = "SELECTED_GAME_INFO_UPDATE";
      
      public static const GAME_INFO_UPDATE:String = "GAME_INFO_UPDATE";
      
      public static const USER_INFO_UPDATE:String = "USER_INFO_UPDATE";
      
      public static const CAPTAIN_UPDATE:String = "CAPTAIN_UPDATE";
      
      public static const PASSWORD_UPDATE:String = "PASSWORD_UPDATE";
      
      public static const PREPARE_STATE:String = "PREPARE_STATE";
      
      public static const ONLINE_STATE:String = "ONLINE_STATE";
      
      public static const UPDATE_EAST_TEAMLEFTVIEW:String = "UPDATE_EAST_TEAMLEFTVIEW";
      
      public static const UPDATE_WISHINFO:String = "UPDATE_WISHINFO";
      
      public static const UPDATE_BUFFERINFO:String = "UPDATE_BUFFERINFO";
      
      public static const UPDATE_SHOPINFO:String = "UPDATE_SHOPINFO";
      
      public static const PAGE_UPDATE:String = "PAGE_UPDATE";
      
      public static const UPDATE_AUTO_BATTLE:String = "UPDATE_AUTO_BATTLE";
      
      public var data:Object;
      
      public function GameHallEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

