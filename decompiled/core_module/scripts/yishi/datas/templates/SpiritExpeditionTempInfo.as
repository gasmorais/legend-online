package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class SpiritExpeditionTempInfo
   {
      
      public var Id:int;
      
      public var AreaId:int;
      
      public var NodeId:int;
      
      public var Star:int;
      
      public var Bosses:String;
      
      public var Npcs:String;
      
      public function SpiritExpeditionTempInfo()
      {
         super();
      }
      
      public function get bossTemp() : GameHeroTempInfo
      {
         if(StringHelper.isNullOrEmpty(Bosses))
         {
            return null;
         }
         var _loc1_:int = int(Bosses.substring(0,Bosses.indexOf(",")));
         return TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc1_);
      }
      
      public function get npcTemp() : PawnTemplate
      {
         if(StringHelper.isNullOrEmpty(Npcs))
         {
            return null;
         }
         var _loc1_:int = int(Npcs.substring(0,Npcs.indexOf(",")));
         return TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc1_);
      }
   }
}

