package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GemInfoUpdateMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.minigame.GemInfoMsg")]
      public var gemDel:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.minigame.GemInfoMsg")]
      public var gemAdd:Array = [];
      
      [ArrayElementType("int")]
      public var score:Array = [];
      
      private var curExp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var maxExp$field:int;
      
      private var gemLevel$field:int;
      
      private var scoreOrder$field:int;
      
      [ArrayElementType("com.road.yishi.proto.minigame.RewardInfoMsg")]
      public var rewardInfo:Array = [];
      
      public function GemInfoUpdateMsg()
      {
         super();
      }
      
      public function removeCurExp() : void
      {
         hasField$0 &= 4294967294;
         curExp$field = new int();
      }
      
      public function get hasCurExp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curExp(param1:int) : void
      {
         hasField$0 |= 1;
         curExp$field = param1;
      }
      
      public function get curExp() : int
      {
         return curExp$field;
      }
      
      public function removeMaxExp() : void
      {
         hasField$0 &= 4294967293;
         maxExp$field = new int();
      }
      
      public function get hasMaxExp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxExp(param1:int) : void
      {
         hasField$0 |= 2;
         maxExp$field = param1;
      }
      
      public function get maxExp() : int
      {
         return maxExp$field;
      }
      
      public function removeGemLevel() : void
      {
         hasField$0 &= 4294967291;
         gemLevel$field = new int();
      }
      
      public function get hasGemLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gemLevel(param1:int) : void
      {
         hasField$0 |= 4;
         gemLevel$field = param1;
      }
      
      public function get gemLevel() : int
      {
         return gemLevel$field;
      }
      
      public function removeScoreOrder() : void
      {
         hasField$0 &= 4294967287;
         scoreOrder$field = new int();
      }
      
      public function get hasScoreOrder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set scoreOrder(param1:int) : void
      {
         hasField$0 |= 8;
         scoreOrder$field = param1;
      }
      
      public function get scoreOrder() : int
      {
         return scoreOrder$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < gemDel.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,gemDel[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < gemAdd.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,gemAdd[_loc2_]);
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < score.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score[_loc5_]);
            _loc5_++;
         }
         if(hasCurExp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,curExp$field);
         }
         if(hasMaxExp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,maxExp$field);
         }
         if(hasGemLevel)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,gemLevel$field);
         }
         if(hasScoreOrder)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,scoreOrder$field);
         }
         _loc3_ = 0;
         while(_loc3_ < rewardInfo.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardInfo[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:GemInfoMsg = null;
         var _loc3_:GemInfoMsg = null;
         var _loc10_:RewardInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc5_ = new GemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  gemDel.push(_loc5_);
                  break;
               case 1:
                  _loc3_ = new GemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  gemAdd.push(_loc3_);
                  break;
               case 3:
                  if((_loc9_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,score);
                  }
                  else
                  {
                     score.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GemInfoUpdateMsg.curExp cannot be set twice.");
                  }
                  _loc6_++;
                  curExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GemInfoUpdateMsg.maxExp cannot be set twice.");
                  }
                  _loc4_++;
                  maxExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GemInfoUpdateMsg.gemLevel cannot be set twice.");
                  }
                  _loc8_++;
                  gemLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GemInfoUpdateMsg.scoreOrder cannot be set twice.");
                  }
                  _loc7_++;
                  scoreOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc10_ = new RewardInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  rewardInfo.push(_loc10_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

