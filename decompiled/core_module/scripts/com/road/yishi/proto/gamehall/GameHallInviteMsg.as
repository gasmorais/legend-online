package com.road.yishi.proto.gamehall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameHallInviteMsg extends Message implements IExternalizable
   {
      
      private var teamId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gameId$field:int;
      
      private var difficulty$field:int;
      
      private var inviterId$field:int;
      
      private var inviterName$field:String;
      
      private var count$field:int;
      
      private var param1$field:int;
      
      public function GameHallInviteMsg()
      {
         super();
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967294;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 1;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeGameId() : void
      {
         hasField$0 &= 4294967293;
         gameId$field = new int();
      }
      
      public function get hasGameId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gameId(param1:int) : void
      {
         hasField$0 |= 2;
         gameId$field = param1;
      }
      
      public function get gameId() : int
      {
         return gameId$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967291;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 4;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeInviterId() : void
      {
         hasField$0 &= 4294967287;
         inviterId$field = new int();
      }
      
      public function get hasInviterId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set inviterId(param1:int) : void
      {
         hasField$0 |= 8;
         inviterId$field = param1;
      }
      
      public function get inviterId() : int
      {
         return inviterId$field;
      }
      
      public function removeInviterName() : void
      {
         inviterName$field = null;
      }
      
      public function get hasInviterName() : Boolean
      {
         return inviterName$field != null;
      }
      
      public function set inviterName(param1:String) : void
      {
         inviterName$field = param1;
      }
      
      public function get inviterName() : String
      {
         return inviterName$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967263;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 32;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasGameId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,gameId$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         if(hasInviterId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,inviterId$field);
         }
         if(hasInviterName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,inviterName$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallInviteMsg.teamId cannot be set twice.");
                  }
                  _loc7_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallInviteMsg.gameId cannot be set twice.");
                  }
                  _loc8_++;
                  gameId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallInviteMsg.difficulty cannot be set twice.");
                  }
                  _loc10_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallInviteMsg.inviterId cannot be set twice.");
                  }
                  _loc4_++;
                  inviterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallInviteMsg.inviterName cannot be set twice.");
                  }
                  _loc5_++;
                  inviterName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallInviteMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallInviteMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

