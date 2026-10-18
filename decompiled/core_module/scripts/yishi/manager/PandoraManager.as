package yishi.manager
{
   import com.road.yishi.proto.cccactive.LotteryRewardMsg;
   import com.road.yishi.proto.cccactive.PandoraLotteryMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class PandoraManager
   {
      
      private static var _instance:PandoraManager;
      
      public var openPandora:Boolean = false;
      
      private var _pandoraMsg:PandoraLotteryMsg;
      
      public function PandoraManager()
      {
         super();
      }
      
      public static function get instance() : PandoraManager
      {
         if(!_instance)
         {
            _instance = new PandoraManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 429,__pandoraHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 430,__openStateHandler);
      }
      
      private function __pandoraHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PandoraLotteryMsg = new PandoraLotteryMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PandoraLotteryMsg;
         if(_loc2_.op == 1)
         {
            _pandoraMsg = _loc2_;
         }
         else
         {
            _pandoraMsg.op = _loc2_.op;
            _pandoraMsg.currentLevel = _loc2_.currentLevel;
            _pandoraMsg.resultPoint = _loc2_.resultPoint;
            _pandoraMsg.leftLotteryCount = _loc2_.leftLotteryCount;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PANDORA_RESULT_UPDATE"));
      }
      
      private function __openStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openPandora = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get pandoraMsg() : PandoraLotteryMsg
      {
         return _pandoraMsg;
      }
      
      public function get rewardMsg() : LotteryRewardMsg
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _pandoraMsg.reward.length)
         {
            if(_pandoraMsg.reward[_loc1_].level == _pandoraMsg.currentLevel)
            {
               return _pandoraMsg.reward[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function OperatePandoraReq(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9645,0,23);
         var _loc2_:PandoraLotteryMsg = new PandoraLotteryMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

