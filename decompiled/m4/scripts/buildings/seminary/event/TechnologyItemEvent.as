package buildings.seminary.event
{
   import flash.events.Event;
   import mvc.module.buildings.BuildInfo;
   
   public class TechnologyItemEvent extends Event
   {
      
      public static var ITEM_CLICK:String = "ITEM_CLICK";
      
      public static var CREATE:String = "CREATE";
      
      public static var UPDATA:String = "UPDATA";
      
      public static var TECHNOLOGY_ITEM_ROLL_OVER:String = "technology_item_roll_over";
      
      public static var TECHNOLOGY_ITEM_ROLL_OUT:String = "technology_item_roll_out";
      
      public var data:BuildInfo;
      
      public function TechnologyItemEvent(param1:String, param2:BuildInfo = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

