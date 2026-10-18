package com.road.yishi.proto.activitydaily
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActivityDailyRspMsg extends Message implements IExternalizable
   {
      
      private var masterType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var activityDailyProcess$field:String;
      
      private var totalNum$field:int;
      
      private var weekActivityDailyProcess$field:String;
      
      private var weekTotalNum$field:int;
      
      public function ActivityDailyRspMsg()
      {
         super();
      }
      
      public function removeMasterType() : void
      {
         hasField$0 &= 4294967294;
         masterType$field = new int();
      }
      
      public function get hasMasterType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set masterType(param1:int) : void
      {
         hasField$0 |= 1;
         masterType$field = param1;
      }
      
      public function get masterType() : int
      {
         return masterType$field;
      }
      
      public function removeActivityDailyProcess() : void
      {
         activityDailyProcess$field = null;
      }
      
      public function get hasActivityDailyProcess() : Boolean
      {
         return activityDailyProcess$field != null;
      }
      
      public function set activityDailyProcess(param1:String) : void
      {
         activityDailyProcess$field = param1;
      }
      
      public function get activityDailyProcess() : String
      {
         return activityDailyProcess$field;
      }
      
      public function removeTotalNum() : void
      {
         hasField$0 &= 4294967293;
         totalNum$field = new int();
      }
      
      public function get hasTotalNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalNum(param1:int) : void
      {
         hasField$0 |= 2;
         totalNum$field = param1;
      }
      
      public function get totalNum() : int
      {
         return totalNum$field;
      }
      
      public function removeWeekActivityDailyProcess() : void
      {
         weekActivityDailyProcess$field = null;
      }
      
      public function get hasWeekActivityDailyProcess() : Boolean
      {
         return weekActivityDailyProcess$field != null;
      }
      
      public function set weekActivityDailyProcess(param1:String) : void
      {
         weekActivityDailyProcess$field = param1;
      }
      
      public function get weekActivityDailyProcess() : String
      {
         return weekActivityDailyProcess$field;
      }
      
      public function removeWeekTotalNum() : void
      {
         hasField$0 &= 4294967291;
         weekTotalNum$field = new int();
      }
      
      public function get hasWeekTotalNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set weekTotalNum(param1:int) : void
      {
         hasField$0 |= 4;
         weekTotalNum$field = param1;
      }
      
      public function get weekTotalNum() : int
      {
         return weekTotalNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMasterType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,masterType$field);
         }
         if(hasActivityDailyProcess)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,activityDailyProcess$field);
         }
         if(hasTotalNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,totalNum$field);
         }
         if(hasWeekActivityDailyProcess)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,weekActivityDailyProcess$field);
         }
         if(hasWeekTotalNum)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,weekTotalNum$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyRspMsg.masterType cannot be set twice.");
                  }
                  _loc4_++;
                  masterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyRspMsg.activityDailyProcess cannot be set twice.");
                  }
                  _loc7_++;
                  activityDailyProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyRspMsg.totalNum cannot be set twice.");
                  }
                  _loc6_++;
                  totalNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyRspMsg.weekActivityDailyProcess cannot be set twice.");
                  }
                  _loc3_++;
                  weekActivityDailyProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyRspMsg.weekTotalNum cannot be set twice.");
                  }
                  _loc8_++;
                  weekTotalNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

