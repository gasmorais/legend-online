package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignFogMsg extends Message implements IExternalizable
   {
      
      private var row$field:int;
      
      private var hasField$0:uint = 0;
      
      private var col$field:int;
      
      [ArrayElementType("flash.utils.ByteArray")]
      public var forArray:Array = [];
      
      private var map_tempId$field:int;
      
      public function CampaignFogMsg()
      {
         super();
      }
      
      public function removeRow() : void
      {
         hasField$0 &= 4294967294;
         row$field = new int();
      }
      
      public function get hasRow() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set row(param1:int) : void
      {
         hasField$0 |= 1;
         row$field = param1;
      }
      
      public function get row() : int
      {
         return row$field;
      }
      
      public function removeCol() : void
      {
         hasField$0 &= 4294967293;
         col$field = new int();
      }
      
      public function get hasCol() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set col(param1:int) : void
      {
         hasField$0 |= 2;
         col$field = param1;
      }
      
      public function get col() : int
      {
         return col$field;
      }
      
      public function removeMapTempId() : void
      {
         hasField$0 &= 4294967291;
         map_tempId$field = new int();
      }
      
      public function get hasMapTempId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set mapTempId(param1:int) : void
      {
         hasField$0 |= 4;
         map_tempId$field = param1;
      }
      
      public function get mapTempId() : int
      {
         return map_tempId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasRow)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,row$field);
         }
         if(hasCol)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,col$field);
         }
         _loc2_ = 0;
         while(_loc2_ < forArray.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_BYTES(param1,forArray[_loc2_]);
            _loc2_++;
         }
         if(hasMapTempId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,map_tempId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignFogMsg.row cannot be set twice.");
                  }
                  _loc3_++;
                  row = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignFogMsg.col cannot be set twice.");
                  }
                  _loc4_++;
                  col = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  forArray.push(ReadUtils.read$TYPE_BYTES(param1));
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignFogMsg.mapTempId cannot be set twice.");
                  }
                  _loc6_++;
                  mapTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

