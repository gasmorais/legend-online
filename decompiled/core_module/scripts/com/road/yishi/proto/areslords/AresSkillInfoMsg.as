package com.road.yishi.proto.areslords
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AresSkillInfoMsg extends Message implements IExternalizable
   {
      
      private var skillTempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skillCount$field:int;
      
      public function AresSkillInfoMsg()
      {
         super();
      }
      
      public function removeSkillTempId() : void
      {
         hasField$0 &= 4294967294;
         skillTempId$field = new int();
      }
      
      public function get hasSkillTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillTempId(param1:int) : void
      {
         hasField$0 |= 1;
         skillTempId$field = param1;
      }
      
      public function get skillTempId() : int
      {
         return skillTempId$field;
      }
      
      public function removeSkillCount() : void
      {
         hasField$0 &= 4294967293;
         skillCount$field = new int();
      }
      
      public function get hasSkillCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set skillCount(param1:int) : void
      {
         hasField$0 |= 2;
         skillCount$field = param1;
      }
      
      public function get skillCount() : int
      {
         return skillCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skillTempId$field);
         }
         if(hasSkillCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,skillCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AresSkillInfoMsg.skillTempId cannot be set twice.");
                  }
                  _loc4_++;
                  skillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AresSkillInfoMsg.skillCount cannot be set twice.");
                  }
                  _loc3_++;
                  skillCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

