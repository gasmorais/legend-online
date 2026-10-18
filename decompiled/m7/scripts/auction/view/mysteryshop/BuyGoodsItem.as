package auction.view.mysteryshop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MysteryShopEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MysteryShopManager;
   import mvc.controler.MysteryShopControler;
   import mvc.module.auction.BuyGoodsInfo;
   import mvc.module.auction.MysteryShopModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class BuyGoodsItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _buyBtn:IconButton;
      
      private var _boughtBtn:IconButton;
      
      private var _name:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _priceIcon:ScaleFrameImage;
      
      private var _goods:BaseItemView;
      
      private var _shopGoodsInfo:ShopGoodsInfo;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _buyGoodsInfo:BuyGoodsInfo;
      
      private var _buyTipData:String;
      
      public function BuyGoodsItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopGoodsItemBg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopBuyBtn");
         _boughtBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopBoughtBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsNameTextStyle");
         _price = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsValueTextStyle");
         _priceIcon = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsValueIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("auction.MysteryBaseItemView");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_name);
         addChild(_price);
         addChild(_priceIcon);
         addChild(_goods);
         _boughtBtn.enable = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOut",__onMouseOut);
         addEventListener("mouseOver",__onMouseOver);
         _buyBtn.addEventListener("click",__onBuyBtnHandler);
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
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         if(mysteryShopModel.buyCount >= mysteryShopModel.maxBuyCount)
         {
            _buyTipData = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData");
            MessageTipManager.instance().show(_buyTipData);
            return;
         }
         SimpleAlertHelper.instance.data = [buyGoodsHandlerBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:int = 0;
         if(_shopGoodsInfo.Point > 0)
         {
            _loc4_ = int(_shopGoodsInfo.Point);
            _loc6_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.tipContent",_goodsTempInfo.TemplateName,_loc4_);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
         }
         if(_shopGoodsInfo.GiftToken > 0)
         {
            _loc4_ = int(_shopGoodsInfo.GiftToken);
            _loc6_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.tipContent",_goodsTempInfo.TemplateName,_loc4_);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc4_);
         }
      }
      
      private function buyGoodsHandlerBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SoundManager.instance.play("022");
            mysteryShopManager.sendBuyGoodsItem(_buyGoodsInfo.itemId,_buyGoodsInfo.index,param2);
            useBoughtBtn();
            mysteryShopModel.addEventListener("MYSTERY_GOODS_BUY_RETURN",__buyReturnHandler);
         }
         if(mysteryShopControler.frame)
         {
            StageReferance.stage.focus = mysteryShopControler.frame;
         }
      }
      
      private function __buyReturnHandler(param1:MysteryShopEvent) : void
      {
         mysteryShopModel.removeEventListener("MYSTERY_GOODS_BUY_RETURN",__buyReturnHandler);
         if(mysteryShopModel.buyResult == 1 || mysteryShopModel.buyResult == 12)
         {
            useBoughtBtn();
            _buyGoodsInfo.isCanBuy = 1;
         }
         else
         {
            useBuyBtn();
            _buyGoodsInfo.isCanBuy = 0;
         }
         shopingResult(mysteryShopModel.buyResult);
      }
      
      private function shopingResult(param1:int) : void
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 1:
               return;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command02");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command03");
               break;
            case 5:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command05");
               break;
            case 6:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command06");
               break;
            case 7:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command07");
               break;
            case 8:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command08");
               break;
            case 9:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command09");
               break;
            case 10:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command10");
               break;
            case 11:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command11");
               break;
            case 12:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command12");
               break;
            case 15:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command15");
               break;
            case 19:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command19");
               break;
            case 20:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command20");
               break;
            case 21:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command21");
               break;
            case 22:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command22");
               break;
            case 23:
               _loc2_ = LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command23");
               break;
            case 4:
               return;
         }
         MessageTipManager.instance().show(_loc2_);
      }
      
      public function set data(param1:BuyGoodsInfo) : void
      {
         clean();
         if(param1)
         {
            addEvent();
            _buyGoodsInfo = param1;
            _shopGoodsInfo = TempleteManager.instance.getMysteryInfoByItemId(_buyGoodsInfo.itemId);
            _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_shopGoodsInfo.ItemId);
            _goodsInfo = new GoodsInfo();
            _goodsInfo.templateId = _goodsTempInfo.TemplateId;
            _goodsInfo.validDate = _shopGoodsInfo.ValidDate;
            if(!_goodsTempInfo || !_shopGoodsInfo)
            {
               data = null;
               return;
            }
            _goods.data = _goodsInfo;
            _name.text = _goodsTempInfo.TemplateName;
            _name.numLines == 2 ? (_name.y = 5) : (Number(_name.y = 15));
            if(_shopGoodsInfo.Point > 0)
            {
               _price.text = String(_shopGoodsInfo.Point);
            }
            if(_shopGoodsInfo.GiftToken > 0)
            {
               _price.text = String(_shopGoodsInfo.GiftToken);
            }
            _priceIcon.visible = true;
            if(_buyGoodsInfo.isCanBuy == 0)
            {
               useBuyBtn();
            }
            else
            {
               useBoughtBtn();
            }
         }
         else
         {
            removeEvent();
         }
      }
      
      private function useBuyBtn() : void
      {
         if(_boughtBtn && _boughtBtn.parent)
         {
            _boughtBtn.parent.removeChild(_boughtBtn);
         }
         if(_buyBtn)
         {
            addChild(_buyBtn);
         }
      }
      
      private function useBoughtBtn() : void
      {
         if(_boughtBtn)
         {
            addChild(_boughtBtn);
         }
         if(_buyBtn && _buyBtn.parent)
         {
            _buyBtn.parent.removeChild(_buyBtn);
         }
      }
      
      private function clean() : void
      {
         _goods.data = null;
         _bg.setFrame(1);
         _name.text = "";
         _price.text = "";
         _priceIcon.visible = false;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _buyBtn = null;
         _shopGoodsInfo = null;
         _goodsTempInfo = null;
         _goodsInfo = null;
         _buyGoodsInfo = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get mysteryShopControler() : MysteryShopControler
      {
         return FrameControllerManager.instance.mysteryShopController;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get mysteryShopModel() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
      }
      
      private function get mysteryShopManager() : MysteryShopManager
      {
         return MysteryShopManager.instance;
      }
   }
}

