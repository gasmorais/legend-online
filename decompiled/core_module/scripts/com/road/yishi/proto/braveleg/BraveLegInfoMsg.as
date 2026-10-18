package com.road.yishi.proto.braveleg
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BraveLegInfoMsg extends Message implements IExternalizable
   {
      
      private var uid$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var headId$field:int;
      
      private var grades$field:int;
      
      private var fightPower$field:int;
      
      private var teamType$field:int;
      
      private var totalScore$field:int;
      
      private var rankOrder$field:int;
      
      private var season$field:int;
      
      private var groupId$field:int;
      
      private var isMaster$field:Boolean;
      
      private var orderTemp$field:int;
      
      private var sexJob$field:int;
      
      private var dayScore$field:int;
      
      private var lastTotalScore$field:int;
      
      private var result$field:int;
      
      private var lastWinCount$field:int;
      
      public function BraveLegInfoMsg()
      {
         super();
      }
      
      public function removeUid() : void
      {
         uid$field = null;
      }
      
      public function get hasUid() : Boolean
      {
         return uid$field != null;
      }
      
      public function set uid(param1:String) : void
      {
         uid$field = param1;
      }
      
      public function get uid() : String
      {
         return uid$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967293;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 2;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967291;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 4;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967287;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 8;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeTeamType() : void
      {
         hasField$0 &= 4294967279;
         teamType$field = new int();
      }
      
      public function get hasTeamType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set teamType(param1:int) : void
      {
         hasField$0 |= 16;
         teamType$field = param1;
      }
      
      public function get teamType() : int
      {
         return teamType$field;
      }
      
      public function removeTotalScore() : void
      {
         hasField$0 &= 4294967263;
         totalScore$field = new int();
      }
      
      public function get hasTotalScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set totalScore(param1:int) : void
      {
         hasField$0 |= 32;
         totalScore$field = param1;
      }
      
      public function get totalScore() : int
      {
         return totalScore$field;
      }
      
      public function removeRankOrder() : void
      {
         hasField$0 &= 4294967231;
         rankOrder$field = new int();
      }
      
      public function get hasRankOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set rankOrder(param1:int) : void
      {
         hasField$0 |= 64;
         rankOrder$field = param1;
      }
      
      public function get rankOrder() : int
      {
         return rankOrder$field;
      }
      
      public function removeSeason() : void
      {
         hasField$0 &= 4294967167;
         season$field = new int();
      }
      
      public function get hasSeason() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set season(param1:int) : void
      {
         hasField$0 |= 128;
         season$field = param1;
      }
      
      public function get season() : int
      {
         return season$field;
      }
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294967039;
         groupId$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 256;
         groupId$field = param1;
      }
      
      public function get groupId() : int
      {
         return groupId$field;
      }
      
      public function removeIsMaster() : void
      {
         hasField$0 &= 4294966783;
         isMaster$field = new Boolean();
      }
      
      public function get hasIsMaster() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isMaster(param1:Boolean) : void
      {
         hasField$0 |= 512;
         isMaster$field = param1;
      }
      
      public function get isMaster() : Boolean
      {
         return isMaster$field;
      }
      
      public function removeOrderTemp() : void
      {
         hasField$0 &= 4294966271;
         orderTemp$field = new int();
      }
      
      public function get hasOrderTemp() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set orderTemp(param1:int) : void
      {
         hasField$0 |= 1024;
         orderTemp$field = param1;
      }
      
      public function get orderTemp() : int
      {
         return orderTemp$field;
      }
      
      public function removeSexJob() : void
      {
         hasField$0 &= 4294965247;
         sexJob$field = new int();
      }
      
      public function get hasSexJob() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set sexJob(param1:int) : void
      {
         hasField$0 |= 2048;
         sexJob$field = param1;
      }
      
      public function get sexJob() : int
      {
         return sexJob$field;
      }
      
      public function removeDayScore() : void
      {
         hasField$0 &= 4294963199;
         dayScore$field = new int();
      }
      
      public function get hasDayScore() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set dayScore(param1:int) : void
      {
         hasField$0 |= 4096;
         dayScore$field = param1;
      }
      
      public function get dayScore() : int
      {
         return dayScore$field;
      }
      
      public function removeLastTotalScore() : void
      {
         hasField$0 &= 4294959103;
         lastTotalScore$field = new int();
      }
      
      public function get hasLastTotalScore() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set lastTotalScore(param1:int) : void
      {
         hasField$0 |= 8192;
         lastTotalScore$field = param1;
      }
      
      public function get lastTotalScore() : int
      {
         return lastTotalScore$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294950911;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 16384;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeLastWinCount() : void
      {
         hasField$0 &= 4294934527;
         lastWinCount$field = new int();
      }
      
      public function get hasLastWinCount() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set lastWinCount(param1:int) : void
      {
         hasField$0 |= 32768;
         lastWinCount$field = param1;
      }
      
      public function get lastWinCount() : int
      {
         return lastWinCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasTeamType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,teamType$field);
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         if(hasRankOrder)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,rankOrder$field);
         }
         if(hasSeason)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,season$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,groupId$field);
         }
         if(hasIsMaster)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isMaster$field);
         }
         if(hasOrderTemp)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,orderTemp$field);
         }
         if(hasSexJob)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,sexJob$field);
         }
         if(hasDayScore)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,dayScore$field);
         }
         if(hasLastTotalScore)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,lastTotalScore$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasLastWinCount)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,lastWinCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc20_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         var _loc16_:uint = 0;
         var _loc9_:uint = 0;
         var _loc22_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc21_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc17_:uint = 0;
         var _loc8_:uint = 0;
         var _loc18_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.uid cannot be set twice.");
                  }
                  _loc20_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.userId cannot be set twice.");
                  }
                  _loc12_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.serverName cannot be set twice.");
                  }
                  _loc14_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.nickName cannot be set twice.");
                  }
                  _loc16_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.headId cannot be set twice.");
                  }
                  _loc9_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.grades cannot be set twice.");
                  }
                  _loc22_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.teamType cannot be set twice.");
                  }
                  _loc3_++;
                  teamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.totalScore cannot be set twice.");
                  }
                  _loc5_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.rankOrder cannot be set twice.");
                  }
                  _loc13_++;
                  rankOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.season cannot be set twice.");
                  }
                  _loc15_++;
                  season = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.groupId cannot be set twice.");
                  }
                  _loc21_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.isMaster cannot be set twice.");
                  }
                  _loc10_++;
                  isMaster = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.orderTemp cannot be set twice.");
                  }
                  _loc7_++;
                  orderTemp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.sexJob cannot be set twice.");
                  }
                  _loc17_++;
                  sexJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.dayScore cannot be set twice.");
                  }
                  _loc8_++;
                  dayScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.lastTotalScore cannot be set twice.");
                  }
                  _loc18_++;
                  lastTotalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.result cannot be set twice.");
                  }
                  _loc11_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegInfoMsg.lastWinCount cannot be set twice.");
                  }
                  _loc6_++;
                  lastWinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

