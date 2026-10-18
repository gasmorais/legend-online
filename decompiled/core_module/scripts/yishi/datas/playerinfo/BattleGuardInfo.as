package yishi.datas.playerinfo
{
   import flash.events.EventDispatcher;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class BattleGuardInfo extends EventDispatcher
   {
      
      public static const OPEN_GRADE:int = 55;
      
      private var _notchList:Vector.<BattleGuardSocketInfo>;
      
      private var _battleWillPower:BattleGuardSocketInfo;
      
      public function BattleGuardInfo()
      {
         var _loc1_:int = 0;
         super();
         _notchList = new Vector.<BattleGuardSocketInfo>(6);
         _loc1_ = 0;
         while(_loc1_ < _notchList.length)
         {
            _notchList[_loc1_] = new BattleGuardSocketInfo(_loc1_,3);
            _notchList[_loc1_].type = 2;
            _loc1_++;
         }
         _battleWillPower = new BattleGuardSocketInfo(0,3);
         _battleWillPower.type = 1;
      }
      
      public function get notchList() : Vector.<BattleGuardSocketInfo>
      {
         return _notchList;
      }
      
      public function get battleWillPower() : BattleGuardSocketInfo
      {
         return _battleWillPower;
      }
      
      public function getSocketInfo(param1:int, param2:int) : BattleGuardSocketInfo
      {
         if(param1 == 1)
         {
            return _battleWillPower;
         }
         return _notchList[param2];
      }
      
      public function get battleWillPoint() : int
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc1_:int = 0;
         for each(var _loc3_:int in _battleWillPower.itemList)
         {
            if(_loc3_ > 0)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_);
               _loc1_ += _loc2_.ReduceResi;
            }
         }
         return _loc1_;
      }
      
      public function getAllPoint() : Array
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         for each(var _loc2_:BattleGuardSocketInfo in notchList)
         {
            for each(var _loc8_:int in _loc2_.itemList)
            {
               if(_loc8_ > 0)
               {
                  _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc8_);
                  _loc6_ += _loc3_.FireResi;
                  _loc7_ += _loc3_.WaterResi;
                  _loc9_ += _loc3_.WindResi;
                  _loc10_ += _loc3_.ElectResi;
                  _loc4_ += _loc3_.LightResi;
                  _loc5_ += _loc3_.DarkResi;
               }
            }
         }
         var _loc1_:Array = [];
         _loc1_.push(battleWillPoint);
         _loc1_.push(_loc6_);
         _loc1_.push(_loc7_);
         _loc1_.push(_loc9_);
         _loc1_.push(_loc10_);
         _loc1_.push(_loc4_);
         _loc1_.push(_loc5_);
         return _loc1_;
      }
      
      public function getAllPoint2() : Array
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         for each(var _loc2_:BattleGuardSocketInfo in notchList)
         {
            for each(var _loc8_:int in _loc2_.itemList)
            {
               if(_loc8_ > 0)
               {
                  _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc8_);
                  _loc6_ += _loc3_.FireResi;
                  _loc7_ += _loc3_.WaterResi;
                  _loc9_ += _loc3_.WindResi;
                  _loc10_ += _loc3_.ElectResi;
                  _loc4_ += _loc3_.LightResi;
                  _loc5_ += _loc3_.DarkResi;
               }
            }
         }
         var _loc1_:Array = [];
         _loc1_.push(_loc6_);
         _loc1_.push(_loc7_);
         _loc1_.push(_loc9_);
         _loc1_.push(_loc10_);
         _loc1_.push(_loc4_);
         _loc1_.push(_loc5_);
         return _loc1_;
      }
   }
}

