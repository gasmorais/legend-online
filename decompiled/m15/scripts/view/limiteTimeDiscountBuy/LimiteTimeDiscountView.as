package view.limiteTimeDiscountBuy
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
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.ShopManager;
   import view.GoodsItem11;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class LimiteTimeDiscountView extends Sprite implements Disposeable
   {
      
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
      
      private var _shopCartBtn:IconButton;
      
      public function LimiteTimeDiscountView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsItem11 = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.Back1");
         _itemBgs = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG2");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("shop.NextPageBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("shop.LastPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.shop.pageNumBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PageTextStyle1");
         _sexwoman = ComponentFactory.Instance.creatBitmap("asset.shop.sexwoman");
         _giftTxtBg = ComponentFactory.Instance.creatComponentByStylename("shop.pointImage");
         _pointTxtBg = ComponentFactory.Instance.creatComponentByStylename("shop.bindDiamond");
         _giftTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GiftTextStyle1");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PointTextStyle1");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ChargeBtn");
         _shopCartBtn = ComponentFactory.Instance.creatComponentByStylename("shop.VipShopCartBtn");
         addChild(_sexwoman);
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
         _giftTxt.text = playerInfo.giftToken + "";
         addChild(_pointTxt);
         _pointTxt.text = playerInfo.point + "";
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
         while(_loc2_ < 9)
         {
            _loc4_ = _loc2_ / 3;
            _loc1_ = _loc2_ % 3;
            _loc3_ = new GoodsItem11();
            _loc3_.x = _loc1_ * (_loc3_.width - 3) + 217;
            _loc3_.y = _loc4_ * _loc3_.height + 30;
            addChild(_loc3_);
            _goodList.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
         _rechargeBtn.addEventListener("click",__rechargeHandler);
         if(_shopCartBtn)
         {
            _shopCartBtn.addEventListener("click",__shopCartBtnHandler);
         }
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",_preHandler);
         _nextBtn.removeEventListener("click",_nextHandler);
         _rechargeBtn.removeEventListener("click",__rechargeHandler);
         if(_shopCartBtn)
         {
            _shopCartBtn.removeEventListener("click",__shopCartBtnHandler);
         }
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
      }
      
      private function __shopCartBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",200);
      }
      
      private function __refreshPlayerInfoHandler(param1:PlayerEvent) : void
      {
         _giftTxt.text = playerInfo.giftToken + "";
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
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _countGood = 0;
         var _loc1_:Array = ShopManager.Instance.model.limiteTimeDiscountGoodsList;
         if(_loc1_.length % 9 != 0 || _loc1_.length == 0)
         {
            _totalPage = _loc1_.length / 9 + 1;
         }
         else
         {
            _totalPage = _loc1_.length / 9;
         }
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            if(_currentPage - 1 < 0)
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc3_ + (_currentPage - 1) * 9;
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
         updatePageView();
      }
      
      private function updatePageView() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
         ShopManager.Instance.model.limiteTimeDicountCurrentPage = _currentPage;
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
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
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
         ShopManager.Instance.isTimeBuyOpen = false;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

