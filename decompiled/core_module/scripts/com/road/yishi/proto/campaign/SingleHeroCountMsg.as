package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SingleHeroCountMsg extends Message implements IExternalizable
   {
      
      private var count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var buy_count$field:int;
      
      public function SingleHeroCountMsg()
      {
         super();
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967294;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 1;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967293;
         buy_count$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 2;
         buy_count$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buy_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,buy_count$field);
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
                     throw new IOError("Bad data format: SingleHeroCountMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SingleHeroCountMsg.buyCount cannot be set twice.");
                  }
                  _loc3_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

