package mvc.module.avenger
{
   import yishi.datas.templates.AvengerCommonTempInfo;
   import yishi.manager.TempleteManager;
   
   public class AvengerDevilArmorHoleInfo
   {
      
      public static const ARMOR_HOLE_TYPE:int = 1;
      
      public var pos:int;
      
      public var grade:int;
      
      public var exp:int;
      
      public var inlayItem:int;
      
      public function AvengerDevilArmorHoleInfo()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return grade > 0;
      }
      
      public function get tempInfo() : AvengerCommonTempInfo
      {
         return TempleteManager.instance.avengerCommonTempCate.getTemplateByTypeAndGrade(1,grade);
      }
      
      public function get nextTempInfo() : AvengerCommonTempInfo
      {
         return TempleteManager.instance.avengerCommonTempCate.getTemplateByTypeAndGrade(1,grade + 1);
      }
   }
}

