package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SoldierMsg extends Message implements IExternalizable
   {
      
      private var living_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var temp_id$field:int;
      
      private var type$field:int;
      
      private var side$field:int;
      
      private var pos$field:int;
      
      private var init_hp$field:int;
      
      private var hp$field:int;
      
      private var qte_time$field:int;
      
      private var cast_time$field:int;
      
      private var army_pawn_id$field:int;
      
      private var grade$field:int;
      
      private var phy_attack$field:int;
      
      private var phy_defence$field:int;
      
      private var mag_attack$field:int;
      
      private var mag_defence$field:int;
      
      private var force_hit$field:int;
      
      private var parry$field:int;
      
      private var sites$field:int;
      
      [ArrayElementType("int")]
      public var skillId:Array = [];
      
      private var attack_wound$field:int;
      
      private var hit_wound$field:int;
      
      private var penetrate$field:int;
      
      private var stunAttr$field:int;
      
      public function SoldierMsg()
      {
         super();
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
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967293;
         temp_id$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 2;
         temp_id$field = param1;
      }
      
      public function get tempId() : int
      {
         return temp_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967287;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 8;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967279;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 16;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeInitHp() : void
      {
         hasField$0 &= 4294967263;
         init_hp$field = new int();
      }
      
      public function get hasInitHp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set initHp(param1:int) : void
      {
         hasField$0 |= 32;
         init_hp$field = param1;
      }
      
      public function get initHp() : int
      {
         return init_hp$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967231;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 64;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeQteTime() : void
      {
         hasField$0 &= 4294967167;
         qte_time$field = new int();
      }
      
      public function get hasQteTime() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set qteTime(param1:int) : void
      {
         hasField$0 |= 128;
         qte_time$field = param1;
      }
      
      public function get qteTime() : int
      {
         return qte_time$field;
      }
      
      public function removeCastTime() : void
      {
         hasField$0 &= 4294967039;
         cast_time$field = new int();
      }
      
      public function get hasCastTime() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set castTime(param1:int) : void
      {
         hasField$0 |= 256;
         cast_time$field = param1;
      }
      
      public function get castTime() : int
      {
         return cast_time$field;
      }
      
      public function removeArmyPawnId() : void
      {
         hasField$0 &= 4294966783;
         army_pawn_id$field = new int();
      }
      
      public function get hasArmyPawnId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set armyPawnId(param1:int) : void
      {
         hasField$0 |= 512;
         army_pawn_id$field = param1;
      }
      
      public function get armyPawnId() : int
      {
         return army_pawn_id$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294966271;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 1024;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removePhyAttack() : void
      {
         hasField$0 &= 4294965247;
         phy_attack$field = new int();
      }
      
      public function get hasPhyAttack() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set phyAttack(param1:int) : void
      {
         hasField$0 |= 2048;
         phy_attack$field = param1;
      }
      
      public function get phyAttack() : int
      {
         return phy_attack$field;
      }
      
      public function removePhyDefence() : void
      {
         hasField$0 &= 4294963199;
         phy_defence$field = new int();
      }
      
      public function get hasPhyDefence() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set phyDefence(param1:int) : void
      {
         hasField$0 |= 4096;
         phy_defence$field = param1;
      }
      
      public function get phyDefence() : int
      {
         return phy_defence$field;
      }
      
      public function removeMagAttack() : void
      {
         hasField$0 &= 4294959103;
         mag_attack$field = new int();
      }
      
      public function get hasMagAttack() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set magAttack(param1:int) : void
      {
         hasField$0 |= 8192;
         mag_attack$field = param1;
      }
      
      public function get magAttack() : int
      {
         return mag_attack$field;
      }
      
      public function removeMagDefence() : void
      {
         hasField$0 &= 4294950911;
         mag_defence$field = new int();
      }
      
      public function get hasMagDefence() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set magDefence(param1:int) : void
      {
         hasField$0 |= 16384;
         mag_defence$field = param1;
      }
      
      public function get magDefence() : int
      {
         return mag_defence$field;
      }
      
      public function removeForceHit() : void
      {
         hasField$0 &= 4294934527;
         force_hit$field = new int();
      }
      
      public function get hasForceHit() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set forceHit(param1:int) : void
      {
         hasField$0 |= 32768;
         force_hit$field = param1;
      }
      
      public function get forceHit() : int
      {
         return force_hit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294901759;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 65536;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeSites() : void
      {
         hasField$0 &= 4294836223;
         sites$field = new int();
      }
      
      public function get hasSites() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set sites(param1:int) : void
      {
         hasField$0 |= 131072;
         sites$field = param1;
      }
      
      public function get sites() : int
      {
         return sites$field;
      }
      
      public function removeAttackWound() : void
      {
         hasField$0 &= 4294705151;
         attack_wound$field = new int();
      }
      
      public function get hasAttackWound() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set attackWound(param1:int) : void
      {
         hasField$0 |= 262144;
         attack_wound$field = param1;
      }
      
      public function get attackWound() : int
      {
         return attack_wound$field;
      }
      
      public function removeHitWound() : void
      {
         hasField$0 &= 4294443007;
         hit_wound$field = new int();
      }
      
      public function get hasHitWound() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set hitWound(param1:int) : void
      {
         hasField$0 |= 524288;
         hit_wound$field = param1;
      }
      
      public function get hitWound() : int
      {
         return hit_wound$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4293918719;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 1048576;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeStunAttr() : void
      {
         hasField$0 &= 4292870143;
         stunAttr$field = new int();
      }
      
      public function get hasStunAttr() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set stunAttr(param1:int) : void
      {
         hasField$0 |= 2097152;
         stunAttr$field = param1;
      }
      
      public function get stunAttr() : int
      {
         return stunAttr$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasInitHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,init_hp$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasQteTime)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,qte_time$field);
         }
         if(hasCastTime)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,cast_time$field);
         }
         if(hasArmyPawnId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,army_pawn_id$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasPhyAttack)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,phy_attack$field);
         }
         if(hasPhyDefence)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,phy_defence$field);
         }
         if(hasMagAttack)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,mag_attack$field);
         }
         if(hasMagDefence)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,mag_defence$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,force_hit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasSites)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,sites$field);
         }
         _loc2_ = 0;
         while(_loc2_ < skillId.length)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,skillId[_loc2_]);
            _loc2_++;
         }
         if(hasAttackWound)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,attack_wound$field);
         }
         if(hasHitWound)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,hit_wound$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasStunAttr)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,stunAttr$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc25_:uint = 0;
         var _loc17_:uint = 0;
         var _loc16_:uint = 0;
         var _loc18_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc22_:uint = 0;
         var _loc14_:uint = 0;
         var _loc21_:uint = 0;
         var _loc19_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc20_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.livingId cannot be set twice.");
                  }
                  _loc25_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.tempId cannot be set twice.");
                  }
                  _loc17_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.type cannot be set twice.");
                  }
                  _loc16_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.side cannot be set twice.");
                  }
                  _loc18_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.pos cannot be set twice.");
                  }
                  _loc15_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.initHp cannot be set twice.");
                  }
                  _loc9_++;
                  initHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.hp cannot be set twice.");
                  }
                  _loc22_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.qteTime cannot be set twice.");
                  }
                  _loc14_++;
                  qteTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.castTime cannot be set twice.");
                  }
                  _loc21_++;
                  castTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.armyPawnId cannot be set twice.");
                  }
                  _loc19_++;
                  armyPawnId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.phyAttack cannot be set twice.");
                  }
                  _loc4_++;
                  phyAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.phyDefence cannot be set twice.");
                  }
                  _loc13_++;
                  phyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.magAttack cannot be set twice.");
                  }
                  _loc23_++;
                  magAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.magDefence cannot be set twice.");
                  }
                  _loc24_++;
                  magDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.forceHit cannot be set twice.");
                  }
                  _loc6_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.parry cannot be set twice.");
                  }
                  _loc10_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.sites cannot be set twice.");
                  }
                  _loc3_++;
                  sites = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if((_loc11_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillId);
                  }
                  else
                  {
                     skillId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 20:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.attackWound cannot be set twice.");
                  }
                  _loc12_++;
                  attackWound = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.hitWound cannot be set twice.");
                  }
                  _loc7_++;
                  hitWound = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.penetrate cannot be set twice.");
                  }
                  _loc8_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SoldierMsg.stunAttr cannot be set twice.");
                  }
                  _loc20_++;
                  stunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

