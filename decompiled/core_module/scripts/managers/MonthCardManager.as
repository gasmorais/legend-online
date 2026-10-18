package managers
{
   import com.road.yishi.proto.cccactive.GiftItemInfoMsg;
   import com.road.yishi.proto.cccactive.MonthCardGiftMsg;
   import com.road.yishi.proto.cccactive.MonthCardMsg;
   import mvc.module.fundVein.RewardItemInfo;
   import mvc.module.monthcard.MonthCardGiftInfo;
   import mvc.module.monthcard.MonthCardModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class MonthCardManager
   {
      
      private static var _instance:MonthCardManager;
      
      public static const OPEN_FRAME:int = 1;
      
      public static const GIFT_BUY:int = 2;
      
      public static const REWARD_GET:int = 3;
      
      private var _model:MonthCardModel;
      
      public function MonthCardManager()
      {
         super();
      }
      
      public static function get instance() : MonthCardManager
      {
         if(_instance == null)
         {
            _instance = new MonthCardManager();
         }
         return _instance;
      }
      
      public function get model() : MonthCardModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new MonthCardModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 175,__updateMonthCardMsg);
      }
      
      private function __updateMonthCardMsg(param1:SLGSocketEvent) : void
      {
         var _loc7_:MonthCardGiftInfo = null;
         var _loc5_:RewardItemInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonthCardMsg = new MonthCardMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as MonthCardMsg;
         if(!model.isOpen && _loc2_.isOpen)
         {
            model.openChange = true;
         }
         else
         {
            model.openChange = false;
         }
         if(_loc2_.hasIsOpen)
         {
            model.isOpen = _loc2_.isOpen;
         }
         if(_loc2_.hasOpenTime)
         {
            model.openTime = _loc2_.openTime;
         }
         if(_loc2_.hasStopTime)
         {
            model.stopTime = _loc2_.stopTime;
         }
         model.giftList = [];
         for each(var _loc3_:MonthCardGiftMsg in _loc2_.gifts)
         {
            _loc7_ = new MonthCardGiftInfo();
            _loc7_.type = _loc3_.type;
            _loc7_.giftName = _loc3_.giftName;
            _loc7_.giftPic = _loc3_.giftPic;
            _loc7_.needPoint = _loc3_.needPoint;
            _loc7_.lastDay = _loc3_.lastDay;
            _loc7_.leftDay = _loc3_.leftDay;
            if(_loc3_.hasCollectTime)
            {
               _loc7_.collectTime = _loc3_.collectTime;
            }
            _loc7_.itemList = [];
            for each(var _loc4_:GiftItemInfoMsg in _loc3_.items)
            {
               _loc5_ = new RewardItemInfo();
               _loc5_.tempId = _loc4_.templateId;
               _loc5_.count = _loc4_.templateCount;
               _loc7_.itemList.push(_loc5_);
            }
            model.giftList.push(_loc7_);
         }
         model.giftList.sortOn("type",16);
         MsgMan.notifyObserver("MONTH_INFO_CHANGE");
      }
      
      public function sendMonthRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,29);
         var _loc3_:MonthCardMsg = new MonthCardMsg();
         _loc3_.op = param1;
         _loc3_.type = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

