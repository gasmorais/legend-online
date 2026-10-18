package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConsortiaBossTemplateInfo;
   
   public class ConsortiaBossTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ConsortiaBossTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByLevel(param1:int) : ConsortiaBossTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Level == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,ConsortiaBossTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

