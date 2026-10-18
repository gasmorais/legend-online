package yishi.manager
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.OutyardAreaTemplateInfo;
   import yishi.datas.templates.cate.TemplateCate;
   
   public class OutyardAreaTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function OutyardAreaTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : OutyardAreaTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list && !_dic[param1])
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@EventId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,OutyardAreaTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

