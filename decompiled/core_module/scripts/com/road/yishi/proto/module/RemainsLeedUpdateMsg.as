package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RemainsLeedUpdateMsg extends Message implements IExternalizable
   {
      
      private var dayLiveness$field:int;
      
      private var hasField$0:uint = 0;
      
      private var weekLiveness$field:int;
      
      [ArrayElementType("com.road.yishi.proto.module.RemainsLeedDataMsg")]
      public var leedDataList:Array = [];
      
      public function RemainsLeedUpdateMsg()
      {
         super();
      }
      
      public function removeDayLiveness() : void
      {
         hasField$0 &= 4294967294;
         dayLiveness$field = new int();
      }
      
      public function get hasDayLiveness() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dayLiveness(param1:int) : void
      {
         hasField$0 |= 1;
         dayLiveness$field = param1;
      }
      
      public function get dayLiveness() : int
      {
         return dayLiveness$field;
      }
      
      public function removeWeekLiveness() : void
      {
         hasField$0 &= 4294967293;
         weekLiveness$field = new int();
      }
      
      public function get hasWeekLiveness() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set weekLiveness(param1:int) : void
      {
         hasField$0 |= 2;
         weekLiveness$field = param1;
      }
      
      public function get weekLiveness() : int
      {
         return weekLiveness$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDayLiveness)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,dayLiveness$field);
         }
         if(hasWeekLiveness)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,weekLiveness$field);
         }
         _loc2_ = 0;
         while(_loc2_ < leedDataList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,leedDataList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:RemainsLeedDataMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsLeedUpdateMsg.dayLiveness cannot be set twice.");
                  }
                  _loc4_++;
                  dayLiveness = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsLeedUpdateMsg.weekLiveness cannot be set twice.");
                  }
                  _loc3_++;
                  weekLiveness = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc6_ = new RemainsLeedDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  leedDataList.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

