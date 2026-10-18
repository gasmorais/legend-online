package mvc.module.raveparty
{
   import manager.LanguageMgr;
   
   public class RavePartyRewardInfo
   {
      
      public var uuid:String;
      
      public var rewardType:int;
      
      public var rewardLevel:int;
      
      public var needValue:int;
      
      public var startRank:int;
      
      public var endRank:int;
      
      public var rewardScore:int;
      
      public var rewardItem1:String;
      
      public var rewardItem2:String;
      
      public var rewardItem3:String;
      
      public var rewardItem4:String;
      
      public var rewardItem5:String;
      
      public var rewardItem6:String;
      
      public var rewardState:int;
      
      public function RavePartyRewardInfo()
      {
         super();
      }
      
      public function get rewardRankStr() : String
      {
         if(startRank == endRank && endRank != 0)
         {
            return LanguageMgr.GetTranslation("RavePartyRewardInfo.rewardRankStr.text1",endRank);
         }
         if(startRank != endRank && endRank != 0)
         {
            return LanguageMgr.GetTranslation("RavePartyRewardInfo.rewardRankStr.text2",startRank,endRank);
         }
         return LanguageMgr.GetTranslation("RavePartyRewardInfo.rewardRankStr.text3",startRank);
      }
   }
}

