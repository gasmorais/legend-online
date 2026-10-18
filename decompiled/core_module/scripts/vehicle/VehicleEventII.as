package vehicle
{
   import flash.events.Event;
   
   public class VehicleEventII extends Event
   {
      
      public static const SINGLE_START:String = "SINGLE_START";
      
      public static const SINGLE_CANCLE:String = "SINGLE_CANCLE";
      
      public var data:Object;
      
      public function VehicleEventII(param1:String = "", param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

