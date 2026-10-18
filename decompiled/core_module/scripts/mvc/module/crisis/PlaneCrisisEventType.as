package mvc.module.crisis
{
   public class PlaneCrisisEventType
   {
      
      public static const MOVE_TO_POINT:String = "PlaneCrisisEventType.moveTo";
      
      public static const SELF_MOVE_OVER:String = "PlaneCrisisEventType.selfmoveOver";
      
      public static const ADD_ARMY:String = "PlaneCrisisEventType.addArmy";
      
      public static const REMOVE_ARMY:String = "PlaneCrisisEventType.removeArmy";
      
      public static const UPDATE_ROLE_POS:String = "PlaneCrisisEventType.updateRolePos";
      
      public static const UPDATE_NODE_INFO:String = "PlaneCrisisEventType.updateNodeInfo";
      
      public static const UPDATE_PLAYER_INFO:String = "PlaneCrisisEventType.updatePlayerInfo";
      
      public static const UPDATE_EVENT_COUNT:String = "PlaneCrisisEventType.updateEventCount";
      
      public static const TRANS_MAP_EVENT:String = "PlaneCrisisEventType.TRANS_MAP_EVENT";
      
      public static const SHOW_BOSS_TO_SMALLMAP:String = "PlaneCrisisEventType.showBossToSmall";
      
      public static const UPDATE_SMALL_POINT:String = "PlaneCrisisEventType.updateSmallPoint";
      
      public static var END_BOSS:int = 1;
      
      public static var TRAP_BOSS:int = 2;
      
      public static var MIDDLE_BOSS:int = 3;
      
      public static var DISPERSE_GOG:int = 4;
      
      public static var TREASURE_BOX:int = 5;
      
      public static var KEY:int = 6;
      
      public static var CRYSTAL:int = 7;
      
      public static var REWARD:int = 8;
      
      public static var NULL:int = 9;
      
      public function PlaneCrisisEventType()
      {
         super();
      }
   }
}

