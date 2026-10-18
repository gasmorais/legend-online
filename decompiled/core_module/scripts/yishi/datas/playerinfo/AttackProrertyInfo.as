package yishi.datas.playerinfo
{
   public class AttackProrertyInfo
   {
      
      public var totalPhyAttack:int;
      
      public var totalPhyDefence:int;
      
      public var totalMagicAttack:int;
      
      public var totalMagicDefence:int;
      
      public var totalForceHit:int;
      
      public var totalLive:int;
      
      public var totalConatArmy:int;
      
      public var totalParry:int;
      
      public var totalIntensity:int;
      
      public var totalTenacity:int;
      
      public var totalPenetrate:int;
      
      public var totalDingli:int;
      
      public var basePhyAttack:int;
      
      public var basePhyDefence:int;
      
      public var baseMagicAttack:int;
      
      public var baseMagicDefence:int;
      
      public var baseForceHit:int;
      
      public var baseConatArmy:int;
      
      public var baseLive:int;
      
      public var baseParry:int;
      
      public var baseIntensity:int;
      
      public var baseTenacity:int;
      
      public var basePenetrate:int;
      
      public var baseDingli:int;
      
      public function AttackProrertyInfo()
      {
         super();
      }
      
      public function hasEffect(param1:String) : int
      {
         if(param1 == "basePhyAttack" && totalPhyAttack - basePhyAttack > 0)
         {
            return 2;
         }
         if(param1 == "basePhyDefence" && totalPhyDefence - basePhyDefence > 0)
         {
            return 2;
         }
         if(param1 == "baseMagicAttack" && totalMagicAttack - baseMagicAttack > 0)
         {
            return 2;
         }
         if(param1 == "baseMagicDefence" && totalMagicDefence - baseMagicDefence > 0)
         {
            return 2;
         }
         if(param1 == "baseForceHit" && totalForceHit - baseForceHit > 0)
         {
            return 2;
         }
         if(param1 == "baseConatArmy" && totalConatArmy - baseConatArmy > 0)
         {
            return 2;
         }
         if(param1 == "baseLive" && totalLive - baseLive > 0)
         {
            return 2;
         }
         if(param1 == "baseParry" && totalParry - baseParry > 0)
         {
            return 2;
         }
         if(param1 == "baseTenacity" && totalTenacity - baseTenacity > 0)
         {
            return 2;
         }
         if(param1 == "baseIntensity" && totalIntensity - baseIntensity > 0)
         {
            return 2;
         }
         return 1;
      }
      
      public function get totalAttribute() : Number
      {
         return totalPhyAttack + totalPhyDefence + int(totalMagicAttack * 1.05) + totalMagicDefence + totalForceHit;
      }
      
      public function get totalIntensityEffect() : String
      {
         return (totalIntensity * 100 / (totalIntensity + 8000)).toFixed(2);
      }
      
      public function get totalTenacityEffect() : String
      {
         return (totalTenacity * 100 / (totalTenacity + 8000)).toFixed(2);
      }
      
      public function commit() : void
      {
      }
   }
}

