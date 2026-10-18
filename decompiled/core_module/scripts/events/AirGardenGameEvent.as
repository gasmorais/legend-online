package events
{
   import flash.events.Event;
   
   public class AirGardenGameEvent extends Event
   {
      
      public static const INIT_FIVE_CARD:String = "INIT_FIVE_CARD";
      
      public static const SHOW_FIVE_CARD:String = "SHOW_FIVE_CARD";
      
      public static const FIVE_CARD_ADD_SCORE:String = "FIVE_CARD_ADD_SCORE";
      
      public static const INIT_MEMORY_CARD:String = "INIT_MEMORY_CARD";
      
      public static const FLIP_MEMORY_CARD:String = "FLIP_MEMORY_CARD";
      
      public static const AUTO_MEMORY_CARD:String = "AUTO_MEMORY_CARD";
      
      public static const SHOW_MEMORY_CARD:String = "SHOW_MEMORY_CARD";
      
      public static const UPDATE_DATA_MEMORY_CARD:String = "UPDATE_DATA_MEMORY_CARD";
      
      public var data:Object;
      
      public function AirGardenGameEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

