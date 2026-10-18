package com.road.yishi.proto.blackjack
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BlackJackListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.blackjack.BlackJackMsg")]
      public var blackJack:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.blackjack.BlackJackExchangeMsg")]
      public var blackJackExchange:Array = [];
      
      public function BlackJackListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < blackJack.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,blackJack[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < blackJackExchange.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,blackJackExchange[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:BlackJackMsg = null;
         var _loc3_:BlackJackExchangeMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc5_ = new BlackJackMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  blackJack.push(_loc5_);
                  break;
               case 1:
                  _loc3_ = new BlackJackExchangeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  blackJackExchange.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

