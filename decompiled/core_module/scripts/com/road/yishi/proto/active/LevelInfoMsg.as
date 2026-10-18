package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LevelInfoMsg extends Message implements IExternalizable
   {
      
      private var needPoint$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isBuy$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.active.GradeRewardInfoMsg")]
      public var infoMsg:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.RewardItemInfoMsg")]
      public var allTakedInfo:Array = [];
      
      private var level$field:int;
      
      public function LevelInfoMsg()
      {
         super();
      }
      
      public function removeNeedPoint() : void
      {
         hasField$0 &= 4294967294;
         needPoint$field = new int();
      }
      
      public function get hasNeedPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set needPoint(param1:int) : void
      {
         hasField$0 |= 1;
         needPoint$field = param1;
      }
      
      public function get needPoint() : int
      {
         return needPoint$field;
      }
      
      public function removeIsBuy() : void
      {
         hasField$0 &= 4294967293;
         isBuy$field = new Boolean();
      }
      
      public function get hasIsBuy() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isBuy(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isBuy$field = param1;
      }
      
      public function get isBuy() : Boolean
      {
         return isBuy$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967291;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 4;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasNeedPoint)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,needPoint$field);
         }
         if(hasIsBuy)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isBuy$field);
         }
         _loc3_ = 0;
         while(_loc3_ < infoMsg.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,infoMsg[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < allTakedInfo.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,allTakedInfo[_loc2_]);
            _loc2_++;
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc8_:GradeRewardInfoMsg = null;
         var _loc7_:RewardItemInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LevelInfoMsg.needPoint cannot be set twice.");
                  }
                  _loc6_++;
                  needPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LevelInfoMsg.isBuy cannot be set twice.");
                  }
                  _loc4_++;
                  isBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  _loc8_ = new GradeRewardInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  infoMsg.push(_loc8_);
                  break;
               case 3:
                  _loc7_ = new RewardItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  allTakedInfo.push(_loc7_);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LevelInfoMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

