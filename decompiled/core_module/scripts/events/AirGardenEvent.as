package events
{
   import flash.events.Event;
   
   public class AirGardenEvent extends Event
   {
      
      public static const AIRGARDEN_STATE_CHANGE:String = "AIRGARDEN_STATE_CHANGE";
      
      public static const PARTY_LIST_UPDATE:String = "PARTY_LIST_UPDATE";
      
      public static const SELF_INFO_UPDATE:String = "SELF_INFO_UPDATE";
      
      public static const CAMPAIGN_INFO_UPDATE:String = "CAMPAIGN_INFO_UPDATE";
      
      public static const CAMPAIGN_DETAIL_UPDATE:String = "CAMPAIGN_DETAIL_UPDATE";
      
      public var data:Object;
      
      public function AirGardenEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

