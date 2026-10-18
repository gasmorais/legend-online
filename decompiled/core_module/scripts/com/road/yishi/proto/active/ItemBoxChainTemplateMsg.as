package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemBoxChainTemplateMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.ItemBoxChainIndexListMsg")]
      public var itemBoxChainIndexList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.ItemBoxChainMsg")]
      public var itemBoxChainMsg:Array = [];
      
      public function ItemBoxChainTemplateMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < itemBoxChainIndexList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,itemBoxChainIndexList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < itemBoxChainMsg.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,itemBoxChainMsg[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:ItemBoxChainIndexListMsg = null;
         var _loc4_:ItemBoxChainMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new ItemBoxChainIndexListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  itemBoxChainIndexList.push(_loc3_);
                  break;
               case 1:
                  _loc4_ = new ItemBoxChainMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  itemBoxChainMsg.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

