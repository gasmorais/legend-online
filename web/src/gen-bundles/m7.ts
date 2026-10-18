// @ts-nocheck
export const defs = {};
export const deps = {};
defs["auction.SupermarketFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __SupermarketFrame extends __Base {
    static $fields(self) {
    self._back = null;
    self._actionShopView = null;
    self._mysteryShopView = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.MarketBg");
         this._actionShopView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.AuctionShop");
         this._mysteryShopView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.MysteryShop");
         this.addToContent(this._back);
         this.addToContent(this._actionShopView);
         this.addToContent(this._mysteryShopView);
      }
    get auctionShopView() {
         return this._actionShopView;
      }
    get mysteryShopView() {
         return this._mysteryShopView;
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    show(param1 = 1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command24");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         if(!this.mysteryShopModel.lastRefreshTime || this.mysteryShopModel.remainTime == 0)
         {
            this.mysteryShopManager.sendRefreshGoodsList(false);
         }
         if(param1 == 1)
         {
            this._actionShopView.showMask.visible = false;
         }
         else
         {
            this._mysteryShopView.showMask.visible = false;
         }
      }
    get mysteryShopModel() {
         return $.C("managers.MysteryShopManager").instance.model;
      }
    get mysteryShopManager() {
         return $.C("managers.MysteryShopManager").instance;
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    set groups(v) { super.groups = v; }
    set auctionShopView(v) { super.auctionShopView = v; }
    set mysteryShopView(v) { super.mysteryShopView = v; }
    set mysteryShopModel(v) { super.mysteryShopModel = v; }
    set mysteryShopManager(v) { super.mysteryShopManager = v; }
  }
  $.meta(__SupermarketFrame, "auction.SupermarketFrame", []);
  return __SupermarketFrame;
}
deps["auction.SupermarketFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.MysteryShopManager", "yishi.keyboard.KeyBoardRegister"];

defs["auction.view.AuctionAlert"] = function define($) {
  const __Base = $.Object;
  class __AuctionAlert extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static alert(param1, param2, param3 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var title = param1;
         var msg = param2;
         var closeFun = param3;
         var response = (param1) =>
         {
            if(closeFun != null)
            {
               if(closeFun.length > 0)
               {
                  closeFun(param1);
               }
               else
               {
                  closeFun();
               }
            }
            alert.removeEventListener("response",response);
            alert.dispose();
         };
         var alert = $.C("com.pickgliss.ui.AlertManager").Instance.simpleAlert(title,msg);
         alert.addEventListener("response",response);
      }
  }
  $.meta(__AuctionAlert, "auction.view.AuctionAlert", []);
  return __AuctionAlert;
}
deps["auction.view.AuctionAlert"] = ["com.pickgliss.ui.AlertManager"];

defs["auction.view.AuctionBuyPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionBuyPane extends __Base {
    static $fields(self) {
    self._searchPane = null;
    self._categoryPane = null;
    self._resultPane = null;
    self._searchControl = null;
    }
    constructor() {
         super();
         this.initView();
         this._searchControl = new ($.C("auction.view.buy.AuctionSearchControl"))(this._searchPane,this._categoryPane,this._resultPane.getBottomBar().getPageControlComp(),this._resultPane);
      }
    initView() {
         this._searchPane = new ($.C("auction.view.buy.AuctionSearchPane"))();
         this._searchPane.x = 3;
         this._searchPane.y = 4;
         this.addChild(this._searchPane);
         this._categoryPane = new ($.C("auction.view.buy.AuctionCategoryPane"))();
         this._categoryPane.x = 0;
         this._categoryPane.y = 84;
         this.addChild(this._categoryPane);
         this._resultPane = new ($.C("auction.view.buy.AuctionBuyResultPane"))();
         this._resultPane.x = 222;
         this._resultPane.y = 84;
         this.addChild(this._resultPane);
      }
    addHandler() {
      }
    removeHandler() {
      }
    getSearchControl() {
         return this._searchControl;
      }
    dispose() {
         this.removeHandler();
         this._searchControl.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._searchPane);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._categoryPane);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resultPane);
         this._searchPane = null;
         this._categoryPane = null;
         this._resultPane = null;
      }
  }
  $.meta(__AuctionBuyPane, "auction.view.AuctionBuyPane", ["Disposeable"]);
  return __AuctionBuyPane;
}
deps["auction.view.AuctionBuyPane"] = ["auction.view.buy.AuctionBuyResultPane", "auction.view.buy.AuctionCategoryPane", "auction.view.buy.AuctionSearchControl", "auction.view.buy.AuctionSearchPane", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["auction.view.AuctionFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __AuctionFrame extends __Base {
    static $fields(self) {
    self._border = null;
    self._paneBack = null;
    self._bar = null;
    self._paneContainer = null;
    self._currentPane = null;
    self._help = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.auctionhelpBtn");
    self._isFirstOpen = true;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this._help.tipData = $.C("manager.LanguageMgr").GetTranslation("Auction.AuctionFrameTitle.helpData");
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("Auction.AuctionFrameTitle");
      }
    initView() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionFrameBorder");
         this.addToContent(this._border);
         this._paneBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionFramePaneBack.Scale9CornerImage");
         this.addToContent(this._paneBack);
         this._bar = new ($.C("auction.view.AuctionTopBar"))();
         this._bar.x = 21;
         this._bar.y = -9.5;
         this.addToContent(this._bar);
         this._paneContainer = new ($.C("flash.display.Sprite"))();
         this.addToContent(this._paneContainer);
      }
    addChildren() {
         super.addChildren();
         this.addChild(this._help);
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         this.onBuyClick(null);
         this._bar.initIndex();
      }
    showPane(param1) {
         var _loc2_ = this._currentPane;
         this._currentPane = param1;
         if(!this._currentPane.parent)
         {
            this._paneContainer.addChild(this._currentPane);
            this._currentPane.x = 25;
            this._currentPane.y = 42;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc2_);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "frameResponse"));
         this._bar.getBuyBtn().addEventListener("click",$.bind(this, "onBuyClick"),false,10);
         this._bar.getSellGoodsBtn().addEventListener("click",$.bind(this, "onSellGoodsClick"),false,10);
         this._bar.getSellPetBtn().addEventListener("click",$.bind(this, "__onSellPetClick"),false,10);
         this._bar.getRecordBtn().addEventListener("click",$.bind(this, "onRecordClick"),false,10);
         this._help.addEventListener("click",$.bind(this, "__helpClick"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "frameResponse"));
         this._bar.getBuyBtn().removeEventListener("click",$.bind(this, "onBuyClick"));
         this._bar.getSellGoodsBtn().removeEventListener("click",$.bind(this, "onSellGoodsClick"));
         this._bar.getSellPetBtn().removeEventListener("click",$.bind(this, "__onSellPetClick"));
         this._bar.getRecordBtn().removeEventListener("click",$.bind(this, "onRecordClick"));
         this._help.removeEventListener("click",$.bind(this, "__helpClick"));
      }
    __helpClick(param1) {
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._bar.getSelectedBtn() == this._bar.getSellPetBtn())
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.auctionHelperFrame");
            _loc2_.helpHtmlText = "AuctionFrame.helpPet";
         }
         else
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.auctionHelperFrame");
         }
         _loc2_.show(2);
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
    onBuyClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._bar.getSelectedBtn() == this._bar.getBuyBtn())
         {
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.clear();
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.currentModulIndex = 0;
         var _loc2_ = new ($.C("auction.view.AuctionBuyPane"))();
         this.showPane(_loc2_);
         _loc2_.getSearchControl().restoreListTitle();
      }
    onSellGoodsClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._bar.getSelectedBtn() == this._bar.getSellGoodsBtn())
         {
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.clear();
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.currentModulIndex = 1;
         this.showPane(new ($.C("auction.view.AuctionSellPane"))(1));
         $.C("mediator.AuctionMessageSender").sendMyAuctionListReq(1,9,1);
      }
    __onSellPetClick(param1) {
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this.thaneInfo.grades < 50)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",50);
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            param1.stopImmediatePropagation();
            return;
         }
         if(this._bar.getSelectedBtn() == this._bar.getSellPetBtn())
         {
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.clear();
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.currentModulIndex = 1;
         this.showPane(new ($.C("auction.view.AuctionSellPane"))(2));
         $.C("mediator.AuctionMessageSender").sendMyAuctionListReq(1,9,1);
      }
    onRecordClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._bar.getSelectedBtn() == this._bar.getRecordBtn())
         {
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.clear();
         $.C("yishi.manager.FrameControllerManager").instance.auctionController.model.currentModulIndex = 2;
         this.showPane(new ($.C("auction.view.AuctionRecordPane"))());
         $.C("mediator.AuctionMessageSender").sendMyAuctionListHistoryReq(1,9,1);
      }
    frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    get thaneInfo() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._paneBack);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._border);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bar);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentPane);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._help);
         this._bar = null;
         this._currentPane = null;
         $.C("auction.view.sell.AuctionGoodMoveControl").dispose();
         super.dispose();
      }
    set thaneInfo(v) { super.thaneInfo = v; }
    set groups(v) { super.groups = v; }
  }
  $.meta(__AuctionFrame, "auction.view.AuctionFrame", []);
  return __AuctionFrame;
}
deps["auction.view.AuctionFrame"] = ["auction.view.AuctionBuyPane", "auction.view.AuctionRecordPane", "auction.view.AuctionSellPane", "auction.view.AuctionTopBar", "auction.view.sell.AuctionGoodMoveControl", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "mediator.AuctionMessageSender", "yishi.keyboard.KeyBoardRegister", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["auction.view.AuctionRecordPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionRecordPane extends __Base {
    static $fields(self) {
    self._resultPane = null;
    }
    constructor() {
         super();
         this._resultPane = new ($.C("auction.view.record.AuctionRecordResultPane"))();
         this.addChild(this._resultPane);
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resultPane);
         this._resultPane = null;
      }
  }
  $.meta(__AuctionRecordPane, "auction.view.AuctionRecordPane", ["Disposeable"]);
  return __AuctionRecordPane;
}
deps["auction.view.AuctionRecordPane"] = ["auction.view.record.AuctionRecordResultPane", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["auction.view.AuctionSellPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionSellPane extends __Base {
    static $fields(self) {
    self._sellPane = null;
    self._resultPane = null;
    self._type = 0;
    }
    constructor(param1 = 1) {
         $.pre(new.target, (__s) => {
         __s._type = param1;
         });
         super();
         $.preFlush(this, new.target);
         this.init();
      }
    init() {
         this._sellPane = new ($.C("auction.view.sell.AuctionSellSubmitPane"))();
         this._sellPane.x = 1;
         this._sellPane.y = 1;
         this.addChild(this._sellPane);
         this._resultPane = new ($.C("auction.view.sell.AuctionSellResultPane"))(this._type);
         this._resultPane.x = 222;
         this._resultPane.y = 1;
         this.addChild(this._resultPane);
         $.C("auction.view.sell.AuctionGoodMoveControl").isFirstOpenSellPane = true;
         $.C("auction.view.sell.AuctionGoodMoveControl").init(this._sellPane.getGoodCell(),this._resultPane.getBagPane(),this._sellPane);
         this.addHandler();
      }
    addHandler() {
         this._sellPane.getCellItem().addEventListener("interactive_click",$.bind(this, "_InteractiveEventHandler"),false,100);
         this._sellPane.getCellItem().addEventListener("interactive_double_click",$.bind(this, "_InteractiveEventHandler"));
      }
    _InteractiveEventHandler(param1) {
         this.openBag();
      }
    openBag() {
         this._resultPane.openBag();
      }
    dispose() {
         this._sellPane.getCellItem().removeEventListener("interactive_click",$.bind(this, "_InteractiveEventHandler"));
         this._sellPane.getCellItem().removeEventListener("interactive_double_click",$.bind(this, "_InteractiveEventHandler"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sellPane);
         this._sellPane = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resultPane);
         this._resultPane = null;
      }
  }
  $.meta(__AuctionSellPane, "auction.view.AuctionSellPane", ["Disposeable"]);
  return __AuctionSellPane;
}
deps["auction.view.AuctionSellPane"] = ["auction.view.sell.AuctionGoodMoveControl", "auction.view.sell.AuctionSellResultPane", "auction.view.sell.AuctionSellSubmitPane", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["auction.view.AuctionTopBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionTopBar extends __Base {
    static $fields(self) {
    self._back = null;
    self._group = null;
    self._buyBtn = null;
    self._sellGoodsBtn = null;
    self._sellPetBtn = null;
    self._recordBtn = null;
    self._limitBtn = null;
    }
    constructor() {
         super();
         this.init();
      }
    init() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.TopBarBackBMD.MutipleImage");
         this.addChild(this._back);
         this._group = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._buyBtn = this.addBtn("auction.bar.buyBtn");
         this._sellGoodsBtn = this.addBtn("auction.bar.sellBtn");
         this._recordBtn = this.addBtn("auction.bar.recordBtn");
         this._limitBtn = this.addBtn("auction.bar.limitBtn");
         this._limitBtn.enable = false;
         this._sellPetBtn = this.addBtn("auction.bar.sellPetBtn");
         var _loc1_ = $.int($.C("yishi.manager.ArmyManager").instance.thane.grades);
         if(_loc1_ < 50)
         {
            this._sellPetBtn.enable = false;
         }
      }
    addBtn(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param1);
         this._group.addSelectItem(_loc2_);
         this.addChild(_loc2_);
         return _loc2_;
      }
    initIndex() {
         this._group.selectIndex = 0;
      }
    getBuyBtn() {
         return this._buyBtn;
      }
    getSellGoodsBtn() {
         return this._sellGoodsBtn;
      }
    getRecordBtn() {
         return this._recordBtn;
      }
    getLimitBtn() {
         return this._limitBtn;
      }
    getSellPetBtn() {
         return this._sellPetBtn;
      }
    getSelectedBtn() {
         return this._group.getSelectedItem();
      }
    dispose() {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this._back.dispose();
         this._back = null;
         this._group.dispose();
         this._group = null;
         this._buyBtn.dispose();
         this._buyBtn = null;
         this._sellGoodsBtn.dispose();
         this._sellGoodsBtn = null;
         this._recordBtn.dispose();
         this._recordBtn = null;
         this._limitBtn.dispose();
         this._limitBtn = null;
      }
  }
  $.meta(__AuctionTopBar, "auction.view.AuctionTopBar", ["Disposeable"]);
  return __AuctionTopBar;
}
deps["auction.view.AuctionTopBar"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.SelectedButtonGroup", "flash.display.Sprite", "yishi.manager.ArmyManager"];

defs["auction.view.buy.AuctionBuyBottomBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionBuyBottomBar extends __Base {
    static $fields(self) {
    self._diamondBack = null;
    self._diamondTxt = null;
    self._pageControl = null;
    self._auctionBtn = null;
    self._fixedPriceBtn = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._diamondBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.diamondBackImg1");
         this._diamondTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.DiamondTxt1");
         this._pageControl = new ($.C("auction.view.common.AuctionPageControlComponent"))();
         this._pageControl.x = 211;
         this._pageControl.y = 10;
         this._pageControl.update($.C("yishi.manager.FrameControllerManager").instance.auctionController.model.forSaleList);
         this._auctionBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.auctionBtn");
         this._fixedPriceBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.fixedPriceBtn");
         this.addChild(this._diamondBack);
         this.addChild(this._diamondTxt);
         this.addChild(this._pageControl);
         this.addChild(this._auctionBtn);
         this.addChild(this._fixedPriceBtn);
         var _loc1_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
         _loc1_.addEventListener("POINT_CHANGE",$.bind(this, "onPointChanged"),false,0,true);
         this.onPointChanged(null);
      }
    onPointChanged(param1) {
         this._diamondTxt.text = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point + "";
      }
    getAuctionBtn() {
         return this._auctionBtn;
      }
    getFixedPriceBtn() {
         return this._fixedPriceBtn;
      }
    getPageControlComp() {
         return this._pageControl;
      }
    dispose() {
         var _loc1_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
         _loc1_.removeEventListener("POINT_CHANGE",$.bind(this, "onPointChanged"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._pageControl = null;
         this._diamondBack = null;
         this._diamondTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__AuctionBuyBottomBar, "auction.view.buy.AuctionBuyBottomBar", ["Disposeable"]);
  return __AuctionBuyBottomBar;
}
deps["auction.view.buy.AuctionBuyBottomBar"] = ["auction.view.common.AuctionPageControlComponent", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager"];

defs["auction.view.buy.AuctionBuyResultPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionBuyResultPane extends __Base {
    static $fields(self) {
    self._border = null;
    self._listTitle = null;
    self._listComponent = null;
    self._bottomBar = null;
    self._corner1 = null;
    self._corner2 = null;
    self._corner3 = null;
    self._corner4 = null;
    self._data = null;
    self._inputFrame = null;
    }
    constructor() {
         super();
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.auctionController.model;
         this._data = _loc1_.forSaleList;
         this.init();
         this.addHandler();
      }
    init() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.buy.resultBack");
         this.addChild(this._border);
         var _loc1_ = $.C("auction.view.common.AuctionListColWidthConst").short;
         var _loc2_ = $.C("auction.view.common.AuctionListColWidthConst").shortX;
         this._listTitle = new ($.C("auction.view.common.AuctionListTitleComponent"))("auction.listTitleBmdS",_loc1_,_loc2_);
         this._listTitle.x = 1;
         this._listTitle.y = 1;
         this.addChild(this._listTitle);
         this._listComponent = new ($.C("auction.view.common.AuctionListComponent"))($.C("auction.view.common.AuctionListItem1"),7,-3);
         this._listComponent.setData(this._data.getList());
         this._listComponent.x = 3;
         this._listComponent.y = 31;
         this._listComponent.callBack = $.bind(this, "auction");
         this.addChild(this._listComponent);
         this._bottomBar = new ($.C("auction.view.buy.AuctionBuyBottomBar"))();
         this._bottomBar.x = 3;
         this._bottomBar.y = 321;
         this.addChild(this._bottomBar);
         this._corner1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.buyCorner1");
         this._corner2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.buyCorner2");
         this._corner3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.buyCorner3");
         this._corner4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.buyCorner4");
         this.addChild(this._corner1);
         this.addChild(this._corner2);
         this.addChild(this._corner3);
         this.addChild(this._corner4);
      }
    addHandler() {
         this._data.addEventListener("change",$.bind(this, "onListDataChange"));
         this._bottomBar.getAuctionBtn().addEventListener("click",$.bind(this, "onAuctionClick"));
         this._bottomBar.getFixedPriceBtn().addEventListener("click",$.bind(this, "onFixedPriceClick"));
      }
    get listTitle() {
         return this._listTitle;
      }
    onListDataChange(param1) {
         this._listComponent.setData(this._data.getList());
      }
    onAuctionClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.auction();
      }
    auction() {
         var _loc1_ = this._listComponent.getSelectedItemData();
         if(_loc1_)
         {
            if(!$.C("auction.view.common.AuctionChecker").checkAuction(_loc1_))
            {
               return;
            }
            this._inputFrame = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionInputFrame");
            this._inputFrame.setData(_loc1_);
            this._inputFrame.backCall = $.bind(this, "inputPriceCallback");
            this._inputFrame.show();
         }
         else
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.PleaseSelectGood"));
         }
      }
    inputPriceCallback(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc7_ = null;
         var _loc8_ = null;
         var _loc9_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc2_ = null;
         var _loc10_ = null;
         var _loc4_ = null;
         var _loc3_ = this._listComponent.getSelectedItemData();
         if(param1 == _loc3_.currPrice)
         {
            if(!_loc3_.auctioned)
            {
               $.C("mediator.AuctionMessageSender").sendAuctionGoods(_loc3_.goodId,param1);
               return;
            }
         }
         if(param1 <= _loc3_.currPrice)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [];
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc9_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("Action.UnderCurrentPrice");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc9_,_loc5_,_loc7_,"",true,false,false,2);
         }
         else if(param1 >= _loc3_.fixedPrice)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "isFixedBuy"),_loc3_.goodId,_loc3_.fixedPrice];
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc10_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("Action.OuterFixedPrice");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc10_,_loc4_,_loc6_,_loc2_,true,false,false,2);
         }
         else
         {
            $.C("mediator.AuctionMessageSender").sendAuctionGoods(_loc3_.goodId,param1);
         }
      }
    isFixedBuy(param1, param2, param3, param4) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if(param1)
         {
            $.C("mediator.AuctionMessageSender").sendFixPriceItemMessage(param3,param4);
         }
      }
    onFixedPriceClick(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc4_ = this._listComponent.getSelectedItemData();
         if(_loc4_)
         {
            if(!$.C("auction.view.common.AuctionChecker").checkFixPrice(_loc4_))
            {
               return;
            }
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "fixedPriceBuy"),_loc4_.goodId,_loc4_.fixedPrice];
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("Auction.FixedPriceBuy");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2);
         }
         else
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.PleaseSelectGood"));
         }
      }
    fixedPriceBuy(param1, param2, param3, param4) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if(param1)
         {
            $.C("mediator.AuctionMessageSender").sendFixPriceItemMessage(param3,param4);
         }
      }
    getBottomBar() {
         return this._bottomBar;
      }
    dispose() {
         this._data.removeEventListener("change",$.bind(this, "onListDataChange"));
         this._bottomBar.getAuctionBtn().removeEventListener("click",$.bind(this, "onAuctionClick"));
         this._bottomBar.getFixedPriceBtn().removeEventListener("click",$.bind(this, "onFixedPriceClick"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._inputFrame)
         {
            this._inputFrame.dispose();
            this._inputFrame = null;
         }
      }
    set listTitle(v) { super.listTitle = v; }
  }
  $.meta(__AuctionBuyResultPane, "auction.view.buy.AuctionBuyResultPane", ["Disposeable"]);
  return __AuctionBuyResultPane;
}
deps["auction.view.buy.AuctionBuyResultPane"] = ["auction.view.AuctionAlert", "auction.view.buy.AuctionBuyBottomBar", "auction.view.common.AuctionChecker", "auction.view.common.AuctionListColWidthConst", "auction.view.common.AuctionListComponent", "auction.view.common.AuctionListItem1", "auction.view.common.AuctionListTitleComponent", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "mediator.AuctionMessageSender", "yishi.manager.FrameControllerManager", "yishi.utils.SimpleAlertHelper"];

defs["auction.view.buy.AuctionCategoryItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionCategoryItem extends __Base {
    static $fields(self) {
    self._titleBtn = null;
    self._subContent = null;
    self._selected = false;
    self._height = 31;
    self._vo = null;
    self._tipTxt = null;
    }
    constructor() {
         super();
      }
    setData(param1, param2) {
         this._vo = param1;
         this._titleBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("asset.auction.CategoryBigItemBtn" + (param1.Type + 1));
         this.addChild(this._titleBtn);
         if(param2 && param2.length > 0)
         {
            this._subContent = new ($.C("auction.view.buy.AuctionCategorySubComp"))();
            this._subContent.x = 0;
            this._subContent.y = 35;
            this._subContent.setData(param2);
         }
         this._tipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("AuctionCategoryPane.OpenPetTipTxt");
         this.addChild(this._tipTxt);
      }
    enableAndShowTip(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._tipTxt.text = param1;
         this._titleBtn.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         this._subContent.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         this.mouseEnabled = this.mouseChildren = false;
      }
    set selected(param1) {
         this._titleBtn.selected = this._selected;
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         this._titleBtn.selected = this._selected;
         if(this._selected)
         {
            if(this._subContent)
            {
               if(!this._subContent.parent)
               {
                  this.addChild(this._subContent);
               }
               this._subContent.setSelectByIndex(0);
               this.changeHeight(true);
            }
         }
         else if(this._subContent && this._subContent.parent)
         {
            this.removeChild(this._subContent);
            this.changeHeight(false);
         }
      }
    changeHeight(param1) {
         if(!param1)
         {
            this._height = 31;
         }
         else
         {
            this._height = super.height;
         }
         var _loc2_ = new ($.C("flash.utils.Dictionary"))();
         _loc2_["height"] = true;
         this.dispatchEvent(new ($.C("com.pickgliss.events.ComponentEvent"))("propertiesChanged",_loc2_));
      }
    get height() {
         return this._height;
      }
    get selected() {
         return this._selected;
      }
    getData() {
         return this._vo;
      }
    getSubSelectedVo() {
         if(this._subContent)
         {
            if(this._subContent.getSelectItem())
            {
               return this._subContent.getSelectItem().getData();
            }
         }
         return null;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleBtn);
         this._titleBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._subContent);
         this._subContent = null;
         if(this._tipTxt)
         {
            this._tipTxt.dispose();
         }
         this._tipTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set height(v) { super.height = v; }
  }
  $.meta(__AuctionCategoryItem, "auction.view.buy.AuctionCategoryItem", ["Disposeable"]);
  return __AuctionCategoryItem;
}
deps["auction.view.buy.AuctionCategoryItem"] = ["auction.view.buy.AuctionCategorySubComp", "com.pickgliss.events.ComponentEvent", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Dictionary", "yishi.filter.UIFilter"];

defs["auction.view.buy.AuctionCategoryPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionCategoryPane extends __Base {
    static $fields(self) {
    self._scrollPane = null;
    self._border = null;
    self._corner1 = null;
    self._corner2 = null;
    self._corner3 = null;
    self._corner4 = null;
    self._itemBox = null;
    self._data = null;
    self._selectedItem = null;
    self._xml = null;
    }
    constructor() {
         super();
         this._xml = new $.XML($.C("manager.LanguageMgr").GetTranslation("AuctionCategoryPane.xml"));
         this.initData(this._xml);
         this.initView();
         this.createView();
      }
    initView() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.buy.categoryBack");
         this.addChild(this._border);
         this._itemBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._itemBox.spacing = 2;
         this._scrollPane = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.search.Scroll");
         this._scrollPane.setView(this._itemBox);
         this.addChild(this._scrollPane);
         this._corner1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.categoryCorner1");
         this._corner2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.categoryCorner2");
         this._corner3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.categoryCorner3");
         this._corner4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.categoryCorner4");
         this.addChild(this._corner1);
         this.addChild(this._corner2);
         this.addChild(this._corner3);
         this.addChild(this._corner4);
      }
    initData(param1) {
         var _loc4_ = null;
         var _loc6_ = 0;
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc7_ = 0;
         this._data = [];
         this._data.push([]);
         this._data.push([]);
         var _loc5_ = param1.$descendants("Menu");
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc4_ = $.as(_loc5_[_loc6_], "XML");
            this._data[0].push(this.createMemberVo(_loc4_));
            _loc3_ = _loc4_.MenuItem;
            _loc2_ = [];
            this._data[1][_loc6_] = _loc2_;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length())
            {
               _loc4_ = $.as(_loc3_[_loc7_], "XML");
               _loc2_.push(this.createMemberVo(_loc4_));
               _loc7_++;
            }
            _loc6_++;
         }
      }
    createMemberVo(param1) {
         var _loc2_ = new ($.C("mvc.module.auction.CategoryVO"))();
         _loc2_.MenuName = param1["@MenuName"];
         _loc2_.Type = $.int(param1["@Type"]);
         return _loc2_;
      }
    createView() {
         var _loc3_ = null;
         var _loc5_ = 0;
         var _loc2_ = null;
         var _loc1_ = this._data[0];
         var _loc4_ = $.int($.C("yishi.manager.ArmyManager").instance.thane.grades);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc3_ = new ($.C("auction.view.buy.AuctionCategoryItem"))();
            _loc3_.setData(_loc1_[_loc5_],this._data[1][_loc5_]);
            _loc3_.addEventListener("click",$.bind(this, "onItemClick"),false,0,true);
            this._itemBox.addChild(_loc3_);
            if(_loc1_[_loc5_].Type == 4 && _loc4_ < 50)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("armyII.SkillFrame.AlertMsg",50);
               _loc3_.enableAndShowTip(_loc2_);
            }
            _loc5_++;
         }
         this.selectItem($.cast($.C("auction.view.buy.AuctionCategoryItem"), this._itemBox.getChildAt(0)));
      }
    onItemClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.selectItem($.as(param1.currentTarget, $.C("auction.view.buy.AuctionCategoryItem")));
      }
    selectItem(param1) {
         if(this._selectedItem == param1)
         {
            this.dispatchEvent(new ($.C("flash.events.Event"))("select"));
            this._selectedItem.selected = true;
            return;
         }
         if(this._selectedItem)
         {
            this._selectedItem.selected = false;
         }
         this._selectedItem = param1;
         this._selectedItem.selected = true;
         this._scrollPane.invalidateViewport();
         this.dispatchEvent(new ($.C("flash.events.Event"))("select"));
      }
    getFirstCategoryType() {
         if(this._selectedItem)
         {
            return this._selectedItem.getData().Type;
         }
         return 0;
      }
    getSecondCategoryType() {
         if(this._selectedItem && this._selectedItem.getSubSelectedVo())
         {
            return this._selectedItem.getSubSelectedVo().Type;
         }
         return 0;
      }
    dispose() {
         var _loc1_ = null;
         while(this._itemBox.numChildren > 0)
         {
            _loc1_ = $.as(this._itemBox.getChildAt(0), $.C("auction.view.buy.AuctionCategoryItem"));
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_.removeEventListener("click",$.bind(this, "onItemClick"));
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
  }
  $.meta(__AuctionCategoryPane, "auction.view.buy.AuctionCategoryPane", ["Disposeable"]);
  return __AuctionCategoryPane;
}
deps["auction.view.buy.AuctionCategoryPane"] = ["auction.view.buy.AuctionCategoryItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.events.Event", "manager.LanguageMgr", "mvc.module.auction.CategoryVO", "yishi.manager.ArmyManager"];

