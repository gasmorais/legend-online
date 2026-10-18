package mvpshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MvpShopManager;
   import mvc.module.mvpshop.MvpShopItemInfo;
   import mvc.module.mvpshop.MvpShopModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class MvpShopGoodsItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _priceIcon:Image;
      
      private var _goods:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      private var _data:MvpShopItemInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _rareImg:Bitmap;
      
      public function MvpShopGoodsItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("mvpShop.MvpShopGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("MvpShopGoodsItem.nameTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("MvpShopGoodsItem.priceTxt");
         _priceIcon = ComponentFactory.Instance.creatComponentByStylename("MvpShopGoodsItem.priceIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("MvpShopGoodsItem.ItemBaseItemView");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("MvpShopGoodsItem.BuyBtn");
         _rareImg = ComponentFactory.Instance.creatBitmap("asset.MvpShopFrame.rareImg");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_nameTxt);
         addChild(_priceTxt);
         addChild(_priceIcon);
         addChild(_goods);
         addChild(_buyBtn);
         addChild(_rareImg);
         _rareImg.visible = false;
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
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(!_goodsInfo)
         {
            return;
         }
         if(model.score >= _data.price)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("MvpShopGoodsItem.buyGoods.txt",_data.price,_goodsInfo.templateInfo.TemplateName,_data.itemCount);
            SimpleAlertHelper.instance.data = [isBuyHandler];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MvpShopGoodsItem.score.notEnough.txt"));
         }
      }
      
      private function isBuyHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MvpShopManager.instance.sendRequest(1,_data.id);
         }
      }
      
      public function set data(param1:MvpShopItemInfo) : void
      {
         clean();
         if(param1)
         {
            addEvent();
            _data = param1;
            _goodsInfo = new GoodsInfo();
            _goodsInfo.templateId = _data.itemId;
            _goodsInfo.count = _data.itemCount;
            _goods.data = _goodsInfo;
            if(_goodsInfo.templateInfo)
            {
               _nameTxt.text = _goodsInfo.templateInfo.TemplateName;
               if(_nameTxt.numLines == 1)
               {
                  _nameTxt.y = 10;
               }
               else
               {
                  _nameTxt.y = 0;
               }
            }
            _priceTxt.text = _data.price.toString();
            _priceIcon.visible = true;
            _buyBtn.visible = true;
            _buyBtn.enable = !_data.isBuy;
            _rareImg.visible = _data.isRare;
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
         _priceIcon.visible = false;
         _buyBtn.enable = false;
         _buyBtn.visible = false;
      }
      
      private function get model() : MvpShopModel
      {
         return MvpShopManager.instance.model;
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
         if(_rareImg)
         {
            ObjectUtils.disposeObject(_rareImg);
         }
         _rareImg = null;
         _data = null;
         _goodsInfo = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

