package outercityshop.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.OuterCityShopManager;
   import managers.PlayerCurrencyManager;
   import mvc.controler.OuterCityShopControler;
   import mvc.module.outercityshop.OuterCityShopItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class OuterCityShopGoodsItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _goods:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      private var _boughtBtn:IconButton;
      
      private var _priceIcon:BaseIconView;
      
      private var _pointsIcon:Image;
      
      private var _dropImg:Bitmap;
      
      private var sprite:Sprite;
      
      private var _hBox:HBox;
      
      private var _itemInfo:OuterCityShopItemInfo;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _needValueCount:Array = [];
      
      private var _needValueItemId:Array = [];
      
      private var _items:Array = [];
      
      public function OuterCityShopGoodsItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsItemBg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsBuyBtn");
         _boughtBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsBoughtBtn");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsNameTextStyle");
         _dropImg = ComponentFactory.Instance.creatBitmap("asset.outercityshop.dropImg");
         _goods = ComponentFactory.Instance.creatCustomObject("outercityshop.OuterCityShopGoodsBaseItemView");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsHbox");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_nameTxt);
         addChild(_hBox);
         addChild(_goods);
         addChild(_dropImg);
         _boughtBtn.enable = false;
      }
      
      public function set data(param1:OuterCityShopItemInfo) : void
      {
         var _loc5_:GoodsTemplateInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc4_:Boolean = false;
         clean();
         if(param1)
         {
            addEvent();
            _itemInfo = param1;
            _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_itemInfo.itemTemInfo.ItemId);
            if(!_goodsTempInfo)
            {
               data = null;
               return;
            }
            _goodsInfo = new GoodsInfo();
            _goodsInfo.templateId = _goodsTempInfo.TemplateId;
            _goodsInfo.count = _itemInfo.itemTemInfo.Count;
            _goods.data = _goodsInfo;
            _nameTxt.text = _goodsTempInfo.TemplateName;
            _nameTxt.y = _nameTxt.numLines > 1 ? 4 : 15;
            _loc4_ = false;
            if(_itemInfo.costInfos)
            {
               for each(var _loc2_:Array in _itemInfo.costInfos)
               {
                  if(_loc2_[0] == "Score")
                  {
                     _loc4_ = true;
                     _needValueCount.push(_loc2_[1]);
                     _needValueItemId.push("Score");
                     sprite = new Sprite();
                     _priceTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsValueTextStyle");
                     _priceTxt.text = _loc2_[1];
                     sprite.addChild(_priceTxt);
                     _items.push(_priceTxt);
                     _pointsIcon = ComponentFactory.Instance.creatComponentByStylename("outercityshop.PointsImg");
                     _pointsIcon.x = _priceTxt.textWidth + 5;
                     sprite.addChild(_pointsIcon);
                     _items.push(_pointsIcon);
                     _hBox.addChild(sprite);
                  }
                  else
                  {
                     _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_[0]);
                     if(_loc5_)
                     {
                        _loc3_ = new GoodsInfo();
                        _loc3_.templateId = _loc5_.TemplateId;
                        _needValueCount.push(_loc2_[1]);
                        _needValueItemId.push(_loc5_.TemplateId);
                        sprite = new Sprite();
                        _priceTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsValueTextStyle");
                        _priceTxt.text = _loc2_[1];
                        sprite.addChild(_priceTxt);
                        _items.push(_priceTxt);
                        _priceIcon = ComponentFactory.Instance.creatCustomObject("outercityshop.OuterCityShopGoodsValueIcon");
                        _priceIcon.icon = IconFactory.getOuterCityShopIconPath(_loc5_.TemplateId);
                        _priceIcon.tipData = _loc5_.TemplateName;
                        if(_loc5_.TemplateId == 2131057)
                        {
                           _priceIcon.tipData = _loc5_.Description;
                        }
                        _priceIcon.x = _priceTxt.textWidth + 5;
                        sprite.addChild(_priceIcon);
                        _items.push(_priceIcon);
                        _hBox.addChild(sprite);
                     }
                  }
               }
            }
            _hBox.x = 250 - _hBox.width;
            if(_loc4_)
            {
               _hBox.x = 239 - _hBox.width;
            }
            if(_itemInfo.itemTemInfo.IsDrop == 1)
            {
               _dropImg.visible = true;
            }
            if(_itemInfo.isBuy)
            {
               useBoughtBtn();
            }
            else
            {
               useBuyBtn();
            }
         }
         else
         {
            removeEvent();
         }
      }
      
      private function getCountStr(param1:int) : String
      {
         var _loc2_:Number = param1 / 1000;
         if(param1 % 1000 == 0)
         {
            if(_loc2_ >= 1)
            {
               return int(_loc2_) + "K";
            }
         }
         else
         {
            if(_loc2_ >= 1 && _loc2_ < 10)
            {
               return _loc2_.toFixed(1) + "K";
            }
            if(_loc2_ > 10)
            {
               return int(_loc2_) + "K";
            }
         }
         return param1.toString();
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
      
      private function addEvent() : void
      {
         addEventListener("mouseOut",__onMouseOutHandler);
         addEventListener("mouseOver",__onMouseOverHandler);
         _buyBtn.addEventListener("click",__onBuyBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOut",__onMouseOutHandler);
         removeEventListener("mouseOver",__onMouseOverHandler);
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__onBuyBtnHandler);
         }
      }
      
      private function get checkGoods() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:String = null;
         _loc2_ = 0;
         for(; _loc2_ < _needValueCount.length; _loc2_++)
         {
            if(_needValueItemId[_loc2_] == "Score")
            {
               if(OuterCityShopManager.instance.model.consumePoints < _needValueCount[_loc2_])
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("outercityshop.goodsItemTip",LanguageMgr.GetTranslation("outercityshop.score")));
                  return true;
               }
               continue;
            }
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_needValueItemId[_loc2_]).TemplateName;
            switch(_needValueItemId[_loc2_])
            {
               case -100:
                  if(ResourceManager.instance.gold.count < _needValueCount[_loc2_])
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case -300:
                  if(playerModel.playerInfo.strategy < _needValueCount[_loc2_])
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case -400:
                  if(playerModel.playerInfo.point + playerModel.playerInfo.giftToken < _needValueCount[_loc2_])
                  {
                     RechargeAlertMannager.show();
                     return true;
                  }
                  break;
               case -600:
                  if(ResourceManager.instance.waterCrystal.count < _needValueCount[_loc2_])
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case 2131057:
                  if(GoodsManager.instance.getGoodsNumByTempId(2131057) < _needValueCount[_loc2_])
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case 208001:
                  if(PlayerCurrencyManager.instance.currencyInfo.arenaMedal.amount < _needValueCount[_loc2_])
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
            }
         }
         return false;
      }
      
      private function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc8_:String = null;
         SoundManager.instance.play("022");
         if(checkGoods)
         {
            return;
         }
         var _loc7_:String = getConfirmContent();
         if(_itemInfo.itemTemInfo.Type == 1)
         {
            SimpleAlertHelper.instance.data = [confirmBuyBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
            return;
         }
         if(SharedManagerHelper.ins.isNeedAlert("outercityshop_GoodsItem_buyBtnHandle"))
         {
            SharedManagerHelper.ins.needAlert("outercityshop_GoodsItem_buyBtnHandle",buyGoodsHandlerBack,LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt"),_loc7_,"");
         }
         else
         {
            SimpleAlertHelper.instance.data = [confirmBuyBack2];
            _loc5_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc8_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc7_,_loc5_,_loc4_,true,false,false,2,"SIMPLE_ALERT");
         }
      }
      
      private function getConfirmContent() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = LanguageMgr.GetTranslation("outercityshop.goodsItem.tipContent",_goodsTempInfo.TemplateName);
         _loc1_ = 0;
         while(_loc1_ < _needValueCount.length)
         {
            if(_needValueItemId[_loc1_] == "Score")
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("outercityshop.score") + "x" + _needValueCount[_loc1_];
            }
            else
            {
               _loc2_ += " " + TempleteManager.instance.goodsTemplateCate.getTemplateByID(_needValueItemId[_loc1_]).TemplateName + "x" + _needValueCount[_loc1_];
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function confirmBuyBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            buyGoodsHandlerBack(false);
         }
      }
      
      private function confirmBuyBack2(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            _loc3_ = getConfirmContent();
            SharedManagerHelper.ins.needAlert("outercityshop_GoodsItem_buyBtnHandle",buyGoodsHandlerBack,LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt"),_loc3_,"");
         }
      }
      
      private function buyGoodsHandlerBack(param1:Boolean) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = param1 ? 2 : 1;
         if(_itemInfo.itemTemInfo.Type == 2)
         {
            OuterCityShopManager.instance.sendAction(2,_itemInfo.itemTemInfo.Type,_itemInfo.index,_loc2_);
         }
         else if(_itemInfo.itemTemInfo.Type == 1)
         {
            OuterCityShopManager.instance.sendAction(2,_itemInfo.itemTemInfo.Type,_itemInfo.itemTemInfo.MapShopId,_loc2_);
         }
         if(outercityShopControler.frame)
         {
            StageReferance.stage.focus = outercityShopControler.frame;
         }
      }
      
      private function clean() : void
      {
         _needValueCount = [];
         _needValueItemId = [];
         _hBox.disposeAllChildren();
         if(_boughtBtn && _boughtBtn.parent)
         {
            _boughtBtn.parent.removeChild(_boughtBtn);
         }
         if(_buyBtn && _buyBtn.parent)
         {
            _buyBtn.parent.removeChild(_buyBtn);
         }
         _goods.data = null;
         if(_priceIcon)
         {
            _priceIcon = null;
         }
         _bg.setFrame(1);
         _nameTxt.text = "";
         if(_priceTxt)
         {
            _priceTxt = null;
         }
         if(sprite)
         {
            sprite = null;
         }
         _dropImg.visible = false;
      }
      
      private function __onMouseOverHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      private function __onMouseOutHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function get outercityShopControler() : OuterCityShopControler
      {
         return FrameControllerManager.instance.outerCityShopControler;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_priceTxt)
         {
            _priceTxt.dispose();
         }
         _priceTxt = null;
         if(_goods)
         {
            _goods.dispose();
         }
         _goods = null;
         if(_buyBtn)
         {
            _buyBtn.dispose();
         }
         _buyBtn = null;
         if(_boughtBtn)
         {
            _boughtBtn.dispose();
         }
         _boughtBtn = null;
         if(_priceIcon)
         {
            _priceIcon.dispose();
         }
         _priceIcon = null;
         if(_pointsIcon)
         {
            _pointsIcon.dispose();
         }
         _pointsIcon = null;
         ObjectUtils.disposeObject(_dropImg);
         _dropImg = null;
         if(_items)
         {
            while(_items.length > 0)
            {
               ObjectUtils.disposeObject(_items.pop());
            }
            _items = null;
         }
         if(_hBox)
         {
            _hBox.disposeAllChildren();
            _hBox.dispose();
         }
         _hBox = null;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _buyBtn = null;
         _itemInfo = null;
         _goodsTempInfo = null;
         _goodsInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

