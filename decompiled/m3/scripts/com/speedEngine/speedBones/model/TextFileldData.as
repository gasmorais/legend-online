package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.manager.RenderManager;
   import com.speedEngine.speedBones.manager.TextFieldManager;
   import com.speedEngine.speedBones.textures.SpeedTexture;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class TextFileldData extends DisplayData
   {
      
      private var _indexArray:Array = [];
      
      private var _size:int;
      
      private var _imageSize:Number;
      
      private var _renderLength:uint;
      
      private var _textureIndex:int = -1;
      
      private var _quadLen:int;
      
      public function TextFileldData(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:Vector.<uint>, param5:Vector.<uint>)
      {
         super(param1,param2,param3,param4,param5);
         _size = TextFieldManager.WORD_SIZE;
         _imageSize = TextFieldManager.IMAGE_SIZE;
      }
      
      public function setText(param1:String) : void
      {
         if(isDispose)
         {
            return;
         }
         _indexArray = TextFieldManager.instance.getIndexArray(param1);
         _textureIndex = TextFieldManager.instance.textureIndex;
         _quadLen = _indexArray.length;
         changeData();
      }
      
      public function setBitmapData(param1:BitmapData) : void
      {
         var _loc3_:SpeedTexture = null;
         var _loc4_:int = param1.width;
         var _loc2_:int = param1.height;
         if(_textureIndex != TextFieldManager.instance.textureIndex && _textureIndex != -1)
         {
            RenderManager.instance.disposeTexture(_textureIndex);
         }
         _textureIndex = RenderManager.instance.createBitmapData(param1);
         _loc3_ = RenderManager.instance.getSpeedTexture(_textureIndex);
         _renderLength = 32;
         _quadLen = 1;
         _movementXYDataBytes.length = _renderLength;
         _movementUVDataBytes.length = _renderLength;
         _movementXYDataBytes.position = 0;
         _movementUVDataBytes.position = 0;
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(_loc4_);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(_loc4_);
         _movementXYDataBytes.writeFloat(-_loc2_);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(-_loc2_);
         _movementUVDataBytes.position = 0;
         _movementUVDataBytes.writeFloat(0);
         _movementUVDataBytes.writeFloat(0);
         _movementUVDataBytes.writeFloat(_loc4_ / _loc3_.textureWidth);
         _movementUVDataBytes.writeFloat(0);
         _movementUVDataBytes.writeFloat(_loc4_ / _loc3_.textureWidth);
         _movementUVDataBytes.writeFloat(_loc2_ / _loc3_.textureHeight);
         _movementUVDataBytes.writeFloat(0);
         _movementUVDataBytes.writeFloat(_loc2_ / _loc3_.textureHeight);
         updateBounds();
      }
      
      override protected function updateBounds() : void
      {
         getRect(0,_renderLength);
      }
      
      public function changeData() : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = int(_indexArray.length);
         var _loc5_:int = -1;
         _renderLength = _loc1_ * 4 * 2 * 4;
         _movementXYDataBytes.length = _renderLength;
         _movementUVDataBytes.length = _renderLength;
         _movementXYDataBytes.position = 0;
         _movementUVDataBytes.position = 0;
         _loc3_ = TextFieldManager.instance.leading;
         while(++_loc5_ < _loc1_)
         {
            _loc2_ = int(_indexArray[_loc5_][2]);
            _movementXYDataBytes.writeFloat(_loc3_);
            _movementXYDataBytes.writeFloat(0);
            _movementXYDataBytes.writeFloat(_loc3_ + _size);
            _movementXYDataBytes.writeFloat(0);
            _movementXYDataBytes.writeFloat(_loc3_ + _size);
            _movementXYDataBytes.writeFloat(-_size);
            _movementXYDataBytes.writeFloat(_loc3_);
            _movementXYDataBytes.writeFloat(-_size);
            _loc3_ += _loc2_;
         }
         _loc5_ = -1;
         while(++_loc5_ < _loc1_)
         {
            _loc6_ = _indexArray[_loc5_][1] * _size;
            _loc4_ = _indexArray[_loc5_][0] * _size;
            _movementUVDataBytes.writeFloat(_loc6_ / _imageSize);
            _movementUVDataBytes.writeFloat(_loc4_ / _imageSize);
            _movementUVDataBytes.writeFloat((_loc6_ + _size) / _imageSize);
            _movementUVDataBytes.writeFloat(_loc4_ / _imageSize);
            _movementUVDataBytes.writeFloat((_loc6_ + _size) / _imageSize);
            _movementUVDataBytes.writeFloat((_loc4_ + _size) / _imageSize);
            _movementUVDataBytes.writeFloat(_loc6_ / _imageSize);
            _movementUVDataBytes.writeFloat((_loc4_ + _size) / _imageSize);
         }
         updateBounds();
      }
      
      override public function writeController(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:uint, param5:RenderContainerData = null) : void
      {
         if(isDispose)
         {
            trace("你的代码中Textfield已经释放{invalid_utf8=239}{invalid_utf8=188}? 但是还在舞台上， 请检查代码， 确保先移除再释放Textfield",_name);
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
         _controlStreamBytes.writeUnsignedInt(_quadLen * 2);
         _controlStreamBytes.writeUnsignedInt(_quadLen * 6);
         _vertexXYStream.writeBytes(_movementXYDataBytes);
         _vertexUVStream.writeBytes(_movementUVDataBytes);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _indexArray = null;
      }
   }
}

