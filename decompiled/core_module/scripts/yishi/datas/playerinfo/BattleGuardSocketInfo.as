package yishi.datas.playerinfo
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class BattleGuardSocketInfo extends EventDispatcher
   {
      
      public static const CLOSE:int = 0;
      
      public static const OPEN:int = 1;
      
      private var _itemList:Vector.<int>;
      
      private var _state:int = 0;
      
      private var _pos:int = 0;
      
      public var length:int = 0;
      
      public var type:int = 1;
      
      public function BattleGuardSocketInfo(param1:int, param2:int = 3)
      {
         var _loc3_:int = 0;
         super();
         _pos = param1;
         this.length = param2;
         _itemList = new Vector.<int>(param2);
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _itemList[_loc3_] = null;
            _loc3_++;
         }
      }
      
      public function addItem(param1:int, param2:int) : void
      {
         _itemList[param2] = param1;
      }
      
      public function getTempByPos(param1:int) : GoodsTemplateInfo
      {
         var _loc2_:int = _itemList[param1];
         if(_loc2_ > 0)
         {
            return TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_);
         }
         return null;
      }
      
      public function removeItem(param1:int) : void
      {
         var _loc2_:int = _itemList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _itemList[_loc2_] = null;
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function commit() : void
      {
         dispatchEvent(new Event("change"));
      }
      
      public function get itemList() : Vector.<int>
      {
         return _itemList;
      }
      
      public function existSameGoods(param1:int, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            _loc5_ = _itemList[_loc4_];
            if(_loc5_ > 0)
            {
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_);
               if(_loc6_ && _loc3_ && _loc6_.Property1 == _loc3_.Property1 && param2 != _loc4_)
               {
                  return true;
               }
            }
            _loc4_++;
         }
         return false;
      }
   }
}

