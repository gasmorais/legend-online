package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetHallowListMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sonType$field:int;
      
      private var petId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.pet.PetContractInfoMsg")]
      public var contractInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.pet.PetHallowInfoMsg")]
      public var hallowInfo:Array = [];
      
      [ArrayElementType("int")]
      public var lockSet:Array = [];
      
      private var removeItemTempId$field:int;
      
      private var payType$field:int;
      
      public function PetHallowListMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967293;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 2;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967291;
         petId$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 4;
         petId$field = param1;
      }
      
      public function get petId() : int
      {
         return petId$field;
      }
      
      public function removeRemoveItemTempId() : void
      {
         hasField$0 &= 4294967287;
         removeItemTempId$field = new int();
      }
      
      public function get hasRemoveItemTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set removeItemTempId(param1:int) : void
      {
         hasField$0 |= 8;
         removeItemTempId$field = param1;
      }
      
      public function get removeItemTempId() : int
      {
         return removeItemTempId$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967279;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 16;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,petId$field);
         }
         _loc4_ = 0;
         while(_loc4_ < contractInfo.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,contractInfo[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < hallowInfo.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,hallowInfo[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < lockSet.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,lockSet[_loc2_]);
            _loc2_++;
         }
         if(hasRemoveItemTempId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,removeItemTempId$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:PetContractInfoMsg = null;
         var _loc4_:PetHallowInfoMsg = null;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowListMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowListMsg.sonType cannot be set twice.");
                  }
                  _loc3_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowListMsg.petId cannot be set twice.");
                  }
                  _loc5_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc9_ = new PetContractInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  contractInfo.push(_loc9_);
                  break;
               case 4:
                  _loc4_ = new PetHallowInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  hallowInfo.push(_loc4_);
                  break;
               case 5:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,lockSet);
                  }
                  else
                  {
                     lockSet.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowListMsg.removeItemTempId cannot be set twice.");
                  }
                  _loc6_++;
                  removeItemTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowListMsg.payType cannot be set twice.");
                  }
                  _loc7_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

