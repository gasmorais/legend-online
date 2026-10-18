package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarEnergyListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.campaign.WarEnergyMsg")]
      public var energy:Array = [];
      
      public function WarEnergyListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < energy.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,energy[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:WarEnergyMsg = null;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new WarEnergyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  energy.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

