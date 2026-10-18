package com.road.yishi.proto.pet
{
   public final class TableState
   {
      
      public static const NEW:int = 0;
      
      public static const PRE_FLOP:int = 1;
      
      public static const FLOP:int = 2;
      
      public static const TURN:int = 3;
      
      public static const RIVER:int = 4;
      
      public static const SHOW_DOWN:int = 5;
      
      public static const ENDED:int = 6;
      
      public function TableState()
      {
         super();
      }
   }
}

