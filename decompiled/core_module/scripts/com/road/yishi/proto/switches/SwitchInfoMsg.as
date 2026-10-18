package com.road.yishi.proto.switches
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SwitchInfoMsg extends Message implements IExternalizable
   {
      
      private var switch_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var switch_type$field:int;
      
      private var is_open$field:Boolean;
      
      private var begin_date$field:String;
      
      private var end_date$field:String;
      
      public function SwitchInfoMsg()
      {
         super();
      }
      
      public function removeSwitchId() : void
      {
         hasField$0 &= 4294967294;
         switch_id$field = new int();
      }
      
      public function get hasSwitchId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set switchId(param1:int) : void
      {
         hasField$0 |= 1;
         switch_id$field = param1;
      }
      
      public function get switchId() : int
      {
         return switch_id$field;
      }
      
      public function removeSwitchType() : void
      {
         hasField$0 &= 4294967293;
         switch_type$field = new int();
      }
      
      public function get hasSwitchType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set switchType(param1:int) : void
      {
         hasField$0 |= 2;
         switch_type$field = param1;
      }
      
      public function get switchType() : int
      {
         return switch_type$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967291;
         is_open$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_open$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return is_open$field;
      }
      
      public function removeBeginDate() : void
      {
         begin_date$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return begin_date$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         begin_date$field = param1;
      }
      
      public function get beginDate() : String
      {
         return begin_date$field;
      }
      
      public function removeEndDate() : void
      {
         end_date$field = null;
      }
      
      public function get hasEndDate() : Boolean
      {
         return end_date$field != null;
      }
      
      public function set endDate(param1:String) : void
      {
         end_date$field = param1;
      }
      
      public function get endDate() : String
      {
         return end_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSwitchId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,switch_id$field);
         }
         if(hasSwitchType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,switch_type$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_open$field);
         }
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,begin_date$field);
         }
         if(hasEndDate)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,end_date$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SwitchInfoMsg.switchId cannot be set twice.");
                  }
                  _loc4_++;
                  switchId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SwitchInfoMsg.switchType cannot be set twice.");
                  }
                  _loc7_++;
                  switchType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SwitchInfoMsg.isOpen cannot be set twice.");
                  }
                  _loc3_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SwitchInfoMsg.beginDate cannot be set twice.");
                  }
                  _loc5_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SwitchInfoMsg.endDate cannot be set twice.");
                  }
                  _loc8_++;
                  endDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

