package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTreasureLotteryPB extends Message implements IExternalizable
   {
      
      private var active_id$field:String;
      
      private var hasField$0:uint = 0;
      
      private var fresh_time$field:String;
      
      private var times$field:int;
      
      public function SkyTreasureLotteryPB()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         hasField$0 &= 4294967294;
         active_id$field = new String();
      }
      
      public function get hasActiveId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set activeId(param1:String) : void
      {
         hasField$0 |= 1;
         active_id$field = param1;
      }
      
      public function get activeId() : String
      {
         return active_id$field;
      }
      
      public function removeFreshTime() : void
      {
         hasField$0 &= 4294967293;
         fresh_time$field = new String();
      }
      
      public function get hasFreshTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set freshTime(param1:String) : void
      {
         hasField$0 |= 2;
         fresh_time$field = param1;
      }
      
      public function get freshTime() : String
      {
         return fresh_time$field;
      }
      
      public function removeTimes() : void
      {
         hasField$0 &= 4294967291;
         times$field = new int();
      }
      
      public function get hasTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set times(param1:int) : void
      {
         hasField$0 |= 4;
         times$field = param1;
      }
      
      public function get times() : int
      {
         return times$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,active_id$field);
         }
         if(hasFreshTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,fresh_time$field);
         }
         if(hasTimes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,times$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTreasureLotteryPB.activeId cannot be set twice.");
                  }
                  _loc3_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTreasureLotteryPB.freshTime cannot be set twice.");
                  }
                  _loc4_++;
                  freshTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTreasureLotteryPB.times cannot be set twice.");
                  }
                  _loc6_++;
                  times = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

