package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SevenYearOrderListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.SevenYearOrderMsg")]
      public var orders:Array = [];
      
      private var orderDate$field:String;
      
      public function SevenYearOrderListMsg()
      {
         super();
      }
      
      public function removeOrderDate() : void
      {
         orderDate$field = null;
      }
      
      public function get hasOrderDate() : Boolean
      {
         return orderDate$field != null;
      }
      
      public function set orderDate(param1:String) : void
      {
         orderDate$field = param1;
      }
      
      public function get orderDate() : String
      {
         return orderDate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < orders.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,orders[_loc2_]);
            _loc2_++;
         }
         if(hasOrderDate)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,orderDate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:SevenYearOrderMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc5_ = new SevenYearOrderMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  orders.push(_loc5_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearOrderListMsg.orderDate cannot be set twice.");
                  }
                  _loc3_++;
                  orderDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

