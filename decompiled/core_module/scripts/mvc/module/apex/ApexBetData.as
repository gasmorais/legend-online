package mvc.module.apex
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.apex.ApexBetMsg;
   import com.road.yishi.proto.apex.ApexRankTeamMsg;
   
   public class ApexBetData
   {
      
      public var selfBetTeamUid:String;
      
      public var selfBetCount:int;
      
      public var lastBetWinningCount:Number;
      
      public var currentBonusPool:Number;
      
      public var rankList:Array;
      
      public var guessGroup:int;
      
      public var guessRank:int;
      
      public function ApexBetData(param1:ApexBetMsg)
      {
         super();
         selfBetTeamUid = param1.selfBetTeamUid;
         selfBetCount = param1.selfBetCount;
         lastBetWinningCount = Int64Utils.int64ToNumber(param1.lastBetWinningCount);
         currentBonusPool = Int64Utils.int64ToNumber(param1.currentBonusPool);
         guessGroup = param1.guessGroup;
         guessRank = param1.guessRank;
         rankList = [];
         for each(var _loc2_:ApexRankTeamMsg in param1.rankList.teamList)
         {
            rankList.push(new ApexRankTeamData(_loc2_,param1.rankList.group));
         }
      }
      
      public function get betTeamData() : ApexRankTeamData
      {
         for each(var _loc1_:ApexRankTeamData in rankList)
         {
            if(_loc1_.teamUid == selfBetTeamUid)
            {
               return _loc1_;
            }
         }
         return null;
      }
   }
}

