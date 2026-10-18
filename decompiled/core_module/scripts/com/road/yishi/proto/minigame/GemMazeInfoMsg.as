package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GemMazeInfoMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.minigame.GemInfoMsg")]
      public var allGems:Array = [];
      
      private var score$field:int;
      
      private var hasField$0:uint = 0;
      
      private var weekScore$field:int;
      
      private var timesLeft$field:int;
      
      private var buyTimesLeft$field:int;
      
      private var helpTimesLeft$field:int;
      
      private var gemLevel$field:int;
      
      private var curExp$field:int;
      
      private var maxExp$field:int;
      
      private var boxMark$field:int;
      
      private var scoreOrder$field:int;
      
      [ArrayElementType("int")]
      public var boxesId:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.minigame.DropItemInfoMsg")]
      public var dropItemList:Array = [];
      
      public function GemMazeInfoMsg()
      {
         super();
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967294;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 1;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeWeekScore() : void
      {
         hasField$0 &= 4294967293;
         weekScore$field = new int();
      }
      
      public function get hasWeekScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set weekScore(param1:int) : void
      {
         hasField$0 |= 2;
         weekScore$field = param1;
      }
      
      public function get weekScore() : int
      {
         return weekScore$field;
      }
      
      public function removeTimesLeft() : void
      {
         hasField$0 &= 4294967291;
         timesLeft$field = new int();
      }
      
      public function get hasTimesLeft() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set timesLeft(param1:int) : void
      {
         hasField$0 |= 4;
         timesLeft$field = param1;
      }
      
      public function get timesLeft() : int
      {
         return timesLeft$field;
      }
      
      public function removeBuyTimesLeft() : void
      {
         hasField$0 &= 4294967287;
         buyTimesLeft$field = new int();
      }
      
      public function get hasBuyTimesLeft() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set buyTimesLeft(param1:int) : void
      {
         hasField$0 |= 8;
         buyTimesLeft$field = param1;
      }
      
      public function get buyTimesLeft() : int
      {
         return buyTimesLeft$field;
      }
      
      public function removeHelpTimesLeft() : void
      {
         hasField$0 &= 4294967279;
         helpTimesLeft$field = new int();
      }
      
      public function get hasHelpTimesLeft() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set helpTimesLeft(param1:int) : void
      {
         hasField$0 |= 16;
         helpTimesLeft$field = param1;
      }
      
      public function get helpTimesLeft() : int
      {
         return helpTimesLeft$field;
      }
      
      public function removeGemLevel() : void
      {
         hasField$0 &= 4294967263;
         gemLevel$field = new int();
      }
      
      public function get hasGemLevel() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set gemLevel(param1:int) : void
      {
         hasField$0 |= 32;
         gemLevel$field = param1;
      }
      
      public function get gemLevel() : int
      {
         return gemLevel$field;
      }
      
      public function removeCurExp() : void
      {
         hasField$0 &= 4294967231;
         curExp$field = new int();
      }
      
      public function get hasCurExp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set curExp(param1:int) : void
      {
         hasField$0 |= 64;
         curExp$field = param1;
      }
      
      public function get curExp() : int
      {
         return curExp$field;
      }
      
      public function removeMaxExp() : void
      {
         hasField$0 &= 4294967167;
         maxExp$field = new int();
      }
      
      public function get hasMaxExp() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set maxExp(param1:int) : void
      {
         hasField$0 |= 128;
         maxExp$field = param1;
      }
      
      public function get maxExp() : int
      {
         return maxExp$field;
      }
      
      public function removeBoxMark() : void
      {
         hasField$0 &= 4294967039;
         boxMark$field = new int();
      }
      
      public function get hasBoxMark() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set boxMark(param1:int) : void
      {
         hasField$0 |= 256;
         boxMark$field = param1;
      }
      
      public function get boxMark() : int
      {
         return boxMark$field;
      }
      
      public function removeScoreOrder() : void
      {
         hasField$0 &= 4294966783;
         scoreOrder$field = new int();
      }
      
      public function get hasScoreOrder() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set scoreOrder(param1:int) : void
      {
         hasField$0 |= 512;
         scoreOrder$field = param1;
      }
      
      public function get scoreOrder() : int
      {
         return scoreOrder$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < allGems.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,allGems[_loc2_]);
            _loc2_++;
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasWeekScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,weekScore$field);
         }
         if(hasTimesLeft)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,timesLeft$field);
         }
         if(hasBuyTimesLeft)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,buyTimesLeft$field);
         }
         if(hasHelpTimesLeft)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,helpTimesLeft$field);
         }
         if(hasGemLevel)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,gemLevel$field);
         }
         if(hasCurExp)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,curExp$field);
         }
         if(hasMaxExp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,maxExp$field);
         }
         if(hasBoxMark)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,boxMark$field);
         }
         if(hasScoreOrder)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,scoreOrder$field);
         }
         _loc4_ = 0;
         while(_loc4_ < boxesId.length)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,boxesId[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < dropItemList.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,dropItemList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc11_:GemInfoMsg = null;
         var _loc5_:DropItemInfoMsg = null;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc11_ = new GemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  allGems.push(_loc11_);
                  break;
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.score cannot be set twice.");
                  }
                  _loc13_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.weekScore cannot be set twice.");
                  }
                  _loc6_++;
                  weekScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.timesLeft cannot be set twice.");
                  }
                  _loc8_++;
                  timesLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.buyTimesLeft cannot be set twice.");
                  }
                  _loc15_++;
                  buyTimesLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.helpTimesLeft cannot be set twice.");
                  }
                  _loc9_++;
                  helpTimesLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.gemLevel cannot be set twice.");
                  }
                  _loc4_++;
                  gemLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.curExp cannot be set twice.");
                  }
                  _loc7_++;
                  curExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.maxExp cannot be set twice.");
                  }
                  _loc3_++;
                  maxExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.boxMark cannot be set twice.");
                  }
                  _loc14_++;
                  boxMark = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeInfoMsg.scoreOrder cannot be set twice.");
                  }
                  _loc10_++;
                  scoreOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,boxesId);
                  }
                  else
                  {
                     boxesId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 12:
                  _loc5_ = new DropItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  dropItemList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

