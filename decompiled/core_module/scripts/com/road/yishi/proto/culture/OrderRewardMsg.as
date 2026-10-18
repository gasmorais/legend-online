package com.road.yishi.proto.culture
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OrderRewardMsg extends Message implements IExternalizable
   {
      
      private var order1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var order2$field:int;
      
      private var rewardItems$field:String;
      
      public function OrderRewardMsg()
      {
         super();
      }
      
      public function removeOrder1() : void
      {
         hasField$0 &= 4294967294;
         order1$field = new int();
      }
      
      public function get hasOrder1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set order1(param1:int) : void
      {
         hasField$0 |= 1;
         order1$field = param1;
      }
      
      public function get order1() : int
      {
         return order1$field;
      }
      
      public function removeOrder2() : void
      {
         hasField$0 &= 4294967293;
         order2$field = new int();
      }
      
      public function get hasOrder2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set order2(param1:int) : void
      {
         hasField$0 |= 2;
         order2$field = param1;
      }
      
      public function get order2() : int
      {
         return order2$field;
      }
      
      public function removeRewardItems() : void
      {
         rewardItems$field = null;
      }
      
      public function get hasRewardItems() : Boolean
      {
         return rewardItems$field != null;
      }
      
      public function set rewardItems(param1:String) : void
      {
         rewardItems$field = param1;
      }
      
      public function get rewardItems() : String
      {
         return rewardItems$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOrder1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order1$field);
         }
         if(hasOrder2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order2$field);
         }
         if(hasRewardItems)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,rewardItems$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OrderRewardMsg.order1 cannot be set twice.");
                  }
                  _loc3_++;
                  order1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OrderRewardMsg.order2 cannot be set twice.");
                  }
                  _loc6_++;
                  order2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OrderRewardMsg.rewardItems cannot be set twice.");
                  }
                  _loc4_++;
                  rewardItems = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

