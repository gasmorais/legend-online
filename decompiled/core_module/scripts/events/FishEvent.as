package events
{
   import flash.events.Event;
   
   public class FishEvent extends Event
   {
      
      public static const UPDATE_FISH_POOL:String = "UPDATE_FISH_POOL";
      
      public static const CREAT_FISH_INFO:String = "CREAT_FISH_INFO";
      
      public static const UPDATE_FISH_INFO:String = "UPDATE_FISH_INFO";
      
      public static const UPDATE_CHECK_INFO:String = "UPDATE_CHECK_INFO";
      
      public static const ORDERDATA_LOAD_COMPLETE:String = "ORDERDATA_LOAD_COMPLETE";
      
      public static const FISH_SIG:String = "FISH_SIG";
      
      public static const FISH_RAGE:String = "FISH_RAGE";
      
      public static const TIME_OVER:String = "TIME_OVER";
      
      public static const HELP_OVER:String = "HELP_OVER";
      
      public static const POINT_HELP:String = "POINT_HELP";
      
      public function FishEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

