package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class SingleCampaignDataTempInfo
   {
      
      public var Id:int;
      
      public var CampaignId:int;
      
      public var NodeName:String;
      
      public var Index:int;
      
      public var MasterType:int;
      
      public var Heros:String;
      
      public var Soldiers:String;
      
      public var ResPath:String;
      
      public var HeroGp:int;
      
      public var Scale:int;
      
      public var Param1:int;
      
      public var Param2:int;
      
      public function SingleCampaignDataTempInfo()
      {
         super();
      }
      
      public function get bossTemp() : GameHeroTempInfo
      {
         if(StringHelper.isNullOrEmpty(Heros))
         {
            return null;
         }
         var _loc1_:int = int(Heros.substring(0,Heros.indexOf(",")));
         return TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc1_);
      }
      
      public function get soldierTemp() : PawnTemplate
      {
         if(StringHelper.isNullOrEmpty(Soldiers))
         {
            return null;
         }
         var _loc1_:int = int(Soldiers.substring(0,Soldiers.indexOf(",")));
         return TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc1_);
      }
   }
}

