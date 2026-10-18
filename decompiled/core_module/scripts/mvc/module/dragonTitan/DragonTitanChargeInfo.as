package mvc.module.dragonTitan
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   
   public class DragonTitanChargeInfo
   {
      
      public static const REDUCE_RESI_PG:int = 16;
      
      public static const FIRE_RESI_PG:int = 17;
      
      public static const WATER_RESI_PG:int = 18;
      
      public static const ELECT_RESI_PG:int = 19;
      
      public static const WIND_RESI_PG:int = 20;
      
      public static const DARK_RESI_PG:int = 21;
      
      public static const LIGHT_RESI_PG:int = 22;
      
      public var selectedIndex:int = 0;
      
      public var inputCount:int;
      
      public var attList:Array = [];
      
      private var attDic:Dictionary = new Dictionary();
      
      public function DragonTitanChargeInfo()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         var _loc5_:DragonTitanChargeCellInfo = null;
         var _loc1_:Array = [16,17,18,19,20,21,22];
         var _loc4_:String = LanguageMgr.GetTranslation("DragonTitanChargeInfo.init.attStr");
         var _loc2_:Array = _loc4_.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = new DragonTitanChargeCellInfo(_loc1_[_loc3_]);
            _loc5_.attName = _loc2_[_loc3_];
            attDic[_loc5_.type] = _loc5_;
            _loc5_.index = _loc3_;
            attList.push(_loc5_);
            _loc3_++;
         }
      }
      
      public function get currentPackItemCount() : int
      {
         return GoodsManager.instance.getGoodsNumByTempId(208060);
      }
      
      public function isItemEnough() : Boolean
      {
         return this.currentPackItemCount >= inputCount;
      }
      
      public function setValueByType(param1:int, param2:int) : void
      {
         var _loc3_:DragonTitanChargeCellInfo = attDic[param1];
         if(_loc3_)
         {
            _loc3_.attValue = param2;
         }
      }
      
      public function update(param1:DragonTitanModel) : void
      {
         var _loc9_:DragonTitanChargeCellInfo = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(124);
         _loc2_.sortOn("Grades",16);
         var _loc4_:Array = [param1.reduceResiGp,param1.fireResiGp,param1.waterResiGp,param1.electResiGp,param1.windResiGp,param1.darkResiGp,param1.lightResiGp];
         var _loc8_:DragonTitanChargeCellInfo = attList[0];
         var _loc3_:DragonTitanChargeCellInfo = attList[0];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc9_ = attList[_loc5_];
            _loc9_.isRedTxt = false;
            _loc9_.setExpValue(_loc4_[_loc5_],_loc2_);
            if(_loc9_.grade > _loc8_.grade)
            {
               _loc8_ = _loc9_;
            }
            if(_loc9_.grade < _loc3_.grade)
            {
               _loc3_ = _loc9_;
            }
            _loc5_++;
         }
         var _loc6_:int = -1;
         if(_loc8_.grade - _loc3_.grade >= 20)
         {
            _loc6_ = _loc8_.grade;
         }
         if(_loc6_ > -1)
         {
            _loc7_ = 0;
            while(_loc7_ < attList.length)
            {
               _loc9_ = attList[_loc7_];
               if(_loc9_.grade >= _loc6_)
               {
                  _loc9_.isRedTxt = true;
               }
               _loc7_++;
            }
         }
      }
   }
}

