package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerPetMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.pet.PetInfoMsg")]
      public var petInfo:Array = [];
      
      private var nick_name$field:String;
      
      private var order$field:int;
      
      private var cha_pos$field:String;
      
      private var score$field:int;
      
      private var pet_count$field:int;
      
      private var operate_type$field:int;
      
      private var lords_pos$field:String;
      
      private var monopoly_pos$field:String;
      
      private var uuid$field:String;
      
      [ArrayElementType("com.road.yishi.proto.pet.PetEquipmentMsg")]
      public var equipmets:Array = [];
      
      private var consortia_pos$field:String;
      
      private var mate_lords_pos$field:String;
      
      private var transfer_pos$field:String;
      
      public function PlayerPetMsg()
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
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967293;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 2;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeChaPos() : void
      {
         cha_pos$field = null;
      }
      
      public function get hasChaPos() : Boolean
      {
         return cha_pos$field != null;
      }
      
      public function set chaPos(param1:String) : void
      {
         cha_pos$field = param1;
      }
      
      public function get chaPos() : String
      {
         return cha_pos$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removePetCount() : void
      {
         hasField$0 &= 4294967287;
         pet_count$field = new int();
      }
      
      public function get hasPetCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set petCount(param1:int) : void
      {
         hasField$0 |= 8;
         pet_count$field = param1;
      }
      
      public function get petCount() : int
      {
         return pet_count$field;
      }
      
      public function removeOperateType() : void
      {
         hasField$0 &= 4294967279;
         operate_type$field = new int();
      }
      
      public function get hasOperateType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set operateType(param1:int) : void
      {
         hasField$0 |= 16;
         operate_type$field = param1;
      }
      
      public function get operateType() : int
      {
         return operate_type$field;
      }
      
      public function removeLordsPos() : void
      {
         lords_pos$field = null;
      }
      
      public function get hasLordsPos() : Boolean
      {
         return lords_pos$field != null;
      }
      
      public function set lordsPos(param1:String) : void
      {
         lords_pos$field = param1;
      }
      
      public function get lordsPos() : String
      {
         return lords_pos$field;
      }
      
      public function removeMonopolyPos() : void
      {
         monopoly_pos$field = null;
      }
      
      public function get hasMonopolyPos() : Boolean
      {
         return monopoly_pos$field != null;
      }
      
      public function set monopolyPos(param1:String) : void
      {
         monopoly_pos$field = param1;
      }
      
      public function get monopolyPos() : String
      {
         return monopoly_pos$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeConsortiaPos() : void
      {
         consortia_pos$field = null;
      }
      
      public function get hasConsortiaPos() : Boolean
      {
         return consortia_pos$field != null;
      }
      
      public function set consortiaPos(param1:String) : void
      {
         consortia_pos$field = param1;
      }
      
      public function get consortiaPos() : String
      {
         return consortia_pos$field;
      }
      
      public function removeMateLordsPos() : void
      {
         mate_lords_pos$field = null;
      }
      
      public function get hasMateLordsPos() : Boolean
      {
         return mate_lords_pos$field != null;
      }
      
      public function set mateLordsPos(param1:String) : void
      {
         mate_lords_pos$field = param1;
      }
      
      public function get mateLordsPos() : String
      {
         return mate_lords_pos$field;
      }
      
      public function removeTransferPos() : void
      {
         transfer_pos$field = null;
      }
      
      public function get hasTransferPos() : Boolean
      {
         return transfer_pos$field != null;
      }
      
      public function set transferPos(param1:String) : void
      {
         transfer_pos$field = param1;
      }
      
      public function get transferPos() : String
      {
         return transfer_pos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         _loc3_ = 0;
         while(_loc3_ < petInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,petInfo[_loc3_]);
            _loc3_++;
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasChaPos)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,cha_pos$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasPetCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pet_count$field);
         }
         if(hasOperateType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,operate_type$field);
         }
         if(hasLordsPos)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,lords_pos$field);
         }
         if(hasMonopolyPos)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,monopoly_pos$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         _loc2_ = 0;
         while(_loc2_ < equipmets.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,equipmets[_loc2_]);
            _loc2_++;
         }
         if(hasConsortiaPos)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,consortia_pos$field);
         }
         if(hasMateLordsPos)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,mate_lords_pos$field);
         }
         if(hasTransferPos)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,transfer_pos$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc4_:PetInfoMsg = null;
         var _loc13_:PetEquipmentMsg = null;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.userId cannot be set twice.");
                  }
                  _loc14_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new PetInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  petInfo.push(_loc4_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.order cannot be set twice.");
                  }
                  _loc11_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.chaPos cannot be set twice.");
                  }
                  _loc7_++;
                  chaPos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.score cannot be set twice.");
                  }
                  _loc16_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.petCount cannot be set twice.");
                  }
                  _loc17_++;
                  petCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.operateType cannot be set twice.");
                  }
                  _loc18_++;
                  operateType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.lordsPos cannot be set twice.");
                  }
                  _loc12_++;
                  lordsPos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.monopolyPos cannot be set twice.");
                  }
                  _loc3_++;
                  monopolyPos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.uuid cannot be set twice.");
                  }
                  _loc9_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  _loc13_ = new PetEquipmentMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  equipmets.push(_loc13_);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.consortiaPos cannot be set twice.");
                  }
                  _loc10_++;
                  consortiaPos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.mateLordsPos cannot be set twice.");
                  }
                  _loc6_++;
                  mateLordsPos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerPetMsg.transferPos cannot be set twice.");
                  }
                  _loc8_++;
                  transferPos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

