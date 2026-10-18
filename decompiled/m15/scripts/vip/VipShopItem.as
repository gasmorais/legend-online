package vip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.ShopManager;
   import managers.VIPManager;
   import mvc.module.currency.CurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.vip.VIPModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class VipShopItem extends Component
   {
      
      private var _bg:Image;
      
      private var _goods:BaseItemView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _noDiscountCurrencyTxt:FilterFrameText;
      
      private var _currencyTxt:FilterFrameText;
      
      private var _currencyImage:Image;
      
      private var _exchangeBtn:IconButton;
      
      private var _tip:FilterFrameText;
      
      private var _lineShape:Sprite;
      
      private var _data:ShopGoodsInfo;
      
      public function VipShopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopItem.bg");
         _goods = ComponentFactory.Instance.creatCustomObject("vip.vipShopItem.goodsItem");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopItem.name");
         _noDiscountCurrencyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopItem.noDiscountCurrency");
         _currencyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopItem.currency");
         _currencyImage = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopView.CurrencyIcon");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopItem.exchangeBtn");
         _tip = ComponentFactory.Instance.creatComponentByStylename("vip.vipShopItem.tip");
         addChild(_bg);
         addChild(_goods);
         addChild(_nameTxt);
         addChild(_noDiscountCurrencyTxt);
         addChild(_currencyTxt);
         addChild(_currencyImage);
         _currencyImage.x = 160;
         _currencyImage.y = 67;
         addChild(_exchangeBtn);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_noDiscountCurrencyTxt);
         _noDiscountCurrencyTxt = null;
         ObjectUtils.disposeObject(_currencyTxt);
         _currencyTxt = null;
         ObjectUtils.disposeObject(_currencyImage);
         _currencyImage = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         ObjectUtils.disposeObject(_tip);
         _tip = null;
      }
      
      private function addEvent() : void
      {
         _exchangeBtn.addEventListener("click",__exChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _exchangeBtn.removeEventListener("click",__exChangeHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         clean();
         _data = param1;
         if(_data != null)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _data.ItemId;
            _goods.data = _loc2_;
            _nameTxt.text = _loc2_.templateInfo.TemplateName;
            _currencyImage.visible = true;
            _exchangeBtn.visible = true;
            _noDiscountCurrencyTxt.text = _data.Score + "";
            creatShape();
            _currencyTxt.text = Math.floor(_data.Score * getDiscountByLevel() / 10) + "";
         }
      }
      
      private function clean() : void
      {
         _goods.data = null;
         _nameTxt.text = "";
         _currencyTxt.text = "";
         _noDiscountCurrencyTxt.text = "";
         _currencyImage.visible = false;
         _exchangeBtn.visible = false;
         _tip.visible = false;
         if(_lineShape)
         {
            _lineShape.graphics.clear();
            ObjectUtils.disposeObject(_lineShape);
         }
      }
      
      private function getDiscountByLevel() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getTemplatesByType(208);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].grade == vipModel.vipInfo.VipGrade)
            {
               _loc1_ = Number(_loc3_[_loc2_].para1);
            }
            _loc2_++;
         }
         return _loc1_ / 10;
      }
      
      private function creatShape() : void
      {
         _lineShape = new Sprite();
         _lineShape.graphics.lineStyle(1,12451871,1);
         _lineShape.graphics.moveTo(153 - _noDiscountCurrencyTxt.textWidth,68);
         _lineShape.graphics.lineTo(157,68);
         _lineShape.graphics.endFill();
         addChild(_lineShape);
      }
      
      private function __exChangeHandler(param1:MouseEvent) : void
      {
         if(!vipModel.vipInfo.IsVipAndNoExpirt)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("vip.vipShop.item.tip04"));
            return;
         }
         var _loc2_:int = _data.Score * getDiscountByLevel() / 10;
         if(gemDust.amount < _loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("vip.vipShop.item.tip02"));
            return;
         }
         CheckUIModuleUtil.instance.tryCall("numbuy",showExchangeFrameCall);
      }
      
      private function showExchangeFrameCall() : void
      {
         ShopManager.Instance.type = 1033;
         ShopManager.Instance.currBuyGoods = null;
         ShopManager.Instance.currBuyGoods2 = _data;
         ShopManager.Instance.getGoodsBuyNum(_data.Id,1033,false);
      }
      
      private function get gemDust() : CurrencyInfo
      {
         return PlayerCurrencyManager.instance.currencyInfo.gemDust;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
   }
}

