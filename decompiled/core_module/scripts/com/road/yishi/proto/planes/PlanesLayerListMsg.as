package com.road.yishi.proto.planes
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesLayerListMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      [ArrayElementType("com.road.yishi.proto.planes.PlanesLayerInfoMsg")]
      public var layerList:Array = [];
      
      public function PlanesLayerListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         _loc2_ = 0;
         while(_loc2_ < layerList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,layerList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc5_:PlanesLayerInfoMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesLayerListMsg.op cannot be set twice.");
                  }
                  _loc4_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new PlanesLayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  layerList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
         if(_loc4_ != 1)
         {
            throw new IOError("Bad data format: PlanesLayerListMsg.op must be set.");
         }
      }
   }
}

