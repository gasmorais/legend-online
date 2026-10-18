package events
{
   import flash.events.Event;
   
   public class EncoGoldEvents extends Event
   {
      
      public static const ENCO_GOLD_INFO_UP_DATA:String = "ENCO_GOLD_INFO_UP_DATA";
      
      public static const ENCO_GOLD_OPENSTATE_UPDTAE:String = "ENCO_GOLD_OPENSTATE_UPDTAE";
      
      public function EncoGoldEvents(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

