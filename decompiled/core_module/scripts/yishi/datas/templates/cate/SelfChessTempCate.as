package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SelfChessTempInfo;
   
   public class SelfChessTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SelfChessTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:int = 0;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = int(_loc1_.@TemplateId);
               _dic[_loc2_] = createNode(_loc1_,SelfChessTempInfo,_tempXml) as SelfChessTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTempById(param1:int) : SelfChessTempInfo
      {
         return _dic[param1];
      }
   }
}

