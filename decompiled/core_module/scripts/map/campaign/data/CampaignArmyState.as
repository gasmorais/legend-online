package map.campaign.data
{
   public class CampaignArmyState
   {
      
      public static const STATE_LIVE:int = 0;
      
      public static const STATE_DIED:int = 1;
      
      public static const STATE_TRAN:int = 2;
      
      public static const STATE_DIEDTRAN:int = 3;
      
      public static const STATE_DEFENCE:int = 4;
      
      public static const STATE_FLAME:int = 5;
      
      public static const STATE_CAR:int = 6;
      
      public static const STATE_CAR_DIE:int = 7;
      
      public static const STATE_TOWER:int = 8;
      
      public static const STATE_FLAG:int = 9;
      
      public static const STATE_GODDESS_TRAN:int = 10;
      
      public static const STATE_GODDESS_TRAN_DIE:int = 11;
      
      public static const STATE_GODDESS:int = 12;
      
      public function CampaignArmyState()
      {
         super();
      }
      
      public static function checkisFlag(param1:int) : Boolean
      {
         return param1 == 9;
      }
      
      public static function inVehicle(param1:int) : Boolean
      {
         return 6 == param1 || 7 == param1;
      }
      
      public static function inTower(param1:int) : Boolean
      {
         return 8 == param1;
      }
      
      public static function checkDied(param1:int) : Boolean
      {
         if(param1 == 1 || param1 == 3 || param1 == 7)
         {
            return true;
         }
         return false;
      }
      
      public static function checkIsFlameState(param1:int) : Boolean
      {
         return param1 == 5;
      }
      
      public static function checkIsDefence(param1:int) : Boolean
      {
         return param1 == 4;
      }
      
      public static function isStrongControl(param1:int) : Boolean
      {
         return false;
      }
   }
}

