package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehicleBuffStateMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var buffId$field:int;
      
      private var state$field:int;
      
      private var playerId$field:int;
      
      private var effectValue$field:int;
      
      private var serverName$field:String;
      
      public function VehicleBuffStateMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeBuffId() : void
      {
         hasField$0 &= 4294967293;
         buffId$field = new int();
      }
      
      public function get hasBuffId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buffId(param1:int) : void
      {
         hasField$0 |= 2;
         buffId$field = param1;
      }
      
      public function get buffId() : int
      {
         return buffId$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967291;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 4;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967287;
         playerId$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 8;
         playerId$field = param1;
      }
      
      public function get playerId() : int
      {
         return playerId$field;
      }
      
      public function removeEffectValue() : void
      {
         hasField$0 &= 4294967279;
         effectValue$field = new int();
      }
      
      public function get hasEffectValue() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set effectValue(param1:int) : void
      {
         hasField$0 |= 16;
         effectValue$field = param1;
      }
      
      public function get effectValue() : int
      {
         return effectValue$field;
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
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasBuffId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,buffId$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasEffectValue)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,effectValue$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleBuffStateMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleBuffStateMsg.buffId cannot be set twice.");
                  }
                  _loc3_++;
                  buffId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleBuffStateMsg.state cannot be set twice.");
                  }
                  _loc7_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleBuffStateMsg.playerId cannot be set twice.");
                  }
                  _loc5_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleBuffStateMsg.effectValue cannot be set twice.");
                  }
                  _loc9_++;
                  effectValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleBuffStateMsg.serverName cannot be set twice.");
                  }
                  _loc4_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

