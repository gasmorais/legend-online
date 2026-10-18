package yishi.events
{
   import flash.events.Event;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   
   public class PlayerEvent extends Event
   {
      
      public static const CASTLE_DEFENCE_TIME:String = "CASTLE_DEFENCE_TIME";
      
      public static const POINT_CHANGE:String = "POINT_CHANGE";
      
      public static const WEARY_CHANGE:String = "WEARY_CHANGE";
      
      public static const FIRSTCHARGE:String = "FIRSTCHARGE";
      
      public static const RELOGINPROCESS_UPDATE:String = "RELOGINPROCESS_UPDATE";
      
      public static const SYSTIME_UPGRADE_DATE:String = "SYSTIME_UPGRADE_DATE";
      
      public static const SYSTIME_UPGRADE_SECOND:String = "SYSTIME_UPGRADE_SECOND";
      
      public static const SYSTIME_UPGRADE_MINUTE:String = "SYSTIME_UPGRADE_MINUTE";
      
      public static const SYSTIME_UPGRADE_HOUR:String = "SYSTIME_UPGRADE_HOUR";
      
      public static const TIMEBOX_UPDATE:String = "TIMEBOX_UPDATE";
      
      public static const COMPOSE_LIST_CHANGE:String = "COMPOSE_LIST_CHANGE";
      
      public static const PLAYER_SIGNSITE_CHANGE:String = "PLAYER_SIGNSITE_CHANGE";
      
      public static const PLAYER_INFO_UPDATE:String = "PLAYER_INFO_UPDATE";
      
      public static const UPDATE_EXTRABUFFER:String = "UPDATE_EXTRABUFFER";
      
      public static const PLAYER_STATE_CHANGE:String = "PLAYER_STATE_CHANGE";
      
      public static const THANE_LEVEL_UPDATE:String = "THANE_LEVEL_UPDATE";
      
      public static const THANE_EXP_UPDATE:String = "THANE_EXP_UPDATE";
      
      public static const BLOOD_UPDATE:String = "BLOOD_UPDATE";
      
      public static const BLOOD_VISIBLE_UPDATE:String = "BLOOD_VISIBLE_UPDATE";
      
      public static const THANE_SKILL_POINT:String = "THANE_SKILL_POINT";
      
      public static const SKILL_INDEX:String = "SKILL_INDEX";
      
      public static const ACTIVE_DOUBLE_SKILL:String = "ACTIVE_DOUBLE_SKILL";
      
      public static const ATTACK_COUNT_CHANGE:String = "ATTACK_COUNT_CHANGE";
      
      public static const CONSORTIA_DUTY_CHANGE:String = "CONSORTIA_DUTY_CHANGE";
      
      public static const CONSORTIA_OFFER_CHANGE:String = "CONSORTIA_OFFER_CHANGE";
      
      public static const CONSORTIA_CHANGE:String = "CONSORTIA_CHANGE";
      
      public static const CONSORTIA_NAME_CHANGE:String = "CONSORTIA_NAME_CHANGE";
      
      public static const IS_AUTO_CHANGE:String = "IS_AUTO_CHANGE";
      
      public static const PLAYER_AVATA_CHANGE:String = "PLAYER_AVATA_CHANGE";
      
      public static const SEMINARY_EFFECT:String = "SEMINARY_EFFECT";
      
      public static const JEWELGP_UPDATE:String = "JEWELGP_UPDATE";
      
      public static const JEWELGRADES_UPDATE:String = "JEWELGRADES_UPDATE";
      
      public static const THANE_INFO_UPDATE:String = "THANE_INFO_UPDATE";
      
      public static const THANE_FASTKEY_UPDATE:String = "THANE_FASTKEY_UPDATE";
      
      public static const TREE_INFO_UPDATE:String = "TREE_INFO_UPDATE";
      
      public static const LOGIN_SUCCESS:String = "LOGIN_SUCCESS";
      
      public static const BAG_CAPICITY_INCRESS:String = "BAG_CAPICITY_INCRESS";
      
      public static const STAR_FREECOUNT_CHANGE:String = "STAR_FREECOUNT_CHANGE";
      
      public static const STARBAG_CAPICITY_INCRESS:String = "STARBAG_CAPICITY_INCRESS";
      
      public static const STAR_POINT_UPDATE:String = "STAR_POINT_UPDATE";
      
      public static const HERO_CAPICITY_INCRESS:String = "HERO_CAPICITY_INCRESS";
      
      public static const NICKNAME_UPDATE:String = "NICKNAME_UPDATE";
      
      public static const PLAYER_HONOR:String = "PLAYER_HONOR";
      
      public static const PLAYER_HONOR_DAY:String = "PLAYER_HONOR_DAY";
      
      public static const PLAYER_HONOR_DAY_MAX:String = "PLAYER_HONOR_DAY_MAX";
      
      public static const REFRESH_PLAYER_LIST:String = "REFRESH_PLAYER_LIST";
      
      public static const UPDATE_TOWER_INFO:String = "UPDATE_TOWER_INFO";
      
      public static const GET_KING_BUFF:String = "GET_KING_BUFF";
      
      public static const WORLDPROSPERITY:String = "WORLDPROSPERITY";
      
      public static const GVGISOPEN:String = "GVGISOPEN";
      
      public static const MINERAL:String = "MINERAL";
      
      public static const WORLDBOSSSTATE:String = "WORLDBOSSSTATE";
      
      public static const ISPVPSTART:String = "ISPVPSTART";
      
      public static const PVP_CONUT_CHANGE:String = "PVP_CONUT_CHANGE";
      
      public static const SEEK_COUNT_CHANGE:String = "SEEK_COUNT_CHANGE";
      
      public static const APPELL_CHANGE:String = "APPELL_CHANGE";
      
      public static const SMALL_BUGLE_FREE_COUNT:String = "SMALL_BUGLE_FREE_COUNT";
      
      public static const CROSS_SCORE_RAWARD:String = "CROSS_SCORE_RAWARD";
      
      public static const VEHICLESTART:String = "VEHICLESTART";
      
      public static const VEHICLE_GP:String = "VEHICLE_GP";
      
      public static const PLAYER_VEHICLE_CHANGE:String = "PLAYER_VEHICLE_CHANGE";
      
      public static const PLAYER_VEHICLEINFO_CHANGE:String = "PLAYER_VEHICLEINFO_CHANGE";
      
      public static const GLORY_CHANGE:String = "GLORY_CHANGE";
      
      public static const PLAYER_PET_LIST_CHANGE:String = "PLAYER_PET_LIST_CHANGE";
      
      public static const PLAYER_CHILD_LIST_CHANGE:String = "PLAYER_CHILD_LIST_CHANGE";
      
      public static const MUTICOPY_COUNT:String = "MUTICOPY_COUNT";
      
      public static const MUTICOPY_MAX_COUNT:String = "MUTICOPY_MAX_COUNT";
      
      public static const SENIORSTOREGRADE_UPDATE:String = "SENIORSTOREGRADE_UPDATE";
      
      public static const SENIORSTOREGP_UPDATE:String = "SENIORSTOREGP_UPDATE";
      
      public static const DRAGON_SOUL_TYPE:String = "DRAGON_SOUL_TYPE";
      
      public static const DRAGON_SOUL_GRADE:String = "DRAGON_SOUL_GRADE";
      
      public static const DRAGON_SOUL_GP:String = "DRAGON_SOUL_GP";
      
      public static const VOCATION_INDEX:String = "VOCATION_INDEX";
      
      public static const VOCATION_GRADES:String = "VOCATION_GRADES";
      
      public static const VOCATION_GP:String = "VOCATION_GP";
      
      public static const DRAGON_SOUL_TRANSFER:String = "DRAGON_SOUL_TRANSFER";
      
      public static const CROSSGUILDSCOREREFRESH:String = "CROSSGUILDSCOREREFRESH";
      
      public static const CROSSLEAGUESCOREREFRESH:String = "CROSSLEAGUESCOREREFRESH";
      
      public static const RENTAL_BAG_STATUS_REFRESH:String = "RENTAL_BAG_TIME_REFRESH";
      
      public static const MEDALGRADE_UPDATE:String = "MEDALGRADE_UPDATE";
      
      public static const MEDALGP_UPDATE:String = "MEDALGP_UPDATE";
      
      public static const MEDALINVALIDTIME_UPDATE:String = "MEDALINVALIDTIME_UPDATE";
      
      public static const MULTIPLE_AP_UPDATE:String = "MULTIPLE_AP_UPDATE";
      
      public static const FREESKILL_CHANGE:String = "FREESKILL_CHANGE";
      
      public static const PROFICIENCY_CHANGE:String = "PROFICIENCY_CHANGE";
      
      public static const LIFESKILLID_CHANGE:String = "LIFESKILLID_CHANGE";
      
      public static const LIFESKILLGRADE_CHANGE:String = "LIFESKILLID_CHANGE";
      
      public static const LIFESKILLCAMPAIGNID_CHANGE:String = "LIFESKILLCAMPAIGNID_CHANGE";
      
      public static const CONCISE_GRADES_CHANGE:String = "CONCISE_GRADES_CHANGE";
      
      public static const CONCISE_GP_CHANGE:String = "CONCISE_GP_CHANGE";
      
      public static const TIME_VORTEX_COUNT_CHANGE:String = "TIME_VORTEX_COUNT_CHANGE";
      
      public static const TIME_VORTEX_NODE_CHANGE:String = "TIME_VORTEX_NODE_CHANGE";
      
      public static const TIME_VORTEX_CAPTURE_CHANGE:String = "TIME_VORTEX_CAPTURE_CHANGE";
      
      public static const TIME_VORTEX_CRACK_CHANGE:String = "TIME_VORTEX_CRACK_CHANGE";
      
      public static const TIME_VORTEX_REVENGE_CHANGE:String = "TIME_VORTEX_REVENGE_CHANGE";
      
      public static const PLAYER_OLDBACKER_BUFF_CHANGE:String = "PLAYER_OLDBACKER_BUFF_CHANGE";
      
      public static const FIGHTINGCAPACITY_CHANGE:String = "FIGHTINGCAPACITY_CHANGE";
      
      public static const AVENGER_DEGREE_CHANGE:String = "AVENGER_DEGREE_CHANGE";
      
      public static const RUNE_COUNT_CHANGE:String = "RUNE_COUNT_CHANGE";
      
      public static const RUNPOWER_POINT_CHANGE:String = "RUNPOWER_POINT_CHANGE";
      
      private var _info:SimplePlayerInfo;
      
      public var prevGrade:int = 0;
      
      public function PlayerEvent(param1:String, param2:SimplePlayerInfo, param3:int = 0)
      {
         _info = param2;
         prevGrade = param3;
         super(param1,false,false);
      }
      
      public function get info() : SimplePlayerInfo
      {
         return _info;
      }
   }
}

