package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.VipPrerogativeInfo;
   
   public class VipPrerogativeTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public var totoalLen:int;
      
      public function VipPrerogativeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         totoalLen = param1.length();
      }
      
      public function getVipPrerogativeTypeTempList(param1:int) : Array
      {
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc2_:Array = [];
         if(_list)
         {
            _loc5_ = _list.(@type == param1);
            for each(var _loc3_:XML in _loc5_)
            {
               _loc6_ = _loc3_.@id;
               if(!_dic[_loc6_])
               {
                  _dic[_loc6_] = createNode(_loc3_,VipPrerogativeInfo,_tempXml);
               }
               _loc2_.push(_dic[_loc6_]);
            }
         }
         else
         {
            for each(var _loc4_:VipPrerogativeInfo in _dic)
            {
               if(_loc4_.type == param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getTemplatesByType(param1:int) : Array
      {
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc2_:Array = [];
         if(_list)
         {
            _loc5_ = _list.(@type == param1);
            for each(var _loc3_:XML in _loc5_)
            {
               _loc6_ = _loc3_.@id;
               if(!_dic[_loc6_])
               {
                  _dic[_loc6_] = createNode(_loc3_,VipPrerogativeInfo,_tempXml);
               }
               _loc2_.push(_dic[_loc6_]);
            }
         }
         else
         {
            for each(var _loc4_:VipPrerogativeInfo in _dic)
            {
               if(_loc4_.para2 == param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getTemplatesByGrade(param1:int) : Array
      {
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc2_:Array = [];
         if(_list)
         {
            _loc5_ = _list.(@grade == param1);
            for each(var _loc3_:XML in _loc5_)
            {
               _loc6_ = _loc3_.@id;
               if(!_dic[_loc6_])
               {
                  _dic[_loc6_] = createNode(_loc3_,VipPrerogativeInfo,_tempXml);
               }
               _loc2_.push(_dic[_loc6_]);
            }
         }
         else
         {
            for each(var _loc4_:VipPrerogativeInfo in _dic)
            {
               if(_loc4_.grade == param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         _loc2_.sortOn("para2",16);
         return _loc2_;
      }
   }
}

