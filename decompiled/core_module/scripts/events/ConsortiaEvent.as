package events
{
   import flash.events.Event;
   
   public class ConsortiaEvent extends Event
   {
      
      public static const UPDE_ALTAR_SIZE:String = "UPDE_ALTAR_SIZE";
      
      public static const IS_CONSORTIA_EXIST:String = "IS_CONSORTIA_EXIST";
      
      public static const ON_BLESS_COMPLETE:String = "ON_BLESS_COMPLETE";
      
      public static const ON_TEMPLETEID_UPDATA:String = "ON_TEMPLETEID_UPDATA";
      
      public static const UPDE_MEMEBER_STATE:String = "UPDE_MEMEBER_STATE";
      
      public static const UPDE_CONSORTIA_SEARCH_PAGE:String = "UPDE_CONSORTIA_SEARCH_PAGE";
      
      public static const UPDE_CONTRIBUTION_SEARCH_PAGE:String = "UPDE_CONTRIBUTION_SEARCH_PAGE";
      
      public static const UPDE_RECRUIT_SEARCH_PAGE:String = "UPDE_RECRUIT_SEARCH_PAGE";
      
      public static const UPDE_SHOP_SEARCH_PAGE:String = "UPDE_SHOP_SEARCH_PAGE";
      
      public static const UPDE_SHOP_GOODS_LIST:String = "UPDE_SHOP_GOODS_LIST";
      
      public static const UPDE_ALTAR_GOODS:String = "UPDE_ALTAR_GOODS";
      
      public static const UPDA_COOLDOWN_TIME:String = "UPDA_COOLDOWN_TIME";
      
      public static const UPDA_CONSORTIA_LIST:String = "UPDA_CONSORTIA_LIST";
      
      public static const UPDA_CONSORTIA_EVENT_LIST:String = "UPDA_CONSORTIA_EVENT_LIST";
      
      public static const UPDA_RECORD_LIST:String = "UPDA_RECORD_LIST";
      
      public static const UPDA_ALTAR_BLESS_INFO:String = "UPDA_ALTAR_BLESS_INFO";
      
      public static const UPDA_ALTAR_BLESS:String = "UPDA_ALTAR_BLESS";
      
      public static const UPDA_CONSORTIA_INFO:String = "UPDA_CONSORTIA_INFO";
      
      public static const GET_CONSORTIA_INFO:String = "GET_CONSORTIA_INFO";
      
      public static const UPDA_APPLY_CONSORTIA_INFO:String = "UPDA_APPLY_CONSORTIA_INFO";
      
      public static const UPDA_CONSORTIA_CONTRIBUTE_INFO:String = "UPDA_CONSORTIA_CONTRIBUTE_INFO";
      
      public static const UPDA_CONSORTIA_RIGHTS:String = "UPDA_CONSORTIA_RIGHTS";
      
      public static const UPDA_CONSORTIA_SKILL_LIST:String = "UPDA_CONSORTIA_SKILL_LIST";
      
      public static const UPDA_ALTAR_BLESS_LEFT_TIME:String = "UPDA_ALTAR_BLESS_LEFT_TIME";
      
      public static const UPDATA_CONSORTIA_MEMBER:String = "UPDATA_CONSORTIA_MEMBER";
      
      public static const UPDA_CONSORTIA_CHAIRMAN:String = "UPDA_CONSORTIA_CHAIRMAN";
      
      public static const CONSORTIA_UPGRADE:String = "CONSORTIA_UPGRADE";
      
      public static const CONSORTIA_ITEM_CLICK:String = "CONSORTIA_ITEM_CLICK";
      
      public static const APPLY_PLAYER_ITEM_CLICK:String = "APPLY_PLAYER_ITEM_CLICK";
      
      public static const GET_ALTAR_GOODS:String = "GET_ALTAR_GOODS";
      
      public static const APPLY_CONSORTIA_SUCCESS:String = "APPLY_CONSORTIA_SUCCESS";
      
      public static const APPLY_CONSORTIA_RECEIVE:String = "APPLY_CONSORTIA_RECEIVE";
      
      public static const SHOW_MEMBER_LIST:String = "SHOW_MEMBER_LIST";
      
      public static const ON_CONSORTIA_CONTRIBUTE_SUCCEED:String = "ON_CONSORTIA_CONTRIBUTE_SUCCEED";
      
      public static const CONSORTIA_STUDY:String = "CONSORTIA_STUDY";
      
      public static const CONSORTIA_STUDY_UPGRADE:String = "CONSORTIA_STUDY_UPGRADE";
      
      public static const RECRUITNUM_CHANGED:String = "recruitnum_changed";
      
      public static const UPDATA_CONSORTIAEMAIL_MEMBERLIST:String = "UPDATA_CONSORTIAEMAIL_MEMBERLIST";
      
      public static const MEMBERLIST_SELECTED_CHANGE:String = "MEMBERLIST_SELECTED_CHANGE";
      
      public static const CONSORTIA_OFFER_CHANGE:String = "CONSORTIA_OFFER_CHANGE";
      
      public static const CONSORTIA_VOTINGLIST_CHANGE:String = "CONSORTIA_VOTINGLIST_CHANGE";
      
      public static const SECRET_UPDATE:String = "SECRET_UPDATE";
      
      public static const TREE_STATE_UPDATE:String = "TREE_STATE_UPDATE";
      
      public static const PICK_TIME_UPDATE:String = "PICK_TIME_UPDATE";
      
      public static const DEMON_SWITCH:String = "DEMON_SWITCH";
      
      public static const PRIZE_LIST_UPDATE:String = "PRIZE_LIST_UPDATE";
      
      public static const PRIZE_LIST_COUNT_UPDATE:String = "PRIZE_LIST_COUNT_UPDATE";
      
      public static const PRIZE_MEMBER_LIST_UPDATE:String = "PRIZE_MEMBER_LIST_UPDATE";
      
      public static const REFRESH_CONSORTIA_NAME:String = "REFRESH_CONSORTIA_NAME";
      
      public static const CROSSGUILDOPEN:String = "CROSSGUILDOPEN";
      
      public static const CONSORTIA_BOSS_BUFFERIDS:String = "ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS";
      
      public static const CONSORTIAICONSTATECHANGE:String = "CONSORTIAICONSTATECHANGE";
      
      public static const OPEN_TREASURES:String = "OPEN_TREASURES";
      
      public static const OPEN_MY_TREASURES:String = "OPEN_MY_TREASURES";
      
      public static const OPEN_OTHERS_TREASURES:String = "OPEN_OTHERS_TREASURES";
      
      public static const REFRESH:String = "REFRESH";
      
      public static const OPEN_TREASURE:String = "OPEN_TREASURE";
      
      public static const HELP_OPEN_TREASURE:String = "HELP_OPEN_TREASURE";
      
      public static const GET_REWARD:String = "GET_REWARD";
      
      public static const SPEED_UP:String = "SPEED_UP";
      
      public static const REQUEST_HELP:String = "REQUEST_HELP";
      
      public static const HELP_INFO:String = "HELP_INFO";
      
      public static const SECRET_SORT_UPDATE:String = "SECRET_SORT_UPDATE";
      
      public static const OPEN_EMEDREAM_REWARD_FRAME:String = "OPEN_EMEDREAM_REWARD_FRAME";
      
      public static const SKILL_ICON_SELECT:String = "SKILL_ICON_SELECT";
      
      public static const UPDATE_QUEST_INFO:String = "UPDATE_QUEST_INFO";
      
      public static const UPDATE_BUSINESS_INFO:String = "UPDATE_BUSINESS_INFO";
      
      public var data:Object;
      
      public function ConsortiaEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         data = param2;
      }
   }
}

