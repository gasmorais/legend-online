package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaBoxInfoMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consortia_id$field:int;
      
      private var count$field:int;
      
      private var add_time$field:ByteArray;
      
      private var remove_time$field:ByteArray;
      
      public function ConsortiaBoxInfoMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967293;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 2;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
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
      
      public function removeAddTime() : void
      {
         add_time$field = null;
      }
      
      public function get hasAddTime() : Boolean
      {
         return add_time$field != null;
      }
      
      public function set addTime(param1:ByteArray) : void
      {
         add_time$field = param1;
      }
      
      public function get addTime() : ByteArray
      {
         return add_time$field;
      }
      
      public function removeRemoveTime() : void
      {
         remove_time$field = null;
      }
      
      public function get hasRemoveTime() : Boolean
      {
         return remove_time$field != null;
      }
      
      public function set removeTime(param1:ByteArray) : void
      {
         remove_time$field = param1;
      }
      
      public function get removeTime() : ByteArray
      {
         return remove_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasAddTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_BYTES(param1,add_time$field);
         }
         if(hasRemoveTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_BYTES(param1,remove_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBoxInfoMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBoxInfoMsg.consortiaId cannot be set twice.");
                  }
                  _loc4_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBoxInfoMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBoxInfoMsg.addTime cannot be set twice.");
                  }
                  _loc6_++;
                  addTime = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBoxInfoMsg.removeTime cannot be set twice.");
                  }
                  _loc5_++;
                  removeTime = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

