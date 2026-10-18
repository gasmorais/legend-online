package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.BuildingTempInfo;
   
   public class BuildTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function BuildTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : BuildingTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,BuildingTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getBuildingTemplatesBySonType(param1:int) : Array
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:String = null;
         checkFirst();
         var _loc2_:Array = [];
         if(_list)
         {
            _loc5_ = _list.(@Sontype == param1);
            for each(var _loc3_:XML in _loc5_)
            {
               _loc6_ = _loc3_.@TemplateId;
               if(!_dic[_loc6_])
               {
                  _dic[_loc6_] = createNode(_loc3_,BuildingTempInfo,_tempXml) as BuildingTempInfo;
               }
               _loc2_.push(_dic[_loc6_]);
            }
         }
         else
         {
            for each(_loc4_ in _dic)
            {
               if(_loc4_.SonType == param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getInternalTechnologyTemplates() : Array
      {
         var _loc6_:* = null;
         var _loc2_:BuildingTempInfo = null;
         var _loc7_:String = null;
         checkFirst();
         var _loc3_:Array = [];
         var _loc5_:Dictionary = new Dictionary();
         if(_list)
         {
            _loc6_ = _list.(@MasterType == 13);
            for each(var _loc1_:XML in _loc6_)
            {
               _loc7_ = _loc1_.@TemplateId;
               _loc2_ = _dic[_loc7_] as BuildingTempInfo;
               if(!_loc2_)
               {
                  _loc2_ = _dic[_loc7_] = createNode(_loc1_,BuildingTempInfo,_tempXml) as BuildingTempInfo;
               }
               if(!_loc5_[_loc2_.SonType])
               {
                  _loc5_[_loc2_.SonType] = _loc2_;
                  _loc3_.push(_loc2_);
               }
            }
         }
         else
         {
            for each(var _loc4_:BuildingTempInfo in _dic)
            {
               if(_loc4_.MasterType == 13 && _loc5_[_loc4_.SonType] == null)
               {
                  _loc5_[_loc4_.SonType] = _loc4_;
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getWarTechnologyTemplates() : Array
      {
         var _loc6_:* = null;
         var _loc2_:BuildingTempInfo = null;
         var _loc7_:String = null;
         checkFirst();
         var _loc3_:Array = [];
         var _loc5_:Dictionary = new Dictionary();
         if(_list)
         {
            _loc6_ = _list.(@MasterType == 14);
            for each(var _loc1_:XML in _loc6_)
            {
               _loc7_ = _loc1_.@TemplateId;
               _loc2_ = _dic[_loc7_] as BuildingTempInfo;
               if(!_loc2_)
               {
                  _loc2_ = _dic[_loc7_] = createNode(_loc1_,BuildingTempInfo,_tempXml) as BuildingTempInfo;
               }
               if(!_loc5_[_loc2_.SonType])
               {
                  _loc5_[_loc2_.SonType] = _loc2_;
                  _loc3_.push(_loc2_);
               }
            }
         }
         else
         {
            for each(var _loc4_:BuildingTempInfo in _dic)
            {
               if(_loc4_.MasterType == 14 && _loc5_[_loc4_.SonType] == null)
               {
                  _loc5_[_loc4_.SonType] = _loc4_;
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getMinGradeBuildingTemplete(param1:int) : BuildingTempInfo
      {
         var _loc2_:XML = null;
         var _loc4_:String = null;
         checkFirst();
         if(_list)
         {
            _loc2_ = _list.(@BuildingGrade == 1 && @Sontype == param1)[0];
            if(_loc2_)
            {
               _loc4_ = _loc2_.@TemplateId;
               if(!_dic[_loc4_])
               {
                  _dic[_loc4_] = createNode(_loc2_,BuildingTempInfo,_tempXml);
               }
               return _dic[_loc4_] as BuildingTempInfo;
            }
         }
         else
         {
            for each(var _loc3_:BuildingTempInfo in _dic)
            {
               if(_loc3_.SonType == param1 && _loc3_.BuildingGrade == 1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
   }
}

