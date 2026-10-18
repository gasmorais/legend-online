package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SumActiveItemInfoMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var template_type$field:int;
      
      private var count$field:int;
      
      private var isbind$field:Boolean;
      
      private var length$field:int;
      
      private var job$field:int;
      
      public function SumActiveItemInfoMsg()
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
      
      public function removeTemplateType() : void
      {
         hasField$0 &= 4294967293;
         template_type$field = new int();
      }
      
      public function get hasTemplateType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateType(param1:int) : void
      {
         hasField$0 |= 2;
         template_type$field = param1;
      }
      
      public function get templateType() : int
      {
         return template_type$field;
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
      
      public function removeIsbind() : void
      {
         hasField$0 &= 4294967287;
         isbind$field = new Boolean();
      }
      
      public function get hasIsbind() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isbind(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isbind$field = param1;
      }
      
      public function get isbind() : Boolean
      {
         return isbind$field;
      }
      
      public function removeLength() : void
      {
         hasField$0 &= 4294967279;
         length$field = new int();
      }
      
      public function get hasLength() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set length(param1:int) : void
      {
         hasField$0 |= 16;
         length$field = param1;
      }
      
      public function get length() : int
      {
         return length$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967263;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 32;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasTemplateType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,template_type$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasIsbind)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isbind$field);
         }
         if(hasLength)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,length$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveItemInfoMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveItemInfoMsg.templateType cannot be set twice.");
                  }
                  _loc6_++;
                  templateType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveItemInfoMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveItemInfoMsg.isbind cannot be set twice.");
                  }
                  _loc9_++;
                  isbind = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveItemInfoMsg.length cannot be set twice.");
                  }
                  _loc4_++;
                  length = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveItemInfoMsg.job cannot be set twice.");
                  }
                  _loc5_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

