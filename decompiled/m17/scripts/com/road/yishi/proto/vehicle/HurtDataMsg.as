package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HurtDataMsg extends Message implements IExternalizable
   {
      
      private var affecteId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var value$field:int;
      
      public function HurtDataMsg()
      {
         super();
      }
      
      public function removeAffecteId() : void
      {
         hasField$0 &= 4294967294;
         affecteId$field = new int();
      }
      
      public function get hasAffecteId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set affecteId(param1:int) : void
      {
         hasField$0 |= 1;
         affecteId$field = param1;
      }
      
      public function get affecteId() : int
      {
         return affecteId$field;
      }
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967293;
         value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 2;
         value$field = param1;
      }
      
      public function get value() : int
      {
         return value$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAffecteId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,affecteId$field);
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,value$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HurtDataMsg.affecteId cannot be set twice.");
                  }
                  _loc3_++;
                  affecteId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HurtDataMsg.value cannot be set twice.");
                  }
                  _loc5_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

