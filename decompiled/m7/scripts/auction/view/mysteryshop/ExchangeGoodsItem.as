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
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MysteryShopManager;
   import managers.ShopManager;
   import mvc.controler.MysteryShopControler;
   import mvc.module.auction.MysteryShopModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.NumBuyFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ExchangeGoodsItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _buyBtn:IconButton;
      
      private var _name:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _priceIcon:ScaleFrameImage;
      
      private var _points:FilterFrameText;
      
      private var _pointsIcon:ScaleFrameImage;
      
      private var _goods:BaseItemView;
      
      private var _data:ShopGoodsInfo;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      private var cost:int = 0;
      
      public function ExchangeGoodsItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopGoodsItemBg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopBuyBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsNameTextStyle");
         _price = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsValueTextStyle");
         _priceIcon = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsValueIcon");
         _points = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsPointsTextStyle");
         _pointsIcon = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryGoodsPointsIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("auction.MysteryBaseItemView");
         _price.x = 70;
         _priceIcon.x = 140;
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_buyBtn);
         addChild(_name);
         addChild(_price);
         addChild(_priceIcon);
         addChild(_points);
         addChild(_pointsIcon);
         addChild(_goods);
      }
      
      private function initEvents() : void
      {
         addEventListener("mouseOver",__itemRollOverHandler);
         addEventListener("mouseOut",__itemRollOutHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",__itemRollOverHandler);
         removeEventListener("mouseOut",__itemRollOutHandler);
         _buyBtn.removeEventListener("click",__buyBtnClickHandler);
      }
      
      private function __itemRollOverHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      private function __itemRollOutHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_data)
         {
            return;
         }
         SoundManager.instance.play("022");
         if(mysteryShopModel.buyCount >= mysteryShopModel.maxBuyCount)
         {
            _loc2_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(MysteryShopManager.instance.model.consumePoints < data.Score)
         {
            _loc2_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData2");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         CheckUIModuleUtil.instance.tryCall("numbuy",showBuyFrameCall);
      }
      
      private function showBuyFrameCall() : void
      {
         var _loc1_:NumBuyFrame = ComponentFactory.Instance.creatComponentByStylename("numbuy.numbuyFrame");
         _loc1_.data = _data;
         _loc1_.show();
      }
      
      private function buyGoodsHandlerBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            SoundManager.instance.play("022");
            if(param2)
            {
               _loc3_ = playerInfo.point + playerInfo.giftToken;
            }
            else
            {
               _loc3_ = int(playerInfo.point);
            }
            if(_loc3_ < cost)
            {
               RechargeAlertMannager.show();
               return;
            }
            ShopManager.Instance.buyOne((_data as ShopGoodsInfo).Id,1,playerInfo.userId,(_data as ShopGoodsInfo).PayType,false);
         }
         if(mysteryShopControler.frame)
         {
            StageReferance.stage.focus = mysteryShopControler.frame;
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
      
      public function get data() : ShopGoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         clean();
         _data = param1;
         if(data)
         {
            initEvents();
            _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(data.ItemId);
            _goodsInfo = new GoodsInfo();
            _goodsInfo.templateId = _goodsTempInfo.TemplateId;
            _goodsInfo.validDate = data.ValidDate;
            if(!_goodsTempInfo)
            {
               data = null;
               return;
            }
            _goods.data = _goodsInfo;
            _name.text = _goodsTempInfo.TemplateName;
            _name.numLines == 2 ? (_name.y = 5) : (Number(_name.y = 15));
            if(data.Point != 0)
            {
               _price.text = String(data.Point);
               _priceIcon.visible = true;
            }
            else if(data.GiftToken != 0)
            {
               _price.text = String(data.GiftToken);
               _priceIcon.visible = true;
            }
            _points.text = String(data.Score);
            _pointsIcon.visible = true;
            _buyBtn.visible = true;
         }
         else
         {
            removeEvents();
         }
      }
      
      private function clean() : void
      {
         _goods.data = null;
         _bg.setFrame(1);
         _name.text = "";
         _price.text = "";
         _priceIcon.visible = false;
         _points.text = "";
         _pointsIcon.visible = false;
         _buyBtn.visible = false;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_buyBtn)
         {
            ObjectUtils.disposeObject(_buyBtn);
         }
         _buyBtn = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_price)
         {
            ObjectUtils.disposeObject(_price);
         }
         _price = null;
         if(_priceIcon)
         {
            ObjectUtils.disposeObject(_priceIcon);
         }
         _priceIcon = null;
         if(_points)
         {
            ObjectUtils.disposeObject(_points);
         }
         _points = null;
         if(_pointsIcon)
         {
            ObjectUtils.disposeObject(_pointsIcon);
         }
         _pointsIcon = null;
         if(_goods)
         {
            ObjectUtils.disposeObject(_goods);
         }
         _goods = null;
         _data = null;
         _goodsTempInfo = null;
         _goodsInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