defs["auction.view.buy.AuctionCategorySubComp"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionCategorySubComp extends __Base {
    static $fields(self) {
    self._data = null;
    self._items = null;
    self._selectedItem = null;
    self._vBox = null;
    }
    constructor() {
         super();
      }
    setData(param1) {
         this._data = param1;
         this.buildView();
      }
    buildView() {
         var _loc1_ = null;
         var _loc2_ = 0;
         if(this._data && this._data.length > 0)
         {
            this._items = [];
            this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
            this.addChild(this._vBox);
            _loc2_ = 0;
            while(_loc2_ < this._data.length)
            {
               _loc1_ = new ($.C("auction.view.buy.AuctionCategorySubItem"))();
               _loc1_.setData(this._data[_loc2_]);
               this._vBox.addChild(_loc1_);
               this._items.push(_loc1_);
               _loc1_.addEventListener("click",$.bind(this, "onItemClick"));
               if(_loc2_ < this._data.length - 1)
               {
                  this._vBox.addChild(this.createLine());
               }
               _loc2_++;
            }
         }
      }
    onItemClick(param1) {
         if(this._selectedItem == param1.currentTarget)
         {
            this._selectedItem.selected = true;
            this.dispatchEvent(new ($.C("flash.events.Event"))("select"));
            return;
         }
         this.setSelectItem($.as(param1.currentTarget, $.C("auction.view.buy.AuctionCategorySubItem")));
         this.dispatchEvent(new ($.C("flash.events.Event"))("select"));
      }
    createLine() {
         return $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.CategorySmallItemLine");
      }
    setSelectByIndex(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         if(this._items && this._items.length > param1)
         {
            _loc2_ = this._items[param1];
            this.setSelectItem(_loc2_);
         }
      }
    setSelectItem(param1) {
         if(!param1)
         {
            return;
         }
         if(this._selectedItem)
         {
            this._selectedItem.selected = false;
         }
         this._selectedItem = param1;
         this._selectedItem.selected = true;
      }
    getLength() {
         if(this._items)
         {
            return this._items.length;
         }
         return 0;
      }
    getSelectItem() {
         return this._selectedItem;
      }
    clear() {
         for (var _loc1_ of $.values(this._items))
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._items = null;
      }
    dispose() {
         this.clear();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectedItem);
         this._selectedItem = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         this._data = null;
      }
  }
  $.meta(__AuctionCategorySubComp, "auction.view.buy.AuctionCategorySubComp", ["Disposeable"]);
  return __AuctionCategorySubComp;
}
deps["auction.view.buy.AuctionCategorySubComp"] = ["auction.view.buy.AuctionCategorySubItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.events.Event"];

defs["auction.view.buy.AuctionCategorySubItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionCategorySubItem extends __Base {
    static $fields(self) {
    self._selectedBtn = null;
    self._arrow = null;
    self._data = null;
    }
    constructor() {
         super();
         this._selectedBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.categorySubBtn");
         this.addChild(this._selectedBtn);
         this._arrow = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.CategorySmallItemArrow");
         this.addChild(this._arrow);
      }
    setData(param1) {
         this._data = param1;
         this._selectedBtn.setText(param1.MenuName);
      }
    getData() {
         return this._data;
      }
    get selected() {
         return this._selectedBtn.selected;
      }
    set selected(param1) {
         this._selectedBtn.selected = param1;
      }
    get height() {
         return 27;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    set height(v) { super.height = v; }
  }
  $.meta(__AuctionCategorySubItem, "auction.view.buy.AuctionCategorySubItem", []);
  return __AuctionCategorySubItem;
}
deps["auction.view.buy.AuctionCategorySubItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["auction.view.buy.AuctionSearchControl"] = function define($) {
  const __Base = $.Object;
  class __AuctionSearchControl extends __Base {
    static $fields(self) {
    self._searchPane = null;
    self._categoryPane = null;
    self._pageControl = null;
    self._resultPane = null;
    self._recordDic = new ($.C("flash.utils.Dictionary"))();
    self._currentOrderBy = 0;
    self._currentOrderType = 0;
    }
    constructor(param1, param2, param3, param4) {
         super();
         this._searchPane = param1;
         this._categoryPane = param2;
         this._pageControl = param3;
         this._resultPane = param4;
         this.addHandler();
      }
    addHandler() {
         this._searchPane.searchBtn.addEventListener("click",$.bind(this, "onSearchBtnClick"));
         this._searchPane.nameInput.addEventListener("keyDown",$.bind(this, "__onkeyDownHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("AUCTION_HOT_SEARCH",$.bind(this, "__hotSearchHandler"));
         this._pageControl.getNextBtn().addEventListener("click",$.bind(this, "searchNextPage"));
         this._pageControl.getPreBtn().addEventListener("click",$.bind(this, "searchPrevPage"));
         this._resultPane.listTitle.titleGrade.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._resultPane.listTitle.titleTime.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._resultPane.listTitle.titlePrice.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._resultPane.listTitle.titleCurPrice.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._categoryPane.addEventListener("select",$.bind(this, "onCategoryChanged"));
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.auctionController.model;
         _loc1_.addEventListener($.C("events.AuctionEvent").REFRESH_FORSELL,$.bind(this, "onRefreshEvent"));
      }
    __onkeyDownHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(param1.charCode == 13)
         {
            this.restoreListTitle();
            this.search();
         }
      }
    __hotSearchHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.as(param1.data, "String");
         this.restoreListTitle(_loc2_);
         this.search(1,0,0,_loc2_);
      }
    onRefreshEvent(param1) {
         this.search(this._pageControl.getData().currentPage,this._currentOrderBy,this._currentOrderType);
      }
    search(param1 = 1, param2 = 0, param3 = 0, param4 = null) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         var _loc6_ = null;
         var _loc5_ = new ($.C("com.road.yishi.proto.mall.SearchItemReqMsg"))();
         if(this._recordDic && this._recordDic["name"])
         {
            _loc5_.itemName = this._recordDic["name"];
         }
         else
         {
            _loc5_.itemName = "";
         }
         if(param4)
         {
            _loc5_.itemName = param4;
         }
         _loc6_ = this._recordDic["grade"];
         if(_loc6_ && _loc6_.id != 0)
         {
            _loc5_.minLevel = _loc6_.min;
            _loc5_.maxLevel = _loc6_.max;
         }
         _loc6_ = this._recordDic["quality"];
         if(_loc6_ && _loc6_.id != 0)
         {
            _loc5_.quality = _loc6_.id;
         }
         _loc6_ = this._recordDic["job"];
         if(_loc6_ && _loc6_.id != 0)
         {
            _loc5_.job = _loc6_.id;
         }
         if(this._recordDic["type"] != 0)
         {
            _loc5_.type = this._recordDic["type"];
            if(this._recordDic["sonType"] != 0)
            {
               _loc5_.sonType = this._recordDic["sonType"];
            }
         }
         _loc5_.usable = this._recordDic["usable"] ? true : false;
         _loc5_.page = param1;
         _loc5_.orderBy = param2;
         _loc5_.orderType = param3;
         $.C("mediator.AuctionMessageSender").search(_loc5_);
      }
    onSearchBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.restoreListTitle();
         this.search();
      }
    recordSearchData(param1 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = $.C("yishi.utils.StringUtil").trim(this._searchPane.nameInput.text);
         if(_loc2_ && _loc2_ != "" && this._searchPane.nameTextClicked)
         {
            this._recordDic["name"] = _loc2_;
         }
         else
         {
            this._recordDic["name"] = "";
         }
         if(param1)
         {
            this._recordDic["name"] = param1;
         }
         this._recordDic["grade"] = this._searchPane.gradeCombo.currentSelectedCellValue;
         this._recordDic["quality"] = this._searchPane.qualityCombo.currentSelectedCellValue;
         this._recordDic["job"] = this._searchPane.jobCombo.currentSelectedCellValue;
         this._recordDic["usable"] = this._searchPane.availableCheckBtn.selected;
         this._recordDic["type"] = this._categoryPane.getFirstCategoryType();
         this._recordDic["sonType"] = this._categoryPane.getSecondCategoryType();
      }
    searchNextPage(param1) {
         this.search(this._pageControl.getData().currentPage + 1,this._currentOrderBy,this._currentOrderType);
      }
    searchPrevPage(param1) {
         this.search(this._pageControl.getData().currentPage - 1,this._currentOrderBy,this._currentOrderType);
      }
    onCategoryChanged(param1) {
         this.restoreListTitle();
      }
    restoreListTitle(param1 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._currentOrderBy = this._currentOrderType = 0;
         this._resultPane.listTitle.currentSelectBut(null);
         this.recordSearchData(param1);
         this.search();
      }
    __onTitleClick(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("com.pickgliss.ui.controls.TitleButton"));
         switch(_loc2_)
         {
            case this._resultPane.listTitle.titleGrade:
               this._currentOrderBy = 1;
               break;
            case this._resultPane.listTitle.titleTime:
               this._currentOrderBy = 2;
               break;
            case this._resultPane.listTitle.titlePrice:
               this._currentOrderBy = 4;
               break;
            case this._resultPane.listTitle.titleCurPrice:
               this._currentOrderBy = 3;
         }
         if(this._resultPane.listTitle.currentSelectBut(_loc2_) == 2)
         {
            this._currentOrderType = 1;
         }
         else
         {
            this._currentOrderType = 2;
         }
         this.search(1,this._currentOrderBy,this._currentOrderType);
      }
    dispose() {
         this._currentOrderBy = this._currentOrderType = 0;
         this._resultPane.listTitle.currentSelectBut(null);
         this._searchPane.searchBtn.removeEventListener("click",$.bind(this, "onSearchBtnClick"));
         this._searchPane.nameInput.removeEventListener("keyDown",$.bind(this, "__onkeyDownHandler"));
         this._pageControl.getNextBtn().removeEventListener("click",$.bind(this, "searchNextPage"));
         this._pageControl.getPreBtn().removeEventListener("click",$.bind(this, "searchPrevPage"));
         this._resultPane.listTitle.titleGrade.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._resultPane.listTitle.titleTime.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._resultPane.listTitle.titlePrice.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._resultPane.listTitle.titleCurPrice.removeEventListener("click",$.bind(this, "__onTitleClick"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("AUCTION_HOT_SEARCH",$.bind(this, "__hotSearchHandler"));
         this._categoryPane.removeEventListener("select",$.bind(this, "onCategoryChanged"));
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.auctionController.model;
         _loc1_.removeEventListener($.C("events.AuctionEvent").REFRESH_FORSELL,$.bind(this, "onRefreshEvent"));
      }
  }
  $.meta(__AuctionSearchControl, "auction.view.buy.AuctionSearchControl", []);
  return __AuctionSearchControl;
}
deps["auction.view.buy.AuctionSearchControl"] = ["com.pickgliss.ui.controls.TitleButton", "com.pickgliss.utils.SoundManager", "com.road.yishi.proto.mall.SearchItemReqMsg", "events.AuctionEvent", "flash.utils.Dictionary", "mediator.AuctionMessageSender", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.utils.StringUtil"];

defs["auction.view.buy.AuctionSearchPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionSearchPane extends __Base {
    static $fields(self) {
    self._nameLabel = null;
    self._nameInputBack = null;
    self.nameInput = null;
    self._gradeLabel = null;
    self.gradeCombo = null;
    self._qualityLabel = null;
    self.qualityCombo = null;
    self._jobLabel = null;
    self.jobCombo = null;
    self.availableCheckBtn = null;
    self._availableLabel = null;
    self.searchBtn = null;
    self.resetBtn = null;
    self.nameTextClicked = false;
    self._hotSearchImage = null;
    self._hotSearchList = null;
    self._txtChange = "";
    }
    constructor() {
         super();
         this.initView();
         this.initData();
         this.addEvent();
         this.refreshResetBtnState();
      }
    initView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._nameLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.searchNameLabelBMD");
         this._nameInputBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.searchNameInputBackBMD");
         this.nameInput = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.searchInputTxt");
         this._gradeLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.searchGradeLabelBMD");
         this._qualityLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.searchQualityLabelBMD");
         this._jobLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.searchJobLabelBMD");
         this._availableLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.searchAvailableLabelBMD");
         this.resetBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.search.resetBtn");
         this.searchBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.search.searchBtn");
         this.availableCheckBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.search.availableBtn");
         this.gradeCombo = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.SearchGradeComboBox");
         this.qualityCombo = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.SearchQualityComboBox");
         this.jobCombo = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.SearchJobComboBox");
         this._hotSearchImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.hotSearchImage");
         this._nameInputBack.x = 44.5;
         this._nameInputBack.y = 5.25;
         this.addChild(this._nameLabel);
         this.addChild(this._nameInputBack);
         this.addChild(this.nameInput);
         this.nameInput.textField.maxChars = 16;
         this.nameInput.textField.wordWrap = false;
         this.nameInput.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.EnterGoodName");
         this.gradeCombo.textField.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.PleaseSelect");
         this.qualityCombo.textField.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.PleaseSelect");
         this.jobCombo.textField.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.PleaseSelect");
         this.addChild(this._gradeLabel);
         this.addChild(this._qualityLabel);
         this.addChild(this._jobLabel);
         this.addChild(this._availableLabel);
         this.addChild(this.resetBtn);
         this.addChild(this.searchBtn);
         this.addChild(this.availableCheckBtn);
         this.addChild(this.gradeCombo);
         this.addChild(this.qualityCombo);
         this.addChild(this.jobCombo);
         this.addChild(this._hotSearchImage);
         this._hotSearchList = new $.Vector();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new ($.C("auction.view.buy.HotSearchItem"))();
            _loc1_.index = _loc2_;
            this.addChild(_loc1_);
            this._hotSearchList.push(_loc1_);
            if(_loc2_ == 0)
            {
               _loc1_.x = 208;
            }
            else
            {
               _loc1_.x = this._hotSearchList[_loc2_ - 1].x + this._hotSearchList[_loc2_ - 1].displayWidth + 40 + (_loc2_ - 1) * 5;
            }
            _loc1_.y = 31;
            if(_loc2_ == 3 || _loc2_ == 4 || _loc2_ == 5)
            {
               _loc1_.x = this._hotSearchList[_loc2_ - 3].x;
               _loc1_.y = 56;
            }
            _loc2_++;
         }
      }
    initData() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc1_ = $.C("mvc.module.auction.AuctionModel").getGradeComboData();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.gradeCombo.listPanel.vectorListModel.append(_loc1_[_loc2_]);
            _loc2_++;
         }
         _loc1_ = $.C("mvc.module.auction.AuctionModel").getQualityComboData();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.qualityCombo.listPanel.vectorListModel.append(_loc1_[_loc2_]);
            _loc2_++;
         }
         _loc1_ = $.C("mvc.module.auction.AuctionModel").getJobComboData();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.jobCombo.listPanel.vectorListModel.append(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
    addEvent() {
         this.resetBtn.addEventListener("click",$.bind(this, "onResetBtnClick"));
         this.nameInput.addEventListener("change",$.bind(this, "__onTxtChange"));
         this.nameInput.addEventListener("click",$.bind(this, "onNameInputClick"));
         this.nameInput.textField.addEventListener("focusOut",$.bind(this, "outNameInput"));
         this.gradeCombo.addEventListener("stateChange",$.bind(this, "onComboStateChange"));
         this.qualityCombo.addEventListener("stateChange",$.bind(this, "onComboStateChange"));
         this.jobCombo.addEventListener("stateChange",$.bind(this, "onComboStateChange"));
         this.availableCheckBtn.addEventListener("select",$.bind(this, "onAvailableBtnSelect"));
         $.C("yishi.utils.MsgMan").addObserver("ICON_DOUBLE_CLICK",this,$.bind(this, "clickIconHandler"));
      }
    clickIconHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.nameInput.text = $.as(param2, "String");
         this.nameTextClicked = true;
      }
    removeEvent() {
         if(this.resetBtn)
         {
            this.resetBtn.removeEventListener("click",$.bind(this, "onResetBtnClick"));
         }
         if(this.nameInput)
         {
            this.nameInput.removeEventListener("change",$.bind(this, "__onTxtChange"));
            this.nameInput.removeEventListener("click",$.bind(this, "onNameInputClick"));
            if(this.nameInput.textField)
            {
               this.nameInput.textField.removeEventListener("focusOut",$.bind(this, "outNameInput"));
            }
         }
         if(this.gradeCombo)
         {
            this.gradeCombo.removeEventListener("stateChange",$.bind(this, "onComboStateChange"));
         }
         if(this.qualityCombo)
         {
            this.qualityCombo.removeEventListener("stateChange",$.bind(this, "onComboStateChange"));
         }
         if(this.jobCombo)
         {
            this.jobCombo.removeEventListener("stateChange",$.bind(this, "onComboStateChange"));
         }
         if(this.availableCheckBtn)
         {
            this.availableCheckBtn.removeEventListener("select",$.bind(this, "onAvailableBtnSelect"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("ICON_DOUBLE_CLICK",this,$.bind(this, "clickIconHandler"));
      }
    onAvailableBtnSelect(param1) {
         this.refreshResetBtnState();
      }
    onComboStateChange(param1) {
         this.refreshResetBtnState();
         if(param1.target.textField.text != $.C("manager.LanguageMgr").GetTranslation("Auction.Search.PleaseSelect"))
         {
            param1.target.textField.textColor = 15523745;
         }
      }
    outNameInput(param1) {
         if(this.nameInput.text == "")
         {
            this.nameInput.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.EnterGoodName");
            this.nameTextClicked = false;
         }
         this.refreshResetBtnState();
      }
    refreshResetBtnState() {
         if((this.nameInput.text == "" || this.nameTextClicked == false) && !this.gradeCombo.currentSelectedCellValue && !this.qualityCombo.currentSelectedCellValue && !this.jobCombo.currentSelectedCellValue && !this.availableCheckBtn.selected)
         {
            this.resetBtn.enable = false;
         }
         else
         {
            this.resetBtn.enable = true;
         }
      }
    onNameInputClick(param1) {
         if(!this.nameTextClicked)
         {
            this.nameInput.text = "";
            this.nameTextClicked = true;
         }
      }
    onResetBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.nameInput.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.EnterGoodName");
         this.gradeCombo.textField.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.PleaseSelect");
         this.qualityCombo.textField.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.PleaseSelect");
         this.jobCombo.textField.text = $.C("manager.LanguageMgr").GetTranslation("Auction.Search.PleaseSelect");
         this.gradeCombo.listPanel.scrollToTop();
         this.qualityCombo.listPanel.scrollToTop();
         this.jobCombo.listPanel.scrollToTop();
         this.gradeCombo.reset();
         this.qualityCombo.reset();
         this.jobCombo.reset();
         this.availableCheckBtn.selected = false;
         this.nameTextClicked = false;
         this.resetBtn.enable = false;
      }
    __onTxtChange(param1) {
         var _loc2_ = $.int(this.nameInput.text.replace(/[^\x00-\xff]/g,"xx").length);
         if(_loc2_ > 16)
         {
            this.nameInput.text = this._txtChange;
            $.trace(this.nameInput.text,this._txtChange);
         }
         this._txtChange = this.nameInput.text;
         $.trace(this.nameInput.text,this._txtChange);
         if(this.nameInput.text == $.C("manager.LanguageMgr").GetTranslation("Auction.Search.EnterGoodName"))
         {
            this.nameInput.textField.textColor = 8547171;
         }
         else
         {
            this.nameInput.textField.textColor = 15523745;
         }
      }
    cleanList() {
         if(!this._hotSearchList)
         {
            return;
         }
         while(this._hotSearchList.length > 0)
         {
            this._hotSearchList.pop().dispose();
         }
         this._hotSearchList = null;
      }
    dispose() {
         this.removeEvent();
         this.cleanList();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
  }
  $.meta(__AuctionSearchPane, "auction.view.buy.AuctionSearchPane", ["Disposeable"]);
  return __AuctionSearchPane;
}
deps["auction.view.buy.AuctionSearchPane"] = ["auction.view.buy.HotSearchItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.auction.AuctionModel", "yishi.utils.MsgMan"];

defs["auction.view.buy.HotSearchItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __HotSearchItem extends __Base {
    static $fields(self) {
    self._back = null;
    self._iconView = null;
    self._goodsName = null;
    self._sp = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.hotSearchBack");
         this._iconView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.hotSearchItem.IconView");
         this._goodsName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.hotSearchItem.name");
         this._sp = new ($.C("flash.display.Sprite"))();
         this.buttonMode = true;
         if(this._back)
         {
            this.addChild(this._back);
         }
         if(this._iconView)
         {
            this.addChild(this._iconView);
         }
         if(this._goodsName)
         {
            this.addChild(this._goodsName);
         }
         if(this._sp)
         {
            this.addChild(this._sp);
         }
      }
    get displayWidth() {
         return this.width - (this._goodsName.width - this._goodsName.textWidth) + 20;
      }
    set index(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         switch(param1)
         {
            case 0:
               this._iconView.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(2129400);
               this._goodsName.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.buy.HotSearchItem.goodsName0");
               break;
            case 1:
               this._iconView.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(2129003);
               this._goodsName.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.buy.HotSearchItem.goodsName1");
               break;
            case 2:
               this._iconView.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(208014);
               this._goodsName.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.buy.HotSearchItem.goodsName2");
               break;
            case 3:
               this._iconView.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(208012);
               this._goodsName.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.buy.HotSearchItem.goodsName3");
               break;
            case 4:
               this._iconView.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(2130005);
               this._goodsName.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.buy.HotSearchItem.goodsName4");
               break;
            case 5:
               this._iconView.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(2127003);
               this._goodsName.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.buy.HotSearchItem.goodsName5");
         }
         this.setHitArea();
      }
    setHitArea() {
         this._sp.graphics.clear();
         this._sp.graphics.beginFill(0,0);
         this._sp.graphics.drawRect(0,0,this._goodsName.textWidth,this._goodsName.height);
         this._sp.x = this._goodsName.x;
         this._sp.y = this._goodsName.y;
      }
    initEvent() {
         this.addEventListener("click",$.bind(this, "__clickHandler"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__clickHandler"));
      }
    __clickHandler(param1) {
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("AUCTION_HOT_SEARCH",this._goodsName.text));
      }
    dispose() {
         this.removeEvent();
         this._sp = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iconView);
         this._iconView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodsName);
         this._goodsName = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set displayWidth(v) { super.displayWidth = v; }
    get index() { return super.index; }
  }
  $.meta(__HotSearchItem, "auction.view.buy.HotSearchItem", ["Disposeable"]);
  return __HotSearchItem;
}
deps["auction.view.buy.HotSearchItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.events.NotificationEvent", "yishi.manager.NotificationManager", "yishi.utils.IconFactory"];

defs["auction.view.common.AuctionChecker"] = function define($) {
  const __Base = $.Object;
  class __AuctionChecker extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static checkAuction(param1) {
         if(param1.getGoodsInfo().userId == $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.userInfo.userId)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("Auction.AuctionCheckResult1"));
            return false;
         }
         return true;
      }
    static checkFixPrice(param1) {
         if(param1.getGoodsInfo().userId == $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.userInfo.userId)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("Auction.AuctionCheckResult2"));
            return false;
         }
         return true;
      }
  }
  $.meta(__AuctionChecker, "auction.view.common.AuctionChecker", []);
  return __AuctionChecker;
}
deps["auction.view.common.AuctionChecker"] = ["manager.LanguageMgr", "yishi.manager.PlayerManager", "yishi.view.tips.MessageTipManager"];

defs["auction.view.common.AuctionEvent"] = function define($) {
  const __Base = $.Object;
  class __AuctionEvent extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__AuctionEvent, "auction.view.common.AuctionEvent", []);
  $.statics(__AuctionEvent, () => {
    __AuctionEvent.ICON_DOUBLE_CLICK = "ICON_DOUBLE_CLICK";
  });
  return __AuctionEvent;
}
deps["auction.view.common.AuctionEvent"] = [];

defs["auction.view.common.AuctionInputFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __AuctionInputFrame extends __Base {
    static $fields(self) {
    self._alertTxt = null;
    self._inputBack = null;
    self._inputTxt = null;
    self._warmTxt = null;
    self._confirmBtn = null;
    self._cancelBtn = null;
    self._diamondBm = null;
    self._backCall = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("Auction.AuctionTitle");
      }
    set backCall(param1) {
         this._backCall = param1;
      }
    setData(param1) {
         this._data = param1;
      }
    initView() {
         this._alertTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.AuctionPriceLabelBMD");
         this._inputBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionInputBack");
         this._inputTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionInputText");
         this._warmTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionInputWarmText");
         this._confirmBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionConfirmBtn");
         this._cancelBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionCancelBtn");
         this._diamondBm = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.DiamondBigIcon");
         this._diamondBm.x = 251;
         this._diamondBm.y = 11;
         this.addToContent(this._alertTxt);
         this.addToContent(this._inputBack);
         this.addToContent(this._inputTxt);
         this._inputTxt.restrict = "0-9";
         this._inputTxt.maxChars = 9;
         this.addToContent(this._warmTxt);
         this._warmTxt.text = $.C("manager.LanguageMgr").GetTranslation("Auction.EnterAuctionPrice");
         this.addToContent(this._confirmBtn);
         this.addToContent(this._cancelBtn);
         this.addToContent(this._diamondBm);
      }
    initEvent() {
         this._inputTxt.addEventListener("change",$.bind(this, "__onChangeInput"));
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this.addEventListener("addedToStage",$.bind(this, "__onAddedToStage"));
         this._confirmBtn.addEventListener("click",$.bind(this, "__confirmHandler"));
         this._cancelBtn.addEventListener("click",$.bind(this, "__cancelHandler"));
      }
    __onChangeInput(param1) {
         if($.int(this._inputTxt.text) > $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point)
         {
            this._inputTxt.text = "" + $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point;
         }
      }
    removeEvent() {
         if(this._inputTxt)
         {
            this._inputTxt.removeEventListener("change",$.bind(this, "__onChangeInput"));
         }
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         this.removeEventListener("addedToStage",$.bind(this, "__onAddedToStage"));
         this._confirmBtn.removeEventListener("click",$.bind(this, "__confirmHandler"));
         this._cancelBtn.removeEventListener("click",$.bind(this, "__cancelHandler"));
      }
    __onAddedToStage(param1) {
         this.removeEventListener("addedToStage",$.bind(this, "__onAddedToStage"));
         this.stage.focus = this._inputTxt;
      }
    __confirmHandler(param1) {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._backCall != null)
         {
            if(this._inputTxt.text == "")
            {
               $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "confirmAlert")];
               _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
               _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
               _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("Auction.EnterAuctionPrice");
               $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc2_,_loc3_,"",true,false,false,2);
            }
            else
            {
               this._backCall(this._inputTxt.text);
            }
         }
         this.dispose();
      }
    confirmAlert(param1, param2) {
      }
    __cancelHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this.dispose();
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
               break;
            case 2:
               this.__confirmHandler(null);
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         this._backCall = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._inputTxt);
         this._inputTxt = null;
         super.dispose();
      }
    get backCall() { return super.backCall; }
  }
  $.meta(__AuctionInputFrame, "auction.view.common.AuctionInputFrame", []);
  return __AuctionInputFrame;
}
deps["auction.view.common.AuctionInputFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "manager.LanguageMgr", "yishi.keyboard.KeyBoardRegister", "yishi.manager.PlayerManager", "yishi.utils.SimpleAlertHelper"];

defs["auction.view.common.AuctionListColWidthConst"] = function define($) {
  const __Base = $.Object;
  class __AuctionListColWidthConst extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__AuctionListColWidthConst, "auction.view.common.AuctionListColWidthConst", []);
  $.statics(__AuctionListColWidthConst, () => {
    __AuctionListColWidthConst.short = [44,118,65,83,90,110,120];
    __AuctionListColWidthConst.shortX = [2,45,150,200,285,370,475];
    __AuctionListColWidthConst.long = [43,137,75,133,143,133,128];
    __AuctionListColWidthConst.longX = [2,47,186,268,406,552,690];
  });
  return __AuctionListColWidthConst;
}
deps["auction.view.common.AuctionListColWidthConst"] = [];

defs["auction.view.common.AuctionListComponent"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionListComponent extends __Base {
    static $fields(self) {
    self._vbox = null;
    self._selectItem = null;
    self._itemClass = null;
    self._length = 0;
    self._gap = NaN;
    self._callBack = null;
    }
    constructor(param1, param2, param3) {
         $.pre(new.target, (__s) => {
         __s._itemClass = param1;
         __s._length = param2;
         __s._gap = param3;
         __s.initView();
         });
         super();
         $.preFlush(this, new.target);
      }
    get callBack() {
         return this._callBack;
      }
    set callBack(param1) {
         this._callBack = param1;
      }
    initView() {
         this._vbox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vbox.spacing = this._gap;
         this.addChild(this._vbox);
      }
    setData(param1) {
         var _loc2_ = 0;
         this.clear();
         _loc2_ = 0;
         while(_loc2_ < this._length)
         {
            if(param1 && _loc2_ < param1.length)
            {
               this.addItem(param1[_loc2_]);
            }
            else
            {
               this.addItem(null);
            }
            _loc2_++;
         }
      }
    addItem(param1) {
         var _loc2_ = new this._itemClass();
         _loc2_.setData(param1);
         _loc2_.doubleClickEnabled = true;
         _loc2_.addEventListener("click",$.bind(this, "onItemClick"));
         _loc2_.addEventListener("doubleClick",$.bind(this, "onItemDoubleClick"));
         this._vbox.addChild(_loc2_);
      }
    onItemDoubleClick(param1) {
         if(this._callBack != null)
         {
            this._callBack();
         }
      }
    onItemClick(param1) {
         if(this._selectItem == param1.currentTarget)
         {
            return;
         }
         this.setSelectItem($.as(param1.currentTarget, $.C("auction.view.common.AuctionListItemBase")));
         this.dispatchEvent(new ($.C("flash.events.Event"))("select"));
      }
    setSelectItem(param1) {
         if(this._selectItem)
         {
            this._selectItem.selected = false;
         }
         this._selectItem = param1;
         this._selectItem.selected = true;
      }
    clear() {
         var _loc1_ = null;
         while(this._vbox.numChildren > 0)
         {
            _loc1_ = $.as(this._vbox.getChildAt(0), $.C("auction.view.common.AuctionListItemBase"));
            _loc1_.removeEventListener("click",$.bind(this, "onItemClick"));
            _loc1_.removeEventListener("doubleClick",$.bind(this, "onItemDoubleClick"));
            this._vbox.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._selectItem = null;
      }
    getSelectedItemData() {
         if(this._selectItem)
         {
            return this._selectItem.getData();
         }
         return null;
      }
    dispose() {
         this.clear();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
  }
  $.meta(__AuctionListComponent, "auction.view.common.AuctionListComponent", []);
  return __AuctionListComponent;
}
deps["auction.view.common.AuctionListComponent"] = ["auction.view.common.AuctionListItemBase", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.events.Event"];

defs["auction.view.common.AuctionListItem1"] = function define($) {
  const __Base = $.C("auction.view.common.AuctionListItemBase");
  class __AuctionListItem1 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super("auction.listItemSelectS","auction.listItemUnselectS","auction.listItemOverS");
      }
    refreshView() {
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberNameTxtS");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberGradeTxtS");
         this._timeLeftTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberTimeLeftTxtS");
         this._salerTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberSalerTxtS");
         this._fixedPriceBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listPriceBackS1");
         this._fixedPriceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberFixedPriceTxtS");
         this._currPriceBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listPriceBackS2");
         this._currPriceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberCurrPriceTxtS");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.listGoodItemS");
         this._auctionedIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listItemAuctionedIconS");
      }
  }
  $.meta(__AuctionListItem1, "auction.view.common.AuctionListItem1", []);
  return __AuctionListItem1;
}
deps["auction.view.common.AuctionListItem1"] = ["auction.view.common.AuctionListItemBase", "com.pickgliss.ui.ComponentFactory"];

