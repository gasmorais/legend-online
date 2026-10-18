package mvc.module.childnswar
{
   import flash.utils.Dictionary;
   import yishi.utils.SimpleDictionary;
   
   public class ChildNswarModel
   {
      
      public var selfUserInfo:ChildNswarUserInfo;
      
      public var matchState:int = 1;
      
      public var matchSelfInfo:ChildNswarMatchPlayInfo;
      
      public var matchOtherInfo:ChildNswarMatchPlayInfo;
      
      public var resultInfo:ChildNswarFightResultInfo;
      
      public var rewardDic:SimpleDictionary;
      
      public var seasonTimeInfo:ChildNswarSeasonInfo;
      
      public var battleInfo:ChildNswarBattleInfo;
      
      public var avatarPoolDic:Dictionary;
      
      public function ChildNswarModel()
      {
         super();
         selfUserInfo = new ChildNswarUserInfo();
         matchSelfInfo = new ChildNswarMatchPlayInfo();
         matchOtherInfo = new ChildNswarMatchPlayInfo();
         resultInfo = new ChildNswarFightResultInfo();
         rewardDic = new SimpleDictionary();
         seasonTimeInfo = new ChildNswarSeasonInfo();
         battleInfo = new ChildNswarBattleInfo();
         avatarPoolDic = new Dictionary(true);
      }
   }
}

