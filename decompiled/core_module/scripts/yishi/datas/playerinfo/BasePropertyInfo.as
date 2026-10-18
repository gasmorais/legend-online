package yishi.datas.playerinfo
{
   public class BasePropertyInfo
   {
      
      public var basePowerPoint:int;
      
      public var baseAgilityPoint:int;
      
      public var baseIntellectPoint:int;
      
      public var basePhysiquePoint:int;
      
      public var baseCaptainPoint:int;
      
      public var remainPoint:int;
      
      public var addPowerPoint:int;
      
      public var addAgilityPoint:int;
      
      public var addIntellectPoint:int;
      
      public var addPhysiquePoint:int;
      
      public var addCaptainPoint:int;
      
      public var totalPower:int;
      
      public var totalAgility:int;
      
      public var totalIntellect:int;
      
      public var totalCaptain:int;
      
      public var totalPhysique:int;
      
      public var totalBattleWill:int;
      
      public var totalFireResi:int;
      
      public var totalWaterResi:int;
      
      public var totalWindResi:int;
      
      public var totalElecResi:int;
      
      public var totalLightResi:int;
      
      public var totalDarkResi:int;
      
      public var totalStrikeResi:int;
      
      public var totalResistResi:int;
      
      public var hasSetBattleInfoFlag:Boolean = false;
      
      public var fashionPower:int;
      
      public var fashionAgility:int;
      
      public var fashionIntellect:int;
      
      public var fashionPhysigue:int;
      
      public var hasSetFashionProperty:Boolean = false;
      
      public function BasePropertyInfo()
      {
         super();
      }
      
      public function hasEffect(param1:String) : int
      {
         if(param1 == "powerPoint" && totalPower - basePowerPoint > 0)
         {
            return 2;
         }
         if(param1 == "agilityPoint" && totalAgility - baseAgilityPoint > 0)
         {
            return 2;
         }
         if(param1 == "intellectPoint" && totalIntellect - baseIntellectPoint > 0)
         {
            return 2;
         }
         if(param1 == "captainPoint" && totalCaptain - baseCaptainPoint > 0)
         {
            return 2;
         }
         if(param1 == "physiquePoint" && totalPhysique - basePhysiquePoint > 0)
         {
            return 2;
         }
         return 1;
      }
      
      public function commit() : void
      {
      }
   }
}

