package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ResolveTemplateInfo;
   
   public class ResolveTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ResolveTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByTypeAndTempId(param1:int, param2:int) : ResolveTemplateInfo
      {
         var _loc4_:* = null;
         var _loc3_:XML = null;
         if(param1 == 0 || param2 == 0)
         {
            return null;
         }
         var _loc5_:String = param1 + "_" + param2;
         if(_list)
         {
            if(!_dic[_loc5_])
            {
               _loc3_ = _list.(@Type == param1 && @ResolvedItem == param2)[0];
               if(_loc3_)
               {
                  _dic[_loc5_] = createNode(_loc3_,ResolveTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[_loc5_];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Type + "_" + _loc1_.@ResolvedItem;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,ResolveTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

