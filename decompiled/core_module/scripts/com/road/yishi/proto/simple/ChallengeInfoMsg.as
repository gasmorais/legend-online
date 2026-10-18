package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChallengeInfoMsg extends Message implements IExternalizable
   {
      
      private var last_winCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var challengeCount$field:int;
      
      private var cur_rank$field:int;
      
      [ArrayElementType("com.road.yishi.proto.simple.SimplePlayerInfoMsg")]
      public var simplePlayer:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.simple.ChallengeLogMsg")]
      public var challengeLog:Array = [];
      
      private var notic_msg$field:String;
      
      [ArrayElementType("com.road.yishi.proto.simple.AvaterMsg")]
      public var avater:Array = [];
      
      private var left_day$field:int;
      
      private var total_count$field:int;
      
      private var total_buyCount$field:int;
      
      public function ChallengeInfoMsg()
      {
         super();
      }
      
      public function removeLastWinCount() : void
      {
         hasField$0 &= 4294967294;
         last_winCount$field = new int();
      }
      
      public function get hasLastWinCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set lastWinCount(param1:int) : void
      {
         hasField$0 |= 1;
         last_winCount$field = param1;
      }
      
      public function get lastWinCount() : int
      {
         return last_winCount$field;
      }
      
      public function removeChallengeCount() : void
      {
         hasField$0 &= 4294967293;
         challengeCount$field = new int();
      }
      
      public function get hasChallengeCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set challengeCount(param1:int) : void
      {
         hasField$0 |= 2;
         challengeCount$field = param1;
      }
      
      public function get challengeCount() : int
      {
         return challengeCount$field;
      }
      
      public function removeCurRank() : void
      {
         hasField$0 &= 4294967291;
         cur_rank$field = new int();
      }
      
      public function get hasCurRank() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curRank(param1:int) : void
      {
         hasField$0 |= 4;
         cur_rank$field = param1;
      }
      
      public function get curRank() : int
      {
         return cur_rank$field;
      }
      
      public function removeNoticMsg() : void
      {
         notic_msg$field = null;
      }
      
      public function get hasNoticMsg() : Boolean
      {
         return notic_msg$field != null;
      }
      
      public function set noticMsg(param1:String) : void
      {
         notic_msg$field = param1;
      }
      
      public function get noticMsg() : String
      {
         return notic_msg$field;
      }
      
      public function removeLeftDay() : void
      {
         hasField$0 &= 4294967287;
         left_day$field = new int();
      }
      
      public function get hasLeftDay() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftDay(param1:int) : void
      {
         hasField$0 |= 8;
         left_day$field = param1;
      }
      
      public function get leftDay() : int
      {
         return left_day$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967279;
         total_count$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 16;
         total_count$field = param1;
      }
      
      public function get totalCount() : int
      {
         return total_count$field;
      }
      
      public function removeTotalBuyCount() : void
      {
         hasField$0 &= 4294967263;
         total_buyCount$field = new int();
      }
      
      public function get hasTotalBuyCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set totalBuyCount(param1:int) : void
      {
         hasField$0 |= 32;
         total_buyCount$field = param1;
      }
      
      public function get totalBuyCount() : int
      {
         return total_buyCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         if(hasLastWinCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,last_winCount$field);
         }
         if(hasChallengeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,challengeCount$field);
         }
         if(hasCurRank)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cur_rank$field);
         }
         _loc3_ = 0;
         while(_loc3_ < simplePlayer.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,simplePlayer[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < challengeLog.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,challengeLog[_loc4_]);
            _loc4_++;
         }
         if(hasNoticMsg)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,notic_msg$field);
         }
         _loc2_ = 0;
         while(_loc2_ < avater.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,avater[_loc2_]);
            _loc2_++;
         }
         if(hasLeftDay)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,left_day$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,total_count$field);
         }
         if(hasTotalBuyCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,total_buyCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc8_:SimplePlayerInfoMsg = null;
         var _loc4_:ChallengeLogMsg = null;
         var _loc11_:AvaterMsg = null;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeInfoMsg.lastWinCount cannot be set twice.");
                  }
                  _loc9_++;
                  lastWinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeInfoMsg.challengeCount cannot be set twice.");
                  }
                  _loc3_++;
                  challengeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeInfoMsg.curRank cannot be set twice.");
                  }
                  _loc5_++;
                  curRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc8_ = new SimplePlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  simplePlayer.push(_loc8_);
                  break;
               case 4:
                  _loc4_ = new ChallengeLogMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  challengeLog.push(_loc4_);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeInfoMsg.noticMsg cannot be set twice.");
                  }
                  _loc12_++;
                  noticMsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  _loc11_ = new AvaterMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  avater.push(_loc11_);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeInfoMsg.leftDay cannot be set twice.");
                  }
                  _loc10_++;
                  leftDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeInfoMsg.totalCount cannot be set twice.");
                  }
                  _loc6_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeInfoMsg.totalBuyCount cannot be set twice.");
                  }
                  _loc7_++;
                  totalBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

