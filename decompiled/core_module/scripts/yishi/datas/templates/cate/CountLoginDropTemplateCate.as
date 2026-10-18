package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CountLoginDropTemplate;
   
   public class CountLoginDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function CountLoginDropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByIndex(param1:int) : Array
      {
         var _loc3_:* = null;
         if(_list)
         {
            _loc3_ = _list.(@Times == param1);
            for each(var _loc2_:XML in _loc3_)
            {
               if(!_dic[param1])
               {
                  _dic[param1] = [];
               }
               _dic[param1].push(createNode(_loc2_,CountLoginDropTemplate,_tempXml));
            }
         }
         return _dic[param1];
      }
   }
}

