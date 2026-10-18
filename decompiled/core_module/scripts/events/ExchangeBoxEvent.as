package events
{
   import flash.events.Event;
   
   public class ExchangeBoxEvent extends Event
   {
      
      public static const EXCHANGE_BUY_BACK:String = "EXCHANGE_BUY_BACK";
      
      public static const EXCHANGE_HOT_UPDATE:String = "EXCHANGE_HOT_UPDATE";
      
      public static const EXCHANGE_DROP_UPDATE:String = "EXCHANGE_DROP_UPDATE";
      
      public var data:Object;
      
      public function ExchangeBoxEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

