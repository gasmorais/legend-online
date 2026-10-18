package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoInfoDataMsg extends Message implements IExternalizable
   {
      
      private var current_data$field:BingoInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.bingo.BingoInfoMsg")]
      public var historyData:Array = [];
      
      public function BingoInfoDataMsg()
      {
         super();
      }
      
      public function removeCurrentData() : void
      {
         current_data$field = null;
      }
      
      public function get hasCurrentData() : Boolean
      {
         return current_data$field != null;
      }
      
      public function set currentData(param1:BingoInfoMsg) : void
      {
         current_data$field = param1;
      }
      
      public function get currentData() : BingoInfoMsg
      {
         return current_data$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCurrentData)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,current_data$field);
         }
         _loc2_ = 0;
         while(_loc2_ < historyData.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,historyData[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:BingoInfoMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BingoInfoDataMsg.currentData cannot be set twice.");
                  }
                  _loc3_++;
                  currentData = new BingoInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,currentData);
                  break;
               case 1:
                  _loc4_ = new BingoInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  historyData.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

