package events
{
   import flash.events.Event;
   
   public class SevenYearEvent extends Event
   {
      
      public static const UPDATE_ACTIVE_INFO:String = "UPDATE_ACTIVE_INFO";
      
      public static const UPDATE_USER_INFO:String = "UPDATE_USER_INFO";
      
      public static const UPDATE_ORDER_INFO:String = "UPDATE_ORDER_INFO";
      
      public static const UPDATE_QUESTION_INFO:String = "UPDATE_QUESTION_INFO";
      
      public static const UPDATE_TREASUREBOX_INFO:String = "UPDATE_TREASUREBOX_INFO";
      
      public static const BUY_NUM_CHANGE:String = "BUY_NUM_CHANGE";
      
      public static const UPDATE_TREASUREBOX_LIST:String = "UPDATE_TREASUREBOX_LIST";
      
      public static const UPDATE_SNOW_TEAM_COUNT:String = "UPDATE_SNOW_TEAM_COUNT";
      
      public var data:Object;
      
      public function SevenYearEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

