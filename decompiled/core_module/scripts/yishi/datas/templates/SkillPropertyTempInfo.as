package yishi.datas.templates
{
   public class SkillPropertyTempInfo
   {
      
      public var TemplateId:int;
      
      public var AddType:int;
      
      public var Power:int;
      
      public var Agility:int;
      
      public var Intellect:int;
      
      public var Captain:int;
      
      public var Physique:int;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var MagicAttack:int;
      
      public var MagicDefence:int;
      
      public var ForceHit:int;
      
      public var Parry:int;
      
      public var Penetrate:int;
      
      public var Live:int;
      
      public var Conat:int;
      
      public var StunAttr:int;
      
      public var Strength:int;
      
      public var Tenacity:int;
      
      public var ReduceResi:int;
      
      public var FireResi:int;
      
      public var WaterResi:int;
      
      public var LightResi:int;
      
      public var DarkResi:int;
      
      public var WindResi:int;
      
      public var ElectResi:int;
      
      public var ResiPenetrate:int;
      
      public var ReduceResiAgainst:int;
      
      public function SkillPropertyTempInfo()
      {
         super();
      }
      
      public function get allAttName() : Array
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
         if(StunAttr != 0)
         {
            _loc1_.push("StunAttr");
         }
         if(Strength != 0)
         {
            _loc1_.push("Strength");
         }
         if(Tenacity != 0)
         {
            _loc1_.push("Tenacity");
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
         if(LightResi != 0)
         {
            _loc1_.push("LightResi");
         }
         if(DarkResi != 0)
         {
            _loc1_.push("DarkResi");
         }
         if(WindResi != 0)
         {
            _loc1_.push("WindResi");
         }
         if(ElectResi != 0)
         {
            _loc1_.push("ElectResi");
         }
         if(ResiPenetrate != 0)
         {
            _loc1_.push("ResiPenetrate");
         }
         if(ReduceResiAgainst != 0)
         {
            _loc1_.push("ReduceResiAgainst");
         }
         return _loc1_;
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
         return _loc1_;
      }
      
      public function get hasKanAtt() : Array
      {
         var _loc1_:Array = [];
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
         if(LightResi != 0)
         {
            _loc1_.push("LightResi");
         }
         if(DarkResi != 0)
         {
            _loc1_.push("DarkResi");
         }
         if(WindResi != 0)
         {
            _loc1_.push("WindResi");
         }
         if(ElectResi != 0)
         {
            _loc1_.push("ElectResi");
         }
         if(ResiPenetrate != 0)
         {
            _loc1_.push("ResiPenetrate");
         }
         if(ReduceResiAgainst != 0)
         {
            _loc1_.push("ReduceResiAgainst");
         }
         return _loc1_;
      }
   }
}

