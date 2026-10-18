package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.lottery.LotteryMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.vip.VipRouletteMsg;
   import events.LotteryEvent;
   import flash.events.EventDispatcher;
   import mvc.module.lottery.LotteryModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class LotteryManager extends EventDispatcher
   {
      
      private static var _instance:LotteryManager;
      
      private var _model:LotteryModel;
      
      public function LotteryManager()
      {
         super();
      }
      
      public static function get Instance() : LotteryManager
      {
         if(!_instance)
         {
            _instance = new LotteryManager();
         }
         return _instance;
      }
      
      public function get model() : LotteryModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new LotteryModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4637,__lotteryState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4636,__lotteryInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4641,__lotteryDropListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4639,__lotteryNoticeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4642,__lotteryResultHandler);
      }
      
      private function __lotteryInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LotteryMsg = new LotteryMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LotteryMsg;
         model.info.dayMaxCount = _loc2_.dayMaxCount;
         model.info.leftCount = _loc2_.leftCount;
         model.info.leftTimes = Int64Utils.int64ToNumber(_loc2_.leftMillis) / 1000;
         model.info.onceNeedPoint = _loc2_.onceNeedPoint;
         model.info.payedPoint = _loc2_.payedPoint;
         model.info.totalCount = _loc2_.totalCount;
         model.info.dayAddCount = _loc2_.dayAddCount;
         dispatchEvent(new LotteryEvent("LOTTERY_INFO",null));
      }
      
      private function __lotteryNoticeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LotteryMsg = new LotteryMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LotteryMsg;
         model.lotteryShowInfo = _loc2_.property3.concat();
      }
      
      private function __lotteryState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LotteryMsg = new LotteryMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LotteryMsg;
         model.info.isOpen = _loc2_.isOpen;
         dispatchEvent(new LotteryEvent("LOTTERY_STATE",null));
      }
      
      private function __lotteryDropListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipRouletteMsg = new VipRouletteMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VipRouletteMsg;
         model.lotteryGoodsList = _loc2_.leftItem.concat();
         dispatchEvent(new LotteryEvent("DROP_LIST",null));
      }
      
      private function __lotteryResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.info.leftCount = _loc2_.param2;
         model.dropId = _loc2_.param1;
         model.dropCount = _loc2_.param3;
         dispatchEvent(new LotteryEvent("LOTTERY_RESULT",null));
      }
      
      public function requestInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(8750);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function senLotteryRolette() : void
      {
         var _loc1_:PackageOut = new PackageOut(8748);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
   }
}

