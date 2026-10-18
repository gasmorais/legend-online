package com.road.yishi.proto.farm
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LoadFarmRsp extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.farm.FriendFarmStateMsg")]
      public var friendFarmState:Array = [];
      
      private var farm$field:FarmInfoRspMsg;
      
      [ArrayElementType("com.road.yishi.proto.farm.FarmLogRsp")]
      public var farmLog:Array = [];
      
      public function LoadFarmRsp()
      {
         super();
      }
      
      public function removeFarm() : void
      {
         farm$field = null;
      }
      
      public function get hasFarm() : Boolean
      {
         return farm$field != null;
      }
      
      public function set farm(param1:FarmInfoRspMsg) : void
      {
         farm$field = param1;
      }
      
      public function get farm() : FarmInfoRspMsg
      {
         return farm$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < friendFarmState.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,friendFarmState[_loc2_]);
            _loc2_++;
         }
         if(hasFarm)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,farm$field);
         }
         _loc3_ = 0;
         while(_loc3_ < farmLog.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,farmLog[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:FriendFarmStateMsg = null;
         var _loc4_:FarmLogRsp = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc5_ = new FriendFarmStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  friendFarmState.push(_loc5_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LoadFarmRsp.farm cannot be set twice.");
                  }
                  _loc3_++;
                  farm = new FarmInfoRspMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,farm);
                  break;
               case 2:
                  _loc4_ = new FarmLogRsp();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  farmLog.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

