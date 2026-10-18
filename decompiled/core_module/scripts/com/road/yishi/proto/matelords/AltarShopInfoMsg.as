package com.road.yishi.proto.matelords
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AltarShopInfoMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var price$field:int;
      
      private var leftCount$field:int;
      
      private var maxCount$field:int;
      
      private var skillTempId$field:int;
      
      public function AltarShopInfoMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removePrice() : void
      {
         hasField$0 &= 4294967293;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 2;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967291;
         leftCount$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 4;
         leftCount$field = param1;
      }
      
      public function get leftCount() : int
      {
         return leftCount$field;
      }
      
      public function removeMaxCount() : void
      {
         hasField$0 &= 4294967287;
         maxCount$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$0 |= 8;
         maxCount$field = param1;
      }
      
      public function get maxCount() : int
      {
         return maxCount$field;
      }
      
      public function removeSkillTempId() : void
      {
         hasField$0 &= 4294967279;
         skillTempId$field = new int();
      }
      
      public function get hasSkillTempId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set skillTempId(param1:int) : void
      {
         hasField$0 |= 16;
         skillTempId$field = param1;
      }
      
      public function get skillTempId() : int
      {
         return skillTempId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,leftCount$field);
         }
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,maxCount$field);
         }
         if(hasSkillTempId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,skillTempId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopInfoMsg.templateId cannot be set twice.");
                  }
                  _loc3_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopInfoMsg.price cannot be set twice.");
                  }
                  _loc4_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopInfoMsg.leftCount cannot be set twice.");
                  }
                  _loc6_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopInfoMsg.maxCount cannot be set twice.");
                  }
                  _loc7_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopInfoMsg.skillTempId cannot be set twice.");
                  }
                  _loc5_++;
                  skillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

