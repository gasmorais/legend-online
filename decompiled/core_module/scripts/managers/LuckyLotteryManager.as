package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.cccactive.ItemInfoMsg;
   import com.road.yishi.proto.cccactive.LuckyLotteryOpMsg;
   import com.road.yishi.proto.cccactive.LuckyLotteryRecordMsg;
   import com.road.yishi.proto.cccactive.LuckyLotteryRespMsg;
   import com.road.yishi.proto.cccactive.RecordMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.luckylottery.LuckyLotteryGoodsInfo;
   import mvc.module.luckylottery.LuckyLotteryModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class LuckyLotteryManager
   {
      
      private static var _instance:LuckyLotteryManager;
      
      private var _model:LuckyLotteryModel;
      
      public function LuckyLotteryManager()
      {
         super();
      }
      
      public static function get instance() : LuckyLotteryManager
      {
         if(!_instance)
         {
            _instance = new LuckyLotteryManager();
         }
         return _instance;
      }
      
      public function get model() : LuckyLotteryModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new LuckyLotteryModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4892,__lotteryRespHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4893,__lotteryRecordHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 462,__openStateHandler);
      }
      
      private function __lotteryRespHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:LuckyLotteryGoodsInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:LuckyLotteryRespMsg = new LuckyLotteryRespMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as LuckyLotteryRespMsg;
         if(_loc2_)
         {
            restFlag();
            for each(var _loc4_:RecordMsg in _loc2_.records)
            {
               _loc5_ = 0;
               while(_loc5_ < _model.allItemInfoArray.length)
               {
                  _loc3_ = _model.allItemInfoArray[_loc5_] as LuckyLotteryGoodsInfo;
                  if(_loc4_.label == 1 && _loc4_.index == 1)
                  {
                     _model.specialAwardInfo.currentNum = _loc4_.curNum;
                  }
                  if(_loc4_ && _loc3_.label == _loc4_.label && _loc3_.index == _loc4_.index)
                  {
                     _loc3_.currentNum = _loc4_.curNum;
                     _loc3_.selected = true;
                     break;
                  }
                  _loc5_++;
               }
            }
         }
         NotificationManager.instance.sendNotification("LUCKY_LOTTERY_RECORD");
      }
      
      private function restFlag() : void
      {
         var _loc1_:LuckyLotteryGoodsInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(_model.allItemInfoArray.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _model.allItemInfoArray[_loc3_] as LuckyLotteryGoodsInfo;
            _loc1_.selected = false;
            _loc3_++;
         }
      }
      
      private function __lotteryRecordHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:LuckyLotteryGoodsInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:LuckyLotteryRecordMsg = new LuckyLotteryRecordMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as LuckyLotteryRecordMsg;
         if(_loc2_)
         {
            _model.needGoodsTempId = _loc2_.costItemId;
            _model.needGoodsCount = _loc2_.onceCostItemNum;
            _model.refreshNeedTimes = _loc2_.needTimes;
            _model.allItemInfoArray = [];
            for each(var _loc3_:ItemInfoMsg in _loc2_.itemInfos)
            {
               _loc4_ = new LuckyLotteryGoodsInfo();
               _loc4_.label = _loc3_.label;
               _loc4_.index = _loc3_.index;
               _loc4_.templateId = _loc3_.tempId;
               _loc4_.count = _loc3_.gainNum;
               _loc4_.currentNum = _loc3_.currentNum;
               _loc4_.selected = false;
               _loc4_.maxNum = _loc3_.maxNum;
               _model.allItemInfoArray.push(_loc4_);
               if(_loc3_.label == 1 && _loc3_.index == 1)
               {
                  _model.specialAwardInfo = _loc4_;
               }
            }
            _model.refreshCountTimes = _loc2_.refreshTimes;
            _model.refreshedCountTimes = _loc2_.refreshedTimes;
            NotificationManager.instance.sendNotification("LUCKY_LOTTERY_RECORD");
         }
      }
      
      private function __openStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         _model.startDate = _loc2_.param4;
         _model.endDate = _loc2_.param5;
         _model.openLuckyLottery = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function frameOperation(param1:int, param2:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,34);
         var _loc3_:LuckyLotteryOpMsg = new LuckyLotteryOpMsg();
         _loc3_.opType = param1;
         _loc3_.times = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketSendManager.instance.sendProtoBuffer(param1,param2);
      }
   }
}

