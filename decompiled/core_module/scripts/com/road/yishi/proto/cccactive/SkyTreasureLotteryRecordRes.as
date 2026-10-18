package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTreasureLotteryRecordRes extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.cccactive.LotteryRecordPB")]
      public var selfRecord:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.cccactive.LotteryRecordPB")]
      public var serverRecord:Array = [];
      
      public function SkyTreasureLotteryRecordRes()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < selfRecord.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,selfRecord[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < serverRecord.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,serverRecord[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:LotteryRecordPB = null;
         var _loc3_:LotteryRecordPB = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc5_ = new LotteryRecordPB();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  selfRecord.push(_loc5_);
                  break;
               case 1:
                  _loc3_ = new LotteryRecordPB();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  serverRecord.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

