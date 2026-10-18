package com.road.yishi.proto.activitydaily
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActivityDailyData extends Message implements IExternalizable
   {
      
      private var masterType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sonType$field:int;
      
      private var taskType$field:int;
      
      private var current_count$field:int;
      
      private var is_complete$field:Boolean;
      
      public function ActivityDailyData()
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
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967293;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 2;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removeTaskType() : void
      {
         hasField$0 &= 4294967291;
         taskType$field = new int();
      }
      
      public function get hasTaskType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set taskType(param1:int) : void
      {
         hasField$0 |= 4;
         taskType$field = param1;
      }
      
      public function get taskType() : int
      {
         return taskType$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$0 &= 4294967287;
         current_count$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$0 |= 8;
         current_count$field = param1;
      }
      
      public function get currentCount() : int
      {
         return current_count$field;
      }
      
      public function removeIsComplete() : void
      {
         hasField$0 &= 4294967279;
         is_complete$field = new Boolean();
      }
      
      public function get hasIsComplete() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isComplete(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_complete$field = param1;
      }
      
      public function get isComplete() : Boolean
      {
         return is_complete$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMasterType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,masterType$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasTaskType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,taskType$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,current_count$field);
         }
         if(hasIsComplete)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_complete$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyData.masterType cannot be set twice.");
                  }
                  _loc6_++;
                  masterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyData.sonType cannot be set twice.");
                  }
                  _loc3_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyData.taskType cannot be set twice.");
                  }
                  _loc4_++;
                  taskType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyData.currentCount cannot be set twice.");
                  }
                  _loc5_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDailyData.isComplete cannot be set twice.");
                  }
                  _loc8_++;
                  isComplete = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

