package events
{
   import flash.events.Event;
   
   public class SinglePassEvent extends Event
   {
      
      public static const SINGLEPASS_INFO_UPDATE:String = "SINGLEPASS_INFO_UPDATE";
      
      public static const ORDERDATA_LOAD_COMPLETE:String = "ORDERDATA_LOAD_COMPLETE";
      
      public static const UPDATE_BUGLE_INFO:String = "UPDATE_BUGLE_INFO";
      
      public static const UPDATE_BUGLE_REWARDS:String = "UPDATE_BUGLE_REWARDS";
      
      public var data:Object;
      
      public function SinglePassEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

