package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoLotteryNotifyMsg extends Message implements IExternalizable
   {
      
      private var called_num$field:int;
      
      private var hasField$0:uint = 0;
      
      private var luck_num$field:Boolean;
      
      private var data$field:BingoResultDataMsg;
      
      public function BingoLotteryNotifyMsg()
      {
         super();
      }
      
      public function removeCalledNum() : void
      {
         hasField$0 &= 4294967294;
         called_num$field = new int();
      }
      
      public function get hasCalledNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set calledNum(param1:int) : void
      {
         hasField$0 |= 1;
         called_num$field = param1;
      }
      
      public function get calledNum() : int
      {
         return called_num$field;
      }
      
      public function removeLuckNum() : void
      {
         hasField$0 &= 4294967293;
         luck_num$field = new Boolean();
      }
      
      public function get hasLuckNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set luckNum(param1:Boolean) : void
      {
         hasField$0 |= 2;
         luck_num$field = param1;
      }
      
      public function get luckNum() : Boolean
      {
         return luck_num$field;
      }
      
      public function removeData() : void
      {
         data$field = null;
      }
      
      public function get hasData() : Boolean
      {
         return data$field != null;
      }
      
      public function set data(param1:BingoResultDataMsg) : void
      {
         data$field = param1;
      }
      
      public function get data() : BingoResultDataMsg
      {
         return data$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCalledNum)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,called_num$field);
         }
         if(hasLuckNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,luck_num$field);
         }
         if(hasData)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,data$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BingoLotteryNotifyMsg.calledNum cannot be set twice.");
                  }
                  _loc3_++;
                  calledNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BingoLotteryNotifyMsg.luckNum cannot be set twice.");
                  }
                  _loc4_++;
                  luckNum = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BingoLotteryNotifyMsg.data cannot be set twice.");
                  }
                  _loc6_++;
                  data = new BingoResultDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,data);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

