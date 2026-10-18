package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerPetOpMsg extends Message implements IExternalizable
   {
      
      private var pet_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var op_type$field:int;
      
      private var pet_name$field:String;
      
      [ArrayElementType("int")]
      public var attributes:Array = [];
      
      private var value$field:int;
      
      private var item_pos$field:int;
      
      private var pay_type$field:int;
      
      private var skillId$field:int;
      
      private var fightType$field:int;
      
      public function PlayerPetOpMsg()
      {
         super();
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967294;
         pet_id$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 1;
         pet_id$field = param1;
      }
      
      public function get petId() : int
      {
         return pet_id$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967293;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 2;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removePetName() : void
      {
         pet_name$field = null;
      }
      
      public function get hasPetName() : Boolean
      {
         return pet_name$field != null;
      }
      
      public function set petName(param1:String) : void
      {
         pet_name$field = param1;
      }
      
      public function get petName() : String
      {
         return pet_name$field;
      }
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967291;
         value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 4;
         value$field = param1;
      }
      
      public function get value() : int
      {
         return value$field;
      }
      
      public function removeItemPos() : void
      {
         hasField$0 &= 4294967287;
         item_pos$field = new int();
      }
      
      public function get hasItemPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set itemPos(param1:int) : void
      {
         hasField$0 |= 8;
         item_pos$field = param1;
      }
      
      public function get itemPos() : int
      {
         return item_pos$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967279;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 16;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967263;
         skillId$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 32;
         skillId$field = param1;
      }
      
      public function get skillId() : int
      {
         return skillId$field;
      }
      
      public function removeFightType() : void
      {
         hasField$0 &= 4294967231;
         fightType$field = new int();
      }
      
      public function get hasFightType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fightType(param1:int) : void
      {
         hasField$0 |= 64;
         fightType$field = param1;
      }
      
      public function get fightType() : int
      {
         return fightType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pet_id$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,pet_name$field);
         }
         _loc2_ = 0;
         while(_loc2_ < attributes.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attributes[_loc2_]);
            _loc2_++;
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,value$field);
         }
         if(hasItemPos)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,item_pos$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,skillId$field);
         }
         if(hasFightType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,fightType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.petId cannot be set twice.");
                  }
                  _loc6_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.petName cannot be set twice.");
                  }
                  _loc5_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,attributes);
                  }
                  else
                  {
                     attributes.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.value cannot be set twice.");
                  }
                  _loc9_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.itemPos cannot be set twice.");
                  }
                  _loc3_++;
                  itemPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.payType cannot be set twice.");
                  }
                  _loc10_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.skillId cannot be set twice.");
                  }
                  _loc7_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetOpMsg.fightType cannot be set twice.");
                  }
                  _loc11_++;
                  fightType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

