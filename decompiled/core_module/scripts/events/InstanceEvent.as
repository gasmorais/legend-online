package events
{
   import flash.events.Event;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import yishi.datas.templates.CampaignTemplate;
   
   public class InstanceEvent extends Event
   {
      
      public static const SELECT_INSTANCE:String = "select_instance";
      
      public static const CONFIRM_INSTANCE:String = "confirm_instance";
      
      public static const CLOSE_INSTANCE_FRAME:String = "close_instance_frame";
      
      public static const DONT_SELECT_INSTANCE:String = "dont_select_instance";
      
      public var selectedAreaInfo:CampaignAreaInfo;
      
      public var selectedMapInfo:CampaignTemplate;
      
      public function InstanceEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

