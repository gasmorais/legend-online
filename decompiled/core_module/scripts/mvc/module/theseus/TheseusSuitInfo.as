package mvc.module.theseus
{
   import managers.TheseussoulManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusSuitInfo
   {
      
      public var suite1:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite2:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite3:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite4:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite5:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite6:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite7:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite8:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public var suite9:String = "0,0,0,0,0,0,0,0,0,0,0,0";
      
      public function TheseusSuitInfo()
      {
         super();
      }
      
      public function clean() : void
      {
         suite1 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite2 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite3 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite4 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite5 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite6 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite7 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite8 = "0,0,0,0,0,0,0,0,0,0,0,0";
         suite9 = "0,0,0,0,0,0,0,0,0,0,0,0";
      }
      
      public function getSuitArray(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:String = this["suite" + param1];
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc2_ = _loc3_.split(",");
         }
         return _loc2_;
      }
      
      public function getOneSuitMinLv(param1:int, param2:int) : int
      {
         var _loc11_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         _loc7_ = 99999;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc9_:WarFrameItemInfo = null;
         var _loc10_:int = 0;
         var _loc5_:Array = getSuitArray(param1);
         var _loc6_:Array = getParts(param2);
         var _loc3_:int = 99999;
         _loc10_ = 0;
         while(_loc10_ < _loc6_.length)
         {
            _loc4_ = int(_loc6_[_loc10_]);
            _loc11_ = int(_loc5_[_loc4_]);
            _loc9_ = TheseussoulManager.Instance.model.armorBagDic[_loc11_] as WarFrameItemInfo;
            if(!(_loc11_ > 0 && _loc9_))
            {
               return 1;
            }
            _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc9_.templateId);
            if(_loc8_ && _loc8_.Property4 < _loc3_)
            {
               _loc3_ = _loc8_.Property4;
            }
            _loc10_++;
         }
         if(_loc3_ == 99999)
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      public function getParts(param1:int) : Array
      {
         var _loc2_:Array = [];
         if(param1 == 1)
         {
            _loc2_ = [0,4];
         }
         else if(param1 == 2)
         {
            _loc2_ = [1,2];
         }
         else if(param1 == 3)
         {
            _loc2_ = [3,5,6,7,8,9,10,11];
         }
         return _loc2_;
      }
   }
}

