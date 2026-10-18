package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.textures.SpeedTexture;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class ImageData extends DisplayData
   {
      
      private var _renderLength:uint = 32;
      
      private var _textureIndex:uint;
      
      private var _textureWidth:int;
      
      private var _textureHeight:int;
      
      private var _rectArray:Array;
      
      private var _scaleArray:Array;
      
      private var _rect:Rectangle;
      
      private var _quadLen:int;
      
      private var _srcWidth:Number;
      
      private var _srcHeight:Number;
      
      private var _mVertexData:Array;
      
      public function ImageData(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:Vector.<uint>, param5:Vector.<uint>)
      {
         super(param1,param2,param3,param4,param5);
         _scaleArray = [];
         _rectArray = [];
         _mVertexData = [];
         _mVertexData[0] = [0,0];
         _mVertexData[1] = [1,0];
         _mVertexData[2] = [1,1];
         _mVertexData[3] = [0,1];
      }
      
      public function setTexCoordsTo(param1:int, param2:Number, param3:Number) : void
      {
         _mVertexData[param1][0] = param2;
         _mVertexData[param1][1] = param3;
         if(isNaN(_srcWidth) || isNaN(_srcHeight))
         {
            return;
         }
         if(!_rect)
         {
            _movementUVDataBytes.position = 0;
            _movementUVDataBytes.writeFloat(_mVertexData[0][0]);
            _movementUVDataBytes.writeFloat(_mVertexData[0][1]);
            _movementUVDataBytes.writeFloat(_mVertexData[1][0] * _srcWidth / _textureWidth);
            _movementUVDataBytes.writeFloat(_mVertexData[1][1]);
            _movementUVDataBytes.writeFloat(_mVertexData[2][0] * _srcWidth / _textureWidth);
            _movementUVDataBytes.writeFloat(_mVertexData[2][1] * _srcHeight / _textureHeight);
            _movementUVDataBytes.writeFloat(_mVertexData[3][0]);
         }
      }
      
      public function get textureHeight() : int
      {
         return _textureHeight;
      }
      
      public function get textureWidth() : int
      {
         return _textureWidth;
      }
      
      public function setTexture(param1:SpeedTexture, param2:uint) : void
      {
         _textureIndex = param2;
         _textureWidth = param1.textureWidth;
         _textureHeight = param1.textureHeight;
         _srcWidth = param1.width;
         _srcHeight = param1.height;
         setVertexData();
      }
      
      public function setVertexData() : void
      {
         if(_rect)
         {
            writeScaleData();
         }
         else
         {
            writeSrcData();
         }
      }
      
      private function writeSrcData() : void
      {
         _renderLength = 32;
         _movementXYDataBytes.length = _renderLength;
         _movementUVDataBytes.length = _renderLength;
         _movementXYDataBytes.position = 0;
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(_srcWidth);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(_srcWidth);
         _movementXYDataBytes.writeFloat(-_srcHeight);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(-_srcHeight);
         _movementUVDataBytes.position = 0;
         _movementUVDataBytes.writeFloat(_mVertexData[0][0]);
         _movementUVDataBytes.writeFloat(_mVertexData[0][1]);
         _movementUVDataBytes.writeFloat(_mVertexData[1][0] * _srcWidth / _textureWidth);
         _movementUVDataBytes.writeFloat(_mVertexData[1][1]);
         _movementUVDataBytes.writeFloat(_mVertexData[2][0] * _srcWidth / _textureWidth);
         _movementUVDataBytes.writeFloat(_mVertexData[2][1] * _srcHeight / _textureHeight);
         _movementUVDataBytes.writeFloat(_mVertexData[3][0]);
         _movementUVDataBytes.writeFloat(_mVertexData[3][1] * _srcHeight / _textureHeight);
         _quadLen = 1;
         clearSrcStream();
         updateBounds();
      }
      
      override protected function updateBounds() : void
      {
         getRect(0,_renderLength);
      }
      
      public function setScale9Grid(param1:Rectangle) : void
      {
         if(param1 == null)
         {
            _rect = null;
            return;
         }
         if(_rect && param1.x == _rect.x && param1.y == _rect.y && param1.width == _rect.width && param1.height == _rect.height)
         {
            return;
         }
         _rect = param1.clone();
         _scaleArray.length = 0;
         _scaleArray.push([0,0,_rect.x,_rect.y]);
         _scaleArray.push([_rect.x,0,_rect.width,_rect.y]);
         _scaleArray.push([_rect.right,0,_srcWidth - _rect.right,_rect.y]);
         _scaleArray.push([0,_rect.y,_rect.x,_rect.height]);
         _scaleArray.push([_rect.x,_rect.y,_rect.width,_rect.height]);
         _scaleArray.push([_rect.right,_rect.y,_srcWidth - _rect.right,_rect.height]);
         _scaleArray.push([0,_rect.bottom,_rect.x,_srcHeight - _rect.bottom]);
         _scaleArray.push([_rect.x,_rect.bottom,_rect.width,_srcHeight - _rect.bottom]);
         _scaleArray.push([_rect.right,_rect.bottom,_srcWidth - _rect.right,_srcHeight - _rect.bottom]);
      }
      
      public function setNewWidthAndNewHeight(param1:Number, param2:Number) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc15_:Number = param1;
         var _loc10_:Number = param2;
         _loc17_ = _loc15_ - _srcWidth + _rect.width;
         _loc14_ = _loc10_ - _srcHeight + _rect.height;
         _loc17_ = _loc17_ > 0 ? 1 : _loc15_ / (_srcWidth - _rect.width);
         _loc14_ = _loc14_ > 0 ? 1 : _loc10_ / (_srcHeight - _rect.height);
         _rectArray.length = 0;
         _loc12_ = _rect.x * _loc17_;
         _loc13_ = _rect.y * _loc14_;
         _loc4_ = _loc15_ - _srcWidth + _rect.right - _rect.x;
         _loc9_ = _loc10_ - _srcHeight + _rect.bottom - _rect.y;
         _loc4_ = _loc4_ < 0 ? 0 : _loc4_;
         _loc9_ = _loc9_ < 0 ? 0 : _loc9_;
         _loc3_ = Math.ceil(_loc9_ / _rect.height);
         _loc16_ = Math.ceil(_loc4_ / _rect.width);
         _loc18_ = (_loc16_ * _rect.width - _loc4_) / _rect.width;
         _loc11_ = (_loc3_ * _rect.height - _loc9_) / _rect.height;
         _loc18_ = _loc18_ == 0 ? 0 : 1 - _loc18_;
         _loc11_ = _loc11_ == 0 ? 0 : 1 - _loc11_;
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc16_)
            {
               _loc7_ = _loc5_ = 1;
               if(_loc6_ == _loc16_ - 1 && _loc18_ != 0)
               {
                  _loc7_ = _loc18_;
               }
               if(_loc8_ == _loc3_ - 1 && _loc11_ != 0)
               {
                  _loc5_ = _loc11_;
               }
               _rectArray.push([_loc12_ + _loc6_ * _rect.width,-(_loc13_ + _loc8_ * _rect.height),4,_loc7_,_loc5_]);
               _loc6_++;
            }
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc7_ = _loc5_ = 1;
            if(_loc8_ == _loc3_ - 1 && _loc11_ != 0)
            {
               _loc5_ = _loc11_;
            }
            _rectArray.push([0,-(_loc13_ + _loc8_ * _rect.height),3,_loc17_,_loc5_]);
            _loc8_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc16_)
         {
            _loc7_ = _loc5_ = 1;
            if(_loc6_ == _loc16_ - 1 && _loc18_ != 0)
            {
               _loc7_ = _loc18_;
            }
            _rectArray.push([_loc12_ + _loc6_ * _rect.width,0,1,_loc7_,_loc14_]);
            _loc6_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc7_ = _loc5_ = 1;
            if(_loc8_ == _loc3_ - 1 && _loc11_ != 0)
            {
               _loc5_ = _loc11_;
            }
            _rectArray.push([_loc4_ + _loc12_,-(_loc13_ + _loc8_ * _rect.height),5,_loc17_,_loc5_]);
            _loc8_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc16_)
         {
            _loc7_ = _loc5_ = 1;
            if(_loc6_ == _loc16_ - 1 && _loc18_ != 0)
            {
               _loc7_ = _loc18_;
            }
            _rectArray.push([_loc12_ + _loc6_ * _rect.width,-(_loc9_ + _loc13_),7,_loc7_,_loc14_]);
            _loc6_++;
         }
         _rectArray.push([0,0,0,_loc17_,_loc14_]);
         _rectArray.push([_loc4_ + _loc12_,0,2,_loc17_,_loc14_]);
         _rectArray.push([0,-(_loc9_ + _loc13_),6,_loc17_,_loc14_]);
         _rectArray.push([_loc4_ + _loc12_,-(_loc9_ + _loc13_),8,_loc17_,_loc14_]);
         setVertexData();
      }
      
      public function writeScaleData() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc13_:Array = null;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:Array = null;
         var _loc7_:Array = _rectArray;
         var _loc1_:int = int(_loc7_.length);
         var _loc5_:int = -1;
         _quadLen = _loc1_;
         _movementXYDataBytes.length = 0;
         _movementUVDataBytes.length = 0;
         _movementXYDataBytes.position = 0;
         _movementUVDataBytes.position = 0;
         while(++_loc5_ < _loc1_)
         {
            _loc13_ = _loc7_[_loc5_];
            _loc11_ = int(_loc13_[0]);
            _loc9_ = int(_loc13_[1]);
            _loc8_ = int(_loc13_[2]);
            _loc12_ = _scaleArray[_loc8_];
            _loc2_ = _loc12_[2] * _loc13_[3];
            _loc4_ = _loc12_[3] * _loc13_[4];
            if(_loc2_ == 0 || _loc4_ == 0)
            {
               _quadLen = _quadLen - 1;
            }
            else
            {
               _movementXYDataBytes.writeFloat(_loc11_);
               _movementXYDataBytes.writeFloat(_loc9_);
               _movementXYDataBytes.writeFloat(_loc11_ + _loc2_);
               _movementXYDataBytes.writeFloat(_loc9_);
               _movementXYDataBytes.writeFloat(_loc11_ + _loc2_);
               _movementXYDataBytes.writeFloat(_loc9_ - _loc4_);
               _movementXYDataBytes.writeFloat(_loc11_);
               _movementXYDataBytes.writeFloat(_loc9_ - _loc4_);
               _movementUVDataBytes.writeFloat(_loc12_[0] / textureWidth);
               _movementUVDataBytes.writeFloat(_loc12_[1] / textureHeight);
               _movementUVDataBytes.writeFloat((_loc12_[0] + _loc2_) / textureWidth);
               _movementUVDataBytes.writeFloat(_loc12_[1] / textureHeight);
               _movementUVDataBytes.writeFloat((_loc12_[0] + _loc2_) / textureWidth);
               _movementUVDataBytes.writeFloat((_loc12_[1] + _loc4_) / textureHeight);
               _movementUVDataBytes.writeFloat(_loc12_[0] / textureWidth);
               _movementUVDataBytes.writeFloat((_loc12_[1] + _loc4_) / textureHeight);
            }
         }
         _renderLength = _quadLen * 4 * 2 * 4;
         clearSrcStream();
         updateBounds();
      }
      
      override public function writeController(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:uint, param5:RenderContainerData = null) : void
      {
         if(isDispose)
         {
            trace("你的代码中ImageData已经释放{invalid_utf8=239}{invalid_utf8=188}? 但是还在舞台上， 请检查代码， 确保先移除再释放ImageData",_name);
            return;
         }
         updatePipeSize(_renderLength);
         _controlstreamController[_controlstreamControllerIndex[2]] += 1;
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
         _controlStreamBytes.writeUnsignedInt(11);
         _controlStreamBytes.writeUnsignedInt(1);
         _controlStreamBytes.writeUnsignedInt(2 * _quadLen);
         _controlStreamBytes.writeUnsignedInt(6 * _quadLen);
         _vertexXYStream.writeBytes(_movementXYDataBytes);
         _vertexUVStream.writeBytes(_movementUVDataBytes);
      }
      
      public function get textureIndex() : uint
      {
         return _textureIndex;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

