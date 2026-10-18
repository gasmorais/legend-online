package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.utils.ByteArray;
   
   use namespace speedBones_internal;
   
   public class ParticleData extends DisplayData
   {
      
      private var _renderIndex:uint;
      
      public function ParticleData(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:Vector.<uint>, param5:Vector.<uint>)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function writeController(param1:ByteArray, param2:ByteArray, param3:ByteArray, param4:uint, param5:RenderContainerData = null) : void
      {
         if(isDispose)
         {
            trace("你的代码中ParticleData已经释放{invalid_utf8=239}{invalid_utf8=188}? 但是还在舞台上， 请检查代码， 确保先移除再释放ParticleData",_name);
            return;
         }
         var _loc6_:uint = _controlstreamControllerIndex[2];
         var _loc7_:Number = _controlstreamController[_loc6_] + 1;
         _controlstreamController[_loc6_] = _loc7_;
         _controlStreamBytes.writeUnsignedInt(18);
         _controlStreamBytes.writeUnsignedInt(_renderIndex);
      }
      
      public function get renderIndex() : uint
      {
         return _renderIndex;
      }
      
      speedBones_internal function set renderIndex(param1:uint) : void
      {
         _renderIndex = param1;
      }
   }
}

