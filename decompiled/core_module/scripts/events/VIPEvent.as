package events
{
   import flash.events.Event;
   
   public class VIPEvent extends Event
   {
      
      public static const UPFRAMEVIEW_CHANGE:String = "upframeview_change";
      
      public static const VIP_EFFCT_COMPLETE:String = "vipeffctcomplete";
      
      public static const VIP_UPROULETTE_INFO:String = "vip_uprolette_info";
      
      public static const VIP_RECHARGE_TIP:String = "vip_recharge_tip";
      
      public static const VIP_OPEN_BOX:String = "vip_open_box";
      
      public static const VIPSHOP_LEVELINFO:String = "vipshop_levelinfo";
      
      public var data:Object;
      
      public function VIPEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1);
      }
   }
}

