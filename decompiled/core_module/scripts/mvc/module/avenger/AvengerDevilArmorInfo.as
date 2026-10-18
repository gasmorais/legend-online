package mvc.module.avenger
{
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class AvengerDevilArmorInfo
   {
      
      public var grade:int;
      
      public var exp:int;
      
      public var holeDic:SimpleDictionary;
      
      public function AvengerDevilArmorInfo()
      {
         super();
         holeDic = new SimpleDictionary();
      }
      
      public function get upgradeTempInfo() : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(grade,155);
      }
      
      public function get nextUpgradeTempInfo() : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(grade + 1,155);
      }
   }
}