defs["auction.view.common.AuctionListItem2"] = function define($) {
  const __Base = $.C("auction.view.common.AuctionListItemBase");
  class __AuctionListItem2 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super("auction.listItemSelectL","auction.listItemUnselectL","auction.listItemOverL");
      }
    refreshView() {
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberNameTxtL");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberGradeTxtL");
         this._timeLeftTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberTimeLeftTxtL");
         this._salerTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberSalerTxtL");
         this._fixedPriceBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listPriceBackL1");
         this._fixedPriceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberFixedPriceTxtL");
         this._currPriceBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listPriceBackL2");
         this._currPriceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.listMemberCurrPriceTxtL");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.listGoodItemL");
         this._itemTipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.timeLeftTip");
         this._itemTipView.graphics.beginFill(0,0);
         this._itemTipView.graphics.drawRect(0,0,820,42);
         this._itemTipView.graphics.endFill();
         this._itemTipView.x = 0;
         this._itemTipView.y = 0;
         this._itemTipView.doubleClickEnabled = true;
      }
  }
  $.meta(__AuctionListItem2, "auction.view.common.AuctionListItem2", []);
  return __AuctionListItem2;
}
deps["auction.view.common.AuctionListItem2"] = ["auction.view.common.AuctionListItemBase", "com.pickgliss.ui.ComponentFactory"];

