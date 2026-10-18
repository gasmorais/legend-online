package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.filter.UIFilter;
   
   public class GoodsItem1 extends GoodsItem
   {
      
      private var _limitedTxt:FilterFrameText;
      
      private var _limitedNum:FilterFrameText;
      
      private var _vipMC:MovieImage;
      
      private var _discountMc:MovieImage;
      
      private var _label:ScaleFrameImage;
      
      public function GoodsItem1()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsItemBg1");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsNameTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.BuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.BaseItemView");
         _hasOwnTxt = ComponentFactory.Instance.creatComponentByStylename("shop.hasOwnTxt");
         _bg.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_goods);
         addChild(_buyBtn);
         _lineImg.y = 55;
         _limitedTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsLimitedTextStyle");
         _limitedNum = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsLimitedNumTextStyle");
         addChild(_limitedTxt);
         addChild(_limitedNum);
      }
      
      override public function set data(param1:ShopGoodsInfo) : void
      {
         super.data = param1;
         if(param1)
         {
            setLimitCount();
            setDiscount(_data.Discount);
            setLabel(_data.Labels);
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
         if(_data.Labels == 1 || _data.Labels == 2 || _data.Labels == 3)
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
               _lookBtn.enable = false;
               _buyBtn.enable = false;
            }
            else
            {
               _limitedTxt.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited02");
               _limitedNum.text = _data.OneDayCount - _data.OneCurrentCount + "";
               _lookBtn.enable = true;
               _buyBtn.enable = true;
            }
         }
         else
         {
            _limitedTxt.text = "";
            _limitedNum.text = "";
            _lookBtn.enable = true;
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
         ObjectUtils.disposeObject(_limitedTxt);
         _limitedTxt = null;
         ObjectUtils.disposeObject(_limitedNum);
         _limitedNum = null;
         ObjectUtils.disposeObject(_vipMC);
         _vipMC = null;
         ObjectUtils.disposeObject(_discountMc);
         _discountMc = null;
         ObjectUtils.disposeObject(_label);
         _label = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

