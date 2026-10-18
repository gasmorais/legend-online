package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerNodeStateMsg extends Message implements IExternalizable
   {
      
      private var map_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var node_id$field:int;
      
      private var is_stand$field:Boolean;
      
      private var army_id$field:int;
      
      public function PlayerNodeStateMsg()
      {
         super();
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967294;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 1;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967293;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 2;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeIsStand() : void
      {
         hasField$0 &= 4294967291;
         is_stand$field = new Boolean();
      }
      
      public function get hasIsStand() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isStand(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_stand$field = param1;
      }
      
      public function get isStand() : Boolean
      {
         return is_stand$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967287;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 8;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasIsStand)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_stand$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerNodeStateMsg.mapId cannot be set twice.");
                  }
                  _loc4_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerNodeStateMsg.nodeId cannot be set twice.");
                  }
                  _loc5_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerNodeStateMsg.isStand cannot be set twice.");
                  }
                  _loc6_++;
                  isStand = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerNodeStateMsg.armyId cannot be set twice.");
                  }
                  _loc3_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

