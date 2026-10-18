package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehiclePickPropMsg extends Message implements IExternalizable
   {
      
      private var propNodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var playerId$field:int;
      
      private var serverName$field:String;
      
      public function VehiclePickPropMsg()
      {
         super();
      }
      
      public function removePropNodeId() : void
      {
         hasField$0 &= 4294967294;
         propNodeId$field = new int();
      }
      
      public function get hasPropNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set propNodeId(param1:int) : void
      {
         hasField$0 |= 1;
         propNodeId$field = param1;
      }
      
      public function get propNodeId() : int
      {
         return propNodeId$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967293;
         playerId$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 2;
         playerId$field = param1;
      }
      
      public function get playerId() : int
      {
         return playerId$field;
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
         if(hasPropNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,propNodeId$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
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
                     throw new IOError("Bad data format: VehiclePickPropMsg.propNodeId cannot be set twice.");
                  }
                  _loc4_++;
                  propNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehiclePickPropMsg.playerId cannot be set twice.");
                  }
                  _loc5_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehiclePickPropMsg.serverName cannot be set twice.");
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

