package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DamageMsg extends Message implements IExternalizable
   {
      
      private var living_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var damage_type$field:int;
      
      private var has_icon$field:Boolean;
      
      private var is_harmful$field:Boolean;
      
      private var damage_value$field:Int64;
      
      private var left_value$field:Int64;
      
      private var extra_data$field:int;
      
      private var parry$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.battle.DropInfoMsg")]
      public var dropInfos:Array = [];
      
      private var order$field:int;
      
      private var hp_limit$field:Int64;
      
      private var resi_type$field:int;
      
      private var resi_value$field:int;
      
      private var resi_percent$field:int;
      
      private var buffer_type$field:int;
      
      public function DamageMsg()
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
      
      public function removeDamageType() : void
      {
         hasField$0 &= 4294967293;
         damage_type$field = new int();
      }
      
      public function get hasDamageType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set damageType(param1:int) : void
      {
         hasField$0 |= 2;
         damage_type$field = param1;
      }
      
      public function get damageType() : int
      {
         return damage_type$field;
      }
      
      public function removeHasIcon() : void
      {
         hasField$0 &= 4294967291;
         has_icon$field = new Boolean();
      }
      
      public function get hasHasIcon() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set hasIcon(param1:Boolean) : void
      {
         hasField$0 |= 4;
         has_icon$field = param1;
      }
      
      public function get hasIcon() : Boolean
      {
         return has_icon$field;
      }
      
      public function removeIsHarmful() : void
      {
         hasField$0 &= 4294967287;
         is_harmful$field = new Boolean();
      }
      
      public function get hasIsHarmful() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isHarmful(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_harmful$field = param1;
      }
      
      public function get isHarmful() : Boolean
      {
         return is_harmful$field;
      }
      
      public function removeDamageValue() : void
      {
         damage_value$field = null;
      }
      
      public function get hasDamageValue() : Boolean
      {
         return damage_value$field != null;
      }
      
      public function set damageValue(param1:Int64) : void
      {
         damage_value$field = param1;
      }
      
      public function get damageValue() : Int64
      {
         return damage_value$field;
      }
      
      public function removeLeftValue() : void
      {
         left_value$field = null;
      }
      
      public function get hasLeftValue() : Boolean
      {
         return left_value$field != null;
      }
      
      public function set leftValue(param1:Int64) : void
      {
         left_value$field = param1;
      }
      
      public function get leftValue() : Int64
      {
         return left_value$field;
      }
      
      public function removeExtraData() : void
      {
         hasField$0 &= 4294967279;
         extra_data$field = new int();
      }
      
      public function get hasExtraData() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set extraData(param1:int) : void
      {
         hasField$0 |= 16;
         extra_data$field = param1;
      }
      
      public function get extraData() : int
      {
         return extra_data$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294967263;
         parry$field = new Boolean();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set parry(param1:Boolean) : void
      {
         hasField$0 |= 32;
         parry$field = param1;
      }
      
      public function get parry() : Boolean
      {
         return parry$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967231;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 64;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeHpLimit() : void
      {
         hp_limit$field = null;
      }
      
      public function get hasHpLimit() : Boolean
      {
         return hp_limit$field != null;
      }
      
      public function set hpLimit(param1:Int64) : void
      {
         hp_limit$field = param1;
      }
      
      public function get hpLimit() : Int64
      {
         return hp_limit$field;
      }
      
      public function removeResiType() : void
      {
         hasField$0 &= 4294967167;
         resi_type$field = new int();
      }
      
      public function get hasResiType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set resiType(param1:int) : void
      {
         hasField$0 |= 128;
         resi_type$field = param1;
      }
      
      public function get resiType() : int
      {
         return resi_type$field;
      }
      
      public function removeResiValue() : void
      {
         hasField$0 &= 4294967039;
         resi_value$field = new int();
      }
      
      public function get hasResiValue() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set resiValue(param1:int) : void
      {
         hasField$0 |= 256;
         resi_value$field = param1;
      }
      
      public function get resiValue() : int
      {
         return resi_value$field;
      }
      
      public function removeResiPercent() : void
      {
         hasField$0 &= 4294966783;
         resi_percent$field = new int();
      }
      
      public function get hasResiPercent() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set resiPercent(param1:int) : void
      {
         hasField$0 |= 512;
         resi_percent$field = param1;
      }
      
      public function get resiPercent() : int
      {
         return resi_percent$field;
      }
      
      public function removeBufferType() : void
      {
         hasField$0 &= 4294966271;
         buffer_type$field = new int();
      }
      
      public function get hasBufferType() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set bufferType(param1:int) : void
      {
         hasField$0 |= 1024;
         buffer_type$field = param1;
      }
      
      public function get bufferType() : int
      {
         return buffer_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasDamageType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,damage_type$field);
         }
         if(hasHasIcon)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,has_icon$field);
         }
         if(hasIsHarmful)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_harmful$field);
         }
         if(hasDamageValue)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,damage_value$field);
         }
         if(hasLeftValue)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,left_value$field);
         }
         if(hasExtraData)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,extra_data$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,parry$field);
         }
         _loc2_ = 0;
         while(_loc2_ < dropInfos.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,dropInfos[_loc2_]);
            _loc2_++;
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasHpLimit)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT64(param1,hp_limit$field);
         }
         if(hasResiType)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,resi_type$field);
         }
         if(hasResiValue)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,resi_value$field);
         }
         if(hasResiPercent)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,resi_percent$field);
         }
         if(hasBufferType)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,buffer_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc9_:DropInfoMsg = null;
         var _loc18_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc15_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.livingId cannot be set twice.");
                  }
                  _loc18_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.damageType cannot be set twice.");
                  }
                  _loc6_++;
                  damageType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.hasIcon cannot be set twice.");
                  }
                  _loc10_++;
                  hasIcon = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.isHarmful cannot be set twice.");
                  }
                  _loc4_++;
                  isHarmful = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.damageValue cannot be set twice.");
                  }
                  _loc11_++;
                  damageValue = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.leftValue cannot be set twice.");
                  }
                  _loc12_++;
                  leftValue = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.extraData cannot be set twice.");
                  }
                  _loc5_++;
                  extraData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.parry cannot be set twice.");
                  }
                  _loc16_++;
                  parry = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  _loc9_ = new DropInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  dropInfos.push(_loc9_);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.order cannot be set twice.");
                  }
                  _loc15_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.hpLimit cannot be set twice.");
                  }
                  _loc14_++;
                  hpLimit = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.resiType cannot be set twice.");
                  }
                  _loc3_++;
                  resiType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.resiValue cannot be set twice.");
                  }
                  _loc7_++;
                  resiValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.resiPercent cannot be set twice.");
                  }
                  _loc8_++;
                  resiPercent = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DamageMsg.bufferType cannot be set twice.");
                  }
                  _loc13_++;
                  bufferType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

