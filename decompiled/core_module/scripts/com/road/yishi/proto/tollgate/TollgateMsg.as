package com.road.yishi.proto.tollgate
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TollgateMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var end_time$field:String;
      
      private var order$field:int;
      
      private var score$field:int;
      
      private var remain_count$field:int;
      
      private var remain_time$field:int;
      
      [ArrayElementType("com.road.yishi.proto.tollgate.ChallengeMsg")]
      public var challengeInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.tollgate.ChallengeScoreMsg")]
      public var scoreInfo:Array = [];
      
      private var isOpen$field:Boolean;
      
      private var cur_tollgate_id$field:int;
      
      private var lucky_reward$field:String;
      
      private var remain_buy_count$field:int;
      
      private var start_time$field:String;
      
      private var add_time_count$field:int;
      
      public function TollgateMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeEndTime() : void
      {
         end_time$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return end_time$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
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
      
      public function removeRemainCount() : void
      {
         hasField$0 &= 4294967279;
         remain_count$field = new int();
      }
      
      public function get hasRemainCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set remainCount(param1:int) : void
      {
         hasField$0 |= 16;
         remain_count$field = param1;
      }
      
      public function get remainCount() : int
      {
         return remain_count$field;
      }
      
      public function removeRemainTime() : void
      {
         hasField$0 &= 4294967263;
         remain_time$field = new int();
      }
      
      public function get hasRemainTime() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set remainTime(param1:int) : void
      {
         hasField$0 |= 32;
         remain_time$field = param1;
      }
      
      public function get remainTime() : int
      {
         return remain_time$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967231;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeCurTollgateId() : void
      {
         hasField$0 &= 4294967167;
         cur_tollgate_id$field = new int();
      }
      
      public function get hasCurTollgateId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set curTollgateId(param1:int) : void
      {
         hasField$0 |= 128;
         cur_tollgate_id$field = param1;
      }
      
      public function get curTollgateId() : int
      {
         return cur_tollgate_id$field;
      }
      
      public function removeLuckyReward() : void
      {
         lucky_reward$field = null;
      }
      
      public function get hasLuckyReward() : Boolean
      {
         return lucky_reward$field != null;
      }
      
      public function set luckyReward(param1:String) : void
      {
         lucky_reward$field = param1;
      }
      
      public function get luckyReward() : String
      {
         return lucky_reward$field;
      }
      
      public function removeRemainBuyCount() : void
      {
         hasField$0 &= 4294967039;
         remain_buy_count$field = new int();
      }
      
      public function get hasRemainBuyCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set remainBuyCount(param1:int) : void
      {
         hasField$0 |= 256;
         remain_buy_count$field = param1;
      }
      
      public function get remainBuyCount() : int
      {
         return remain_buy_count$field;
      }
      
      public function removeStartTime() : void
      {
         start_time$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return start_time$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         start_time$field = param1;
      }
      
      public function get startTime() : String
      {
         return start_time$field;
      }
      
      public function removeAddTimeCount() : void
      {
         hasField$0 &= 4294966783;
         add_time_count$field = new int();
      }
      
      public function get hasAddTimeCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set addTimeCount(param1:int) : void
      {
         hasField$0 |= 512;
         add_time_count$field = param1;
      }
      
      public function get addTimeCount() : int
      {
         return add_time_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasRemainCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,remain_count$field);
         }
         if(hasRemainTime)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,remain_time$field);
         }
         _loc3_ = 0;
         while(_loc3_ < challengeInfo.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,challengeInfo[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < scoreInfo.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,scoreInfo[_loc2_]);
            _loc2_++;
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasCurTollgateId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,cur_tollgate_id$field);
         }
         if(hasLuckyReward)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,lucky_reward$field);
         }
         if(hasRemainBuyCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,remain_buy_count$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasAddTimeCount)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,add_time_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc17_:ChallengeMsg = null;
         var _loc4_:ChallengeScoreMsg = null;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc18_:uint = 0;
         var _loc5_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.type cannot be set twice.");
                  }
                  _loc10_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.userId cannot be set twice.");
                  }
                  _loc15_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.endTime cannot be set twice.");
                  }
                  _loc9_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.order cannot be set twice.");
                  }
                  _loc13_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.score cannot be set twice.");
                  }
                  _loc18_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.remainCount cannot be set twice.");
                  }
                  _loc5_++;
                  remainCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.remainTime cannot be set twice.");
                  }
                  _loc14_++;
                  remainTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc17_ = new ChallengeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc17_);
                  challengeInfo.push(_loc17_);
                  break;
               case 8:
                  _loc4_ = new ChallengeScoreMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  scoreInfo.push(_loc4_);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.isOpen cannot be set twice.");
                  }
                  _loc12_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.curTollgateId cannot be set twice.");
                  }
                  _loc3_++;
                  curTollgateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.luckyReward cannot be set twice.");
                  }
                  _loc6_++;
                  luckyReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.remainBuyCount cannot be set twice.");
                  }
                  _loc11_++;
                  remainBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.startTime cannot be set twice.");
                  }
                  _loc7_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TollgateMsg.addTimeCount cannot be set twice.");
                  }
                  _loc8_++;
                  addTimeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

