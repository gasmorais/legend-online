package com.road.yishi.proto.powcard
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PowCardBufListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.powcard.PowCardBufMsg")]
      public var bufInfos:Array = [];
      
      public function PowCardBufListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < bufInfos.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,bufInfos[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:PowCardBufMsg = null;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new PowCardBufMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  bufInfos.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

