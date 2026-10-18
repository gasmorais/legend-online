package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetChallengePlayerMsg extends Message implements IExternalizable
   {
      
      private var left_time$field:int;
      
      private var hasField$0:uint = 0;
      
      private var challenge_count$field:int;
      
      private var total_count$field:int;
      
      private var score$field:int;
      
      private var order$field:int;
      
      public function PetChallengePlayerMsg()
      {
         super();
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967294;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 1;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeChallengeCount() : void
      {
         hasField$0 &= 4294967293;
         challenge_count$field = new int();
      }
      
      public function get hasChallengeCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set challengeCount(param1:int) : void
      {
         hasField$0 |= 2;
         challenge_count$field = param1;
      }
      
      public function get challengeCount() : int
      {
         return challenge_count$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967291;
         total_count$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 4;
         total_count$field = param1;
      }
      
      public function get totalCount() : int
      {
         return total_count$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967287;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 8;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967279;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 16;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasChallengeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,challenge_count$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,total_count$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,order$field);
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
                     throw new IOError("Bad data format: PetChallengePlayerMsg.leftTime cannot be set twice.");
                  }
                  _loc5_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PetChallengePlayerMsg.challengeCount cannot be set twice.");
                  }
                  _loc7_++;
                  challengeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetChallengePlayerMsg.totalCount cannot be set twice.");
                  }
                  _loc3_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PetChallengePlayerMsg.score cannot be set twice.");
                  }
                  _loc8_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetChallengePlayerMsg.order cannot be set twice.");
                  }
                  _loc4_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

