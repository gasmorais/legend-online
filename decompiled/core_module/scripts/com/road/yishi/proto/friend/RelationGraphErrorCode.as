package com.road.yishi.proto.friend
{
   public final class RelationGraphErrorCode
   {
      
      public static const NONE:int = 0;
      
      public static const ERROR_PARAM_OP_NONE:int = 1;
      
      public static const ERROR_PARAM_UUID_EQUAL_SELF:int = 2;
      
      public static const ERROR_USER_NONE:int = 3;
      
      public static const ERROR_USER_OFFLINE:int = 4;
      
      public static const ERROR_FOLLOWING_FOLLOWED:int = 5;
      
      public static const ERROR_FOLLOWING_NUM_LIMIT:int = 6;
      
      public static const ERROR_CHAT_CHANNEL_NONE:int = 7;
      
      public static const ERROR_CHAT_CHANNEL_MISMATCHING:int = 8;
      
      public static const ERROR_CHAT_MESSAGE_NONE:int = 9;
      
      public static const ERROR_CHAT_MESSAGE_FREQUENCY_LIMIT:int = 10;
      
      public function RelationGraphErrorCode()
      {
         super();
      }
   }
}

