package sandbox.daylight
{
   import flash.events.EventDispatcher;
   import sandbox.daylight.data.DayLightTeamInfo;
   import sandbox.daylight.data.DayLightUnitInfo;
   import sandbox.daylight.data.DayLightUserInfo;
   import sandbox.daylight.event.DayLightEvent;
   
   public class DayLightModel extends EventDispatcher
   {
      
      public static const TEAM_BLUE:int = 1;
      
      public static const TEAM_RED:int = 2;
      
      public static const STATE_FREE:int = 0;
      
      public static const STATE_ATTACK:int = 1;
      
      public static const STATE_DIE:int = 2;
      
      public static const STATE_DEFEND:int = 3;
      
      public static const SKILL_TEMPLATE_ID_1:int = 410201;
      
      public static const SKILL_TEMPLATE_ID_2:int = 410202;
      
      public static const SKILL_TEMPLATE_ID_3:int = 410203;
      
      public static const SKILL_TEMPLATE_ID_4:int = 410204;
      
      public static const SKILL_TEMPLATE_ID_5:int = 410205;
      
      public static const REWARD_TEMPLATE_ID:int = 2060801;
      
      public static const MIN_SCORE:int = 5;
      
      public static const PERSONAL_REWARDS:Array = [{
         "rank":"1",
         "count":20,
         "idx":1
      },{
         "rank":"2",
         "count":15,
         "idx":2
      },{
         "rank":"3",
         "count":12,
         "idx":3
      },{
         "rank":"4-6",
         "count":10,
         "idx":6
      },{
         "rank":"7-15",
         "count":5,
         "idx":15
      },{
         "rank":"16-50",
         "count":3,
         "idx":50
      }];
      
      public var fightBeginCd:int;
      
      public var fightEndCd:int;
      
      public var blueTeamInfo:DayLightTeamInfo;
      
      public var redTeamInfo:DayLightTeamInfo;
      
      public var selfInfo:DayLightUserInfo;
      
      public var userRankList:Vector.<DayLightUserInfo>;
      
      public var resultRankList:Vector.<DayLightUserInfo>;
      
      public var blueUnitList:Vector.<DayLightUnitInfo>;
      
      public var redUnitList:Vector.<DayLightUnitInfo>;
      
      public var skillUseTeam:int;
      
      public var skillUseId:int;
      
      public var winTeam:int;
      
      public function DayLightModel()
      {
         super();
      }
      
      public function dispose() : void
      {
         blueTeamInfo = null;
         redTeamInfo = null;
         selfInfo = null;
         userRankList = null;
         resultRankList = null;
         blueUnitList = null;
         redUnitList = null;
      }
      
      public function updateSelfUserInfo() : void
      {
         this.dispatchEvent(new DayLightEvent("SELF_INFO_UPDATE"));
      }
      
      public function updateUserInfoRankList() : void
      {
         this.dispatchEvent(new DayLightEvent("USER_INFO_RANK_LIST_UPDATE"));
      }
      
      public function updateUnitInfoList() : void
      {
         this.dispatchEvent(new DayLightEvent("UNIT_INFO_LIST_UPDATE"));
      }
      
      public function updateSkillUseResult() : void
      {
         this.dispatchEvent(new DayLightEvent("SKILL_USE_RESULT_UPDATE"));
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new DayLightEvent("SANDBOX_INFO_UPDATE"));
      }
   }
}

