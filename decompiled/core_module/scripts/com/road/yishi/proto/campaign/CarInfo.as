package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CarInfo extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var minerals$field:int;
      
      private var quality$field:int;
      
      private var tramcar_count$field:int;
      
      private var hand_count$field:int;
      
      private var is_own$field:int;
      
      private var pick_count$field:int;
      
      private var army_id$field:int;
      
      public function CarInfo()
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
      
      public function removeMinerals() : void
      {
         hasField$0 &= 4294967293;
         minerals$field = new int();
      }
      
      public function get hasMinerals() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set minerals(param1:int) : void
      {
         hasField$0 |= 2;
         minerals$field = param1;
      }
      
      public function get minerals() : int
      {
         return minerals$field;
      }
      
      public function removeQuality() : void
      {
         hasField$0 &= 4294967291;
         quality$field = new int();
      }
      
      public function get hasQuality() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set quality(param1:int) : void
      {
         hasField$0 |= 4;
         quality$field = param1;
      }
      
      public function get quality() : int
      {
         return quality$field;
      }
      
      public function removeTramcarCount() : void
      {
         hasField$0 &= 4294967287;
         tramcar_count$field = new int();
      }
      
      public function get hasTramcarCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tramcarCount(param1:int) : void
      {
         hasField$0 |= 8;
         tramcar_count$field = param1;
      }
      
      public function get tramcarCount() : int
      {
         return tramcar_count$field;
      }
      
      public function removeHandCount() : void
      {
         hasField$0 &= 4294967279;
         hand_count$field = new int();
      }
      
      public function get hasHandCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set handCount(param1:int) : void
      {
         hasField$0 |= 16;
         hand_count$field = param1;
      }
      
      public function get handCount() : int
      {
         return hand_count$field;
      }
      
      public function removeIsOwn() : void
      {
         hasField$0 &= 4294967263;
         is_own$field = new int();
      }
      
      public function get hasIsOwn() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isOwn(param1:int) : void
      {
         hasField$0 |= 32;
         is_own$field = param1;
      }
      
      public function get isOwn() : int
      {
         return is_own$field;
      }
      
      public function removePickCount() : void
      {
         hasField$0 &= 4294967231;
         pick_count$field = new int();
      }
      
      public function get hasPickCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set pickCount(param1:int) : void
      {
         hasField$0 |= 64;
         pick_count$field = param1;
      }
      
      public function get pickCount() : int
      {
         return pick_count$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967167;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 128;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasMinerals)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,minerals$field);
         }
         if(hasQuality)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,quality$field);
         }
         if(hasTramcarCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,tramcar_count$field);
         }
         if(hasHandCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,hand_count$field);
         }
         if(hasIsOwn)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,is_own$field);
         }
         if(hasPickCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pick_count$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.minerals cannot be set twice.");
                  }
                  _loc9_++;
                  minerals = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.quality cannot be set twice.");
                  }
                  _loc3_++;
                  quality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.tramcarCount cannot be set twice.");
                  }
                  _loc5_++;
                  tramcarCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.handCount cannot be set twice.");
                  }
                  _loc11_++;
                  handCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.isOwn cannot be set twice.");
                  }
                  _loc8_++;
                  isOwn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.pickCount cannot be set twice.");
                  }
                  _loc4_++;
                  pickCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CarInfo.armyId cannot be set twice.");
                  }
                  _loc6_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

