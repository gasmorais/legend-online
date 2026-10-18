package com.road.yishi.proto.building
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BuildingOptionReqMsg extends Message implements IExternalizable
   {
      
      private var building_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var son_type$field:int;
      
      public function BuildingOptionReqMsg()
      {
         super();
      }
      
      public function removeBuildingId() : void
      {
         hasField$0 &= 4294967294;
         building_id$field = new int();
      }
      
      public function get hasBuildingId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set buildingId(param1:int) : void
      {
         hasField$0 |= 1;
         building_id$field = param1;
      }
      
      public function get buildingId() : int
      {
         return building_id$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967293;
         son_type$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 2;
         son_type$field = param1;
      }
      
      public function get sonType() : int
      {
         return son_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBuildingId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,building_id$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,son_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingOptionReqMsg.buildingId cannot be set twice.");
                  }
                  _loc4_++;
                  buildingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingOptionReqMsg.sonType cannot be set twice.");
                  }
                  _loc3_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

