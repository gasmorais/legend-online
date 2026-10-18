package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HotItemMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.FMBaseItem")]
      public var fashion:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.FMBaseItem")]
      public var mount:Array = [];
      
      public function HotItemMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < fashion.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,fashion[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < mount.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,mount[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:FMBaseItem = null;
         var _loc3_:FMBaseItem = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new FMBaseItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  fashion.push(_loc4_);
                  break;
               case 1:
                  _loc3_ = new FMBaseItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  mount.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