defs["auction.view.common.AuctionListItemBase"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionListItemBase extends __Base {
    static $fields(self) {
    self.unselectedView = null;
    self.selectedView = null;
    self.mouseOverView = null;
    self._selected = false;
    self._data = null;
    self._itemIcon = null;
    self._nameTxt = null;
    self._gradeTxt = null;
    self._timeLeftTxt = null;
    self._salerTxt = null;
    self._fixedPriceBack = null;
    self._fixedPriceTxt = null;
    self._currPriceBack = null;
    self._currPriceTxt = null;
    self._icon = null;
    self._auctionedIcon = null;
    self._itemTipView = null;
    self._tipView = null;
    self._fixedPriceTipView = null;
    self._currPriceTipView = null;
    }
    constructor(param1, param2, param3) {
         super();
         this.unselectedView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param2);
         this.addChild(this.unselectedView);
         this.selectedView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param1);
         this.addChild(this.selectedView);
         this.selectedView.visible = false;
         this.mouseOverView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param3);
         this.addChild(this.mouseOverView);
         this.mouseOverView.visible = false;
         this.addHandler();
      }
    setData(param1) {
         if(this._data)
         {
            this._data.removeEventListener("change",$.bind(this, "onDataChange"));
            this._icon.removeEventListener("interactive_double_click",$.bind(this, "iconDoubleClickHandler"));
         }
         this._data = param1;
         if(!this._data)
         {
            this.selected = false;
            this.onMouseOut(null);
            this.mouseChildren = this.mouseEnabled = false;
         }
         else
         {
            this.refreshView();
            this.showDataView();
            this._data.addEventListener("change",$.bind(this, "onDataChange"));
            this._icon.addEventListener("interactive_double_click",$.bind(this, "iconDoubleClickHandler"));
         }
      }
    iconDoubleClickHandler(param1) {
         $.C("yishi.utils.MsgMan").notifyObserver("ICON_DOUBLE_CLICK",this._data.name);
      }
    onDataChange(param1) {
         this.updateValue();
      }
    refreshView() {
      }
    showDataView() {
         this.addChild(this._nameTxt);
         this.addChild(this._gradeTxt);
         this.addChild(this._timeLeftTxt);
         this.addChild(this._salerTxt);
         this.addChild(this._fixedPriceBack);
         this.addChild(this._fixedPriceTxt);
         this.addChild(this._currPriceBack);
         this.addChild(this._currPriceTxt);
         this.addItemTip();
         this.addChild(this._icon);
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this._icon);
         if(this._auctionedIcon)
         {
            this.addChild(this._auctionedIcon);
            this._auctionedIcon.tipData = $.C("manager.LanguageMgr").GetTranslation("Auction.AuctionedTips");
         }
         this.updateValue();
         this.setTimeLeftTip();
         this.setUnitPriceTip();
         this._nameTxt.doubleClickEnabled = this._gradeTxt.doubleClickEnabled = this._timeLeftTxt.doubleClickEnabled = this._salerTxt.doubleClickEnabled = this._fixedPriceTxt.doubleClickEnabled = this._currPriceTxt.doubleClickEnabled = true;
         $.cast($.C("flash.display.DisplayObjectContainer"), this.mouseOverView).doubleClickEnabled = $.cast($.C("flash.display.DisplayObjectContainer"), this.selectedView).doubleClickEnabled = true;
         this._fixedPriceBack.mouseChildren = this._currPriceBack.mouseChildren = false;
         this._fixedPriceBack.mouseEnabled = this._currPriceBack.mouseEnabled = false;
      }
    addItemTip() {
         if(this._itemTipView)
         {
            this.addChild(this._itemTipView);
         }
      }
    updateValue() {
         this._nameTxt.text = this._data.name;
         this._gradeTxt.text = this._data.grade + "";
         this._timeLeftTxt.text = this._data.timeLeft;
         this._salerTxt.text = this._data.saler;
         this._fixedPriceTxt.text = this._data.fixedPrice + "";
         this._currPriceTxt.text = this._data.currPrice + "";
         this._icon.data = this._data.getGoodsInfo();
         if(this._auctionedIcon)
         {
            this._auctionedIcon.visible = this._data.auctioned;
         }
         if(this._itemTipView)
         {
            if(this._data.selfPrice < this._data.currPrice)
            {
               this._itemTipView.tipData = $.C("manager.LanguageMgr").GetTranslation("Auction.AuctionItemOverTips");
               this.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            }
            else
            {
               this._itemTipView.tipData = "";
               this.filters = null;
            }
         }
         if(this._tipView)
         {
            this._tipView.tipData = this.getLeftTimeTip();
         }
         if(this._fixedPriceTipView)
         {
            this._fixedPriceTipView.tipData = $.C("manager.LanguageMgr").GetTranslation("auction.view.common.AuctionListItemBase.count01") + this.getUnitPriceValue(this._data.fixedPrice);
         }
         if(this._currPriceTipView)
         {
            this._currPriceTipView.tipData = $.C("manager.LanguageMgr").GetTranslation("auction.view.common.AuctionListItemBase.count02") + this.getUnitPriceValue(this._data.currPrice);
         }
      }
    setTimeLeftTip() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipView);
         this._tipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.timeLeftTip");
         this._tipView.graphics.beginFill(0,0);
         this._tipView.graphics.drawRect(0,0,this._timeLeftTxt.width,this._timeLeftTxt.height);
         this._tipView.graphics.endFill();
         this._tipView.x = this._timeLeftTxt.x;
         this._tipView.y = this._timeLeftTxt.y;
         this._tipView.tipData = this.getLeftTimeTip();
         this._tipView.doubleClickEnabled = true;
         this.addChild(this._tipView);
      }
    setUnitPriceTip() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fixedPriceTipView);
         this._fixedPriceTipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.UnitPriceTip");
         this._fixedPriceTipView.graphics.beginFill(0,0);
         this._fixedPriceTipView.graphics.drawRect(0,0,this._fixedPriceTxt.width,this._fixedPriceTxt.height);
         this._fixedPriceTipView.graphics.endFill();
         this._fixedPriceTipView.x = this._fixedPriceTxt.x;
         this._fixedPriceTipView.y = this._fixedPriceTxt.y;
         this._fixedPriceTipView.tipData = $.C("manager.LanguageMgr").GetTranslation("auction.view.common.AuctionListItemBase.count01") + this.getUnitPriceValue(this._data.fixedPrice);
         this._fixedPriceTipView.doubleClickEnabled = true;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currPriceTipView);
         this._currPriceTipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.UnitPriceTip");
         this._currPriceTipView.graphics.beginFill(0,0);
         this._currPriceTipView.graphics.drawRect(0,0,this._currPriceTxt.width,this._currPriceTxt.height);
         this._currPriceTipView.graphics.endFill();
         this._currPriceTipView.x = this._currPriceTxt.x;
         this._currPriceTipView.y = this._currPriceTxt.y;
         this._currPriceTipView.tipData = $.C("manager.LanguageMgr").GetTranslation("auction.view.common.AuctionListItemBase.count02") + this.getUnitPriceValue(this._data.currPrice);
         this._currPriceTipView.doubleClickEnabled = true;
         this.addChild(this._currPriceTipView);
         this.addChild(this._fixedPriceTipView);
      }
    getLeftTimeTip() {
         var _loc2_ = "Auction.LeftTimeTip";
         var _loc3_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.nowDate - this._data.startTime.time;
         var _loc1_ = this._data.hour * 3600 * 1000 - _loc3_;
         _loc1_ /= 3600000;
         if(_loc1_ >= 12)
         {
            _loc2_ += "1";
         }
         else if(_loc1_ >= 2 && _loc1_ < 12)
         {
            _loc2_ += "2";
         }
         else if(_loc1_ >= 0.5 && _loc1_ < 2)
         {
            _loc2_ += "3";
         }
         else
         {
            _loc2_ += "4";
         }
         return $.C("manager.LanguageMgr").GetTranslation(_loc2_);
      }
    getUnitPriceValue(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(this._data)
         {
            _loc2_ = $.int(this._data.getGoodsInfo().count);
            return (Math.round(param1 / _loc2_ * 10) / 10).toString();
         }
         return "";
      }
    getData() {
         return this._data;
      }
    addHandler() {
         this.addEventListener("rollOver",$.bind(this, "onMouseOver"));
         this.addEventListener("rollOut",$.bind(this, "onMouseOut"));
      }
    onMouseOver(param1) {
         this.mouseOverView.visible = true;
         this.buttonMode = true;
      }
    onMouseOut(param1) {
         this.mouseOverView.visible = false;
         this.buttonMode = false;
      }
    set autoSelect(param1) {
      }
    get selected() {
         return this._selected;
      }
    set selected(param1) {
         this._selected = param1;
         if(this._selected)
         {
            this.unselectedView.visible = false;
            this.selectedView.visible = true;
         }
         else
         {
            this.unselectedView.visible = true;
            this.selectedView.visible = false;
         }
      }
    asDisplayObject() {
         return this;
      }
    get height() {
         return 44;
      }
    dispose() {
         this.removeEventListener("rollOver",$.bind(this, "onMouseOver"));
         this.removeEventListener("rollOut",$.bind(this, "onMouseOut"));
         if(this._data)
         {
            this._data.removeEventListener("change",$.bind(this, "onDataChange"));
            $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this._icon);
            this._icon.removeEventListener("interactive_double_click",$.bind(this, "iconDoubleClickHandler"));
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipView);
         this._tipView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get autoSelect() { return super.autoSelect; }
    set height(v) { super.height = v; }
  }
  $.meta(__AuctionListItemBase, "auction.view.common.AuctionListItemBase", ["Disposeable", "ISelectable"]);
  return __AuctionListItemBase;
}
deps["auction.view.common.AuctionListItemBase"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.DoubleClickManager", "com.pickgliss.utils.ObjectUtils", "flash.display.DisplayObjectContainer", "flash.display.Sprite", "manager.LanguageMgr", "yishi.filter.UIFilter", "yishi.manager.PlayerManager", "yishi.utils.MsgMan"];

defs["auction.view.common.AuctionListTitleComponent"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionListTitleComponent extends __Base {
    static $fields(self) {
    self._backStyle = null;
    self._backView = null;
    self._columnWidths = null;
    self._columnXs = null;
    self._startX = NaN;
    self._startY = NaN;
    self._titleIcon = null;
    self._titleName = null;
    self._titleGrade = null;
    self._titleTime = null;
    self._titleMan = null;
    self._titlePrice = null;
    self._titleCurPrice = null;
    self._curSelectBtn = null;
    }
    constructor(param1, param2, param3, param4 = 3, param5 = 6) {
         $.pre(new.target, (__s) => {
         __s._backStyle = param1;
         __s._columnWidths = param2;
         __s._columnXs = param3;
         __s._startX = param4;
         __s._startY = param5;
         __s.initView();
         });
         super();
         $.preFlush(this, new.target);
      }
    initView() {
         this._backView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(this._backStyle);
         this.addChild(this._backView);
         this._titleIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ListTitleIcon");
         this._titleIcon.width = this._columnWidths[0];
         this._titleIcon.x = this._columnXs[0];
         this._titleName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ListTitleName");
         this._titleName.width = this._columnWidths[1];
         this._titleName.x = this._columnXs[1];
         this._titleGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ListTitleGrade");
         this._titleGrade.width = this._columnWidths[2];
         this._titleGrade.x = this._columnXs[2];
         this._titleGrade.buttonMode = true;
         this._titleGrade.addMouseEffect();
         this._titleTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ListTitleTime");
         this._titleTime.width = this._columnWidths[3];
         this._titleTime.x = this._columnXs[3];
         this._titleTime.buttonMode = true;
         this._titleTime.addMouseEffect();
         this._titleMan = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ListTitleMan");
         this._titleMan.width = this._columnWidths[4];
         this._titleMan.x = this._columnXs[4];
         this._titlePrice = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ListTitlePrice");
         this._titlePrice.width = this._columnWidths[5];
         this._titlePrice.x = this._columnXs[5];
         this._titlePrice.buttonMode = true;
         this._titlePrice.addMouseEffect();
         this._titleCurPrice = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ListTitleCurPrice");
         this._titleCurPrice.width = this._columnWidths[6];
         this._titleCurPrice.x = this._columnXs[6];
         this._titleCurPrice.buttonMode = true;
         this._titleCurPrice.addMouseEffect();
         this.addChild(this._titleIcon);
         this._titleIcon.text = $.C("manager.LanguageMgr").GetTranslation("Auction.ResultListTitle1");
         this.addChild(this._titleName);
         this._titleName.text = $.C("manager.LanguageMgr").GetTranslation("Auction.ResultListTitle2");
         this.addChild(this._titleGrade);
         this._titleGrade.text = $.C("manager.LanguageMgr").GetTranslation("public.grade");
         this.addChild(this._titleTime);
         this._titleTime.text = $.C("manager.LanguageMgr").GetTranslation("Auction.ResultListTitle4");
         this.addChild(this._titleMan);
         this._titleMan.text = $.C("manager.LanguageMgr").GetTranslation("Auction.ResultListTitle5");
         this.addChild(this._titlePrice);
         this._titlePrice.text = $.C("manager.LanguageMgr").GetTranslation("Auction.ResultListTitle6");
         this.addChild(this._titleCurPrice);
         this._titleCurPrice.text = $.C("manager.LanguageMgr").GetTranslation("Auction.ResultListTitle7");
      }
    get titleGrade() {
         return this._titleGrade;
      }
    get titleTime() {
         return this._titleTime;
      }
    get titlePrice() {
         return this._titlePrice;
      }
    get titleCurPrice() {
         return this._titleCurPrice;
      }
    currentSelectBut(param1) {
         this._titleIcon.setFrame = 0;
         this._titleName.setFrame = 0;
         this._titleGrade.setFrame = 0;
         this._titleTime.setFrame = 0;
         this._titleMan.setFrame = 0;
         this._titlePrice.setFrame = 0;
         this._titleCurPrice.setFrame = 0;
         if(param1 == null)
         {
            this._curSelectBtn = null;
            return 1;
         }
         if(this._curSelectBtn == param1)
         {
            param1.setFrame = 2;
            this._curSelectBtn = null;
            return 2;
         }
         param1.setFrame = 1;
         this._curSelectBtn = param1;
         return 1;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    set titleGrade(v) { super.titleGrade = v; }
    set titleTime(v) { super.titleTime = v; }
    set titlePrice(v) { super.titlePrice = v; }
    set titleCurPrice(v) { super.titleCurPrice = v; }
  }
  $.meta(__AuctionListTitleComponent, "auction.view.common.AuctionListTitleComponent", ["Disposeable"]);
  return __AuctionListTitleComponent;
}
deps["auction.view.common.AuctionListTitleComponent"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr"];

defs["auction.view.common.AuctionPageControlComponent"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionPageControlComponent extends __Base {
    static $fields(self) {
    self._preBtn = null;
    self._nextBtn = null;
    self._pageTxtBack = null;
    self._pageTxt = null;
    self._id = -1;
    self._data = null;
    }
    constructor() {
         super();
         this.init();
      }
    init() {
         this._preBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.prePageBtn");
         this._nextBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.nextPageBtn");
         this._pageTxtBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.PageNumBack");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.PageTxt");
         this._preBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.prePage");
         this._nextBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.nextPage");
         this.addChild(this._preBtn);
         this.addChild(this._nextBtn);
         this.addChild(this._pageTxtBack);
         this.addChild(this._pageTxt);
      }
    refreshView() {
         if(this._data)
         {
            this._pageTxt.text = this._data.currentPage + "/" + this._data.totalPage;
         }
         if(this._data.currentPage > 1)
         {
            this._preBtn.enable = true;
         }
         else
         {
            this._preBtn.enable = false;
         }
         if(this._data.currentPage < this._data.totalPage)
         {
            this._nextBtn.enable = true;
         }
         else
         {
            this._nextBtn.enable = false;
         }
      }
    update(param1) {
         if(this._data)
         {
            this._data.removeEventListener("change",$.bind(this, "onDataChanged"));
         }
         this._data = param1;
         this._data.addEventListener("change",$.bind(this, "onDataChanged"));
         this.refreshView();
      }
    onDataChanged(param1) {
         this.refreshView();
      }
    getPreBtn() {
         return this._preBtn;
      }
    getNextBtn() {
         return this._nextBtn;
      }
    get id() {
         return this._id;
      }
    set id(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._id = param1;
      }
    getData() {
         return this._data;
      }
    dispose() {
         if(this._data)
         {
            this._data.removeEventListener("change",$.bind(this, "onDataChanged"));
         }
         this._data = null;
         if(this._preBtn)
         {
            this._preBtn.dispose();
         }
         this._preBtn = null;
         if(this._nextBtn)
         {
            this._nextBtn.dispose();
         }
         this._nextBtn = null;
         if(this._pageTxt)
         {
            this._pageTxt.dispose();
         }
         this._pageTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pageTxtBack);
         this._pageTxtBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
  }
  $.meta(__AuctionPageControlComponent, "auction.view.common.AuctionPageControlComponent", ["Disposeable"]);
  return __AuctionPageControlComponent;
}
deps["auction.view.common.AuctionPageControlComponent"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr"];

defs["auction.view.common.TimeLimitButton"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.SelectedButton");
  class __TimeLimitButton extends __Base {
    static $fields(self) {
    self._text = null;
    }
    constructor() {
         super();
      }
    setText(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._text = param1;
         if(this._selectedButton)
         {
            $.cast($.C("com.pickgliss.ui.controls.TextButton"), this._selectedButton).text = this._text;
         }
         if(this._unSelectedButton)
         {
            $.cast($.C("com.pickgliss.ui.controls.TextButton"), this._unSelectedButton).text = this._text;
         }
      }
    onProppertiesUpdate() {
         super.onProppertiesUpdate();
         if(this._text)
         {
            this.setText(this._text);
         }
      }
  }
  $.meta(__TimeLimitButton, "auction.view.common.TimeLimitButton", []);
  return __TimeLimitButton;
}
deps["auction.view.common.TimeLimitButton"] = ["com.pickgliss.ui.controls.SelectedButton", "com.pickgliss.ui.controls.TextButton"];

defs["auction.view.mysteryshop.BuyGoodsItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BuyGoodsItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._buyBtn = null;
    self._boughtBtn = null;
    self._name = null;
    self._price = null;
    self._priceIcon = null;
    self._goods = null;
    self._shopGoodsInfo = null;
    self._goodsTempInfo = null;
    self._goodsInfo = null;
    self._buyGoodsInfo = null;
    self._buyTipData = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopGoodsItemBg");
         this._buyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopBuyBtn");
         this._boughtBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopBoughtBtn");
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsNameTextStyle");
         this._price = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsValueTextStyle");
         this._priceIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsValueIcon");
         this._goods = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.MysteryBaseItemView");
         this.addChild(this._bg);
         this._bg.setFrame(1);
         this.addChild(this._name);
         this.addChild(this._price);
         this.addChild(this._priceIcon);
         this.addChild(this._goods);
         this._boughtBtn.enable = false;
      }
    addEvent() {
         this.addEventListener("mouseOut",$.bind(this, "__onMouseOut"));
         this.addEventListener("mouseOver",$.bind(this, "__onMouseOver"));
         this._buyBtn.addEventListener("click",$.bind(this, "__onBuyBtnHandler"));
      }
    removeEvent() {
         this.removeEventListener("mouseOut",$.bind(this, "__onMouseOut"));
         this.removeEventListener("mouseOver",$.bind(this, "__onMouseOver"));
         if(this._buyBtn)
         {
            this._buyBtn.removeEventListener("click",$.bind(this, "__onBuyBtnHandler"));
         }
      }
    __onMouseOver(param1) {
         this._bg.setFrame(2);
      }
    __onMouseOut(param1) {
         this._bg.setFrame(1);
      }
    __onBuyBtnHandler(param1) {
         var _loc6_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this.mysteryShopModel.buyCount >= this.mysteryShopModel.maxBuyCount)
         {
            this._buyTipData = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData");
            $.C("yishi.view.tips.MessageTipManager").instance().show(this._buyTipData);
            return;
         }
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "buyGoodsHandlerBack")];
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
         var _loc4_ = 0;
         if(this._shopGoodsInfo.Point > 0)
         {
            _loc4_ = $.int(this._shopGoodsInfo.Point);
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyGoodsItem.tipContent",this._goodsTempInfo.TemplateName,_loc4_);
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
         }
         if(this._shopGoodsInfo.GiftToken > 0)
         {
            _loc4_ = $.int(this._shopGoodsInfo.GiftToken);
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyGoodsItem.tipContent",this._goodsTempInfo.TemplateName,_loc4_);
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc4_);
         }
      }
    buyGoodsHandlerBack(param1, param2) {
         if(param1)
         {
            $.C("com.pickgliss.utils.SoundManager").instance.play("022");
            this.mysteryShopManager.sendBuyGoodsItem(this._buyGoodsInfo.itemId,this._buyGoodsInfo.index,param2);
            this.useBoughtBtn();
            this.mysteryShopModel.addEventListener("MYSTERY_GOODS_BUY_RETURN",$.bind(this, "__buyReturnHandler"));
         }
         if(this.mysteryShopControler.frame)
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = this.mysteryShopControler.frame;
         }
      }
    __buyReturnHandler(param1) {
         this.mysteryShopModel.removeEventListener("MYSTERY_GOODS_BUY_RETURN",$.bind(this, "__buyReturnHandler"));
         if(this.mysteryShopModel.buyResult == 1 || this.mysteryShopModel.buyResult == 12)
         {
            this.useBoughtBtn();
            this._buyGoodsInfo.isCanBuy = 1;
         }
         else
         {
            this.useBuyBtn();
            this._buyGoodsInfo.isCanBuy = 0;
         }
         this.shopingResult(this.mysteryShopModel.buyResult);
      }
    shopingResult(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = "";
         switch(param1)
         {
            case 1:
               return;
            case 2:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command02");
               break;
            case 3:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command03");
               break;
            case 5:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command05");
               break;
            case 6:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command06");
               break;
            case 7:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command07");
               break;
            case 8:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command08");
               break;
            case 9:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command09");
               break;
            case 10:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command10");
               break;
            case 11:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command11");
               break;
            case 12:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command12");
               break;
            case 15:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command15");
               break;
            case 19:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command19");
               break;
            case 20:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command20");
               break;
            case 21:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command21");
               break;
            case 22:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command22");
               break;
            case 23:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("shop.utils.ShopingHelper.command23");
               break;
            case 4:
               return;
         }
         $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
      }
    set data(param1) {
         this.clean();
         if(param1)
         {
            this.addEvent();
            this._buyGoodsInfo = param1;
            this._shopGoodsInfo = $.C("yishi.manager.TempleteManager").instance.getMysteryInfoByItemId(this._buyGoodsInfo.itemId);
            this._goodsTempInfo = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._shopGoodsInfo.ItemId);
            this._goodsInfo = new ($.C("yishi.datas.goods.GoodsInfo"))();
            this._goodsInfo.templateId = this._goodsTempInfo.TemplateId;
            this._goodsInfo.validDate = this._shopGoodsInfo.ValidDate;
            if(!this._goodsTempInfo || !this._shopGoodsInfo)
            {
               this.data = null;
               return;
            }
            this._goods.data = this._goodsInfo;
            this._name.text = this._goodsTempInfo.TemplateName;
            this._name.numLines == 2 ? (this._name.y = 5) : (Number(this._name.y = 15));
            if(this._shopGoodsInfo.Point > 0)
            {
               this._price.text = String(this._shopGoodsInfo.Point);
            }
            if(this._shopGoodsInfo.GiftToken > 0)
            {
               this._price.text = String(this._shopGoodsInfo.GiftToken);
            }
            this._priceIcon.visible = true;
            if(this._buyGoodsInfo.isCanBuy == 0)
            {
               this.useBuyBtn();
            }
            else
            {
               this.useBoughtBtn();
            }
         }
         else
         {
            this.removeEvent();
         }
      }
    useBuyBtn() {
         if(this._boughtBtn && this._boughtBtn.parent)
         {
            this._boughtBtn.parent.removeChild(this._boughtBtn);
         }
         if(this._buyBtn)
         {
            this.addChild(this._buyBtn);
         }
      }
    useBoughtBtn() {
         if(this._boughtBtn)
         {
            this.addChild(this._boughtBtn);
         }
         if(this._buyBtn && this._buyBtn.parent)
         {
            this._buyBtn.parent.removeChild(this._buyBtn);
         }
      }
    clean() {
         this._goods.data = null;
         this._bg.setFrame(1);
         this._name.text = "";
         this._price.text = "";
         this._priceIcon.visible = false;
      }
    uninit() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._buyBtn = null;
         this._shopGoodsInfo = null;
         this._goodsTempInfo = null;
         this._goodsInfo = null;
         this._buyGoodsInfo = null;
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get mysteryShopControler() {
         return $.C("yishi.manager.FrameControllerManager").instance.mysteryShopController;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get mysteryShopModel() {
         return $.C("managers.MysteryShopManager").instance.model;
      }
    get mysteryShopManager() {
         return $.C("managers.MysteryShopManager").instance;
      }
    get data() { return super.data; }
    set mysteryShopControler(v) { super.mysteryShopControler = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set mysteryShopModel(v) { super.mysteryShopModel = v; }
    set mysteryShopManager(v) { super.mysteryShopManager = v; }
  }
  $.meta(__BuyGoodsItem, "auction.view.mysteryshop.BuyGoodsItem", ["Disposeable"]);
  return __BuyGoodsItem;
}
deps["auction.view.mysteryshop.BuyGoodsItem"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "managers.MysteryShopManager", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["auction.view.mysteryshop.ExchangeGoodsItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ExchangeGoodsItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._buyBtn = null;
    self._name = null;
    self._price = null;
    self._priceIcon = null;
    self._points = null;
    self._pointsIcon = null;
    self._goods = null;
    self._data = null;
    self._goodsTempInfo = null;
    self._goodsInfo = null;
    self.cost = 0;
    }
    constructor() {
         super();
         this.initView();
         this.initEvents();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopGoodsItemBg");
         this._buyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopBuyBtn");
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsNameTextStyle");
         this._price = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsValueTextStyle");
         this._priceIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsValueIcon");
         this._points = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsPointsTextStyle");
         this._pointsIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryGoodsPointsIcon");
         this._goods = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.MysteryBaseItemView");
         this._price.x = 70;
         this._priceIcon.x = 140;
         this.addChild(this._bg);
         this._bg.setFrame(1);
         this.addChild(this._buyBtn);
         this.addChild(this._name);
         this.addChild(this._price);
         this.addChild(this._priceIcon);
         this.addChild(this._points);
         this.addChild(this._pointsIcon);
         this.addChild(this._goods);
      }
    initEvents() {
         this.addEventListener("mouseOver",$.bind(this, "__itemRollOverHandler"));
         this.addEventListener("mouseOut",$.bind(this, "__itemRollOutHandler"));
         this._buyBtn.addEventListener("click",$.bind(this, "__buyBtnClickHandler"));
      }
    removeEvents() {
         this.removeEventListener("mouseOver",$.bind(this, "__itemRollOverHandler"));
         this.removeEventListener("mouseOut",$.bind(this, "__itemRollOutHandler"));
         this._buyBtn.removeEventListener("click",$.bind(this, "__buyBtnClickHandler"));
      }
    __itemRollOverHandler(param1) {
         this._bg.setFrame(2);
      }
    __itemRollOutHandler(param1) {
         this._bg.setFrame(1);
      }
    __buyBtnClickHandler(param1) {
         var _loc2_ = null;
         if(!this._data)
         {
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this.mysteryShopModel.buyCount >= this.mysteryShopModel.maxBuyCount)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("managers.MysteryShopManager").instance.model.consumePoints < this.data.Score)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData2");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("yishi.utils.CheckUIModuleUtil").instance.tryCall("numbuy",$.bind(this, "showBuyFrameCall"));
      }
    showBuyFrameCall() {
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("numbuy.numbuyFrame");
         _loc1_.data = this._data;
         _loc1_.show();
      }
    buyGoodsHandlerBack(param1, param2) {
         var _loc3_ = 0;
         if(param1)
         {
            $.C("com.pickgliss.utils.SoundManager").instance.play("022");
            if(param2)
            {
               _loc3_ = this.playerInfo.point + this.playerInfo.giftToken;
            }
            else
            {
               _loc3_ = $.int(this.playerInfo.point);
            }
            if(_loc3_ < this.cost)
            {
               $.C("yishi.manager.RechargeAlertMannager").show();
               return;
            }
            $.C("managers.ShopManager").Instance.buyOne(($.as(this._data, $.C("mvc.module.shop.ShopGoodsInfo"))).Id,1,this.playerInfo.userId,($.as(this._data, $.C("mvc.module.shop.ShopGoodsInfo"))).PayType,false);
         }
         if(this.mysteryShopControler.frame)
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = this.mysteryShopControler.frame;
         }
      }
    get mysteryShopControler() {
         return $.C("yishi.manager.FrameControllerManager").instance.mysteryShopController;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get mysteryShopModel() {
         return $.C("managers.MysteryShopManager").instance.model;
      }
    get mysteryShopManager() {
         return $.C("managers.MysteryShopManager").instance;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this.clean();
         this._data = param1;
         if(this.data)
         {
            this.initEvents();
            this._goodsTempInfo = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this.data.ItemId);
            this._goodsInfo = new ($.C("yishi.datas.goods.GoodsInfo"))();
            this._goodsInfo.templateId = this._goodsTempInfo.TemplateId;
            this._goodsInfo.validDate = this.data.ValidDate;
            if(!this._goodsTempInfo)
            {
               this.data = null;
               return;
            }
            this._goods.data = this._goodsInfo;
            this._name.text = this._goodsTempInfo.TemplateName;
            this._name.numLines == 2 ? (this._name.y = 5) : (Number(this._name.y = 15));
            if(this.data.Point != 0)
            {
               this._price.text = String(this.data.Point);
               this._priceIcon.visible = true;
            }
            else if(this.data.GiftToken != 0)
            {
               this._price.text = String(this.data.GiftToken);
               this._priceIcon.visible = true;
            }
            this._points.text = String(this.data.Score);
            this._pointsIcon.visible = true;
            this._buyBtn.visible = true;
         }
         else
         {
            this.removeEvents();
         }
      }
    clean() {
         this._goods.data = null;
         this._bg.setFrame(1);
         this._name.text = "";
         this._price.text = "";
         this._priceIcon.visible = false;
         this._points.text = "";
         this._pointsIcon.visible = false;
         this._buyBtn.visible = false;
      }
    dispose() {
         this.removeEvents();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._bg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         }
         this._bg = null;
         if(this._buyBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buyBtn);
         }
         this._buyBtn = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._price)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._price);
         }
         this._price = null;
         if(this._priceIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._priceIcon);
         }
         this._priceIcon = null;
         if(this._points)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._points);
         }
         this._points = null;
         if(this._pointsIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pointsIcon);
         }
         this._pointsIcon = null;
         if(this._goods)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goods);
         }
         this._goods = null;
         this._data = null;
         this._goodsTempInfo = null;
         this._goodsInfo = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set mysteryShopControler(v) { super.mysteryShopControler = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set mysteryShopModel(v) { super.mysteryShopModel = v; }
    set mysteryShopManager(v) { super.mysteryShopManager = v; }
  }
  $.meta(__ExchangeGoodsItem, "auction.view.mysteryshop.ExchangeGoodsItem", ["Disposeable"]);
  return __ExchangeGoodsItem;
}
deps["auction.view.mysteryshop.ExchangeGoodsItem"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "managers.MysteryShopManager", "managers.ShopManager", "mvc.module.shop.ShopGoodsInfo", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.manager.TempleteManager", "yishi.utils.CheckUIModuleUtil", "yishi.view.tips.MessageTipManager"];

defs["auction.view.mysteryshop.MysteryShopEventItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MysteryShopEventItem extends __Base {
    static $fields(self) {
    self._rect = null;
    self._data = null;
    self._textBlock = null;
    self._lineWidth = 205;
    self._faceHeigth = 18;
    self.totalLine = 0;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s._rect = new ($.C("flash.geom.Rectangle"))(0,0,__s._lineWidth,__s._faceHeigth);
         });
         super();
         $.preFlush(this, new.target);
         this.mouseEnabled = false;
      }
    get viewRectangle() {
         return this._rect;
      }
    set lineWidth(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._lineWidth = param1;
      }
    set data(param1) {
         this._data = $.as(param1, $.C("chat.datas.ChatData"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         var _loc3_ = this._data.chatItemData.getAllElements();
         if(!_loc3_ || _loc3_.length == 0)
         {
            return;
         }
         var _loc2_ = new ($.C("flash.text.engine.GroupElement"))(_loc3_);
         _loc3_ = null;
         this._textBlock = new ($.C("flash.text.engine.TextBlock"))();
         this._textBlock.baselineZero = "ideographicCenter";
         this._textBlock.content = _loc2_;
         this.createTextLines();
         this.drawBack();
      }
    createTextLines() {
         var _loc1_ = 0;
         this.totalLine = 0;
         var _loc2_ = true;
         var _loc3_ = this._textBlock.createTextLine(null,this._lineWidth);
         _loc3_.mouseEnabled = false;
         _loc3_.doubleClickEnabled = false;
         while(_loc3_)
         {
            this.totalLine = this.totalLine + 1;
            this.addChild(_loc3_);
            _loc3_.x = 0;
            if(_loc2_)
            {
               _loc2_ = false;
               _loc1_ = _loc3_.y = _loc3_.height / 2;
            }
            else
            {
               _loc1_ = _loc3_.y = _loc1_ + this._faceHeigth;
               _loc3_.x = 2;
            }
            _loc3_ = this._textBlock.createTextLine(_loc3_,this._lineWidth);
         }
         this.filters = [new ($.C("flash.filters.GlowFilter"))(0,1,4,4,4)];
      }
    drawBack() {
         this.graphics.beginFill(16777215,0);
         this.graphics.drawRect(0,0,this._lineWidth,this.totalLine * this._faceHeigth);
         this.graphics.endFill();
         this._rect.height = this.totalLine * this._faceHeigth;
      }
    dispose() {
         this.graphics.clear();
         this._data.dispose();
         this._data = null;
         this._textBlock = null;
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    get lineWidth() { return super.lineWidth; }
    get data() { return super.data; }
  }
  $.meta(__MysteryShopEventItem, "auction.view.mysteryshop.MysteryShopEventItem", ["Disposeable", "IManualSize"]);
  return __MysteryShopEventItem;
}
deps["auction.view.mysteryshop.MysteryShopEventItem"] = ["chat.datas.ChatData", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.filters.GlowFilter", "flash.geom.Rectangle", "flash.text.engine.GroupElement", "flash.text.engine.TextBlock"];

defs["auction.view.mysteryshop.MysteryShopFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __MysteryShopFrame extends __Base {
    static $fields(self) {
    self._helpBtn = null;
    self._canBuyCount = 0;
    self._buttongroup = null;
    self._page1 = null;
    self._page2 = null;
    self._frameLeftBackBg = null;
    self._frameRightBackBg = null;
    self._leftBack = null;
    self._rightBack = null;
    self._projectRareItem = null;
    self._projectLuckyPlayer = null;
    self._scrolPanel = null;
    self._vBox = null;
    self._bottomBg = null;
    self._dailyCountTxt = null;
    self._countTimeTxt = null;
    self._countTime = null;
    self._quickRefreshBtn = null;
    self._consumePointsBg = null;
    self._pageBg = null;
    self._pageTxt = null;
    self._lastPageBtn = null;
    self._nextPageBtn = null;
    self._goodsListContainer = null;
    self._rareGoodsListContainer = null;
    self._exchangeGoodsListContainer = null;
    self._buyGoodsList = null;
    self._rareGoodsList = null;
    self._exchangeGoodsList = null;
    self._consumePointsTxt = null;
    self._buyTipTxt = null;
    }
    constructor() {
         super();
         this.initView();
         this.initData();
         this.addEvent();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,774,500);
      }
    initView() {
         this._helpBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopHelpBtn");
         this._buyGoodsList = new $.Vector();
         this._rareGoodsList = new $.Vector();
         this._exchangeGoodsList = new $.Vector();
         this._buttongroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._page1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.SelectBuyItemBtn");
         this._page2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.SelectExchangeItemBtn");
         this._buttongroup.addSelectItem(this._page1);
         this._buttongroup.addSelectItem(this._page2);
         this._buttongroup.selectIndex = 0;
         this._frameLeftBackBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrameLeftBackBg");
         this._frameRightBackBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrameRightBackBg");
         this._leftBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.LeftBack");
         this._rightBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.RightBack");
         this._projectRareItem = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.ProjectRareItem");
         this._projectLuckyPlayer = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.ProjectLuckyPlayer");
         this._scrolPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.ScrollPanel");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.Vbox");
         this._bottomBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.BottomBg");
         this._dailyCountTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.DailyCountTxt");
         this._countTimeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.LeftTimeTxt");
         this._countTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopBuyUpdateTime");
         this._quickRefreshBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopQuickRefreshBtn");
         this._quickRefreshBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyTimeView.quickRefreshTip",this.mysteryShopModel.refreshRewardNeedPay);
         this._consumePointsBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.ConsumePointsBg");
         this._consumePointsTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.PageTextStyle");
         this._pageBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.PageBg");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.PageTextStyle");
         this._lastPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.LastPageBtn");
         this._nextPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopFrame.NextPageBtn");
         this._buyTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.BuyTipTxt");
         this._goodsListContainer = new ($.C("flash.display.Sprite"))();
         this._goodsListContainer.x = 230;
         this._goodsListContainer.y = 37;
         this._rareGoodsListContainer = new ($.C("flash.display.Sprite"))();
         this._rareGoodsListContainer.x = 0;
         this._rareGoodsListContainer.y = 30;
         this._exchangeGoodsListContainer = new ($.C("flash.display.Sprite"))();
         this._exchangeGoodsListContainer.x = 230;
         this._exchangeGoodsListContainer.y = 37;
         this.addToContent(this._frameLeftBackBg);
         this.addToContent(this._frameRightBackBg);
         this.addToContent(this._leftBack);
         this.addToContent(this._rightBack);
         this.addToContent(this._projectRareItem);
         this.addToContent(this._projectLuckyPlayer);
         this.addToContent(this._scrolPanel);
         this.addToContent(this._page1);
         this.addToContent(this._page2);
         this.addToContent(this._bottomBg);
         this.addToContent(this._consumePointsBg);
         this.addToContent(this._consumePointsTxt);
         this._consumePointsTxt.x = 320;
         this._consumePointsTxt.y = 358;
         this.addToContent(this._dailyCountTxt);
         this.addToContent(this._countTimeTxt);
         this.addToContent(this._countTime);
         this.addToContent(this._buyTipTxt);
         this.addToContent(this._quickRefreshBtn);
         this.addToContent(this._pageBg);
         this.addToContent(this._pageTxt);
         this.addToContent(this._lastPageBtn);
         this.addToContent(this._nextPageBtn);
         this.addToContent(this._goodsListContainer);
         this.addToContent(this._rareGoodsListContainer);
         this.addToContent(this._exchangeGoodsListContainer);
         this.addToContent(this._helpBtn);
         this._helpBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.MysteryShopFrame.HelpBtn.Tipdata");
         this._scrolPanel.beginChanges();
         this._scrolPanel.setView(this._vBox,true);
         this._scrolPanel.invalidateViewport();
         this.createGoodsList();
         this.createRareGoodsList();
         this.createExchangeGoodsList();
         this.showCaseBagTip();
      }
    initData() {
         if(!this.mysteryShopModel.remainTime || this.mysteryShopModel.remainTime == 0)
         {
            this.mysteryShopManager.sendRefreshGoodsList(false);
         }
         this._countTime.timeCount = this.mysteryShopModel.remainTime;
         this.mysteryShopControler.initRareGoodsData();
         this.mysteryShopControler.initExchangeGoodsData();
         this.updateGoodsListData();
         this.updateRareGoodsListData();
         this.__refreshCountView(null);
         this.__refreshPointsView(null);
         this.__refreshLuckyPlayerListHandler(null);
         this.__refreshPageView(null);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._page1.addEventListener("click",$.bind(this, "__pageIClick"));
         this._page2.addEventListener("click",$.bind(this, "__pageIIClick"));
         this._lastPageBtn.addEventListener("click",$.bind(this, "__onPageHandler"));
         this._nextPageBtn.addEventListener("click",$.bind(this, "__onPageHandler"));
         this.mysteryShopModel.addEventListener("MYSTERY_GOODS_LIST_REFRESH",$.bind(this, "__refreshFrameView"));
         this.mysteryShopModel.addEventListener("BUY_COUNTS_REFRESH",$.bind(this, "__refreshCountView"));
         this.mysteryShopModel.addEventListener("CONSUME_POINTS_REFRESH",$.bind(this, "__refreshPointsView"));
         this.mysteryShopModel.addEventListener("EXCHANGE_GOODS_LIST_UPDATE",$.bind(this, "__refreshExchangeGoodsView"));
         this.mysteryShopModel.addEventListener("EXCHANGE_PAGE_UPDATE",$.bind(this, "__refreshPageView"));
         this._quickRefreshBtn.addEventListener("click",$.bind(this, "__onQuickRefreshClick"));
         this._countTime.addEventListener("timerDown_complete",$.bind(this, "__timeCompleteHandler"));
         this._helpBtn.addEventListener("click",$.bind(this, "__onHelpClick"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         this._page1.removeEventListener("click",$.bind(this, "__pageIClick"));
         this._page2.removeEventListener("click",$.bind(this, "__pageIIClick"));
         this._lastPageBtn.removeEventListener("click",$.bind(this, "__onPageHandler"));
         this._nextPageBtn.removeEventListener("click",$.bind(this, "__onPageHandler"));
         this.mysteryShopModel.removeEventListener("MYSTERY_GOODS_LIST_REFRESH",$.bind(this, "__refreshFrameView"));
         this.mysteryShopModel.removeEventListener("BUY_COUNTS_REFRESH",$.bind(this, "__refreshCountView"));
         this.mysteryShopModel.removeEventListener("CONSUME_POINTS_REFRESH",$.bind(this, "__refreshPointsView"));
         this.mysteryShopModel.removeEventListener("EXCHANGE_GOODS_LIST_UPDATE",$.bind(this, "__refreshExchangeGoodsView"));
         this.mysteryShopModel.removeEventListener("EXCHANGE_PAGE_UPDATE",$.bind(this, "__refreshPageView"));
         this._quickRefreshBtn.removeEventListener("click",$.bind(this, "__onQuickRefreshClick"));
         this._countTime.removeEventListener("timerDown_complete",$.bind(this, "__timeCompleteHandler"));
         this._helpBtn.removeEventListener("click",$.bind(this, "__onHelpClick"));
      }
    __pageIClick(param1) {
         this.showCaseBagTip();
         this.updateGoodsListData();
         this.refreshTimeView();
      }
    __pageIIClick(param1) {
         this.showCaseBagTip(false);
         this.updateExchangeGoodsListData();
      }
    __onPageHandler(param1) {
         this.mysteryShopControler.pageBtnHandler(param1.currentTarget == this._lastPageBtn);
      }
    __refreshPageView(param1) {
         var _loc3_ = 1;
         var _loc2_ = 1;
         this._pageTxt.text = this.mysteryShopModel.currentPage + " / " + this.mysteryShopModel.totalPage;
         this._lastPageBtn.enable = this.mysteryShopModel.currentPage != 1;
         this._nextPageBtn.enable = this.mysteryShopModel.currentPage != this.mysteryShopModel.totalPage;
      }
    __refreshExchangeGoodsView(param1) {
         this.updateExchangeGoodsListData();
      }
    showCaseBagTip(param1 = true) {
         this._countTimeTxt.visible = param1;
         this._countTime.visible = param1;
         this._quickRefreshBtn.visible = param1;
         this._goodsListContainer.visible = param1;
         this._pageBg.visible = !param1;
         this._pageTxt.visible = !param1;
         this._lastPageBtn.visible = !param1;
         this._nextPageBtn.visible = !param1;
         this._exchangeGoodsListContainer.visible = !param1;
      }
    __refreshLuckyPlayerListHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc4_ = null;
         var _loc5_ = 0;
         this._vBox.removeAllChild();
         this._scrolPanel.beginChanges();
         var _loc6_ = this.mysteryShopModel.luckyPlayerList;
         if(_loc6_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc3_ = new ($.C("auction.view.mysteryshop.MysteryShopEventItem"))();
               _loc2_ = $.as(_loc6_[_loc5_], $.C("mvc.module.auction.MysteryShopEventInfo"));
               _loc4_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("chat.datas.ChatData")), $.C("chat.datas.ChatData"));
               _loc4_.channel = 103;
               _loc4_.msg = _loc2_.msg;
               _loc4_.chatItemData.cellVector = $.C("chat.utils.ChatFormat").getContentCellData(_loc4_);
               _loc3_.data = _loc4_;
               this._vBox.addChildAt(_loc3_,0);
               _loc5_++;
            }
         }
         this._vBox.refreshChildPos();
         this._scrolPanel.invalidateViewport();
         this._scrolPanel.commitChanges();
      }
    __refreshCountView(param1) {
         this._canBuyCount = this.mysteryShopModel.maxBuyCount - this.mysteryShopModel.buyCount;
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyCountView.tipText");
         this._dailyCountTxt.text = _loc2_ + " " + String(this._canBuyCount) + " / " + String(this.mysteryShopModel.maxBuyCount);
      }
    __refreshPointsView(param1) {
         this._consumePointsTxt.text = this.mysteryShopModel.consumePoints.toString();
      }
    createGoodsList() {
         var _loc4_ = 0;
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc1_ = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new ($.C("auction.view.mysteryshop.BuyGoodsItem"))();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            this._buyGoodsList.push(_loc1_);
            this._goodsListContainer.addChild(_loc1_);
            _loc3_++;
         }
      }
    createRareGoodsList() {
         var _loc4_ = 0;
         var _loc1_ = 0;
         var _loc3_ = 0;
         var _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.MysteryShopFrame.BaseItemView");
            _loc4_ = _loc3_ / 4;
            _loc1_ = _loc3_ % 4;
            _loc2_.x = 9 + _loc1_ * 55;
            _loc2_.y = 9 + _loc4_ * 55;
            this._rareGoodsList.push(_loc2_);
            this._rareGoodsListContainer.addChild(_loc2_);
            _loc3_++;
         }
      }
    createExchangeGoodsList() {
         var _loc4_ = 0;
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc1_ = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new ($.C("auction.view.mysteryshop.ExchangeGoodsItem"))();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            this._exchangeGoodsList.push(_loc1_);
            this._exchangeGoodsListContainer.addChild(_loc1_);
            _loc3_++;
         }
      }
    updateGoodsListData() {
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this._buyGoodsList.length)
         {
            if(this.mysteryShopModel.goodsList && this.mysteryShopModel.goodsList[_loc1_])
            {
               this._buyGoodsList[_loc1_].data = $.as(this.mysteryShopModel.goodsList[_loc1_], $.C("mvc.module.auction.BuyGoodsInfo"));
            }
            else
            {
               this._buyGoodsList[_loc1_].data = null;
            }
            _loc1_++;
         }
      }
    updateRareGoodsListData() {
         var _loc3_ = 0;
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc4_ = null;
         if(this.mysteryShopModel.rareGoodsList)
         {
            _loc3_ = 0;
            while(_loc3_ < this._rareGoodsList.length)
            {
               if(this.mysteryShopModel.rareGoodsList[_loc3_])
               {
                  _loc1_ = $.as(this.mysteryShopModel.rareGoodsList[_loc3_], $.C("mvc.module.shop.ShopGoodsInfo"));
                  _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc1_.ItemId);
                  _loc4_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                  _loc4_.templateId = _loc2_.TemplateId;
                  _loc4_.validDate = _loc1_.ValidDate;
                  this._rareGoodsList[_loc3_].data = _loc4_;
               }
               _loc3_++;
            }
         }
      }
    updateExchangeGoodsListData() {
         var _loc1_ = 0;
         if(this.mysteryShopModel.showGoodsList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._exchangeGoodsList.length)
            {
               if(this.mysteryShopModel.showGoodsList[_loc1_])
               {
                  this._exchangeGoodsList[_loc1_].data = $.as(this.mysteryShopModel.showGoodsList[_loc1_], $.C("mvc.module.shop.ShopGoodsInfo"));
               }
               else
               {
                  this._exchangeGoodsList[_loc1_].data = null;
               }
               _loc1_++;
            }
         }
      }
    __refreshFrameView(param1) {
         this.__refreshCountView(null);
         this.updateGoodsListData();
         this.refreshTimeView();
      }
    refreshTimeView() {
         this._countTime.timeCount = this.mysteryShopModel.remainTime;
         if(this._countTime.timeCount == 0)
         {
            $.C("managers.MysteryShopManager").instance.sendRefreshGoodsList(false);
         }
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    __onHelpClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.mysteryShopHelpFrame");
         _loc2_.show();
      }
    __onQuickRefreshClick(param1) {
         var _loc3_ = null;
         var _loc5_ = false;
         var _loc4_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this.quickRefreshAlert($.bind(this, "startRefreshAlertBack")))
         {
            return;
         }
         var _loc2_ = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point);
         if($.C("yishi.manager.SharedManager").instance.mysteryShopRefreshUseBind)
         {
            _loc2_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point + $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.giftToken;
         }
         if(_loc2_ < this.mysteryShopModel.refreshRewardNeedPay)
         {
            $.C("yishi.manager.RechargeAlertMannager").show();
            return;
         }
         if(this._canBuyCount > 0)
         {
            _loc3_ = $.C("yishi.manager.SharedManager").instance.mysteryShopRefreshUseBindDate;
            _loc5_ = Boolean($.C("yishi.manager.SharedManager").instance.mysteryShopRefreshUseBind);
            _loc4_ = new Date();
            if(_loc3_.month <= _loc3_.month && _loc3_.date <= _loc4_.date)
            {
               this.checkRareAndQuickRefresh($.C("yishi.manager.SharedManager").instance.mysteryShopRefreshUseBind);
            }
            else
            {
               this.checkRareAndQuickRefresh($.C("yishi.manager.SharedManager").instance.mysteryShopRefreshUseBind);
            }
         }
         else
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData"));
         }
      }
    checkRareAndQuickRefresh(param1 = true) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         if($.C("managers.MysteryShopManager").instance.model.hasRareGoods)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "quickRefreshCallBack")];
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.MysteryShopFrame.quickRefreshTipTxt");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
         else
         {
            $.C("managers.MysteryShopManager").instance.sendRefreshGoodsList(true,param1);
         }
      }
    quickRefreshCallBack(param1, param2) {
         if(param1)
         {
            $.C("managers.MysteryShopManager").instance.sendRefreshGoodsList(true,param2);
         }
      }
    quickRefreshAlert(param1 = null) {
         var _loc8_ = null;
         var _loc7_ = null;
         var _loc3_ = null;
         var _loc4_ = $.C("yishi.manager.SharedManager").instance.mysteryShopRefreshCheckDate;
         var _loc6_ = Boolean($.C("yishi.manager.SharedManager").instance.mysteryShopRefresh);
         var _loc5_ = new Date();
         var _loc2_ = false;
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopRefreshAlertFrame");
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyTimeView.quickRefreshTip",this.mysteryShopModel.refreshRewardNeedPay);
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,$.bind(this, "startRefreshAlertBack"),null,"left",1,false,this.mysteryShopModel.refreshRewardNeedPay);
         }
         return _loc2_;
      }
    startRefreshAlertBack(param1, param2) {
         $.C("yishi.manager.SharedManager").instance.mysteryShopRefresh = param1;
         $.C("yishi.manager.SharedManager").instance.mysteryShopRefreshCheckDate = new Date();
         $.C("yishi.manager.SharedManager").instance.saveMysteryShopRefreshCheck();
         if(param1)
         {
            $.C("yishi.manager.SharedManager").instance.mysteryShopRefreshUseBind = param2;
            $.C("yishi.manager.SharedManager").instance.mysteryShopRefreshUseBindDate = new Date();
            $.C("yishi.manager.SharedManager").instance.saveMysteryShopRefreshUseBind();
         }
         this.refreshGoodsListPayCall(param2);
      }
    refreshGoodsListPayCall(param1) {
         var _loc2_ = 0;
         if(param1)
         {
            _loc2_ = this.playerInfo.point + this.playerInfo.giftToken;
         }
         else
         {
            _loc2_ = $.int(this.playerInfo.point);
         }
         if(_loc2_ < this.mysteryShopModel.refreshRewardNeedPay)
         {
            $.C("yishi.manager.RechargeAlertMannager").show();
            return;
         }
         this.checkRareAndQuickRefresh(param1);
         if(this.mysteryShopControler.frame)
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = this.mysteryShopControler.frame;
         }
      }
    __timeCompleteHandler(param1) {
         $.C("managers.MysteryShopManager").instance.sendRefreshGoodsList(false);
         this._countTime.timeCount = this.mysteryShopModel.remainTime;
      }
    get groups() {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
    show() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.MysteryShopFrame.titleText");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
      }
    get mysteryShopManager() {
         return $.C("managers.MysteryShopManager").instance;
      }
    get mysteryShopModel() {
         return $.C("managers.MysteryShopManager").instance.model;
      }
    get mysteryShopControler() {
         return $.C("yishi.manager.FrameControllerManager").instance.mysteryShopController;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    cleanList() {
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         while(this._buyGoodsList.length > 0)
         {
            _loc1_ = this._buyGoodsList.pop();
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         while(this._rareGoodsList.length > 0)
         {
            _loc2_ = this._rareGoodsList.pop();
            if(_loc2_)
            {
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         while(this._exchangeGoodsList.length > 0)
         {
            _loc3_ = this._exchangeGoodsList.pop();
            if(_loc3_)
            {
               if(_loc3_.parent)
               {
                  _loc3_.parent.removeChild(_loc3_);
               }
               _loc3_.dispose();
               _loc3_ = null;
            }
         }
      }
    dispose() {
         this.removeEvent();
         this.cleanList();
         $.C("flash.ui.Mouse").cursor = "auto";
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._helpBtn);
         this._helpBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buttongroup);
         this._buttongroup = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._page1);
         this._page1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._page2);
         this._page2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._frameLeftBackBg);
         this._frameLeftBackBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._frameRightBackBg);
         this._frameRightBackBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftBack);
         this._leftBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightBack);
         this._rightBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._projectRareItem);
         this._projectRareItem = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._projectLuckyPlayer);
         this._projectLuckyPlayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrolPanel);
         this._scrolPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bottomBg);
         this._bottomBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dailyCountTxt);
         this._dailyCountTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countTimeTxt);
         this._countTimeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countTime);
         this._countTime = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buyTipTxt);
         this._buyTipTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._quickRefreshBtn);
         this._quickRefreshBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consumePointsBg);
         this._consumePointsBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pageBg);
         this._pageBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pageTxt);
         this._pageTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lastPageBtn);
         this._lastPageBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextPageBtn);
         this._nextPageBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodsListContainer);
         this._goodsListContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rareGoodsListContainer);
         this._rareGoodsListContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._exchangeGoodsListContainer);
         this._exchangeGoodsListContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consumePointsTxt);
         this._consumePointsTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("shop");
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set mysteryShopManager(v) { super.mysteryShopManager = v; }
    set mysteryShopModel(v) { super.mysteryShopModel = v; }
    set mysteryShopControler(v) { super.mysteryShopControler = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__MysteryShopFrame, "auction.view.mysteryshop.MysteryShopFrame", ["IManualSize"]);
  return __MysteryShopFrame;
}
deps["auction.view.mysteryshop.MysteryShopFrame"] = ["auction.view.mysteryshop.BuyGoodsItem", "auction.view.mysteryshop.ExchangeGoodsItem", "auction.view.mysteryshop.MysteryShopEventItem", "chat.datas.ChatData", "chat.utils.ChatFormat", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.geom.Rectangle", "flash.ui.Mouse", "manager.LanguageMgr", "managers.MysteryShopManager", "mvc.module.auction.BuyGoodsInfo", "mvc.module.auction.MysteryShopEventInfo", "mvc.module.shop.ShopGoodsInfo", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.manager.SharedManager", "yishi.manager.TempleteManager", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["auction.view.record.AuctionRecordBottomBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionRecordBottomBar extends __Base {
    static $fields(self) {
    self._diamondBack = null;
    self._diamondTxt = null;
    self._pageControl = null;
    self._auctionBtn = null;
    self._fixedPriceBtn = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._diamondBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.diamondBackImg3");
         this._diamondTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.DiamondTxt3");
         this._diamondTxt.text = "10000";
         this._pageControl = new ($.C("auction.view.common.AuctionPageControlComponent"))();
         this._pageControl.x = 337;
         this._pageControl.y = 17;
         this._pageControl.update($.C("yishi.manager.FrameControllerManager").instance.auctionController.model.recordList);
         this._auctionBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.auctionBtn3");
         this._fixedPriceBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.fixedPriceBtn3");
         this.addChild(this._diamondBack);
         this.addChild(this._diamondTxt);
         this.addChild(this._pageControl);
         this.addChild(this._auctionBtn);
         this.addChild(this._fixedPriceBtn);
         var _loc1_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
         _loc1_.addEventListener("POINT_CHANGE",$.bind(this, "onPointChanged"),false,0,true);
         this.onPointChanged(null);
      }
    onPointChanged(param1) {
         this._diamondTxt.text = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point + "";
      }
    getAuctionBtn() {
         return this._auctionBtn;
      }
    getFixedPriceBtn() {
         return this._fixedPriceBtn;
      }
    getPageControlComp() {
         return this._pageControl;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
  }
  $.meta(__AuctionRecordBottomBar, "auction.view.record.AuctionRecordBottomBar", ["Disposeable"]);
  return __AuctionRecordBottomBar;
}
deps["auction.view.record.AuctionRecordBottomBar"] = ["auction.view.common.AuctionPageControlComponent", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager"];

defs["auction.view.record.AuctionRecordResultPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionRecordResultPane extends __Base {
    static $fields(self) {
    self._border = null;
    self._listTitle = null;
    self._listComponent = null;
    self._bottomBar = null;
    self._corner1 = null;
    self._corner2 = null;
    self._corner3 = null;
    self._corner4 = null;
    self._data = null;
    self._inputFrame = null;
    self._currentOrderBy = 0;
    self._currentOrderType = 0;
    }
    constructor() {
         super();
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.auctionController.model;
         this._data = _loc1_.recordList;
         this.init();
         this.addHandler();
      }
    init() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.record.resultBack");
         this.addChild(this._border);
         var _loc1_ = $.C("auction.view.common.AuctionListColWidthConst").long;
         var _loc2_ = $.C("auction.view.common.AuctionListColWidthConst").longX;
         this._listTitle = new ($.C("auction.view.common.AuctionListTitleComponent"))("auction.listTitleBmdL",_loc1_,_loc2_);
         this._listTitle.x = 1;
         this._listTitle.y = 2;
         this.addChild(this._listTitle);
         this._listComponent = new ($.C("auction.view.common.AuctionListComponent"))($.C("auction.view.common.AuctionListItem2"),9,-3);
         this._listComponent.setData(this._data.getList());
         this._listComponent.x = 3;
         this._listComponent.y = 33;
         this._listComponent.callBack = $.bind(this, "onAuction");
         this.addChild(this._listComponent);
         this._bottomBar = new ($.C("auction.view.record.AuctionRecordBottomBar"))();
         this._bottomBar.x = 3;
         this._bottomBar.y = 398;
         this.addChild(this._bottomBar);
         this._corner1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.recordCorner1");
         this._corner2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.recordCorner2");
         this._corner3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.recordCorner3");
         this._corner4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.recordCorner4");
         this.addChild(this._corner1);
         this.addChild(this._corner2);
         this.addChild(this._corner3);
         this.addChild(this._corner4);
      }
    addHandler() {
         this._data.addEventListener("change",$.bind(this, "onListDataChange"));
         this._bottomBar.getPageControlComp().getPreBtn().addEventListener("click",$.bind(this, "onPrePageClick"));
         this._bottomBar.getPageControlComp().getNextBtn().addEventListener("click",$.bind(this, "onNextPageClick"));
         this._bottomBar.getAuctionBtn().addEventListener("click",$.bind(this, "onAuctionClick"));
         this._bottomBar.getFixedPriceBtn().addEventListener("click",$.bind(this, "onFixedPriceClick"));
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.auctionController.model;
         _loc1_.addEventListener($.C("events.AuctionEvent").REFRESH_RECORD,$.bind(this, "onRefreshEvent"));
         this._listTitle.titleGrade.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleTime.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titlePrice.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleCurPrice.addEventListener("click",$.bind(this, "__onTitleClick"));
      }
    restoreListTitle() {
         this._currentOrderBy = this._currentOrderType = 0;
         this._listTitle.currentSelectBut(null);
      }
    __onTitleClick(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("com.pickgliss.ui.controls.TitleButton"));
         switch(_loc2_)
         {
            case this._listTitle.titleGrade:
               this._currentOrderBy = 1;
               break;
            case this._listTitle.titleTime:
               this._currentOrderBy = 2;
               break;
            case this._listTitle.titlePrice:
               this._currentOrderBy = 4;
               break;
            case this._listTitle.titleCurPrice:
               this._currentOrderBy = 3;
         }
         if(this._listTitle.currentSelectBut(_loc2_) == 2)
         {
            this._currentOrderType = 1;
         }
         else
         {
            this._currentOrderType = 2;
         }
         $.C("mediator.AuctionMessageSender").sendMyAuctionListHistoryReq(this._data.currentPage,9,1,this._currentOrderBy,this._currentOrderType);
      }
    onRefreshEvent(param1) {
         $.C("mediator.AuctionMessageSender").sendMyAuctionListHistoryReq(this._data.currentPage,9,1,this._currentOrderBy,this._currentOrderType);
      }
    onPrePageClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("mediator.AuctionMessageSender").sendMyAuctionListHistoryReq(this._bottomBar.getPageControlComp().getData().currentPage - 1,9,1,this._currentOrderBy,this._currentOrderType);
      }
    onListDataChange(param1) {
         this._listComponent.setData(this._data.getList());
      }
    onNextPageClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("mediator.AuctionMessageSender").sendMyAuctionListHistoryReq(this._bottomBar.getPageControlComp().getData().currentPage + 1,9,1,this._currentOrderBy,this._currentOrderType);
      }
    onAuctionClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.onAuction();
      }
    onAuction() {
         var _loc1_ = this._listComponent.getSelectedItemData();
         if(_loc1_)
         {
            if(!$.C("auction.view.common.AuctionChecker").checkAuction(_loc1_))
            {
               return;
            }
            this._inputFrame = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionInputFrame");
            this._inputFrame.setData(_loc1_);
            this._inputFrame.backCall = $.bind(this, "inputPriceCallback");
            this._inputFrame.show();
         }
         else
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.PleaseSelectGood"));
         }
      }
    inputPriceCallback(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc7_ = null;
         var _loc8_ = null;
         var _loc9_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc2_ = null;
         var _loc10_ = null;
         var _loc4_ = null;
         var _loc3_ = this._listComponent.getSelectedItemData();
         if(param1 <= _loc3_.currPrice)
         {
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc9_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("Action.UnderCurrentPrice");
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [];
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc9_,_loc5_,_loc7_,"",true,false,false,2);
         }
         else if(param1 >= _loc3_.fixedPrice)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "isFixedBuy"),_loc3_.goodId,_loc3_.fixedPrice];
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc10_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("Action.OuterFixedPrice");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc10_,_loc4_,_loc6_,_loc2_,true,false,false,2);
         }
         else
         {
            $.C("mediator.AuctionMessageSender").sendAuctionGoods(_loc3_.goodId,param1);
         }
      }
    isFixedBuy(param1, param2, param3, param4) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if(param1)
         {
            $.C("mediator.AuctionMessageSender").sendFixPriceItemMessage(param3,param4);
         }
      }
    onFixedPriceClick(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc4_ = this._listComponent.getSelectedItemData();
         if(_loc4_)
         {
            if(!$.C("auction.view.common.AuctionChecker").checkFixPrice(_loc4_))
            {
               return;
            }
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "fixedPriceBuy"),_loc4_.goodId,_loc4_.fixedPrice];
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("Auction.FixedPriceBuy");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2);
         }
         else
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.PleaseSelectGood"));
         }
      }
    fixedPriceBuy(param1, param2, param3, param4) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if(param1)
         {
            $.C("mediator.AuctionMessageSender").sendFixPriceItemMessage(param3,param4);
         }
      }
    dispose() {
         if(this._inputFrame)
         {
            this._inputFrame.dispose();
            this._inputFrame = null;
         }
         this._listTitle.titleGrade.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleTime.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titlePrice.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleCurPrice.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._data.removeEventListener("change",$.bind(this, "onListDataChange"));
         this._bottomBar.getPageControlComp().getPreBtn().removeEventListener("click",$.bind(this, "onPrePageClick"));
         this._bottomBar.getPageControlComp().getNextBtn().removeEventListener("click",$.bind(this, "onNextPageClick"));
         this._bottomBar.getAuctionBtn().removeEventListener("click",$.bind(this, "onAuctionClick"));
         this._bottomBar.getFixedPriceBtn().removeEventListener("click",$.bind(this, "onFixedPriceClick"));
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.auctionController.model;
         _loc1_.removeEventListener($.C("events.AuctionEvent").REFRESH_RECORD,$.bind(this, "onRefreshEvent"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
  }
  $.meta(__AuctionRecordResultPane, "auction.view.record.AuctionRecordResultPane", ["Disposeable"]);
  return __AuctionRecordResultPane;
}
deps["auction.view.record.AuctionRecordResultPane"] = ["auction.view.AuctionAlert", "auction.view.common.AuctionChecker", "auction.view.common.AuctionListColWidthConst", "auction.view.common.AuctionListComponent", "auction.view.common.AuctionListItem2", "auction.view.common.AuctionListTitleComponent", "auction.view.record.AuctionRecordBottomBar", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.TitleButton", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "events.AuctionEvent", "flash.display.Sprite", "manager.LanguageMgr", "mediator.AuctionMessageSender", "yishi.manager.FrameControllerManager", "yishi.utils.SimpleAlertHelper"];

defs["auction.view.sell.AuctionBagCellClickMediator"] = function define($) {
  const __Base = $.Object;
  class __AuctionBagCellClickMediator extends __Base {
    static $fields(self) {
    self._cell = null;
    }
    constructor() {
         super();
      }
    register(param1) {
         this._cell = $.as(param1, $.C("auction.view.sell.AuctionSellBagCell"));
         if(this._cell.icon)
         {
            $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this._cell.icon);
            this._cell.icon.addEventListener("interactive_click",$.bind(this, "__mouseClickByClicker"));
            this._cell.icon.addEventListener("interactive_double_click",$.bind(this, "__mouseDoubleClick"));
         }
      }
    __mouseClickByClicker(param1) {
         var _loc2_ = null;
         if(!this._cell || !this._cell.data || !this._cell.isNormalFilter)
         {
            return;
         }
         if(this._cell.data.isLock)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("vicepassword.description10");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("yishi.manager.NotificationManager").instance.sendNotification("DRAG_ITEM_BagNotic",[this._cell,this._cell.data.count]);
      }
    __mouseDoubleClick(param1) {
         var _loc2_ = null;
         if(!this._cell || !this._cell.data || !this._cell.isNormalFilter)
         {
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("024",true);
         if(this._cell.data.isLock)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("vicepassword.description10");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("auction.view.sell.AuctionGoodMoveControl").moveToTargetCell(this._cell);
      }
    unregister(param1) {
         if(this._cell && this._cell.icon)
         {
            $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this._cell.icon);
            this._cell.icon.removeEventListener("interactive_click",$.bind(this, "__mouseClickByClicker"));
            this._cell.icon.removeEventListener("interactive_double_click",$.bind(this, "__mouseDoubleClick"));
            this._cell = null;
         }
      }
  }
  $.meta(__AuctionBagCellClickMediator, "auction.view.sell.AuctionBagCellClickMediator", ["IMediator"]);
  return __AuctionBagCellClickMediator;
}
deps["auction.view.sell.AuctionBagCellClickMediator"] = ["auction.view.sell.AuctionGoodMoveControl", "auction.view.sell.AuctionSellBagCell", "com.pickgliss.utils.DoubleClickManager", "com.pickgliss.utils.SoundManager", "manager.LanguageMgr", "yishi.manager.NotificationManager", "yishi.view.tips.MessageTipManager"];

defs["auction.view.sell.AuctionBagCellDropMediator"] = function define($) {
  const __Base = $.C("cell.mediator.CellDropMediator");
  class __AuctionBagCellDropMediator extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.storeController;
      }
    get model() {
         return this.control.model;
      }
    getData() {
         return null;
      }
    starItemDrag(param1 = -1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("com.pickgliss.utils.SoundManager").instance.play("003");
         this._cell.isDraging = true;
         var _loc3_ = this.getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_ = $.C("yishi.manager.DragManager").getInstance().starDrag(this._cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = $.bind(this, "beDropHitCallBack");
         _loc2_.dropChecks = [$.C("yishi.view.community.BaseItemView"),$.C("flash.display.Stage")];
         this._cell.setGrayFilter();
      }
    beDropHitCallBack(param1) {
         var _loc5_ = null;
         var _loc4_ = 0;
         var _loc2_ = null;
         var _loc3_ = null;
         if($.is(param1.dropTarget, $.C("auction.view.sell.AuctionSellTargetCell")))
         {
            _loc5_ = $.as(param1.dropTarget, $.C("auction.view.sell.AuctionSellTargetCell"));
            if(this._cell.data.isLock)
            {
               _loc3_ = $.C("manager.LanguageMgr").GetTranslation("vicepassword.description10");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
               $.C("yishi.manager.NotificationManager").instance.sendNotification("ITEM_DROP_BagNotic",[this._cell,true]);
               return;
            }
            $.C("auction.view.sell.AuctionGoodMoveControl").moveToTargetCell(this._cell);
            param1.stopImmediatePropagation();
         }
         else
         {
            $.C("yishi.manager.NotificationManager").instance.sendNotification("ITEM_DROP_BagNotic",[this._cell,true]);
         }
      }
    set control(v) { super.control = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__AuctionBagCellDropMediator, "auction.view.sell.AuctionBagCellDropMediator", []);
  return __AuctionBagCellDropMediator;
}
deps["auction.view.sell.AuctionBagCellDropMediator"] = ["auction.view.sell.AuctionGoodMoveControl", "auction.view.sell.AuctionSellTargetCell", "cell.mediator.CellDropMediator", "com.pickgliss.utils.SoundManager", "flash.display.Stage", "manager.LanguageMgr", "yishi.manager.DragManager", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.view.community.BaseItemView", "yishi.view.tips.MessageTipManager"];

defs["auction.view.sell.AuctionBagFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __AuctionBagFrame extends __Base {
    static $fields(self) {
    self._items = null;
    self._goodsType = 0;
    self.panelParent = null;
    }
    constructor(param1 = 1) {
         $.pre(new.target, (__s) => {
         __s._goodsType = param1;
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
         this.addHandler();
      }
    initView() {
         this._items = $.C("yishi.manager.GoodsManager").instance.getGeneralBagList();
         this.addToContent(this.getBagPane());
         this.panelParent = __AuctionBagFrame.pane.parent;
         this.getBagPane().defaultView(this._goodsType);
      }
    addHandler() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.hide();
         }
      }
    show() {
         if(this._goodsType == 2)
         {
            this.titleText = $.C("manager.LanguageMgr").GetTranslation("pet.PetFrame.title");
         }
         else
         {
            this.titleText = $.C("manager.LanguageMgr").GetTranslation("Auction.BagTitle");
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,2);
         this.getBagPane().setScrollPosition();
         $.C("auction.view.sell.AuctionGoodMoveControl").stopBlink();
      }
    isOpen() {
         if(this.parent)
         {
            return true;
         }
         return false;
      }
    hide() {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("auction.view.sell.AuctionGoodMoveControl").playBlink();
         $.C("auction.view.sell.AuctionGoodMoveControl").isFirstOpenSellPane = false;
      }
    getBagPane() {
         if(!__AuctionBagFrame.pane)
         {
            __AuctionBagFrame.pane = new ($.C("auction.view.sell.AuctionSellBagPane"))(7,8);
            __AuctionBagFrame.pane.x = -2;
            __AuctionBagFrame.pane.y = 2;
         }
         return __AuctionBagFrame.pane;
      }
    dispose() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(__AuctionBagFrame.pane && this.panelParent && __AuctionBagFrame.pane.parent == this.panelParent)
         {
            __AuctionBagFrame.pane.parent.removeChild(__AuctionBagFrame.pane);
         }
         this.panelParent = null;
         super.dispose();
      }
  }
  $.meta(__AuctionBagFrame, "auction.view.sell.AuctionBagFrame", []);
  $.statics(__AuctionBagFrame, () => {
    __AuctionBagFrame.pane = null;
  });
  return __AuctionBagFrame;
}
deps["auction.view.sell.AuctionBagFrame"] = ["auction.view.sell.AuctionGoodMoveControl", "auction.view.sell.AuctionSellBagPane", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "manager.LanguageMgr", "yishi.manager.GoodsManager"];

