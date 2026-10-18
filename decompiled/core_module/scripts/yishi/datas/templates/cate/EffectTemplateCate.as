package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.EffectTemplateInfo;
   
   public class EffectTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function EffectTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : EffectTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,EffectTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1] as EffectTemplateInfo;
      }
   }
}

