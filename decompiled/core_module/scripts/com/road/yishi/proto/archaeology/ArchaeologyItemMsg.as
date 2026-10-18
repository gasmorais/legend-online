package com.road.yishi.proto.archaeology
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArchaeologyItemMsg extends Message implements IExternalizable
   {
      
      private var temp_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var chip_count$field:int;
      
      private var item_count$field:int;
      
      public function ArchaeologyItemMsg()
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
      
      public function removeChipCount() : void
      {
         hasField$0 &= 4294967293;
         chip_count$field = new int();
      }
      
      public function get hasChipCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set chipCount(param1:int) : void
      {
         hasField$0 |= 2;
         chip_count$field = param1;
      }
      
      public function get chipCount() : int
      {
         return chip_count$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967291;
         item_count$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 4;
         item_count$field = param1;
      }
      
      public function get itemCount() : int
      {
         return item_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasChipCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,chip_count$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,item_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArchaeologyItemMsg.tempId cannot be set twice.");
                  }
                  _loc5_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArchaeologyItemMsg.chipCount cannot be set twice.");
                  }
                  _loc3_++;
                  chipCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArchaeologyItemMsg.itemCount cannot be set twice.");
                  }
                  _loc6_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

