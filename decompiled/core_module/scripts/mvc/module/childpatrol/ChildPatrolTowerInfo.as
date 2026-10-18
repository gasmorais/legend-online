package mvc.module.childpatrol
{
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   
   public class ChildPatrolTowerInfo
   {
      
      public var towerId:int;
      
      public var onGarrison:Boolean;
      
      public var state:int;
      
      public var level:int;
      
      public var curExp:int;
      
      public var garrisonExpPerMinute:int;
      
      public var garrisonChildIdList:Array;
      
      public var garrisonStartTime:Number;
      
      public var garrisonEndTime:Number;
      
      public var patrolChildIdList:Array;
      
      public var patrolStartTime:Number;
      
      public var patrolEndTime:Number;
      
      public var normalMissionId:int;
      
      public var normalMissionReached:Boolean;
      
      public var hardMissionId:int;
      
      public var hardMissionReached:Boolean;
      
      public var nightmareMissionId:int;
      
      public var nightmareMissionReached:Boolean;
      
      public var exploreChildId:int;
      
      public var bossId:int;
      
      public var bossState:int;
      
      public var bossGrade:int = 1;
      
      private var _exploreLeftTime:Number;
      
      private var _garrisonLeftTime:Number;
      
      private var _patrolLeftTime:Number;
      
      public function ChildPatrolTowerInfo()
      {
         super();
         garrisonChildIdList = [];
         patrolChildIdList = [];
      }
      
      public function get exploreLeftTime() : Number
      {
         return _exploreLeftTime;
      }
      
      public function set exploreLeftTime(param1:Number) : void
      {
         _exploreLeftTime = param1;
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateExploreLeftTimeHandler);
         if(_exploreLeftTime > 0)
         {
            PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateExploreLeftTimeHandler);
         }
      }
      
      private function __updateExploreLeftTimeHandler(param1:PlayerEvent) : void
      {
         _exploreLeftTime = _exploreLeftTime - 1;
         if(_exploreLeftTime <= 0)
         {
            PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateExploreLeftTimeHandler);
         }
      }
      
      public function get garrisonLeftTime() : Number
      {
         return _garrisonLeftTime;
      }
      
      public function set garrisonLeftTime(param1:Number) : void
      {
         _garrisonLeftTime = param1;
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateGarrisonLeftTimeHandler);
         if(_garrisonLeftTime > 0)
         {
            PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateGarrisonLeftTimeHandler);
         }
      }
      
      private function __updateGarrisonLeftTimeHandler(param1:PlayerEvent) : void
      {
         _garrisonLeftTime = _garrisonLeftTime - 1;
         if(_garrisonLeftTime <= 0)
         {
            PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateGarrisonLeftTimeHandler);
         }
      }
      
      public function get patrolLeftTime() : Number
      {
         return _patrolLeftTime;
      }
      
      public function set patrolLeftTime(param1:Number) : void
      {
         _patrolLeftTime = param1;
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updatePatrolLeftTimeHandler);
         if(_patrolLeftTime > 0)
         {
            PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updatePatrolLeftTimeHandler);
         }
      }
      
      private function __updatePatrolLeftTimeHandler(param1:PlayerEvent) : void
      {
         _patrolLeftTime = _patrolLeftTime - 1;
         if(_patrolLeftTime <= 0)
         {
            PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updatePatrolLeftTimeHandler);
         }
      }
   }
}

