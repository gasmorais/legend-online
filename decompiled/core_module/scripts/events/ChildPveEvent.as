package events
{
   import flash.events.Event;
   
   public class ChildPveEvent extends Event
   {
      
      public static const ORDERDATA_LOAD_COMPLETE:String = "ORDERDATA_LOAD_COMPLETE";
      
      public static const UPDATEORDER:String = "UPDATEORDER";
      
      public var data:Object;
      
      public function ChildPveEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

