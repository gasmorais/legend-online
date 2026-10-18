package com.road.yishi.proto.airgarden
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AirGardenCampaignDetailMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.airgarden.AirGardenCampaignNodeMsg")]
      public var nodeList:Array = [];
      
      private var masterUserId$field:int;
      
      private var hasField$0:uint = 0;
      
      public function AirGardenCampaignDetailMsg()
      {
         super();
      }
      
      public function removeMasterUserId() : void
      {
         hasField$0 &= 4294967294;
         masterUserId$field = new int();
      }
      
      public function get hasMasterUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set masterUserId(param1:int) : void
      {
         hasField$0 |= 1;
         masterUserId$field = param1;
      }
      
      public function get masterUserId() : int
      {
         return masterUserId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < nodeList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeList[_loc2_]);
            _loc2_++;
         }
         if(hasMasterUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,masterUserId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:AirGardenCampaignNodeMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new AirGardenCampaignNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  nodeList.push(_loc3_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignDetailMsg.masterUserId cannot be set twice.");
                  }
                  _loc5_++;
                  masterUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

