package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehicleScroeListMsg extends Message implements IExternalizable
   {
      
      private var playerId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var playerScroe$field:int;
      
      private var playerExp$field:int;
      
      private var awardPropId$field:int;
      
      private var awardSum$field:int;
      
      private var ladderPropId$field:int;
      
      private var ladderSum$field:int;
      
      private var awardPropId_new$field:int;
      
      private var awardSum_new$field:int;
      
      private var server_name$field:String;
      
      private var kill_count$field:int;
      
      private var order$field:int;
      
      private var nick_name$field:String;
      
      private var score_change_time$field:int;
      
      private var pickSkillCount$field:int;
      
      private var enterSeq$field:int;
      
      public function VehicleScroeListMsg()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         playerId$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         playerId$field = param1;
      }
      
      public function get playerId() : int
      {
         return playerId$field;
      }
      
      public function removePlayerScroe() : void
      {
         hasField$0 &= 4294967293;
         playerScroe$field = new int();
      }
      
      public function get hasPlayerScroe() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set playerScroe(param1:int) : void
      {
         hasField$0 |= 2;
         playerScroe$field = param1;
      }
      
      public function get playerScroe() : int
      {
         return playerScroe$field;
      }
      
      public function removePlayerExp() : void
      {
         hasField$0 &= 4294967291;
         playerExp$field = new int();
      }
      
      public function get hasPlayerExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set playerExp(param1:int) : void
      {
         hasField$0 |= 4;
         playerExp$field = param1;
      }
      
      public function get playerExp() : int
      {
         return playerExp$field;
      }
      
      public function removeAwardPropId() : void
      {
         hasField$0 &= 4294967287;
         awardPropId$field = new int();
      }
      
      public function get hasAwardPropId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set awardPropId(param1:int) : void
      {
         hasField$0 |= 8;
         awardPropId$field = param1;
      }
      
      public function get awardPropId() : int
      {
         return awardPropId$field;
      }
      
      public function removeAwardSum() : void
      {
         hasField$0 &= 4294967279;
         awardSum$field = new int();
      }
      
      public function get hasAwardSum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set awardSum(param1:int) : void
      {
         hasField$0 |= 16;
         awardSum$field = param1;
      }
      
      public function get awardSum() : int
      {
         return awardSum$field;
      }
      
      public function removeLadderPropId() : void
      {
         hasField$0 &= 4294967263;
         ladderPropId$field = new int();
      }
      
      public function get hasLadderPropId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set ladderPropId(param1:int) : void
      {
         hasField$0 |= 32;
         ladderPropId$field = param1;
      }
      
      public function get ladderPropId() : int
      {
         return ladderPropId$field;
      }
      
      public function removeLadderSum() : void
      {
         hasField$0 &= 4294967231;
         ladderSum$field = new int();
      }
      
      public function get hasLadderSum() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set ladderSum(param1:int) : void
      {
         hasField$0 |= 64;
         ladderSum$field = param1;
      }
      
      public function get ladderSum() : int
      {
         return ladderSum$field;
      }
      
      public function removeAwardPropIdNew() : void
      {
         hasField$0 &= 4294967167;
         awardPropId_new$field = new int();
      }
      
      public function get hasAwardPropIdNew() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set awardPropIdNew(param1:int) : void
      {
         hasField$0 |= 128;
         awardPropId_new$field = param1;
      }
      
      public function get awardPropIdNew() : int
      {
         return awardPropId_new$field;
      }
      
      public function removeAwardSumNew() : void
      {
         hasField$0 &= 4294967039;
         awardSum_new$field = new int();
      }
      
      public function get hasAwardSumNew() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set awardSumNew(param1:int) : void
      {
         hasField$0 |= 256;
         awardSum_new$field = param1;
      }
      
      public function get awardSumNew() : int
      {
         return awardSum_new$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeKillCount() : void
      {
         hasField$0 &= 4294966783;
         kill_count$field = new int();
      }
      
      public function get hasKillCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set killCount(param1:int) : void
      {
         hasField$0 |= 512;
         kill_count$field = param1;
      }
      
      public function get killCount() : int
      {
         return kill_count$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294966271;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 1024;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
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
      
      public function removeScoreChangeTime() : void
      {
         hasField$0 &= 4294965247;
         score_change_time$field = new int();
      }
      
      public function get hasScoreChangeTime() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set scoreChangeTime(param1:int) : void
      {
         hasField$0 |= 2048;
         score_change_time$field = param1;
      }
      
      public function get scoreChangeTime() : int
      {
         return score_change_time$field;
      }
      
      public function removePickSkillCount() : void
      {
         hasField$0 &= 4294963199;
         pickSkillCount$field = new int();
      }
      
      public function get hasPickSkillCount() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set pickSkillCount(param1:int) : void
      {
         hasField$0 |= 4096;
         pickSkillCount$field = param1;
      }
      
      public function get pickSkillCount() : int
      {
         return pickSkillCount$field;
      }
      
      public function removeEnterSeq() : void
      {
         hasField$0 &= 4294959103;
         enterSeq$field = new int();
      }
      
      public function get hasEnterSeq() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set enterSeq(param1:int) : void
      {
         hasField$0 |= 8192;
         enterSeq$field = param1;
      }
      
      public function get enterSeq() : int
      {
         return enterSeq$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasPlayerScroe)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,playerScroe$field);
         }
         if(hasPlayerExp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,playerExp$field);
         }
         if(hasAwardPropId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,awardPropId$field);
         }
         if(hasAwardSum)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,awardSum$field);
         }
         if(hasLadderPropId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,ladderPropId$field);
         }
         if(hasLadderSum)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,ladderSum$field);
         }
         if(hasAwardPropIdNew)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,awardPropId_new$field);
         }
         if(hasAwardSumNew)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,awardSum_new$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasKillCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,kill_count$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasScoreChangeTime)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,score_change_time$field);
         }
         if(hasPickSkillCount)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,pickSkillCount$field);
         }
         if(hasEnterSeq)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,enterSeq$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc7_:uint = 0;
         var _loc18_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.playerId cannot be set twice.");
                  }
                  _loc3_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.playerScroe cannot be set twice.");
                  }
                  _loc13_++;
                  playerScroe = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.playerExp cannot be set twice.");
                  }
                  _loc12_++;
                  playerExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.awardPropId cannot be set twice.");
                  }
                  _loc16_++;
                  awardPropId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.awardSum cannot be set twice.");
                  }
                  _loc7_++;
                  awardSum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.ladderPropId cannot be set twice.");
                  }
                  _loc18_++;
                  ladderPropId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.ladderSum cannot be set twice.");
                  }
                  _loc8_++;
                  ladderSum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.awardPropIdNew cannot be set twice.");
                  }
                  _loc15_++;
                  awardPropIdNew = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.awardSumNew cannot be set twice.");
                  }
                  _loc17_++;
                  awardSumNew = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.killCount cannot be set twice.");
                  }
                  _loc11_++;
                  killCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.order cannot be set twice.");
                  }
                  _loc14_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.scoreChangeTime cannot be set twice.");
                  }
                  _loc9_++;
                  scoreChangeTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.pickSkillCount cannot be set twice.");
                  }
                  _loc5_++;
                  pickSkillCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleScroeListMsg.enterSeq cannot be set twice.");
                  }
                  _loc6_++;
                  enterSeq = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

