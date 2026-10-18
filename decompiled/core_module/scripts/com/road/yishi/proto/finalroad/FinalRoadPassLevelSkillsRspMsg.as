package com.road.yishi.proto.finalroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FinalRoadPassLevelSkillsRspMsg extends Message implements IExternalizable
   {
      
      private var level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skills$field:String;
      
      public function FinalRoadPassLevelSkillsRspMsg()
      {
         super();
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967294;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 1;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadPassLevelSkillsRspMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadPassLevelSkillsRspMsg.skills cannot be set twice.");
                  }
                  _loc5_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

