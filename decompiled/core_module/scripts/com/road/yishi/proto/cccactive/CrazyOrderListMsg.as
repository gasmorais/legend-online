package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrazyOrderListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.cccactive.CrazyOrderInfoMsg")]
      public var orderInfo:Array = [];
      
      private var rankType$field:int;
      
      private var hasField$0:uint = 0;
      
      public function CrazyOrderListMsg()
      {
         super();
      }
      
      public function removeRankType() : void
      {
         hasField$0 &= 4294967294;
         rankType$field = new int();
      }
      
      public function get hasRankType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rankType(param1:int) : void
      {
         hasField$0 |= 1;
         rankType$field = param1;
      }
      
      public function get rankType() : int
      {
         return rankType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < orderInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,orderInfo[_loc2_]);
            _loc2_++;
         }
         if(hasRankType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rankType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:CrazyOrderInfoMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new CrazyOrderInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  orderInfo.push(_loc3_);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrazyOrderListMsg.rankType cannot be set twice.");
                  }
                  _loc4_++;
                  rankType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

