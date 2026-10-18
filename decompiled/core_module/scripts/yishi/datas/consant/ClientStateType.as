package yishi.datas.consant
{
   public class ClientStateType
   {
      
      public static const CLIENT_INCASTLE:int = 0;
      
      public static const CLIENT_ROOMLIST:int = 1;
      
      public static const CLIENT_GAMEROOM:int = 2;
      
      public static const CLIENT_WORLDMAP:int = 3;
      
      public static const CLIENT_CAMPAIGN:int = 4;
      
      public static const CLIENT_BATTLE:int = 5;
      
      public static const CLIENT_PVP_ROOM:int = 6;
      
      public function ClientStateType()
      {
         super();
      }
      
      public static function getClientState(param1:String) : int
      {
         switch(param1)
         {
            case "BATTLE_SCENE":
               return 5;
            case "CAMPAIGN_MAP_SCENE":
               return 4;
            case "CASTLE_SCENE":
               return 0;
            case "OUTER_CITY_SCENE":
               return 3;
            case "PVE_ROOM_SCENE":
               return 2;
            case "PVP_ROOM_SCENE":
               return 6;
            default:
               return -1;
         }
      }
   }
}

