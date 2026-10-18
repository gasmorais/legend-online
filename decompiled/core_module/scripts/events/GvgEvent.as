package events
{
   import flash.events.Event;
   
   public class GvgEvent extends Event
   {
      
      public static const GUILD_ORDER_INFO_LIST:String = "GUILD_ORDER_INFO_LIST";
      
      public static const GUILD_CHALLENGE_LIST:String = "GUILD_CHALLENGE_LIST";
      
      public static const GUILD_INFO_CHANGE:String = "GUILD_INFO_CHANGE";
      
      public static const SELECT_MEMBER_ITEM:String = "SELECT_MEMBER_ITEM";
      
      public static const UPDATE_GUILD_GROUP:String = "UPDATE_GUILD_GROUP";
      
      public static const UPDATE_GUILD_ORDER_GROUP:String = "UPDATE_GUILD_ORDER_GROUP";
      
      public static const UPDATE_CURRENT_COUNT:String = "UPDATE_CURRENT_COUNT";
      
      public static const GUILDWAR_OPEN_LEFTTIME:String = "GUILDWAR_OPEN_LEFTTIME";
      
      public static const GUILDWAR_PLAYER_COUNT:String = "GUILDWAR_PLAYER_COUNT";
      
      public static const TOP_TEN_CHANGE:String = "TOP_TEN_CHANGE";
      
      public var data:Object;
      
      public function GvgEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

