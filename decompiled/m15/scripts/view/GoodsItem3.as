package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.fashion.FashionModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   
   public class GoodsItem3 extends GoodsItem
   {
      
      private var _limitedTxt:FilterFrameText;
      
      private var _limitedNum:FilterFrameText;
      
      private var _vipMC:MovieImage;
      
      private var _discountMc:MovieImage;
      
      private var _label:ScaleFrameImage;
      
      private var _tryOnBtn:TextButton;
      
      private var _activeState:FilterFrameText;
      
      public function GoodsItem3()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.fashionGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsNameTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _tryOnBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.BuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.BaseItemView");
         _activeState = ComponentFactory.Instance.creatComponentByStylename("shop.ActiveStateTextStyle");
         _bg.setFrame(1);
         _tryOnBtn.visible = false;
         _tryOnBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         _activeState.text = LanguageMgr.GetTranslation("view.GoodsItem3.ActiveState.text");
         _activeState.visible = false;
         addChild(_bg);
         addChild(_lineImg);
         _lineImg.x = 231;
         _lineImg.y = 47;
         _lineImg.setFrame(1);
         addChild(_nameTxt);
         _nameTxt.x = 140;
         _nameTxt.y = 17;
         addChild(_tips);
         addChild(_valueTxt);
         _valueTxt.x = 163;
         _valueTxt.y = 45;
         addChild(_goods);
         _goods.x = 20;
         _goods.y = 15;
         _goods.buttonMode = true;
         addChild(_buyBtn);
         _buyBtn.x = 174;
         _buyBtn.y = 67;
         addChild(_activeState);
         _limitedTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsLimitedTextStyle");
         _limitedNum = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsLimitedNumTextStyle");
         addChild(_limitedTxt);
         _limitedTxt.y = 80;
         addChild(_limitedNum);
         _limitedTxt.y = 80;
      }
      
      override protected function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         this.addEventListener("click",__clickHandler);
      }
      
      override protected function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _buyBtn)
         {
            __onBuyBtnHandler(param1);
         }
         else if(!isFashionSoul)
         {
            __onLookBtnHandler(param1);
         }
      }
      
      override protected function __overHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_bg)
         {
            _bg.setFrame(2);
         }
         if(_tryOnBtn && !isFashionSoul)
         {
            _tryOnBtn.visible = true;
         }
         if(_label && !isFashionSoul)
         {
            _label.visible = false;
         }
      }
      
      override protected function __outHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_bg)
         {
            _bg.setFrame(1);
         }
         if(_tryOnBtn)
         {
            _tryOnBtn.visible = false;
         }
         if(_label)
         {
            _label.visible = true;
         }
      }
      
      override public function set data(param1:ShopGoodsInfo) : void
      {
         buttonMode = false;
         super.data = param1;
         if(param1)
         {
            setLimitCount();
            setDiscount(_data.Discount);
            setLabel(_data.Labels);
            setActiveState();
            if(!isFashionSoul)
            {
               buttonMode = true;
            }
         }
      }
      
      private function get isFashionSoul() : Boolean
      {
         if(_data)
         {
            return _data.ItemId == 208020 || _data.ItemId == 208021;
         }
         return false;
      }
      
      override protected function setFilter() : void
      {
         super.setFilter();
         _tryOnBtn.visible = false;
      }
      
      override protected function __onLookBtnHandler(param1:MouseEvent) : void
      {
         if(isFashion)
         {
            fashionModel.wearFahion(_data);
         }
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function setActiveState() : void
      {
         if(fashionModel.isInBookList(_data.ItemId))
         {
            _nameTxt.x = 75;
            _activeState.visible = true;
         }
         else
         {
            _nameTxt.x = 115;
            _activeState.visible = false;
         }
      }
      
      private function setLabel(param1:int) : void
      {
         if(_data.Discount != 0 || _data.Labels == 0)
         {
            return;
         }
         if(!_label)
         {
            _label = ComponentFactory.Instance.creatComponentByStylename("shop.ItemLabel");
            _label.mouseChildren = _label.mouseEnabled = false;
         }
         addChild(_label);
         if(_data.Labels == 1 || _data.Labels == 2)
         {
            _label.setFrame(_data.Labels + 1);
         }
         else
         {
            _label.setFrame(1);
         }
      }
      
      private function setLimitCount() : void
      {
         if(_data.OneDayCount != -1)
         {
            if(_data.OneCurrentCount >= _data.OneDayCount)
            {
               _limitedTxt.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited");
               _limitedNum.text = "";
               _tryOnBtn.enable = false;
               _buyBtn.enable = false;
            }
            else
            {
               _limitedTxt.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited02");
               _limitedNum.text = _data.OneDayCount - _data.OneCurrentCount + "";
               _tryOnBtn.enable = true;
               _buyBtn.enable = true;
            }
         }
         else
         {
            _limitedTxt.text = "";
            _limitedNum.text = "";
            _tryOnBtn.enable = true;
            _buyBtn.enable = true;
         }
      }
      
      override protected function clean() : void
      {
         super.clean();
         _limitedTxt.text = "";
         _limitedNum.text = "";
         if(_vipMC)
         {
            _vipMC.parent.removeChild(_vipMC);
            _vipMC = null;
         }
         if(_discountMc)
         {
            _discountMc.parent.removeChild(_discountMc);
            _discountMc = null;
         }
         if(_label && _label.parent)
         {
            _label.parent.removeChild(_label);
         }
         _activeState.visible = false;
      }
      
      private function setDiscount(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         if(!_discountMc)
         {
            _discountMc = ComponentFactory.Instance.creatComponentByStylename("shop.DiscountMc");
            addChild(_discountMc);
            _discountMc.mouseChildren = false;
            _discountMc.mouseEnabled = false;
         }
         _discountMc.movie.gotoAndStop(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

