package mvc.module.crossguild
{
   import yishi.utils.SimpleDictionary;
   
   public class CrossGuildWarTeamInfo
   {
      
      public var consortiaName:String;
      
      public var serverName:String;
      
      public var blood:int;
      
      public var maxBlood:int;
      
      public var guildBufferId:int;
      
      public var towerDic:SimpleDictionary;
      
      public function CrossGuildWarTeamInfo()
      {
         super();
         towerDic = new SimpleDictionary();
      }
   }
}

