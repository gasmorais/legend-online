package events
{
   import flash.events.Event;
   
   public class MonopolyEvent extends Event
   {
      
      public static const MONOPOLY_INFO_CHANGE:String = "MONOPOLY_INFO_CHANGE";
      
      public var data:Object;
      
      public function MonopolyEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

