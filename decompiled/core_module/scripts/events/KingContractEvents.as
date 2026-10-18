package events
{
   import flash.events.Event;
   
   public class KingContractEvents extends Event
   {
      
      public static const UPDATE_KINGCONTRACT:String = "UPDATE_KINGCONTRACT";
      
      public var data:Object;
      
      public function KingContractEvents(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

