package yishi.datas.templates
{
   import manager.LanguageMgr;
   import yishi.manager.TempleteManager;
   
   public class ApexRewardDropTemp
   {
      
      public var id:int;
      
      public var dropId:int;
      
      public var site:String;
      
      public var para2:String;
      
      public var itemId:Number;
      
      public var count:int;
      
      public var isBind:Boolean;
      
      public var appearType:int;
      
      public var validDate:int;
      
      public function ApexRewardDropTemp()
      {
         super();
      }
      
      public function get sort() : int
      {
         return para2.split(",")[0];
      }
      
      public function get rankStr() : String
      {
         return LanguageMgr.GetTranslation("apex.award.str1",para2.replace(",","-"));
      }
      
      public function get nameAndCount() : String
      {
         return template.TemplateName + "*" + count;
      }
      
      public function get template() : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(itemId);
      }
      
      public function get isGradeData() : Boolean
      {
         return site.length < 2;
      }
   }
}

