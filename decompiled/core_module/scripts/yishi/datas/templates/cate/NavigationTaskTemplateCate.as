package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.NavigationTaskTempInfo;
   
   public class NavigationTaskTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function NavigationTaskTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : NavigationTaskTempInfo
      {
         var _loc2_:XML = null;
         if(_list && !_dic[param1])
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,NavigationTaskTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

