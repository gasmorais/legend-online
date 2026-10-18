package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReliveMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:String;
      
      private var living_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skill_id$field:int;
      
      private var parm1$field:int;
      
      private var parm2$field:int;
      
      private var parm3$field:String;
      
      public function ReliveMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         battle_id$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battle_id$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battle_id$field = param1;
      }
      
      public function get battleId() : String
      {
         return battle_id$field;
      }
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967294;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 1;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967293;
         skill_id$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 2;
         skill_id$field = param1;
      }
      
      public function get skillId() : int
      {
         return skill_id$field;
      }
      
      public function removeParm1() : void
      {
         hasField$0 &= 4294967291;
         parm1$field = new int();
      }
      
      public function get hasParm1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set parm1(param1:int) : void
      {
         hasField$0 |= 4;
         parm1$field = param1;
      }
      
      public function get parm1() : int
      {
         return parm1$field;
      }
      
      public function removeParm2() : void
      {
         hasField$0 &= 4294967287;
         parm2$field = new int();
      }
      
      public function get hasParm2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set parm2(param1:int) : void
      {
         hasField$0 |= 8;
         parm2$field = param1;
      }
      
      public function get parm2() : int
      {
         return parm2$field;
      }
      
      public function removeParm3() : void
      {
         parm3$field = null;
      }
      
      public function get hasParm3() : Boolean
      {
         return parm3$field != null;
      }
      
      public function set parm3(param1:String) : void
      {
         parm3$field = param1;
      }
      
      public function get parm3() : String
      {
         return parm3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skill_id$field);
         }
         if(hasParm1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,parm1$field);
         }
         if(hasParm2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,parm2$field);
         }
         if(hasParm3)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,parm3$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ReliveMsg.battleId cannot be set twice.");
                  }
                  _loc7_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ReliveMsg.livingId cannot be set twice.");
                  }
                  _loc8_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ReliveMsg.skillId cannot be set twice.");
                  }
                  _loc5_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ReliveMsg.parm1 cannot be set twice.");
                  }
                  _loc3_++;
                  parm1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ReliveMsg.parm2 cannot be set twice.");
                  }
                  _loc4_++;
                  parm2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ReliveMsg.parm3 cannot be set twice.");
                  }
                  _loc9_++;
                  parm3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

