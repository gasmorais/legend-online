package yishi.events
{
   import flash.events.Event;
   
   public class PlayerBufferEvent extends Event
   {
      
      public static const CAMPAIGN_BUFFER_UPDATE:String = "CAMPAIGN_BUFFER_UPDATE";
      
      public static const ITEM_BUFFER_UPDATE:String = "ITEM_BUFFER_UPDATE";
      
      public function PlayerBufferEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

