package com.road.yishi.proto.artifactgiftactivity
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArtifactGiftActivityTemplateMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.artifactgiftactivity.LotteryItemInfoMsg")]
      public var lotteryItem:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.artifactgiftactivity.LotteryItemInfoMsg")]
      public var rewardItem:Array = [];
      
      private var open$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var end_time$field:Int64;
      
      public function ArtifactGiftActivityTemplateMsg()
      {
         super();
      }
      
      public function removeOpen() : void
      {
         hasField$0 &= 4294967294;
         open$field = new Boolean();
      }
      
      public function get hasOpen() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set open(param1:Boolean) : void
      {
         hasField$0 |= 1;
         open$field = param1;
      }
      
      public function get open() : Boolean
      {
         return open$field;
      }
      
      public function removeEndTime() : void
      {
         end_time$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return end_time$field != null;
      }
      
      public function set endTime(param1:Int64) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : Int64
      {
         return end_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < lotteryItem.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,lotteryItem[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < rewardItem.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardItem[_loc3_]);
            _loc3_++;
         }
         if(hasOpen)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,open$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,end_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:LotteryItemInfoMsg = null;
         var _loc3_:LotteryItemInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new LotteryItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  lotteryItem.push(_loc4_);
                  break;
               case 1:
                  _loc3_ = new LotteryItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  rewardItem.push(_loc3_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityTemplateMsg.open cannot be set twice.");
                  }
                  _loc5_++;
                  open = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityTemplateMsg.endTime cannot be set twice.");
                  }
                  _loc6_++;
                  endTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

