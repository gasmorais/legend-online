package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.AreaMapDropTemplate;
   
   public class AreaMapDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function AreaMapDropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : Array
      {
         var _loc3_:* = null;
         if(_list)
         {
            if(_dic[param1])
            {
               return _dic[param1];
            }
            _loc3_ = _list.(@mapId == param1);
            for each(var _loc2_:XML in _loc3_)
            {
               if(!_dic[param1])
               {
                  _dic[param1] = [];
               }
               _dic[param1].push(createNode(_loc2_,AreaMapDropTemplate,_tempXml));
            }
         }
         return _dic[param1];
      }
   }
}

