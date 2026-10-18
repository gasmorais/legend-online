package com.road.yishi.proto.planes
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesEnergyMsg extends Message implements IExternalizable
   {
      
      public var energy:int;
      
      public var countDown:Int64;
      
      public function PlanesEnergyMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,energy);
         WriteUtils.writeTag(param1,0,2);
         WriteUtils.write$TYPE_INT64(param1,countDown);
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesEnergyMsg.energy cannot be set twice.");
                  }
                  _loc5_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesEnergyMsg.countDown cannot be set twice.");
                  }
                  _loc3_++;
                  countDown = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
         if(_loc5_ != 1)
         {
            throw new IOError("Bad data format: PlanesEnergyMsg.energy must be set.");
         }
         if(_loc3_ != 1)
         {
            throw new IOError("Bad data format: PlanesEnergyMsg.countDown must be set.");
         }
      }
   }
}

