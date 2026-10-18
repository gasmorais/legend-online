package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialPointMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var layNumId$field:int;
      
      private var posIndex$field:int;
      
      private var army$field:ArmyMsg;
      
      private var uuid$field:String;
      
      private var svrName$field:String;
      
      private var lordInfo$field:String;
      
      private var petsInfo$field:String;
      
      private var childInfo$field:String;
      
      [ArrayElementType("com.road.yishi.proto.battle.SkyTrialPointInfoMsg")]
      public var pointInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.SkyTrialOrderInfoMsg")]
      public var orderInfo:Array = [];
      
      private var eventId$field:int;
      
      private var myDayOrder$field:int;
      
      private var myDayTimer$field:int;
      
      private var myWeekOrder$field:int;
      
      private var myWeekTimer$field:int;
      
      private var isOccpPoint$field:Boolean;
      
      public function SkyTrialPointMsg()
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
      
      public function removeLayNumId() : void
      {
         hasField$0 &= 4294967293;
         layNumId$field = new int();
      }
      
      public function get hasLayNumId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set layNumId(param1:int) : void
      {
         hasField$0 |= 2;
         layNumId$field = param1;
      }
      
      public function get layNumId() : int
      {
         return layNumId$field;
      }
      
      public function removePosIndex() : void
      {
         hasField$0 &= 4294967291;
         posIndex$field = new int();
      }
      
      public function get hasPosIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posIndex(param1:int) : void
      {
         hasField$0 |= 4;
         posIndex$field = param1;
      }
      
      public function get posIndex() : int
      {
         return posIndex$field;
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
      
      public function removeSvrName() : void
      {
         svrName$field = null;
      }
      
      public function get hasSvrName() : Boolean
      {
         return svrName$field != null;
      }
      
      public function set svrName(param1:String) : void
      {
         svrName$field = param1;
      }
      
      public function get svrName() : String
      {
         return svrName$field;
      }
      
      public function removeLordInfo() : void
      {
         lordInfo$field = null;
      }
      
      public function get hasLordInfo() : Boolean
      {
         return lordInfo$field != null;
      }
      
      public function set lordInfo(param1:String) : void
      {
         lordInfo$field = param1;
      }
      
      public function get lordInfo() : String
      {
         return lordInfo$field;
      }
      
      public function removePetsInfo() : void
      {
         petsInfo$field = null;
      }
      
      public function get hasPetsInfo() : Boolean
      {
         return petsInfo$field != null;
      }
      
      public function set petsInfo(param1:String) : void
      {
         petsInfo$field = param1;
      }
      
      public function get petsInfo() : String
      {
         return petsInfo$field;
      }
      
      public function removeChildInfo() : void
      {
         childInfo$field = null;
      }
      
      public function get hasChildInfo() : Boolean
      {
         return childInfo$field != null;
      }
      
      public function set childInfo(param1:String) : void
      {
         childInfo$field = param1;
      }
      
      public function get childInfo() : String
      {
         return childInfo$field;
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
      
      public function removeMyDayOrder() : void
      {
         hasField$0 &= 4294967279;
         myDayOrder$field = new int();
      }
      
      public function get hasMyDayOrder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set myDayOrder(param1:int) : void
      {
         hasField$0 |= 16;
         myDayOrder$field = param1;
      }
      
      public function get myDayOrder() : int
      {
         return myDayOrder$field;
      }
      
      public function removeMyDayTimer() : void
      {
         hasField$0 &= 4294967263;
         myDayTimer$field = new int();
      }
      
      public function get hasMyDayTimer() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set myDayTimer(param1:int) : void
      {
         hasField$0 |= 32;
         myDayTimer$field = param1;
      }
      
      public function get myDayTimer() : int
      {
         return myDayTimer$field;
      }
      
      public function removeMyWeekOrder() : void
      {
         hasField$0 &= 4294967231;
         myWeekOrder$field = new int();
      }
      
      public function get hasMyWeekOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set myWeekOrder(param1:int) : void
      {
         hasField$0 |= 64;
         myWeekOrder$field = param1;
      }
      
      public function get myWeekOrder() : int
      {
         return myWeekOrder$field;
      }
      
      public function removeMyWeekTimer() : void
      {
         hasField$0 &= 4294967167;
         myWeekTimer$field = new int();
      }
      
      public function get hasMyWeekTimer() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set myWeekTimer(param1:int) : void
      {
         hasField$0 |= 128;
         myWeekTimer$field = param1;
      }
      
      public function get myWeekTimer() : int
      {
         return myWeekTimer$field;
      }
      
      public function removeIsOccpPoint() : void
      {
         hasField$0 &= 4294967039;
         isOccpPoint$field = new Boolean();
      }
      
      public function get hasIsOccpPoint() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isOccpPoint(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isOccpPoint$field = param1;
      }
      
      public function get isOccpPoint() : Boolean
      {
         return isOccpPoint$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasLayNumId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,layNumId$field);
         }
         if(hasPosIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,posIndex$field);
         }
         if(hasArmy)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,army$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasSvrName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,svrName$field);
         }
         if(hasLordInfo)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,lordInfo$field);
         }
         if(hasPetsInfo)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,petsInfo$field);
         }
         if(hasChildInfo)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,childInfo$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pointInfo.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,pointInfo[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < orderInfo.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,orderInfo[_loc3_]);
            _loc3_++;
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,eventId$field);
         }
         if(hasMyDayOrder)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,myDayOrder$field);
         }
         if(hasMyDayTimer)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,myDayTimer$field);
         }
         if(hasMyWeekOrder)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,myWeekOrder$field);
         }
         if(hasMyWeekTimer)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,myWeekTimer$field);
         }
         if(hasIsOccpPoint)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,isOccpPoint$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc13_:SkyTrialPointInfoMsg = null;
         var _loc3_:SkyTrialOrderInfoMsg = null;
         var _loc20_:uint = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc19_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc17_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc16_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.op cannot be set twice.");
                  }
                  _loc20_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.layNumId cannot be set twice.");
                  }
                  _loc4_++;
                  layNumId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.posIndex cannot be set twice.");
                  }
                  _loc14_++;
                  posIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.army cannot be set twice.");
                  }
                  _loc19_++;
                  army = new ArmyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,army);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.uuid cannot be set twice.");
                  }
                  _loc12_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.svrName cannot be set twice.");
                  }
                  _loc10_++;
                  svrName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.lordInfo cannot be set twice.");
                  }
                  _loc5_++;
                  lordInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.petsInfo cannot be set twice.");
                  }
                  _loc6_++;
                  petsInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.childInfo cannot be set twice.");
                  }
                  _loc8_++;
                  childInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  _loc13_ = new SkyTrialPointInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  pointInfo.push(_loc13_);
                  break;
               case 10:
                  _loc3_ = new SkyTrialOrderInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  orderInfo.push(_loc3_);
                  break;
               case 11:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.eventId cannot be set twice.");
                  }
                  _loc17_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.myDayOrder cannot be set twice.");
                  }
                  _loc7_++;
                  myDayOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.myDayTimer cannot be set twice.");
                  }
                  _loc15_++;
                  myDayTimer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.myWeekOrder cannot be set twice.");
                  }
                  _loc9_++;
                  myWeekOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.myWeekTimer cannot be set twice.");
                  }
                  _loc16_++;
                  myWeekTimer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointMsg.isOccpPoint cannot be set twice.");
                  }
                  _loc11_++;
                  isOccpPoint = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

