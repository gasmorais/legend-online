package yishi.datas.templates
{
   public class AvengerCommonTempInfo
   {
      
      public var Id:int;
      
      public var Type:int;
      
      public var Grade:int;
      
      public var NeedItem:int;
      
      public var NeedItemNum:int;
      
      public var PhyAttack:int;
      
      public var PhyDefence:int;
      
      public var MagAttack:int;
      
      public var MagDefence:int;
      
      public var Health:int;
      
      public function AvengerCommonTempInfo()
      {
         super();
      }
      
      public function get showPropValueAry() : Array
      {
         return [PhyAttack,PhyDefence,MagDefence,Health];
      }
   }
}

