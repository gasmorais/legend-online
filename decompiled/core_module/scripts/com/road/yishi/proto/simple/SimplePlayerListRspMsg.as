package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimplePlayerListRspMsg extends Message implements IExternalizable
   {
      
      private var total_rows$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.simple.SimplePlayerInfoMsg")]
      public var playerInfo:Array = [];
      
      private var uuid$field:String;
      
      public function SimplePlayerListRspMsg()
      {
         super();
      }
      
      public function removeTotalRows() : void
      {
         hasField$0 &= 4294967294;
         total_rows$field = new int();
      }
      
      public function get hasTotalRows() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set totalRows(param1:int) : void
      {
         hasField$0 |= 1;
         total_rows$field = param1;
      }
      
      public function get totalRows() : int
      {
         return total_rows$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTotalRows)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,total_rows$field);
         }
         _loc2_ = 0;
         while(_loc2_ < playerInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,playerInfo[_loc2_]);
            _loc2_++;
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:SimplePlayerInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerListRspMsg.totalRows cannot be set twice.");
                  }
                  _loc3_++;
                  totalRows = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new SimplePlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  playerInfo.push(_loc5_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerListRspMsg.uuid cannot be set twice.");
                  }
                  _loc4_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

