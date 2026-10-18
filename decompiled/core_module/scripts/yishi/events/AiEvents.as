package yishi.events
{
   import flash.events.Event;
   
   public class AiEvents extends Event
   {
      
      public static const MOVE_STATE:String = "moveState";
      
      public static const UPDATE_SPEED:String = "updateSpeed";
      
      public static const IS_LIVING:String = "isLiving";
      
      public static const UPDATE_CENTER_POINT:String = "updateCenterPoint";
      
      public static const UPDATE_NEXT_POINT:String = "updateNextPoint";
      
      public static const UPDATE_PATHS:String = "updatePaths";
      
      public static const NEXT_POINT:String = "nextPoint";
      
      public var data:Object;
      
      public function AiEvents(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

