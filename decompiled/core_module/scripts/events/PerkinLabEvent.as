package events
{
   import flash.events.Event;
   
   public class PerkinLabEvent extends Event
   {
      
      public static const UPDATE_SELF_LIST:String = "UPDATE_SELF_LIST";
      
      public static const UPDATE_ROB_LIST:String = "UPDATE_ROB_LIST";
      
      public static const UPDATE_LOG_LIST:String = "UPDATE_LOG_LIST";
      
      public static const UPDATE_FRAME_STATE:String = "UPDATE_FRAME_STATE";
      
      public static const PERKINLAB_TASK_MOVIE:String = "PERKINLAB_TASK_MOVIE";
      
      public var data:Object;
      
      public function PerkinLabEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

