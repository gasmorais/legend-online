package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MultiCampaignHpSyncMsg extends Message implements IExternalizable
   {
      
      private var proxyId$field:String;
      
      private var mapId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nodeId$field:int;
      
      private var nodeHp$field:int;
      
      private var nodeTotalHp$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.MultiPlayerHpSyncMsg")]
      public var playerHp:Array = [];
      
      public function MultiCampaignHpSyncMsg()
      {
         super();
      }
      
      public function removeProxyId() : void
      {
         proxyId$field = null;
      }
      
      public function get hasProxyId() : Boolean
      {
         return proxyId$field != null;
      }
      
      public function set proxyId(param1:String) : void
      {
         proxyId$field = param1;
      }
      
      public function get proxyId() : String
      {
         return proxyId$field;
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967294;
         mapId$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 1;
         mapId$field = param1;
      }
      
      public function get mapId() : int
      {
         return mapId$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967293;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 2;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeNodeHp() : void
      {
         hasField$0 &= 4294967291;
         nodeHp$field = new int();
      }
      
      public function get hasNodeHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nodeHp(param1:int) : void
      {
         hasField$0 |= 4;
         nodeHp$field = param1;
      }
      
      public function get nodeHp() : int
      {
         return nodeHp$field;
      }
      
      public function removeNodeTotalHp() : void
      {
         hasField$0 &= 4294967287;
         nodeTotalHp$field = new int();
      }
      
      public function get hasNodeTotalHp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set nodeTotalHp(param1:int) : void
      {
         hasField$0 |= 8;
         nodeTotalHp$field = param1;
      }
      
      public function get nodeTotalHp() : int
      {
         return nodeTotalHp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasProxyId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,proxyId$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,mapId$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasNodeHp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,nodeHp$field);
         }
         if(hasNodeTotalHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,nodeTotalHp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < playerHp.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,playerHp[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:MultiPlayerHpSyncMsg = null;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MultiCampaignHpSyncMsg.proxyId cannot be set twice.");
                  }
                  _loc7_++;
                  proxyId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MultiCampaignHpSyncMsg.mapId cannot be set twice.");
                  }
                  _loc9_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MultiCampaignHpSyncMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MultiCampaignHpSyncMsg.nodeHp cannot be set twice.");
                  }
                  _loc4_++;
                  nodeHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MultiCampaignHpSyncMsg.nodeTotalHp cannot be set twice.");
                  }
                  _loc5_++;
                  nodeTotalHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc8_ = new MultiPlayerHpSyncMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  playerHp.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

