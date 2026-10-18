package events
{
   import flash.events.Event;
   
   public class StoreEvent extends Event
   {
      
      public static const UPDATA_ITEM_DATA:String = "UPDATA_ITEM_DATA";
      
      public static const UPDATE_COMPOSE_SELECTED_CELL:String = "UPDATE_COMPOSE_SELECTED_CELL";
      
      public static const UPDATE_COMPOSE_TEMP_LIST:String = "UPDATE_COMPOSE_TEMP_LIST";
      
      public static const UPDATE_COMPOSE_MAX_COUNT:String = "UPDATE_COMPOSE_MAX_COUNT";
      
      public static const SELECTED_PANEL_CHANGE:String = "SELECTED_PANEL_CHANGE";
      
      public static const COMPOSE_COMPLETE:String = "COMPOSE_COMPLETE";
      
      public static const COMPOSE_TYPE_CHANGE:String = "COMPOSE_TYPE_CHANGE";
      
      public static const REFRESH_LOCK_CHANGE:String = "REFRESH_LOCK_CHANGE";
      
      public static const GRADE_TYPE_CHANGE:String = "GRADE_TYPE_CHANGE";
      
      public static const UPDATE_LIFESKILL_SELECTED_CELL:String = "UPDATE_LIFESKILL_SELECTED_CELL";
      
      public static const LIFESKILL_COMPOLETE:String = "LIFESKILL_COMPOLETE";
      
      public static const LIFESKILL_UPDATE:String = "LIFESKILL_UPDATE";
      
      public var data:Object;
      
      public function StoreEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1);
      }
   }
}

