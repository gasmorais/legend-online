package events
{
   import flash.events.Event;
   
   public class CustomerServiceEvent extends Event
   {
      
      public static const UPLOAD_SUCCESS:String = "UPLOAD_SUCCESS";
      
      public function CustomerServiceEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

