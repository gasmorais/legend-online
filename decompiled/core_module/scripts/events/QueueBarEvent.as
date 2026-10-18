package events
{
   import flash.events.Event;
   
   public class QueueBarEvent extends Event
   {
      
      public static const OFFER_REWARD_FRAME_CLOSE:String = "OFFER_REWARD_FRAME_CLOSE";
      
      public var data:Object;
      
      public function QueueBarEvent(param1:String, param2:Object)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

