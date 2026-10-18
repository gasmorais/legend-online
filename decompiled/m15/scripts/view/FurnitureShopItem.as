package view
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import yishi.datas.templates.FurnitureShopTemplateInfo;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.frame.FurnitureShopBuyFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class FurnitureShopItem extends Component
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _goodItem:*;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _valueTxt:FilterFrameText;
      
      protected var _buyBtn:IconButton;
      
      protected var _tips:FilterFrameText;
      
      protected var _payImg:ScaleFrameImage;
      
      protected var _hasCountText:FilterFrameText;
      
      protected var furnitureTempInfo:FurnitureTempInfo;
      
      protected var _data:FurnitureShopTemplateInfo;
      
      private var hasCount:int;
      
      private var maxCount:int;
      
      public function FurnitureShopItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _payImg = ComponentFactory.Instance.creatComponentByStylename("FurnitureShopItem.payImg");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _hasCountText = ComponentFactory.Instance.creatComponentByStylename("FurnitureShopItem.hasCountText");
         if(DisplayLoader.Context.applicationDomain.getDefinition("map.campaign.view.house.FurnitureBagCell") as Class)
         {
            _goodItem = ComponentFactory.Instance.creatCustomObject("FurnitureShopItem.FurnitureBagCell");
            _goodItem.isCanClickItem = false;
         }
         addChild(_bg);
         addChild(_goodItem);
         addChild(_payImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_hasCountText);
         addChild(_buyBtn);
         _bg.setFrame(1);
      }
      
      protected function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         _buyBtn.addEventListener("click",__clickHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         _buyBtn.removeEventListener("click",__clickHandler);
      }
      
      public function get data() : FurnitureShopTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:FurnitureShopTemplateInfo) : void
      {
         _data = param1;
         if(_data)
         {
            furnitureTempInfo = TempleteManager.instance.furnitureTemplateCate.getTempById(_data.SellFurnitureId);
         }
         if(!_data || !furnitureTempInfo)
         {
            clean();
            return;
         }
         addEvent();
         _buyBtn.visible = _payImg.visible = _goodItem.visible = true;
         maxCount = HomeManager.instance.model.getCanSetMaxCountByFurnitureType(furnitureTempInfo.FurnitureType);
         hasCount = HomeManager.instance.model.getCurHasCountByTempId(furnitureTempInfo.TemplateId);
         _nameTxt.text = furnitureTempInfo.TemplateName;
         _valueTxt.text = _data.CostItemCount + "";
         _goodItem.furniture = furnitureTempInfo;
         _goodItem.refreshTxt(_data.SellFurnitureCount);
         _goodItem.isCanClickItem = false;
         _hasCountText.text = LanguageMgr.GetTranslation("FurnitureShopItem.FurnitureBagCell.tipData",hasCount,maxCount);
         hasCount >= maxCount ? _hasCountText.setFrame(2) : _hasCountText.setFrame(1);
      }
      
      protected function clean() : void
      {
         removeEvent();
         _buyBtn.visible = false;
         _payImg.visible = false;
         _goodItem.visible = false;
         _valueTxt.text = "";
         _nameTxt.text = "";
         _tips.text = "";
         _hasCountText.text = "";
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(hasCount >= maxCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("FurnitureShopItem.FurnitureBagCell.buyFullAlert"));
            return;
         }
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:FurnitureShopBuyFrame = ComponentFactory.Instance.creatComponentByStylename("quickbuy.FurnitureShopBuyFrame");
         _loc1_.data = _data;
         _loc1_.show();
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
      
      override public function get width() : Number
      {
         return 238;
      }
      
      override public function get height() : Number
      {
         return 126;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_tips);
         _tips = null;
         ObjectUtils.disposeObject(_payImg);
         _payImg = null;
         ObjectUtils.disposeObject(_goodItem);
         _goodItem = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

