package events
{
   import flash.events.Event;
   
   public class GoldenSheepEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      public static const STATE_UPDATE:String = "STATE_UPDATE";
      
      public static const ANIMATION_UPDATE:String = "ANIMATION_UPDATE";
      
      public var data:Object;
      
      public function GoldenSheepEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

