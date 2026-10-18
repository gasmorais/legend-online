package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.VehicleAdditionTemplate;
   
   public class VehicleAdditionTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function VehicleAdditionTemplateCate(param1:XMLList)
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
               if(!_dic[String(_loc1_.@TemplateId)])
               {
                  _dic[String(_loc1_.@TemplateId)] = createNode(_loc1_,VehicleAdditionTemplate,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByIndex(param1:int) : VehicleAdditionTemplate
      {
         var _loc3_:* = null;
         if(!_dic[param1] && _list)
         {
            _loc3_ = _list.(@TemplateId == param1);
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_;
            for each(var _loc2_:XML in _loc8_)
            {
               _dic[String(_loc2_.@TemplateId)] = createNode(_loc2_,VehicleAdditionTemplate,_tempXml);
            }
         }
         return _dic[param1];
      }
   }
}

