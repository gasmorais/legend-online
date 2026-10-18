package com.road.yishi.proto.eclipticpalace
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EclipticPalaceRouteMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.eclipticpalace.EclipticPalaceBossMsg")]
      public var bossList:Array = [];
      
      private var guard_job_type1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var guard_job_type2$field:int;
      
      private var skill_id$field:int;
      
      public function EclipticPalaceRouteMsg()
      {
         super();
      }
      
      public function removeGuardJobType1() : void
      {
         hasField$0 &= 4294967294;
         guard_job_type1$field = new int();
      }
      
      public function get hasGuardJobType1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set guardJobType1(param1:int) : void
      {
         hasField$0 |= 1;
         guard_job_type1$field = param1;
      }
      
      public function get guardJobType1() : int
      {
         return guard_job_type1$field;
      }
      
      public function removeGuardJobType2() : void
      {
         hasField$0 &= 4294967293;
         guard_job_type2$field = new int();
      }
      
      public function get hasGuardJobType2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set guardJobType2(param1:int) : void
      {
         hasField$0 |= 2;
         guard_job_type2$field = param1;
      }
      
      public function get guardJobType2() : int
      {
         return guard_job_type2$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967291;
         skill_id$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 4;
         skill_id$field = param1;
      }
      
      public function get skillId() : int
      {
         return skill_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < bossList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,bossList[_loc2_]);
            _loc2_++;
         }
         if(hasGuardJobType1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,guard_job_type1$field);
         }
         if(hasGuardJobType2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,guard_job_type2$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,skill_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:EclipticPalaceBossMsg = null;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new EclipticPalaceBossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  bossList.push(_loc6_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceRouteMsg.guardJobType1 cannot be set twice.");
                  }
                  _loc3_++;
                  guardJobType1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceRouteMsg.guardJobType2 cannot be set twice.");
                  }
                  _loc7_++;
                  guardJobType2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceRouteMsg.skillId cannot be set twice.");
                  }
                  _loc4_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

