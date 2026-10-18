package managers
{
   import com.road.yishi.proto.active.WishPoolItemInfo;
   import com.road.yishi.proto.active.WishPoolReqMsg;
   import com.road.yishi.proto.active.WishPoolRespMsg;
   import com.road.yishi.proto.active.WishPoolShopGoodInfo;
   import com.road.yishi.proto.active.WishPoolWindowMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.utils.Dictionary;
   import mvc.module.wishpool.WishPoolInfoVO;
   import mvc.module.wishpool.WishPoolModel;
   import mvc.module.wishpool.WishPoolShopInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class WishPoolManager
   {
      
      private static var _instance:WishPoolManager;
      
      public static var OPENFRAME:int = 1;
      
      public static var REFRESH:int = 2;
      
      public static var WISH:int = 3;
      
      public static var OPEN_SHOP_FRAME:int = 4;
      
      public static var SHOP_BUY:int = 5;
      
      private var _model:WishPoolModel;
      
      public function WishPoolManager()
      {
         super();
      }
      
      public static function get instance() : WishPoolManager
      {
         if(!_instance)
         {
            _instance = new WishPoolManager();
         }
         return _instance;
      }
      
      public function get model() : WishPoolModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new WishPoolModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 196,__wishPoolWindowInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 197,__wishpoolRespHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__wishPoolBtnHandler);
      }
      
      private function __wishPoolWindowInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:WishPoolWindowMsg = new WishPoolWindowMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as WishPoolWindowMsg;
         if(_loc2_ && _loc2_.type == 1)
         {
            model.refreshPrice = _loc2_.refreshPrice;
            model.wishOnePrice = _loc2_.wishOnePrice;
            model.countDown = _loc2_.sysCountDown;
            model.totalWishDic = new Dictionary();
            model.totalWishArray = [];
            for each(var _loc3_:WishPoolItemInfo in _loc2_.allWishes)
            {
               if(_loc3_)
               {
                  model.totalWishDic[_loc3_.key] = readWishPoolItemInfo(_loc3_);
                  model.totalWishArray.push(readWishPoolItemInfo(_loc3_));
               }
            }
            model.wishpoolArray = _loc2_.keys;
            model.wishpoolArray.sort(16);
            model.selectedWishArray = [];
            model.totalWishArray.sort(sortByRare);
            NotificationManager.instance.sendNotification("WISH_POOL_WINDOW_INFO_UPDATE");
         }
         else if(_loc2_ && _loc2_.type == 2)
         {
            model.totalShopArray = [];
            for each(var _loc4_:WishPoolShopGoodInfo in _loc2_.goods)
            {
               if(_loc4_)
               {
                  model.totalShopArray.push(readWishPoolShopGoodInfo(_loc4_));
               }
            }
            NotificationManager.instance.sendNotification("WISH_POOL_SHOP_SCORE_UPDATE");
         }
      }
      
      private function sortByRare(param1:WishPoolInfoVO, param2:WishPoolInfoVO) : int
      {
         if(param1.isRare && !param2.isRare)
         {
            return -1;
         }
         if(!param1.isRare && param2.isRare)
         {
            return 1;
         }
         return 0;
      }
      
      private function __wishpoolRespHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:WishPoolShopInfo = null;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:WishPoolRespMsg = new WishPoolRespMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as WishPoolRespMsg;
         if(_loc2_)
         {
            if(_loc2_.optype == OPENFRAME)
            {
               model.countDown = _loc2_.countDown;
               model.selectedWishArray = [];
               NotificationManager.instance.sendNotification("WISH_POOL_COUNTDOWN_REFRESH");
            }
            else if(_loc2_.optype == REFRESH)
            {
               if(_loc2_.hasCountDown)
               {
                  model.countDown = _loc2_.countDown;
               }
               model.wishpoolArray = _loc2_.keys;
               model.selectedWishArray = [];
               if(model.wishpoolArray)
               {
                  model.wishpoolArray.sort(16);
               }
               NotificationManager.instance.sendNotification("WISH_POOL_REFRESH");
            }
            else if(_loc2_.optype == WISH)
            {
               model.wishResult = _loc2_.wishResult;
               if(model.wishResult)
               {
                  model.wishpoolArray = _loc2_.keys;
                  NotificationManager.instance.sendNotification("WISH_POOL_SUCCESS",model.selectedWishArray);
                  model.selectedWishArray = [];
                  if(model.wishpoolArray)
                  {
                     model.wishpoolArray.sort(16);
                  }
                  if(model.successWishArray)
                  {
                     model.successWishArray.push(_loc2_.wishRewardTip);
                  }
                  else
                  {
                     model.successWishArray = [];
                     model.successWishArray.push(_loc2_.wishRewardTip);
                  }
               }
               NotificationManager.instance.sendNotification("WISH_POOL_WISH");
            }
            else if(_loc2_.optype == OPEN_SHOP_FRAME || _loc2_.optype == SHOP_BUY)
            {
               model.leftScore = _loc2_.leftScore;
               _loc3_ = 0;
               while(_loc3_ < model.totalShopArray.length)
               {
                  _loc5_ = model.totalShopArray[_loc3_] as WishPoolShopInfo;
                  if(_loc5_ && _loc5_.key == _loc2_.goodKey)
                  {
                     _loc5_.curHasBuyCount = _loc2_.curBuyCount;
                     break;
                  }
                  _loc3_++;
               }
               NotificationManager.instance.sendNotification("WISH_POOL_SHOP_SCORE_UPDATE");
            }
         }
      }
      
      private function __wishPoolBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 2058)
         {
            model.wishPoolIsOpen = _loc2_.param7;
            model.startDate = DateFormatter.parse(_loc2_.param4,"YYYY-MM-DD hh:mm:ss");
            model.endDate = DateFormatter.parse(_loc2_.param5,"YYYY-MM-DD hh:mm:ss");
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function readWishPoolItemInfo(param1:WishPoolItemInfo) : WishPoolInfoVO
      {
         var _loc2_:WishPoolInfoVO = null;
         if(param1)
         {
            _loc2_ = new WishPoolInfoVO();
            _loc2_.key = param1.key;
            _loc2_.tempalteId = param1.itemId;
            _loc2_.count = param1.count;
            _loc2_.isRare = param1.isRare;
         }
         return _loc2_;
      }
      
      private function readWishPoolShopGoodInfo(param1:WishPoolShopGoodInfo) : WishPoolShopInfo
      {
         var _loc2_:WishPoolShopInfo = null;
         if(param1)
         {
            _loc2_ = new WishPoolShopInfo();
            _loc2_.key = param1.key;
            _loc2_.tempalteId = param1.itemId;
            _loc2_.count = param1.count;
            _loc2_.price = param1.price;
            _loc2_.limitBuyCount = param1.limitBuyCount;
            _loc2_.curHasBuyCount = param1.curBuyCount;
         }
         return _loc2_;
      }
      
      public function frameOperation(param1:int, param2:Array, param3:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(9645,0,36);
         var _loc4_:WishPoolReqMsg = new WishPoolReqMsg();
         _loc4_.optype = param1;
         _loc4_.keys = param2;
         _loc4_.isUseProp = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function wishPoolShopBuy(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,36);
         var _loc3_:WishPoolReqMsg = new WishPoolReqMsg();
         _loc3_.optype = SHOP_BUY;
         _loc3_.goodKey = param1;
         _loc3_.buyCount = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

