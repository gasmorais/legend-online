package com.road.yishi.bg.utils
{
   import flash.utils.Dictionary;
   import map.space.BgTileInfo;
   
   public class TilesPool
   {
      
      private var _waitCount:int;
      
      private var _gcCount:int;
      
      private var MAX_CACHE_COUNT:int = 40;
      
      private var _pool:Dictionary;
      
      public function TilesPool(param1:Boolean = false)
      {
         _pool = new Dictionary(param1);
         super();
      }
      
      public function addTile(param1:BgTileInfo) : void
      {
         var _loc2_:int = 0;
         if(!_pool[param1.key])
         {
            _waitCount = _waitCount + 1;
            _pool[param1.key] = _waitCount;
            _pool[_waitCount] = param1;
            remove();
         }
         else
         {
            _waitCount = _waitCount + 1;
            _gcCount = _gcCount + 1;
            _loc2_ = int(_pool[param1.key]);
            delete _pool[_loc2_];
            _pool[param1.key] = _waitCount;
         }
      }
      
      private function remove() : void
      {
         while(_waitCount - _gcCount > MAX_CACHE_COUNT)
         {
            removeTile(_gcCount++);
         }
      }
      
      public function removeTileByInfo(param1:BgTileInfo) : void
      {
         var _loc2_:int = int(_pool[param1.key]);
         delete _pool[_loc2_];
         delete _pool[param1.key];
      }
      
      private function removeTile(param1:int) : void
      {
         var _loc2_:BgTileInfo = _pool[param1];
         if(_loc2_)
         {
            if(_loc2_.tileView)
            {
               if(_loc2_.tileView.parent)
               {
                  _loc2_.tileView.parent.removeChild(_loc2_.tileView);
               }
            }
            _loc2_.isLoaded = false;
            delete _pool[_loc2_.key];
            _loc2_ = null;
         }
         delete _pool[param1];
      }
   }
}

