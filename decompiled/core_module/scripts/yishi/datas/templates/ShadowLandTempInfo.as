package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class ShadowLandTempInfo
   {
      
      public var CheckpointId:int;
      
      public var AreaId:int;
      
      public var NodeId:int;
      
      public var Difficulty:int;
      
      public var Npc1:String;
      
      public var Npc2:String;
      
      public var Npc3:String;
      
      public var Bosses:String;
      
      public function ShadowLandTempInfo()
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
         if(StringHelper.isNullOrEmpty(Npc1))
         {
            return null;
         }
         var _loc1_:int = int(Npc1.substring(0,Npc1.indexOf(",")));
         return TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc1_);
      }
   }
}

