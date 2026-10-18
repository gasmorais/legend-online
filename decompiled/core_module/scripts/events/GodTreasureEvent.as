package events
{
   import flash.events.Event;
   
   public class GodTreasureEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      public static const VIEW_UPDATE:String = "VIEW_UPDATE";
      
      public var data:*;
      
      public function GodTreasureEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

