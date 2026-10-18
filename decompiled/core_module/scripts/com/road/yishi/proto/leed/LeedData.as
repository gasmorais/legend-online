package com.road.yishi.proto.leed
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LeedData extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var current_count$field:int;
      
      private var begin_date$field:String;
      
      private var is_complete$field:Boolean;
      
      public function LeedData()
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$0 &= 4294967291;
         current_count$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$0 |= 4;
         current_count$field = param1;
      }
      
      public function get currentCount() : int
      {
         return current_count$field;
      }
      
      public function removeBeginDate() : void
      {
         begin_date$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return begin_date$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         begin_date$field = param1;
      }
      
      public function get beginDate() : String
      {
         return begin_date$field;
      }
      
      public function removeIsComplete() : void
      {
         hasField$0 &= 4294967287;
         is_complete$field = new Boolean();
      }
      
      public function get hasIsComplete() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isComplete(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_complete$field = param1;
      }
      
      public function get isComplete() : Boolean
      {
         return is_complete$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,current_count$field);
         }
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,begin_date$field);
         }
         if(hasIsComplete)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_complete$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LeedData.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LeedData.userId cannot be set twice.");
                  }
                  _loc4_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LeedData.currentCount cannot be set twice.");
                  }
                  _loc3_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LeedData.beginDate cannot be set twice.");
                  }
                  _loc5_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LeedData.isComplete cannot be set twice.");
                  }
                  _loc8_++;
                  isComplete = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

