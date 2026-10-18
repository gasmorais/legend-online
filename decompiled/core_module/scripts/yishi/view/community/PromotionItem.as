package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.view.frame.LookFrame;
   import yishi.view.frame.ShopMainBuyFrame;
   
   public class PromotionItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _lookBtn:TextButton;
      
      private var _buyBt:BaseButton;
      
      private var _name:FilterFrameText;
      
      private var _value:FilterFrameText;
      
      private var _valueIcon:ScaleFrameImage;
      
      private var _goods:BaseItemView;
      
      private var _label:Bitmap;
      
      private var _timeLable:Bitmap;
      
      private var _timeValue:FilterFrameText;
      
      private var _discountBack:Bitmap;
      
      private var _discountTxtBitm:Bitmap;
      
      private var _discountTxt:FilterFrameText;
      
      private var _promoTimeTxt:Bitmap;
      
      private var _promoTimeTxt02:Bitmap;
      
      private var _promoPromptTxt:Bitmap;
      
      private var _data:MainShopInfo;
      
      private var _lookFrame:LookFrame;
      
      public function PromotionItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsItemBg4");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _buyBt = ComponentFactory.Instance.creatComponentByStylename("shop.BuyBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsNameTextStyle");
         _value = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsValueTextStyle");
         _valueIcon = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.PromotionItemView");
         _discountTxt = ComponentFactory.Instance.creatComponentByStylename("shop.DiscountTxt");
         _timeValue = ComponentFactory.Instance.creatComponentByStylename("shop.PromotionText");
         _discountBack = ComponentFactory.Instance.creatBitmap("asset.core.DiscountBack");
         _label = ComponentFactory.Instance.creatBitmap("asset.core.PromotionBtnImg");
         _timeLable = ComponentFactory.Instance.creatBitmap("asset.core.PromotionTimeBtnImg");
         _discountTxtBitm = ComponentFactory.Instance.creatBitmap("asset.core.DiscounttxtBitm");
         _promoTimeTxt = ComponentFactory.Instance.creatBitmap("asset.core.PromoTimeImgTxt");
         _promoTimeTxt02 = ComponentFactory.Instance.creatBitmap("asset.core.PromoTimeImgTxt02");
         _promoPromptTxt = ComponentFactory.Instance.creatBitmap("asset.core.PromoPromptImgTxt");
         _bg.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         addChild(_bg);
         addChild(_buyBt);
         _buyBt.x = 122;
         _buyBt.y = 105;
         _buyBt.visible = false;
         addChild(_name);
         _name.x = 91;
         _name.y = 51;
         addChild(_value);
         _value.x = 105;
         _value.y = 79;
         addChild(_valueIcon);
         _valueIcon.x = 175;
         _valueIcon.y = 80;
         _valueIcon.visible = false;
         addChild(_goods);
         addChild(_discountBack);
         _discountBack.visible = false;
         addChild(_discountTxtBitm);
         _discountTxtBitm.visible = false;
         addChild(_discountTxt);
         addChild(_label);
         addChild(_timeLable);
         addChild(_timeValue);
         addChild(_promoTimeTxt);
         _promoTimeTxt.visible = false;
         addChild(_promoTimeTxt02);
         _promoTimeTxt02.visible = false;
         addChild(_promoPromptTxt);
         _promoPromptTxt.visible = false;
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
         if(param1.target == _buyBt)
         {
            __buyHandler(param1);
         }
         else if(isFashion)
         {
            __onLookBtnHandler(param1);
         }
      }
      
      public function set data(param1:MainShopInfo) : void
      {
         var _loc2_:String = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc8_:Object = null;
         var _loc7_:GoodsInfo = null;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc3_:ShopGoodsInfo = null;
         var _loc4_:GoodsTemplateInfo = null;
         _goods.data = null;
         _data = param1;
         buttonMode = isFashion;
         if(param1)
         {
            initEvent();
            if(_data.isGift)
            {
               _goods.icon.icon = PathManager.info.REQUEST_PATH + _data.url;
               _loc2_ = _data.content;
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
               if(_loc6_ && _loc6_.SonType == 206)
               {
                  _loc2_ += "<br/><font color=\'#00ff00\'>" + _loc6_.Description + "</font>";
               }
               _loc8_ = {
                  "name":_data.names,
                  "content":_loc2_
               };
               _goods.icon.tipData = _loc8_;
               _goods.icon.tipStyle = "yishi.view.tips.ShopMainTips";
               _name.text = _data.names;
               _valueIcon.setFrame(1);
            }
            else
            {
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _data.templateId;
               _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
               _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(_data.templateId);
               if(!_loc5_ || !_loc3_)
               {
                  data = null;
                  return;
               }
               _goods.data = _loc7_;
               _name.text = _loc5_.TemplateName;
            }
            _value.text = _data.price + "";
            _valueIcon.visible = true;
            _buyBt.visible = true;
            if(_data.isDiscount <= 0)
            {
               _discountBack.visible = true;
               _discountTxtBitm.visible = true;
               _discountTxt.text = _data.discount * 10 + "";
            }
            _promoPromptTxt.visible = false;
            _timeLable.filters = null;
            _label.filters = null;
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
            if(isFashion)
            {
               _discountBack.y = 73;
               _discountTxtBitm.y = 95;
               _discountTxt.y = 77;
            }
            else
            {
               _discountBack.y = 93;
               _discountTxtBitm.y = 115;
               _discountTxt.y = 97;
            }
         }
         else
         {
            _data = null;
            _goods.data = null;
            _lookBtn.visible = false;
            _buyBt.visible = false;
            _promoTimeTxt.visible = false;
            _promoTimeTxt02.visible = false;
            _valueIcon.visible = false;
            _discountBack.visible = false;
            _discountTxtBitm.visible = false;
            _promoPromptTxt.visible = true;
            _name.text = "";
            _value.text = "";
            _discountTxt.text = "";
            _timeValue.text = "";
            removeEvent();
            _timeLable.filters = ComponentFactory.Instance.creatFilters("core.GrayFilter");
            _label.filters = ComponentFactory.Instance.creatFilters("core.GrayFilter");
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
         switch(TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId).SonType - 109)
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
         var _loc2_:ShopGoodsInfo = null;
         if(isFashion)
         {
            _loc2_ = ShopManager.Instance.model.getShopTempInfoById(_data.shopId);
            FrameControllerManager.instance.fashionCodeController.model.tryOnShopInfo = _loc2_;
            if(!FrameControllerManager.instance.shopController.frame)
            {
               ShopManager.Instance.shopFrameDefaultPanel = "fashion";
               FrameControllerManager.instance.openControllerByInfo("shop");
               return;
            }
            ShopManager.Instance.model.switchToFashionTab();
         }
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:ShopMainBuyFrame = ComponentFactory.Instance.creatComponentByStylename("shop.ShopMainBuyFrame");
         _loc1_["show"]();
         _loc1_["data"](_data);
      }
      
      public function get data() : MainShopInfo
      {
         return _data;
      }
      
      public function set timeText(param1:int) : void
      {
         _timeValue.text = DateFormatter.getStopDateString(param1);
         _promoTimeTxt.visible = true;
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
         if(isFashion && _lookBtn)
         {
            _lookBtn.visible = true;
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
      }
   }
}

