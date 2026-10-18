package map.campaign.event
{
   import flash.events.Event;
   
   public class SvsEvent extends Event
   {
      
      public static const SVS_INFO_CHANGE:String = "SVS_INFO_CHANGE";
      
      public static const SVS_CAMPAIGN_INFO_CHANGE:String = "SVS_CAMPAIGN_INFO_CHANGE";
      
      public static const SVS_USER_LIST_CHANGE:String = "SVS_USER_LIST_CHANGE";
      
      public static const SVS_USER_ONLINE_LIST_CHANGE:String = "SVS_USER_ONLINE_LIST_CHANGE";
      
      public static const SVS_FINAL_ORDER_LIST_CHANGE:String = "SVS_FINAL_ORDER_LIST_CHANGE";
      
      public static const SVS_SELECT_USER_ITEM:String = "SVS_SELECT_USER_ITEM";
      
      public var data:Object;
      
      public function SvsEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

