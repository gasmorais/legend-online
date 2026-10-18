package com.road.yishi.proto.farm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendFarmStateMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var is_charge_energy$field:Boolean;
      
      private var is_revive$field:Boolean;
      
      private var is_worm$field:Boolean;
      
      private var isGrass$field:Boolean;
      
      private var isFeed$field:Boolean;
      
      private var is_feed_livestock$field:Boolean;
      
      private var is_pacify$field:Boolean;
      
      private var is_cure$field:Boolean;
      
      private var is_plant_reap$field:Boolean;
      
      private var is_animal_reap$field:Boolean;
      
      public function FriendFarmStateMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeIsChargeEnergy() : void
      {
         hasField$0 &= 4294967293;
         is_charge_energy$field = new Boolean();
      }
      
      public function get hasIsChargeEnergy() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isChargeEnergy(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_charge_energy$field = param1;
      }
      
      public function get isChargeEnergy() : Boolean
      {
         return is_charge_energy$field;
      }
      
      public function removeIsRevive() : void
      {
         hasField$0 &= 4294967291;
         is_revive$field = new Boolean();
      }
      
      public function get hasIsRevive() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isRevive(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_revive$field = param1;
      }
      
      public function get isRevive() : Boolean
      {
         return is_revive$field;
      }
      
      public function removeIsWorm() : void
      {
         hasField$0 &= 4294967287;
         is_worm$field = new Boolean();
      }
      
      public function get hasIsWorm() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isWorm(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_worm$field = param1;
      }
      
      public function get isWorm() : Boolean
      {
         return is_worm$field;
      }
      
      public function removeIsGrass() : void
      {
         hasField$0 &= 4294967279;
         isGrass$field = new Boolean();
      }
      
      public function get hasIsGrass() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isGrass(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isGrass$field = param1;
      }
      
      public function get isGrass() : Boolean
      {
         return isGrass$field;
      }
      
      public function removeIsFeed() : void
      {
         hasField$0 &= 4294967263;
         isFeed$field = new Boolean();
      }
      
      public function get hasIsFeed() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isFeed(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isFeed$field = param1;
      }
      
      public function get isFeed() : Boolean
      {
         return isFeed$field;
      }
      
      public function removeIsFeedLivestock() : void
      {
         hasField$0 &= 4294967231;
         is_feed_livestock$field = new Boolean();
      }
      
      public function get hasIsFeedLivestock() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isFeedLivestock(param1:Boolean) : void
      {
         hasField$0 |= 64;
         is_feed_livestock$field = param1;
      }
      
      public function get isFeedLivestock() : Boolean
      {
         return is_feed_livestock$field;
      }
      
      public function removeIsPacify() : void
      {
         hasField$0 &= 4294967167;
         is_pacify$field = new Boolean();
      }
      
      public function get hasIsPacify() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isPacify(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_pacify$field = param1;
      }
      
      public function get isPacify() : Boolean
      {
         return is_pacify$field;
      }
      
      public function removeIsCure() : void
      {
         hasField$0 &= 4294967039;
         is_cure$field = new Boolean();
      }
      
      public function get hasIsCure() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isCure(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_cure$field = param1;
      }
      
      public function get isCure() : Boolean
      {
         return is_cure$field;
      }
      
      public function removeIsPlantReap() : void
      {
         hasField$0 &= 4294966783;
         is_plant_reap$field = new Boolean();
      }
      
      public function get hasIsPlantReap() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isPlantReap(param1:Boolean) : void
      {
         hasField$0 |= 512;
         is_plant_reap$field = param1;
      }
      
      public function get isPlantReap() : Boolean
      {
         return is_plant_reap$field;
      }
      
      public function removeIsAnimalReap() : void
      {
         hasField$0 &= 4294966271;
         is_animal_reap$field = new Boolean();
      }
      
      public function get hasIsAnimalReap() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isAnimalReap(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         is_animal_reap$field = param1;
      }
      
      public function get isAnimalReap() : Boolean
      {
         return is_animal_reap$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasIsChargeEnergy)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,is_charge_energy$field);
         }
         if(hasIsRevive)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_revive$field);
         }
         if(hasIsWorm)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_worm$field);
         }
         if(hasIsGrass)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isGrass$field);
         }
         if(hasIsFeed)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isFeed$field);
         }
         if(hasIsFeedLivestock)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,is_feed_livestock$field);
         }
         if(hasIsPacify)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,is_pacify$field);
         }
         if(hasIsCure)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,is_cure$field);
         }
         if(hasIsPlantReap)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,is_plant_reap$field);
         }
         if(hasIsAnimalReap)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,is_animal_reap$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.userId cannot be set twice.");
                  }
                  _loc11_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isChargeEnergy cannot be set twice.");
                  }
                  _loc5_++;
                  isChargeEnergy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isRevive cannot be set twice.");
                  }
                  _loc3_++;
                  isRevive = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isWorm cannot be set twice.");
                  }
                  _loc6_++;
                  isWorm = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isGrass cannot be set twice.");
                  }
                  _loc10_++;
                  isGrass = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isFeed cannot be set twice.");
                  }
                  _loc12_++;
                  isFeed = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isFeedLivestock cannot be set twice.");
                  }
                  _loc9_++;
                  isFeedLivestock = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isPacify cannot be set twice.");
                  }
                  _loc14_++;
                  isPacify = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isCure cannot be set twice.");
                  }
                  _loc4_++;
                  isCure = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isPlantReap cannot be set twice.");
                  }
                  _loc7_++;
                  isPlantReap = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FriendFarmStateMsg.isAnimalReap cannot be set twice.");
                  }
                  _loc8_++;
                  isAnimalReap = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

