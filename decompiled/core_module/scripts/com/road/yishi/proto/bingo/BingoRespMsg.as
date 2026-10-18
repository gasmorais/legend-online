package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoRespMsg extends Message implements IExternalizable
   {
      
      private var result$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var data$field:ByteArray;
      
      public function BingoRespMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeData() : void
      {
         data$field = null;
      }
      
      public function get hasData() : Boolean
      {
         return data$field != null;
      }
      
      public function set data(param1:ByteArray) : void
      {
         data$field = param1;
      }
      
      public function get data() : ByteArray
      {
         return data$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasData)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_BYTES(param1,data$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 2)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRespMsg.result cannot be set twice.");
                  }
                  _loc3_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRespMsg.data cannot be set twice.");
                  }
                  _loc5_++;
                  data = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

