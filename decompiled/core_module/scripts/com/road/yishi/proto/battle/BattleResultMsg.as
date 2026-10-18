package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleResultMsg extends Message implements IExternalizable
   {
      
      private var proxy_id$field:String;
      
      private var combat_result$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.battle.ArmyMsg")]
      public var army:Array = [];
      
      private var castle_roomId$field:int;
      
      [ArrayElementType("int")]
      public var userIdList:Array = [];
      
      [ArrayElementType("int")]
      public var scoreList:Array = [];
      
      private var remoteKills$field:String;
      
      public function BattleResultMsg()
      {
         super();
      }
      
      public function removeProxyId() : void
      {
         proxy_id$field = null;
      }
      
      public function get hasProxyId() : Boolean
      {
         return proxy_id$field != null;
      }
      
      public function set proxyId(param1:String) : void
      {
         proxy_id$field = param1;
      }
      
      public function get proxyId() : String
      {
         return proxy_id$field;
      }
      
      public function removeCombatResult() : void
      {
         hasField$0 &= 4294967294;
         combat_result$field = new int();
      }
      
      public function get hasCombatResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set combatResult(param1:int) : void
      {
         hasField$0 |= 1;
         combat_result$field = param1;
      }
      
      public function get combatResult() : int
      {
         return combat_result$field;
      }
      
      public function removeCastleRoomId() : void
      {
         hasField$0 &= 4294967293;
         castle_roomId$field = new int();
      }
      
      public function get hasCastleRoomId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set castleRoomId(param1:int) : void
      {
         hasField$0 |= 2;
         castle_roomId$field = param1;
      }
      
      public function get castleRoomId() : int
      {
         return castle_roomId$field;
      }
      
      public function removeRemoteKills() : void
      {
         remoteKills$field = null;
      }
      
      public function get hasRemoteKills() : Boolean
      {
         return remoteKills$field != null;
      }
      
      public function set remoteKills(param1:String) : void
      {
         remoteKills$field = param1;
      }
      
      public function get remoteKills() : String
      {
         return remoteKills$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         if(hasProxyId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,proxy_id$field);
         }
         if(hasCombatResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,combat_result$field);
         }
         _loc2_ = 0;
         while(_loc2_ < army.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,army[_loc2_]);
            _loc2_++;
         }
         if(hasCastleRoomId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,castle_roomId$field);
         }
         _loc4_ = 0;
         while(_loc4_ < userIdList.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,userIdList[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < scoreList.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,scoreList[_loc3_]);
            _loc3_++;
         }
         if(hasRemoteKills)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,remoteKills$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:ArmyMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleResultMsg.proxyId cannot be set twice.");
                  }
                  _loc3_++;
                  proxyId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BattleResultMsg.combatResult cannot be set twice.");
                  }
                  _loc4_++;
                  combatResult = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc7_ = new ArmyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  army.push(_loc7_);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattleResultMsg.castleRoomId cannot be set twice.");
                  }
                  _loc5_++;
                  castleRoomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIdList);
                  }
                  else
                  {
                     userIdList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,scoreList);
                  }
                  else
                  {
                     scoreList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BattleResultMsg.remoteKills cannot be set twice.");
                  }
                  _loc6_++;
                  remoteKills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

