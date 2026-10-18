package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PropertyMsg extends Message implements IExternalizable
   {
      
      private var temp_data$field:int;
      
      private var hasField$0:uint = 0;
      
      private var effect_Per$field:int;
      
      private var effect_Data$field:int;
      
      private var bag_Per$field:int;
      
      private var bag_Data$field:int;
      
      private var star_Per$field:int;
      
      private var star_Data$field:int;
      
      private var powcard_Per$field:int;
      
      private var powcard_Data$field:int;
      
      private var skill_Per$field:int;
      
      private var skill_Data$field:int;
      
      private var base_Join$field:int;
      
      public function PropertyMsg()
      {
         super();
      }
      
      public function removeTempData() : void
      {
         hasField$0 &= 4294967294;
         temp_data$field = new int();
      }
      
      public function get hasTempData() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tempData(param1:int) : void
      {
         hasField$0 |= 1;
         temp_data$field = param1;
      }
      
      public function get tempData() : int
      {
         return temp_data$field;
      }
      
      public function removeEffect_Per() : void
      {
         hasField$0 &= 4294967293;
         effect_Per$field = new int();
      }
      
      public function get hasEffect_Per() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set effect_Per(param1:int) : void
      {
         hasField$0 |= 2;
         effect_Per$field = param1;
      }
      
      public function get effect_Per() : int
      {
         return effect_Per$field;
      }
      
      public function removeEffect_Data() : void
      {
         hasField$0 &= 4294967291;
         effect_Data$field = new int();
      }
      
      public function get hasEffect_Data() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set effect_Data(param1:int) : void
      {
         hasField$0 |= 4;
         effect_Data$field = param1;
      }
      
      public function get effect_Data() : int
      {
         return effect_Data$field;
      }
      
      public function removeBag_Per() : void
      {
         hasField$0 &= 4294967287;
         bag_Per$field = new int();
      }
      
      public function get hasBag_Per() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bag_Per(param1:int) : void
      {
         hasField$0 |= 8;
         bag_Per$field = param1;
      }
      
      public function get bag_Per() : int
      {
         return bag_Per$field;
      }
      
      public function removeBag_Data() : void
      {
         hasField$0 &= 4294967279;
         bag_Data$field = new int();
      }
      
      public function get hasBag_Data() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set bag_Data(param1:int) : void
      {
         hasField$0 |= 16;
         bag_Data$field = param1;
      }
      
      public function get bag_Data() : int
      {
         return bag_Data$field;
      }
      
      public function removeStar_Per() : void
      {
         hasField$0 &= 4294967263;
         star_Per$field = new int();
      }
      
      public function get hasStar_Per() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set star_Per(param1:int) : void
      {
         hasField$0 |= 32;
         star_Per$field = param1;
      }
      
      public function get star_Per() : int
      {
         return star_Per$field;
      }
      
      public function removeStar_Data() : void
      {
         hasField$0 &= 4294967231;
         star_Data$field = new int();
      }
      
      public function get hasStar_Data() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set star_Data(param1:int) : void
      {
         hasField$0 |= 64;
         star_Data$field = param1;
      }
      
      public function get star_Data() : int
      {
         return star_Data$field;
      }
      
      public function removePowcard_Per() : void
      {
         hasField$0 &= 4294967167;
         powcard_Per$field = new int();
      }
      
      public function get hasPowcard_Per() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set powcard_Per(param1:int) : void
      {
         hasField$0 |= 128;
         powcard_Per$field = param1;
      }
      
      public function get powcard_Per() : int
      {
         return powcard_Per$field;
      }
      
      public function removePowcard_Data() : void
      {
         hasField$0 &= 4294967039;
         powcard_Data$field = new int();
      }
      
      public function get hasPowcard_Data() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set powcard_Data(param1:int) : void
      {
         hasField$0 |= 256;
         powcard_Data$field = param1;
      }
      
      public function get powcard_Data() : int
      {
         return powcard_Data$field;
      }
      
      public function removeSkill_Per() : void
      {
         hasField$0 &= 4294966783;
         skill_Per$field = new int();
      }
      
      public function get hasSkill_Per() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set skill_Per(param1:int) : void
      {
         hasField$0 |= 512;
         skill_Per$field = param1;
      }
      
      public function get skill_Per() : int
      {
         return skill_Per$field;
      }
      
      public function removeSkill_Data() : void
      {
         hasField$0 &= 4294966271;
         skill_Data$field = new int();
      }
      
      public function get hasSkill_Data() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set skill_Data(param1:int) : void
      {
         hasField$0 |= 1024;
         skill_Data$field = param1;
      }
      
      public function get skill_Data() : int
      {
         return skill_Data$field;
      }
      
      public function removeBase_Join() : void
      {
         hasField$0 &= 4294965247;
         base_Join$field = new int();
      }
      
      public function get hasBase_Join() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set base_Join(param1:int) : void
      {
         hasField$0 |= 2048;
         base_Join$field = param1;
      }
      
      public function get base_Join() : int
      {
         return base_Join$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTempData)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,temp_data$field);
         }
         if(hasEffect_Per)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,effect_Per$field);
         }
         if(hasEffect_Data)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,effect_Data$field);
         }
         if(hasBag_Per)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,bag_Per$field);
         }
         if(hasBag_Data)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,bag_Data$field);
         }
         if(hasStar_Per)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,star_Per$field);
         }
         if(hasStar_Data)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,star_Data$field);
         }
         if(hasPowcard_Per)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,powcard_Per$field);
         }
         if(hasPowcard_Data)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,powcard_Data$field);
         }
         if(hasSkill_Per)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,skill_Per$field);
         }
         if(hasSkill_Data)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,skill_Data$field);
         }
         if(hasBase_Join)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,base_Join$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.tempData cannot be set twice.");
                  }
                  _loc6_++;
                  tempData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.effect_Per cannot be set twice.");
                  }
                  _loc8_++;
                  effect_Per = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.effect_Data cannot be set twice.");
                  }
                  _loc3_++;
                  effect_Data = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.bag_Per cannot be set twice.");
                  }
                  _loc4_++;
                  bag_Per = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.bag_Data cannot be set twice.");
                  }
                  _loc5_++;
                  bag_Data = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.star_Per cannot be set twice.");
                  }
                  _loc7_++;
                  star_Per = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.star_Data cannot be set twice.");
                  }
                  _loc11_++;
                  star_Data = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.powcard_Per cannot be set twice.");
                  }
                  _loc9_++;
                  powcard_Per = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.powcard_Data cannot be set twice.");
                  }
                  _loc14_++;
                  powcard_Data = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.skill_Per cannot be set twice.");
                  }
                  _loc15_++;
                  skill_Per = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.skill_Data cannot be set twice.");
                  }
                  _loc10_++;
                  skill_Data = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyMsg.base_Join cannot be set twice.");
                  }
                  _loc13_++;
                  base_Join = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

