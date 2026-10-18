package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SuiteTempInfo;
   
   public class SuitTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SuitTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : SuiteTempInfo
      {
         var _loc2_:XML = null;
         if(param1 == 0)
         {
            return null;
         }
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,SuiteTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

