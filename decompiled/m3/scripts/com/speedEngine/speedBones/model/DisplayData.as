package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.BaseClass;
   import com.speedEngine.speedBones.events.Event;
   import com.speedEngine.speedBones.events.EventDispatch;
   import com.speedEngine.speedBones.interfaces.IDispatch;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class DisplayData extends BaseClass implements IDispatch
   {
      
      public static var HALF_WIDTH:Number;
      
      public static var HALF_HEIGHT:Number;
      
      public static var SCENCE_SCALEX:Number;
      
      public static var SCENCE_SCALEY:Number;
      
      private static var INDEX:uint = 0;
      
      protected var _controlstreamController:Vector.<uint> = null;
      
      protected var _controlstreamControllerIndex:Vector.<uint> = null;
      
      protected var _vertexXYStream:ByteArray = null;
      
      protected var _vertexUVStream:ByteArray = null;
      
      protected var _controlStreamBytes:ByteArray = null;
      
      protected var _movementXYDataBytes:ByteArray;
      
      protected var _movementUVDataBytes:ByteArray;
      
      protected const LIMIT_UPLOAD:int = 524256;
      
      protected var _triangles:Vector.<Number>;
      
      private var _maxX:Number;
      
      private var _minX:Number;
      
      private var _maxY:Number;
      
      private var _minY:Number;
      
      private var _tempIndex:int;
      
      private var _pointLen:uint;
      
      private var _tempX:Number;
      
      private var _tempY:Number;
      
      private var _boundRect:Rectangle;
      
      public var _name:String;
      
      private var _isDispose:Boolean = false;
      
      private var _dispath:EventDispatch;
      
      private var _helpAttribute:ByteArray = null;
      
      private var _srcXYDataBytes:ByteArray;
      
      public function DisplayData(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:Vector.<uint>, param5:Vector.<uint>)
      {
         super();
         _dispath = new EventDispatch(this);
         _name = "instance" + INDEX++;
         _vertexXYStream = param1;
         _vertexUVStream = param2;
         _controlStreamBytes = param3;
         _controlstreamController = param4;
         _controlstreamControllerIndex = param5;
         _movementXYDataBytes = new ByteArray();
         _movementUVDataBytes = new ByteArray();
         _movementXYDataBytes.endian = "littleEndian";
         _movementUVDataBytes.endian = "littleEndian";
         _triangles = new Vector.<Number>();
         _boundRect = new Rectangle();
         _helpAttribute = new ByteArray();
         _helpAttribute.endian = "littleEndian";
      }
      
      protected function clearSrcStream() : void
      {
         if(_srcXYDataBytes)
         {
            _srcXYDataBytes.clear();
            _srcXYDataBytes = null;
         }
      }
      
      protected function copyDataToSrc() : ByteArray
      {
         _srcXYDataBytes = new ByteArray();
         _srcXYDataBytes.endian = "littleEndian";
         _movementXYDataBytes.position = 0;
         _movementXYDataBytes.readBytes(_srcXYDataBytes);
         return _srcXYDataBytes;
      }
      
      public function setControlStream(param1:Number, param2:Number) : void
      {
         if(_srcXYDataBytes == null)
         {
            copyDataToSrc();
         }
         var _loc3_:ByteArray = _srcXYDataBytes;
         _loc3_.position = 0;
         _movementXYDataBytes.position = 0;
         while(_loc3_.bytesAvailable > 0)
         {
            _movementXYDataBytes.writeFloat(_loc3_.readFloat() - param1);
            _movementXYDataBytes.writeFloat(_loc3_.readFloat() - param2);
         }
      }
      
      protected function updateBounds() : void
      {
         throw "override this function";
      }
      
      public function writeController(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:uint, param5:RenderContainerData = null) : void
      {
      }
      
      public function updatePipeSize(param1:uint) : void
      {
         if(_controlstreamController[_controlstreamControllerIndex[3]] + param1 > 524256)
         {
            var _loc2_:* = 0;
            var _loc3_:Number = _controlstreamControllerIndex[_loc2_] + 4;
            _controlstreamControllerIndex[_loc2_] = _loc3_;
            _controlstreamControllerIndex[1] += 4;
            _controlstreamControllerIndex[2] += 4;
            _controlstreamControllerIndex[3] += 4;
            _controlstreamController[_controlstreamControllerIndex[0]] = _vertexXYStream.position;
            _controlstreamController[_controlstreamControllerIndex[1]] = _controlStreamBytes.position;
            _controlstreamController[_controlstreamControllerIndex[2]] = 0;
            _controlstreamController[_controlstreamControllerIndex[3]] = 0;
         }
         _loc2_ = _controlstreamControllerIndex[3];
         _loc3_ = _controlstreamController[_loc2_] + param1;
         _controlstreamController[_loc2_] = _loc3_;
      }
      
      public function updateContainerFilter(param1:ByteArray, param2:uint, param3:RenderContainerData) : void
      {
         _controlStreamBytes.writeUnsignedInt(0);
         _controlStreamBytes.writeUnsignedInt(param2);
         updateAttributeBytes(param1,36,param3);
      }
      
      public function updateAttributeBytes(param1:ByteArray, param2:uint, param3:RenderContainerData) : void
      {
         _helpAttribute.length = 0;
         _helpAttribute.position = 0;
         _helpAttribute.writeBytes(param1);
         _helpAttribute.position = 0;
         var _loc6_:Number = _helpAttribute.readFloat();
         var _loc7_:Number = _helpAttribute.readFloat();
         var _loc5_:Number = _helpAttribute.readFloat();
         var _loc4_:Number = _helpAttribute.readFloat();
         _loc6_ /= DisplayData.SCENCE_SCALEX;
         _loc7_ /= DisplayData.SCENCE_SCALEY;
         _loc6_ *= param3.renderScaleX;
         _loc7_ *= param3.renderScaleY;
         _loc5_ /= DisplayData.SCENCE_SCALEX;
         _loc4_ /= DisplayData.SCENCE_SCALEY;
         _loc5_ += DisplayData.HALF_WIDTH;
         _loc4_ = DisplayData.HALF_HEIGHT - _loc4_;
         _loc5_ = param3.getTransformX(_loc5_);
         _loc4_ = param3.getTransformY(_loc4_);
         _helpAttribute.position = 0;
         _helpAttribute.writeFloat(_loc6_);
         _helpAttribute.writeFloat(_loc7_);
         _helpAttribute.writeFloat(_loc5_);
         _helpAttribute.writeFloat(_loc4_);
         _controlStreamBytes.writeBytes(_helpAttribute,0,param2);
      }
      
      protected function getRect(param1:uint, param2:uint) : void
      {
         if(param2 > _movementXYDataBytes.length || param2 < 8)
         {
            _triangles.length = 0;
            _boundRect.x = 0;
            _boundRect.y = 0;
            _boundRect.right = 0;
            _boundRect.bottom = 0;
            return;
         }
         _pointLen = param2 / 8;
         _tempIndex = 0;
         _triangles.length = 0;
         _movementXYDataBytes.position = param1;
         _maxX = _minX = _movementXYDataBytes.readFloat();
         _maxY = _minY = _movementXYDataBytes.readFloat();
         _triangles.push(_maxX,_maxY);
         _pointLen = _pointLen - 1;
         while(_tempIndex++ < _pointLen)
         {
            _tempX = _movementXYDataBytes.readFloat();
            _tempY = _movementXYDataBytes.readFloat();
            _triangles.push(_tempX,_tempY);
            if(_tempX < _maxX)
            {
               if(_tempX < _minX)
               {
                  _minX = _tempX;
               }
            }
            else
            {
               _maxX = _tempX;
            }
            if(_tempY < _maxY)
            {
               if(_tempY < _minY)
               {
                  _minY = _tempY;
               }
            }
            else
            {
               _maxY = _tempY;
            }
         }
         _boundRect.setEmpty();
         _boundRect.x = _minX;
         _boundRect.y = -_maxY;
         _boundRect.right = _maxX;
         _boundRect.bottom = -_minY;
         dispathEventWidth(Event.getEvent(Event,"change"));
      }
      
      public function get movementXYDataBytes() : ByteArray
      {
         return _movementXYDataBytes;
      }
      
      public function set movementXYDataBytes(param1:ByteArray) : void
      {
         _movementXYDataBytes = param1;
      }
      
      public function get movementUVDataBytes() : ByteArray
      {
         return _movementUVDataBytes;
      }
      
      public function set movementUVDataBytes(param1:ByteArray) : void
      {
         _movementUVDataBytes = param1;
      }
      
      public function get triangles() : Vector.<Number>
      {
         return _triangles;
      }
      
      public function set triangles(param1:Vector.<Number>) : void
      {
         _triangles = param1;
      }
      
      public function dispose() : void
      {
         _isDispose = true;
         clearSrcStream();
         if(_dispath)
         {
            _dispath.removeAllEvents();
         }
         if(_movementXYDataBytes)
         {
            _movementXYDataBytes.clear();
            _movementXYDataBytes = null;
         }
         if(_movementUVDataBytes)
         {
            _movementUVDataBytes.clear();
            _movementUVDataBytes = null;
         }
         if(_triangles)
         {
            _triangles.length = 0;
            _triangles = null;
         }
         _vertexXYStream = null;
         _controlstreamController = null;
         _controlstreamControllerIndex = null;
         _vertexUVStream = null;
         _controlStreamBytes = null;
         _dispath = null;
      }
      
      public function get boundRect() : Rectangle
      {
         return _boundRect;
      }
      
      public function get isDispose() : Boolean
      {
         return _isDispose;
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         _dispath.addEventListener(param1,param2);
      }
      
      public function dispathEventWidth(param1:Event, param2:Boolean = false) : void
      {
         _dispath.dispathEventWidth(param1,param2);
      }
      
      public function hasEventType(param1:String) : Boolean
      {
         return _dispath.hasEventType(param1);
      }
      
      public function removeAllEvents() : void
      {
         _dispath.removeAllEvents();
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         _dispath.removeEventListener(param1,param2);
      }
      
      public function get width() : Number
      {
         return _boundRect.width;
      }
      
      public function get height() : Number
      {
         return _boundRect.height;
      }
   }
}

