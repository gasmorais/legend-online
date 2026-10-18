package com.road.yishi.proto.vip
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VipBoxDropMsg extends Message implements IExternalizable
   {
      
      private var week_gift_date$field:ByteArray;
      
      public function VipBoxDropMsg()
      {
         super();
      }
      
      public function removeWeekGiftDate() : void
      {
         week_gift_date$field = null;
      }
      
      public function get hasWeekGiftDate() : Boolean
      {
         return week_gift_date$field != null;
      }
      
      public function set weekGiftDate(param1:ByteArray) : void
      {
         week_gift_date$field = param1;
      }
      
      public function get weekGiftDate() : ByteArray
      {
         return week_gift_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasWeekGiftDate)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_BYTES(param1,week_gift_date$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VipBoxDropMsg.weekGiftDate cannot be set twice.");
                  }
                  _loc3_++;
                  weekGiftDate = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

