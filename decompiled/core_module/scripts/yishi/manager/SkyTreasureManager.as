package yishi.manager
{
   import com.road.yishi.proto.active.ItemInfoMsg;
   import com.road.yishi.proto.active.PlayerCrashInfoMsg;
   import com.road.yishi.proto.active.PlayerJoinInfoMsg;
   import com.road.yishi.proto.active.PlayerRankMsg;
   import com.road.yishi.proto.active.RewardInfoMsg;
   import com.road.yishi.proto.active.TreasureHuntActiveMsg;
   import com.road.yishi.proto.active.TreasureHuntOpMsg;
   import com.road.yishi.proto.active.TreasureRankMsg;
   import com.road.yishi.proto.cccactive.ActiveInfoPB;
   import com.road.yishi.proto.cccactive.ActiveRankPB;
   import com.road.yishi.proto.cccactive.LotteryRecordPB;
   import com.road.yishi.proto.cccactive.SkyTreasureActiveTempInfoRes;
   import com.road.yishi.proto.cccactive.SkyTreasureAwardHistoryPB;
   import com.road.yishi.proto.cccactive.SkyTreasureAwardHistoryRes;
   import com.road.yishi.proto.cccactive.SkyTreasureExchangeActivePB;
   import com.road.yishi.proto.cccactive.SkyTreasureExchangeInfoRes;
   import com.road.yishi.proto.cccactive.SkyTreasureExchangeReq;
   import com.road.yishi.proto.cccactive.SkyTreasureExchangeRes;
   import com.road.yishi.proto.cccactive.SkyTreasureLotteryPB;
   import com.road.yishi.proto.cccactive.SkyTreasureLotteryRecordReq;
   import com.road.yishi.proto.cccactive.SkyTreasureLotteryRecordRes;
   import com.road.yishi.proto.cccactive.SkyTreasureLotteryReq;
   import com.road.yishi.proto.cccactive.SkyTreasurePlayerInfoRes;
   import com.road.yishi.proto.cccactive.SkyTreasureRankInfoPB;
   import com.road.yishi.proto.cccactive.SkyTreasureRankInfoRes;
   import events.SkyTreasureEvent;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureLotteryDataInfo;
   import mvc.module.skytreasure.SkyTreasureModel;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import mvc.module.skytreasure.info.SkyTreasureHuntActiveVO;
   import mvc.module.skytreasure.info.SkyTreasureItemInfoVO;
   import mvc.module.skytreasure.info.SkyTreasurePlayerRankInfoVO;
   import mvc.module.skytreasure.info.SkyTreasurePlayerVO;
   import mvc.module.skytreasure.info.SkyTreasureRewardInfoVO;
   import ui.toptoolbar.TopToolsBar;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class SkyTreasureManager extends EventDispatcher
   {
      
      public static const STATE_START:int = 1;
      
      public static const STATE_STOP:int = 2;
      
      private static var _instance:SkyTreasureManager;
      
      public static const CHARGE:int = 1;
      
      public static const GETREWARD:int = 2;
      
      public static const REQUEST_ACTIVE:int = 3;
      
      public static const REQUEST_RANK:int = 4;
      
      public static const COMMON_CHARGE:int = 1;
      
      public static const SENOIR_CHARGE:int = 2;
      
      public static const HIT_BOX:int = 5;
      
      public static const SPEEDUP:int = 6;
      
      public static const FINISH:int = 7;
      
      public static const START:int = 8;
      
      public static const ACTIVE_END:int = 9;
      
      private var _modelNew:SkyTreasureModelNew;
      
      private var _isLotteryNeedTip:Boolean = true;
      
      private var _state:int = 0;
      
      private var _model:SkyTreasureModel;
      
      public var isOpen:Boolean;
      
      public var startTime:Number;
      
      public var endTime:Number;
      
      private var _timer1:Timer;
      
      public function SkyTreasureManager()
      {
         super();
      }
      
      public static function get Instance() : SkyTreasureManager
      {
         if(!_instance)
         {
            _instance = new SkyTreasureManager();
         }
         return _instance;
      }
      
      public function get modelNew() : SkyTreasureModelNew
      {
         if(!_modelNew)
         {
            _modelNew = new SkyTreasureModelNew();
         }
         return _modelNew;
      }
      
      public function get isLotteryNeedTip() : Boolean
      {
         return _isLotteryNeedTip;
      }
      
      public function set isLotteryNeedTip(param1:Boolean) : void
      {
         if(_isLotteryNeedTip == param1)
         {
            return;
         }
         _isLotteryNeedTip = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function isStart() : Boolean
      {
         if(_state == 1)
         {
            return true;
         }
         return false;
      }
      
      public function get model() : SkyTreasureModel
      {
         if(_model == null)
         {
            _model = new SkyTreasureModel();
         }
         return _model;
      }
      
      public function setup() : void
      {
         createModel();
         initEvent();
      }
      
      private function createModel() : void
      {
         if(!_modelNew)
         {
            _modelNew = new SkyTreasureModelNew();
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4769,__skyTreasureHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4956,__hitBox);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4770,__skyTreasureRankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 772,__updateSkyTreasureRankInfoRes);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 773,__updateSkyTreasureAwardHistoryRes);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 774,__updateSkyTreasureLotteryInfoRes);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 775,__updateSkyTreasureLotteryRecordRes);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 776,__updateSkyTreasureExchangeInfoRes);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 777,__updateSkyTreasureExchangeRes);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 778,__updateSkyTreasureActiveTempInfoRes);
      }
      
      protected function __hitBox(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerCrashInfoMsg = new PlayerCrashInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerCrashInfoMsg;
         if(_loc2_.param == 9)
         {
            isOpen = false;
            sendDispatchEvent("SKYTREASURE_ACTIVES_INFO");
         }
         if(_loc2_ != null)
         {
            model.joinInfoVO.height = _loc2_.height;
         }
         if(_loc2_.param == 5)
         {
            if(_loc2_ != null)
            {
               model.joinInfoVO.integral = _loc2_.crashScore;
            }
            sendDispatchEvent("SKYTREASURE_RANK_UPDATE");
         }
         if(_loc2_.param == 6)
         {
            if(_loc2_ != null)
            {
               model.joinInfoVO.integral = _loc2_.crashScore;
            }
            sendDispatchEvent("SKYTREASURE_SPEEDUP",_loc2_);
         }
         if(_loc2_.param == 7)
         {
            sendDispatchEvent("SKYTREASURE_FINISH");
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __skyTreasureHandler(param1:SLGSocketEvent) : void
      {
         var _loc13_:Array = null;
         var _loc18_:Array = null;
         var _loc4_:int = 0;
         var _loc17_:SkyTreasureRewardInfoVO = null;
         var _loc6_:SkyTreasureItemInfoVO = null;
         var _loc14_:RewardInfoMsg = null;
         var _loc3_:ItemInfoMsg = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc15_:SkyTreasureRewardInfoVO = null;
         var _loc11_:int = 0;
         var _loc20_:SkyTreasureItemInfoVO = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:TreasureHuntActiveMsg = new TreasureHuntActiveMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as TreasureHuntActiveMsg;
         var _loc9_:SkyTreasureHuntActiveVO = new SkyTreasureHuntActiveVO();
         _loc9_.activeId = _loc2_.activeId;
         _loc9_.beginDate = DateFormatter.parse(_loc2_.beginDate,"YYYY-MM-DD hh:mm:ss").getTime();
         _loc9_.endDate = DateFormatter.parse(_loc2_.endDate,"YYYY-MM-DD hh:mm:ss").getTime();
         _loc9_.isOpen = _loc2_.isOpen;
         isOpen = _loc2_.isOpen;
         startTime = DateFormatter.parse(_loc2_.beginDate,"YYYY-MM-DD hh:mm:ss").getTime();
         endTime = DateFormatter.parse(_loc2_.endDate,"YYYY-MM-DD hh:mm:ss").getTime();
         TopToolsBar.instance.show();
         if(!model.joinInfoVO)
         {
            model.joinInfoVO = new SkyTreasurePlayerVO();
         }
         var _loc19_:PlayerJoinInfoMsg = new PlayerJoinInfoMsg();
         _loc19_ = _loc2_.joinInfo;
         if(_loc19_ != null)
         {
            model.joinInfoVO.updateHeightAndIntegral(_loc19_.height);
            model.joinInfoVO.rank = _loc19_.rank;
            model.joinInfoVO.actionEnergy = _loc19_.actionEnergy;
            _loc9_.joinInfo.height = _loc19_.height;
            _loc9_.joinInfo.rank = _loc19_.rank;
         }
         _loc13_ = _loc2_.rewards;
         model.chargeRewardList = new Vector.<SkyTreasureRewardInfoVO>();
         model.chargeRewardsListCountArray = [];
         model.chargeRewardsListTemplateIdArray = [];
         var _loc12_:Array = [];
         var _loc16_:Array = [];
         if(_loc13_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc13_.length)
            {
               if((_loc13_[_loc4_] as RewardInfoMsg).type == 1)
               {
                  _loc12_.push(_loc13_[_loc4_]);
               }
               else
               {
                  _loc16_.push(_loc13_[_loc4_]);
               }
               _loc4_++;
            }
         }
         _loc12_.sort(sortList);
         _loc16_.sort(sortList);
         _loc5_ = 0;
         while(_loc5_ < _loc12_.length)
         {
            _loc14_ = _loc12_[_loc5_] as RewardInfoMsg;
            _loc17_ = new SkyTreasureRewardInfoVO();
            _loc17_.packageId = _loc14_.packageId;
            _loc17_.statu = _loc14_.statu;
            _loc17_.param = _loc14_.param;
            _loc17_.type = _loc14_.type;
            _loc18_ = _loc14_.items;
            _loc7_ = 0;
            while(_loc7_ < _loc18_.length)
            {
               _loc3_ = _loc18_[_loc7_] as ItemInfoMsg;
               _loc6_ = new SkyTreasureItemInfoVO();
               _loc6_.templateId = _loc3_.templateId;
               _loc6_.count = _loc3_.count;
               _loc17_.itemsList.push(_loc6_);
               model.chargeRewardsListTemplateIdArray.push(_loc6_.templateId);
               model.chargeRewardsListCountArray.push(_loc6_.count);
               _loc6_ = null;
               _loc3_ = null;
               _loc7_++;
            }
            model.chargeRewardList.push(_loc17_);
            _loc17_ = null;
            _loc14_ = null;
            _loc5_++;
         }
         model.chargeRewardList.sort(sortList2);
         model.rankRewardsListTemplateIdArray = [];
         model.rankRewardsListCountArray = [];
         model.ranRewardsList = new Vector.<SkyTreasureRewardInfoVO>();
         _loc10_ = 0;
         while(_loc10_ < _loc16_.length)
         {
            _loc15_ = new SkyTreasureRewardInfoVO();
            _loc15_.packageId = (_loc16_[_loc10_] as RewardInfoMsg).packageId;
            _loc15_.statu = (_loc16_[_loc10_] as RewardInfoMsg).statu;
            _loc15_.param = (_loc16_[_loc10_] as RewardInfoMsg).param;
            _loc15_.type = (_loc16_[_loc10_] as RewardInfoMsg).type;
            _loc18_ = (_loc16_[_loc10_] as RewardInfoMsg).items;
            _loc11_ = 0;
            while(_loc11_ < _loc18_.length)
            {
               _loc20_ = new SkyTreasureItemInfoVO();
               _loc20_.templateId = (_loc18_[_loc11_] as ItemInfoMsg).templateId;
               _loc20_.count = (_loc18_[_loc11_] as ItemInfoMsg).count;
               _loc15_.itemsList.push(_loc20_);
               model.rankRewardsListTemplateIdArray.push(_loc20_.templateId);
               model.rankRewardsListCountArray.push(_loc20_.count);
               _loc11_++;
            }
            model.ranRewardsList.push(_loc15_);
            _loc10_++;
         }
         model.ranRewardsList.sort(sortList2);
         sendDispatchEvent("SKYTREASURE_ACTIVES_INFO");
      }
      
      private function sortList2(param1:SkyTreasureRewardInfoVO, param2:SkyTreasureRewardInfoVO) : int
      {
         if(param1.param < param2.param)
         {
            return -1;
         }
         if(param1.param > param2.param)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortList(param1:RewardInfoMsg, param2:RewardInfoMsg) : int
      {
         if(param1.param < param2.param)
         {
            return -1;
         }
         if(param1.param > param2.param)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortList3(param1:SkyTreasurePlayerRankInfoVO, param2:SkyTreasurePlayerRankInfoVO) : int
      {
         if(param1.rank < param2.rank)
         {
            return -1;
         }
         if(param1.rank > param2.rank)
         {
            return 1;
         }
         return 0;
      }
      
      private function __skyTreasureRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:SkyTreasurePlayerRankInfoVO = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TreasureRankMsg = new TreasureRankMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TreasureRankMsg;
         _loc3_ = _loc2_.rankInfos;
         model.rankList = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = new SkyTreasurePlayerRankInfoVO();
            _loc5_.userId = (_loc3_[_loc4_] as PlayerRankMsg).userId;
            _loc5_.nickname = (_loc3_[_loc4_] as PlayerRankMsg).nickname;
            _loc5_.height = (_loc3_[_loc4_] as PlayerRankMsg).height;
            _loc5_.rank = (_loc3_[_loc4_] as PlayerRankMsg).rank;
            model.rankList.push(_loc5_);
            _loc4_++;
         }
         model.rankList.sort(sortList3);
         sendDispatchEvent("SKYTREASURE_RANK_UPDATE");
      }
      
      public function sendDispatchEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new SkyTreasureEvent(param1,param2));
      }
      
      public function getBoxGoods() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function commonCharge() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 1;
         _loc1_.feedType = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function senoirCharge() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 1;
         _loc1_.feedType = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function getActivesInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 3;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function getRanksInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 4;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendHitBox() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 5;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendSpeedup() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 6;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendFinish() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 7;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendStart() : void
      {
         var _loc2_:PackageOut = new PackageOut(8966);
         var _loc1_:TreasureHuntOpMsg = new TreasureHuntOpMsg();
         _loc1_.opType = 8;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      private function __updateSkyTreasureRankInfoRes(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTreasureRankInfoRes = new SkyTreasureRankInfoRes();
         _loc2_ = _loc5_.readBody(_loc2_) as SkyTreasureRankInfoRes;
         for each(var _loc3_:SkyTreasureRankInfoPB in _loc2_.info)
         {
            _loc4_ = int(_modelNew.findSkyTreasureActTempInfoByActId(_loc3_.activeId) ? _modelNew.findSkyTreasureActTempInfoByActId(_loc3_.activeId).actType : 0);
            if(_modelNew.actIsRoundRankType(_loc4_))
            {
               _modelNew.createRoundRankInfo(_loc3_);
            }
            else if(_modelNew.actIsTotalRankType(_loc4_))
            {
               _modelNew.createTotalRankInfo(_loc3_);
            }
         }
         MsgMan.notifyObserver("SKYTREASURE1");
         timeHandler1(null);
         dispatchEvent(new SkyTreasureEvent("SKY_TREASURE_RANKINFO_UPDATE"));
      }
      
      private function __updateSkyTreasureAwardHistoryRes(param1:SLGSocketEvent) : void
      {
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTreasureAwardHistoryRes = new SkyTreasureAwardHistoryRes();
         _loc2_ = _loc7_.readBody(_loc2_) as SkyTreasureAwardHistoryRes;
         _modelNew.delteteAllSkyTreasureRankRecordInfo();
         for each(var _loc3_:SkyTreasureAwardHistoryPB in _loc2_.info)
         {
            _loc6_ = [];
            for each(var _loc5_:ActiveRankPB in _loc3_.ranks)
            {
               _loc6_.push({
                  "rank":_loc5_.rank,
                  "server":_loc5_.site,
                  "name":_loc5_.nickName || _loc5_.userName,
                  "score":_loc5_.score
               });
            }
            _loc4_ = int(_loc3_.self ? _loc3_.self.rank : 0);
            _modelNew.addskyTreasureRankRecordInfo(_loc3_.activeId,_loc3_.desc,_loc6_,_loc4_,_loc3_.self ? _loc3_.self.score : 0);
         }
         MsgMan.notifyObserver("SKYTREASURE1");
         timeHandler1(null);
         dispatchEvent(new SkyTreasureEvent("SKY_TREASURE_RANKHISTORY_UPDATE"));
      }
      
      private function __updateSkyTreasureLotteryInfoRes(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTreasurePlayerInfoRes = new SkyTreasurePlayerInfoRes();
         _loc2_ = _loc4_.readBody(_loc2_) as SkyTreasurePlayerInfoRes;
         for each(var _loc3_:SkyTreasureLotteryPB in _loc2_.info)
         {
            _modelNew.addTreasureLotteryDataInfo(_loc3_);
         }
         dispatchEvent(new SkyTreasureEvent("SKY_TREASURE_LOTTERYINFO_UPDATE"));
         MsgMan.notifyObserver("SKYTREASURE1");
         timeHandler1(null);
      }
      
      private function __updateSkyTreasureLotteryRecordRes(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTreasureLotteryRecordRes = new SkyTreasureLotteryRecordRes();
         _loc2_ = _loc5_.readBody(_loc2_) as SkyTreasureLotteryRecordRes;
         _modelNew.deleteSelfSkyTreasureRecordArray();
         _modelNew.delteteAllSkyTreasureRecordArray();
         for each(var _loc3_:LotteryRecordPB in _loc2_.selfRecord)
         {
            _modelNew.addSkyTreasureRecordInfo(_loc3_.time,_loc3_.serverId,_loc3_.nickName,_loc3_.activeName,_loc3_.itemId,_loc3_.itemCount,false);
         }
         for each(var _loc4_:LotteryRecordPB in _loc2_.serverRecord)
         {
            _modelNew.addSkyTreasureRecordInfo(_loc4_.time,_loc4_.serverId,_loc4_.nickName,_loc4_.activeName,_loc4_.itemId,_loc4_.itemCount,true);
         }
         dispatchEvent(new SkyTreasureEvent("SKY_TREASURE_LOTTERYRECORD_UPDATE"));
         MsgMan.notifyObserver("SKYTREASURE1");
         timeHandler1(null);
      }
      
      private function __updateSkyTreasureExchangeInfoRes(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTreasureExchangeInfoRes = new SkyTreasureExchangeInfoRes();
         _loc2_ = _loc4_.readBody(_loc2_) as SkyTreasureExchangeInfoRes;
         _modelNew._skyTreasureExchangeItemInfo = [];
         for each(var _loc3_:SkyTreasureExchangeActivePB in _loc2_.exchangeInfo)
         {
            _modelNew.addSkyTreasureExchangeItemInfo(_loc3_);
         }
         dispatchEvent(new SkyTreasureEvent("SKY_TREASURE_EXCHANGEINFO_UPDATE"));
         MsgMan.notifyObserver("SKYTREASURE1");
         timeHandler1(null);
      }
      
      private function __updateSkyTreasureExchangeRes(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTreasureExchangeRes = new SkyTreasureExchangeRes();
         _loc2_ = _loc3_.readBody(_loc2_) as SkyTreasureExchangeRes;
         if(_loc2_.hasInfo)
         {
            _modelNew.addSkyTreasureExchangeItemInfo(_loc2_.info);
            dispatchEvent(new SkyTreasureEvent("SKY_TREASURE_EXCHANGEINFO_UPDATE"));
         }
         MsgMan.notifyObserver("SKYTREASURE1");
         timeHandler1(null);
      }
      
      private function __updateSkyTreasureActiveTempInfoRes(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTreasureActiveTempInfoRes = new SkyTreasureActiveTempInfoRes();
         _loc2_ = _loc4_.readBody(_loc2_) as SkyTreasureActiveTempInfoRes;
         for each(var _loc3_:ActiveInfoPB in _loc2_.info)
         {
            _modelNew.addSkyTreasureActTempInfo(_loc3_);
         }
         MsgMan.notifyObserver("SKYTREASURE1");
         timeHandler1(null);
         dispatchEvent(new SkyTreasureEvent("SKY_TREASURE_ACTTEMPLATEINFO_UPDATE"));
      }
      
      private function timeHandler1(param1:TimerEvent) : void
      {
         var _loc4_:SkyTreasureActTemplateInfo = null;
         var _loc2_:SkyTreasureLotteryDataInfo = null;
         var _loc5_:int = 0;
         if(_timer1 == null)
         {
            _timer1 = new Timer(1000);
            _timer1.addEventListener("timer",timeHandler1);
            _timer1.start();
         }
         var _loc3_:Number = 0;
         if(modelNew.getAllSkyTreasureFrameOpenActTempData().length == 0)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < modelNew.getAllSkyTreasureFrameOpenActTempData().length)
         {
            _loc4_ = modelNew.getAllSkyTreasureFrameOpenActTempData()[_loc5_];
            _loc2_ = modelNew.findSkyTreasureLotteryDataInfo(_loc4_.actId);
            if(_loc2_)
            {
               if(_loc3_ > _loc2_.freeLotteryLeftTimes || _loc3_ == 0)
               {
                  _loc3_ = _loc2_.freeLotteryLeftTimes;
               }
            }
            _loc5_++;
         }
         if(--_loc3_ <= 0)
         {
            _timer1.stop();
            _timer1.removeEventListener("timer",timeHandler1);
            _timer1 = null;
            MsgMan.notifyObserver("SKYTREASURE1");
         }
      }
      
      public function sendSkyTreasureLotteryReq(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9025);
         var _loc3_:SkyTreasureLotteryReq = new SkyTreasureLotteryReq();
         _loc3_.activeId = param1;
         _loc3_.count = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendSkyTreasureLotteryRecordReq(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(9026);
         var _loc2_:SkyTreasureLotteryRecordReq = new SkyTreasureLotteryRecordReq();
         _loc2_.activeId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendSkyTreasureExchangeReq(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(9027);
         var _loc4_:SkyTreasureExchangeReq = new SkyTreasureExchangeReq();
         _loc4_.activeId = param1;
         _loc4_.templateId = param2;
         _loc4_.count = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendSkyTreasureRankInfoReq() : void
      {
         var _loc1_:PackageOut = new PackageOut(9030);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
         _loc1_ = new PackageOut(9032);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function sendSkyTreasureRankHistroyInfoReq() : void
      {
         var _loc1_:PackageOut = new PackageOut(9031);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
   }
}

