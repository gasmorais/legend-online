package events
{
   import flash.events.Event;
   
   public class RemainsExploreEvent extends Event
   {
      
      public static const EXPLORE_INFO_UPDATE:String = "EXPLORE_INFO_UPDATE";
      
      public static const DO_EXPLORE_UPDATE:String = "DO_EXPLORE_UPDATE";
      
      public static const REMAINS_LEED_UPDATE:String = "REMAINS_LEED_UPDATE";
      
      public var data:Object;
      
      public function RemainsExploreEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

