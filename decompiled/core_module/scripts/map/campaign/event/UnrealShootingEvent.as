package map.campaign.event
{
   import flash.events.Event;
   
   public class UnrealShootingEvent extends Event
   {
      
      public static const UNREAL_SHOOTING_ACTIVE_STATE_CHANGE:String = "UNREAL_SHOOTING_ACTIVE_STATE_CHANGE";
      
      public static const UNREAL_SHOOTING_INFO_CHANGE:String = "UNREAL_SHOOTING_INFO_CHANGE";
      
      public static const UNREAL_SHOOTING_TEMPLATE_ID_CHANGE:String = "UNREAL_SHOOTING_TEMPLATE_ID_CHANGE";
      
      public static const UNREAL_SHOOTING_PLAYER_LIST_CHANGE:String = "UNREAL_SHOOTING_PLAYER_LIST_CHANGE";
      
      public static const UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE:String = "UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE";
      
      public static const UNREAL_SHOOTING_FINAL_ORDER_LIST_CHANGE:String = "UNREAL_SHOOTING_FINAL_ORDER_LIST_CHANGE";
      
      public var data:Object;
      
      public function UnrealShootingEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

