package com.road.yishi.proto.achievementtask
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AchievementTaskListMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var leftSecond$field:int;
      
      [ArrayElementType("com.road.yishi.proto.achievementtask.AchievementTaskMsg")]
      public var tasks:Array = [];
      
      public function AchievementTaskListMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeLeftSecond() : void
      {
         hasField$0 &= 4294967291;
         leftSecond$field = new int();
      }
      
      public function get hasLeftSecond() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leftSecond(param1:int) : void
      {
         hasField$0 |= 4;
         leftSecond$field = param1;
      }
      
      public function get leftSecond() : int
      {
         return leftSecond$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasLeftSecond)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,leftSecond$field);
         }
         _loc2_ = 0;
         while(_loc2_ < tasks.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,tasks[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:AchievementTaskMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskListMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskListMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskListMsg.leftSecond cannot be set twice.");
                  }
                  _loc3_++;
                  leftSecond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc7_ = new AchievementTaskMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  tasks.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

