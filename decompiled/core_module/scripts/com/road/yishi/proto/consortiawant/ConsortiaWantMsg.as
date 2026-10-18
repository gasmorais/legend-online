package com.road.yishi.proto.consortiawant
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWantMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var personalScore$field:int;
      
      private var consortiaScore$field:int;
      
      private var leftCount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.consortiawant.ConsortiaWantBoxStateMsg")]
      public var receiveState:Array = [];
      
      private var wantGoal$field:ConsortiaWantGoalMsg;
      
      private var myRank$field:int;
      
      private var totalScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.consortiawant.ConsortiaWantRankMsg")]
      public var rankInfos:Array = [];
      
      private var drawIndex$field:int;
      
      private var drawType$field:int;
      
      private var leftFreeRefreshCD$field:int;
      
      public function ConsortiaWantMsg()
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
      
      public function removePersonalScore() : void
      {
         hasField$0 &= 4294967293;
         personalScore$field = new int();
      }
      
      public function get hasPersonalScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set personalScore(param1:int) : void
      {
         hasField$0 |= 2;
         personalScore$field = param1;
      }
      
      public function get personalScore() : int
      {
         return personalScore$field;
      }
      
      public function removeConsortiaScore() : void
      {
         hasField$0 &= 4294967291;
         consortiaScore$field = new int();
      }
      
      public function get hasConsortiaScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set consortiaScore(param1:int) : void
      {
         hasField$0 |= 4;
         consortiaScore$field = param1;
      }
      
      public function get consortiaScore() : int
      {
         return consortiaScore$field;
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967287;
         leftCount$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 8;
         leftCount$field = param1;
      }
      
      public function get leftCount() : int
      {
         return leftCount$field;
      }
      
      public function removeWantGoal() : void
      {
         wantGoal$field = null;
      }
      
      public function get hasWantGoal() : Boolean
      {
         return wantGoal$field != null;
      }
      
      public function set wantGoal(param1:ConsortiaWantGoalMsg) : void
      {
         wantGoal$field = param1;
      }
      
      public function get wantGoal() : ConsortiaWantGoalMsg
      {
         return wantGoal$field;
      }
      
      public function removeMyRank() : void
      {
         hasField$0 &= 4294967279;
         myRank$field = new int();
      }
      
      public function get hasMyRank() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set myRank(param1:int) : void
      {
         hasField$0 |= 16;
         myRank$field = param1;
      }
      
      public function get myRank() : int
      {
         return myRank$field;
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
      
      public function removeDrawIndex() : void
      {
         hasField$0 &= 4294967231;
         drawIndex$field = new int();
      }
      
      public function get hasDrawIndex() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set drawIndex(param1:int) : void
      {
         hasField$0 |= 64;
         drawIndex$field = param1;
      }
      
      public function get drawIndex() : int
      {
         return drawIndex$field;
      }
      
      public function removeDrawType() : void
      {
         hasField$0 &= 4294967167;
         drawType$field = new int();
      }
      
      public function get hasDrawType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set drawType(param1:int) : void
      {
         hasField$0 |= 128;
         drawType$field = param1;
      }
      
      public function get drawType() : int
      {
         return drawType$field;
      }
      
      public function removeLeftFreeRefreshCD() : void
      {
         hasField$0 &= 4294967039;
         leftFreeRefreshCD$field = new int();
      }
      
      public function get hasLeftFreeRefreshCD() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set leftFreeRefreshCD(param1:int) : void
      {
         hasField$0 |= 256;
         leftFreeRefreshCD$field = param1;
      }
      
      public function get leftFreeRefreshCD() : int
      {
         return leftFreeRefreshCD$field;
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
         if(hasPersonalScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,personalScore$field);
         }
         if(hasConsortiaScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,consortiaScore$field);
         }
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,leftCount$field);
         }
         _loc3_ = 0;
         while(_loc3_ < receiveState.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,receiveState[_loc3_]);
            _loc3_++;
         }
         if(hasWantGoal)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,wantGoal$field);
         }
         if(hasMyRank)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,myRank$field);
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rankInfos.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,rankInfos[_loc2_]);
            _loc2_++;
         }
         if(hasDrawIndex)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,drawIndex$field);
         }
         if(hasDrawType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,drawType$field);
         }
         if(hasLeftFreeRefreshCD)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,leftFreeRefreshCD$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc3_:ConsortiaWantBoxStateMsg = null;
         var _loc7_:ConsortiaWantRankMsg = null;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.opType cannot be set twice.");
                  }
                  _loc11_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.personalScore cannot be set twice.");
                  }
                  _loc6_++;
                  personalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.consortiaScore cannot be set twice.");
                  }
                  _loc13_++;
                  consortiaScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.leftCount cannot be set twice.");
                  }
                  _loc14_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc3_ = new ConsortiaWantBoxStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  receiveState.push(_loc3_);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.wantGoal cannot be set twice.");
                  }
                  _loc8_++;
                  wantGoal = new ConsortiaWantGoalMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,wantGoal);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.myRank cannot be set twice.");
                  }
                  _loc4_++;
                  myRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.totalScore cannot be set twice.");
                  }
                  _loc5_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc7_ = new ConsortiaWantRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  rankInfos.push(_loc7_);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.drawIndex cannot be set twice.");
                  }
                  _loc10_++;
                  drawIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.drawType cannot be set twice.");
                  }
                  _loc12_++;
                  drawType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWantMsg.leftFreeRefreshCD cannot be set twice.");
                  }
                  _loc9_++;
                  leftFreeRefreshCD = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

