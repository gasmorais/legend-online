package vip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.ShopManager;
   import managers.VIPManager;
   import mvc.module.currency.CurrencyInfo;
   import mvc.module.shop.ShopModel;
   import mvc.module.vip.VIPModel;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class VIPShopView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _bottomBg:Image;
      
      private var _centerBg:Image;
      
      private var _privilegeBtn:IconButton;
      
      private var _time:FilterFrameText;
      
      private var _timeBg:Bitmap;
      
      private var _frameVipIcon:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _vipGradeSp:Sprite;
      
      private var _frameVipIcon01:Bitmap;
      
      private var _frameVipIcon00:Bitmap;
      
      private var _frameExp:MovieImage;
      
      private var _currentLevelIcon:ScaleFrameImage;
      
      private var _nextLevelIcon:ScaleFrameImage;
      
      private var _expMcImage:MovieImage;
      
      private var _progressTxt:FilterFrameText;
      
      private var _currencyBg:Image;
      
      private var _currencyIcon:Image;
      
      private var _currencyName:Image;
      
      private var _currencyTxt:FilterFrameText;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _exchangeItemList:Array;
      
      private var _shopModel:ShopModel;
      
      private var _vipGradeNunBg:BitmapData;
      
      public function VIPShopView()
      {
         super();
         _shopModel = ShopManager.Instance.model;
         initView();
         addEvent();
         FrameControllerManager.instance.shopController.initVIPShopFrame();
         __UpViewFrame(null);
      }
      
      private function initView() : void
      {
         var _loc1_:VipShopItem = null;
         var _loc5_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.bg");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.BottomBg");
         _centerBg = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.CenterBg");
         _frameExp = ComponentFactory.Instance.creatComponentByStylename("vip.vipFrameExp");
         _vipGradeNunBg = ComponentFactory.Instance.creatBitmapData("asset.vip.VipGradeNunber");
         _currencyBg = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.CurrencyBg");
         _currencyIcon = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.CurrencyIcon");
         _currencyName = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.CurrencyName");
         _currencyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.CurrencyTxt");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.pageTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.HelpBtn");
         _privilegeBtn = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeBtn");
         _frameVipIcon01 = ComponentFactory.Instance.creatBitmap("asset.vip.FrameVipIcon01");
         _frameVipIcon00 = ComponentFactory.Instance.creatBitmap("asset.vip.FrameVipIcon00");
         _time = ComponentFactory.Instance.creatComponentByStylename("vip.vipFrameTime");
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipFrameTimeBg");
         _frameVipIcon = ComponentFactory.Instance.creatBitmap("asset.vip.FrameVipIcon");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("vip.LevelTxt");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("vip.ExpTxt");
         addChild(_bg);
         addChild(_bottomBg);
         addChild(_privilegeBtn);
         addChild(_frameVipIcon);
         addChild(_frameVipIcon00);
         addChild(_frameVipIcon01);
         addChild(_time);
         addChild(_timeBg);
         addChild(_frameExp);
         _vipGradeSp = new Sprite();
         addChild(_vipGradeSp);
         _vipGradeSp.x = _frameVipIcon.x + 29;
         addChild(_levelTxt);
         addChild(_expTxt);
         addChild(_currencyBg);
         addChild(_currencyIcon);
         addChild(_currencyName);
         addChild(_currencyTxt);
         _currencyTxt.text = gemDust.amount + "";
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         _pageTxt.text = "1/1";
         _exchangeItemList = [];
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc1_ = new VipShopItem();
            _loc6_ = _loc5_ / 2;
            _loc3_ = _loc5_ % 2;
            _loc1_.x = 273 * _loc3_;
            _loc1_.y = 96 * _loc6_ + 123 - 25;
            _exchangeItemList.push(_loc1_);
            addChild(_loc1_);
            _loc5_++;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataTitle",vipModel.vipInfo.VipGp);
         var _loc4_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataContent");
         addChild(_centerBg);
         _centerBg.mouseChildren = _centerBg.mouseEnabled = false;
         _frameExp.tipData = {
            "title":_loc2_,
            "content":_loc4_
         };
         _helpBtn.tipData = LanguageMgr.GetTranslation("vip.vipShop.view.helpBtnTip");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_currencyBg);
         _currencyBg = null;
         ObjectUtils.disposeObject(_currencyName);
         _currencyName = null;
         ObjectUtils.disposeObject(_currencyIcon);
         _currencyIcon = null;
         ObjectUtils.disposeObject(_currencyTxt);
         _currencyTxt = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_centerBg);
         _centerBg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
      }
      
      private function addEvent() : void
      {
         _lastPageBtn.addEventListener("click",__pageBtnClickHandler);
         _nextPageBtn.addEventListener("click",__pageBtnClickHandler);
         _shopModel.addEventListener("PAGE_UPDATE",__refreshPageHandler);
         _shopModel.addEventListener("GOODS_LIST_UPDATE",__refreshGoodsHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__currencyRefreshHandler);
         vipModel.addEventListener("vipshop_levelinfo",__levelInfoHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
         _privilegeBtn.addEventListener("click",__privilegeHandler);
         vipModel.addEventListener("upframeview_change",__UpViewFrame);
      }
      
      public function __UpViewFrame(param1:Event) : void
      {
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            _frameVipIcon00.visible = false;
            _vipGradeSp.visible = true;
            _time.text = DateFormatter.getFullDateString(vipModel.vipInfo.ExpirData.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
            if(vipModel.vipInfo.VipType == 1)
            {
               _frameVipIcon01.visible = true;
               _frameVipIcon.visible = false;
               _vipGradeSp.y = 30;
            }
            else
            {
               _frameVipIcon.visible = true;
               _frameVipIcon01.visible = false;
               _vipGradeSp.y = 24;
            }
         }
         else
         {
            _frameVipIcon00.visible = true;
            _frameVipIcon.visible = false;
            _frameVipIcon01.visible = false;
            _vipGradeSp.visible = false;
            _time.text = "";
         }
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(vipModel.vipInfo.VipGrade + 1,4);
         if(!_loc2_)
         {
            _frameExp.setFrame(100);
            _expTxt.text = vipModel.vipInfo.VipGp + "";
         }
         else if(_loc2_.Data == 0)
         {
            _frameExp.setFrame(1);
            _expTxt.text = vipModel.vipInfo.VipGp + " / " + vipModel.vipInfo.VipGp;
         }
         else
         {
            _frameExp.setFrame(int(vipModel.vipInfo.VipGp / _loc2_.Data * 100));
            _expTxt.text = vipModel.vipInfo.VipGp + " / " + _loc2_.Data;
         }
         _levelTxt.text = vipModel.vipInfo.VipGrade + "";
         NumberViewUtils.refreshValue(vipModel.vipInfo.VipGrade - 1,_vipGradeSp,_vipGradeNunBg,24,27,0,24);
         var _loc3_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataTitle",vipModel.vipInfo.VipGp);
         var _loc4_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataContent");
         _frameExp.tipData = {
            "title":_loc3_,
            "content":_loc4_
         };
      }
      
      private function __privilegeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.vipController.showPrivilegeFrame();
      }
      
      private function removeEvent() : void
      {
         _privilegeBtn.removeEventListener("click",__privilegeHandler);
         vipModel.removeEventListener("upframeview_change",__UpViewFrame);
         _nextPageBtn.removeEventListener("click",__pageBtnClickHandler);
         _nextPageBtn.removeEventListener("click",__pageBtnClickHandler);
         _shopModel.removeEventListener("PAGE_UPDATE",__refreshPageHandler);
         _shopModel.removeEventListener("GOODS_LIST_UPDATE",__refreshGoodsHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__currencyRefreshHandler);
         vipModel.removeEventListener("vipshop_levelinfo",__levelInfoHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.HelpFrame");
         _loc2_["show"]();
      }
      
      private function __currencyRefreshHandler(param1:NotificationEvent) : void
      {
         _currencyTxt.text = gemDust.amount + "";
      }
      
      private function __refreshPageHandler(param1:ShopEvent) : void
      {
         _pageTxt.text = _shopModel.currentPage + "/" + _shopModel.totalPage;
         _lastPageBtn.enable = _shopModel.currentPage != 1;
         _nextPageBtn.enable = _shopModel.currentPage != _shopModel.totalPage;
      }
      
      private function __refreshGoodsHandler(param1:ShopEvent) : void
      {
         var _loc2_:VipShopItem = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _exchangeItemList.length)
         {
            _loc2_ = _exchangeItemList[_loc3_];
            if(_loc3_ < _shopModel.showGoodsList.length)
            {
               _loc2_.data = _shopModel.showGoodsList[_loc3_];
            }
            else
            {
               _loc2_.data = null;
            }
            _loc3_++;
         }
      }
      
      private function __pageBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _lastPageBtn);
      }
      
      private function __levelInfoHandler(param1:VIPEvent) : void
      {
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function get gemDust() : CurrencyInfo
      {
         return PlayerCurrencyManager.instance.currencyInfo.gemDust;
      }
   }
}

