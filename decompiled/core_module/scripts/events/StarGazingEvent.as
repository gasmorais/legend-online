package events
{
   import flash.events.Event;
   
   public class StarGazingEvent extends Event
   {
      
      public static const SELECT_STAR_INDEX_CHANGE:String = "SELECT_STAR_INDEX_CHANGE";
      
      public static const STAR_POWER_CHANGE:String = "STAR_POWER_CHANGE";
      
      public static const STAR_CHART_PIECE_CHANGE:String = "STAR_CHART_PIECE_CHANGE";
      
      public static const STAR_FORCE_POINT_CHANGE:String = "STAR_FORCE_POINT_CHANGE";
      
      public static const STAR_VIEW_DATA_CHANGE:String = "STAR_VIEW_DATA_CHANGE";
      
      public var data:Object;
      
      public function StarGazingEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

