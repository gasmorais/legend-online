package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
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
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.LookFrame;
   import yishi.view.frame.ShopMainBuyFrame;
   
   public class FunnyHotBuyItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _buyBtn:BaseButton;
      
      private var _name:FilterFrameText;
      
      private var _value:FilterFrameText;
      
      private var _valueIcon:ScaleFrameImage;
      
      private var _goods:BaseItemView;
      
      private var _timeLable:FilterFrameText;
      
      private var _discountMc:MovieImage;
      
      private var _timeValue:FilterFrameText;
      
      private var _promoTimeTxt:Bitmap;
      
      private var _promoPromptTxt:Bitmap;
      
      private var _data:MainShopInfo;
      
      private var _lookFrame:LookFrame;
      
      private var _purchaseTxt:FilterFrameText;
      
      private var _purchaseValue:FilterFrameText;
      
      private var _listPriceTxt:FilterFrameText;
      
      private var _listPriceImg:ScaleFrameImage;
      
      private var _lineShape:Shape;
      
      private var _lookBtn:TextButton;
      
      public function FunnyHotBuyItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("funny.FunnyHotBuyItemBg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("funny.FunnyHotBuyBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("funny.FunnyHotBuyNameText");
         _value = ComponentFactory.Instance.creatComponentByStylename("funny.FunnyHotBuyValueText");
         _valueIcon = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.BaseItemView2");
         _purchaseTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PurchaseTextStyle");
         _purchaseValue = ComponentFactory.Instance.creatComponentByStylename("shop.PurchaseNumTextStyle");
         _timeValue = ComponentFactory.Instance.creatComponentByStylename("shop.timeRemaining");
         _timeLable = ComponentFactory.Instance.creatComponentByStylename("shop.remainingTimeTxt");
         _promoTimeTxt = ComponentFactory.Instance.creatBitmap("asset.core.PromoTimeImgTxt");
         _promoPromptTxt = ComponentFactory.Instance.creatBitmap("asset.core.PromoPromptImgTxt");
         _listPriceTxt = ComponentFactory.Instance.creatComponentByStylename("funny.FunnyHotBuyListPromptTxt");
         _listPriceImg = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _listPriceImg.x = 0;
         _listPriceImg.y = 0;
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_buyBtn);
         addChild(_name);
         addChild(_value);
         addChild(_valueIcon);
         _valueIcon.x = 205;
         _valueIcon.y = 78;
         addChild(_goods);
         addChild(_timeLable);
         addChild(_timeValue);
         addChild(_promoPromptTxt);
         _promoPromptTxt.y = 41;
         _promoPromptTxt.visible = false;
         addChild(_purchaseTxt);
         _purchaseTxt.text = LanguageMgr.GetTranslation("task.view.shopFrame.Purchase");
         _purchaseTxt.y = 105;
         addChild(_purchaseValue);
         _purchaseValue.y = 105;
         _lookBtn.x = 10;
         _lookBtn.y = 94;
      }
      
      private function creatShape() : void
      {
         _lineShape = new Shape();
         _lineShape.graphics.lineStyle(1,10066329,1);
         _lineShape.graphics.moveTo(200 - _listPriceTxt.textWidth,68);
         _lineShape.graphics.lineTo(227,68);
         _lineShape.graphics.endFill();
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
            if(_data.type == 1)
            {
               ShopManager.Instance.type = 1;
               ShopManager.Instance.currBuyGoods = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.id,0);
            }
            else if(_data.type == 2)
            {
               ShopManager.Instance.type = 2;
               __buyHandler(param1);
            }
         }
         else if(isFashion)
         {
            __onLookBtnHandler(param1);
         }
      }
      
      public function set data(param1:MainShopInfo) : void
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:String = null;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc10_:Object = null;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc9_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         _goods.data = null;
         _data = param1;
         buttonMode = isFashion;
         if(param1)
         {
            initEvent();
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
            if(_data.isGift)
            {
               _goods.icon.icon = PathManager.info.REQUEST_PATH + _data.url;
               _loc2_ = _data.content;
               _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
               if(_loc7_ && _loc7_.SonType == 206)
               {
                  _loc2_ += "<br/><font color=\'#00ff00\'>" + _loc7_.Description + "</font>";
               }
               _loc10_ = {
                  "name":_data.names,
                  "content":_loc2_
               };
               _goods.icon.tipData = _loc10_;
               _goods.icon.tipStyle = "yishi.view.tips.ShopMainTips";
               _name.text = _data.names;
               _valueIcon.setFrame(1);
               _loc8_ = 0;
               _loc6_ = 0;
               while(_loc6_ < 9)
               {
                  if(_loc6_ > 0)
                  {
                     if(data["shopId" + _loc6_] <= 0)
                     {
                        break;
                     }
                     _loc8_ += data.price * data["count" + _loc6_];
                  }
                  else
                  {
                     _loc8_ += data.price * data["counts"];
                  }
                  _loc6_++;
               }
               _listPriceTxt.text = LanguageMgr.GetTranslation("funny.view.FunnyHotBuyItem.price1",_loc8_);
               _listPriceImg.setFrame(1);
            }
            else
            {
               _loc9_ = new GoodsInfo();
               _loc9_.templateId = _data.templateId;
               _loc9_.count = _data.counts;
               if(!_loc4_)
               {
                  data = null;
                  return;
               }
               _listPriceTxt.text = LanguageMgr.GetTranslation("funny.view.FunnyHotBuyItem.price1",data.price);
               _listPriceImg.setFrame(1);
               _goods.data = _loc9_;
               _name.text = _loc4_.TemplateName;
            }
            _value.text = LanguageMgr.GetTranslation("funny.view.FunnyHotBuyItem.price2",_data.price);
            _valueIcon.visible = true;
            _buyBtn.visible = true;
            _promoPromptTxt.visible = false;
            _timeLable.filters = null;
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
            if(param1.type == 2)
            {
               if(param1.limitCount > 0)
               {
                  _purchaseTxt.visible = true;
                  _purchaseValue.visible = true;
                  _purchaseValue.text = param1.limitCount + "";
               }
               if(param1.limitCount <= param1.count)
               {
                  _buyBtn.enable = false;
               }
               else
               {
                  _buyBtn.enable = true;
               }
            }
            else
            {
               _purchaseTxt.visible = false;
               _purchaseValue.visible = false;
            }
            creatShape();
            _timeLable.text = LanguageMgr.GetTranslation("Task.view.GoodsItem5.timeLable.text");
         }
         else
         {
            _data = null;
            _goods.data = null;
            _buyBtn.visible = false;
            _promoTimeTxt.visible = false;
            _valueIcon.visible = false;
            _promoPromptTxt.visible = true;
            _lookBtn.visible = false;
            _name.text = "";
            _value.text = "";
            _timeValue.text = "";
            removeEvent();
            _timeLable.filters = ComponentFactory.Instance.creatFilters("core.GrayFilter");
         }
      }
      
      protected function get isFashion() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         if(_data.isGift)
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
            case 1:
            case 2:
            case 3:
               return true;
            default:
               return false;
         }
      }
      
      private function __onLookBtnHandler(param1:MouseEvent) : void
      {
         var _loc4_:ShopGoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:* = undefined;
         if(isFashion)
         {
            _loc4_ = ShopManager.Instance.model.getShopTempInfoById(_data.shopId);
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
         if(_data.type == 1)
         {
            _timeValue.text = DateFormatter.getStopDateString(param1);
         }
         else if(_data.type == 2)
         {
            _timeValue.text = DateFormatter.getConsortiaCountDate(param1);
         }
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
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_value);
         _value = null;
         ObjectUtils.disposeObject(_valueIcon);
         _valueIcon = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_timeLable);
         _timeLable = null;
         ObjectUtils.disposeObject(_discountMc);
         _discountMc = null;
         ObjectUtils.disposeObject(_timeValue);
         _timeValue = null;
         ObjectUtils.disposeObject(_promoTimeTxt);
         _promoTimeTxt = null;
         ObjectUtils.disposeObject(_promoPromptTxt);
         _promoPromptTxt = null;
         ObjectUtils.disposeObject(_lookFrame);
         _lookFrame = null;
         ObjectUtils.disposeObject(_purchaseTxt);
         _purchaseTxt = null;
         ObjectUtils.disposeObject(_purchaseValue);
         _purchaseValue = null;
         ObjectUtils.disposeObject(_listPriceTxt);
         _listPriceTxt = null;
         ObjectUtils.disposeObject(_listPriceImg);
         _listPriceImg = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

