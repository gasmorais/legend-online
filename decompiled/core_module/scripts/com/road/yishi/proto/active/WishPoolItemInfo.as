package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WishPoolItemInfo extends Message implements IExternalizable
   {
      
      private var key$field:int;
      
      private var hasField$0:uint = 0;
      
      private var itemId$field:int;
      
      private var count$field:int;
      
      private var isRare$field:Boolean;
      
      public function WishPoolItemInfo()
      {
         super();
      }
      
      public function removeKey() : void
      {
         hasField$0 &= 4294967294;
         key$field = new int();
      }
      
      public function get hasKey() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set key(param1:int) : void
      {
         hasField$0 |= 1;
         key$field = param1;
      }
      
      public function get key() : int
      {
         return key$field;
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967293;
         itemId$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 2;
         itemId$field = param1;
      }
      
      public function get itemId() : int
      {
         return itemId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeIsRare() : void
      {
         hasField$0 &= 4294967287;
         isRare$field = new Boolean();
      }
      
      public function get hasIsRare() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isRare(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isRare$field = param1;
      }
      
      public function get isRare() : Boolean
      {
         return isRare$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasKey)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,key$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasIsRare)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isRare$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolItemInfo.key cannot be set twice.");
                  }
                  _loc3_++;
                  key = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolItemInfo.itemId cannot be set twice.");
                  }
                  _loc7_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolItemInfo.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolItemInfo.isRare cannot be set twice.");
                  }
                  _loc5_++;
                  isRare = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

