package com.road.yishi.proto.collection
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemMsg extends Message implements IExternalizable
   {
      
      private var itemId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var num$field:int;
      
      public function ItemMsg()
      {
         super();
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967294;
         itemId$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 1;
         itemId$field = param1;
      }
      
      public function get itemId() : int
      {
         return itemId$field;
      }
      
      public function removeNum() : void
      {
         hasField$0 &= 4294967293;
         num$field = new int();
      }
      
      public function get hasNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set num(param1:int) : void
      {
         hasField$0 |= 2;
         num$field = param1;
      }
      
      public function get num() : int
      {
         return num$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,num$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemMsg.itemId cannot be set twice.");
                  }
                  _loc4_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemMsg.num cannot be set twice.");
                  }
                  _loc5_++;
                  num = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

