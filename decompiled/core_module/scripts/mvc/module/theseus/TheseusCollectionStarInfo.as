package mvc.module.theseus
{
   public class TheseusCollectionStarInfo
   {
      
      public var Id:int;
      
      public var CollectionName:String;
      
      public var Description:String;
      
      public var Icon:String;
      
      public var Quality:int;
      
      public var UpGold:int;
      
      public var UpNeed:String;
      
      public var UpNeed2:String;
      
      public var Specialeffect:int;
      
      public var SpecialeffectDesc:String;
      
      public var chipId:int;
      
      public var chipNeedNum:int;
      
      public var chipId1:int;
      
      public var chipNeedNum1:int;
      
      public var quality:int;
      
      public var Power:int;
      
      public var Agility:int;
      
      public var Intellect:int;
      
      public var Physique:int;
      
      public var Captain:int;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var MagicAttack:int;
      
      public var MagicDefence:int;
      
      public var ForceHit:int;
      
      public var StunAttr:int;
      
      public var Parry:int;
      
      public var Penetrate:int;
      
      public var Live:int;
      
      public var Conat:int;
      
      public var Property1:int;
      
      public var Property2:int;
      
      public var Property3:int;
      
      public var Property4:int;
      
      public var Property5:int;
      
      public var Property6:int;
      
      public var Property7:int;
      
      public var SellGold:int;
      
      public var DefaultSkill:String;
      
      public var Avata:String;
      
      public var StrengthenMax:int;
      
      public var RandomSkillCount:int;
      
      public var SuiteId:int;
      
      public var Refresh:int;
      
      public var Strength:int;
      
      public var Tenacity:int;
      
      public var ReduceResi:int;
      
      public var FireResi:int;
      
      public var WaterResi:int;
      
      public var ElectResi:int;
      
      public var WindResi:int;
      
      public var DarkResi:int;
      
      public var LightResi:int;
      
      public var NeedChangeJob:int;
      
      public var IsOpen:int;
      
      public var ReduceResiAgainst:int;
      
      public var ResiPenetrate:int;
      
      public function TheseusCollectionStarInfo()
      {
         super();
      }
      
      public function setChip() : void
      {
         var _loc1_:Array = UpNeed.split("|");
         chipId = _loc1_[0].split(",")[0];
         chipNeedNum = _loc1_[0].split(",")[1];
         if(_loc1_[1])
         {
            chipId1 = _loc1_[1].split(",")[0];
            chipNeedNum1 = _loc1_[1].split(",")[1];
         }
      }
      
      public function get hasValueAtt() : Array
      {
         var _loc1_:Array = [];
         if(Power != 0)
         {
            _loc1_.push("Power");
         }
         if(Agility != 0)
         {
            _loc1_.push("Agility");
         }
         if(Intellect != 0)
         {
            _loc1_.push("Intellect");
         }
         if(Physique != 0)
         {
            _loc1_.push("Physique");
         }
         if(Captain != 0)
         {
            _loc1_.push("Captain");
         }
         if(Attack != 0)
         {
            _loc1_.push("Attack");
         }
         if(Defence != 0)
         {
            _loc1_.push("Defence");
         }
         if(MagicAttack != 0)
         {
            _loc1_.push("MagicAttack");
         }
         if(MagicDefence != 0)
         {
            _loc1_.push("MagicDefence");
         }
         if(ForceHit != 0)
         {
            _loc1_.push("ForceHit");
         }
         if(StunAttr != 0)
         {
            _loc1_.push("StunAttr");
         }
         if(Parry != 0)
         {
            _loc1_.push("Parry");
         }
         if(Penetrate != 0)
         {
            _loc1_.push("Penetrate");
         }
         if(Live != 0)
         {
            _loc1_.push("Live");
         }
         if(Conat != 0)
         {
            _loc1_.push("Conat");
         }
         if(ReduceResi != 0)
         {
            _loc1_.push("ReduceResi");
         }
         if(FireResi != 0)
         {
            _loc1_.push("FireResi");
         }
         if(WaterResi != 0)
         {
            _loc1_.push("WaterResi");
         }
         if(ElectResi != 0)
         {
            _loc1_.push("ElectResi");
         }
         if(WindResi != 0)
         {
            _loc1_.push("WindResi");
         }
         if(DarkResi != 0)
         {
            _loc1_.push("DarkResi");
         }
         if(LightResi != 0)
         {
            _loc1_.push("LightResi");
         }
         if(ReduceResiAgainst != 0)
         {
            _loc1_.push("ReduceResiAgainst");
         }
         if(ResiPenetrate != 0)
         {
            _loc1_.push("ResiPenetrate");
         }
         if(StunAttr != 0)
         {
            _loc1_.push("StunAttr");
         }
         if(Strength != 0)
         {
            _loc1_.push("Strength");
         }
         return _loc1_;
      }
   }
}

