package mvc.module.skytreasure.info
{
   public class SkyTreasureHuntActiveVO
   {
      
      public var activeId:String;
      
      public var beginDate:Number;
      
      public var endDate:Number;
      
      public var isOpen:Boolean;
      
      public var joinInfo:SkyTreasurePlayerVO = new SkyTreasurePlayerVO();
      
      public var rewardList:Vector.<SkyTreasureRewardInfoVO> = new Vector.<SkyTreasureRewardInfoVO>();
      
      public function SkyTreasureHuntActiveVO()
      {
         super();
      }
   }
}

