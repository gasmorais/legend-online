package events
{
   import flash.events.Event;
   
   public class ChildesalEvent extends Event
   {
      
      public static const CHILDSEAL_INFO_UP_DATA:String = "CHILDSEAL_INFO_UP_DATA";
      
      public var data:*;
      
      public function ChildesalEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

