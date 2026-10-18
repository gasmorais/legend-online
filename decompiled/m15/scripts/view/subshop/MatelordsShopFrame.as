package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import utils.LogicUtils;
   import view.FurnitureShopItem;
   import view.GoodsItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class MatelordsShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _bg:MutipleImage;
      
      private var _back:ScaleBitmapImage;
      
      private var _signButton:IconButton;
      
      private var _displayShow:Bitmap;
      
      private var _pvpIcon:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _stripView:StripView;
      
      private var _group:SelectedButtonGroup;
      
      private var _mateShopBtn:SelectedButton;
      
      private var _furnitureShopBtn:SelectedButton;
      
      private var _itemContiner:Component;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _furnitureList:Vector.<FurnitureShopItem>;
      
      private var _currencyInfo:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      
      public function MatelordsShopFrame()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.shopController.model;
         titleText = LanguageMgr.GetTranslation("view.subshop.MatelordsShopFrame.str01");
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _pvpIcon = ComponentFactory.Instance.creatBitmap("asset.core.EternalCrystal");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.matelordsDisplayShowTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("warlords.WarlordsShopFrame.HelpButton");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.matelordsShopTip.StripView");
         _mateShopBtn = ComponentFactory.Instance.creatComponentByStylename("MatelordsShopFrame.mateShopBtn");
         _furnitureShopBtn = ComponentFactory.Instance.creatComponentByStylename("MatelordsShopFrame.furnitureShopBtn");
         _itemContiner = new Component();
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_mateShopBtn);
         _group.addSelectItem(_furnitureShopBtn);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-1600);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc1_.Description;
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = _currencyInfo.eternalCrystal.amount.toString();
         _helpBtn.tipData = LanguageMgr.GetTranslation("multilords.MultilordsShopFrame.HelpButton.TipTxt");
         addToContent(_back);
         _back.y = 31;
         addToContent(_bg);
         _bg.x = 7;
         _bg.y = 37;
         addToContent(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 464;
         addToContent(_pvpIcon);
         _pvpIcon.x = 14;
         _pvpIcon.y = 467;
         addToContent(_displayShowTxt);
         _displayShowTxt.x = 41;
         _displayShowTxt.y = 469;
         addToContent(_signButton);
         _signButton.y = 443;
         addToContent(_prePageBtn);
         _prePageBtn.y = 419;
         addToContent(_nextPageBtn);
         _nextPageBtn.y = 419;
         addToContent(_pageNumTxt);
         _pageNumTxt.y = 422;
         addToContent(_contributeTxt);
         _contributeTxt.x = 115;
         _contributeTxt.y = 469;
         addToContent(_stripView);
         addToContent(_mateShopBtn);
         addToContent(_furnitureShopBtn);
         addToContent(_itemContiner);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         _helpBtn.addEventListener("click",__helpHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
         if(_group)
         {
            _group.addEventListener("change",__changeViewHandler);
         }
         MsgMan.addObserver("ChildEvent.HOME_INFO",this,__updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         _helpBtn.removeEventListener("click",__helpHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
         if(_group)
         {
            _group.removeEventListener("change",__changeViewHandler);
         }
         MsgMan.removeObserver("ChildEvent.HOME_INFO",this,__updateInfoHandler);
      }
      
      private function __updateInfoHandler(param1:String = "", param2:Object = null) : void
      {
         __refreshGoods(null);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("multilords.MultilordsShopHelpFrame");
         _loc2_["show"]();
      }
      
      private function __refreshPage(param1:ShopEvent) : void
      {
         _pageNumTxt.text = _data.currentPage + "/" + _data.totalPage;
         _prePageBtn.enable = _data.currentPage != 1;
         _nextPageBtn.enable = _data.currentPage != _data.totalPage;
      }
      
      private function __changeViewHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         ObjectUtils.disposeAllChildren(_itemContiner);
         LogicUtils.disposeDisplayCollection(_itemList);
         LogicUtils.disposeDisplayCollection(_furnitureList);
         var _loc6_:int = int(_group.selectIndex);
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _itemList = new Vector.<GoodsItem>();
         _furnitureList = new Vector.<FurnitureShopItem>();
         _loc4_ = 0;
         while(_loc4_ < 9)
         {
            _loc2_ = _loc6_ == 0 ? new GoodsItem() : new FurnitureShopItem();
            _loc5_ = _loc4_ / 3;
            _loc3_ = _loc4_ % 3;
            _loc2_.x = _loc3_ * _loc2_.width + 7;
            _loc2_.y = _loc5_ * (_loc2_.height + 3) + 35;
            addToContent(_loc2_);
            _loc6_ == 0 ? _itemList.push(_loc2_) : _furnitureList.push(_loc2_);
            _loc4_++;
         }
         if(_loc6_ == 0)
         {
            FrameControllerManager.instance.shopController.initMatelordsShopFrame();
         }
         else if(_loc6_ == 1)
         {
            FrameControllerManager.instance.shopController.initFurnitureShopFrame();
         }
      }
      
      private function __refreshGoods(param1:ShopEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            if(_group.selectIndex == 0)
            {
               _itemList[_loc2_].data = _loc2_ < _data.showGoodsList.length ? ShopGoodsInfo(_data.showGoodsList[_loc2_]) : null;
            }
            else
            {
               _furnitureList[_loc2_].data = _loc2_ < _data.showGoodsList.length ? _data.showGoodsList[_loc2_] : null;
            }
            _loc2_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __updateGodwinerPoint(param1:NotificationEvent) : void
      {
         _contributeTxt.text = _currencyInfo.eternalCrystal.amount.toString();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_itemList);
         LogicUtils.disposeDisplayCollection(_furnitureList);
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

