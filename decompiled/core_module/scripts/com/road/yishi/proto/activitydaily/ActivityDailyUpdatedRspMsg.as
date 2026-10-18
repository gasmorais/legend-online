package com.road.yishi.proto.activitydaily
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActivityDailyUpdatedRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.activitydaily.ActivityDailyData")]
      public var activityDailyData:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.activitydaily.ActivityDailyRspMsg")]
      public var activityDaily:Array = [];
      
      private var buff_stop_date$field:String;
      
      private var vipNum$field:int;
      
      private var hasField$0:uint = 0;
      
      public function ActivityDailyUpdatedRspMsg()
      {
         super();
      }
      
      public function removeBuffStopDate() : void
      {
         buff_stop_date$field = null;
      }
      
      public function get hasBuffStopDate() : Boolean
      {
         return buff_stop_date$field != null;
      }
      
      public function set buffStopDate(param1:String) : void
      {
         buff_stop_date$field = param1;
      }
      
      public function get buffStopDate() : String
      {
         return buff_stop_date$field;
      }
      
      public function removeVipNum() : void
      {
         hasField$0 &= 4294967294;
         vipNum$field = new int();
      }
      
      public function get hasVipNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set vipNum(param1:int) : void
      {
         hasField$0 |= 1;
         vipNum$field = param1;
      }
      
      public function get vipNum() : int
      {
         return vipNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < activityDailyData.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,activityDailyData[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < activityDaily.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,activityDaily[_loc2_]);
            _loc2_++;
         }
         if(hasBuffStopDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,buff_stop_date$field);
         }
         if(hasVipNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,vipNum$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:ActivityDailyData = null;
         var _loc4_:ActivityDailyRspMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new ActivityDailyData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  activityDailyData.push(_loc7_);
                  break;
               case 1:
                  _loc4_ = new ActivityDailyRspMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  activityDaily.push(_loc4_);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyUpdatedRspMsg.buffStopDate cannot be set twice.");
                  }
                  _loc3_++;
                  buffStopDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyUpdatedRspMsg.vipNum cannot be set twice.");
                  }
                  _loc5_++;
                  vipNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

