package stage3drender.map
{
   import com.pickgliss.toplevel.StageReferance;
   import dragonBones.animation.WorldClock;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import managers.RingTaskManager;
   import map.internals.MapData;
   import map.internals.data.SpaceNode;
   import map.internals.utils.QTree;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import mvc.module.ringtask.RingTask;
   import stage3drender.BuildLayer;
   import stage3drender.Global;
   import stage3drender.WalkLayer;
   import stage3drender.avatar.AvatarRender;
   import stage3drender.avatar.SpaceAvatar;
   import stage3drender.avatar.SpaceNpc;
   import stage3drender.nodes.MapNodeRender;
   import stage3drender.nodes.SpacePhysicsNode;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.Stage;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.filters.BlurFilter;
   import starling.textures.Texture;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.CursorManagerII;
   import yishi.manager.PlayerManager;
   
   public class Map extends starling.display.Sprite implements IAnimatable
   {
      
      private var _bgLayer:starling.display.Sprite;
      
      private var _walkLayer:WalkLayer;
      
      private var _buildLayer:BuildLayer;
      
      private var _hitLayer:flash.display.Sprite;
      
      private const tweenMoveDistance:int = 10;
      
      private var mapWidth:int;
      
      private var mapHeight:int;
      
      private var intMapWidth:uint = 8960;
      
      private var intMapHeight:uint = 6400;
      
      private const intBlockWidth:uint = 512;
      
      private const intBlockHeight:uint = 512;
      
      private var intMaxCacheRows:uint = 4;
      
      private var intMaxCacheCols:uint = 5;
      
      private var intMaxRows:int;
      
      private var intMaxCols:int;
      
      private var _viewPortRect:Rectangle;
      
      private var _mapRect:Rectangle;
      
      private var _blockRectToMap:Rectangle;
      
      private var arrayTextureBlocks:Array;
      
      private var _mapModel:SpaceModel;
      
      private var _filter:BlurFilter;
      
      private var _qtree:QTree;
      
      private var _lastHoverObject:DisplayObject;
      
      private var _mouseDownTimeId:int;
      
      private var _selfArmy:SpaceAvatar;
      
      private var _xLimen:int = 10;
      
      private var _yLimen:int = 10;
      
      private var _bevelSpeed:int;
      
      private var _tweenValue:Number = 0.2;
      
      private var _isInit:Boolean = false;
      
      public function Map()
      {
         super();
         _qtree = new QTree(0,0,5000,5000);
         Global.qtree = _qtree;
         _bgLayer = new starling.display.Sprite();
         _bgLayer.touchable = false;
         initThumbnail();
         addChild(_bgLayer);
         _buildLayer = new BuildLayer();
         SpaceManager.instance.controller.mouseEnabled = false;
         SpaceManager.instance.controller.buildLayer = _buildLayer;
         addChild(_buildLayer);
         _walkLayer = new WalkLayer();
         SpaceManager.instance.controller.walkLayer = _walkLayer;
         addChild(_walkLayer);
         _mapModel = SpaceManager.instance.model;
         mapWidth = _mapModel.mapTempInfo.Width;
         mapHeight = _mapModel.mapTempInfo.Height;
         intMaxRows = Math.round(mapWidth / 512);
         intMaxCols = Math.round(mapHeight / 512);
         intMapWidth = intMaxRows * 512;
         intMapHeight = intMaxCols * 512;
         arrayTextureBlocks = [];
         _mapRect = new Rectangle(0,0,intMapWidth,intMapHeight);
         _blockRectToMap = new Rectangle(0,0,512 * intMaxCacheCols,512 * intMaxCacheRows);
         _viewPortRect = new Rectangle(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         prepareLoadBg();
         initEvent();
         _filter = BlurFilter.createGlow();
      }
      
      public function get walkLayer() : WalkLayer
      {
         return _walkLayer;
      }
      
      private function initThumbnail() : void
      {
      }
      
      private function initEvent() : void
      {
         _hitLayer = new flash.display.Sprite();
         _hitLayer.graphics.beginFill(16777215,0);
         _hitLayer.graphics.drawRect(0,0,_viewPortRect.width,_viewPortRect.height);
         Starling.current.nativeStage.addChildAt(_hitLayer,0);
         _hitLayer.addEventListener("rollOver",__mouseOverHandler);
         _hitLayer.addEventListener("rollOut",__mouseOutHandler);
         _hitLayer.addEventListener("enterFrame",__enterFrameHandler);
         Starling.current.nativeStage.addEventListener("resize",__resizeHandler);
      }
      
      private function removeEvent() : void
      {
         Starling.current.stage.removeEventListener("touch",__mapTouchHandler);
         _hitLayer.removeEventListener("rollOver",__mouseOverHandler);
         _hitLayer.removeEventListener("rollOut",__mouseOutHandler);
         _hitLayer.removeEventListener("enterFrame",__enterFrameHandler);
         Starling.current.nativeStage.removeEventListener("resize",__resizeHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         Starling.current.stage.addEventListener("touch",__mapTouchHandler);
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         if(!_lastHoverObject)
         {
            return;
         }
         var _loc2_:Point = new Point(_hitLayer.mouseX,_hitLayer.mouseY);
         _loc2_ = _lastHoverObject.globalToLocal(_loc2_);
         if(_lastHoverObject.hitTest(_loc2_,true) == null)
         {
            mouseOut(_lastHoverObject);
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _viewPortRect.width = StageReferance.stageWidth;
         _viewPortRect.height = StageReferance.stageHeight;
         Starling.current.viewPort = _viewPortRect;
         Starling.current.stage.stageWidth = _viewPortRect.width;
         Starling.current.stage.stageHeight = _viewPortRect.height;
         _hitLayer.graphics.clear();
         _hitLayer.graphics.beginFill(16777215,0);
         _hitLayer.graphics.drawRect(0,0,_viewPortRect.width,_viewPortRect.height);
         updateCurrentPosition();
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
            _mouseDownTimeId = 0;
         }
         Starling.current.stage.removeEventListener("touch",__mapTouchHandler);
         mouseOut(_lastHoverObject);
      }
      
      private function __mapTouchHandler(param1:TouchEvent) : void
      {
         var _loc2_:Touch = null;
         var _loc3_:Touch = param1.touches[0];
         var _loc4_:DisplayObject = getTouchTarget(_loc3_);
         if(_loc3_.phase == "began")
         {
            mouseDown(_loc4_,_loc3_);
         }
         else if(_loc3_.phase == "ended")
         {
            mouseUp(_loc4_,_loc3_);
         }
         else
         {
            _loc2_ = param1.getTouch(_lastHoverObject);
            if(_loc2_)
            {
               mouseOverOrMove(_loc4_,_loc3_);
            }
            else
            {
               mouseOut(_lastHoverObject);
               mouseOverOrMove(_loc4_,_loc3_);
            }
         }
      }
      
      private function getTouchTarget(param1:Touch) : DisplayObject
      {
         var _loc4_:AvatarRender = null;
         var _loc2_:Point = null;
         var _loc5_:DisplayObject = param1.target;
         var _loc3_:Array = [Stage,SpaceAvatar,SpaceNpc,SpacePhysicsNode];
         while(!isOneOfClasses(_loc5_,_loc3_))
         {
            if(!_loc5_)
            {
               _loc5_ = stage;
               break;
            }
            _loc5_ = _loc5_.parent;
         }
         if(_loc5_ is AvatarRender)
         {
            _loc4_ = _loc5_ as AvatarRender;
            _loc2_ = param1.getLocation(_loc4_);
            if(!_loc4_.getPointIsHitable(_loc2_))
            {
               _loc2_ = param1.getLocation(this);
               _loc5_ = getTouchObjectUnderPoint(_loc2_);
               if(!_loc5_)
               {
                  _loc5_ = stage;
               }
            }
         }
         return _loc5_;
      }
      
      private function isOneOfClasses(param1:DisplayObject, param2:Array) : Boolean
      {
         for each(var _loc3_:Class in param2)
         {
            if(param1 is _loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getTouchObjectUnderPoint(param1:Point) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc4_:Array = getNearTouchObjects(param1);
         var _loc6_:Point = new Point();
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc5_] as DisplayObject;
            _loc6_.x = param1.x - _loc2_.x;
            _loc6_.y = param1.y - _loc2_.y;
            if(_loc2_.hasOwnProperty("getPointIsHitable") && _loc2_["getPointIsHitable"](_loc6_))
            {
               _loc3_ = _loc2_;
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function getNearTouchObjects(param1:Point) : Array
      {
         var _loc2_:int = 250;
         var _loc4_:Rectangle = new Rectangle(param1.x - _loc2_,param1.y - _loc2_,_loc2_ * 2,_loc2_ * 2);
         var _loc3_:Array = _qtree.find(_loc4_);
         _loc3_.sort(deepSort);
         return _loc3_;
      }
      
      private function deepSort(param1:Object, param2:Object) : int
      {
         if(param1.y > param2.y)
         {
            return 1;
         }
         if(param1.y < param2.y)
         {
            return -1;
         }
         if(param1.x > param2.x)
         {
            return 1;
         }
         if(param1.x > param2.x)
         {
            return -1;
         }
         return 0;
      }
      
      private function mouseDown(param1:DisplayObject, param2:Touch) : void
      {
         var _loc3_:SpaceNode = null;
         var _loc4_:SpaceAvatar = null;
         if(param1 is SpaceAvatar)
         {
            _loc4_ = param1 as SpaceAvatar;
            if(_loc4_.data && _loc4_.data != _mapModel.selfArmy)
            {
               PlayerManager.instance.currentPlayerModel.selectTarget = _loc4_.data;
               PlayerManager.instance.currentPlayerModel.reinforce = _loc4_.data;
            }
         }
         else if(param1 is SpaceNpc)
         {
            _loc3_ = (param1 as SpaceNpc).nodeInfo;
            if(_loc3_)
            {
               SpaceManager.instance.visitSpaceNPC(_loc3_.nodeId,true);
            }
         }
         else if(param1 is MapNodeRender)
         {
            _loc3_ = (param1 as MapNodeRender).info as SpaceNode;
            if(_loc3_)
            {
               SpaceManager.instance.visitSpaceNPC(_loc3_.nodeId,true);
            }
         }
         else
         {
            SpaceManager.instance.model.selectNode = null;
            clickToWalk();
         }
      }
      
      private function clickToWalk() : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
            _mouseDownTimeId = 0;
         }
         _mouseDownTimeId = setInterval(clickToWalk,500);
         var _loc1_:Point = new Point(_hitLayer.mouseX - x,_hitLayer.mouseY - y);
         SpaceManager.instance.controller.moveArmyByPos(_loc1_.x,_loc1_.y,true);
      }
      
      private function mouseUp(param1:DisplayObject, param2:Touch) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
      }
      
      private function mouseOverOrMove(param1:DisplayObject, param2:Touch) : void
      {
         var _loc4_:SpaceNode = null;
         var _loc6_:RingTask = null;
         var _loc5_:OfferRewardConditionTemplate = null;
         var _loc3_:String = null;
         if(param1 == _lastHoverObject)
         {
            return;
         }
         if(param1 != _lastHoverObject)
         {
            mouseOut(_lastHoverObject);
         }
         if(!param1)
         {
            return;
         }
         if(param1 is SpaceNpc)
         {
            CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
         }
         else if(param1 is SpaceAvatar)
         {
            CursorManagerII.instance.showCursorByType("SPACE_PLAYER_CURSOR");
         }
         else if(param1 is SpacePhysicsNode)
         {
            _loc4_ = (param1 as SpacePhysicsNode).info as SpaceNode;
            if(_loc4_)
            {
               if(_loc4_.nodeId == 18)
               {
                  _loc6_ = RingTaskManager.instance.getRingTask();
                  if(_loc6_)
                  {
                     _loc5_ = _loc6_.conditionList[0] as OfferRewardConditionTemplate;
                  }
                  if(_loc5_ && _loc5_.CondictionType == 4 && _loc5_.Para1 + "" == _loc4_.param4 && !_loc6_.isCompleted)
                  {
                     CursorManagerII.instance.showCursorByType("FARM_PICK_CURSOR");
                  }
               }
               else if(_loc4_.nodeId == 1)
               {
                  CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
               }
               else if(_loc4_.info.types == 171)
               {
                  Mouse.cursor = "button";
               }
            }
         }
         else
         {
            _loc3_ = CursorManagerII.instance.currentState;
            if(_loc3_ && _loc3_ != "DEFAULT_CURSOR")
            {
               CursorManagerII.instance.resetCursor();
            }
         }
         if(param1 is AvatarRender)
         {
            (param1 as AvatarRender).setAvatarFilter(_filter);
         }
         else if(param1 is SpacePhysicsNode)
         {
            param1.filter = _filter;
         }
         _lastHoverObject = param1;
      }
      
      private function mouseOut(param1:DisplayObject) : void
      {
         Mouse.cursor = "auto";
         var _loc2_:String = CursorManagerII.instance.currentState;
         if(_loc2_ && _loc2_ != "DEFAULT_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
         if(param1)
         {
            param1.filter = null;
         }
         if(param1 is AvatarRender)
         {
            (param1 as AvatarRender).setAvatarFilter(null);
         }
         if(param1 == _lastHoverObject)
         {
            _lastHoverObject = null;
         }
      }
      
      private function prepareLoadBg() : void
      {
         var _loc2_:int = 0;
         var _loc3_:MapTextureBlock = null;
         var _loc1_:int = intMaxCacheRows * intMaxCacheCols;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new MapTextureBlock(intMapWidth,intMapHeight,intMaxCacheRows,intMaxCacheCols,_loc2_);
            arrayTextureBlocks.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function updateCurrentPosition(param1:Boolean = false) : void
      {
         if(!_selfArmy)
         {
            return;
         }
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc7_:int = _blockRectToMap.x + _blockRectToMap.width - 512 - 512 / 2;
         var _loc6_:int = _blockRectToMap.x + 512 + 512 / 2;
         var _loc5_:int = _blockRectToMap.y + _blockRectToMap.height - 512 - 512 / 2;
         var _loc4_:int = _blockRectToMap.y + 512 + 512 / 2;
         if(_selfArmy.x > _loc7_ && _blockRectToMap.x + _blockRectToMap.width < intMapWidth)
         {
            _blockRectToMap.x += 512;
            param1 = true;
         }
         else if(_selfArmy.x < _loc6_ && _blockRectToMap.x > 0)
         {
            _blockRectToMap.x -= 512;
            param1 = true;
         }
         if(_selfArmy.y > _loc5_ && _blockRectToMap.y + _blockRectToMap.height < intMapHeight)
         {
            _blockRectToMap.y += 512;
            param1 = true;
         }
         else if(_selfArmy.y < _loc4_ && _blockRectToMap.y > 0)
         {
            _blockRectToMap.y -= 512;
            param1 = true;
         }
         if(param1)
         {
            updateBlock();
         }
         if(_selfArmy.x < _viewPortRect.width / 2)
         {
            _loc2_ = 0;
         }
         else if(_selfArmy.x > mapWidth - _viewPortRect.width / 2)
         {
            _loc2_ = _viewPortRect.width - mapWidth;
         }
         else
         {
            _loc2_ = _viewPortRect.width / 2 - _selfArmy.x;
         }
         if(_selfArmy.y < _viewPortRect.height / 2)
         {
            _loc3_ = 0;
         }
         else if(_selfArmy.y > mapHeight - _viewPortRect.height / 2)
         {
            _loc3_ = _viewPortRect.height - mapHeight;
         }
         else
         {
            _loc3_ = _viewPortRect.height / 2 - _selfArmy.y;
         }
         SpaceManager.instance.mapView.x = int(_loc2_ + 0.5);
         SpaceManager.instance.mapView.y = int(_loc3_ + 0.5);
         x = SpaceManager.instance.mapView.x;
         y = SpaceManager.instance.mapView.y;
      }
      
      private function moveXY(param1:int, param2:int) : void
      {
         param1 = int(Math.abs(param1 - x) < _xLimen + _bevelSpeed ? x : param1);
         param2 = int(Math.abs(param2 - y) < _yLimen + _bevelSpeed ? y : param2);
         var _loc4_:int = param1 - x;
         var _loc5_:int = param2 - y;
         if(Math.abs(_loc4_) < _xLimen && Math.abs(_loc5_) < _yLimen)
         {
            return;
         }
         var _loc3_:Point = new Point(x,y);
         if(_loc3_.x + param1 > 10)
         {
            if(_viewPortRect.width - x >= mapWidth)
            {
               _loc3_.x = _viewPortRect.width - mapWidth;
            }
            else
            {
               _loc3_.x -= (_loc3_.x + param1 - 10) * _tweenValue;
               _loc3_.x = _loc3_.x + 0.5 >> 0;
            }
         }
         else if(x >= -10)
         {
            _loc3_.x = -10;
         }
         else if(_loc3_.x + param1 < -10)
         {
            _loc3_.x -= (_loc3_.x + param1 + 10) * _tweenValue;
            _loc3_.x = _loc3_.x + 0.5 >> 0;
         }
         if(_loc3_.y + param2 > 10)
         {
            if(_viewPortRect.height - y >= mapHeight)
            {
               _loc3_.y = _viewPortRect.height - mapHeight;
            }
            else
            {
               _loc3_.y -= (_loc3_.y + param2 - 10) * _tweenValue;
               _loc3_.y = _loc3_.y + 0.5 >> 0;
            }
         }
         else if(_loc3_.y >= -10)
         {
            _loc3_.y = -10;
         }
         else if(_loc3_.y + param2 < -10)
         {
            _loc3_.y -= (_loc3_.y + param2 + 10) * _tweenValue;
            _loc3_.y = _loc3_.y + 0.5 >> 0;
         }
         x = _loc3_.x;
         y = _loc3_.y;
      }
      
      private function updateBlock() : void
      {
         var _loc5_:MapTextureBlock = null;
         var _loc4_:int = 0;
         var _loc1_:int = _blockRectToMap.x / 512;
         var _loc3_:int = _blockRectToMap.y / 512;
         var _loc2_:int = int(arrayTextureBlocks.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = arrayTextureBlocks[_loc4_];
            _loc5_.setBlockLocal(_loc1_ + _loc4_ % 5,_loc3_ + _loc4_ / 5,_bgLayer,_blockRectToMap);
            _loc4_++;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         _walkLayer.advanceTime(param1);
         if(!_isInit)
         {
            if(!_selfArmy)
            {
               _selfArmy = SpaceManager.instance.controller.getArmyView(SpaceManager.instance.model.selfArmy) as SpaceAvatar;
               _bevelSpeed = _selfArmy.aiInfo.speed;
               return;
            }
            _isInit = true;
            updateCurrentPosition(true);
         }
         else
         {
            updateCurrentPosition();
         }
         WorldClock.clock.advanceTime(param1);
      }
      
      override public function dispose() : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
            _mouseDownTimeId = 0;
         }
         removeEvent();
         for each(var _loc1_:MapTextureBlock in arrayTextureBlocks)
         {
            _loc1_.dispose();
         }
         if(_qtree)
         {
            _qtree.dispose();
            _qtree = null;
         }
         Global.qtree = null;
         if(_hitLayer.parent)
         {
            _hitLayer.parent.removeChild(_hitLayer);
         }
         _filter.dispose();
         _filter = null;
         _bgLayer = null;
         _walkLayer = null;
         arrayTextureBlocks = null;
         _mapRect = null;
         _viewPortRect = null;
         _blockRectToMap = null;
         _mapModel = null;
         super.dispose();
      }
   }
}

