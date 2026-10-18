package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import yishi.datas.templates.OuterCityShopCostTemplateInfo;
   
   public class OuterCityShopCostTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXML:XML;
      
      public function OuterCityShopCostTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _tempXML = describeType(OuterCityShopCostTemplateInfo);
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,OuterCityShopCostTemplateInfo,_tempXML);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateById(param1:int) : OuterCityShopCostTemplateInfo
      {
         var _loc2_:XML = null;
         if(!_dic[param1] && _list)
         {
            _loc2_ = _list.(@Id == param1)[0];
            if(_loc2_)
            {
               _dic[param1] = createNode(_loc2_,OuterCityShopCostTemplateInfo,_tempXML);
            }
         }
         return _dic[param1] as OuterCityShopCostTemplateInfo;
      }
      
      public function getTemplatesByMapShopId(param1:int) : Array
      {
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc2_:Array = [];
         if(_list)
         {
            _loc5_ = _list.(@MapShopId == param1);
            for each(var _loc3_:XML in _loc5_)
            {
               _loc6_ = _loc3_.@Id;
               if(!_dic[_loc6_])
               {
                  _dic[_loc6_] = createNode(_loc3_,OuterCityShopCostTemplateInfo,_tempXML);
               }
               _loc2_.push(_dic[_loc6_] as OuterCityShopCostTemplateInfo);
            }
         }
         else
         {
            for each(var _loc4_:OuterCityShopCostTemplateInfo in _dic)
            {
               if(_loc4_.MapShopId == param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         _loc2_.sort(tempCompare);
         return _loc2_;
      }
      
      private function tempCompare(param1:OuterCityShopCostTemplateInfo, param2:OuterCityShopCostTemplateInfo) : int
      {
         if(!param1 || !param2)
         {
            return 0;
         }
         if(param1.NeedItemId < param2.NeedItemId)
         {
            return -1;
         }
         return 1;
      }
   }
}

