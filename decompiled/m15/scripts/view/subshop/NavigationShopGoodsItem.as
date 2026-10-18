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
   import managers.NavigationManager;
   import mvc.module.mounts.MountShopInfo;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.NavigationShopTempInfo;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class NavigationShopGoodsItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _priceIcon:Image;
      
      private var _goods:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      private var _data:MountShopInfo;
      
      private var _shopTempInfo:NavigationShopTempInfo;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _maxBuyCount:int;
      
      private var _pointTxt:FilterFrameText;
      
      private var _pointIcon:Image;
      
      public function NavigationShopGoodsItem()
      {
         super();
         _maxBuyCount = ConfigInfoManager.instance.getNavigationShopBuyNum();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.shopGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.nameTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.priceTxt");
         _priceIcon = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.priceIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("NavigationShopGoodsItem.ItemBaseItemView");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.BuyBtn");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.pointTxt");
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.pointIcon");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_nameTxt);
         addChild(_priceTxt);
         addChild(_priceIcon);
         addChild(_pointTxt);
         addChild(_pointIcon);
         addChild(_goods);
         addChild(_buyBtn);
         _priceIcon.tipData = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type101");
         _buyBtn.x = 154;
         _buyBtn.y = 61;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOut",__onMouseOut);
         addEventListener("mouseOver",__onMouseOver);
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__onBuyBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOut",__onMouseOut);
         removeEventListener("mouseOver",__onMouseOver);
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__onBuyBtnHandler);
         }
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         if(!_goodsTempInfo || !_shopTempInfo)
         {
            return;
         }
         if(model.hasBuyShopNum >= _maxBuyCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationShopGoodsItem.noBuyCount.Alert"));
            return;
         }
         var _loc2_:String = "NavigationShopGoodsItem.alertText.BuyBtn.content";
         if(_shopTempInfo.Diamond > 0)
         {
            _loc2_ = "NavigationShopGoodsItem.alertText.BuyBtn.content2";
         }
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation(_loc2_,_shopTempInfo.Currency,_shopTempInfo.Count,_goodsTempInfo.TemplateName,_shopTempInfo.Diamond);
         NotAlertManager.ins.needAlert("navigation.NavigationShopGoodsItem.buyAlert",buyResultHandler,_loc3_,_loc4_,false);
      }
      
      private function buyResultHandler() : void
      {
         if(model.currency < _shopTempInfo.Currency)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationShopGoodsItem.noCurrency.Alert"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < _shopTempInfo.Diamond)
         {
            RechargeAlertMannager.show();
            return;
         }
         NavigationManager.instance.sendNavigationOperate(14,"","",_data.index);
      }
      
      public function set data(param1:MountShopInfo) : void
      {
         clean();
         if(param1)
         {
            addEvent();
            _data = param1;
            _shopTempInfo = TempleteManager.instance.nagivationShopTemplateCate.getTemplateByShopId(_data.tempId);
            _goodsInfo = new GoodsInfo();
            _goodsInfo.templateId = _shopTempInfo.ItemId;
            _goodsInfo.count = _shopTempInfo.Count;
            if(!_shopTempInfo)
            {
               data = null;
               return;
            }
            _goods.data = _goodsInfo;
            _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_shopTempInfo.ItemId);
            if(_goodsTempInfo)
            {
               _nameTxt.text = _goodsTempInfo.TemplateName;
            }
            _priceTxt.text = _shopTempInfo.Currency.toString();
            _priceIcon.visible = true;
            if(_shopTempInfo.Diamond > 0)
            {
               _pointTxt.text = _shopTempInfo.Diamond.toString();
               _pointIcon.visible = true;
            }
            _buyBtn.visible = true;
            _buyBtn.enable = !_data.isCanBuy;
            _nameTxt.y = _nameTxt.numLines < 2 ? 10 : 0;
         }
         else
         {
            removeEvent();
         }
      }
      
      private function clean() : void
      {
         _goods.data = null;
         _bg.setFrame(1);
         _nameTxt.text = "";
         _priceTxt.text = "";
         _pointTxt.text = "";
         _priceIcon.visible = false;
         _pointIcon.visible = false;
         _buyBtn.enable = false;
         _buyBtn.visible = false;
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_priceTxt)
         {
            ObjectUtils.disposeObject(_priceTxt);
         }
         _priceTxt = null;
         if(_pointTxt)
         {
            ObjectUtils.disposeObject(_pointTxt);
         }
         _pointTxt = null;
         if(_priceIcon)
         {
            ObjectUtils.disposeObject(_priceIcon);
         }
         _priceIcon = null;
         if(_pointIcon)
         {
            ObjectUtils.disposeObject(_pointIcon);
         }
         _pointIcon = null;
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
         super.dispose();
      }
   }
}

