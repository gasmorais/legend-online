package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoReward extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var card_id$field:int;
      
      private var amount$field:int;
      
      private var reward$field:int;
      
      private var rank$field:int;
      
      public function BingoReward()
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
      
      public function removeCardId() : void
      {
         hasField$0 &= 4294967293;
         card_id$field = new int();
      }
      
      public function get hasCardId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set cardId(param1:int) : void
      {
         hasField$0 |= 2;
         card_id$field = param1;
      }
      
      public function get cardId() : int
      {
         return card_id$field;
      }
      
      public function removeAmount() : void
      {
         hasField$0 &= 4294967291;
         amount$field = new int();
      }
      
      public function get hasAmount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set amount(param1:int) : void
      {
         hasField$0 |= 4;
         amount$field = param1;
      }
      
      public function get amount() : int
      {
         return amount$field;
      }
      
      public function removeReward() : void
      {
         hasField$0 &= 4294967287;
         reward$field = new int();
      }
      
      public function get hasReward() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set reward(param1:int) : void
      {
         hasField$0 |= 8;
         reward$field = param1;
      }
      
      public function get reward() : int
      {
         return reward$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967279;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 16;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasCardId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,card_id$field);
         }
         if(hasAmount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,amount$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,reward$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BingoReward.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BingoReward.cardId cannot be set twice.");
                  }
                  _loc8_++;
                  cardId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BingoReward.amount cannot be set twice.");
                  }
                  _loc6_++;
                  amount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BingoReward.reward cannot be set twice.");
                  }
                  _loc4_++;
                  reward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BingoReward.rank cannot be set twice.");
                  }
                  _loc3_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

