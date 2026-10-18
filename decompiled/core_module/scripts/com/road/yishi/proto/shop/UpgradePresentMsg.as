package com.road.yishi.proto.shop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class UpgradePresentMsg extends Message implements IExternalizable
   {
      
      private var area$field:int;
      
      private var hasField$0:uint = 0;
      
      private var end_time$field:Int64;
      
      [ArrayElementType("int")]
      public var boughtCount:Array = [];
      
      [ArrayElementType("int")]
      public var shopId:Array = [];
      
      public function UpgradePresentMsg()
      {
         super();
      }
      
      public function removeArea() : void
      {
         hasField$0 &= 4294967294;
         area$field = new int();
      }
      
      public function get hasArea() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set area(param1:int) : void
      {
         hasField$0 |= 1;
         area$field = param1;
      }
      
      public function get area() : int
      {
         return area$field;
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
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasArea)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,area$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,end_time$field);
         }
         _loc3_ = 0;
         while(_loc3_ < boughtCount.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,boughtCount[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < shopId.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,shopId[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: UpgradePresentMsg.area cannot be set twice.");
                  }
                  _loc5_++;
                  area = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: UpgradePresentMsg.endTime cannot be set twice.");
                  }
                  _loc3_++;
                  endTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,boughtCount);
                  }
                  else
                  {
                     boughtCount.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,shopId);
                  }
                  else
                  {
                     shopId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

