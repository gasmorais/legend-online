package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SyncRoomBossHPMsg extends Message implements IExternalizable
   {
      
      private var room_boss_info_list$field:RoomBossInfoListMsg;
      
      [ArrayElementType("com.road.yishi.proto.simple.WoundInfoMsg")]
      public var castleWound:Array = [];
      
      public function SyncRoomBossHPMsg()
      {
         super();
      }
      
      public function removeRoomBossInfoList() : void
      {
         room_boss_info_list$field = null;
      }
      
      public function get hasRoomBossInfoList() : Boolean
      {
         return room_boss_info_list$field != null;
      }
      
      public function set roomBossInfoList(param1:RoomBossInfoListMsg) : void
      {
         room_boss_info_list$field = param1;
      }
      
      public function get roomBossInfoList() : RoomBossInfoListMsg
      {
         return room_boss_info_list$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasRoomBossInfoList)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,room_boss_info_list$field);
         }
         _loc2_ = 0;
         while(_loc2_ < castleWound.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,castleWound[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:WoundInfoMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SyncRoomBossHPMsg.roomBossInfoList cannot be set twice.");
                  }
                  _loc5_++;
                  roomBossInfoList = new RoomBossInfoListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,roomBossInfoList);
                  break;
               case 1:
                  _loc4_ = new WoundInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  castleWound.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

