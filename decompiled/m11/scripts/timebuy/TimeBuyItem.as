package timebuy
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
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.ShopMainBuyFrame;
   
   public class TimeBuyItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _lookBtn:TextButton;
      
      private var _buyBt:BaseButton;
      
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
      
      private var _purchaseTxt:FilterFrameText;
      
      private var _purchaseValue:FilterFrameText;
      
      private var _listPriceImg:ScaleFrameImage;
      
      private var _lineShape:Sprite;
      
      private var _worthImg:Bitmap;
      
      private var _discountBg:MovieImage;
      
      private var _discountNum:BitmapData;
      
      private var _dazheC:Sprite;
      
      public function TimeBuyItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("timebuy.timeBuyGoodsItemBg");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _buyBt = ComponentFactory.Instance.creatComponentByStylename("timebuy.BuyBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("timebuy.GoodsNameTextStyle");
         _value = ComponentFactory.Instance.creatComponentByStylename("timebuy.goodsItem4ValueTextStyle");
         _valueIcon = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("timebuy.BaseItemView2");
         _purchaseTxt = ComponentFactory.Instance.creatComponentByStylename("timebuy.PurchaseTextStyle");
         _purchaseValue = ComponentFactory.Instance.creatComponentByStylename("timebuy.PurchaseNumTextStyle");
         _timeValue = ComponentFactory.Instance.creatComponentByStylename("timebuy.timeRemaining");
         _timeLable = ComponentFactory.Instance.creatComponentByStylename("timebuy.remainingTimeTxt");
         _promoTimeTxt = ComponentFactory.Instance.creatBitmap("asset.core.PromoTimeImgTxt");
         _promoPromptTxt = ComponentFactory.Instance.creatBitmap("asset.core.PromoPromptImgTxt");
         _listPriceImg = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _worthImg = ComponentFactory.Instance.creatBitmap("asset.timebuy.worthImg");
         _discountNum = ComponentFactory.Instance.creatBitmapData("asset.timebuy.discountNum");
         _discountBg = ComponentFactory.Instance.creatComponentByStylename("timebuy.discountBg");
         _listPriceImg.x = 0;
         _listPriceImg.y = 0;
         _bg.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         addChild(_bg);
         addChild(_buyBt);
         addChild(_name);
         addChild(_value);
         addChild(_valueIcon);
         _valueIcon.y = 72;
         addChild(_goods);
         addChild(_timeLable);
         addChild(_timeValue);
         addChild(_promoPromptTxt);
         _promoPromptTxt.y = 41;
         _promoPromptTxt.visible = false;
         addChild(_purchaseTxt);
         _purchaseTxt.text = LanguageMgr.GetTranslation("task.view.shopFrame.Purchase");
         _purchaseTxt.visible = false;
         addChild(_purchaseValue);
         _purchaseValue.text = "33";
         _purchaseValue.visible = false;
         addChild(_worthImg);
         _worthImg.visible = false;
         addChild(_discountBg);
         _dazheC = new Sprite();
         addChild(_dazheC);
         dazheSet(100);
      }
      
      private function creatShape() : void
      {
         _lineShape = new Sprite();
         _lineShape.graphics.lineStyle(1,10066329,1);
         _lineShape.graphics.lineTo(138,77);
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
         if(param1.target == _buyBt)
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
               ShopManager.Instance.currBuyGoods = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.id,2);
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
         if(_lineShape)
         {
            _lineShape.graphics.clear();
            ObjectUtils.disposeObject(_lineShape);
         }
         if(param1)
         {
            _worthImg.visible = true;
            initEvent();
            _listPriceImg.visible = true;
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
                     if(_loc6_ != 4)
                     {
                        if(data["shopId" + _loc6_] <= 0)
                        {
                           break;
                        }
                        _loc8_ += data.price * data["count" + _loc6_];
                     }
                  }
                  else
                  {
                     _loc8_ += data.price * data["counts"];
                  }
                  _loc6_++;
               }
               _listPriceImg.setFrame(1);
            }
            else
            {
               _loc9_ = new GoodsInfo();
               _loc9_.templateId = _data.templateId;
               if(!_loc4_)
               {
                  data = null;
                  return;
               }
               _listPriceImg.setFrame(1);
               _goods.data = _loc9_;
               _name.text = _loc4_.TemplateName;
            }
            _value.text = _data.price + "";
            _valueIcon.visible = true;
            _buyBt.visible = true;
            _promoPromptTxt.visible = false;
            _timeLable.filters = null;
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
            _buyBt.enable = true;
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
                  _buyBt.enable = false;
               }
               else
               {
                  _buyBt.enable = true;
               }
            }
            else
            {
               _purchaseTxt.visible = false;
               _purchaseValue.visible = false;
            }
            creatShape();
            _timeLable.text = LanguageMgr.GetTranslation("Task.view.GoodsItem5.timeLable.text");
            showDiscount();
            showWorthImg();
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
            _listPriceImg.visible = false;
            _lookBtn.visible = false;
            _buyBt.visible = false;
            _promoTimeTxt.visible = false;
            _valueIcon.visible = false;
            _promoPromptTxt.visible = true;
            _name.text = "";
            _value.text = "";
            _timeValue.text = "";
            _timeLable.text = "";
            removeEvent();
            _timeLable.filters = ComponentFactory.Instance.creatFilters("core.GrayFilter");
            _discountBg.visible = false;
            _dazheC.visible = false;
         }
         if(_name.text.length > 30)
         {
            _name.text = _name.text.substr(0,29) + "...";
         }
      }
      
      private function showDiscount() : void
      {
         var _loc1_:Number = 100 - _data.discount * 100;
         _loc1_ = Number(_loc1_.toFixed(1));
         if(!_discountBg || !_dazheC)
         {
            return;
         }
         if(_loc1_ > 0 && _loc1_ < 100)
         {
            if(_dazheC && _discountBg)
            {
               dazheSet(_loc1_);
               _discountBg.visible = true;
               _dazheC.visible = true;
            }
         }
         else if(_discountMc && _dazheC)
         {
            _discountMc.visible = false;
            _dazheC.visible = false;
         }
      }
      
      private function showWorthImg() : void
      {
         if(_data.discount >= 0.3)
         {
            _worthImg.visible = true;
         }
         else
         {
            _worthImg.visible = false;
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
         }
      }
      
      public function buyWingFunction() : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
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
            if(param1 > 2592000)
            {
               _timeLable.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               _timeValue.text = "";
            }
            else
            {
               _timeLable.text = LanguageMgr.GetTranslation("Task.view.GoodsItem5.timeLable.text");
               _timeValue.text = DateFormatter.getStopDateString(param1);
            }
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
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
         if(_lookBtn)
         {
            _lookBtn.visible = false;
         }
      }
      
      private function dazheSet(param1:Number) : void
      {
         ObjectUtils.removeChildAllChildren(_dazheC);
         NumberViewUtils.getNumberView(param1,_dazheC,_discountNum,14,18,10,14,".0123456789",1);
         _dazheC.rotation = 15;
         var _loc2_:String = param1 + "";
         if(_loc2_.indexOf(".") == -1)
         {
            if(param1 == 10)
            {
               _dazheC.x = _discountBg.x + 15;
               _dazheC.y = _discountBg.y + 13;
            }
            else
            {
               _dazheC.x = _discountBg.x + 15;
               _dazheC.y = _discountBg.y + 15;
            }
         }
         else
         {
            _dazheC.y = _discountBg.y + 12;
            _dazheC.x = _discountBg.x + 20;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _lookBtn = null;
         _buyBt = null;
         _name = null;
         _value = null;
         _valueIcon = null;
         _goods = null;
         _timeLable = null;
         _discountMc = null;
         _timeValue = null;
         _promoTimeTxt = null;
         _promoPromptTxt = null;
         _worthImg = null;
         _data = null;
      }
   }
}

