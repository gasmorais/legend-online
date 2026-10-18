package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.OutyardTitanTemplateInfo;
   
   public class OutyardTitanTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function OutyardTitanTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_loc1_.@level + "_" + _loc1_.@itemId])
               {
                  _dic[_loc1_.@level + "_" + _loc1_.@itemId] = createNode(_loc1_,OutyardTitanTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

