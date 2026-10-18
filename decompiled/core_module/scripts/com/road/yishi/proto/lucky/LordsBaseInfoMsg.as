package com.road.yishi.proto.lucky
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LordsBaseInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var userKeys$field:String;
      
      private var job$field:int;
      
      private var sexJob$field:int;
      
      private var grades$field:int;
      
      private var fashionArm$field:String;
      
      private var fashionWing$field:String;
      
      private var fashionCloth$field:String;
      
      private var fashionHair$field:String;
      
      private var fashionHat$field:String;
      
      private var arm$field:String;
      
      private var isVip$field:Boolean;
      
      private var fightPower$field:int;
      
      private var readyScore$field:int;
      
      private var readyOrder$field:int;
      
      private var readyRewad$field:int;
      
      private var finalScore$field:int;
      
      private var finalOrder$field:int;
      
      private var finalRewad$field:int;
      
      private var readyTurn$field:int;
      
      private var finalTurn$field:int;
      
      private var readyWinCount$field:int;
      
      private var finalWinCount$field:int;
      
      private var isExist$field:Boolean;
      
      private var property1$field:String;
      
      private var property2$field:String;
      
      private var battle_result$field:int;
      
      private var bet_Index$field:int;
      
      private var fightPowerOrder$field:int;
      
      public function LordsBaseInfoMsg()
      {
         super();
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
      
      public function removeFashionArm() : void
      {
         fashionArm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashionArm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashionArm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashionArm$field;
      }
      
      public function removeFashionWing() : void
      {
         fashionWing$field = null;
      }
      
      public function get hasFashionWing() : Boolean
      {
         return fashionWing$field != null;
      }
      
      public function set fashionWing(param1:String) : void
      {
         fashionWing$field = param1;
      }
      
      public function get fashionWing() : String
      {
         return fashionWing$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashionCloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashionCloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashionCloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashionCloth$field;
      }
      
      public function removeFashionHair() : void
      {
         fashionHair$field = null;
      }
      
      public function get hasFashionHair() : Boolean
      {
         return fashionHair$field != null;
      }
      
      public function set fashionHair(param1:String) : void
      {
         fashionHair$field = param1;
      }
      
      public function get fashionHair() : String
      {
         return fashionHair$field;
      }
      
      public function removeFashionHat() : void
      {
         fashionHat$field = null;
      }
      
      public function get hasFashionHat() : Boolean
      {
         return fashionHat$field != null;
      }
      
      public function set fashionHat(param1:String) : void
      {
         fashionHat$field = param1;
      }
      
      public function get fashionHat() : String
      {
         return fashionHat$field;
      }
      
      public function removeArm() : void
      {
         arm$field = null;
      }
      
      public function get hasArm() : Boolean
      {
         return arm$field != null;
      }
      
      public function set arm(param1:String) : void
      {
         arm$field = param1;
      }
      
      public function get arm() : String
      {
         return arm$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294967279;
         isVip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isVip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return isVip$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967263;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 32;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeReadyScore() : void
      {
         hasField$0 &= 4294967231;
         readyScore$field = new int();
      }
      
      public function get hasReadyScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set readyScore(param1:int) : void
      {
         hasField$0 |= 64;
         readyScore$field = param1;
      }
      
      public function get readyScore() : int
      {
         return readyScore$field;
      }
      
      public function removeReadyOrder() : void
      {
         hasField$0 &= 4294967167;
         readyOrder$field = new int();
      }
      
      public function get hasReadyOrder() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set readyOrder(param1:int) : void
      {
         hasField$0 |= 128;
         readyOrder$field = param1;
      }
      
      public function get readyOrder() : int
      {
         return readyOrder$field;
      }
      
      public function removeReadyRewad() : void
      {
         hasField$0 &= 4294967039;
         readyRewad$field = new int();
      }
      
      public function get hasReadyRewad() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set readyRewad(param1:int) : void
      {
         hasField$0 |= 256;
         readyRewad$field = param1;
      }
      
      public function get readyRewad() : int
      {
         return readyRewad$field;
      }
      
      public function removeFinalScore() : void
      {
         hasField$0 &= 4294966783;
         finalScore$field = new int();
      }
      
      public function get hasFinalScore() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set finalScore(param1:int) : void
      {
         hasField$0 |= 512;
         finalScore$field = param1;
      }
      
      public function get finalScore() : int
      {
         return finalScore$field;
      }
      
      public function removeFinalOrder() : void
      {
         hasField$0 &= 4294966271;
         finalOrder$field = new int();
      }
      
      public function get hasFinalOrder() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set finalOrder(param1:int) : void
      {
         hasField$0 |= 1024;
         finalOrder$field = param1;
      }
      
      public function get finalOrder() : int
      {
         return finalOrder$field;
      }
      
      public function removeFinalRewad() : void
      {
         hasField$0 &= 4294965247;
         finalRewad$field = new int();
      }
      
      public function get hasFinalRewad() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set finalRewad(param1:int) : void
      {
         hasField$0 |= 2048;
         finalRewad$field = param1;
      }
      
      public function get finalRewad() : int
      {
         return finalRewad$field;
      }
      
      public function removeReadyTurn() : void
      {
         hasField$0 &= 4294963199;
         readyTurn$field = new int();
      }
      
      public function get hasReadyTurn() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set readyTurn(param1:int) : void
      {
         hasField$0 |= 4096;
         readyTurn$field = param1;
      }
      
      public function get readyTurn() : int
      {
         return readyTurn$field;
      }
      
      public function removeFinalTurn() : void
      {
         hasField$0 &= 4294959103;
         finalTurn$field = new int();
      }
      
      public function get hasFinalTurn() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set finalTurn(param1:int) : void
      {
         hasField$0 |= 8192;
         finalTurn$field = param1;
      }
      
      public function get finalTurn() : int
      {
         return finalTurn$field;
      }
      
      public function removeReadyWinCount() : void
      {
         hasField$0 &= 4294950911;
         readyWinCount$field = new int();
      }
      
      public function get hasReadyWinCount() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set readyWinCount(param1:int) : void
      {
         hasField$0 |= 16384;
         readyWinCount$field = param1;
      }
      
      public function get readyWinCount() : int
      {
         return readyWinCount$field;
      }
      
      public function removeFinalWinCount() : void
      {
         hasField$0 &= 4294934527;
         finalWinCount$field = new int();
      }
      
      public function get hasFinalWinCount() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set finalWinCount(param1:int) : void
      {
         hasField$0 |= 32768;
         finalWinCount$field = param1;
      }
      
      public function get finalWinCount() : int
      {
         return finalWinCount$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294901759;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 65536;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
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
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      public function removeBattleResult() : void
      {
         hasField$0 &= 4294836223;
         battle_result$field = new int();
      }
      
      public function get hasBattleResult() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set battleResult(param1:int) : void
      {
         hasField$0 |= 131072;
         battle_result$field = param1;
      }
      
      public function get battleResult() : int
      {
         return battle_result$field;
      }
      
      public function removeBet_Index() : void
      {
         hasField$0 &= 4294705151;
         bet_Index$field = new int();
      }
      
      public function get hasBet_Index() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set bet_Index(param1:int) : void
      {
         hasField$0 |= 262144;
         bet_Index$field = param1;
      }
      
      public function get bet_Index() : int
      {
         return bet_Index$field;
      }
      
      public function removeFightPowerOrder() : void
      {
         hasField$0 &= 4294443007;
         fightPowerOrder$field = new int();
      }
      
      public function get hasFightPowerOrder() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set fightPowerOrder(param1:int) : void
      {
         hasField$0 |= 524288;
         fightPowerOrder$field = param1;
      }
      
      public function get fightPowerOrder() : int
      {
         return fightPowerOrder$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasUserKeys)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,userKeys$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasSexJob)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,sexJob$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionWing)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,fashionWing$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasFashionHair)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,fashionHair$field);
         }
         if(hasFashionHat)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,fashionHat$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,isVip$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasReadyScore)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,readyScore$field);
         }
         if(hasReadyOrder)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,readyOrder$field);
         }
         if(hasReadyRewad)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,readyRewad$field);
         }
         if(hasFinalScore)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,finalScore$field);
         }
         if(hasFinalOrder)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,finalOrder$field);
         }
         if(hasFinalRewad)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,finalRewad$field);
         }
         if(hasReadyTurn)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,readyTurn$field);
         }
         if(hasFinalTurn)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,finalTurn$field);
         }
         if(hasReadyWinCount)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,readyWinCount$field);
         }
         if(hasFinalWinCount)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,finalWinCount$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,27);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         if(hasBattleResult)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,battle_result$field);
         }
         if(hasBet_Index)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,bet_Index$field);
         }
         if(hasFightPowerOrder)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,fightPowerOrder$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc28_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc30_:uint = 0;
         var _loc22_:uint = 0;
         var _loc19_:uint = 0;
         var _loc26_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc16_:uint = 0;
         var _loc7_:uint = 0;
         var _loc24_:uint = 0;
         var _loc5_:uint = 0;
         var _loc33_:uint = 0;
         var _loc18_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc34_:uint = 0;
         var _loc27_:uint = 0;
         var _loc20_:uint = 0;
         var _loc12_:uint = 0;
         var _loc31_:uint = 0;
         var _loc25_:uint = 0;
         var _loc32_:uint = 0;
         var _loc23_:uint = 0;
         var _loc29_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.userId cannot be set twice.");
                  }
                  _loc28_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.nickName cannot be set twice.");
                  }
                  _loc13_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.userKeys cannot be set twice.");
                  }
                  _loc10_++;
                  userKeys = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.job cannot be set twice.");
                  }
                  _loc17_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.sexJob cannot be set twice.");
                  }
                  _loc30_++;
                  sexJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.grades cannot be set twice.");
                  }
                  _loc22_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.fashionArm cannot be set twice.");
                  }
                  _loc19_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.fashionWing cannot be set twice.");
                  }
                  _loc26_++;
                  fashionWing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.fashionCloth cannot be set twice.");
                  }
                  _loc3_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.fashionHair cannot be set twice.");
                  }
                  _loc11_++;
                  fashionHair = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.fashionHat cannot be set twice.");
                  }
                  _loc4_++;
                  fashionHat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.arm cannot be set twice.");
                  }
                  _loc16_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.isVip cannot be set twice.");
                  }
                  _loc7_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc24_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.readyScore cannot be set twice.");
                  }
                  _loc5_++;
                  readyScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.readyOrder cannot be set twice.");
                  }
                  _loc33_++;
                  readyOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.readyRewad cannot be set twice.");
                  }
                  _loc18_++;
                  readyRewad = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.finalScore cannot be set twice.");
                  }
                  _loc8_++;
                  finalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.finalOrder cannot be set twice.");
                  }
                  _loc15_++;
                  finalOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.finalRewad cannot be set twice.");
                  }
                  _loc34_++;
                  finalRewad = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.readyTurn cannot be set twice.");
                  }
                  _loc27_++;
                  readyTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.finalTurn cannot be set twice.");
                  }
                  _loc20_++;
                  finalTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.readyWinCount cannot be set twice.");
                  }
                  _loc12_++;
                  readyWinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.finalWinCount cannot be set twice.");
                  }
                  _loc31_++;
                  finalWinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.isExist cannot be set twice.");
                  }
                  _loc25_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 27:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.property1 cannot be set twice.");
                  }
                  _loc32_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 28:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.property2 cannot be set twice.");
                  }
                  _loc23_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 29:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.battleResult cannot be set twice.");
                  }
                  _loc29_++;
                  battleResult = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.bet_Index cannot be set twice.");
                  }
                  _loc6_++;
                  bet_Index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: LordsBaseInfoMsg.fightPowerOrder cannot be set twice.");
                  }
                  _loc14_++;
                  fightPowerOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

