package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EggItemMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var counts$field:int;
      
      private var isOpen$field:Boolean;
      
      private var isHiden$field:Boolean;
      
      public function EggItemMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeCounts() : void
      {
         hasField$0 &= 4294967291;
         counts$field = new int();
      }
      
      public function get hasCounts() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set counts(param1:int) : void
      {
         hasField$0 |= 4;
         counts$field = param1;
      }
      
      public function get counts() : int
      {
         return counts$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967287;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeIsHiden() : void
      {
         hasField$0 &= 4294967279;
         isHiden$field = new Boolean();
      }
      
      public function get hasIsHiden() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isHiden(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isHiden$field = param1;
      }
      
      public function get isHiden() : Boolean
      {
         return isHiden$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasCounts)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,counts$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasIsHiden)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isHiden$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EggItemMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EggItemMsg.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EggItemMsg.counts cannot be set twice.");
                  }
                  _loc3_++;
                  counts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EggItemMsg.isOpen cannot be set twice.");
                  }
                  _loc4_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EggItemMsg.isHiden cannot be set twice.");
                  }
                  _loc8_++;
                  isHiden = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

