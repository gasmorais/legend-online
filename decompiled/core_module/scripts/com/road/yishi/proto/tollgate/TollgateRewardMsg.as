package com.road.yishi.proto.tollgate
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TollgateRewardMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var order$field:int;
      
      private var score_items$field:String;
      
      private var lucky_items$field:String;
      
      public function TollgateRewardMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967291;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 4;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeScoreItems() : void
      {
         score_items$field = null;
      }
      
      public function get hasScoreItems() : Boolean
      {
         return score_items$field != null;
      }
      
      public function set scoreItems(param1:String) : void
      {
         score_items$field = param1;
      }
      
      public function get scoreItems() : String
      {
         return score_items$field;
      }
      
      public function removeLuckyItems() : void
      {
         lucky_items$field = null;
      }
      
      public function get hasLuckyItems() : Boolean
      {
         return lucky_items$field != null;
      }
      
      public function set luckyItems(param1:String) : void
      {
         lucky_items$field = param1;
      }
      
      public function get luckyItems() : String
      {
         return lucky_items$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasScoreItems)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,score_items$field);
         }
         if(hasLuckyItems)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,lucky_items$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateRewardMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateRewardMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateRewardMsg.order cannot be set twice.");
                  }
                  _loc3_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateRewardMsg.scoreItems cannot be set twice.");
                  }
                  _loc8_++;
                  scoreItems = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateRewardMsg.luckyItems cannot be set twice.");
                  }
                  _loc4_++;
                  luckyItems = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

