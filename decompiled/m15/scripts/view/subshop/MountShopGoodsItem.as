package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.mounts.MountShopInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class MountShopGoodsItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _activeTxt:FilterFrameText;
      
      private var _priceIcon:Image;
      
      private var _goods:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      private var _data:MountShopInfo;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      public function MountShopGoodsItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MountShopGoodsItem.shopGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("MountShopGoodsItem.nameTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("MountShopGoodsItem.priceTxt");
         _activeTxt = ComponentFactory.Instance.creatComponentByStylename("MountShopGoodsItem.activeTxt");
         _priceIcon = ComponentFactory.Instance.creatComponentByStylename("MountShopGoodsItem.priceIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("MountShopGoodsItem.buyBtn");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_nameTxt);
         addChild(_priceTxt);
         addChild(_activeTxt);
         _activeTxt.visible = false;
         addChild(_priceIcon);
         addChild(_goods);
         addChild(_buyBtn);
         _activeTxt.text = LanguageMgr.GetTranslation("view.GoodsItem3.ActiveState.text2");
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
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(MountsManager.instance.avatarList.isLightTemplate(_goodsTempInfo.Property1) || Boolean(GoodsManager.instance.checkExistGoodsByTempIdInAllBag(_goodsTempInfo.TemplateId)))
         {
            _loc4_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         if(PlayerCurrencyManager.instance.currencyInfo.mountCoin.amount < _data.price)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.subshop.MountShopGoodsItem.MountCoin.isNotEnough"));
            return;
         }
         SimpleAlertHelper.instance.data = [buyResultHandler];
         _loc2_ = LanguageMgr.GetTranslation("public.confirm");
         _loc3_ = LanguageMgr.GetTranslation("public.cancel");
         _loc5_ = LanguageMgr.GetTranslation("public.prompt");
         _loc6_ = LanguageMgr.GetTranslation("view.subshop.MountShopGoodsItem.content",_data.price,_goodsTempInfo.TemplateName);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true);
      }
      
      private function buyResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MountsManager.instance.mountOperateSend(9,0,0,_data.tempId,_data.index);
         }
      }
      
      public function set data(param1:MountShopInfo) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         clean();
         if(param1)
         {
            addEvent();
            _data = param1;
            _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.tempId);
            _goodsInfo = new GoodsInfo();
            _goodsInfo.templateId = _data.tempId;
            _goodsInfo.count = _data.count;
            if(!_goodsTempInfo)
            {
               data = null;
               return;
            }
            _goods.data = _goodsInfo;
            _nameTxt.text = _goodsTempInfo.TemplateName;
            _nameTxt.y = _nameTxt.numLines >= 2 ? 14 : 22;
            _priceTxt.text = _data.price.toString();
            _priceIcon.visible = true;
            _loc3_ = Boolean(MountsManager.instance.avatarList.isLightTemplate(_goodsTempInfo.Property1));
            _loc2_ = Boolean(GoodsManager.instance.checkExistGoodsByTempIdInAllBag(_goodsTempInfo.TemplateId));
            _activeTxt.visible = _loc3_ || _loc2_;
            _buyBtn.visible = true;
            if(_loc3_ || _loc2_ || !_data.isCanBuy)
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
            removeEvent();
         }
      }
      
      private function clean() : void
      {
         _goods.data = null;
         _bg.setFrame(1);
         _nameTxt.text = "";
         _priceTxt.text = "";
         _activeTxt.visible = false;
         _priceIcon.visible = false;
         _buyBtn.enable = false;
         _buyBtn.visible = false;
      }
      
      public function dispose() : void
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
         if(_activeTxt)
         {
            ObjectUtils.disposeObject(_activeTxt);
         }
         _activeTxt = null;
         if(_priceIcon)
         {
            ObjectUtils.disposeObject(_priceIcon);
         }
         _priceIcon = null;
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
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

