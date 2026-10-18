package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ArtifactTemplateInfo;
   
   public class ArtifactTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ArtifactTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateById(param1:int) : ArtifactTemplateInfo
      {
         var _loc3_:* = null;
         if(param1 <= 0)
         {
            return null;
         }
         if(!_dic[param1] && _list)
         {
            _loc3_ = _list.(@TemplateId == param1);
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_;
            for each(var _loc2_:XML in _loc8_)
            {
               _dic[String(_loc2_.@TemplateId)] = createNode(_loc2_,ArtifactTemplateInfo,_tempXml);
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@TemplateId)])
               {
                  _dic[String(_loc1_.@TemplateId)] = createNode(_loc1_,ArtifactTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

