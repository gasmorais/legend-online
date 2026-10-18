package com.road.yishi.proto.children
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildrenInfoMsg extends Message implements IExternalizable
   {
      
      private var child_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var name$field:String;
      
      private var job$field:int;
      
      private var sex$field:int;
      
      private var userId_a$field:int;
      
      private var userId_b$field:int;
      
      private var growth_grade$field:int;
      
      private var mood$field:int;
      
      private var growth_gp$field:int;
      
      private var growth_count$field:int;
      
      private var fight_capacity$field:int;
      
      private var state$field:int;
      
      [ArrayElementType("com.road.yishi.proto.children.ChildEquipmentMsg")]
      public var equipmets:Array = [];
      
      private var emblem$field:int;
      
      public function ChildrenInfoMsg()
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
      
      public function removeUserIdB() : void
      {
         hasField$0 &= 4294967279;
         userId_b$field = new int();
      }
      
      public function get hasUserIdB() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set userIdB(param1:int) : void
      {
         hasField$0 |= 16;
         userId_b$field = param1;
      }
      
      public function get userIdB() : int
      {
         return userId_b$field;
      }
      
      public function removeGrowthGrade() : void
      {
         hasField$0 &= 4294967263;
         growth_grade$field = new int();
      }
      
      public function get hasGrowthGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set growthGrade(param1:int) : void
      {
         hasField$0 |= 32;
         growth_grade$field = param1;
      }
      
      public function get growthGrade() : int
      {
         return growth_grade$field;
      }
      
      public function removeMood() : void
      {
         hasField$0 &= 4294967231;
         mood$field = new int();
      }
      
      public function get hasMood() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set mood(param1:int) : void
      {
         hasField$0 |= 64;
         mood$field = param1;
      }
      
      public function get mood() : int
      {
         return mood$field;
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
      
      public function removeState() : void
      {
         hasField$0 &= 4294966271;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 1024;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeEmblem() : void
      {
         hasField$0 &= 4294965247;
         emblem$field = new int();
      }
      
      public function get hasEmblem() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set emblem(param1:int) : void
      {
         hasField$0 |= 2048;
         emblem$field = param1;
      }
      
      public function get emblem() : int
      {
         return emblem$field;
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
         if(hasUserIdB)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,userId_b$field);
         }
         if(hasGrowthGrade)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,growth_grade$field);
         }
         if(hasMood)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,mood$field);
         }
         if(hasGrowthGp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,growth_gp$field);
         }
         if(hasGrowthCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,growth_count$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         _loc2_ = 0;
         while(_loc2_ < equipmets.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,equipmets[_loc2_]);
            _loc2_++;
         }
         if(hasEmblem)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,emblem$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc10_:ChildEquipmentMsg = null;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.childId cannot be set twice.");
                  }
                  _loc4_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.name cannot be set twice.");
                  }
                  _loc9_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.job cannot be set twice.");
                  }
                  _loc12_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.sex cannot be set twice.");
                  }
                  _loc6_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.userIdA cannot be set twice.");
                  }
                  _loc5_++;
                  userIdA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.userIdB cannot be set twice.");
                  }
                  _loc8_++;
                  userIdB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.growthGrade cannot be set twice.");
                  }
                  _loc7_++;
                  growthGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.mood cannot be set twice.");
                  }
                  _loc15_++;
                  mood = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.growthGp cannot be set twice.");
                  }
                  _loc13_++;
                  growthGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.growthCount cannot be set twice.");
                  }
                  _loc11_++;
                  growthCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.fightCapacity cannot be set twice.");
                  }
                  _loc17_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.state cannot be set twice.");
                  }
                  _loc14_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  _loc10_ = new ChildEquipmentMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  equipmets.push(_loc10_);
                  break;
               case 13:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenInfoMsg.emblem cannot be set twice.");
                  }
                  _loc3_++;
                  emblem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

