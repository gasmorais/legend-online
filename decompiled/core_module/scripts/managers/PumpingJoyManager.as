package managers
{
   import com.road.yishi.proto.cccactive.EggTempMsg;
   import com.road.yishi.proto.cccactive.LuckyRewardMsg;
   import com.road.yishi.proto.cccactive.PumpingMsg;
   import mvc.module.pumpingegg.PumpingJoyLuckyInfo;
   import mvc.module.pumpingegg.PumpingJoyModel;
   import mvc.module.pumpingegg.PumpingJoyRewardInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class PumpingJoyManager
   {
      
      private static var _instance:PumpingJoyManager;
      
      public static const OPEN_FRAME_OP:int = 1;
      
      public static const LOTTERY_TYPE_OP:int = 2;
      
      public static const GET_LUCKY_REWARD_OP:int = 3;
      
      private var _model:PumpingJoyModel;
      
      public function PumpingJoyManager()
      {
         super();
      }
      
      public static function get instance() : PumpingJoyManager
      {
         if(!_instance)
         {
            _instance = new PumpingJoyManager();
         }
         return _instance;
      }
      
      public function get model() : PumpingJoyModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new PumpingJoyModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4850,__pumpingJoyInfoBack);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4848,__pumpingJoyResultBack);
      }
      
      private function __pumpingJoyInfoBack(param1:SLGSocketEvent) : void
      {
         var _loc3_:PumpingJoyRewardInfo = null;
         var _loc4_:PumpingJoyLuckyInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:PumpingMsg = new PumpingMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as PumpingMsg;
         if(_loc2_.hasOpenTime)
         {
            model.startDateNum = DateFormatter.parse(_loc2_.openTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
         }
         if(_loc2_.hasStopTime)
         {
            model.endDateNum = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
            model.exchangeEndDateNum = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss").time / 1000 + 86400;
         }
         if(_loc2_.hasTotalScore)
         {
            model.totalScore = _loc2_.totalScore;
         }
         if(_loc2_.hasOneNeedPoint)
         {
            model.oneNeedPoint = _loc2_.oneNeedPoint;
         }
         if(_loc2_.hasTenNeedPoint)
         {
            model.tenNeedPoint = _loc2_.tenNeedPoint;
         }
         if(_loc2_.hasFloorNeedPumps)
         {
            model.floorNeedPumps = _loc2_.floorNeedPumps;
         }
         if(_loc2_.hasLuckyLeftCount)
         {
            model.luckyLeftCount = _loc2_.luckyLeftCount;
         }
         model.rewardList = [];
         if(_loc2_.eggTempList && _loc2_.eggTempList.length > 0)
         {
            for each(var _loc6_:EggTempMsg in _loc2_.eggTempList)
            {
               _loc3_ = new PumpingJoyRewardInfo();
               _loc3_.id = _loc6_.id;
               _loc3_.tempId = _loc6_.tempId;
               _loc3_.count = _loc6_.count;
               _loc3_.profile = _loc6_.profile;
               _loc3_.isShow = _loc6_.isShow;
               _loc3_.types = _loc6_.types;
               _loc3_.rewardScore = _loc6_.rewardScore;
               model.rewardList.push(_loc3_);
            }
         }
         model.luckyList = [];
         if(_loc2_.luckyRewards && _loc2_.luckyRewards.length > 0)
         {
            for each(var _loc5_:LuckyRewardMsg in _loc2_.luckyRewards)
            {
               _loc4_ = new PumpingJoyLuckyInfo();
               _loc4_.uuid = _loc5_.uuid;
               _loc4_.eggId = _loc5_.eggId;
               _loc4_.timeOutDateNum = DateFormatter.parse(_loc5_.timeOutDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
               _loc4_.takeState = _loc5_.takeState;
               model.luckyList.push(_loc4_);
            }
            model.luckyList.sortOn("timeOutDateNum",16);
         }
         MsgMan.notifyObserver("PUMPING_JOY_MSG_BACK");
      }
      
      private function __pumpingJoyResultBack(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PumpingMsg = new PumpingMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PumpingMsg;
         if(_loc2_.resultEggIds && _loc2_.resultEggIds.length > 0)
         {
            MsgMan.notifyObserver("PUMPING_JOY_DRAW_BACK",_loc2_.resultEggIds);
         }
      }
      
      public function sendPumpRequest(param1:int, param2:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,27);
         var _loc3_:PumpingMsg = new PumpingMsg();
         _loc3_.op = param1;
         _loc3_.lotteryType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

