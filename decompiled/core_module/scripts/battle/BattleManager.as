package battle
{
   import battle.control.BattleMapSoundControl;
   import battle.events.BattleEvent;
   import battle.handler.BattlePlotHandler;
   import battle.handler.BattleResultHandler;
   import battle.quicken.BattleQuickenControl;
   import battle.quicken.BattleQuickenModel;
   import battle.skillsys.SkillSystem;
   import battle.utils.BattleUtils;
   import battle.view.roles.HeroRoleView;
   import battle.view.roles.MonsterRoleView;
   import flash.events.EventDispatcher;
   import logging.LoggerSys;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.BatterModel;
   import yishi.datas.battle.ResistModel;
   import yishi.datas.battle.ResourceModel;
   import yishi.manager.NotificationManager;
   
   public class BattleManager extends EventDispatcher
   {
      
      public static var begingBattle:Boolean = false;
      
      public static var localDubeg:Boolean = false;
      
      private static const _standardFrame:int = 25;
      
      public static var loginToBattleFlag:Boolean;
      
      public static var criticalNum:int;
      
      public static const VIEW_BATTLE_TYPE:uint = 1;
      
      public static const NORMAL_BATTLE_TYPE:uint = 0;
      
      public static var exitFlag:Boolean;
      
      public static var molongCountDownTime:Number;
      
      public static var molongLayer:int;
      
      public static var selfDie:Boolean = false;
      
      public static var isExitingBattle:Boolean = false;
      
      private static var _instance:BattleManager;
      
      public static var preScene:String = "";
      
      private var _battleModel:BattleModel;
      
      public var started:Boolean;
      
      public var _liftTime:int;
      
      private var _addFrame:int = 1;
      
      private var _battleMap:*;
      
      public var battleUIView:*;
      
      public var mainViewContainer:*;
      
      public var battleScene:*;
      
      public var resourceModel:ResourceModel;
      
      public var batterModel:BatterModel;
      
      public var resistModel:ResistModel;
      
      private var _diaplayMode:String = "normal";
      
      private var _skillSystem:SkillSystem;
      
      public var quickenModel:BattleQuickenModel;
      
      public var quickenControl:BattleQuickenControl;
      
      public var plotHandler:BattlePlotHandler;
      
      public var muiscControl:BattleMapSoundControl;
      
      public var _curJoinType:uint;
      
      private var _isLockChildnswar:Boolean = false;
      
      public function BattleManager()
      {
         super();
         BattleUtils.initRolePos();
         plotHandler = new BattlePlotHandler();
      }
      
      public static function getInstance() : BattleManager
      {
         if(!_instance)
         {
            _instance = new BattleManager();
         }
         return _instance;
      }
      
      public static function onFightCanceled() : void
      {
         var _loc1_:String = null;
         if(getInstance().battleModel)
         {
            _loc1_ = "战斗被取消了,battleId=" + getInstance().battleModel.battleId;
         }
         else
         {
            _loc1_ = "战斗被取消了,但找不到战斗数据";
         }
         LoggerSys.info(_loc1_);
         BattleResultHandler.exitBattle();
         NotificationManager.instance.dispatchEvent(new BattleEvent("battleCancel",null));
         NotificationManager.instance.dispatchEvent(new BattleEvent("battleComplete",null));
      }
      
      public function get isLockChildnswar() : Boolean
      {
         return _isLockChildnswar;
      }
      
      public function set isLockChildnswar(param1:Boolean) : void
      {
         if(_isLockChildnswar == param1)
         {
            return;
         }
         _isLockChildnswar = param1;
         NotificationManager.instance.sendNotification("childNswarLockChange");
      }
      
      public function set synchronization(param1:int) : void
      {
         _liftTime = param1;
         this.dispatchEvent(new BattleEvent("synchronization",param1));
      }
      
      public function set model(param1:BattleModel) : void
      {
         _battleModel = param1;
      }
      
      public function get battleModel() : BattleModel
      {
         return _battleModel;
      }
      
      public function enterGame() : void
      {
      }
      
      public function startGame() : void
      {
      }
      
      public function setup() : void
      {
         if(_battleModel && _battleModel.battleType == 3911)
         {
            isLockChildnswar = true;
         }
         batterModel = new BatterModel();
         resistModel = new ResistModel();
         quickenModel = new BattleQuickenModel();
         quickenControl = new BattleQuickenControl(quickenModel);
         muiscControl = new BattleMapSoundControl();
      }
      
      public function setBattleFrameRate(param1:int) : void
      {
         _addFrame = Math.round(25 / param1);
      }
      
      public function battleNextFrame() : void
      {
         _liftTime += _addFrame;
      }
      
      public function get BattleFrameCount() : int
      {
         return _liftTime;
      }
      
      public function get battleMap() : *
      {
         return _battleMap;
      }
      
      public function set battleMap(param1:*) : void
      {
         _battleMap = param1;
      }
      
      public function getSelfRoleView() : *
      {
         return _battleMap.rolesDict[_battleModel.selfHero.livingId];
      }
      
      public function getSelfChildRoleView() : HeroRoleView
      {
         if(!_battleModel.selfChildHeroInfo)
         {
            return null;
         }
         return _battleMap.rolesDict[_battleModel.selfChildHeroInfo.livingId];
      }
      
      public function getSelfMonsterRoleView() : MonsterRoleView
      {
         if(!_battleModel.selfMonsterRoleInfo)
         {
            return null;
         }
         return _battleMap.rolesDict[_battleModel.selfMonsterRoleInfo.livingId];
      }
      
      public function initBattle(param1:*) : void
      {
         mainViewContainer = param1;
      }
      
      public function initSkillSystem() : void
      {
         _skillSystem = new SkillSystem();
      }
      
      public function disposeBattle() : void
      {
         if(quickenControl)
         {
            quickenControl.dispose();
            quickenControl = null;
         }
         if(muiscControl)
         {
            muiscControl.dispose();
            muiscControl = null;
         }
         if(resourceModel)
         {
            resourceModel.dispose();
         }
         resourceModel = null;
         if(_skillSystem)
         {
            _skillSystem.dispose();
         }
         _skillSystem = null;
         if(battleUIView)
         {
            battleUIView.dispose();
         }
         battleUIView = null;
         if(_battleModel)
         {
            _battleModel.dispose();
         }
         _battleModel = null;
         mainViewContainer = null;
         if(battleScene)
         {
            battleScene.dispose();
            battleScene = null;
         }
         batterModel = null;
         resistModel = null;
      }
      
      public function getSkillSystem() : SkillSystem
      {
         return _skillSystem;
      }
      
      public function isAllSkillExecuted() : Boolean
      {
         if(_skillSystem && _skillSystem.getSkillQueue().getActions().length > 0)
         {
            return false;
         }
         if(_battleModel && !_battleModel.isAllSkillExecuted())
         {
            return false;
         }
         return true;
      }
      
      public function getWaitSkillList() : Array
      {
         var _loc1_:Array = _skillSystem.getSkillQueue().getActions();
         if(_battleModel.getWaitSkillList() != null)
         {
            _loc1_ = _battleModel.getWaitSkillList().concat(_loc1_);
         }
         return _loc1_;
      }
   }
}

