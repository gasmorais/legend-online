package com.road.yishi.proto.building
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TransInfoMsg extends Message implements IExternalizable
   {
      
      private var current_energy$field:int;
      
      private var hasField$0:uint = 0;
      
      private var remain_time$field:int;
      
      public function TransInfoMsg()
      {
         super();
      }
      
      public function removeCurrentEnergy() : void
      {
         hasField$0 &= 4294967294;
         current_energy$field = new int();
      }
      
      public function get hasCurrentEnergy() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set currentEnergy(param1:int) : void
      {
         hasField$0 |= 1;
         current_energy$field = param1;
      }
      
      public function get currentEnergy() : int
      {
         return current_energy$field;
      }
      
      public function removeRemainTime() : void
      {
         hasField$0 &= 4294967293;
         remain_time$field = new int();
      }
      
      public function get hasRemainTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set remainTime(param1:int) : void
      {
         hasField$0 |= 2;
         remain_time$field = param1;
      }
      
      public function get remainTime() : int
      {
         return remain_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCurrentEnergy)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,current_energy$field);
         }
         if(hasRemainTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,remain_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TransInfoMsg.currentEnergy cannot be set twice.");
                  }
                  _loc4_++;
                  currentEnergy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TransInfoMsg.remainTime cannot be set twice.");
                  }
                  _loc3_++;
                  remainTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

