package yishi.manager
{
   import com.road.yishi.proto.cccactive.ChargePointLotteryMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class ChargeLotteryManager
   {
      
      private static var _instance:ChargeLotteryManager;
      
      public var openChargeLottery:Boolean;
      
      private var _chargeLotteryMsg:ChargePointLotteryMsg;
      
      public function ChargeLotteryManager()
      {
         super();
      }
      
      public static function get instance() : ChargeLotteryManager
      {
         if(!_instance)
         {
            _instance = new ChargeLotteryManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 432,__chargelotteryHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 433,__openStateHandler);
      }
      
      private function __chargelotteryHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChargePointLotteryMsg = new ChargePointLotteryMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChargePointLotteryMsg;
         if(_loc2_.op == 1)
         {
            _chargeLotteryMsg = _loc2_;
         }
         else if(_loc2_.op == 2)
         {
            _chargeLotteryMsg.op = _loc2_.op;
            _chargeLotteryMsg.leftNeedPoint = _loc2_.leftNeedPoint;
            _chargeLotteryMsg.leftCount = _loc2_.leftCount;
            _chargeLotteryMsg.dayAddCount = _loc2_.dayAddCount;
            _chargeLotteryMsg.isOneKey = _loc2_.isOneKey;
            _chargeLotteryMsg.isRare = _loc2_.isRare;
            _chargeLotteryMsg.resultPos = _loc2_.resultPos.slice(0,_loc2_.resultPos.length);
         }
         else if(_loc2_.op == 3)
         {
            _chargeLotteryMsg.op = _loc2_.op;
            _chargeLotteryMsg.logs = _loc2_.logs.slice(0,_loc2_.logs.length);
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CHARGELOTTERY_RESULT_UPDATE"));
      }
      
      private function __openStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openChargeLottery = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get chargeMsg() : ChargePointLotteryMsg
      {
         return _chargeLotteryMsg;
      }
      
      public function get normalArr() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Array = [];
         var _loc4_:Array = [];
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _chargeLotteryMsg.reward.length)
         {
            if(_chargeLotteryMsg.reward[_loc3_].templateType == 0)
            {
               _loc5_.push(_chargeLotteryMsg.reward[_loc3_]);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _chargeLotteryMsg.reward.length)
         {
            if(_chargeLotteryMsg.reward[_loc3_].templateType == 1)
            {
               _loc4_.push(_chargeLotteryMsg.reward[_loc3_]);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 22)
         {
            if(_loc3_ == 6)
            {
               _loc1_.push(_loc4_[0]);
            }
            else if(_loc3_ == 17)
            {
               _loc1_.push(_loc4_[1]);
            }
            else
            {
               _loc1_.push(_loc5_[_loc2_]);
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get rareArr() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _chargeLotteryMsg.reward.length)
         {
            if(_chargeLotteryMsg.reward[_loc2_].templateType == 2)
            {
               _loc1_.push(_chargeLotteryMsg.reward[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function OperateChargeReq(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,24);
         var _loc3_:ChargePointLotteryMsg = new ChargePointLotteryMsg();
         _loc3_.op = param1;
         _loc3_.isOneKey = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

