package com.road.yishi.proto.friend
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RecommendListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.friend.FriendPlayer")]
      public var girlList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.friend.FriendPlayer")]
      public var boyList:Array = [];
      
      public function RecommendListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < girlList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,girlList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < boyList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,boyList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:FriendPlayer = null;
         var _loc3_:FriendPlayer = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new FriendPlayer();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  girlList.push(_loc4_);
                  break;
               case 1:
                  _loc3_ = new FriendPlayer();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  boyList.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

