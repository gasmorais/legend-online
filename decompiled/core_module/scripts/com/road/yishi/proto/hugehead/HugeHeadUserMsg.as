package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadUserMsg extends Message implements IExternalizable
   {
      
      private var user_uid$field:String;
      
      private var nick_name$field:String;
      
      private var stack_head_alive$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var stack_head_debuff_level$field:int;
      
      private var fight_capacity$field:int;
      
      private var grade$field:int;
      
      private var first_change_grade$field:int;
      
      private var second_change_grade$field:int;
      
      private var change_branch$field:int;
      
      private var job$field:int;
      
      private var userid$field:int;
      
      public function HugeHeadUserMsg()
      {
         super();
      }
      
      public function removeUserUid() : void
      {
         user_uid$field = null;
      }
      
      public function get hasUserUid() : Boolean
      {
         return user_uid$field != null;
      }
      
      public function set userUid(param1:String) : void
      {
         user_uid$field = param1;
      }
      
      public function get userUid() : String
      {
         return user_uid$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeStackHeadAlive() : void
      {
         hasField$0 &= 4294967294;
         stack_head_alive$field = new Boolean();
      }
      
      public function get hasStackHeadAlive() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set stackHeadAlive(param1:Boolean) : void
      {
         hasField$0 |= 1;
         stack_head_alive$field = param1;
      }
      
      public function get stackHeadAlive() : Boolean
      {
         return stack_head_alive$field;
      }
      
      public function removeStackHeadDebuffLevel() : void
      {
         hasField$0 &= 4294967293;
         stack_head_debuff_level$field = new int();
      }
      
      public function get hasStackHeadDebuffLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set stackHeadDebuffLevel(param1:int) : void
      {
         hasField$0 |= 2;
         stack_head_debuff_level$field = param1;
      }
      
      public function get stackHeadDebuffLevel() : int
      {
         return stack_head_debuff_level$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967291;
         fight_capacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 4;
         fight_capacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fight_capacity$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967287;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 8;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeFirstChangeGrade() : void
      {
         hasField$0 &= 4294967279;
         first_change_grade$field = new int();
      }
      
      public function get hasFirstChangeGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set firstChangeGrade(param1:int) : void
      {
         hasField$0 |= 16;
         first_change_grade$field = param1;
      }
      
      public function get firstChangeGrade() : int
      {
         return first_change_grade$field;
      }
      
      public function removeSecondChangeGrade() : void
      {
         hasField$0 &= 4294967263;
         second_change_grade$field = new int();
      }
      
      public function get hasSecondChangeGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set secondChangeGrade(param1:int) : void
      {
         hasField$0 |= 32;
         second_change_grade$field = param1;
      }
      
      public function get secondChangeGrade() : int
      {
         return second_change_grade$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$0 &= 4294967231;
         change_branch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$0 |= 64;
         change_branch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return change_branch$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967167;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 128;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeUserid() : void
      {
         hasField$0 &= 4294967039;
         userid$field = new int();
      }
      
      public function get hasUserid() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set userid(param1:int) : void
      {
         hasField$0 |= 256;
         userid$field = param1;
      }
      
      public function get userid() : int
      {
         return userid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,user_uid$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasStackHeadAlive)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,stack_head_alive$field);
         }
         if(hasStackHeadDebuffLevel)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,stack_head_debuff_level$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasFirstChangeGrade)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,first_change_grade$field);
         }
         if(hasSecondChangeGrade)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,second_change_grade$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,change_branch$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasUserid)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,userid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.userUid cannot be set twice.");
                  }
                  _loc6_++;
                  userUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.stackHeadAlive cannot be set twice.");
                  }
                  _loc7_++;
                  stackHeadAlive = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.stackHeadDebuffLevel cannot be set twice.");
                  }
                  _loc9_++;
                  stackHeadDebuffLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.fightCapacity cannot be set twice.");
                  }
                  _loc13_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.firstChangeGrade cannot be set twice.");
                  }
                  _loc5_++;
                  firstChangeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.secondChangeGrade cannot be set twice.");
                  }
                  _loc14_++;
                  secondChangeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.changeBranch cannot be set twice.");
                  }
                  _loc12_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.job cannot be set twice.");
                  }
                  _loc10_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadUserMsg.userid cannot be set twice.");
                  }
                  _loc8_++;
                  userid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

