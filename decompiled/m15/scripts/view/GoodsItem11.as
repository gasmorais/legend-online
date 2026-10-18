package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shop.LimiteTimeDiscountInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.ShopLimiteTimeDiscountBuyFrame;
   
   public class GoodsItem11 extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _lookBtn:TextButton;
      
      private var _buyBtn:IconButton;
      
      private var _name:FilterFrameText;
      
      private var _value:FilterFrameText;
      
      private var _valueIcon:ScaleFrameImage;
      
      private var _goods:BaseItemView;
      
      private var _discountMc:MovieImage;
      
      private var _promoTimeTxt:Bitmap;
      
      private var _data:LimiteTimeDiscountInfo;
      
      private var _listPriceTxt:FilterFrameText;
      
      private var _listPriceImg:ScaleFrameImage;
      
      private var _lineShape:Sprite;
      
      private var _hasGetMaxTxt:FilterFrameText;
      
      public function GoodsItem11()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsItemBg1");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.BuyBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsNameTextStyle");
         _value = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsValueTextStyle");
         _valueIcon = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.BaseItemView");
         _promoTimeTxt = ComponentFactory.Instance.creatBitmap("asset.core.PromoTimeImgTxt");
         _listPriceTxt = ComponentFactory.Instance.creatComponentByStylename("shop.timeBuyListPromptTxt");
         _listPriceImg = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _hasGetMaxTxt = ComponentFactory.Instance.creatComponentByStylename("shop.hasGetMaxTxt");
         _listPriceImg.x = 0;
         _listPriceImg.y = 0;
         _bg.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         addChild(_bg);
         addChild(_buyBtn);
         addChild(_name);
         addChild(_value);
         addChild(_valueIcon);
         _valueIcon.y = 55;
         _valueIcon.x = 194;
         addChild(_goods);
         addChild(_lookBtn);
         addChild(_hasGetMaxTxt);
         _hasGetMaxTxt.text = LanguageMgr.GetTranslation("view.GoodsItem10.hasBuyEnough");
         _hasGetMaxTxt.visible = false;
      }
      
      private function creatShape() : void
      {
         _lineShape = new Sprite();
         _lineShape.graphics.lineStyle(1,10066329,1);
         _lineShape.graphics.moveTo(110 - _listPriceTxt.textWidth,77);
         _lineShape.graphics.lineTo(138,77);
         _lineShape.graphics.endFill();
         addChild(_lineShape);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseOut);
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseOut);
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _buyBtn)
         {
            __onBuyBtnHandler(param1);
         }
         else if(isFashion)
         {
            __onLookBtnHandler(param1);
         }
      }
      
      private function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:ShopLimiteTimeDiscountBuyFrame = ComponentFactory.Instance.creatComponentByStylename("shop.ShopLimiteTimeDiscountBuyFrame");
         _loc1_.show();
         _loc1_.data(_data);
      }
      
      public function set data(param1:LimiteTimeDiscountInfo) : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:GoodsInfo = null;
         _goods.data = null;
         _data = param1;
         buttonMode = isFashion;
         if(_lineShape)
         {
            _lineShape.graphics.clear();
            ObjectUtils.disposeObject(_lineShape);
         }
         if(_data)
         {
            initEvent();
            _listPriceImg.visible = true;
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _data.templateId;
            if(!_loc2_)
            {
               data = null;
               return;
            }
            _listPriceTxt.htmlText = "<strike>" + _data.price + "</strike> ";
            _listPriceImg.setFrame(1);
            _goods.data = _loc3_;
            _name.text = _loc2_.TemplateName;
            _value.text = _data.price + "";
            _valueIcon.visible = true;
            _buyBtn.visible = true;
            _buyBtn.enable = true;
            _hasGetMaxTxt.visible = false;
            if(param1.limitCount <= param1.count)
            {
               _buyBtn.enable = false;
               _hasGetMaxTxt.visible = true;
            }
            else
            {
               _buyBtn.enable = true;
            }
         }
         else
         {
            _data = null;
            _goods.data = null;
            if(_lineShape)
            {
               _lineShape.graphics.clear();
               ObjectUtils.disposeObject(_lineShape);
            }
            _hasGetMaxTxt.visible = false;
            _listPriceImg.visible = false;
            _lookBtn.visible = false;
            _buyBtn.visible = false;
            _promoTimeTxt.visible = false;
            _valueIcon.visible = false;
            _listPriceTxt.text = "";
            _name.text = "";
            _value.text = "";
            removeEvent();
         }
      }
      
      protected function get isFashion() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         if(!TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId))
         {
            return false;
         }
         switch(int(TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId).SonType) - 109)
         {
            case 0:
               return true;
            case 1:
               return true;
            case 2:
               return true;
            case 3:
               return true;
            default:
               return false;
         }
      }
      
      private function __onLookBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:* = undefined;
         if(isFashion)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
            _loc2_ = new Vector.<GoodsTemplateInfo>();
            _loc2_.push(null);
            _loc2_.push(null);
            _loc2_.push(null);
            _loc2_.push(null);
            if(_loc3_.SonType == 109)
            {
               _loc2_[0] = _loc3_;
            }
            else if(_loc3_.SonType == 111)
            {
               _loc2_[1] = _loc3_;
            }
            else if(_loc3_.SonType == 112)
            {
               _loc2_[2] = _loc3_;
            }
            else if(_loc3_.SonType == 110)
            {
               _loc2_[3] = _loc3_;
            }
            FrameControllerManager.instance.openControllerByInfo("shop",9,[_loc2_,null,null]);
         }
      }
      
      public function buyWingFunction() : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      public function get data() : LimiteTimeDiscountInfo
      {
         return _data;
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
         if(isFashion && _lookBtn)
         {
            _lookBtn.visible = false;
         }
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
         if(_lookBtn)
         {
            _lookBtn.visible = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _lookBtn = null;
         _buyBtn = null;
         _name = null;
         _value = null;
         _valueIcon = null;
         _goods = null;
         _discountMc = null;
         _data = null;
      }
   }
}

