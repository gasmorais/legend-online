package com.road.yishi.proto.crisis
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrisisPlayerMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var currentNodeId$field:int;
      
      private var energy$field:int;
      
      private var color$field:int;
      
      private var player$field:RoomPlayerMsg;
      
      public function CrisisPlayerMsg()
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
      
      public function removeCurrentNodeId() : void
      {
         hasField$0 &= 4294967293;
         currentNodeId$field = new int();
      }
      
      public function get hasCurrentNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentNodeId(param1:int) : void
      {
         hasField$0 |= 2;
         currentNodeId$field = param1;
      }
      
      public function get currentNodeId() : int
      {
         return currentNodeId$field;
      }
      
      public function removeEnergy() : void
      {
         hasField$0 &= 4294967291;
         energy$field = new int();
      }
      
      public function get hasEnergy() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set energy(param1:int) : void
      {
         hasField$0 |= 4;
         energy$field = param1;
      }
      
      public function get energy() : int
      {
         return energy$field;
      }
      
      public function removeColor() : void
      {
         hasField$0 &= 4294967287;
         color$field = new int();
      }
      
      public function get hasColor() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set color(param1:int) : void
      {
         hasField$0 |= 8;
         color$field = param1;
      }
      
      public function get color() : int
      {
         return color$field;
      }
      
      public function removePlayer() : void
      {
         player$field = null;
      }
      
      public function get hasPlayer() : Boolean
      {
         return player$field != null;
      }
      
      public function set player(param1:RoomPlayerMsg) : void
      {
         player$field = param1;
      }
      
      public function get player() : RoomPlayerMsg
      {
         return player$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasCurrentNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,currentNodeId$field);
         }
         if(hasEnergy)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,energy$field);
         }
         if(hasColor)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,color$field);
         }
         if(hasPlayer)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,player$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerMsg.id cannot be set twice.");
                  }
                  _loc3_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerMsg.currentNodeId cannot be set twice.");
                  }
                  _loc5_++;
                  currentNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerMsg.energy cannot be set twice.");
                  }
                  _loc7_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerMsg.color cannot be set twice.");
                  }
                  _loc4_++;
                  color = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerMsg.player cannot be set twice.");
                  }
                  _loc8_++;
                  player = new RoomPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,player);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

