package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleArmyPawnMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var army_id$field:int;
      
      private var sites$field:int;
      
      private var son_type$field:int;
      
      private var tempate_id$field:int;
      
      private var own_pawns$field:int;
      
      private var live$field:int;
      
      private var attack$field:int;
      
      private var defence$field:int;
      
      private var magic_attack$field:int;
      
      private var magic_defence$field:int;
      
      private var skill$field:int;
      
      private var forceHit$field:int;
      
      private var parry$field:int;
      
      public function SimpleArmyPawnMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967293;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 2;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeSites() : void
      {
         hasField$0 &= 4294967291;
         sites$field = new int();
      }
      
      public function get hasSites() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sites(param1:int) : void
      {
         hasField$0 |= 4;
         sites$field = param1;
      }
      
      public function get sites() : int
      {
         return sites$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967287;
         son_type$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 8;
         son_type$field = param1;
      }
      
      public function get sonType() : int
      {
         return son_type$field;
      }
      
      public function removeTempateId() : void
      {
         hasField$0 &= 4294967279;
         tempate_id$field = new int();
      }
      
      public function get hasTempateId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set tempateId(param1:int) : void
      {
         hasField$0 |= 16;
         tempate_id$field = param1;
      }
      
      public function get tempateId() : int
      {
         return tempate_id$field;
      }
      
      public function removeOwnPawns() : void
      {
         hasField$0 &= 4294967263;
         own_pawns$field = new int();
      }
      
      public function get hasOwnPawns() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set ownPawns(param1:int) : void
      {
         hasField$0 |= 32;
         own_pawns$field = param1;
      }
      
      public function get ownPawns() : int
      {
         return own_pawns$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294967231;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 64;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967167;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 128;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefence() : void
      {
         hasField$0 &= 4294967039;
         defence$field = new int();
      }
      
      public function get hasDefence() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set defence(param1:int) : void
      {
         hasField$0 |= 256;
         defence$field = param1;
      }
      
      public function get defence() : int
      {
         return defence$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294966783;
         magic_attack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 512;
         magic_attack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magic_attack$field;
      }
      
      public function removeMagicDefence() : void
      {
         hasField$0 &= 4294966271;
         magic_defence$field = new int();
      }
      
      public function get hasMagicDefence() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set magicDefence(param1:int) : void
      {
         hasField$0 |= 1024;
         magic_defence$field = param1;
      }
      
      public function get magicDefence() : int
      {
         return magic_defence$field;
      }
      
      public function removeSkill() : void
      {
         hasField$0 &= 4294965247;
         skill$field = new int();
      }
      
      public function get hasSkill() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set skill(param1:int) : void
      {
         hasField$0 |= 2048;
         skill$field = param1;
      }
      
      public function get skill() : int
      {
         return skill$field;
      }
      
      public function removeForceHit() : void
      {
         hasField$0 &= 4294963199;
         forceHit$field = new int();
      }
      
      public function get hasForceHit() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set forceHit(param1:int) : void
      {
         hasField$0 |= 4096;
         forceHit$field = param1;
      }
      
      public function get forceHit() : int
      {
         return forceHit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294959103;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 8192;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasSites)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sites$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,son_type$field);
         }
         if(hasTempateId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,tempate_id$field);
         }
         if(hasOwnPawns)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,own_pawns$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefence)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,defence$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,magic_attack$field);
         }
         if(hasMagicDefence)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,magic_defence$field);
         }
         if(hasSkill)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,skill$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,forceHit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc17_:uint = 0;
         var _loc16_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.id cannot be set twice.");
                  }
                  _loc7_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.armyId cannot be set twice.");
                  }
                  _loc10_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.sites cannot be set twice.");
                  }
                  _loc3_++;
                  sites = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.sonType cannot be set twice.");
                  }
                  _loc4_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.tempateId cannot be set twice.");
                  }
                  _loc15_++;
                  tempateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.ownPawns cannot be set twice.");
                  }
                  _loc11_++;
                  ownPawns = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.live cannot be set twice.");
                  }
                  _loc9_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.attack cannot be set twice.");
                  }
                  _loc12_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.defence cannot be set twice.");
                  }
                  _loc17_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.magicAttack cannot be set twice.");
                  }
                  _loc16_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.magicDefence cannot be set twice.");
                  }
                  _loc5_++;
                  magicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.skill cannot be set twice.");
                  }
                  _loc8_++;
                  skill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.forceHit cannot be set twice.");
                  }
                  _loc6_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyPawnMsg.parry cannot be set twice.");
                  }
                  _loc13_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

