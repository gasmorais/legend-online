package map.internals.constant
{
   public class NpcEffectiveState
   {
      
      public static var ATTACK_RADIUS:int = 600;
      
      public static var BATTLE_RADIUS:int = 60;
      
      public static var ALERT_RADIUS:int = 300;
      
      public static var TOWER_RADIUS:int = 60;
      
      private static var _isNovice:Boolean = true;
      
      public function NpcEffectiveState()
      {
         super();
      }
      
      public static function set novice(param1:Boolean) : void
      {
         _isNovice = param1;
         if(param1)
         {
            ATTACK_RADIUS = 600;
            BATTLE_RADIUS = 80;
            ALERT_RADIUS = 300;
         }
         else
         {
            ATTACK_RADIUS = 600;
            BATTLE_RADIUS = 60;
            ALERT_RADIUS = 300;
         }
      }
   }
}

