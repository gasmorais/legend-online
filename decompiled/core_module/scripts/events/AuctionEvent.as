package events
{
   import flash.events.Event;
   
   public class AuctionEvent extends Event
   {
      
      public static var REFRESH_FORSELL:String = "REFRESH_FORSELL";
      
      public static var REFRESH_RECORD:String = "REFRESH_RECORD";
      
      public function AuctionEvent(param1:String)
      {
         super(param1);
      }
   }
}