defs["auction.view.sell.AuctionGoodMoveControl"] = function define($) {
  const __Base = $.Object;
  class __AuctionGoodMoveControl extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static init(param1, param2, param3) {
         __AuctionGoodMoveControl._targetCell = param1;
         __AuctionGoodMoveControl.bagPane = param2;
         __AuctionGoodMoveControl._sellPane = param3;
      }
    static playBlink() {
         if(!__AuctionGoodMoveControl._targetCell.data && __AuctionGoodMoveControl.isFirstOpenSellPane)
         {
            __AuctionGoodMoveControl._sellPane.playBlink();
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = __AuctionGoodMoveControl._sellPane;
      }
    static stopBlink() {
         __AuctionGoodMoveControl._sellPane.stopBlink();
      }
    static delTargetData() {
         if(__AuctionGoodMoveControl.bagPane && $.is(__AuctionGoodMoveControl.bagPane, $.C("auction.view.sell.PetSellView")))
         {
            ($.as(__AuctionGoodMoveControl.bagPane, $.C("auction.view.sell.PetSellView"))).refresh();
         }
         if(__AuctionGoodMoveControl._storeTargetData && __AuctionGoodMoveControl._storeTargetData.id == __AuctionGoodMoveControl._targetCell.data.id)
         {
            if(__AuctionGoodMoveControl._targetCell.data)
            {
               __AuctionGoodMoveControl._targetCell.data = null;
            }
         }
         else
         {
            $.C("yishi.manager.GoodsManager").instance.dispatchEvent(new ($.C("bag.events.BagEvent"))("RETURN_REFRESH",null));
         }
      }
    static storeTargetData() {
         if(__AuctionGoodMoveControl._storeTargetData)
         {
            __AuctionGoodMoveControl._storeTargetData = null;
         }
         __AuctionGoodMoveControl._storeTargetData = __AuctionGoodMoveControl._targetCell.data;
      }
    static moveToTargetCell(param1) {
         if(__AuctionGoodMoveControl._targetCell.data)
         {
            $.C("yishi.manager.NotificationManager").instance.sendNotification("ITEM_DROP_BagNotic",[__AuctionGoodMoveControl._targetCell]);
            __AuctionGoodMoveControl._targetCell.data = null;
         }
         param1.setGrayFilter();
         __AuctionGoodMoveControl._targetCell.data = param1.data;
         __AuctionGoodMoveControl.checkSellCount(param1);
         __AuctionGoodMoveControl._targetCell.setNumText(0);
      }
    static checkSellCount(param1) {
         var _loc2_ = null;
         if(param1.data && param1.data.count > 1)
         {
            __AuctionGoodMoveControl._sellPane.setPriceNull();
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionSellNumFrame");
            _loc2_.show(param1,__AuctionGoodMoveControl._targetCell);
            _loc2_.callBack = __AuctionGoodMoveControl._sellPane.checkData;
         }
         else
         {
            param1.data.willSellCount = 1;
            __AuctionGoodMoveControl._targetCell.setNumText(1);
            __AuctionGoodMoveControl._sellPane.checkData();
         }
      }
    static dispose() {
         __AuctionGoodMoveControl._targetCell = null;
         __AuctionGoodMoveControl.bagPane = null;
      }
  }
  $.meta(__AuctionGoodMoveControl, "auction.view.sell.AuctionGoodMoveControl", []);
  $.statics(__AuctionGoodMoveControl, () => {
    __AuctionGoodMoveControl._targetCell = null;
    __AuctionGoodMoveControl.bagPane = null;
    __AuctionGoodMoveControl._sellPane = null;
    __AuctionGoodMoveControl._storeTargetData = null;
    __AuctionGoodMoveControl.isFirstOpenSellPane = true;
  });
  return __AuctionGoodMoveControl;
}
deps["auction.view.sell.AuctionGoodMoveControl"] = ["auction.view.sell.PetSellView", "bag.events.BagEvent", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "yishi.manager.GoodsManager", "yishi.manager.NotificationManager"];

defs["auction.view.sell.AuctionSellBagCell"] = function define($) {
  const __Base = $.C("yishi.view.community.BaseItemView");
  class __AuctionSellBagCell extends __Base {
    static $fields(self) {
    self._equipStyle = null;
    self._heroEquipIcon = null;
    self._shape = null;
    self._registed = false;
    self._mediatorKey = null;
    }
    constructor() {
         super();
         this.createShape();
      }
    set equipStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
      }
    onProppertiesUpdate() {
         super.onProppertiesUpdate();
         if(this._changedPropeties["equip"])
         {
            this._heroEquipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(this._equipStyle);
            this._heroEquipIcon.visible = false;
         }
      }
    addChildren() {
         super.addChildren();
         if(this._heroEquipIcon)
         {
            this.addChild(this._heroEquipIcon);
         }
      }
    createShape() {
         if(!this._shape)
         {
            this._shape = new ($.C("flash.display.Shape"))();
         }
         this._shape.graphics.beginFill(16711680);
         this._shape.graphics.drawRect(0,0,41,41);
         this._shape.graphics.endFill();
         this._shape.x = 2;
         this._shape.y = 2;
         this._shape.blendMode = "multiply";
      }
    removeShape() {
         if(this._shape && this._shape.parent)
         {
            this._shape.parent.removeChild(this._shape);
         }
      }
    checkGoodsByHero(param1 = true) {
         if($.C("bag.helper.GoodsCheck").isGradeFix(this.thane,this.data.templateInfo,param1))
         {
            return $.C("bag.helper.GoodsCheck").checkGoodsByHero(this.data,this.thane,param1);
         }
         return false;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    set data(param1) {
         var _loc2_ = 0;
         super.data = param1;
         this.removeShape();
         if(!this._registed)
         {
            this.registerMediator();
         }
         if(this._heroEquipIcon)
         {
            this._heroEquipIcon.visible = false;
            if(param1)
            {
               _loc2_ = $.int($.C("yishi.manager.ArmyManager").instance.thane.id);
               if(param1.objectId == _loc2_)
               {
                  this._heroEquipIcon.visible = true;
                  this._icon.tipStyle = "yishi.view.tips.goods.EquipTip";
               }
            }
         }
         if(!param1)
         {
            return;
         }
         if(!param1.templateInfo)
         {
            return;
         }
         if($.C("bag.helper.GoodsCheck").isEquip(param1.templateInfo) && !this.checkGoodsByHero(false) && this._shape)
         {
            this.addChild(this._shape);
         }
      }
    registerMediator() {
         this._registed = true;
         var _loc1_ = [$.C("auction.view.sell.AuctionBagCellClickMediator"),$.C("auction.view.sell.AuctionBagCellDropMediator")];
         this._mediatorKey = $.C("yishi.manager.MediatorMananger").instance.registerMediatorList(_loc1_,this,"auction.view.sell.AuctionSellBagCell");
      }
    dispose() {
         $.C("yishi.manager.MediatorMananger").instance.unregisterMediatorList(this._mediatorKey,this);
         super.dispose();
         this._heroEquipIcon = null;
      }
    get width() {
         return 45;
      }
    get height() {
         return 45;
      }
    get equipStyle() { return super.equipStyle; }
    set thane(v) { super.thane = v; }
    get data() { return super.data; }
    set width(v) { super.width = v; }
    set height(v) { super.height = v; }
  }
  $.meta(__AuctionSellBagCell, "auction.view.sell.AuctionSellBagCell", []);
  $.statics(__AuctionSellBagCell, () => {
    __AuctionSellBagCell.P_equip = "equip";
    __AuctionSellBagCell.NAME = "auction.view.sell.AuctionSellBagCell";
  });
  return __AuctionSellBagCell;
}
deps["auction.view.sell.AuctionSellBagCell"] = ["auction.view.sell.AuctionBagCellClickMediator", "auction.view.sell.AuctionBagCellDropMediator", "bag.helper.GoodsCheck", "com.pickgliss.ui.ComponentFactory", "flash.display.Shape", "yishi.manager.ArmyManager", "yishi.manager.MediatorMananger", "yishi.view.community.BaseItemView"];

