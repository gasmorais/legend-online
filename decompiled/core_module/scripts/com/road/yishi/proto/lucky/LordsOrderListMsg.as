package com.road.yishi.proto.lucky
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LordsOrderListMsg extends Message implements IExternalizable
   {
      
      private var leftTime$field:int;
      
      private var hasField$0:uint = 0;
      
      private var maxTurn$field:int;
      
      private var currTurn$field:int;
      
      private var myOrder$field:int;
      
      private var winCount$field:int;
      
      private var score$field:int;
      
      [ArrayElementType("com.road.yishi.proto.lucky.LordsBaseInfoMsg")]
      public var lordsInfo:Array = [];
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:String;
      
      private var param4$field:String;
      
      private var param5$field:Boolean;
      
      public function LordsOrderListMsg()
      {
         super();
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967294;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 1;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
      }
      
      public function removeMaxTurn() : void
      {
         hasField$0 &= 4294967293;
         maxTurn$field = new int();
      }
      
      public function get hasMaxTurn() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxTurn(param1:int) : void
      {
         hasField$0 |= 2;
         maxTurn$field = param1;
      }
      
      public function get maxTurn() : int
      {
         return maxTurn$field;
      }
      
      public function removeCurrTurn() : void
      {
         hasField$0 &= 4294967291;
         currTurn$field = new int();
      }
      
      public function get hasCurrTurn() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currTurn(param1:int) : void
      {
         hasField$0 |= 4;
         currTurn$field = param1;
      }
      
      public function get currTurn() : int
      {
         return currTurn$field;
      }
      
      public function removeMyOrder() : void
      {
         hasField$0 &= 4294967287;
         myOrder$field = new int();
      }
      
      public function get hasMyOrder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set myOrder(param1:int) : void
      {
         hasField$0 |= 8;
         myOrder$field = param1;
      }
      
      public function get myOrder() : int
      {
         return myOrder$field;
      }
      
      public function removeWinCount() : void
      {
         hasField$0 &= 4294967279;
         winCount$field = new int();
      }
      
      public function get hasWinCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set winCount(param1:int) : void
      {
         hasField$0 |= 16;
         winCount$field = param1;
      }
      
      public function get winCount() : int
      {
         return winCount$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967263;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 32;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967231;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 64;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967167;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 128;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         param3$field = null;
      }
      
      public function get hasParam3() : Boolean
      {
         return param3$field != null;
      }
      
      public function set param3(param1:String) : void
      {
         param3$field = param1;
      }
      
      public function get param3() : String
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         param4$field = null;
      }
      
      public function get hasParam4() : Boolean
      {
         return param4$field != null;
      }
      
      public function set param4(param1:String) : void
      {
         param4$field = param1;
      }
      
      public function get param4() : String
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         hasField$0 &= 4294967039;
         param5$field = new Boolean();
      }
      
      public function get hasParam5() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set param5(param1:Boolean) : void
      {
         hasField$0 |= 256;
         param5$field = param1;
      }
      
      public function get param5() : Boolean
      {
         return param5$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         if(hasMaxTurn)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,maxTurn$field);
         }
         if(hasCurrTurn)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,currTurn$field);
         }
         if(hasMyOrder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,myOrder$field);
         }
         if(hasWinCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,winCount$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         _loc2_ = 0;
         while(_loc2_ < lordsInfo.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,lordsInfo[_loc2_]);
            _loc2_++;
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,param5$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc3_:LordsBaseInfoMsg = null;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.leftTime cannot be set twice.");
                  }
                  _loc14_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.maxTurn cannot be set twice.");
                  }
                  _loc10_++;
                  maxTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.currTurn cannot be set twice.");
                  }
                  _loc9_++;
                  currTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.myOrder cannot be set twice.");
                  }
                  _loc11_++;
                  myOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.winCount cannot be set twice.");
                  }
                  _loc7_++;
                  winCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.score cannot be set twice.");
                  }
                  _loc13_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc3_ = new LordsBaseInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  lordsInfo.push(_loc3_);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.param2 cannot be set twice.");
                  }
                  _loc15_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.param3 cannot be set twice.");
                  }
                  _loc5_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.param4 cannot be set twice.");
                  }
                  _loc6_++;
                  param4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LordsOrderListMsg.param5 cannot be set twice.");
                  }
                  _loc8_++;
                  param5 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

