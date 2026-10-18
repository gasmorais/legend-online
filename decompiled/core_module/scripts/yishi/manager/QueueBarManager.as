package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.building.ActiveQueueListMsg;
   import com.road.yishi.proto.building.ActiveQueueMsg;
   import com.road.yishi.proto.consortia.ConsortiaMsg;
   import com.road.yishi.proto.consortia.ConsortiaQuitReqMsg;
   import com.road.yishi.proto.guardpve.GuardPVERspMsg;
   import com.road.yishi.proto.hugehead.HugeHeadMySignInStateMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import com.road.yishi.proto.hugehead.StackHeadSelfMsg;
   import com.road.yishi.proto.pet.NavigationMsg;
   import com.road.yishi.proto.pet.NavigationPortMsg;
   import com.road.yishi.proto.player.ChallengeCoolTimeMsg;
   import com.road.yishi.proto.player.ExtraFieldInfoMsg;
   import com.road.yishi.proto.player.PlayerExtraFieldMsg;
   import com.road.yishi.proto.reward.RewardFreshRspMsg;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import com.road.yishi.proto.skytrial.SkyTrialInfoMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import managers.ChildPatrolManager;
   import managers.GloryroadManager;
   import managers.OfferRewardManager;
   import managers.SpiritExpeditionManager;
   import mvc.module.buildings.BuildingModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class QueueBarManager extends EventDispatcher
   {
      
      private static var _instance:QueueBarManager;
      
      private var _time:Timer;
      
      private var _remainTime:Number;
      
      public function QueueBarManager()
      {
         super();
         initOutyardInstance();
      }
      
      public static function get instance() : QueueBarManager
      {
         if(!_instance)
         {
            _instance = new QueueBarManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 366,__loadActiveQueueListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 46,__consortiaQuitHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 45,__consortiaRefreshAltar);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4197,__offerRewardListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 350,__hugeHeadMySignInState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 311,__selfInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 306,__stackHeadState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 342,__updateNavigationData);
         SocketManager.instance.listener(4176,__petchallengeTimeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4176,__colosseumTimeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4979,__refreshChildPveBossInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4552,__skyBoxRoadHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 260,__playerExtraFieldHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4460,__shuttleHandler);
         ArmyManager.instance.thane.addEventListener("THANE_LEVEL_UPDATE",__heroLevelUpdate);
         GloryroadManager.instance.addEventListener("GLORY_ROAD_DATA_UPDATE",__updateGloryRoadInfo);
         MsgMan.addObserver("EXPEDITION_INFO_UPDATE",this,__updateSpiritExpeditionInfo);
         MsgMan.addObserver("FORMATION_INFO_UPDATE",this,__updateSpiritExpeditionInfo);
      }
      
      public function __updateGloryRoadInfo(param1:Event) : void
      {
         var _loc2_:BuildingOrderInfo = BuildingManager.instance.model.getActiveOrderById(14);
         if(_loc2_)
         {
            if(_loc2_.currentCount != GloryroadManager.instance.model.leftAmount)
            {
               activeOrderidChange();
            }
         }
      }
      
      private function __loadActiveQueueListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:BuildingOrderInfo = null;
         var _loc5_:BuildingOrderInfo = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:ActiveQueueListMsg = new ActiveQueueListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ActiveQueueListMsg;
         var _loc3_:Array = [];
         if(_loc2_.op == 4)
         {
            for each(var _loc6_:ActiveQueueMsg in _loc2_.list)
            {
               if(_loc6_.type == 3)
               {
                  _loc4_ = model.getActiveOrderById(3);
                  if(!_loc4_)
                  {
                     _loc4_.orderId = _loc6_.type;
                     _loc4_.orderType = 4;
                     _loc4_.currentCount = _loc6_.current;
                     _loc4_.totalCount = _loc6_.max;
                     _loc4_.remainTime = _loc6_.countDownTime;
                     _loc4_.sendDataChange();
                     startOutyardTime();
                  }
               }
            }
            return;
         }
         for each(var _loc7_:ActiveQueueMsg in _loc2_.list)
         {
            _loc5_ = BuildingManager.instance.model.getActiveOrderById(_loc7_.type);
            if(_loc5_)
            {
               _loc5_.orderId = _loc7_.type;
               _loc5_.orderType = 4;
               _loc5_.currentCount = _loc7_.current;
               _loc5_.totalCount = _loc7_.max;
               _loc5_.remainTime = _loc7_.countDownTime;
            }
            else
            {
               _loc5_ = new BuildingOrderInfo();
               _loc5_.orderId = _loc7_.type;
               _loc5_.orderType = 4;
               _loc5_.currentCount = _loc7_.current;
               _loc5_.totalCount = _loc7_.max;
               _loc5_.remainTime = _loc7_.countDownTime;
               _loc3_.push(_loc5_);
            }
         }
         BuildingManager.instance.model.setOrderList(_loc3_);
         _loc8_ = null;
         _loc2_ = null;
         activeOrderidChange();
         startOutyardTime();
      }
      
      private function __consortiaQuitHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaQuitReqMsg = new ConsortiaQuitReqMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaQuitReqMsg;
         _loc3_.currentCount = 0;
         _loc3_.totalCount = 0;
         activeOrderidChange();
      }
      
      private function __updateSpiritExpeditionInfo(param1:String, param2:Object) : void
      {
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(16);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.currentCount = spiritExpeditionModel.childList.length - spiritExpeditionModel.childCdTimeLen;
         _loc3_.totalCount = spiritExpeditionModel.childList.length;
         activeOrderidChange();
      }
      
      private function __consortiaRefreshAltar(param1:SLGSocketEvent) : void
      {
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(1);
         if(!_loc3_)
         {
            return;
         }
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaMsg;
         var _loc7_:ConsortiaTemplete = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,ConsortiaManager.instance.model.consortiaInfo.altarLevel);
         var _loc5_:int = _loc2_.blessLeftTime;
         var _loc4_:int = _loc7_.Property2;
         _loc5_ = _loc4_ - _loc5_ < 0 ? 0 : _loc4_ - _loc5_;
         _loc3_.currentCount = _loc5_;
         _loc3_.totalCount = _loc4_;
         if(_loc3_.currentCount <= 0)
         {
            activeOrderidChange();
         }
         else
         {
            _loc3_.sendDataChange();
         }
      }
      
      private function __offerRewardListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(2);
         if(!_loc3_)
         {
            return;
         }
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardFreshRspMsg = new RewardFreshRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as RewardFreshRspMsg;
         var _loc6_:int = OfferRewardManager.instance.model.maxRewardCount;
         var _loc4_:int = _loc2_.rewardTimes;
         var _loc5_:int = _loc6_ - _loc4_ > 0 ? _loc6_ - thane.rewardCount : 0;
         _loc3_.beginTime = DateFormatter.parse(_loc2_.rewardLastdate,"YYYY-MM-DD hh:mm:ss");
         _loc3_.currentCount = _loc5_;
         _loc3_.totalCount = _loc6_;
         if(_loc2_.isButton)
         {
            _loc3_.remainTime = getRefreshRemainTime(_loc3_.beginTime);
         }
         if(_loc3_.currentCount <= 0)
         {
            activeOrderidChange();
         }
         else
         {
            _loc3_.sendDataChange();
         }
      }
      
      public function getRefreshRemainTime(param1:Date) : Number
      {
         var _loc2_:Number = NaN;
         if(param1)
         {
            _loc2_ = 1800 - (playerModel.sysCurTimeBySecond - param1.time / 1000);
            if(_loc2_ > 0)
            {
               return _loc2_ > 1800 ? 1800 : _loc2_;
            }
            return 0;
         }
         return 0;
      }
      
      private function initOutyardInstance() : void
      {
         var _loc4_:BuildingOrderInfo = new BuildingOrderInfo();
         _loc4_.orderId = 3;
         _loc4_.orderType = 4;
         _loc4_.currentCount = 0;
         _loc4_.totalCount = 0;
         var _loc1_:BuildingOrderInfo = new BuildingOrderInfo();
         _loc1_.orderId = 15;
         _loc1_.orderType = 4;
         _loc1_.currentCount = 0;
         _loc1_.totalCount = 0;
         var _loc3_:BuildingOrderInfo = new BuildingOrderInfo();
         _loc3_.orderId = 13;
         _loc3_.orderType = 4;
         _loc3_.currentCount = 0;
         _loc3_.totalCount = 0;
         var _loc5_:BuildingOrderInfo = new BuildingOrderInfo();
         _loc5_.orderId = 6;
         _loc5_.orderType = 4;
         _loc5_.currentCount = 0;
         _loc5_.totalCount = 0;
         var _loc2_:BuildingOrderInfo = new BuildingOrderInfo();
         _loc2_.orderId = 5;
         _loc2_.orderType = 4;
         _loc2_.currentCount = 0;
         _loc2_.totalCount = 0;
         BuildingManager.instance.model.setOrderList([_loc4_,_loc1_,_loc3_,_loc5_,_loc2_]);
      }
      
      private function __hugeHeadMySignInState(param1:SLGSocketEvent) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:BuildingOrderInfo = model.getActiveOrderById(3);
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(15);
         var _loc4_:BuildingOrderInfo = model.getActiveOrderById(13);
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:HugeHeadMySignInStateMsg = new HugeHeadMySignInStateMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as HugeHeadMySignInStateMsg;
         if(_loc6_)
         {
            _loc5_ = _loc6_.property2;
         }
         if(_loc3_)
         {
            _loc5_ = _loc3_.property2;
         }
         if(_loc4_)
         {
            _loc5_ = _loc4_.property2;
         }
         if(_loc5_ == _loc2_.selfJoin)
         {
            return;
         }
         if(_loc6_)
         {
            _loc6_.property2 = _loc2_.selfJoin;
         }
         if(_loc3_)
         {
            _loc3_.property2 = _loc2_.selfJoin;
         }
         if(_loc4_)
         {
            _loc4_.property2 = _loc2_.selfJoin;
         }
         activeOrderidChange();
      }
      
      private function __selfInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(3);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:StackHeadSelfMsg = new StackHeadSelfMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as StackHeadSelfMsg;
         _loc3_.currentCount = _loc2_.actionPoint;
         _loc3_.sendDataChange();
         startOutyardTime();
      }
      
      private function __shuttleHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:BuildingOrderInfo = model.getActiveOrderById(15);
         if(!_loc4_)
         {
            return;
         }
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShuttleInfoMsg = new ShuttleInfoMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ShuttleInfoMsg;
         var _loc3_:int = ConfigInfoManager.instance.getShuttleResetFree();
         var _loc5_:int = _loc3_ - _loc2_.resetCount > 0 ? _loc3_ - _loc2_.resetCount : 0;
         _loc4_.currentCount = _loc5_;
         _loc4_.sendDataChange();
      }
      
      private function __stackHeadState(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:HugeHeadStateMsg = new HugeHeadStateMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as HugeHeadStateMsg;
         var _loc9_:BuildingOrderInfo = model.getActiveOrderById(3);
         if(_loc9_)
         {
            _loc5_ = _loc9_.property1;
            if(_loc5_ == 0 && _loc2_.stackHeadState != 0)
            {
               _loc9_.property1 = _loc2_.stackHeadState;
               activeOrderidChange();
               startOutyardTime();
            }
            if(_loc5_ != 0 && _loc2_.stackHeadState == 0)
            {
               _loc9_.property1 = _loc2_.stackHeadState;
               activeOrderidChange();
            }
            _loc9_.property1 = _loc2_.stackHeadState;
         }
         var _loc6_:BuildingOrderInfo = model.getActiveOrderById(15);
         if(_loc6_)
         {
            _loc4_ = _loc6_.property1;
            if(_loc4_ == 0 && _loc2_.hugeHeadState != 0)
            {
               _loc6_.property1 = _loc2_.hugeHeadState;
               activeOrderidChange();
            }
            if(_loc4_ != 0 && _loc2_.hugeHeadState == 0)
            {
               _loc6_.property1 = _loc2_.hugeHeadState;
               activeOrderidChange();
            }
            _loc6_.property1 = _loc2_.hugeHeadState;
         }
         var _loc7_:BuildingOrderInfo = model.getActiveOrderById(13);
         if(_loc7_)
         {
            _loc3_ = _loc7_.property1;
            if(_loc3_ == 0 && _loc2_.hugeHeadState != 0 && _loc2_.hugeHeadState != 1)
            {
               _loc7_.property1 = _loc2_.hugeHeadState;
               activeOrderidChange();
            }
            if(_loc3_ != 0 && _loc2_.hugeHeadState == 0)
            {
               _loc7_.property1 = _loc2_.hugeHeadState;
               activeOrderidChange();
            }
            _loc7_.property1 = _loc2_.hugeHeadState;
         }
      }
      
      private function __updateNavigationData(param1:SLGSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:BuildingOrderInfo = model.getActiveOrderById(4);
         if(!_loc6_)
         {
            return;
         }
         var _loc12_:PackageIn = param1.data as PackageIn;
         var _loc2_:NavigationMsg = new NavigationMsg();
         _loc2_ = _loc12_.readBody(_loc2_) as NavigationMsg;
         if(!_loc2_.port)
         {
            return;
         }
         for each(var _loc3_:NavigationPortMsg in _loc2_.port)
         {
            _loc4_ = Int64Utils.int64ToNumber(_loc3_.cd);
            _loc5_ = _loc4_ < playerModel.sysCurTimeBySecond;
            if(StringHelper.isNullOrEmpty(_loc3_.shippingBoatId) && _loc5_)
            {
               _loc7_++;
            }
         }
         var _loc9_:Boolean = false;
         var _loc11_:int = int(_loc6_.info.strength);
         if(_loc11_ != _loc2_.strength && (_loc11_ == 0 || _loc2_.strength == 0))
         {
            _loc9_ = true;
         }
         _loc6_.info.strength = _loc2_.strength;
         _loc6_.currentCount = _loc7_;
         _loc6_.totalCount = 3;
         if(_loc9_)
         {
            activeOrderidChange();
         }
         else
         {
            _loc6_.sendDataChange();
         }
      }
      
      private function __petchallengeTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(5);
         if(!_loc3_)
         {
            return;
         }
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeCoolTimeMsg = new ChallengeCoolTimeMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChallengeCoolTimeMsg;
         if(_loc2_.type != 1)
         {
            return;
         }
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Pet_Challenge_Count");
         _loc3_.currentCount = _loc2_.challengeCount;
         _loc3_.totalCount = parseInt(_loc4_.ConfigValue);
         _loc3_.remainTime = _loc2_.leftTime;
         if(_loc3_.currentCount <= 0)
         {
            activeOrderidChange();
         }
         else
         {
            _loc3_.sendDataChange();
         }
      }
      
      private function __colosseumTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:BuildingOrderInfo = BuildingManager.instance.model.colosseumOrderList[0];
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeCoolTimeMsg = new ChallengeCoolTimeMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ChallengeCoolTimeMsg;
         if(_loc2_.type != 0)
         {
            return;
         }
         _loc5_.currentCount = _loc2_.challengeCount;
         _loc5_.totalCount = _loc2_.totalCount;
         _loc5_.totalBuyCount = _loc2_.totalBuyCount;
         _loc5_.remainTime = _loc2_.leftTime;
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(6);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.currentCount = _loc2_.challengeCount;
         _loc3_.totalCount = _loc2_.totalCount;
         _loc3_.totalBuyCount = _loc2_.totalBuyCount;
         _loc3_.remainTime = _loc2_.leftTime;
         if(_loc3_.currentCount <= 0)
         {
            activeOrderidChange();
         }
         else
         {
            _loc3_.sendDataChange();
         }
      }
      
      private function __refreshChildPveBossInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(7);
         if(!_loc3_)
         {
            return;
         }
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc9_:GuardPVERspMsg = new GuardPVERspMsg();
         _loc9_ = _loc8_.readBody(_loc9_) as GuardPVERspMsg;
         var _loc2_:Array = ChildPatrolManager.instance.model.towerInfoList;
         for each(var _loc5_:ChildPatrolTowerInfo in _loc2_)
         {
            if(_loc5_.bossState == 1)
            {
               _loc7_++;
            }
            if(_loc5_.towerId != 100)
            {
               _loc6_++;
            }
         }
         if(_loc6_ == 0)
         {
            return;
         }
         _loc3_.currentCount = _loc6_ - _loc7_;
         _loc3_.totalCount = _loc6_;
         if(_loc3_.currentCount <= 0)
         {
            activeOrderidChange();
         }
         else
         {
            _loc3_.sendDataChange();
         }
      }
      
      private function __skyBoxRoadHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BuildingOrderInfo = model.getActiveOrderById(8);
         if(!_loc3_)
         {
            return;
         }
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTrialInfoMsg = new SkyTrialInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SkyTrialInfoMsg;
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_max_energy");
         _loc3_.currentCount = _loc2_.energy;
         _loc3_.totalCount = int(_loc4_.ConfigValue);
         activeOrderidChange();
      }
      
      private function __playerExtraFieldHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:ExtraFieldInfoMsg = null;
         var _loc5_:int = 0;
         var _loc3_:BuildingOrderInfo = null;
         var _loc7_:ConfigInfosTempInfo = null;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:BuildingOrderInfo = null;
         var _loc9_:ConfigInfosTempInfo = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerExtraFieldMsg = new PlayerExtraFieldMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PlayerExtraFieldMsg;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.extraField.length)
         {
            _loc10_ = _loc2_.extraField[_loc5_];
            if(_loc10_.fieldId == 9)
            {
               _loc3_ = model.getActiveOrderById(10);
               if(_loc3_)
               {
                  _loc7_ = TempleteManager.instance.getConfigInfoByConfigName("archaeology_max_count");
                  _loc4_ = int(_loc10_.value);
                  _loc11_ = parseInt(_loc7_.ConfigValue) - _loc4_;
                  _loc3_.currentCount = _loc11_;
                  _loc3_.totalCount = parseInt(_loc7_.ConfigValue);
                  activeOrderidChange();
               }
            }
            if(_loc10_.fieldId == 15)
            {
               _loc6_ = model.getActiveOrderById(13);
               if(_loc6_)
               {
                  _loc9_ = TempleteManager.instance.getConfigInfoByConfigName("huge_head_explore_point");
                  _loc6_.totalCount = parseInt(_loc9_.ConfigValue);
                  _loc6_.currentCount = int(_loc10_.value);
                  _loc6_.sendDataChange();
               }
            }
            _loc5_++;
         }
      }
      
      private function __heroLevelUpdate(param1:PlayerEvent) : void
      {
         if(thane.preGrade != 50 && thane.grades >= 50)
         {
            activeOrderidChange();
         }
      }
      
      private function activeOrderidChange() : void
      {
         dispatchEvent(new Event("ACTIVE_ORDERID_CHANGE"));
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : BuildingModel
      {
         return BuildingManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get spiritExpeditionModel() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      private function startOutyardTime() : void
      {
         var _loc1_:BuildingOrderInfo = model.getActiveOrderById(3);
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_.currentCount < _loc1_.totalCount)
         {
            remainTime = 1800;
         }
      }
      
      private function set remainTime(param1:Number) : void
      {
         _remainTime = param1;
         if(_remainTime > 0)
         {
            if(!_time)
            {
               _time = new Timer(1000);
            }
            _time.addEventListener("timer",__updateEnergyTimeHandler);
            _time.reset();
            _time.start();
         }
      }
      
      private function __updateEnergyTimeHandler(param1:TimerEvent) : void
      {
         var _loc4_:ActiveQueueMsg = null;
         var _loc2_:Array = null;
         var _loc3_:ActiveQueueListMsg = null;
         _remainTime = _remainTime - 1;
         if(_remainTime <= 0)
         {
            _loc4_ = new ActiveQueueMsg();
            _loc4_.type = 3;
            _loc2_ = [_loc4_];
            _loc3_ = new ActiveQueueListMsg();
            _loc3_.list = _loc2_;
            _loc3_.op = 4;
            sendActiveQueueRequest(_loc3_);
            if(_time)
            {
               _time.removeEventListener("timer",__updateEnergyTimeHandler);
               _time.stop();
            }
         }
      }
      
      private function sendActiveQueueRequest(param1:ActiveQueueListMsg) : void
      {
         var _loc2_:PackageOut = new PackageOut(9612);
         SocketManager.instance.socket.sendProtobuffer(_loc2_,param1);
      }
   }
}

