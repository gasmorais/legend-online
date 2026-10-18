package com.road.yishi.proto.matelords
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MateLordsInfoMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var teamUid$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var userKeys$field:String;
      
      private var job$field:int;
      
      private var sexJob$field:int;
      
      private var grades$field:int;
      
      private var fightPower$field:int;
      
      private var totalWinCount$field:int;
      
      private var teamType$field:int;
      
      private var warIndex$field:int;
      
      private var curreOrder$field:int;
      
      private var result$field:int;
      
      private var turnCount$field:int;
      
      private var addScore$field:int;
      
      private var totalScore$field:int;
      
      private var property1$field:String;
      
      [ArrayElementType("int")]
      public var clearRateItems:Array = [];
      
      private var descScore$field:int;
      
      public function MateLordsInfoMsg()
      {
         super();
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
      
      public function removeTeamUid() : void
      {
         teamUid$field = null;
      }
      
      public function get hasTeamUid() : Boolean
      {
         return teamUid$field != null;
      }
      
      public function set teamUid(param1:String) : void
      {
         teamUid$field = param1;
      }
      
      public function get teamUid() : String
      {
         return teamUid$field;
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
      
      public function removeUserKeys() : void
      {
         userKeys$field = null;
      }
      
      public function get hasUserKeys() : Boolean
      {
         return userKeys$field != null;
      }
      
      public function set userKeys(param1:String) : void
      {
         userKeys$field = param1;
      }
      
      public function get userKeys() : String
      {
         return userKeys$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967293;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 2;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeSexJob() : void
      {
         hasField$0 &= 4294967291;
         sexJob$field = new int();
      }
      
      public function get hasSexJob() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sexJob(param1:int) : void
      {
         hasField$0 |= 4;
         sexJob$field = param1;
      }
      
      public function get sexJob() : int
      {
         return sexJob$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967287;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 8;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967279;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 16;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeTotalWinCount() : void
      {
         hasField$0 &= 4294967263;
         totalWinCount$field = new int();
      }
      
      public function get hasTotalWinCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set totalWinCount(param1:int) : void
      {
         hasField$0 |= 32;
         totalWinCount$field = param1;
      }
      
      public function get totalWinCount() : int
      {
         return totalWinCount$field;
      }
      
      public function removeTeamType() : void
      {
         hasField$0 &= 4294967231;
         teamType$field = new int();
      }
      
      public function get hasTeamType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set teamType(param1:int) : void
      {
         hasField$0 |= 64;
         teamType$field = param1;
      }
      
      public function get teamType() : int
      {
         return teamType$field;
      }
      
      public function removeWarIndex() : void
      {
         hasField$0 &= 4294967167;
         warIndex$field = new int();
      }
      
      public function get hasWarIndex() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set warIndex(param1:int) : void
      {
         hasField$0 |= 128;
         warIndex$field = param1;
      }
      
      public function get warIndex() : int
      {
         return warIndex$field;
      }
      
      public function removeCurreOrder() : void
      {
         hasField$0 &= 4294967039;
         curreOrder$field = new int();
      }
      
      public function get hasCurreOrder() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set curreOrder(param1:int) : void
      {
         hasField$0 |= 256;
         curreOrder$field = param1;
      }
      
      public function get curreOrder() : int
      {
         return curreOrder$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294966783;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 512;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeTurnCount() : void
      {
         hasField$0 &= 4294966271;
         turnCount$field = new int();
      }
      
      public function get hasTurnCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set turnCount(param1:int) : void
      {
         hasField$0 |= 1024;
         turnCount$field = param1;
      }
      
      public function get turnCount() : int
      {
         return turnCount$field;
      }
      
      public function removeAddScore() : void
      {
         hasField$0 &= 4294965247;
         addScore$field = new int();
      }
      
      public function get hasAddScore() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set addScore(param1:int) : void
      {
         hasField$0 |= 2048;
         addScore$field = param1;
      }
      
      public function get addScore() : int
      {
         return addScore$field;
      }
      
      public function removeTotalScore() : void
      {
         hasField$0 &= 4294963199;
         totalScore$field = new int();
      }
      
      public function get hasTotalScore() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set totalScore(param1:int) : void
      {
         hasField$0 |= 4096;
         totalScore$field = param1;
      }
      
      public function get totalScore() : int
      {
         return totalScore$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
      {
         return property1$field;
      }
      
      public function removeDescScore() : void
      {
         hasField$0 &= 4294959103;
         descScore$field = new int();
      }
      
      public function get hasDescScore() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set descScore(param1:int) : void
      {
         hasField$0 |= 8192;
         descScore$field = param1;
      }
      
      public function get descScore() : int
      {
         return descScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasTeamUid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,teamUid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasUserKeys)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,userKeys$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasSexJob)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,sexJob$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasTotalWinCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,totalWinCount$field);
         }
         if(hasTeamType)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,teamType$field);
         }
         if(hasWarIndex)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,warIndex$field);
         }
         if(hasCurreOrder)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,curreOrder$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasTurnCount)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,turnCount$field);
         }
         if(hasAddScore)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,addScore$field);
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         _loc2_ = 0;
         while(_loc2_ < clearRateItems.length)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,clearRateItems[_loc2_]);
            _loc2_++;
         }
         if(hasDescScore)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,descScore$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc14_:uint = 0;
         var _loc18_:uint = 0;
         var _loc16_:uint = 0;
         var _loc22_:uint = 0;
         var _loc6_:uint = 0;
         var _loc20_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc23_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc19_:uint = 0;
         var _loc7_:uint = 0;
         var _loc17_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.uuid cannot be set twice.");
                  }
                  _loc12_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.teamUid cannot be set twice.");
                  }
                  _loc5_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.userId cannot be set twice.");
                  }
                  _loc11_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.serverName cannot be set twice.");
                  }
                  _loc13_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.nickName cannot be set twice.");
                  }
                  _loc15_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.userKeys cannot be set twice.");
                  }
                  _loc14_++;
                  userKeys = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.job cannot be set twice.");
                  }
                  _loc18_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.sexJob cannot be set twice.");
                  }
                  _loc16_++;
                  sexJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.grades cannot be set twice.");
                  }
                  _loc22_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc6_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.totalWinCount cannot be set twice.");
                  }
                  _loc20_++;
                  totalWinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.teamType cannot be set twice.");
                  }
                  _loc4_++;
                  teamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.warIndex cannot be set twice.");
                  }
                  _loc8_++;
                  warIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.curreOrder cannot be set twice.");
                  }
                  _loc23_++;
                  curreOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.result cannot be set twice.");
                  }
                  _loc10_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.turnCount cannot be set twice.");
                  }
                  _loc9_++;
                  turnCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.addScore cannot be set twice.");
                  }
                  _loc19_++;
                  addScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.totalScore cannot be set twice.");
                  }
                  _loc7_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.property1 cannot be set twice.");
                  }
                  _loc17_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,clearRateItems);
                  }
                  else
                  {
                     clearRateItems.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 21:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsInfoMsg.descScore cannot be set twice.");
                  }
                  _loc3_++;
                  descScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

