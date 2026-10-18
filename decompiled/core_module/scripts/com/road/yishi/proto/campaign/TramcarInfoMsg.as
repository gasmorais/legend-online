package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TramcarInfoMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.campaign.CarInfo")]
      public var carInfo:Array = [];
      
      [ArrayElementType("int")]
      public var userIds:Array = [];
      
      private var active_time$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      private var multiple$field:int;
      
      public function TramcarInfoMsg()
      {
         super();
      }
      
      public function removeActiveTime() : void
      {
         hasField$0 &= 4294967294;
         active_time$field = new int();
      }
      
      public function get hasActiveTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set activeTime(param1:int) : void
      {
         hasField$0 |= 1;
         active_time$field = param1;
      }
      
      public function get activeTime() : int
      {
         return active_time$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeMultiple() : void
      {
         hasField$0 &= 4294967291;
         multiple$field = new int();
      }
      
      public function get hasMultiple() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set multiple(param1:int) : void
      {
         hasField$0 |= 4;
         multiple$field = param1;
      }
      
      public function get multiple() : int
      {
         return multiple$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < carInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,carInfo[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < userIds.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userIds[_loc3_]);
            _loc3_++;
         }
         if(hasActiveTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,active_time$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasMultiple)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,multiple$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:CarInfo = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new CarInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  carInfo.push(_loc7_);
                  break;
               case 1:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIds);
                  }
                  else
                  {
                     userIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TramcarInfoMsg.activeTime cannot be set twice.");
                  }
                  _loc4_++;
                  activeTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TramcarInfoMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TramcarInfoMsg.multiple cannot be set twice.");
                  }
                  _loc5_++;
                  multiple = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

