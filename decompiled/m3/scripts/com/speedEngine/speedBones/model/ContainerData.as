package com.speedEngine.speedBones.model
{
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class ContainerData extends DisplayData
   {
      
      public function ContainerData(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:Vector.<uint>, param5:Vector.<uint>)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function writeController(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:uint, param5:RenderContainerData = null) : void
      {
         var _loc6_:uint = _controlstreamControllerIndex[2];
         var _loc7_:Number = _controlstreamController[_loc6_] + 1;
         _controlstreamController[_loc6_] = _loc7_;
         _controlStreamBytes.writeUnsignedInt(19);
         _controlStreamBytes.writeBytes(param1,0,16);
         _controlStreamBytes.writeUnsignedInt(param4);
         _controlStreamBytes.writeBytes(param3);
      }
      
      public function writeContainerController(param1:Rectangle) : void
      {
         var _loc2_:uint = _controlstreamControllerIndex[2];
         var _loc3_:Number = _controlstreamController[_loc2_] + 1;
         _controlstreamController[_loc2_] = _loc3_;
         _controlStreamBytes.writeUnsignedInt(20);
         _controlStreamBytes.writeFloat(int(param1.x - 10));
         _controlStreamBytes.writeFloat(int(param1.y - 15));
         _controlStreamBytes.writeFloat(int(param1.width + 20));
         _controlStreamBytes.writeFloat(int(param1.height + 30));
      }
   }
}

