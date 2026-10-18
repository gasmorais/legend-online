package mvc.module.guildwanted
{
   import yishi.utils.SimpleDictionary;
   
   public class GuildWantedModel
   {
      
      public var personalScore:int;
      
      public var consortiaScore:int;
      
      public var leftCount:int;
      
      public var selfBoxState:SimpleDictionary;
      
      public var guildBoxState:SimpleDictionary;
      
      public var targetInfo:GuildWantedTargetInfo;
      
      public var myRank:int;
      
      public var totalScore:int;
      
      public var rankInfoList:SimpleDictionary;
      
      public var leftFreeRefreshCD:int;
      
      public function GuildWantedModel()
      {
         super();
         selfBoxState = new SimpleDictionary();
         guildBoxState = new SimpleDictionary();
         targetInfo = new GuildWantedTargetInfo();
         rankInfoList = new SimpleDictionary();
      }
   }
}

