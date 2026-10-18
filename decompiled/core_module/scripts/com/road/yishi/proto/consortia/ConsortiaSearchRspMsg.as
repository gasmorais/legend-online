package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaSearchRspMsg extends Message implements IExternalizable
   {
      
      private var total_rows$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.consortia.ConsortiaInfoMsg")]
      public var consortiaInfo:Array = [];
      
      private var is_reset$field:Boolean;
      
      public function ConsortiaSearchRspMsg()
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
      
      public function removeIsReset() : void
      {
         hasField$0 &= 4294967293;
         is_reset$field = new Boolean();
      }
      
      public function get hasIsReset() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isReset(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_reset$field = param1;
      }
      
      public function get isReset() : Boolean
      {
         return is_reset$field;
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
         while(_loc2_ < consortiaInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,consortiaInfo[_loc2_]);
            _loc2_++;
         }
         if(hasIsReset)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_reset$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:ConsortiaInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaSearchRspMsg.totalRows cannot be set twice.");
                  }
                  _loc3_++;
                  totalRows = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc6_ = new ConsortiaInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  consortiaInfo.push(_loc6_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaSearchRspMsg.isReset cannot be set twice.");
                  }
                  _loc4_++;
                  isReset = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

