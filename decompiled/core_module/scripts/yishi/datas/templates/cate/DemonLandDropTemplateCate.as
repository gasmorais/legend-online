package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.DemonLandDropTemplate;
   
   public class DemonLandDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function DemonLandDropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByDropId(param1:int) : Array
      {
         var _loc3_:DemonLandDropTemplate = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _dic[param1] = [];
               for each(var _loc2_:XML in _list)
               {
                  if(int(_loc2_.@DropId) == param1)
                  {
                     _loc3_ = createNode(_loc2_,DemonLandDropTemplate) as DemonLandDropTemplate;
                     _dic[param1].push(_loc3_);
                  }
               }
            }
         }
         return _dic[param1];
      }
   }
}

