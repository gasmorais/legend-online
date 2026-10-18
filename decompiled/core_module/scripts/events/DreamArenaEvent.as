package events
{
   import flash.events.Event;
   
   public class DreamArenaEvent extends Event
   {
      
      public static const LEFT_ITEM_SELECT:String = "LEFT_ITEM_SELECT";
      
      public static const TITAN_SET_SKILL:String = "TITAN_SET_SKILL";
      
      public static const TITAN_CLIENT_SKILL_UPDATE:String = "TITAN_CLIENT_SKILL_UPDATE";
      
      public static const MATCH_STATE_UPDATE:String = "MATCH_STATE_UPDATE";
      
      public static const RANK_LIST_BACK:String = "RANK_LIST_BACK";
      
      public static const USER_INFO_CHANGE:String = "USER_INFO_CHANGE";
      
      public static const DREAM_ARENA_CLIENT_SELECT:String = "DREAM_ARENA_CLIENT_SELECT";
      
      public static const DREAM_ARENA_TICKET_CHANGE:String = "DREAM_ARENA_TICKET_CHANGE";
      
      public static const FIGHT_INFO_CHANGE:String = "FIGHT_INFO_CHANGE";
      
      public var data:Object;
      
      public function DreamArenaEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

