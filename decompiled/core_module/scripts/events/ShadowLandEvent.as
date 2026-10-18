package events
{
   import flash.events.Event;
   
   public class ShadowLandEvent extends Event
   {
      
      public static const SHADOWLAND_INFO_UPDATE:String = "SHADOWLAND_INFO_UPDATE";
      
      public var data:Object;
      
      public function ShadowLandEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

