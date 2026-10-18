package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TaskData extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var allyId$field:int;
      
      private var currentCount$field:int;
      
      private var status$field:int;
      
      public function TaskData()
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
      
      public function removeAllyId() : void
      {
         hasField$0 &= 4294967293;
         allyId$field = new int();
      }
      
      public function get hasAllyId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set allyId(param1:int) : void
      {
         hasField$0 |= 2;
         allyId$field = param1;
      }
      
      public function get allyId() : int
      {
         return allyId$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$0 &= 4294967291;
         currentCount$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$0 |= 4;
         currentCount$field = param1;
      }
      
      public function get currentCount() : int
      {
         return currentCount$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967287;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 8;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasAllyId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,allyId$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,currentCount$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TaskData.templateId cannot be set twice.");
                  }
                  _loc3_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TaskData.allyId cannot be set twice.");
                  }
                  _loc4_++;
                  allyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TaskData.currentCount cannot be set twice.");
                  }
                  _loc5_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TaskData.status cannot be set twice.");
                  }
                  _loc7_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

