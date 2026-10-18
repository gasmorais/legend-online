package events
{
   import flash.events.Event;
   
   public class LotteryEvent extends Event
   {
      
      public static const LOTTERY_EFFCT_COMPLETE:String = "lottery_effct_complete";
      
      public static const LOTTERY_INFO:String = "LOTTERY_INFO";
      
      public static const LOTTERY_STATE:String = "LOTTERY_STATE";
      
      public static const UPDATE_SHOW_INFO:String = "UPDATE_SHOW_INFO";
      
      public static const DROP_LIST:String = "DROP_LIST";
      
      public static const LOTTERY_RESULT:String = "LOTTERY_RESULT";
      
      public var data:Object;
      
      public function LotteryEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1);
      }
   }
}

