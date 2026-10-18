package mvc.module.skytreasure
{
   public class SkyTreasureRankRewardInfo
   {
      
      public var rank:String;
      
      public var reqGrade:int;
      
      public var rewardDesc:String;
      
      public function SkyTreasureRankRewardInfo(param1:String, param2:int, param3:String)
      {
         super();
         this.rank = param1;
         this.reqGrade = param2;
         this.rewardDesc = param3;
      }
   }
}

