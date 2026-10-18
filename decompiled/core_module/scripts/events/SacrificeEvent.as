package events
{
   import flash.events.Event;
   
   public class SacrificeEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      public static const VIEW_UPDATE:String = "VIEW_UPDATE";
      
      public var data:*;
      
      public function SacrificeEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         data = param2;
      }
   }
}

