package com.road.yishi.proto.universalActive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ExchangeReq extends Message implements IExternalizable
   {
      
      private var bag_id$field:int;
      
      private var hasField$0:uint = 0;
      
      public function ExchangeReq()
      {
         super();
      }
      
      public function removeBagId() : void
      {
         hasField$0 &= 4294967294;
         bag_id$field = new int();
      }
      
      public function get hasBagId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bagId(param1:int) : void
      {
         hasField$0 |= 1;
         bag_id$field = param1;
      }
      
      public function get bagId() : int
      {
         return bag_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBagId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bag_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ExchangeReq.bagId cannot be set twice.");
                  }
                  _loc3_++;
                  bagId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

