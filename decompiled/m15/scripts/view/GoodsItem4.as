package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.DateFormatter;
   
   public class GoodsItem4 extends GoodsItem
   {
      
      private var _timeRemaining:FilterFrameText;
      
      private var _timeRemainingImg:Bitmap;
      
      private var _purchaseNum:FilterFrameText;
      
      private var _discountMc:MovieImage;
      
      private var _purchase:FilterFrameText;
      
      public function GoodsItem4()
      {
         super();
         initView();
      }
      
      override protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.timeBuyGoodsItemBg");
         _timeRemainingImg = ComponentFactory.Instance.creatBitmap("asset.shop.timeRemainingBG");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.BaseItemView2");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.timeBuyGoodsNameTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.goodsItemtimeBuyBtn");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.goodsItem4ValueTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _timeRemaining = ComponentFactory.Instance.creatComponentByStylename("shop.timeRemaining");
         _bg.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         addChild(_bg);
         addChild(_lineImg);
         addChild(_timeRemaining);
         addChild(_timeRemainingImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_goods);
         _lineImg.y = 68;
      }
      
      private function __timerHand(param1:TimerEvent) : void
      {
      }
      
      override public function set data(param1:ShopGoodsInfo) : void
      {
         buttonMode = false;
         super.data = param1;
         if(!param1)
         {
         }
      }
      
      private function setPurchaseNum(param1:int) : void
      {
         if(param1 > 0)
         {
            _purchaseNum = ComponentFactory.Instance.creatComponentByStylename("shop.PurchaseNumTextStyle");
            _purchase = ComponentFactory.Instance.creatComponentByStylename("shop.PurchaseTextStyle");
            addChild(_purchaseNum);
            addChild(_purchase);
            _purchase.text = LanguageMgr.GetTranslation("task.view.shopFrame.Purchase");
            _purchaseNum.text = param1 + "";
         }
      }
      
      private function setDiscount(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         if(!_discountMc)
         {
            _discountMc = ComponentFactory.Instance.creatComponentByStylename("shop.timeBuyDiscountMc");
            addChild(_discountMc);
            _discountMc.mouseChildren = false;
            _discountMc.mouseEnabled = false;
         }
         _discountMc.movie.gotoAndStop(param1);
      }
      
      private function setLabel(param1:int) : void
      {
      }
      
      private function settime(param1:int) : void
      {
         _timeRemaining.text = DateFormatter.getStopDateString(param1);
         _timeRemaining.visible = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function showTime(param1:int) : String
      {
         return "2{invalid_utf8=229}{invalid_utf8=164}?3小时";
      }
   }
}

