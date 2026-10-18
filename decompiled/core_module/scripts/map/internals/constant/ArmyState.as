package map.internals.constant
{
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.view.tips.MessageTipManager;
   
   public class ArmyState
   {
      
      public static const STATE_WAITING:int = 0;
      
      public static const STATE_MOVING:int = 1;
      
      public static const STATE_FIGHT:int = 2;
      
      public static const BATTLE_PENDING:int = 3;
      
      public static const RECALLING:int = 4;
      
      public static const CAMPAIGN:int = 6;
      
      public function ArmyState()
      {
         super();
      }
      
      public static function checkCampaignAttack(param1:int) : Boolean
      {
         if(param1 == 3 || param1 == 2)
         {
            return false;
         }
         return true;
      }
      
      public static function returnHome(param1:int) : Boolean
      {
         if(param1 == 4 || param1 == 0)
         {
            return true;
         }
         return false;
      }
      
      public static function moveState(param1:int) : Boolean
      {
         if(param1 == 4 || param1 == 1)
         {
            return true;
         }
         return false;
      }
      
      public static function checkAttackRange(param1:Point, param2:Point) : Boolean
      {
         var _loc3_:String = null;
         if(Point.distance(param1,param2) > 430)
         {
            _loc3_ = LanguageMgr.GetTranslation("map.internals.constant.ArmyState.command03");
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         return true;
      }
   }
}

