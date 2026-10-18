package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.VehicleObjectTempInfo;
   
   public class VehicleObjectTempInfoCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _typeDic:Dictionary;
      
      private var _tempXml:XML;
      
      public function VehicleObjectTempInfoCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _typeDic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@TemplateId)])
               {
                  _dic[String(_loc1_.@TemplateId)] = createNode(_loc1_,VehicleObjectTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByIndex(param1:int) : VehicleObjectTempInfo
      {
         var _loc3_:* = null;
         if(!_dic[param1] && _list)
         {
            _loc3_ = _list.(@TemplateId == param1);
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_;
            for each(var _loc2_:XML in _loc8_)
            {
               _dic[String(_loc2_.@TemplateId)] = createNode(_loc2_,VehicleObjectTempInfo,_tempXml);
            }
         }
         return _dic[param1];
      }
      
      public function getTemplatesByType(param1:int) : Array
      {
         var _loc3_:String = "Type_" + param1;
         if(!_typeDic[_loc3_])
         {
            getTemplates();
            for each(var _loc2_:VehicleObjectTempInfo in _dic)
            {
               _loc3_ = "Type_" + _loc2_.Type;
               if(!_typeDic[_loc3_])
               {
                  _typeDic[_loc3_] = [];
               }
               _typeDic[_loc3_].push(_loc2_);
            }
            _loc3_ = "Type_" + param1;
         }
         return _typeDic[_loc3_];
      }
   }
}

