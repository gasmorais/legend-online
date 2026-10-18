package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroSkillInfoMsg extends Message implements IExternalizable
   {
      
      private var skill_point$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skill_script$field:String;
      
      [ArrayElementType("int")]
      public var skillSet:Array = [];
      
      public function HeroSkillInfoMsg()
      {
         super();
      }
      
      public function removeSkillPoint() : void
      {
         hasField$0 &= 4294967294;
         skill_point$field = new int();
      }
      
      public function get hasSkillPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillPoint(param1:int) : void
      {
         hasField$0 |= 1;
         skill_point$field = param1;
      }
      
      public function get skillPoint() : int
      {
         return skill_point$field;
      }
      
      public function removeSkillScript() : void
      {
         skill_script$field = null;
      }
      
      public function get hasSkillScript() : Boolean
      {
         return skill_script$field != null;
      }
      
      public function set skillScript(param1:String) : void
      {
         skill_script$field = param1;
      }
      
      public function get skillScript() : String
      {
         return skill_script$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasSkillPoint)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skill_point$field);
         }
         if(hasSkillScript)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,skill_script$field);
         }
         _loc2_ = 0;
         while(_loc2_ < skillSet.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skillSet[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroSkillInfoMsg.skillPoint cannot be set twice.");
                  }
                  _loc3_++;
                  skillPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroSkillInfoMsg.skillScript cannot be set twice.");
                  }
                  _loc4_++;
                  skillScript = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillSet);
                  }
                  else
                  {
                     skillSet.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

