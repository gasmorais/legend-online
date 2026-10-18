package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BottleDropListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.item.BottleItemInfoMsg")]
      public var dropItem:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.item.BottlePackage")]
      public var score:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.item.BottlePackage")]
      public var storey:Array = [];
      
      private var open$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var end_time$field:String;
      
      public function BottleDropListMsg()
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
      
      public function set endTime(param1:String) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < dropItem.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,dropItem[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < score.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,score[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < storey.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,storey[_loc2_]);
            _loc2_++;
         }
         if(hasOpen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,open$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:BottleItemInfoMsg = null;
         var _loc3_:BottlePackage = null;
         var _loc8_:BottlePackage = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new BottleItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  dropItem.push(_loc6_);
                  break;
               case 1:
                  _loc3_ = new BottlePackage();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  score.push(_loc3_);
                  break;
               case 2:
                  _loc8_ = new BottlePackage();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  storey.push(_loc8_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BottleDropListMsg.open cannot be set twice.");
                  }
                  _loc4_++;
                  open = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BottleDropListMsg.endTime cannot be set twice.");
                  }
                  _loc5_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

