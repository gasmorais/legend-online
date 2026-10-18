package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NavigationFishingStateMsg extends Message implements IExternalizable
   {
      
      private var open$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var startTime$field:Int64;
      
      private var endTime$field:Int64;
      
      public function NavigationFishingStateMsg()
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
      
      public function removeStartTime() : void
      {
         startTime$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return startTime$field != null;
      }
      
      public function set startTime(param1:Int64) : void
      {
         startTime$field = param1;
      }
      
      public function get startTime() : Int64
      {
         return startTime$field;
      }
      
      public function removeEndTime() : void
      {
         endTime$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return endTime$field != null;
      }
      
      public function set endTime(param1:Int64) : void
      {
         endTime$field = param1;
      }
      
      public function get endTime() : Int64
      {
         return endTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpen)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,open$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,startTime$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,endTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationFishingStateMsg.open cannot be set twice.");
                  }
                  _loc5_++;
                  open = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationFishingStateMsg.startTime cannot be set twice.");
                  }
                  _loc4_++;
                  startTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationFishingStateMsg.endTime cannot be set twice.");
                  }
                  _loc3_++;
                  endTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

