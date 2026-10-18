package mvc.module.stele
{
   public class StelaAttInfo
   {
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var MagicAttack:int;
      
      public var MagicDefence:int;
      
      public var Live:int;
      
      public var ForceHit:int;
      
      public var Parry:int;
      
      public var Penetrate:int;
      
      public var ReduceResiAgainst:int;
      
      public var ResiPenetrate:int;
      
      public function StelaAttInfo()
      {
         super();
      }
      
      public function reset() : void
      {
         Attack = 0;
         Defence = 0;
         MagicAttack = 0;
         MagicDefence = 0;
         Live = 0;
         ForceHit = 0;
         Parry = 0;
         Penetrate = 0;
         ReduceResiAgainst = 0;
         ResiPenetrate = 0;
      }
      
      public function clone() : StelaAttInfo
      {
         var _loc1_:StelaAttInfo = new StelaAttInfo();
         _loc1_.Attack = Attack;
         _loc1_.Defence = Defence;
         _loc1_.MagicAttack = MagicAttack;
         _loc1_.MagicDefence = MagicDefence;
         _loc1_.Live = Live;
         _loc1_.ForceHit = ForceHit;
         _loc1_.Parry = Parry;
         _loc1_.Penetrate = Penetrate;
         _loc1_.ReduceResiAgainst = ReduceResiAgainst;
         _loc1_.ResiPenetrate = ResiPenetrate;
         return _loc1_;
      }
      
      public function get hasValueAtt() : Array
      {
         var _loc1_:Array = [];
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
         if(Live != 0)
         {
            _loc1_.push("Live");
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
         if(ReduceResiAgainst != 0)
         {
            _loc1_.push("ReduceResiAgainst");
         }
         if(ResiPenetrate != 0)
         {
            _loc1_.push("ResiPenetrate");
         }
         return _loc1_;
      }
      
      public function get allValueAtt() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("Attack");
         _loc1_.push("Defence");
         _loc1_.push("MagicAttack");
         _loc1_.push("MagicDefence");
         _loc1_.push("Live");
         _loc1_.push("ForceHit");
         _loc1_.push("Parry");
         _loc1_.push("Penetrate");
         _loc1_.push("ReduceResiAgainst");
         _loc1_.push("ResiPenetrate");
         return _loc1_;
      }
   }
}

