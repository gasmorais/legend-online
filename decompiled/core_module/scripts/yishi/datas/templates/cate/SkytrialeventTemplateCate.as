package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkytrialeventTemplateInfo;
   
   public class SkytrialeventTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SkytrialeventTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateById(param1:int) : SkytrialeventTemplateInfo
      {
         var _loc2_:XML = null;
         checkFirst();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@EventId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,SkytrialeventTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

