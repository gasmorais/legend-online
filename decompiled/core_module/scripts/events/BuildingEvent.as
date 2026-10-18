package events
{
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.module.buildings.BuildInfo;
   
   public class BuildingEvent extends Event
   {
      
      public static const U_C_GOLD_IMPOSERESULT:String = "U_C_GOLD_IMPOSERESULT";
      
      public static const CASTLE_SCALE:String = "CASTLE_SCALE";
      
      public static const BUILDING_LOAD_COMPLETE:String = "BUILDING_LOAD_COMPLETE";
      
      public static const ADD_NEW_BUILD:String = "ADD_NEW_BUILD";
      
      public static const BUILD_INFO_UPDATE:String = "BUILD_INFO_UPDATE";
      
      public static const BUILDING_UPGRADE_RECEIVE:String = "BUILDING_UPGRADE_RECEIVE";
      
      public static const CREATE_NEW_BUILDING:String = "CREATE_NEW_BUILDING";
      
      public static const BUILDING_CREATE_RECEIVE:String = "BUILDING_CREATE_RECEIVE";
      
      public static const CASTLE_MAP_SCALe_CHANGE:String = "CASTLE_MAP_SCALe_CHANGE";
      
      public static const ADD_BUILDING_NAME:String = "ADD_BUILDING_NAME";
      
      public static const CHANGE_BUILDING_NAME:String = "CHANGE_BUILDING_NAME";
      
      public static const NEW_BUILDING_FOCUS:String = "NEW_BUILDING_FOCUS";
      
      public static const BUILDING_NAME_SHOW_HIDE:String = "building_name_show_hide";
      
      public static const BUILDING_SHOW_VIEW:String = "show_buildingView";
      
      public static const TRANSFER_TIME_COOL:String = "TRANSFER_TIME_COOL";
      
      public static const TRANSFER_POWER_SUCCESS:String = "TRANSFER_POWER_SUCCESS";
      
      public static const U_UNOCCPWILDLAND:String = "U_UNOCCPWILDLAND";
      
      public static const U_SECURITY_INFO_UPDATE:String = "U_SECURITY_INFO_UPDATE";
      
      public static const UNAPPLY:String = "UNAPPLY";
      
      private var _data:Object;
      
      public var newBuildingPoint:Point;
      
      public var scaleX:Number;
      
      public var scaleY:Number;
      
      public var index:String;
      
      public var buildingName:String;
      
      public var buildingLv:int;
      
      public function BuildingEvent(param1:String, param2:Object = null)
      {
         _data = param2;
         super(param1,false,false);
      }
      
      public function get buildingInfo() : BuildInfo
      {
         return _data as BuildInfo;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

