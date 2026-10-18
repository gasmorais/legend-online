package com.road.yishi.proto.blackjack
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BlackJackBoardMsg extends Message implements IExternalizable
   {
      
      private var reward_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var bankerCard:Array = [];
      
      [ArrayElementType("int")]
      public var playerCard:Array = [];
      
      private var stoped$field:Boolean;
      
      public function BlackJackBoardMsg()
      {
         super();
      }
      
      public function removeRewardId() : void
      {
         hasField$0 &= 4294967294;
         reward_id$field = new int();
      }
      
      public function get hasRewardId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardId(param1:int) : void
      {
         hasField$0 |= 1;
         reward_id$field = param1;
      }
      
      public function get rewardId() : int
      {
         return reward_id$field;
      }
      
      public function removeStoped() : void
      {
         hasField$0 &= 4294967293;
         stoped$field = new Boolean();
      }
      
      public function get hasStoped() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set stoped(param1:Boolean) : void
      {
         hasField$0 |= 2;
         stoped$field = param1;
      }
      
      public function get stoped() : Boolean
      {
         return stoped$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasRewardId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,reward_id$field);
         }
         _loc3_ = 0;
         while(_loc3_ < bankerCard.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bankerCard[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < playerCard.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,playerCard[_loc2_]);
            _loc2_++;
         }
         if(hasStoped)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,stoped$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackBoardMsg.rewardId cannot be set twice.");
                  }
                  _loc4_++;
                  rewardId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,bankerCard);
                  }
                  else
                  {
                     bankerCard.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,playerCard);
                  }
                  else
                  {
                     playerCard.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackBoardMsg.stoped cannot be set twice.");
                  }
                  _loc5_++;
                  stoped = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

