package com.road.yishi.bg.model
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import map.space.BgTileInfo;
   
   public class BgModel
   {
      
      private var _row:int;
      
      private var _col:int;
      
      private var _tileSize:int;
      
      private var _tiles:Array;
      
      private var _loadQueue:Array;
      
      private var _viewport:Rectangle = new Rectangle();
      
      private var _viewportCenterTile:BgTileInfo;
      
      private var _viewportCoverBounds:Rectangle;
      
      private var _mapId:int;
      
      private var _mapContainer:Sprite;
      
      public function BgModel(param1:int, param2:int, param3:Sprite, param4:int, param5:int = 100, param6:Boolean = false)
      {
         super();
         _tileSize = param5;
         _mapContainer = param3;
         _mapId = param4;
         _row = Math.ceil(param1 / _tileSize);
         _col = Math.ceil(param2 / _tileSize);
         initTiles(param6);
      }
      
      public function get tileSize() : Number
      {
         return _tileSize;
      }
      
      private function initTiles(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _tiles = [];
         _loc2_ = 0;
         while(_loc2_ < _row)
         {
            _tiles.push([]);
            _loc3_ = 0;
            while(_loc3_ < _col)
            {
               _tiles[_loc2_][_loc3_] = new BgTileInfo(_loc2_,_loc3_,_tileSize,_mapId,_mapContainer,param1);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function get viewport() : Rectangle
      {
         return _viewport;
      }
      
      public function get loadQueue() : Array
      {
         return _loadQueue;
      }
      
      public function getTileInfo(param1:int, param2:int) : BgTileInfo
      {
         return _tiles[param1][param2];
      }
      
      public function get col() : int
      {
         return _col;
      }
      
      public function get row() : int
      {
         return _row;
      }
      
      public function updateLoadQueue() : void
      {
         _loadQueue = [];
         bfsRound(_viewportCenterTile,_viewportCoverBounds,_loadQueue);
      }
      
      public function updateViewportCenterTile() : Boolean
      {
         var _loc4_:Number = _viewport.x + _viewport.width / 2;
         var _loc3_:Number = _viewport.y + _viewport.height / 2;
         loop0:
         for each(var _loc1_:Array in _tiles)
         {
            var _loc6_:int = 0;
            var _loc5_:Array = _loc1_;
            do
            {
               for each(var _loc2_:BgTileInfo in _loc5_)
               {
               }
               continue loop0;
            }
            while(!(_loc2_.x <= _loc4_ && _loc2_.y <= _loc3_ && _loc2_.x + _loc2_.size >= _loc4_ && _loc2_.y + _loc2_.size >= _loc3_));
            if(_loc2_ == _viewportCenterTile)
            {
               return false;
            }
            _viewportCenterTile = _loc2_;
            return true;
         }
         _viewportCenterTile = null;
         return false;
      }
      
      public function updateViewportCoverBounds() : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = Math.ceil(_viewport.width / _tileSize) + 1;
         var _loc1_:int = Math.ceil(_viewport.height / _tileSize) + 1;
         if(_loc8_ & true)
         {
            _loc6_ = _loc5_ = (_loc8_ - 1) / 2;
         }
         else if(_viewport.x + _viewport.width / 2 >= _viewportCenterTile.x + _tileSize / 2)
         {
            _loc6_ = _loc8_ / 2 - 1;
            _loc5_ = _loc8_ / 2;
         }
         else
         {
            _loc6_ = _loc8_ / 2;
            _loc5_ = _loc8_ / 2 - 1;
         }
         var _loc2_:int = Math.max(_viewportCenterTile.tx - _loc6_ - 1,0);
         var _loc11_:int = Math.min(_viewportCenterTile.tx + _loc5_ + 1,_row - 1);
         if(_loc1_ & true)
         {
            _loc3_ = _loc4_ = (_loc1_ - 1) / 2;
         }
         else if(_viewport.y + _viewport.height / 2 >= _viewportCenterTile.y + _tileSize / 2)
         {
            _loc3_ = _loc1_ / 2 - 1;
            _loc4_ = _loc1_ / 2;
         }
         else
         {
            _loc3_ = _loc1_ / 2;
            _loc4_ = _loc1_ / 2 - 1;
         }
         var _loc9_:int = Math.max(_viewportCenterTile.ty - _loc3_ - 1,0);
         var _loc12_:int = Math.min(_viewportCenterTile.ty + _loc4_ + 1,_col - 1);
         var _loc7_:Number = _loc11_ - _loc2_ + 1;
         var _loc10_:Number = _loc12_ - _loc9_ + 1;
         _viewportCoverBounds = new Rectangle(_loc2_,_loc9_,_loc7_,_loc10_);
      }
      
      public function bfsRound(param1:BgTileInfo, param2:Rectangle, param3:Array) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:BgTileInfo = null;
         var _loc7_:Array = [];
         _loc7_.push(param1);
         while(_loc7_.length > 0)
         {
            param1 = _loc7_.shift();
            param3.push(param1);
            _loc4_ = getRoundTiles(param1,param2);
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_];
               if(-1 == param3.indexOf(_loc6_) && -1 == _loc7_.indexOf(_loc6_))
               {
                  _loc7_.push(_loc6_);
               }
               _loc5_++;
            }
         }
      }
      
      public function getRoundTiles(param1:BgTileInfo, param2:Rectangle) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:Array = [[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,-1],[1,1],[-1,1]];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = param1.tx + _loc4_[_loc5_][0];
            _loc7_ = param1.ty + _loc4_[_loc5_][1];
            if(_loc6_ >= param2.x && _loc6_ < param2.right && _loc7_ >= param2.y && _loc7_ < param2.bottom)
            {
               _loc3_.push(_tiles[_loc6_][_loc7_]);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:Array in _tiles)
         {
            for each(var _loc2_:BgTileInfo in _loc1_)
            {
               if(_loc2_)
               {
                  if(_loc2_.tileView)
                  {
                     if(_loc2_.tileView.parent)
                     {
                        _loc2_.tileView.parent.removeChild(_loc2_.tileView);
                     }
                     if(_loc2_.tileView.bitmapData)
                     {
                        _loc2_.tileView.bitmapData.dispose();
                     }
                     _loc2_.tileView = null;
                  }
               }
            }
            _loc1_.length = 0;
         }
         _tiles = null;
         _loadQueue = null;
         _viewport = null;
         _viewportCenterTile = null;
         _viewportCoverBounds = null;
      }
   }
}

