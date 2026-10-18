package events
{
   import flash.events.Event;
   
   public class ApexEvent extends Event
   {
      
      public static const REFRESH_APEX_STATE:String = "REFRESH_APEX_STATE";
      
      public static const REFRESH_MAIN_VIEW:String = "REFRESH_MAIN_VIEW";
      
      public static const REFRESH_BATTLE_STATE:String = "REFRESH_BATTLE_STATE";
      
      public static const REFRESH_GUESS_STATE:String = "REFRESH_GUESS_STATE";
      
      public static const REFRESH_SPACE_AVATAR:String = "REFRESH_SPACE_AVATAR";
      
      public static const REFRESH_APEX_BATTLE_RANK:String = "REFRESH_APEX_BATTLE_RANK";
      
      public static const REFRESH_APEX_TERM_DATA:String = "REFRESH_APEX_TERM_DATA";
      
      public var data:*;
      
      public function ApexEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

