package com.road.yishi.proto.olderreflux
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OlderRefluxInfoMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var needCounts$field:int;
      
      private var rewardState$field:int;
      
      public function OlderRefluxInfoMsg()
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
      
      public function removeNeedCounts() : void
      {
         hasField$0 &= 4294967293;
         needCounts$field = new int();
      }
      
      public function get hasNeedCounts() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set needCounts(param1:int) : void
      {
         hasField$0 |= 2;
         needCounts$field = param1;
      }
      
      public function get needCounts() : int
      {
         return needCounts$field;
      }
      
      public function removeRewardState() : void
      {
         hasField$0 &= 4294967291;
         rewardState$field = new int();
      }
      
      public function get hasRewardState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rewardState(param1:int) : void
      {
         hasField$0 |= 4;
         rewardState$field = param1;
      }
      
      public function get rewardState() : int
      {
         return rewardState$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasNeedCounts)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,needCounts$field);
         }
         if(hasRewardState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rewardState$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxInfoMsg.templateId cannot be set twice.");
                  }
                  _loc3_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxInfoMsg.needCounts cannot be set twice.");
                  }
                  _loc6_++;
                  needCounts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxInfoMsg.rewardState cannot be set twice.");
                  }
                  _loc4_++;
                  rewardState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

