package com.road.yishi.proto.bingo
{
   public final class BingOpState
   {
      
      public static const SYNC_DATA:int = 0;
      
      public static const REQUEST_BUY:int = 1;
      
      public static const RESPONSE_BUY:int = 2;
      
      public static const CONFIRM_BUY:int = 3;
      
      public static const LOTTERY_NOTITY:int = 4;
      
      public static const REWARD:int = 5;
      
      public static const UPDATE_DATA:int = 6;
      
      public static const MESSAGE_FORWARD:int = 7;
      
      public function BingOpState()
      {
         super();
      }
   }
}

