package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.FurnitureTempInfo;
   
   public class FurnitureTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function FurnitureTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      private function initDic() : void
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@TemplateId)])
               {
                  _dic[String(_loc1_.@TemplateId)] = createNode(_loc1_,FurnitureTempInfo,_tempXml);
               }
            }
         }
      }
      
      public function getTemplates() : Dictionary
      {
         initDic();
         return _dic;
      }
      
      public function getTempById(param1:int) : FurnitureTempInfo
      {
         initDic();
         for each(var _loc2_:FurnitureTempInfo in _dic)
         {
            if(_loc2_.TemplateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

