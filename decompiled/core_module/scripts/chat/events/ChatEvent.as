package chat.events
{
   import chat.datas.ChatData;
   import flash.events.Event;
   
   public class ChatEvent extends Event
   {
      
      public static const UPDATE_CHAT_VIEW:String = "UPDATE_CHAT_VIEW";
      
      public static const UPDATE_BIGBUGLE_VIEW:String = "UPDATE_BIGBUGLE_VIEW";
      
      public static const CHAT_FROM_CONSORTIA:String = "CHAT_FROM_CONSORTIA";
      
      public static const ADD_CHAT:String = "ADD_CHAT";
      
      public static const CHANNEL_CLICK:String = "CHANNEL_CLICK";
      
      public static const PLAYER_NAME_CLICK:String = "PLAYER_NAME_CLICK";
      
      public static const CONSORTIA_CLICK:String = "CONSORTIA_CLICK";
      
      public static const PROP_CLICK:String = "PROP_CLICK";
      
      public static const EQUIP_CLICK:String = "EQUIP_CLICK";
      
      public static const STAR_CLICK:String = "STAR_CLICK";
      
      public static const CARD_CLICK:String = "CARD_CLICK";
      
      public static const ROOM_CLICK:String = "ROOM_CLICK";
      
      public static const VIP_LINK_CLICK:String = "VIP_LINK_CLICK";
      
      public static const SHARE_SPACE_TIME_CLICK:String = "SHARE_SPACE_TIME_CLICK";
      
      public static const APPELL_LINK_CLICK:String = "APPELL_LINK_CLICK";
      
      public static const ROSE_BACK_CLICK:String = "ROSE_BACK_CLICK";
      
      public static const CARD_BACK_CLICK:String = "CARD_BACK_CLICK";
      
      public static const REINFORCE_CLICK:String = "REINFORCE_CLICK";
      
      public static const OUTPUT_CHANNEL_CHANGE:String = "OUTPUT_CHANNEL_CHANGE";
      
      public static const INPUT_CHANNEL_CHANGE:String = "INPUT_CHANNEL_CHANGE";
      
      public static const CHAT_NAME_CLICK:String = "CHAT_NAME_CLICK";
      
      public static const SEEK_LINK_CLICK:String = "SEEK_LINK_CLICK";
      
      public static const CHAT_REFESH_TO_VIEW:String = "CHAT_REFESH_TO_VIEW";
      
      public static const CLEAN_CHAT:String = "CLEAN_CHAT";
      
      public static const OUTPUT_TEXT_SCROLL:String = "OUTPUT_TEXT_SCROLL";
      
      public static const OUTPUT_SCROLL_SCROLL:String = "OUTPUT_SCROLL_SCROLL";
      
      public static const CHAT_LOCK_CHANGE:String = "CHAT_LOCK_CHANGE";
      
      public static const CHAT_LOCK_ENABLE_CHANGE:String = "CHAT_LOCK_ENABLE_CHANGE";
      
      public static const SEND_GOODS:String = "SEND_GOODS";
      
      public static const SEND_STAR:String = "SEND_STAR";
      
      public static const SEND_CARD:String = "SEND_CARD";
      
      public static const SEND_SPACETIME_SHARE:String = "SEND_SPACETIME_SHARE";
      
      public static const FISH_CLICK:String = "FISH_CLICK";
      
      public static const GOLDROAD_CLICK:String = "GOLDROAD_CLICK";
      
      public static const OUTER_CITY_BOSS_CLICK:String = "OUTER_CITY_BOSS_CLICK";
      
      public static const PLANES_DEAD_HELP_CLICK:String = "PLANES_DEAD_HELP_CLICK";
      
      public static const OPEN_SALE_CLICK:String = "OPEN_SALE_CLICK";
      
      public static const OPEN_TREASURE_CLICK:String = "OPEN_TREASURE_CLICK";
      
      public static const ALCHEMICAL_INVITE_CLICK:String = "ALCHEMICAL_INVITE_CLICK";
      
      public static const CRISIS_ATTACK_INVATE_CLICK:String = "CRISIS_ATTACK_INVATE_CLICK";
      
      public static const GAME_HALLK_INVATE_CLICK:String = "GAME_HALLK_INVATE_CLICK";
      
      public static const APEX_TEAM_INVATE_CLICK:String = "APEX_TEAM_INVATE_CLICK";
      
      public static const CONSORTIA_NEW_BOSS_CLICK:String = "CONSORTIA_NEW_BOSS_CLICK";
      
      public static const GODS_EVENING_GOTO:String = "GODS_EVENING_GOTO";
      
      private var _data:ChatData;
      
      private var _releaceScroll:Boolean;
      
      private var _replaceAll:Boolean;
      
      public function ChatEvent(param1:String, param2:ChatData = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,false,false);
         _data = param2;
         _releaceScroll = param3;
         _replaceAll = param4;
      }
      
      public function get data() : ChatData
      {
         return _data;
      }
      
      public function get releaceScroll() : Boolean
      {
         return _releaceScroll;
      }
      
      public function get replaceAll() : Boolean
      {
         return _replaceAll;
      }
   }
}

