package com.road.yishi.proto.guardendless
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GuardendlessOpMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.guardendless.GuardEndlessBossMsg")]
      public var bossInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.guardendless.GuardEndlessPosMsg")]
      public var guardPos:Array = [];
      
      private var bossNum$field:int;
      
      private var index$field:int;
      
      private var plies$field:int;
      
      private var maxIndex$field:int;
      
      private var guardSealNum$field:int;
      
      private var items$field:String;
      
      private var sweepTime$field:String;
      
      private var sweepIndex$field:int;
      
      private var resetTime$field:String;
      
      private var payType$field:int;
      
      private var isFinishes$field:Boolean;
      
      private var isHorrible$field:Boolean;
      
      public function GuardendlessOpMsg()
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
      
      public function removeBossNum() : void
      {
         hasField$0 &= 4294967293;
         bossNum$field = new int();
      }
      
      public function get hasBossNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bossNum(param1:int) : void
      {
         hasField$0 |= 2;
         bossNum$field = param1;
      }
      
      public function get bossNum() : int
      {
         return bossNum$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967291;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 4;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removePlies() : void
      {
         hasField$0 &= 4294967287;
         plies$field = new int();
      }
      
      public function get hasPlies() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set plies(param1:int) : void
      {
         hasField$0 |= 8;
         plies$field = param1;
      }
      
      public function get plies() : int
      {
         return plies$field;
      }
      
      public function removeMaxIndex() : void
      {
         hasField$0 &= 4294967279;
         maxIndex$field = new int();
      }
      
      public function get hasMaxIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set maxIndex(param1:int) : void
      {
         hasField$0 |= 16;
         maxIndex$field = param1;
      }
      
      public function get maxIndex() : int
      {
         return maxIndex$field;
      }
      
      public function removeGuardSealNum() : void
      {
         hasField$0 &= 4294967263;
         guardSealNum$field = new int();
      }
      
      public function get hasGuardSealNum() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set guardSealNum(param1:int) : void
      {
         hasField$0 |= 32;
         guardSealNum$field = param1;
      }
      
      public function get guardSealNum() : int
      {
         return guardSealNum$field;
      }
      
      public function removeItems() : void
      {
         items$field = null;
      }
      
      public function get hasItems() : Boolean
      {
         return items$field != null;
      }
      
      public function set items(param1:String) : void
      {
         items$field = param1;
      }
      
      public function get items() : String
      {
         return items$field;
      }
      
      public function removeSweepTime() : void
      {
         sweepTime$field = null;
      }
      
      public function get hasSweepTime() : Boolean
      {
         return sweepTime$field != null;
      }
      
      public function set sweepTime(param1:String) : void
      {
         sweepTime$field = param1;
      }
      
      public function get sweepTime() : String
      {
         return sweepTime$field;
      }
      
      public function removeSweepIndex() : void
      {
         hasField$0 &= 4294967231;
         sweepIndex$field = new int();
      }
      
      public function get hasSweepIndex() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set sweepIndex(param1:int) : void
      {
         hasField$0 |= 64;
         sweepIndex$field = param1;
      }
      
      public function get sweepIndex() : int
      {
         return sweepIndex$field;
      }
      
      public function removeResetTime() : void
      {
         resetTime$field = null;
      }
      
      public function get hasResetTime() : Boolean
      {
         return resetTime$field != null;
      }
      
      public function set resetTime(param1:String) : void
      {
         resetTime$field = param1;
      }
      
      public function get resetTime() : String
      {
         return resetTime$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967167;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 128;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeIsFinishes() : void
      {
         hasField$0 &= 4294967039;
         isFinishes$field = new Boolean();
      }
      
      public function get hasIsFinishes() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isFinishes(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isFinishes$field = param1;
      }
      
      public function get isFinishes() : Boolean
      {
         return isFinishes$field;
      }
      
      public function removeIsHorrible() : void
      {
         hasField$0 &= 4294966783;
         isHorrible$field = new Boolean();
      }
      
      public function get hasIsHorrible() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isHorrible(param1:Boolean) : void
      {
         hasField$0 |= 512;
         isHorrible$field = param1;
      }
      
      public function get isHorrible() : Boolean
      {
         return isHorrible$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         _loc3_ = 0;
         while(_loc3_ < bossInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,bossInfo[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < guardPos.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,guardPos[_loc2_]);
            _loc2_++;
         }
         if(hasBossNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,bossNum$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasPlies)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,plies$field);
         }
         if(hasMaxIndex)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,maxIndex$field);
         }
         if(hasGuardSealNum)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,guardSealNum$field);
         }
         if(hasItems)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,items$field);
         }
         if(hasSweepTime)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,sweepTime$field);
         }
         if(hasSweepIndex)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,sweepIndex$field);
         }
         if(hasResetTime)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,resetTime$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasIsFinishes)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,isFinishes$field);
         }
         if(hasIsHorrible)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,isHorrible$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc10_:GuardEndlessBossMsg = null;
         var _loc18_:GuardEndlessPosMsg = null;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc15_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.opType cannot be set twice.");
                  }
                  _loc11_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc10_ = new GuardEndlessBossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  bossInfo.push(_loc10_);
                  break;
               case 2:
                  _loc18_ = new GuardEndlessPosMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc18_);
                  guardPos.push(_loc18_);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.bossNum cannot be set twice.");
                  }
                  _loc6_++;
                  bossNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.index cannot be set twice.");
                  }
                  _loc8_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.plies cannot be set twice.");
                  }
                  _loc9_++;
                  plies = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.maxIndex cannot be set twice.");
                  }
                  _loc4_++;
                  maxIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.guardSealNum cannot be set twice.");
                  }
                  _loc3_++;
                  guardSealNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.items cannot be set twice.");
                  }
                  _loc17_++;
                  items = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.sweepTime cannot be set twice.");
                  }
                  _loc7_++;
                  sweepTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.sweepIndex cannot be set twice.");
                  }
                  _loc13_++;
                  sweepIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.resetTime cannot be set twice.");
                  }
                  _loc14_++;
                  resetTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.payType cannot be set twice.");
                  }
                  _loc12_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.isFinishes cannot be set twice.");
                  }
                  _loc15_++;
                  isFinishes = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GuardendlessOpMsg.isHorrible cannot be set twice.");
                  }
                  _loc5_++;
                  isHorrible = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

