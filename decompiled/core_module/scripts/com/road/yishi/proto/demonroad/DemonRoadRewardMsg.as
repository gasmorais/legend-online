package com.road.yishi.proto.demonroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DemonRoadRewardMsg extends Message implements IExternalizable
   {
      
      private var ItemTempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var Count$field:int;
      
      public function DemonRoadRewardMsg()
      {
         super();
      }
      
      public function removeItemTempId() : void
      {
         hasField$0 &= 4294967294;
         ItemTempId$field = new int();
      }
      
      public function get hasItemTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set itemTempId(param1:int) : void
      {
         hasField$0 |= 1;
         ItemTempId$field = param1;
      }
      
      public function get itemTempId() : int
      {
         return ItemTempId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         Count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         Count$field = param1;
      }
      
      public function get count() : int
      {
         return Count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,ItemTempId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,Count$field);
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
                     throw new IOError("Bad data format: DemonRoadRewardMsg.itemTempId cannot be set twice.");
                  }
                  _loc5_++;
                  itemTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadRewardMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