defs["auction.view.sell.AuctionSellBagPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionSellBagPane extends __Base {
    static $fields(self) {
    self._bg1 = null;
    self._list = null;
    self._bagScroll = null;
    self._defaultCount = 0;
    self._rowCount = 0;
    self._columnCount = 0;
    self._data = null;
    self._itemList = null;
    self._itemDic = new ($.C("yishi.utils.SimpleDictionary"))(true);
    self._type = 1;
    }
    constructor(param1, param2) {
         super();
         this._rowCount = param1;
         this._columnCount = param2;
         this._defaultCount = this._rowCount * this._columnCount;
         $.C("auction.view.sell.AuctionSellBagCell");
         this.initView();
         this.initEvent();
         this.initList();
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.storeController.model;
      }
    get uArmy() {
         return $.C("yishi.manager.ArmyManager").instance.army;
      }
    initView() {
         this._bg1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.bag.Bg");
         this._list = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.bag.SimpleTileList",[7]);
         this._bagScroll = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.bag.Scroll");
         this._bagScroll.vUnitIncrement = 8;
         this._bagScroll.setView(this._list);
         this.addChild(this._bg1);
         this.addChild(this._bagScroll);
      }
    initList() {
         var _loc2_ = 0;
         var _loc1_ = null;
         if(this._rowCount > 0 && this._columnCount > 0)
         {
            this._itemList = new $.Vector();
            this._list.beginChanges();
            _loc2_ = 0;
            while(_loc2_ < this._defaultCount)
            {
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("acution.BagCell");
               _loc1_.pos = -1;
               this._list.addChild(_loc1_);
               this._itemList.push(_loc1_);
               _loc2_++;
            }
            this._list.hSpace = 3;
            this._list.commitChanges();
            this._bagScroll.invalidateViewport();
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    sortHeroEquip(param1, param2) {
         if(param1.templateInfo.NeedGrades > param2.templateInfo.NeedGrades)
         {
            return -1;
         }
         if(param1.templateInfo.NeedGrades == param2.templateInfo.NeedGrades)
         {
            if(param1.templateInfo.Profile > param2.templateInfo.Profile)
            {
               return -1;
            }
            if(param1.templateInfo.Profile < param2.templateInfo.Profile)
            {
               return 1;
            }
            return 0;
         }
         return 1;
      }
    refreshView() {
         var _loc1_ = 0;
         var _loc2_ = null;
         this.clearGoods();
         this.refreshBag();
         _loc1_ = 0;
         while(_loc1_ < this._data.length)
         {
            _loc2_ = $.as(this._data[_loc1_], $.C("yishi.datas.goods.GoodsInfo"));
            this._itemList[_loc1_].bagType = _loc2_.bagType;
            this._itemList[_loc1_].pos = _loc2_.pos;
            this._itemList[_loc1_].data = _loc2_;
            this._itemDic.add(_loc2_.pos + "_" + _loc2_.objectId + "_" + _loc2_.bagType,this._itemList[_loc1_]);
            _loc1_++;
         }
      }
    setScrollPosition() {
         var _loc1_ = new ($.C("com.pickgliss.geom.IntPoint"))(0,0);
         if(this._bagScroll)
         {
            this._bagScroll.viewPort.viewPosition = _loc1_;
         }
      }
    clearGoods() {
         for (var _loc1_ of $.values(this._itemList))
         {
            _loc1_.data = null;
         }
         for (var _loc2_ of $.values(this._itemDic))
         {
            _loc2_.data = null;
            _loc2_.pos = -1;
         }
         this._itemDic.clear();
      }
    refreshBag() {
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc4_ = this._rowCount * ($.int((this._data.length + this._rowCount - 1) / this._rowCount));
         var _loc1_ = _loc4_ < this._defaultCount ? this._defaultCount : _loc4_;
         if(this._itemList.length < _loc1_)
         {
            this.addItems(_loc1_ - this._itemList.length);
         }
         else if(this._itemList.length > _loc1_ && this._itemList.length > this._defaultCount)
         {
            this.removeItems(this._itemList.length - _loc1_);
         }
      }
    removeItems(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc2_ = null;
         this._list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = this._itemList.pop();
            this._list.removeChild(_loc2_);
            _loc2_.dispose();
            _loc3_++;
         }
         if(this._itemList.length <= this._defaultCount)
         {
            this._list.hSpace = 3;
         }
         else
         {
            this._list.hSpace = 0;
         }
         this._list.commitChanges();
         this._bagScroll.invalidateViewport();
      }
    addItems(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc2_ = null;
         this._list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("acution.BagCell");
            _loc2_.pos = -1;
            this._list.addChild(_loc2_);
            this._itemList.push(_loc2_);
            _loc3_++;
         }
         if(this._itemList.length <= this._defaultCount)
         {
            this._list.hSpace = 3;
         }
         else
         {
            this._list.hSpace = 0;
         }
         this._list.commitChanges();
         this._bagScroll.invalidateViewport();
      }
    addItem(param1) {
         var _loc2_ = null;
         if(this.canSell(param1) && this._data)
         {
            _loc2_ = this.findBagEmputyItem(this._data.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            this._itemDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
    defaultView(param1 = 1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._type = param1;
         if(param1 == 2)
         {
            this.getCanBeSellPet();
         }
         else
         {
            this.getCanBeSellGoodsFormBag();
         }
         this.refreshView();
      }
    getCanBeSellPet() {
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc2_ = 0;
         this._data = [];
         var _loc1_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.petList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = $.as(_loc1_[_loc2_], $.C("mvc.module.pet.PetData"));
            if(this.canSell(_loc4_))
            {
               _loc3_ = _loc4_.convertToGoods();
               this._data.push(_loc3_);
            }
            _loc2_++;
         }
      }
    getCanBeSellGoodsFormBag() {
         var _loc3_ = null;
         var _loc2_ = 0;
         this._data = [];
         var _loc1_ = $.C("yishi.manager.GoodsManager").instance.getGeneralBagList().getList();
         _loc1_ = _loc1_.concat($.C("yishi.manager.GoodsManager").instance.getStroeBagList().getList());
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = $.as(_loc1_[_loc2_], $.C("yishi.datas.goods.GoodsInfo"));
            if(this.canSell(_loc3_))
            {
               this._data.push(_loc3_);
            }
            _loc2_++;
         }
      }
    initEvent() {
         $.C("yishi.manager.GoodsManager").instance.addEventListener("UPDATE_BAG",$.bind(this, "__bagItemUpdateHandler"));
         $.C("yishi.manager.GoodsManager").instance.addEventListener("DELETE_BAG",$.bind(this, "__bagItemDeleteHandler"));
         $.C("yishi.manager.GoodsManager").instance.addEventListener("RETURN_REFRESH",$.bind(this, "__cleanBagItemFilterHandler"));
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.addEventListener("PET_ADD",$.bind(this, "__refreshPetHander"));
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.addEventListener("PET_REMOVE",$.bind(this, "__refreshPetHander"));
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.addEventListener("PET_UPDATE",$.bind(this, "__refreshPetHander"));
      }
    __refreshPetHander(param1) {
         if(!this.stage)
         {
            return;
         }
         if(this._type != 2)
         {
            return;
         }
         this.defaultView(this._type);
         this.cleanBagItemFilter();
      }
    __cleanBagItemFilterHandler(param1) {
         this.cleanBagItemFilter();
      }
    removeEvent() {
         $.C("yishi.manager.GoodsManager").instance.removeEventListener("UPDATE_BAG",$.bind(this, "__bagItemUpdateHandler"));
         $.C("yishi.manager.GoodsManager").instance.removeEventListener("DELETE_BAG",$.bind(this, "__bagItemDeleteHandler"));
         $.C("yishi.manager.GoodsManager").instance.removeEventListener("RETURN_REFRESH",$.bind(this, "__cleanBagItemFilterHandler"));
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.removeEventListener("PET_ADD",$.bind(this, "__refreshPetHander"));
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.removeEventListener("PET_REMOVE",$.bind(this, "__refreshPetHander"));
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.removeEventListener("PET_UPDATE",$.bind(this, "__refreshPetHander"));
      }
    __bagItemDeleteHandler(param1) {
         var _loc3_ = param1.info;
         for (var _loc2_ of $.values(this._itemDic))
         {
            if(_loc2_.data && _loc3_.id == _loc2_.data.id)
            {
               _loc2_.data = null;
               _loc2_.setNormalFilter();
               break;
            }
         }
      }
    __bagItemUpdateHandler(param1) {
         var _loc3_ = param1.info;
         if(_loc3_.bagType == 0)
         {
            return;
         }
         var _loc2_ = this._itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
         else
         {
            this.addItem(_loc3_);
         }
         this.cleanBagItemFilter();
      }
    cleanBagItemFilter() {
         for (var _loc1_ of $.values(this._itemList))
         {
            if(_loc1_ && !_loc1_.isNormalFilter)
            {
               _loc1_.setNormalFilter();
            }
         }
      }
    sortByTpye(param1, param2) {
         var _loc4_ = param1.templateInfo;
         var _loc3_ = param2.templateInfo;
         return _loc4_.MasterType == _loc3_.MasterType ? 0 : (_loc4_.MasterType > _loc3_.MasterType ? 1 : -1);
      }
    findSuperpositionPos(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._itemDic.hasOwnProperty(param1 + "_0_" + 1))
         {
            return $.as(this._itemDic[param1 + "_0_" + 1], $.C("yishi.view.community.BaseItemView"));
         }
         return null;
      }
    findBagEmputyItem(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc3_ = param1;
         _loc3_;
         while(_loc3_ < this._itemList.length)
         {
            if(!this._itemList[_loc3_].data)
            {
               return this._itemList[_loc3_];
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this._columnCount)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("acution.BagCell");
            this._list.addChild(_loc2_);
            this._itemList.push(_loc2_);
            _loc4_++;
         }
         this._list.hSpace = 0;
         this._list.commitChanges();
         this._bagScroll.invalidateViewport();
         return this.findBagEmputyItem(_loc3_);
      }
    canSell(param1) {
         var _loc2_ = null;
         if($.is(param1, $.C("yishi.datas.goods.GoodsInfo")))
         {
            return !($.as(param1, $.C("yishi.datas.goods.GoodsInfo"))).isBinds;
         }
         if($.is(param1, $.C("mvc.module.pet.PetData")))
         {
            _loc2_ = $.as(param1, $.C("mvc.module.pet.PetData"));
            return !_loc2_.isBind && !_loc2_.isEnterWar && !_loc2_.isPractice;
         }
         return false;
      }
    get itemList() {
         return this._itemList;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg1);
         this._bg1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._list);
         this._list = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bagScroll);
         this._bagScroll = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg1);
         this._bg1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg1);
         this._bg1 = null;
         for (var _loc1_ of $.values(this._itemDic))
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._itemDic.clear();
         this._itemList = null;
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set model(v) { super.model = v; }
    set uArmy(v) { super.uArmy = v; }
    set thane(v) { super.thane = v; }
    set itemList(v) { super.itemList = v; }
  }
  $.meta(__AuctionSellBagPane, "auction.view.sell.AuctionSellBagPane", ["Disposeable"]);
  return __AuctionSellBagPane;
}
deps["auction.view.sell.AuctionSellBagPane"] = ["auction.view.sell.AuctionSellBagCell", "com.pickgliss.geom.IntPoint", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "mvc.module.pet.PetData", "yishi.datas.goods.GoodsInfo", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.manager.PlayerManager", "yishi.utils.SimpleDictionary", "yishi.view.community.BaseItemView"];

defs["auction.view.sell.AuctionSellBottomBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionSellBottomBar extends __Base {
    static $fields(self) {
    self._diamondBack = null;
    self._diamondTxt = null;
    self._cancelBtn = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._diamondBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.diamondBackImg2");
         this._diamondTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.DiamondTxt2");
         this._diamondTxt.text = "10000";
         this._cancelBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.cancelBtn");
         this.addChild(this._diamondBack);
         this.addChild(this._diamondTxt);
         this.addChild(this._cancelBtn);
         this.playerInfo.addEventListener("POINT_CHANGE",$.bind(this, "onPointChanged"),false,0,true);
         this.onPointChanged(null);
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    onPointChanged(param1) {
         this._diamondTxt.text = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point + "";
      }
    getCancelBtn() {
         return this._cancelBtn;
      }
    dispose() {
         this.playerInfo.removeEventListener("POINT_CHANGE",$.bind(this, "onPointChanged"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._diamondBack);
         this._diamondBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._diamondTxt);
         this._diamondTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cancelBtn);
         this._cancelBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__AuctionSellBottomBar, "auction.view.sell.AuctionSellBottomBar", ["Disposeable"]);
  return __AuctionSellBottomBar;
}
deps["auction.view.sell.AuctionSellBottomBar"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.PlayerManager"];

defs["auction.view.sell.AuctionSellNumPane"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __AuctionSellNumPane extends __Base {
    static $fields(self) {
    self._countTxt = null;
    self._addBtn = null;
    self._reduceBtn = null;
    self._lableIcon = null;
    self._inputBack = null;
    self._warmTxt = null;
    self._ensureBtn = null;
    self._cancelBtn = null;
    self.callBack = null;
    self._item = null;
    self._targetCell = null;
    self._timeId = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addHandler();
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("Auction.AuctionSellNumTitle");
         this._warmTxt.text = $.C("manager.LanguageMgr").GetTranslation("Auction.EnterSellNum");
      }
    initView() {
         this._lableIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.AuctionNumIcon");
         this._inputBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionInputBack");
         this._countTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionBuyNumText");
         this._warmTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionInputWarmText");
         this._ensureBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionConfirmBtn");
         this._cancelBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionCancelBtn");
         this._addBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AddButton");
         this._reduceBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.ReduceButton");
         this.addToContent(this._inputBack);
         this.addToContent(this._lableIcon);
         this.addToContent(this._ensureBtn);
         this.addToContent(this._cancelBtn);
         this.addToContent(this._countTxt);
         this.addToContent(this._warmTxt);
         this.addToContent(this._addBtn);
         this.addToContent(this._reduceBtn);
      }
    addHandler() {
         this._ensureBtn.addEventListener("click",$.bind(this, "onEnsureHandler"));
         this._cancelBtn.addEventListener("click",$.bind(this, "onCancelHandler"));
         this._countTxt.addEventListener("keyDown",$.bind(this, "__onKeydownHandler"));
         this._countTxt.addEventListener("change",$.bind(this, "changeHandler"));
         this._addBtn.addEventListener("click",$.bind(this, "onAddHandler"));
         this._addBtn.addEventListener("mouseDown",$.bind(this, "onAddDownHandler"));
         this._addBtn.addEventListener("rollOut",$.bind(this, "onUpHandler"));
         this._reduceBtn.addEventListener("click",$.bind(this, "onReduceHandler"));
         this._reduceBtn.addEventListener("mouseDown",$.bind(this, "onReduceDownHandler"));
         this._reduceBtn.addEventListener("rollOut",$.bind(this, "onUpHandler"));
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this.addEventListener("addedToStage",$.bind(this, "__onAddedToStage"));
         this.addEventListener("mouseUp",$.bind(this, "onUpHandler"));
      }
    __onKeydownHandler(param1) {
         if(param1.keyCode == 13 && Boolean(this._ensureBtn.enable))
         {
            this.onEnsureHandler(null);
         }
         param1.stopPropagation();
      }
    onUpHandler(param1) {
         $.C("flash.utils.clearInterval")(this._timeId);
      }
    onReduceDownHandler(param1) {
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "reducing"),150);
      }
    reducing() {
         this.onReduceHandler(null);
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "reducing"),150);
      }
    onAddDownHandler(param1) {
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "adding"),150);
      }
    adding() {
         this.onAddHandler(null);
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "adding"),150);
      }
    changeHandler(param1) {
         if(!this._item.data)
         {
            return;
         }
         if(this.curNum <= 1)
         {
            this._countTxt.text = "1";
            this._reduceBtn.enable = false;
         }
         else
         {
            this._reduceBtn.enable = true;
         }
         if(this._item.data && this.curNum >= this._item.data.count)
         {
            this._countTxt.text = this._item.data.count + "";
            this._addBtn.enable = false;
         }
         else
         {
            this._addBtn.enable = true;
         }
         this._countTxt.text = this.curNum + "";
      }
    __onAddedToStage(param1) {
         this.removeEventListener("addedToStage",$.bind(this, "__onAddedToStage"));
         this.stage.focus = this._countTxt;
         this._countTxt.setSelection(0,this._countTxt.length);
      }
    show(param1, param2) {
         this._item = param1;
         this._targetCell = param2;
         this._countTxt.text = this._item.data.count + "";
         this.changeHandler(null);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,2,true,true,1);
      }
    removeHandler() {
         this._ensureBtn.removeEventListener("click",$.bind(this, "onEnsureHandler"));
         this._cancelBtn.removeEventListener("click",$.bind(this, "onCancelHandler"));
         this._countTxt.removeEventListener("keyDown",$.bind(this, "__onKeydownHandler"));
         this._countTxt.removeEventListener("change",$.bind(this, "changeHandler"));
         this._addBtn.removeEventListener("click",$.bind(this, "onAddHandler"));
         this._addBtn.removeEventListener("mouseDown",$.bind(this, "onAddDownHandler"));
         this._addBtn.removeEventListener("rollOut",$.bind(this, "onUpHandler"));
         this._reduceBtn.removeEventListener("click",$.bind(this, "onReduceHandler"));
         this._reduceBtn.removeEventListener("mouseDown",$.bind(this, "onReduceDownHandler"));
         this._reduceBtn.removeEventListener("rollOut",$.bind(this, "onUpHandler"));
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         this.removeEventListener("addedToStage",$.bind(this, "__onAddedToStage"));
         this.removeEventListener("mouseUp",$.bind(this, "onUpHandler"));
      }
    onReduceHandler(param1) {
         this._countTxt.text = (this.curNum - 1).toString();
         this.changeHandler(null);
      }
    onAddHandler(param1) {
         this._countTxt.text = (this.curNum + 1).toString();
         this.changeHandler(null);
      }
    onCancelHandler(param1) {
         this._item.setNormalFilter();
         this._targetCell.data = null;
         this.dispose();
      }
    onEnsureHandler(param1) {
         this._targetCell.setNumText(this.curNum);
         this._targetCell.data.willSellCount = this.curNum;
         if(this.callBack != null)
         {
            this.callBack();
         }
         this.dispose();
      }
    get curNum() {
         var _loc1_ = $.int(this._countTxt.text);
         if(_loc1_ <= 0)
         {
            _loc1_ = 0;
         }
         else if(_loc1_ > 999)
         {
            _loc1_ = 999;
         }
         return _loc1_;
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
               this.onCancelHandler(null);
               break;
            case 1:
               this.onCancelHandler(null);
         }
      }
    dispose() {
         super.dispose();
         this.removeHandler();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    set curNum(v) { super.curNum = v; }
  }
  $.meta(__AuctionSellNumPane, "auction.view.sell.AuctionSellNumPane", []);
  $.statics(__AuctionSellNumPane, () => {
    __AuctionSellNumPane.GAP_TIME = 150;
  });
  return __AuctionSellNumPane;
}
deps["auction.view.sell.AuctionSellNumPane"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "flash.utils.clearInterval", "flash.utils.setTimeout", "manager.LanguageMgr"];

defs["auction.view.sell.AuctionSellResultPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionSellResultPane extends __Base {
    static $fields(self) {
    self._border = null;
    self._listTitle = null;
    self._listComponent = null;
    self._bottomBar = null;
    self._corner1 = null;
    self._corner2 = null;
    self._corner3 = null;
    self._corner4 = null;
    self._data = null;
    self._bag = undefined;
    self._bagDefPoint = new ($.C("flash.geom.Point"))(70,25);
    self._delayShowBagTimer = null;
    self._goodsType = 0;
    self._currentOrder = null;
    self.__currentOrderType = 0;
    }
    constructor(param1 = 1) {
         $.pre(new.target, (__s) => {
         __s._goodsType = param1;
         });
         super();
         $.preFlush(this, new.target);
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance.auctionController.model;
         this._data = _loc2_.soldList;
         this.init();
         this.addHandler();
      }
    init() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sell.resultBack");
         this.addChild(this._border);
         var _loc1_ = $.C("auction.view.common.AuctionListColWidthConst").short;
         var _loc2_ = $.C("auction.view.common.AuctionListColWidthConst").shortX;
         this._listTitle = new ($.C("auction.view.common.AuctionListTitleComponent"))("auction.listTitleBmdS",_loc1_,_loc2_);
         this._listTitle.x = 1;
         this._listTitle.y = 1;
         this.addChild(this._listTitle);
         this._listComponent = new ($.C("auction.view.common.AuctionListComponent"))($.C("auction.view.common.AuctionListItem1"),9,-3);
         this._listComponent.setData(this._data.getList());
         this._listComponent.x = 3;
         this._listComponent.y = 31;
         this.addChild(this._listComponent);
         this._bottomBar = new ($.C("auction.view.sell.AuctionSellBottomBar"))();
         this._bottomBar.x = 2;
         this._bottomBar.y = 398;
         this.addChild(this._bottomBar);
         this._corner1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellResultCorner1");
         this._corner2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellResultCorner2");
         this._corner3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellResultCorner3");
         this._corner4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellResultCorner4");
         this.addChild(this._corner1);
         this.addChild(this._corner2);
         this.addChild(this._corner3);
         this.addChild(this._corner4);
         if(this._goodsType == 1)
         {
            this._bag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionBagFrame",[this._goodsType]);
         }
         else if(this._goodsType == 2)
         {
            this._bag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.PetSellView");
         }
      }
    addHandler() {
         this._data.addEventListener("change",$.bind(this, "onListDataChange"));
         this._bottomBar.getCancelBtn().addEventListener("click",$.bind(this, "onCancelBtnClick"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "layout"));
         this.addEventListener("addedToStage",$.bind(this, "onAddedToStage"));
         this._bag.addEventListener("FRAME_MOVE_COMPLETE",$.bind(this, "onBagMoveEvent"));
         this._listTitle.titleGrade.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleTime.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titlePrice.addEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleCurPrice.addEventListener("click",$.bind(this, "__onTitleClick"));
      }
    __onTitleClick(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("com.pickgliss.ui.controls.TitleButton"));
         switch(_loc2_)
         {
            case this._listTitle.titleGrade:
               this._currentOrder = "grade";
               break;
            case this._listTitle.titleTime:
               this._currentOrder = "hour";
               break;
            case this._listTitle.titlePrice:
               this._currentOrder = "fixedPrice";
               break;
            case this._listTitle.titleCurPrice:
               this._currentOrder = "currPrice";
         }
         if(this._listTitle.currentSelectBut(_loc2_) == 2)
         {
            this.__currentOrderType = 0;
         }
         else
         {
            this.__currentOrderType = 2;
         }
         var _loc3_ = this._data.getList().sortOn(this._currentOrder,0x10 | this.__currentOrderType);
         this._listComponent.setData(_loc3_);
      }
    onBagMoveEvent(param1) {
         this._bagDefPoint = this._bag.parent.localToGlobal(new ($.C("flash.geom.Point"))(this._bag.x,this._bag.y));
         this._bagDefPoint = this.globalToLocal(this._bagDefPoint);
      }
    onAddedToStage(param1) {
         this.removeEventListener("addedToStage",$.bind(this, "onAddedToStage"));
         this._delayShowBagTimer = new ($.C("flash.utils.Timer"))(20,1);
         this._delayShowBagTimer.addEventListener("timerComplete",$.bind(this, "onDelayShowBagTimerComplete"));
         this._delayShowBagTimer.start();
      }
    onDelayShowBagTimerComplete(param1) {
         this.removeDelayTimer();
         this._bag.show();
         this.layout(null);
      }
    removeDelayTimer() {
         if(this._delayShowBagTimer)
         {
            this._delayShowBagTimer.stop();
            this._delayShowBagTimer.removeEventListener("timerComplete",$.bind(this, "onDelayShowBagTimerComplete"));
            this._delayShowBagTimer = null;
         }
      }
    layout(param1) {
         var _loc2_ = null;
         if(this._bag && this._bag.parent)
         {
            _loc2_ = this._bagDefPoint.clone();
            _loc2_ = this.localToGlobal(_loc2_);
            _loc2_ = this._bag.parent.globalToLocal(_loc2_);
            this._bag.x = _loc2_.x;
            this._bag.y = _loc2_.y;
         }
      }
    onListDataChange(param1) {
         var _loc2_ = null;
         if(this._currentOrder)
         {
            _loc2_ = this._data.getList().sortOn(this._currentOrder,this.__currentOrderType);
            this._listComponent.setData(_loc2_);
         }
         else
         {
            this._listComponent.setData(this._data.getList());
         }
      }
    onCancelBtnClick(param1) {
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc3_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = this._listComponent.getSelectedItemData();
         if(_loc2_)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "cancelSell"),_loc2_.goodId];
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("Action.SellGoods.CancelSell");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc6_,_loc3_,_loc4_,_loc5_,true,false,false,2);
         }
         else
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.PleaseSelectGood"));
         }
      }
    cancelSell(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if(param1)
         {
            $.C("mediator.AuctionMessageSender").sendCancelItemMessage(param3);
         }
      }
    openBag() {
         if(this._bag && !this._bag.isOpen())
         {
            this._bagDefPoint = new ($.C("flash.geom.Point"))(70,25);
            this._bag.show();
            this.layout(null);
         }
      }
    getBagPane() {
         return this._bag.getBagPane();
      }
    dispose() {
         this._listTitle.titleGrade.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleTime.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titlePrice.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._listTitle.titleCurPrice.removeEventListener("click",$.bind(this, "__onTitleClick"));
         this._data.removeEventListener("change",$.bind(this, "onListDataChange"));
         this._bottomBar.getCancelBtn().removeEventListener("click",$.bind(this, "onCancelBtnClick"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "layout"));
         this.removeEventListener("addedToStage",$.bind(this, "onAddedToStage"));
         this.removeDelayTimer();
         if(this._bag)
         {
            this._bag.removeEventListener("FRAME_MOVE_COMPLETE",$.bind(this, "onBagMoveEvent"));
            this._bag.dispose();
            this._bag = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._border);
         this._border = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._listTitle);
         this._listTitle = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._listComponent);
         this._listComponent = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bottomBar);
         this._bottomBar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._corner1);
         this._corner1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._corner2);
         this._corner2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._corner3);
         this._corner3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._corner4);
         this._corner4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bag);
         this._bag = null;
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__AuctionSellResultPane, "auction.view.sell.AuctionSellResultPane", ["Disposeable"]);
  return __AuctionSellResultPane;
}
deps["auction.view.sell.AuctionSellResultPane"] = ["auction.view.AuctionAlert", "auction.view.common.AuctionListColWidthConst", "auction.view.common.AuctionListComponent", "auction.view.common.AuctionListItem1", "auction.view.common.AuctionListTitleComponent", "auction.view.sell.AuctionSellBottomBar", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.TitleButton", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.geom.Point", "flash.utils.Timer", "manager.LanguageMgr", "mediator.AuctionMessageSender", "yishi.manager.FrameControllerManager", "yishi.utils.SimpleAlertHelper"];

defs["auction.view.sell.AuctionSellSubmitPane"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionSellSubmitPane extends __Base {
    static $fields(self) {
    self._border = null;
    self._back = null;
    self._topLeftFlag = null;
    self._startBtn = null;
    self._topTipTxt = null;
    self._itemNameTxt = null;
    self._priceTxt1 = null;
    self._priceTxt2 = null;
    self._carryingCostTxt = null;
    self._timeLimitBtn1 = null;
    self._timeLimitBtn2 = null;
    self._timeLimitBtn3 = null;
    self._group = null;
    self._goldIcon = null;
    self._corner2 = null;
    self._goodCell = null;
    self._blinkMc = null;
    self._recordData = null;
    }
    constructor() {
         super();
         this.initView();
         this.addHandler();
      }
    initView() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sell.sellBack");
         this.addChild(this._border);
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.sellSubmitBack");
         this.addChild(this._back);
         this._topLeftFlag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.sellLeftFlag");
         this.addChild(this._topLeftFlag);
         this._startBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.startAuctionBtn");
         this.addChild(this._startBtn);
         this._topTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellSubmitTopTipTxt");
         this._itemNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellSubmitItemNameTxt");
         this._priceTxt1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellSubmitPriceTxt1");
         this._priceTxt2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellSubmitPriceTxt2");
         this._carryingCostTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellSubmitCarryingCostTxt");
         this._timeLimitBtn1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellTimeLimitBtn1");
         this._timeLimitBtn2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellTimeLimitBtn2");
         this._timeLimitBtn3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellTimeLimitBtn3");
         this._goldIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.goldIcon");
         this._goodCell = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("auction.sellTargetCell");
         this._blinkMc = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.auction.blinkIcon");
         this._blinkMc.x = 9;
         this._blinkMc.y = 63;
         this.addChild(this._topTipTxt);
         this.addChild(this._itemNameTxt);
         this.addChild(this._priceTxt1);
         this.addChild(this._priceTxt2);
         this.addChild(this._carryingCostTxt);
         this.addChild(this._timeLimitBtn1);
         this.addChild(this._timeLimitBtn2);
         this.addChild(this._timeLimitBtn3);
         this.addChild(this._goldIcon);
         this.addChild(this._blinkMc);
         this.addChild(this._goodCell);
         this._topTipTxt.text = $.C("manager.LanguageMgr").GetTranslation("Auction.SubmitTopTip");
         this._itemNameTxt.text = "";
         this._priceTxt1.text = "";
         this._priceTxt1.maxChars = 9;
         this._priceTxt1.textField.restrict = "0-9";
         this._priceTxt2.text = "";
         this._priceTxt2.maxChars = 9;
         this._priceTxt2.textField.restrict = "0-9";
         this._priceTxt1.enable = this._priceTxt2.enable = false;
         this._timeLimitBtn1.setText($.C("manager.LanguageMgr").GetTranslation("Auction.SubmitHour1"));
         this._timeLimitBtn2.setText($.C("manager.LanguageMgr").GetTranslation("Auction.SubmitHour2"));
         this._timeLimitBtn3.setText($.C("manager.LanguageMgr").GetTranslation("Auction.SubmitHour3"));
         this._corner2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.sellCorner2");
         this.addChild(this._corner2);
         this._group = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._group.addSelectItem(this._timeLimitBtn1);
         this._group.addSelectItem(this._timeLimitBtn2);
         this._group.addSelectItem(this._timeLimitBtn3);
         this._group.selectIndex = 0;
         this.updateCarryingCost();
      }
    addHandler() {
         this._startBtn.addEventListener("click",$.bind(this, "onSellBtnClick"));
         this._goodCell.addEventListener("change",$.bind(this, "onDataChange"));
         this._group.addEventListener("change",$.bind(this, "onHourChange"));
         this._priceTxt1.textField.addEventListener("change",$.bind(this, "__correctFirstZero"));
         this._priceTxt2.textField.addEventListener("change",$.bind(this, "__correctFirstZero"));
      }
    updateCarryingCost() {
         this._carryingCostTxt.text = 250 * this.getSelectTime() + "";
      }
    onSellBtnClick(param1) {
         var _loc2_ = 0;
         var _loc3_ = 0;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this._goodCell.data)
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.SubmitAlert1"));
            return;
         }
         if($.C("yishi.utils.StringUtil").trim(this._priceTxt1.text) == "")
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.SubmitAlert6"));
            return;
         }
         var _loc5_ = $.int(this._priceTxt1.text);
         if(_loc5_ < 2)
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.SubmitAlert2"));
            return;
         }
         _loc2_ = $.int(this._goodCell.data.templateInfo.StartingPrice);
         _loc3_ = $.int(this._goodCell.data.willSellCount);
         if(_loc5_ < _loc2_ * _loc3_)
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.SubmitAlert5"));
            this.calPriceTxt1(_loc2_,_loc3_);
            return;
         }
         var _loc6_ = $.int(this._priceTxt2.text);
         if(_loc6_ < 1)
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.SubmitAlert3"));
            return;
         }
         if(_loc6_ <= _loc5_)
         {
            $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("Auction.SubmitAlert4"));
            return;
         }
         var _loc4_ = new ($.C("mvc.module.auction.SellItemVO"))();
         if(this._goodCell.data.petData)
         {
            if(($.as(this._goodCell.data.petData, $.C("mvc.module.pet.PetData"))).isRemote)
            {
               $.C("auction.view.AuctionAlert").alert($.C("manager.LanguageMgr").GetTranslation("public.prompt"),$.C("manager.LanguageMgr").GetTranslation("pet.inRemotePet4"));
               return;
            }
            _loc4_.itemPos = ($.as(this._goodCell.data.petData, $.C("mvc.module.pet.PetData"))).petId;
            _loc4_.itemType = 2;
         }
         else
         {
            _loc4_.itemId = this._goodCell.data.id;
            _loc4_.itemPos = this._goodCell.data.pos;
            _loc4_.itemType = 1;
            _loc4_.bagType = this._goodCell.data.bagType;
         }
         if(this._goodCell.data.willSellCount)
         {
            _loc4_.count = this._goodCell.data.willSellCount;
         }
         else
         {
            _loc4_.count = this._goodCell.data.count;
         }
         _loc4_.point = _loc5_;
         _loc4_.fixPoint = _loc6_;
         _loc4_.hour = this.getSelectTime();
         _loc4_.templateId = this._goodCell.data.templateId;
         $.C("auction.view.sell.AuctionGoodMoveControl").storeTargetData();
         $.C("mediator.AuctionMessageSender").sendSellItemMessage(_loc4_);
         this.recordData(_loc4_);
         this._goodCell.data.willSellCount = 0;
      }
    recordData(param1) {
         this._recordData = null;
         this._recordData = param1;
      }
    getSelectTime() {
         if(this._group.selectIndex == 0)
         {
            return 8;
         }
         if(this._group.selectIndex == 1)
         {
            return 24;
         }
         return 48;
      }
    onDataChange(param1) {
         var _loc2_ = null;
         if(this._goodCell.data)
         {
            if(this._goodCell.data.petData)
            {
               _loc2_ = $.as(this._goodCell.data.petData, $.C("mvc.module.pet.PetData"));
               this._itemNameTxt.text = _loc2_.template.TemplateName;
            }
            else
            {
               this._itemNameTxt.text = this._goodCell.data.templateInfo.TemplateName;
            }
            this.calPriceTxt1(this._goodCell.data.templateInfo.StartingPrice,this._goodCell.data.count);
            this._priceTxt1.enable = this._priceTxt2.enable = true;
         }
         else
         {
            this._itemNameTxt.text = "";
            this._priceTxt1.text = "";
            this._priceTxt2.text = "";
            this._priceTxt1.enable = this._priceTxt2.enable = false;
         }
         if(this._itemNameTxt.numLines == 1)
         {
            this._itemNameTxt.y = 85;
         }
         else if(this._itemNameTxt.numLines == 2)
         {
            this._itemNameTxt.y = 85;
         }
         else if(this._itemNameTxt.numLines == 3)
         {
            this._itemNameTxt.y = 80;
         }
         else
         {
            this._itemNameTxt.y = 70;
         }
      }
    __correctFirstZero(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("flash.text.TextField"));
         if(_loc2_.text.charAt(0) == "0")
         {
            _loc2_.text = $.int(_loc2_.text).toString();
         }
      }
    setPriceNull() {
         this._priceTxt1.text = "";
         this._priceTxt2.text = "";
      }
    calPriceTxt1(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(param1 * param2 < 2)
         {
            this._priceTxt1.text = "2";
         }
         else
         {
            this._priceTxt1.text = param1 * param2 + "";
         }
      }
    checkData() {
         var _loc1_ = this._goodCell.data;
         if(_loc1_.petData)
         {
            this.checkForPet(_loc1_.petData);
         }
         else
         {
            this.checkForNormalGoods();
         }
      }
    checkForPet(param1) {
         var _loc2_ = $.int(this._goodCell.data.templateInfo.StartingPrice);
         this.calPriceTxt1(_loc2_,1);
         this._priceTxt2.text = "";
      }
    checkForNormalGoods() {
         var _loc1_ = 1;
         var _loc2_ = 1;
         if(!this._recordData)
         {
            if(this._goodCell.data.willSellCount)
            {
               _loc1_ = $.int(this._goodCell.data.templateInfo.StartingPrice);
               _loc2_ = $.int(this._goodCell.data.willSellCount);
            }
            else
            {
               _loc1_ = $.int(this._goodCell.data.templateInfo.StartingPrice);
               _loc2_ = $.int(this._goodCell.data.count);
            }
            this.calPriceTxt1(_loc1_,_loc2_);
         }
         else if(this._goodCell.data.templateId == this._recordData.templateId && this._goodCell.data.count == this._recordData.count || this._goodCell.data.templateId == this._recordData.templateId && this._goodCell.data.willSellCount && this._goodCell.data.willSellCount == this._recordData.count)
         {
            this._priceTxt1.text = this._recordData.point.toString();
            this._priceTxt2.text = this._recordData.fixPoint.toString();
         }
         else
         {
            if(this._goodCell.data.willSellCount)
            {
               this.calPriceTxt1(this._goodCell.data.templateInfo.StartingPrice,this._goodCell.data.willSellCount);
            }
            else
            {
               this.calPriceTxt1(this._goodCell.data.templateInfo.StartingPrice,this._goodCell.data.count);
            }
            this._priceTxt2.text = "";
         }
      }
    onHourChange(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.updateCarryingCost();
      }
    getCellItem() {
         return this._goodCell;
      }
    getGoodCell() {
         return this._goodCell;
      }
    dispose() {
         if(this._goodCell.data)
         {
            $.C("yishi.manager.GoodsManager").instance.dispatchEvent(new ($.C("bag.events.BagEvent"))("RETURN_REFRESH",null));
         }
         this._goodCell.removeEventListener("change",$.bind(this, "onDataChange"));
         this._startBtn.removeEventListener("click",$.bind(this, "onSellBtnClick"));
         this._group.removeEventListener("change",$.bind(this, "onHourChange"));
         this._priceTxt1.textField.removeEventListener("change",$.bind(this, "__correctFirstZero"));
         this._priceTxt2.textField.removeEventListener("change",$.bind(this, "__correctFirstZero"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._border);
         this._border = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._topLeftFlag);
         this._topLeftFlag = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._startBtn);
         this._startBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._topTipTxt);
         this._topTipTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemNameTxt);
         this._itemNameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._priceTxt1);
         this._priceTxt1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._priceTxt2);
         this._priceTxt2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._carryingCostTxt);
         this._carryingCostTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeLimitBtn1);
         this._timeLimitBtn1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeLimitBtn2);
         this._timeLimitBtn2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeLimitBtn3);
         this._timeLimitBtn3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._group);
         this._group = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goldIcon);
         this._goldIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._corner2);
         this._corner2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodCell);
         this._goodCell = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blinkMc);
         this._blinkMc = null;
         if(this.parent)
         {
            this.parent.removeChild(this._blinkMc);
         }
      }
    playBlink() {
         this._blinkMc.gotoAndPlay(1);
      }
    stopBlink() {
         this._blinkMc.gotoAndStop(1);
      }
  }
  $.meta(__AuctionSellSubmitPane, "auction.view.sell.AuctionSellSubmitPane", ["Disposeable"]);
  return __AuctionSellSubmitPane;
}
deps["auction.view.sell.AuctionSellSubmitPane"] = ["auction.view.AuctionAlert", "auction.view.sell.AuctionGoodMoveControl", "bag.events.BagEvent", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ClassUtils", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.text.TextField", "manager.LanguageMgr", "mediator.AuctionMessageSender", "mvc.module.auction.SellItemVO", "mvc.module.pet.PetData", "yishi.manager.GoodsManager", "yishi.utils.StringUtil"];

