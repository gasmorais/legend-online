package events
{
   import flash.events.Event;
   
   public class AppellEvent extends Event
   {
      
      public static const APPELL_DATA_UPDATA:String = "APPELL_DATA_UPDATA";
      
      public static const OPEN_ADDITION:String = "OPEN_ADDITION";
      
      public static const APPELL_LOAD_COMPLETE:String = "APPELL_LOAD_COMPLETE";
      
      public var data:Object;
      
      public function AppellEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         data = param2;
      }
   }
}

