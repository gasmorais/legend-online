package yishi.utils
{
   import manager.LanguageMgr;
   
   public class FormularySets
   {
      
      public static const STEP:Number = 9999999;
      
      public function FormularySets()
      {
         super();
      }
      
      public static function calcPawnCountByCaptainAndLevel(param1:int, param2:int) : int
      {
         return param1 + param2 * 2;
      }
      
      public static function calcHPByLevelAndPhysique(param1:int, param2:int) : int
      {
         return 100 + param1 * 10 + param2 * 5;
      }
      
      public static function calcCritByAgility(param1:int, param2:int) : int
      {
         return int(calcCritValueByAgility(param1) / param2 * 0.005);
      }
      
      public static function calcCritValueByAgility(param1:int) : int
      {
         return param1;
      }
      
      public static function calcPhysicalAttackByStrength(param1:int, param2:int) : int
      {
         return int(param1 * 2 + param2);
      }
      
      public static function calcPhysicalDefenceByStrengthAndPhysique(param1:int, param2:int) : int
      {
         return param1 + param2;
      }
      
      public static function calcMagicAttackByAbility(param1:int, param2:int) : int
      {
         return param1 * 2 + param2;
      }
      
      public static function calcMagicDefenceByAbilityAndPhysiqe(param1:int) : int
      {
         return param1;
      }
      
      public static function toStringSelf(param1:Number, param2:Number) : String
      {
         var _loc3_:String = null;
         if(param1 > param2)
         {
            param1 /= 1000;
            _loc3_ = param1 + LanguageMgr.GetTranslation("public.Thousands");
         }
         else
         {
            _loc3_ = int(param1).toString();
         }
         return _loc3_;
      }
      
      public static function toStringByNum(param1:Number, param2:Number) : String
      {
         var _loc3_:String = null;
         if(param1 > param2)
         {
            param1 /= 1000;
            _loc3_ = param1 + LanguageMgr.GetTranslation("public.Thousands");
         }
         else
         {
            _loc3_ = int(param1).toString();
         }
         return _loc3_;
      }
   }
}

