package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
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
   import managers.ChildNswarManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.childnswar.ChildNswarUserInfo;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import utils.LogicUtils;
   import view.GoodsItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildNswarTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class ChildNswarShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _bg:MutipleImage;
      
      private var _back:ScaleBitmapImage;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _stripView:StripView;
      
      private var _displayShow:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _displayIcon:Bitmap;
      
      private var _itemContiner:Component;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _group:SelectedButtonGroup;
      
      private var _tabHbox:HBox;
      
      private var _tabBtnList:Vector.<SelectedIconButton>;
      
      private var _currencyInfo:PlayerCurrencyInfo;
      
      public function ChildNswarShopFrame()
      {
         super();
         _currencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         initView();
         addEvent();
         _group.selectIndex = 0;
      }
      
      private function initView() : void
      {
         var _loc1_:SelectedIconButton = null;
         var _loc6_:ChildNswarTempInfo = null;
         var _loc8_:int = 0;
         var _loc4_:GoodsItem = null;
         _data = FrameControllerManager.instance.shopController.model;
         titleText = LanguageMgr.GetTranslation("childnswar.shopTitle");
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("warlords.WarlordsShopFrame.HelpButton");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.matelordsShopTip.StripView");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.childnswar.shopFt");
         _displayIcon = ComponentFactory.Instance.creatBitmap("asset.childnswar.fgyIcon");
         _tabHbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvpShop.tabHbox");
         var _loc2_:ChildNswarUserInfo = ChildNswarManager.Instance.model.selfUserInfo;
         var _loc3_:ChildNswarTempInfo = TempleteManager.instance.childNswarCate.getTempById(_loc2_.pvpId);
         var _loc5_:Array = TempleteManager.instance.childNswarCate.getAlltemps();
         _itemContiner = new Component();
         _tabBtnList = new Vector.<SelectedIconButton>();
         _group = new SelectedButtonGroup();
         _tabHbox.beginChanges();
         _loc8_ = 1;
         while(_loc8_ <= 6)
         {
            if(_loc8_ == 6)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.shopTab6");
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.shopTab" + _loc8_);
            }
            _loc1_.enableMouseAble = true;
            _loc1_.lock = _loc3_.OpenShop < _loc8_;
            if(_loc3_.OpenShop < _loc8_)
            {
               _loc6_ = getMinArea(_loc5_,_loc8_);
               _loc1_.tipData = LanguageMgr.GetTranslation("theseuspvp.shopLockTip",_loc6_.Name);
            }
            else
            {
               _loc1_.tipData = null;
            }
            _tabHbox.addChild(_loc1_);
            _group.addSelectItem(_loc1_);
            _loc8_++;
         }
         _tabHbox.commitChanges();
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         _itemList = new Vector.<GoodsItem>();
         _loc8_ = 0;
         while(_loc8_ < 9)
         {
            _loc4_ = new GoodsItem();
            _loc9_ = _loc8_ / 3;
            _loc7_ = _loc8_ % 3;
            _loc4_.x = _loc7_ * _loc4_.width + 7;
            _loc4_.y = _loc9_ * (_loc4_.height + 3) + 35;
            _itemContiner.addChild(_loc4_);
            _itemList.push(_loc4_);
            _loc8_++;
         }
         var _loc10_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(7650001);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc10_.Description;
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = _currencyInfo.childNsWarCoin.amount.toString();
         _helpBtn.tipData = LanguageMgr.GetTranslation("multilords.MultilordsShopFrame.HelpButton.TipTxt");
         addToContent(_back);
         _back.y = 31;
         addToContent(_bg);
         _bg.x = 7;
         _bg.y = 37;
         addToContent(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 454;
         addToContent(_displayShowTxt);
         _displayShowTxt.x = 36;
         _displayShowTxt.y = 461;
         addToContent(_displayIcon);
         _displayIcon.x = 11;
         _displayIcon.y = 452;
         addToContent(_prePageBtn);
         _prePageBtn.y = 419;
         addToContent(_nextPageBtn);
         _nextPageBtn.y = 419;
         addToContent(_pageNumTxt);
         _pageNumTxt.y = 422;
         addToContent(_contributeTxt);
         _contributeTxt.x = 105;
         _contributeTxt.y = 459;
         addToContent(_stripView);
         addToContent(_itemContiner);
         addToContent(_tabHbox);
      }
      
      private function getMinArea(param1:Array, param2:int) : ChildNswarTempInfo
      {
         var _loc5_:ChildNswarTempInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.OpenShop >= param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
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
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
         if(_group)
         {
            _group.addEventListener("change",__changeViewHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
         if(_group)
         {
            _group.removeEventListener("change",__changeViewHandler);
         }
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("multilords.MultilordsShopHelpFrame");
         _loc2_["show"]();
      }
      
      private function __changeViewHandler(param1:Event) : void
      {
         var _loc2_:int = _group.selectIndex + 1;
         FrameControllerManager.instance.shopController.initChildNsWarShopFrame(_loc2_);
      }
      
      private function __refreshGoods(param1:ShopEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _itemList[_loc2_].data = _loc2_ < _data.showGoodsList.length ? ShopGoodsInfo(_data.showGoodsList[_loc2_]) : null;
            _loc2_++;
         }
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      private function __updateGodwinerPoint(param1:NotificationEvent) : void
      {
         _contributeTxt.text = _currencyInfo.childNsWarCoin.amount.toString();
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
      
      private function __refreshPage(param1:ShopEvent) : void
      {
         _pageNumTxt.text = _data.currentPage + "/" + _data.totalPage;
         _prePageBtn.enable = _data.currentPage != 1;
         _nextPageBtn.enable = _data.currentPage != _data.totalPage;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tabHbox);
         _tabHbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

