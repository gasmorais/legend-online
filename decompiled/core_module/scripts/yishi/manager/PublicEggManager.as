package yishi.manager
{
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.sumpassion.EggListMsg;
   import com.road.yishi.proto.sumpassion.SumGiftList;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class PublicEggManager
   {
      
      private static var _instance:PublicEggManager;
      
      public var openEgg1:Boolean = false;
      
      public var openEgg:Boolean = false;
      
      private var _eggListMsg:EggListMsg;
      
      public var openGift1:Boolean = false;
      
      public var openGift:Boolean = false;
      
      private var _giftListMsg:SumGiftList;
      
      public function PublicEggManager()
      {
         super();
      }
      
      public static function get instance() : PublicEggManager
      {
         if(!_instance)
         {
            _instance = new PublicEggManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 417,__egglistHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 416,__openEggStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 419,__giftlistHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 418,__openGiftStateHandler);
      }
      
      private function __egglistHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:EggListMsg = new EggListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as EggListMsg;
         _eggListMsg = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PUBLIC_EGG_UPDATE"));
      }
      
      private function __openEggStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openEgg1 = _loc2_.param7 && _loc2_.param1 == 1;
         openEgg = _loc2_.param7 && _loc2_.param1 == 0;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      private function __giftlistHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SumGiftList = new SumGiftList();
         _loc2_ = _loc5_.readBody(_loc2_) as SumGiftList;
         if(_loc2_.op == 1)
         {
            _giftListMsg = _loc2_;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.buyLevel.length)
            {
               _loc4_ = 0;
               while(_loc4_ < _giftListMsg.buyLevel.length)
               {
                  if(_giftListMsg.buyLevel[_loc4_].levelId == _loc2_.buyLevel[_loc3_].levelId)
                  {
                     _giftListMsg.buyLevel[_loc4_].isFinish = _loc2_.buyLevel[_loc3_].isFinish;
                     _giftListMsg.buyLevel[_loc4_].takeDays = _loc2_.buyLevel[_loc3_].takeDays;
                     _giftListMsg.buyLevel[_loc4_].canTake = _loc2_.buyLevel[_loc3_].canTake;
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.chargeLevel.length)
            {
               _loc4_ = 0;
               while(_loc4_ < _giftListMsg.chargeLevel.length)
               {
                  if(_giftListMsg.chargeLevel[_loc4_].levelId == _loc2_.chargeLevel[_loc3_].levelId)
                  {
                     _giftListMsg.chargeLevel[_loc4_].isFinish = _loc2_.chargeLevel[_loc3_].isFinish;
                     _giftListMsg.chargeLevel[_loc4_].takeDays = _loc2_.chargeLevel[_loc3_].takeDays;
                     _giftListMsg.chargeLevel[_loc4_].canTake = _loc2_.chargeLevel[_loc3_].canTake;
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PUBLIC_GIFT_UPDATE"));
      }
      
      private function __openGiftStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openGift1 = _loc2_.param7 && _loc2_.param1 == 1;
         openGift = _loc2_.param7 && _loc2_.param1 == 0;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get openEggGift() : Boolean
      {
         return openEgg1 || openGift1;
      }
      
      public function get eggListMsg() : EggListMsg
      {
         return _eggListMsg;
      }
      
      public function get giftListMsg() : SumGiftList
      {
         return _giftListMsg;
      }
      
      public function OperateEggReq(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9640);
         var _loc3_:EggListMsg = new EggListMsg();
         _loc3_.op = param1;
         _loc3_.profile = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function OperateGiftReq(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9642);
         var _loc4_:SumGiftList = new SumGiftList();
         _loc4_.op = param1;
         _loc4_.giftType = param2;
         _loc4_.level = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}

