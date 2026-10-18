package mvc.module.theseus
{
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class TheseusPropertys
   {
      
      public var power:int;
      
      public var agility:int;
      
      public var intellect:int;
      
      public var captain:int;
      
      public var physique:int;
      
      public var attack:int;
      
      public var defence:int;
      
      public var magicAttack:int;
      
      public var magicDefence:int;
      
      public var forceHit:int;
      
      public var parry:int;
      
      public var live:int;
      
      public var conat:int;
      
      public var reduceResi:int;
      
      public var fireResi:int;
      
      public var waterResi:int;
      
      public var electResi:int;
      
      public var windResi:int;
      
      public var darkResi:int;
      
      public var lightResi:int;
      
      public var strength:int;
      
      public var tenacity:int;
      
      public var penetrate:int;
      
      public var stunAttr:int;
      
      public var reduceResiAgainst:int;
      
      public var resiPenetrate:int;
      
      public var armour:int;
      
      private var _thane:ThaneInfo;
      
      public function TheseusPropertys()
      {
         super();
         _thane = new ThaneInfo();
      }
      
      public function get thane() : ThaneInfo
      {
         refreshThaneInfo();
         return _thane;
      }
      
      private function refreshThaneInfo() : void
      {
         _thane.attackProrerty.totalIntensity = strength;
         _thane.attackProrerty.totalPhyAttack = attack;
         _thane.attackProrerty.totalPhyDefence = defence;
         _thane.attackProrerty.totalMagicAttack = magicAttack;
         _thane.attackProrerty.totalMagicDefence = magicDefence;
         _thane.attackProrerty.totalForceHit = forceHit;
         _thane.attackProrerty.totalParry = parry;
         _thane.attackProrerty.totalLive = live;
         _thane.attackProrerty.totalConatArmy = conat;
         _thane.attackProrerty.totalTenacity = tenacity;
         _thane.attackProrerty.totalPenetrate = penetrate;
         _thane.attackProrerty.totalDingli = stunAttr;
         _thane.baseProperty.totalPower = power;
         _thane.baseProperty.totalAgility = agility;
         _thane.baseProperty.totalIntellect = intellect;
         _thane.baseProperty.totalCaptain = captain;
         _thane.baseProperty.totalPhysique = physique;
         _thane.baseProperty.totalResistResi = reduceResi;
         _thane.baseProperty.totalResistResi = reduceResiAgainst;
         _thane.baseProperty.totalFireResi = fireResi;
         _thane.baseProperty.totalWaterResi = waterResi;
         _thane.baseProperty.totalElecResi = electResi;
         _thane.baseProperty.totalWindResi = windResi;
         _thane.baseProperty.totalDarkResi = darkResi;
         _thane.baseProperty.totalLightResi = lightResi;
         _thane.baseProperty.totalStrikeResi = resiPenetrate;
         _thane.grades = ArmyManager.instance.thane.grades;
      }
   }
}

