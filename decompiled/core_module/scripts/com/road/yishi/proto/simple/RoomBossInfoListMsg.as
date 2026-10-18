package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomBossInfoListMsg extends Message implements IExternalizable
   {
      
      private var castle_room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaign_id$field:int;
      
      private var node_id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.simple.RoomBossInfoMsg")]
      public var roomBoss:Array = [];
      
      public function RoomBossInfoListMsg()
      {
         super();
      }
      
      public function removeCastleRoomId() : void
      {
         hasField$0 &= 4294967294;
         castle_room_id$field = new int();
      }
      
      public function get hasCastleRoomId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set castleRoomId(param1:int) : void
      {
         hasField$0 |= 1;
         castle_room_id$field = param1;
      }
      
      public function get castleRoomId() : int
      {
         return castle_room_id$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967293;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 2;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967291;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 4;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCastleRoomId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,castle_room_id$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < roomBoss.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,roomBoss[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:RoomBossInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoListMsg.castleRoomId cannot be set twice.");
                  }
                  _loc4_++;
                  castleRoomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoListMsg.campaignId cannot be set twice.");
                  }
                  _loc5_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoListMsg.nodeId cannot be set twice.");
                  }
                  _loc6_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc3_ = new RoomBossInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  roomBoss.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

