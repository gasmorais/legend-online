package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HangupStateListMsg extends Message implements IExternalizable
   {
      
      private var max_count$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.campaign.HangupStateMsg")]
      public var hangupState:Array = [];
      
      public function HangupStateListMsg()
      {
         super();
      }
      
      public function removeMaxCount() : void
      {
         hasField$0 &= 4294967294;
         max_count$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$0 |= 1;
         max_count$field = param1;
      }
      
      public function get maxCount() : int
      {
         return max_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,max_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < hangupState.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,hangupState[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:HangupStateMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HangupStateListMsg.maxCount cannot be set twice.");
                  }
                  _loc4_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new HangupStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  hangupState.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

