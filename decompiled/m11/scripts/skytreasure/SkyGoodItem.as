package skytreasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureExchangeData;
   import mvc.module.skytreasure.SkyTreasureExchangeItemInfo;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   
   public class SkyGoodItem extends Sprite implements Disposeable
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _valueTxt:FilterFrameText;
      
      protected var _goods:BaseItemView;
      
      protected var _buyBtn:IconButton;
      
      protected var _tips:FilterFrameText;
      
      protected var _lineImg:Bitmap;
      
      protected var _data:SkyTreasureExchangeItemInfo;
      
      protected var _filter:IFilterFormat;
      
      public function SkyGoodItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _lineImg = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.DiamondIcon");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _bg.setFrame(1);
         _lineImg.x = 195;
         _lineImg.y = 50;
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         _tips.x = 22;
         _tips.y = 85;
         _tips.width = 110;
         _tips.height = 38;
         addChild(_buyBtn);
         addChild(_goods);
      }
      
      protected function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         this.addEventListener("click",__clickHandler);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",__onLotteryResult);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         this.removeEventListener("click",__clickHandler);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",__onLotteryResult);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _buyBtn)
         {
            __onBuyBtnHandler(param1);
         }
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function buyWingFunction(param1:Vector.<ShopGoodsInfo>) : void
      {
         __onBuyBtnHandler(null);
      }
      
      protected function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         var _loc2_:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:SkyShopBuyFrame = ComponentFactory.Instance.creatComponentByStylename("skytreasure.SkyShopBuyFrame");
         _loc1_.data(_data);
         _loc1_.show();
      }
      
      private function conformBuy(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:SkyTreasureActTemplateInfo = pumpModel.findSkyTreasureActTempInfoByActId(pumpModel.currShowActId);
         var _loc3_:SkyTreasureExchangeData = pumpModel.findSkyTreasureExchangeDataInfo(pumpModel.currShowActId);
         if(_data.limitNum - _loc3_.findTempExchangeNum(_data.templateId) <= 0)
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      public function get data() : SkyTreasureExchangeItemInfo
      {
         return _data;
      }
      
      private function __onLotteryResult(param1:SkyTreasureEvent = null) : void
      {
         var _loc2_:SkyTreasureExchangeData = pumpModel.findSkyTreasureExchangeDataInfo(pumpModel.currShowActId);
         if(_data.limitType != 0)
         {
            _tips.text = _data.LimitDesc + (_data.limitNum - _loc2_.findTempExchangeNum(_data.templateId)) + "/" + _data.limitNum;
            _buyBtn.enable = _data.limitNum - _loc2_.findTempExchangeNum(_data.templateId) > 0;
         }
      }
      
      public function set data(param1:SkyTreasureExchangeItemInfo) : void
      {
         var _loc2_:String = null;
         var _loc4_:SkyTreasureActTemplateInfo = null;
         var _loc3_:SkyTreasureExchangeData = null;
         _data = param1;
         if(param1)
         {
            _buyBtn.visible = true;
            _buyBtn.enable = true;
            _lineImg.visible = true;
            _loc2_ = "shop.ItemGoodsNameTextStyle2_t";
            _loc4_ = pumpModel.findSkyTreasureActTempInfoByActId(pumpModel.currShowActId);
            _loc3_ = pumpModel.findSkyTreasureExchangeDataInfo(pumpModel.currShowActId);
            addEvent();
            if(param1.limitType == 0)
            {
               _tips.text = param1.LimitDesc;
            }
            else
            {
               _tips.text = param1.LimitDesc + (param1.limitNum - _loc3_.findTempExchangeNum(param1.templateId)) + "/" + param1.limitNum;
               _buyBtn.enable = param1.limitNum - _loc3_.findTempExchangeNum(_data.templateId) > 0;
            }
            _nameTxt.text = getName();
            setPosition();
            _nameTxt.visible = true;
            _valueTxt.text = param1.exchangeCostNum + "";
         }
         else
         {
            clean();
            removeEvent();
         }
      }
      
      private function setPosition() : void
      {
         if(_nameTxt.numLines > 1)
         {
            _nameTxt.y = 9;
         }
         else
         {
            _nameTxt.y = 19;
         }
      }
      
      private function get pumpModel() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      private function getName() : String
      {
         var _loc1_:* = null;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _data.templateId;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
         if(!_loc2_)
         {
            _data = null;
            return LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaShopGoodsItem.noFindGoods");
         }
         _goods.data = _loc3_;
         return _loc2_.TemplateName;
      }
      
      protected function clean() : void
      {
         _nameTxt.text = "";
         _valueTxt.text = "";
         _buyBtn.visible = false;
         _lineImg.visible = false;
         _goods.data = null;
         _tips.text = "";
      }
      
      public function dispose() : void
      {
         removeEvent();
         _filter = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_tips);
         _tips = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

