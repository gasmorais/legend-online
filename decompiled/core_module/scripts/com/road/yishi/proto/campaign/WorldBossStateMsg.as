package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossStateMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.campaign.WorldBossInfoStateMsg")]
      public var worldBossInfo:Array = [];
      
      public function WorldBossStateMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < worldBossInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,worldBossInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:WorldBossInfoStateMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new WorldBossInfoStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  worldBossInfo.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

