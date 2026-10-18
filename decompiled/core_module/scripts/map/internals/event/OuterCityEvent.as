package map.internals.event
{
   import flash.events.Event;
   
   public class OuterCityEvent extends Event
   {
      
      public static const NINE_SLICE_SCALING:String = "nineSliceScaling";
      
      public static const CURRENT_CONFIG_CHANGE:String = "currentConfigChange";
      
      public static const READ_FILE_OVER:String = "readFileOver";
      
      public static const CURRENT_CASTLES:String = "currentCastles";
      
      public static const CURRENT_WILD_LAND:String = "currentWildLand";
      
      public static const CURRENT_NPC_POS:String = "currentNpcPos";
      
      public static const BEGIN_LOADING:String = "beginLoading";
      
      public static const COMMIT_LOADING:String = "commitLoading";
      
      public static const ADD_GARRISON:String = "addGarrison";
      
      public static const REMOVE_ARMY:String = "REMOVE_ARMY";
      
      public static const ADD_PLUNDER:String = "addPlunder";
      
      public static const ADD_DIJKSTRA:String = "addDijkstra";
      
      public static const OVERSTEP:String = "overstep";
      
      public static const CENTER_POINT:String = "centerPoint";
      
      public static const LAY_MAP_ARMY:String = "layMapArmy";
      
      public static const RETURN_HOME:String = "return_home";
      
      public static const POSATION_POINT:String = "POSATION_POINT";
      
      public static const CURRENT_TREASURE_LAND:String = "CURRENT_TREASURE_LAND";
      
      public static const REFRESH_NPC:String = "REFRESH_NPC";
      
      public static const CHANGE_HERO_FOCUS:String = "changeHeroFocus";
      
      public static const TARGET_POINT:String = "target_point";
      
      public static const UPDATA_MAP_PHYSICS:String = "UPDATA_MAP_PHYSICS";
      
      public static const DRAG_SCENE_END:String = "DRAG_SCENE_END";
      
      public static const DRAG_SCENE_START:String = "DRAG_SCENE_START";
      
      public static const ADD_NPCS:String = "ADD_NPCS";
      
      public static const START_MOVE:String = "START_MOVE";
      
      public static const MOVE_OVER:String = "MOVE_OVER";
      
      public static const REMOVE_NODE:String = "REMOVE_NODE";
      
      public static const SELECT_PK_ARMY:String = "selectPkArmy";
      
      public static const REMOVE_NODE_NPC:String = "REMOVE_NODE_NPC";
      
      public static const REMOVE_NODE_MOVIE:String = "REMOVE_NODE_MOVIE";
      
      public static const REMOVE_CASTLE:String = "REMOVE_CASTLE";
      
      public static const MAP_MOVE:String = "MAP_MOVE";
      
      public static const ADD_DENSEFOG_BY_BUILD:String = "OUTERCITY_ADD_DENSEFOG_BY_BUILD";
      
      public static const OUTER_CITY_GET_BOSSINFO:String = "OUTER_CITY_GET_BOSSINFO";
      
      public static const OUTER_CITY_UPDATE_BOSS_TIME:String = "OUTER_CITY_UPDATE_BOSS_TIME";
      
      public static const OUTER_CITY_REMOVE_FOG:String = "OUTER_CITY_REMOVE_FOG";
      
      public static const OUTER_CITY_ADD_FOG:String = "OUTER_CITY_ADD_FOG";
      
      public static const OUTER_CITY_UPDATE_BOX:String = "OUTER_CITY_UPDATE_BOX";
      
      private var _data:Object;
      
      private var _isSwitchMap:Boolean;
      
      public function OuterCityEvent(param1:String, param2:Object, param3:Boolean = false)
      {
         _data = param2;
         _isSwitchMap = param3;
         super(param1,false,false);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get isSwitchMap() : Boolean
      {
         return _isSwitchMap;
      }
   }
}

