package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarRankMsg extends Message implements IExternalizable
   {
      
      private var rank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var job$field:int;
      
      private var camp$field:int;
      
      private var kill$field:int;
      
      private var occupy$field:int;
      
      private var score$field:int;
      
      private var uuid$field:String;
      
      private var fightPower$field:int;
      
      private var isReward$field:Boolean;
      
      private var exploits$field:int;
      
      public function SecretWarRankMsg()
      {
         super();
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967294;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 1;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
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
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967291;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 4;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeCamp() : void
      {
         hasField$0 &= 4294967287;
         camp$field = new int();
      }
      
      public function get hasCamp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set camp(param1:int) : void
      {
         hasField$0 |= 8;
         camp$field = param1;
      }
      
      public function get camp() : int
      {
         return camp$field;
      }
      
      public function removeKill() : void
      {
         hasField$0 &= 4294967279;
         kill$field = new int();
      }
      
      public function get hasKill() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set kill(param1:int) : void
      {
         hasField$0 |= 16;
         kill$field = param1;
      }
      
      public function get kill() : int
      {
         return kill$field;
      }
      
      public function removeOccupy() : void
      {
         hasField$0 &= 4294967263;
         occupy$field = new int();
      }
      
      public function get hasOccupy() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set occupy(param1:int) : void
      {
         hasField$0 |= 32;
         occupy$field = param1;
      }
      
      public function get occupy() : int
      {
         return occupy$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967231;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 64;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
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
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967167;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 128;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294967039;
         isReward$field = new Boolean();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isReward(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isReward$field = param1;
      }
      
      public function get isReward() : Boolean
      {
         return isReward$field;
      }
      
      public function removeExploits() : void
      {
         hasField$0 &= 4294966783;
         exploits$field = new int();
      }
      
      public function get hasExploits() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set exploits(param1:int) : void
      {
         hasField$0 |= 512;
         exploits$field = param1;
      }
      
      public function get exploits() : int
      {
         return exploits$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
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
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasCamp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,camp$field);
         }
         if(hasKill)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,kill$field);
         }
         if(hasOccupy)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,occupy$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isReward$field);
         }
         if(hasExploits)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,exploits$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc16_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.rank cannot be set twice.");
                  }
                  _loc4_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.userId cannot be set twice.");
                  }
                  _loc8_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.nickName cannot be set twice.");
                  }
                  _loc12_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.job cannot be set twice.");
                  }
                  _loc14_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.camp cannot be set twice.");
                  }
                  _loc6_++;
                  camp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.kill cannot be set twice.");
                  }
                  _loc9_++;
                  kill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.occupy cannot be set twice.");
                  }
                  _loc7_++;
                  occupy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.score cannot be set twice.");
                  }
                  _loc16_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.uuid cannot be set twice.");
                  }
                  _loc11_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.fightPower cannot be set twice.");
                  }
                  _loc5_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.isReward cannot be set twice.");
                  }
                  _loc13_++;
                  isReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarRankMsg.exploits cannot be set twice.");
                  }
                  _loc3_++;
                  exploits = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

