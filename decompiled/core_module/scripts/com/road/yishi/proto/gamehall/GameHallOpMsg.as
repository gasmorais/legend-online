package com.road.yishi.proto.gamehall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameHallOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var teamId$field:int;
      
      private var gameId$field:int;
      
      private var difficulty$field:int;
      
      private var userId$field:int;
      
      private var password$field:String;
      
      private var isUseCount$field:Boolean;
      
      private var isPrepare$field:Boolean;
      
      private var isRefresh$field:Boolean;
      
      private var autoType$field:int;
      
      public function GameHallOpMsg()
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
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967293;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 2;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeGameId() : void
      {
         hasField$0 &= 4294967291;
         gameId$field = new int();
      }
      
      public function get hasGameId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gameId(param1:int) : void
      {
         hasField$0 |= 4;
         gameId$field = param1;
      }
      
      public function get gameId() : int
      {
         return gameId$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967287;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 8;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967279;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 16;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
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
      
      public function removeIsUseCount() : void
      {
         hasField$0 &= 4294967263;
         isUseCount$field = new Boolean();
      }
      
      public function get hasIsUseCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isUseCount(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isUseCount$field = param1;
      }
      
      public function get isUseCount() : Boolean
      {
         return isUseCount$field;
      }
      
      public function removeIsPrepare() : void
      {
         hasField$0 &= 4294967231;
         isPrepare$field = new Boolean();
      }
      
      public function get hasIsPrepare() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isPrepare(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isPrepare$field = param1;
      }
      
      public function get isPrepare() : Boolean
      {
         return isPrepare$field;
      }
      
      public function removeIsRefresh() : void
      {
         hasField$0 &= 4294967167;
         isRefresh$field = new Boolean();
      }
      
      public function get hasIsRefresh() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isRefresh(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isRefresh$field = param1;
      }
      
      public function get isRefresh() : Boolean
      {
         return isRefresh$field;
      }
      
      public function removeAutoType() : void
      {
         hasField$0 &= 4294967039;
         autoType$field = new int();
      }
      
      public function get hasAutoType() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set autoType(param1:int) : void
      {
         hasField$0 |= 256;
         autoType$field = param1;
      }
      
      public function get autoType() : int
      {
         return autoType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasGameId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gameId$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasPassword)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,password$field);
         }
         if(hasIsUseCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isUseCount$field);
         }
         if(hasIsPrepare)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isPrepare$field);
         }
         if(hasIsRefresh)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isRefresh$field);
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
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.op cannot be set twice.");
                  }
                  _loc12_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.teamId cannot be set twice.");
                  }
                  _loc6_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.gameId cannot be set twice.");
                  }
                  _loc9_++;
                  gameId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.difficulty cannot be set twice.");
                  }
                  _loc13_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.password cannot be set twice.");
                  }
                  _loc8_++;
                  password = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.isUseCount cannot be set twice.");
                  }
                  _loc5_++;
                  isUseCount = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.isPrepare cannot be set twice.");
                  }
                  _loc4_++;
                  isPrepare = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.isRefresh cannot be set twice.");
                  }
                  _loc10_++;
                  isRefresh = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallOpMsg.autoType cannot be set twice.");
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

