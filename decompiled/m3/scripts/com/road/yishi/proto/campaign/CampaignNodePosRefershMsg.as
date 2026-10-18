package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignNodePosRefershMsg extends Message implements IExternalizable
   {
      
      private var map_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var node_id$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var state$field:int;
      
      public function CampaignNodePosRefershMsg()
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
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967291;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 4;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967287;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 8;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
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
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodePosRefershMsg.mapId cannot be set twice.");
                  }
                  _loc5_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodePosRefershMsg.nodeId cannot be set twice.");
                  }
                  _loc6_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodePosRefershMsg.posX cannot be set twice.");
                  }
                  _loc8_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodePosRefershMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodePosRefershMsg.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

