package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HangupInfoMsg extends Message implements IExternalizable
   {
      
      private var left_weay$field:int;
      
      private var hasField$0:uint = 0;
      
      private var is_startHangup$field:Boolean;
      
      private var add_weay$field:int;
      
      public function HangupInfoMsg()
      {
         super();
      }
      
      public function removeLeftWeay() : void
      {
         hasField$0 &= 4294967294;
         left_weay$field = new int();
      }
      
      public function get hasLeftWeay() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftWeay(param1:int) : void
      {
         hasField$0 |= 1;
         left_weay$field = param1;
      }
      
      public function get leftWeay() : int
      {
         return left_weay$field;
      }
      
      public function removeIsStartHangup() : void
      {
         hasField$0 &= 4294967293;
         is_startHangup$field = new Boolean();
      }
      
      public function get hasIsStartHangup() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isStartHangup(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_startHangup$field = param1;
      }
      
      public function get isStartHangup() : Boolean
      {
         return is_startHangup$field;
      }
      
      public function removeAddWeay() : void
      {
         hasField$0 &= 4294967291;
         add_weay$field = new int();
      }
      
      public function get hasAddWeay() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set addWeay(param1:int) : void
      {
         hasField$0 |= 4;
         add_weay$field = param1;
      }
      
      public function get addWeay() : int
      {
         return add_weay$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLeftWeay)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,left_weay$field);
         }
         if(hasIsStartHangup)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,is_startHangup$field);
         }
         if(hasAddWeay)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,add_weay$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HangupInfoMsg.leftWeay cannot be set twice.");
                  }
                  _loc4_++;
                  leftWeay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HangupInfoMsg.isStartHangup cannot be set twice.");
                  }
                  _loc6_++;
                  isStartHangup = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HangupInfoMsg.addWeay cannot be set twice.");
                  }
                  _loc3_++;
                  addWeay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

