package mvc.module.gamehall
{
   import manager.LanguageMgr;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.datas.templates.GameHallTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class GameHallGameInfo
   {
      
      public var teamId:int;
      
      public var gameId:int;
      
      public var difficulty:int;
      
      public function GameHallGameInfo()
      {
         super();
      }
      
      public function get templateInfo() : GameHallTemplateInfo
      {
         return TempleteManager.instance.gameHallTemplateCate.getTemplateByID(gameId);
      }
      
      public function get eastTemplateInfo() : GameHallEasterTemplateInfo
      {
         return TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(difficulty);
      }
      
      public function get gameName() : String
      {
         if(templateInfo)
         {
            if(gameId == 4)
            {
               if(eastTemplateInfo)
               {
                  return eastTemplateInfo.TemplateName;
               }
               return "";
            }
            if(difficulty != 0)
            {
               return templateInfo.GameName + LanguageMgr.GetTranslation("planeCrisis.DiffName" + difficulty);
            }
            return templateInfo.GameName;
         }
         return "测试数据_" + gameId + "_" + difficulty;
      }
   }
}

