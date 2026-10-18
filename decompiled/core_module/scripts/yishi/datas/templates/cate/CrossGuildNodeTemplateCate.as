package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CrossGuildNodeTemplate;
   
   public class CrossGuildNodeTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function CrossGuildNodeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getNodeTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@NodeId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,CrossGuildNodeTemplate,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByNodeId(param1:int) : CrossGuildNodeTemplate
      {
         var _loc3_:* = null;
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@NodeId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,CrossGuildNodeTemplate,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

