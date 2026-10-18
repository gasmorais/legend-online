package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LordsMsg extends Message implements IExternalizable
   {
      
      private var army$field:ArmyMsg;
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var server_name$field:String;
      
      private var nick_name$field:String;
      
      private var user_keys$field:String;
      
      private var fight_power$field:int;
      
      private var ready_score$field:int;
      
      private var ready_order$field:int;
      
      private var final_score$field:int;
      
      private var final_order$field:int;
      
      private var win_counter$field:int;
      
      private var current_turn$field:int;
      
      private var final_turn$field:int;
      
      private var final_winCount$field:int;
      
      private var isVip$field:Boolean;
      
      private var teamUid$field:String;
      
      private var uuid$field:String;
      
      private var teamName$field:String;
      
      public function LordsMsg()
      {
         super();
      }
      
      public function removeArmy() : void
      {
         army$field = null;
      }
      
      public function get hasArmy() : Boolean
      {
         return army$field != null;
      }
      
      public function set army(param1:ArmyMsg) : void
      {
         army$field = param1;
      }
      
      public function get army() : ArmyMsg
      {
         return army$field;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
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
      
      public function removeUserKeys() : void
      {
         user_keys$field = null;
      }
      
      public function get hasUserKeys() : Boolean
      {
         return user_keys$field != null;
      }
      
      public function set userKeys(param1:String) : void
      {
         user_keys$field = param1;
      }
      
      public function get userKeys() : String
      {
         return user_keys$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967291;
         fight_power$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 4;
         fight_power$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fight_power$field;
      }
      
      public function removeReadyScore() : void
      {
         hasField$0 &= 4294967287;
         ready_score$field = new int();
      }
      
      public function get hasReadyScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set readyScore(param1:int) : void
      {
         hasField$0 |= 8;
         ready_score$field = param1;
      }
      
      public function get readyScore() : int
      {
         return ready_score$field;
      }
      
      public function removeReadyOrder() : void
      {
         hasField$0 &= 4294967279;
         ready_order$field = new int();
      }
      
      public function get hasReadyOrder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set readyOrder(param1:int) : void
      {
         hasField$0 |= 16;
         ready_order$field = param1;
      }
      
      public function get readyOrder() : int
      {
         return ready_order$field;
      }
      
      public function removeFinalScore() : void
      {
         hasField$0 &= 4294967263;
         final_score$field = new int();
      }
      
      public function get hasFinalScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set finalScore(param1:int) : void
      {
         hasField$0 |= 32;
         final_score$field = param1;
      }
      
      public function get finalScore() : int
      {
         return final_score$field;
      }
      
      public function removeFinalOrder() : void
      {
         hasField$0 &= 4294967231;
         final_order$field = new int();
      }
      
      public function get hasFinalOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set finalOrder(param1:int) : void
      {
         hasField$0 |= 64;
         final_order$field = param1;
      }
      
      public function get finalOrder() : int
      {
         return final_order$field;
      }
      
      public function removeWinCounter() : void
      {
         hasField$0 &= 4294967167;
         win_counter$field = new int();
      }
      
      public function get hasWinCounter() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set winCounter(param1:int) : void
      {
         hasField$0 |= 128;
         win_counter$field = param1;
      }
      
      public function get winCounter() : int
      {
         return win_counter$field;
      }
      
      public function removeCurrentTurn() : void
      {
         hasField$0 &= 4294967039;
         current_turn$field = new int();
      }
      
      public function get hasCurrentTurn() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set currentTurn(param1:int) : void
      {
         hasField$0 |= 256;
         current_turn$field = param1;
      }
      
      public function get currentTurn() : int
      {
         return current_turn$field;
      }
      
      public function removeFinalTurn() : void
      {
         hasField$0 &= 4294966783;
         final_turn$field = new int();
      }
      
      public function get hasFinalTurn() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set finalTurn(param1:int) : void
      {
         hasField$0 |= 512;
         final_turn$field = param1;
      }
      
      public function get finalTurn() : int
      {
         return final_turn$field;
      }
      
      public function removeFinalWinCount() : void
      {
         hasField$0 &= 4294966271;
         final_winCount$field = new int();
      }
      
      public function get hasFinalWinCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set finalWinCount(param1:int) : void
      {
         hasField$0 |= 1024;
         final_winCount$field = param1;
      }
      
      public function get finalWinCount() : int
      {
         return final_winCount$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294965247;
         isVip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         isVip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return isVip$field;
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
      
      public function removeTeamName() : void
      {
         teamName$field = null;
      }
      
      public function get hasTeamName() : Boolean
      {
         return teamName$field != null;
      }
      
      public function set teamName(param1:String) : void
      {
         teamName$field = param1;
      }
      
      public function get teamName() : String
      {
         return teamName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasArmy)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,army$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasUserKeys)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,user_keys$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fight_power$field);
         }
         if(hasReadyScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,ready_score$field);
         }
         if(hasReadyOrder)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,ready_order$field);
         }
         if(hasFinalScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,final_score$field);
         }
         if(hasFinalOrder)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,final_order$field);
         }
         if(hasWinCounter)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,win_counter$field);
         }
         if(hasCurrentTurn)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,current_turn$field);
         }
         if(hasFinalTurn)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,final_turn$field);
         }
         if(hasFinalWinCount)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,final_winCount$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,isVip$field);
         }
         if(hasTeamUid)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,teamUid$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasTeamName)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,teamName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc20_:* = 0;
         var _loc21_:uint = 0;
         var _loc8_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc19_:uint = 0;
         var _loc16_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         var _loc22_:uint = 0;
         var _loc17_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc20_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.army cannot be set twice.");
                  }
                  _loc21_++;
                  army = new ArmyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,army);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.id cannot be set twice.");
                  }
                  _loc8_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.userId cannot be set twice.");
                  }
                  _loc18_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.serverName cannot be set twice.");
                  }
                  _loc12_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.userKeys cannot be set twice.");
                  }
                  _loc6_++;
                  userKeys = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.fightPower cannot be set twice.");
                  }
                  _loc19_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.readyScore cannot be set twice.");
                  }
                  _loc16_++;
                  readyScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.readyOrder cannot be set twice.");
                  }
                  _loc3_++;
                  readyOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.finalScore cannot be set twice.");
                  }
                  _loc15_++;
                  finalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.finalOrder cannot be set twice.");
                  }
                  _loc4_++;
                  finalOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.winCounter cannot be set twice.");
                  }
                  _loc22_++;
                  winCounter = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.currentTurn cannot be set twice.");
                  }
                  _loc17_++;
                  currentTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.finalTurn cannot be set twice.");
                  }
                  _loc9_++;
                  finalTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.finalWinCount cannot be set twice.");
                  }
                  _loc10_++;
                  finalWinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.isVip cannot be set twice.");
                  }
                  _loc13_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.teamUid cannot be set twice.");
                  }
                  _loc7_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.uuid cannot be set twice.");
                  }
                  _loc14_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LordsMsg.teamName cannot be set twice.");
                  }
                  _loc11_++;
                  teamName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc20_ & 7);
            }
         }
      }
   }
}

