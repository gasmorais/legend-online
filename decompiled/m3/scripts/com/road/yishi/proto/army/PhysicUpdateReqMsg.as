package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PhysicUpdateReqMsg extends Message implements IExternalizable
   {
      
      private var req_grid$field:String;
      
      private var map_id$field:int;
      
      private var hasField$0:uint = 0;
      
      public function PhysicUpdateReqMsg()
      {
         super();
      }
      
      public function removeReqGrid() : void
      {
         req_grid$field = null;
      }
      
      public function get hasReqGrid() : Boolean
      {
         return req_grid$field != null;
      }
      
      public function set reqGrid(param1:String) : void
      {
         req_grid$field = param1;
      }
      
      public function get reqGrid() : String
      {
         return req_grid$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasReqGrid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,req_grid$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PhysicUpdateReqMsg.reqGrid cannot be set twice.");
                  }
                  _loc3_++;
                  reqGrid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PhysicUpdateReqMsg.mapId cannot be set twice.");
                  }
                  _loc4_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

