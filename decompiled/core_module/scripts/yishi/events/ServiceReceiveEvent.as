package yishi.events
{
   import flash.events.Event;
   
   public class ServiceReceiveEvent extends Event
   {
      
      public static const BUILDING_QUICKEN_RECEIVE:String = "buildingQuickenReceive";
      
      public static const PAWN_RECRUIT_LIST_RECEIVE:String = "pawnRecruitListReceive";
      
      public static const SICK_PAWN_LIST:String = "sickpawnlist";
      
      public static const ARMY_LIST_RECEIVE:String = "armyListReceive";
      
      public static const ARMY_PAWN_LIST_RECEIVE:String = "armyPawnListReceive";
      
      public static const GET_HERO_RECEIVE:String = "getHeroReceive";
      
      public static const FREE_HERO_RECEIVE:String = "freeHeroReceive";
      
      public static const AUTO_SETUP_ARMY_RECEIVE:String = "setupArmyReceive";
      
      public static const SETUP_ARMY_RECEIVE:String = "setupArmyReceive";
      
      public static const DISBAND_ARMY_RECEIVE:String = "disbandArmyReceive";
      
      public static const TECHNOLOGY_LIST_RECEIVE:String = "technologyListReceive";
      
      public static const TECHNOLOGY_COOLDOWN_ALL:String = "TECHNOLOGY_COOLDOWN_ALL";
      
      public static const TECHNOLOGY_UPGRADE_RECEIVE:String = "technologyUpgradeReceive";
      
      public static const TECHNOLOGY_QUICKEN_RECEIVE:String = "technologyQuickenReceive";
      
      public static const TECHNOLOGY_CANCEL_RECEIVE:String = "technologyCancelReceive";
      
      public static const RECRUIT_SUCCESS:String = "recruitsuccess";
      
      public static const RECRUITED_PAWN_LIST:String = "recruitedpawnlist";
      
      public static const GET_BYID_SUCCESS:String = "getbyidsuccess";
      
      public static const UPGRADE_PAWN_SUCCESS:String = "upgrade_pawn_success";
      
      public static const CURE_PAWN_SUCCESS:String = "curepawnsuccess";
      
      public static const HERO_REFRESH_RECEIVE:String = "heroRefreshReceive";
      
      public static const HERO_EMPLOY_RECEIVE:String = "hero_employ_receive";
      
      public static const HERO_TALENT_RECEIVE:String = "heroTalentReceive";
      
      public static const TALENT_COMMIT_RECEIVE:String = "talentCommitReceive";
      
      public static const MOVE_BAG_TO_BAG_RECEIVE:String = "moveBagToBagReceive";
      
      public static const PLAYER_INFO_RECEIVE:String = "playerInfoReceive";
      
      public static const HEROINFO_CHANGE:String = "heroInfoChange";
      
      public static const HERO_LEVEL_UP:String = "heroLevelUp";
      
      public static const PLAYER_LEVEL_UP:String = "playerLevelUp";
      
      public static const TRANSEFER_CASTLE_SUCCESS:String = "TRANSEFER_CASTLE_SUCCESS";
      
      public static const TRANSEFER_ARMY_SUCCESS:String = "TRANSEFER_ARMY_SUCCESS";
      
      public static const COOL_SUCCESS:String = "coolsuccess";
      
      public static const ADD_POWER_SUCCESS:String = "addpawnsuccess";
      
      public static const GET_BUILDINFO_SUCCESS:String = "getbuildinfosuccess";
      
      public var result:Boolean;
      
      public var data:Object;
      
      public function ServiceReceiveEvent(param1:String, param2:Boolean, param3:Object)
      {
         this.result = param2;
         this.data = param3;
         super(param1);
      }
   }
}

