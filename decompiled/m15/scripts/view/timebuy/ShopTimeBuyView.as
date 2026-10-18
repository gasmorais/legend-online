package view.timebuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import managers.ShopManager;
   import view.GoodsItem5;
   import view.inside.MainRightView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class ShopTimeBuyView extends Sprite implements Disposeable
   {
      
      private static const NUM:int = 6;
      
      private var _homepageTime:Timer;
      
      private var _countGood:int = 0;
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemBgs:MutipleImage;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxtBack:Bitmap;
      
      private var _pageTxt:FilterFrameText;
      
      private var _goodList:Array;
      
      private var _sexwoman:Bitmap;
      
      private var _giftTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _giftTxtBg:MutipleImage;
      
      private var _pointTxtBg:MutipleImage;
      
      private var _rechargeBtn:IconButton;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var _isVIPShop:Boolean = false;
      
      private var b:Boolean = true;
      
      private var _shopCartBtn:IconButton;
      
      private var _mainRightView:MainRightView;
      
      private var _boxMc:MovieClip;
      
      private var _fireMc:MovieClip;
      
      public function ShopTimeBuyView()
      {
         super();
         initView();
         initEvent();
         initTimeGoods();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsItem5 = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.Back1");
         _itemBgs = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG2");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("shop.NextPageBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("shop.LastPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.shop.pageNumBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PageTextStyle1");
         _sexwoman = ComponentFactory.Instance.creatBitmap("asset.shop.sexwoman");
         _boxMc = ComponentFactory.Instance.creatCustomObject("shop.boxMc");
         _fireMc = ComponentFactory.Instance.creatCustomObject("shop.fireMc");
         _giftTxtBg = ComponentFactory.Instance.creatComponentByStylename("shop.pointImage");
         _pointTxtBg = ComponentFactory.Instance.creatComponentByStylename("shop.bindDiamond");
         _giftTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GiftTextStyle1");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PointTextStyle1");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ChargeBtn");
         _shopCartBtn = ComponentFactory.Instance.creatComponentByStylename("shop.VipShopCartBtn");
         addChild(_sexwoman);
         addChild(_boxMc);
         addChild(_fireMc);
         addChild(_bg);
         addChild(_itemBgs);
         _itemBgs.x = 209;
         _itemBgs.y = 31;
         addChild(_giftTxtBg);
         _giftTxtBg.x = 221;
         _giftTxtBg.y = 458;
         addChild(_pointTxtBg);
         _pointTxtBg.x = 400;
         _pointTxtBg.y = 458;
         addChild(_giftTxt);
         _giftTxt.text = playerInfo.giftToken1 + "";
         addChild(_pointTxt);
         _pointTxt.text = playerInfo.point + "";
         _pointTxt.y = _giftTxt.y = 465;
         addChild(_rechargeBtn);
         addChild(_shopCartBtn);
         addChild(_preBtn);
         _preBtn.enable = false;
         addChild(_nextBtn);
         addChild(_pageTxtBack);
         addChild(_pageTxt);
         _pageTxt.text = "1/1";
         _goodList = [];
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc4_ = _loc2_ / 2;
            _loc1_ = _loc2_ % 2;
            _loc3_ = new GoodsItem5();
            _loc3_.x = _loc1_ * (_loc3_.width + 10) + 213;
            _loc3_.y = _loc4_ * (_loc3_.height - 5) + 30;
            addChild(_loc3_);
            _goodList.push(_loc3_);
            _loc2_++;
         }
         ShopManager.Instance.isTimeBuyOpen = true;
         _mainRightView = new MainRightView();
         _mainRightView.x = 240;
         _mainRightView.y = 0;
         addChild(_mainRightView);
         _mainRightView.updateView();
         _boxMc.gotoAndPlay(1);
         _fireMc.gotoAndPlay(1);
      }
      
      private function initTimeGoods() : void
      {
         ShopManager.Instance.refreshTimeGoods();
         ShopManager.Instance.isFrist = false;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
         _rechargeBtn.addEventListener("click",__rechargeHandler);
         if(_shopCartBtn)
         {
            _shopCartBtn.addEventListener("click",__shopCartBtnHandler);
         }
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         NotificationManager.instance.addEventListener("SHOP_TIME_BUY_REFRESH",__refreshTimeBuy);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         _preBtn.removeEventListener("click",_preHandler);
         _nextBtn.removeEventListener("click",_nextHandler);
         _rechargeBtn.removeEventListener("click",__rechargeHandler);
         if(_shopCartBtn)
         {
            _shopCartBtn.removeEventListener("click",__shopCartBtnHandler);
         }
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         NotificationManager.instance.removeEventListener("SHOP_TIME_BUY_REFRESH",__refreshTimeBuy);
      }
      
      private function __shopCartBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",200);
      }
      
      private function __refreshTimeBuy(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      private function __refreshPlayerInfoHandler(param1:PlayerEvent) : void
      {
         _giftTxt.text = playerInfo.giftToken1 + "";
         _pointTxt.text = playerInfo.point + "";
      }
      
      private function __rechargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         updateView();
         updatePageView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
         updatePageView();
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         removeTimer();
         updateView();
      }
      
      public function set isVIPShop(param1:Boolean) : void
      {
         _isVIPShop = param1;
      }
      
      public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _countGood = 0;
         var _loc1_:Array = _isVIPShop ? ShopManager.Instance.model.getTimeBuyList(1) : ShopManager.Instance.model.getTimeBuyList(0);
         if(_loc1_.length % 6 != 0 || _loc1_.length == 0)
         {
            _totalPage = _loc1_.length / 6 + 1;
         }
         else
         {
            _totalPage = _loc1_.length / 6;
         }
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            if(_currentPage - 1 < 0)
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc3_ + (_currentPage - 1) * 6;
            }
            if(_loc1_.length > _loc2_)
            {
               _countGood = _countGood + 1;
               _goodList[_loc3_].data = _loc1_[_loc2_];
            }
            else
            {
               _goodList[_loc3_].data = null;
            }
            _loc3_++;
         }
         if(_countGood > 0)
         {
            if(_homepageTime == null)
            {
               addTimer();
            }
            __updateTimeHandler(null);
         }
         updatePageView();
      }
      
      private function addTimer() : void
      {
         _homepageTime = new Timer(1000);
         _homepageTime.addEventListener("timer",__updateTimeHandler);
         _homepageTime.start();
      }
      
      private function removeTimer() : void
      {
         if(_homepageTime)
         {
            _homepageTime.stop();
            _homepageTime.removeEventListener("timer",__updateTimeHandler);
            _homepageTime = null;
         }
      }
      
      private function updatePageView() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
         if(_currentPage == 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      private function __updateTimeHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            if(_goodList[_loc2_].data)
            {
               _loc3_ = Number(_goodList[_loc2_].data.remainTime);
               if(_loc3_ > 0)
               {
                  _goodList[_loc2_].timeText = _loc3_;
               }
               else
               {
                  _goodList[_loc2_].data = null;
                  updateView();
               }
               if(_goodList[_loc2_].data && _goodList[_loc2_].data.type == 2)
               {
                  _loc4_ = int(ShopManager.Instance.timeBuyDesc);
                  _loc5_ = _loc4_ - playerModel.sysCurTimeBySecond;
                  if(_loc5_ > 0)
                  {
                     _goodList[_loc2_].timeText = _loc5_;
                     b = true;
                  }
                  else if(b)
                  {
                     b = false;
                     ShopManager.Instance.refreshTimeGoods();
                     ShopManager.Instance.refreshGoodsCount();
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeTimer();
         _goodList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_itemBgs);
         _itemBgs = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxtBack);
         _pageTxtBack = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_sexwoman);
         _sexwoman = null;
         ObjectUtils.disposeViolentMc(_boxMc);
         _boxMc = null;
         ObjectUtils.disposeViolentMc(_fireMc);
         _fireMc = null;
         ObjectUtils.disposeObject(_giftTxt);
         _giftTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_giftTxtBg);
         _giftTxtBg = null;
         ObjectUtils.disposeObject(_pointTxtBg);
         _pointTxtBg = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeObject(_shopCartBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeObject(_mainRightView);
         _mainRightView = null;
         ShopManager.Instance.isTimeBuyOpen = false;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
   }
}

