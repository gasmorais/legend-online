package com.road.yishi.proto.quest
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuestFinishedReqMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var reward_item_id$field:int;
      
      private var is_pass$field:Boolean;
      
      public function QuestFinishedReqMsg()
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
      
      public function removeRewardItemId() : void
      {
         hasField$0 &= 4294967293;
         reward_item_id$field = new int();
      }
      
      public function get hasRewardItemId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardItemId(param1:int) : void
      {
         hasField$0 |= 2;
         reward_item_id$field = param1;
      }
      
      public function get rewardItemId() : int
      {
         return reward_item_id$field;
      }
      
      public function removeIsPass() : void
      {
         hasField$0 &= 4294967291;
         is_pass$field = new Boolean();
      }
      
      public function get hasIsPass() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isPass(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_pass$field = param1;
      }
      
      public function get isPass() : Boolean
      {
         return is_pass$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasRewardItemId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,reward_item_id$field);
         }
         if(hasIsPass)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_pass$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuestFinishedReqMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: QuestFinishedReqMsg.rewardItemId cannot be set twice.");
                  }
                  _loc3_++;
                  rewardItemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuestFinishedReqMsg.isPass cannot be set twice.");
                  }
                  _loc4_++;
                  isPass = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

