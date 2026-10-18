package managers
{
   import com.netease.protobuf.Message;
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.active.ShopDiscountActiveMsg;
   import com.road.yishi.proto.active.ShopItemInfoMsg;
   import com.road.yishi.proto.active.UserBuyInfoMsg;
   import com.road.yishi.proto.children.FurnitureShopBuyMsg;
   import com.road.yishi.proto.item.FastUseBloodMsg;
   import com.road.yishi.proto.player.CheckNickMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.CommonMsgList;
   import com.road.yishi.proto.shop.BuyInfo;
   import com.road.yishi.proto.shop.CarItemInfoMsg;
   import com.road.yishi.proto.shop.FashionShopMsg;
   import com.road.yishi.proto.shop.HasDataInfo;
   import com.road.yishi.proto.shop.MainDiscountInfo;
   import com.road.yishi.proto.shop.ShopCarListMsg;
   import com.road.yishi.proto.shop.ShopMainRspMsg;
   import com.road.yishi.proto.shop.ShopMsg;
   import com.road.yishi.proto.shop.ShopTempInfoListMsg;
   import com.road.yishi.proto.shop.ShopTempInfoMsg;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import mvc.controler.ShopControler;
   import mvc.module.shop.BuyDataInfo;
   import mvc.module.shop.LimiteTimeDiscountInfo;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopCartGoodsInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import tasktracetip.data.TipMessageData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.view.frame.ArtifactBuyFrame;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.ShopMainBuyFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopManager
   {
      
      public static const SHOPFRAME_FASHION:String = "fashion";
      
      public static const SHOPFRAME_TIMEBUY:String = "SHOPFRAME_TIMEBUY";
      
      public static const SHOPFRAME_VIPBUY:String = "SHOPFRAME_VIPBUY";
      
      private static var _Instance:ShopManager;
      
      public var currBuyGoods:MainShopInfo;
      
      public var currBuyGoods2:ShopGoodsInfo;
      
      public var currBuyGoods3:MainShopInfo;
      
      public var count:int = 0;
      
      public var dayGiftCount:int = 0;
      
      public var costGiftCount:int = 0;
      
      public var isHandsel:int = 0;
      
      public var timeBuyDesc:int = 0;
      
      public var isFrist:Boolean = true;
      
      public var type:int = 1;
      
      public var needPop:Boolean;
      
      public var timeArr:Array;
      
      public var isOpenMountPreviewFrame:Boolean = false;
      
      public var isPetLand:Boolean = false;
      
      private var _model:ShopModel;
      
      public var shopFrameDefaultPanel:String;
      
      public var _controler:ShopControler;
      
      public var isTimeBuyOpen:Boolean = false;
      
      private var _oldArr:Array;
      
      public var totalFashionCount:int = 0;
      
      public var _refreshTime:int = 0;
      
      private var _timerId:uint;
      
      public function ShopManager()
      {
         super();
      }
      
      public static function get Instance() : ShopManager
      {
         if(!_Instance)
         {
            _Instance = new ShopManager();
         }
         return _Instance;
      }
      
      public function setup() : void
      {
         initEvent();
         _model = new ShopModel();
         timeArr = [];
         _oldArr = [];
      }
      
      public function get model() : ShopModel
      {
         return _model;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4238,__shopHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4375,__shopDiscountHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4145,__getBuyDataInfosSuccess);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4599,__shopBuyDiscount);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4547,__refreshTimeBuyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 344,__shopTempDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4890,__limiteTimeDiscountBtnDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 528,shopBuyHandler);
      }
      
      private function shopBuyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ShopGoodsInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CommonMsgList = new CommonMsgList();
         _loc2_ = _loc5_.readBody(_loc2_) as CommonMsgList;
         for each(var _loc3_:CommonMsg in _loc2_.list)
         {
            _loc4_ = getShopInfo(_loc3_.param1);
            if(_loc4_)
            {
               _loc4_.OneCurrentCount = _loc3_.param2;
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BTHESSOXSHOPBUYEFF"));
      }
      
      private function getShopInfo(param1:int) : ShopGoodsInfo
      {
         var _loc3_:Dictionary = null;
         var _loc2_:* = null;
         _loc3_ = TempleteManager.instance.getAthleticsShopTempInfoList();
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         _loc3_ = TempleteManager.instance.getFlameTempleDic();
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         _loc3_ = TempleteManager.instance.getDuskAreaShopDic();
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         _loc3_ = TempleteManager.instance.chesspvpShopDic;
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         _loc3_ = TempleteManager.instance.getthessShopTemplateDic();
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function __shopBuyDiscount(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopMsg = new ShopMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ShopMsg;
         if(_loc2_.buyInfo)
         {
            count = _loc2_.buyInfo.count;
            if(_loc2_.buyInfo.type == 5)
            {
               dayGiftCount = _loc2_.buyInfo.count;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOP_TIME_GIFT_REFRESH",_loc2_.buyInfo));
               return;
            }
            if(_loc2_.buyInfo.type == 6)
            {
               costGiftCount = _loc2_.buyInfo.count;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOP_TIME_GIFT_REFRESH",_loc2_.buyInfo));
               return;
            }
            if(_loc2_.buyInfo.type == 7)
            {
               if(!currBuyGoods3)
               {
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOP_TIME_GIFT_REFRESH",_loc2_.buyInfo));
                  return;
               }
               currBuyGoods3.count = _loc2_.buyInfo.count;
               currBuyGoods3.currentCount = _loc2_.buyInfo.count;
            }
            if(_loc2_.buyInfo.type == 1027 || _loc2_.buyInfo.type == 1031)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOP_TIME_GIFT_REFRESH",_loc2_.buyInfo));
            }
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      public function getDiscountIntimeBuy(param1:int) : Number
      {
         var _loc2_:MainShopInfo = null;
         var _loc4_:int = 0;
         var _loc3_:Number = 1;
         var _loc5_:Array = model.getTimeBuyList();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc4_] as MainShopInfo;
            if(_loc2_.type == 1)
            {
               if(!_loc2_.isGift)
               {
                  if(_loc2_.templateId == param1)
                  {
                     _loc3_ = _loc2_.discount;
                  }
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function quickUIcallback() : void
      {
         var _loc2_:ShopMainBuyFrame = null;
         var _loc1_:BuyFrameI = null;
         var _loc3_:ArtifactBuyFrame = null;
         if(currBuyGoods)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("shop.ShopMainBuyFrame");
            _loc2_["show"]();
            _loc2_["data"](currBuyGoods);
            currBuyGoods = null;
         }
         else if(currBuyGoods2)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
            _loc1_.data(currBuyGoods2);
            _loc1_.show();
            currBuyGoods2 = null;
         }
         else if(currBuyGoods3)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("artifact.buyFrame");
            _loc3_.data(currBuyGoods3);
            _loc3_.show();
            currBuyGoods3 = null;
         }
      }
      
      private function __shopDiscountHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MainShopInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MainDiscountInfo = new MainDiscountInfo();
         _loc2_ = _loc6_.readBody(_loc2_) as MainDiscountInfo;
         var _loc8_:Array = _model.getTimeBuyList();
         _loc8_ = _loc8_.concat(_model.getTimeBuyList2());
         var _loc4_:int = int(_loc8_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc8_[_loc5_];
            if(_loc3_.id == _loc2_.id)
            {
               _loc3_.currentCount = _loc2_.currentCount;
               _loc3_.oneDayCount = _loc2_.oneDayCount;
               _loc3_.maxCount = _loc2_.maxCount;
               _loc3_.maxCurrentDate = DateFormatter.parse(_loc2_.maxCurrentDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
               _loc3_.beginDate = DateFormatter.parse(_loc2_.beginDate,"YYYY-MM-DD hh:mm:ss").time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               _loc3_.endDate = DateFormatter.parse(_loc2_.endDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOPHOMEPAGE_UPDATA"));
               return;
            }
            _loc5_++;
         }
         var _loc7_:Array = _model.getPromotionalGoodsList();
         _loc4_ = int(_loc7_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc7_[_loc5_];
            if(_loc3_.id == _loc2_.id)
            {
               _loc3_.currentCount = _loc2_.currentCount;
               _loc3_.oneDayCount = _loc2_.oneDayCount;
               _loc3_.maxCount = _loc2_.maxCount;
               _loc3_.maxCurrentDate = DateFormatter.parse(_loc2_.maxCurrentDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
               _loc3_.beginDate = DateFormatter.parse(_loc2_.beginDate,"YYYY-MM-DD hh:mm:ss").time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               _loc3_.endDate = DateFormatter.parse(_loc2_.endDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOPHOMEPAGE_UPDATA"));
               return;
            }
            _loc5_++;
         }
      }
      
      private function __shopHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         timeArr = [];
         _model.randomCount = Math.random();
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopMainRspMsg = new ShopMainRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ShopMainRspMsg;
         var _loc5_:Boolean = false;
         var _loc3_:Boolean = false;
         loop0:
         for each(_loc4_ in _loc2_.discountInfo)
         {
            for each(_loc7_ in _model.mainDiscountList)
            {
               if(_loc4_.id != _loc7_.id)
               {
                  continue;
               }
               continue loop0;
            }
            if(DateFormatter.parse(_loc4_.beginDate,"YYYY-MM-DD hh:mm:ss").time > PlayerManager.instance.currentPlayerModel.nowDate)
            {
               timeArr.push(_loc4_);
            }
            else if(!checkItemisIn(_loc4_))
            {
               _loc5_ = true;
               _loc3_ = true;
               _loc4_.vip > 0 ? _loc3_ : (_loc5_);
            }
         }
         if(_model.splitFlag == _loc2_.flag)
         {
            _oldArr = _oldArr.concat(_loc2_.discountInfo);
            _model.mainDiscountList = _oldArr;
         }
         else
         {
            _oldArr = _loc2_.discountInfo;
            _model.mainDiscountList = _loc2_.discountInfo;
            _model.splitFlag = _loc2_.flag;
         }
         _model.mainNewList = _loc2_.goodInfo;
         _model.mainUrlList = _loc2_.urlInfo;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOPHOMEPAGE_UPDATA"));
         if(_loc3_ || _loc5_)
         {
            showShopTimeBuyTip(_loc3_);
         }
         if(_loc5_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOWTIMEBUYEFF"));
         }
      }
      
      private function checkItemisIn(param1:MainDiscountInfo) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _oldArr.length)
         {
            if(param1.id == _oldArr[_loc2_].id)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function __getBuyDataInfosSuccess(param1:SLGSocketEvent) : void
      {
         var _loc3_:MainShopInfo = null;
         var _loc4_:BuyDataInfo = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc8_:ShopGoodsInfo = null;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopMsg = new ShopMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as ShopMsg;
         var _loc5_:Boolean = false;
         var _loc13_:int = int(_loc2_.hasDataInfo.length);
         var _loc15_:Array = _model.getTimeBuyList();
         var _loc10_:int = int(_loc15_.length);
         var _loc14_:Array = _model.artifactList;
         _loc7_ = 0;
         while(_loc7_ < _loc13_)
         {
            _loc4_ = readDataInfo(_loc2_.hasDataInfo[_loc7_] as HasDataInfo);
            if(_loc4_.isDiscount)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc10_)
               {
                  _loc3_ = _loc15_[_loc9_];
                  if(_loc4_.itemId == _loc3_.id)
                  {
                     _loc3_.oneCurrentCount = _loc4_.counts;
                     _loc3_.count = _loc4_.counts;
                     _loc5_ = true;
                     break;
                  }
                  _loc9_++;
               }
               if(_loc14_)
               {
                  _loc6_ = int(_loc14_.length);
                  _loc12_ = 0;
                  while(_loc12_ < _loc6_)
                  {
                     _loc3_ = _loc14_[_loc12_];
                     if(_loc4_.itemId == _loc3_.id)
                     {
                        _loc3_.oneCurrentCount = _loc4_.counts;
                        _loc3_.count = _loc4_.counts;
                        _loc5_ = true;
                        break;
                     }
                     _loc12_++;
                  }
               }
            }
            else
            {
               _loc8_ = _model.getShopTempInfoById(_loc4_.itemId);
               if(_loc8_)
               {
                  _loc8_.OneCurrentCount = _loc4_.counts;
                  _loc5_ = true;
               }
            }
            _loc7_++;
         }
         if(_loc5_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOP_TIME_BUY_REFRESH"));
            _loc5_ = false;
         }
      }
      
      private function readDataInfo(param1:HasDataInfo) : BuyDataInfo
      {
         var _loc2_:BuyDataInfo = new BuyDataInfo();
         _loc2_.userId = param1.userId;
         _loc2_.itemId = param1.itemId;
         _loc2_.counts = param1.counts;
         _loc2_.buyDate = DateFormatter.parse(param1.buyDate,"YYYY-MM-DD hh:mm:ss");
         _loc2_.isDiscount = param1.isDiscount;
         return _loc2_;
      }
      
      public function sendPresent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4148,__checkNicknameBack);
         ShopManager.Instance.getUserId(model.giftInfo.nickname);
      }
      
      public function sendShopCartPresent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4148,__checkShopCartNicknameBack);
         ShopManager.Instance.getUserId(model.giftInfo.nickname);
      }
      
      private function __checkShopCartNicknameBack(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc7_:* = undefined;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc9_:Object = null;
         var _loc4_:Object = null;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4148,__checkNicknameBack);
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:CheckNickMsg = new CheckNickMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as CheckNickMsg;
         if(_loc2_.nickName.toLowerCase() != model.giftInfo.nickname.toLowerCase())
         {
            return;
         }
         if(_loc2_.playerId != -1)
         {
            if(_loc2_.playerId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               _loc3_ = LanguageMgr.GetTranslation("shop.ShopControler.command01");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            _loc7_ = _model.shopCartList;
            _loc5_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc7_.length)
            {
               if(_loc7_[_loc6_].goodsInfo is ShopGoodsInfo)
               {
                  _loc9_ = {};
                  _loc9_.shopId = (_loc7_[_loc6_].goodsInfo as ShopGoodsInfo).Id;
                  _loc9_.number = _loc7_[_loc6_].number;
                  _loc9_.type = _loc7_[_loc6_].isBind ? 2 : 1;
                  _loc9_.isDiscount = _loc7_[_loc6_].isDiscount;
                  _loc5_.push(_loc9_);
               }
               else if(_loc7_[_loc6_].goodsInfo is MainShopInfo)
               {
                  _loc4_ = {};
                  _loc4_.shopId = (_loc7_[_loc6_].goodsInfo as MainShopInfo).id;
                  _loc4_.number = _loc7_[_loc6_].number;
                  _loc4_.type = 1;
                  _loc4_.isDiscount = _loc7_[_loc6_].isDiscount;
                  _loc5_.push(_loc4_);
               }
               _loc6_++;
            }
            allBuy(_loc5_,_loc2_.playerId);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command06");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function __checkNicknameBack(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4148,__checkNicknameBack);
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CheckNickMsg = new CheckNickMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CheckNickMsg;
         if(!model.giftInfo || _loc2_.nickName.toLowerCase() != model.giftInfo.nickname.toLowerCase())
         {
            return;
         }
         if(_loc2_.playerId != -1)
         {
            if(_loc2_.playerId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               _loc3_ = LanguageMgr.GetTranslation("shop.ShopControler.command01");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            buyOne(model.giftInfo.goodId,model.giftInfo.count,_loc2_.playerId,1,model.giftInfo.isDiscount);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command06");
            MessageTipManager.instance().show(_loc3_);
         }
         model.giftInfo = null;
      }
      
      public function sendShoping(param1:int, param2:int, param3:int, param4:Boolean = false, param5:uint = 5154, param6:Boolean = true, param7:int = 0) : void
      {
         var _loc11_:PackageOut = null;
         var _loc10_:FashionShopMsg = null;
         var _loc8_:ShopMsg = null;
         SocketManager.instance.addEventListener("SLGSocketEvent" + 90,__shoppingHandler);
         param3 = param3 == 0 ? PlayerManager.instance.currentPlayerModel.playerInfo.userId : param3;
         var _loc9_:BuyInfo = new BuyInfo();
         _loc9_.goodId = param1;
         _loc9_.count = param2;
         _loc9_.receiveId = param3;
         _loc9_.isDiscount = param4;
         _loc9_.type = ShopManager.Instance.type;
         if(param5 == 8592)
         {
            _loc11_ = new PackageOut(8592);
            _loc10_ = new FashionShopMsg();
            _loc10_.buyInfos = [_loc9_];
            _loc10_.payType = 0;
            _loc10_.itemTemplateId = param7;
            if(!param6)
            {
               _loc10_.payType = 1;
            }
            sendProtoBuffer(_loc11_,_loc10_);
         }
         else
         {
            _loc11_ = new PackageOut(5154);
            _loc8_ = new ShopMsg();
            _loc8_.buyInfo = _loc9_;
            _loc8_.payType = 0;
            _loc8_.itemTemplateId = param7;
            if(!param6)
            {
               _loc8_.payType = 1;
            }
            sendProtoBuffer(_loc11_,_loc8_);
         }
      }
      
      private function __shoppingHandler(param1:SLGSocketEvent) : void
      {
         var _loc11_:Array = null;
         var _loc9_:int = 0;
         var _loc4_:MainShopInfo = null;
         var _loc8_:int = 0;
         var _loc5_:ShopGoodsInfo = null;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 90,__shoppingHandler);
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopMsg = new ShopMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as ShopMsg;
         var _loc6_:int = _loc2_.buyInfo.goodId;
         var _loc7_:int = _loc2_.buyInfo.count;
         var _loc12_:int = _loc2_.buyInfo.receiveId;
         var _loc3_:int = _loc2_.buyInfo.result;
         shopingResult(_loc3_,_loc6_);
         if(_loc3_ == 1 || _loc3_ == 12)
         {
            if(_loc2_.buyInfo.isDiscount)
            {
               _loc11_ = _model.getTimeBuyList();
               _loc9_ = int(_loc11_.length);
               _loc8_ = 0;
               while(_loc8_ < _loc9_)
               {
                  _loc4_ = _loc11_[_loc8_];
                  if(_loc6_ == _loc4_.id)
                  {
                     _loc4_.oneCurrentCount += _loc7_;
                     _loc4_.count += _loc7_;
                     disEvent();
                     return;
                  }
                  _loc8_++;
               }
            }
            else
            {
               _loc5_ = model.getShopTempInfoById(_loc6_);
               if(!_loc5_ || _loc5_.OneDayCount == -1)
               {
                  return;
               }
               _loc5_.OneCurrentCount += _loc7_;
            }
         }
      }
      
      public function getShopGift(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9545);
         var _loc2_:CarItemInfoMsg = new CarItemInfoMsg();
         _loc2_.shopId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function refreshTimeGoods() : void
      {
         var _loc2_:PackageOut = new PackageOut(8632);
         var _loc1_:* = null;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      private function __refreshTimeBuyHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MainShopInfo = null;
         var _loc4_:BuyDataInfo = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopMsg = new ShopMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as ShopMsg;
         var _loc9_:Number = DateFormatter.parse(_loc2_.refreshDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
         var _loc6_:int = _loc2_.refreshInterval;
         if(_loc6_ <= 0)
         {
            _loc6_ = 3600;
         }
         _refreshTime = _loc6_ / 60 / 60;
         timeBuyDesc = _loc9_ + _loc6_;
         var _loc5_:int = int(_loc2_.hasDataInfo.length);
         var _loc12_:Array = _model.getTimeBuyList();
         var _loc10_:int = int(_loc12_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = readDataInfo(_loc2_.hasDataInfo[_loc7_] as HasDataInfo);
            _loc8_ = 0;
            while(_loc8_ < _loc10_)
            {
               _loc3_ = _loc12_[_loc8_];
               if(!_loc3_.beginDate)
               {
               }
               if(_loc4_.itemId == _loc3_.id)
               {
                  _loc3_.count = _loc4_.counts;
                  break;
               }
               _loc8_++;
            }
            _loc7_++;
         }
         disEvent();
         if(_loc3_)
         {
            shopTimeDesc(_loc3_.needVIPGrade > 0);
         }
      }
      
      public function refreshGoodsCount() : void
      {
         var _loc1_:MainShopInfo = null;
         var _loc2_:int = 0;
         var _loc4_:Array = _model.getTimeBuyList();
         var _loc3_:int = int(_loc4_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = _loc4_[_loc2_];
            if(_loc1_.type == 2)
            {
               _loc1_.count = 0;
            }
            _loc2_++;
         }
      }
      
      private function __shopTempDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:ShopGoodsInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopTempInfoListMsg = new ShopTempInfoListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ShopTempInfoListMsg;
         var _loc6_:Array = [];
         for each(var _loc4_:ShopTempInfoMsg in _loc2_.shopTempInfo)
         {
            _loc3_ = new ShopGoodsInfo();
            _loc3_.Id = _loc4_.id;
            _loc3_.ShopType = _loc4_.shopType;
            _loc3_.Area = _loc4_.area;
            _loc3_.ItemId = _loc4_.itemId;
            _loc3_.Point = _loc4_.point;
            _loc3_.GiftToken = _loc4_.giftToken;
            _loc3_.Gold = _loc4_.gold;
            _loc3_.ConsortiaOffer = _loc4_.consortiaOffer;
            _loc3_.Honor = _loc4_.honor;
            _loc3_.MazeCoin = _loc4_.mazeCoin;
            _loc3_.MazeLayers = _loc4_.mazeLayers;
            _loc3_.MazeLayers2 = _loc4_.mazeLayers2;
            _loc3_.NeedGrades = _loc4_.needGrades;
            _loc3_.NeedConsortiaLevels = _loc4_.needConsortiaLevels;
            _loc3_.NeedMinVip = _loc4_.needMinVip;
            _loc3_.VIP0Count = _loc4_.vIP0Count;
            _loc3_.VIP1Count = _loc4_.vIP1Count;
            _loc3_.VIP2Count = _loc4_.vIP2Count;
            _loc3_.VIP3Count = _loc4_.vIP3Count;
            _loc3_.VIP4Count = _loc4_.vIP4Count;
            _loc3_.VIP5Count = _loc4_.vIP5Count;
            _loc3_.VIP6Count = _loc4_.vIP6Count;
            _loc3_.VIP7Count = _loc4_.vIP7Count;
            _loc3_.VIP8Count = _loc4_.vIP8Count;
            _loc3_.VIP9Count = _loc4_.vIP9Count;
            _loc3_.Discount = _loc4_.discount;
            _loc3_.Sort = _loc4_.sort;
            _loc3_.IsHot = _loc4_.isHot;
            _loc3_.Labels = _loc4_.labels;
            _loc3_.NeedGeste = _loc4_.needGeste;
            _loc3_.ValidDate = _loc4_.validDate;
            _loc3_.Rands = _loc4_.rands;
            _loc3_.NeedMinGrade = _loc4_.needMinGrade;
            _loc3_.NeedMaxGrade = _loc4_.needMaxGrade;
            _loc3_.LordsScore = _loc4_.lordsScore;
            _loc3_.NeedItem = _loc4_.needItem;
            _loc3_.MineScore = _loc4_.mineScore;
            _loc3_.CrossGuildScore = _loc4_.crossGuildScore;
            _loc3_.PokerScore = _loc4_.pokerScore;
            _loc3_.Score = _loc4_.needScore;
            _loc3_.init();
            _loc6_.push(_loc3_);
         }
         _loc6_.sortOn("Sort",16);
         if(_loc2_.hasShopType)
         {
            model.shopTempDic[_loc2_.shopType] = _loc6_;
            if(_loc2_.shopType == 1003)
            {
               FrameControllerManager.instance.shopController.initPokeShopFrame();
            }
         }
      }
      
      private function __limiteTimeDiscountBtnDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:LimiteTimeDiscountInfo = null;
         var _loc7_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopDiscountActiveMsg = new ShopDiscountActiveMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ShopDiscountActiveMsg;
         model.limiteTimeDiscountActiveId = _loc2_.id;
         model.limiteTimeDiscountBegin = _loc2_.begin;
         model.limiteTimeDiscountEnd = _loc2_.end;
         model.limiteTimeDiscountIsOpen = _loc2_.isopen;
         model.limiteTimeDiscountGoodsList = [];
         var _loc5_:int = 0;
         for each(var _loc6_:ShopItemInfoMsg in _loc2_.allItems)
         {
            _loc4_ = new LimiteTimeDiscountInfo();
            _loc4_.id = _loc6_.id;
            _loc4_.limitCount = _loc6_.num;
            _loc4_.price = _loc6_.price;
            _loc4_.templateId = _loc6_.templateId;
            _loc4_.isBindMoney = _loc6_.isBindMoney;
            model.limiteTimeDiscountGoodsList.push(_loc4_);
            _loc5_++;
         }
         model.limiteTimeDiscountGoodsList.sortOn("id",16);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = model.limiteTimeDiscountGoodsList[_loc7_];
            for each(var _loc3_:UserBuyInfoMsg in _loc2_.buyInfos)
            {
               if(_loc4_.id == _loc3_.id)
               {
                  _loc4_.count = _loc3_.num;
                  break;
               }
            }
            _loc7_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOP_LIMITE_TIMEDISCOUNT_UPDATA"));
      }
      
      public function disEvent() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOP_TIME_BUY_REFRESH",null));
      }
      
      public function sendShopingBloo(param1:int, param2:int = 1, param3:Boolean = true) : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 170,__shoppingBlooHandler);
         var _loc6_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         var _loc5_:PackageOut = new PackageOut(5633);
         var _loc4_:ShopMsg = new ShopMsg();
         _loc4_.buyInfo = new BuyInfo();
         _loc4_.buyInfo.goodId = param1;
         _loc4_.buyInfo.count = param2;
         _loc4_.buyInfo.receiveId = _loc6_;
         _loc4_.payType = 0;
         if(!param3)
         {
            _loc4_.payType = 1;
         }
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      protected function __shoppingBlooHandler(param1:SLGSocketEvent) : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 170,__shoppingBlooHandler);
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FastUseBloodMsg = new FastUseBloodMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FastUseBloodMsg;
         var _loc4_:int = _loc2_.templateId;
         var _loc3_:int = _loc2_.result;
         shopingResult(_loc3_);
         if(_loc3_ == 1)
         {
         }
      }
      
      public function getBuyDataInfos() : void
      {
         var _loc1_:PackageOut = new PackageOut(8218);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function getUserId(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8223);
         var _loc2_:CheckNickMsg = new CheckNickMsg();
         _loc2_.nickName = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function getGoodsBuyNum(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc6_:PackageOut = new PackageOut(8693);
         var _loc4_:ShopMsg = new ShopMsg();
         var _loc5_:BuyInfo = new BuyInfo();
         _loc5_.goodId = param1;
         _loc4_.buyInfo = _loc5_;
         _loc4_.buyInfo.type = param2;
         _loc4_.buyInfo.isDiscount = param3;
         sendProtoBuffer(_loc6_,_loc4_);
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public function getCountById(param1:int) : int
      {
         var _loc2_:MainShopInfo = null;
         var _loc3_:int = 0;
         var _loc5_:Array = _model.getTimeBuyList();
         var _loc4_:int = int(_loc5_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = _loc5_[_loc3_];
            if(param1 == _loc2_.id)
            {
               return _loc2_.canTotalCount;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function shopingResult(param1:int, param2:int = 0) : void
      {
         var _loc3_:String = "";
         switch(param1)
         {
            case 1:
               if(isHandsel == 0)
               {
                  _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command01");
               }
               else if(isHandsel == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command13");
               }
               break;
            case 2:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command02");
               break;
            case 3:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command03");
               break;
            case 5:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command05");
               break;
            case 6:
               if(isHandsel == 0)
               {
                  if(getCountById(param2) == -1)
                  {
                     _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command06");
                  }
                  else if(getCountById(param2) > 0)
                  {
                     _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command06");
                  }
                  else
                  {
                     _loc3_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrame.sellOver");
                  }
               }
               else if(isHandsel == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command14");
               }
               break;
            case 7:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command07");
               break;
            case 8:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command08");
               break;
            case 9:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command09");
               break;
            case 10:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command10");
               break;
            case 11:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command11");
               break;
            case 12:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command12");
               break;
            case 15:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command15");
               break;
            case 17:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command17");
               break;
            case 18:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command18");
               break;
            case 19:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command19");
               break;
            case 20:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command20");
               break;
            case 21:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command21");
               break;
            case 22:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command22");
               break;
            case 23:
               _loc3_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command23");
               break;
            case 4:
               return;
         }
         if(_loc3_ != "")
         {
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      public function showShopTimeBuyTip(param1:Boolean = false) : void
      {
         if(ArmyManager.instance.thane.grades < 10)
         {
            return;
         }
         if(FrameControllerManager.instance.shopController.getShopFrame() && isTimeBuyOpen)
         {
            return;
         }
         if(model.getTimeBuyList(0).length <= 0)
         {
            return;
         }
         var _loc2_:String = param1 ? "tasktracetip.view.ShopTimeBuyTipView.vipContentTxt" : "tasktracetip.view.ShopTimeBuyTipView.contentTxt";
         var _loc3_:TipMessageData = new TipMessageData();
         _loc3_.title = LanguageMgr.GetTranslation("public.prompt");
         _loc3_.content = LanguageMgr.GetTranslation(_loc2_);
         _loc3_.type = 33;
         _loc3_.data = {"isVIPShop":param1};
         TaskTraceTipManager.instance.showView(_loc3_);
      }
      
      public function shopTimeDesc(param1:Boolean = false) : void
      {
         clearInterval(_timerId);
         _timerId = setInterval(timerDesc,1000,param1);
      }
      
      private function timerDesc(param1:Boolean) : void
      {
         var _loc2_:int = timeBuyDesc - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc2_ <= 0)
         {
            clearInterval(_timerId);
            _timerId = 0;
            showShopTimeBuyTip(param1);
         }
      }
      
      public function getGroupBuyInfo() : Array
      {
         var _loc1_:Array = null;
         var _loc4_:MainShopInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_model.groupBuyList && _model.groupBuyList.length > 0)
         {
            _loc2_ = int(_model.groupBuyList.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = _model.groupBuyList[_loc3_];
               if(_loc4_.beginDate < PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond)
               {
                  if(_loc4_.sendDate - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond > 0)
                  {
                     if(_loc1_ == null)
                     {
                        _loc1_ = [];
                     }
                     _loc1_.push(_loc4_);
                  }
               }
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      public function getMainShopInfoById(param1:int) : MainShopInfo
      {
         var _loc4_:MainShopInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_model.groupBuyList && _model.groupBuyList.length > 0)
         {
            _loc2_ = int(_model.groupBuyList.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = _model.groupBuyList[_loc3_];
               if(_loc4_.id == param1)
               {
                  return _loc4_;
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      public function allBuy(param1:Array, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:CarItemInfoMsg = null;
         var _loc7_:PackageOut = new PackageOut(8970);
         var _loc3_:ShopCarListMsg = new ShopCarListMsg();
         var _loc5_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = new CarItemInfoMsg();
            _loc4_.shopId = param1[_loc6_].shopId;
            _loc4_.counts = param1[_loc6_].number;
            _loc4_.type = param1[_loc6_].shopType;
            _loc4_.payType = param1[_loc6_].type;
            _loc4_.isDiscountShop = param1[_loc6_].isDiscount;
            _loc5_.push(_loc4_);
            _loc6_++;
         }
         _loc3_.receiveUserId = param2;
         _loc3_.carItemInfo = _loc5_;
         sendProtoBuffer(_loc7_,_loc3_);
      }
      
      public function allFashion(param1:Array, param2:int, param3:Boolean, param4:int) : void
      {
         var _loc8_:int = 0;
         var _loc6_:CarItemInfoMsg = null;
         var _loc9_:PackageOut = new PackageOut(8970);
         var _loc5_:ShopCarListMsg = new ShopCarListMsg();
         var _loc7_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < param1.length)
         {
            _loc6_ = new CarItemInfoMsg();
            _loc6_.shopId = param1[_loc8_].Id;
            _loc6_.counts = param1[_loc8_].count;
            _loc6_.payType = param3 ? 2 : 1;
            _loc6_.isDiscountShop = false;
            _loc7_.push(_loc6_);
            _loc8_++;
         }
         _loc5_.receiveUserId = param2;
         _loc5_.carItemInfo = _loc7_;
         if(param4 != -1)
         {
            _loc5_.discountTempId = param4;
         }
         sendProtoBuffer(_loc9_,_loc5_);
      }
      
      public function buyOne(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int = 0) : void
      {
         var _loc10_:PackageOut = new PackageOut(8970);
         var _loc7_:ShopCarListMsg = new ShopCarListMsg();
         _loc7_.discountTempId = param6;
         var _loc9_:Array = [];
         var _loc8_:CarItemInfoMsg = new CarItemInfoMsg();
         _loc8_.shopId = param1;
         _loc8_.counts = param2;
         _loc8_.payType = param4;
         _loc8_.isDiscountShop = param5;
         _loc9_.push(_loc8_);
         _loc7_.receiveUserId = param3;
         _loc7_.carItemInfo = _loc9_;
         sendProtoBuffer(_loc10_,_loc7_);
      }
      
      public function buyOneNew(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int, param7:int = 0) : void
      {
         var _loc11_:PackageOut = new PackageOut(8970);
         var _loc8_:ShopCarListMsg = new ShopCarListMsg();
         _loc8_.discountTempId = param7;
         var _loc10_:Array = [];
         var _loc9_:CarItemInfoMsg = new CarItemInfoMsg();
         _loc9_.shopId = param1;
         _loc9_.counts = param2;
         _loc9_.type = param6;
         _loc9_.payType = param4;
         _loc9_.isDiscountShop = param5;
         _loc10_.push(_loc9_);
         _loc8_.receiveUserId = param3;
         _loc8_.carItemInfo = _loc10_;
         sendProtoBuffer(_loc11_,_loc8_);
      }
      
      public function getGift(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9545);
         var _loc2_:CarItemInfoMsg = new CarItemInfoMsg();
         _loc2_.shopId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function buyFurnitureGoods(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9519);
         var _loc3_:FurnitureShopBuyMsg = new FurnitureShopBuyMsg();
         _loc3_.shopId = param1;
         _loc3_.count = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

