package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.NumBuyFrame;
   
   public class GoodsItem6 extends Component
   {
      
      private var _bg:Image;
      
      private var _overbg:Image;
      
      private var _itemView:BaseItemView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _moneyImg:ScaleFrameImage;
      
      private var _petMoneyImg:ScaleFrameImage;
      
      private var _exchagneBtn:IconButton;
      
      private var _lookBtn:TextButton;
      
      public var clickCallBack:Function;
      
      public var profileColors:Array;
      
      private var _data:ShopGoodsInfo;
      
      public function GoodsItem6()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("GoodsItem6.Bg");
         _overbg = ComponentFactory.Instance.creatComponentByStylename("GoodsItem6.OverBg");
         _itemView = ComponentFactory.Instance.creatCustomObject("GoodsItem6.ItemView");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("GoodsItem6.NameTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("GoodsItem6.PriceTxt");
         _moneyImg = ComponentFactory.Instance.creatComponentByStylename("GoodsItem6.MoneyImg");
         _petMoneyImg = ComponentFactory.Instance.creatComponentByStylename("GoodsItem6.PetMoneyImg");
         _exchagneBtn = ComponentFactory.Instance.creatComponentByStylename("GoodsItem6.ExchagneBtn");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         addChild(_bg);
         addChild(_overbg);
         addChild(_itemView);
         addChild(_nameTxt);
         addChild(_priceTxt);
         addChild(_moneyImg);
         addChild(_petMoneyImg);
         addChild(_exchagneBtn);
         _overbg.visible = false;
         _exchagneBtn.setFrame(1);
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         clean();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_overbg);
         _overbg = null;
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_moneyImg);
         _moneyImg = null;
         ObjectUtils.disposeObject(_petMoneyImg);
         _petMoneyImg = null;
         ObjectUtils.disposeObject(_exchagneBtn);
         _exchagneBtn = null;
         ObjectUtils.disposeObject(_lookBtn);
         _lookBtn = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         removeEventListener("click",__clickHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _overbg.visible = true;
         if(checkIsFashion())
         {
            _lookBtn.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _overbg.visible = false;
         _lookBtn.visible = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(param1.target == _exchagneBtn)
         {
            if(clickCallBack != null)
            {
               clickCallBack(data);
            }
            showConfirmFrame();
         }
         else if(param1.target == _lookBtn)
         {
            showFashionPreview();
         }
      }
      
      private function showFashionPreview() : void
      {
         if(!checkIsFashion())
         {
            return;
         }
         var _loc2_:Vector.<GoodsTemplateInfo> = new Vector.<GoodsTemplateInfo>(4);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
         switch(int(_data.Area) - 109)
         {
            case 0:
               _loc2_[0] = _loc1_;
               break;
            case 1:
               _loc2_[3] = _loc1_;
               break;
            case 2:
               _loc2_[1] = _loc1_;
               break;
            case 3:
               _loc2_[2] = _loc1_;
         }
         FrameControllerManager.instance.openControllerByInfo("shop",9,[_loc2_]);
      }
      
      private function showConfirmFrame() : void
      {
         CheckUIModuleUtil.instance.tryCall("numbuy",showBuyFrameCall);
      }
      
      public function getHtmlName(param1:String, param2:int) : String
      {
         if(!profileColors)
         {
            profileColors = ["#ffffff","#999999","#59cd41","#32a2f8","#a838f7","#ff8000","#ce0f0f","#ce0f0f"];
         }
         var _loc3_:String = profileColors[param2];
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("StarHelper.tempTxt",_loc3_,param1);
         }
         return param1;
      }
      
      private function showBuyFrameCall() : void
      {
         if(isDie)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         var _loc1_:NumBuyFrame = ComponentFactory.Instance.creatComponentByStylename("numbuy.numbuyFrame");
         _loc1_.data = _data;
         _loc1_.show();
      }
      
      public function get data() : ShopGoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         _data = param1;
         if(_data)
         {
            addEvent();
            refresh();
         }
         else
         {
            removeEvent();
            clean();
         }
      }
      
      private function checkIsFashion() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         switch(int(_data.Area) - 109)
         {
            case 0:
            case 1:
            case 2:
            case 3:
               return true;
            default:
               return false;
         }
      }
      
      private function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = _data.ItemId;
         var _loc1_:GoodsTemplateInfo = _loc5_.templateInfo;
         _nameTxt.text = "";
         if(_loc1_)
         {
            _nameTxt.text = _loc1_.TemplateName;
            _nameTxt.setFrame(_loc1_.Profile);
         }
         _itemView.data = _loc5_;
         _priceTxt.text = _data.price + "";
         if(_data.ShopType == 8)
         {
            _loc2_ = _data.PayType - 1001 + 1;
            _petMoneyImg.setFrame(_loc2_);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.NeedItem);
            if(_loc3_)
            {
               _petMoneyImg.tipData = _loc3_.Description;
            }
            _petMoneyImg.visible = true;
            _moneyImg.visible = false;
         }
         else if(_data.ShopType == 15)
         {
            _petMoneyImg.setFrame(7);
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2100038);
            _petMoneyImg.tipData = _loc4_.Description;
            _petMoneyImg.visible = true;
            _moneyImg.visible = false;
         }
         else
         {
            _moneyImg.setFrame(_data.PayType);
            _moneyImg.visible = true;
            _petMoneyImg.visible = false;
         }
         _exchagneBtn.visible = true;
         _itemView.visible = true;
         refreshBtnState();
      }
      
      public function refreshBtnState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         if(_data && _data.NeedItem != 0)
         {
            switch(_data.NeedItem)
            {
               case 3101011:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petFireCream.amount);
                  break;
               case 3101021:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petWaterCream.amount);
                  break;
               case 3101031:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petElectricCream.amount);
                  break;
               case 3101041:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petWindCream.amount);
                  break;
               case 3101071:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petExchangeCoin.amount);
                  break;
               case 2100038:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petCrystal.amount);
                  break;
               case 3101081:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petSpirit.amount);
                  break;
               case 3101091:
                  _loc1_ = int(PlayerCurrencyManager.instance.currencyInfo.petBreath.amount);
                  break;
               default:
                  _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(_data.NeedItem));
            }
            _loc2_ = _loc1_ >= _data.price;
            if(!_loc2_)
            {
               _exchagneBtn.enable = false;
               _itemView.filters = [UIFilter.getGrayFilter()];
               _priceTxt.setFrame(2);
            }
            else
            {
               _exchagneBtn.enable = true;
               _itemView.filters = null;
               _priceTxt.setFrame(1);
            }
         }
      }
      
      private function clean() : void
      {
         _itemView.data = null;
         _nameTxt.text = "";
         _priceTxt.text = "";
         _moneyImg.visible = false;
         _petMoneyImg.visible = false;
         _exchagneBtn.visible = false;
         _itemView.visible = false;
         _lookBtn.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
         clickCallBack = null;
      }
   }
}

