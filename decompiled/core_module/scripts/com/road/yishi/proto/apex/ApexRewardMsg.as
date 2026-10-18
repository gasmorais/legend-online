package com.road.yishi.proto.apex
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexRewardMsg extends Message implements IExternalizable
   {
      
      private var itemTempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var itemCount$field:int;
      
      public function ApexRewardMsg()
      {
         super();
      }
      
      public function removeItemTempId() : void
      {
         hasField$0 &= 4294967294;
         itemTempId$field = new int();
      }
      
      public function get hasItemTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set itemTempId(param1:int) : void
      {
         hasField$0 |= 1;
         itemTempId$field = param1;
      }
      
      public function get itemTempId() : int
      {
         return itemTempId$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967293;
         itemCount$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 2;
         itemCount$field = param1;
      }
      
      public function get itemCount() : int
      {
         return itemCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,itemTempId$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,itemCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRewardMsg.itemTempId cannot be set twice.");
                  }
                  _loc4_++;
                  itemTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRewardMsg.itemCount cannot be set twice.");
                  }
                  _loc3_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

