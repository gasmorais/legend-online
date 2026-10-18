package com.road.yishi.proto.secretexplore
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretExploreSecenRspMsg extends Message implements IExternalizable
   {
      
      private var levelId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var mapDataIds$field:String;
      
      private var currentMapDataId$field:int;
      
      private var nodeId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.secretexplore.SecretExploreMapRspMsg")]
      public var maps:Array = [];
      
      public function SecretExploreSecenRspMsg()
      {
         super();
      }
      
      public function removeLevelId() : void
      {
         hasField$0 &= 4294967294;
         levelId$field = new int();
      }
      
      public function get hasLevelId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set levelId(param1:int) : void
      {
         hasField$0 |= 1;
         levelId$field = param1;
      }
      
      public function get levelId() : int
      {
         return levelId$field;
      }
      
      public function removeMapDataIds() : void
      {
         mapDataIds$field = null;
      }
      
      public function get hasMapDataIds() : Boolean
      {
         return mapDataIds$field != null;
      }
      
      public function set mapDataIds(param1:String) : void
      {
         mapDataIds$field = param1;
      }
      
      public function get mapDataIds() : String
      {
         return mapDataIds$field;
      }
      
      public function removeCurrentMapDataId() : void
      {
         hasField$0 &= 4294967293;
         currentMapDataId$field = new int();
      }
      
      public function get hasCurrentMapDataId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentMapDataId(param1:int) : void
      {
         hasField$0 |= 2;
         currentMapDataId$field = param1;
      }
      
      public function get currentMapDataId() : int
      {
         return currentMapDataId$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967291;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 4;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLevelId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,levelId$field);
         }
         if(hasMapDataIds)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,mapDataIds$field);
         }
         if(hasCurrentMapDataId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,currentMapDataId$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < maps.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,maps[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:SecretExploreMapRspMsg = null;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreSecenRspMsg.levelId cannot be set twice.");
                  }
                  _loc3_++;
                  levelId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreSecenRspMsg.mapDataIds cannot be set twice.");
                  }
                  _loc7_++;
                  mapDataIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreSecenRspMsg.currentMapDataId cannot be set twice.");
                  }
                  _loc5_++;
                  currentMapDataId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreSecenRspMsg.nodeId cannot be set twice.");
                  }
                  _loc4_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc6_ = new SecretExploreMapRspMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  maps.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

