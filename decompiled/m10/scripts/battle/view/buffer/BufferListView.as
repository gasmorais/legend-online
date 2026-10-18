package battle.view.buffer
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import flash.display.Sprite;
   import yishi.datas.BattleModel;
   import yishi.events.RoleEvent;
   
   public class BufferListView extends Sprite
   {
      
      private var _items:Array = [];
      
      private var _pool:Array = [];
      
      public function BufferListView()
      {
         super();
         addHandler();
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function addHandler() : void
      {
         battleModel.selfHero.addEventListener("REFRESH_BUFFER",__reFreshBuffer);
      }
      
      private function __reFreshBuffer(param1:RoleEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Vector.<BufferDamageData> = new Vector.<BufferDamageData>();
         for each(var _loc3_:BufferDamageData in param1.data)
         {
            if(_loc3_.currentTurn > 0)
            {
               _loc4_.push(_loc3_);
            }
         }
         setData(_loc4_);
         refreshView();
      }
      
      private function removeBufferData(param1:Vector.<BufferDamageData>) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:BufferListItem = null;
         var _loc8_:BufferDamageData = null;
         var _loc3_:Boolean = false;
         var _loc6_:Array = _items.concat([]);
         var _loc2_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            _loc3_ = true;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = param1[_loc7_];
               if(_loc5_ && _loc5_.data.templateId == _loc8_.templateId)
               {
                  _loc3_ = false;
                  break;
               }
               _loc7_++;
            }
            if(_loc3_)
            {
               removeItemByItem(_loc5_);
               _loc6_[_loc4_] = null;
            }
            _loc4_++;
         }
      }
      
      public function addBufferData(param1:BufferDamageData) : void
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = true;
         for each(_loc2_ in _items)
         {
            _loc3_ = true;
            if(param1.templateId == _loc2_.data.templateId)
            {
               _loc2_.data = param1;
               _loc3_ = false;
               break;
            }
         }
         if(_loc3_)
         {
            addItem(param1);
         }
      }
      
      private function __reFreshBufferTurn(param1:RoleEvent = null) : void
      {
         var _loc2_:BufferListItem = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_];
            _loc2_.refreshTurn();
            _loc3_++;
         }
      }
      
      public function setData(param1:Vector.<BufferDamageData>) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:BufferListItem = null;
         removeTurnOutItems(param1);
         var _loc2_:int = int(param1.length);
         var _loc5_:Array = _items.concat([]);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               if(param1[_loc4_].templateId == _loc5_[_loc6_].data.templateId)
               {
                  _loc3_ = _loc5_[_loc6_];
                  break;
               }
               _loc6_++;
            }
            if(_loc3_)
            {
               _loc3_.data = param1[_loc4_];
            }
            else
            {
               addItem(param1[_loc4_]);
            }
            _loc3_ = null;
            _loc4_++;
         }
      }
      
      private function removeTurnOutItems(param1:Vector.<BufferDamageData>) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:BufferListItem = null;
         var _loc8_:BufferDamageData = null;
         var _loc3_:Boolean = false;
         var _loc6_:Array = _items.concat([]);
         var _loc2_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            _loc3_ = true;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = param1[_loc7_];
               if(_loc5_ && _loc5_.data.templateId == _loc8_.templateId)
               {
                  _loc3_ = false;
                  break;
               }
               _loc7_++;
            }
            if(_loc3_)
            {
               removeItem(_loc5_.data);
               _loc6_[_loc4_] = null;
            }
            _loc4_++;
         }
      }
      
      public function addItem(param1:BufferDamageData) : void
      {
         var _loc2_:BufferListItem = _pool.pop();
         if(!_loc2_)
         {
            _loc2_ = new BufferListItem();
         }
         _loc2_.data = param1;
         _items.push(_loc2_);
         addChild(_loc2_);
      }
      
      public function removeItem(param1:BufferDamageData) : void
      {
         var _loc2_:BufferListItem = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_];
            if(_loc2_.data == param1)
            {
               _items.splice(_loc3_,1);
               _pool.push(_loc2_);
               removeChild(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function removeItemByItem(param1:BufferListItem) : void
      {
         var _loc2_:int = _items.indexOf(param1);
         if(_loc2_ != -1)
         {
            _items.splice(_loc2_,1);
            _pool.push(param1);
            removeChild(param1);
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:BufferListItem = null;
         var _loc3_:int = 0;
         var _loc2_:int = 35;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc1_ = _items[_loc3_];
            _loc1_.x = _loc2_ * _loc3_;
            _loc3_++;
         }
      }
      
      private function clear() : void
      {
         var _loc1_:BufferListItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_];
            removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _pool.length)
         {
            _loc1_ = _items[_loc2_];
            removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_++;
         }
         _pool = null;
         _items = null;
      }
      
      public function dispose() : void
      {
         battleModel.selfHero.removeEventListener("REFRESH_BUFFER",__reFreshBuffer);
         clear();
      }
   }
}

