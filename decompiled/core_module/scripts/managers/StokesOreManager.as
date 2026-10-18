package managers
{
   import com.road.yishi.proto.active.OreActiveBaseInfoMsg;
   import com.road.yishi.proto.active.OreActiveClientOpMsg;
   import com.road.yishi.proto.active.OreMineRespMsg;
   import com.road.yishi.proto.active.OreRewardTempMsg;
   import com.road.yishi.proto.active.OreWindowMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.utils.Dictionary;
   import logging.LoggerSys;
   import mvc.module.stokesore.StokesOreModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class StokesOreManager
   {
      
      private static var _instance:StokesOreManager;
      
      private var _model:StokesOreModel;
      
      public function StokesOreManager()
      {
         super();
      }
      
      public static function get instance() : StokesOreManager
      {
         if(!_instance)
         {
            _instance = new StokesOreManager();
         }
         return _instance;
      }
      
      public function get model() : StokesOreModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new StokesOreModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 188,__updateStokesOreInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 189,__updateStokesOreCrossInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 187,__updateOpenResultInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 190,__updateOpenStatusInfo);
      }
      
      private function __updateStokesOreInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:OreActiveBaseInfoMsg = new OreActiveBaseInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as OreActiveBaseInfoMsg;
         if(_loc2_)
         {
            model.oneOpenCost = _loc2_.mineOncePrice;
            model.tenOpenCost = _loc2_.mineTimesPrice;
            model.goodsDic = new Dictionary();
            model.layerArray = [];
            for each(var _loc3_:OreRewardTempMsg in _loc2_.rewards)
            {
               model.goodsDic[_loc3_.rewardType] = _loc3_;
               if(_loc3_.rewardType != 0)
               {
                  model.layerArray.push(_loc3_.rewardType);
               }
            }
            model.layerArray.sort(16);
            model.initSpeed();
            model.updateStatus();
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __updateStokesOreCrossInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:OreWindowMsg = new OreWindowMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as OreWindowMsg;
         if(_loc2_)
         {
            model.todayLeftNumber = _loc2_.todayRemainTurns;
            model.curSeq = _loc2_.curSeq;
            model.todayLeftNumber2 = _loc2_.spRewardRemainTimes;
            model.countDown = _loc2_.countDown;
            if(model.countDown == -1)
            {
               model.startNextOre();
            }
            model.updateCrossInfo();
         }
      }
      
      private function __updateOpenResultInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:OreMineRespMsg = new OreMineRespMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as OreMineRespMsg;
         if(_loc2_.passType == 1)
         {
            LoggerSys.info("玩家 " + playerModel.playerInfo.userId + "在 " + playerModel.nowDate + "收到斯托斯矿石开采结果，获得物品个数 ==" + _loc2_.infos.length);
            if(model.oreRewardsInfo)
            {
               model.oreRewardsInfo = model.oreRewardsInfo.concat(_loc2_.infos);
            }
            else
            {
               model.oreRewardsInfo = _loc2_.infos;
            }
         }
         else if(_loc2_.passType == 2)
         {
            model.oreLuckShowInfo = _loc2_.infos;
         }
      }
      
      private function __updateOpenStatusInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.startDate = DateFormatter.parse(_loc2_.param4,"YYYY-MM-DD hh:mm:ss");
         model.endDate = DateFormatter.parse(_loc2_.param5,"YYYY-MM-DD hh:mm:ss");
         model.openStokesOre = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function sendClientOperation(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,35);
         var _loc3_:OreActiveClientOpMsg = new OreActiveClientOpMsg();
         _loc3_.opType = param1;
         _loc3_.isUseProp = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         if(param1 == 1)
         {
            LoggerSys.info("玩家 " + playerModel.playerInfo.userId + "在 " + playerModel.nowDate + " 开采1次斯托斯矿石");
         }
         else if(param1 == 2)
         {
            LoggerSys.info("玩家 " + playerModel.playerInfo.userId + "在 " + playerModel.nowDate + " 开采10次斯托斯矿石");
         }
      }
   }
}

