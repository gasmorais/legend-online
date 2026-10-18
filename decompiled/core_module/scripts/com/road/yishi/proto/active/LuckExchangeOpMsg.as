package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LuckExchangeOpMsg extends Message implements IExternalizable
   {
      
      private var exchange_id$field:String;
      
      private var exchange_count$field:int;
      
      private var hasField$0:uint = 0;
      
      public function LuckExchangeOpMsg()
      {
         super();
      }
      
      public function removeExchangeId() : void
      {
         exchange_id$field = null;
      }
      
      public function get hasExchangeId() : Boolean
      {
         return exchange_id$field != null;
      }
      
      public function set exchangeId(param1:String) : void
      {
         exchange_id$field = param1;
      }
      
      public function get exchangeId() : String
      {
         return exchange_id$field;
      }
      
      public function removeExchangeCount() : void
      {
         hasField$0 &= 4294967294;
         exchange_count$field = new int();
      }
      
      public function get hasExchangeCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set exchangeCount(param1:int) : void
      {
         hasField$0 |= 1;
         exchange_count$field = param1;
      }
      
      public function get exchangeCount() : int
      {
         return exchange_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasExchangeId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,exchange_id$field);
         }
         if(hasExchangeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,exchange_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeOpMsg.exchangeId cannot be set twice.");
                  }
                  _loc3_++;
                  exchangeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeOpMsg.exchangeCount cannot be set twice.");
                  }
                  _loc4_++;
                  exchangeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

