package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetLogMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tarUserId$field:int;
      
      private var tarServerName$field:String;
      
      private var tarNickName$field:String;
      
      private var result$field:int;
      
      private var isAttack$field:Boolean;
      
      private var logDate$field:String;
      
      private var score$field:int;
      
      [ArrayElementType("com.road.yishi.proto.pet.CrossPetInfoMsg")]
      public var pets:Array = [];
      
      public function PetLogMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeTarUserId() : void
      {
         hasField$0 &= 4294967293;
         tarUserId$field = new int();
      }
      
      public function get hasTarUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tarUserId(param1:int) : void
      {
         hasField$0 |= 2;
         tarUserId$field = param1;
      }
      
      public function get tarUserId() : int
      {
         return tarUserId$field;
      }
      
      public function removeTarServerName() : void
      {
         tarServerName$field = null;
      }
      
      public function get hasTarServerName() : Boolean
      {
         return tarServerName$field != null;
      }
      
      public function set tarServerName(param1:String) : void
      {
         tarServerName$field = param1;
      }
      
      public function get tarServerName() : String
      {
         return tarServerName$field;
      }
      
      public function removeTarNickName() : void
      {
         tarNickName$field = null;
      }
      
      public function get hasTarNickName() : Boolean
      {
         return tarNickName$field != null;
      }
      
      public function set tarNickName(param1:String) : void
      {
         tarNickName$field = param1;
      }
      
      public function get tarNickName() : String
      {
         return tarNickName$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967291;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 4;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeIsAttack() : void
      {
         hasField$0 &= 4294967287;
         isAttack$field = new Boolean();
      }
      
      public function get hasIsAttack() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isAttack(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isAttack$field = param1;
      }
      
      public function get isAttack() : Boolean
      {
         return isAttack$field;
      }
      
      public function removeLogDate() : void
      {
         logDate$field = null;
      }
      
      public function get hasLogDate() : Boolean
      {
         return logDate$field != null;
      }
      
      public function set logDate(param1:String) : void
      {
         logDate$field = param1;
      }
      
      public function get logDate() : String
      {
         return logDate$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967279;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 16;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasTarUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tarUserId$field);
         }
         if(hasTarServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,tarServerName$field);
         }
         if(hasTarNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,tarNickName$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasIsAttack)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isAttack$field);
         }
         if(hasLogDate)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,logDate$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pets.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,pets[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc8_:CrossPetInfoMsg = null;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.tarUserId cannot be set twice.");
                  }
                  _loc3_++;
                  tarUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.tarServerName cannot be set twice.");
                  }
                  _loc4_++;
                  tarServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.tarNickName cannot be set twice.");
                  }
                  _loc6_++;
                  tarNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.result cannot be set twice.");
                  }
                  _loc9_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.isAttack cannot be set twice.");
                  }
                  _loc5_++;
                  isAttack = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.logDate cannot be set twice.");
                  }
                  _loc7_++;
                  logDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PetLogMsg.score cannot be set twice.");
                  }
                  _loc12_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc8_ = new CrossPetInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  pets.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

