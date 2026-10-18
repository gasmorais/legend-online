package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoResultDataMsg extends Message implements IExternalizable
   {
      
      private var event_date$field:String;
      
      [ArrayElementType("int")]
      public var lotteryNum:Array = [];
      
      [ArrayElementType("int")]
      public var luckNum:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.bingo.BingoRankDataMsg")]
      public var rankData:Array = [];
      
      public function BingoResultDataMsg()
      {
         super();
      }
      
      public function removeEventDate() : void
      {
         event_date$field = null;
      }
      
      public function get hasEventDate() : Boolean
      {
         return event_date$field != null;
      }
      
      public function set eventDate(param1:String) : void
      {
         event_date$field = param1;
      }
      
      public function get eventDate() : String
      {
         return event_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(hasEventDate)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,event_date$field);
         }
         _loc2_ = 0;
         while(_loc2_ < lotteryNum.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,lotteryNum[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < luckNum.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,luckNum[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < rankData.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,rankData[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:BingoRankDataMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BingoResultDataMsg.eventDate cannot be set twice.");
                  }
                  _loc3_++;
                  eventDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,lotteryNum);
                  }
                  else
                  {
                     lotteryNum.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,luckNum);
                  }
                  else
                  {
                     luckNum.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  _loc4_ = new BingoRankDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  rankData.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

