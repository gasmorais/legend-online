package events
{
   import flash.events.Event;
   
   public class RapidInfoEvent extends Event
   {
      
      public static const RAPID_UPDATE:String = "rapid_update";
      
      public static const RAPID_PASS_UPDATE:String = "rapid_pass_update";
      
      public static const RAPID_COLLECT_COMPLETE:String = "rapid_collect_complete";
      
      public static const RAPID_RANK_UPDATE:String = "rapid_rank_update";
      
      public var data:Object;
      
      public function RapidInfoEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

