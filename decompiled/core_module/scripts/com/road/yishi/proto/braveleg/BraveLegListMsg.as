package com.road.yishi.proto.braveleg
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BraveLegListMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var eventId$field:int;
      
      private var uid$field:String;
      
      private var userId$field:int;
      
      private var serverId$field:int;
      
      private var openTime$field:String;
      
      private var isSign$field:Boolean;
      
      private var isOpen$field:Boolean;
      
      private var leftTime$field:int;
      
      private var season$field:int;
      
      private var warIndex$field:int;
      
      private var currentTurn$field:int;
      
      private var maxTurnCount$field:int;
      
      private var totalScore$field:int;
      
      private var teamType$field:int;
      
      private var order$field:int;
      
      private var isOver$field:Boolean;
      
      private var leftWarIndex$field:int;
      
      [ArrayElementType("com.road.yishi.proto.braveleg.BraveLegInfoMsg")]
      public var info:Array = [];
      
      private var headId$field:int;
      
      private var groupId$field:int;
      
      private var skillMasterType$field:int;
      
      public function BraveLegListMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967293;
         eventId$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 2;
         eventId$field = param1;
      }
      
      public function get eventId() : int
      {
         return eventId$field;
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
         hasField$0 &= 4294967291;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294967287;
         serverId$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 8;
         serverId$field = param1;
      }
      
      public function get serverId() : int
      {
         return serverId$field;
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
      
      public function removeIsSign() : void
      {
         hasField$0 &= 4294967279;
         isSign$field = new Boolean();
      }
      
      public function get hasIsSign() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isSign(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isSign$field = param1;
      }
      
      public function get isSign() : Boolean
      {
         return isSign$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967263;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967231;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 64;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
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
      
      public function removeWarIndex() : void
      {
         hasField$0 &= 4294967039;
         warIndex$field = new int();
      }
      
      public function get hasWarIndex() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set warIndex(param1:int) : void
      {
         hasField$0 |= 256;
         warIndex$field = param1;
      }
      
      public function get warIndex() : int
      {
         return warIndex$field;
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
      
      public function removeMaxTurnCount() : void
      {
         hasField$0 &= 4294966271;
         maxTurnCount$field = new int();
      }
      
      public function get hasMaxTurnCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set maxTurnCount(param1:int) : void
      {
         hasField$0 |= 1024;
         maxTurnCount$field = param1;
      }
      
      public function get maxTurnCount() : int
      {
         return maxTurnCount$field;
      }
      
      public function removeTotalScore() : void
      {
         hasField$0 &= 4294965247;
         totalScore$field = new int();
      }
      
      public function get hasTotalScore() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set totalScore(param1:int) : void
      {
         hasField$0 |= 2048;
         totalScore$field = param1;
      }
      
      public function get totalScore() : int
      {
         return totalScore$field;
      }
      
      public function removeTeamType() : void
      {
         hasField$0 &= 4294963199;
         teamType$field = new int();
      }
      
      public function get hasTeamType() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set teamType(param1:int) : void
      {
         hasField$0 |= 4096;
         teamType$field = param1;
      }
      
      public function get teamType() : int
      {
         return teamType$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294959103;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 8192;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeIsOver() : void
      {
         hasField$0 &= 4294950911;
         isOver$field = new Boolean();
      }
      
      public function get hasIsOver() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set isOver(param1:Boolean) : void
      {
         hasField$0 |= 16384;
         isOver$field = param1;
      }
      
      public function get isOver() : Boolean
      {
         return isOver$field;
      }
      
      public function removeLeftWarIndex() : void
      {
         hasField$0 &= 4294934527;
         leftWarIndex$field = new int();
      }
      
      public function get hasLeftWarIndex() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set leftWarIndex(param1:int) : void
      {
         hasField$0 |= 32768;
         leftWarIndex$field = param1;
      }
      
      public function get leftWarIndex() : int
      {
         return leftWarIndex$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294901759;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 65536;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294836223;
         groupId$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 131072;
         groupId$field = param1;
      }
      
      public function get groupId() : int
      {
         return groupId$field;
      }
      
      public function removeSkillMasterType() : void
      {
         hasField$0 &= 4294705151;
         skillMasterType$field = new int();
      }
      
      public function get hasSkillMasterType() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set skillMasterType(param1:int) : void
      {
         hasField$0 |= 262144;
         skillMasterType$field = param1;
      }
      
      public function get skillMasterType() : int
      {
         return skillMasterType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,eventId$field);
         }
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,serverId$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasIsSign)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isSign$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         if(hasSeason)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,season$field);
         }
         if(hasWarIndex)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,warIndex$field);
         }
         if(hasCurrentTurn)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,currentTurn$field);
         }
         if(hasMaxTurnCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,maxTurnCount$field);
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         if(hasTeamType)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,teamType$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasIsOver)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,isOver$field);
         }
         if(hasLeftWarIndex)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,leftWarIndex$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,groupId$field);
         }
         if(hasSkillMasterType)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,skillMasterType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:BraveLegInfoMsg = null;
         var _loc23_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:uint = 0;
         var _loc18_:uint = 0;
         var _loc13_:uint = 0;
         var _loc21_:uint = 0;
         var _loc24_:uint = 0;
         var _loc20_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc25_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc22_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.op cannot be set twice.");
                  }
                  _loc23_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.eventId cannot be set twice.");
                  }
                  _loc7_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.uid cannot be set twice.");
                  }
                  _loc10_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.userId cannot be set twice.");
                  }
                  _loc17_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.serverId cannot be set twice.");
                  }
                  _loc19_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.openTime cannot be set twice.");
                  }
                  _loc18_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.isSign cannot be set twice.");
                  }
                  _loc13_++;
                  isSign = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.isOpen cannot be set twice.");
                  }
                  _loc21_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.leftTime cannot be set twice.");
                  }
                  _loc24_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.season cannot be set twice.");
                  }
                  _loc20_++;
                  season = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.warIndex cannot be set twice.");
                  }
                  _loc3_++;
                  warIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.currentTurn cannot be set twice.");
                  }
                  _loc14_++;
                  currentTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.maxTurnCount cannot be set twice.");
                  }
                  _loc25_++;
                  maxTurnCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.totalScore cannot be set twice.");
                  }
                  _loc15_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.teamType cannot be set twice.");
                  }
                  _loc12_++;
                  teamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.order cannot be set twice.");
                  }
                  _loc22_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.isOver cannot be set twice.");
                  }
                  _loc4_++;
                  isOver = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.leftWarIndex cannot be set twice.");
                  }
                  _loc5_++;
                  leftWarIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  _loc6_ = new BraveLegInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  info.push(_loc6_);
                  break;
               case 20:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.headId cannot be set twice.");
                  }
                  _loc16_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.groupId cannot be set twice.");
                  }
                  _loc11_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BraveLegListMsg.skillMasterType cannot be set twice.");
                  }
                  _loc8_++;
                  skillMasterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

