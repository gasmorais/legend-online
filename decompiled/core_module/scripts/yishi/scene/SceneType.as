package yishi.scene
{
   public class SceneType
   {
      
      public static const EMPTY_SCENE:String = "EMPTY_SCENE";
      
      public static const TRAINER_SCENE:String = "TRAINER_SCENE";
      
      public static const CASTLE_SCENE:String = "CASTLE_SCENE";
      
      public static const SPACE_SCENE:String = "SPACE_SCENE";
      
      public static const OUTER_CITY_SCENE:String = "OUTER_CITY_SCENE";
      
      public static const CAMPAIGN_MAP_SCENE:String = "CAMPAIGN_MAP_SCENE";
      
      public static const SINGLE_CAMPAIGN_MAP_SCENE:String = "SINGLE_CAMPAIGN_MAP_SCENE";
      
      public static const BATTLE_SCENE:String = "BATTLE_SCENE";
      
      public static const PVE_ROOM_SCENE:String = "PVE_ROOM_SCENE";
      
      public static const PVP_ROOM_SCENE:String = "PVP_ROOM_SCENE";
      
      public static const FARM:String = "FARM";
      
      public static const WARLORDS_ROOM:String = "WARLORDS_ROOM";
      
      public static const MULTILORDS_ROOM:String = "MULTILORDS_ROOM";
      
      public static const MATELORDS_ROOM:String = "MATELORDS_ROOM";
      
      public static const VEHICLE:String = "VEHICLE";
      
      public static const VEHICLE_ROOM_SCENE:String = "VEHICLE_ROOM_SCENE";
      
      public static const CHANLLENGE_ROOM_SCENE:String = "CHANLLENGE_ROOM_SCENE";
      
      public static const PLANES_WAR_SCENE:String = "PLANES_WAR_SCENE";
      
      public static const SKYBOX_ROAD_SCENE:String = "SKYBOX_ROAD_SCENE";
      
      public static const FINAL_DEFENSE_SCENE:String = "FINAL_DEFENSE_SCENE";
      
      public static const ARESLORDS_ROOM:String = "ARESLORDS_ROOM";
      
      public static const UNREAL_SHOOTING_ROOM:String = "UNREAL_SHOOTING_ROOM";
      
      public static const SANDBOX_SCENE:String = "SANDBOX_SCENE";
      
      public static const PLANE_CRISRIS:String = "PLANE_CRISRIS";
      
      public static const GAME_HALL_SCENE:String = "GAME_HALL_SCENE";
      
      public static const APEX_ROOM:String = "APEX_ROOM";
      
      public static const CROSS_GUILD_SCENE:String = "CROSS_GUILD_SCENE";
      
      public static const STARAREA_SCENE:String = "STARAREA_SCENE";
      
      public static const GLORY_GAME_ROOM:String = "GLORY_GAME_SCENE";
      
      public static const INCREASINGLY_ROAD_SCENE:String = "INCREASINGLY_ROAD_SCENE";
      
      public static const SELF_CHESS_SCENE:String = "SELF_CHESS_SCENE";
      
      public static const DARK_MAZE_SCENE:String = "DARK_MAZE_SCENE";
      
      public static const SECRET_ADVENTURE_SCENE:String = "SECRET_ADVENTURE_SCENE";
      
      public static const THESE_PVP_SCENE:String = "THESE_PVP_SCENE";
      
      public static const THESE_Double_PVP_SCENE:String = "THESE_Double_PVP_SCENE";
      
      public static const SECRET_WAR_SCENE:String = "SECRET_WAR_SCENE";
      
      public static const CHILD_NS_WAR_SCENE:String = "CHILD_NS_WAR_SCENE";
      
      public function SceneType()
      {
         super();
      }
      
      public static function getSceneTypeById(param1:int) : String
      {
         switch(param1)
         {
            case 1:
               return "CASTLE_SCENE";
            case 2:
               return "OUTER_CITY_SCENE";
            case 3:
               return "CAMPAIGN_MAP_SCENE";
            case 4:
               return "BATTLE_SCENE";
            case 5:
               return "PVE_ROOM_SCENE";
            case 6:
               return "PVP_ROOM_SCENE";
            case 7:
               return "FARM";
            case 8:
               return "VEHICLE";
            case 10:
               return "SPACE_SCENE";
            case 11:
               return "CHANLLENGE_ROOM_SCENE";
            case 13:
               return "MULTILORDS_ROOM";
            case 20:
               return "PLANES_WAR_SCENE";
            case 23:
               return "UNREAL_SHOOTING_ROOM";
            case 25:
               return "SANDBOX_SCENE";
            case 26:
               return "GAME_HALL_SCENE";
            case 27:
               return "STARAREA_SCENE";
            case 28:
               return "SECRET_ADVENTURE_SCENE";
            case 29:
               return "THESE_PVP_SCENE";
            case 30:
               return "SECRET_WAR_SCENE";
            case 31:
               return "CHILD_NS_WAR_SCENE";
            case 32:
               return "THESE_Double_PVP_SCENE";
            default:
               return "SPACE_SCENE";
         }
      }
   }
}

