package com.road.yishi.proto.collection
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CollectionRewardMsg extends Message implements IExternalizable
   {
      
      private var boxCount$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.collection.RewardTask")]
      public var tasks:Array = [];
      
      public function CollectionRewardMsg()
      {
         super();
      }
      
      public function removeBoxCount() : void
      {
         hasField$0 &= 4294967294;
         boxCount$field = new int();
      }
      
      public function get hasBoxCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set boxCount(param1:int) : void
      {
         hasField$0 |= 1;
         boxCount$field = param1;
      }
      
      public function get boxCount() : int
      {
         return boxCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBoxCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,boxCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < tasks.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,tasks[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:RewardTask = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CollectionRewardMsg.boxCount cannot be set twice.");
                  }
                  _loc3_++;
                  boxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new RewardTask();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  tasks.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

