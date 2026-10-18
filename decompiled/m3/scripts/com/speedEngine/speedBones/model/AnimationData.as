package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class AnimationData extends DisplayData
   {
      
      public var _movementIndex:ByteArray;
      
      public var _frameIndex:ByteArray;
      
      public var _movementLength:uint;
      
      public var _controlStreamData:ByteArray;
      
      public var _rideDataBytes:ByteArray = null;
      
      public var _rideIndexBytes:ByteArray = null;
      
      public var embedChildBytes:ByteArray = null;
      
      public var embedMovementBytes:ByteArray = null;
      
      public var embedFrameIndexBytes:ByteArray = null;
      
      public var embedDataBytes:ByteArray = null;
      
      public var appendData:Object = null;
      
      public var hinderDataBytes:ByteArray = null;
      
      public var _movementLoop:Boolean;
      
      public var _textureIndex:uint = 0;
      
      public var _moveNum:int = 2;
      
      private var _movementDic:Dictionary;
      
      private var _movementList:Vector.<String>;
      
      private var _scale:Number;
      
      private var _name:String;
      
      private var _cacheHander:Object = {};
      
      private var _cacheNode:Object = {};
      
      private var _cacheRect:Object = {};
      
      private var _cacheKey:String = null;
      
      private var _movementsIndex:int = 0;
      
      private var _movementNumber:int = 0;
      
      private var _frameNumber:int = 0;
      
      private var _hasChangeFrame:Boolean = false;
      
      public function AnimationData(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:Vector.<uint>, param5:Vector.<uint>)
      {
         super(param1,param2,param3,param4,param5);
         _frameIndex = new ByteArray();
         _movementIndex = new ByteArray();
         _controlStreamData = new ByteArray();
         _rideDataBytes = new ByteArray();
         _rideIndexBytes = new ByteArray();
         embedChildBytes = new ByteArray();
         embedMovementBytes = new ByteArray();
         embedFrameIndexBytes = new ByteArray();
         embedDataBytes = new ByteArray();
         hinderDataBytes = new ByteArray();
         embedChildBytes.endian = "littleEndian";
         embedMovementBytes.endian = "littleEndian";
         embedFrameIndexBytes.endian = "littleEndian";
         embedDataBytes.endian = "littleEndian";
         hinderDataBytes.endian = "littleEndian";
         _frameIndex.endian = "littleEndian";
         _movementIndex.endian = "littleEndian";
         _controlStreamData.endian = "littleEndian";
         _rideDataBytes.endian = "littleEndian";
         _rideIndexBytes.endian = "littleEndian";
         _movementDic = new Dictionary();
         _movementList = new Vector.<String>();
      }
      
      public function writeFramePipe(param1:uint, param2:uint, param3:uint) : void
      {
         if(_movementNumber != param2 || _frameNumber != param3)
         {
            _hasChangeFrame = true;
         }
         else
         {
            _hasChangeFrame = false;
         }
         _movementsIndex = param1;
         _movementNumber = param2;
         _frameNumber = param3;
      }
      
      override public function writeController(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:uint, param5:RenderContainerData = null) : void
      {
         if(isDispose)
         {
            trace("你的代码中AnimationData已经释放{invalid_utf8=239}{invalid_utf8=188}? 但是还在舞台上， 请检查代码， 确保先移除再释放Animation",_name);
            return;
         }
         var _loc10_:uint = _movementsIndex + _frameNumber * 12;
         if(_frameIndex == null || _loc10_ >= _frameIndex.length)
         {
            return;
         }
         _frameIndex.position = _loc10_;
         var _loc13_:uint = _frameIndex.readUnsignedInt();
         var _loc12_:uint = _frameIndex.readUnsignedInt();
         if(_loc12_ <= 0)
         {
            return;
         }
         var _loc6_:uint = _frameIndex.readUnsignedInt();
         _controlStreamData.position = _loc6_;
         var _loc8_:uint = _controlStreamData.readUnsignedInt();
         var _loc11_:uint = _controlStreamData.readUnsignedInt();
         _loc6_ = _controlStreamData.position;
         var _loc7_:Boolean = param3.length > 0 && _loc11_ > 1;
         var _loc9_:uint = 1;
         if(_loc7_ || param5)
         {
            _loc9_ = _loc11_;
            _loc11_ = 1;
         }
         updatePipeSize(_loc12_);
         _controlstreamController[_controlstreamControllerIndex[2]] += _loc11_;
         if(param5)
         {
            updateContainerFilter(param1,_textureIndex,param5);
         }
         else
         {
            _controlStreamBytes.writeUnsignedInt(param4);
            _controlStreamBytes.writeUnsignedInt(_textureIndex);
            _controlStreamBytes.writeBytes(param1,0,36);
            _controlStreamBytes.writeBytes(param2);
            _controlStreamBytes.writeBytes(param3);
         }
         if(_loc7_ || param5)
         {
            updataControlStreanm(_loc6_,_loc9_,_loc12_);
         }
         else
         {
            _controlStreamBytes.writeBytes(_controlStreamData,_loc6_,_loc8_);
         }
         _vertexXYStream.writeBytes(_movementXYDataBytes,_loc13_,_loc12_);
         _vertexUVStream.writeBytes(_movementUVDataBytes,_loc13_,_loc12_);
      }
      
      public function updataControlStreanm(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         _loc5_ = param3 / 16;
         _loc4_ = _loc5_ * 3;
         _controlStreamBytes.writeUnsignedInt(11);
         _controlStreamBytes.writeUnsignedInt(1);
         _controlStreamBytes.writeUnsignedInt(_loc5_);
         _controlStreamBytes.writeUnsignedInt(_loc4_);
      }
      
      public function getBound() : void
      {
         updateBounds();
      }
      
      override protected function updateBounds() : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _cacheKey = _movementNumber + "_" + _frameNumber;
         var _loc1_:Object = _cacheRect[_cacheKey];
         if(_loc1_)
         {
            if(_hasChangeFrame)
            {
               boundRect.copyFrom(_loc1_.rect);
               _triangles.length = 0;
               _triangles = _loc1_.triangles.slice(0);
               dispathEventWidth(Event.getEvent(Event,"change"));
            }
         }
         else
         {
            _loc4_ = uint(_movementsIndex + _frameNumber * 12);
            if(_frameIndex == null || _loc4_ >= _frameIndex.length)
            {
               return;
            }
            _frameIndex.position = _loc4_;
            _loc3_ = _frameIndex.readUnsignedInt();
            _loc2_ = _frameIndex.readUnsignedInt();
            if(_loc2_ > 0)
            {
               getRect(_loc3_,_loc2_);
            }
            _cacheRect[_cacheKey] = {
               "rect":boundRect.clone(),
               "triangles":_triangles.slice(0)
            };
         }
      }
      
      public function setTextureIndex(param1:uint) : void
      {
         _textureIndex = param1;
      }
      
      public function get hasHinderData() : Boolean
      {
         return hinderDataBytes != null && hinderDataBytes.length > 0;
      }
      
      public function getHinderData(param1:int, param2:int) : HinderData
      {
         if(hinderDataBytes.length == 0)
         {
            return null;
         }
         _cacheKey = param1 + "_" + param2;
         var _loc3_:HinderData = _cacheHander[_cacheKey];
         if(_loc3_)
         {
            return _loc3_;
         }
         embedMovementBytes.position = param1 << 2;
         embedFrameIndexBytes.position = embedMovementBytes.readUnsignedInt() + param2 * _moveNum * 4;
         embedFrameIndexBytes.position += 8;
         hinderDataBytes.position = embedFrameIndexBytes.readUnsignedInt();
         var _loc4_:uint = hinderDataBytes.readUnsignedInt();
         if(_loc4_ < hinderDataBytes.bytesAvailable)
         {
            _loc3_ = new HinderData();
            _loc3_.hinderStr = hinderDataBytes.readUTFBytes(_loc4_);
            _loc3_.hitSize = int(getDataByName("hitSize",getMovementStrByID(param1)));
            _cacheHander[_cacheKey] = _loc3_;
         }
         return _loc3_;
      }
      
      public function getChildNode(param1:uint, param2:uint) : BoneTransform
      {
         if(_rideIndexBytes.length == 0)
         {
            return null;
         }
         _cacheKey = param1 + "_" + param2;
         var _loc3_:BoneTransform = _cacheNode[_cacheKey];
         if(_loc3_)
         {
            return _loc3_;
         }
         _rideIndexBytes.position = param1 * 4;
         _rideDataBytes.position = _rideIndexBytes.readUnsignedInt() + param2 * 32;
         if(_rideDataBytes.bytesAvailable > 32)
         {
            _loc3_ = new BoneTransform();
            _loc3_.x = _rideDataBytes.readFloat();
            _loc3_.y = _rideDataBytes.readFloat();
            _loc3_.scaleX = _rideDataBytes.readFloat();
            _loc3_.scaleY = _rideDataBytes.readFloat();
            _loc3_.skewX = _rideDataBytes.readFloat();
            _loc3_.skewY = _rideDataBytes.readFloat();
            _loc3_.pivotX = _rideDataBytes.readFloat();
            _loc3_.pivotY = _rideDataBytes.readFloat();
            _cacheNode[_cacheKey] = _loc3_;
         }
         return _loc3_;
      }
      
      public function getFrameRect() : Rectangle
      {
         _cacheKey = _movementNumber + "_" + _frameNumber;
         var _loc1_:Object = _cacheRect[_cacheKey];
         if(_loc1_)
         {
            return _loc1_.rect;
         }
         return new Rectangle();
      }
      
      public function getMovementIndexByMovementID(param1:uint) : uint
      {
         _movementIndex.position = param1 << 3;
         return _movementIndex.readUnsignedInt();
      }
      
      public function getMovementLengthByMovementID(param1:uint) : uint
      {
         _movementIndex.position = (param1 << 3) + 4;
         return _movementIndex.readUnsignedInt();
      }
      
      public function getMovementIDByName(param1:String) : uint
      {
         var _loc2_:Object = _movementDic[param1];
         if(_loc2_)
         {
            _movementLoop = _loc2_.isLoop;
            return _loc2_.index;
         }
         return 0;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function set scale(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            _scale = param1;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function addMovIndex(param1:String, param2:Object) : void
      {
         _movementDic[param1] = param2;
         if(_movementList.indexOf(param1) == -1)
         {
            _movementList.push(param1);
         }
      }
      
      public function getMovementStrByID(param1:int) : String
      {
         var _loc2_:Object = null;
         for(var _loc3_:String in _movementDic)
         {
            _loc2_ = _movementDic[_loc3_];
            if(_loc2_ && _loc2_.index == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getDataByName(param1:String, param2:String) : String
      {
         var _loc4_:String = null;
         var _loc3_:Object = _movementDic[param2];
         if(_loc3_ && _loc3_.append)
         {
            _loc4_ = _loc3_.append[param1];
         }
         else
         {
            _loc4_ = appendData[param1];
         }
         return _loc4_;
      }
      
      public function get movementList() : Vector.<String>
      {
         return _movementList;
      }
      
      override public function dispose() : void
      {
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
         if(_movementIndex)
         {
            _movementIndex.clear();
            _movementIndex = null;
         }
         if(_frameIndex)
         {
            _frameIndex.clear();
            _frameIndex = null;
         }
         if(_controlStreamData)
         {
            _controlStreamData.clear();
            _controlStreamData = null;
         }
         if(_rideDataBytes)
         {
            _rideDataBytes.clear();
            _rideDataBytes = null;
         }
         if(_rideIndexBytes)
         {
            _rideIndexBytes.clear();
            _rideIndexBytes = null;
         }
         if(embedChildBytes)
         {
            embedChildBytes.clear();
            embedChildBytes = null;
         }
         if(embedDataBytes)
         {
            embedDataBytes.clear();
            embedDataBytes = null;
         }
         if(embedFrameIndexBytes)
         {
            embedFrameIndexBytes.clear();
            embedFrameIndexBytes = null;
         }
         if(embedMovementBytes)
         {
            embedMovementBytes.clear();
            embedMovementBytes = null;
         }
         if(hinderDataBytes)
         {
            hinderDataBytes.clear();
            hinderDataBytes = null;
         }
         _vertexXYStream = null;
         _vertexUVStream = null;
         _controlStreamBytes = null;
         _controlstreamController = null;
         _controlstreamControllerIndex = null;
         _movementDic = null;
         _movementList.length = 0;
         _movementList = null;
         _cacheHander = null;
         _cacheKey = null;
         _cacheNode = null;
         _cacheRect = null;
         super.dispose();
      }
   }
}

