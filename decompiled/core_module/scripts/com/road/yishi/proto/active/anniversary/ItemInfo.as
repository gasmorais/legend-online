package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemInfo extends Message implements IExternalizable
   {
      
      private var temp_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      private var value$field:int;
      
      private var is_rare$field:Boolean;
      
      private var multiple$field:int;
      
      private var is_buy$field:Boolean;
      
      public function ItemInfo()
      {
         super();
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967294;
         temp_id$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 1;
         temp_id$field = param1;
      }
      
      public function get tempId() : int
      {
         return temp_id$field;
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
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967291;
         value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 4;
         value$field = param1;
      }
      
      public function get value() : int
      {
         return value$field;
      }
      
      public function removeIsRare() : void
      {
         hasField$0 &= 4294967287;
         is_rare$field = new Boolean();
      }
      
      public function get hasIsRare() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isRare(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_rare$field = param1;
      }
      
      public function get isRare() : Boolean
      {
         return is_rare$field;
      }
      
      public function removeMultiple() : void
      {
         hasField$0 &= 4294967279;
         multiple$field = new int();
      }
      
      public function get hasMultiple() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set multiple(param1:int) : void
      {
         hasField$0 |= 16;
         multiple$field = param1;
      }
      
      public function get multiple() : int
      {
         return multiple$field;
      }
      
      public function removeIsBuy() : void
      {
         hasField$0 &= 4294967263;
         is_buy$field = new Boolean();
      }
      
      public function get hasIsBuy() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isBuy(param1:Boolean) : void
      {
         hasField$0 |= 32;
         is_buy$field = param1;
      }
      
      public function get isBuy() : Boolean
      {
         return is_buy$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,value$field);
         }
         if(hasIsRare)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_rare$field);
         }
         if(hasMultiple)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,multiple$field);
         }
         if(hasIsBuy)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,is_buy$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfo.tempId cannot be set twice.");
                  }
                  _loc7_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfo.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfo.value cannot be set twice.");
                  }
                  _loc8_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfo.isRare cannot be set twice.");
                  }
                  _loc9_++;
                  isRare = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfo.multiple cannot be set twice.");
                  }
                  _loc5_++;
                  multiple = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfo.isBuy cannot be set twice.");
                  }
                  _loc3_++;
                  isBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

