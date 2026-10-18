package water.events
{
   import flash.events.Event;
   
   public class WaterEvent extends Event
   {
      
      public static var CREATE_TREE:String = "CREATE_TREE";
      
      public static const PRE_SELECTED:String = "PRE_SELECTED";
      
      public static const NEXT_SELECTED:String = "NEXT_SELECTED";
      
      public static const SELECTED_TREE_CHANGE:String = "SELECTED_TREE_CHANGE";
      
      public static const WATER_LOG_UPDATE:String = "WATER_LOG_UPDATE";
      
      public static const TREE_UPDATE:String = "TREE_UPDATE";
      
      public static const CLEAN_WATER_EFFECT:String = "CLEAN_WATER_EFFECT";
      
      public static const UPDATA_WATER_STATE:String = "UPDATA_WATER_STATE";
      
      public static const GP_CHANGED:String = "gp_changed";
      
      public static const GRAGE_CHANGED:String = "grade_changed";
      
      private var _data:Object;
      
      public function WaterEvent(param1:String, param2:Object)
      {
         _data = param2;
         super(param1,false,false);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

