package mvc.module.matelords
{
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class MatelordsPlayerInfo
   {
      
      public var uuid:String;
      
      public var teamUid:String;
      
      public var userId:int;
      
      public var serverName:String;
      
      public var userKeys:String;
      
      public var nickName:String;
      
      public var job:int;
      
      public var sexJob:int;
      
      public var grades:int;
      
      public var fightPower:int;
      
      public var teamType:int;
      
      public var warIndex:int;
      
      public var curOrder:int;
      
      public var turnCount:int;
      
      public var totalScore:int;
      
      public var thaneInfo:ThaneInfo;
      
      public function MatelordsPlayerInfo()
      {
         super();
      }
      
      public function get teamName() : String
      {
         return LanguageMgr.GetTranslation("multilords.MultilordsMamanger.TeamTipsTxt",nickName);
      }
   }
}

