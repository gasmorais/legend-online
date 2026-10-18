package mvc.module.theseuspvp
{
   import mvc.module.theseusdoublepvp.TheseusDoublePvpMatchPlayerInfo;
   import yishi.utils.SimpleDictionary;
   
   public class TheseusPvpModel
   {
      
      public var selfUserInfo:TheseusPvpUserInfo;
      
      public var matchState:int = 1;
      
      public var matchSelfInfo:TheseusPvpMatchPlayerInfo;
      
      public var matchOtherInfo:TheseusPvpMatchPlayerInfo;
      
      public var resultInfo:TheseusPvpFightResultInfo;
      
      public var leaveInfo:TheseusPvpLeaveReportInfo;
      
      public var rewardDic:SimpleDictionary;
      
      public var seasonTimeInfo:TheseusPvpSeasonInfo;
      
      public var matchSelfInfoArr:Array = [];
      
      public var matchOtherInfoArr:Array = [];
      
      public function TheseusPvpModel()
      {
         super();
         selfUserInfo = new TheseusPvpUserInfo();
         matchSelfInfo = new TheseusPvpMatchPlayerInfo();
         matchOtherInfo = new TheseusPvpMatchPlayerInfo();
         resultInfo = new TheseusPvpFightResultInfo();
         leaveInfo = new TheseusPvpLeaveReportInfo();
         rewardDic = new SimpleDictionary();
         seasonTimeInfo = new TheseusPvpSeasonInfo();
         var _loc1_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc1_.job = 1;
         _loc1_.fightCapacity = 2;
         _loc1_.nickName = "a";
         _loc1_.pvpId = 1;
         _loc1_.serverName = "hahah";
         var _loc2_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc2_.job = 1;
         _loc2_.fightCapacity = 2;
         _loc2_.nickName = "b";
         _loc2_.pvpId = 1;
         _loc2_.serverName = "hahah";
         var _loc3_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc3_.job = 1;
         _loc3_.fightCapacity = 2;
         _loc3_.nickName = "c";
         _loc3_.pvpId = 1;
         _loc3_.serverName = "hahah";
         var _loc4_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc4_.job = 1;
         _loc4_.fightCapacity = 2;
         _loc4_.nickName = "d";
         _loc4_.pvpId = 1;
         _loc4_.serverName = "hahah";
         var _loc5_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc5_.job = 1;
         _loc5_.fightCapacity = 2;
         _loc5_.nickName = "e";
         _loc5_.pvpId = 1;
         _loc5_.serverName = "hahah";
         var _loc8_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc8_.job = 1;
         _loc8_.fightCapacity = 2;
         _loc8_.nickName = "f";
         _loc8_.pvpId = 1;
         _loc8_.serverName = "hahah";
         var _loc7_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc7_.job = 1;
         _loc7_.fightCapacity = 2;
         _loc7_.nickName = "g";
         _loc7_.pvpId = 1;
         _loc7_.serverName = "hahah";
         var _loc6_:TheseusDoublePvpMatchPlayerInfo = new TheseusDoublePvpMatchPlayerInfo();
         _loc6_.job = 1;
         _loc6_.fightCapacity = 2;
         _loc6_.nickName = "h";
         _loc6_.pvpId = 1;
         _loc6_.serverName = "hahah";
         matchSelfInfoArr = [_loc1_,_loc2_,_loc3_,_loc4_];
         matchOtherInfoArr = [_loc5_,_loc8_,_loc7_,_loc6_];
      }
   }
}

