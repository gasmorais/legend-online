package mvc.module.apex
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.apex.ApexRankTeamMsg;
   import manager.LanguageMgr;
   
   public class ApexRankTeamData
   {
      
      public var teamUid:String;
      
      public var teamName:String;
      
      public var serverName:String;
      
      public var fightCapacity:int;
      
      public var score:int;
      
      public var rank:int;
      
      public var vipType:int;
      
      public var nextGroup:int;
      
      public var group:int;
      
      public function ApexRankTeamData(param1:ApexRankTeamMsg, param2:int)
      {
         super();
         teamUid = param1.teamUid;
         teamName = param1.teamName;
         serverName = param1.serverName;
         fightCapacity = Int64Utils.int64ToNumber(param1.fightCapacity);
         score = param1.score;
         rank = param1.rank;
         vipType = param1.vipType;
         nextGroup = param1.nextGroup;
         this.group = param2;
      }
      
      public function get groupStr() : String
      {
         return LanguageMgr.GetTranslation("apex.name." + group);
      }
   }
}

