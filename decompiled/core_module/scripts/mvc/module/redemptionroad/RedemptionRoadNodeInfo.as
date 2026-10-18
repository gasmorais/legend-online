package mvc.module.redemptionroad
{
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.TempleteManager;
   
   public class RedemptionRoadNodeInfo
   {
      
      public var id:int;
      
      public var layer:int;
      
      public var pos:int;
      
      public var buff:int;
      
      public var debuff:int;
      
      public var boss:String;
      
      public var npc:String;
      
      public var rewards:String;
      
      public function RedemptionRoadNodeInfo()
      {
         super();
      }
      
      public function getBossTemp() : GameHeroTempInfo
      {
         var _loc1_:int = int(boss.substring(0,boss.indexOf(",")));
         return TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc1_);
      }
      
      public function getNpcTemp() : PawnTemplate
      {
         var _loc1_:int = int(npc.substring(0,npc.indexOf(",")));
         return TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc1_);
      }
   }
}

