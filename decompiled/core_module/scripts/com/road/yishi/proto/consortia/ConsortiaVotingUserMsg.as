package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaVotingUserMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var voting_id$field:int;
      
      private var is_votingman$field:Boolean;
      
      private var votingTime$field:int;
      
      private var votingData$field:int;
      
      public function ConsortiaVotingUserMsg()
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
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeVotingId() : void
      {
         hasField$0 &= 4294967293;
         voting_id$field = new int();
      }
      
      public function get hasVotingId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set votingId(param1:int) : void
      {
         hasField$0 |= 2;
         voting_id$field = param1;
      }
      
      public function get votingId() : int
      {
         return voting_id$field;
      }
      
      public function removeIsVotingman() : void
      {
         hasField$0 &= 4294967291;
         is_votingman$field = new Boolean();
      }
      
      public function get hasIsVotingman() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isVotingman(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_votingman$field = param1;
      }
      
      public function get isVotingman() : Boolean
      {
         return is_votingman$field;
      }
      
      public function removeVotingTime() : void
      {
         hasField$0 &= 4294967287;
         votingTime$field = new int();
      }
      
      public function get hasVotingTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set votingTime(param1:int) : void
      {
         hasField$0 |= 8;
         votingTime$field = param1;
      }
      
      public function get votingTime() : int
      {
         return votingTime$field;
      }
      
      public function removeVotingData() : void
      {
         hasField$0 &= 4294967279;
         votingData$field = new int();
      }
      
      public function get hasVotingData() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set votingData(param1:int) : void
      {
         hasField$0 |= 16;
         votingData$field = param1;
      }
      
      public function get votingData() : int
      {
         return votingData$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasVotingId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,voting_id$field);
         }
         if(hasIsVotingman)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_votingman$field);
         }
         if(hasVotingTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,votingTime$field);
         }
         if(hasVotingData)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,votingData$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaVotingUserMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaVotingUserMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaVotingUserMsg.votingId cannot be set twice.");
                  }
                  _loc9_++;
                  votingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaVotingUserMsg.isVotingman cannot be set twice.");
                  }
                  _loc3_++;
                  isVotingman = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaVotingUserMsg.votingTime cannot be set twice.");
                  }
                  _loc5_++;
                  votingTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaVotingUserMsg.votingData cannot be set twice.");
                  }
                  _loc8_++;
                  votingData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

