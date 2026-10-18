package events
{
   import flash.events.Event;
   
   public class RedemptionRoadEvent extends Event
   {
      
      public static const DIFF_CHANGE:String = "DIFF_CHANGE";
      
      public static const USER_INFO_CHANGE:String = "USER_INFO_CHANGE";
      
      public static const TEMP_INFO_CHANGE:String = "TEMP_INFO_CHANGE";
      
      public static const NODE_POS_SELECT:String = "NODE_POS_SELECT";
      
      public var data:Object;
      
      public function RedemptionRoadEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

