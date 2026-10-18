package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarShopMsg extends Message implements IExternalizable
   {
      
      private var good_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var result$field:int;
      
      public function StarShopMsg()
      {
         super();
      }
      
      public function removeGoodId() : void
      {
         hasField$0 &= 4294967294;
         good_id$field = new int();
      }
      
      public function get hasGoodId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set goodId(param1:int) : void
      {
         hasField$0 |= 1;
         good_id$field = param1;
      }
      
      public function get goodId() : int
      {
         return good_id$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967293;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 2;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGoodId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,good_id$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,result$field);
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
                     throw new IOError("Bad data format: StarShopMsg.goodId cannot be set twice.");
                  }
                  _loc3_++;
                  goodId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarShopMsg.result cannot be set twice.");
                  }
                  _loc4_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

