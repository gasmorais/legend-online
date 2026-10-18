package map.internals.constant
{
   public class LoginState
   {
      
      public static const INCASTLE:int = 0;
      
      public static const CAMPAIGN:int = 4;
      
      public static const BATTLE:int = 5;
      
      public static const UNREAL_SHOOTING:int = 262;
      
      public static const SANDBOX_DAY_LIGHT:int = 6;
      
      public static const GAME_HALL:int = 7;
      
      public static const SECRET_WAR:int = 8;
      
      public function LoginState()
      {
         super();
      }
      
      public static function getState(param1:int) : String
      {
         if(param1 == 0)
         {
            return "CASTLE_SCENE";
         }
         if(param1 == 4)
         {
            return "CAMPAIGN_MAP_SCENE";
         }
         if(param1 == 5)
         {
            return "BATTLE_SCENE";
         }
         if(param1 == 262)
         {
            return "UNREAL_SHOOTING_ROOM";
         }
         if(param1 == 6)
         {
            return "SPACE_SCENE";
         }
         if(param1 == 7)
         {
            return "GAME_HALL_SCENE";
         }
         if(param1 == 8)
         {
            return "SECRET_WAR_SCENE";
         }
         return "";
      }
   }
}

