package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NavigationBoatUpgradeInviteMsg extends Message implements IExternalizable
   {
      
      private var playerId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var playerName$field:String;
      
      private var boatId$field:String;
      
      private var token$field:String;
      
      public function NavigationBoatUpgradeInviteMsg()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         playerId$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         playerId$field = param1;
      }
      
      public function get playerId() : int
      {
         return playerId$field;
      }
      
      public function removePlayerName() : void
      {
         playerName$field = null;
      }
      
      public function get hasPlayerName() : Boolean
      {
         return playerName$field != null;
      }
      
      public function set playerName(param1:String) : void
      {
         playerName$field = param1;
      }
      
      public function get playerName() : String
      {
         return playerName$field;
      }
      
      public function removeBoatId() : void
      {
         boatId$field = null;
      }
      
      public function get hasBoatId() : Boolean
      {
         return boatId$field != null;
      }
      
      public function set boatId(param1:String) : void
      {
         boatId$field = param1;
      }
      
      public function get boatId() : String
      {
         return boatId$field;
      }
      
      public function removeToken() : void
      {
         token$field = null;
      }
      
      public function get hasToken() : Boolean
      {
         return token$field != null;
      }
      
      public function set token(param1:String) : void
      {
         token$field = param1;
      }
      
      public function get token() : String
      {
         return token$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasPlayerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,playerName$field);
         }
         if(hasBoatId)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,boatId$field);
         }
         if(hasToken)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,token$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationBoatUpgradeInviteMsg.playerId cannot be set twice.");
                  }
                  _loc3_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationBoatUpgradeInviteMsg.playerName cannot be set twice.");
                  }
                  _loc4_++;
                  playerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationBoatUpgradeInviteMsg.boatId cannot be set twice.");
                  }
                  _loc7_++;
                  boatId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationBoatUpgradeInviteMsg.token cannot be set twice.");
                  }
                  _loc5_++;
                  token = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

