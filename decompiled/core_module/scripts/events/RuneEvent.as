package events
{
   import flash.events.Event;
   
   public class RuneEvent extends Event
   {
      
      public static const RUNE_UPGRADE:String = "RUNE_UPGRADE";
      
      public static const SET_FAST_KEY:String = "SET_FAST_KEY";
      
      public static const FAST_KEY_MOVE:String = "FAST_KEY_MOVE";
      
      public static const DOUBLE_KEY_CHANGE:String = "DOUBLE_KEY_CHANGE";
      
      public static const RUNE_NO_CHANGE:String = "RUNE_NO_CHANGE";
      
      public var data:*;
      
      public function RuneEvent(param1:String, param2:* = null)
      {
         super(param1,false,false);
         data = param2;
      }
   }
}

