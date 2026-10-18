package com.road.yishi.proto.secretexplore
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretExploreMapRspMsg extends Message implements IExternalizable
   {
      
      private var mapDataId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.secretexplore.SecretExploreEventRspMsg")]
      public var events:Array = [];
      
      public function SecretExploreMapRspMsg()
      {
         super();
      }
      
      public function removeMapDataId() : void
      {
         hasField$0 &= 4294967294;
         mapDataId$field = new int();
      }
      
      public function get hasMapDataId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapDataId(param1:int) : void
      {
         hasField$0 |= 1;
         mapDataId$field = param1;
      }
      
      public function get mapDataId() : int
      {
         return mapDataId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasMapDataId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mapDataId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < events.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,events[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:SecretExploreEventRspMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreMapRspMsg.mapDataId cannot be set twice.");
                  }
                  _loc5_++;
                  mapDataId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new SecretExploreEventRspMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  events.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

