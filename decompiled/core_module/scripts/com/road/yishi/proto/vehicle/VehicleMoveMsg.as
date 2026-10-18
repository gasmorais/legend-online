package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehicleMoveMsg extends Message implements IExternalizable
   {
      
      private var playerId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var timestamp$field:int;
      
      [ArrayElementType("com.road.yishi.proto.vehicle.Position")]
      public var path:Array = [];
      
      private var serverName$field:String;
      
      public function VehicleMoveMsg()
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
      
      public function removeTimestamp() : void
      {
         hasField$0 &= 4294967293;
         timestamp$field = new int();
      }
      
      public function get hasTimestamp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set timestamp(param1:int) : void
      {
         hasField$0 |= 2;
         timestamp$field = param1;
      }
      
      public function get timestamp() : int
      {
         return timestamp$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasTimestamp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,timestamp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < path.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,path[_loc2_]);
            _loc2_++;
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:Position = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleMoveMsg.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleMoveMsg.timestamp cannot be set twice.");
                  }
                  _loc5_++;
                  timestamp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc7_ = new Position();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  path.push(_loc7_);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleMoveMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

