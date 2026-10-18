package events
{
   import flash.events.Event;
   
   public class NewYearLotteryEvent extends Event
   {
      
      public static const LOTTERY_EFFCT_COMPLETE:String = "LOTTERY_EFFCT_COMPLETE";
      
      public static const LOTTERY_INFO:String = "LOTTERY_INFO";
      
      public var data:Object;
      
      public function NewYearLotteryEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1);
      }
   }
}

