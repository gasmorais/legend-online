package discountshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.discountshop.DiscountShopItemInfo;
   import mvc.module.discountshop.DiscountShopModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.DiscountShopManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   
   public class DiscountGoodsItem extends Sprite implements Disposeable
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _initialPriceTxt:FilterFrameText;
      
      protected var _initialPriceValue:FilterFrameText;
      
      protected var _nowPriceTxt:FilterFrameText;
      
      protected var _nowPriceValue:FilterFrameText;
      
      protected var _nowPriceCount:FilterFrameText;
      
      protected var _lineImg:Bitmap;
      
      protected var _diamondIcon1:ScaleFrameImage;
      
      protected var _diamondIcon2:ScaleFrameImage;
      
      protected var _goods:BaseItemView;
      
      protected var _buyBtn:IconButton;
      
      protected var _data:DiscountShopItemInfo;
      
      public function DiscountGoodsItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("discountshop.ItemGoodsItemBg");
         _initialPriceTxt = ComponentFactory.Instance.creatComponentByStylename("discountshop.IniItemGoodsText");
         _initialPriceValue = ComponentFactory.Instance.creatComponentByStylename("discountshop.IniItemGoodsValue");
         _nowPriceTxt = ComponentFactory.Instance.creatComponentByStylename("discountshop.NowItemGoodsText");
         _nowPriceValue = ComponentFactory.Instance.creatComponentByStylename("discountshop.NowItemGoodsValue");
         _nowPriceCount = ComponentFactory.Instance.creatComponentByStylename("discountshop.NowItemGoodsCount");
         _diamondIcon1 = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _diamondIcon2 = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _lineImg = ComponentFactory.Instance.creatBitmap("asset.discountshop.redline");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("discountshop.ItemBaseItemView");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_initialPriceTxt);
         _initialPriceTxt.text = LanguageMgr.GetTranslation("discountshop.goodsitem.initialPrice");
         addChild(_initialPriceValue);
         _initialPriceValue.text = "5000";
         addChild(_nowPriceTxt);
         _nowPriceTxt.text = LanguageMgr.GetTranslation("discountshop.goodsitem.nowPrice");
         addChild(_nowPriceValue);
         _nowPriceValue.text = "4000";
         addChild(_diamondIcon1);
         _diamondIcon1.setFrame(1);
         _diamondIcon1.x = 217;
         _diamondIcon1.y = 18;
         addChild(_diamondIcon2);
         _diamondIcon2.setFrame(1);
         _diamondIcon2.x = 217;
         _diamondIcon2.y = 47;
         addChild(_lineImg);
         addChild(_buyBtn);
         addChild(_goods);
         addChild(_nowPriceCount);
         _buyBtn.x = 171;
         _buyBtn.y = 70;
      }
      
      protected function addEvent() : void
      {
         _buyBtn.addEventListener("click",__clickHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
      }
      
      protected function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__clickHandler);
         }
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:DiscountShopBuyFrame = ComponentFactory.Instance.creatComponentByStylename("discountshop.buyFrame");
         _loc1_.data = _data;
         _loc1_.show();
      }
      
      public function set data(param1:DiscountShopItemInfo) : void
      {
         _data = param1;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = param1.itemId;
         _goods.data = _loc3_;
         _initialPriceValue.text = param1.price.toString();
         var _loc2_:int = param1.price * discountModel.myDiscount / 10 < 1 ? 1 : param1.price * discountModel.myDiscount / 10;
         _nowPriceValue.text = _loc2_.toString();
         _nowPriceCount.text = param1.count.toString();
      }
      
      public function get discountModel() : DiscountShopModel
      {
         return DiscountShopManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_initialPriceTxt)
         {
            ObjectUtils.disposeObject(_initialPriceTxt);
         }
         _initialPriceTxt = null;
         if(_initialPriceValue)
         {
            ObjectUtils.disposeObject(_initialPriceValue);
         }
         _initialPriceValue = null;
         if(_nowPriceTxt)
         {
            ObjectUtils.disposeObject(_nowPriceTxt);
         }
         _nowPriceTxt = null;
         if(_nowPriceValue)
         {
            ObjectUtils.disposeObject(_nowPriceValue);
         }
         _nowPriceValue = null;
         if(_nowPriceCount)
         {
            ObjectUtils.disposeObject(_nowPriceCount);
         }
         _nowPriceCount = null;
         if(_lineImg)
         {
            ObjectUtils.disposeObject(_lineImg);
         }
         _lineImg = null;
         if(_diamondIcon1)
         {
            ObjectUtils.disposeObject(_diamondIcon1);
         }
         _diamondIcon1 = null;
         if(_diamondIcon2)
         {
            ObjectUtils.disposeObject(_diamondIcon2);
         }
         _diamondIcon2 = null;
         if(_goods)
         {
            ObjectUtils.disposeObject(_goods);
         }
         _goods = null;
         if(_buyBtn)
         {
            ObjectUtils.disposeObject(_buyBtn);
         }
         _buyBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

