package com.road.yishi.proto.guardpvp
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GuardPvpInfoMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var fightPower$field:int;
      
      private var winCount$field:int;
      
      private var teamType$field:int;
      
      private var teamIndex$field:int;
      
      private var teamPos$field:int;
      
      private var crossServerId$field:int;
      
      private var signUpTime$field:Int64;
      
      public function GuardPvpInfoMsg()
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
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967293;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 2;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeWinCount() : void
      {
         hasField$0 &= 4294967291;
         winCount$field = new int();
      }
      
      public function get hasWinCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set winCount(param1:int) : void
      {
         hasField$0 |= 4;
         winCount$field = param1;
      }
      
      public function get winCount() : int
      {
         return winCount$field;
      }
      
      public function removeTeamType() : void
      {
         hasField$0 &= 4294967287;
         teamType$field = new int();
      }
      
      public function get hasTeamType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set teamType(param1:int) : void
      {
         hasField$0 |= 8;
         teamType$field = param1;
      }
      
      public function get teamType() : int
      {
         return teamType$field;
      }
      
      public function removeTeamIndex() : void
      {
         hasField$0 &= 4294967279;
         teamIndex$field = new int();
      }
      
      public function get hasTeamIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set teamIndex(param1:int) : void
      {
         hasField$0 |= 16;
         teamIndex$field = param1;
      }
      
      public function get teamIndex() : int
      {
         return teamIndex$field;
      }
      
      public function removeTeamPos() : void
      {
         hasField$0 &= 4294967263;
         teamPos$field = new int();
      }
      
      public function get hasTeamPos() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set teamPos(param1:int) : void
      {
         hasField$0 |= 32;
         teamPos$field = param1;
      }
      
      public function get teamPos() : int
      {
         return teamPos$field;
      }
      
      public function removeCrossServerId() : void
      {
         hasField$0 &= 4294967231;
         crossServerId$field = new int();
      }
      
      public function get hasCrossServerId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set crossServerId(param1:int) : void
      {
         hasField$0 |= 64;
         crossServerId$field = param1;
      }
      
      public function get crossServerId() : int
      {
         return crossServerId$field;
      }
      
      public function removeSignUpTime() : void
      {
         signUpTime$field = null;
      }
      
      public function get hasSignUpTime() : Boolean
      {
         return signUpTime$field != null;
      }
      
      public function set signUpTime(param1:Int64) : void
      {
         signUpTime$field = param1;
      }
      
      public function get signUpTime() : Int64
      {
         return signUpTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
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
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasWinCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,winCount$field);
         }
         if(hasTeamType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,teamType$field);
         }
         if(hasTeamIndex)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,teamIndex$field);
         }
         if(hasTeamPos)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,teamPos$field);
         }
         if(hasCrossServerId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,crossServerId$field);
         }
         if(hasSignUpTime)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT64(param1,signUpTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.uuid cannot be set twice.");
                  }
                  _loc10_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.serverName cannot be set twice.");
                  }
                  _loc11_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.nickName cannot be set twice.");
                  }
                  _loc12_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.winCount cannot be set twice.");
                  }
                  _loc9_++;
                  winCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.teamType cannot be set twice.");
                  }
                  _loc3_++;
                  teamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.teamIndex cannot be set twice.");
                  }
                  _loc7_++;
                  teamIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.teamPos cannot be set twice.");
                  }
                  _loc6_++;
                  teamPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.crossServerId cannot be set twice.");
                  }
                  _loc8_++;
                  crossServerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPvpInfoMsg.signUpTime cannot be set twice.");
                  }
                  _loc14_++;
                  signUpTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

