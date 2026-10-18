package com.road.yishi.proto.guardpvp
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GuardPvpListMsg extends Message implements IExternalizable
   {
      
      private var guardPvpOp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var eventId$field:int;
      
      private var uuid$field:String;
      
      private var userId$field:int;
      
      private var serverId$field:int;
      
      private var isSign$field:Boolean;
      
      private var status$field:int;
      
      private var nextFightTime$field:String;
      
      private var betWinCount$field:int;
      
      private var teamType$field:int;
      
      private var autoTeamType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.guardpvp.GuardPvpInfoMsg")]
      public var info:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.guardpvp.GuardPvpPosMsg")]
      public var guardPos:Array = [];
      
      private var hasReward$field:Boolean;
      
      private var currentTurn$field:int;
      
      public function GuardPvpListMsg()
      {
         super();
      }
      
      public function removeGuardPvpOp() : void
      {
         hasField$0 &= 4294967294;
         guardPvpOp$field = new int();
      }
      
      public function get hasGuardPvpOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set guardPvpOp(param1:int) : void
      {
         hasField$0 |= 1;
         guardPvpOp$field = param1;
      }
      
      public function get guardPvpOp() : int
      {
         return guardPvpOp$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967293;
         eventId$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 2;
         eventId$field = param1;
      }
      
      public function get eventId() : int
      {
         return eventId$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294967287;
         serverId$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 8;
         serverId$field = param1;
      }
      
      public function get serverId() : int
      {
         return serverId$field;
      }
      
      public function removeIsSign() : void
      {
         hasField$0 &= 4294967279;
         isSign$field = new Boolean();
      }
      
      public function get hasIsSign() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isSign(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isSign$field = param1;
      }
      
      public function get isSign() : Boolean
      {
         return isSign$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967263;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 32;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      public function removeNextFightTime() : void
      {
         nextFightTime$field = null;
      }
      
      public function get hasNextFightTime() : Boolean
      {
         return nextFightTime$field != null;
      }
      
      public function set nextFightTime(param1:String) : void
      {
         nextFightTime$field = param1;
      }
      
      public function get nextFightTime() : String
      {
         return nextFightTime$field;
      }
      
      public function removeBetWinCount() : void
      {
         hasField$0 &= 4294967231;
         betWinCount$field = new int();
      }
      
      public function get hasBetWinCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set betWinCount(param1:int) : void
      {
         hasField$0 |= 64;
         betWinCount$field = param1;
      }
      
      public function get betWinCount() : int
      {
         return betWinCount$field;
      }
      
      public function removeTeamType() : void
      {
         hasField$0 &= 4294967167;
         teamType$field = new int();
      }
      
      public function get hasTeamType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set teamType(param1:int) : void
      {
         hasField$0 |= 128;
         teamType$field = param1;
      }
      
      public function get teamType() : int
      {
         return teamType$field;
      }
      
      public function removeAutoTeamType() : void
      {
         hasField$0 &= 4294967039;
         autoTeamType$field = new int();
      }
      
      public function get hasAutoTeamType() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set autoTeamType(param1:int) : void
      {
         hasField$0 |= 256;
         autoTeamType$field = param1;
      }
      
      public function get autoTeamType() : int
      {
         return autoTeamType$field;
      }
      
      public function removeHasReward() : void
      {
         hasField$0 &= 4294966783;
         hasReward$field = new Boolean();
      }
      
      public function get hasHasReward() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set hasReward(param1:Boolean) : void
      {
         hasField$0 |= 512;
         hasReward$field = param1;
      }
      
      public function get hasReward() : Boolean
      {
         return hasReward$field;
      }
      
      public function removeCurrentTurn() : void
      {
         hasField$0 &= 4294966271;
         currentTurn$field = new int();
      }
      
      public function get hasCurrentTurn() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set currentTurn(param1:int) : void
      {
         hasField$0 |= 1024;
         currentTurn$field = param1;
      }
      
      public function get currentTurn() : int
      {
         return currentTurn$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasGuardPvpOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,guardPvpOp$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,eventId$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,serverId$field);
         }
         if(hasIsSign)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isSign$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
         if(hasNextFightTime)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,nextFightTime$field);
         }
         if(hasBetWinCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,betWinCount$field);
         }
         if(hasTeamType)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,teamType$field);
         }
         if(hasAutoTeamType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,autoTeamType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < guardPos.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,guardPos[_loc3_]);
            _loc3_++;
         }
         if(hasHasReward)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,hasReward$field);
         }
         if(hasCurrentTurn)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,currentTurn$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc12_:GuardPvpInfoMsg = null;
         var _loc18_:GuardPvpPosMsg = null;
         var _loc16_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.guardPvpOp cannot be set twice.");
                  }
                  _loc16_++;
                  guardPvpOp = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.eventId cannot be set twice.");
                  }
                  _loc13_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.uuid cannot be set twice.");
                  }
                  _loc9_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.serverId cannot be set twice.");
                  }
                  _loc8_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.isSign cannot be set twice.");
                  }
                  _loc4_++;
                  isSign = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.status cannot be set twice.");
                  }
                  _loc7_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.nextFightTime cannot be set twice.");
                  }
                  _loc11_++;
                  nextFightTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.betWinCount cannot be set twice.");
                  }
                  _loc14_++;
                  betWinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.teamType cannot be set twice.");
                  }
                  _loc3_++;
                  teamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.autoTeamType cannot be set twice.");
                  }
                  _loc17_++;
                  autoTeamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  _loc12_ = new GuardPvpInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc12_);
                  info.push(_loc12_);
                  break;
               case 12:
                  _loc18_ = new GuardPvpPosMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc18_);
                  guardPos.push(_loc18_);
                  break;
               case 13:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.hasReward cannot be set twice.");
                  }
                  _loc10_++;
                  hasReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpListMsg.currentTurn cannot be set twice.");
                  }
                  _loc5_++;
                  currentTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

