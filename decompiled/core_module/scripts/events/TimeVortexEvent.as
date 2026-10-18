package events
{
   import flash.events.Event;
   
   public class TimeVortexEvent extends Event
   {
      
      public static const LAIRD_INFO_CHANGE:String = "LAIRD_INFO_CHANGE";
      
      public static const CRACK_INFO_CHANGE:String = "CRACK_INFO_CHANGE";
      
      public static const CRACK_TEAM_INFO_CHANGE:String = "CRACK_TEAM_INFO_CHANGE";
      
      public static const SINGLE_LAIRD_INFO_CHANGE:String = "SINGLE_LAIRD_INFO_CHANGE";
      
      public static const SELECTED_LAND_CHANGE:String = "SELECTED_LAND_CHANGE";
      
      public static const SELECTED_CHAPTER_CHANGE:String = "SELECTED_CHAPTER_CHANGE";
      
      public static const SELECTED_AREA_CHANGE:String = "SELECTED_AREA_CHANGE";
      
      public static const SELECTED_CAMPAIGN_CHANGE:String = "SELECTED_CAMPAIGN_CHANGE";
      
      public static const VIEW_CONTENT_LOADED:String = "VIEW_CONTENT_LOADED";
      
      public static const UPDATE_MAIN_FRAME_STATE:String = "UPDATE_MAIN_FRAME_STATE";
      
      public static const UPDATE_CRACK_FRAME_STATE:String = "UPDATE_CRACK_FRAME_STATE";
      
      public static const DRAGON_OPEN_INFO:String = "DRAGON_OPEN_INFO";
      
      public static const RECEIVE_WAIT_INFO:String = "RECEIVE_WAIT_INFO";
      
      public var data:Object;
      
      public function TimeVortexEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

