package events
{
   import flash.events.Event;
   
   public class TreasureMapEvent extends Event
   {
      
      public static const TREASURE_INFO_UPDATE:String = "TREASURE_INFO_UPDATE";
      
      public var data:Object;
      
      public function TreasureMapEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

