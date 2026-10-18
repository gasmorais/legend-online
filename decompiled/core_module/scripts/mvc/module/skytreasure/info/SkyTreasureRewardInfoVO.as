package mvc.module.skytreasure.info
{
   public class SkyTreasureRewardInfoVO
   {
      
      public var packageId:String;
      
      public var itemsList:Vector.<SkyTreasureItemInfoVO> = new Vector.<SkyTreasureItemInfoVO>();
      
      public var type:int;
      
      public var param:int;
      
      public var statu:int;
      
      public function SkyTreasureRewardInfoVO()
      {
         super();
      }
   }
}

