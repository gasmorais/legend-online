package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetRankMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var server_name$field:String;
      
      private var nick_name$field:String;
      
      private var rank$field:int;
      
      private var score$field:int;
      
      private var fightCapacity$field:int;
      
      [ArrayElementType("com.road.yishi.proto.pet.CrossPetInfoMsg")]
      public var pets:Array = [];
      
      public function PetRankMsg()
      {
         super();
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
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
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
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967293;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 2;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
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
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967287;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 8;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pets.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,pets[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:CrossPetInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetRankMsg.uuid cannot be set twice.");
                  }
                  _loc3_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PetRankMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PetRankMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetRankMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PetRankMsg.rank cannot be set twice.");
                  }
                  _loc5_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PetRankMsg.score cannot be set twice.");
                  }
                  _loc11_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PetRankMsg.fightCapacity cannot be set twice.");
                  }
                  _loc10_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc7_ = new CrossPetInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  pets.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

