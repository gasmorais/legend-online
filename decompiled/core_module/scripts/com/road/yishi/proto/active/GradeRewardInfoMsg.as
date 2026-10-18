package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GradeRewardInfoMsg extends Message implements IExternalizable
   {
      
      private var needGrade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isTaked$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.active.RewardItemInfoMsg")]
      public var itemInfo:Array = [];
      
      private var index$field:int;
      
      public function GradeRewardInfoMsg()
      {
         super();
      }
      
      public function removeNeedGrade() : void
      {
         hasField$0 &= 4294967294;
         needGrade$field = new int();
      }
      
      public function get hasNeedGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set needGrade(param1:int) : void
      {
         hasField$0 |= 1;
         needGrade$field = param1;
      }
      
      public function get needGrade() : int
      {
         return needGrade$field;
      }
      
      public function removeIsTaked() : void
      {
         hasField$0 &= 4294967293;
         isTaked$field = new Boolean();
      }
      
      public function get hasIsTaked() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isTaked(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isTaked$field = param1;
      }
      
      public function get isTaked() : Boolean
      {
         return isTaked$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasNeedGrade)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,needGrade$field);
         }
         if(hasIsTaked)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isTaked$field);
         }
         _loc2_ = 0;
         while(_loc2_ < itemInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,itemInfo[_loc2_]);
            _loc2_++;
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:RewardItemInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GradeRewardInfoMsg.needGrade cannot be set twice.");
                  }
                  _loc5_++;
                  needGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GradeRewardInfoMsg.isTaked cannot be set twice.");
                  }
                  _loc3_++;
                  isTaked = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  _loc7_ = new RewardItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  itemInfo.push(_loc7_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GradeRewardInfoMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

