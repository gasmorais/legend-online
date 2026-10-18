package mvc.module.treasurehunt
{
   import flash.events.Event;
   
   public class HuntEvent extends Event
   {
      
      public static const HUNT_TEM:String = "HUNT_TEM";
      
      public static const INFO_SHOW:String = "INFO_SHOW";
      
      public var data:Object;
      
      public function HuntEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

