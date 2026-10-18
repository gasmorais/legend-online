package yishi.datas.templates
{
   import manager.LanguageMgr;
   
   public class GoddessEquipTempInfo
   {
      
      public static const TYPE_STRENGTH:int = 1;
      
      public static const TYPE_STEP:int = 2;
      
      public static const TYPE_SUIT:int = 3;
      
      public var Id:int;
      
      public var AdvanceType:int;
      
      public var EquipType:int;
      
      public var Grade:int;
      
      public var AdvanceCost:String;
      
      public var StrengthenLevelMax:int;
      
      public var HpValue:int;
      
      public var PhysicalDefenceValue:int;
      
      public var MagicalDefenceValue:int;
      
      public var AttackValue:int;
      
      public var HitValue:int;
      
      public var PenetrationValue:int;
      
      public var Blessing:String;
      
      public function GoddessEquipTempInfo()
      {
         super();
      }
      
      public static function getEquipName(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("goddess.equip.headName");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("goddess.equip.earName");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("goddess.equip.flowName");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("goddess.equip.xlName");
         }
         return _loc2_;
      }
      
      public function getKeyValues() : Array
      {
         var _loc1_:Array = [];
         if(HpValue > 0)
         {
            _loc1_.push([HpValue,LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11")]);
         }
         if(PhysicalDefenceValue > 0)
         {
            _loc1_.push([PhysicalDefenceValue,LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07")]);
         }
         if(MagicalDefenceValue > 0)
         {
            _loc1_.push([MagicalDefenceValue,LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09")]);
         }
         if(AttackValue > 0)
         {
            _loc1_.push([AttackValue,LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip29")]);
         }
         if(HitValue > 0)
         {
            _loc1_.push([HitValue,LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10")]);
         }
         if(PenetrationValue > 0)
         {
            _loc1_.push([PenetrationValue,LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25")]);
         }
         return _loc1_;
      }
   }
}

