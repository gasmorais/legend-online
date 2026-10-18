package events
{
   import flash.events.Event;
   
   public class SelectCampaignEvent extends Event
   {
      
      public static const SELECTED_LAND_CHANGE:String = "SELECTED_LAND_CHANGE";
      
      public static const SELECTED_CHAPTER_CHANGE:String = "SELECTED_CHAPTER_CHANGE";
      
      public static const SELECTED_AREA_CHANGE:String = "SELECTED_AREA_CHANGE";
      
      public static const SELECTED_CAMPAIGN_CHANGE:String = "SELECTED_CAMPAIGN_CHANGE";
      
      public static const VIEW_CONTENT_LOADED:String = "VIEW_CONTENT_LOADED";
      
      public var data:Object;
      
      public function SelectCampaignEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