defs["auction.view.sell.AuctionSellTargetCell"] = function define($) {
  const __Base = $.C("yishi.view.community.BaseItemView");
  class __AuctionSellTargetCell extends __Base {
    static $fields(self) {
    self._activeStyle = null;
    self._hitBack = null;
    self._textIconStyle = null;
    self.sonType = 0;
    self.resetTip = null;
    self._mediatorKey = null;
    self._registed = false;
    self._blinkMc = null;
    }
    constructor() {
         super();
         this.bagType = 0;
         this.pos = 0;
         this.setNormal();
         this.registerMediator();
         this.buttonMode = true;
      }
    set activeStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._activeStyle = param1;
         this.onPropertiesChanged("activeStyle");
      }
    set textIconStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._textIconStyle = param1;
         this.onPropertiesChanged("textIcon");
      }
    onProppertiesUpdate() {
         super.onProppertiesUpdate();
      }
    addChildren() {
         this._hitBack = new ($.C("flash.display.Sprite"))();
         this._hitBack.graphics.beginFill(0,0);
         this._hitBack.graphics.drawRect(0,0,63,63);
         this._hitBack.graphics.endFill();
         this.addChild(this._hitBack);
         if(this._back)
         {
            this.addChild(this._back);
         }
         if(this._icon)
         {
            this.addChild(this._icon);
         }
         if(this._profile)
         {
            this.addChild(this._profile);
         }
         if(this._itemText)
         {
            this.addChild(this._itemText);
         }
         if(this._strengthenIcon)
         {
            this.addChild(this._strengthenIcon);
         }
      }
    registerMediator() {
         this._registed = true;
         var _loc1_ = [$.C("auction.view.sell.SellTargetCellClickMediator"),$.C("auction.view.sell.SellTargetCellDropMediator")];
         this._mediatorKey = $.C("yishi.manager.MediatorMananger").instance.registerMediatorList(_loc1_,this,"auction.view.sell.AuctionSellTargetCell");
      }
    set data(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("024",true);
         super.data = param1;
         this.dispatchEvent(new ($.C("flash.events.Event"))("change"));
         if(this.data)
         {
            this.buttonMode = false;
         }
         else
         {
            this.buttonMode = true;
         }
      }
    setTipStyle(param1) {
         if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(this.resetTip))
         {
            this.icon.tipStyle = this.resetTip;
         }
         else
         {
            super.setTipStyle(param1);
         }
      }
    dispose() {
         $.C("yishi.manager.MediatorMananger").instance.unregisterMediatorList(this._mediatorKey,this);
         super.dispose();
      }
    setNormal() {
      }
    setFocus() {
      }
    setNumText(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(param1)
         {
            this._itemText.text = param1 + "";
         }
         else
         {
            this._itemText.text = "";
         }
      }
    get activeStyle() { return super.activeStyle; }
    get textIconStyle() { return super.textIconStyle; }
    get data() { return super.data; }
  }
  $.meta(__AuctionSellTargetCell, "auction.view.sell.AuctionSellTargetCell", []);
  $.statics(__AuctionSellTargetCell, () => {
    __AuctionSellTargetCell.P_activeStyle = "activeStyle";
    __AuctionSellTargetCell.P_textIcon = "textIcon";
    __AuctionSellTargetCell.EQUIP = -1;
    __AuctionSellTargetCell.NAME = "auction.view.sell.AuctionSellTargetCell";
  });
  return __AuctionSellTargetCell;
}
deps["auction.view.sell.AuctionSellTargetCell"] = ["auction.view.sell.SellTargetCellClickMediator", "auction.view.sell.SellTargetCellDropMediator", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.events.Event", "yishi.manager.MediatorMananger", "yishi.utils.StringHelper", "yishi.view.community.BaseItemView"];

defs["auction.view.sell.PetSellView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __PetSellView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._vBox = null;
    self._listPanel = null;
    self._list = null;
    self.canBeSellPet = null;
    }
    constructor() {
         super();
         this.initView();
         if(this.stage)
         {
            this.refresh();
         }
         else
         {
            this.addEventListener("addedToStage",$.bind(this, "__onStage"));
         }
      }
    __onStage(param1) {
         this.removeEventListener("addedToStage",$.bind(this, "__onStage"));
         this.refresh();
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("auction.view.sell.PetSellView.title");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FarmPetSelectMeun.back");
         this._bg.mouseChildren = this._bg.mouseEnabled = false;
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("farm.PetVBox");
         this._listPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FarmPetSelectMeun.ScrollPanel");
         this._listPanel.vScrollProxy = 1;
         this.addToContent(this._bg);
         this.addToContent(this._listPanel);
         this._vBox.mouseEnabled = false;
      }
    refresh() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this.removeEvent();
         this._vBox.disposeAllChildren();
         this._list = [];
         this.canBeSellPet = this.getCanBeSellPet();
         _loc2_ = 0;
         while(_loc2_ < this.canBeSellPet.length)
         {
            _loc1_ = new ($.C("farm.view.FarmPetListItemView"))();
            _loc1_.data = $.as(this.canBeSellPet[_loc2_], $.C("mvc.module.pet.PetData"));
            _loc1_.setType(1);
            this._list.push(_loc1_);
            this._vBox.addChild(_loc1_);
            _loc2_++;
         }
         this._listPanel.setView(this._vBox);
         this._listPanel.invalidateViewport();
         this.addEvent();
         if(this.canBeSellPet.length == 0)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("auction.view.sell.PetSellView.noPetToSell"));
            this._bg.height = 65;
            this.height = 140;
            this.width = 240;
         }
         else if(this.canBeSellPet.length <= 5)
         {
            this._bg.height = this._vBox.height + 10;
            this.height = this._vBox.height + 75;
            this.width = 240;
         }
         else
         {
            this._bg.height = 233;
            this.height = 358;
            this.width = 260;
         }
      }
    getCanBeSellPet() {
         var _loc5_ = null;
         var _loc4_ = 0;
         var _loc1_ = [];
         var _loc3_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
         var _loc2_ = _loc3_.petList;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = $.as(_loc2_[_loc4_], $.C("mvc.module.pet.PetData"));
            if(!_loc5_.isBind && !_loc5_.isEnterWar && !_loc5_.isPractice && _loc3_.petChallengeFormationOfArray.indexOf(_loc5_.petId + "") < 0)
            {
               _loc1_.push(_loc5_);
            }
            _loc4_++;
         }
         return _loc1_;
      }
    addEvent() {
         var _loc1_ = 0;
         this.addEventListener("response",$.bind(this, "__responseHandler"));
         if(this._list)
         {
            _loc1_ = 0;
            while(_loc1_ < this._list.length)
            {
               this._list[_loc1_].addEventListener("rollOver",$.bind(this, "__mouseOverHandler"));
               this._list[_loc1_].addEventListener("rollOut",$.bind(this, "__mouseOutHandler"));
               this._list[_loc1_].addEventListener("click",$.bind(this, "__moveToSellCell"));
               this._list[_loc1_].addEventListener("doubleClick",$.bind(this, "__moveToSellCell"));
               _loc1_++;
            }
         }
      }
    removeEvent() {
         var _loc1_ = 0;
         this.removeEventListener("response",$.bind(this, "__responseHandler"));
         if(this._list)
         {
            _loc1_ = 0;
            while(_loc1_ < this._list.length)
            {
               this._list[_loc1_].removeEventListener("rollOver",$.bind(this, "__mouseOverHandler"));
               this._list[_loc1_].removeEventListener("rollOut",$.bind(this, "__mouseOutHandler"));
               this._list[_loc1_].removeEventListener("click",$.bind(this, "__moveToSellCell"));
               this._list[_loc1_].removeEventListener("doubleClick",$.bind(this, "__moveToSellCell"));
               _loc1_++;
            }
         }
      }
    __moveToSellCell(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("farm.view.FarmPetListItemView"));
         if(_loc2_)
         {
            $.C("auction.view.sell.AuctionGoodMoveControl").moveToTargetCell(_loc2_.cell);
         }
      }
    __mouseOverHandler(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("farm.view.FarmPetListItemView"));
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
    __mouseOutHandler(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("farm.view.FarmPetListItemView"));
         if(_loc2_)
         {
            _loc2_.mouseOut();
         }
      }
    __responseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.hide();
         }
      }
    hide() {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("auction.view.sell.AuctionGoodMoveControl").playBlink();
         $.C("auction.view.sell.AuctionGoodMoveControl").isFirstOpenSellPane = false;
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,2);
         $.C("auction.view.sell.AuctionGoodMoveControl").stopBlink();
      }
    isOpen() {
         if(this.parent)
         {
            return true;
         }
         return false;
      }
    getBagPane() {
         return this;
      }
    dispose() {
         this.removeEventListener("addedToStage",$.bind(this, "__onStage"));
         this.removeEvent();
         this._list = [];
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._listPanel);
         this._listPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PetSellView, "auction.view.sell.PetSellView", []);
  return __PetSellView;
}
deps["auction.view.sell.PetSellView"] = ["auction.view.sell.AuctionGoodMoveControl", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "farm.view.FarmPetListItemView", "manager.LanguageMgr", "mvc.module.pet.PetData", "yishi.manager.PlayerManager", "yishi.view.tips.MessageTipManager"];

defs["auction.view.sell.SellTargetCellClickMediator"] = function define($) {
  const __Base = $.Object;
  class __SellTargetCellClickMediator extends __Base {
    static $fields(self) {
    self._cell = null;
    }
    constructor() {
         super();
      }
    register(param1) {
         this._cell = $.as(param1, $.C("auction.view.sell.AuctionSellTargetCell"));
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this._cell);
         this._cell.addEventListener("interactive_click",$.bind(this, "__mouseClickByClicker"));
         this._cell.addEventListener("interactive_double_click",$.bind(this, "__mouseDoubleClick"));
      }
    unregister(param1) {
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this._cell);
         this._cell.removeEventListener("interactive_click",$.bind(this, "__mouseClickByClicker"));
         this._cell.removeEventListener("interactive_double_click",$.bind(this, "__mouseDoubleClick"));
      }
    __mouseClickByClicker(param1) {
         if(!this._cell || !this._cell.data)
         {
            return;
         }
         $.C("yishi.manager.NotificationManager").instance.sendNotification("DRAG_ITEM_BagNotic",[this._cell,this._cell.data.count]);
      }
    __mouseDoubleClick(param1) {
         $.C("yishi.manager.NotificationManager").instance.sendNotification("ITEM_DROP_BagNotic",[this._cell]);
         this._cell.data = null;
      }
  }
  $.meta(__SellTargetCellClickMediator, "auction.view.sell.SellTargetCellClickMediator", ["IMediator"]);
  return __SellTargetCellClickMediator;
}
deps["auction.view.sell.SellTargetCellClickMediator"] = ["auction.view.sell.AuctionSellTargetCell", "com.pickgliss.utils.DoubleClickManager", "yishi.manager.NotificationManager"];

defs["auction.view.sell.SellTargetCellDropMediator"] = function define($) {
  const __Base = $.C("cell.mediator.CellDropMediator");
  class __SellTargetCellDropMediator extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    starItemDrag(param1 = -1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("com.pickgliss.utils.SoundManager").instance.play("003");
         this._cell.isDraging = true;
         var _loc3_ = this.getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_ = $.C("yishi.manager.DragManager").getInstance().starDrag(this._cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = $.bind(this, "beDropHitCallBack");
         _loc2_.dropChecks = [$.C("yishi.view.community.BaseItemView"),$.C("com.pickgliss.ui.controls.Frame"),$.C("flash.display.Stage")];
         this._cell.setGrayFilter();
      }
    __dragItemBagHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("003");
         super.__dragItemBagHandler(param1);
         var _loc2_ = $.as(param1.data[0], $.C("auction.view.sell.AuctionSellBagCell"));
         if(!_loc2_)
         {
            return;
         }
         if($.is(this._cell, $.C("auction.view.sell.AuctionSellTargetCell")))
         {
            $.cast($.C("auction.view.sell.AuctionSellTargetCell"), this._cell).setFocus();
            return;
         }
         $.cast($.C("auction.view.sell.AuctionSellTargetCell"), this._cell).setNormal();
      }
    __itemDropBagHandler(param1) {
         super.__itemDropBagHandler(param1);
         $.cast($.C("auction.view.sell.AuctionSellTargetCell"), this._cell).setNormal();
      }
    unregister(param1) {
         super.unregister(param1);
         $.C("yishi.manager.DragManager").getInstance().stopDrag();
      }
    beDropHitCallBack(param1) {
         this._cell.isDraging = false;
         this._cell.setNormalFilter();
         $.cast($.C("auction.view.sell.AuctionSellTargetCell"), this._cell).data = null;
         $.C("yishi.manager.NotificationManager").instance.sendNotification("ITEM_DROP_BagNotic",[this._cell]);
      }
  }
  $.meta(__SellTargetCellDropMediator, "auction.view.sell.SellTargetCellDropMediator", []);
  return __SellTargetCellDropMediator;
}
deps["auction.view.sell.SellTargetCellDropMediator"] = ["auction.view.sell.AuctionSellBagCell", "auction.view.sell.AuctionSellTargetCell", "cell.mediator.CellDropMediator", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.SoundManager", "flash.display.Stage", "yishi.manager.DragManager", "yishi.manager.NotificationManager", "yishi.view.community.BaseItemView"];

defs["auction.view.supermarket.AuctionShopView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AuctionShopView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._text = null;
    self.$$_mask = null;
    self._enterBtn = null;
    self._shape = null;
    }
    constructor() {
         super();
         this.init();
         this.initEvent();
      }
    init() {
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.AuctionShopIcon");
         this.$$_mask = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.Mask");
         this._text = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.DescribeText");
         this._enterBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.AuctionShopButton");
         this.createShape();
         this.addChild(this._icon);
         this.addChild(this._text);
         this.addChild(this._enterBtn);
         this.addChild(this.$$_mask);
         this.addChild(this._shape);
         this._text.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.supermarket.AuctionShopView.text");
      }
    createShape() {
         this._shape = new ($.C("flash.display.Shape"))();
         this._shape.graphics.beginFill(65535,0);
         this._shape.graphics.drawRect(0,0,this.$$_mask.width,this.$$_mask.height);
      }
    initEvent() {
         this._enterBtn.addEventListener("click",$.bind(this, "__enterHandler"));
         this.addEventListener("mouseOver",$.bind(this, "__overHandler"));
      }
    removeEvent() {
         this._enterBtn.removeEventListener("click",$.bind(this, "__enterHandler"));
         this.removeEventListener("mouseOver",$.bind(this, "__overHandler"));
      }
    get enterBtn() {
         return this._enterBtn;
      }
    __overHandler(param1) {
         this.$$_mask.visible = false;
         ($.as(this.parent.parent, $.C("auction.SupermarketFrame"))).mysteryShopView.showMask.visible = true;
      }
    get showMask() {
         return this.$$_mask;
      }
    __enterHandler(param1) {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("auction");
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set enterBtn(v) { super.enterBtn = v; }
    set showMask(v) { super.showMask = v; }
  }
  $.meta(__AuctionShopView, "auction.view.supermarket.AuctionShopView", ["Disposeable"]);
  return __AuctionShopView;
}
deps["auction.view.supermarket.AuctionShopView"] = ["auction.SupermarketFrame", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Shape", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.FrameControllerManager"];

defs["auction.view.supermarket.MysteryShopView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MysteryShopView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._text = null;
    self.$$_mask = null;
    self._enterBtn = null;
    self._shape = null;
    }
    constructor() {
         super();
         this.init();
         this.initEvent();
      }
    init() {
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.MysteryShopIcon");
         this.$$_mask = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.auction.Mask");
         this._text = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.DescribeText");
         this._enterBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("auction.MysteryShopButton");
         this.createShape();
         this.addChild(this._icon);
         this.addChild(this._text);
         this.addChild(this._enterBtn);
         this.addChild(this.$$_mask);
         this.addChild(this._shape);
         this._text.text = $.C("manager.LanguageMgr").GetTranslation("auction.view.supermarket.MysteryShopView.text");
      }
    createShape() {
         this._shape = new ($.C("flash.display.Shape"))();
         this._shape.graphics.beginFill(65535,0);
         this._shape.graphics.drawRect(0,0,this.$$_mask.width,this.$$_mask.height);
      }
    initEvent() {
         this._enterBtn.addEventListener("click",$.bind(this, "__enterHandler"));
         this.addEventListener("mouseOver",$.bind(this, "__overHandler"));
      }
    removeEvent() {
         this._enterBtn.removeEventListener("click",$.bind(this, "__enterHandler"));
         this.removeEventListener("mouseOver",$.bind(this, "__overHandler"));
      }
    get enterBtn() {
         return this._enterBtn;
      }
    __overHandler(param1) {
         this.$$_mask.visible = false;
         ($.as(this.parent.parent, $.C("auction.SupermarketFrame"))).auctionShopView.showMask.visible = true;
      }
    get showMask() {
         return this.$$_mask;
      }
    __enterHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         if($.C("yishi.manager.ArmyManager").instance.thane.grades < 26)
         {
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.supermarket.MysteryShopView.gradesTipData");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
            return;
         }
         if(this.mysteryShopModel.buyCount >= this.mysteryShopModel.maxBuyCount)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("mysteryshop");
      }
    get mysteryShopModel() {
         return $.C("managers.MysteryShopManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set enterBtn(v) { super.enterBtn = v; }
    set showMask(v) { super.showMask = v; }
    set mysteryShopModel(v) { super.mysteryShopModel = v; }
  }
  $.meta(__MysteryShopView, "auction.view.supermarket.MysteryShopView", ["Disposeable"]);
  return __MysteryShopView;
}
deps["auction.view.supermarket.MysteryShopView"] = ["auction.SupermarketFrame", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Shape", "flash.display.Sprite", "manager.LanguageMgr", "managers.MysteryShopManager", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["outercityshop.OuterCityShopFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __OuterCityShopFrame extends __Base {
    static $fields(self) {
    self._leftView = null;
    self._randomView = null;
    self._exchangeView = null;
    self._randomButton = null;
    self._exchangeButton = null;
    self._buttonGroup = null;
    self._freshTimeTxt = null;
    self._downTime = null;
    self._leftBackBg = null;
    self._rightBackBg = null;
    self._upBack = null;
    self._dailyCountTxt = null;
    self._pointsShowBack = null;
    self._pointsShow = null;
    self._pointsShowTxt = null;
    self._stonesShowBack = null;
    self._stonesShow = null;
    self._stonesShowTxt = null;
    self._stripView = null;
    self._helpBtn = null;
    self.MAX_COUNT = 10;
    }
    constructor() {
         super();
         this.initView();
         this.initData();
         this.addEvent();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,775,525);
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
    initView() {
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("ShopFresh_DayCount");
         if(_loc1_)
         {
            this.MAX_COUNT = $.int(_loc1_.ConfigValue);
         }
         this._leftBackBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.leftBackBg");
         this._rightBackBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.rightBackBg");
         this._upBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.upBack");
         this._dailyCountTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.DailyCountTxt");
         this._pointsShowBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.displayShowBack");
         this._pointsShow = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.displayShowPoints");
         this._pointsShowTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.displayShowTxt");
         this._stonesShowBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.displayShowBack");
         this._stonesShow = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.displayShow");
         this._stonesShowTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.displayShowTxt");
         this._leftView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.leftView");
         this._randomView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.randomView");
         this._exchangeView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.exchangeView");
         this._randomButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.randomButton");
         this._exchangeButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.exchangeButton");
         this._freshTimeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.freshTimeTxt");
         this._downTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.downUpdateTime");
         this._helpBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopFrame.HelpBtn");
         this._helpBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.help");
         this._stripView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("shop.mysteryTip.StripView");
         this._stripView.setHitArea(0,0,60,27);
         this._stripView.tipData = $.C("manager.LanguageMgr").GetTranslation("tips.mysteryTip.StripView");
         this._buttonGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._buttonGroup.addSelectItem(this._randomButton);
         this._buttonGroup.addSelectItem(this._exchangeButton);
         this._freshTimeTxt.text = $.C("manager.LanguageMgr").GetTranslation("outercityshop.OuterCityShopFrame.freshTimeText2");
         this.addToContent(this._leftBackBg);
         this.addToContent(this._rightBackBg);
         this.addToContent(this._upBack);
         this.addToContent(this._dailyCountTxt);
         this.addToContent(this._pointsShowBack);
         this._pointsShowBack.y -= 34;
         this.addToContent(this._pointsShow);
         this.addToContent(this._pointsShowTxt);
         this._pointsShowTxt.y -= 34;
         this.addToContent(this._stonesShowBack);
         this.addToContent(this._stonesShow);
         this.addToContent(this._stonesShowTxt);
         this.addToContent(this._leftView);
         this.addToContent(this._randomButton);
         this.addToContent(this._exchangeButton);
         this.addToContent(this._freshTimeTxt);
         this.addToContent(this._downTime);
         this.addToContent(this._stripView);
         this.refreshView();
      }
    initData() {
         $.C("managers.OuterCityShopManager").instance.sendAction(1);
         this.outercityShopControler.initExchangeGoodsData();
         if(this.model.lastFreshTime > 0)
         {
            this._downTime.visible = true;
            this._freshTimeTxt.visible = true;
            this._downTime.timeCount = this.model.lastFreshTime;
         }
         else
         {
            this.__timeCompleteHandler(null);
         }
         this.__refreshCountView(null);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         this.model.addEventListener("FRESH_VIEW",$.bind(this, "__freshViewHandler"));
         this._downTime.addEventListener("timerDown_complete",$.bind(this, "__timeCompleteHandler"));
         this._buttonGroup.addEventListener("change",$.bind(this, "__tabButtonHandler"));
         $.C("yishi.manager.GoodsManager").instance.addEventListener("UPDATE_BAG",$.bind(this, "__updateHandler"));
         $.C("yishi.manager.GoodsManager").instance.addEventListener("DELETE_BAG",$.bind(this, "__updateHandler"));
      }
    __updateHandler(param1) {
         this.refreshView();
      }
    __freshViewHandler(param1) {
         if(this.model.lastFreshTime > 0)
         {
            if(this._buttonGroup.getSelectedItem() == this._randomButton)
            {
               this._downTime.visible = true;
               this._freshTimeTxt.visible = true;
            }
            else
            {
               this._downTime.visible = false;
               this._freshTimeTxt.visible = false;
            }
            this._downTime.timeCount = this.model.lastFreshTime;
         }
         else
         {
            this.__timeCompleteHandler(null);
         }
         this.__refreshCountView(null);
      }
    __tabButtonHandler(param1) {
         switch(this._buttonGroup.getSelectedItem())
         {
            case this._randomButton:
               if(this._exchangeView && this._exchangeView.parent)
               {
                  this._exchangeView.parent.removeChild(this._exchangeView);
               }
               this._dailyCountTxt.visible = true;
               this.addToContent(this._randomView);
               if(this.model.lastFreshTime > 0)
               {
                  this._downTime.visible = true;
                  this._freshTimeTxt.visible = true;
               }
               else
               {
                  this._downTime.visible = false;
                  this._freshTimeTxt.visible = false;
               }
               break;
            case this._exchangeButton:
               if(this._randomView && this._randomView.parent)
               {
                  this._randomView.parent.removeChild(this._randomView);
               }
               this._dailyCountTxt.visible = false;
               this.addToContent(this._exchangeView);
               this._downTime.visible = false;
               this._freshTimeTxt.visible = false;
               this.model.resetData();
               this.model.updateShowGoodsList();
         }
      }
    __onHelpHandler(param1) {
         var _loc2_ = null;
         _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.helpframe");
         _loc2_.show();
      }
    __goodsLinkHandler(param1) {
         $.C("yishi.manager.FrameControllerManager").instance.outerCityShopControler.openGoodsFrame();
      }
    __timeCompleteHandler(param1) {
         this._downTime.timeCount = this.model.lastFreshTime;
         this._downTime.visible = false;
         this._freshTimeTxt.visible = false;
         this._randomView.setIsFreeFreshAble(true);
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         this.model.removeEventListener("FRESH_VIEW",$.bind(this, "__freshViewHandler"));
         this._downTime.removeEventListener("timerDown_complete",$.bind(this, "__timeCompleteHandler"));
         this._buttonGroup.removeEventListener("change",$.bind(this, "__tabButtonHandler"));
         $.C("yishi.manager.GoodsManager").instance.removeEventListener("UPDATE_BAG",$.bind(this, "__updateHandler"));
         $.C("yishi.manager.GoodsManager").instance.removeEventListener("DELETE_BAG",$.bind(this, "__updateHandler"));
      }
    __refreshCountView(param1) {
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("auction.view.mysteryshop.RefreshCountView.tipText");
         var _loc3_ = this.MAX_COUNT - this.model.fresh_count;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         this._dailyCountTxt.text = _loc2_ + _loc3_ + " / " + this.MAX_COUNT;
         this.refreshView();
      }
    refreshView() {
         this._pointsShowTxt.text = this.model.consumePoints.toString();
         this._stonesShowTxt.text = $.C("yishi.manager.GoodsManager").instance.getGoodsNumByTempId(2131057).toString();
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    show() {
         this._buttonGroup.selectIndex = 0;
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("outercityshop.OuterCityShopFrame.titleText");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
      }
    get model() {
         return $.C("managers.OuterCityShopManager").instance.model;
      }
    get outercityShopControler() {
         return $.C("yishi.manager.FrameControllerManager").instance.outerCityShopControler;
      }
    dispose() {
         this.removeEvent();
         if(this._leftView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftView);
         }
         this._leftView = null;
         if(this._randomView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._randomView);
         }
         this._randomView = null;
         if(this._exchangeView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._exchangeView);
         }
         this._exchangeView = null;
         if(this._randomButton)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._randomButton);
         }
         this._randomButton = null;
         if(this._exchangeButton)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._exchangeButton);
         }
         this._exchangeButton = null;
         if(this._buttonGroup)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buttonGroup);
         }
         this._buttonGroup = null;
         if(this._freshTimeTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._freshTimeTxt);
         }
         this._freshTimeTxt = null;
         if(this._downTime)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._downTime);
         }
         this._downTime = null;
         if(this._leftBackBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftBackBg);
         }
         this._leftBackBg = null;
         if(this._rightBackBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightBackBg);
         }
         this._rightBackBg = null;
         if(this._upBack)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._upBack);
         }
         this._upBack = null;
         if(this._helpBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._helpBtn);
         }
         this._helpBtn = null;
         if(this._stripView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stripView);
         }
         this._stripView = null;
         if(this._stonesShowTxt)
         {
            this._stonesShowTxt.dispose();
         }
         this._stonesShowTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stonesShow);
         this._stonesShow = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stonesShowBack);
         this._stonesShowBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pointsShowTxt);
         this._pointsShowTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pointsShow);
         this._pointsShow = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pointsShowBack);
         this._pointsShowBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dailyCountTxt);
         this._dailyCountTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pointsShowTxt);
         this._pointsShowTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pointsShowTxt);
         this._pointsShowTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pointsShowTxt);
         this._pointsShowTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set model(v) { super.model = v; }
    set outercityShopControler(v) { super.outercityShopControler = v; }
  }
  $.meta(__OuterCityShopFrame, "outercityshop.OuterCityShopFrame", ["IManualSize"]);
  return __OuterCityShopFrame;
}
deps["outercityshop.OuterCityShopFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectUtils", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.OuterCityShopManager", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.manager.TempleteManager"];

