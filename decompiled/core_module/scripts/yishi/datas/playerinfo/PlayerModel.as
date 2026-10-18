package yishi.datas.playerinfo
{
   import com.road.yishi.proto.shop.MainDiscountInfo;
   import events.AppellEvent;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.ExternalInterfaceManager;
   import managers.FreedomTeamManager;
   import managers.FunnyManager;
   import managers.GuideTaskManager;
   import managers.MagicSpringManager;
   import managers.OfferRewardManager;
   import managers.ShopManager;
   import managers.TreasureMapManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.BaseCastle;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.event.SpaceEvent;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.findback.FindBackModel;
   import mvc.module.upgradepresent.UpgradePresentModel;
   import newyearact.ContinousLoginModel;
   import newyearact.NewYearLotteryModel;
   import ui.toptoolbar.TopToolsBar;
   import yishi.actions.hero.HeroFightingUpdateAction;
   import yishi.datas.UserInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NewYearActManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.manager.UpgradePresentManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   
   public class PlayerModel extends EventDispatcher
   {
      
      public static const OPEN_DRAGON_SOUL_SYSTEM_GRADE:int = 40;
      
      public static const OPEN_PET_SYSTEM_GRADE:int = 50;
      
      public static const OPEN_CELL_NEEDED_POINT:int = 100;
      
      public static const BAG_PAGE_CELL_NUM:int = 56;
      
      public static const PLAYER_STAR_BAG_COUNT:int = 18;
      
      public static const ORIGINAL_OPEN_BAG_COUNT:int = 12;
      
      public static const EQUIP_STAR_BAG_COUNT:int = 10;
      
      public static var HOLY_DRAGONSOUL_COSTTEMPID:int = 208550;
      
      public var userInfo:UserInfo;
      
      private var _playerInfo:PlayerInfo;
      
      public var towerInfo:TowerInfo;
      
      public var towerInfo1:TowerInfo;
      
      public var towerInfo2:TowerInfo;
      
      public var towerInfo3:TowerInfo;
      
      public var playerEffect:PlayerEffectInfo;
      
      public var mapNodeInfo:BaseCastle = new BaseCastle();
      
      public var currntBattleId:String;
      
      public var indulgeTime:Number = 0;
      
      private var _isInAAS:Boolean = false;
      
      public var hookTime:Number;
      
      public var hookGp:Number;
      
      public var currentTower:int;
      
      private var _time:Timer;
      
      private var _isFirstSyncTime:Boolean = true;
      
      public var sysStartTime:Date;
      
      private var _vehicleTech:int = 0;
      
      private var _selectTarget:BaseArmy;
      
      public var spaceNodeId:int = 0;
      
      public var campaignFindTarget:Object;
      
      public var spaceMapId:int = 0;
      
      public var inCastle:Boolean = false;
      
      public var isOnObstacle:Boolean = false;
      
      private var _reinforceTarget:BaseArmy;
      
      public var faterotaryCount:int = 0;
      
      public var faterotaryCount1:int = 0;
      
      public var faterotaryCount2:int = 0;
      
      public var iscost:Boolean = false;
      
      private var _sysSecond:Number;
      
      private var _castle_offset:Number;
      
      private var _grand_world_offset:Number;
      
      public var showBattleGuardBtnShine:Boolean = false;
      
      public var showDragonSoulBtnShine:Boolean = false;
      
      private var _currentSysSecond:Number;
      
      private var _sysCurtime:Date;
      
      private var count:int = 0;
      
      private var _isOpenCrossGvg:Boolean = false;
      
      private var _isOpenNewYearLottery:Boolean = false;
      
      private var _isOpenNewYearAct:Boolean = false;
      
      private var _openActivityDay:int = 0;
      
      private var activity_openTemp:ConfigInfosTempInfo;
      
      private var isDispatchStar:Boolean = false;
      
      private var isDispatchEnd:Boolean;
      
      private var _tiroActStarTime:String = "";
      
      private var _tiroActEndTime:String = "";
      
      public var isOpenAct:Object;
      
      public var isEndAct:Object;
      
      private var _isCrossGvgExpired:Boolean = false;
      
      public var fightingCapacityRecord:int = -1;
      
      private var _isOpenAppellAddition:Boolean = false;
      
      public var findBackModel:FindBackModel = new FindBackModel();
      
      public function PlayerModel()
      {
         super();
         _playerInfo = new PlayerInfo();
         playerEffect = new PlayerEffectInfo();
         towerInfo = new TowerInfo();
         towerInfo1 = new TowerInfo();
         towerInfo2 = new TowerInfo();
         towerInfo3 = new TowerInfo();
         _time = new Timer(1000);
         _time.addEventListener("timer",__timeUpdateHandler);
         _castle_offset = -1;
         _grand_world_offset = -1;
      }
      
      public function get grand_world_offset() : Number
      {
         return _grand_world_offset;
      }
      
      public function set grand_world_offset(param1:Number) : void
      {
         _grand_world_offset = param1;
      }
      
      public function get castle_offset() : Number
      {
         return _castle_offset;
      }
      
      public function set castle_offset(param1:Number) : void
      {
         _castle_offset = param1;
      }
      
      public function get petSystemIsOpened() : Boolean
      {
         if(ArmyManager.instance.thane.grades >= 50)
         {
            return true;
         }
         return false;
      }
      
      public function get selectTarget() : BaseArmy
      {
         return _selectTarget;
      }
      
      public function set selectTarget(param1:BaseArmy) : void
      {
         var _loc2_:Object = null;
         if(!param1)
         {
            reinforce = null;
         }
         if(_selectTarget == param1)
         {
            return;
         }
         if(_selectTarget)
         {
            _loc2_ = getTargetView(_selectTarget);
            if(_selectTarget && _loc2_ && _loc2_.hasOwnProperty("unlockTargetAndShowFate"))
            {
               _loc2_["unlockTargetAndShowFate"]();
               _selectTarget = null;
            }
         }
         _selectTarget = param1;
         if(_selectTarget)
         {
            _loc2_ = getTargetView(_selectTarget);
         }
         if(_selectTarget && _loc2_ && _loc2_.hasOwnProperty("lockTargetAndHideFate"))
         {
            _loc2_["lockTargetAndHideFate"]();
         }
         dispatchEvent(new SpaceEvent("TARGET_CHANGE",_selectTarget));
      }
      
      public function get reinforce() : BaseArmy
      {
         return _reinforceTarget;
      }
      
      public function set reinforce(param1:BaseArmy) : void
      {
         _reinforceTarget = param1;
         if(!param1)
         {
            TreasureMapManager.instance.model.reinforceTarget = null;
         }
         if(_reinforceTarget && FreedomTeamManager.instance.inMyTeam(_reinforceTarget.userId) && targetIsFighting(_reinforceTarget))
         {
            dispatchEvent(new SpaceEvent("TARGET_CHANGE",_reinforceTarget));
         }
      }
      
      private function targetIsFighting(param1:BaseArmy) : Boolean
      {
         if(param1.state == 2)
         {
            return true;
         }
         return false;
      }
      
      private function getTargetView(param1:Object) : Object
      {
         var _loc2_:* = undefined;
         if(param1 is SpaceArmy)
         {
            _loc2_ = SpaceManager.instance.controller;
         }
         else if(param1 is CampaignArmy)
         {
            _loc2_ = CampaignManager.instance.controller;
         }
         if(_loc2_)
         {
            return _loc2_.getArmyView(param1);
         }
         return null;
      }
      
      public function get vehicleTech() : int
      {
         return _vehicleTech;
      }
      
      public function set vehicleTech(param1:int) : void
      {
         if(param1 == _vehicleTech)
         {
            return;
         }
         _vehicleTech = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("VEHICLE_TECH_CHANGE",_vehicleTech));
      }
      
      public function get isInAAS() : Boolean
      {
         return _isInAAS;
      }
      
      public function set isInAAS(param1:Boolean) : void
      {
         _isInAAS = param1;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function get nowDate() : Number
      {
         return sysCurtime.time;
      }
      
      public function get sysCurTimeBySecond() : Number
      {
         return _currentSysSecond;
      }
      
      public function get sysSecond() : Number
      {
         return _sysSecond;
      }
      
      public function set sysSecond(param1:Number) : void
      {
         _sysSecond = param1;
      }
      
      public function set sysCurtime(param1:Date) : void
      {
         _sysCurtime = param1;
         _currentSysSecond = Math.floor(_sysCurtime.getTime() / 1000);
         _time.reset();
         _time.start();
         if(_isFirstSyncTime)
         {
            _isFirstSyncTime = false;
            ExternalInterfaceManager.instance.syncDesktopTime(_sysCurtime.hours * 3600 + _sysCurtime.minutes * 60 + _sysCurtime.seconds);
         }
      }
      
      public function get sysCurtime() : Date
      {
         var _loc1_:Date = new Date();
         _loc1_.time = _currentSysSecond * 1000;
         return _loc1_;
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         var _loc2_:Date = null;
         count = count + 1;
         if(count % 60 == 0)
         {
            PlayerManager.instance.checkAccelerator();
            count = 0;
         }
         _currentSysSecond = _currentSysSecond + 1;
         sysSecond = sysSecond + 1;
         dispatchEvent(new PlayerEvent("SYSTIME_UPGRADE_SECOND",null));
         var _loc3_:Number = _currentSysSecond % 3600;
         if(_loc3_ % 60 == 0)
         {
            PlayerManager.instance.synchronizedSystime();
            _loc2_ = sysCurtime;
            ExternalInterfaceManager.instance.syncDesktopTime(_loc2_.hours * 3600 + _loc2_.minutes * 60 + _loc2_.seconds);
            dispatchEvent(new PlayerEvent("SYSTIME_UPGRADE_MINUTE",null));
            if(upgradePresentModel.isShowBtn)
            {
               upgradePresentModel.setModelData(true);
            }
         }
         if(_loc3_ == 0)
         {
            if(sysCurtime.getDate() != _sysCurtime.getDate())
            {
               dispatchEvent(new PlayerEvent("SYSTIME_UPGRADE_DATE",null));
            }
            if(sysCurtime.getHours() == 5)
            {
               TaskManage.instance.requestCanAcceptTask();
               StarManager.instance.sendResetStarData();
               OfferRewardManager.instance.model.isNeedReset = true;
               NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
            }
            if(sysCurtime.getHours() == 0)
            {
               if(GuideTaskManager.instance.model.statu == 1)
               {
                  GuideTaskManager.instance.getReward(-1001);
               }
            }
         }
         checkOpenActivity();
         checkOpenNewYearAct();
         checkOpenNewYearLottery();
         checkRechargeGift();
         checkShopPop();
         MagicSpringManager.instance.model.checkBufferTime();
      }
      
      private function checkShopPop() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = ShopManager.Instance.timeArr;
         var _loc2_:Array = [];
         if(_loc1_ && _loc1_.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               if(DateFormatter.parse((_loc1_[_loc3_] as MainDiscountInfo).beginDate,"YYYY-MM-DD hh:mm:ss").time < nowDate)
               {
                  ShopManager.Instance.showShopTimeBuyTip((_loc1_[_loc3_] as MainDiscountInfo).vip > 0);
                  _loc2_.push(_loc3_);
               }
               _loc3_++;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc1_.splice(_loc4_);
               _loc4_++;
            }
         }
      }
      
      private function checkRechargeGift() : void
      {
         var _loc1_:Boolean = FunnyManager.instance.isNeed;
         var _loc2_:String = FunnyManager.instance.needTime;
         if(_loc1_ && _loc2_ != "")
         {
            if(DateFormatter.parse(_loc2_,"YYYY-MM-DD hh:mm:ss").getTime() < nowDate)
            {
               FunnyManager.instance.isNeed = false;
               FunnyManager.instance.needTime = "";
               FunnyManager.instance.sendGetBag(1);
            }
         }
      }
      
      public function set isOpenNewYearLottery(param1:Boolean) : void
      {
         if(param1 != _isOpenNewYearLottery)
         {
            _isOpenNewYearLottery = param1;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_NEWYEAR_BTN"));
         }
      }
      
      public function get isOpenNewYearLottery() : Boolean
      {
         return _isOpenNewYearLottery;
      }
      
      private function checkOpenNewYearLottery() : void
      {
         var _loc4_:NewYearLotteryModel = NewYearActManager.instance.lotteryModel;
         if(!_loc4_ || _loc4_.statu == 1)
         {
            isOpenNewYearLottery = false;
            return;
         }
         var _loc1_:Number = _loc4_.beginTime;
         var _loc2_:Number = _loc4_.endTime;
         var _loc3_:Number = sysCurtime.getTime();
         if(_loc3_ >= _loc1_ && _loc3_ <= _loc2_)
         {
            isOpenNewYearLottery = true;
         }
         else
         {
            isOpenNewYearLottery = false;
         }
      }
      
      public function get isOpenNewYearAct() : Boolean
      {
         return this._isOpenNewYearAct;
      }
      
      public function set isOpenNewYearAct(param1:Boolean) : void
      {
         if(this._isOpenNewYearAct != param1)
         {
            this._isOpenNewYearAct = param1;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_NEWYEAR_BTN"));
         }
      }
      
      private function checkOpenNewYearAct() : void
      {
         var _loc1_:ContinousLoginModel = NewYearActManager.instance.loginModel;
         if(!_loc1_ || !_loc1_.isSwitch)
         {
            isOpenNewYearAct = false;
            return;
         }
         var _loc2_:Date = DateFormatter.parse(_loc1_.starTime,"YYYY-MM-DD hh:mm:ss");
         var _loc4_:Date = DateFormatter.parse(_loc1_.endTime,"YYYY-MM-DD hh:mm:ss");
         var _loc5_:Object = DateFormatter.compareDate(_loc2_,sysCurtime);
         var _loc3_:Object = DateFormatter.compareDate(sysCurtime,_loc4_);
         if(_loc5_["flag"])
         {
            if(_loc3_["flag"])
            {
               isOpenNewYearAct = true;
            }
            else
            {
               isOpenNewYearAct = false;
            }
         }
         else
         {
            isOpenNewYearAct = false;
         }
      }
      
      public function get openActivityDay() : int
      {
         return _openActivityDay;
      }
      
      public function set tiroActStarTime(param1:String) : void
      {
         _tiroActStarTime = param1;
      }
      
      public function set tiroActEndTime(param1:String) : void
      {
         _tiroActEndTime = param1;
      }
      
      public function get tiroActStarTime() : String
      {
         return _tiroActStarTime;
      }
      
      public function get tiroActEndTime() : String
      {
         return _tiroActEndTime;
      }
      
      private function checkOpenActivity() : void
      {
         if(_tiroActStarTime == "")
         {
            return;
         }
         if(_tiroActEndTime == "")
         {
            return;
         }
         var _loc5_:Date = DateFormatter.parse(_tiroActStarTime,"YYYY-MM-DD hh:mm:ss");
         var _loc1_:Date = DateFormatter.parse(_tiroActEndTime,"YYYY-MM-DD hh:mm:ss");
         var _loc2_:Object = DateFormatter.compareDate(_loc5_,sysCurtime);
         var _loc4_:Object = DateFormatter.compareDate(sysCurtime,_loc1_);
         isOpenAct = _loc2_;
         isEndAct = _loc4_;
         if(!_loc2_["flag"])
         {
            return;
         }
         if(!_loc4_["flag"])
         {
            return;
         }
         var _loc3_:int = DateFormatter.compareDay(_loc5_);
         if(_loc3_ == openActivityDay && _loc3_ > 0)
         {
            return;
         }
         _openActivityDay = _loc3_;
         if(!isDispatchStar)
         {
            isDispatchStar = true;
            TopToolsBar.instance.show();
         }
         if(openActivityDay > 7 && !isDispatchEnd)
         {
            isDispatchEnd = true;
            TopToolsBar.instance.show();
         }
      }
      
      private function checkGvgOpenState() : void
      {
         var _loc1_:String = null;
         var _loc7_:Object = null;
         var _loc9_:String = null;
         var _loc4_:Date = null;
         var _loc3_:String = null;
         var _loc8_:Date = null;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("GuildSignOpen");
         if(_loc2_)
         {
            _loc1_ = _loc2_.ConfigValue;
         }
         var _loc6_:Date = DateFormatter.parse(_loc1_,"YYYY-MM-DD hh:mm:ss");
         var _loc5_:Object = DateFormatter.compareDate(sysCurtime,_loc6_);
         _loc2_ = TempleteManager.instance.getConfigInfoByConfigName("CrossGuild_TimeOutDate");
         if(_loc2_)
         {
            _loc9_ = _loc2_.ConfigValue;
            _loc4_ = DateFormatter.parse(_loc9_,"YYYY-MM-DD hh:mm:ss");
            _loc7_ = DateFormatter.compareDate(sysCurtime,_loc4_);
         }
         else
         {
            _loc2_ = TempleteManager.instance.getConfigInfoByConfigName("GuildSignStop");
            if(_loc2_)
            {
               _loc3_ = _loc2_.ConfigValue;
               _loc8_ = DateFormatter.parse(_loc3_,"YYYY-MM-DD hh:mm:ss");
               _loc8_.date = _loc8_.date + 60;
               _loc7_ = DateFormatter.compareDate(sysCurtime,_loc8_);
            }
         }
         if(_loc7_ && _loc7_["flag"])
         {
            if(!_loc5_["flag"])
            {
               if(!_isOpenCrossGvg)
               {
                  _isOpenCrossGvg = true;
                  TopToolsBar.instance.show();
               }
            }
         }
         else if(!_isCrossGvgExpired)
         {
            _isCrossGvgExpired = true;
            TopToolsBar.instance.show();
         }
      }
      
      public function get isCrossGvgExpired() : Boolean
      {
         return _isCrossGvgExpired;
      }
      
      public function get isOpenCrossGvg() : Boolean
      {
         return _isOpenCrossGvg;
      }
      
      public function setFightingCapacityRecord(param1:String) : void
      {
         if(param1 == "start")
         {
            fightingCapacityRecord = _playerInfo.fightingCapacity;
         }
         else
         {
            if(param1 != "end")
            {
               throw new Error("argument error.");
            }
            if(-1 != fightingCapacityRecord && fightingCapacityRecord < _playerInfo.fightingCapacity)
            {
               DelayActionsUtils.instance.addAction(new HeroFightingUpdateAction(fightingCapacityRecord,ArmyManager.instance.thane));
            }
         }
      }
      
      public function get isOpenAppellAddition() : Boolean
      {
         return _isOpenAppellAddition;
      }
      
      private function get upgradePresentModel() : UpgradePresentModel
      {
         return UpgradePresentManager.instance.model;
      }
      
      public function set isOpenAppellAddition(param1:Boolean) : void
      {
         if(_isOpenAppellAddition == param1)
         {
            return;
         }
         _isOpenAppellAddition = param1;
         if(param1)
         {
            dispatchEvent(new AppellEvent("OPEN_ADDITION"));
         }
      }
   }
}

