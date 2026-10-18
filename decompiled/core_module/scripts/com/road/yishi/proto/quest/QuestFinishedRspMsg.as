package com.road.yishi.proto.quest
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuestFinishedRspMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isJump$field:int;
      
      [ArrayElementType("com.road.yishi.proto.quest.FinishedTempId")]
      public var finishedTemps:Array = [];
      
      public function QuestFinishedRspMsg()
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
      
      public function removeIsJump() : void
      {
         hasField$0 &= 4294967293;
         isJump$field = new int();
      }
      
      public function get hasIsJump() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isJump(param1:int) : void
      {
         hasField$0 |= 2;
         isJump$field = param1;
      }
      
      public function get isJump() : int
      {
         return isJump$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasIsJump)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,isJump$field);
         }
         _loc2_ = 0;
         while(_loc2_ < finishedTemps.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,finishedTemps[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:FinishedTempId = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuestFinishedRspMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuestFinishedRspMsg.isJump cannot be set twice.");
                  }
                  _loc4_++;
                  isJump = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new FinishedTempId();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  finishedTemps.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

