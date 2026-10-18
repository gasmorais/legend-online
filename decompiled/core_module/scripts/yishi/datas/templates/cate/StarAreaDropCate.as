package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StarareaDropTemplate;
   
   public class StarAreaDropCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function StarAreaDropCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByTypeAndNode(param1:int, param2:int) : Array
      {
         var _loc4_:StarareaDropTemplate = null;
         if(_list)
         {
            if(!_dic[param1 + "_" + param2])
            {
               _dic[param1 + "_" + param2] = [];
               for each(var _loc3_:XML in _list)
               {
                  if(int(_loc3_.@site) == param1 && int(_loc3_.@para2) == param2)
                  {
                     _loc4_ = createNode(_loc3_,StarareaDropTemplate) as StarareaDropTemplate;
                     _dic[param1 + "_" + param2].push(_loc4_);
                  }
               }
            }
         }
         return _dic[param1 + "_" + param2];
      }
   }
}

