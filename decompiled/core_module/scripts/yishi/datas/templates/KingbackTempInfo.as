package yishi.datas.templates
{
   import bag.datas.GoodsSonType;
   import yishi.manager.TempleteManager;
   
   public class KingbackTempInfo
   {
      
      public var TempId:int;
      
      public var Type:int;
      
      public var SubType:int;
      
      public var MinGrade:int;
      
      public var MinPower:int;
      
      public var IsCondition:int;
      
      public var ConditionType:int;
      
      public var Topic:int;
      
      public var Point:int;
      
      public var CostItems:String;
      
      public var RewardTemplate:String;
      
      public var Desc:String;
      
      public var Param1:String;
      
      public var Param2:String;
      
      private var _itemNames:String = null;
      
      private var _itemColorNames:String = null;
      
      public function KingbackTempInfo()
      {
         super();
      }
      
      public function getRewardList() : Array
      {
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc5_:Array = [];
         var _loc2_:Array = RewardTemplate.split("|");
         var _loc3_:int = int(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_].split(",");
            _loc1_.push([int(_loc5_[0]),int(_loc5_[1])]);
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function getItemNames(param1:Boolean = false) : String
      {
         var _loc6_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         if(_itemNames != null)
         {
            if(param1)
            {
               return _itemColorNames;
            }
            return _itemNames;
         }
         var _loc8_:String = "";
         var _loc2_:String = "";
         var _loc3_:Array = CostItems.split(",");
         var _loc5_:int = int(_loc3_ ? _loc3_.length : 0);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = int(_loc3_[_loc7_]);
            if(_loc4_ != 0)
            {
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_);
               if(_loc6_)
               {
                  _loc2_ += _loc6_.TemplateName;
                  _loc8_ += "<font color=\'" + GoodsSonType.getColorByProfile(_loc6_.Profile) + "\'>" + _loc6_.TemplateName + "</font>";
               }
               if(_loc7_ != _loc5_ - 1)
               {
                  _loc2_ += "/";
                  _loc8_ += "/";
               }
            }
            _loc7_++;
         }
         _itemNames = _loc2_;
         _itemColorNames = _loc8_;
         if(param1)
         {
            return _itemColorNames;
         }
         return _itemNames;
      }
   }
}

