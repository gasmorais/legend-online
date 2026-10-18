package com.road.yishi.proto.universalActive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ExchangeActive extends Message implements IExternalizable
   {
      
      private var start_time$field:String;
      
      private var end_time$field:String;
      
      private var bag_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bag_name$field:String;
      
      [ArrayElementType("com.road.yishi.proto.universalActive.ExchangeItemInfo")]
      public var rewardItem:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.universalActive.ExchangeItemInfo")]
      public var needItem:Array = [];
      
      public function ExchangeActive()
      {
         super();
      }
      
      public function removeStartTime() : void
      {
         start_time$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return start_time$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         start_time$field = param1;
      }
      
      public function get startTime() : String
      {
         return start_time$field;
      }
      
      public function removeEndTime() : void
      {
         end_time$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return end_time$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
      }
      
      public function removeBagId() : void
      {
         hasField$0 &= 4294967294;
         bag_id$field = new int();
      }
      
      public function get hasBagId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bagId(param1:int) : void
      {
         hasField$0 |= 1;
         bag_id$field = param1;
      }
      
      public function get bagId() : int
      {
         return bag_id$field;
      }
      
      public function removeBagName() : void
      {
         bag_name$field = null;
      }
      
      public function get hasBagName() : Boolean
      {
         return bag_name$field != null;
      }
      
      public function set bagName(param1:String) : void
      {
         bag_name$field = param1;
      }
      
      public function get bagName() : String
      {
         return bag_name$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
         if(hasBagId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,bag_id$field);
         }
         if(hasBagName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,bag_name$field);
         }
         _loc3_ = 0;
         while(_loc3_ < rewardItem.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardItem[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < needItem.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,needItem[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:ExchangeItemInfo = null;
         var _loc4_:ExchangeItemInfo = null;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ExchangeActive.startTime cannot be set twice.");
                  }
                  _loc5_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ExchangeActive.endTime cannot be set twice.");
                  }
                  _loc8_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ExchangeActive.bagId cannot be set twice.");
                  }
                  _loc7_++;
                  bagId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ExchangeActive.bagName cannot be set twice.");
                  }
                  _loc3_++;
                  bagName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  _loc6_ = new ExchangeItemInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  rewardItem.push(_loc6_);
                  break;
               case 5:
                  _loc4_ = new ExchangeItemInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  needItem.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

