package com.road.yishi.proto.matelords
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MateLordsListMsg extends Message implements IExternalizable
   {
      
      private var isSign$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var isOpen$field:Boolean;
      
      private var order$field:int;
      
      private var eventId$field:int;
      
      private var teamType$field:int;
      
      private var openTime$field:String;
      
      private var totalScore$field:int;
      
      private var altarScore$field:int;
      
      private var inspirLevel$field:int;
      
      private var maxTurnCount$field:int;
      
      private var currentTurn$field:int;
      
      private var leftTime$field:int;
      
      [ArrayElementType("com.road.yishi.proto.matelords.MateLordsInfoMsg")]
      public var info:Array = [];
      
      private var masterUserId$field:int;
      
      private var teamUid$field:String;
      
      private var teamName$field:String;
      
      private var warIndex$field:int;
      
      private var serverId$field:int;
      
      private var fashionArm$field:String;
      
      private var fashionWing$field:String;
      
      private var fashionCloth$field:String;
      
      private var fashionHair$field:String;
      
      private var fashionHat$field:String;
      
      private var arm$field:String;
      
      private var job$field:int;
      
      private var nickName$field:String;
      
      private var isOver$field:Boolean;
      
      private var sexJob$field:int;
      
      public function MateLordsListMsg()
      {
         super();
      }
      
      public function removeIsSign() : void
      {
         hasField$0 &= 4294967294;
         isSign$field = new Boolean();
      }
      
      public function get hasIsSign() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isSign(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isSign$field = param1;
      }
      
      public function get isSign() : Boolean
      {
         return isSign$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967293;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967291;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 4;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967287;
         eventId$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 8;
         eventId$field = param1;
      }
      
      public function get eventId() : int
      {
         return eventId$field;
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
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
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
      
      public function removeAltarScore() : void
      {
         hasField$0 &= 4294967231;
         altarScore$field = new int();
      }
      
      public function get hasAltarScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set altarScore(param1:int) : void
      {
         hasField$0 |= 64;
         altarScore$field = param1;
      }
      
      public function get altarScore() : int
      {
         return altarScore$field;
      }
      
      public function removeInspirLevel() : void
      {
         hasField$0 &= 4294967167;
         inspirLevel$field = new int();
      }
      
      public function get hasInspirLevel() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set inspirLevel(param1:int) : void
      {
         hasField$0 |= 128;
         inspirLevel$field = param1;
      }
      
      public function get inspirLevel() : int
      {
         return inspirLevel$field;
      }
      
      public function removeMaxTurnCount() : void
      {
         hasField$0 &= 4294967039;
         maxTurnCount$field = new int();
      }
      
      public function get hasMaxTurnCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set maxTurnCount(param1:int) : void
      {
         hasField$0 |= 256;
         maxTurnCount$field = param1;
      }
      
      public function get maxTurnCount() : int
      {
         return maxTurnCount$field;
      }
      
      public function removeCurrentTurn() : void
      {
         hasField$0 &= 4294966783;
         currentTurn$field = new int();
      }
      
      public function get hasCurrentTurn() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set currentTurn(param1:int) : void
      {
         hasField$0 |= 512;
         currentTurn$field = param1;
      }
      
      public function get currentTurn() : int
      {
         return currentTurn$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294966271;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 1024;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
      }
      
      public function removeMasterUserId() : void
      {
         hasField$0 &= 4294965247;
         masterUserId$field = new int();
      }
      
      public function get hasMasterUserId() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set masterUserId(param1:int) : void
      {
         hasField$0 |= 2048;
         masterUserId$field = param1;
      }
      
      public function get masterUserId() : int
      {
         return masterUserId$field;
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
      
      public function removeWarIndex() : void
      {
         hasField$0 &= 4294963199;
         warIndex$field = new int();
      }
      
      public function get hasWarIndex() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set warIndex(param1:int) : void
      {
         hasField$0 |= 4096;
         warIndex$field = param1;
      }
      
      public function get warIndex() : int
      {
         return warIndex$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294959103;
         serverId$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 8192;
         serverId$field = param1;
      }
      
      public function get serverId() : int
      {
         return serverId$field;
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
      
      public function removeJob() : void
      {
         hasField$0 &= 4294950911;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 16384;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
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
      
      public function removeIsOver() : void
      {
         hasField$0 &= 4294934527;
         isOver$field = new Boolean();
      }
      
      public function get hasIsOver() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set isOver(param1:Boolean) : void
      {
         hasField$0 |= 32768;
         isOver$field = param1;
      }
      
      public function get isOver() : Boolean
      {
         return isOver$field;
      }
      
      public function removeSexJob() : void
      {
         hasField$0 &= 4294901759;
         sexJob$field = new int();
      }
      
      public function get hasSexJob() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set sexJob(param1:int) : void
      {
         hasField$0 |= 65536;
         sexJob$field = param1;
      }
      
      public function get sexJob() : int
      {
         return sexJob$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIsSign)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isSign$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,eventId$field);
         }
         if(hasTeamType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,teamType$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         if(hasAltarScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,altarScore$field);
         }
         if(hasInspirLevel)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,inspirLevel$field);
         }
         if(hasMaxTurnCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,maxTurnCount$field);
         }
         if(hasCurrentTurn)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,currentTurn$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasMasterUserId)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,masterUserId$field);
         }
         if(hasTeamUid)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,teamUid$field);
         }
         if(hasTeamName)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,teamName$field);
         }
         if(hasWarIndex)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,warIndex$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,serverId$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionWing)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,fashionWing$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasFashionHair)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,fashionHair$field);
         }
         if(hasFashionHat)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,fashionHat$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,26);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasIsOver)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_BOOL(param1,isOver$field);
         }
         if(hasSexJob)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,sexJob$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc14_:MateLordsInfoMsg = null;
         var _loc20_:uint = 0;
         var _loc27_:uint = 0;
         var _loc28_:uint = 0;
         var _loc15_:uint = 0;
         var _loc19_:uint = 0;
         var _loc25_:uint = 0;
         var _loc22_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc30_:uint = 0;
         var _loc21_:uint = 0;
         var _loc31_:uint = 0;
         var _loc18_:uint = 0;
         var _loc23_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc26_:uint = 0;
         var _loc16_:uint = 0;
         var _loc24_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc29_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.isSign cannot be set twice.");
                  }
                  _loc20_++;
                  isSign = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.isOpen cannot be set twice.");
                  }
                  _loc27_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.order cannot be set twice.");
                  }
                  _loc28_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.eventId cannot be set twice.");
                  }
                  _loc15_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.teamType cannot be set twice.");
                  }
                  _loc19_++;
                  teamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.openTime cannot be set twice.");
                  }
                  _loc25_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.totalScore cannot be set twice.");
                  }
                  _loc22_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.altarScore cannot be set twice.");
                  }
                  _loc5_++;
                  altarScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.inspirLevel cannot be set twice.");
                  }
                  _loc6_++;
                  inspirLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.maxTurnCount cannot be set twice.");
                  }
                  _loc30_++;
                  maxTurnCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.currentTurn cannot be set twice.");
                  }
                  _loc21_++;
                  currentTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.leftTime cannot be set twice.");
                  }
                  _loc31_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  _loc14_ = new MateLordsInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  info.push(_loc14_);
                  break;
               case 14:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.masterUserId cannot be set twice.");
                  }
                  _loc18_++;
                  masterUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.teamUid cannot be set twice.");
                  }
                  _loc23_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.teamName cannot be set twice.");
                  }
                  _loc9_++;
                  teamName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.warIndex cannot be set twice.");
                  }
                  _loc7_++;
                  warIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.serverId cannot be set twice.");
                  }
                  _loc26_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.fashionArm cannot be set twice.");
                  }
                  _loc16_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.fashionWing cannot be set twice.");
                  }
                  _loc24_++;
                  fashionWing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.fashionCloth cannot be set twice.");
                  }
                  _loc3_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.fashionHair cannot be set twice.");
                  }
                  _loc10_++;
                  fashionHair = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.fashionHat cannot be set twice.");
                  }
                  _loc4_++;
                  fashionHat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 24:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.arm cannot be set twice.");
                  }
                  _loc12_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 25:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.job cannot be set twice.");
                  }
                  _loc13_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.nickName cannot be set twice.");
                  }
                  _loc11_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 27:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.isOver cannot be set twice.");
                  }
                  _loc8_++;
                  isOver = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 28:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: MateLordsListMsg.sexJob cannot be set twice.");
                  }
                  _loc29_++;
                  sexJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

