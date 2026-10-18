package com.road.yishi.proto.dragontalker
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DragonTalkerInfoMsg extends Message implements IExternalizable
   {
      
      private var currentSkillIndex$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isNowDragonTalker$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.dragontalker.SkillInfoMsg")]
      public var skillInfoList:Array = [];
      
      private var currentFightMount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.dragontalker.SymbiontGp")]
      public var symbiontGpList:Array = [];
      
      private var fightMountGp$field:int;
      
      private var isOpen$field:Boolean;
      
      private var potentialId1$field:int;
      
      private var potentialId2$field:int;
      
      private var potentialId3$field:int;
      
      private var potentialId4$field:int;
      
      private var fashions$field:DragonFashionMsg;
      
      private var skillCount$field:int;
      
      public function DragonTalkerInfoMsg()
      {
         super();
      }
      
      public function removeCurrentSkillIndex() : void
      {
         hasField$0 &= 4294967294;
         currentSkillIndex$field = new int();
      }
      
      public function get hasCurrentSkillIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set currentSkillIndex(param1:int) : void
      {
         hasField$0 |= 1;
         currentSkillIndex$field = param1;
      }
      
      public function get currentSkillIndex() : int
      {
         return currentSkillIndex$field;
      }
      
      public function removeIsNowDragonTalker() : void
      {
         hasField$0 &= 4294967293;
         isNowDragonTalker$field = new Boolean();
      }
      
      public function get hasIsNowDragonTalker() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isNowDragonTalker(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isNowDragonTalker$field = param1;
      }
      
      public function get isNowDragonTalker() : Boolean
      {
         return isNowDragonTalker$field;
      }
      
      public function removeCurrentFightMount() : void
      {
         hasField$0 &= 4294967291;
         currentFightMount$field = new int();
      }
      
      public function get hasCurrentFightMount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentFightMount(param1:int) : void
      {
         hasField$0 |= 4;
         currentFightMount$field = param1;
      }
      
      public function get currentFightMount() : int
      {
         return currentFightMount$field;
      }
      
      public function removeFightMountGp() : void
      {
         hasField$0 &= 4294967287;
         fightMountGp$field = new int();
      }
      
      public function get hasFightMountGp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightMountGp(param1:int) : void
      {
         hasField$0 |= 8;
         fightMountGp$field = param1;
      }
      
      public function get fightMountGp() : int
      {
         return fightMountGp$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967279;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removePotentialId1() : void
      {
         hasField$0 &= 4294967263;
         potentialId1$field = new int();
      }
      
      public function get hasPotentialId1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set potentialId1(param1:int) : void
      {
         hasField$0 |= 32;
         potentialId1$field = param1;
      }
      
      public function get potentialId1() : int
      {
         return potentialId1$field;
      }
      
      public function removePotentialId2() : void
      {
         hasField$0 &= 4294967231;
         potentialId2$field = new int();
      }
      
      public function get hasPotentialId2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set potentialId2(param1:int) : void
      {
         hasField$0 |= 64;
         potentialId2$field = param1;
      }
      
      public function get potentialId2() : int
      {
         return potentialId2$field;
      }
      
      public function removePotentialId3() : void
      {
         hasField$0 &= 4294967167;
         potentialId3$field = new int();
      }
      
      public function get hasPotentialId3() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set potentialId3(param1:int) : void
      {
         hasField$0 |= 128;
         potentialId3$field = param1;
      }
      
      public function get potentialId3() : int
      {
         return potentialId3$field;
      }
      
      public function removePotentialId4() : void
      {
         hasField$0 &= 4294967039;
         potentialId4$field = new int();
      }
      
      public function get hasPotentialId4() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set potentialId4(param1:int) : void
      {
         hasField$0 |= 256;
         potentialId4$field = param1;
      }
      
      public function get potentialId4() : int
      {
         return potentialId4$field;
      }
      
      public function removeFashions() : void
      {
         fashions$field = null;
      }
      
      public function get hasFashions() : Boolean
      {
         return fashions$field != null;
      }
      
      public function set fashions(param1:DragonFashionMsg) : void
      {
         fashions$field = param1;
      }
      
      public function get fashions() : DragonFashionMsg
      {
         return fashions$field;
      }
      
      public function removeSkillCount() : void
      {
         hasField$0 &= 4294966783;
         skillCount$field = new int();
      }
      
      public function get hasSkillCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set skillCount(param1:int) : void
      {
         hasField$0 |= 512;
         skillCount$field = param1;
      }
      
      public function get skillCount() : int
      {
         return skillCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasCurrentSkillIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,currentSkillIndex$field);
         }
         if(hasIsNowDragonTalker)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isNowDragonTalker$field);
         }
         _loc3_ = 0;
         while(_loc3_ < skillInfoList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,skillInfoList[_loc3_]);
            _loc3_++;
         }
         if(hasCurrentFightMount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,currentFightMount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < symbiontGpList.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,symbiontGpList[_loc2_]);
            _loc2_++;
         }
         if(hasFightMountGp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,fightMountGp$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasPotentialId1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,potentialId1$field);
         }
         if(hasPotentialId2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,potentialId2$field);
         }
         if(hasPotentialId3)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,potentialId3$field);
         }
         if(hasPotentialId4)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,potentialId4$field);
         }
         if(hasFashions)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,fashions$field);
         }
         if(hasSkillCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,skillCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc10_:SkillInfoMsg = null;
         var _loc4_:SymbiontGp = null;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.currentSkillIndex cannot be set twice.");
                  }
                  _loc3_++;
                  currentSkillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.isNowDragonTalker cannot be set twice.");
                  }
                  _loc8_++;
                  isNowDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  _loc10_ = new SkillInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  skillInfoList.push(_loc10_);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.currentFightMount cannot be set twice.");
                  }
                  _loc7_++;
                  currentFightMount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc4_ = new SymbiontGp();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  symbiontGpList.push(_loc4_);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.fightMountGp cannot be set twice.");
                  }
                  _loc14_++;
                  fightMountGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.isOpen cannot be set twice.");
                  }
                  _loc12_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.potentialId1 cannot be set twice.");
                  }
                  _loc9_++;
                  potentialId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.potentialId2 cannot be set twice.");
                  }
                  _loc13_++;
                  potentialId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.potentialId3 cannot be set twice.");
                  }
                  _loc15_++;
                  potentialId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.potentialId4 cannot be set twice.");
                  }
                  _loc5_++;
                  potentialId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.fashions cannot be set twice.");
                  }
                  _loc11_++;
                  fashions = new DragonFashionMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,fashions);
                  break;
               case 12:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerInfoMsg.skillCount cannot be set twice.");
                  }
                  _loc6_++;
                  skillCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

