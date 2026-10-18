package mvc.module.gloryGame.event
{
   import flash.events.Event;
   
   public class GloryGameEvent extends Event
   {
      
      public static const VIEW_OPENED:String = "VIEW_OPENED";
      
      public static const SCHEDULE_INFO_UPDATE:String = "SCHEDULE_INFO_UPDATE";
      
      public static const BET_INFO_UPDATE:String = "BET_INFO_UPDATE";
      
      public static const JUMP_TO_BET:String = "JUMP_TO_BET";
      
      public static const JUMP_TO_SCHEDULE:String = "JUMP_TO_SCHEDULE";
      
      public static const ROOM_UPDATE:String = "ROOM_UPDATE";
      
      public var data:*;
      
      public function GloryGameEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

