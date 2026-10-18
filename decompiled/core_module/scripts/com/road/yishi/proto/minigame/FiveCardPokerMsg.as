package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FiveCardPokerMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curTurn$field:int;
      
      private var score$field:int;
      
      private var addScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.minigame.FiveCardPoker")]
      public var pokers:Array = [];
      
      [ArrayElementType("int")]
      public var holdList:Array = [];
      
      public function FiveCardPokerMsg()
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
      
      public function removeCurTurn() : void
      {
         hasField$0 &= 4294967293;
         curTurn$field = new int();
      }
      
      public function get hasCurTurn() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curTurn(param1:int) : void
      {
         hasField$0 |= 2;
         curTurn$field = param1;
      }
      
      public function get curTurn() : int
      {
         return curTurn$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeAddScore() : void
      {
         hasField$0 &= 4294967287;
         addScore$field = new int();
      }
      
      public function get hasAddScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set addScore(param1:int) : void
      {
         hasField$0 |= 8;
         addScore$field = param1;
      }
      
      public function get addScore() : int
      {
         return addScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasCurTurn)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curTurn$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasAddScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,addScore$field);
         }
         _loc3_ = 0;
         while(_loc3_ < pokers.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,pokers[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < holdList.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,holdList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:FiveCardPoker = null;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FiveCardPokerMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FiveCardPokerMsg.curTurn cannot be set twice.");
                  }
                  _loc4_++;
                  curTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FiveCardPokerMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FiveCardPokerMsg.addScore cannot be set twice.");
                  }
                  _loc5_++;
                  addScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc3_ = new FiveCardPoker();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  pokers.push(_loc3_);
                  break;
               case 5:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,holdList);
                  }
                  else
                  {
                     holdList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

