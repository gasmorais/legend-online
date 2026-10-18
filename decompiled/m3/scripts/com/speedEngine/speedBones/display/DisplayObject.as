package com.speedEngine.speedBones.display
{
   import avmplus.getQualifiedClassName;
   import com.speedEngine.speedBones.BaseClass;
   import com.speedEngine.speedBones.events.Event;
   import com.speedEngine.speedBones.events.EventDispatch;
   import com.speedEngine.speedBones.filters.BlurFilter;
   import com.speedEngine.speedBones.filters.ColorFilter;
   import com.speedEngine.speedBones.filters.Filter;
   import com.speedEngine.speedBones.interfaces.IDispatch;
   import com.speedEngine.speedBones.model.DisplayData;
   import com.speedEngine.speedBones.model.RenderContainerData;
   import com.speedEngine.speedBones.utils.TriangleUtils;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   
   use namespace speedBones_internal;
   
   public class DisplayObject extends BaseClass implements IDispatch
   {
      
      private static var INSTANCECOUNT:uint = 0;
      
      public static const TRIANGLES:String = "tiangles";
      
      public static const SET_ATTRIBUTE:String = "set_attribute";
      
      public static const PIVOT:String = "pivot";
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _z:Number;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      private var _rotation:Number;
      
      private var _scale:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _pivotX:Number;
      
      private var _pivotY:Number;
      
      private var _skewX:Number;
      
      private var _skewY:Number;
      
      private var _alpha:Number;
      
      private var _visible:Boolean;
      
      private var _touchable:Boolean;
      
      private var _touchTarget:Boolean;
      
      protected var _unScaleWidth:Number;
      
      protected var _unScaleHeight:Number;
      
      private var _triangles:Vector.<Number>;
      
      private var _srcTriangles:Vector.<Number>;
      
      private var _name:String;
      
      private var _parent:DisplayObjectContainer;
      
      private var _stage:Stage;
      
      private var _dispatch:EventDispatch;
      
      private var _lastMouseMovePoint:Point;
      
      private var _isDown:Boolean;
      
      private var _isDispose:Boolean = false;
      
      private var _passSpeed:Number = 1;
      
      private var _gx:Number;
      
      private var _gy:Number;
      
      private var _gScaleX:Number;
      
      private var _gScaleY:Number;
      
      private var _gSkewX:Number = 0;
      
      private var _gSkewY:Number = 0;
      
      private var _gAlpha:Number = 0;
      
      protected var _attributeBytes:ByteArray;
      
      protected var _blurFilterBytes:ByteArray;
      
      protected var _colorFilterBytes:ByteArray;
      
      protected var _colorFilterSize:uint = 0;
      
      protected var _renderMode:uint = 0;
      
      protected var _renderContainerData:RenderContainerData = null;
      
      protected var _filters:Vector.<ColorFilter> = new Vector.<ColorFilter>();
      
      protected var _filter:Filter = null;
      
      protected var _hasChangeFilter:Boolean = false;
      
      protected var _displayData:DisplayData;
      
      protected var _rect:Rectangle;
      
      protected var _srcRect:Rectangle;
      
      private var _pSkewX:Number;
      
      private var _pSkewY:Number;
      
      private var _pX:Number;
      
      private var _pSrcX:Number;
      
      private var _pY:Number;
      
      private var _pSrcY:Number;
      
      private var _renderFunctionMap:Object;
      
      private var _markRenderFunction:Object;
      
      private var _sinX:Number;
      
      private var _cosX:Number;
      
      private var _sinY:Number;
      
      private var _cosY:Number;
      
      public function DisplayObject()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "com.speedEngine.speedBones.display::DisplayObject")
         {
            throw new Error("Abstract Class not new object!!");
         }
         initialize();
      }
      
      protected function initialize() : void
      {
         _renderFunctionMap = {};
         _markRenderFunction = {};
         _dispatch = new EventDispatch(this);
         _attributeBytes = new ByteArray();
         _attributeBytes.endian = "littleEndian";
         _colorFilterBytes = new ByteArray();
         _colorFilterBytes.endian = "littleEndian";
         _blurFilterBytes = new ByteArray();
         _blurFilterBytes.endian = "littleEndian";
         _triangles = new Vector.<Number>();
         _name = "instance" + ++INSTANCECOUNT;
         pushRenderFunction("set_attribute",setAttribute);
         pushRenderFunction("tiangles",changeTriangles);
         pushRenderFunction("pivot",changePivot);
         reset();
      }
      
      private function changePivot() : void
      {
         var _loc1_:Number = (_skewX + _gSkewX) % 360;
         var _loc2_:Number = (_skewY + _gSkewY) % 360;
         _sinX = Math.sin(_loc1_ * 3.141592653589793 / 180);
         _cosX = Math.cos(_loc1_ * 3.141592653589793 / 180);
         _sinY = Math.sin(_loc2_ * 3.141592653589793 / 180);
         _cosY = Math.cos(_loc2_ * 3.141592653589793 / 180);
         _pSrcX = _pivotX * width;
         _pSrcY = _pivotY * height;
         _pX = _pSrcX * _cosY + _pSrcY * _sinX;
         _pY = _pSrcY * _cosX - _pSrcX * _sinY;
         _pX *= _gScaleX * _scaleX;
         _pY *= _gScaleY * _scaleY;
      }
      
      private function setAttribute() : void
      {
         if(this.public::stage)
         {
            writeX(_gx - _pX + _pSrcX + _x);
            writeY(_gy - _pY + _pSrcY + _y);
            writeScaleX(_gScaleX * _scaleX);
            writeScaleY(_gScaleY * _scaleY);
            writeSkewX(_skewX);
            writeSkewY(_skewY);
         }
      }
      
      public function reset() : void
      {
         _isDispose = false;
         _attributeBytes.length = 36;
         _x = _y = _pX = _pY = _rotation = _width = _pSrcX = _pSrcY = 0;
         _height = _pivotX = _pivotY = _skewX = _skewY = _pSkewX = _pSkewY = _gSkewX = _gSkewY = 0;
         _sinX = _sinY = 0;
         _cosX = _cosY = 1;
         _unScaleWidth = _unScaleHeight = 0;
         _passSpeed = _scale = _alpha = _scaleX = _scaleY = _gScaleX = _gScaleY = 1;
         _visible = _touchable = _touchTarget = true;
         _rect = new Rectangle();
         _srcRect = new Rectangle();
         writeXYScale(0,0,1,1);
         writeSkew(0,0);
         _parent = null;
         _dispatch.removeAllEvents();
      }
      
      protected function pushRenderFunction(param1:String, param2:Function) : void
      {
         _renderFunctionMap[param1] = param2;
      }
      
      private function onResize(param1:Event) : void
      {
         if(this.public::stage)
         {
            _hasChangeFilter = true;
            writeXYScale(gx + x,gy + y,gScaleX * scaleX,gScaleY * scaleY);
         }
      }
      
      speedBones_internal function getInternalGX() : Number
      {
         return isNaN(_gx) ? 0 : _gx;
      }
      
      speedBones_internal function getInternalGY() : Number
      {
         return isNaN(_gy) ? 0 : _gy;
      }
      
      final public function repaint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Array) : void
      {
         if(_gSkewX != param6 || _gSkewY != param7 || _gScaleX != param4 || _gScaleY != param5)
         {
            _gSkewX != param6 ? (writeSkewX(param6 + _skewX),validate("tiangles")) : null;
            _gSkewY != param7 ? (writeSkewY(param7 + _skewY),validate("tiangles")) : null;
            _gScaleX != param4 ? (writeScaleX(param4 * _scaleX),validate("tiangles")) : null;
            _gScaleY != param5 ? (writeScaleY(param5 * _scaleY),validate("tiangles")) : null;
            _gSkewX = param6;
            _gSkewY = param7;
            _gScaleX = param4;
            _gScaleY = param5;
            changePivot();
         }
         if(isNaN(param2) || isNaN(param3))
         {
            throw "error";
         }
         param8[0] = param2 + _x - _pX + _pSrcX;
         param8[1] = param3 + _y - _pY + _pSrcY;
         if(isNaN(param8[0]) || isNaN(param8[0]))
         {
            throw "error";
         }
         _gx != param2 ? writeX(param8[0]) : null;
         _gy != param3 ? writeY(param8[1]) : null;
         _gAlpha != param1 ? writeAlpha(param1 * _alpha) : null;
         _gx = param2;
         _gy = param3;
         callRenderFunction();
         update();
      }
      
      protected function update() : void
      {
      }
      
      public function render(param1:Number) : void
      {
      }
      
      public function advanceFrame(param1:Number) : void
      {
      }
      
      protected function setUnScaleWidth(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw "error";
         }
         _unScaleWidth = param1;
         _width = _unScaleWidth * _scaleX;
         validate("tiangles");
      }
      
      protected function setUnScaleHeight(param1:Number) : void
      {
         _unScaleHeight = param1;
         _height = _unScaleHeight * _scaleY;
         validate("tiangles");
      }
      
      protected function setSrcRect(param1:Rectangle) : void
      {
         _srcRect = param1;
         _rect = _srcRect.clone();
         validate("tiangles");
      }
      
      protected function setSrcTriangles(param1:Vector.<Number>) : void
      {
         _srcTriangles = param1;
         _triangles = _srcTriangles.slice(0);
         validate("tiangles");
      }
      
      public function hitTest(param1:Point) : DisplayObject
      {
         return TriangleUtils.check(_triangles,param1) ? this : null;
      }
      
      public function localToGlobal(param1:Point) : Point
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return new Point(_gx + x + param1.x,_gy + y + param1.y);
      }
      
      public function globalToLocal#2(param1:Point) : Point
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return new Point(param1.x - _gx - x,param1.y - _gy - y);
      }
      
      speedBones_internal function globalToLocal#11(param1:Point, param2:Point = null) : Point
      {
         if(param2 == null)
         {
            param2 = new Point();
         }
         param2.setTo(param1.x - (isNaN(_gx) ? 0 : _gx) - x,param1.y - (isNaN(_gy) ? 0 : _gy) - y);
         return param2;
      }
      
      speedBones_internal function setRenderContainerFilter(param1:RenderContainerData) : void
      {
         _renderContainerData = param1;
      }
      
      public function set filter(param1:Filter) : void
      {
         if(_filter != param1)
         {
            _filter = param1;
            _hasChangeFilter = true;
         }
      }
      
      public function get filter() : Filter
      {
         return _filter;
      }
      
      public function addColorFilter(param1:ColorFilter) : void
      {
         if(param1 == null || param1.filterBytes.length == 0)
         {
            return;
         }
         var _loc2_:int = _filters.indexOf(param1);
         if(_loc2_ == -1)
         {
            _filters.length >= 3 ? (_filters[2] = param1) : _filters.push(param1);
            _hasChangeFilter = true;
         }
      }
      
      public function clearColorFilter(param1:ColorFilter = null) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            _colorFilterSize = 0;
            _renderMode &= 4;
            _renderMode |= _colorFilterSize;
            _colorFilterBytes.length = 0;
            _hasChangeFilter = true;
            _filters.length = 0;
         }
         else
         {
            _loc2_ = _filters.indexOf(param1);
            if(_loc2_ != -1)
            {
               _filters.splice(_loc2_,1);
               _hasChangeFilter = true;
            }
         }
      }
      
      public function containsPoint(param1:Number, param2:Number) : Boolean
      {
         getBounds();
         if(_rect.x > param1 || param1 > _rect.right)
         {
            return false;
         }
         if(_rect.y > param2 || param2 > _rect.bottom)
         {
            return false;
         }
         return true;
      }
      
      public function updateColorFilter() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:int = 0;
         _colorFilterBytes.clear();
         _colorFilterBytes.length = 0;
         _blurFilterBytes.clear();
         _blurFilterBytes.length = 0;
         _colorFilterSize = 0;
         _loc2_ = 0;
         while(_loc2_ < _filters.length)
         {
            _loc1_ = _filters[_loc2_].filterBytes;
            if(_loc1_ && _loc1_.length > 0)
            {
               _colorFilterBytes.position = _colorFilterSize * 80;
               _colorFilterBytes.writeBytes(_loc1_);
               _colorFilterSize = _colorFilterSize + 1;
            }
            _loc2_++;
         }
         _renderMode = 0;
         _renderMode |= _colorFilterSize;
         _hasChangeFilter = false;
      }
      
      public function updateFilter() : void
      {
         if(_filter is BlurFilter)
         {
            (_filter as BlurFilter).setTextureSize(getBounds());
            if(_filter.filterBytes.length > 0)
            {
               _colorFilterBytes.clear();
               _blurFilterBytes.clear();
               _colorFilterBytes.length = 0;
               _blurFilterBytes.length = 0;
               _blurFilterBytes.position = 0;
               _renderMode = (_filter as BlurFilter).renderMode;
               _blurFilterBytes.writeBytes(_filter.filterBytes);
               _hasChangeFilter = false;
            }
         }
      }
      
      protected function validate(param1:String) : void
      {
         _markRenderFunction[param1] = param1;
      }
      
      private function callRenderFunction() : void
      {
         for(var _loc1_:String in _markRenderFunction)
         {
            _renderFunctionMap[_loc1_].call(null);
            delete _markRenderFunction[_loc1_];
         }
      }
      
      protected function changeTriangles() : void
      {
         if(_srcTriangles == null)
         {
            return;
         }
         var _loc13_:Vector.<Number> = _srcTriangles.slice(0);
         var _loc1_:uint = _loc13_.length / 2;
         var _loc6_:int = -1;
         var _loc4_:int = -1;
         var _loc12_:Number = -Math.sin((_skewX + _gSkewX) * 3.141592653589793 / 180);
         var _loc7_:Number = Math.cos((_skewX + _gSkewX) * 3.141592653589793 / 180);
         var _loc11_:Number = Math.sin((_skewY + _gSkewX) * 3.141592653589793 / 180);
         var _loc2_:Number = Math.cos((_skewY + _gSkewX) * 3.141592653589793 / 180);
         var _loc5_:Number = 0;
         var _loc3_:Number = 0;
         var _loc10_:Number = 0;
         var _loc8_:Number = _gScaleX * _scaleX;
         var _loc9_:Number = _gScaleY * _scaleY;
         while(++_loc4_ < _loc1_)
         {
            var _loc14_:int = _loc6_ = _loc4_ << 1;
            var _loc15_:Number = _loc13_[_loc14_] * _loc8_;
            _loc13_[_loc14_] = _loc15_;
            _loc13_[_loc6_ + 1] *= _loc9_;
            _loc5_ = _loc13_[_loc6_];
            _loc3_ = _loc13_[_loc6_ + 1];
            _loc13_[_loc6_] = _loc5_ * _loc2_ + _loc3_ * _loc12_;
            _loc13_[_loc6_ + 1] = _loc3_ * _loc7_ + _loc5_ * _loc11_;
         }
         _triangles = _loc13_;
         _loc5_ = _srcRect.x;
         _loc3_ = _srcRect.y;
         _rect.setTo(0,0,0,0);
         _loc5_ *= _loc8_;
         _loc3_ *= _loc9_;
         _rect.x = _loc5_ * _loc2_ - _loc3_ * _loc12_;
         _rect.y = _loc3_ * _loc7_ - _loc5_ * _loc11_;
         _loc5_ = _srcRect.right;
         _loc3_ = _srcRect.bottom;
         _loc5_ *= _loc8_;
         _loc3_ *= _loc9_;
         _rect.right = _loc5_ * _loc2_ - _loc3_ * _loc12_;
         _rect.bottom = _loc3_ * _loc7_ - _loc5_ * _loc11_;
         if(_rect.x > _rect.right)
         {
            _loc10_ = _rect.x;
            _rect.x = _rect.right;
            _rect.right = _loc10_;
         }
         if(_rect.y > _rect.bottom)
         {
            _loc10_ = _rect.y;
            _rect.y = _rect.bottom;
            _rect.bottom = _loc10_;
         }
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         _dispatch.addEventListener(param1,param2);
      }
      
      public function dispathEventWidth(param1:Event, param2:Boolean = false) : void
      {
         if(_dispatch)
         {
            _dispatch.dispathEventWidth(param1,param2);
         }
      }
      
      public function hasEventType(param1:String) : Boolean
      {
         return _dispatch.hasEventType(param1);
      }
      
      public function removeAllEvents() : void
      {
         _dispatch.removeAllEvents();
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         _dispatch.removeEventListener(param1,param2);
      }
      
      public function writeX(param1:Number) : void
      {
         param1 = (int(param1) - DisplayData.HALF_WIDTH) * DisplayData.SCENCE_SCALEX;
         _attributeBytes.position = 8;
         _attributeBytes.writeFloat(param1);
      }
      
      public function writeY(param1:Number) : void
      {
         param1 = (DisplayData.HALF_HEIGHT - int(param1)) * DisplayData.SCENCE_SCALEY;
         _attributeBytes.position = 12;
         _attributeBytes.writeFloat(param1);
      }
      
      public function writeScaleX(param1:Number) : void
      {
         param1 *= DisplayData.SCENCE_SCALEX;
         _attributeBytes.position = 0;
         _attributeBytes.writeFloat(param1);
      }
      
      public function writeScaleY(param1:Number) : void
      {
         param1 *= DisplayData.SCENCE_SCALEY;
         _attributeBytes.position = 4;
         _attributeBytes.writeFloat(param1);
      }
      
      public function writeXYScale(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         param1 -= DisplayData.HALF_WIDTH;
         param1 *= DisplayData.SCENCE_SCALEX;
         param2 = DisplayData.HALF_HEIGHT - param2;
         param2 *= DisplayData.SCENCE_SCALEY;
         param3 *= DisplayData.SCENCE_SCALEX;
         param4 *= DisplayData.SCENCE_SCALEY;
         _attributeBytes.position = 0;
         _attributeBytes.writeFloat(param3);
         _attributeBytes.writeFloat(param4);
         _attributeBytes.writeFloat(param1);
         _attributeBytes.writeFloat(param2);
      }
      
      public function writeSkewX(param1:Number) : void
      {
         var _loc2_:Number = -Math.sin(param1 * 3.141592653589793 / 180);
         var _loc3_:Number = Math.cos(param1 * 3.141592653589793 / 180);
         _attributeBytes.position = 16;
         _attributeBytes.writeFloat(_loc2_);
         _attributeBytes.writeFloat(_loc3_);
      }
      
      public function writeSkewY(param1:Number) : void
      {
         var _loc3_:Number = Math.sin(param1 * 3.141592653589793 / 180);
         var _loc2_:Number = Math.cos(param1 * 3.141592653589793 / 180);
         _attributeBytes.position = 24;
         _attributeBytes.writeFloat(_loc3_);
         _attributeBytes.writeFloat(_loc2_);
      }
      
      public function writeSkew(param1:Number, param2:Number) : void
      {
         var _loc5_:Number = -Math.sin(param1 * 3.141592653589793 / 180);
         var _loc6_:Number = Math.cos(param1 * 3.141592653589793 / 180);
         var _loc4_:Number = Math.sin(param2 * 3.141592653589793 / 180);
         var _loc3_:Number = Math.cos(param2 * 3.141592653589793 / 180);
         _attributeBytes.position = 16;
         _attributeBytes.writeFloat(_loc5_);
         _attributeBytes.writeFloat(_loc6_);
         _attributeBytes.writeFloat(_loc4_);
         _attributeBytes.writeFloat(_loc3_);
      }
      
      public function writeAlpha(param1:Number) : void
      {
         _attributeBytes.position = 32;
         _attributeBytes.writeFloat(param1);
      }
      
      public function getBounds() : Rectangle
      {
         return _rect;
      }
      
      public function dispose() : void
      {
         if(this.public::parent)
         {
            this.public::parent.removeChild(this);
         }
         if(_dispatch)
         {
            _dispatch.removeAllEvents();
         }
         _dispatch = null;
         _blurFilterBytes.clear();
         _blurFilterBytes.length = 0;
         _colorFilterBytes.clear();
         _colorFilterBytes.length = 0;
         _renderMode = 0;
         _filters.length = 0;
         _filter = null;
         _displayData = null;
         _renderContainerData = null;
      }
      
      public function get parent() : DisplayObjectContainer
      {
         return _parent;
      }
      
      speedBones_internal function set parent(param1:DisplayObjectContainer) : void
      {
         _parent = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw "error";
         }
         _x = param1;
         validate("set_attribute");
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw "error";
         }
         _y = param1;
         validate("set_attribute");
      }
      
      public function get scaleX() : Number
      {
         return _scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(_scaleX == param1)
         {
            return;
         }
         _scaleX = param1;
         validate("tiangles");
         validate("set_attribute");
         validate("pivot");
      }
      
      public function get scaleY() : Number
      {
         return _scaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(_scaleY == param1)
         {
            return;
         }
         _scaleY = param1;
         validate("tiangles");
         validate("set_attribute");
         validate("pivot");
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         _alpha = param1;
         _alpha = _alpha > 1 ? 1 : (_alpha < 0 ? 0 : _alpha);
         writeAlpha(_gAlpha * _alpha);
      }
      
      private function traceDispose() : void
      {
         trace("调用set方法{invalid_utf8=227}{invalid_utf8=128}?" + this.name + "】对象已经被dispose但没有移除stage,请检查代码！{invalid_utf8=239}{invalid_utf8=188}?",this);
      }
      
      public function get gx() : Number
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return _gx;
      }
      
      public function get gy() : Number
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return _gy;
      }
      
      public function get gScaleX() : Number
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return _gScaleX;
      }
      
      public function get gScaleY() : Number
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return _gScaleY;
      }
      
      public function get mouseX() : Number
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return _stage.nativeStage.mouseX - _gx - x;
      }
      
      public function get mouseY() : Number
      {
         if(_stage == null)
         {
            throw "no stage";
         }
         return _stage.nativeStage.mouseY - _gy - y;
      }
      
      speedBones_internal function get lastMouseMovePoint() : Point
      {
         return _lastMouseMovePoint;
      }
      
      speedBones_internal function set lastMouseMovePoint(param1:Point) : void
      {
         _lastMouseMovePoint = param1;
      }
      
      speedBones_internal function get isDown() : Boolean
      {
         return _isDown;
      }
      
      speedBones_internal function set isDown(param1:Boolean) : void
      {
         _isDown = param1;
      }
      
      public function get rotation() : Number
      {
         if(_skewX == _skewY)
         {
            _rotation = _skewX;
         }
         return _rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         _rotation = param1;
         skewX = skewY = param1;
      }
      
      public function get stage() : Stage
      {
         return _stage;
      }
      
      speedBones_internal function set stage(param1:Stage) : void
      {
         var _loc2_:Event = null;
         if(param1 == _stage)
         {
            return;
         }
         if(_stage == null)
         {
            _stage = param1;
            if(param1 != null)
            {
               _loc2_ = Event.getEvent(Event,"add_to_stage",param1);
               dispathEventWidth(_loc2_);
               writeXYScale(gx + x,gy + y,gScaleX * scaleX,gScaleY * scaleY);
               _stage.addEventListener("resize",onResize);
            }
         }
         else
         {
            if(param1 == null)
            {
               _loc2_ = Event.getEvent(Event,"remove_from_stage",_stage);
               dispathEventWidth(_loc2_);
               _stage.removeEventListener("resize",onResize);
            }
            _stage = param1;
         }
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _visible = param1;
      }
      
      public function get touchable() : Boolean
      {
         return _touchable;
      }
      
      public function set touchable(param1:Boolean) : void
      {
         _touchable = param1;
      }
      
      public function get width() : Number
      {
         return _width;
      }
      
      public function set width(param1:Number) : void
      {
         if(_unScaleWidth > 0)
         {
            _width = param1;
            scaleX = _width / _unScaleWidth;
         }
      }
      
      public function get height() : Number
      {
         return _height;
      }
      
      public function set height(param1:Number) : void
      {
         if(_unScaleHeight > 0)
         {
            _height = param1;
            scaleY = _height / _unScaleHeight;
         }
      }
      
      public function get pivotX() : Number
      {
         return _pivotX;
      }
      
      public function set pivotX(param1:Number) : void
      {
         _pivotX = param1;
         validate("pivot");
      }
      
      public function get pivotY() : Number
      {
         return _pivotY;
      }
      
      public function set pivotY(param1:Number) : void
      {
         _pivotY = param1;
         validate("pivot");
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set z(param1:Number) : void
      {
         _z = param1;
      }
      
      public function get attributeBytes() : ByteArray
      {
         return _attributeBytes;
      }
      
      speedBones_internal function get triangles() : Vector.<Number>
      {
         return _triangles;
      }
      
      public function get skewX() : Number
      {
         return _skewX;
      }
      
      public function set skewX(param1:Number) : void
      {
         if(_skewX == param1)
         {
            return;
         }
         _skewX = param1;
         validate("tiangles");
         validate("set_attribute");
         validate("pivot");
      }
      
      public function get skewY() : Number
      {
         return _skewY;
      }
      
      public function set skewY(param1:Number) : void
      {
         if(_skewY == param1)
         {
            return;
         }
         _skewY = param1;
         validate("tiangles");
         validate("set_attribute");
         validate("pivot");
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function set scale(param1:Number) : void
      {
         _scale = param1;
         scaleX = param1;
         scaleY = param1;
      }
      
      public function get passSpeed() : Number
      {
         return _passSpeed;
      }
      
      public function set passSpeed(param1:Number) : void
      {
         _passSpeed = param1;
      }
      
      public function get touchTarget() : Boolean
      {
         return _touchTarget;
      }
      
      public function set touchTarget(param1:Boolean) : void
      {
         _touchTarget = param1;
      }
      
      public function get isDispose() : Boolean
      {
         return _isDispose;
      }
      
      public function get colorFilters() : Vector.<ColorFilter>
      {
         return _filters;
      }
   }
}

