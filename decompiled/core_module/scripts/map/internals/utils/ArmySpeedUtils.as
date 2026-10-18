package map.internals.utils
{
   import managers.MountsManager;
   import mvc.module.armyII.BaseArmy;
   
   public class ArmySpeedUtils
   {
      
      public function ArmySpeedUtils()
      {
         super();
      }
      
      public static function getMoveSpeed(param1:BaseArmy = null) : Number
      {
         var _loc2_:Number = 7;
         if(param1)
         {
            if(param1.mountTemplate)
            {
               _loc2_ = 7 * (100 + MountsManager.instance.avatarList.getSpeedMaxMount()) / 100;
            }
            else
            {
               _loc2_ = 7;
            }
         }
         return _loc2_;
      }
   }
}

