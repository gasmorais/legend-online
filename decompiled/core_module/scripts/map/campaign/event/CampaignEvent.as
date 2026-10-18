package map.campaign.event
{
   import flash.events.Event;
   
   public class CampaignEvent extends Event
   {
      
      public static const SELECT_ITEM:String = "SELECT_ITEM";
      
      public static const CONTINGEN_LIST_CHANGE:String = "CONTINGEN_LIST_CHANGE";
      
      public static const UPDATE_CAMPAIGN_ROOM:String = "UPDATE_CAMPAIGN_ROOM";
      
      public static const ADD_CAMPAIGN_ROOM:String = "ADD_CAMPAIGN_ROOM";
      
      public static const CAMPAIGN_ROOM_MEMBER_LIST_CHANGE:String = "CAMPAIGN_ROOM_LIST_MEMBER_CHANGE";
      
      public static const ADD_CAMPAIGN_ROOM_MEMBER_CHANGE:String = "ADD_CAMPAIGN_ROOM_MEMBER_CHANGE";
      
      public static const REMOVE_CAMPAIGN_ROOM_MEMBER_CHANGE:String = "REMOVE_CAMPAIGN_ROOM_MEMBER_CHANGE";
      
      public static const CUR_CAMPAIGN_TEMPINFO:String = "curCampaignTempInfo";
      
      public static const CUR_CAMPAIGN_ROOM:String = "curCampaignRoom";
      
      public static const ENTER_CAMPAIGN_SCENE:String = "ENTER_CAMPAIGN_SCENE";
      
      public static const SWITCH_STATE:String = "SWITCH_STATE";
      
      public static const MOVE_ARMY_TO_RANGE:String = "MOVE_ARMY_TO_RANGE";
      
      public static const GET_SYS_ARMY_INFO:String = "GET_SYS_ARMY_INFO";
      
      public static const SYS_ARMY_UPDATE:String = "SYS_ARMY_UPDATE";
      
      public static const PLAYER_NODE_MOVIE:String = "PLAYER_NODE_MOVIE";
      
      public static const SHOW_FALLGOODS_SELECTITEM:String = "show_fallgoods_selectItem";
      
      public static const NPC_ATTACK_ARMY:String = "NPC_ATTACK_ARMY";
      
      public static const UPDATE_SMALL_MAP_ICON:String = "UPDATE_SMALL_MAP_ICON";
      
      public static const STANDPOS:String = "STANDPOS";
      
      public static const MOVE_NPC:String = "MOVE_NPC";
      
      public static const NPC_CHASE:String = "NPC_CHASE";
      
      public static const UPDATE_GVG_INFO:String = "UPDATE_GVG_INFO";
      
      public static const UPDATE_MINERAL_INFO:String = "UPDATE_MINERAL_INFO";
      
      public static const UPDATE_MINERAL_CAR:String = "UPDATE_MINERAL_CAR";
      
      public static const UPDATE_CAMPAING_NODE:String = "UPDATE_CAMPAING_NODE";
      
      public static const UPDATE_TIMEENDFLAG:String = "UPDATE_TIMEENDFLAG";
      
      public static const CAMPAIGN_OVER:String = "CAMPAIGN_OVER";
      
      public static const CONSORTIA_BOSS_SWITCH:String = "CampaignEvent.CONSORTIA_BOSS_SWITCH";
      
      public static const CONSORTIA_BOSS_STATE_UPDATE:String = "CampaignEvent.CONSORTIA_BOSS_STATE_UPDATE";
      
      public static const ACTIVEVEHICLE_CHATDATA:String = "ACTIVEVEHICLE_CHATDATA";
      
      public static const ACTIVEVEHICLE_PLAYERSUPDATE:String = "ACTIVEVEHICLE_PLAYERSUPDATE";
      
      public static const ACTIVEVEHICLE_SCORECHANGE:String = "ACTIVEVEHICLE_SCORECHANGE";
      
      public static const ACTIVEVEHICLE_COUNTTIME:String = "ACTIVEVEHICLE_COUNTTIME";
      
      public static const ACTIVEVEHICLE_CAMPAIGNTIME:String = "ACTIVEVEHICLE_CAMPAIGNTIME";
      
      public static const FANTASYMATRIX_MAIN_UPDATE:String = "FANTASYMATRIX_MAIN_UPDATE";
      
      public static const FANTASYMATRIX_MAP_UPDATE:String = "FANTASYMATRIX_MAP_UPDATE";
      
      public static const CHILD_WAR_BUFF_CHANGE:String = "CHILD_WAR_BUFF_CHANGE";
      
      public static const DEEP_PRISION_UPDATE:String = "DEEP_PRISION_UPDATE";
      
      public static const UPDATE_SINGLE_CAMPAIGN:String = "UPDATE_SINGLE_CAMPAIGN";
      
      public static const PET_BOSS_SWITCH:String = "CampaignEvent.PET_BOSS_SWITCH";
      
      public static const PET_BOSS_SCORE:String = "CampaignEvent.PET_BOSS_SCORE";
      
      public static const MARKET_OPBACK:String = "CampaignEvent.MARKET_OPBACK";
      
      public var data:Object;
      
      public function CampaignEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

