package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StelaStepTemplateInfo;
   
   public class StelaStepTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function StelaStepTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@StelaId + "_" + _loc1_.@Step;
               _dic[_loc2_] = createNode(_loc1_,StelaStepTemplateInfo,_tempXml) as StelaStepTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplateById(param1:int, param2:int) : StelaStepTemplateInfo
      {
         var _loc3_:String = param1 + "_" + param2;
         return _dic[_loc3_];
      }
   }
}

