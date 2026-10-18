package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BufferDataMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var validity_date$field:int;
      
      private var grade$field:int;
      
      private var type$field:int;
      
      private var type_templateid$field:int;
      
      private var isCancel$field:Boolean;
      
      public function BufferDataMsg()
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
      
      public function removeValidityDate() : void
      {
         hasField$0 &= 4294967293;
         validity_date$field = new int();
      }
      
      public function get hasValidityDate() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set validityDate(param1:int) : void
      {
         hasField$0 |= 2;
         validity_date$field = param1;
      }
      
      public function get validityDate() : int
      {
         return validity_date$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967291;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 4;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967287;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeTypeTemplateid() : void
      {
         hasField$0 &= 4294967279;
         type_templateid$field = new int();
      }
      
      public function get hasTypeTemplateid() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set typeTemplateid(param1:int) : void
      {
         hasField$0 |= 16;
         type_templateid$field = param1;
      }
      
      public function get typeTemplateid() : int
      {
         return type_templateid$field;
      }
      
      public function removeIsCancel() : void
      {
         hasField$0 &= 4294967263;
         isCancel$field = new Boolean();
      }
      
      public function get hasIsCancel() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isCancel(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isCancel$field = param1;
      }
      
      public function get isCancel() : Boolean
      {
         return isCancel$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasValidityDate)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,validity_date$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasTypeTemplateid)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,type_templateid$field);
         }
         if(hasIsCancel)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isCancel$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BufferDataMsg.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BufferDataMsg.validityDate cannot be set twice.");
                  }
                  _loc5_++;
                  validityDate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BufferDataMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BufferDataMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BufferDataMsg.typeTemplateid cannot be set twice.");
                  }
                  _loc9_++;
                  typeTemplateid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BufferDataMsg.isCancel cannot be set twice.");
                  }
                  _loc3_++;
                  isCancel = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

