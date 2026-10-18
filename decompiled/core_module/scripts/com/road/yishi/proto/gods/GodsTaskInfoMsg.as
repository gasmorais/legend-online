package com.road.yishi.proto.gods
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GodsTaskInfoMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cur_count$field:int;
      
      private var has_reward$field:Boolean;
      
      private var repeat_count$field:int;
      
      public function GodsTaskInfoMsg()
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
      
      public function removeCurCount() : void
      {
         hasField$0 &= 4294967293;
         cur_count$field = new int();
      }
      
      public function get hasCurCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curCount(param1:int) : void
      {
         hasField$0 |= 2;
         cur_count$field = param1;
      }
      
      public function get curCount() : int
      {
         return cur_count$field;
      }
      
      public function removeHasReward() : void
      {
         hasField$0 &= 4294967291;
         has_reward$field = new Boolean();
      }
      
      public function get hasHasReward() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set hasReward(param1:Boolean) : void
      {
         hasField$0 |= 4;
         has_reward$field = param1;
      }
      
      public function get hasReward() : Boolean
      {
         return has_reward$field;
      }
      
      public function removeRepeatCount() : void
      {
         hasField$0 &= 4294967287;
         repeat_count$field = new int();
      }
      
      public function get hasRepeatCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set repeatCount(param1:int) : void
      {
         hasField$0 |= 8;
         repeat_count$field = param1;
      }
      
      public function get repeatCount() : int
      {
         return repeat_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasCurCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,cur_count$field);
         }
         if(hasHasReward)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,has_reward$field);
         }
         if(hasRepeatCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,repeat_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GodsTaskInfoMsg.templateId cannot be set twice.");
                  }
                  _loc4_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GodsTaskInfoMsg.curCount cannot be set twice.");
                  }
                  _loc6_++;
                  curCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GodsTaskInfoMsg.hasReward cannot be set twice.");
                  }
                  _loc3_++;
                  hasReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GodsTaskInfoMsg.repeatCount cannot be set twice.");
                  }
                  _loc7_++;
                  repeatCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

