package com.road.yishi.proto.children
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildrenMsg extends Message implements IExternalizable
   {
      
      private var child_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var name$field:String;
      
      private var job$field:int;
      
      private var sex$field:int;
      
      private var userId_a$field:int;
      
      private var growth_grade$field:int;
      
      private var skill$field:String;
      
      private var fight_userId$field:int;
      
      private var fight_skill$field:String;
      
      private var state$field:int;
      
      private var birth_time$field:String;
      
      private var growth_gp$field:int;
      
      private var growth_count$field:int;
      
      private var fight_capacity$field:int;
      
      private var skill_books$field:String;
      
      [ArrayElementType("com.road.yishi.proto.children.EmblemMsg")]
      public var emblemPos:Array = [];
      
      private var emblem$field:int;
      
      private var emblemGp$field:int;
      
      private var fight_pet$field:FightPetMsg;
      
      private var fightSlaveUserId$field:int;
      
      private var join_info$field:JoinInfoMsg;
      
      private var childAssistAwakeLevel$field:int;
      
      public function ChildrenMsg()
      {
         super();
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294967294;
         child_id$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 1;
         child_id$field = param1;
      }
      
      public function get childId() : int
      {
         return child_id$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967293;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 2;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967291;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 4;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeUserIdA() : void
      {
         hasField$0 &= 4294967287;
         userId_a$field = new int();
      }
      
      public function get hasUserIdA() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set userIdA(param1:int) : void
      {
         hasField$0 |= 8;
         userId_a$field = param1;
      }
      
      public function get userIdA() : int
      {
         return userId_a$field;
      }
      
      public function removeGrowthGrade() : void
      {
         hasField$0 &= 4294967279;
         growth_grade$field = new int();
      }
      
      public function get hasGrowthGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set growthGrade(param1:int) : void
      {
         hasField$0 |= 16;
         growth_grade$field = param1;
      }
      
      public function get growthGrade() : int
      {
         return growth_grade$field;
      }
      
      public function removeSkill() : void
      {
         skill$field = null;
      }
      
      public function get hasSkill() : Boolean
      {
         return skill$field != null;
      }
      
      public function set skill(param1:String) : void
      {
         skill$field = param1;
      }
      
      public function get skill() : String
      {
         return skill$field;
      }
      
      public function removeFightUserId() : void
      {
         hasField$0 &= 4294967263;
         fight_userId$field = new int();
      }
      
      public function get hasFightUserId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set fightUserId(param1:int) : void
      {
         hasField$0 |= 32;
         fight_userId$field = param1;
      }
      
      public function get fightUserId() : int
      {
         return fight_userId$field;
      }
      
      public function removeFightSkill() : void
      {
         fight_skill$field = null;
      }
      
      public function get hasFightSkill() : Boolean
      {
         return fight_skill$field != null;
      }
      
      public function set fightSkill(param1:String) : void
      {
         fight_skill$field = param1;
      }
      
      public function get fightSkill() : String
      {
         return fight_skill$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967231;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 64;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeBirthTime() : void
      {
         birth_time$field = null;
      }
      
      public function get hasBirthTime() : Boolean
      {
         return birth_time$field != null;
      }
      
      public function set birthTime(param1:String) : void
      {
         birth_time$field = param1;
      }
      
      public function get birthTime() : String
      {
         return birth_time$field;
      }
      
      public function removeGrowthGp() : void
      {
         hasField$0 &= 4294967167;
         growth_gp$field = new int();
      }
      
      public function get hasGrowthGp() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set growthGp(param1:int) : void
      {
         hasField$0 |= 128;
         growth_gp$field = param1;
      }
      
      public function get growthGp() : int
      {
         return growth_gp$field;
      }
      
      public function removeGrowthCount() : void
      {
         hasField$0 &= 4294967039;
         growth_count$field = new int();
      }
      
      public function get hasGrowthCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set growthCount(param1:int) : void
      {
         hasField$0 |= 256;
         growth_count$field = param1;
      }
      
      public function get growthCount() : int
      {
         return growth_count$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294966783;
         fight_capacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 512;
         fight_capacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fight_capacity$field;
      }
      
      public function removeSkillBooks() : void
      {
         skill_books$field = null;
      }
      
      public function get hasSkillBooks() : Boolean
      {
         return skill_books$field != null;
      }
      
      public function set skillBooks(param1:String) : void
      {
         skill_books$field = param1;
      }
      
      public function get skillBooks() : String
      {
         return skill_books$field;
      }
      
      public function removeEmblem() : void
      {
         hasField$0 &= 4294966271;
         emblem$field = new int();
      }
      
      public function get hasEmblem() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set emblem(param1:int) : void
      {
         hasField$0 |= 1024;
         emblem$field = param1;
      }
      
      public function get emblem() : int
      {
         return emblem$field;
      }
      
      public function removeEmblemGp() : void
      {
         hasField$0 &= 4294965247;
         emblemGp$field = new int();
      }
      
      public function get hasEmblemGp() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set emblemGp(param1:int) : void
      {
         hasField$0 |= 2048;
         emblemGp$field = param1;
      }
      
      public function get emblemGp() : int
      {
         return emblemGp$field;
      }
      
      public function removeFightPet() : void
      {
         fight_pet$field = null;
      }
      
      public function get hasFightPet() : Boolean
      {
         return fight_pet$field != null;
      }
      
      public function set fightPet(param1:FightPetMsg) : void
      {
         fight_pet$field = param1;
      }
      
      public function get fightPet() : FightPetMsg
      {
         return fight_pet$field;
      }
      
      public function removeFightSlaveUserId() : void
      {
         hasField$0 &= 4294963199;
         fightSlaveUserId$field = new int();
      }
      
      public function get hasFightSlaveUserId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set fightSlaveUserId(param1:int) : void
      {
         hasField$0 |= 4096;
         fightSlaveUserId$field = param1;
      }
      
      public function get fightSlaveUserId() : int
      {
         return fightSlaveUserId$field;
      }
      
      public function removeJoinInfo() : void
      {
         join_info$field = null;
      }
      
      public function get hasJoinInfo() : Boolean
      {
         return join_info$field != null;
      }
      
      public function set joinInfo(param1:JoinInfoMsg) : void
      {
         join_info$field = param1;
      }
      
      public function get joinInfo() : JoinInfoMsg
      {
         return join_info$field;
      }
      
      public function removeChildAssistAwakeLevel() : void
      {
         hasField$0 &= 4294959103;
         childAssistAwakeLevel$field = new int();
      }
      
      public function get hasChildAssistAwakeLevel() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set childAssistAwakeLevel(param1:int) : void
      {
         hasField$0 |= 8192;
         childAssistAwakeLevel$field = param1;
      }
      
      public function get childAssistAwakeLevel() : int
      {
         return childAssistAwakeLevel$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,child_id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasUserIdA)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,userId_a$field);
         }
         if(hasGrowthGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,growth_grade$field);
         }
         if(hasSkill)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,skill$field);
         }
         if(hasFightUserId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,fight_userId$field);
         }
         if(hasFightSkill)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,fight_skill$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasBirthTime)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,birth_time$field);
         }
         if(hasGrowthGp)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,growth_gp$field);
         }
         if(hasGrowthCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,growth_count$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity$field);
         }
         if(hasSkillBooks)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,skill_books$field);
         }
         _loc2_ = 0;
         while(_loc2_ < emblemPos.length)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_MESSAGE(param1,emblemPos[_loc2_]);
            _loc2_++;
         }
         if(hasEmblem)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,emblem$field);
         }
         if(hasEmblemGp)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,emblemGp$field);
         }
         if(hasFightPet)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,fight_pet$field);
         }
         if(hasFightSlaveUserId)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,fightSlaveUserId$field);
         }
         if(hasJoinInfo)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_MESSAGE(param1,join_info$field);
         }
         if(hasChildAssistAwakeLevel)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,childAssistAwakeLevel$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc22_:EmblemMsg = null;
         var _loc4_:uint = 0;
         var _loc19_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc23_:uint = 0;
         var _loc21_:uint = 0;
         var _loc24_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc18_:uint = 0;
         var _loc3_:uint = 0;
         var _loc25_:uint = 0;
         var _loc8_:uint = 0;
         var _loc20_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.childId cannot be set twice.");
                  }
                  _loc4_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.name cannot be set twice.");
                  }
                  _loc19_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.job cannot be set twice.");
                  }
                  _loc9_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.sex cannot be set twice.");
                  }
                  _loc5_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.userIdA cannot be set twice.");
                  }
                  _loc16_++;
                  userIdA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.growthGrade cannot be set twice.");
                  }
                  _loc7_++;
                  growthGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.skill cannot be set twice.");
                  }
                  _loc6_++;
                  skill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.fightUserId cannot be set twice.");
                  }
                  _loc10_++;
                  fightUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.fightSkill cannot be set twice.");
                  }
                  _loc17_++;
                  fightSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.state cannot be set twice.");
                  }
                  _loc11_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.birthTime cannot be set twice.");
                  }
                  _loc13_++;
                  birthTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.growthGp cannot be set twice.");
                  }
                  _loc23_++;
                  growthGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.growthCount cannot be set twice.");
                  }
                  _loc21_++;
                  growthCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.fightCapacity cannot be set twice.");
                  }
                  _loc24_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.skillBooks cannot be set twice.");
                  }
                  _loc14_++;
                  skillBooks = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  _loc22_ = new EmblemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc22_);
                  emblemPos.push(_loc22_);
                  break;
               case 17:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.emblem cannot be set twice.");
                  }
                  _loc15_++;
                  emblem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.emblemGp cannot be set twice.");
                  }
                  _loc18_++;
                  emblemGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.fightPet cannot be set twice.");
                  }
                  _loc3_++;
                  fightPet = new FightPetMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,fightPet);
                  break;
               case 20:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.fightSlaveUserId cannot be set twice.");
                  }
                  _loc25_++;
                  fightSlaveUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.joinInfo cannot be set twice.");
                  }
                  _loc8_++;
                  joinInfo = new JoinInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,joinInfo);
                  break;
               case 22:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenMsg.childAssistAwakeLevel cannot be set twice.");
                  }
                  _loc20_++;
                  childAssistAwakeLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

