package managers
{
   import com.road.yishi.proto.party.OrderInfoMsg;
   import com.road.yishi.proto.party.PartyMsg;
   import com.road.yishi.proto.party.PartyOpMsg;
   import com.road.yishi.proto.party.PartyOrdersMsg;
   import com.road.yishi.proto.party.PartyRewardMsg;
   import mvc.module.raveparty.RavePartyModel;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import mvc.module.raveparty.RavePartySortInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class RavePartyManager
   {
      
      private static var _instance:RavePartyManager;
      
      private var _model:RavePartyModel;
      
      public function RavePartyManager()
      {
         super();
      }
      
      public static function get instance() : RavePartyManager
      {
         if(!_instance)
         {
            _instance = new RavePartyManager();
         }
         return _instance;
      }
      
      public function get model() : RavePartyModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new RavePartyModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 393,__updatePartyTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 400,__updatePartyUserInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 401,__updatePartyOpenStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 402,__updatePartyGuildSortHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 403,__updatePartyServerSortHandler);
      }
      
      private function __updatePartyTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PartyMsg = new PartyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PartyMsg;
         if(_loc2_.hasOpenTime)
         {
            model.openTime = _loc2_.openTime;
         }
         if(_loc2_.hasStopTime)
         {
            model.stopTime = _loc2_.stopTime;
         }
         if(_loc2_.hasChargeScoreSet)
         {
            model.chargeScoreSet = _loc2_.chargeScoreSet;
         }
         if(_loc2_.hasConsumScoreSet)
         {
            model.consumScoreSet = _loc2_.consumScoreSet;
         }
         if(_loc2_.chargeReward)
         {
            model.chargeRewardList.length = 0;
            model.chargeRewardList = resolveMsgToArr(_loc2_.chargeReward);
         }
         if(_loc2_.comsumReward)
         {
            model.consumRewardList.length = 0;
            model.consumRewardList = resolveMsgToArr(_loc2_.comsumReward);
         }
         if(_loc2_.leedsReward)
         {
            model.leedsRewardList.length = 0;
            model.leedsRewardList = resolveMsgToArr(_loc2_.leedsReward);
         }
         if(_loc2_.playerScoreReward)
         {
            model.playerScoreRewardList.length = 0;
            model.playerScoreRewardList = resolveMsgToArr(_loc2_.playerScoreReward);
         }
         if(_loc2_.consortiaScoreReward)
         {
            model.guildScoreRewardList.length = 0;
            model.guildScoreRewardList = resolveMsgToArr(_loc2_.consortiaScoreReward);
         }
         if(_loc2_.serverScoreReward)
         {
            model.serverScoreRewardList.length = 0;
            model.serverScoreRewardList = resolveMsgToArr(_loc2_.serverScoreReward);
         }
         if(_loc2_.consortiaCrossOrderReward)
         {
            model.guildSortRewardList.length = 0;
            model.guildSortRewardList = resolveMsgToArr(_loc2_.consortiaCrossOrderReward);
         }
         if(_loc2_.serverCrossOrderReward)
         {
            model.serverSortRewardList.length = 0;
            model.serverSortRewardList = resolveMsgToArr(_loc2_.serverCrossOrderReward);
         }
         model.hasTempData = true;
         MsgMan.notifyObserver("RAVE_PARTY_TEMP_UPDTAE");
      }
      
      private function resolveMsgToArr(param1:Array) : Array
      {
         var _loc3_:RavePartyRewardInfo = null;
         var _loc4_:Array = [];
         for each(var _loc2_:PartyRewardMsg in param1)
         {
            _loc3_ = new RavePartyRewardInfo();
            _loc3_.uuid = _loc2_.uUid;
            _loc3_.rewardType = _loc2_.rewardType;
            _loc3_.rewardLevel = _loc2_.rewardLevel;
            _loc3_.needValue = _loc2_.needValue1;
            _loc3_.startRank = _loc2_.needOrder1;
            _loc3_.endRank = _loc2_.needOrder2;
            _loc3_.rewardScore = _loc2_.rewardScore;
            _loc3_.rewardItem1 = _loc2_.templateIds1;
            _loc3_.rewardItem2 = _loc2_.templateIds2;
            _loc3_.rewardItem3 = _loc2_.templateIds3;
            _loc3_.rewardItem4 = _loc2_.templateIds4;
            _loc3_.rewardItem5 = _loc2_.templateIds5;
            _loc3_.rewardItem6 = _loc2_.templateIds6;
            _loc4_.push(_loc3_);
         }
         _loc4_.sortOn("rewardLevel",16);
         return _loc4_;
      }
      
      private function __updatePartyUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PartyMsg = new PartyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PartyMsg;
         if(_loc2_.hasMyTotalScore)
         {
            model.myTotalScore = _loc2_.myTotalScore;
         }
         if(_loc2_.hasMyChargePoint)
         {
            model.myChargePoint = _loc2_.myChargePoint;
         }
         if(_loc2_.hasMyConsumPoint)
         {
            model.myConsumPoint = _loc2_.myConsumPoint;
         }
         if(_loc2_.hasMyLeedScore)
         {
            model.myLeedScore = _loc2_.myLeedScore;
         }
         if(_loc2_.hasMyConsortiaScore)
         {
            model.myGuildScore = _loc2_.myConsortiaScore;
         }
         if(_loc2_.hasMyServerScore)
         {
            model.myServerScore = _loc2_.myServerScore;
         }
         if(_loc2_.chargeReward)
         {
            resolveRewardUserInfoState(_loc2_.chargeReward,model.chargeRewardList);
         }
         if(_loc2_.comsumReward)
         {
            resolveRewardUserInfoState(_loc2_.comsumReward,model.consumRewardList);
         }
         if(_loc2_.leedsReward)
         {
            resolveRewardUserInfoState(_loc2_.leedsReward,model.leedsRewardList);
         }
         if(_loc2_.playerScoreReward)
         {
            resolveRewardUserInfoState(_loc2_.playerScoreReward,model.playerScoreRewardList);
         }
         if(_loc2_.consortiaScoreReward)
         {
            resolveRewardUserInfoState(_loc2_.consortiaScoreReward,model.guildScoreRewardList);
         }
         if(_loc2_.serverScoreReward)
         {
            resolveRewardUserInfoState(_loc2_.serverScoreReward,model.serverScoreRewardList);
         }
         if(_loc2_.consortiaCrossOrderReward)
         {
            resolveRewardUserInfoState(_loc2_.consortiaCrossOrderReward,model.guildSortRewardList);
         }
         if(_loc2_.serverCrossOrderReward)
         {
            resolveRewardUserInfoState(_loc2_.serverCrossOrderReward,model.serverSortRewardList);
         }
         MsgMan.notifyObserver("RAVE_PARTY_USERINFO_UPDTAE");
      }
      
      public function resolveRewardUserInfoState(param1:Array, param2:Array) : void
      {
         var _loc4_:RavePartyRewardInfo = null;
         for each(var _loc3_:PartyRewardMsg in param1)
         {
            _loc4_ = model.getPartyRewardInfoByLevelAndType(_loc3_,param2);
            if(_loc4_)
            {
               _loc4_.rewardState = _loc3_.rewardState;
            }
         }
      }
      
      private function __updatePartyOpenStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PartyOpMsg = new PartyOpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PartyOpMsg;
         model.openState = _loc2_.state;
         MsgMan.notifyObserver("RAVE_PARTY_OPENSTATE_UPDTAE");
         if(model.openState == 0)
         {
            model.cleanData();
         }
      }
      
      private function __updatePartyGuildSortHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:RavePartySortInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PartyOrdersMsg = new PartyOrdersMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PartyOrdersMsg;
         if(_loc2_.hasMyOrder)
         {
            model.myGuildOrder = _loc2_.myOrder;
         }
         if(_loc2_.hasUpdateTime)
         {
            model.guildSortUpdateTime = _loc2_.updateTime;
         }
         model.guildSortList.length = 0;
         for each(var _loc3_:OrderInfoMsg in _loc2_.info)
         {
            _loc4_ = new RavePartySortInfo();
            _loc4_.order = _loc3_.order;
            _loc4_.guildName = _loc3_.consortiaName;
            _loc4_.serverName = _loc3_.serverName;
            _loc4_.score = _loc3_.partyScore;
            model.guildSortList.push(_loc4_);
         }
         model.guildSortList.sortOn("order",16);
         MsgMan.notifyObserver("RAVE_PARTY_SORT_UPDTAE",7);
      }
      
      private function __updatePartyServerSortHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:RavePartySortInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PartyOrdersMsg = new PartyOrdersMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PartyOrdersMsg;
         if(_loc2_.hasMyOrder)
         {
            model.myServerOrder = _loc2_.myOrder;
         }
         if(_loc2_.hasUpdateTime)
         {
            model.serverSortUpdateTime = _loc2_.updateTime;
         }
         model.serverSortList.length = 0;
         for each(var _loc3_:OrderInfoMsg in _loc2_.info)
         {
            _loc4_ = new RavePartySortInfo();
            _loc4_.order = _loc3_.order;
            _loc4_.guildName = _loc3_.consortiaName;
            _loc4_.serverName = _loc3_.serverName;
            _loc4_.score = _loc3_.partyScore;
            model.serverSortList.push(_loc4_);
         }
         model.serverSortList.sortOn("order",16);
         MsgMan.notifyObserver("RAVE_PARTY_SORT_UPDTAE",8);
      }
      
      public function sendRavePartyRequest(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9630);
         var _loc4_:PartyOpMsg = new PartyOpMsg();
         _loc4_.op = param1;
         if(param2 != 0)
         {
            _loc4_.takeRewardType = param2;
         }
         if(param3 != 0)
         {
            _loc4_.takeRewardLevel = param3;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}

