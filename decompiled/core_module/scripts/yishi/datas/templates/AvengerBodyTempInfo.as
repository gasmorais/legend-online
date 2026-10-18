package yishi.datas.templates
{
   public class AvengerBodyTempInfo
   {
      
      public var Id:int;
      
      public var BodyType:int;
      
      public var BodyGrade:int;
      
      public var NeedItem:int;
      
      public var NeedItemNum:int;
      
      public var PhyAttack:int;
      
      public var PhyDefence:int;
      
      public var MagAttack:int;
      
      public var MagDefence:int;
      
      public var Health:int;
      
      public function AvengerBodyTempInfo()
      {
         super();
      }
      
      public function get showPropValueAry() : Array
      {
         return [PhyAttack,PhyDefence,MagDefence,Health];
      }
   }
}

