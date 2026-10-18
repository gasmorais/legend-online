package managers
{
   import com.road.yishi.proto.mall.MysteryEventInfoMsg;
   import com.road.yishi.proto.mall.MysteryEventListMsg;
   import com.road.yishi.proto.mall.ShopFreshReqMsg;
   import com.road.yishi.proto.mall.ShopFreshRspMsg;
   import com.road.yishi.proto.mall.ShopItemBuyMsg;
   import com.road.yishi.proto.mall.ShopItemBuyRspMsg;
   import flash.events.EventDispatcher;
   import mvc.controler.MysteryShopControler;
   import mvc.module.auction.BuyGoodsInfo;
   import mvc.module.auction.MysteryShopEventInfo;
   import mvc.module.auction.MysteryShopModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class MysteryShopManager extends EventDispatcher
   {
      
      private static var _instance:MysteryShopManager;
      
      private var _model:MysteryShopModel;
      
      public function MysteryShopManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : MysteryShopManager
      {
         if(!_instance)
         {
            _instance = new MysteryShopManager();
         }
         return _instance;
      }
      
      public function get model() : MysteryShopModel
      {
         return _model;
      }
      
      public function get controller() : MysteryShopControler
      {
         return FrameControllerManager.instance.mysteryShopController;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new MysteryShopModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4383,__refreshGoodsHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4384,__refreshGoodsListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4470,__refreshLuckyPlayerListHandler);
      }
      
      private function __refreshGoodsHandler(param1:SLGSocketEvent) : void
      {
         model.beginChanges();
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopItemBuyRspMsg = new ShopItemBuyRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ShopItemBuyRspMsg;
         model.buyResult = _loc2_.result;
         model.buyCount = _loc2_.buyCount;
         model.consumePoints = _loc2_.score;
         model.commit();
      }
      
      private function __refreshGoodsListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:BuyGoodsInfo = null;
         model.beginChanges();
         model.goodsList = [];
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopFreshRspMsg = new ShopFreshRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ShopFreshRspMsg;
         model.lastRefreshTime = DateFormatter.parse(_loc2_.freshLastdate,"YYYY-MM-DD hh:mm:ss");
         model.buyCount = _loc2_.buyCount;
         model.maxBuyCount = _loc2_.maxBuyCount;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.itemId.length)
         {
            _loc3_ = new BuyGoodsInfo();
            _loc3_.index = _loc4_;
            _loc3_.itemId = _loc2_.itemId[_loc4_];
            _loc3_.isCanBuy = _loc2_.isCanBuy[_loc4_];
            model.goodsList.push(_loc3_);
            _loc4_++;
         }
         model.commit();
      }
      
      private function __refreshLuckyPlayerListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MysteryShopEventInfo = null;
         var _loc4_:int = 0;
         var _loc6_:MysteryEventInfoMsg = null;
         model.beginChanges();
         model.luckyPlayerList = [];
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MysteryEventListMsg = new MysteryEventListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MysteryEventListMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.eventInfo.length)
         {
            _loc6_ = _loc2_.eventInfo[_loc4_] as MysteryEventInfoMsg;
            _loc3_ = new MysteryShopEventInfo();
            _loc3_.id = _loc6_.id;
            _loc3_.userId = _loc6_.userId;
            _loc3_.msg = _loc6_.remark;
            _loc3_.isExist = _loc6_.isExist;
            model.luckyPlayerList.push(_loc3_);
            _loc4_++;
         }
         model.commit();
      }
      
      public function sendBuyGoodsItem(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(8482);
         var _loc4_:ShopItemBuyMsg = new ShopItemBuyMsg();
         _loc4_.itemId = param1;
         _loc4_.index = param2;
         _loc4_.payType = 2;
         if(!param3)
         {
            _loc4_.payType = 1;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendRefreshGoodsList(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8483);
         var _loc3_:ShopFreshReqMsg = new ShopFreshReqMsg();
         _loc3_.isButton = param1;
         _loc3_.payType = 0;
         if(!param2)
         {
            _loc3_.payType = 1;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

