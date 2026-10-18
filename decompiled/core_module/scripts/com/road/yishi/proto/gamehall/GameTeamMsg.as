package com.road.yishi.proto.gamehall
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameTeamMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var opUserId$field:int;
      
      private var teamId$field:int;
      
      private var gameId$field:int;
      
      private var teamState$field:int;
      
      private var captainId$field:int;
      
      private var password$field:String;
      
      private var difficulty$field:int;
      
      [ArrayElementType("com.road.yishi.proto.gamehall.GameTeamPlayerMsg")]
      public var players:Array = [];
      
      private var autoType$field:int;
      
      public function GameTeamMsg()
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
      
      public function removeOpUserId() : void
      {
         hasField$0 &= 4294967293;
         opUserId$field = new int();
      }
      
      public function get hasOpUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set opUserId(param1:int) : void
      {
         hasField$0 |= 2;
         opUserId$field = param1;
      }
      
      public function get opUserId() : int
      {
         return opUserId$field;
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967291;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 4;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeGameId() : void
      {
         hasField$0 &= 4294967287;
         gameId$field = new int();
      }
      
      public function get hasGameId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gameId(param1:int) : void
      {
         hasField$0 |= 8;
         gameId$field = param1;
      }
      
      public function get gameId() : int
      {
         return gameId$field;
      }
      
      public function removeTeamState() : void
      {
         hasField$0 &= 4294967279;
         teamState$field = new int();
      }
      
      public function get hasTeamState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set teamState(param1:int) : void
      {
         hasField$0 |= 16;
         teamState$field = param1;
      }
      
      public function get teamState() : int
      {
         return teamState$field;
      }
      
      public function removeCaptainId() : void
      {
         hasField$0 &= 4294967263;
         captainId$field = new int();
      }
      
      public function get hasCaptainId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set captainId(param1:int) : void
      {
         hasField$0 |= 32;
         captainId$field = param1;
      }
      
      public function get captainId() : int
      {
         return captainId$field;
      }
      
      public function removePassword() : void
      {
         password$field = null;
      }
      
      public function get hasPassword() : Boolean
      {
         return password$field != null;
      }
      
      public function set password(param1:String) : void
      {
         password$field = param1;
      }
      
      public function get password() : String
      {
         return password$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967231;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 64;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeAutoType() : void
      {
         hasField$0 &= 4294967167;
         autoType$field = new int();
      }
      
      public function get hasAutoType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set autoType(param1:int) : void
      {
         hasField$0 |= 128;
         autoType$field = param1;
      }
      
      public function get autoType() : int
      {
         return autoType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasOpUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,opUserId$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasGameId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,gameId$field);
         }
         if(hasTeamState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,teamState$field);
         }
         if(hasCaptainId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,captainId$field);
         }
         if(hasPassword)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,password$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,players[_loc2_]);
            _loc2_++;
         }
         if(hasAutoType)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,autoType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc5_:GameTeamPlayerMsg = null;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.op cannot be set twice.");
                  }
                  _loc12_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.opUserId cannot be set twice.");
                  }
                  _loc6_++;
                  opUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.teamId cannot be set twice.");
                  }
                  _loc4_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.gameId cannot be set twice.");
                  }
                  _loc9_++;
                  gameId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.teamState cannot be set twice.");
                  }
                  _loc10_++;
                  teamState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.captainId cannot be set twice.");
                  }
                  _loc7_++;
                  captainId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.password cannot be set twice.");
                  }
                  _loc8_++;
                  password = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.difficulty cannot be set twice.");
                  }
                  _loc13_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc5_ = new GameTeamPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  players.push(_loc5_);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamMsg.autoType cannot be set twice.");
                  }
                  _loc3_++;
                  autoType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

