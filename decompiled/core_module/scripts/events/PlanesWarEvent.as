package events
{
   import flash.events.Event;
   
   public class PlanesWarEvent extends Event
   {
      
      public static const DRAG_MAP_START:String = "DRAG_MAP_START";
      
      public static const DRAG_MAP_END:String = "DRAG_MAP_END";
      
      public static const PLANES_INFO_UPDATE:String = "PLANES_INFO_UPDATE";
      
      public static const PLANES_WARINFO_UPDATE:String = "PLANES_WARINFO_UPDATE";
      
      public static const PLANES_MAPTILES_UPDATE:String = "PLANES_MAPTILES_UPDATE";
      
      public static const PLANES_GRIDINFO_UPDATE:String = "PLANES_GRIDINFO_UPDATE";
      
      public static const PLANES_MOVE_PATH:String = "PLANES_MOVE_PATH";
      
      public static const PLANES_MARKETOP_BACK:String = "PLANES_MARKETOP_BACK";
      
      public static const PLANES_CARDOP_BACK:String = "PLANES_CARDOP_BACK";
      
      public static const PLANES_REVIVE_BACK:String = "PLANES_REVIVE_BACK";
      
      public static const PLANES_BUFFER_REFRESH:String = "PLANES_BUFFER_REFRESH";
      
      public static const RESTORE_POSXY:String = "RESTORE_POSXY";
      
      public static const PLANES_RESOURCE_UPDATE:String = "PLANES_RESOURCE_UPDATE";
      
      public static const UPDATE_QUEUE_ENERGY:String = "UPDATE_QUEUE_ENERGY";
      
      public static const PLANES_LAYERLIST_UPDATE:String = "PLANES_LAYERLIST_UPDATE";
      
      public static const SMALL_MAP_HEROUPDATE:String = "SMALL_MAP_HEROUPDATE";
      
      public static const HELP_RERIVE_BACK:String = "HELP_RERIVE_BACK";
      
      public static const PLANES_FUNCBUY_BACK:String = "PLANES_FUNCBUY_BACK";
      
      public static const PLANES_FUNCSELECT_CHANGE:String = "PLANES_FUNCSELECT_CHANGE";
      
      public var data:*;
      
      public function PlanesWarEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

