package mvc.module.children
{
   public class ChildAttValueInfo
   {
      
      public var attack:int;
      
      public var defence:int;
      
      public var magicAttack:int;
      
      public var magicDefence:int;
      
      public var hp:int;
      
      public var forceHit:int;
      
      public var parry:int;
      
      public var penetrate:int;
      
      public var stunAttr:int;
      
      public var reduceResi:int;
      
      public var fireResi:int;
      
      public var waterResi:int;
      
      public var electResi:int;
      
      public var windResi:int;
      
      public var darkResi:int;
      
      public var lightResi:int;
      
      public var strikeResi:int;
      
      public var resResistResi:int;
      
      public function ChildAttValueInfo()
      {
         super();
      }
      
      public function get resiArr() : Array
      {
         return [reduceResi,fireResi,waterResi,electResi,windResi,darkResi,lightResi,strikeResi,resResistResi];
      }
      
      public function get attValueArr() : Array
      {
         return [attack,defence,magicAttack,magicDefence,forceHit,penetrate,parry,hp,stunAttr];
      }
   }
}

