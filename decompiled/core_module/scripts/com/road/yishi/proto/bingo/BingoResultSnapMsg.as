package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoResultSnapMsg extends Message implements IExternalizable
   {
      
      private var event_date$field:String;
      
      private var tatal_pond$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.bingo.BingoRankPlayerMsg")]
      public var lotteryPlayer:Array = [];
      
      public var time:Number;
      
      public var realIdx:int = 0;
      
      public function BingoResultSnapMsg()
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
      
      public function removeTatalPond() : void
      {
         hasField$0 &= 4294967294;
         tatal_pond$field = new int();
      }
      
      public function get hasTatalPond() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tatalPond(param1:int) : void
      {
         hasField$0 |= 1;
         tatal_pond$field = param1;
      }
      
      public function get tatalPond() : int
      {
         return tatal_pond$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasEventDate)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,event_date$field);
         }
         if(hasTatalPond)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tatal_pond$field);
         }
         _loc2_ = 0;
         while(_loc2_ < lotteryPlayer.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,lotteryPlayer[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:BingoRankPlayerMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BingoResultSnapMsg.eventDate cannot be set twice.");
                  }
                  _loc4_++;
                  eventDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BingoResultSnapMsg.tatalPond cannot be set twice.");
                  }
                  _loc5_++;
                  tatalPond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new BingoRankPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  lotteryPlayer.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

