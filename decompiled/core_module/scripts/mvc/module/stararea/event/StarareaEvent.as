package mvc.module.stararea.event
{
   import flash.events.Event;
   
   public class StarareaEvent extends Event
   {
      
      public static const MOVE_TO_POINT:String = "MOVE_TO_POINT";
      
      public static const UPDATE_NODES:String = "UPDATE_NODES";
      
      public static const UPDATE_ROADS:String = "UPDATE_ROADS";
      
      public static const CLICK_STAR:String = "CLICK_STAR";
      
      public static const UPDATE_DATA:String = "UPDATE_DATA";
      
      public static const UPDATE_TAB_VIEW:String = "UPDATE_TAB_VIEW";
      
      public static const GAME_PASS:String = "GAME_PASS";
      
      public var data:*;
      
      public function StarareaEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

