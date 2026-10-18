package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetChallengeInfoMsg extends Message implements IExternalizable
   {
      
      private var player_info$field:PetChallengePlayerMsg;
      
      [ArrayElementType("com.road.yishi.proto.pet.PlayerPetMsg")]
      public var playerPets:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.pet.PetChallengeLogMsg")]
      public var challengeLog:Array = [];
      
      public function PetChallengeInfoMsg()
      {
         super();
      }
      
      public function removePlayerInfo() : void
      {
         player_info$field = null;
      }
      
      public function get hasPlayerInfo() : Boolean
      {
         return player_info$field != null;
      }
      
      public function set playerInfo(param1:PetChallengePlayerMsg) : void
      {
         player_info$field = param1;
      }
      
      public function get playerInfo() : PetChallengePlayerMsg
      {
         return player_info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasPlayerInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,player_info$field);
         }
         _loc2_ = 0;
         while(_loc2_ < playerPets.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,playerPets[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < challengeLog.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,challengeLog[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:PlayerPetMsg = null;
         var _loc4_:PetChallengeLogMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetChallengeInfoMsg.playerInfo cannot be set twice.");
                  }
                  _loc3_++;
                  playerInfo = new PetChallengePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,playerInfo);
                  break;
               case 1:
                  _loc5_ = new PlayerPetMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  playerPets.push(_loc5_);
                  break;
               case 2:
                  _loc4_ = new PetChallengeLogMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  challengeLog.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

