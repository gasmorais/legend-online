package com.road.yishi.bg
{
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.road.yishi.bg.model.BgModel;
   import com.road.yishi.bg.utils.TilesPool;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import map.internals.MapData;
   import map.internals.data.template.MapTemplate;
   import map.space.BgTileInfo;
   import yishi.manager.PathManager;
   
   public class BgLayer extends Sprite implements Disposeable
   {
      
      public static const TITLE_SIZE:uint = 300;
      
      private static var loadRecord:Dictionary = new Dictionary(true);
      
      private var _tilesPool:TilesPool;
      
      protected var _bgModel:BgModel;
      
      private var _mapTemplate:MapTemplate;
      
      private var _mouseDown:Boolean;
      
      private var _mouseTime:int;
      
      private var _parent:DisplayObjectContainer;
      
      private var _timeId:int;
      
      public function BgLayer(param1:DisplayObjectContainer, param2:MapTemplate, param3:Object, param4:Boolean = false)
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         _parent = param1;
         _parent.addChild(this);
         _mapTemplate = param2;
         _bgModel = new BgModel(_mapTemplate.Width,_mapTemplate.Height,this,_mapTemplate.MapFileId,300,param4);
         _tilesPool = new TilesPool();
         init();
         initThumbnail();
      }
      
      private function initThumbnail() : void
      {
         if(!parent)
         {
            return;
         }
         var _loc1_:Bitmap = MapData.thumbnail;
         if(_loc1_)
         {
            parent.addChildAt(_loc1_,0);
         }
      }
      
      public function setParent(param1:DisplayObjectContainer) : void
      {
         _parent = param1;
         if(_parent)
         {
            _parent.addChild(this);
            initEvent();
            initThumbnail();
         }
      }
      
      public function removeParent() : void
      {
         if(this.parent && _parent)
         {
            removeEvent();
            _parent.removeChild(this);
            _parent = null;
         }
      }
      
      public function __onMouseWheel(param1:MouseEvent) : void
      {
         var _loc3_:Number = param1.delta > 0 ? 0.01 : -0.01;
         var _loc2_:Number = scaleY + _loc3_;
         _loc2_ = _loc2_ < 0.75 ? 0.75 : _loc2_;
         _loc2_ = _loc2_ > 1 ? 1 : _loc2_;
         if(StageReferance.stageWidth > width * _loc2_)
         {
            _loc2_ = StageReferance.stageWidth / width;
         }
         else if(StageReferance.stageHeight > height * _loc2_)
         {
            _loc2_ = StageReferance.stageHeight / height;
         }
         this.scaleX = _loc2_;
         this.scaleY = _loc2_;
         dragingCallBack();
      }
      
      public function dragingCallBack(param1:Event = null) : void
      {
         if(width * this.scaleX < StageReferance.stageWidth)
         {
            x = 0;
         }
         else if(x < StageReferance.stageWidth - width * this.scaleX)
         {
            x = StageReferance.stageWidth - width * this.scaleX;
         }
         else if(x > 0)
         {
            x = 0;
         }
         if(height * this.scaleY < StageReferance.stageHeight)
         {
            y = 0;
         }
         else if(y < StageReferance.stageHeight - height * this.scaleY)
         {
            y = StageReferance.stageHeight - height * this.scaleY;
         }
         else if(y > 0)
         {
            y = 0;
         }
         updateBgViewport();
      }
      
      public function dropCallBack() : void
      {
      }
      
      public function moveMapToPoint(param1:Point, param2:Function) : void
      {
         TweenMax.to(this,1,{
            "x":stage.stageWidth / 2 - param1.x,
            "y":stage.stageHeight / 2 - param1.y,
            "onComplete":param2
         });
      }
      
      public function moveMapToPointII(param1:Point, param2:Function) : void
      {
         TweenMax.to(this,1,{
            "x":stage.stageWidth / 2 - param1.x,
            "y":stage.stageHeight / 2 - param1.y,
            "onUpdate":dragingCallBack,
            "onComplete":param2
         });
      }
      
      public function onStageScale() : void
      {
         this.scaleX = 1;
         this.scaleY = 1;
         dragingCallBack();
      }
      
      public function removeUselessTiles() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BgTileInfo = null;
         var _loc1_:Bitmap = null;
         _loc2_ = 0;
         while(_loc2_ < _bgModel.row)
         {
            _loc3_ = 0;
            while(_loc3_ < _bgModel.col)
            {
               _loc4_ = _bgModel.getTileInfo(_loc2_,_loc3_);
               if(_bgModel.loadQueue.indexOf(_loc4_) == -1)
               {
                  _loc1_ = _loc4_.tileView;
                  if(_loc1_)
                  {
                     if(_loc1_.parent)
                     {
                        _loc1_.parent.removeChild(_loc1_);
                     }
                  }
                  _tilesPool.addTile(_loc4_);
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function resize(param1:Event = null) : void
      {
         dragingCallBack();
         dropCallBack();
      }
      
      protected function init() : void
      {
         initEvent();
         updateBgViewport();
      }
      
      protected function initEvent() : void
      {
         if(_parent)
         {
            _parent.addEventListener("MOVE_SCENET_END",dragingCallBack);
            StageReferance.stage.addEventListener("resize",__resizeHandler);
         }
      }
      
      protected function loadViewportTiles() : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         LoaderManagerII.instance.clearLoaderInfoBypriority(9);
         var _loc1_:Array = _bgModel.loadQueue.reverse();
         var _loc4_:Array = [];
         for each(var _loc2_:BgTileInfo in _loc1_)
         {
            if(loadRecord[_loc2_.key])
            {
               _loc4_.unshift(_loc2_);
            }
            else
            {
               _loc4_.push(_loc2_);
            }
         }
         _loc1_.length = 0;
         _loc1_ = null;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_] as BgTileInfo;
            if(_loc2_.tileView)
            {
               _loc2_.tileView = _loc2_.tileView;
            }
            else
            {
               _loc5_ = PathManager.getMapBackPaths(_loc2_.mapTemplate) + "tile_" + _loc2_.key + ".jpg";
               LoaderManagerII.instance.load(_loc5_,2,9,tileLoadComplete,null,null,_loc2_);
            }
            _loc3_++;
         }
      }
      
      private function tileLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_bgModel)
         {
            return;
         }
         var _loc4_:int = int(param1.url.indexOf("tile_"));
         var _loc6_:int = int(param1.url.indexOf(".jpg"));
         var _loc3_:String = param1.url.substr(_loc4_ + 5,_loc6_ - _loc4_ - 5);
         loadRecord[_loc3_] = true;
         var _loc5_:BgTileInfo = param1.args as BgTileInfo;
         _loc5_.tileView = param2 as Bitmap;
         _tilesPool.removeTileByInfo(_loc5_);
      }
      
      protected function removeEvent() : void
      {
         if(_parent)
         {
            _parent.removeEventListener("MOVE_SCENET_END",dragingCallBack);
            StageReferance.stage.removeEventListener("resize",__resizeHandler);
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         dragingCallBack();
      }
      
      protected function updateBgView() : void
      {
         if(_bgModel.updateViewportCenterTile())
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(tileLoadComplete);
            _bgModel.updateViewportCoverBounds();
            _bgModel.updateLoadQueue();
            removeUselessTiles();
            loadViewportTiles();
         }
      }
      
      protected function updateBgViewport() : void
      {
         var _loc2_:Point = new Point(0,0);
         var _loc1_:Point = this.globalToLocal(_loc2_);
         _bgModel.viewport.x = _loc1_.x;
         _bgModel.viewport.y = _loc1_.y;
         _bgModel.viewport.width = StageReferance.stageWidth;
         _bgModel.viewport.height = StageReferance.stageHeight;
         updateBgView();
      }
      
      public function forceUpdate(param1:Rectangle) : void
      {
         _bgModel.viewport.x = param1.x;
         _bgModel.viewport.y = param1.y;
         _bgModel.viewport.width = param1.width;
         _bgModel.viewport.height = param1.height;
         updateBgView();
      }
      
      private function __onMouseDownHandler(param1:MouseEvent) : void
      {
         _mouseDown = true;
         _mouseTime = getTimer();
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = setTimeout(dragStart,300);
      }
      
      private function __onMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer() - _mouseTime;
         _mouseDown = false;
         if(_loc2_ < 300)
         {
            onBgClick(param1);
         }
      }
      
      private function dragStart() : void
      {
         clearTimeout(_timeId);
         _timeId = 0;
         if(_mouseDown)
         {
            dragStartCallBack();
         }
      }
      
      private function dragStartCallBack() : void
      {
         TweenMax.killTweensOf(this);
      }
      
      private function getTileViewPath(param1:BgTileInfo) : String
      {
         return PathManager.getMapBackPaths(_mapTemplate.MapFileId) + "tile_" + param1.key + ".jpg";
      }
      
      private function onBgClick(param1:MouseEvent) : void
      {
         dropCallBack();
      }
      
      private function onDragTweenEnd() : void
      {
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Bitmap = null;
         removeEvent();
         _loc2_ = 0;
         while(_loc2_ < _bgModel.row)
         {
            _loc3_ = 0;
            while(_loc3_ < _bgModel.col)
            {
               _loc1_ = _bgModel.getTileInfo(_loc2_,_loc3_).tileView;
               if(_loc1_)
               {
                  if(_loc1_.parent)
                  {
                     _loc1_.parent.removeChild(_loc1_);
                  }
                  if(_loc1_.bitmapData)
                  {
                     _loc1_.bitmapData.dispose();
                  }
                  _loc1_ = null;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         _bgModel.dispose();
         _bgModel = null;
      }
   }
}

