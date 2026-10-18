package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BottleItemInfoMsg extends Message implements IExternalizable
   {
      
      private var temp_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      private var is_show$field:Boolean;
      
      private var is_new_items$field:Boolean;
      
      public function BottleItemInfoMsg()
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
      
      public function removeIsShow() : void
      {
         hasField$0 &= 4294967291;
         is_show$field = new Boolean();
      }
      
      public function get hasIsShow() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_show$field = param1;
      }
      
      public function get isShow() : Boolean
      {
         return is_show$field;
      }
      
      public function removeIsNewItems() : void
      {
         hasField$0 &= 4294967287;
         is_new_items$field = new Boolean();
      }
      
      public function get hasIsNewItems() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isNewItems(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_new_items$field = param1;
      }
      
      public function get isNewItems() : Boolean
      {
         return is_new_items$field;
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
         if(hasIsShow)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_show$field);
         }
         if(hasIsNewItems)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_new_items$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BottleItemInfoMsg.tempId cannot be set twice.");
                  }
                  _loc6_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BottleItemInfoMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BottleItemInfoMsg.isShow cannot be set twice.");
                  }
                  _loc5_++;
                  isShow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BottleItemInfoMsg.isNewItems cannot be set twice.");
                  }
                  _loc7_++;
                  isNewItems = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

