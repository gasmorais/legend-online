package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MemoryCardMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curTurn$field:int;
      
      private var score$field:int;
      
      private var addScore$field:int;
      
      private var addScore2$field:int;
      
      private var cIndex1$field:int;
      
      private var cIndex2$field:int;
      
      private var result$field:Boolean;
      
      private var leftAutoChance$field:int;
      
      private var leftCheckChance$field:int;
      
      private var duration$field:int;
      
      [ArrayElementType("com.road.yishi.proto.minigame.MemoryCard")]
      public var cards:Array = [];
      
      public function MemoryCardMsg()
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
      
      public function removeAddScore2() : void
      {
         hasField$0 &= 4294967279;
         addScore2$field = new int();
      }
      
      public function get hasAddScore2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set addScore2(param1:int) : void
      {
         hasField$0 |= 16;
         addScore2$field = param1;
      }
      
      public function get addScore2() : int
      {
         return addScore2$field;
      }
      
      public function removeCIndex1() : void
      {
         hasField$0 &= 4294967263;
         cIndex1$field = new int();
      }
      
      public function get hasCIndex1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set cIndex1(param1:int) : void
      {
         hasField$0 |= 32;
         cIndex1$field = param1;
      }
      
      public function get cIndex1() : int
      {
         return cIndex1$field;
      }
      
      public function removeCIndex2() : void
      {
         hasField$0 &= 4294967231;
         cIndex2$field = new int();
      }
      
      public function get hasCIndex2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set cIndex2(param1:int) : void
      {
         hasField$0 |= 64;
         cIndex2$field = param1;
      }
      
      public function get cIndex2() : int
      {
         return cIndex2$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967167;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 128;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeLeftAutoChance() : void
      {
         hasField$0 &= 4294967039;
         leftAutoChance$field = new int();
      }
      
      public function get hasLeftAutoChance() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set leftAutoChance(param1:int) : void
      {
         hasField$0 |= 256;
         leftAutoChance$field = param1;
      }
      
      public function get leftAutoChance() : int
      {
         return leftAutoChance$field;
      }
      
      public function removeLeftCheckChance() : void
      {
         hasField$0 &= 4294966783;
         leftCheckChance$field = new int();
      }
      
      public function get hasLeftCheckChance() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set leftCheckChance(param1:int) : void
      {
         hasField$0 |= 512;
         leftCheckChance$field = param1;
      }
      
      public function get leftCheckChance() : int
      {
         return leftCheckChance$field;
      }
      
      public function removeDuration() : void
      {
         hasField$0 &= 4294966271;
         duration$field = new int();
      }
      
      public function get hasDuration() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set duration(param1:int) : void
      {
         hasField$0 |= 1024;
         duration$field = param1;
      }
      
      public function get duration() : int
      {
         return duration$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
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
         if(hasAddScore2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,addScore2$field);
         }
         if(hasCIndex1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,cIndex1$field);
         }
         if(hasCIndex2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,cIndex2$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasLeftAutoChance)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,leftAutoChance$field);
         }
         if(hasLeftCheckChance)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,leftCheckChance$field);
         }
         if(hasDuration)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,duration$field);
         }
         _loc2_ = 0;
         while(_loc2_ < cards.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,cards[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc9_:MemoryCard = null;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.op cannot be set twice.");
                  }
                  _loc14_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.curTurn cannot be set twice.");
                  }
                  _loc8_++;
                  curTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.score cannot be set twice.");
                  }
                  _loc13_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.addScore cannot be set twice.");
                  }
                  _loc11_++;
                  addScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.addScore2 cannot be set twice.");
                  }
                  _loc15_++;
                  addScore2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.cIndex1 cannot be set twice.");
                  }
                  _loc6_++;
                  cIndex1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.cIndex2 cannot be set twice.");
                  }
                  _loc4_++;
                  cIndex2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.result cannot be set twice.");
                  }
                  _loc3_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.leftAutoChance cannot be set twice.");
                  }
                  _loc5_++;
                  leftAutoChance = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.leftCheckChance cannot be set twice.");
                  }
                  _loc7_++;
                  leftCheckChance = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MemoryCardMsg.duration cannot be set twice.");
                  }
                  _loc10_++;
                  duration = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  _loc9_ = new MemoryCard();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  cards.push(_loc9_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

