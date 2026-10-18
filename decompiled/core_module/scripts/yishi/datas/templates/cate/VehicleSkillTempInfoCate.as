package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.VehicleSkillTempInfo;
   
   public class VehicleSkillTempInfoCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function VehicleSkillTempInfoCate(param1:XMLList)
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
                  _dic[String(_loc1_.@TemplateId)] = createNode(_loc1_,VehicleSkillTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByTid(param1:int) : VehicleSkillTempInfo
      {
         var _loc3_:* = null;
         if(!_dic[param1] && _list)
         {
            _loc3_ = _list.(@TemplateId == param1);
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_;
            for each(var _loc2_:XML in _loc8_)
            {
               _dic[String(_loc2_.@TemplateId)] = createNode(_loc2_,VehicleSkillTempInfo,_tempXml);
            }
         }
         return _dic[param1] as VehicleSkillTempInfo;
      }
   }
}

