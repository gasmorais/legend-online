package com.road.mapengine.bitmap.logic
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.IMouseEvent;
   import com.road.mapengine.bitmap.load.ResourceInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import map.internals.utils.MapUtisl;
   import yishi.filter.UIFilter;
   
   public class BitmapSimpleLogic implements Disposeable, IMouseEvent
   {
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _rotation:Number;
      
      private var _mouseEnabled:Boolean;
      
      private var _enable:Boolean;
      
      private var _resourceList:Array;
      
      protected var _curStepFrame:int;
      
      protected var _cycleStepFrame:int = 3;
      
      protected var _displayMode:int;
      
      protected var _baseView:Bitmap;
      
      protected var _container:VehicleBaseSprite;
      
      protected var _mapScene:BaseMapScene;
      
      private var _areaKeyX:int;
      
      private var _areaKeyY:int;
      
      protected var _hitRect:LogicRectangle;
      
      private var _instanceId:int;
      
      private var _filer:UIFilter = new UIFilter();
      
      private var _slelecMc:Sprite;
      
      public function BitmapSimpleLogic(param1:BaseMapScene)
      {
         super();
         _instanceId = MapUtisl.instanceId;
         _mapScene = param1;
         _displayMode = 1;
         _resourceList = [];
         _container = new VehicleBaseSprite(this);
         _hitRect = new LogicRectangle(this);
         _baseView = new Bitmap();
      }
      
      public function get mapScene() : BaseMapScene
      {
         return _mapScene;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get hitRect() : LogicRectangle
      {
         var _loc1_:Rectangle = null;
         _hitRect.x = this.x;
         _hitRect.y = this.y;
         _hitRect.width = 1;
         _hitRect.height = 1;
         if(_baseView && _mapScene.parent)
         {
            _loc1_ = _baseView.getBounds(_mapScene.parent);
            _hitRect.x = _loc1_.x;
            _hitRect.y = _loc1_.y;
            _hitRect.width = _loc1_.width;
            _hitRect.height = _loc1_.height;
         }
         return _hitRect;
      }
      
      public function hitGlobalPoint(param1:Point) : Boolean
      {
         var _loc2_:int = param1.x - x - _baseView.x;
         var _loc3_:int = param1.y - y - _baseView.y;
         var _loc4_:int = int(_baseView.bitmapData.getPixel(_loc2_,_loc3_));
         return _loc4_ > 50 ? true : false;
      }
      
      public function setFilter() : void
      {
         _container.transform.colorTransform = new ColorTransform(1,0.2,0.2);
      }
      
      public function get displayMode() : int
      {
         return _displayMode;
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(param1 == _container)
         {
            return null;
         }
         _container.addChild(param1);
         return param1;
      }
      
      public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(param1)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
         return param1;
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         _container.addChildAt(param1,param2);
         return param1;
      }
      
      public function update() : void
      {
         if(_curStepFrame == _cycleStepFrame - 1)
         {
            updateStart();
            _curStepFrame = _curStepFrame + 1;
         }
         else if(_curStepFrame >= _cycleStepFrame)
         {
            _curStepFrame = 0;
            updateOver();
         }
         else
         {
            updateWait(_curStepFrame);
            _curStepFrame = _curStepFrame + 1;
         }
      }
      
      protected function updateStart() : void
      {
      }
      
      protected function updateWait(param1:int) : void
      {
      }
      
      protected function updateOver() : void
      {
      }
      
      public function over() : void
      {
      }
      
      internal function throwResourceTypeError(param1:int, param2:String) : void
      {
      }
      
      protected function loaderResourceCall(param1:LoaderInfo, param2:Object) : void
      {
      }
      
      public function get curResourceType() : int
      {
         return 0;
      }
      
      public function get resourceList() : Array
      {
         return _resourceList;
      }
      
      public function addResourceInfo(param1:ResourceInfo) : void
      {
         _resourceList.push(param1);
      }
      
      public function get rotation() : Number
      {
         return _rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         _rotation = param1;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
         _container.y = param1;
         _areaKeyY = _y >> 20;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
         _container.x = param1;
         _areaKeyX = _x >> 20;
      }
      
      public function get AreaKey() : String
      {
         return _areaKeyX + "_" + _areaKeyY;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
      }
      
      protected function getResourcepath(param1:String) : String
      {
         throw new Error("重载该方{invalid_utf8=230}{invalid_utf8=179}?");
      }
      
      public function get mouseEnabled() : Boolean
      {
         return _mouseEnabled;
      }
      
      public function set mouseEnabled(param1:Boolean) : void
      {
         _mouseEnabled = param1;
      }
      
      public function getMousePixelsValue() : int
      {
         return 0;
      }
      
      public function mouseClickEvent(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseDownEvent(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseUpEvent(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOverEvent(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOutEvent(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseMoveEvent(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
         if(_container && _container.parent)
         {
            _container.parent.removeChild(_container);
         }
         if(_hitRect)
         {
            _hitRect.dispose();
         }
         _hitRect = null;
         if(_baseView && _baseView.bitmapData)
         {
            _baseView.bitmapData.dispose();
         }
         _baseView = null;
         ObjectUtils.disposeAllChildren(_container);
      }
      
      public function get container() : Sprite
      {
         return _container;
      }
      
      public function getTilePoint() : Point
      {
         return new Point(int(Math.floor(x / 20)),int(Math.floor(y / 20)));
      }
      
      public function select(param1:Sprite) : void
      {
         _slelecMc = param1;
         _slelecMc.hitArea = _container;
      }
      
      public function unSelect() : void
      {
         if(_slelecMc && _slelecMc.parent)
         {
            _slelecMc.parent.removeChild(_slelecMc);
            _slelecMc.hitArea = null;
         }
         _slelecMc = null;
      }
   }
}

