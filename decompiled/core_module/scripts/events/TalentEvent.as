package events
{
   import flash.events.Event;
   
   public class TalentEvent extends Event
   {
      
      public static const TALENT_UPGRADE:String = "TALENT_UPGRADE";
      
      public static const TALENT_GRADUP_SUCC:String = "TALENT_GRADUP_SUCC";
      
      public static const TALENT_RESET:String = "TALENT_RESET";
      
      public static const UPDATE_TALENT:String = "UPDATE_TALENT";
      
      public var data:*;
      
      public function TalentEvent(param1:String, param2:*)
      {
         super(param1,false,false);
         data = param2;
      }
   }
}

