package managers
{
   import com.road.yishi.proto.auction.AuctionItemInfoListMsg;
   import com.road.yishi.proto.auction.AuctionItemInfoMsg;
   import com.road.yishi.proto.item.BottlePassMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import manager.LanguageMgr;
   import mvc.module.sale.SaleData;
   import mvc.module.sale.SaleEvent;
   import mvc.module.sale.SaleModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SaleManager
   {
      
      private static var _instance:SaleManager;
      
      public static const OP_BIDING:int = 1;
      
      public static const OP_REQUEST:int = 2;
      
      public static const OP_ITEMS:int = 3;
      
      public static const OP_CLOSE_WIN:int = 4;
      
      public var currSelectedPage:String = "";
      
      public var currSelectedView:String = "";
      
      public var openFrame:int = 1;
      
      private var firstLoad:Boolean = true;
      
      private var _model:SaleModel;
      
      private var _delay:uint;
      
      public function SaleManager()
      {
         super();
         if(_model == null)
         {
            _model = new SaleModel();
         }
      }
      
      public static function get instance() : SaleManager
      {
         if(!_instance)
         {
            _instance = new SaleManager();
         }
         return _instance;
      }
      
      public function get model() : SaleModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 329,__saleDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 330,__saleSwitchHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 332,__saleNoticHandler);
      }
      
      protected function __saleNoticHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
         model.luckShowInfo = _loc2_.infos;
         NotificationManager.instance.dispatchEvent(new SaleEvent("SaleEvent.SALE_NOTIC"));
      }
      
      public function sendGetSaleInfos() : void
      {
         var _loc2_:PackageOut = new PackageOut(9584);
         var _loc1_:AuctionItemInfoMsg = new AuctionItemInfoMsg();
         _loc1_.op = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendBid(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9584);
         var _loc3_:AuctionItemInfoMsg = new AuctionItemInfoMsg();
         _loc3_.op = 1;
         _loc3_.auctionId = param1;
         _loc3_.buyPoint = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendCloseWindow() : void
      {
         var _loc2_:PackageOut = new PackageOut(9584);
         var _loc1_:AuctionItemInfoMsg = new AuctionItemInfoMsg();
         _loc1_.op = 4;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendPreview() : void
      {
         var _loc2_:PackageOut = new PackageOut(9584);
         var _loc1_:AuctionItemInfoMsg = new AuctionItemInfoMsg();
         _loc1_.op = 3;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      protected function __saleSwitchHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.isOpen = _loc2_.param7;
         NotificationManager.instance.dispatchEvent(new SaleEvent("SaleEvent.SALE_SWITCH"));
      }
      
      protected function __saleDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:AuctionItemInfoMsg = null;
         var _loc6_:SaleData = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:AuctionItemInfoListMsg = new AuctionItemInfoListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as AuctionItemInfoListMsg;
         model.specialId = _loc2_.specialAuctionId;
         model.leftSecond = _loc2_.leftSecond;
         model.items = new Vector.<SaleData>(5);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.auctionItemInfos.length)
         {
            _loc4_ = _loc2_.auctionItemInfos[_loc3_] as AuctionItemInfoMsg;
            _loc6_ = new SaleData();
            _loc6_.auctionId = _loc4_.auctionId;
            _loc6_.templateId = _loc4_.templateId;
            _loc6_.counts = _loc4_.counts;
            _loc6_.startPoint = _loc4_.startPoint;
            _loc6_.fixPoint = _loc4_.fixPoint;
            _loc6_.seconds = _loc4_.seconds;
            _loc6_.buyPoint = _loc4_.buyPoint;
            _loc6_.buyUserId = _loc4_.buyUserId;
            _loc6_.states = _loc4_.states;
            _loc6_.currentPoint = _loc4_.currentPoint;
            _loc6_.op = _loc4_.op;
            _loc6_.index = _loc4_.index;
            _loc6_.currentBidUserId = _loc4_.currentBidUserId;
            if(_loc6_.index == 0)
            {
               model.specialItem = _loc6_;
            }
            else
            {
               model.items[_loc6_.index - 1] = _loc6_;
            }
            _loc3_++;
         }
         if(_loc2_.allItemInfos.length > 0)
         {
            model.allItems = new Vector.<SaleData>();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.allItemInfos.length)
            {
               _loc4_ = _loc2_.allItemInfos[_loc3_] as AuctionItemInfoMsg;
               _loc6_ = new SaleData();
               _loc6_.auctionId = _loc4_.auctionId;
               _loc6_.templateId = _loc4_.templateId;
               _loc6_.counts = _loc4_.counts;
               _loc6_.startPoint = _loc4_.startPoint;
               _loc6_.fixPoint = _loc4_.fixPoint;
               _loc6_.seconds = _loc4_.seconds;
               _loc6_.buyPoint = _loc4_.buyPoint;
               _loc6_.buyUserId = _loc4_.buyUserId;
               _loc6_.states = _loc4_.states;
               _loc6_.currentPoint = _loc4_.currentPoint;
               _loc6_.op = _loc4_.op;
               _loc6_.index = _loc4_.index;
               _loc6_.currentBidUserId = _loc4_.currentBidUserId;
               model.allItems.push(_loc6_);
               _loc3_++;
            }
            NotificationManager.instance.dispatchEvent(new SaleEvent("SaleEvent.SALE_PREVIEW_LOADED"));
         }
         else
         {
            NotificationManager.instance.dispatchEvent(new SaleEvent("SaleEvent.SALE_DATA"));
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function openDragonTitanFrame() : void
      {
         if(ConfigManager.version_info.TAITAN_LOCK)
         {
            if(thane.isChangeJob)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01"));
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("dragontitan");
            }
         }
      }
   }
}

