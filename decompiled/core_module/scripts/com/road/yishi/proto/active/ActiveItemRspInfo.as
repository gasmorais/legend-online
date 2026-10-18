package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveItemRspInfo extends Message implements IExternalizable
   {
      
      private var activeId$field:String;
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var counts$field:int;
      
      private var jobs$field:int;
      
      private var isBind$field:Boolean;
      
      private var templateType$field:int;
      
      public function ActiveItemRspInfo()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         activeId$field = null;
      }
      
      public function get hasActiveId() : Boolean
      {
         return activeId$field != null;
      }
      
      public function set activeId(param1:String) : void
      {
         activeId$field = param1;
      }
      
      public function get activeId() : String
      {
         return activeId$field;
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
      
      public function removeCounts() : void
      {
         hasField$0 &= 4294967293;
         counts$field = new int();
      }
      
      public function get hasCounts() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set counts(param1:int) : void
      {
         hasField$0 |= 2;
         counts$field = param1;
      }
      
      public function get counts() : int
      {
         return counts$field;
      }
      
      public function removeJobs() : void
      {
         hasField$0 &= 4294967291;
         jobs$field = new int();
      }
      
      public function get hasJobs() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set jobs(param1:int) : void
      {
         hasField$0 |= 4;
         jobs$field = param1;
      }
      
      public function get jobs() : int
      {
         return jobs$field;
      }
      
      public function removeIsBind() : void
      {
         hasField$0 &= 4294967287;
         isBind$field = new Boolean();
      }
      
      public function get hasIsBind() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isBind(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isBind$field = param1;
      }
      
      public function get isBind() : Boolean
      {
         return isBind$field;
      }
      
      public function removeTemplateType() : void
      {
         hasField$0 &= 4294967279;
         templateType$field = new int();
      }
      
      public function get hasTemplateType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set templateType(param1:int) : void
      {
         hasField$0 |= 16;
         templateType$field = param1;
      }
      
      public function get templateType() : int
      {
         return templateType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,activeId$field);
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
         if(hasJobs)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,jobs$field);
         }
         if(hasIsBind)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isBind$field);
         }
         if(hasTemplateType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,templateType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveItemRspInfo.activeId cannot be set twice.");
                  }
                  _loc7_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveItemRspInfo.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveItemRspInfo.counts cannot be set twice.");
                  }
                  _loc3_++;
                  counts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveItemRspInfo.jobs cannot be set twice.");
                  }
                  _loc8_++;
                  jobs = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveItemRspInfo.isBind cannot be set twice.");
                  }
                  _loc4_++;
                  isBind = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveItemRspInfo.templateType cannot be set twice.");
                  }
                  _loc6_++;
                  templateType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

