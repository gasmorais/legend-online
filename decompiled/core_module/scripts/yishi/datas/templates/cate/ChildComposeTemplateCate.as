package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChildComposeTempInfo;
   
   public class ChildComposeTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChildComposeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByJobType(param1:int) : ChildComposeTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@JobType == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,ChildComposeTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

