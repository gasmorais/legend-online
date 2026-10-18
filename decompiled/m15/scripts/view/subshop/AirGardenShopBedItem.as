package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.airgarden.AirGardenCampaignBedInfo;
   import mvc.module.airgarden.AirGardenModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AirGardenBedTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class AirGardenShopBedItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _goods:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      private var _tips:FilterFrameText;
      
      private var _lineImg:Image;
      
      private var _data:AirGardenBedTempInfo;
      
      private var cost:int;
      
      public function AirGardenShopBedItem()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("AirGardenShopBedItem.coinImage");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_goods);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-5100);
         _lineImg.tipData = _loc1_.Description;
      }
      
      protected function addEvent() : void
      {
         _buyBtn.addEventListener("click",__clickHandler);
      }
      
      protected function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         __onBuyBtnHandler(param1);
      }
      
      protected function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(hasBuyCount >= data.limitCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.campaign.noBedAlert"));
            return;
         }
         if(PlayerCurrencyManager.instance.currencyInfo.airGardenBedCoin.amount < cost)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.airgardenBed.buyAlertTip"));
            return;
         }
         AirGardenManager.instance.sendBedShopBuy(data.TemplateId);
      }
      
      public function get data() : AirGardenBedTempInfo
      {
         return _data;
      }
      
      public function set data(param1:AirGardenBedTempInfo) : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:Array = null;
         _data = param1;
         if(data)
         {
            _buyBtn.visible = true;
            _lineImg.visible = true;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = data.ItemTempId;
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(data.ItemTempId);
            if(_loc2_)
            {
               _goods.data = _loc4_;
               _nameTxt.text = _loc2_.TemplateName;
            }
            _loc3_ = data.Cost.split(",");
            cost = _loc3_.length > hasBuyCount ? _loc3_[hasBuyCount] : _loc3_[hasBuyCount - 1];
            _valueTxt.text = cost + "";
         }
         else
         {
            clean();
         }
      }
      
      protected function clean() : void
      {
         _nameTxt.text = "";
         _valueTxt.text = "";
         _tips.text = "";
         _buyBtn.visible = false;
         _lineImg.visible = false;
         _goods.data = null;
      }
      
      private function get hasBuyCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:AirGardenCampaignBedInfo in model.bedNodeList)
         {
            if(_loc2_.nodeTempId == data.TemplateId)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function get model() : AirGardenModel
      {
         return AirGardenManager.instance.model;
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

