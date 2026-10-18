package com.road.yishi.proto.dragontalker
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkillInfoMsg extends Message implements IExternalizable
   {
      
      private var skillIndex$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skillPoint$field:int;
      
      private var skillScript$field:String;
      
      private var fastKey$field:String;
      
      public function SkillInfoMsg()
      {
         super();
      }
      
      public function removeSkillIndex() : void
      {
         hasField$0 &= 4294967294;
         skillIndex$field = new int();
      }
      
      public function get hasSkillIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillIndex(param1:int) : void
      {
         hasField$0 |= 1;
         skillIndex$field = param1;
      }
      
      public function get skillIndex() : int
      {
         return skillIndex$field;
      }
      
      public function removeSkillPoint() : void
      {
         hasField$0 &= 4294967293;
         skillPoint$field = new int();
      }
      
      public function get hasSkillPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set skillPoint(param1:int) : void
      {
         hasField$0 |= 2;
         skillPoint$field = param1;
      }
      
      public function get skillPoint() : int
      {
         return skillPoint$field;
      }
      
      public function removeSkillScript() : void
      {
         skillScript$field = null;
      }
      
      public function get hasSkillScript() : Boolean
      {
         return skillScript$field != null;
      }
      
      public function set skillScript(param1:String) : void
      {
         skillScript$field = param1;
      }
      
      public function get skillScript() : String
      {
         return skillScript$field;
      }
      
      public function removeFastKey() : void
      {
         fastKey$field = null;
      }
      
      public function get hasFastKey() : Boolean
      {
         return fastKey$field != null;
      }
      
      public function set fastKey(param1:String) : void
      {
         fastKey$field = param1;
      }
      
      public function get fastKey() : String
      {
         return fastKey$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skillIndex$field);
         }
         if(hasSkillPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,skillPoint$field);
         }
         if(hasSkillScript)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,skillScript$field);
         }
         if(hasFastKey)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,fastKey$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkillInfoMsg.skillIndex cannot be set twice.");
                  }
                  _loc3_++;
                  skillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkillInfoMsg.skillPoint cannot be set twice.");
                  }
                  _loc6_++;
                  skillPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SkillInfoMsg.skillScript cannot be set twice.");
                  }
                  _loc7_++;
                  skillScript = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SkillInfoMsg.fastKey cannot be set twice.");
                  }
                  _loc5_++;
                  fastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

