package yishi.manager
{
   import com.road.yishi.proto.cccactive.CrazyOrderInfoMsg;
   import com.road.yishi.proto.cccactive.GoldCrazyMsg;
   import com.road.yishi.proto.cccactive.GoldCrazyRewardMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.exchargerank.ExchargeRankData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class GoldenDionysiaManager
   {
      
      private static var _instance:GoldenDionysiaManager;
      
      public static var OPEN:uint = 1;
      
      public static var REWARD:uint = 2;
      
      public static var STATE1:uint = 1;
      
      public static var STATE2:uint = 2;
      
      public static var FIRST:int = 1;
      
      public static var SECOND:int = 2;
      
      public static var THIRD:int = 3;
      
      public static var LUCKY:int = 4;
      
      public static var NORMAL:int = 5;
      
      public var openGoldenDionysia:Boolean;
      
      private var _goldenMsg:GoldCrazyMsg;
      
      public function GoldenDionysiaManager()
      {
         super();
      }
      
      public static function get instance() : GoldenDionysiaManager
      {
         if(!_instance)
         {
            _instance = new GoldenDionysiaManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 440,__onInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 441,__onLuckResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 443,__onSwitchDataHandler);
      }
      
      private function __onInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GoldCrazyMsg = new GoldCrazyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GoldCrazyMsg;
         _goldenMsg = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("GOLDEN_DIONYSIA_INFO"));
      }
      
      private function __onLuckResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GoldCrazyMsg = new GoldCrazyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GoldCrazyMsg;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("GOLDEN_DIONYSIA_RESULT",[_loc2_.myRewardType,_loc2_.myLuckNum,_loc2_.myRewardPoint,_loc2_.myRewardGift]));
      }
      
      private function __onSwitchDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openGoldenDionysia = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get allocationActive() : Boolean
      {
         var _loc1_:GoldCrazyRewardMsg = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _goldenMsg.reward.length)
         {
            _loc1_ = _goldenMsg.reward[_loc2_];
            if(_loc1_.rewardSite == 4)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getLuckyRankList(param1:int = 1) : Vector.<ExchargeRankData>
      {
         var _loc3_:ExchargeRankData = null;
         var _loc4_:CrazyOrderInfoMsg = null;
         var _loc5_:int = 0;
         var _loc2_:ExchargeRankData = null;
         var _loc7_:int = 0;
         var _loc6_:Vector.<ExchargeRankData> = new Vector.<ExchargeRankData>();
         _loc5_ = 0;
         while(_loc5_ < _goldenMsg.orderInfo.length)
         {
            _loc4_ = _goldenMsg.orderInfo[_loc5_];
            if(!(param1 == 1 && _loc5_ >= 100))
            {
               if(!(param1 == 2 && _loc4_.rewardType != 2))
               {
                  _loc3_ = new ExchargeRankData();
                  _loc3_.rank = _loc4_.order;
                  _loc3_.nickName = _loc4_.nickName;
                  _loc3_.agencyServer = _loc4_.serverName;
                  _loc3_.amount = String(_loc4_.consumePoint);
                  _loc6_.push(_loc3_);
               }
            }
            _loc5_++;
         }
         _loc6_.sort(sortFun);
         if(param1 == 2)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc2_ = _loc6_[_loc7_];
               _loc2_.rank = _loc7_ + 1;
               _loc7_++;
            }
         }
         return _loc6_;
      }
      
      protected function sortFun(param1:ExchargeRankData, param2:ExchargeRankData) : Number
      {
         if(param1.rank < param2.rank)
         {
            return -1;
         }
         return 1;
      }
      
      public function get goldenMsg() : GoldCrazyMsg
      {
         return _goldenMsg;
      }
      
      public function get isActive() : Boolean
      {
         return _goldenMsg.currentPoint >= _goldenMsg.activeRewardPoint && _goldenMsg.activeRewardPoint > 0;
      }
      
      public function getRewardArrByType(param1:int) : Array
      {
         var _loc3_:GoldCrazyRewardMsg = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _goldenMsg.reward.length)
         {
            _loc3_ = _goldenMsg.reward[_loc4_];
            if(_loc3_.rewardType == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function OperateGoldenDionysiaReq(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,25);
         var _loc3_:GoldCrazyMsg = new GoldCrazyMsg();
         _loc3_.op = param1;
         _loc3_.myRewardType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

