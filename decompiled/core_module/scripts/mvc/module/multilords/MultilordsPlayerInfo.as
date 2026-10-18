package mvc.module.multilords
{
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class MultilordsPlayerInfo
   {
      
      public var sort:int;
      
      public var userKey:String;
      
      public var serverName:String;
      
      public var userId:int;
      
      public var nickname:String;
      
      public var grade:int;
      
      public var fightingCapacity:int;
      
      public var fightingCapacityRank:int;
      
      public var isVip:Boolean;
      
      public var winCount:int;
      
      public var serialWinCount:int;
      
      public var awardGolds:int;
      
      public var prelimScore:int;
      
      public var betRank:int;
      
      public var uuid:String;
      
      public var teamId:String;
      
      public var teamLeader:String;
      
      public var thaneInfo:ThaneInfo;
      
      public function MultilordsPlayerInfo()
      {
         super();
      }
      
      public function get teamName() : String
      {
         return LanguageMgr.GetTranslation("multilords.MultilordsMamanger.TeamTipsTxt",teamLeader);
      }
      
      public function get isTempleGroup() : Boolean
      {
         return fightingCapacityRank > 0 && fightingCapacityRank <= 16;
      }
      
      public function get displaySort() : int
      {
         if(sort <= 0)
         {
            return sort;
         }
         if(fightingCapacityRank <= 16)
         {
            return sort;
         }
         return sort - 16;
      }
   }
}

