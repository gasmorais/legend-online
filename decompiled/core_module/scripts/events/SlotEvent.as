package events
{
   import flash.events.Event;
   
   public class SlotEvent extends Event
   {
      
      public static const SLOTINFO:String = "SLOTINFO";
      
      public static const SLOTSATECHANGE:String = "SLOTSATECHANGE";
      
      public function SlotEvent(param1:String)
      {
         super(param1);
      }
   }
}

