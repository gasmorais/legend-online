package events
{
   import flash.events.Event;
   
   public class MopupEvent extends Event
   {
      
      public static const MOPUP_RESULT_LIST_REFRESH:String = "MOPUP_RESULT_LIST_REFRESH";
      
      public static const MOPUP_END:String = "MOPUP_END";
      
      public function MopupEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

