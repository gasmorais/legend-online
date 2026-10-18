package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArmyPawnInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var army_id$field:int;
      
      private var sites$field:int;
      
      private var son_type$field:int;
      
      private var tempate_id$field:int;
      
      private var own_pawns$field:int;
      
      [ArrayElementType("com.road.yishi.proto.army.PropertyMsg")]
      public var pawnLive:Array = [];
      
      private var fight_pos$field:int;
      
      private var special_tempIds$field:String;
      
      private var comprehedn_tempIds$field:String;
      
      private var bless_num$field:int;
      
      public function ArmyPawnInfoMsg()
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
      
      public function removeFightPos() : void
      {
         hasField$0 &= 4294967231;
         fight_pos$field = new int();
      }
      
      public function get hasFightPos() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fightPos(param1:int) : void
      {
         hasField$0 |= 64;
         fight_pos$field = param1;
      }
      
      public function get fightPos() : int
      {
         return fight_pos$field;
      }
      
      public function removeSpecialTempIds() : void
      {
         special_tempIds$field = null;
      }
      
      public function get hasSpecialTempIds() : Boolean
      {
         return special_tempIds$field != null;
      }
      
      public function set specialTempIds(param1:String) : void
      {
         special_tempIds$field = param1;
      }
      
      public function get specialTempIds() : String
      {
         return special_tempIds$field;
      }
      
      public function removeComprehednTempIds() : void
      {
         comprehedn_tempIds$field = null;
      }
      
      public function get hasComprehednTempIds() : Boolean
      {
         return comprehedn_tempIds$field != null;
      }
      
      public function set comprehednTempIds(param1:String) : void
      {
         comprehedn_tempIds$field = param1;
      }
      
      public function get comprehednTempIds() : String
      {
         return comprehedn_tempIds$field;
      }
      
      public function removeBlessNum() : void
      {
         hasField$0 &= 4294967167;
         bless_num$field = new int();
      }
      
      public function get hasBlessNum() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set blessNum(param1:int) : void
      {
         hasField$0 |= 128;
         bless_num$field = param1;
      }
      
      public function get blessNum() : int
      {
         return bless_num$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
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
         _loc2_ = 0;
         while(_loc2_ < pawnLive.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,pawnLive[_loc2_]);
            _loc2_++;
         }
         if(hasFightPos)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,fight_pos$field);
         }
         if(hasSpecialTempIds)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,special_tempIds$field);
         }
         if(hasComprehednTempIds)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,comprehedn_tempIds$field);
         }
         if(hasBlessNum)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,bless_num$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc13_:PropertyMsg = null;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.armyId cannot be set twice.");
                  }
                  _loc8_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.sites cannot be set twice.");
                  }
                  _loc3_++;
                  sites = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.sonType cannot be set twice.");
                  }
                  _loc5_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.tempateId cannot be set twice.");
                  }
                  _loc14_++;
                  tempateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.ownPawns cannot be set twice.");
                  }
                  _loc10_++;
                  ownPawns = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc13_ = new PropertyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  pawnLive.push(_loc13_);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.fightPos cannot be set twice.");
                  }
                  _loc7_++;
                  fightPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.specialTempIds cannot be set twice.");
                  }
                  _loc4_++;
                  specialTempIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.comprehednTempIds cannot be set twice.");
                  }
                  _loc9_++;
                  comprehednTempIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPawnInfoMsg.blessNum cannot be set twice.");
                  }
                  _loc11_++;
                  blessNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

