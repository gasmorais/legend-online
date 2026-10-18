package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoInfoMsg extends Message implements IExternalizable
   {
      
      private var event_data$field:String;
      
      [ArrayElementType("com.road.yishi.proto.bingo.BingoCardTempMsg")]
      public var cardTemp:Array = [];
      
      private var result_data$field:BingoResultDataMsg;
      
      private var result_snap$field:BingoResultSnapMsg;
      
      public function BingoInfoMsg()
      {
         super();
      }
      
      public function removeEventData() : void
      {
         event_data$field = null;
      }
      
      public function get hasEventData() : Boolean
      {
         return event_data$field != null;
      }
      
      public function set eventData(param1:String) : void
      {
         event_data$field = param1;
      }
      
      public function get eventData() : String
      {
         return event_data$field;
      }
      
      public function removeResultData() : void
      {
         result_data$field = null;
      }
      
      public function get hasResultData() : Boolean
      {
         return result_data$field != null;
      }
      
      public function set resultData(param1:BingoResultDataMsg) : void
      {
         result_data$field = param1;
      }
      
      public function get resultData() : BingoResultDataMsg
      {
         return result_data$field;
      }
      
      public function removeResultSnap() : void
      {
         result_snap$field = null;
      }
      
      public function get hasResultSnap() : Boolean
      {
         return result_snap$field != null;
      }
      
      public function set resultSnap(param1:BingoResultSnapMsg) : void
      {
         result_snap$field = param1;
      }
      
      public function get resultSnap() : BingoResultSnapMsg
      {
         return result_snap$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasEventData)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,event_data$field);
         }
         _loc2_ = 0;
         while(_loc2_ < cardTemp.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,cardTemp[_loc2_]);
            _loc2_++;
         }
         if(hasResultData)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,result_data$field);
         }
         if(hasResultSnap)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,result_snap$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:BingoCardTempMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BingoInfoMsg.eventData cannot be set twice.");
                  }
                  _loc4_++;
                  eventData = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  _loc3_ = new BingoCardTempMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  cardTemp.push(_loc3_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BingoInfoMsg.resultData cannot be set twice.");
                  }
                  _loc5_++;
                  resultData = new BingoResultDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,resultData);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BingoInfoMsg.resultSnap cannot be set twice.");
                  }
                  _loc7_++;
                  resultSnap = new BingoResultSnapMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,resultSnap);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

