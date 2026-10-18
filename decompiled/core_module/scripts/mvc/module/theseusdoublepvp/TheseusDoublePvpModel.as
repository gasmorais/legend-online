package mvc.module.theseusdoublepvp
{
   import yishi.utils.SimpleDictionary;
   
   public class TheseusDoublePvpModel
   {
      
      public var selfUserInfo:TheseusDoublePvpUserInfo;
      
      public var matchState:int = 1;
      
      public var matchSelfInfoArr:Array = [];
      
      public var matchOtherInfoArr:Array = [];
      
      public var resultInfo:TheseusDoublePvpFightResultInfo;
      
      public var leaveInfo:TheseusDoublePvpLeaveReportInfo;
      
      public var rewardDic:SimpleDictionary;
      
      public var seasonTimeInfo:TheseusDoublePvpSeasonInfo;
      
      public function TheseusDoublePvpModel()
      {
         super();
         selfUserInfo = new TheseusDoublePvpUserInfo();
         resultInfo = new TheseusDoublePvpFightResultInfo();
         leaveInfo = new TheseusDoublePvpLeaveReportInfo();
         rewardDic = new SimpleDictionary();
         seasonTimeInfo = new TheseusDoublePvpSeasonInfo();
      }
   }
}

