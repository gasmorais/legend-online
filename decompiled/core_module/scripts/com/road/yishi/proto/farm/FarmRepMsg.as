package com.road.yishi.proto.farm
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FarmRepMsg extends Message implements IExternalizable
   {
      
      private var farm_land_info$field:FarmLandInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.farm.FarmPetInfoMsg")]
      public var petInfo:Array = [];
      
      public function FarmRepMsg()
      {
         super();
      }
      
      public function removeFarmLandInfo() : void
      {
         farm_land_info$field = null;
      }
      
      public function get hasFarmLandInfo() : Boolean
      {
         return farm_land_info$field != null;
      }
      
      public function set farmLandInfo(param1:FarmLandInfoMsg) : void
      {
         farm_land_info$field = param1;
      }
      
      public function get farmLandInfo() : FarmLandInfoMsg
      {
         return farm_land_info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasFarmLandInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,farm_land_info$field);
         }
         _loc2_ = 0;
         while(_loc2_ < petInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,petInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:FarmPetInfoMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FarmRepMsg.farmLandInfo cannot be set twice.");
                  }
                  _loc5_++;
                  farmLandInfo = new FarmLandInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,farmLandInfo);
                  break;
               case 1:
                  _loc3_ = new FarmPetInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  petInfo.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

