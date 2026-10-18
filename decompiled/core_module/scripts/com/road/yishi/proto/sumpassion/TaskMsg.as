package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TaskMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var taskType$field:int;
      
      private var needKillCount$field:int;
      
      private var killCount$field:int;
      
      private var isSendReward$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.ItemMsg")]
      public var item:Array = [];
      
      public function TaskMsg()
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
      
      public function removeTaskType() : void
      {
         hasField$0 &= 4294967293;
         taskType$field = new int();
      }
      
      public function get hasTaskType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set taskType(param1:int) : void
      {
         hasField$0 |= 2;
         taskType$field = param1;
      }
      
      public function get taskType() : int
      {
         return taskType$field;
      }
      
      public function removeNeedKillCount() : void
      {
         hasField$0 &= 4294967291;
         needKillCount$field = new int();
      }
      
      public function get hasNeedKillCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set needKillCount(param1:int) : void
      {
         hasField$0 |= 4;
         needKillCount$field = param1;
      }
      
      public function get needKillCount() : int
      {
         return needKillCount$field;
      }
      
      public function removeKillCount() : void
      {
         hasField$0 &= 4294967287;
         killCount$field = new int();
      }
      
      public function get hasKillCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set killCount(param1:int) : void
      {
         hasField$0 |= 8;
         killCount$field = param1;
      }
      
      public function get killCount() : int
      {
         return killCount$field;
      }
      
      public function removeIsSendReward() : void
      {
         hasField$0 &= 4294967279;
         isSendReward$field = new Boolean();
      }
      
      public function get hasIsSendReward() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isSendReward(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isSendReward$field = param1;
      }
      
      public function get isSendReward() : Boolean
      {
         return isSendReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasTaskType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,taskType$field);
         }
         if(hasNeedKillCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,needKillCount$field);
         }
         if(hasKillCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,killCount$field);
         }
         if(hasIsSendReward)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isSendReward$field);
         }
         _loc2_ = 0;
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:ItemMsg = null;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TaskMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TaskMsg.taskType cannot be set twice.");
                  }
                  _loc3_++;
                  taskType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TaskMsg.needKillCount cannot be set twice.");
                  }
                  _loc8_++;
                  needKillCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TaskMsg.killCount cannot be set twice.");
                  }
                  _loc5_++;
                  killCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TaskMsg.isSendReward cannot be set twice.");
                  }
                  _loc6_++;
                  isSendReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  _loc4_ = new ItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  item.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

