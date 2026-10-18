package yishi.manager
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.OutyardTemplateInfo;
   import yishi.datas.templates.cate.TemplateCate;
   
   public class OutyardTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function OutyardTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : OutyardTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list && !_dic[param1])
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@NodeTempId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,OutyardTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

