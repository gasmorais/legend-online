package com.road.yishi.proto.theseusdungeon
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusDungeonUserMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var level$field:int;
      
      private var freeActionNum$field:int;
      
      private var buyActionNum$field:int;
      
      private var dayPurchasableActionNum$field:int;
      
      [ArrayElementType("com.road.yishi.proto.theseusdungeon.TheseusDungeonBlockInfo")]
      public var blockInfo:Array = [];
      
      [ArrayElementType("int")]
      public var skillIdList:Array = [];
      
      public function TheseusDungeonUserMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeFreeActionNum() : void
      {
         hasField$0 &= 4294967291;
         freeActionNum$field = new int();
      }
      
      public function get hasFreeActionNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set freeActionNum(param1:int) : void
      {
         hasField$0 |= 4;
         freeActionNum$field = param1;
      }
      
      public function get freeActionNum() : int
      {
         return freeActionNum$field;
      }
      
      public function removeBuyActionNum() : void
      {
         hasField$0 &= 4294967287;
         buyActionNum$field = new int();
      }
      
      public function get hasBuyActionNum() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set buyActionNum(param1:int) : void
      {
         hasField$0 |= 8;
         buyActionNum$field = param1;
      }
      
      public function get buyActionNum() : int
      {
         return buyActionNum$field;
      }
      
      public function removeDayPurchasableActionNum() : void
      {
         hasField$0 &= 4294967279;
         dayPurchasableActionNum$field = new int();
      }
      
      public function get hasDayPurchasableActionNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set dayPurchasableActionNum(param1:int) : void
      {
         hasField$0 |= 16;
         dayPurchasableActionNum$field = param1;
      }
      
      public function get dayPurchasableActionNum() : int
      {
         return dayPurchasableActionNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasFreeActionNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,freeActionNum$field);
         }
         if(hasBuyActionNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buyActionNum$field);
         }
         if(hasDayPurchasableActionNum)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,dayPurchasableActionNum$field);
         }
         _loc2_ = 0;
         while(_loc2_ < blockInfo.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,blockInfo[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < skillIdList.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,skillIdList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:TheseusDungeonBlockInfo = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusDungeonUserMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusDungeonUserMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusDungeonUserMsg.freeActionNum cannot be set twice.");
                  }
                  _loc5_++;
                  freeActionNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusDungeonUserMsg.buyActionNum cannot be set twice.");
                  }
                  _loc7_++;
                  buyActionNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusDungeonUserMsg.dayPurchasableActionNum cannot be set twice.");
                  }
                  _loc8_++;
                  dayPurchasableActionNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc6_ = new TheseusDungeonBlockInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  blockInfo.push(_loc6_);
                  break;
               case 6:
                  if((_loc9_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillIdList);
                  }
                  else
                  {
                     skillIdList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

