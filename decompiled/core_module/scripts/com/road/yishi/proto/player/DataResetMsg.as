package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DataResetMsg extends Message implements IExternalizable
   {
      
      private var weary$field:int;
      
      private var hasField$0:uint = 0;
      
      private var hangup_count$field:int;
      
      private var trans_energy$field:int;
      
      private var attack_count$field:int;
      
      private var challenge_count$field:int;
      
      private var left_hangupWeary$field:int;
      
      private var tower1_enterCount$field:int;
      
      private var tower2_enterCount$field:int;
      
      private var blessing_count$field:int;
      
      private var blessing_buff$field:int;
      
      private var buy_count$field:int;
      
      private var king_Buff$field:Boolean;
      
      private var server_name$field:String;
      
      private var UpRuneByPointTimes$field:int;
      
      private var tower3_enterCount$field:int;
      
      public function DataResetMsg()
      {
         super();
      }
      
      public function removeWeary() : void
      {
         hasField$0 &= 4294967294;
         weary$field = new int();
      }
      
      public function get hasWeary() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set weary(param1:int) : void
      {
         hasField$0 |= 1;
         weary$field = param1;
      }
      
      public function get weary() : int
      {
         return weary$field;
      }
      
      public function removeHangupCount() : void
      {
         hasField$0 &= 4294967293;
         hangup_count$field = new int();
      }
      
      public function get hasHangupCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hangupCount(param1:int) : void
      {
         hasField$0 |= 2;
         hangup_count$field = param1;
      }
      
      public function get hangupCount() : int
      {
         return hangup_count$field;
      }
      
      public function removeTransEnergy() : void
      {
         hasField$0 &= 4294967291;
         trans_energy$field = new int();
      }
      
      public function get hasTransEnergy() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set transEnergy(param1:int) : void
      {
         hasField$0 |= 4;
         trans_energy$field = param1;
      }
      
      public function get transEnergy() : int
      {
         return trans_energy$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967287;
         attack_count$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 8;
         attack_count$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attack_count$field;
      }
      
      public function removeChallengeCount() : void
      {
         hasField$0 &= 4294967279;
         challenge_count$field = new int();
      }
      
      public function get hasChallengeCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set challengeCount(param1:int) : void
      {
         hasField$0 |= 16;
         challenge_count$field = param1;
      }
      
      public function get challengeCount() : int
      {
         return challenge_count$field;
      }
      
      public function removeLeftHangupWeary() : void
      {
         hasField$0 &= 4294967263;
         left_hangupWeary$field = new int();
      }
      
      public function get hasLeftHangupWeary() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set leftHangupWeary(param1:int) : void
      {
         hasField$0 |= 32;
         left_hangupWeary$field = param1;
      }
      
      public function get leftHangupWeary() : int
      {
         return left_hangupWeary$field;
      }
      
      public function removeTower1EnterCount() : void
      {
         hasField$0 &= 4294967231;
         tower1_enterCount$field = new int();
      }
      
      public function get hasTower1EnterCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set tower1EnterCount(param1:int) : void
      {
         hasField$0 |= 64;
         tower1_enterCount$field = param1;
      }
      
      public function get tower1EnterCount() : int
      {
         return tower1_enterCount$field;
      }
      
      public function removeTower2EnterCount() : void
      {
         hasField$0 &= 4294967167;
         tower2_enterCount$field = new int();
      }
      
      public function get hasTower2EnterCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set tower2EnterCount(param1:int) : void
      {
         hasField$0 |= 128;
         tower2_enterCount$field = param1;
      }
      
      public function get tower2EnterCount() : int
      {
         return tower2_enterCount$field;
      }
      
      public function removeBlessingCount() : void
      {
         hasField$0 &= 4294967039;
         blessing_count$field = new int();
      }
      
      public function get hasBlessingCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set blessingCount(param1:int) : void
      {
         hasField$0 |= 256;
         blessing_count$field = param1;
      }
      
      public function get blessingCount() : int
      {
         return blessing_count$field;
      }
      
      public function removeBlessingBuff() : void
      {
         hasField$0 &= 4294966783;
         blessing_buff$field = new int();
      }
      
      public function get hasBlessingBuff() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set blessingBuff(param1:int) : void
      {
         hasField$0 |= 512;
         blessing_buff$field = param1;
      }
      
      public function get blessingBuff() : int
      {
         return blessing_buff$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294966271;
         buy_count$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 1024;
         buy_count$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buy_count$field;
      }
      
      public function removeKing_Buff() : void
      {
         hasField$0 &= 4294965247;
         king_Buff$field = new Boolean();
      }
      
      public function get hasKing_Buff() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set king_Buff(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         king_Buff$field = param1;
      }
      
      public function get king_Buff() : Boolean
      {
         return king_Buff$field;
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
      
      public function removeUpRuneByPointTimes() : void
      {
         hasField$0 &= 4294963199;
         UpRuneByPointTimes$field = new int();
      }
      
      public function get hasUpRuneByPointTimes() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set upRuneByPointTimes(param1:int) : void
      {
         hasField$0 |= 4096;
         UpRuneByPointTimes$field = param1;
      }
      
      public function get upRuneByPointTimes() : int
      {
         return UpRuneByPointTimes$field;
      }
      
      public function removeTower3EnterCount() : void
      {
         hasField$0 &= 4294959103;
         tower3_enterCount$field = new int();
      }
      
      public function get hasTower3EnterCount() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set tower3EnterCount(param1:int) : void
      {
         hasField$0 |= 8192;
         tower3_enterCount$field = param1;
      }
      
      public function get tower3EnterCount() : int
      {
         return tower3_enterCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasWeary)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,weary$field);
         }
         if(hasHangupCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hangup_count$field);
         }
         if(hasTransEnergy)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,trans_energy$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attack_count$field);
         }
         if(hasChallengeCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,challenge_count$field);
         }
         if(hasLeftHangupWeary)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,left_hangupWeary$field);
         }
         if(hasTower1EnterCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,tower1_enterCount$field);
         }
         if(hasTower2EnterCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,tower2_enterCount$field);
         }
         if(hasBlessingCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,blessing_count$field);
         }
         if(hasBlessingBuff)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,blessing_buff$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,buy_count$field);
         }
         if(hasKing_Buff)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,king_Buff$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasUpRuneByPointTimes)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,UpRuneByPointTimes$field);
         }
         if(hasTower3EnterCount)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,tower3_enterCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc16_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.weary cannot be set twice.");
                  }
                  _loc3_++;
                  weary = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.hangupCount cannot be set twice.");
                  }
                  _loc5_++;
                  hangupCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.transEnergy cannot be set twice.");
                  }
                  _loc12_++;
                  transEnergy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.attackCount cannot be set twice.");
                  }
                  _loc7_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.challengeCount cannot be set twice.");
                  }
                  _loc8_++;
                  challengeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.leftHangupWeary cannot be set twice.");
                  }
                  _loc6_++;
                  leftHangupWeary = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.tower1EnterCount cannot be set twice.");
                  }
                  _loc16_++;
                  tower1EnterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.tower2EnterCount cannot be set twice.");
                  }
                  _loc9_++;
                  tower2EnterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.blessingCount cannot be set twice.");
                  }
                  _loc4_++;
                  blessingCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.blessingBuff cannot be set twice.");
                  }
                  _loc18_++;
                  blessingBuff = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.buyCount cannot be set twice.");
                  }
                  _loc13_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.king_Buff cannot be set twice.");
                  }
                  _loc15_++;
                  king_Buff = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.upRuneByPointTimes cannot be set twice.");
                  }
                  _loc11_++;
                  upRuneByPointTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DataResetMsg.tower3EnterCount cannot be set twice.");
                  }
                  _loc14_++;
                  tower3EnterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

