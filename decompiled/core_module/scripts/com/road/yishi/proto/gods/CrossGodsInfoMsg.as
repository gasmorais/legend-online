package com.road.yishi.proto.gods
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrossGodsInfoMsg extends Message implements IExternalizable
   {
      
      private var game_key$field:String;
      
      private var server_name$field:String;
      
      private var fight_power$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var server_id$field:int;
      
      private var readyScore$field:int;
      
      private var readyOrder$field:int;
      
      private var finalScore$field:int;
      
      private var finalOrder$field:int;
      
      private var lordsInfo$field:String;
      
      private var goddessInfo$field:String;
      
      private var group_id$field:int;
      
      private var team_id$field:int;
      
      private var rank$field:int;
      
      private var buffer_lv$field:int;
      
      public function CrossGodsInfoMsg()
      {
         super();
      }
      
      public function removeGameKey() : void
      {
         game_key$field = null;
      }
      
      public function get hasGameKey() : Boolean
      {
         return game_key$field != null;
      }
      
      public function set gameKey(param1:String) : void
      {
         game_key$field = param1;
      }
      
      public function get gameKey() : String
      {
         return game_key$field;
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
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967294;
         fight_power$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 1;
         fight_power$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fight_power$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294967291;
         server_id$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 4;
         server_id$field = param1;
      }
      
      public function get serverId() : int
      {
         return server_id$field;
      }
      
      public function removeReadyScore() : void
      {
         hasField$0 &= 4294967287;
         readyScore$field = new int();
      }
      
      public function get hasReadyScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set readyScore(param1:int) : void
      {
         hasField$0 |= 8;
         readyScore$field = param1;
      }
      
      public function get readyScore() : int
      {
         return readyScore$field;
      }
      
      public function removeReadyOrder() : void
      {
         hasField$0 &= 4294967279;
         readyOrder$field = new int();
      }
      
      public function get hasReadyOrder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set readyOrder(param1:int) : void
      {
         hasField$0 |= 16;
         readyOrder$field = param1;
      }
      
      public function get readyOrder() : int
      {
         return readyOrder$field;
      }
      
      public function removeFinalScore() : void
      {
         hasField$0 &= 4294967263;
         finalScore$field = new int();
      }
      
      public function get hasFinalScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set finalScore(param1:int) : void
      {
         hasField$0 |= 32;
         finalScore$field = param1;
      }
      
      public function get finalScore() : int
      {
         return finalScore$field;
      }
      
      public function removeFinalOrder() : void
      {
         hasField$0 &= 4294967231;
         finalOrder$field = new int();
      }
      
      public function get hasFinalOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set finalOrder(param1:int) : void
      {
         hasField$0 |= 64;
         finalOrder$field = param1;
      }
      
      public function get finalOrder() : int
      {
         return finalOrder$field;
      }
      
      public function removeLordsInfo() : void
      {
         lordsInfo$field = null;
      }
      
      public function get hasLordsInfo() : Boolean
      {
         return lordsInfo$field != null;
      }
      
      public function set lordsInfo(param1:String) : void
      {
         lordsInfo$field = param1;
      }
      
      public function get lordsInfo() : String
      {
         return lordsInfo$field;
      }
      
      public function removeGoddessInfo() : void
      {
         goddessInfo$field = null;
      }
      
      public function get hasGoddessInfo() : Boolean
      {
         return goddessInfo$field != null;
      }
      
      public function set goddessInfo(param1:String) : void
      {
         goddessInfo$field = param1;
      }
      
      public function get goddessInfo() : String
      {
         return goddessInfo$field;
      }
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294967167;
         group_id$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 128;
         group_id$field = param1;
      }
      
      public function get groupId() : int
      {
         return group_id$field;
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967039;
         team_id$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 256;
         team_id$field = param1;
      }
      
      public function get teamId() : int
      {
         return team_id$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294966783;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 512;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeBufferLv() : void
      {
         hasField$0 &= 4294966271;
         buffer_lv$field = new int();
      }
      
      public function get hasBufferLv() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set bufferLv(param1:int) : void
      {
         hasField$0 |= 1024;
         buffer_lv$field = param1;
      }
      
      public function get bufferLv() : int
      {
         return buffer_lv$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGameKey)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,game_key$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fight_power$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,server_id$field);
         }
         if(hasReadyScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,readyScore$field);
         }
         if(hasReadyOrder)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,readyOrder$field);
         }
         if(hasFinalScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,finalScore$field);
         }
         if(hasFinalOrder)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,finalOrder$field);
         }
         if(hasLordsInfo)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,lordsInfo$field);
         }
         if(hasGoddessInfo)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,goddessInfo$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,group_id$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasBufferLv)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,buffer_lv$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc18_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc17_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.gameKey cannot be set twice.");
                  }
                  _loc5_++;
                  gameKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc15_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.score cannot be set twice.");
                  }
                  _loc18_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.serverId cannot be set twice.");
                  }
                  _loc3_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.readyScore cannot be set twice.");
                  }
                  _loc6_++;
                  readyScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.readyOrder cannot be set twice.");
                  }
                  _loc17_++;
                  readyOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.finalScore cannot be set twice.");
                  }
                  _loc8_++;
                  finalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.finalOrder cannot be set twice.");
                  }
                  _loc13_++;
                  finalOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.lordsInfo cannot be set twice.");
                  }
                  _loc14_++;
                  lordsInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.goddessInfo cannot be set twice.");
                  }
                  _loc11_++;
                  goddessInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.groupId cannot be set twice.");
                  }
                  _loc9_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.teamId cannot be set twice.");
                  }
                  _loc10_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.rank cannot be set twice.");
                  }
                  _loc4_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CrossGodsInfoMsg.bufferLv cannot be set twice.");
                  }
                  _loc12_++;
                  bufferLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

