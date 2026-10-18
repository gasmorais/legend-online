package yishi.manager
{
   import com.road.yishi.proto.active.DiscountMallItemInfo;
   import com.road.yishi.proto.active.DiscountMallMsg;
   import com.road.yishi.proto.active.DiscountMallRequestMsg;
   import com.road.yishi.proto.active.DiscountMallScoreInfo;
   import events.ShopEvent;
   import mvc.module.discountshop.DiscountShopItemInfo;
   import mvc.module.discountshop.DiscountShopModel;
   import mvc.module.discountshop.DiscountShopScoreInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class DiscountShopManager
   {
      
      private static var _instance:DiscountShopManager;
      
      private var _model:DiscountShopModel;
      
      public function DiscountShopManager()
      {
         super();
      }
      
      public static function get instance() : DiscountShopManager
      {
         if(!_instance)
         {
            _instance = new DiscountShopManager();
         }
         return _instance;
      }
      
      public function get model() : DiscountShopModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new DiscountShopModel();
         }
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 389,__discountShopInfoHandler);
      }
      
      private function __discountShopInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:DiscountMallItemInfo = null;
         var _loc5_:int = 0;
         var _loc8_:DiscountShopItemInfo = null;
         var _loc7_:DiscountMallScoreInfo = null;
         var _loc3_:DiscountShopScoreInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:DiscountMallMsg = new DiscountMallMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as DiscountMallMsg;
         _model.discountShopItemInfo = new Vector.<DiscountShopItemInfo>();
         _model.discountShopScoreInfo = new Vector.<DiscountShopScoreInfo>();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.items.length)
         {
            _loc8_ = new DiscountShopItemInfo();
            _loc4_ = _loc2_.items[_loc5_] as DiscountMallItemInfo;
            _loc8_.buycount = _loc4_.buycount;
            _loc8_.index = _loc4_.index;
            _loc8_.itemId = _loc4_.itemId;
            _loc8_.limit = _loc4_.limit;
            _loc8_.price = _loc4_.price;
            _loc8_.count = _loc4_.count;
            _model.discountShopItemInfo.push(_loc8_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.scores.length)
         {
            _loc3_ = new DiscountShopScoreInfo();
            _loc7_ = _loc2_.scores[_loc5_] as DiscountMallScoreInfo;
            _loc3_.isTake = _loc7_.isTake;
            _loc3_.itemId = _loc7_.itemId;
            _loc3_.score = _loc7_.score;
            _loc3_.count = _loc7_.count;
            _model.discountShopScoreInfo.push(_loc3_);
            _loc5_++;
         }
         _model.discountShopScoreInfo.sort(sortFun);
         _model.beginTime = _loc2_.begin;
         _model.endTime = _loc2_.end;
         _model.id = _loc2_.id;
         _model.logo = _loc2_.logo;
         _model.myDiscount = _loc2_.myDisc;
         _model.myScore = _loc2_.myscore;
         if(_loc2_.begin == null)
         {
            _model.showTopIcon = false;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
            return;
         }
         if(!_model.showTopIcon)
         {
            _model.showTopIcon = true;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
         _model.dispatchEvent(new ShopEvent("DISCOUNTSHOP_UPDATE"));
      }
      
      protected function sortFun(param1:DiscountShopScoreInfo, param2:DiscountShopScoreInfo) : Number
      {
         var _loc3_:int = param1.score;
         var _loc4_:int = param2.score;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public function operationDiscountShop(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9628);
         var _loc4_:DiscountMallRequestMsg = new DiscountMallRequestMsg();
         _loc4_.op = param1;
         _loc4_.param1 = param2;
         _loc4_.param2 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
   }
}

