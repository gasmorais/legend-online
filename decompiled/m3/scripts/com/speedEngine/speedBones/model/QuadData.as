package com.speedEngine.speedBones.model
{
   import flash.utils.ByteArray;
   
   public class QuadData extends DisplayData
   {
      
      private const renderLength:uint = 32;
      
      private var _movementARGBDataBytes:ByteArray;
      
      public function QuadData(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:Vector.<uint>, param5:Vector.<uint>)
      {
         super(param1,param2,param3,param4,param5);
         _movementARGBDataBytes = new ByteArray();
         _movementARGBDataBytes.endian = "littleEndian";
      }
      
      public function setVertexData(param1:int, param2:int, param3:uint) : void
      {
         _movementXYDataBytes.length = 32;
         _movementARGBDataBytes.length = 16;
         _movementXYDataBytes.position = 0;
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(param1);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(param1);
         _movementXYDataBytes.writeFloat(-param2);
         _movementXYDataBytes.writeFloat(0);
         _movementXYDataBytes.writeFloat(-param2);
         _movementUVDataBytes.length = 32;
         _movementARGBDataBytes.writeFloat((param3 >> 16 & 0xFF) / 255);
         _movementARGBDataBytes.writeFloat((param3 >> 8 & 0xFF) / 255);
         _movementARGBDataBytes.writeFloat((param3 & 0xFF) / 255);
         _movementARGBDataBytes.writeFloat(1);
         updateBounds();
      }
      
      override protected function updateBounds() : void
      {
         getRect(0,32);
      }
      
      override public function writeController(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:uint, param5:RenderContainerData = null) : void
      {
         if(isDispose)
         {
            trace("你的代码中QuadData已经释放{invalid_utf8=239}{invalid_utf8=188}? 但是还在舞台上， 请检查代码， 确保先移除再释放QuadData",_name);
            return;
         }
         updatePipeSize(32);
         _controlstreamController[_controlstreamControllerIndex[2]] += 1;
         _controlStreamBytes.writeUnsignedInt(17);
         _controlStreamBytes.writeUnsignedInt(1);
         _controlStreamBytes.writeBytes(param1,0,36);
         _controlStreamBytes.writeBytes(_movementARGBDataBytes);
         _controlStreamBytes.writeUnsignedInt(2);
         _controlStreamBytes.writeUnsignedInt(6);
         _vertexXYStream.writeBytes(_movementXYDataBytes);
         _vertexUVStream.writeBytes(_movementUVDataBytes);
      }
   }
}

