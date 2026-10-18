package events
{
   import flash.events.Event;
   
   public class EclipticPalaceEvent extends Event
   {
      
      public static const SELECT_PATH:String = "SELECT_PATH";
      
      public static const ECLIPTIC_PALACE_INFO_CHANGE:String = "ECLIPTIC_PALACE_INFO_CHANGE";
      
      public static const REWARD_GOODS_BACK:String = "REWARD_GOODS_BACK";
      
      public var data:Object;
      
      public function EclipticPalaceEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

