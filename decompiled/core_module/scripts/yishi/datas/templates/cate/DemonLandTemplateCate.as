package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.DemonLandTemplate;
   
   public class DemonLandTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function DemonLandTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByChapterAndNodeId(param1:int, param2:int) : DemonLandTemplate
      {
         var _loc4_:DemonLandTemplate = null;
         if(_list)
         {
            if(!_dic[param1 + "_" + param2])
            {
               for each(var _loc3_:XML in _list)
               {
                  if(int(_loc3_.@ChapterId) == param1 && int(_loc3_.@NodeId) == param2)
                  {
                     _loc4_ = createNode(_loc3_,DemonLandTemplate) as DemonLandTemplate;
                     _dic[param1 + "_" + param2] = _loc4_;
                  }
               }
            }
         }
         return _dic[param1 + "_" + param2] as DemonLandTemplate;
      }
   }
}