defs["outercityshop.view.LuckyProgressView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __LuckyProgressView extends __Base {
    static $fields(self) {
    self._progressBgHbox = null;
    self._progressHbox = null;
    self._luckyBg = null;
    self._lucky = null;
    self.$$_mask = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         var _loc1_ = 0;
         this._progressBgHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.view.progressBgHbox");
         this._progressHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.view.progressHbox");
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this._luckyBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.luckyBg");
            this._lucky = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.lucky");
            this._progressBgHbox.addChild(this._luckyBg);
            this._progressHbox.addChild(this._lucky);
            _loc1_++;
         }
         this.$$_mask = new ($.C("flash.display.Sprite"))();
         this.addChild(this._progressBgHbox);
         this.addChild(this._progressHbox);
         this.addChild(this.$$_mask);
         this.creatMask(0,10);
         this._progressHbox.mask = this.$$_mask;
      }
    creatMask(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(param1 > param2)
         {
            param1 = param2;
         }
         if(this.$$_mask)
         {
            this.$$_mask.graphics.clear();
            this.$$_mask.graphics.beginFill(0,0);
            this.$$_mask.graphics.drawRect(0,0,param1 * 85 / param2,20);
            this.$$_mask.graphics.endFill();
         }
      }
    dispose() {
         this._progressBgHbox.removeAllChild();
         this._progressHbox.removeAllChild();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._progressBgHbox);
         this._progressBgHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._progressBgHbox);
         this._progressBgHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._luckyBg);
         this._luckyBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lucky);
         this._lucky = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.$$_mask);
         this.$$_mask = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__LuckyProgressView, "outercityshop.view.LuckyProgressView", []);
  return __LuckyProgressView;
}
deps["outercityshop.view.LuckyProgressView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["outercityshop.view.OuterCityShopExchangeView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __OuterCityShopExchangeView extends __Base {
    static $fields(self) {
    self._exchangeList = null;
    self._lastPageBtn = null;
    self._nextPageBtn = null;
    self._pageBg = null;
    self._pageTxt = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._exchangeList = new $.Vector();
         this.createExchangeList();
         this._pageBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.PageBg");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.PageTextStyle");
         this._lastPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.LastPageBtn");
         this._nextPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.NextPageBtn");
         this.addChild(this._pageBg);
         this.addChild(this._pageTxt);
         this.addChild(this._lastPageBtn);
         this.addChild(this._nextPageBtn);
      }
    addEvent() {
         this._lastPageBtn.addEventListener("click",$.bind(this, "__onPageHandler"));
         this._nextPageBtn.addEventListener("click",$.bind(this, "__onPageHandler"));
         this.model.addEventListener("EXCHANGE_GOODS_LIST_UPDATE",$.bind(this, "__refreshViewHandler"));
      }
    removeEvent() {
         this._lastPageBtn.removeEventListener("click",$.bind(this, "__onPageHandler"));
         this._nextPageBtn.removeEventListener("click",$.bind(this, "__onPageHandler"));
         this.model.removeEventListener("EXCHANGE_GOODS_LIST_UPDATE",$.bind(this, "__refreshViewHandler"));
      }
    createExchangeList() {
         var _loc4_ = 0;
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc1_ = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new ($.C("outercityshop.view.OuterCityShopGoodsItem"))();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            this._exchangeList.push(_loc1_);
            this.addChild(_loc1_);
            _loc3_++;
         }
      }
    __refreshViewHandler(param1) {
         var _loc3_ = 1;
         var _loc2_ = 1;
         this._pageTxt.text = this.model.currentPage + "/" + this.model.totalPage;
         this._lastPageBtn.enable = this.model.currentPage != 1;
         this._nextPageBtn.enable = this.model.currentPage != this.model.totalPage;
         this.updateExchangeGoodsListData();
      }
    updateExchangeGoodsListData() {
         var _loc2_ = null;
         var _loc1_ = 0;
         if(this.model.showGoodsList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._exchangeList.length)
            {
               if(this.model.showGoodsList[_loc1_])
               {
                  _loc2_ = new ($.C("mvc.module.outercityshop.OuterCityShopItemInfo"))();
                  _loc2_.isBuy = false;
                  _loc2_.itemTemInfo = $.as(this.model.showGoodsList[_loc1_], $.C("mvc.module.outercityshop.OuterCityShopGoodsInfo"));
                  if(_loc2_.itemTemInfo.Point > 0)
                  {
                     _loc2_.costInfos.push([-400,_loc2_.itemTemInfo.Point]);
                  }
                  if(_loc2_.itemTemInfo.Score > 0)
                  {
                     _loc2_.costInfos.push(["Score",_loc2_.itemTemInfo.Score]);
                  }
                  if(_loc2_.itemTemInfo.SecretStone > 0)
                  {
                     _loc2_.costInfos.push([2131057,_loc2_.itemTemInfo.SecretStone]);
                  }
                  if(_loc2_.itemTemInfo.Strategy > 0)
                  {
                     _loc2_.costInfos.push([-300,_loc2_.itemTemInfo.Strategy]);
                  }
                  if(_loc2_.itemTemInfo.Crystal > 0)
                  {
                     _loc2_.costInfos.push([-600,_loc2_.itemTemInfo.Crystal]);
                  }
                  this._exchangeList[_loc1_].data = _loc2_;
               }
               else
               {
                  this._exchangeList[_loc1_].data = null;
               }
               _loc1_++;
            }
         }
      }
    __onPageHandler(param1) {
         this.outercityShopControler.pageBtnHandler(param1.currentTarget == this._lastPageBtn);
      }
    get outercityShopControler() {
         return $.C("yishi.manager.FrameControllerManager").instance.outerCityShopControler;
      }
    get model() {
         return $.C("managers.OuterCityShopManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set outercityShopControler(v) { super.outercityShopControler = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__OuterCityShopExchangeView, "outercityshop.view.OuterCityShopExchangeView", ["Disposeable"]);
  return __OuterCityShopExchangeView;
}
deps["outercityshop.view.OuterCityShopExchangeView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "managers.OuterCityShopManager", "mvc.module.outercityshop.OuterCityShopGoodsInfo", "mvc.module.outercityshop.OuterCityShopItemInfo", "outercityshop.view.OuterCityShopGoodsItem", "yishi.manager.FrameControllerManager"];

defs["outercityshop.view.OuterCityShopGoodsFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __OuterCityShopGoodsFrame extends __Base {
    static $fields(self) {
    self._goodsBackBg = null;
    self._goodsBack = null;
    self._goodsView = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("outercityshop.OuterCityShopFrame.linkText");
         this._goodsBackBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.goodsBackBg");
         this._goodsBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.goodsBack");
         this._goodsView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.goodsView");
         this.addToContent(this._goodsBackBg);
         this.addToContent(this._goodsBack);
         this.addToContent(this._goodsView);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
      }
    dispose() {
         this.removeEvent();
         if(this._goodsBackBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodsBackBg);
         }
         this._goodsBackBg = null;
         if(this._goodsBack)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodsBack);
         }
         this._goodsBack = null;
         if(this._goodsView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodsView);
         }
         this._goodsView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
  }
  $.meta(__OuterCityShopGoodsFrame, "outercityshop.view.OuterCityShopGoodsFrame", []);
  return __OuterCityShopGoodsFrame;
}
deps["outercityshop.view.OuterCityShopGoodsFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr"];

defs["outercityshop.view.OuterCityShopGoodsItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __OuterCityShopGoodsItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._nameTxt = null;
    self._priceTxt = null;
    self._goods = null;
    self._buyBtn = null;
    self._boughtBtn = null;
    self._priceIcon = null;
    self._pointsIcon = null;
    self._dropImg = null;
    self.sprite = null;
    self._hBox = null;
    self._itemInfo = null;
    self._goodsTempInfo = null;
    self._goodsInfo = null;
    self._needValueCount = [];
    self._needValueItemId = [];
    self._items = [];
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsItemBg");
         this._buyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsBuyBtn");
         this._boughtBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsBoughtBtn");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsNameTextStyle");
         this._dropImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.dropImg");
         this._goods = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.OuterCityShopGoodsBaseItemView");
         this._hBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsHbox");
         this.addChild(this._bg);
         this._bg.setFrame(1);
         this.addChild(this._nameTxt);
         this.addChild(this._hBox);
         this.addChild(this._goods);
         this.addChild(this._dropImg);
         this._boughtBtn.enable = false;
      }
    set data(param1) {
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = false;
         this.clean();
         if(param1)
         {
            this.addEvent();
            this._itemInfo = param1;
            this._goodsTempInfo = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._itemInfo.itemTemInfo.ItemId);
            if(!this._goodsTempInfo)
            {
               this.data = null;
               return;
            }
            this._goodsInfo = new ($.C("yishi.datas.goods.GoodsInfo"))();
            this._goodsInfo.templateId = this._goodsTempInfo.TemplateId;
            this._goodsInfo.count = this._itemInfo.itemTemInfo.Count;
            this._goods.data = this._goodsInfo;
            this._nameTxt.text = this._goodsTempInfo.TemplateName;
            this._nameTxt.y = this._nameTxt.numLines > 1 ? 4 : 15;
            _loc4_ = false;
            if(this._itemInfo.costInfos)
            {
               for (var _loc2_ of $.values(this._itemInfo.costInfos))
               {
                  if(_loc2_[0] == "Score")
                  {
                     _loc4_ = true;
                     this._needValueCount.push(_loc2_[1]);
                     this._needValueItemId.push("Score");
                     this.sprite = new ($.C("flash.display.Sprite"))();
                     this._priceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsValueTextStyle");
                     this._priceTxt.text = _loc2_[1];
                     this.sprite.addChild(this._priceTxt);
                     this._items.push(this._priceTxt);
                     this._pointsIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.PointsImg");
                     this._pointsIcon.x = this._priceTxt.textWidth + 5;
                     this.sprite.addChild(this._pointsIcon);
                     this._items.push(this._pointsIcon);
                     this._hBox.addChild(this.sprite);
                  }
                  else
                  {
                     _loc5_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc2_[0]);
                     if(_loc5_)
                     {
                        _loc3_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                        _loc3_.templateId = _loc5_.TemplateId;
                        this._needValueCount.push(_loc2_[1]);
                        this._needValueItemId.push(_loc5_.TemplateId);
                        this.sprite = new ($.C("flash.display.Sprite"))();
                        this._priceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.OuterCityShopGoodsValueTextStyle");
                        this._priceTxt.text = _loc2_[1];
                        this.sprite.addChild(this._priceTxt);
                        this._items.push(this._priceTxt);
                        this._priceIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.OuterCityShopGoodsValueIcon");
                        this._priceIcon.icon = $.C("yishi.utils.IconFactory").getOuterCityShopIconPath(_loc5_.TemplateId);
                        this._priceIcon.tipData = _loc5_.TemplateName;
                        if(_loc5_.TemplateId == 2131057)
                        {
                           this._priceIcon.tipData = _loc5_.Description;
                        }
                        this._priceIcon.x = this._priceTxt.textWidth + 5;
                        this.sprite.addChild(this._priceIcon);
                        this._items.push(this._priceIcon);
                        this._hBox.addChild(this.sprite);
                     }
                  }
               }
            }
            this._hBox.x = 250 - this._hBox.width;
            if(_loc4_)
            {
               this._hBox.x = 239 - this._hBox.width;
            }
            if(this._itemInfo.itemTemInfo.IsDrop == 1)
            {
               this._dropImg.visible = true;
            }
            if(this._itemInfo.isBuy)
            {
               this.useBoughtBtn();
            }
            else
            {
               this.useBuyBtn();
            }
         }
         else
         {
            this.removeEvent();
         }
      }
    getCountStr(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = param1 / 1000;
         if(param1 % 1000 == 0)
         {
            if(_loc2_ >= 1)
            {
               return $.int(_loc2_) + "K";
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
               return $.int(_loc2_) + "K";
            }
         }
         return param1.toString();
      }
    useBuyBtn() {
         if(this._boughtBtn && this._boughtBtn.parent)
         {
            this._boughtBtn.parent.removeChild(this._boughtBtn);
         }
         if(this._buyBtn)
         {
            this.addChild(this._buyBtn);
         }
      }
    useBoughtBtn() {
         if(this._boughtBtn)
         {
            this.addChild(this._boughtBtn);
         }
         if(this._buyBtn && this._buyBtn.parent)
         {
            this._buyBtn.parent.removeChild(this._buyBtn);
         }
      }
    addEvent() {
         this.addEventListener("mouseOut",$.bind(this, "__onMouseOutHandler"));
         this.addEventListener("mouseOver",$.bind(this, "__onMouseOverHandler"));
         this._buyBtn.addEventListener("click",$.bind(this, "__onBuyBtnHandler"));
      }
    removeEvent() {
         this.removeEventListener("mouseOut",$.bind(this, "__onMouseOutHandler"));
         this.removeEventListener("mouseOver",$.bind(this, "__onMouseOverHandler"));
         if(this._buyBtn)
         {
            this._buyBtn.removeEventListener("click",$.bind(this, "__onBuyBtnHandler"));
         }
      }
    get checkGoods() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         for(; _loc2_ < this._needValueCount.length; _loc2_++)
         {
            if(this._needValueItemId[_loc2_] == "Score")
            {
               if($.C("managers.OuterCityShopManager").instance.model.consumePoints < this._needValueCount[_loc2_])
               {
                  $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("outercityshop.goodsItemTip",$.C("manager.LanguageMgr").GetTranslation("outercityshop.score")));
                  return true;
               }
               continue;
            }
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._needValueItemId[_loc2_]).TemplateName;
            switch(this._needValueItemId[_loc2_])
            {
               case -100:
                  if($.C("yishi.manager.ResourceManager").instance.gold.count < this._needValueCount[_loc2_])
                  {
                     $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case -300:
                  if(this.playerModel.playerInfo.strategy < this._needValueCount[_loc2_])
                  {
                     $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case -400:
                  if(this.playerModel.playerInfo.point + this.playerModel.playerInfo.giftToken < this._needValueCount[_loc2_])
                  {
                     $.C("yishi.manager.RechargeAlertMannager").show();
                     return true;
                  }
                  break;
               case -600:
                  if($.C("yishi.manager.ResourceManager").instance.waterCrystal.count < this._needValueCount[_loc2_])
                  {
                     $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case 2131057:
                  if($.C("yishi.manager.GoodsManager").instance.getGoodsNumByTempId(2131057) < this._needValueCount[_loc2_])
                  {
                     $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
                  break;
               case 208001:
                  if($.C("managers.PlayerCurrencyManager").instance.currencyInfo.arenaMedal.amount < this._needValueCount[_loc2_])
                  {
                     $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("outercityshop.goodsItemTip",_loc1_));
                     return true;
                  }
            }
         }
         return false;
      }
    __onBuyBtnHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc5_ = null;
         var _loc4_ = null;
         var _loc8_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this.checkGoods)
         {
            return;
         }
         var _loc7_ = this.getConfirmContent();
         if(this._itemInfo.itemTemInfo.Type == 1)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "confirmBuyBack")];
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
            return;
         }
         if($.C("yishi.manager.SharedManagerHelper").ins.isNeedAlert("outercityshop_GoodsItem_buyBtnHandle"))
         {
            $.C("yishi.manager.SharedManagerHelper").ins.needAlert("outercityshop_GoodsItem_buyBtnHandle",$.bind(this, "buyGoodsHandlerBack"),$.C("manager.LanguageMgr").GetTranslation("active.expback.frame.selectbtntxt"),_loc7_,"");
         }
         else
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "confirmBuyBack2")];
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc8_,_loc7_,_loc5_,_loc4_,true,false,false,2,"SIMPLE_ALERT");
         }
      }
    getConfirmContent() {
         var _loc1_ = 0;
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("outercityshop.goodsItem.tipContent",this._goodsTempInfo.TemplateName);
         _loc1_ = 0;
         while(_loc1_ < this._needValueCount.length)
         {
            if(this._needValueItemId[_loc1_] == "Score")
            {
               _loc2_ += " " + $.C("manager.LanguageMgr").GetTranslation("outercityshop.score") + "x" + this._needValueCount[_loc1_];
            }
            else
            {
               _loc2_ += " " + $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._needValueItemId[_loc1_]).TemplateName + "x" + this._needValueCount[_loc1_];
            }
            _loc1_++;
         }
         return _loc2_;
      }
    confirmBuyBack(param1, param2) {
         if(param1)
         {
            this.buyGoodsHandlerBack(false);
         }
      }
    confirmBuyBack2(param1, param2) {
         var _loc3_ = null;
         if(param1)
         {
            _loc3_ = this.getConfirmContent();
            $.C("yishi.manager.SharedManagerHelper").ins.needAlert("outercityshop_GoodsItem_buyBtnHandle",$.bind(this, "buyGoodsHandlerBack"),$.C("manager.LanguageMgr").GetTranslation("active.expback.frame.selectbtntxt"),_loc3_,"");
         }
      }
    buyGoodsHandlerBack(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = param1 ? 2 : 1;
         if(this._itemInfo.itemTemInfo.Type == 2)
         {
            $.C("managers.OuterCityShopManager").instance.sendAction(2,this._itemInfo.itemTemInfo.Type,this._itemInfo.index,_loc2_);
         }
         else if(this._itemInfo.itemTemInfo.Type == 1)
         {
            $.C("managers.OuterCityShopManager").instance.sendAction(2,this._itemInfo.itemTemInfo.Type,this._itemInfo.itemTemInfo.MapShopId,_loc2_);
         }
         if(this.outercityShopControler.frame)
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = this.outercityShopControler.frame;
         }
      }
    clean() {
         this._needValueCount = [];
         this._needValueItemId = [];
         this._hBox.disposeAllChildren();
         if(this._boughtBtn && this._boughtBtn.parent)
         {
            this._boughtBtn.parent.removeChild(this._boughtBtn);
         }
         if(this._buyBtn && this._buyBtn.parent)
         {
            this._buyBtn.parent.removeChild(this._buyBtn);
         }
         this._goods.data = null;
         if(this._priceIcon)
         {
            this._priceIcon = null;
         }
         this._bg.setFrame(1);
         this._nameTxt.text = "";
         if(this._priceTxt)
         {
            this._priceTxt = null;
         }
         if(this.sprite)
         {
            this.sprite = null;
         }
         this._dropImg.visible = false;
      }
    __onMouseOverHandler(param1) {
         this._bg.setFrame(2);
      }
    __onMouseOutHandler(param1) {
         this._bg.setFrame(1);
      }
    get outercityShopControler() {
         return $.C("yishi.manager.FrameControllerManager").instance.outerCityShopControler;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    dispose() {
         if(this._bg)
         {
            this._bg.dispose();
         }
         this._bg = null;
         if(this._nameTxt)
         {
            this._nameTxt.dispose();
         }
         this._nameTxt = null;
         if(this._priceTxt)
         {
            this._priceTxt.dispose();
         }
         this._priceTxt = null;
         if(this._goods)
         {
            this._goods.dispose();
         }
         this._goods = null;
         if(this._buyBtn)
         {
            this._buyBtn.dispose();
         }
         this._buyBtn = null;
         if(this._boughtBtn)
         {
            this._boughtBtn.dispose();
         }
         this._boughtBtn = null;
         if(this._priceIcon)
         {
            this._priceIcon.dispose();
         }
         this._priceIcon = null;
         if(this._pointsIcon)
         {
            this._pointsIcon.dispose();
         }
         this._pointsIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dropImg);
         this._dropImg = null;
         if(this._items)
         {
            while(this._items.length > 0)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._items.pop());
            }
            this._items = null;
         }
         if(this._hBox)
         {
            this._hBox.disposeAllChildren();
            this._hBox.dispose();
         }
         this._hBox = null;
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._buyBtn = null;
         this._itemInfo = null;
         this._goodsTempInfo = null;
         this._goodsInfo = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
    set checkGoods(v) { super.checkGoods = v; }
    set outercityShopControler(v) { super.outercityShopControler = v; }
    set playerModel(v) { super.playerModel = v; }
  }
  $.meta(__OuterCityShopGoodsItem, "outercityshop.view.OuterCityShopGoodsItem", ["Disposeable"]);
  return __OuterCityShopGoodsItem;
}
deps["outercityshop.view.OuterCityShopGoodsItem"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "managers.OuterCityShopManager", "managers.PlayerCurrencyManager", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.manager.ResourceManager", "yishi.manager.SharedManagerHelper", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["outercityshop.view.OuterCityShopGoodsView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __OuterCityShopGoodsView extends __Base {
    static $fields(self) {
    self._lastPageBtn = null;
    self._nextPageBtn = null;
    self._pageBg = null;
    self._pageTxt = null;
    self._goodsLists = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         var _loc1_ = null;
         var _loc2_ = 0;
         var _loc3_ = 0;
         this._goodsLists = new $.Vector();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = 0;
            while(_loc3_ < 6)
            {
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.goodsItemView");
               _loc1_.x = _loc3_ * 70;
               _loc1_.y = _loc2_ * 70;
               this._goodsLists.push(_loc1_);
               this.addChild(_loc1_);
               _loc3_++;
            }
            _loc2_++;
         }
         this._pageBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.lookPageBg");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.lookPageTextStyle");
         this._lastPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.lookLastPageBtn");
         this._nextPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.lookNextPageBtn");
         this.addChild(this._pageBg);
         this.addChild(this._pageTxt);
         this.addChild(this._lastPageBtn);
         this.addChild(this._nextPageBtn);
      }
    addEvent() {
         this._lastPageBtn.addEventListener("click",$.bind(this, "__onPageHandler"));
         this._nextPageBtn.addEventListener("click",$.bind(this, "__onPageHandler"));
         this.model.addEventListener("LOOK_GOODS_LIST_UPDATE",$.bind(this, "__refreshViewHandler"));
      }
    removeEvent() {
         this._lastPageBtn.removeEventListener("click",$.bind(this, "__onPageHandler"));
         this._nextPageBtn.removeEventListener("click",$.bind(this, "__onPageHandler"));
         this.model.removeEventListener("LOOK_GOODS_LIST_UPDATE",$.bind(this, "__refreshViewHandler"));
      }
    __refreshViewHandler(param1) {
         var _loc3_ = 1;
         var _loc2_ = 1;
         this._pageTxt.text = this.model.currentLookPage + " / " + this.model.totalLookPage;
         this._lastPageBtn.enable = this.model.currentLookPage != 1;
         this._nextPageBtn.enable = this.model.currentLookPage != this.model.totalLookPage;
         this.updateLookGoodsListData();
      }
    updateLookGoodsListData() {
         var _loc2_ = null;
         var _loc1_ = 0;
         if(this.model.showLookGoodsList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._goodsLists.length)
            {
               if(this.model.showLookGoodsList[_loc1_])
               {
                  _loc2_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                  _loc2_.templateId = this.model.showLookGoodsList[_loc1_].ItemId;
                  _loc2_.count = this.model.showLookGoodsList[_loc1_].Count;
                  this._goodsLists[_loc1_].data = _loc2_;
               }
               else
               {
                  this._goodsLists[_loc1_].data = null;
               }
               _loc1_++;
            }
         }
      }
    __onPageHandler(param1) {
         this.outercityShopControler.pageLookHandler(param1.currentTarget == this._lastPageBtn);
      }
    get outercityShopControler() {
         return $.C("yishi.manager.FrameControllerManager").instance.outerCityShopControler;
      }
    get model() {
         return $.C("managers.OuterCityShopManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         this._goodsLists = null;
         if(this._pageBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pageBg);
         }
         this._pageBg = null;
         if(this._pageTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pageTxt);
         }
         this._pageTxt = null;
         if(this._lastPageBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lastPageBtn);
         }
         this._lastPageBtn = null;
         if(this._nextPageBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextPageBtn);
         }
         this._nextPageBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set outercityShopControler(v) { super.outercityShopControler = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__OuterCityShopGoodsView, "outercityshop.view.OuterCityShopGoodsView", ["Disposeable"]);
  $.statics(__OuterCityShopGoodsView, () => {
    __OuterCityShopGoodsView.COLUMN_NUM = 6;
    __OuterCityShopGoodsView.ROW_NUM = 5;
    __OuterCityShopGoodsView.PAGE_COUNT = 1;
  });
  return __OuterCityShopGoodsView;
}
deps["outercityshop.view.OuterCityShopGoodsView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "managers.OuterCityShopManager", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager"];

defs["outercityshop.view.OuterCityShopLeftView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __OuterCityShopLeftView extends __Base {
    static $fields(self) {
    self._luckBack = null;
    self._luckTxtBitmap = null;
    self._tipAsset = null;
    self._tipAssetBg = null;
    self._scrolPanel = null;
    self._vBox = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._luckBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.luckBack");
         this._luckTxtBitmap = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.luckTxtBitmap");
         this._tipAssetBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.tipAssetBg");
         this._tipAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.outercityshop.tipAsset");
         this._scrolPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.ScrollPanel");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.Vbox");
         this.addChild(this._luckBack);
         this.addChild(this._luckTxtBitmap);
         this.addChild(this._tipAssetBg);
         this.addChild(this._tipAsset);
         this.addChild(this._scrolPanel);
         this._scrolPanel.beginChanges();
         this._scrolPanel.setView(this._vBox,true);
         this._scrolPanel.invalidateViewport();
         this.__updateLuckShowInfoHandler(null);
      }
    addEvent() {
         this.model.addEventListener("UPDATE_LUCK_SHOW_INFO",$.bind(this, "__updateLuckShowInfoHandler"));
      }
    __updateLuckShowInfoHandler(param1) {
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc3_ = null;
         this._vBox.removeAllChild();
         this._vBox.disposeAllChildren();
         this._vBox.beginChanges();
         if(this.model.shopLuckShowInfo)
         {
            _loc4_ = 0;
            while(_loc4_ < this.model.shopLuckShowInfo.length)
            {
               _loc2_ = new ($.C("auction.view.mysteryshop.MysteryShopEventItem"))();
               _loc3_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("chat.datas.ChatData")), $.C("chat.datas.ChatData"));
               _loc3_.channel = 103;
               _loc3_.msg = this.model.shopLuckShowInfo[_loc4_];
               _loc3_.chatItemData.cellVector = $.C("chat.utils.ChatFormat").getContentCellData(_loc3_);
               _loc2_.data = _loc3_;
               this._vBox.addChildAt(_loc2_,0);
               _loc4_++;
            }
         }
         this._vBox.commitChanges();
         if(param1 == null)
         {
            this._scrolPanel.invalidateViewport(true);
         }
         else
         {
            this._scrolPanel.invalidateViewport();
         }
      }
    removeEvent() {
         this.model.removeEventListener("UPDATE_LUCK_SHOW_INFO",$.bind(this, "__updateLuckShowInfoHandler"));
      }
    get model() {
         return $.C("managers.OuterCityShopManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set model(v) { super.model = v; }
  }
  $.meta(__OuterCityShopLeftView, "outercityshop.view.OuterCityShopLeftView", ["Disposeable"]);
  return __OuterCityShopLeftView;
}
deps["outercityshop.view.OuterCityShopLeftView"] = ["auction.view.mysteryshop.MysteryShopEventItem", "chat.datas.ChatData", "chat.utils.ChatFormat", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "managers.OuterCityShopManager"];

defs["outercityshop.view.OuterCityShopRandomView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __OuterCityShopRandomView extends __Base {
    static $fields(self) {
    self._buyGoodsList = null;
    self._quickRefreshBtn = null;
    self._selectedView = null;
    self._lastClickTime = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._buyGoodsList = new $.Vector();
         this.createGoodsList();
         this._selectedView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("outercityshop.view.selectedView");
         this._quickRefreshBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.QuickRefreshBtn");
         this.addChild(this._selectedView);
         this.addChild(this._quickRefreshBtn);
         this.updateGoodsListData();
      }
    addEvent() {
         this.model.addEventListener("FRESH_VIEW",$.bind(this, "__freshViewHandler"));
         this._quickRefreshBtn.addEventListener("click",$.bind(this, "__quickFreshHandler"));
      }
    setIsFreeFreshAble(param1) {
      }
    __freshViewHandler(param1) {
         this.updateGoodsListData();
      }
    __freeFreshHandler(param1) {
         this.setIsFreeFreshAble(false);
         this.freshGoods();
      }
    __quickFreshHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc4_ = $.C("flash.utils.getTimer")();
         if(_loc4_ - this._lastClickTime < 400)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         this._lastClickTime = _loc4_;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this.model.goodsList)
         {
            return;
         }
         this.model.payType = this._selectedView.payType;
         if(this.checkGoods)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "checkGoodsHandlerBack")];
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("outercityshop.QuickRefreshGoodsTip");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
            return;
         }
         this.checkFresh();
      }
    get checkGoods() {
         for (var _loc1_ of $.values(this.model.goodsList))
         {
            if(!_loc1_.isBuy && _loc1_.itemTemInfo.IsDrop == 1)
            {
               return true;
            }
         }
         return false;
      }
    checkGoodsHandlerBack(param1, param2) {
         if(param1)
         {
            this.checkFresh();
         }
      }
    checkFresh() {
         if(this.model.payType == 1)
         {
            if(this.model.refreshNeedPoint > this.playerModel.playerInfo.point + this.playerModel.playerInfo.giftToken)
            {
               $.C("yishi.manager.RechargeAlertMannager").show();
               return;
            }
            this.alertTodayFrame();
         }
         else
         {
            if(this.model.refreshNeedPoint > this.model.consumePoints)
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("outercityshop.QuickRefreshScoreTip"));
               return;
            }
            this.freshGoods();
         }
      }
    alertTodayFrame() {
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc1_ = null;
         if(__OuterCityShopRandomView.needAlert)
         {
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.RiverNotAlert3");
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("outercityshop.QuickRefreshPointTip",this.model.refreshNeedPoint);
            _loc1_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc3_.show(_loc2_,_loc1_,$.bind(this, "__todayNotAlertFresh"),null,"center",2,true);
         }
         else
         {
            this.freshGoods($.C("yishi.manager.SharedManager").instance.outercityshopFreshUseBind);
         }
      }
    __todayNotAlertFresh(param1, param2) {
         if(param1)
         {
            __OuterCityShopRandomView.needAlert = false;
            $.C("yishi.manager.SharedManager").instance.outercityshopFreshUseBind = param2;
            $.C("yishi.manager.SharedManager").instance.saveOutercityshopFreshAlert();
         }
         this.freshGoods(param2);
      }
    freshGoods(param1 = true) {
         $.C("managers.OuterCityShopManager").instance.sendAction(3,this.model.payType,param1 ? 2 : 1);
         this.setIsFreeFreshAble(false);
      }
    removeEvent() {
         this.model.removeEventListener("FRESH_VIEW",$.bind(this, "__freshViewHandler"));
         this._quickRefreshBtn.removeEventListener("click",$.bind(this, "__quickFreshHandler"));
      }
    createGoodsList() {
         var _loc4_ = 0;
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc1_ = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new ($.C("outercityshop.view.OuterCityShopGoodsItem"))();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            this._buyGoodsList.push(_loc1_);
            this.addChild(_loc1_);
            _loc3_++;
         }
      }
    updateGoodsListData() {
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this._buyGoodsList.length)
         {
            if(this.model.goodsList && this.model.goodsList[_loc1_])
            {
               this._buyGoodsList[_loc1_].data = $.as(this.model.goodsList[_loc1_], $.C("mvc.module.outercityshop.OuterCityShopItemInfo"));
            }
            else
            {
               this._buyGoodsList[_loc1_].data = null;
            }
            _loc1_++;
         }
      }
    get model() {
         return $.C("managers.OuterCityShopManager").instance.model;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    dispose() {
         this.removeEvent();
         if(this._buyGoodsList)
         {
            this._buyGoodsList = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set checkGoods(v) { super.checkGoods = v; }
    set model(v) { super.model = v; }
    set playerModel(v) { super.playerModel = v; }
  }
  $.meta(__OuterCityShopRandomView, "outercityshop.view.OuterCityShopRandomView", ["Disposeable"]);
  $.statics(__OuterCityShopRandomView, () => {
    __OuterCityShopRandomView.needAlert = true;
  });
  return __OuterCityShopRandomView;
}
deps["outercityshop.view.OuterCityShopRandomView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.utils.getTimer", "manager.LanguageMgr", "managers.OuterCityShopManager", "mvc.module.outercityshop.OuterCityShopItemInfo", "outercityshop.view.OuterCityShopGoodsItem", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.manager.SharedManager", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["outercityshop.view.OuterCityShopSelectedView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __OuterCityShopSelectedView extends __Base {
    static $fields(self) {
    self._valueTxt = null;
    self._payIcon = null;
    self._buyNeed = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._valueTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.valueTxt");
         this._payIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outercityshop.payIconImg");
         this._payIcon.setFrame(1);
         this.addChild(this._valueTxt);
         this.addChild(this._payIcon);
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("ShopFresh_NeedDiamond");
         if(_loc1_)
         {
            this._buyNeed = $.int(_loc1_.ConfigValue);
         }
         this.__freshViewHandler(null);
      }
    addEvent() {
         this.model.addEventListener("FRESH_VIEW",$.bind(this, "__freshViewHandler"));
      }
    __freshViewHandler(param1) {
         this._valueTxt.text = $.C("manager.LanguageMgr").GetTranslation("outercityshop.nameTxt1") + " " + this._buyNeed;
         this.updateValueFrame(this._valueTxt,this.model.refreshNeedPoint > this.playerModel.playerInfo.point + this.playerModel.playerInfo.giftToken);
      }
    updateValueFrame(param1, param2) {
         if(param2)
         {
            param1.setFrame(2);
         }
         else
         {
            param1.setFrame(1);
         }
      }
    get payType() {
         return 1;
      }
    removeEvent() {
         this.model.removeEventListener("FRESH_VIEW",$.bind(this, "__freshViewHandler"));
      }
    get model() {
         return $.C("managers.OuterCityShopManager").instance.model;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
      }
    set payType(v) { super.payType = v; }
    set model(v) { super.model = v; }
    set playerModel(v) { super.playerModel = v; }
  }
  $.meta(__OuterCityShopSelectedView, "outercityshop.view.OuterCityShopSelectedView", []);
  return __OuterCityShopSelectedView;
}
deps["outercityshop.view.OuterCityShopSelectedView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "manager.LanguageMgr", "managers.OuterCityShopManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager"];
