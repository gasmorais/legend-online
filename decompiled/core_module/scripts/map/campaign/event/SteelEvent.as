package map.campaign.event
{
   import flash.events.Event;
   
   public class SteelEvent extends Event
   {
      
      public static const STEEL_INFO_CHANGE:String = "STEEL_INFO_CHANGE";
      
      public static const STEEL_CAMPAIGN_INFO_CHANGE:String = "STEEL_CAMPAIGN_INFO_CHANGE";
      
      public static const STEEL_USER_LIST_CHANGE:String = "STEEL_USER_LIST_CHANGE";
      
      public static const STEEL_FINAL_ORDER_LIST_CHANGE:String = "STEEL_FINAL_ORDER_LIST_CHANGE";
      
      public static const STEEL_TEAM_LIST_CHANGE:String = "STEEL_TEAM_LIST_CHANGE";
      
      public static const STEEL_APPLY_LIST_CHANGE:String = "STEEL_APPLY_LIST_CHANGE";
      
      public static const STEEL_AUDIT_LIST_CHANGE:String = "STEEL_AUDIT_LIST_CHANGE";
      
      public static const STEEL_RANK_DETAIL_LIST_CHANGE:String = "STEEL_RANK_DETAIL_LIST_CHANGE";
      
      public static const STEEL_SELECT_USER_ITEM:String = "STEEL_SELECT_USER_ITEM";
      
      public static const UPDE_RECRUIT_SEARCH_PAGE:String = "UPDE_RECRUIT_SEARCH_PAGE";
      
      public static const APPLY_PLAYER_ITEM_CLICK:String = "APPLY_PLAYER_ITEM_CLICK";
      
      public var data:Object;
      
      public function SteelEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

