package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SignDropTemplate;
   
   public class SignDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SignDropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Times;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = [];
               }
               _dic[_loc2_].push(createNode(_loc1_,SignDropTemplate,_tempXml));
            }
         }
         return _dic;
      }
      
      public function getTemplateByIndex(param1:int) : Array
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
               _dic[param1].push(createNode(_loc2_,SignDropTemplate,_tempXml));
            }
         }
         return _dic[param1];
      }
   }
}

