package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MagicPubChatTemplateInfo;
   
   public class MagicPubChatTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MagicPubChatTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int, param2:int) : MagicPubChatTemplateInfo
      {
         var _loc3_:XML = null;
         var _loc4_:String = param1 + "_" + param2;
         if(_list)
         {
            if(!_dic[_loc4_])
            {
               _loc3_ = _list.(@TemplateId == param1 && @Grade == param2)[0];
               if(_loc3_)
               {
                  _dic[_loc4_] = createNode(_loc3_,MagicPubChatTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[_loc4_];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId + "_" + _loc1_.@Grade;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,MagicPubChatTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

