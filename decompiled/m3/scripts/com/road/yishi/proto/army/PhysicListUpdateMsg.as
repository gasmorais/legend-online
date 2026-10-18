package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PhysicListUpdateMsg extends Message implements IExternalizable
   {
      
      private var req_grid$field:String;
      
      [ArrayElementType("com.road.yishi.proto.army.WildLandMsg")]
      public var wildLand:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.army.BaseCastleMsg")]
      public var baseCastle:Array = [];
      
      public function PhysicListUpdateMsg()
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasReqGrid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,req_grid$field);
         }
         _loc2_ = 0;
         while(_loc2_ < wildLand.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,wildLand[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < baseCastle.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,baseCastle[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:WildLandMsg = null;
         var _loc5_:BaseCastleMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PhysicListUpdateMsg.reqGrid cannot be set twice.");
                  }
                  _loc3_++;
                  reqGrid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  _loc4_ = new WildLandMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  wildLand.push(_loc4_);
                  break;
               case 2:
                  _loc5_ = new BaseCastleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  baseCastle.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

