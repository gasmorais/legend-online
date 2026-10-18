// @ts-nocheck
export const defs = {};
export const deps = {};
defs["colosseum.ChallengeSceneControl"] = function define($) {
  const __Base = $.C("yishi.scene.BaseSceneView");
  class __ChallengeSceneControl extends __Base {
    static $fields(self) {
    self._view = null;
    }
    constructor() {
         super();
      }
    get SceneName() {
         return "CHANLLENGE_ROOM_SCENE";
      }
    get model() {
         $.C("managers.ChallengeManager").instance.model;
         if(!$.C("yishi.manager.FrameControllerManager").instance.colosseumControler.model)
         {
            $.C("yishi.manager.FrameControllerManager").instance.colosseumControler.model = new ($.C("mvc.module.colosseum.ColosseumModel"))();
         }
         return $.C("yishi.manager.FrameControllerManager").instance.colosseumControler.model;
      }
    enter(param1, param2 = null) {
         super.enter(param1,param2);
         this._view = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeView");
         this.addChild(this._view);
         this.addEvent();
      }
    enterOver() {
         super.enterOver();
         $.C("chat.view.ChatTopBugleView").instance.setPos();
         $.C("ui.maintoolbar.MainToolBar").instance.show();
         $.C("mainBar.TipsBar").instance.show();
         $.C("mainBar.ChatBar").instance.show();
         $.C("mainBar.TimeBoxView").instance.hide();
         $.C("managers.ChallengeManager").instance.initModel();
         $.C("managers.ChallengeManager").instance.isLogin = true;
      }
    leaving() {
         super.leaving();
         this.removeEvent();
         if(this._view)
         {
            this._view["dispose"]();
            this._view.parent && this._view.parent.removeChild(this._view);
         }
         this._view = null;
         $.C("mainBar.TipsBar").instance.hide();
         $.C("mainBar.ChatBar").instance.hide();
         $.C("mainBar.TimeBoxView").instance.show();
         $.C("managers.ChallengeManager").instance.dispose();
      }
    get sceneView() {
         return this._view;
      }
    removeEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__resizeHanlder"));
         this.removeEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
      }
    addEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__resizeHanlder"));
         this.addEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
      }
    __resizeHanlder(param1) {
         this._view["resize"]($.C("com.pickgliss.toplevel.StageReferance").stageWidth,$.C("com.pickgliss.toplevel.StageReferance").stageHeight);
      }
    __addToStageHandler(param1) {
         this.__resizeHanlder(null);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.SceneViewEvent"))("addToStage","CHANLLENGE_ROOM_SCENE"));
      }
    set SceneName(v) { super.SceneName = v; }
    set model(v) { super.model = v; }
    set sceneView(v) { super.sceneView = v; }
  }
  $.meta(__ChallengeSceneControl, "colosseum.ChallengeSceneControl", []);
  $.statics(__ChallengeSceneControl, () => {
    __ChallengeSceneControl._model = null;
  });
  return __ChallengeSceneControl;
}
deps["colosseum.ChallengeSceneControl"] = ["chat.view.ChatTopBugleView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "mainBar.ChatBar", "mainBar.TimeBoxView", "mainBar.TipsBar", "managers.ChallengeManager", "mvc.module.colosseum.ColosseumModel", "ui.maintoolbar.MainToolBar", "yishi.events.SceneViewEvent", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.scene.BaseSceneView"];

defs["colosseum.ColosseumFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __ColosseumFrame extends __Base {
    static $fields(self) {
    self._back1 = null;
    self._selfView = null;
    self._order = null;
    self._orderback = null;
    self._orderbutton = null;
    self._ordertime = null;
    self._effect = null;
    self._itemList = null;
    self._timeId = 0;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
    initView() {
         this._itemList = [];
         this._back1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.FrameBack");
         this._selfView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.SelfView");
         this._orderback = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.queueBar.itemBgImg");
         this._orderbutton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("queueBar.StartBtn");
         this._ordertime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("queueBar.TimeTextOrder");
         this._effect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("queueBar.ItemMc");
         this.addToContent(this._back1);
         this.addToContent(this._selfView);
         this.initList();
         this._effect.x = 201;
         this._effect.y = 324;
         this._orderback.width = 155;
         this._orderbutton.x = 132;
         this._orderbutton.y = 3;
         this._ordertime.x = 9;
         this._ordertime.y = 1;
         this._ordertime.width = 130;
         this._orderbutton.visible = true;
         this._effect["pos"].addChild(this._orderback);
         this._effect["pos"].addChild(this._orderbutton);
         this._effect["pos"].addChild(this._ordertime);
         this._effect.gotoAndStop(1);
         this.addToContent(this._effect);
         this._orderbutton.tipData = $.C("manager.LanguageMgr").GetTranslation("mainBar.view.QueueItem.QuickText");
      }
    showEffect() {
         this.stopEffect();
         this._effect.play();
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "stopEffect"),3000);
      }
    stopEffect() {
         $.C("flash.utils.clearTimeout")(this._timeId);
         this._effect.gotoAndStop(1);
      }
    initList() {
         var _loc3_ = 0;
         var _loc1_ = null;
         var _loc4_ = this.model.heroList;
         var _loc2_ = $.int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.PlayerItem_" + _loc3_);
            if(_loc3_ < _loc2_)
            {
               _loc1_.thane = _loc4_[_loc3_];
            }
            this._itemList[_loc3_] = _loc1_;
            this.addToContent(_loc1_);
            _loc3_++;
         }
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         for (this._order of $.values($.C("yishi.manager.BuildingManager").instance.model.colosseumOrderList))
         {
            if(this._order.remainTime > 0)
            {
               this._order.addEventListener("change",$.bind(this, "__onChange"));
               this._order.addEventListener("complete",$.bind(this, "__completeHandler"));
               this._orderbutton.addEventListener("click",$.bind(this, "__clickHandler"));
               return;
            }
         }
         this.disposeOrder();
      }
    disposeOrder() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._orderback);
         this._orderback = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._orderbutton);
         this._orderbutton = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._ordertime);
         this._ordertime = null;
      }
    __onChange(param1) {
         if(this._order.remainTime > 0)
         {
            this._ordertime.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.ColosseumFrame.ordertime.text") + $.C("yishi.utils.DateFormatter").getCountDate(this._order.remainTime);
         }
         else
         {
            this.__completeHandler(null);
         }
      }
    __clickHandler(param1) {
         var _loc7_ = 0;
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc8_ = null;
         var _loc2_ = null;
         var _loc5_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc4_ = $.bind(this, "coolColosseBack");
         if($.C("managers.VIPManager").Instance.model.vipCoolPrivilege)
         {
            _loc4_(true,this._order.orderId);
         }
         else
         {
            _loc7_ = Math.ceil(this._order.remainTime / 60);
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipName");
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipContent",_loc7_);
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc3_.initData(_loc6_,_loc8_,this._order.orderId,_loc7_,_loc7_,_loc4_,_loc2_,_loc5_);
            _loc3_.show();
         }
      }
    coolColosseBack(param1, param2 = 0, param3 = 0, param4 = true) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if(param1)
         {
            $.C("yishi.service.managers.SocketSendManager").instance.sendCoolColosseun(param3,param4);
         }
      }
    __completeHandler(param1) {
         this.disposeOrder();
         this._order.removeEventListener("change",$.bind(this, "__onChange"));
         this._order.removeEventListener("complete",$.bind(this, "__completeHandler"));
         if(this._orderbutton)
         {
            this._orderbutton.removeEventListener("click",$.bind(this, "__clickHandler"));
         }
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._order)
         {
            this._order.removeEventListener("change",$.bind(this, "__onChange"));
            this._order.removeEventListener("complete",$.bind(this, "__completeHandler"));
         }
         if(this._orderbutton)
         {
            this._orderbutton.removeEventListener("click",$.bind(this, "__clickHandler"));
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
    show() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("colosseum.ColosseumFrame.titleText");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    getColosseumItemByIndex(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this._itemList[param1];
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.colosseumControler.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back1);
         this._back1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfView);
         this._selfView = null;
         for (var _loc1_ of $.values(this._itemList))
         {
            _loc1_.dispose();
         }
         if(this._itemList)
         {
            this._itemList.length = 0;
         }
         this._itemList = null;
         super.dispose();
      }
    set groups(v) { super.groups = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__ColosseumFrame, "colosseum.ColosseumFrame", []);
  return __ColosseumFrame;
}
deps["colosseum.ColosseumFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.utils.clearTimeout", "flash.utils.setTimeout", "manager.LanguageMgr", "managers.VIPManager", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager", "yishi.service.managers.SocketSendManager", "yishi.utils.DateFormatter"];

defs["colosseum.view.ChallengeLeftItemView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChallengeLeftItemView extends __Base {
    static $fields(self) {
    self._data = null;
    self._index = 0;
    self._icon = null;
    self._bg = null;
    self._titleImg = null;
    self._thaneNameTxt = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.HeadIconCell");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.ChallengeLeftItemBg");
         this._titleImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.challengeLeftItemTitle");
         this._thaneNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.challengeLeftView.thanename");
         this.addChild(this._icon);
         this.addChild(this._bg);
         this.addChild(this._titleImg);
         this.addChild(this._thaneNameTxt);
         this._thaneNameTxt.mouseEnabled = true;
         this._thaneNameTxt.htmlText = "<u>" + $.C("manager.LanguageMgr").GetTranslation("colosseum.view.defaultThaneName") + "</u>";
         this._icon.headId = 5;
         this._bg.setFrame(1);
         this._titleImg.setFrame(1);
      }
    initEvent() {
         this._thaneNameTxt.addEventListener("link",$.bind(this, "__thaneNameTxtHandler"));
      }
    removeEvent() {
         if(this._thaneNameTxt)
         {
            this._thaneNameTxt.removeEventListener("link",$.bind(this, "__thaneNameTxtHandler"));
         }
      }
    __thaneNameTxtHandler(param1) {
         var _loc2_ = new ($.C("yishi.datas.playerinfo.ThaneInfo"))();
         _loc2_.userId = this._data.army.baseHero.userId;
         _loc2_.nickName = this._data.army.baseHero.nickName;
         _loc2_.playerOrdeInfo.gpOrder = this._data.army.baseHero.playerOrdeInfo.gpOrder;
         _loc2_.grades = this._data.army.baseHero.grades;
         _loc2_.gp = this._data.army.baseHero.gp;
         _loc2_.templateId = this._data.army.baseHero.templateId;
         $.C("yishi.manager.PlayerInfoManager").instance.show(_loc2_);
      }
    set data(param1) {
         if(!param1)
         {
            return;
         }
         this._data = param1;
         this._thaneNameTxt.htmlText = "<a href=\'event:\'><u>" + this._data.nikcName + "</u></a>";
         if(this._index != 1)
         {
            this._titleImg.setFrame(this.data.army.baseHero.templateInfo.Job + 1);
         }
         this._icon.headId = this.data.army.baseHero.snsInfo.headId;
      }
    get data() {
         return this._data;
      }
    set index(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._index = param1;
         if(this._index <= 1)
         {
            this._bg.setFrame(1);
         }
         else
         {
            this._bg.setFrame(2);
         }
      }
    dispose() {
         this.removeEvent();
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleImg);
         this._titleImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._thaneNameTxt);
         this._thaneNameTxt = null;
      }
    get index() { return super.index; }
  }
  $.meta(__ChallengeLeftItemView, "colosseum.view.ChallengeLeftItemView", ["Disposeable"]);
  return __ChallengeLeftItemView;
}
deps["colosseum.view.ChallengeLeftItemView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.PlayerInfoManager"];

defs["colosseum.view.ChallengeLeftView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChallengeLeftView extends __Base {
    static $fields(self) {
    self._vbox = null;
    self.item_1 = null;
    self.item_2 = null;
    self.item_3 = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
         this.initData();
      }
    initView() {
         this._vbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.challengeLeftView.vbox");
         this.addChild(this._vbox);
         this.item_1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeLeftItemView");
         this.item_2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeLeftItemView");
         this.item_3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeLeftItemView");
         this.item_1.data = null;
         this.item_1.index = 1;
         this._vbox.addChild(this.item_1);
         this.item_2.data = null;
         this.item_2.index = 2;
         this._vbox.addChild(this.item_2);
         this.item_3.data = null;
         this.item_3.index = 3;
         this._vbox.addChild(this.item_3);
      }
    initEvent() {
         this.sortController.model.addEventListener("SELECTE_LIST_CHANG",$.bind(this, "__listChangeHandler"));
      }
    removeEvent() {
         this.sortController.model.removeEventListener("SELECTE_LIST_CHANG",$.bind(this, "__listChangeHandler"));
      }
    __listChangeHandler(param1) {
         var _loc4_ = 0;
         var _loc2_ = 0;
         var _loc5_ = 0;
         if(this.sortController.model.playerFightList.length > 0)
         {
            for (var _loc3_ of $.values(this.sortController.model.playerFightList))
            {
               if(!this.item_1.data)
               {
                  this.item_1.data = _loc3_;
                  _loc5_++;
                  _loc4_ = $.int(_loc3_.army.baseHero.templateInfo.Job);
               }
               else if(!this.item_2.data && _loc3_.army.baseHero.templateInfo.Job != _loc4_)
               {
                  this.item_2.data = _loc3_;
                  _loc5_++;
                  _loc2_ = $.int(_loc3_.army.baseHero.templateInfo.Job);
               }
               else if(!this.item_3.data && _loc3_.army.baseHero.templateInfo.Job != _loc4_ && _loc3_.army.baseHero.templateInfo.Job != _loc2_)
               {
                  this.item_3.data = _loc3_;
                  _loc5_++;
                  break;
               }
            }
         }
      }
    get sortController() {
         return $.C("yishi.manager.FrameControllerManager").instance.sortController;
      }
    initData() {
         var _loc1_ = null;
         while(this.sortController.model.playerFightList.length > 0)
         {
            _loc1_ = $.as(this.sortController.model.playerFightList.pop(), $.C("mvc.module.sort.SortData"));
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         this.sortController.model.currentSelected = 2;
         this.sortController.loadData("fight.xml");
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.item_1);
         this.item_1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.item_2);
         this.item_2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.item_3);
         this.item_3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._vbox);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vbox);
         this._vbox = null;
      }
    set sortController(v) { super.sortController = v; }
  }
  $.meta(__ChallengeLeftView, "colosseum.view.ChallengeLeftView", ["Disposeable"]);
  return __ChallengeLeftView;
}
deps["colosseum.view.ChallengeLeftView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "mvc.module.sort.SortData", "yishi.manager.FrameControllerManager"];

defs["colosseum.view.ChallengeMiddleItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChallengeMiddleItem extends __Base {
    static $fields(self) {
    self._thaneName = null;
    self._avatar = null;
    self._cushion = null;
    self._fightImg = null;
    self._fightSprite = null;
    self._rankSprite = null;
    self._rankBmd = null;
    self._fightBmp = null;
    self._avatarSprite = null;
    self._effect = null;
    self._notInRank = null;
    self._hitSprite = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._thaneName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.challengeMiddleView.thanename");
         this._avatar = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ShowAvatar",[false,$.bind(this, "__onCompleteHandler"),true]);
         this._cushion = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.middleView.cushion");
         this._fightImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.middleView.Fightimg");
         this._fightBmp = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.challenge.numTxt");
         this._effect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.challenge.selected");
         this._rankBmd = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.challenge.ranknumTxt");
         this._notInRank = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.notInRank");
         this._avatarSprite = new ($.C("com.pickgliss.ui.core.Component"))();
         this._fightSprite = new ($.C("flash.display.Sprite"))();
         this._rankSprite = new ($.C("flash.display.Sprite"))();
         this._hitSprite = new ($.C("flash.display.Sprite"))();
         this._fightSprite.y = 60;
         this._rankSprite.y = 21;
         this.addChild(this._cushion);
         this.addChild(this._effect);
         this._effect.mouseChildren = false;
         this._effect.mouseEnabled = false;
         this.addChild(this._avatarSprite);
         this.addChild(this._fightImg);
         this.addChild(this._fightSprite);
         this.addChild(this._rankSprite);
         this.addChild(this._thaneName);
         this.addChild(this._hitSprite);
         this.addChild(this._notInRank);
         this._notInRank.visible = false;
         this._avatarSprite.buttonMode = true;
         this._hitSprite.buttonMode = true;
      }
    initEvent() {
         this._avatarSprite.addEventListener("mouseOver",$.bind(this, "__overHandler"));
         this._avatarSprite.addEventListener("mouseOut",$.bind(this, "__outHandler"));
         this._avatarSprite.addEventListener("click",$.bind(this, "__avatarClickHandler"));
         this._hitSprite.addEventListener("click",$.bind(this, "__thaneNameHandler"));
      }
    removeEvent() {
         this._avatarSprite.removeEventListener("mouseOver",$.bind(this, "__overHandler"));
         this._avatarSprite.removeEventListener("mouseOut",$.bind(this, "__outHandler"));
         this._avatarSprite.removeEventListener("click",$.bind(this, "__avatarClickHandler"));
         this._hitSprite.removeEventListener("click",$.bind(this, "__thaneNameHandler"));
      }
    __avatarClickHandler(param1) {
         var _loc2_ = null;
         var _loc4_ = null;
         var _loc3_ = 0;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._data)
         {
            _loc2_ = "";
            if(!$.C("yishi.manager.BuildingManager").instance.model.checkHasIdleColosseumOrder())
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumListView.command02");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            _loc4_ = $.C("yishi.scene.SceneManager").instance.currentType;
            if(_loc4_ == "PVP_ROOM_SCENE" || _loc4_ == "PVP_ROOM_SCENE" || _loc4_ == "WARLORDS_ROOM")
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumListView.command03");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            if(_loc4_ == "CAMPAIGN_MAP_SCENE")
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("yishi.utils.WorldBossHelper").getCampaignTips());
               return;
            }
            if(this.model.remainFreeCount <= 0)
            {
               if(this.model.remainBuyCount > 0)
               {
                  _loc3_ = $.int(this.model.buyCountNeedPay);
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumPlayerItem.buyCountTip",_loc3_);
                  $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "sendChallenge"),_loc3_];
                  $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame($.C("manager.LanguageMgr").GetTranslation("public.prompt"),_loc2_,$.C("manager.LanguageMgr").GetTranslation("public.confirm"),$.C("manager.LanguageMgr").GetTranslation("public.cancel"),true,false,false,2,"USEBINDPOINT_ALERT");
               }
               else
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumListView.command01");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               }
               return;
            }
            this.sendChallenge(true,true);
         }
      }
    sendChallenge(param1, param2, param3 = 0) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = 0;
         if(param1 && this._data)
         {
            _loc4_ = $.int(param2 ? this.playerInfo.point + this.playerInfo.giftToken : this.playerInfo.point);
            if(_loc4_ < param3)
            {
               $.C("yishi.manager.RechargeAlertMannager").show();
               return;
            }
            $.C("battle.BattleManager").preScene = $.C("yishi.SwitchPageHelp").returnScene;
            $.C("managers.ChallengeManager").instance.sendChallengeById(this._data.userId,param2 ? 0 : 1);
         }
      }
    __overHandler(param1) {
         if(this._avatar)
         {
            $.C("com.greensock.TweenMax").to(this._avatar,0.5,{
               "glowFilter":{
                  "color":16777215,
                  "alpha":1,
                  "blurX":4,
                  "blurY":4,
                  "strength":10,
                  "quality":1
               },
               "repeat":-1,
               "yoyo":true
            });
         }
      }
    __outHandler(param1) {
         if(this._avatar)
         {
            $.C("com.greensock.TweenMax").killTweensOf(this._avatar);
            this._avatar.filters = [];
         }
      }
    get model() {
         return $.C("managers.ChallengeManager").instance.model;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    __thaneNameHandler(param1) {
         if($.C("yishi.manager.ArmyManager").instance.thane.grades < 16)
         {
            return;
         }
         $.C("yishi.manager.PlayerInfoManager").instance.show(this._data);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         if(!param1)
         {
            return;
         }
         this._data = param1;
         this._avatar.data = this._data;
         this.setFightNumberView(this._data.fightingCapacity);
         if(this._data.challengeRank > 0)
         {
            this._notInRank.visible = false;
            this.setRankNumberView(this._data.challengeRank);
         }
         else
         {
            this._notInRank.visible = true;
            this._notInRank.x = -27;
         }
         this._effect.gotoAndPlay(1);
         this._effect.visible = false;
         this._thaneName.htmlText = this._data.nickName;
         if(this._data.userId == this.thane.userId)
         {
            this._effect.visible = true;
            this._avatarSprite.mouseEnabled = false;
            this._hitSprite.mouseEnabled = false;
         }
         else
         {
            this._avatarSprite.mouseEnabled = true;
            this._hitSprite.mouseEnabled = true;
            this._effect.visible = false;
            this._thaneName.textFormatStyle = "colosseum.challengeMiddleView.thanename_t";
            this.setHitSprite();
         }
      }
    setHitSprite() {
         this._hitSprite.graphics.clear();
         this._hitSprite.graphics.beginFill(0,0);
         this._hitSprite.graphics.drawRect(this._thaneName.x,this._thaneName.y,this._thaneName.textWidth,this._thaneName.height);
         this._hitSprite.graphics.endFill();
      }
    setFightNumberView(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("yishi.utils.NumberViewUtils").refreshValue(param1,this._fightSprite,this._fightBmp,24,25,15,24,"0123456789");
      }
    setRankNumberView(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("yishi.utils.NumberViewUtils").refreshValue(param1,this._rankSprite,this._rankBmd,24,25,15,24,"0123456789");
      }
    __onCompleteHandler() {
         var _loc1_ = this._avatar.body.content;
         if(!_loc1_ || !_loc1_["pos_down"] || !_loc1_["pos_up"])
         {
            return;
         }
         this._avatar.x = -_loc1_["pos_down"]["x"] * 0.8;
         this._avatar.y = -_loc1_["pos_down"]["y"] * 0.8;
         this._thaneName.x = this._avatar.x + _loc1_["pos_up"]["x"] * 0.8 - this._thaneName.textWidth / 2;
         this._avatarSprite.addChild(this._avatar);
         this._fightImg.x = -(this._fightImg.width + this._fightSprite.width) / 2;
         this._fightSprite.x = this._fightImg.x + this._fightImg.width;
         this._rankSprite.x = -this._rankSprite.width / 2;
         this.setHitSprite();
      }
    get avatar() {
         return this._avatar;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._thaneName);
         this._thaneName = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllGrandson(this._avatar);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._avatar);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._avatar);
         this._avatar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cushion);
         this._cushion = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightImg);
         this._fightImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightSprite);
         this._fightSprite = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankSprite);
         this._rankSprite = null;
         this._rankBmd.dispose();
         this._rankBmd = null;
         this._fightBmp.dispose();
         this._fightBmp = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllGrandson(this._avatarSprite);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._avatarSprite);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._avatarSprite);
         this._avatarSprite = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._effect);
         this._effect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._notInRank);
         this._notInRank = null;
      }
    set model(v) { super.model = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set avatar(v) { super.avatar = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__ChallengeMiddleItem, "colosseum.view.ChallengeMiddleItem", ["Disposeable"]);
  return __ChallengeMiddleItem;
}
deps["colosseum.view.ChallengeMiddleItem"] = ["battle.BattleManager", "com.greensock.TweenMax", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "managers.ChallengeManager", "yishi.SwitchPageHelp", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.PlayerInfoManager", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.scene.SceneManager", "yishi.utils.NumberViewUtils", "yishi.utils.SimpleAlertHelper", "yishi.utils.WorldBossHelper", "yishi.view.tips.MessageTipManager"];

defs["colosseum.view.ChallengeMiddleView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChallengeMiddleView extends __Base {
    static $fields(self) {
    self._item0 = null;
    self._item1 = null;
    self._item2 = null;
    self._item3 = null;
    self._item4 = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
         this.refreshView(null);
      }
    initView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            this["_item" + _loc2_] = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeMiddleItem");
            _loc1_ = this["_item" + _loc2_];
            this.addChild(_loc1_);
            _loc2_++;
         }
      }
    refreshView(param1) {
         var _loc6_ = null;
         var _loc7_ = 0;
         var _loc8_ = 0;
         var _loc3_ = null;
         if(!this.model)
         {
            return;
         }
         var _loc9_ = this.model.heroList;
         var _loc2_ = this.thane;
         var _loc4_ = $.int(this.model.currentRank);
         _loc2_.challengeRank = _loc4_;
         _loc9_.push(_loc2_);
         var _loc5_ = $.int(_loc9_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = $.as(_loc9_[_loc7_], $.C("yishi.datas.playerinfo.ThaneInfo"));
            if(_loc4_ >= _loc6_.challengeRank)
            {
               _loc9_.splice(_loc7_,0,_loc2_);
               break;
            }
            _loc7_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 5)
         {
            _loc3_ = $.as(this["_item" + _loc8_], $.C("colosseum.view.ChallengeMiddleItem"));
            _loc3_.data = _loc9_[_loc8_];
            _loc8_++;
         }
      }
    initEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("REFRESH_CHALLENGE",$.bind(this, "refreshView"));
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("REFRESH_CHALLENGE",$.bind(this, "refreshView"));
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get model() {
         return $.C("managers.ChallengeManager").instance.model;
      }
    getItemByIdx(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         var _loc3_ = 0;
         var _loc4_ = this.model.heroList[param1];
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = $.as(this["_item" + _loc3_], $.C("colosseum.view.ChallengeMiddleItem"));
            if(_loc2_ && _loc2_.data == _loc4_)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
    resize(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc6_ = 0;
         this._item0.x = param3 + 90;
         var _loc5_ = param3 + 90;
         var _loc4_ = (param1 - 2 * _loc5_) / 4;
         if(_loc4_ <= 200)
         {
            _loc4_ = 200;
         }
         _loc6_ = 1;
         while(_loc6_ < 5)
         {
            this["_item" + _loc6_].x = param3 + 90 + _loc4_ * _loc6_;
            _loc6_++;
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._item0);
         this._item0 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._item1);
         this._item1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._item2);
         this._item2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._item3);
         this._item3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._item4);
         this._item4 = null;
      }
    set thane(v) { super.thane = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__ChallengeMiddleView, "colosseum.view.ChallengeMiddleView", ["Disposeable"]);
  return __ChallengeMiddleView;
}
deps["colosseum.view.ChallengeMiddleView"] = ["colosseum.view.ChallengeMiddleItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "managers.ChallengeManager", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.ArmyManager", "yishi.manager.NotificationManager"];

defs["colosseum.view.ChallengeTopView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChallengeTopView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._rankReward = null;
    self._SoulTxt = null;
    self._SoulImg = null;
    self._goldTxt = null;
    self._goldImg = null;
    self._getTimeImg = null;
    self._getTimeTxt = null;
    self._battleFieldBtn = null;
    self._rankBtn = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
         this.refreshView();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.topviewBg");
         this._rankReward = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.topviewReward");
         this._SoulTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.rewardSoultxt");
         this._SoulImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.RewardSoulIcon");
         this._goldImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.GoldIcon");
         this._goldTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.rewardGoldtxt");
         this._getTimeImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.topviewGetTime");
         this._getTimeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.getTimetxt");
         this._battleFieldBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.rinkBtn");
         this._rankBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.battleFieldBtn");
         this.addChild(this._bg);
         this.addChild(this._rankReward);
         this.addChild(this._SoulTxt);
         this.addChild(this._SoulImg);
         this._SoulImg.x = 256;
         this._SoulImg.y = 49;
         this.addChild(this._goldImg);
         this._goldImg.x = 182;
         this._goldImg.y = 51;
         this.addChild(this._goldTxt);
         this.addChild(this._getTimeImg);
         this.addChild(this._getTimeTxt);
         this.addChild(this._battleFieldBtn);
         this.addChild(this._rankBtn);
      }
    initEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("REFRESH_CHALLENGE",$.bind(this, "refreshView"));
         this._battleFieldBtn && this._battleFieldBtn.addEventListener("click",$.bind(this, "__battleFieldBtnHandler"));
         this._rankBtn && this._rankBtn.addEventListener("click",$.bind(this, "__rankBtnHandler"));
      }
    removeEvent() {
         this._battleFieldBtn && this._battleFieldBtn.removeEventListener("click",$.bind(this, "__battleFieldBtnHandler"));
         this._rankBtn && this._rankBtn.removeEventListener("click",$.bind(this, "__rankBtnHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("REFRESH_CHALLENGE",$.bind(this, "refreshView"));
      }
    __battleFieldBtnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.control.showRankFrame();
      }
    __rankBtnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.control.showEventFrame();
      }
    refreshView(param1 = null) {
         if(this.model)
         {
            this._goldTxt.text = this.getTakeCount(this.model.currentRank).toString();
            this._SoulTxt.text = this.getTakeCount(this.model.currentRank).toString();
            this._getTimeTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumSelfView.rewardDateValueText",this.model.leftDay);
         }
      }
    get thaneInfo() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.colosseumControler;
      }
    get model() {
         return $.C("managers.ChallengeManager").instance.model;
      }
    get sortController() {
         return $.C("yishi.manager.FrameControllerManager").instance.sortController;
      }
    getTakeCount(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc2_ = 0;
         var _loc4_ = 0;
         if(param1 == 0)
         {
            _loc2_ = 0;
         }
         else if(param1 == 1)
         {
            _loc2_ = 800000;
         }
         else if(param1 == 2)
         {
            _loc2_ = 600000;
         }
         else if(param1 >= 3 && param1 <= 4)
         {
            _loc2_ = 600000;
            _loc4_ = 3;
            while(_loc4_ < 5)
            {
               _loc2_ -= 100000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else if(param1 >= 5 && param1 <= 11)
         {
            _loc2_ = 400000;
            _loc4_ = 5;
            while(_loc4_ < 12)
            {
               _loc2_ -= 10000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else if(param1 >= 12 && param1 <= 51)
         {
            _loc2_ = 330000;
            _loc4_ = 12;
            while(_loc4_ < 52)
            {
               _loc2_ -= 5000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc2_ = 130000;
            _loc3_ = (param1 - 51) * 100;
            _loc2_ -= _loc3_;
            _loc2_ = $.int(_loc2_ < 1000 ? 1000 : _loc2_);
         }
         return _loc2_;
      }
    resize(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if((param1 - 415) / 2 < 315)
         {
            this.x = 315;
         }
         else
         {
            this.x = (param1 - 415) / 2;
         }
         this.y = 2;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankReward);
         this._rankReward = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._SoulTxt);
         this._SoulTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._SoulImg);
         this._SoulImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goldTxt);
         this._goldTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goldImg);
         this._goldImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._getTimeImg);
         this._getTimeImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._getTimeTxt);
         this._getTimeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._battleFieldBtn);
         this._battleFieldBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankBtn);
         this._rankBtn = null;
      }
    set thaneInfo(v) { super.thaneInfo = v; }
    set control(v) { super.control = v; }
    set model(v) { super.model = v; }
    set sortController(v) { super.sortController = v; }
  }
  $.meta(__ChallengeTopView, "colosseum.view.ChallengeTopView", ["Disposeable"]);
  return __ChallengeTopView;
}
deps["colosseum.view.ChallengeTopView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "managers.ChallengeManager", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager"];

defs["colosseum.view.ChallengeView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChallengeView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._leftChallengeView = null;
    self._topChallengeView = null;
    self._middleChallengeView = null;
    self._returnBtn = null;
    self._hasNumTxt = null;
    self._numTxtFiled = null;
    self._numTxt = null;
    self._order = null;
    self._orderback = null;
    self._orderbutton = null;
    self._ordertime = null;
    self._effect = null;
    self._hasBuyNumTxt = null;
    self._timeId = 0;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.bg");
         this._topChallengeView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeTopView");
         this._returnBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.returnBtn");
         this._leftChallengeView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeLeftView");
         this._middleChallengeView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("colosseum.ChallengeMiddleView");
         this._numTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.TodayCount2");
         this._hasNumTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.challenge.hasNumTxt");
         this._hasBuyNumTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.BuyCountTxtImg");
         this._numTxtFiled = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.challengeMiddleView.hasNumTxt");
         this._orderback = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.queueBar.itemBgImg");
         this._orderbutton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("queueBar.StartBtn");
         this._ordertime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("queueBar.TimeTextOrder");
         this._effect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("queueBar.ItemMc");
         this.addChild(this._bg);
         this.addChild(this._leftChallengeView);
         this.addChild(this._topChallengeView);
         this.addChild(this._returnBtn);
         this.addChild(this._middleChallengeView);
         this.addChild(this._hasNumTxt);
         this._hasNumTxt.y = 161;
         this.addChild(this._hasBuyNumTxt);
         this._hasBuyNumTxt.visible = false;
         this.addChild(this._numTxt);
         this._numTxt.y = 165;
         this.addChild(this._numTxtFiled);
         this._numTxtFiled.text = "99";
         this._orderback.width = 155;
         this._orderbutton.x = 132;
         this._orderbutton.y = 3;
         this._ordertime.x = 3;
         this._ordertime.y = 2;
         this._ordertime.width = 130;
         this._orderbutton.visible = true;
         this._effect["pos"].addChild(this._orderback);
         this._effect["pos"].addChild(this._orderbutton);
         this._effect["pos"].addChild(this._ordertime);
         this._effect.gotoAndStop(1);
         this._orderbutton.tipData = $.C("manager.LanguageMgr").GetTranslation("mainBar.view.QueueItem.QuickText");
         this.addChild(this._effect);
         for (this._order of $.values($.C("yishi.manager.BuildingManager").instance.model.colosseumOrderList))
         {
            if(this._order.remainTime > 0)
            {
               this._orderback.visible = true;
               this._orderbutton.visible = true;
               this._ordertime.visible = true;
               this._order.addEventListener("change",$.bind(this, "__onChange"));
               this._order.addEventListener("complete",$.bind(this, "__completeHandler"));
               this._orderbutton.addEventListener("click",$.bind(this, "__clickHandler"));
               this.__UpvipInfoHandler(null);
               return;
            }
            this._orderback.visible = false;
            this._orderbutton.visible = false;
            this._ordertime.visible = false;
         }
      }
    __completeHandler(param1) {
         this.disposeOrder();
         this._order.removeEventListener("change",$.bind(this, "__onChange"));
         this._order.removeEventListener("complete",$.bind(this, "__completeHandler"));
         if(this._orderbutton)
         {
            this._orderbutton.removeEventListener("click",$.bind(this, "__clickHandler"));
         }
      }
    disposeOrder() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._orderback);
         this._orderback = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._orderbutton);
         this._orderbutton = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._ordertime);
         this._ordertime = null;
      }
    __clickHandler(param1) {
         var _loc3_ = null;
         var _loc8_ = 0;
         var _loc4_ = null;
         var _loc7_ = null;
         var _loc9_ = null;
         var _loc2_ = null;
         var _loc6_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc5_ = $.bind(this, "coolColosseBack");
         if($.C("managers.VIPManager").Instance.model.vipCoolPrivilege)
         {
            _loc5_(true,this._order.orderId);
         }
         else
         {
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("Challenge_Cool").ConfigValue.split(",");
            _loc8_ = Math.ceil(this._order.remainTime / (60 * _loc3_[1])) * _loc3_[0];
            _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipName");
            _loc9_ = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipContent",_loc8_);
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc4_.initData(_loc7_,_loc9_,this._order.orderId,_loc8_,_loc8_,_loc5_,_loc2_,_loc6_);
            _loc4_.show();
         }
      }
    coolColosseBack(param1, param2 = 0, param3 = 0, param4 = true) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if(param1)
         {
            $.C("yishi.service.managers.SocketSendManager").instance.sendCoolColosseun(param3,param4);
         }
      }
    __onChange(param1) {
         if(!this._order)
         {
            return;
         }
         if(this._order.remainTime > 0)
         {
            if(!this.model)
            {
               return;
            }
            if(this.model.remainBuyCount <= 0 && this.model.remainFreeCount <= 0)
            {
               this._orderback.visible = false;
               this._orderbutton.visible = false;
               this._ordertime.visible = false;
               this.__completeHandler(null);
            }
            this._orderback.visible = true;
            this._orderbutton.visible = true;
            this._ordertime.visible = true;
            this._ordertime.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.ColosseumFrame.ordertime.text") + $.C("yishi.utils.DateFormatter").getCountDate(this._order.remainTime);
         }
         else
         {
            this._orderback.visible = false;
            this._orderbutton.visible = false;
            this._ordertime.visible = false;
            this.__completeHandler(null);
         }
      }
    showEffect() {
         this.stopEffect();
         this._effect.play();
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "stopEffect"),3000);
      }
    stopEffect() {
         $.C("flash.utils.clearTimeout")(this._timeId);
         this._effect.gotoAndStop(1);
      }
    initEvent() {
         this._returnBtn.addEventListener("click",$.bind(this, "__returnClick"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("REFRESH_CHALLENGE",$.bind(this, "refreshView"));
         $.C("managers.VIPManager").Instance.model.addEventListener("upframeview_change",$.bind(this, "__UpvipInfoHandler"));
      }
    __UpvipInfoHandler(param1) {
         if($.C("managers.VIPManager").Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            $.C("yishi.service.managers.SocketSendManager").instance.sendCoolColosseun(0,true);
         }
      }
    refreshView(param1) {
         if(this.model.remainFreeCount > 0)
         {
            this._hasNumTxt.visible = true;
            this._hasBuyNumTxt.visible = false;
            this._numTxtFiled.text = this.model.remainFreeCount.toString();
         }
         else
         {
            this._hasNumTxt.visible = false;
            this._hasBuyNumTxt.visible = true;
            this._numTxtFiled.text = this.model.remainBuyCount.toString();
            if(this.model.remainBuyCount <= 0 && this.model.currentBuyCount <= 0)
            {
               this._orderback.visible = false;
               this._orderbutton.visible = false;
               this._ordertime.visible = false;
               this._effect.visible = false;
            }
         }
         this._numTxt.x = this._numTxtFiled.x + this._numTxtFiled.textWidth + 6;
      }
    removeEvent() {
         this._returnBtn.removeEventListener("click",$.bind(this, "__returnClick"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("REFRESH_CHALLENGE",$.bind(this, "refreshView"));
         if(this._order)
         {
            this._order.removeEventListener("change",$.bind(this, "__onChange"));
            this._order.removeEventListener("complete",$.bind(this, "__completeHandler"));
         }
         if(this._orderbutton)
         {
            this._orderbutton.removeEventListener("click",$.bind(this, "__clickHandler"));
         }
         $.C("managers.VIPManager").Instance.model.removeEventListener("upframeview_change",$.bind(this, "__UpvipInfoHandler"));
      }
    __returnClick(param1) {
         if($.C("managers.ChallengeManager").instance.enterScene == "CASTLE_SCENE")
         {
            $.C("yishi.scene.SceneManager").instance.setScene("CASTLE_SCENE");
         }
         else
         {
            $.C("yishi.SwitchPageHelp").enterToSpace();
         }
         $.C("managers.ChallengeManager").instance.enterScene = "";
      }
    resize(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(param1 > 1248)
         {
            this._bg.x = (param1 - 1248) / 2;
         }
         else
         {
            this._bg.x = 0;
         }
         if(param2 > 790)
         {
            this._bg.y = (param2 - 790) / 2;
         }
         else
         {
            this._bg.y = 0;
         }
         this._hasNumTxt.x = param1 - 510;
         this._effect.x = param1 - 470;
         this._effect.y = 166;
         this._hasBuyNumTxt.x = param1 - 478;
         this._numTxtFiled.x = param1 - 346;
         this._numTxt.x = this._numTxtFiled.x + this._numTxtFiled.textWidth + 6;
         this._hasNumTxt.y = 153;
         this._hasBuyNumTxt.y = 155;
         this._numTxt.y = 155;
         this._numTxtFiled.y = 144;
         this._returnBtn.x = param1 - 138;
         this._returnBtn.y = 30;
         this._middleChallengeView.y = (param2 - 247) / 2 + 247;
         if((param2 - 247) / 2 < 217)
         {
            this._middleChallengeView.y = 464;
         }
         this._topChallengeView.resize(param1,param2);
         this._middleChallengeView.resize(param1,param2,this._bg.x);
      }
    get model() {
         return $.C("managers.ChallengeManager").instance.model;
      }
    get middleView() {
         return this._middleChallengeView;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hasNumTxt);
         this._hasNumTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._numTxtFiled);
         this._numTxtFiled = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._numTxt);
         this._numTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hasBuyNumTxt);
         this._hasBuyNumTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._returnBtn);
         this._returnBtn = null;
         this._leftChallengeView.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftChallengeView);
         this._leftChallengeView = null;
         this._topChallengeView.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._topChallengeView);
         this._topChallengeView = null;
         this._middleChallengeView.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._middleChallengeView);
         this._middleChallengeView = null;
         this.__completeHandler(null);
      }
    set model(v) { super.model = v; }
    set middleView(v) { super.middleView = v; }
  }
  $.meta(__ChallengeView, "colosseum.view.ChallengeView", ["Disposeable"]);
  return __ChallengeView;
}
deps["colosseum.view.ChallengeView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.utils.clearTimeout", "flash.utils.setTimeout", "manager.LanguageMgr", "managers.ChallengeManager", "managers.VIPManager", "yishi.SwitchPageHelp", "yishi.manager.BuildingManager", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager", "yishi.scene.SceneManager", "yishi.service.managers.SocketSendManager", "yishi.utils.DateFormatter"];

defs["colosseum.view.ColosseumEventFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __ColosseumEventFrame extends __Base {
    static $fields(self) {
    self._back = null;
    self._scrollPanel = null;
    self._vBox1 = null;
    self._vBox2 = null;
    self._content = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,525,280);
      }
    initView() {
         var _loc4_ = null;
         var _loc6_ = null;
         var _loc1_ = null;
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.ColossumEventFrameBack");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.ScrollPanel");
         this._vBox1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventBox1");
         this._vBox2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventBox2");
         this.addToContent(this._back);
         this.addToContent(this._scrollPanel);
         this._content = new ($.C("flash.display.Sprite"))();
         this._content.addChild(this._vBox1);
         this._content.addChild(this._vBox2);
         this._scrollPanel.setView(this._content);
         var _loc5_ = 0;
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.LogtFrameLine");
            this._vBox1.addChild(_loc4_);
            _loc5_++;
         }
         var _loc2_ = this.model.eventsList;
         var _loc3_ = $.int(_loc2_.length);
         _loc2_.sort($.bind(this, "sortOnDate"));
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc1_ = new ($.C("colosseum.view.ColosseumEventItem"))();
            _loc1_.data = _loc6_;
            this._vBox2.addChild(_loc1_);
            if(_loc5_ < _loc3_ - 1 && _loc5_ >= 7)
            {
               _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.LogtFrameLine");
               this._vBox1.addChild(_loc4_);
            }
            _loc5_++;
         }
         this._vBox1.refreshChildPos();
         this._vBox2.refreshChildPos();
         this._scrollPanel.invalidateViewport();
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.control.closeEventFrame();
         }
      }
    sortOnDate(param1, param2) {
         if(param1.logDate.getTime() > param2.logDate.getTime())
         {
            return -1;
         }
         if(param1.logDate.getTime() == param2.logDate.getTime())
         {
            return 0;
         }
         return 1;
      }
    get model() {
         return $.C("managers.ChallengeManager").instance.model;
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.colosseumControler;
      }
    show() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("emailII.EmailFrame.battle");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrollPanel);
         this._scrollPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox1);
         this._vBox1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox2);
         this._vBox2 = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set model(v) { super.model = v; }
    set control(v) { super.control = v; }
  }
  $.meta(__ColosseumEventFrame, "colosseum.view.ColosseumEventFrame", ["IManualSize"]);
  return __ColosseumEventFrame;
}
deps["colosseum.view.ColosseumEventFrame"] = ["colosseum.view.ColosseumEventItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.ChallengeManager", "yishi.keyboard.KeyBoardRegister", "yishi.manager.FrameControllerManager"];

defs["colosseum.view.ColosseumEventItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ColosseumEventItem extends __Base {
    static $fields(self) {
    self._icon = null;
    self._timeTxt = null;
    self._attackCon = null;
    self._attackTxt = null;
    self._txt1 = null;
    self._defebceCon = null;
    self._defenceTxt = null;
    self._restuleTxt = null;
    self._rankTxt = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
         this.refreshPos();
      }
    initView() {
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventIcon");
         this._timeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventTimeTxt");
         this._attackCon = new ($.C("flash.display.Sprite"))();
         this._attackCon.buttonMode = true;
         this._attackCon.y = 1;
         this._attackTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventAttackTxt");
         this._txt1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventDescribeTxt");
         this._defebceCon = new ($.C("flash.display.Sprite"))();
         this._defebceCon.y = 1;
         this._defebceCon.buttonMode = true;
         this._defenceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventDefenceTxt");
         this._restuleTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventResultTxt");
         this._rankTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.EventRankTxt");
         this.addChild(this._icon);
         this._icon.setFrame(1);
         this.addChild(this._timeTxt);
         this._attackCon.addChild(this._attackTxt);
         this.addChild(this._attackCon);
         this.addChild(this._txt1);
         this._defebceCon.addChild(this._defenceTxt);
         this.addChild(this._defebceCon);
         this.addChild(this._restuleTxt);
         this.addChild(this._rankTxt);
         this._attackCon.mouseChildren = this._defebceCon.mouseChildren = false;
      }
    removeEvent() {
         this._attackCon.removeEventListener("click",$.bind(this, "__clickHandler"));
         this._defebceCon.removeEventListener("click",$.bind(this, "__clickHandler"));
      }
    __clickHandler(param1) {
         param1.stopPropagation();
         var _loc2_ = new ($.C("yishi.datas.playerinfo.ThaneInfo"))();
         _loc2_.userId = this._data.tarUserId;
         _loc2_.nickName = this._data.tarNickName;
         _loc2_.playerOrdeInfo.gpOrder = this._data.tarOrder;
         _loc2_.grades = this._data.tarGrade;
         _loc2_.gp = this._data.tarGp;
         _loc2_.templateId = this._data.tarTemplateId;
         $.C("yishi.manager.PlayerInfoManager").instance.show(_loc2_);
      }
    refreshPos() {
         this._attackCon.x = this._timeTxt.x + this._timeTxt.textWidth;
         this._txt1.x = this._attackCon.x + this._attackCon.width - 2;
         this._defebceCon.x = this._txt1.x + this._txt1.textWidth;
         this._restuleTxt.x = this._defebceCon.x + this._defebceCon.width;
         this._rankTxt.x = this._restuleTxt.x + this._restuleTxt.textWidth;
      }
    refreshView() {
         this._timeTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.time") + this.getTimeString();
         this._txt1.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.txt1");
         this._defebceCon.mouseEnabled = this._attackCon.mouseEnabled = false;
         this.initRestult();
         if(this._data.isAttack)
         {
            this._icon.setFrame(1);
            this._attackTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.txt2");
            this._defenceTxt.htmlText = "<font color=\'#f0f695\'><u>" + this._data.tarNickName + "<u/></font>";
            this._defebceCon.addEventListener("click",$.bind(this, "__clickHandler"));
            this._defebceCon.mouseEnabled = true;
         }
         else
         {
            this._icon.setFrame(2);
            this._attackTxt.htmlText = "<font color=\'#f0f695\'><u>" + this._data.tarNickName + "</a><u/></font>";
            this._defenceTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.txt2");
            this._attackCon.addEventListener("click",$.bind(this, "__clickHandler"));
            this._attackCon.mouseEnabled = true;
         }
         this.refreshPos();
      }
    initRestult() {
         if(this._data.forward == 0)
         {
            this._rankTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.rank01");
         }
         else if(this._data.forward > 0)
         {
            this._rankTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.rank02") + this._data.curRankResult;
         }
         else
         {
            this._rankTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.rank03") + this._data.curRankResult;
         }
         if(this._data.restult == 1)
         {
            this._restuleTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.restule01");
         }
         else
         {
            this._restuleTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumEventItem.restule02");
         }
      }
    getTimeString() {
         var _loc1_ = this.serverTime * 1000 - this._data.logDate.getTime();
         if(_loc1_ / 604800000 > 1)
         {
            return $.C("manager.LanguageMgr").GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time01");
         }
         if(_loc1_ / 259200000 > 1)
         {
            return $.C("manager.LanguageMgr").GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time02");
         }
         if(_loc1_ / 43200000 > 1)
         {
            return $.C("manager.LanguageMgr").GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time03");
         }
         if(_loc1_ / 3600000 > 1)
         {
            return $.C("manager.LanguageMgr").GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time04");
         }
         return $.C("manager.LanguageMgr").GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time05");
      }
    get serverTime() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.sysCurTimeBySecond;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeTxt);
         this._timeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._attackCon);
         this._attackCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._attackTxt);
         this._attackTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._txt1);
         this._txt1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._defebceCon);
         this._defebceCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._defenceTxt);
         this._defenceTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._restuleTxt);
         this._restuleTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankTxt);
         this._rankTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._data = null;
      }
    set serverTime(v) { super.serverTime = v; }
    set thane(v) { super.thane = v; }
    get data() { return super.data; }
  }
  $.meta(__ColosseumEventItem, "colosseum.view.ColosseumEventItem", ["Disposeable"]);
  return __ColosseumEventItem;
}
deps["colosseum.view.ColosseumEventItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.ArmyManager", "yishi.manager.PlayerInfoManager", "yishi.manager.PlayerManager"];

defs["colosseum.view.ColosseumPlayerItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ColosseumPlayerItem extends __Base {
    static $fields(self) {
    self._back = null;
    self._figure = null;
    self._effect = null;
    self._back2 = null;
    self._name = null;
    self._level = null;
    self._rankValue = null;
    self._startBtn = null;
    self._thane = null;
    self.$$_mask = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.ItemBack1");
         this._effect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.ItemEffect");
         this._back2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.ItemRankBack");
         this._figure = new ($.C("avatar.view.ShowAvatar"))();
         this._figure.x = 0;
         this._figure.y = 13;
         this._figure.mouseChildren = this._figure.mouseEnabled = false;
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.ItemLevel");
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.ItemName");
         this._rankValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.ItemRankValue");
         this._startBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.StartBtn");
         this._effect.visible = false;
         this.addChild(this._back);
         this.addChild(this._figure);
         this._figure.scaleX = this._figure.scaleY = 0.85;
         this.addChild(this._back2);
         this.addChild(this._effect);
         this.addChild(this._level);
         this.addChild(this._name);
         this.addChild(this._rankValue);
         this.addChild(this._startBtn);
         this._startBtn.visible = false;
         this._figure.mask = this.$$_mask = this.createMask();
         this.addChild(this.$$_mask);
      }
    createMask() {
         var _loc1_ = new ($.C("flash.display.Shape"))();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(6,2,224,235);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
    initEvent() {
         this.addEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.addEventListener("mouseOut",$.bind(this, "__outHandler"));
         this._startBtn.addEventListener("click",$.bind(this, "__clickHandler"));
      }
    removeEvent() {
         this.removeEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.removeEventListener("mouseOut",$.bind(this, "__outHandler"));
         this._startBtn.removeEventListener("click",$.bind(this, "__clickHandler"));
      }
    __overHandler(param1) {
         this._effect.visible = true;
         this._startBtn.visible = true;
      }
    __outHandler(param1) {
         this._effect.visible = false;
         this._startBtn.visible = false;
      }
    __clickHandler(param1) {
         var _loc2_ = null;
         var _loc4_ = null;
         var _loc3_ = 0;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._thane)
         {
            _loc2_ = "";
            if(!$.C("yishi.manager.BuildingManager").instance.model.checkHasIdleColosseumOrder())
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumListView.command02");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               this.control.frame["showEffect"]();
               return;
            }
            _loc4_ = $.C("yishi.scene.SceneManager").instance.currentType;
            if(_loc4_ == "PVP_ROOM_SCENE" || _loc4_ == "PVP_ROOM_SCENE" || _loc4_ == "WARLORDS_ROOM")
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumListView.command03");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            if(_loc4_ == "CAMPAIGN_MAP_SCENE")
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("yishi.utils.WorldBossHelper").getCampaignTips());
               return;
            }
            if(this.control.model.remainFreeCount <= 0)
            {
               if(this.control.model.remainBuyCount > 0)
               {
                  _loc3_ = $.int(this.control.model.buyCountNeedPay);
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumPlayerItem.buyCountTip",_loc3_);
                  $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "sendChallenge"),_loc3_];
                  $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame($.C("manager.LanguageMgr").GetTranslation("public.prompt"),_loc2_,$.C("manager.LanguageMgr").GetTranslation("public.confirm"),$.C("manager.LanguageMgr").GetTranslation("public.cancel"),true,false,false,2,"USEBINDPOINT_ALERT");
               }
               else
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumListView.command01");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               }
               return;
            }
            this.sendChallenge(true,true);
         }
      }
    sendChallenge(param1, param2, param3 = 0) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = 0;
         if(param1 && this._thane)
         {
            _loc4_ = $.int(param2 ? this.playerInfo.point + this.playerInfo.giftToken : this.playerInfo.point);
            if(_loc4_ < param3)
            {
               $.C("yishi.manager.RechargeAlertMannager").show();
               return;
            }
            $.C("battle.BattleManager").preScene = $.C("yishi.SwitchPageHelp").returnScene;
            this.control.sendChallengeById(this._thane.userId,param2 ? 0 : 1);
         }
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.colosseumControler;
      }
    set thane(param1) {
         this._thane = param1;
         this.refreshView();
      }
    get backBitmap() {
         return this._back;
      }
    refreshView() {
         if(this._thane)
         {
            this._level.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this._thane.grades);
            this._name.text = this._thane.nickName;
            if(this._thane.challengeRank == 0)
            {
               this._rankValue.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
            }
            else
            {
               this._rankValue.text = $.C("manager.LanguageMgr").GetTranslation("public.rank",this._thane.challengeRank);
            }
            this._figure.data = this._thane;
         }
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankValue);
         this._rankValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._effect);
         this._effect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         this._name = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._level);
         this._level = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._thane = null;
      }
    set control(v) { super.control = v; }
    get thane() { return super.thane; }
    set backBitmap(v) { super.backBitmap = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__ColosseumPlayerItem, "colosseum.view.ColosseumPlayerItem", ["Disposeable"]);
  return __ColosseumPlayerItem;
}
deps["colosseum.view.ColosseumPlayerItem"] = ["avatar.view.ShowAvatar", "battle.BattleManager", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Shape", "flash.display.Sprite", "manager.LanguageMgr", "yishi.SwitchPageHelp", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.scene.SceneManager", "yishi.utils.SimpleAlertHelper", "yishi.utils.WorldBossHelper", "yishi.view.tips.MessageTipManager"];

defs["colosseum.view.ColosseumSelfView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ColosseumSelfView extends __Base {
    static $fields(self) {
    self._back2 = null;
    self._figure = null;
    self._todayLeftCount1 = null;
    self._todayLeftCount2 = null;
    self._todayLeftCountValue = null;
    self._selfRank = null;
    self._selfRankValue = null;
    self._rankReward = null;
    self._rewardGoldValue = null;
    self._rewardGoldIcon = null;
    self._rewardSoulValue = null;
    self._rewardSoulIcon = null;
    self._rewardDate = null;
    self._rewardDateValue = null;
    self._heroRankBtn = null;
    self._reportBtn = null;
    self._appellIcon1 = null;
    self._appellIcon2 = null;
    self._appellIcon3 = null;
    self._appellIcon4 = null;
    self._appell1 = null;
    self._appell2 = null;
    self._appell3 = null;
    self._appell4 = null;
    self._appellTxt1 = null;
    self._appellTxt2 = null;
    self._appellTxt3 = null;
    self._appellTxt4 = null;
    self._appellPlayer1 = "";
    self._appellPlayer2 = "";
    self._appellPlayer3 = "";
    self._appellPlayer4 = "";
    }
    constructor() {
         super();
         this.initView();
         this.initData();
         this.initEvent();
         this.refreshView();
      }
    initView() {
         this._back2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.FrameBack3.MutipleImage");
         this._figure = new ($.C("avatar.view.ShowAvatar"))();
         this._figure.x = 46;
         this._figure.y = 102;
         this._figure.mouseChildren = this._figure.mouseEnabled = false;
         this._todayLeftCount1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.TodayCount1");
         this._todayLeftCount2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.TodayCount2");
         this._todayLeftCountValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.TodayCountValue");
         this._selfRank = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.SelfRank");
         this._selfRankValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.SelfRankValue");
         this._rankReward = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.RankRewardAsset");
         this._rewardGoldValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.RewardGoldValue");
         this._rewardGoldIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.RewardGoldIcon");
         this._rewardSoulValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.RewardSoulValue");
         this._rewardSoulIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.RewardSoulIcon");
         this._rewardDate = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.RecieveAsset");
         this._rewardDateValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.RewardDateValue");
         this._heroRankBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankBtn");
         this._reportBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.ReportBtn");
         this._appellIcon1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.AppellIcon1");
         this._appellIcon2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.AppellIcon2");
         this._appellIcon3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.AppellIcon2");
         this._appellIcon4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.AppellIcon2");
         this._appell1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.Appell1");
         this._appell2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.Appell2");
         this._appell3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.Appell3");
         this._appell4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.colosseum.Appell4");
         this._appellTxt1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.AppellTxt1");
         this._appellTxt2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.AppellTxt2");
         this._appellTxt3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.AppellTxt3");
         this._appellTxt4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.AppellTxt4");
         this._todayLeftCount1.setFrame(1);
         this.addChild(this._back2);
         this.addChild(this._figure);
         this.addChild(this._todayLeftCount1);
         this.addChild(this._todayLeftCount2);
         this.addChild(this._todayLeftCountValue);
         this.addChild(this._selfRank);
         this.addChild(this._selfRankValue);
         this.addChild(this._rankReward);
         this.addChild(this._rewardGoldValue);
         this.addChild(this._rewardGoldIcon);
         this.addChild(this._rewardSoulValue);
         this.addChild(this._rewardSoulIcon);
         this.addChild(this._rewardDate);
         this.addChild(this._rewardDateValue);
         this.addChild(this._heroRankBtn);
         this.addChild(this._reportBtn);
         this.addChild(this._appellIcon1);
         this.addChild(this._appellIcon2);
         this.addChild(this._appellIcon3);
         this._appellIcon3.y = 46;
         this.addChild(this._appellIcon4);
         this._appellIcon4.y = 66;
         this.addChild(this._appell1);
         this.addChild(this._appell2);
         this.addChild(this._appell3);
         this.addChild(this._appell4);
         this.addChild(this._appellTxt1);
         this.addChild(this._appellTxt2);
         this.addChild(this._appellTxt3);
         this.addChild(this._appellTxt4);
      }
    initData() {
         var _loc1_ = null;
         while(this.sortController.model.playerFightList.length > 0)
         {
            _loc1_ = $.as(this.sortController.model.playerFightList.pop(), $.C("mvc.module.sort.SortData"));
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         this.sortController.model.currentSelected = 2;
         this.sortController.loadData("fight.xml");
      }
    initEvent() {
         this._heroRankBtn.addEventListener("click",$.bind(this, "__heroBtnClickHandler"));
         this._reportBtn.addEventListener("click",$.bind(this, "__reportHandler"));
         this.sortController.model.addEventListener("SELECTE_LIST_CHANG",$.bind(this, "__listChangeHandler"));
      }
    removeEvent() {
         this._heroRankBtn.removeEventListener("click",$.bind(this, "__heroBtnClickHandler"));
         this._reportBtn.removeEventListener("click",$.bind(this, "__reportHandler"));
         this.sortController.model.removeEventListener("SELECTE_LIST_CHANG",$.bind(this, "__listChangeHandler"));
      }
    __listChangeHandler(param1) {
         var _loc3_ = 0;
         if(this.sortController.model.playerFightList.length > 0)
         {
            for (var _loc2_ of $.values(this.sortController.model.playerFightList))
            {
               if($.C("yishi.utils.StringHelper").isNullOrEmpty(this._appellPlayer1))
               {
                  this._appellPlayer1 = _loc2_.nikcName;
                  _loc3_++;
               }
               if($.C("yishi.utils.StringHelper").isNullOrEmpty(this._appellPlayer2) && _loc2_.army.baseHero.templateInfo.Job == 3)
               {
                  this._appellPlayer2 = _loc2_.nikcName;
                  _loc3_++;
               }
               else if($.C("yishi.utils.StringHelper").isNullOrEmpty(this._appellPlayer3) && _loc2_.army.baseHero.templateInfo.Job == 1)
               {
                  this._appellPlayer3 = _loc2_.nikcName;
                  _loc3_++;
               }
               else if($.C("yishi.utils.StringHelper").isNullOrEmpty(this._appellPlayer4) && _loc2_.army.baseHero.templateInfo.Job == 2)
               {
                  this._appellPlayer4 = _loc2_.nikcName;
                  _loc3_++;
               }
               if(_loc3_ >= 4)
               {
                  break;
               }
            }
         }
         this._appellTxt1.text = this._appellPlayer1;
         this._appellTxt2.text = this._appellPlayer2;
         this._appellTxt3.text = this._appellPlayer3;
         this._appellTxt4.text = this._appellPlayer4;
      }
    __reportHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.control.showEventFrame();
      }
    __heroBtnClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.control.showRankFrame();
      }
    refreshView() {
         if(this.model.remainFreeCount > 0)
         {
            this._todayLeftCount1.setFrame(1);
            this._todayLeftCountValue.text = this.model.remainFreeCount.toString();
         }
         else
         {
            this._todayLeftCount1.setFrame(2);
            this._todayLeftCountValue.text = this.model.remainBuyCount.toString();
         }
         this._selfRankValue.text = this.model.currentRank.toString();
         this._rewardGoldValue.text = this.getTakeCount(this.model.currentRank).toString();
         this._rewardSoulValue.text = this.getTakeCount(this.model.currentRank).toString();
         this._rewardGoldIcon.x = this._rewardGoldValue.x + this._rewardGoldValue.textWidth + 5;
         this._rewardSoulValue.x = this._rewardGoldIcon.x + this._rewardGoldIcon.width + 10;
         this._rewardSoulIcon.x = this._rewardSoulValue.x + this._rewardSoulValue.textWidth;
         this._rewardDateValue.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.ColosseumSelfView.rewardDateValueText",this.model.leftDay);
         this._figure.data = this.thaneInfo;
      }
    getTakeCount(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc2_ = 0;
         var _loc4_ = 0;
         if(param1 == 0)
         {
            _loc2_ = 0;
         }
         else if(param1 == 1)
         {
            _loc2_ = 800000;
         }
         else if(param1 == 2)
         {
            _loc2_ = 600000;
         }
         else if(param1 >= 3 && param1 <= 4)
         {
            _loc2_ = 600000;
            _loc4_ = 3;
            while(_loc4_ < 5)
            {
               _loc2_ -= 100000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else if(param1 >= 5 && param1 <= 11)
         {
            _loc2_ = 400000;
            _loc4_ = 5;
            while(_loc4_ < 12)
            {
               _loc2_ -= 10000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else if(param1 >= 12 && param1 <= 51)
         {
            _loc2_ = 330000;
            _loc4_ = 12;
            while(_loc4_ < 52)
            {
               _loc2_ -= 5000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc2_ = 130000;
            _loc3_ = (param1 - 51) * 100;
            _loc2_ -= _loc3_;
            _loc2_ = $.int(_loc2_ < 1000 ? 1000 : _loc2_);
         }
         return _loc2_;
      }
    get thaneInfo() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.colosseumControler;
      }
    get model() {
         return this.control.model;
      }
    get sortController() {
         return $.C("yishi.manager.FrameControllerManager").instance.sortController;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._todayLeftCount1);
         this._todayLeftCount1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._todayLeftCount2);
         this._todayLeftCount2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._todayLeftCountValue);
         this._todayLeftCountValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfRank);
         this._selfRank = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfRankValue);
         this._selfRankValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroRankBtn);
         this._heroRankBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellIcon1);
         this._appellIcon1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellIcon2);
         this._appellIcon2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellIcon3);
         this._appellIcon3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellIcon4);
         this._appellIcon4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appell1);
         this._appell1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appell2);
         this._appell2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appell3);
         this._appell3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appell4);
         this._appell4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTxt1);
         this._appellTxt1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTxt2);
         this._appellTxt2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTxt3);
         this._appellTxt3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTxt4);
         this._appellTxt4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._reportBtn);
         this._reportBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set thaneInfo(v) { super.thaneInfo = v; }
    set control(v) { super.control = v; }
    set model(v) { super.model = v; }
    set sortController(v) { super.sortController = v; }
  }
  $.meta(__ColosseumSelfView, "colosseum.view.ColosseumSelfView", ["Disposeable"]);
  return __ColosseumSelfView;
}
deps["colosseum.view.ColosseumSelfView"] = ["avatar.view.ShowAvatar", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.sort.SortData", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.utils.StringHelper"];

defs["colosseum.view.HeroRankFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __HeroRankFrame extends __Base {
    static $fields(self) {
    self._back1 = null;
    self._back2 = null;
    self._titleBack = null;
    self._rankTxt = null;
    self._nickNameTxt = null;
    self._levelTxt = null;
    self._combatTxt = null;
    self._cancelBtn = null;
    self._scrollPanel = null;
    self._vBox = null;
    self._group = null;
    }
    constructor() {
         super();
         this.initView();
         if(this.model.heroRankList.length <= 0)
         {
            this.getRankList();
         }
         else
         {
            this.initList();
            this.initEvent();
         }
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,450,450);
      }
    getRankList() {
         var _loc1_ = new ($.C("flash.net.URLVariables"))();
         _loc1_["rnd"] = Math.random();
         var _loc2_ = $.C("yishi.manager.PathManager").challengPath;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,5,8,$.bind(this, "__onGetRankComplete"),null,null,null,_loc1_);
      }
    __onGetRankComplete(param1, param2) {
         var _loc6_ = null;
         var _loc3_ = 0;
         var _loc5_ = 0;
         var _loc11_ = 0;
         if(this.isDie)
         {
            return;
         }
         var _loc8_ = new $.XML(param2);
         var _loc10_ = _loc8_.$descendants("item");
         for (var _loc4_ of $.values(_loc10_))
         {
            _loc6_ = new ($.C("yishi.datas.playerinfo.ThaneInfo"))();
            _loc6_.userId = $.int(_loc4_["@userId"]);
            _loc6_.nickName = _loc4_["@nickName"];
            _loc6_.grades = $.int(_loc4_["@grades"]);
            _loc6_.fightingCapacity = $.int(_loc4_["@fightingCapacity"]);
            _loc6_.consortiaName = _loc4_["@consortiaName"];
            _loc6_.playerOrdeInfo.gpOrder = $.int(_loc4_["@order"]);
            _loc6_.templateId = $.int(_loc4_["@job"]);
            _loc6_.challengeRank = $.int(_loc4_["@curRank"]);
            _loc6_.IsVipAndNoExpirt = _loc4_["@IsVip"] == "true" ? true : false;
            for (var _loc7_ of $.values(_loc4_.$descendants("DragonInfo")))
            {
               if($.int(_loc7_["@Type"]) > _loc3_)
               {
                  _loc3_ = $.int( $.int(_loc7_["@Type"]));
                  _loc5_ = $.int( $.int(_loc7_["@Grade"]));
                  _loc11_ = $.int( $.int(_loc7_["@Gp"]));
               }
            }
            _loc6_.dragonSoulType = _loc3_;
            _loc6_.dragonSoulGrade = _loc5_;
            _loc6_.dragonSoulGp = _loc11_;
            for (var _loc9_ of $.values(_loc4_.$descendants("TransferInfo")))
            {
               _loc6_.vocationGrades = $.int(_loc9_["@Grade"]);
               _loc6_.vocationGp = $.int(_loc9_["@Gp"]);
            }
            this.model.heroRankList.push(_loc6_);
         }
         this.initList();
         this.initEvent();
      }
    initView() {
         this._back1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankBack1");
         this._back2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankBack2");
         this._titleBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankTitleBack");
         this._rankTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankTxt");
         this._nickNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankNameTxt");
         this._levelTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankLevelTxt");
         this._combatTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankCombatTxt");
         this._cancelBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankCancelBtn");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankScrollPanel");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankVbox");
         this.addToContent(this._back1);
         this.addToContent(this._back2);
         this.addToContent(this._titleBack);
         this.addToContent(this._rankTxt);
         this.addToContent(this._nickNameTxt);
         this.addToContent(this._levelTxt);
         this.addToContent(this._combatTxt);
         this.addToContent(this._cancelBtn);
         this.addToContent(this._scrollPanel);
         this._vBox.spacing = -2;
         this._scrollPanel.setView(this._vBox);
         this._rankTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.HeroRankFrame.rank");
         this._nickNameTxt.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.HeroRankFrame.nickName");
         this._levelTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.grade");
         this._combatTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.playerInfo.ap");
         this._cancelBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.close");
      }
    initList() {
         var _loc3_ = 0;
         var _loc1_ = null;
         this._group = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         var _loc2_ = $.int(this.model.heroRankList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new ($.C("colosseum.view.HeroRankItem"))();
            _loc1_.data = this.model.heroRankList[_loc3_];
            this._vBox.addChild(_loc1_);
            this._group.addSelectItem(_loc1_);
            _loc3_++;
         }
         this._scrollPanel.invalidateViewport();
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._cancelBtn.addEventListener("click",$.bind(this, "__closeHandler"));
         this._group.addEventListener("change",$.bind(this, "__selectedItemChangeHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         this._cancelBtn.removeEventListener("click",$.bind(this, "__closeHandler"));
         this._group.removeEventListener("change",$.bind(this, "__selectedItemChangeHandler"));
      }
    __selectedItemChangeHandler(param1) {
      }
    __closeHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this.control.closeRankFrame();
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.control.closeRankFrame();
         }
      }
    get model() {
         return $.C("managers.ChallengeManager").instance.model;
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.colosseumControler;
      }
    show() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.HeroRankFrame.title");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,2);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    dispose() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "__onGetRankComplete"));
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set model(v) { super.model = v; }
    set control(v) { super.control = v; }
  }
  $.meta(__HeroRankFrame, "colosseum.view.HeroRankFrame", ["IManualSize"]);
  return __HeroRankFrame;
}
deps["colosseum.view.HeroRankFrame"] = ["colosseum.view.HeroRankItem", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Rectangle", "flash.net.URLVariables", "manager.LanguageMgr", "managers.ChallengeManager", "yishi.datas.playerinfo.ThaneInfo", "yishi.keyboard.KeyBoardRegister", "yishi.manager.FrameControllerManager", "yishi.manager.PathManager"];

defs["colosseum.view.HeroRankItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __HeroRankItem extends __Base {
    static $fields(self) {
    self._back = null;
    self._rankTxt = null;
    self._nickNameTxt = null;
    self._levelTxt = null;
    self._combatTxt = null;
    self._selected = false;
    self._vipIcon = null;
    self._vipText = null;
    self._vocationIcon = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankItemBack");
         this._rankTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankValueTxt");
         this._nickNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankNameValueTxt");
         this._levelTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankLevelValueTxt");
         this._combatTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankCombatValueTxt");
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.VocationIcon");
         this._vocationIcon.visible = false;
         this.addChild(this._back);
         this._back.setFrame(1);
         this.addChild(this._rankTxt);
         this.addChild(this._nickNameTxt);
         this.addChild(this._levelTxt);
         this.addChild(this._combatTxt);
         this.addChild(this._vocationIcon);
      }
    initEvent() {
         this.addEventListener("click",$.bind(this, "__clickHandler"));
         this.addEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.addEventListener("mouseOut",$.bind(this, "__outHandler"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__clickHandler"));
         this.removeEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.removeEventListener("mouseOut",$.bind(this, "__outHandler"));
      }
    __clickHandler(param1) {
         var _loc3_ = this.parent.localToGlobal(new ($.C("flash.geom.Point"))(this.x,this.y + 20));
         var _loc2_ = new ($.C("yishi.view.community.PlayerMenu"))();
         _loc2_.setData(this.data);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc2_,7);
      }
    __overHandler(param1) {
         if(this._selected || !this._data)
         {
            return;
         }
         this._back.setFrame(2);
      }
    __outHandler(param1) {
         if(this._selected || !this._data)
         {
            return;
         }
         this._back.setFrame(1);
      }
    refreshVocation() {
         if(this._data && this._data.vocationGrades > 0)
         {
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName(this._data.templateInfo.Job,this._data.vocationStep,this._data.vocationLevel);
            this._vocationIcon.setFrame(this._data.vocationLevel);
            this._vocationIcon.visible = true;
         }
         else
         {
            this._vocationIcon.visible = false;
         }
      }
    set data(param1) {
         this._data = param1;
         this._rankTxt.text = this._data.challengeRank.toString();
         this._nickNameTxt.text = this._data.nickName;
         this._levelTxt.text = this._data.grades.toString();
         this._combatTxt.text = this._data.fightingCapacity.toString();
         this.setVipIcon();
         if(this.isVip)
         {
            this._nickNameTxt.visible = false;
            this._vipIcon.visible = true;
            this._vipText.visible = true;
         }
         else
         {
            this._nickNameTxt.visible = true;
            this._vipIcon.visible = false;
            this._vipText.visible = false;
         }
         this.refreshVocation();
      }
    get isVip() {
         return this._data.IsVipAndNoExpirt;
      }
    setVipIcon() {
         var _loc1_ = null;
         if(!this._vipIcon)
         {
            this._vipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.simpleVIPIcon");
            this.addChild(this._vipIcon);
         }
         this._vipIcon.x = 68;
         this._vipIcon.y = this._nickNameTxt.y + 1;
         if(!this._vipText)
         {
            this._vipText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("colosseum.HeroRankNameGradientText");
            this.addChild(this._vipText);
            _loc1_ = new ($.C("flash.text.TextField"))();
            this._vipText.text = this._nickNameTxt.text;
         }
      }
    get data() {
         return this._data;
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
            this._back.setFrame(2);
         }
         else
         {
            this._back.setFrame(1);
         }
      }
    asDisplayObject() {
         return this;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankTxt);
         this._rankTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nickNameTxt);
         this._nickNameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levelTxt);
         this._levelTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._combatTxt);
         this._combatTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vipText);
         this._vipText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vocationIcon);
         this._vocationIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._data = null;
      }
    set isVip(v) { super.isVip = v; }
    get autoSelect() { return super.autoSelect; }
  }
  $.meta(__HeroRankItem, "colosseum.view.HeroRankItem", ["Disposeable", "ISelectable"]);
  return __HeroRankItem;
}
deps["colosseum.view.HeroRankItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Point", "flash.text.TextField", "yishi.manager.PlayerManager", "yishi.view.community.PlayerMenu"];

defs["dreamarena.DreamAreanaPreviewRewardFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __DreamAreanaPreviewRewardFrame extends __Base {
    static $fields(self) {
    self._bg = null;
    self._rewardPanel = null;
    self._itemBox = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.refreshView();
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,503,496);
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamAreanaPreviewRewardFrame.bg");
         this._rewardPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaPreviewRewardFrame.rewardPanel");
         this._itemBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaPreviewRewardFrame.itemBox");
         this.addToContent(this._bg);
         this.addToContent(this._rewardPanel);
         this._rewardPanel.setView(this._itemBox);
      }
    refreshView() {
         var _loc4_ = 0;
         var _loc1_ = null;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaRewardTempCate.getWinCountTemplatesDic();
         this._itemBox.removeAllChild();
         var _loc3_ = $.C("battle.utils.Helpers").getKeyList(_loc2_);
         _loc4_ = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = new ($.C("dreamarena.item.DreamAreanaPreviewRewardItem"))(_loc4_);
            _loc1_.setWinCount(_loc3_[_loc4_]);
            _loc1_.data = _loc2_[_loc3_[_loc4_]];
            this._itemBox.addChild(_loc1_);
            _loc4_--;
         }
         this._rewardPanel.beginChanges();
         this._rewardPanel.invalidateViewport();
         this._rewardPanel.commitChanges();
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    show(param1 = null) {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("DreamAreanaPreviewRewardFrame.titleText.text");
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardPanel);
         this._rewardPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemBox);
         this._itemBox = null;
         super.dispose();
      }
    set groups(v) { super.groups = v; }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__DreamAreanaPreviewRewardFrame, "dreamarena.DreamAreanaPreviewRewardFrame", ["IManualSize"]);
  return __DreamAreanaPreviewRewardFrame;
}
deps["dreamarena.DreamAreanaPreviewRewardFrame"] = ["battle.utils.Helpers", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamAreanaPreviewRewardItem", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.datas.ComponentGroupType", "yishi.manager.TempleteManager"];

defs["dreamarena.DreamAreanaReportFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __DreamAreanaReportFrame extends __Base {
    static $fields(self) {
    self._bg = null;
    self._winCon = null;
    self._loseCon = null;
    self._winNum = null;
    self._loseNum = null;
    self._sureBtn = null;
    self._rewardBox = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.refreshView();
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaReportFrame.bg");
         this._winCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaReportFrame.winCon");
         this._loseCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaReportFrame.loseCon");
         this._winNum = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.DreamAreanaReportFrame.winNum");
         this._loseNum = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.DreamAreanaReportFrame.LoseNum");
         this._sureBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaReportFrame.sureBtn");
         this._rewardBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaReportFrame.rewardHbox");
         this.addToContent(this._bg);
         this.addToContent(this._winCon);
         this.addToContent(this._loseCon);
         this.addToContent(this._rewardBox);
         this.addToContent(this._sureBtn);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._sureBtn.addEventListener("click",$.bind(this, "__sureClickHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._sureBtn)
         {
            this._sureBtn.removeEventListener("click",$.bind(this, "__sureClickHandler"));
         }
      }
    __sureClickHandler(param1) {
         this.dispose();
      }
    refreshView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         var _loc5_ = null;
         var _loc3_ = null;
         $.C("yishi.utils.NumberViewUtils").refreshValue(this.model.winCount,this._winCon,this._winNum,25,34,18,25,"0123456789");
         $.C("yishi.utils.NumberViewUtils").refreshValue(this.model.loseCount,this._loseCon,this._loseNum,25,34,18,25,"0123456789");
         this._winCon.x = this.model.winCount >= 10 ? 140 : 157;
         this._rewardBox.removeAllChild();
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaRewardTempCate.getWinCountTemplatesDic()[this.model.winCount];
         if(_loc4_ == null || _loc4_.length <= 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc1_ = _loc4_[_loc2_];
            _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamAreanaReportFrame.rewardItem");
            _loc3_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
            _loc3_.templateId = _loc1_.itemId;
            _loc3_.count = _loc1_.count;
            _loc5_.data = _loc3_;
            this._rewardBox.addChild(_loc5_);
            _loc2_++;
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
    show(param1 = null) {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("DreamAreanaReportFrame.titleText.text");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         this.model.reportData = null;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._winCon);
         this._winCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loseCon);
         this._loseCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._winNum);
         this._winNum = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loseNum);
         this._loseNum = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sureBtn);
         this._sureBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardBox);
         this._rewardBox = null;
         super.dispose();
      }
    set groups(v) { super.groups = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamAreanaReportFrame, "dreamarena.DreamAreanaReportFrame", []);
  return __DreamAreanaReportFrame;
}
deps["dreamarena.DreamAreanaReportFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.datas.ComponentGroupType", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.utils.NumberViewUtils"];

defs["dreamarena.DreamArenaFormationFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __DreamArenaFormationFrame extends __Base {
    static $fields(self) {
    self._border = null;
    self._bg = null;
    self._bottoms = null;
    self._tabGroup = null;
    self._fontBtn1 = null;
    self._fontBtn2 = null;
    self._backBtn1 = null;
    self._backBtn2 = null;
    self._saveBtn = null;
    self._thanePos = 0;
    self._childPos = 0;
    self._slavedChildPos = 0;
    self.heroPosArr = [4,7,6,9];
    }
    constructor() {
         super();
         this._thanePos = this.selectInfo.heroFightPos;
         this.initView();
         this.initEvent();
         this.checkPos();
         this.refreshView();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,543,496);
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    initView() {
         var _loc4_ = 0;
         var _loc2_ = null;
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFormationFrame.border");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.common.formationBg");
         this._fontBtn1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFormationFrame.fontBtn1");
         this._fontBtn2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFormationFrame.fontBtn2");
         this._backBtn1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFormationFrame.backBtn1");
         this._backBtn2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFormationFrame.backBtn2");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFormationFrame.saveBtn");
         this._tabGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._tabGroup.addSelectItem(this._fontBtn1);
         this._tabGroup.addSelectItem(this._fontBtn2);
         this._tabGroup.addSelectItem(this._backBtn1);
         this._tabGroup.addSelectItem(this._backBtn2);
         this.addToContent(this._border);
         this.addToContent(this._bg);
         this.addToContent(this._fontBtn1);
         this.addToContent(this._fontBtn2);
         this.addToContent(this._backBtn1);
         this.addToContent(this._backBtn2);
         this.addToContent(this._saveBtn);
         this._fontBtn1.text = $.C("manager.LanguageMgr").GetTranslation("army.LineUpView.fontBtn1.text");
         this._fontBtn2.text = $.C("manager.LanguageMgr").GetTranslation("army.LineUpView.fontBtn2.text");
         this._backBtn1.text = $.C("manager.LanguageMgr").GetTranslation("army.LineUpView.backBtn1.text");
         this._backBtn2.text = $.C("manager.LanguageMgr").GetTranslation("army.LineUpView.backBtn2.text");
         this._bottoms = [];
         var _loc1_ = [{
            "x":217,
            "y":142
         },{
            "x":175,
            "y":190
         },{
            "x":132,
            "y":247
         },{
            "x":82,
            "y":307
         },{
            "x":411,
            "y":142
         },{
            "x":378,
            "y":190
         },{
            "x":337,
            "y":247
         },{
            "x":282,
            "y":307
         }];
         var _loc3_ = [3,6,9,12,1,4,7,10];
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = new ($.C("dreamarena.item.DreamArenaFormationItem"))(_loc3_[_loc4_]);
            _loc2_.x = _loc1_[_loc4_].x;
            _loc2_.y = _loc1_[_loc4_].y;
            this.addToContent(_loc2_);
            this._bottoms[_loc4_] = _loc2_;
            _loc4_++;
         }
         this._tabGroup.selectIndex = this.heroPosArr.indexOf(this._thanePos);
      }
    initEvent() {
         this._tabGroup.addEventListener("change",$.bind(this, "__updateHeroPosHandler"));
         this._saveBtn.addEventListener("click",$.bind(this, "__saveBtnClickHandler"));
         this.addEventListener("response",$.bind(this, "__frameResponse"));
      }
    removeEvent() {
         if(this._tabGroup)
         {
            this._tabGroup.removeEventListener("change",$.bind(this, "__updateHeroPosHandler"));
         }
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveBtnClickHandler"));
         }
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
      }
    __saveBtnClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("managers.DreamArenaManager").instance.sendHeroPosSelect(this._thanePos);
         this.dispose();
      }
    __updateHeroPosHandler(param1) {
         this._thanePos = this.heroPosArr[this._tabGroup.selectIndex];
         this.model.clientSelectDic.add(20,this._thanePos);
         this.cleanItemView();
         this.updatePosAndView();
      }
    updatePosAndView() {
         this.checkPos();
         this.refreshView();
      }
    getItemByPos(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = [3,6,9,12,1,4,7,10];
         var _loc2_ = _loc3_.indexOf(param1);
         if(_loc2_ == -1)
         {
            return this._bottoms[0];
         }
         return this._bottoms[_loc2_];
      }
    checkPos() {
         if(this._thanePos == 4)
         {
            this._childPos = 6;
            this._slavedChildPos = 12;
         }
         else if(this._thanePos == 7)
         {
            this._childPos = 9;
            this._slavedChildPos = 12;
         }
         else if(this._thanePos == 6)
         {
            this._childPos = 4;
            this._slavedChildPos = 10;
         }
         else if(this._thanePos == 9)
         {
            this._childPos = 7;
            this._slavedChildPos = 10;
         }
      }
    refreshView() {
         var _loc1_ = null;
         _loc1_ = this.getItemByPos(this._thanePos);
         _loc1_.data = this.selectInfo.thane;
         if(this.selectInfo.mainChildData)
         {
            _loc1_ = this.getItemByPos(this._childPos);
            _loc1_.data = this.selectInfo.mainChildData;
         }
         if(this.selectInfo.slaveChildData)
         {
            _loc1_ = this.getItemByPos(this._slavedChildPos);
            _loc1_.data = this.selectInfo.slaveChildData;
         }
         this.refreshSaveBtn();
      }
    refreshSaveBtn() {
         if(this.formationChange)
         {
            this._saveBtn.enable = true;
         }
         else
         {
            this._saveBtn.enable = false;
         }
      }
    get formationChange() {
         if(this.model.clientSelectDic[20] && this.selectInfo.heroFightPos != this.model.clientSelectDic[20])
         {
            return true;
         }
         return false;
      }
    cleanItemView() {
         for (var _loc1_ of $.values(this._bottoms))
         {
            if(_loc1_.data)
            {
               _loc1_.data = null;
            }
         }
      }
    get selectInfo() {
         return $.C("managers.DreamArenaManager").instance.model.selfInfo;
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               if(this.formationChange)
               {
                  $.C("yishi.manager.FrameControllerManager").instance.dreamArenaController.showChangeSaveAlert(20,$.bind(this, "dispose"));
                  break;
               }
               this.dispose();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("DreamArenaFormationFrame.titleText.text");
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         if(this._bg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         }
         this._bg = null;
         if(this._fontBtn1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fontBtn1);
         }
         this._fontBtn1 = null;
         if(this._fontBtn2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fontBtn2);
         }
         this._fontBtn2 = null;
         if(this._backBtn1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._backBtn1);
         }
         this._backBtn1 = null;
         if(this._backBtn2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._backBtn2);
         }
         this._backBtn2 = null;
         if(this._border)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._border);
         }
         this._border = null;
         if(this._saveBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         }
         this._saveBtn = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this._bottoms);
         this._bottoms = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tabGroup);
         this._tabGroup = null;
         this.model.clientSelectDic.del(20);
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set formationChange(v) { super.formationChange = v; }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaFormationFrame, "dreamarena.DreamArenaFormationFrame", []);
  return __DreamArenaFormationFrame;
}
deps["dreamarena.DreamArenaFormationFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "dreamarena.item.DreamArenaFormationItem", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.datas.ComponentGroupType", "yishi.manager.FrameControllerManager"];

defs["dreamarena.DreamArenaFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __DreamArenaFrame extends __Base {
    static $fields(self) {
    self._titleImage = null;
    self._hasTicketText = null;
    self._descText = null;
    self._leftBg = null;
    self._rightBorder = null;
    self._rightBg = null;
    self._costImage = null;
    self._lineImage = null;
    self._mainChildView = null;
    self._slaveChildView = null;
    self._titanView = null;
    self._goddessView = null;
    self._artifactView = null;
    self._petView = null;
    self._dragonTalkerView = null;
    self._heroView = null;
    self._runeView = null;
    self._matchBtn = null;
    self._openBtn = null;
    self._formationBtn = null;
    self.leftList = null;
    self._leftPanel = null;
    self._leftVbox = null;
    self._ticketImage = null;
    self._ticketIcon = null;
    self._costItem = null;
    self.matchingView = null;
    self._noOpenCon = null;
    self._openCon = null;
    self._openBack = null;
    self._winText = null;
    self._loseText = null;
    self._rewardText = null;
    self._winHbox = null;
    self._winGrayBox = null;
    self._loseHbox = null;
    self._loseGrayBox = null;
    self.winMaxCount = 12;
    self.loseMaxCount = 3;
    self.ticketTempId = 0;
    self._helpBtn = null;
    }
    constructor() {
         super();
         this.initView();
         this.initLeftView();
         this.initWinCountView();
         this.addEvent();
         this.model.selectIndex = 1;
         this.refreshView();
         $.C("managers.DreamArenaManager").instance.sendDreamArenaRequest(0);
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,976,641);
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    initView() {
         var _loc2_ = null;
         var _loc1_ = null;
         var _loc4_ = null;
         this._titleImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaFrame.titleImage");
         this._hasTicketText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.hasTicketText");
         this._descText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.descText");
         this._leftBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.leftBg");
         this._rightBorder = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.rightBorder");
         this._rightBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.rightBg");
         this._costImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.costImage");
         this._lineImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.lineImage");
         this._matchBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.matchBtn");
         this._rewardText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.rewardText");
         this._openBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.openBtn");
         this._formationBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.formationBtn");
         this._leftVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.leftVbox");
         this._costItem = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.costItem");
         this._ticketImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.ticketShowImage");
         this._ticketIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaFrame.ticketIcon");
         this._leftPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.leftPanel");
         this._helpBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.helpBtn");
         this._noOpenCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.noOpenCon");
         this._openCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.openCon");
         this._openBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.openBack");
         this._winText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.winText");
         this._loseText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.loseText");
         this._winHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.winHbox");
         this._winGrayBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.winGrayBox");
         this._loseHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.loseHbox");
         this._loseGrayBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaFrame.loseGrayBox");
         this.addToContent(this._titleImage);
         this.addToContent(this._leftBg);
         this.addToContent(this._rightBg);
         this.addToContent(this._rightBorder);
         this.addToContent(this._lineImage);
         this.addToContent(this._leftPanel);
         this.addToContent(this._formationBtn);
         this.addToContent(this._noOpenCon);
         this.addToContent(this._openCon);
         this.addToContent(this._descText);
         this.addToContent(this._rewardText);
         this.addToContent(this._helpBtn);
         this._leftPanel.setView(this._leftVbox);
         this._noOpenCon.addChild(this._ticketImage);
         this._noOpenCon.addChild(this._ticketIcon);
         this._noOpenCon.addChild(this._costImage);
         this._noOpenCon.addChild(this._costItem);
         this._noOpenCon.addChild(this._hasTicketText);
         this._noOpenCon.addChild(this._openBtn);
         this._openCon.addChild(this._openBack);
         this._openCon.addChild(this._winText);
         this._openCon.addChild(this._loseText);
         this._openCon.addChild(this._winHbox);
         this._openCon.addChild(this._winGrayBox);
         this._openCon.addChild(this._loseHbox);
         this._openCon.addChild(this._loseGrayBox);
         this._openCon.addChild(this._matchBtn);
         this.ticketTempId = $.C("yishi.datas.ConfigInfoManager").instance.getDreamArenaTicket();
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this.ticketTempId);
         this._ticketIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(this.ticketTempId);
         if(_loc3_)
         {
            this._ticketIcon.tipData = _loc3_.Description;
         }
         if(this.model.startTime && this.model.stopTime)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.dateType_mmdd",this.model.startTime.date,this.model.startTime.month + 1);
            _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.dateType_mmdd",this.model.stopTime.date,this.model.stopTime.month + 1);
            _loc4_ = $.C("yishi.datas.ConfigInfoManager").instance.getDreamArenaFightTime().join("-");
            this._descText.text = $.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.descText.timeText",_loc2_,_loc1_,_loc4_);
         }
         this._winText.text = $.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.winText.text");
         this._loseText.text = $.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.loseText.text");
         this._rewardText.htmlText = $.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.rewardText.text");
         this._rewardText.mouseEnabled = true;
      }
    initLeftView() {
         var _loc1_ = null;
         var _loc2_ = 0;
         this.leftList = new $.Vector();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ($.C("dreamarena.item.DreamArenaLeftItem"))(_loc2_ + 1);
            this._leftVbox.addChild(_loc1_);
            this.leftList.push(_loc1_);
            _loc2_++;
         }
         this._leftPanel.beginChanges();
         this._leftPanel.invalidateViewport();
         this._leftPanel.commitChanges();
      }
    initWinCountView() {
         var _loc3_ = 0;
         var _loc1_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < this.winMaxCount)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaFrame.winGrapBit");
            _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaFrame.winBit");
            this._winHbox.addChild(_loc4_);
            this._winGrayBox.addChild(_loc1_);
            _loc4_.visible = false;
            _loc1_.visible = true;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.loseMaxCount)
         {
            _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaFrame.loseGrapBit");
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaFrame.loseBit");
            this._loseHbox.addChild(_loc2_);
            this._loseGrayBox.addChild(_loc5_);
            _loc2_.visible = false;
            _loc5_.visible = true;
            _loc3_++;
         }
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._formationBtn.addEventListener("click",$.bind(this, "_formationBtnClickHandler"));
         this._matchBtn.addEventListener("click",$.bind(this, "_matchBtnClickHandler"));
         this._openBtn.addEventListener("click",$.bind(this, "__openBtnClickHandler"));
         this._rewardText.addEventListener("click",$.bind(this, "_rewardClickHandler"));
         if(this._helpBtn)
         {
            this._helpBtn.addEventListener("click",$.bind(this, "__helpBtnHandler"));
         }
         $.C("yishi.utils.MsgMan").addObserver("LEFT_ITEM_SELECT",this,$.bind(this, "__itemSelectChangeHandler"));
         $.C("yishi.utils.MsgMan").addObserver("USER_INFO_CHANGE",this,$.bind(this, "__userInfoChangeHandler"));
         $.C("yishi.utils.MsgMan").addObserver("MATCH_STATE_UPDATE",this,$.bind(this, "__updateMatchHandler"));
         $.C("yishi.utils.MsgMan").addObserver("DREAM_ARENA_TICKET_CHANGE",this,$.bind(this, "__updateTicketHandler"));
         $.C("yishi.utils.MsgMan").addObserver("FIGHT_INFO_CHANGE",this,$.bind(this, "__updateTicketHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._formationBtn)
         {
            this._formationBtn.removeEventListener("click",$.bind(this, "_formationBtnClickHandler"));
         }
         if(this._openBtn)
         {
            this._openBtn.removeEventListener("click",$.bind(this, "__openBtnClickHandler"));
         }
         if(this._matchBtn)
         {
            this._matchBtn.removeEventListener("click",$.bind(this, "_matchBtnClickHandler"));
         }
         if(this._helpBtn)
         {
            this._helpBtn.removeEventListener("click",$.bind(this, "__helpBtnHandler"));
         }
         if(this._rewardText)
         {
            this._rewardText.removeEventListener("click",$.bind(this, "_rewardClickHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("LEFT_ITEM_SELECT",this,$.bind(this, "__itemSelectChangeHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("USER_INFO_CHANGE",this,$.bind(this, "__userInfoChangeHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("MATCH_STATE_UPDATE",this,$.bind(this, "__updateMatchHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("DREAM_ARENA_TICKET_CHANGE",this,$.bind(this, "__updateTicketHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("FIGHT_INFO_CHANGE",this,$.bind(this, "__updateTicketHandler"));
      }
    _formationBtnClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("dreamarena","FORMATION_FRAME");
      }
    _rewardClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("dreamarena","PREVIEW_REWARD_FRAME");
      }
    __openBtnClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this.model.hasTicket <= 0)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.open.noTicketAlert"));
            return;
         }
         var _loc2_ = $.int(this.model.checkAllSelected());
         if(_loc2_ != 0)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.match.noSaveAlert" + _loc2_));
            return;
         }
         $.C("managers.DreamArenaManager").instance.sendDreamArenaRequest(13);
      }
    __updateMatchHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = $.as(param2, "int");
         if(_loc3_ == 0)
         {
            if(!this.matchingView)
            {
               this.matchingView = new ($.C("dreamarena.DreamArenaMatchingView"))();
               this.matchingView.addEventListener("dispose",$.bind(this, "__disposeMatchingView"));
            }
            this.matchingView.show();
         }
         else
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaMatchingView.timeOut.alert"));
            this.__disposeMatchingView(null);
         }
      }
    __disposeMatchingView(param1) {
         if(this.matchingView)
         {
            this.matchingView.removeEventListener("dispose",$.bind(this, "__disposeMatchingView"));
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.matchingView);
         this.matchingView = null;
      }
    _matchBtnClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this.model.canMatch)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.match.notTimeAlert"));
            return;
         }
         var _loc2_ = $.int(this.model.checkAllSelected());
         if(_loc2_ != 0)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.match.noSaveAlert" + _loc2_));
            return;
         }
         $.C("managers.DreamArenaManager").instance.sendDreamArenaRequest(11);
      }
    __helpBtnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dreamarena.DreamArenaFrame.helpFrame");
         _loc2_.show();
      }
    __userInfoChangeHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshLeftView();
         if(this.model.selectIndex == 1)
         {
            if(this.model.selectJob == 4)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               if(!this._dragonTalkerView)
               {
                  this._dragonTalkerView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.dragonTalkerView");
               }
               this._dragonTalkerView.refreshView();
               this.addToContent(this._dragonTalkerView);
            }
            else
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               if(!this._heroView)
               {
                  this._heroView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.heroView");
               }
               this._heroView.refreshView();
               this.addToContent(this._heroView);
            }
         }
         if(this._runeView)
         {
            this._runeView.refreshView();
         }
         if(this._petView)
         {
            this._petView.refreshView();
         }
         if(this._artifactView)
         {
            this._artifactView.refreshView();
         }
         if(this._goddessView)
         {
            this._goddessView.refreshView();
         }
         if(this._titanView)
         {
            this._titanView.refreshView();
         }
         if(this._mainChildView)
         {
            this._mainChildView.refreshView();
         }
         if(this._slaveChildView)
         {
            this._slaveChildView.refreshView();
         }
      }
    __itemSelectChangeHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshLeftView();
         switch($.int(this.model.selectIndex) - 1)
         {
            case 0:
               if(this.model.selectJob == 4)
               {
                  $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
                  this._heroView = null;
                  if(!this._dragonTalkerView)
                  {
                     this._dragonTalkerView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.dragonTalkerView");
                  }
                  this._dragonTalkerView.refreshView();
                  this.addToContent(this._dragonTalkerView);
               }
               else
               {
                  $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
                  this._dragonTalkerView = null;
                  if(!this._heroView)
                  {
                     this._heroView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.heroView");
                  }
                  this._heroView.refreshView();
                  this.addToContent(this._heroView);
               }
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
               this._runeView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
               this._petView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
               this._artifactView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
               this._goddessView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
               this._titanView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
               this._mainChildView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
               this._slaveChildView = null;
               break;
            case 1:
               if(!this._runeView)
               {
                  this._runeView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.runeView");
               }
               this.addToContent(this._runeView);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
               this._petView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
               this._artifactView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
               this._goddessView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
               this._titanView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
               this._mainChildView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
               this._slaveChildView = null;
               break;
            case 2:
               if(!this._petView)
               {
                  this._petView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.petView");
               }
               this.addToContent(this._petView);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
               this._runeView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
               this._artifactView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
               this._goddessView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
               this._titanView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
               this._mainChildView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
               this._slaveChildView = null;
               break;
            case 3:
               if(!this._artifactView)
               {
                  this._artifactView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.artifactView");
               }
               this.addToContent(this._artifactView);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
               this._runeView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
               this._petView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
               this._goddessView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
               this._titanView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
               this._mainChildView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
               this._slaveChildView = null;
               break;
            case 4:
               if(!this._goddessView)
               {
                  this._goddessView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.goddessView");
               }
               this.addToContent(this._goddessView);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
               this._runeView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
               this._artifactView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
               this._petView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
               this._titanView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
               this._mainChildView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
               this._slaveChildView = null;
               break;
            case 5:
               if(!this._titanView)
               {
                  this._titanView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.titanView");
               }
               this.addToContent(this._titanView);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
               this._runeView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
               this._artifactView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
               this._goddessView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
               this._petView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
               this._mainChildView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
               this._slaveChildView = null;
               break;
            case 6:
               if(!this._mainChildView)
               {
                  this._mainChildView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.mainChildView");
               }
               this.addToContent(this._mainChildView);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
               this._runeView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
               this._artifactView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
               this._goddessView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
               this._titanView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
               this._petView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
               this._slaveChildView = null;
               break;
            case 7:
               if(!this._slaveChildView)
               {
                  this._slaveChildView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaFrame.slaveChildView");
               }
               this.addToContent(this._slaveChildView);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
               this._runeView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
               this._dragonTalkerView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
               this._heroView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
               this._artifactView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
               this._goddessView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
               this._titanView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
               this._petView = null;
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
               this._mainChildView = null;
         }
      }
    __updateTicketHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshView();
      }
    refreshView() {
         this._costItem.firstText = "1";
         this._hasTicketText.text = $.C("manager.LanguageMgr").GetTranslation("DreamArenaFrame.hasTicketText.Text",this.model.hasTicket);
         if(this.model.isOpen)
         {
            this._noOpenCon.visible = false;
            this._openCon.visible = true;
            this.refreshWinCountView();
         }
         else
         {
            this._noOpenCon.visible = true;
            this._openCon.visible = false;
         }
      }
    refreshWinCountView() {
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.winMaxCount)
         {
            this._winHbox.getChildAt(_loc1_).visible = _loc1_ < this.model.winCount;
            this._winGrayBox.getChildAt(_loc1_).visible = _loc1_ >= this.model.winCount;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.loseMaxCount)
         {
            this._loseHbox.getChildAt(_loc1_).visible = _loc1_ < this.model.loseCount;
            this._loseGrayBox.getChildAt(_loc1_).visible = _loc1_ >= this.model.loseCount;
            _loc1_++;
         }
      }
    refreshLeftView() {
         var _loc1_ = null;
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = this.leftList[_loc2_];
            _loc1_.refreshView();
            _loc2_++;
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
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleImage);
         this._titleImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hasTicketText);
         this._hasTicketText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._descText);
         this._descText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftBg);
         this._leftBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightBorder);
         this._rightBorder = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightBg);
         this._rightBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._costImage);
         this._costImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lineImage);
         this._lineImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainChildView);
         this._mainChildView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._slaveChildView);
         this._slaveChildView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titanView);
         this._titanView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessView);
         this._goddessView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactView);
         this._artifactView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petView);
         this._petView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeView);
         this._runeView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTalkerView);
         this._dragonTalkerView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroView);
         this._heroView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftVbox);
         this._leftVbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._openBtn);
         this._openBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._matchBtn);
         this._matchBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._formationBtn);
         this._formationBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._costItem);
         this._costItem = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._ticketIcon);
         this._ticketIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftPanel);
         this._leftPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.matchingView);
         this.matchingView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._ticketImage);
         this._ticketImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._helpBtn);
         this._helpBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._noOpenCon);
         this._noOpenCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._openCon);
         this._openCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._openBack);
         this._openBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._winText);
         this._winText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loseText);
         this._loseText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._winHbox);
         this._winHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._winGrayBox);
         this._winGrayBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loseHbox);
         this._loseHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loseGrayBox);
         this._loseGrayBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardText);
         this._rewardText = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.leftList);
         this.leftList = null;
         this.model.clientSelectDic.clear();
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaFrame, "dreamarena.DreamArenaFrame", ["IManualSize"]);
  $.statics(__DreamArenaFrame, () => {
    __DreamArenaFrame.ITEM_COUNT = 8;
  });
  return __DreamArenaFrame;
}
deps["dreamarena.DreamArenaFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "dreamarena.DreamArenaMatchingView", "dreamarena.item.DreamArenaLeftItem", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.datas.ComponentGroupType", "yishi.datas.ConfigInfoManager", "yishi.keyboard.KeyBoardRegister", "yishi.manager.FrameControllerManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.MsgMan", "yishi.view.tips.MessageTipManager"];

defs["dreamarena.DreamArenaMatchingView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaMatchingView extends __Base {
    static $fields(self) {
    self._matchingImage = null;
    self._matchTime = null;
    self._cancelBtn = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._matchingImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaMatchingView.matchingImage");
         this._matchTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaMatchingView.matchTime");
         this._cancelBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaMatchingView.cancelBtn");
         this.addChild(this._matchingImage);
         this.addChild(this._matchTime);
         this.addChild(this._cancelBtn);
      }
    addEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__resizeHandler"));
         this._matchTime.addEventListener("timerDown_complete",$.bind(this, "__timeCompleteHandler"));
         this._cancelBtn.addEventListener("click",$.bind(this, "__cancelClickHandler"));
      }
    removeEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__resizeHandler"));
         if(this._matchTime)
         {
            this._matchTime.removeEventListener("timerDown_complete",$.bind(this, "__timeCompleteHandler"));
         }
         if(this._cancelBtn)
         {
            this._cancelBtn.removeEventListener("click",$.bind(this, "__cancelClickHandler"));
         }
      }
    __resizeHandler(param1) {
         this.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - 529) / 2;
         this.y = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - 100) / 2;
      }
    __timeCompleteHandler(param1) {
         $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaMatchingView.timeOut.alert"));
         $.C("managers.DreamArenaManager").instance.sendDreamArenaRequest(12);
         this.dispose();
      }
    __cancelClickHandler(param1) {
         $.C("managers.DreamArenaManager").instance.sendDreamArenaRequest(12);
         this.dispose();
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         this.__resizeHandler(null);
         this._matchTime.timeCount = 180;
         $.C("yishi.manager.FrameControllerManager").instance.dreamArenaController.dreamArenaMatching = true;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.manager.FrameControllerManager").instance.dreamArenaController.dreamArenaMatching = false;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._matchingImage);
         this._matchingImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._matchTime);
         this._matchTime = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cancelBtn);
         this._cancelBtn = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerModel(v) { super.playerModel = v; }
  }
  $.meta(__DreamArenaMatchingView, "dreamarena.DreamArenaMatchingView", []);
  $.statics(__DreamArenaMatchingView, () => {
    __DreamArenaMatchingView.MATCH_MAX_TIME = 180;
  });
  return __DreamArenaMatchingView;
}
deps["dreamarena.DreamArenaMatchingView"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.view.tips.MessageTipManager"];

defs["dreamarena.DreamArenaRankRewardFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __DreamArenaRankRewardFrame extends __Base {
    static $fields(self) {
    self._border = null;
    self._btnHbox = null;
    self._rankBtn = null;
    self._rewardBtn = null;
    self._btnGroup = null;
    self._myRankText = null;
    self._myScoreText = null;
    self._rankView = null;
    self._rewardView = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this._btnGroup.selectIndex = 0;
         $.C("managers.DreamArenaManager").instance.sendDreamArenaRequest(1);
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,483,406);
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    initView() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankRewardFrame.border");
         this._btnHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankRewardFrame.btnHbox");
         this._rankBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankRewardFrame.rankBtn");
         this._rewardBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankRewardFrame.rewardBtn");
         this._myRankText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankRewardFrame.myRankText");
         this._myScoreText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankRewardFrame.myScoreText");
         this.addToContent(this._border);
         this.addToContent(this._btnHbox);
         this.addToContent(this._myRankText);
         this.addToContent(this._myScoreText);
         this._btnHbox.addChild(this._rankBtn);
         this._btnHbox.addChild(this._rewardBtn);
         this._btnGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._btnGroup.addSelectItem(this._rankBtn);
         this._btnGroup.addSelectItem(this._rewardBtn);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         if(this._btnGroup)
         {
            this._btnGroup.addEventListener("change",$.bind(this, "__tabChangeHandler"));
         }
         $.C("yishi.utils.MsgMan").addObserver("RANK_LIST_BACK",this,$.bind(this, "__rankListBackHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._btnGroup)
         {
            this._btnGroup.removeEventListener("change",$.bind(this, "__tabChangeHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("RANK_LIST_BACK",this,$.bind(this, "__rankListBackHandler"));
      }
    __rankListBackHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshView();
         if(this._rankView)
         {
            this._rankView.refreshListView();
         }
         if(this._rewardView)
         {
            this._rewardView.refreshView();
         }
      }
    __tabChangeHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         switch(this._btnGroup.getSelectedItem())
         {
            case this._rankBtn:
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardView);
               this._rewardView = null;
               if(!this._rankView)
               {
                  this._rankView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaRankRewardFrame.RankView");
               }
               this.addToContent(this._rankView);
               this._rankView.refreshListView();
               break;
            case this._rewardBtn:
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankView);
               this._rankView = null;
               if(!this._rewardView)
               {
                  this._rewardView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaRankRewardFrame.RewardView");
               }
               this.addToContent(this._rewardView);
               this._rewardView.refreshView();
         }
      }
    refreshView() {
         this._myRankText.text = $.C("manager.LanguageMgr").GetTranslation("warlords.room.WarlordsFinalRoomRightView.selfRank",this.model.myRank);
         this._myScoreText.text = $.C("manager.LanguageMgr").GetTranslation("childarena.myScore",this.model.myScore);
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("CrossGuildRankFrame.titleText.text");
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._border);
         this._border = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankBtn);
         this._rankBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardBtn);
         this._rewardBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._btnHbox);
         this._btnHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardView);
         this._rewardView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankView);
         this._rankView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._btnGroup);
         this._btnGroup = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._myRankText);
         this._myRankText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._myScoreText);
         this._myScoreText = null;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaRankRewardFrame, "dreamarena.DreamArenaRankRewardFrame", []);
  return __DreamArenaRankRewardFrame;
}
deps["dreamarena.DreamArenaRankRewardFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.datas.ComponentGroupType", "yishi.utils.MsgMan"];

defs["dreamarena.helper.DreamArenaViewHelper"] = function define($) {
  const __Base = $.Object;
  class __DreamArenaViewHelper extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static getLeftItemData(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc7_ = 0;
         if(!param2.initInfo)
         {
            return null;
         }
         var _loc3_ = {};
         _loc3_.frame = param1 + 3;
         _loc3_.content = "";
         _loc3_.tipStyle = null;
         _loc3_.tipData = null;
         switch(param1 - 1)
         {
            case 0:
               if(!param2.getHeroTempInfo())
               {
                  _loc3_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics(__DreamArenaViewHelper.getDragonTalkerIcon());
               }
               else
               {
                  _loc7_ = $.int(param2.getHeroTempInfo().Job);
                  _loc3_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics(param2.getHeroTempInfo().Icon);
                  _loc3_.frame = _loc7_;
                  _loc3_.content = $.C("manager.LanguageMgr").GetTranslation("DreamArenaLeftItem.heroSelect.skill" + _loc7_ + param2.skillIndex1);
               }
               break;
            case 1:
               _loc3_.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(param2.getRuneTempInfoById(param2.runeId1).Icon);
               _loc3_.tipStyle = "yishi.view.tips.goods.RuneTips";
               _loc3_.tipData = param2.getRuneTempInfoById(param2.runeId1);
               break;
            case 2:
               _loc4_ = param2.getDreamArenaById(param2.heroPetId);
               _loc3_.icon = $.C("yishi.utils.IconFactory").getPetHeadSmallIcon(param2.getPetTempInfoById(param2.heroPetId).TemplateId);
               _loc3_.content = param2.getPetTempInfoById(param2.heroPetId).TemplateName;
               _loc3_.tipStyle = "yishi.view.tips.DreamArenaPetTips";
               _loc3_.tipData = _loc4_;
               break;
            case 3:
               _loc4_ = param2.getDreamArenaById(param2.artifactId);
               _loc5_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc4_.Skill1];
               _loc6_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(_loc4_.PropertyId);
               _loc3_.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(param2.getArtifactTempInfo().Icon);
               _loc3_.content = param2.getArtifactTempInfo().TemplateName;
               _loc3_.tipStyle = "yishi.view.tips.goods.ArtifactEquipTip";
               _loc3_.tipData = {
                  "type":"dreamArena",
                  "tempInfo":param2.getArtifactTempInfo(),
                  "skillTemp":_loc5_,
                  "propTemp":_loc6_
               };
               break;
            case 4:
               _loc4_ = param2.getDreamArenaById(param2.goddessId);
               _loc6_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(_loc4_.PropertyId);
               _loc3_.icon = $.C("yishi.manager.PathManager").getGoddessSmallIcon(param2.getGoddessTempInfo().TemplateId);
               _loc3_.content = param2.getGoddessTempInfo().TemplateName;
               _loc3_.tipStyle = "yishi.view.tips.OneLineTip";
               _loc3_.tipData = $.C("manager.LanguageMgr").GetTranslation("playerinfo.propContiner.tipdata",_loc6_.Attack,_loc6_.Defence,_loc6_.MagicDefence,_loc6_.Live);
               break;
            case 5:
               _loc3_.icon = $.C("yishi.utils.IconFactory").getCommonIconPath("/titan/0.png");
               break;
            case 6:
               _loc3_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics(param2.getChildTempInfoById(param2.mainChildId).Icon);
               _loc4_ = param2.getDreamArenaById(param2.mainChildId);
               _loc3_.tipStyle = "yishi.view.tips.ChildrenFigureTip";
               _loc3_.tipData = _loc4_;
               break;
            case 7:
               _loc3_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics(param2.getChildTempInfoById(param2.slaveChildId).Icon);
               _loc4_ = param2.getDreamArenaById(param2.slaveChildId);
               _loc3_.tipStyle = "yishi.view.tips.ChildrenFigureTip";
               _loc3_.tipData = _loc4_;
               break;
            default:
               return null;
         }
         return _loc3_;
      }
    static getDragonTalkerIcon() {
         return __DreamArenaViewHelper.playerInfo.sexs == 0 ? "/player/102/head.png" : "/player/101/head.png";
      }
    static get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    static set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__DreamArenaViewHelper, "dreamarena.helper.DreamArenaViewHelper", []);
  return __DreamArenaViewHelper;
}
deps["dreamarena.helper.DreamArenaViewHelper"] = ["manager.LanguageMgr", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["dreamarena.item.DreamAreaDragonSelectSkillItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamAreaDragonSelectSkillItem extends __Base {
    static $fields(self) {
    self._skillIcon1 = null;
    self._skillIcon2 = null;
    self._selectBit = null;
    self._selectKuanBit = null;
    self._back = null;
    self._title = null;
    self._selectIdx = 0;
    self._skillIds = null;
    self._type = 0;
    }
    constructor(param1 = -1) {
         super();
         this._type = param1;
         this.initView();
         this.initEvent();
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillIcon1);
         this._skillIcon1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillIcon2);
         this._skillIcon2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBit);
         this._selectBit = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectKuanBit);
         this._selectKuanBit = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         this._title = null;
         super.dispose();
      }
    initView() {
         this._skillIcon1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaHeroSkillItem.DragonskillIcon1");
         this._skillIcon2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaHeroSkillItem.DragonskillIcon2");
         this._selectBit = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArena.lookBtn.cck");
         this._selectKuanBit = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArena.lookBtn.cLk");
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArena.lookBtn.sBk");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.dreamarena.dreamAreaItemTitle");
         this.addChild(this._back);
         this.addChild(this._title);
         this.addChild(this._skillIcon1);
         this.addChild(this._skillIcon2);
         this.addChild(this._selectKuanBit);
         this.addChild(this._selectBit);
         this._skillIcon1.name = "0";
         this._skillIcon2.name = "1";
         this._skillIcon1.buttonMode = true;
         this._skillIcon2.buttonMode = true;
         this.selectIdx = 0;
      }
    set titleText(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._title.text = param1;
      }
    initEvent() {
         this._skillIcon1.addEventListener("click",$.bind(this, "iconClickHandler"));
         this._skillIcon2.addEventListener("click",$.bind(this, "iconClickHandler"));
      }
    removeEvent() {
         this._skillIcon1.removeEventListener("click",$.bind(this, "iconClickHandler"));
         this._skillIcon2.removeEventListener("click",$.bind(this, "iconClickHandler"));
      }
    iconClickHandler(param1) {
         var _loc3_ = $.as(param1.currentTarget, $.C("flash.display.DisplayObject"));
         var _loc2_ = _loc3_.name;
         switch(_loc2_)
         {
            case "0":
               this.selectIdx = 0;
               break;
            case "1":
               this.selectIdx = 1;
         }
         $.C("yishi.manager.NotificationManager").instance.sendNotification("DreamAreaDragonSkillChange",this._type);
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    get selectIdx() {
         return this._selectIdx;
      }
    set selectIdx(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._selectIdx = param1;
         switch(this._selectIdx)
         {
            case 0:
               this._selectKuanBit.x = -2;
               this._selectKuanBit.y = 15;
               this._selectBit.x = 38;
               this._selectBit.y = 53;
               this._skillIcon1.alpha = 1;
               this._skillIcon2.alpha = 0.5;
               break;
            case 1:
               this._selectKuanBit.x = 50;
               this._selectKuanBit.y = 15;
               this._selectBit.x = 88;
               this._selectBit.y = 53;
               this._skillIcon1.alpha = 0.5;
               this._skillIcon2.alpha = 1;
         }
      }
    get skillIds() {
         return this._skillIds;
      }
    set skillIds(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = 0;
         var _loc3_ = null;
         if(this._skillIds == param1)
         {
            return;
         }
         this._skillIds = param1;
         var _loc4_ = this._skillIds.split(",");
         if(_loc4_ && _loc4_.length == 2)
         {
            _loc2_ = $.int(_loc4_[0]);
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc2_];
            this._skillIcon1.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc3_.Icons);
            this._skillIcon1.tipData = _loc3_;
            _loc2_ = $.int(_loc4_[1]);
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc2_];
            this._skillIcon2.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc3_.Icons);
            this._skillIcon2.tipData = _loc3_;
         }
      }
    get titleText() { return super.titleText; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamAreaDragonSelectSkillItem, "dreamarena.item.DreamAreaDragonSelectSkillItem", []);
  return __DreamAreaDragonSelectSkillItem;
}
deps["dreamarena.item.DreamAreaDragonSelectSkillItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.DisplayObject", "managers.DreamArenaManager", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["dreamarena.item.DreamAreaDragonSkillBar"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamAreaDragonSkillBar extends __Base {
    static $fields(self) {
    self._skillHbox = null;
    self._type = 0;
    }
    constructor(param1) {
         super();
         this._type = param1;
         this.initView();
         this.initSkills();
         this.initEvent();
      }
    initView() {
         this._skillHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.dragonSkillHbox");
         this.addChild(this._skillHbox);
      }
    initSkills() {
         var _loc1_ = null;
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,_loc5_);
         var _loc2_ = [];
         if(_loc3_)
         {
            _loc2_ = _loc3_["Skill" + this._type].split(";");
         }
         this._skillHbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.dragonSkillItem",[this._type]);
            _loc1_.skillIds = _loc2_[_loc4_];
            if(this._type == 1)
            {
               _loc1_.titleText = $.C("manager.LanguageMgr").GetTranslation("dreamarea.skill.inactive",_loc4_ + 1);
            }
            else
            {
               _loc1_.titleText = $.C("manager.LanguageMgr").GetTranslation("dreamarea.skill.passtive",_loc4_ + 1);
            }
            this._skillHbox.addChild(_loc1_);
            _loc4_++;
         }
         this._skillHbox.commitChanges();
      }
    initEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("DreamAreaDragonSkillChange",$.bind(this, "selectedChangeHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("DreamAreaDragonSkillChange",$.bind(this, "selectedChangeHandler"));
      }
    selectedChangeHandler(param1) {
         var _loc3_ = $.int(param1.data);
         if(this._type != _loc3_)
         {
            return;
         }
         var _loc4_ = this.selectIds;
         this.model.clientSelectDic.add(22,_loc4_);
         this.model.clientSelectDic.add(22 + 100 + this._type,_loc4_);
         var _loc2_ = 22;
         $.C("yishi.utils.MsgMan").notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    refreshClientSelect() {
      }
    setJobType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc6_ = $.C("managers.DreamArenaManager").instance.model.selfInfo;
         if(this._type == 1)
         {
            _loc3_ = _loc6_.dragonSkill;
         }
         else if(this._type == 2)
         {
            _loc3_ = _loc6_.dragonPassiveSkill;
         }
         var _loc5_ = _loc3_.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc2_ = $.as(this._skillHbox.getChildAt(_loc4_), $.C("dreamarena.item.DreamAreaDragonSelectSkillItem"));
            _loc2_.selectIdx = $.int(_loc5_[_loc4_]);
            _loc4_++;
         }
      }
    get selectIds() {
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc3_ = $.int(this._skillHbox.numChildren);
         var _loc1_ = "";
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = $.as(this._skillHbox.getChildAt(_loc4_), $.C("dreamarena.item.DreamAreaDragonSelectSkillItem"));
            if(_loc4_ < _loc3_ - 1)
            {
               _loc1_ += _loc2_.selectIdx + ",";
            }
            else
            {
               _loc1_ += _loc2_.selectIdx;
            }
            _loc4_++;
         }
         return _loc1_;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillHbox);
         this._skillHbox = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
    set selectIds(v) { super.selectIds = v; }
  }
  $.meta(__DreamAreaDragonSkillBar, "dreamarena.item.DreamAreaDragonSkillBar", []);
  return __DreamAreaDragonSkillBar;
}
deps["dreamarena.item.DreamAreaDragonSkillBar"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamAreaDragonSelectSkillItem", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager", "yishi.utils.MsgMan"];

defs["dreamarena.item.DreamAreanaPreviewRewardItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamAreanaPreviewRewardItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._winCountText = null;
    self._winBit = null;
    self._rewardHbox = null;
    self.index = 0;
    self._data = null;
    }
    constructor(param1) {
         super();
         this.index = param1;
         this.initView();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamAreanaPreviewRewardItem.bg");
         this._winCountText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaPreviewRewardItem.winCountText");
         this._winBit = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamAreanaPreviewRewardItem.winBit");
         this._rewardHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamAreanaPreviewRewardItem.rewardHbox");
         this.addChild(this._bg);
         this._bg.visible = this.index % 2 == 0;
         this.addChild(this._winCountText);
         this.addChild(this._winBit);
         this.addChild(this._rewardHbox);
      }
    setWinCount(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._winCountText.text = param1 + "";
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         this._data = param1;
         this._rewardHbox.removeAllChild();
         if(this.data)
         {
            this.data.sortOn("itemId",16);
            for (var _loc4_ of $.values(this.data))
            {
               _loc2_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
               _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamAreanaReportFrame.rewardItem");
               _loc2_.templateId = _loc4_.itemId;
               _loc2_.count = _loc4_.count;
               _loc3_.data = _loc2_;
               this._rewardHbox.addChild(_loc3_);
            }
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._winCountText);
         this._winCountText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._winBit);
         this._winBit = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardHbox);
         this._rewardHbox = null;
         super.dispose();
      }
  }
  $.meta(__DreamAreanaPreviewRewardItem, "dreamarena.item.DreamAreanaPreviewRewardItem", []);
  return __DreamAreanaPreviewRewardItem;
}
deps["dreamarena.item.DreamAreanaPreviewRewardItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "yishi.datas.goods.GoodsInfo"];

defs["dreamarena.item.DreamArenaChildSelectItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaChildSelectItem extends __Base {
    static $fields(self) {
    self._itemBg = null;
    self._childIcon = null;
    self._selectBg = null;
    self._lookBtn = null;
    self._selectBtn = null;
    self._hasSelectBtn = null;
    self.showSkillView = null;
    self.type = 0;
    self.index = 0;
    self._data = null;
    }
    constructor(param1, param2) {
         super();
         this.type = param1;
         this.index = param2;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._itemBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildSelectItem.itemBg");
         this._childIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaChildSelectItem.childIcon");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaChildSelectItem.selectBg");
         this._selectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaChildSelectItem.selectBtn");
         this._lookBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaChildSelectItem.lookBtn");
         this._hasSelectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildSelectItem.hasSelectBtn");
         this.addChild(this._itemBg);
         this.addChild(this._childIcon);
         this.addChild(this._selectBg);
         this.addChild(this._lookBtn);
         this.addChild(this._selectBtn);
         this.addChild(this._hasSelectBtn);
         this._hasSelectBtn.enable = false;
         this._selectBg.visible = false;
         this._selectBg.mouseEnabled = false;
      }
    addEvent() {
         this._lookBtn.addEventListener("click",$.bind(this, "_lookBtnClickHandler"));
         this._selectBtn.addEventListener("click",$.bind(this, "_selectBtnClickHandler"));
      }
    removeEvent() {
         if(this._lookBtn)
         {
            this._lookBtn.removeEventListener("click",$.bind(this, "_lookBtnClickHandler"));
         }
         if(this._selectBtn)
         {
            this._selectBtn.removeEventListener("click",$.bind(this, "_selectBtnClickHandler"));
         }
      }
    _lookBtnClickHandler(param1) {
         var _loc2_ = null;
         if(!this.data)
         {
            return;
         }
         var _loc3_ = this.data.Skill1.split(",").concat(this.data.PassiveSkill1.split(","));
         if(!this.showSkillView)
         {
            this.showSkillView = new ($.C("dreamarena.view.DreamArenaChildSkillView"))();
            this.showSkillView.show(_loc3_);
            this.showSkillView.addEventListener("dispose",$.bind(this, "__disposeShowView"));
            _loc2_ = new ($.C("flash.geom.Point"))(this._lookBtn.displayWidth / 2,0);
            _loc2_ = this._lookBtn.localToGlobal(_loc2_);
            this.showSkillView.x = _loc2_.x + 15;
            this.showSkillView.y = _loc2_.y + 5;
         }
      }
    __disposeShowView(param1) {
         if(this.showSkillView)
         {
            this.showSkillView.removeEventListener("dispose",$.bind(this, "__disposeShowView"));
         }
         this.showSkillView = null;
      }
    _selectBtnClickHandler(param1) {
         var _loc2_ = 0;
         if(this.type == 1)
         {
            this.model.clientSelectDic.add(3,this.data.TemplateId);
            _loc2_ = 3;
         }
         else if(this.type == 2)
         {
            this.model.clientSelectDic.add(4,this.data.TemplateId);
            _loc2_ = 4;
         }
         $.C("yishi.utils.MsgMan").notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc2_ = null;
         this._data = param1;
         if(this.data)
         {
            _loc2_ = $.as(this.data.typeTempInfo, $.C("yishi.datas.templates.ChildTempInfo"));
            if(_loc2_)
            {
               this._childIcon.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics(_loc2_.Icon);
               this._childIcon.tipData = this.data;
               if(this.type == 1)
               {
                  this._selectBtn.visible = this.data.TemplateId != this.selectInfo.mainChildId;
                  this._hasSelectBtn.visible = this.data.TemplateId == this.selectInfo.mainChildId;
                  this._selectBg.visible = this.data.TemplateId == this.selectInfo.mainChildId;
               }
               else
               {
                  this._selectBtn.visible = this.data.TemplateId != this.selectInfo.slaveChildId;
                  this._hasSelectBtn.visible = this.data.TemplateId == this.selectInfo.slaveChildId;
                  this._selectBg.visible = this.data.TemplateId == this.selectInfo.slaveChildId;
               }
            }
         }
      }
    refreshClientSelect() {
         var _loc1_ = false;
         if(!this.data)
         {
            return;
         }
         if(this.type == 1)
         {
            _loc1_ = this.data.TemplateId == this.model.clientSelectDic[3];
            this._hasSelectBtn.visible = _loc1_;
            this._selectBg.visible = _loc1_;
            this._selectBtn.visible = !_loc1_;
         }
         else if(this.type == 2)
         {
            _loc1_ = this.data.TemplateId == this.model.clientSelectDic[4];
            this._hasSelectBtn.visible = _loc1_;
            this._selectBg.visible = _loc1_;
            this._selectBtn.visible = !_loc1_;
         }
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childIcon);
         this._childIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBtn);
         this._selectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lookBtn);
         this._lookBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hasSelectBtn);
         this._hasSelectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemBg);
         this._itemBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.showSkillView);
         this.showSkillView = null;
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaChildSelectItem, "dreamarena.item.DreamArenaChildSelectItem", []);
  return __DreamArenaChildSelectItem;
}
deps["dreamarena.item.DreamArenaChildSelectItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.view.DreamArenaChildSkillView", "flash.geom.Point", "managers.DreamArenaManager", "yishi.datas.templates.ChildTempInfo", "yishi.utils.IconFactory", "yishi.utils.MsgMan"];

defs["dreamarena.item.DreamArenaCommonRightItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaCommonRightItem extends __Base {
    static $fields(self) {
    self._heroBack = null;
    self._line2 = null;
    self._line1 = null;
    self._hasSelectBtn = null;
    self._selectBtn = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._heroBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.heroBack");
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.line2");
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.lien1");
         this._hasSelectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.hasSelectBtn");
         this._selectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonRightItem.selectBtn");
         this.addChild(this._heroBack);
         this.addChild(this._line1);
         this.addChild(this._line2);
         this.addChild(this._selectBtn);
         this.addChild(this._hasSelectBtn);
         this._hasSelectBtn.enable = false;
      }
    addEvent() {
         this._selectBtn.addEventListener("click",$.bind(this, "_selectBtnClickHandler"));
      }
    removeEvent() {
         if(this._selectBtn)
         {
            this._selectBtn.removeEventListener("click",$.bind(this, "_selectBtnClickHandler"));
         }
      }
    _selectBtnClickHandler(param1) {
      }
    refreshSelect(param1) {
         this._line1.visible = this._line2.visible = param1;
         this._selectBtn.visible = !param1;
         this._hasSelectBtn.visible = param1;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroBack);
         this._heroBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         this._line2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         this._line1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hasSelectBtn);
         this._hasSelectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBtn);
         this._selectBtn = null;
         super.dispose();
      }
  }
  $.meta(__DreamArenaCommonRightItem, "dreamarena.item.DreamArenaCommonRightItem", []);
  return __DreamArenaCommonRightItem;
}
deps["dreamarena.item.DreamArenaCommonRightItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils"];

defs["dreamarena.item.DreamArenaCommonSelectItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaCommonSelectItem extends __Base {
    static $fields(self) {
    self._icon = null;
    self._selectBg = null;
    self._selectBtn = null;
    self.index = 0;
    self.type = 0;
    self._data = null;
    self.armoryInfo = null;
    }
    constructor(param1, param2) {
         super();
         this.type = param1;
         this.index = param2;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaCommonSelectItem.icon");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBg");
         this._selectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBtn");
         this.addChild(this._icon);
         this.addChild(this._selectBg);
         this.addChild(this._selectBtn);
         this._selectBg.mouseEnabled = false;
         this.armoryInfo = new ($.C("mvc.module.ancientartifact.AncientArmoryInfo"))();
      }
    addEvent() {
         this._selectBtn.addEventListener("click",$.bind(this, "_selectBtnClickHandler"));
      }
    removeEvent() {
         if(this._selectBtn)
         {
            this._selectBtn.removeEventListener("click",$.bind(this, "_selectBtnClickHandler"));
         }
      }
    _selectBtnClickHandler(param1) {
         var _loc2_ = 0;
         var _loc3_ = null;
         if(this.type == 1)
         {
            if(!this.model.clientSelectDic[7])
            {
               this.model.clientSelectDic.add(7,[]);
            }
            _loc3_ = $.as(this.model.clientSelectDic[7], "Array");
            if(_loc3_.length >= 3)
            {
               _loc3_ = [this.data.TemplateId];
            }
            else
            {
               _loc3_.push(this.data.TemplateId);
            }
            this.model.clientSelectDic.add(7,_loc3_);
            _loc2_ = 7;
         }
         else if(this.type == 2)
         {
            this.model.clientSelectDic.add(23,this.index);
            _loc2_ = 23;
         }
         $.C("yishi.utils.MsgMan").notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc3_ = false;
         var _loc2_ = null;
         this._data = param1;
         if(this.data)
         {
            this.setTipData();
            if(this.type == 1)
            {
               _loc2_ = $.as(($.as(this.data, $.C("yishi.datas.templates.DreamArenaTempInfo"))).typeTempInfo, $.C("yishi.datas.templates.ArmoryTemplateInfo"));
               this._icon.icon = $.C("yishi.utils.IconFactory").getArmoryIconPath(_loc2_.TemplateId,5);
               _loc3_ = this.selectInfo.armoryAry.indexOf(($.as(this.data, $.C("yishi.datas.templates.DreamArenaTempInfo"))).TemplateId) != -1;
               this._selectBtn.text = _loc3_ ? $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.hasSelectText") : $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.selectText");
               this._selectBg.visible = _loc3_;
               this._selectBtn.enable = !_loc3_;
            }
            else if(this.type == 2)
            {
               this._icon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(($.as(this.data, $.C("yishi.datas.templates.SkillTempInfo"))).Icons);
               _loc3_ = this.selectInfo.selfSelectJob == 4 && this.selectInfo.skillIndex2 == this.index;
               this._selectBtn.text = _loc3_ ? $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.hasSelectText") : $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.selectText");
               this._selectBg.visible = _loc3_;
               this._selectBtn.enable = !_loc3_;
            }
         }
         else
         {
            this._icon.icon = null;
            this._icon.tipData = null;
            this._selectBg.visible = false;
         }
      }
    setTipData() {
         if(this.type == 1)
         {
            this._icon.tipStyle = "yishi.view.tips.AncientArmoryTips";
            this._icon.tipData = this.createArmoryInfo($.as(this.data, $.C("yishi.datas.templates.DreamArenaTempInfo")));
         }
         else if(this.type == 2)
         {
            this._icon.tipStyle = "yishi.view.tips.goods.SkillTips";
            this._icon.tipData = $.as(this.data, $.C("yishi.datas.templates.SkillTempInfo"));
         }
      }
    createArmoryInfo(param1) {
         var _loc2_ = $.as(($.as(param1, $.C("yishi.datas.templates.DreamArenaTempInfo"))).typeTempInfo, $.C("yishi.datas.templates.ArmoryTemplateInfo"));
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(param1.PropertyId);
         this.armoryInfo.templateId = _loc2_.TemplateId;
         this.armoryInfo.grades = 5;
         this.armoryInfo.profile = 5;
         this.armoryInfo.attacks = _loc3_.Attack;
         this.armoryInfo.defences = _loc3_.Defence;
         this.armoryInfo.magicDefences = _loc3_.MagicDefence;
         this.armoryInfo.live = _loc3_.Live;
         this.armoryInfo.parry = _loc3_.Parry;
         this.armoryInfo.penetrate = _loc3_.Penetrate;
         return this.armoryInfo;
      }
    refreshClientSelect() {
         var _loc2_ = false;
         var _loc1_ = null;
         if(!this.data)
         {
            return;
         }
         if(this.type == 1)
         {
            if(!this.model.clientSelectDic[7])
            {
               _loc2_ = false;
            }
            else
            {
               _loc1_ = $.as(this.model.clientSelectDic[7], "Array");
               _loc2_ = _loc1_.indexOf(($.as(this.data, $.C("yishi.datas.templates.DreamArenaTempInfo"))).TemplateId) != -1;
            }
            this._selectBtn.text = _loc2_ ? $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.hasSelectText") : $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.selectText");
            this._selectBg.visible = _loc2_;
            this._selectBtn.enable = !_loc2_;
         }
         else if(this.type == 2)
         {
            if(!this.model.clientSelectDic[23])
            {
               _loc2_ = false;
            }
            else
            {
               _loc2_ = this.model.clientSelectDic[23] == this.index;
            }
            this._selectBtn.text = _loc2_ ? $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.hasSelectText") : $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.selectText");
            this._selectBg.visible = _loc2_;
            this._selectBtn.enable = !_loc2_;
         }
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBtn);
         this._selectBtn = null;
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaCommonSelectItem, "dreamarena.item.DreamArenaCommonSelectItem", []);
  return __DreamArenaCommonSelectItem;
}
deps["dreamarena.item.DreamArenaCommonSelectItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.DreamArenaManager", "mvc.module.ancientartifact.AncientArmoryInfo", "yishi.datas.templates.ArmoryTemplateInfo", "yishi.datas.templates.DreamArenaTempInfo", "yishi.datas.templates.SkillTempInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.MsgMan"];

defs["dreamarena.item.DreamArenaCommonSelectItemII"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaCommonSelectItemII extends __Base {
    static $fields(self) {
    self._itemBg = null;
    self._icon = null;
    self._selectBg = null;
    self._hasSelectBtn = null;
    self._selectBtn = null;
    self.index = 0;
    self.type = 0;
    self._data = null;
    }
    constructor(param1, param2) {
         super();
         this.type = param1;
         this.index = param2;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._itemBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaCommonSelectItemII.itemBg");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaChildPetSelectItem.icon");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaCommonSelectItemII.selectBg");
         this._hasSelectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaChildPetSelectItem.hasSelectBtn");
         this._selectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaChildPetSelectItem.selectBtn");
         this.addChild(this._itemBg);
         this.addChild(this._icon);
         this.addChild(this._selectBg);
         this.addChild(this._selectBtn);
         this.addChild(this._hasSelectBtn);
         this._selectBg.visible = false;
         this._hasSelectBtn.enable = false;
         this._hasSelectBtn.visible = false;
         this._selectBg.mouseEnabled = false;
         if(this.type == 1)
         {
            this._itemBg.visible = false;
            this._icon.scaleX = this._icon.scaleY = 1;
            this._icon.x = 13;
            this._icon.y = 13;
         }
         else
         {
            this._itemBg.visible = true;
            this._icon.scaleX = this._icon.scaleY = 0.75;
            this._icon.x = 23;
            this._icon.y = 20;
         }
      }
    addEvent() {
         this._selectBtn.addEventListener("click",$.bind(this, "_selectBtnClickHandler"));
      }
    removeEvent() {
         if(this._selectBtn)
         {
            this._selectBtn.removeEventListener("click",$.bind(this, "_selectBtnClickHandler"));
         }
      }
    _selectBtnClickHandler(param1) {
         var _loc2_ = 0;
         var _loc3_ = null;
         if(this.type == 1)
         {
            this.model.clientSelectDic.add(6,this.data.TemplateId);
            _loc2_ = 6;
         }
         else if(this.type == 2)
         {
            this.model.clientSelectDic.add(32,this.data.TemplateId);
            _loc2_ = 32;
         }
         else if(this.type == 3)
         {
            this.model.clientSelectDic.add(42,this.data.TemplateId);
            _loc2_ = 42;
         }
         else if(this.type == 4)
         {
            if(!this.model.clientSelectDic[9])
            {
               this.model.clientSelectDic.add(9,[]);
            }
            _loc3_ = $.as(this.model.clientSelectDic[9], "Array");
            if(_loc3_.length >= 2)
            {
               _loc3_ = [this.data.TemplateId];
            }
            else
            {
               _loc3_.push(this.data.TemplateId);
            }
            this.model.clientSelectDic.add(9,_loc3_);
            _loc2_ = 9;
         }
         $.C("yishi.utils.MsgMan").notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc2_ = null;
         this._data = param1;
         if(this.data)
         {
            this.setTipData();
            if(this.type == 1)
            {
               _loc4_ = $.as(this.data.typeTempInfo, $.C("yishi.datas.templates.ArtifactTemplateInfo"));
               if(_loc4_)
               {
                  this._icon.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(_loc4_.Icon);
               }
               this._selectBg.visible = this.data.TemplateId == this.selectInfo.artifactId;
               this._hasSelectBtn.visible = this.data.TemplateId == this.selectInfo.artifactId;
               this._selectBtn.visible = this.data.TemplateId != this.selectInfo.artifactId;
            }
            else if(this.type == 2)
            {
               _loc3_ = $.as(this.data.typeTempInfo, $.C("yishi.datas.templates.PetTemplate"));
               if(_loc3_)
               {
                  this._icon.icon = $.C("yishi.utils.IconFactory").getPetHeadSmallIcon(_loc3_.TemplateId);
               }
               this._selectBg.visible = this.data.TemplateId == this.selectInfo.mainChildPetId;
               this._hasSelectBtn.visible = this.data.TemplateId == this.selectInfo.mainChildPetId;
               this._selectBtn.visible = this.data.TemplateId != this.selectInfo.mainChildPetId;
            }
            else if(this.type == 3)
            {
               _loc5_ = $.as(this.data.typeTempInfo, $.C("yishi.datas.templates.PetTemplate"));
               if(_loc5_)
               {
                  this._icon.icon = $.C("yishi.utils.IconFactory").getPetHeadSmallIcon(_loc5_.TemplateId);
               }
               this._selectBg.visible = this.data.TemplateId == this.selectInfo.slaveChildPetId;
               this._hasSelectBtn.visible = this.data.TemplateId == this.selectInfo.slaveChildPetId;
               this._selectBtn.visible = this.data.TemplateId != this.selectInfo.slaveChildPetId;
            }
            else if(this.type == 4)
            {
               _loc2_ = $.as(this.data.typeTempInfo, $.C("yishi.datas.templates.RuneTemplateInfo"));
               if(_loc2_)
               {
                  this._icon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc2_.Icon);
               }
               this._selectBg.visible = this.selectInfo.runeArys.indexOf(this.data.TemplateId) != -1;
               this._hasSelectBtn.visible = this.selectInfo.runeArys.indexOf(this.data.TemplateId) != -1;
               this._selectBtn.visible = this.selectInfo.runeArys.indexOf(this.data.TemplateId) == -1;
            }
         }
         else
         {
            this._icon.icon = null;
            this._icon.tipData = null;
            this._selectBg.visible = false;
            this._hasSelectBtn.visible = false;
            this._selectBtn.visible = false;
         }
      }
    setTipData() {
         var _loc1_ = null;
         var _loc2_ = null;
         if(this.type == 1)
         {
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[this.data.Skill1];
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(this.data.PropertyId);
            this._icon.tipStyle = "yishi.view.tips.goods.ArtifactEquipTip";
            this._icon.tipData = {
               "type":"dreamArena",
               "tempInfo":$.as(this.data.typeTempInfo, $.C("yishi.datas.templates.ArtifactTemplateInfo")),
               "skillTemp":_loc1_,
               "propTemp":_loc2_
            };
         }
         else if(this.type == 2 || this.type == 3)
         {
            this._icon.tipStyle = "yishi.view.tips.DreamArenaPetTips";
            this._icon.tipData = this.data;
         }
         else if(this.type == 4)
         {
            this._icon.tipStyle = "yishi.view.tips.goods.RuneTips";
            this._icon.tipData = $.as(this.data.typeTempInfo, $.C("yishi.datas.templates.RuneTemplateInfo"));
         }
      }
    refreshClientSelect() {
         var _loc2_ = false;
         var _loc1_ = null;
         if(!this.data)
         {
            return;
         }
         if(this.type == 1)
         {
            _loc2_ = this.data.TemplateId == this.model.clientSelectDic[6];
            this._selectBg.visible = _loc2_;
            this._hasSelectBtn.visible = _loc2_;
            this._selectBtn.visible = !_loc2_;
         }
         else if(this.type == 2)
         {
            _loc2_ = this.data.TemplateId == this.model.clientSelectDic[32];
            this._selectBg.visible = _loc2_;
            this._hasSelectBtn.visible = _loc2_;
            this._selectBtn.visible = !_loc2_;
         }
         else if(this.type == 3)
         {
            _loc2_ = this.data.TemplateId == this.model.clientSelectDic[42];
            this._selectBg.visible = _loc2_;
            this._hasSelectBtn.visible = _loc2_;
            this._selectBtn.visible = !_loc2_;
         }
         else if(this.type == 4)
         {
            if(!this.model.clientSelectDic[9])
            {
               _loc2_ = false;
            }
            else
            {
               _loc1_ = $.as(this.model.clientSelectDic[9], "Array");
               _loc2_ = _loc1_.indexOf(this.data.TemplateId) != -1;
            }
            this._selectBg.visible = _loc2_;
            this._hasSelectBtn.visible = _loc2_;
            this._selectBtn.visible = !_loc2_;
         }
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemBg);
         this._itemBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hasSelectBtn);
         this._hasSelectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBtn);
         this._selectBtn = null;
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaCommonSelectItemII, "dreamarena.item.DreamArenaCommonSelectItemII", []);
  return __DreamArenaCommonSelectItemII;
}
deps["dreamarena.item.DreamArenaCommonSelectItemII"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "managers.DreamArenaManager", "yishi.datas.templates.ArtifactTemplateInfo", "yishi.datas.templates.PetTemplate", "yishi.datas.templates.RuneTemplateInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.MsgMan"];

defs["dreamarena.item.DreamArenaFormationItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaFormationItem extends __Base {
    static $fields(self) {
    self.site = 0;
    self.isLock = false;
    self._data = undefined;
    self._bottom = null;
    self._controller = $.C("yishi.manager.FrameControllerManager").instance.petchallengeController;
    self._pos = 0;
    self._loader = null;
    self._body = null;
    self._heroMovie = null;
    self.SCALE = 0.815;
    }
    constructor(param1 = 0) {
         $.pre(new.target, (__s) => {
         __s._pos = param1;
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
         this.mouseEnabled = false;
      }
    initView() {
         this._bottom = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.common.formationBottom");
         this._bottom.scaleX = this._bottom.scaleY = 0.815;
         this.addChild(this._bottom);
         this.setBottomVisible(false);
         this.hitArea = this._bottom;
      }
    setBottomVisible(param1) {
         if(this._bottom)
         {
            this._bottom.visible = param1;
            this._bottom.stop();
         }
      }
    set data(param1) {
         this._data = param1;
         if(this._data)
         {
            this.refresh();
         }
         else
         {
            this.clean();
         }
      }
    refresh() {
         var _loc2_ = null;
         var _loc1_ = null;
         this.clearBody();
         if($.is(this.data, $.C("yishi.datas.playerinfo.ThaneInfo")))
         {
            this._body = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            this.setBodyProperty();
            _loc2_ = new ($.C("yishi.datas.objects.HeroRoleInfo"))();
            _loc2_.heroInfo = $.as(this.data, $.C("yishi.datas.playerinfo.ThaneInfo"));
            _loc2_.heroInfo.dragonTalkerInfo.isDragonTalker = ($.as(this.data, $.C("yishi.datas.playerinfo.ThaneInfo"))).dragonTalkerInfo.isDragonTalker;
            _loc2_.heroInfo.dragonTalkerInfo.battleBeastId = 8;
            this._heroMovie = new ($.C("yishi.view.tools.PetFormationMovieClip"))(_loc2_);
            this._heroMovie.callBackComplete.addSingleListener($.bind(this, "heroMovieClipLoadComplete"));
            this._heroMovie.startLoad();
         }
         else if($.is(this.data, $.C("mvc.module.children.ChildData")))
         {
            if(this._controller.childDefineDic[($.as(this._data, $.C("mvc.module.children.ChildData"))).job + "_" + ($.as(this._data, $.C("mvc.module.children.ChildData"))).growthGrade])
            {
               this.createBody();
            }
            else
            {
               this._body = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               this.setBodyProperty();
               _loc1_ = $.C("yishi.manager.PathManager").solveChildAvatarPath(this._data.job,this._data.growthGrade);
               $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,8,$.bind(this, "__loadedCompleteHandler"));
            }
         }
         if(this._body)
         {
            this.addChild(this._body);
         }
         this.setBottomVisible(false);
         this.buttonMode = true;
      }
    __loadedCompleteHandler(param1, param2) {
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         this.clearBody();
         if(this.isDie)
         {
            return;
         }
         if(!this._data)
         {
            return;
         }
         if($.is(this._data, $.C("mvc.module.children.ChildData")))
         {
            _loc5_ = $.as(this._controller.childDefineDic[($.as(this._data, $.C("mvc.module.children.ChildData"))).job + "_" + ($.as(this._data, $.C("mvc.module.children.ChildData"))).growthGrade], "Class");
         }
         if(!_loc5_)
         {
            if(param2)
            {
               _loc3_ = new ($.C("flash.system.ApplicationDomain"))($.C("flash.system.ApplicationDomain").currentDomain);
               _loc4_ = new ($.C("flash.system.LoaderContext"))(false,_loc3_);
               this.disposeLoader();
               this._loader = new ($.C("flash.display.Loader"))();
               this._loader.contentLoaderInfo.addEventListener("complete",$.bind(this, "__complete"));
               this._loader.loadBytes($.as(param2, $.C("flash.utils.ByteArray")),_loc4_);
            }
         }
         else
         {
            this.createBody();
         }
      }
    heroMovieClipLoadComplete() {
         if(!this._data)
         {
            return;
         }
         if(this.isDie)
         {
            return;
         }
         this.clearBody();
         if(this._heroMovie)
         {
            this._body = this._heroMovie;
            this.setBodyProperty();
            this.addChild(this._body);
            this._body.gotoAndPlay(1);
         }
      }
    __complete(param1) {
         var _loc3_ = null;
         var _loc2_ = $.as(param1.currentTarget, "flash.display.LoaderInfo");
         _loc2_.removeEventListener("complete",$.bind(this, "__complete"));
         if($.is(this._data, $.C("mvc.module.children.ChildData")))
         {
            _loc3_ = $.as(this._controller.childDefineDic[($.as(this._data, $.C("mvc.module.children.ChildData"))).job + "_" + ($.as(this._data, $.C("mvc.module.children.ChildData"))).growthGrade], "Class");
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
            {
               _loc3_ = $.as(_loc2_.applicationDomain.getDefinition("ClassExport"), "Class");
               this._controller.childDefineDic[($.as(this._data, $.C("mvc.module.children.ChildData"))).job + "_" + ($.as(this._data, $.C("mvc.module.children.ChildData"))).growthGrade] = _loc3_;
            }
         }
         this.createBody();
         this._loader.unloadAndStop(false);
         this._loader = null;
      }
    createBody() {
         var _loc1_ = null;
         if(!this.data)
         {
            return;
         }
         if(this.isDie)
         {
            return;
         }
         this.clearBody();
         if($.is(this.data, $.C("mvc.module.children.ChildData")))
         {
            _loc1_ = $.as(this._controller.childDefineDic[($.as(this._data, $.C("mvc.module.children.ChildData"))).job + "_" + ($.as(this._data, $.C("mvc.module.children.ChildData"))).growthGrade], "Class");
         }
         if(_loc1_)
         {
            this._body = new _loc1_();
            this.setBodyProperty();
            this.addChild(this._body);
            if(this.data && $.is(this.data, $.C("mvc.module.children.ChildData")) && ($.as(this.data, $.C("mvc.module.children.ChildData"))).isSlaveChild)
            {
               this._body.filters = [$.C("yishi.filter.UIFilter").getDarkFilter()];
            }
         }
      }
    setBodyProperty() {
         this._body.mouseChildren = this._body.mouseEnabled = false;
         this._body.scaleX = this._body.scaleY = 0.815;
      }
    clean() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "__loadedCompleteHandler"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._body);
         this._body = null;
         this.hitArea = this._bottom;
         this.buttonMode = false;
      }
    get data() {
         return this._data;
      }
    disposeLoader() {
         if(this._loader)
         {
            this._loader.contentLoaderInfo.removeEventListener("complete",$.bind(this, "__complete"));
            this._loader.unloadAndStop(false);
            this._loader = null;
         }
      }
    clearBody() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._body);
         this._body = null;
      }
    get pos() {
         return this._pos;
      }
    dispose() {
         if(this._heroMovie && this._heroMovie.callBackComplete)
         {
            this._heroMovie.callBackComplete.removeListener($.bind(this, "heroMovieClipLoadComplete"));
         }
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "__loadedCompleteHandler"));
         this.disposeLoader();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._bottom);
         this._bottom = null;
         this.clearBody();
         this._loader = null;
         super.dispose();
         this._controller = null;
      }
    set pos(v) { super.pos = v; }
  }
  $.meta(__DreamArenaFormationItem, "dreamarena.item.DreamArenaFormationItem", []);
  return __DreamArenaFormationItem;
}
deps["dreamarena.item.DreamArenaFormationItem"] = ["com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Loader", "flash.system.ApplicationDomain", "flash.system.LoaderContext", "flash.utils.ByteArray", "mvc.module.children.ChildData", "yishi.datas.objects.HeroRoleInfo", "yishi.datas.playerinfo.ThaneInfo", "yishi.filter.UIFilter", "yishi.manager.FrameControllerManager", "yishi.manager.PathManager", "yishi.view.tools.PetFormationMovieClip"];

defs["dreamarena.item.DreamArenaGoddessRightItem"] = function define($) {
  const __Base = $.C("dreamarena.item.DreamArenaCommonRightItem");
  class __DreamArenaGoddessRightItem extends __Base {
    static $fields(self) {
    self._headBack = null;
    self._goddessIcon = null;
    self._gradeText = null;
    self._nameTxt = null;
    self._dedicationLv = null;
    self._skillHbox = null;
    self.index = 0;
    self._tempInfo = null;
    }
    constructor(param1) {
         param1 = param1;
         super();
         this.initItemView();
      }
    initItemView() {
         this._headBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaGoddessRightItem.headBack");
         this._goddessIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaGoddessRightItem.goddessIcon");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaGoddessRightItem.NameText");
         this._gradeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaGoddessRightItem.gradeText");
         this._skillHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaGoddessRightItem.skillHbox");
         this._dedicationLv = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaGoddessRightItem.dedicationLv");
         this._dedicationLv.initView("ui.goddess.dedicationLvTxt","asset.DreamArenaGoddessRightItem.dedicationFt","right");
         this.addChild(this._headBack);
         this.addChild(this._goddessIcon);
         this.addChild(this._nameTxt);
         this.addChild(this._gradeText);
         this.addChild(this._dedicationLv);
         this.addChild(this._skillHbox);
         this._heroBack.height = 85;
         this._line2.y = 78;
      }
    get tempInfo() {
         return this._tempInfo;
      }
    set tempInfo(param1) {
         this._tempInfo = param1;
         this.initSkillView();
      }
    initSkillView() {
         var _loc8_ = null;
         var _loc1_ = null;
         var _loc5_ = null;
         var _loc7_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc6_ = null;
         this._skillHbox.removeAllChild();
         var _loc2_ = [];
         if(this.tempInfo)
         {
            _loc2_ = this.tempInfo.Skill1.split(",");
            _loc8_ = $.as(this.tempInfo.typeTempInfo, $.C("yishi.datas.templates.GoddessTempInfo"));
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc2_[_loc4_]];
            _loc3_ = new ($.C("com.pickgliss.ui.core.Component"))();
            _loc7_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaGoddessRightItem.skillBack");
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaGoddessRightItem.skillIcon");
            _loc3_.addChild(_loc7_);
            _loc3_.addChild(_loc1_);
            _loc1_.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc5_.Icons);
            _loc1_.tipData = _loc5_;
            this._skillHbox.addChild(_loc3_);
            _loc4_++;
         }
         if(_loc8_)
         {
            this._goddessIcon.icon = $.C("yishi.manager.PathManager").getGoddessHeadIcon(_loc8_.Pic);
            this._nameTxt.text = _loc8_.TemplateName;
            this._gradeText.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc8_.MaxGrade);
            this._dedicationLv.setText("+" + _loc8_.MaxDevote);
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(this.tempInfo.PropertyId);
            this._goddessIcon.tipData = $.C("manager.LanguageMgr").GetTranslation("playerinfo.propContiner.tipdata",_loc6_.Attack,_loc6_.Defence,_loc6_.MagicDefence,_loc6_.Live);
         }
      }
    refreshSkillView() {
         if(this.tempInfo && this.model.selfInfo.goddessId == this.tempInfo.TemplateId)
         {
            this.refreshSelect(true);
            this._headBack.filters = [];
            this._goddessIcon.filters = [];
            this._nameTxt.filters = [];
            this._gradeText.filters = [];
            this._dedicationLv.filters = [];
            this._skillHbox.filters = [];
         }
         else
         {
            this.refreshSelect(false);
            this._headBack.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._goddessIcon.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._nameTxt.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._gradeText.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._dedicationLv.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._skillHbox.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         }
      }
    _selectBtnClickHandler(param1) {
         if(!this.tempInfo)
         {
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("managers.DreamArenaManager").instance.sendPetOrGoddessSelect(5,this.tempInfo.TemplateId);
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headBack);
         this._headBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessIcon);
         this._goddessIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeText);
         this._gradeText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dedicationLv);
         this._dedicationLv = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillHbox);
         this._skillHbox = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaGoddessRightItem, "dreamarena.item.DreamArenaGoddessRightItem", []);
  return __DreamArenaGoddessRightItem;
}
deps["dreamarena.item.DreamArenaGoddessRightItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "dreamarena.item.DreamArenaCommonRightItem", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.datas.templates.GoddessTempInfo", "yishi.filter.UIFilter", "yishi.manager.PathManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["dreamarena.item.DreamArenaHeroSkillItem"] = function define($) {
  const __Base = $.C("dreamarena.item.DreamArenaCommonRightItem");
  class __DreamArenaHeroSkillItem extends __Base {
    static $fields(self) {
    self._skillImage = null;
    self._skillHbox = null;
    self.index = 0;
    self.job = 0;
    }
    constructor(param1) {
         $.pre(new.target, (__s) => {
         __s.index = param1;
         });
         super();
         $.preFlush(this, new.target);
         this.initItemView();
      }
    initItemView() {
         this._skillImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaHeroSkillItem.skillImage");
         this._skillHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaHeroSkillItem.skillHbox");
         this.addChild(this._skillImage);
         this.addChild(this._skillHbox);
         this._skillImage.setFrame(1);
      }
    setJobType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         var _loc8_ = null;
         var _loc9_ = null;
         var _loc4_ = null;
         var _loc6_ = 0;
         this.job = param1;
         this._skillImage.setFrame(this.job + (this.index - 1) * 4);
         this._skillHbox.removeAllChild();
         var _loc7_ = $.int(this.job == 4 ? 0 : this.job);
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,_loc7_);
         var _loc3_ = [];
         if(_loc5_)
         {
            _loc3_ = _loc5_["Skill" + this.index].split(",");
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc8_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc3_[_loc6_]];
            if(_loc8_ != null)
            {
               _loc4_ = new ($.C("com.pickgliss.ui.core.Component"))();
               _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaHeroSkillItem.skillBack");
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaHeroSkillItem.skillIcon");
               _loc4_.addChild(_loc9_);
               _loc4_.addChild(_loc2_);
               _loc2_.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc8_.Icons);
               _loc2_.tipData = _loc8_;
               this._skillHbox.addChild(_loc4_);
            }
            _loc6_++;
         }
         this.refreshSelectState();
      }
    refreshSelectState() {
         if(this.model.selectJob == this.selfInfo.selfSelectJob && this.selfInfo.skillIndex1 == this.index)
         {
            this.refreshSelect(true);
            this._skillImage.filters = [];
            this._skillHbox.filters = [];
         }
         else
         {
            this.refreshSelect(false);
            this._skillImage.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._skillHbox.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         }
      }
    refreshClientSelect() {
         if(this.model.clientSelectDic[22] && this.model.clientSelectDic[22] == this.index)
         {
            this.refreshSelect(true);
            this._skillImage.filters = [];
            this._skillHbox.filters = [];
         }
         else
         {
            this.refreshSelect(false);
            this._skillImage.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._skillHbox.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         }
      }
    _selectBtnClickHandler(param1) {
         this.model.clientSelectDic.add(22,this.index);
         var _loc2_ = 22;
         $.C("yishi.utils.MsgMan").notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
    get selfInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillImage);
         this._skillImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillHbox);
         this._skillHbox = null;
         super.dispose();
      }
    set selfInfo(v) { super.selfInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaHeroSkillItem, "dreamarena.item.DreamArenaHeroSkillItem", []);
  return __DreamArenaHeroSkillItem;
}
deps["dreamarena.item.DreamArenaHeroSkillItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaCommonRightItem", "managers.DreamArenaManager", "yishi.filter.UIFilter", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.MsgMan"];

defs["dreamarena.item.DreamArenaLeftItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaLeftItem extends __Base {
    static $fields(self) {
    self._descText = null;
    self._headBack = null;
    self._headIcon = null;
    self._headBackII = null;
    self._headIconII = null;
    self._nameBack = null;
    self._itemBack = null;
    self._selectBg = null;
    self._nameImage = null;
    self._index = 0;
    self._selected = false;
    }
    constructor(param1) {
         super();
         this._index = param1;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._descText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.descText");
         this._headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaLeftItem.headIcon");
         this._headIconII = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaLeftItem.petIcon");
         this._nameBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.nameBack");
         this._itemBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.itemBack");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.selectBg");
         this._nameImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.nameImage");
         this._headBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.headBack");
         this._headBackII = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.headBackII");
         this.addChild(this._itemBack);
         this.addChild(this._nameBack);
         this.addChild(this._headBack);
         this.addChild(this._headIcon);
         this.addChild(this._headBackII);
         this.addChild(this._headIconII);
         this.addChild(this._nameImage);
         this.addChild(this._descText);
         this.addChild(this._selectBg);
         this._nameImage.setFrame(1);
         this.buttonMode = true;
         this._selectBg.visible = false;
         this._selectBg.mouseEnabled = false;
         this._nameImage.mouseEnabled = false;
      }
    get isShowHeadII() {
         if(this.index == 7 || this.index == 8 || this.index == 2)
         {
            return true;
         }
         return false;
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "__itemSelectHandler"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__itemSelectHandler"));
      }
    __itemSelectHandler(param1) {
         this.model.selectIndex = this.index;
      }
    refreshView() {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         this._selectBg.visible = this.model.selectIndex == this.index;
         var _loc1_ = $.C("dreamarena.helper.DreamArenaViewHelper").getLeftItemData(this.index,this.selectInfo);
         if(!_loc1_)
         {
            return;
         }
         this.refreshVisbleAndPos();
         this._nameImage.setFrame(_loc1_.frame);
         this._descText.text = _loc1_.content;
         this._headIcon.icon = _loc1_.icon;
         this._headIcon.tipStyle = _loc1_.tipStyle;
         this._headIcon.tipData = _loc1_.tipData;
         if(this.index == 2)
         {
            _loc2_ = this.selectInfo.getRuneTempInfoById(this.selectInfo.runeId2);
            this._headIconII.tipStyle = "yishi.view.tips.goods.RuneTips";
            this._headIconII.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc2_.Icon);
            this._headIconII.tipData = _loc2_;
         }
         else if(this.index == 7)
         {
            _loc4_ = this.selectInfo.getPetTempInfoById(this.selectInfo.mainChildPetId);
            _loc3_ = this.selectInfo.getDreamArenaById(this.selectInfo.mainChildPetId);
            this._headIconII.icon = _loc4_ ? $.C("yishi.utils.IconFactory").getPetHeadSmallIcon(_loc4_.TemplateId) : null;
            this._headIconII.tipStyle = "yishi.view.tips.DreamArenaPetTips";
            this._headIconII.tipData = _loc3_;
         }
         else if(this.index == 8)
         {
            _loc4_ = this.selectInfo.getPetTempInfoById(this.selectInfo.slaveChildPetId);
            _loc3_ = this.selectInfo.getDreamArenaById(this.selectInfo.slaveChildPetId);
            this._headIconII.icon = _loc4_ ? $.C("yishi.utils.IconFactory").getPetHeadSmallIcon(_loc4_.TemplateId) : null;
            this._headIconII.tipStyle = "yishi.view.tips.DreamArenaPetTips";
            this._headIconII.tipData = _loc3_;
         }
      }
    refreshVisbleAndPos() {
         if(this.isShowHeadII)
         {
            this._headBackII.visible = this._headIconII.visible = true;
            this._nameBack.x = 100;
            this._nameBack.y = 25;
            this._nameImage.x = 140;
            this._nameImage.y = 25;
         }
         else
         {
            this._headBackII.visible = this._headIconII.visible = false;
            this._nameBack.x = 27;
            this._nameBack.y = 16;
            this._nameImage.x = 69;
            this._nameImage.y = 18;
         }
      }
    get index() {
         return this._index;
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._descText);
         this._descText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIcon);
         this._headIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIconII);
         this._headIconII = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameBack);
         this._nameBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemBack);
         this._itemBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameImage);
         this._nameImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headBack);
         this._headBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headBackII);
         this._headBackII = null;
         super.dispose();
      }
    set isShowHeadII(v) { super.isShowHeadII = v; }
    set index(v) { super.index = v; }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaLeftItem, "dreamarena.item.DreamArenaLeftItem", []);
  return __DreamArenaLeftItem;
}
deps["dreamarena.item.DreamArenaLeftItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.helper.DreamArenaViewHelper", "managers.DreamArenaManager", "yishi.utils.IconFactory"];

defs["dreamarena.item.DreamArenaPetRightItem"] = function define($) {
  const __Base = $.C("dreamarena.item.DreamArenaCommonRightItem");
  class __DreamArenaPetRightItem extends __Base {
    static $fields(self) {
    self._skillHbox = null;
    self._headBack = null;
    self._petNameText = null;
    self._petIcon = null;
    self._hallowImage = null;
    self._hallowIcon = null;
    self._hallowBack = null;
    self.index = 0;
    self._tempInfo = null;
    }
    constructor(param1) {
         param1 = param1;
         super();
         this.initItemView();
      }
    initItemView() {
         this._headBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaPetRightItem.headBack");
         this._petNameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaPetRightItem.petNameText");
         this._petIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaPetRightItem.petIcon");
         this._hallowImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaPetRightItem.hallowImage");
         this._skillHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaPetRightItem.skillHbox");
         this._hallowIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaPetRightItem.hallowIcon");
         this._hallowBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaPetRightItem.hallowBack");
         this.addChild(this._headBack);
         this.addChild(this._petIcon);
         this.addChild(this._petNameText);
         this.addChild(this._skillHbox);
         this.addChild(this._hallowBack);
         this.addChild(this._hallowIcon);
         this.addChild(this._hallowImage);
      }
    get tempInfo() {
         return this._tempInfo;
      }
    set tempInfo(param1) {
         this._tempInfo = param1;
         this.initSkillView();
      }
    initSkillView() {
         var _loc7_ = null;
         var _loc1_ = null;
         var _loc6_ = null;
         var _loc8_ = null;
         var _loc3_ = null;
         var _loc5_ = 0;
         this._skillHbox.removeAllChild();
         var _loc2_ = [];
         if(this.tempInfo)
         {
            _loc2_ = this.tempInfo.Skill1.split(",");
            _loc7_ = $.as(this.tempInfo.typeTempInfo, $.C("yishi.datas.templates.PetTemplate"));
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc2_[_loc5_]];
            _loc3_ = new ($.C("com.pickgliss.ui.core.Component"))();
            _loc8_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaPetRightItem.skillBack");
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaPetRightItem.skillIcon");
            _loc3_.addChild(_loc8_);
            _loc3_.addChild(_loc1_);
            _loc1_.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc6_.Icons);
            _loc1_.tipData = _loc6_;
            this._skillHbox.addChild(_loc3_);
            _loc5_++;
         }
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[this.tempInfo.Skill2.split(",")[0]];
         if(_loc4_)
         {
            this._hallowIcon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc4_.Icons);
            this._hallowIcon.tipData = _loc4_;
         }
         if(_loc7_)
         {
            this._petIcon.icon = $.C("yishi.utils.IconFactory").getPetHeadSmallIcon(_loc7_.TemplateId);
            this._petIcon.tipData = this.tempInfo;
            this._petNameText.text = _loc7_.TemplateName;
         }
      }
    refreshSkillView() {
         if(this.tempInfo && this.model.selfInfo.heroPetId == this.tempInfo.TemplateId)
         {
            this.refreshSelect(true);
            this._skillHbox.filters = [];
            this._petIcon.filters = [];
            this._petNameText.filters = [];
            this._hallowImage.filters = [];
            this._headBack.filters = [];
            this._hallowIcon.filters = [];
            this._hallowBack.filters = [];
         }
         else
         {
            this.refreshSelect(false);
            this._skillHbox.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._petIcon.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._petNameText.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._hallowImage.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._headBack.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._hallowIcon.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._hallowBack.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         }
      }
    _selectBtnClickHandler(param1) {
         if(!this.tempInfo)
         {
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("managers.DreamArenaManager").instance.sendPetOrGoddessSelect(3,this.tempInfo.TemplateId);
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headBack);
         this._headBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petNameText);
         this._petNameText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petIcon);
         this._petIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hallowBack);
         this._hallowBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hallowIcon);
         this._hallowIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hallowImage);
         this._hallowImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillHbox);
         this._skillHbox = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaPetRightItem, "dreamarena.item.DreamArenaPetRightItem", []);
  return __DreamArenaPetRightItem;
}
deps["dreamarena.item.DreamArenaPetRightItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "dreamarena.item.DreamArenaCommonRightItem", "managers.DreamArenaManager", "yishi.datas.templates.PetTemplate", "yishi.filter.UIFilter", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["dreamarena.item.DreamArenaRankItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaRankItem extends __Base {
    static $fields(self) {
    self._rankText = null;
    self._nameText = null;
    self._scoreText = null;
    self._line = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._scoreText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankItem.scoreText");
         this._rankText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankItem.rankText");
         this._nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankItem.nameText");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankItem.line");
         this.addChild(this._rankText);
         this.addChild(this._nameText);
         this.addChild(this._scoreText);
         this.addChild(this._line);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         if(this.data)
         {
            this._rankText.text = this.data.rank + "";
            this._nameText.text = this.data.nickName;
            this._scoreText.text = this.data.score + "";
            this._line.visible = true;
         }
         else
         {
            this._rankText.text = "";
            this._nameText.text = "";
            this._scoreText.text = "";
            this._line.visible = false;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankText);
         this._rankText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameText);
         this._nameText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scoreText);
         this._scoreText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         super.dispose();
      }
  }
  $.meta(__DreamArenaRankItem, "dreamarena.item.DreamArenaRankItem", []);
  return __DreamArenaRankItem;
}
deps["dreamarena.item.DreamArenaRankItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils"];

defs["dreamarena.item.DreamArenaRewardItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaRewardItem extends __Base {
    static $fields(self) {
    self._titleText = null;
    self._line = null;
    self._rewardBox = null;
    self.numStr = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._titleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardItem.titleText");
         this._rewardBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardItem.rewardBox");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardItem.line");
         this.addChild(this._titleText);
         this.addChild(this._rewardBox);
         this.addChild(this._line);
      }
    setTitleText(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.numStr = param1;
         var _loc2_ = this.numStr.split(",");
         if(_loc2_.length > 1)
         {
            this._titleText.text = _loc2_[0] + "-" + _loc2_[1];
         }
         else
         {
            this._titleText.text = this.numStr;
         }
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         this._data = param1;
         if(this.data)
         {
            this._line.visible = true;
            this.data.sortOn("itemId",16);
            for (var _loc4_ of $.values(this.data))
            {
               _loc2_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
               _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.BaseItemView");
               _loc2_.templateId = _loc4_.itemId;
               _loc2_.count = _loc4_.count;
               _loc3_.data = _loc2_;
               this._rewardBox.addChild(_loc3_);
            }
         }
      }
    clean() {
         this._titleText.text = "";
         this._rewardBox.removeAllChild();
         this._line.visible = false;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleText);
         this._titleText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardBox);
         this._rewardBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         super.dispose();
      }
  }
  $.meta(__DreamArenaRewardItem, "dreamarena.item.DreamArenaRewardItem", []);
  return __DreamArenaRewardItem;
}
deps["dreamarena.item.DreamArenaRewardItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "yishi.datas.goods.GoodsInfo"];

defs["dreamarena.item.DreamArenaTalismanSelectItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaTalismanSelectItem extends __Base {
    static $fields(self) {
    self._icon = null;
    self._selectBg = null;
    self._selectBtn = null;
    self.btnSelectView = null;
    self.index = 0;
    self._data = null;
    }
    constructor(param1) {
         super();
         this.index = param1;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaTalismanSelectItem.icon");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBg");
         this._selectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBtn");
         this.addChild(this._icon);
         this.addChild(this._selectBg);
         this.addChild(this._selectBtn);
         this._selectBg.mouseEnabled = false;
      }
    addEvent() {
         this._selectBtn.addEventListener("click",$.bind(this, "_selectBtnClickHandler"));
      }
    removeEvent() {
         if(this._selectBtn)
         {
            this._selectBtn.removeEventListener("click",$.bind(this, "_selectBtnClickHandler"));
         }
      }
    _selectBtnClickHandler(param1) {
         var _loc2_ = null;
         if(!this.data)
         {
            return;
         }
         if(!this.btnSelectView)
         {
            this.btnSelectView = new ($.C("dreamarena.view.DreamArenaTalismanSelectView"))();
            this.btnSelectView.show(this.data);
            this.btnSelectView.addEventListener("dispose",$.bind(this, "__disposeSelectView"));
            _loc2_ = new ($.C("flash.geom.Point"))(this._selectBtn.displayWidth / 2,0);
            _loc2_ = this._selectBtn.localToGlobal(_loc2_);
            this.btnSelectView.x = _loc2_.x - 30;
            this.btnSelectView.y = _loc2_.y + 25;
         }
      }
    __disposeSelectView(param1) {
         if(this.btnSelectView)
         {
            this.btnSelectView.removeEventListener("dispose",$.bind(this, "__disposeSelectView"));
         }
         this.btnSelectView = null;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc2_ = 0;
         var _loc3_ = false;
         this._data = param1;
         if(this.data)
         {
            this._icon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(this.data.TypeTemplateId);
            this._icon.tipData = this.data;
            _loc2_ = $.int(this.selectInfo.talismanSkillsAry.indexOf(this.data.TemplateId));
            _loc3_ = this.selectInfo.selfSelectJob == 4 && _loc2_ != -1;
            this._selectBg.visible = _loc3_;
            if(_loc3_)
            {
               if(this.selectInfo.talismanSkillsAry[_loc2_ + 1] == 1)
               {
                  this._selectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.towSkill");
               }
               else if(this.selectInfo.talismanSkillsAry[_loc2_ + 1] == 2)
               {
                  this._selectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.fourSkill");
               }
            }
            else
            {
               this._selectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.selectText");
            }
         }
         else
         {
            this._icon.icon = null;
            this._icon.tipData = null;
            this._selectBg.visible = false;
         }
      }
    refreshClientSelect() {
         var _loc3_ = false;
         var _loc1_ = null;
         var _loc2_ = 0;
         if(!this.data)
         {
            return;
         }
         if(!this.model.clientSelectDic[24])
         {
            _loc3_ = false;
         }
         else
         {
            _loc1_ = $.as(this.model.clientSelectDic[24], "Array");
            _loc2_ = _loc1_.indexOf(this.data.TemplateId);
            _loc3_ = this.model.selectJob == 4 && _loc2_ != -1;
         }
         this._selectBg.visible = _loc3_;
         if(_loc3_)
         {
            if(_loc1_[_loc2_ + 1] == 1)
            {
               this._selectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.towSkill");
            }
            else if(_loc1_[_loc2_ + 1] == 2)
            {
               this._selectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.fourSkill");
            }
         }
         else
         {
            this._selectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.selectText");
         }
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBtn);
         this._selectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.btnSelectView);
         this.btnSelectView = null;
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaTalismanSelectItem, "dreamarena.item.DreamArenaTalismanSelectItem", []);
  return __DreamArenaTalismanSelectItem;
}
deps["dreamarena.item.DreamArenaTalismanSelectItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.view.DreamArenaTalismanSelectView", "flash.geom.Point", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.utils.IconFactory"];

defs["dreamarena.item.DreamArenaTitanSkillItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaTitanSkillItem extends __Base {
    static $fields(self) {
    self._skillBg = null;
    self._orderBg = null;
    self._icon = null;
    self._orderNum = null;
    self._equipedImage = null;
    self.canDrop = true;
    self._data = null;
    self.index = 0;
    self.type = 0;
    }
    constructor(param1, param2) {
         super();
         this.type = param1;
         this.index = param2;
         this.initView();
         this.initEvent();
      }
    initView() {
         this._skillBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTitanSkillItem.skillBg");
         this._orderBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTitanSkillItem.orderBg");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaTitanSkillItem.skillIcon");
         this._orderNum = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTitanSkillItem.orderNum");
         this._equipedImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTitanSkillItem.equipedImage");
         this.addChild(this._skillBg);
         this.addChild(this._icon);
         this.addChild(this._orderBg);
         this.addChild(this._orderNum);
         this.addChild(this._equipedImage);
         if(this.type == 1)
         {
            this._orderNum.text = this.index + 1 + "";
            this._orderNum.x = this.index + 1 >= 10 ? -6 : -2;
            this._equipedImage.visible = false;
         }
         else
         {
            this._orderNum.text = "";
            this._orderBg.visible = false;
            this._equipedImage.visible = false;
         }
      }
    initEvent() {
         this.addEventListener("mouseDown",$.bind(this, "__clickHandler"));
      }
    removeEvent() {
         this.removeEventListener("mouseDown",$.bind(this, "__clickHandler"));
      }
    set data(param1) {
         this._data = param1;
         if(this.data)
         {
            this._icon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(this._data.Icons);
            this._icon.tipData = this._data;
            this._equipedImage.visible = this.type == 2 && this.selectInfo.titanSkillAry.indexOf(this.data.TemplateId + "") != -1;
         }
         else
         {
            this._icon.icon = null;
            this._icon.tipData = null;
            this._equipedImage.visible = false;
         }
         this.canDrop = !this._equipedImage.visible;
      }
    refreshClientSelect() {
         var _loc2_ = false;
         var _loc1_ = null;
         if(!this.data)
         {
            return;
         }
         if(!this.model.clientSelectDic[21])
         {
            _loc2_ = false;
         }
         else
         {
            _loc1_ = $.as(this.model.clientSelectDic[21], "Array");
            _loc2_ = _loc1_.indexOf(this.data.TemplateId) != -1;
         }
         this._equipedImage.visible = this.type == 2 && _loc2_;
         this.canDrop = !this._equipedImage.visible;
      }
    get data() {
         return this._data;
      }
    __clickHandler(param1) {
         if(!this._data || !this.canDrop)
         {
            return;
         }
         var _loc3_ = this.getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_ = $.C("yishi.manager.DragManager").getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = $.bind(this, "onDragStop");
         _loc2_.dropChecks = [__DreamArenaTitanSkillItem,$.C("flash.display.Stage")];
      }
    getDragIconObj() {
         var _loc1_ = new ($.C("flash.display.BitmapData"))(this._icon.iconWidth / this._icon.scaleX,this._icon.iconHeight / this._icon.scaleY,true,0);
         _loc1_.draw(this._icon);
         return new ($.C("flash.display.Bitmap"))(_loc1_);
      }
    onDragStop(param1) {
         var _loc2_ = null;
         if(param1.dropTarget != this)
         {
            param1.stopImmediatePropagation();
            if(this.type == 1)
            {
               if($.is(param1.dropTarget, __DreamArenaTitanSkillItem))
               {
                  _loc2_ = $.as(param1.dropTarget, __DreamArenaTitanSkillItem);
                  if(_loc2_.type == 1)
                  {
                     $.C("yishi.utils.MsgMan").notifyObserver("TITAN_SET_SKILL",{
                        "dragItem":this,
                        "dropItem":_loc2_
                     });
                  }
                  else
                  {
                     this.data = null;
                  }
               }
               else
               {
                  this.data = null;
               }
            }
            else if($.is(param1.dropTarget, __DreamArenaTitanSkillItem))
            {
               _loc2_ = $.as(param1.dropTarget, __DreamArenaTitanSkillItem);
               if(_loc2_.type == 1)
               {
                  _loc2_.data = this.data;
               }
            }
            $.C("yishi.utils.MsgMan").notifyObserver("TITAN_CLIENT_SKILL_UPDATE");
         }
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         if(this._skillBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillBg);
         }
         this._skillBg = null;
         if(this._orderBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._orderBg);
         }
         this._orderBg = null;
         if(this._icon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         }
         this._icon = null;
         if(this._orderNum)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._orderNum);
         }
         this._orderNum = null;
         if(this._orderNum)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._equipedImage);
         }
         this._equipedImage = null;
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaTitanSkillItem, "dreamarena.item.DreamArenaTitanSkillItem", []);
  return __DreamArenaTitanSkillItem;
}
deps["dreamarena.item.DreamArenaTitanSkillItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.BitmapData", "flash.display.Stage", "managers.DreamArenaManager", "yishi.manager.DragManager", "yishi.utils.IconFactory", "yishi.utils.MsgMan"];

defs["dreamarena.view.DreamArenaArtifactView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaArtifactView extends __Base {
    static $fields(self) {
    self._back = null;
    self._artifactCon = null;
    self._armoryHbox = null;
    self._saveBtn = null;
    self.artifactList = null;
    self.armoryList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
         this.addEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaArtifactView.back");
         this._artifactCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaArtifactView.artifactCon");
         this._armoryHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaArtifactView.armoryHbox");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaArtifactView.saveBtn");
         this.addChild(this._back);
         this.addChild(this._artifactCon);
         this.addChild(this._armoryHbox);
         this.addChild(this._saveBtn);
      }
    initListView() {
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(6);
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(7);
         this.artifactList = new $.Vector();
         this.armoryList = new $.Vector();
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = new ($.C("dreamarena.item.DreamArenaCommonSelectItemII"))(1,_loc4_ + 1);
            _loc5_.data = _loc1_[_loc4_];
            this._artifactCon.appendItem(_loc5_);
            this.artifactList.push(_loc5_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = new ($.C("dreamarena.item.DreamArenaCommonSelectItem"))(1,_loc4_ + 1);
            _loc3_.data = _loc2_[_loc4_];
            this._armoryHbox.addChild(_loc3_);
            this.armoryList.push(_loc3_);
            _loc4_++;
         }
         this.refreshSaveBtn();
      }
    addEvent() {
         this._saveBtn.addEventListener("click",$.bind(this, "__saveArtifactHandler"));
         $.C("yishi.utils.MsgMan").addObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    removeEvent() {
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveArtifactHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    __saveArtifactHandler(param1) {
         var _loc3_ = $.int(this.model.selfInfo.artifactId);
         var _loc2_ = this.model.selfInfo.armoryId1 + "," + this.model.selfInfo.armoryId2 + "," + this.model.selfInfo.armoryId3;
         if(this.model.clientSelectDic[6])
         {
            _loc3_ = $.int(this.model.clientSelectDic[6]);
         }
         if(this.model.clientSelectDic[7])
         {
            _loc2_ = ($.as(this.model.clientSelectDic[7], "Array")).join(",");
         }
         if(_loc2_.split(",").length < 3)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaArtifactView.armoryCount.noEnough"));
            return;
         }
         $.C("managers.DreamArenaManager").instance.sendArtifactSelect(_loc3_,_loc2_);
      }
    __updateClientSelectHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc6_ = null;
         var _loc4_ = 0;
         var _loc3_ = null;
         var _loc5_ = $.as(param2, "int");
         if(_loc5_ == 6)
         {
            _loc4_ = 0;
            while(_loc4_ < this.artifactList.length)
            {
               _loc6_ = this.artifactList[_loc4_];
               _loc6_.refreshClientSelect();
               _loc4_++;
            }
         }
         else if(_loc5_ == 7)
         {
            _loc4_ = 0;
            while(_loc4_ < this.armoryList.length)
            {
               _loc3_ = this.armoryList[_loc4_];
               _loc3_.refreshClientSelect();
               _loc4_++;
            }
         }
         this.refreshSaveBtn();
      }
    refreshView() {
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(6);
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(7);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = this.artifactList[_loc4_];
            _loc5_.data = _loc1_[_loc4_];
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = this.armoryList[_loc4_];
            _loc3_.data = _loc2_[_loc4_];
            _loc4_++;
         }
         this.refreshSaveBtn();
      }
    refreshSaveBtn() {
         this._saveBtn.enable = this.model.getArtifactChange();
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._artifactCon);
         this._artifactCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._armoryHbox);
         this._armoryHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         this._saveBtn = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.armoryList);
         this.armoryList = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.artifactList);
         this.artifactList = null;
         this.model.clientSelectDic.del(6);
         this.model.clientSelectDic.del(7);
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaArtifactView, "dreamarena.view.DreamArenaArtifactView", []);
  return __DreamArenaArtifactView;
}
deps["dreamarena.view.DreamArenaArtifactView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaCommonSelectItem", "dreamarena.item.DreamArenaCommonSelectItemII", "manager.LanguageMgr", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.manager.TempleteManager", "yishi.utils.MsgMan", "yishi.view.tips.MessageTipManager"];

defs["dreamarena.view.DreamArenaChildSkillView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaChildSkillView extends __Base {
    static $fields(self) {
    self._back = null;
    self._itemList = null;
    self.col = 5;
    self.showCount = 10;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildSkillView.back");
         this._itemList = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaChildSkillView.TileContainer");
         this.addChild(this._back);
         this.addChild(this._itemList);
         this._back.mouseChildren = this._back.mouseEnabled = false;
      }
    show(param1) {
         var _loc2_ = 0;
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         _loc4_ = 0;
         while(_loc4_ < this.showCount)
         {
            _loc2_ = $.int(param1[_loc4_] ? param1[_loc4_] : 0);
            _loc5_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc2_];
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaChildSkillView.skillIcon");
            if(_loc5_)
            {
               _loc3_.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc5_.Icons);
               _loc3_.tipData = _loc5_;
            }
            this._itemList.appendItem(_loc3_);
            _loc4_++;
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,7);
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemList);
         this._itemList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
  }
  $.meta(__DreamArenaChildSkillView, "dreamarena.view.DreamArenaChildSkillView", []);
  return __DreamArenaChildSkillView;
}
deps["dreamarena.view.DreamArenaChildSkillView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["dreamarena.view.DreamArenaDragonTalkerView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaDragonTalkerView extends __Base {
    static $fields(self) {
    self._headHbox = null;
    self._selectBg = null;
    self.headList = null;
    self._saveBtn = null;
    self._talismanView = null;
    self._proficiencyView = null;
    self._skillBar1 = null;
    self._skillBar2 = null;
    self._skillImage = null;
    self._chooseTitleTxt = null;
    }
    constructor() {
         super();
         this.initView();
         this.initHeadView();
         this.addEvent();
      }
    initView() {
         this._talismanView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaDragonTalkerView.talismanView");
         this._proficiencyView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaDragonTalkerView.proficiencyView");
         this._skillBar1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dreamarena.item.DreamAreaDragonSkillBar1",[1]);
         this._skillBar2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dreamarena.item.DreamAreaDragonSkillBar2",[2]);
         this._headHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaDragonTalkerView.headHbox");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaDragonTalkerView.selectBg2");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaHeroView.saveBtn");
         this._skillImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.dragonskillScaleImg");
         this._chooseTitleTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.dreamarea.chooseSkTitle");
         this.addChild(this._headHbox);
         this.addChild(this._selectBg);
         this.addChild(this._talismanView);
         this.addChild(this._proficiencyView);
         this.addChild(this._skillImage);
         this.addChild(this._skillBar1);
         this.addChild(this._skillBar2);
         this.addChild(this._saveBtn);
         this.addChild(this._chooseTitleTxt);
         this._chooseTitleTxt.text = $.C("manager.LanguageMgr").GetTranslation("dreamarea.skill.chooseTip");
         this._selectBg.mouseEnabled = false;
      }
    initHeadView() {
         var _loc1_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc6_ = null;
         var _loc5_ = 0;
         var _loc2_ = 0;
         this.headList = new $.Vector();
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            _loc4_ = new ($.C("com.pickgliss.ui.core.Component"))();
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaHeroView.heroBack");
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaHeroView.headIcon");
            _loc1_.addEventListener("click",$.bind(this, "__headSelectHandler"));
            _loc2_ = $.int(this.playerInfo.sexs == 0 ? _loc5_ + 3 : _loc5_);
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.gameHeroTemplateCate.getTemplateByID(_loc2_);
            if(_loc5_ == 4)
            {
               _loc1_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics($.C("dreamarena.helper.DreamArenaViewHelper").getDragonTalkerIcon());
            }
            else
            {
               _loc1_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics(_loc6_.Icon);
            }
            _loc4_.addChild(_loc3_);
            _loc4_.addChild(_loc1_);
            this._headHbox.addChild(_loc4_);
            this.headList.push(_loc1_);
            _loc1_.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.datas.consant.JobType.JobName" + _loc5_);
            _loc5_++;
         }
      }
    addEvent() {
         this._saveBtn.addEventListener("click",$.bind(this, "__saveHeroHandler"));
         $.C("yishi.utils.MsgMan").addObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    removeEvent() {
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveHeroHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    __saveHeroHandler(param1) {
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,0);
         var _loc2_ = $.int(_loc4_.TemplateId);
         var _loc8_ = $.int(this.selectInfo.selfSelectJob == 4 ? this.selectInfo.skillIndex1 : 0);
         var _loc9_ = $.int(this.selectInfo.selfSelectJob == 4 ? this.selectInfo.skillIndex2 : 0);
         var _loc6_ = this.selectInfo.selfSelectJob == 4 ? this.selectInfo.talismanSkillsAry.join(",") : "";
         if(this.model.clientSelectDic[23])
         {
            _loc9_ = $.int(this.model.clientSelectDic[23]);
         }
         if(this.model.clientSelectDic[24])
         {
            _loc6_ = this.model.clientSelectDic[24];
         }
         if(_loc9_ <= 0)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaArtifactView.profiency.noSelectAlert"));
            return;
         }
         if(_loc6_.split(",").length < 4)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaArtifactView.talismanCount.noEnough"));
            return;
         }
         var _loc3_ = this._skillBar1.selectIds;
         var _loc7_ = this._skillBar2.selectIds;
         var _loc5_ = _loc3_ + "|" + _loc7_;
         $.C("managers.DreamArenaManager").instance.sendDragonTalkerSelect(_loc2_,_loc8_,_loc9_,_loc6_,_loc5_);
      }
    __updateClientSelectHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = $.as(param2, "int");
         if(_loc3_ == 22)
         {
            this._skillBar1.refreshClientSelect();
            this._skillBar2.refreshClientSelect();
         }
         else if(_loc3_ == 23)
         {
            if(this._proficiencyView)
            {
               this._proficiencyView.refreshClientSelect();
            }
         }
         else if(_loc3_ == 24)
         {
            if(this._talismanView)
            {
               this._talismanView.refreshClientSelect();
            }
         }
         this.refreshSaveBtn();
      }
    refreshView() {
         this._selectBg.x = this._headHbox.x + (this.model.selectJob - 1) * 71 - 10;
         this._skillBar1.setJobType(this.model.selectJob);
         this._skillBar2.setJobType(this.model.selectJob);
         if(this._proficiencyView)
         {
            this._proficiencyView.refreshView();
         }
         if(this._talismanView)
         {
            this._talismanView.refreshView();
         }
         this.refreshSaveBtn();
      }
    __headSelectHandler(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("yishi.view.community.BaseIconView"));
         var _loc3_ = this.headList.indexOf(_loc2_);
         if(_loc3_ == -1)
         {
            return;
         }
         this.model.selectJob = _loc3_ + 1;
      }
    refreshSaveBtn() {
         var _loc1_ = Boolean(this.model.getHeroChange());
         this._saveBtn.enable = _loc1_;
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    removeHeadEvent(param1) {
         param1.removeEventListener("click",$.bind(this, "__headSelectHandler"));
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headHbox);
         this._headHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._talismanView);
         this._talismanView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._proficiencyView);
         this._proficiencyView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillBar1);
         this._skillBar1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillBar2);
         this._skillBar2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         this._saveBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chooseTitleTxt);
         this._chooseTitleTxt = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.headList,$.bind(this, "removeHeadEvent"));
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaDragonTalkerView, "dreamarena.view.DreamArenaDragonTalkerView", []);
  return __DreamArenaDragonTalkerView;
}
deps["dreamarena.view.DreamArenaDragonTalkerView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.helper.DreamArenaViewHelper", "manager.LanguageMgr", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.MsgMan", "yishi.view.community.BaseIconView", "yishi.view.tips.MessageTipManager"];

defs["dreamarena.view.DreamArenaGoddessView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaGoddessView extends __Base {
    static $fields(self) {
    self._goddessVbox = null;
    self.goddessList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
      }
    initView() {
         this._goddessVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaGoddessView.goddessVbox");
         this.addChild(this._goddessVbox);
      }
    initListView() {
         var _loc1_ = null;
         var _loc2_ = 0;
         this.goddessList = new $.Vector();
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(5);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = new ($.C("dreamarena.item.DreamArenaGoddessRightItem"))(_loc2_ + 1);
            _loc1_.tempInfo = _loc3_[_loc2_];
            _loc1_.refreshSkillView();
            this._goddessVbox.addChild(_loc1_);
            this.goddessList.push(_loc1_);
            _loc2_++;
         }
      }
    refreshView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < this.goddessList.length)
         {
            _loc1_ = $.as(this.goddessList[_loc2_], $.C("dreamarena.item.DreamArenaGoddessRightItem"));
            _loc1_.refreshSkillView();
            _loc2_++;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessVbox);
         this._goddessVbox = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.goddessList);
         this.goddessList = null;
         super.dispose();
      }
  }
  $.meta(__DreamArenaGoddessView, "dreamarena.view.DreamArenaGoddessView", []);
  return __DreamArenaGoddessView;
}
deps["dreamarena.view.DreamArenaGoddessView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaGoddessRightItem", "utils.LogicUtils", "yishi.manager.TempleteManager"];

defs["dreamarena.view.DreamArenaHeroView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaHeroView extends __Base {
    static $fields(self) {
    self._headHbox = null;
    self._selectBg = null;
    self._skillItem1 = null;
    self._skillItem2 = null;
    self.headList = null;
    self._saveBtn = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
         this.addEvent();
      }
    initView() {
         this._skillItem1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaHeroView.skillItem1",[1]);
         this._skillItem2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaHeroView.skillItem2",[2]);
         this._headHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaHeroView.headHbox");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaHeroView.selectBg2");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaHeroView.saveBtn");
         this.addChild(this._headHbox);
         this.addChild(this._selectBg);
         this.addChild(this._skillItem1);
         this.addChild(this._skillItem2);
         this.addChild(this._saveBtn);
         this._selectBg.mouseEnabled = false;
      }
    initListView() {
         var _loc1_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc6_ = null;
         var _loc5_ = 0;
         var _loc2_ = 0;
         this.headList = new $.Vector();
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            _loc4_ = new ($.C("com.pickgliss.ui.core.Component"))();
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DreamArenaHeroView.heroBack");
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArena.DreamArenaHeroView.headIcon");
            _loc1_.addEventListener("click",$.bind(this, "__headSelectHandler"));
            _loc2_ = $.int(this.playerInfo.sexs == 0 ? _loc5_ + 3 : _loc5_);
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.gameHeroTemplateCate.getTemplateByID(_loc2_);
            if(_loc5_ == 4)
            {
               _loc1_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics($.C("dreamarena.helper.DreamArenaViewHelper").getDragonTalkerIcon());
            }
            else
            {
               _loc1_.icon = $.C("yishi.utils.IconFactory").getHeroIconByPics(_loc6_.Icon);
            }
            _loc4_.addChild(_loc3_);
            _loc4_.addChild(_loc1_);
            this._headHbox.addChild(_loc4_);
            this.headList.push(_loc1_);
            _loc1_.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.datas.consant.JobType.JobName" + _loc5_);
            _loc5_++;
         }
      }
    addEvent() {
         this._saveBtn.addEventListener("click",$.bind(this, "__saveHeroHandler"));
         $.C("yishi.utils.MsgMan").addObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    removeEvent() {
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveHeroHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    __saveHeroHandler(param1) {
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,this.model.selectJob);
         var _loc2_ = $.int(_loc3_.TemplateId);
         var _loc4_ = $.int(this.model.selectJob == this.selectInfo.selfSelectJob ? this.selectInfo.skillIndex1 : 0);
         if(this.model.clientSelectDic[22])
         {
            _loc4_ = $.int(this.model.clientSelectDic[22]);
         }
         if(_loc4_ <= 0)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaArtifactView.skill.noSelectAlert"));
            return;
         }
         $.C("managers.DreamArenaManager").instance.sendHeroSelect(_loc2_,_loc4_);
      }
    __updateClientSelectHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = $.as(param2, "int");
         if(_loc3_ == 22)
         {
            this._skillItem1.refreshClientSelect();
            this._skillItem2.refreshClientSelect();
         }
         this.refreshSaveBtn();
      }
    refreshView() {
         this._selectBg.x = this._headHbox.x + (this.model.selectJob - 1) * 71 - 10;
         this._skillItem1.setJobType(this.model.selectJob);
         this._skillItem2.setJobType(this.model.selectJob);
         this.refreshSaveBtn();
      }
    __headSelectHandler(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("yishi.view.community.BaseIconView"));
         var _loc3_ = this.headList.indexOf(_loc2_);
         if(_loc3_ == -1)
         {
            return;
         }
         this.model.selectJob = _loc3_ + 1;
      }
    refreshSaveBtn() {
         this._saveBtn.enable = this.model.getHeroChange();
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    removeHeadEvent(param1) {
         param1.removeEventListener("click",$.bind(this, "__headSelectHandler"));
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headHbox);
         this._headHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillItem2);
         this._skillItem2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillItem1);
         this._skillItem1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         this._saveBtn = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.headList,$.bind(this, "removeHeadEvent"));
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaHeroView, "dreamarena.view.DreamArenaHeroView", []);
  return __DreamArenaHeroView;
}
deps["dreamarena.view.DreamArenaHeroView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.helper.DreamArenaViewHelper", "manager.LanguageMgr", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.MsgMan", "yishi.view.community.BaseIconView", "yishi.view.tips.MessageTipManager"];

defs["dreamarena.view.DreamArenaMainChildView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaMainChildView extends __Base {
    static $fields(self) {
    self._back = null;
    self._titleImage = null;
    self._childCon = null;
    self._petHbox = null;
    self._saveBtn = null;
    self.childList = null;
    self.petList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
         this.addEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.back");
         this._titleImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.titleImage");
         this._childCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaMainChildView.childCon");
         this._petHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.petHbox");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.saveBtn");
         this.addChild(this._back);
         this.addChild(this._titleImage);
         this.addChild(this._childCon);
         this.addChild(this._petHbox);
         this.addChild(this._saveBtn);
      }
    initListView() {
         var _loc1_ = null;
         var _loc4_ = null;
         var _loc3_ = 0;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(3);
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(2);
         this.childList = new $.Vector();
         this.petList = new $.Vector();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new ($.C("dreamarena.item.DreamArenaChildSelectItem"))(1,_loc3_ + 1);
            _loc1_.data = _loc2_[_loc3_];
            this._childCon.appendItem(_loc1_);
            this.childList.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc4_ = new ($.C("dreamarena.item.DreamArenaCommonSelectItemII"))(2,_loc3_ + 1);
            _loc4_.data = _loc5_[_loc3_];
            this._petHbox.addChild(_loc4_);
            this.petList.push(_loc4_);
            _loc3_++;
         }
         this.refreshSaveBtn();
      }
    addEvent() {
         this._saveBtn.addEventListener("click",$.bind(this, "__saveChildHandler"));
         $.C("yishi.utils.MsgMan").addObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    removeEvent() {
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveChildHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    __saveChildHandler(param1) {
         var _loc3_ = $.int(this.model.selfInfo.mainChildId);
         var _loc2_ = $.int(this.model.selfInfo.mainChildPetId);
         if(this.model.clientSelectDic[3])
         {
            _loc3_ = $.int(this.model.clientSelectDic[3]);
         }
         if(this.model.clientSelectDic[32])
         {
            _loc2_ = $.int(this.model.clientSelectDic[32]);
         }
         $.C("managers.DreamArenaManager").instance.sendChildSelect(7,_loc3_,_loc2_);
      }
    __updateClientSelectHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc6_ = $.as(param2, "int");
         if(_loc6_ == 3)
         {
            _loc4_ = 0;
            while(_loc4_ < this.childList.length)
            {
               _loc3_ = this.childList[_loc4_];
               _loc3_.refreshClientSelect();
               _loc4_++;
            }
         }
         else if(_loc6_ == 32)
         {
            _loc4_ = 0;
            while(_loc4_ < this.petList.length)
            {
               _loc5_ = this.petList[_loc4_];
               _loc5_.refreshClientSelect();
               _loc4_++;
            }
         }
         this.refreshSaveBtn();
      }
    refreshView() {
         var _loc1_ = null;
         var _loc4_ = null;
         var _loc3_ = 0;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(3);
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(2);
         _loc3_ = 0;
         while(_loc3_ < this.childList.length)
         {
            _loc1_ = this.childList[_loc3_];
            _loc1_.data = _loc2_[_loc3_];
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc4_ = this.petList[_loc3_];
            _loc4_.data = _loc5_[_loc3_];
            _loc3_++;
         }
         this.refreshSaveBtn();
      }
    refreshSaveBtn() {
         this._saveBtn.enable = this.model.getMainChildChange();
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleImage);
         this._titleImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childCon);
         this._childCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petHbox);
         this._petHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         this._saveBtn = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.childList);
         this.childList = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.petList);
         this.petList = null;
         this.model.clientSelectDic.del(3);
         this.model.clientSelectDic.del(32);
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaMainChildView, "dreamarena.view.DreamArenaMainChildView", []);
  return __DreamArenaMainChildView;
}
deps["dreamarena.view.DreamArenaMainChildView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaChildSelectItem", "dreamarena.item.DreamArenaCommonSelectItemII", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.manager.TempleteManager", "yishi.utils.MsgMan"];

defs["dreamarena.view.DreamArenaPetView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaPetView extends __Base {
    static $fields(self) {
    self._petVbox = null;
    self.petList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
      }
    initView() {
         this._petVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaPetView.petVbox");
         this.addChild(this._petVbox);
      }
    initListView() {
         var _loc2_ = null;
         var _loc1_ = 0;
         this.petList = new $.Vector();
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(2);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_ = new ($.C("dreamarena.item.DreamArenaPetRightItem"))(_loc1_ + 1);
            _loc2_.tempInfo = _loc3_[_loc1_];
            _loc2_.refreshSkillView();
            this._petVbox.addChild(_loc2_);
            this.petList.push(_loc2_);
            _loc1_++;
         }
      }
    refreshView() {
         var _loc1_ = 0;
         var _loc2_ = null;
         _loc1_ = 0;
         while(_loc1_ < this.petList.length)
         {
            _loc2_ = $.as(this.petList[_loc1_], $.C("dreamarena.item.DreamArenaPetRightItem"));
            _loc2_.refreshSkillView();
            _loc1_++;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petVbox);
         this._petVbox = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.petList);
         this.petList = null;
         super.dispose();
      }
  }
  $.meta(__DreamArenaPetView, "dreamarena.view.DreamArenaPetView", []);
  return __DreamArenaPetView;
}
deps["dreamarena.view.DreamArenaPetView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaPetRightItem", "utils.LogicUtils", "yishi.manager.TempleteManager"];

defs["dreamarena.view.DreamArenaProficiencyView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaProficiencyView extends __Base {
    static $fields(self) {
    self._title = null;
    self._back = null;
    self._line = null;
    self._proficiencyHbox = null;
    self.proficiencyList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
      }
    initView() {
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaProficiencyView.title");
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaProficiencyView.back");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaProficiencyView.line");
         this._proficiencyHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTalismanView.proficiencyHbox");
         this.addChild(this._back);
         this.addChild(this._line);
         this.addChild(this._title);
         this.addChild(this._proficiencyHbox);
      }
    initListView() {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc3_ = 0;
         this.proficiencyList = new $.Vector();
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,0);
         var _loc4_ = _loc1_.Skill3.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc5_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc4_[_loc3_]];
            _loc2_ = new ($.C("dreamarena.item.DreamArenaCommonSelectItem"))(2,_loc3_ + 1);
            _loc2_.data = _loc5_;
            this._proficiencyHbox.addChild(_loc2_);
            this.proficiencyList.push(_loc2_);
            _loc3_++;
         }
      }
    refreshView() {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc3_ = 0;
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,0);
         var _loc4_ = _loc1_.Skill3.split(",");
         _loc3_ = 0;
         while(_loc3_ < this.proficiencyList.length)
         {
            _loc5_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc4_[_loc3_]];
            _loc2_ = this.proficiencyList[_loc3_];
            _loc2_.data = _loc5_;
            _loc3_++;
         }
      }
    refreshClientSelect() {
         var _loc1_ = null;
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this.proficiencyList.length)
         {
            _loc1_ = this.proficiencyList[_loc2_];
            _loc1_.refreshClientSelect();
            _loc2_++;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         this._title = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._proficiencyHbox);
         this._proficiencyHbox = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.proficiencyList);
         this.proficiencyList = null;
         super.dispose();
      }
  }
  $.meta(__DreamArenaProficiencyView, "dreamarena.view.DreamArenaProficiencyView", []);
  return __DreamArenaProficiencyView;
}
deps["dreamarena.view.DreamArenaProficiencyView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaCommonSelectItem", "utils.LogicUtils", "yishi.manager.TempleteManager"];

defs["dreamarena.view.DreamArenaRankView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaRankView extends __Base {
    static $fields(self) {
    self._titleBack = null;
    self._rankText = null;
    self._nameText = null;
    self._scoreText = null;
    self._itemBox = null;
    self._scrollPanel = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._titleBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankView.titleBack");
         this._rankText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankView.rankText");
         this._nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankView.nameText");
         this._scoreText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankView.scoreText");
         this._itemBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankView.itemBox");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRankView.scrollPanel");
         this.addChild(this._titleBack);
         this.addChild(this._rankText);
         this.addChild(this._nameText);
         this.addChild(this._scoreText);
         this.addChild(this._scrollPanel);
         this._scrollPanel.setView(this._itemBox);
         this._rankText.text = $.C("manager.LanguageMgr").GetTranslation("colosseum.view.HeroRankFrame.rank");
         this._nameText.text = $.C("manager.LanguageMgr").GetTranslation("outyard.OutyardMemberFrame.sortText2");
         this._scoreText.text = $.C("manager.LanguageMgr").GetTranslation("apexroom.rightView.str3");
      }
    refreshListView() {
         var _loc3_ = 0;
         var _loc1_ = null;
         this._itemBox.removeAllChild();
         var _loc2_ = $.int(this.model.rankList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new ($.C("dreamarena.item.DreamArenaRankItem"))();
            _loc1_.data = this.model.rankList[_loc3_];
            this._itemBox.addChild(_loc1_);
            _loc3_++;
         }
         this._scrollPanel.beginChanges();
         this._scrollPanel.invalidateViewport();
         this._scrollPanel.commitChanges();
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleBack);
         this._titleBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankText);
         this._rankText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameText);
         this._nameText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scoreText);
         this._scoreText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrollPanel);
         this._scrollPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemBox);
         this._itemBox = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaRankView, "dreamarena.view.DreamArenaRankView", []);
  return __DreamArenaRankView;
}
deps["dreamarena.view.DreamArenaRankView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaRankItem", "manager.LanguageMgr", "managers.DreamArenaManager"];

defs["dreamarena.view.DreamArenaRewardView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaRewardView extends __Base {
    static $fields(self) {
    self._titleComponent = null;
    self._titleBack = null;
    self._rankText = null;
    self._rewardText = null;
    self._itemBox = null;
    self._scrollPanel = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._titleComponent = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardView.titleComponent");
         this._titleBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardView.titleBack");
         this._rankText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardView.rankText");
         this._rewardText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardView.rewardText");
         this._itemBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardView.itemBox");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRewardView.scrollPanel");
         this.addChild(this._titleComponent);
         this.addChild(this._scrollPanel);
         this._scrollPanel.setView(this._itemBox);
         this._titleComponent.addChild(this._titleBack);
         this._titleComponent.addChild(this._rankText);
         this._titleComponent.addChild(this._rewardText);
         this._rewardText.text = $.C("manager.LanguageMgr").GetTranslation("CrossGuildCommonRewardView.rewardText.text");
         this._rankText.text = $.C("manager.LanguageMgr").GetTranslation("apex.rank.str1");
      }
    refreshView() {
         var _loc1_ = null;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaRewardTempCate.getTemplatesAry();
         this._itemBox.removeAllChild();
         for (var _loc3_ of $.values(_loc2_))
         {
            _loc1_ = new ($.C("dreamarena.item.DreamArenaRewardItem"))();
            _loc1_.clean();
            _loc1_.setTitleText(_loc3_.rankTitle);
            _loc1_.data = _loc3_.dropAry;
            this._itemBox.addChild(_loc1_);
         }
         this._scrollPanel.beginChanges();
         this._scrollPanel.invalidateViewport();
         this._scrollPanel.commitChanges();
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleComponent);
         this._titleComponent = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrollPanel);
         this._scrollPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemBox);
         this._itemBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleBack);
         this._titleBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rankText);
         this._rankText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardText);
         this._rewardText = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaRewardView, "dreamarena.view.DreamArenaRewardView", []);
  return __DreamArenaRewardView;
}
deps["dreamarena.view.DreamArenaRewardView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaRewardItem", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.manager.TempleteManager"];

defs["dreamarena.view.DreamArenaRuneView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaRuneView extends __Base {
    static $fields(self) {
    self._back = null;
    self._runeCon = null;
    self._saveBtn = null;
    self.runeList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
         this.addEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRuneView.back");
         this._runeCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaRuneView.runeCon");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaRuneView.saveBtn");
         this.addChild(this._back);
         this.addChild(this._runeCon);
         this.addChild(this._saveBtn);
      }
    initListView() {
         var _loc2_ = null;
         var _loc1_ = 0;
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(9);
         this.runeList = new $.Vector();
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_ = new ($.C("dreamarena.item.DreamArenaCommonSelectItemII"))(4,_loc1_ + 1);
            _loc2_.data = _loc3_[_loc1_];
            this._runeCon.appendItem(_loc2_);
            this.runeList.push(_loc2_);
            _loc1_++;
         }
         this.refreshSaveBtn();
      }
    addEvent() {
         this._saveBtn.addEventListener("click",$.bind(this, "__saveRuneHandler"));
         $.C("yishi.utils.MsgMan").addObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    removeEvent() {
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveRuneHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    __saveRuneHandler(param1) {
         var _loc2_ = this.model.selfInfo.runeId1 + "," + this.model.selfInfo.runeId2;
         if(this.model.clientSelectDic[9])
         {
            _loc2_ = ($.as(this.model.clientSelectDic[9], "Array")).join(",");
         }
         if(_loc2_.split(",").length < 2)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaArtifactView.runeCount.noEnough"));
            return;
         }
         $.C("managers.DreamArenaManager").instance.sendTitanOrRuneSelect(9,_loc2_);
      }
    __updateClientSelectHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc4_ = null;
         var _loc3_ = 0;
         var _loc5_ = $.as(param2, "int");
         if(_loc5_ == 9)
         {
            _loc3_ = 0;
            while(_loc3_ < this.runeList.length)
            {
               _loc4_ = this.runeList[_loc3_];
               _loc4_.refreshClientSelect();
               _loc3_++;
            }
         }
         this.refreshSaveBtn();
      }
    refreshView() {
         var _loc2_ = null;
         var _loc1_ = 0;
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(9);
         _loc1_ = 0;
         while(_loc1_ < this.runeList.length)
         {
            _loc2_ = this.runeList[_loc1_];
            _loc2_.data = _loc3_[_loc1_];
            _loc1_++;
         }
         this.refreshSaveBtn();
      }
    refreshSaveBtn() {
         this._saveBtn.enable = this.model.getRuneChange();
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._runeCon);
         this._runeCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         this._saveBtn = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.runeList);
         this.runeList = null;
         this.model.clientSelectDic.del(9);
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaRuneView, "dreamarena.view.DreamArenaRuneView", []);
  return __DreamArenaRuneView;
}
deps["dreamarena.view.DreamArenaRuneView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaCommonSelectItemII", "manager.LanguageMgr", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.manager.TempleteManager", "yishi.utils.MsgMan", "yishi.view.tips.MessageTipManager"];

defs["dreamarena.view.DreamArenaSlaveChildView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaSlaveChildView extends __Base {
    static $fields(self) {
    self._back = null;
    self._titleImage = null;
    self._childCon = null;
    self._petHbox = null;
    self._saveBtn = null;
    self.childList = null;
    self.petList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
         this.addEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.back");
         this._titleImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.titleImage");
         this._childCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaSlaveChildView.childCon");
         this._petHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.petHbox");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaChildView.saveBtn");
         this.addChild(this._back);
         this.addChild(this._titleImage);
         this.addChild(this._childCon);
         this.addChild(this._petHbox);
         this.addChild(this._saveBtn);
      }
    initListView() {
         var _loc1_ = null;
         var _loc4_ = null;
         var _loc3_ = 0;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(4);
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(2);
         this.childList = new $.Vector();
         this.petList = new $.Vector();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new ($.C("dreamarena.item.DreamArenaChildSelectItem"))(2,_loc3_ + 1);
            _loc1_.data = _loc2_[_loc3_];
            this._childCon.appendItem(_loc1_);
            this.childList.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc4_ = new ($.C("dreamarena.item.DreamArenaCommonSelectItemII"))(3,_loc3_ + 1);
            _loc4_.data = _loc5_[_loc3_];
            this._petHbox.addChild(_loc4_);
            this.petList.push(_loc4_);
            _loc3_++;
         }
         this.refreshSaveBtn();
      }
    addEvent() {
         this._saveBtn.addEventListener("click",$.bind(this, "__saveChildHandler"));
         $.C("yishi.utils.MsgMan").addObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    removeEvent() {
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveChildHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("DREAM_ARENA_CLIENT_SELECT",this,$.bind(this, "__updateClientSelectHandler"));
      }
    __saveChildHandler(param1) {
         var _loc3_ = $.int(this.model.selfInfo.slaveChildId);
         var _loc2_ = $.int(this.model.selfInfo.slaveChildPetId);
         if(this.model.clientSelectDic[4])
         {
            _loc3_ = $.int(this.model.clientSelectDic[4]);
         }
         if(this.model.clientSelectDic[42])
         {
            _loc2_ = $.int(this.model.clientSelectDic[42]);
         }
         $.C("managers.DreamArenaManager").instance.sendChildSelect(8,_loc3_,_loc2_);
      }
    __updateClientSelectHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc6_ = $.as(param2, "int");
         if(_loc6_ == 4)
         {
            _loc4_ = 0;
            while(_loc4_ < this.childList.length)
            {
               _loc3_ = this.childList[_loc4_];
               _loc3_.refreshClientSelect();
               _loc4_++;
            }
         }
         else if(_loc6_ == 42)
         {
            _loc4_ = 0;
            while(_loc4_ < this.petList.length)
            {
               _loc5_ = this.petList[_loc4_];
               _loc5_.refreshClientSelect();
               _loc4_++;
            }
         }
         this.refreshSaveBtn();
      }
    refreshView() {
         var _loc1_ = null;
         var _loc4_ = null;
         var _loc3_ = 0;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(4);
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(2);
         _loc3_ = 0;
         while(_loc3_ < this.childList.length)
         {
            _loc1_ = this.childList[_loc3_];
            _loc1_.data = _loc2_[_loc3_];
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc4_ = this.petList[_loc3_];
            _loc4_.data = _loc5_[_loc3_];
            _loc3_++;
         }
         this.refreshSaveBtn();
      }
    refreshSaveBtn() {
         this._saveBtn.enable = this.model.getSlaveChildChange();
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleImage);
         this._titleImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childCon);
         this._childCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petHbox);
         this._petHbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         this._saveBtn = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.childList);
         this.childList = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.petList);
         this.petList = null;
         this.model.clientSelectDic.del(4);
         this.model.clientSelectDic.del(42);
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaSlaveChildView, "dreamarena.view.DreamArenaSlaveChildView", []);
  return __DreamArenaSlaveChildView;
}
deps["dreamarena.view.DreamArenaSlaveChildView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaChildSelectItem", "dreamarena.item.DreamArenaCommonSelectItemII", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.manager.TempleteManager", "yishi.utils.MsgMan"];

defs["dreamarena.view.DreamArenaTalismanSelectView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaTalismanSelectView extends __Base {
    static $fields(self) {
    self._twoSelectBtn = null;
    self._fourSelectBtn = null;
    self.data = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._twoSelectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTalismanSelectView.twoSelectBtn");
         this._fourSelectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTalismanSelectView.fourSelectBtn");
         this.addChild(this._twoSelectBtn);
         this.addChild(this._fourSelectBtn);
         this._twoSelectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.towSkill");
         this._fourSelectBtn.text = $.C("manager.LanguageMgr").GetTranslation("dreamArena.selectBtn.fourSkill");
      }
    addEvent() {
         this._twoSelectBtn.addEventListener("click",$.bind(this, "__selectBtnClickHandler"));
         this._fourSelectBtn.addEventListener("click",$.bind(this, "__selectBtnClickHandler"));
      }
    removeEvent() {
         if(this._twoSelectBtn)
         {
            this._twoSelectBtn.removeEventListener("click",$.bind(this, "__selectBtnClickHandler"));
         }
         if(this._fourSelectBtn)
         {
            this._fourSelectBtn.removeEventListener("click",$.bind(this, "__selectBtnClickHandler"));
         }
      }
    __selectBtnClickHandler(param1) {
         var _loc4_ = 0;
         var _loc2_ = null;
         if(!this.data)
         {
            return;
         }
         if($.is(param1.currentTarget, $.C("com.pickgliss.ui.controls.TextButton")) && param1.currentTarget.stylename == "DreamArenaTalismanSelectView.twoSelectBtn")
         {
            _loc4_ = 1;
         }
         else if($.is(param1.currentTarget, $.C("com.pickgliss.ui.controls.TextButton")) && param1.currentTarget.stylename == "DreamArenaTalismanSelectView.fourSelectBtn")
         {
            _loc4_ = 2;
         }
         if(!this.model.clientSelectDic[24])
         {
            _loc2_ = [];
            _loc2_.push(this.data.TemplateId);
            _loc2_.push(_loc4_);
         }
         else
         {
            _loc2_ = $.as(this.model.clientSelectDic[24], "Array");
            if(_loc2_.indexOf(this.data.TemplateId) != -1)
            {
               _loc2_ = [];
               _loc2_.push(this.data.TemplateId);
               _loc2_.push(_loc4_);
            }
            else if(_loc2_.indexOf(_loc4_) != -1)
            {
               _loc2_ = [];
               _loc2_.push(this.data.TemplateId);
               _loc2_.push(_loc4_);
            }
            else
            {
               _loc2_.push(this.data.TemplateId);
               _loc2_.push(_loc4_);
            }
         }
         this.model.clientSelectDic.add(24,_loc2_);
         var _loc3_ = 24;
         $.C("yishi.utils.MsgMan").notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc3_);
         this.dispose();
      }
    show(param1) {
         var _loc3_ = 0;
         this.data = param1;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,7);
         var _loc2_ = [];
         if(this.model.clientSelectDic[24])
         {
            _loc2_ = $.as(this.model.clientSelectDic[24], "Array");
            _loc3_ = $.int(this.model.selectJob);
         }
         else
         {
            _loc2_ = this.selectInfo.talismanSkillsAry;
            _loc3_ = $.int(this.selectInfo.selfSelectJob);
         }
         var _loc4_ = _loc2_.indexOf(this.data.TemplateId);
         if(_loc3_ == 4 && _loc4_ != -1)
         {
            if(_loc2_[_loc4_ + 1] == 1)
            {
               this._twoSelectBtn.enable = false;
               this._fourSelectBtn.enable = true;
            }
            else if(_loc2_[_loc4_ + 1] == 2)
            {
               this._twoSelectBtn.enable = true;
               this._fourSelectBtn.enable = false;
            }
            else
            {
               this._twoSelectBtn.enable = true;
               this._fourSelectBtn.enable = true;
            }
         }
         else
         {
            this._twoSelectBtn.enable = true;
            this._fourSelectBtn.enable = true;
         }
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._twoSelectBtn);
         this._twoSelectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fourSelectBtn);
         this._fourSelectBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaTalismanSelectView, "dreamarena.view.DreamArenaTalismanSelectView", []);
  return __DreamArenaTalismanSelectView;
}
deps["dreamarena.view.DreamArenaTalismanSelectView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.TextButton", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.DreamArenaManager", "yishi.utils.MsgMan"];

defs["dreamarena.view.DreamArenaTalismanView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaTalismanView extends __Base {
    static $fields(self) {
    self._title = null;
    self._back = null;
    self._line = null;
    self._talismanHbox = null;
    self.talismanList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initListView();
      }
    initView() {
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaTalismanView.title");
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaTalismanView.back");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaTalismanView.line");
         this._talismanHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTalismanView.talismanHbox");
         this.addChild(this._back);
         this.addChild(this._line);
         this.addChild(this._title);
         this.addChild(this._talismanHbox);
      }
    initListView() {
         var _loc3_ = null;
         var _loc1_ = 0;
         this.talismanList = new $.Vector();
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(8);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = new ($.C("dreamarena.item.DreamArenaTalismanSelectItem"))(_loc1_ + 1);
            _loc3_.data = _loc2_[_loc1_];
            this._talismanHbox.addChild(_loc3_);
            this.talismanList.push(_loc3_);
            _loc1_++;
         }
      }
    refreshView() {
         var _loc3_ = null;
         var _loc1_ = 0;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.dreamArenaTempCate.getTemplateByType(8);
         _loc1_ = 0;
         while(_loc1_ < this.talismanList.length)
         {
            _loc3_ = this.talismanList[_loc1_];
            _loc3_.data = _loc2_[_loc1_];
            _loc1_++;
         }
      }
    refreshClientSelect() {
         var _loc2_ = null;
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.talismanList.length)
         {
            _loc2_ = this.talismanList[_loc1_];
            _loc2_.refreshClientSelect();
            _loc1_++;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         this._title = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._talismanHbox);
         this._talismanHbox = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.talismanList);
         this.talismanList = null;
         super.dispose();
      }
  }
  $.meta(__DreamArenaTalismanView, "dreamarena.view.DreamArenaTalismanView", []);
  return __DreamArenaTalismanView;
}
deps["dreamarena.view.DreamArenaTalismanView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dreamarena.item.DreamArenaTalismanSelectItem", "utils.LogicUtils", "yishi.manager.TempleteManager"];

defs["dreamarena.view.DreamArenaTitanView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DreamArenaTitanView extends __Base {
    static $fields(self) {
    self._sortImage = null;
    self._title = null;
    self._back = null;
    self._line = null;
    self._saveBtn = null;
    self._sortContiner = null;
    self.sortList = null;
    self._arrowContiner = null;
    self._equipContiner = null;
    self.equipList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initSkillView();
         this.addEvent();
         this.refreshView();
      }
    initView() {
         this._sortImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.sortImage");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.title");
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.back");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.line");
         this._saveBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaTitanView.saveBtn");
         this._sortContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaTitanView.sortContiner");
         this._arrowContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaTitanView.arrowContiner");
         this._equipContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DreamArenaTitanView.equipContiner");
         this.addChild(this._sortImage);
         this.addChild(this._back);
         this.addChild(this._sortContiner);
         this.addChild(this._arrowContiner);
         this.addChild(this._line);
         this.addChild(this._title);
         this.addChild(this._equipContiner);
         this.addChild(this._saveBtn);
         this._arrowContiner.mouseChildren = this._arrowContiner.mouseEnabled = false;
      }
    initSkillView() {
         var _loc4_ = 0;
         var _loc2_ = null;
         var _loc1_ = null;
         var _loc3_ = null;
         this.sortList = new $.Vector();
         this.equipList = new $.Vector();
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc2_ = new ($.C("dreamarena.item.DreamArenaTitanSkillItem"))(1,_loc4_);
            this._sortContiner.appendItem(_loc2_);
            this.sortList.push(_loc2_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DreamArenaHeroView.skillArrow");
            this._arrowContiner.appendItem(_loc1_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc3_ = new ($.C("dreamarena.item.DreamArenaTitanSkillItem"))(2,_loc4_);
            this._equipContiner.appendItem(_loc3_);
            this.equipList.push(_loc3_);
            _loc4_++;
         }
      }
    addEvent() {
         this._saveBtn.addEventListener("click",$.bind(this, "__saveTitanHandler"));
         $.C("yishi.utils.MsgMan").addObserver("TITAN_SET_SKILL",this,$.bind(this, "__updateSortSkillHandler"));
         $.C("yishi.utils.MsgMan").addObserver("TITAN_CLIENT_SKILL_UPDATE",this,$.bind(this, "__updateEquipSkillHandler"));
      }
    removeEvent() {
         if(this._saveBtn)
         {
            this._saveBtn.removeEventListener("click",$.bind(this, "__saveTitanHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("TITAN_SET_SKILL",this,$.bind(this, "__updateSortSkillHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("TITAN_CLIENT_SKILL_UPDATE",this,$.bind(this, "__updateEquipSkillHandler"));
      }
    __saveTitanHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = this.selectInfo.titanSkills;
         if(this.model.clientSelectDic[21])
         {
            _loc2_ = ($.as(this.model.clientSelectDic[21], "Array")).join(",");
         }
         if(_loc2_.split(",").length < 10)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("DreamArenaArtifactView.titanCount.noEnough"));
            return;
         }
         $.C("managers.DreamArenaManager").instance.sendTitanOrRuneSelect(6,_loc2_);
      }
    __updateEquipSkillHandler(param1 = null, param2 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc5_ = 0;
         var _loc6_ = null;
         var _loc3_ = null;
         var _loc4_ = [];
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc6_ = this.sortList[_loc5_];
            if(_loc6_.data)
            {
               _loc4_.push(_loc6_.data.TemplateId);
            }
            _loc5_++;
         }
         this.model.clientSelectDic.add(21,_loc4_);
         _loc5_ = 0;
         while(_loc5_ < this.equipList.length)
         {
            _loc3_ = this.equipList[_loc5_];
            _loc3_.refreshClientSelect();
            _loc5_++;
         }
         this.refreshSaveBtn();
      }
    __updateSortSkillHandler(param1 = null, param2 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc4_ = null;
         var _loc5_ = $.as(param2.dragItem, $.C("dreamarena.item.DreamArenaTitanSkillItem"));
         var _loc3_ = $.as(param2.dropItem, $.C("dreamarena.item.DreamArenaTitanSkillItem"));
         if(!_loc5_ || !_loc3_)
         {
            return;
         }
         var _loc6_ = _loc5_.index;
         var _loc7_ = _loc3_.index;
         if(_loc3_.data)
         {
            _loc4_ = _loc5_.data;
            this.sortList[_loc6_].data = _loc3_.data;
            this.sortList[_loc7_].data = _loc4_;
         }
         else
         {
            this.sortList[_loc7_].data = _loc5_.data;
            this.sortList[_loc6_].data = null;
         }
      }
    refreshView() {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc4_ = this.sortList[_loc1_];
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[this.selectInfo.titanSkillAry[_loc1_]];
            _loc4_.data = _loc2_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.titanTemplateCate.getTitanList()[_loc1_];
            if(_loc3_)
            {
               _loc4_ = this.equipList[_loc1_];
               _loc2_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc3_.SkillIds];
               _loc4_.data = _loc2_;
            }
            _loc1_++;
         }
         this.refreshSaveBtn();
      }
    refreshSaveBtn() {
         this._saveBtn.enable = this.model.getTitanChange();
      }
    get selectInfo() {
         return this.model.selfInfo;
      }
    get model() {
         return $.C("managers.DreamArenaManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sortImage);
         this._sortImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         this._title = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._saveBtn);
         this._saveBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sortContiner);
         this._sortContiner = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._arrowContiner);
         this._arrowContiner = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._equipContiner);
         this._equipContiner = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.sortList);
         this.sortList = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.equipList);
         this.equipList = null;
         this.model.clientSelectDic.del(21);
         super.dispose();
      }
    set selectInfo(v) { super.selectInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaTitanView, "dreamarena.view.DreamArenaTitanView", []);
  $.statics(__DreamArenaTitanView, () => {
    __DreamArenaTitanView.EQUIP_COUNT = 12;
    __DreamArenaTitanView.SKILL_COUNT = 10;
    __DreamArenaTitanView.ARROW_COUNT = 8;
  });
  return __DreamArenaTitanView;
}
deps["dreamarena.view.DreamArenaTitanView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "dreamarena.item.DreamArenaTitanSkillItem", "manager.LanguageMgr", "managers.DreamArenaManager", "utils.LogicUtils", "yishi.manager.TempleteManager", "yishi.utils.MsgMan", "yishi.view.tips.MessageTipManager"];

defs["net.SingWarSocketSendManager"] = function define($) {
  const __Base = $.Object;
  class __SingWarSocketSendManager extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static enterWarfield(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if($.C("flash.utils.getTimer")() - __SingWarSocketSendManager._enterTime < 5000)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         __SingWarSocketSendManager._enterTime = $.C("flash.utils.getTimer")();
         var _loc3_ = new ($.C("yishi.comm.PackageOut"))(8332);
         var _loc2_ = new ($.C("com.road.yishi.proto.worldmap.WorldBossMsg"))();
         _loc2_.param1 = param1;
         __SingWarSocketSendManager.sendProtoBuffer(_loc2_,_loc3_);
      }
    static sendRequestPvpRemainNumber(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if($.C("flash.utils.getTimer")() - __SingWarSocketSendManager._enterTime < 5000)
         {
            return;
         }
         __SingWarSocketSendManager._enterTime = $.C("flash.utils.getTimer")();
         var _loc3_ = new ($.C("yishi.comm.PackageOut"))(8599);
         var _loc2_ = new ($.C("com.road.yishi.proto.campaign.CampaignReqMsg"))();
         _loc2_.paraInt1 = param1;
         __SingWarSocketSendManager.sendProtoBuffer(_loc2_,_loc3_);
      }
    static sendProtoBuffer(param1, param2) {
         $.C("yishi.service.managers.SocketManager").instance.socket.sendProtobuffer(param2,param1);
      }
    static sendStartCampaignScene(param1 = 0, param2 = 0, param3 = null) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc5_ = $.C("flash.utils.getTimer")();
         if(_loc5_ - __SingWarSocketSendManager._time < 3000)
         {
            if(param3 != null)
            {
               param3();
            }
            return;
         }
         __SingWarSocketSendManager._time = _loc5_;
         var _loc6_ = new ($.C("yishi.comm.PackageOut"))(5039);
         var _loc4_ = new ($.C("com.road.yishi.proto.campaign.CampaignReqMsg"))();
         if(param2 == 1)
         {
            _loc4_.paraInt1 = param2;
         }
         _loc4_.paraInt2 = param1;
         __SingWarSocketSendManager.sendProtoBuffer(_loc4_,_loc6_);
      }
  }
  $.meta(__SingWarSocketSendManager, "net.SingWarSocketSendManager", []);
  $.statics(__SingWarSocketSendManager, () => {
    __SingWarSocketSendManager._enterTime = 0;
    __SingWarSocketSendManager._time = NaN;
  });
  return __SingWarSocketSendManager;
}
deps["net.SingWarSocketSendManager"] = ["com.road.yishi.proto.campaign.CampaignReqMsg", "com.road.yishi.proto.worldmap.WorldBossMsg", "flash.utils.getTimer", "manager.LanguageMgr", "yishi.comm.PackageOut", "yishi.service.managers.SocketManager", "yishi.view.tips.MessageTipManager"];

defs["redemptionroad.RedemptionRoadChapterFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __RedemptionRoadChapterFrame extends __Base {
    static $fields(self) {
    self._border = null;
    self._mainBg = null;
    self._leftFlower = null;
    self._rightFlower = null;
    self._diffImage = null;
    self._layerText = null;
    self._bufferTitle = null;
    self._bufferDesc = null;
    self._debufferTitle = null;
    self._debufferDesc = null;
    self._rewardBox = null;
    self._startBtn = null;
    self._lineCon = null;
    self._nodeCon = null;
    self._nodeBg = null;
    self._nodePanel = null;
    self.nodeInfo = null;
    self.nodeItemDic = null;
    self.lineStyleObj = {
         "-20":"asset.RedemptionRoad.line015",
         "-15":"asset.RedemptionRoad.line015",
         "-10":"asset.RedemptionRoad.line010",
         "-5":"asset.RedemptionRoad.line005",
         "0":"asset.RedemptionRoad.line000",
         "5":"asset.RedemptionRoad.line105",
         "10":"asset.RedemptionRoad.line110",
         "15":"asset.RedemptionRoad.line115",
         "20":"asset.RedemptionRoad.line115"
      };
    self.preLen = -1;
    }
    constructor() {
         super();
         this.initView();
         this.initNodeView();
         this.addEvent();
         this.model.selectPos = 0;
         if(this.model.nodeDic.getList().length <= 0)
         {
            $.C("managers.RedemptionRoadManager").instance.sendRedemptionRoadRequest(0);
         }
         else
         {
            this.refreshView();
         }
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,760,565);
      }
    get groups() {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
    initView() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.border");
         this._mainBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.mainBg");
         this._leftFlower = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.leftFlower");
         this._rightFlower = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.rightFlower");
         this._layerText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.layerText");
         this._bufferTitle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.bufferTitle");
         this._bufferDesc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.bufferDesc");
         this._debufferTitle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.debufferTitle");
         this._debufferDesc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.debufferDesc");
         this._rewardBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.rewardBox");
         this._startBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.startBtn");
         this._diffImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.diffImage");
         this._nodeBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodeBg");
         this._nodeCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodeCon");
         this._nodePanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodePanel");
         this._lineCon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.lineCon");
         this.addToContent(this._border);
         this.addToContent(this._mainBg);
         this.addToContent(this._nodePanel);
         this.addToContent(this._leftFlower);
         this.addToContent(this._rightFlower);
         this.addToContent(this._diffImage);
         this.addToContent(this._layerText);
         this.addToContent(this._bufferTitle);
         this.addToContent(this._bufferDesc);
         this.addToContent(this._debufferTitle);
         this.addToContent(this._debufferDesc);
         this.addToContent(this._rewardBox);
         this.addToContent(this._startBtn);
         this._nodePanel.setView(this._nodeCon);
         this._diffImage.setFrame(1);
         this._leftFlower.mouseEnabled = this._rightFlower.mouseEnabled = false;
         this._bufferTitle.text = $.C("manager.LanguageMgr").GetTranslation("RedemptionRoadChapterFrame.bufferTitle.text");
         this._debufferTitle.text = $.C("manager.LanguageMgr").GetTranslation("RedemptionRoadChapterFrame.debufferTitle.text");
      }
    initNodeView() {
         var _loc3_ = 0;
         var _loc2_ = 0;
         var _loc6_ = null;
         var _loc5_ = 0;
         var _loc1_ = null;
         this._nodeCon.beginChanges();
         this._nodeCon.addChild(this._nodeBg);
         this._nodeCon.addChild(this._lineCon);
         this._nodeBg.setFrame(1);
         var _loc4_ = $.C("yishi.datas.ConfigInfoManager").instance.getRedemptionRoadLayerConfig();
         this.nodeItemDic = new ($.C("flash.utils.Dictionary"))();
         _loc3_ = 1;
         while(_loc3_ <= _loc4_.length)
         {
            _loc2_ = $.int(_loc4_[_loc3_ - 1]);
            _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadChapterFrame.nodeBox");
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc1_ = new ($.C("redemptionroad.item.RedemptionRoadNodeItem"))(_loc5_,_loc2_);
               _loc6_.addChild(_loc1_);
               this.nodeItemDic[_loc3_ + "_" + _loc5_] = _loc1_;
               _loc5_++;
            }
            _loc6_.y = (_loc3_ - 1) * -141 + 1295;
            this._nodeCon.addChild(_loc6_);
            _loc3_++;
         }
         this._nodeCon.commitChanges();
         this._nodePanel.invalidateViewport();
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._startBtn.addEventListener("click",$.bind(this, "__startClickHandler"));
         $.C("yishi.utils.MsgMan").addObserver("USER_INFO_CHANGE",this,$.bind(this, "__userInfoBackHandler"));
         $.C("yishi.utils.MsgMan").addObserver("NODE_POS_SELECT",this,$.bind(this, "__nodePosChangeHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._startBtn)
         {
            this._startBtn.removeEventListener("click",$.bind(this, "__startClickHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("USER_INFO_CHANGE",this,$.bind(this, "__userInfoBackHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("NODE_POS_SELECT",this,$.bind(this, "__nodePosChangeHandler"));
      }
    __startClickHandler(param1) {
         if(!this.nodeInfo)
         {
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("managers.RedemptionRoadManager").instance.sendRedemptionRoadRequest(1,this.nodeInfo.id);
      }
    __nodePosChangeHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshView(false);
      }
    __userInfoBackHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshView();
      }
    refreshView(param1 = true) {
         this.nodeInfo = this.model.getShowNodeInfo(this.model.selectPos);
         if(!this.nodeInfo)
         {
            return;
         }
         this._diffImage.setFrame(this.model.difficulty);
         this._nodeBg.setFrame(this.model.difficulty);
         this._layerText.text = $.C("manager.LanguageMgr").GetTranslation("RedemptionRoadChapterFrame.layerText.text",this.model.curLayer);
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[this.nodeInfo.buff];
         this._bufferDesc.text = _loc2_ ? _loc2_.Description : "";
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[this.nodeInfo.debuff];
         this._debufferDesc.text = _loc3_ ? _loc3_.Description : "";
         this.refreshReward();
         this.refeshNodeView();
         this.drawLineView();
         if(param1)
         {
            if(this.model.curLayer >= this.model.maxLayer)
            {
               this._nodePanel.vScrollbar.scrollValue = 0;
            }
            else
            {
               this._nodePanel.vScrollbar.scrollValue = (this.model.curLayer - 1) * -141 + 1270;
            }
         }
      }
    refreshReward() {
         var _loc3_ = 0;
         var _loc1_ = null;
         this._rewardBox.removeAllChild();
         var _loc2_ = $.C("yishi.utils.GoodsHelp").getCommonRewardAry(this.nodeInfo.rewards);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("RedemptionRoadChapterFrame.rewardItem");
            _loc1_.data = _loc2_[_loc3_];
            this._rewardBox.addChild(_loc1_);
            _loc3_++;
         }
      }
    refeshNodeView() {
         var _loc1_ = null;
         for(var _loc2_ in this.nodeItemDic)
         {
            _loc1_ = this.nodeItemDic[_loc2_];
            _loc1_.nodeInfo = this.model.nodeDic[_loc2_];
            _loc1_.refreshSelect();
         }
      }
    drawLineView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         var _loc10_ = null;
         var _loc3_ = 0;
         var _loc6_ = null;
         var _loc8_ = null;
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc7_ = null;
         var _loc9_ = 0;
         if(!this.model.roadPaths || this.preLen == this.model.roadPaths.length)
         {
            return;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._lineCon);
         this.preLen = this.model.roadPaths.length;
         if(this.preLen <= 1)
         {
            return;
         }
         this._nodeCon.beginChanges();
         _loc9_ = this.preLen - 1;
         while(_loc9_ >= 0)
         {
            if(_loc9_ > 0)
            {
               _loc2_ = $.int(this.model.roadPaths[_loc9_]);
               _loc1_ = this.model.getNodeInfoById(_loc2_);
               if(_loc1_)
               {
                  _loc10_ = this.nodeItemDic[_loc1_.layer + "_" + _loc1_.pos];
                  if(_loc10_)
                  {
                     _loc3_ = $.int(this.model.roadPaths[_loc9_ - 1]);
                     _loc6_ = this.model.getNodeInfoById(_loc3_);
                     if(_loc6_)
                     {
                        _loc8_ = this.nodeItemDic[_loc6_.layer + "_" + _loc6_.pos];
                        if(_loc8_)
                        {
                           _loc4_ = _loc10_.weight - _loc8_.weight;
                           _loc5_ = this.lineStyleObj[_loc4_];
                           _loc7_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(_loc5_);
                           if(_loc4_ <= 0)
                           {
                              _loc7_.x = 252 + _loc10_.x + 60;
                           }
                           else
                           {
                              _loc7_.x = 252 + _loc10_.x + 50 - _loc7_.width - 25;
                           }
                           _loc7_.y = _loc10_.parent.y + 55;
                           this._lineCon.addChild(_loc7_);
                        }
                     }
                  }
               }
            }
            _loc9_--;
         }
         this._nodeCon.commitChanges();
         this._nodePanel.invalidateViewport();
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    get model() {
         return $.C("managers.RedemptionRoadManager").instance.model;
      }
    show(param1 = null) {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("RedemptionRoadMainFrame.title.text");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._border);
         this._border = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainBg);
         this._mainBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._layerText);
         this._layerText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferTitle);
         this._bufferTitle = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferDesc);
         this._bufferDesc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._debufferTitle);
         this._debufferTitle = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._debufferDesc);
         this._debufferDesc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardBox);
         this._rewardBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._startBtn);
         this._startBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftFlower);
         this._leftFlower = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightFlower);
         this._rightFlower = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nodeBg);
         this._nodeBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nodeCon);
         this._nodeCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nodePanel);
         this._nodePanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._diffImage);
         this._diffImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lineCon);
         this._lineCon = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.nodeItemDic);
         this.nodeItemDic = null;
         this.lineStyleObj = null;
         this.model.selectPos = 0;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__RedemptionRoadChapterFrame, "redemptionroad.RedemptionRoadChapterFrame", ["IManualSize"]);
  return __RedemptionRoadChapterFrame;
}
deps["redemptionroad.RedemptionRoadChapterFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Rectangle", "flash.utils.Dictionary", "manager.LanguageMgr", "managers.RedemptionRoadManager", "redemptionroad.item.RedemptionRoadNodeItem", "utils.LogicUtils", "yishi.datas.ConfigInfoManager", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp", "yishi.utils.MsgMan"];

defs["redemptionroad.RedemptionRoadMainFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __RedemptionRoadMainFrame extends __Base {
    static $fields(self) {
    self._border = null;
    self._mainBg = null;
    self._diffImage = null;
    self._processText = null;
    self._rewardBox = null;
    self._startBtn = null;
    self._diffBox = null;
    self.diffList = null;
    self._tipTxt = null;
    }
    constructor() {
         super();
         this.initView();
         this.initDiffView();
         this.addEvent();
         $.C("managers.RedemptionRoadManager").instance.sendRedemptionRoadRequest(0);
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,760,565);
      }
    get groups() {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
    initView() {
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.border");
         this._mainBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.mainBg");
         this._diffImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.diffImage");
         this._processText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.processText");
         this._rewardBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.rewardBox");
         this._startBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.startBtn");
         this._diffBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.diffBox");
         this._tipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadMainFrame.refreshTipTxt");
         this._tipTxt.text = $.C("manager.LanguageMgr").GetTranslation("RedemptionRoadChapterFrame.refreshTip");
         this.addToContent(this._border);
         this.addToContent(this._mainBg);
         this.addToContent(this._diffBox);
         this.addToContent(this._diffImage);
         this.addToContent(this._processText);
         this.addToContent(this._rewardBox);
         this.addToContent(this._startBtn);
         this.addToContent(this._tipTxt);
      }
    initDiffView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this.diffList = new $.Vector();
         _loc2_ = $.int(this.model.maxDiffCount);
         while(_loc2_ > 0)
         {
            _loc1_ = new ($.C("redemptionroad.item.RedemptionRoadDiffItem"))(_loc2_);
            this._diffBox.addChild(_loc1_);
            this.diffList.push(_loc1_);
            _loc2_--;
         }
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._startBtn.addEventListener("click",$.bind(this, "__startClickHandler"));
         $.C("yishi.utils.MsgMan").addObserver("USER_INFO_CHANGE",this,$.bind(this, "__userInfoBackHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._startBtn)
         {
            this._startBtn.removeEventListener("click",$.bind(this, "__startClickHandler"));
         }
         $.C("yishi.utils.MsgMan").removeObserver("USER_INFO_CHANGE",this,$.bind(this, "__userInfoBackHandler"));
      }
    __startClickHandler(param1) {
         if(this.model.isCding)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("redemptionRoad.challenge.cdAlert"));
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("redemptionroad","CHAPTER_FRAME");
      }
    __userInfoBackHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshView();
      }
    refreshView() {
         var _loc4_ = 0;
         var _loc2_ = null;
         var _loc6_ = 0;
         var _loc3_ = null;
         this._diffImage.setFrame(this.model.difficulty);
         if(this.model.difficulty == 2)
         {
            this._diffImage.x = 558;
         }
         else
         {
            this._diffImage.x = 568;
         }
         var _loc1_ = this.model.curLayer - 1;
         this._processText.text = _loc1_ + "/" + this.model.maxLayer;
         this._startBtn.enable = !this.model.isClearance;
         _loc4_ = 0;
         while(_loc4_ < this.model.maxDiffCount)
         {
            _loc2_ = this.diffList[_loc4_];
            _loc2_.refreshView();
            _loc4_++;
         }
         this._rewardBox.removeAllChild();
         var _loc5_ = this.getRewardsAry();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("RedemptionRoadMainFrame.rewardItem");
            _loc3_.data = _loc5_[_loc6_];
            this._rewardBox.addChild(_loc3_);
            _loc6_++;
         }
      }
    getRewardsAry() {
         if(this.model.difficulty == 1)
         {
            return $.C("yishi.datas.ConfigInfoManager").instance.getRedemptionRoadReward1();
         }
         if(this.model.difficulty == 2)
         {
            return $.C("yishi.datas.ConfigInfoManager").instance.getRedemptionRoadReward2();
         }
         if(this.model.difficulty == 3)
         {
            return $.C("yishi.datas.ConfigInfoManager").instance.getRedemptionRoadReward3();
         }
         return [];
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    get model() {
         return $.C("managers.RedemptionRoadManager").instance.model;
      }
    show(param1 = null) {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("RedemptionRoadMainFrame.title.text");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._border);
         this._border = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mainBg);
         this._mainBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._diffImage);
         this._diffImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._processText);
         this._processText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rewardBox);
         this._rewardBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._startBtn);
         this._startBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._diffBox);
         this._diffBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipTxt);
         this._tipTxt = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.diffList);
         this.diffList = null;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set playerModel(v) { super.playerModel = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__RedemptionRoadMainFrame, "redemptionroad.RedemptionRoadMainFrame", ["IManualSize"]);
  return __RedemptionRoadMainFrame;
}
deps["redemptionroad.RedemptionRoadMainFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.RedemptionRoadManager", "redemptionroad.item.RedemptionRoadDiffItem", "utils.LogicUtils", "yishi.datas.ConfigInfoManager", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.utils.MsgMan", "yishi.view.tips.MessageTipManager"];

defs["redemptionroad.item.RedemptionRoadDiffItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __RedemptionRoadDiffItem extends __Base {
    static $fields(self) {
    self._itemBack = null;
    self._diffImage = null;
    self._selectBg = null;
    self._cdBack = null;
    self._cdText = null;
    self._cdBtn = null;
    self._clearanceImage = null;
    self.index = 0;
    self.configCost = 0;
    }
    constructor(param1) {
         super();
         this.index = param1;
         this.initView();
      }
    initView() {
         this._itemBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadDiffItem.itemBack");
         this._diffImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadDiffItem.diffImage");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.RedemptionRoadDiffItem.selectBg");
         this._cdBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadDiffItem.cdBack");
         this._cdText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadDiffItem.cdText");
         this._cdBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadDiffItem.cdBtn");
         this._clearanceImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.RedemptionRoadDiffItem.clearanceImage");
         this.addChild(this._itemBack);
         this.addChild(this._diffImage);
         this.addChild(this._selectBg);
         this.addChild(this._cdBack);
         this.addChild(this._cdText);
         this.addChild(this._cdBtn);
         this.addChild(this._clearanceImage);
         this._itemBack.setFrame(this.index);
         this._diffImage.setFrame(this.index);
         this._selectBg.visible = false;
         this._cdBack.visible = false;
         this._cdBtn.visible = false;
         this._clearanceImage.visible = false;
         this._cdText.text = "";
         this.configCost = $.C("yishi.datas.ConfigInfoManager").instance.getRedemptionRoadCostPoint();
      }
    addEvent() {
         this._cdBtn.addEventListener("click",$.bind(this, "__cdClickHandler"));
         this.playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",$.bind(this, "__updateTimeHandler"));
      }
    removeEvent() {
         if(this._cdBtn)
         {
            this._cdBtn.removeEventListener("click",$.bind(this, "__cdClickHandler"));
         }
         this.playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",$.bind(this, "__updateTimeHandler"));
      }
    __cdClickHandler(param1) {
         var _loc7_ = (this.model.cdEndTime.time - this.playerModel.sysCurtime.time) / 1000 / 60;
         var _loc2_ = $.int(Math.ceil(_loc7_ / 10)) * this.configCost;
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
         var _loc6_ = $.C("manager.LanguageMgr").GetTranslation("RedemptionRoadDiffItem.cdCost.alert",_loc2_);
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "cdConfirmHandler"),_loc2_];
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,true,false);
      }
    cdConfirmHandler(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if(!param1)
         {
            return;
         }
         if(!$.C("utils.LogicUtils").judgePointEnoughToShowPay(param3,false))
         {
            return;
         }
         $.C("managers.RedemptionRoadManager").instance.sendRedemptionRoadRequest(2);
      }
    __updateTimeHandler(param1) {
         var _loc2_ = (this.model.cdEndTime.time - this.playerModel.sysCurtime.time) / 1000;
         if(_loc2_ > 0)
         {
            this._cdText.text = $.C("yishi.utils.DateFormatter").getConsortiaCountDate(_loc2_);
         }
         else
         {
            this.refreshView();
         }
      }
    refreshView() {
         this.clean();
         if(this.index == this.model.difficulty)
         {
            if(this.model.isCding)
            {
               this.addEvent();
               this._cdBack.visible = true;
               this._cdBtn.visible = true;
               this.__updateTimeHandler(null);
            }
            else
            {
               this.removeEvent();
               this._selectBg.visible = true;
               this._itemBack.filters = [];
               this._diffImage.filters = [];
            }
            this._clearanceImage.visible = this.model.isClearance;
         }
         else if(this.index < this.model.difficulty)
         {
            this._itemBack.filters = [];
            this._diffImage.filters = [];
            this._clearanceImage.visible = true;
         }
      }
    clean() {
         this.removeEvent();
         this._selectBg.visible = false;
         this._cdBack.visible = false;
         this._cdBtn.visible = false;
         this._clearanceImage.visible = false;
         this._cdText.text = "";
         this._itemBack.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         this._diffImage.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
      }
    get model() {
         return $.C("managers.RedemptionRoadManager").instance.model;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemBack);
         this._itemBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._diffImage);
         this._diffImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cdBack);
         this._cdBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cdText);
         this._cdText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cdBtn);
         this._cdBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._clearanceImage);
         this._clearanceImage = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
    set playerModel(v) { super.playerModel = v; }
  }
  $.meta(__RedemptionRoadDiffItem, "redemptionroad.item.RedemptionRoadDiffItem", []);
  return __RedemptionRoadDiffItem;
}
deps["redemptionroad.item.RedemptionRoadDiffItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.RedemptionRoadManager", "utils.LogicUtils", "yishi.datas.ConfigInfoManager", "yishi.filter.UIFilter", "yishi.manager.PlayerManager", "yishi.utils.DateFormatter", "yishi.utils.SimpleAlertHelper"];

defs["redemptionroad.item.RedemptionRoadNodeItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __RedemptionRoadNodeItem extends __Base {
    static $fields(self) {
    self._back = null;
    self._bossIcon = null;
    self._topBack = null;
    self._selectBg = null;
    self._stateImage = null;
    self._nodeInfo = null;
    self.pos = 0;
    self.maxCount = 0;
    }
    constructor(param1, param2) {
         super();
         this.pos = param1;
         this.maxCount = param2;
         this.initView();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.RedemptionRoadNodeItem.back");
         this._topBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.RedemptionRoadNodeItem.topBack");
         this._bossIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("RedemptionRoadNodeItem.bossIcon");
         this._selectBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.RedemptionRoadNodeItem.selectBg");
         this._stateImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RedemptionRoadNodeItem.stateImage");
         this.addChild(this._back);
         this.addChild(this._bossIcon);
         this.addChild(this._topBack);
         this.addChild(this._selectBg);
         this.addChild(this._stateImage);
         this._selectBg.visible = false;
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "__clickHandler"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__clickHandler"));
      }
    __clickHandler(param1) {
         this.model.selectPos = this.pos;
      }
    get nodeInfo() {
         return this._nodeInfo;
      }
    set nodeInfo(param1) {
         this._nodeInfo = param1;
         if(!this.nodeInfo)
         {
            return;
         }
         if(this.nodeInfo.getBossTemp())
         {
            this._bossIcon.icon = $.C("yishi.utils.IconFactory").getHeroicon(this.nodeInfo.getBossTemp().TemplateId);
         }
         else if(this.nodeInfo.getNpcTemp())
         {
            this._bossIcon.icon = $.C("yishi.utils.IconFactory").getSoldierIconByIcon(this.nodeInfo.getNpcTemp().Icon);
         }
         else
         {
            this._bossIcon.icon = null;
         }
         if(this.nodeInfo.layer == this.model.curLayer)
         {
            this.addEvent();
            this.filters = [];
            this.buttonMode = true;
            this._stateImage.visible = false;
         }
         else
         {
            this.removeEvent();
            this.buttonMode = false;
            if(this.nodeInfo.layer > this.model.curLayer)
            {
               this.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
               this._stateImage.visible = false;
            }
            else
            {
               this.filters = [];
               this._stateImage.visible = true;
            }
            if(this.model.roadPaths && this.model.roadPaths.indexOf(this.nodeInfo.id) != -1)
            {
               this._stateImage.setFrame(1);
            }
            else
            {
               this._stateImage.setFrame(2);
            }
         }
      }
    refreshSelect() {
         this._selectBg.visible = this.nodeInfo.layer == this.model.curLayer && this.pos == this.model.selectPos;
      }
    get model() {
         return $.C("managers.RedemptionRoadManager").instance.model;
      }
    get weight() {
         if(this.maxCount == 1)
         {
            return 10;
         }
         if(this.maxCount == 2)
         {
            return this.pos * 10 + 5;
         }
         if(this.maxCount >= 3)
         {
            return this.pos * 10;
         }
         return -1;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._topBack);
         this._topBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bossIcon);
         this._bossIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectBg);
         this._selectBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stateImage);
         this._stateImage = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
    set weight(v) { super.weight = v; }
  }
  $.meta(__RedemptionRoadNodeItem, "redemptionroad.item.RedemptionRoadNodeItem", []);
  return __RedemptionRoadNodeItem;
}
deps["redemptionroad.item.RedemptionRoadNodeItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "managers.RedemptionRoadManager", "yishi.filter.UIFilter", "yishi.utils.IconFactory"];

defs["selectcampaign.SelectCampaignFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __SelectCampaignFrame extends __Base {
    static $fields(self) {
    self._areaView = null;
    self._border = null;
    self._bufferView1 = null;
    self._bufferView2 = null;
    self.tempNeedPoint = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("single_hero_buy_cost");
    self.needPoint = self.tempNeedPoint ? $.int(self.tempNeedPoint.ConfigValue) : 10;
    self._helpBtn = null;
    self._rect = new ($.C("flash.geom.Rectangle"))(0,0,930,550);
    }
    constructor() {
         $.C("map.campaign.CampaignSocketOutManager").instance.buyCount(1);
         super();
         this.initView();
         this.initBufferView();
         this.initEvents();
         this.__selectedChapterChangeHandler(null);
      }
    get groups() {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
    get viewRectangle() {
         return this._rect;
      }
    initView() {
         this._areaView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCP.AreaView");
         this.addToContent(this._areaView);
         this._border = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCP.framestyleCp");
         this.addToContent(this._border);
         this._border.width = 1020;
         this._helpBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selectCP.helpBtn");
         this.addToContent(this._helpBtn);
      }
    initBufferView() {
         var _loc1_ = $.C("managers.MagicSpringManager").instance.model.checkIsExistBuffer(3);
         if(_loc1_)
         {
            this._bufferView1 = new ($.C("yishi.view.community.MagicSpringBufferAddView"))(_loc1_);
            this._bufferView1.setDescText(_loc1_.tempInfo.Desc);
            this._bufferView1.x = 720;
            this._bufferView1.y = 25;
            this.addToContent(this._bufferView1);
         }
         var _loc2_ = $.C("managers.MagicSpringManager").instance.model.checkIsExistBuffer(4);
         if(_loc2_)
         {
            this._bufferView2 = new ($.C("yishi.view.community.MagicSpringBufferAddView"))(_loc2_);
            this._bufferView2.setDescText(_loc2_.tempInfo.Desc);
            this._bufferView2.x = 720;
            if(this._bufferView1 && this._bufferView1.parent)
            {
               this._bufferView2.y = this._bufferView1.y + 40;
            }
            else
            {
               this._bufferView2.y = 25;
            }
            this.addToContent(this._bufferView2);
         }
      }
    initEvents() {
         this.addEventListener("addedToStage",$.bind(this, "__addToStage"));
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SWITCH_SCENE",$.bind(this, "__switchSceneHandler"));
         this._helpBtn.addEventListener("click",$.bind(this, "__helpHandler"));
         this.model.addEventListener("SELECTED_CHAPTER_CHANGE",$.bind(this, "__selectedChapterChangeHandler"));
      }
    removeEvents() {
         this.removeEventListener("addedToStage",$.bind(this, "__addToStage"));
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SWITCH_SCENE",$.bind(this, "__switchSceneHandler"));
         this._helpBtn.removeEventListener("click",$.bind(this, "__helpHandler"));
         this.model.removeEventListener("SELECTED_CHAPTER_CHANGE",$.bind(this, "__selectedChapterChangeHandler"));
      }
    __selectedChapterChangeHandler(param1) {
         var _loc4_ = 0;
         var _loc3_ = false;
         var _loc2_ = this._areaView.cpMapView.pointViewArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].ExistDiff())
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
      }
    __helpHandler(param1) {
         var _loc2_ = null;
         _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selectCP.helpFrame");
         _loc2_.show();
      }
    __switchSceneHandler(param1) {
         this.dispose();
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    __addToStage(param1) {
      }
    show() {
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("OPEN_CAMPAIGN_FRAME",null));
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,2);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    get areaView() {
         return this._areaView;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.selectCampaignControler.model;
      }
    dispose() {
         this.removeEvents();
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         if(this._areaView)
         {
            this._areaView.dispose();
         }
         this._areaView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferView1);
         this._bufferView1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferView2);
         this._bufferView2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set groups(v) { super.groups = v; }
    set viewRectangle(v) { super.viewRectangle = v; }
    set areaView(v) { super.areaView = v; }
    set playerModel(v) { super.playerModel = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__SelectCampaignFrame, "selectcampaign.SelectCampaignFrame", ["IManualSize"]);
  return __SelectCampaignFrame;
}
deps["selectcampaign.SelectCampaignFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "flash.geom.Rectangle", "managers.MagicSpringManager", "map.campaign.CampaignSocketOutManager", "yishi.events.NotificationEvent", "yishi.keyboard.KeyBoardRegister", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.view.community.MagicSpringBufferAddView"];

defs["selectcampaign.view.AreaView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AreaView extends __Base {
    static $fields(self) {
    self._map = null;
    self._areaComboxBg = null;
    self._areaCombox = null;
    self._cpInfoView = null;
    self._chapterRewardView = null;
    self._currentIndex = 0;
    self._chapterList = null;
    self._chapterRewardBtn1 = null;
    self._chapterRewardBtn2 = null;
    self._chapterPreBtn = null;
    self._chapterNextBtn = null;
    self._point = null;
    self._openLen = 0;
    }
    constructor() {
         super();
         this.initView();
         this.initEvents();
         this.defaultView();
      }
    initView() {
         this._map = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCP.MapView");
         this._areaComboxBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.selectCP.AreaComBoxBg");
         this._areaCombox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("SelectCP.AreaCombox");
         this._cpInfoView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCp.InfoView");
         this._chapterRewardBtn1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.ChapterRewardBtn1");
         this._chapterRewardBtn2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.ChapterRewardBtn2");
         this._chapterPreBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.chapterPreBtn");
         this._chapterNextBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.chapterNextBtn");
         this._chapterRewardView = new ($.C("selectcampaign.view.ChapterRewardView"))();
         this.addChild(this._map);
         this.addChild(this._cpInfoView);
         this.addChild(this._areaComboxBg);
         this.addChild(this._areaCombox);
         this.addChild(this._chapterRewardBtn1);
         this.addChild(this._chapterRewardBtn2);
         this.addChild(this._chapterPreBtn);
         this.addChild(this._chapterNextBtn);
         this.addChild(this._chapterRewardView);
         this._chapterRewardView.x = 5;
         this._chapterRewardView.y = 80;
         this._chapterRewardView.visible = false;
         this._cpInfoView.visible = false;
      }
    sortFun(param1, param2) {
         if(param1.chapterId < param2.chapterId)
         {
            return -1;
         }
         if(param1.chapterId > param2.chapterId)
         {
            return 1;
         }
         return 0;
      }
    defaultView() {
         var _loc3_ = 0;
         var _loc2_ = 0;
         this._chapterList = this.model.selectedLand.chapterDic.getList();
         this._chapterList.sort($.bind(this, "sortFun"));
         this._areaCombox.beginChanges();
         this._areaCombox.selctedPropName = "text";
         var _loc1_ = this._areaCombox.listPanel.vectorListModel;
         _loc1_.clear();
         _loc3_ = 0;
         while(_loc3_ < this._chapterList.length)
         {
            _loc2_ = $.int(($.as(this._chapterList[_loc3_], $.C("mvc.module.selectcampaign.CampaignChapterInfo"))).chapterId);
            if(_loc2_ <= this.model.maxChapter.chapterId)
            {
               this._openLen = this._openLen + 1;
               _loc1_.append(this._chapterList[_loc3_]);
            }
            _loc3_++;
         }
         this._areaCombox.listPanel.list.updateListView();
         this._areaCombox.commitChanges();
         this._areaCombox.listPanel.list.defaultSelectItemByCellValue = this.model.recentChapter;
         this._currentIndex = this._chapterList.indexOf(this.model.recentChapter);
         this.setBtnState();
      }
    initEvents() {
         this._areaCombox.addEventListener("click",$.bind(this, "__onAreaComboxClick"));
         this._areaCombox.listPanel.list.addEventListener("listItemClick",$.bind(this, "__selectedChapterChange"));
         this._chapterRewardBtn1.addEventListener("click",$.bind(this, "__onRewardBtnClick"));
         this._chapterRewardBtn2.addEventListener("click",$.bind(this, "__onRewardBtnClick"));
         this._chapterPreBtn.addEventListener("click",$.bind(this, "__onAreaBtnClick"));
         this._chapterNextBtn.addEventListener("click",$.bind(this, "__onAreaBtnClick"));
         this.model.addEventListener("SELECTED_AREA_CHANGE",$.bind(this, "__areaChangeHandler"));
      }
    removeEvents() {
         this._areaCombox.removeEventListener("click",$.bind(this, "__onAreaComboxClick"));
         this._areaCombox.listPanel.list.removeEventListener("listItemClick",$.bind(this, "__selectedChapterChange"));
         this._chapterRewardBtn1.removeEventListener("click",$.bind(this, "__onRewardBtnClick"));
         this._chapterRewardBtn2.removeEventListener("click",$.bind(this, "__onRewardBtnClick"));
         this._chapterPreBtn.removeEventListener("click",$.bind(this, "__onAreaBtnClick"));
         this._chapterNextBtn.removeEventListener("click",$.bind(this, "__onAreaBtnClick"));
         this.model.removeEventListener("SELECTED_AREA_CHANGE",$.bind(this, "__areaChangeHandler"));
      }
    __onAreaComboxClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
      }
    __areaChangeHandler(param1) {
         this._cpInfoView.visible = true;
         if(param1.data != null)
         {
            this._point = $.as(param1.data, $.C("flash.geom.Point"));
         }
         if(this.model.selectedArea && this._point != null)
         {
            this._cpInfoView.visible = true;
            this._cpInfoView.x = this.model.selectedArea.posX + this._point.x - 10;
            this._cpInfoView.y = this.model.selectedArea.posY + this._point.y - 200;
            if(this._cpInfoView.y < 0)
            {
               if(this._cpInfoView.x > 620)
               {
                  this._cpInfoView.tipsGotoFrame(3);
                  this._cpInfoView.x -= 317;
               }
               else
               {
                  this._cpInfoView.tipsGotoFrame(2);
               }
               this._cpInfoView.y += 135;
            }
            else if(this._cpInfoView.x > 620)
            {
               this._cpInfoView.tipsGotoFrame(4);
               this._cpInfoView.x -= 317;
            }
            else
            {
               this._cpInfoView.tipsGotoFrame(1);
            }
         }
         else
         {
            this._cpInfoView.visible = false;
         }
         if(this.model.selectedChapter.isAllOpenArea())
         {
            this._chapterRewardBtn1.visible = false;
            this._chapterRewardBtn2.visible = true;
         }
         else
         {
            this._chapterRewardBtn1.visible = true;
            this._chapterRewardBtn2.visible = false;
         }
      }
    __onAreaBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this.model.selectedChapter.isAllLoaded())
         {
            return;
         }
         var _loc2_ = this._chapterList.indexOf(this.model.selectedChapter);
         switch(param1.target)
         {
            case this._chapterPreBtn:
               if(_loc2_ > 0)
               {
                  this._currentIndex = _loc2_ - 1;
                  this.model.selectedChapter = this._chapterList[this._currentIndex];
               }
               break;
            case this._chapterNextBtn:
               if(this.model.selectedChapter.chapterId < this.model.maxChapter.chapterId)
               {
                  this._currentIndex = _loc2_ + 1;
                  this.model.selectedChapter = this._chapterList[this._currentIndex];
               }
         }
         this._areaCombox.listPanel.list.defaultSelectItemByCellValue = this.model.selectedChapter;
         this.refreshFallGoods();
         this.setBtnState();
      }
    setBtnState() {
         this._chapterPreBtn.enable = this._currentIndex > 0;
         this._chapterNextBtn.enable = this._currentIndex < this._openLen - 1;
      }
    __onRewardBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._chapterRewardView.visible = !this._chapterRewardView.visible;
      }
    __selectedChapterChange(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(param1.cellValue == this.model.selectedChapter)
         {
            return;
         }
         this.model.selectedChapter = $.as(param1.cellValue, $.C("mvc.module.selectcampaign.CampaignChapterInfo"));
         this._currentIndex = this._chapterList.indexOf(this.model.selectedChapter);
         this.refreshFallGoods();
         this.setBtnState();
      }
    refreshFallGoods() {
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc8_ = null;
         this.clearFallGoodsCell();
         var _loc7_ = $.C("yishi.manager.TempleteManager").instance.districtTemplateCate.getTemplatesByID(this.model.selectedChapter.chapterId);
         if(!_loc7_ || _loc7_.length == 0)
         {
            return;
         }
         for (var _loc2_ of $.values(_loc7_))
         {
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selecteCP.DistrictGoodsCell");
            _loc5_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
            _loc5_.templateId = _loc2_.ItemId;
            _loc5_.count = _loc2_.Count;
            _loc3_.data = _loc5_;
            this._chapterRewardView.chapterRewardBox.addChild(_loc3_);
         }
         this._chapterRewardView.chapterRewardBox.refreshChildPos();
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.districtSSSTemplateCate.getTemplatesByID(this.model.selectedChapter.chapterId);
         if(!_loc4_ || _loc4_.length == 0)
         {
            this._chapterRewardView.chapterTipAsset.visible = true;
            return;
         }
         for (var _loc1_ of $.values(_loc4_))
         {
            _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selecteCP.DistrictGoodsCell");
            _loc8_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
            _loc8_.templateId = _loc1_.ItemId;
            _loc8_.count = _loc1_.Count;
            _loc6_.data = _loc8_;
            this._chapterRewardView.chapterSSSBox.addChild(_loc6_);
         }
         this._chapterRewardView.chapterSSSBox.refreshChildPos();
         this._chapterRewardView.chapterTipAsset.visible = false;
      }
    clearFallGoodsCell() {
         this._chapterRewardView.chapterRewardBox.disposeAllChildren();
         this._chapterRewardView.chapterRewardBox.refreshChildPos();
         this._chapterRewardView.chapterSSSBox.disposeAllChildren();
         this._chapterRewardView.chapterSSSBox.refreshChildPos();
      }
    get cpMapView() {
         return this._map;
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.selectCampaignControler.model;
      }
    get cpInfoView() {
         return this._cpInfoView;
      }
    dispose() {
         this.removeEvents();
         this.clearFallGoodsCell();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._chapterRewardView)
         {
            this._chapterRewardView.dispose();
         }
         this._chapterRewardView = null;
         if(this._cpInfoView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cpInfoView);
         }
         this._cpInfoView = null;
         if(this._areaCombox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._areaCombox);
         }
         this._areaCombox = null;
         if(this._map)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._map);
         }
         this._map = null;
         if(this._chapterRewardBtn1)
         {
            this._chapterRewardBtn1.dispose();
         }
         this._chapterRewardBtn1 = null;
         if(this._chapterRewardBtn2)
         {
            this._chapterRewardBtn2.dispose();
         }
         this._chapterRewardBtn2 = null;
         if(this._chapterPreBtn)
         {
            this._chapterPreBtn.dispose();
         }
         this._chapterPreBtn = null;
         if(this._chapterNextBtn)
         {
            this._chapterNextBtn.dispose();
         }
         this._chapterNextBtn = null;
         this._chapterList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._areaComboxBg);
         this._areaComboxBg = null;
         this._point = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set cpMapView(v) { super.cpMapView = v; }
    set model(v) { super.model = v; }
    set cpInfoView(v) { super.cpInfoView = v; }
  }
  $.meta(__AreaView, "selectcampaign.view.AreaView", ["Disposeable"]);
  return __AreaView;
}
deps["selectcampaign.view.AreaView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.geom.Point", "mvc.module.selectcampaign.CampaignChapterInfo", "selectcampaign.view.ChapterRewardView", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager", "yishi.manager.TempleteManager"];

defs["selectcampaign.view.CampaignInfoView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CampaignInfoView extends __Base {
    static $fields(self) {
    self._back1 = null;
    self._mapMask = null;
    self._mapIcon = null;
    self._mapNameIcon = null;
    self._goods = null;
    self._optimizeTxt = null;
    self._optimizeProfile = null;
    self._normalBtn = null;
    self._heroBtn = null;
    self._buttonGroup = null;
    self._startBtn = null;
    self._mopupBtnSprite = null;
    self._mopupBtn = null;
    self._checkFallGoodsBtn = null;
    self._info9CornerBg = null;
    self._closeBtn = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.selectCP.CampaignInfoBackMc");
         this._info9CornerBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.CampaignInfoView.9CornerBg");
         this._mapMask = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selectCP.mapMask.back");
         this._normalBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.NormalBtn");
         this._heroBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.HeroBtn");
         this._startBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.StartBtn");
         this._mopupBtnSprite = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selecteCP.MopupBtnStripView");
         this._mopupBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.MopupBtn");
         this._mapIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selecteCP.MapIcon",[$.bind(this, "loadComplete")]);
         this._mapNameIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selecteCP.MapNameBmp",[$.bind(this, "loadNameComplete")]);
         this._optimizeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.ProfileTxt");
         this._optimizeProfile = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.Profile");
         this._checkFallGoodsBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.checkFallGoodsBtn");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("campaignInfoView.CloseBtn");
         this._goods = new ($.C("selectcampaign.view.FallGoodsView"))();
         this._goods.x = 30;
         this._goods.y = 192;
         this._back1.y = 62;
         this._mopupBtnSprite.addChild(this._mopupBtn);
         this.addChild(this._goods);
         this.addChild(this._back1);
         this.addChild(this._info9CornerBg);
         this.addChild(this._mapIcon);
         this.addChild(this._mapNameIcon);
         this.addChild(this._mapMask);
         this.addChild(this._optimizeTxt);
         this.addChild(this._optimizeProfile);
         this.addChild(this._normalBtn);
         this.addChild(this._heroBtn);
         this.addChild(this._startBtn);
         this.addChild(this._mopupBtnSprite);
         this.addChild(this._checkFallGoodsBtn);
         this.addChild(this._closeBtn);
         this._checkFallGoodsBtn.text = $.C("manager.LanguageMgr").GetTranslation("selectcampaign.view.CampaignInfoView.checkFallGoodsBtn.text");
         this._buttonGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._buttonGroup.addSelectItem(this._normalBtn);
         this._buttonGroup.addSelectItem(this._heroBtn);
         this._goods.visible = false;
         this._optimizeTxt.visible = false;
         this._optimizeProfile.visible = false;
         if($.C("yishi.manager.ArmyManager").instance.thane.grades < 20)
         {
            this._mopupBtn.enable = false;
            this._mopupBtnSprite.tipData = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",20);
         }
         else
         {
            this._mopupBtn.enable = true;
         }
      }
    tipsGotoFrame(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._back1.gotoAndStop(param1);
      }
    loadComplete(param1 = null) {
         ($.as(this._mapIcon.content, $.C("flash.display.Bitmap"))).smoothing = false;
      }
    loadNameComplete(param1 = null) {
         ($.as(this._mapNameIcon.content, $.C("flash.display.Bitmap"))).smoothing = false;
      }
    initEvent() {
         this._buttonGroup.addEventListener("change",$.bind(this, "__selectedChangeHandler"));
         this._startBtn.addEventListener("click",$.bind(this, "__clickHandler"));
         this._mopupBtn.addEventListener("click",$.bind(this, "__mopupHandler"));
         this.model.addEventListener("SELECTED_AREA_CHANGE",$.bind(this, "__selectedAreaChangeHandler"));
         this._checkFallGoodsBtn.addEventListener("click",$.bind(this, "__checkFallGoodsHandler"));
         this._closeBtn.addEventListener("click",$.bind(this, "__onCloseBtnClick"));
         this._normalBtn.addEventListener("click",$.bind(this, "__normalBtnClick"));
         this._heroBtn.addEventListener("click",$.bind(this, "__normalBtnClick"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4192,$.bind(this, "__createFailHandler"));
      }
    removeEvent() {
         if(this._buttonGroup)
         {
            this._buttonGroup.removeEventListener("change",$.bind(this, "__selectedChangeHandler"));
         }
         if(this._startBtn)
         {
            this._startBtn.removeEventListener("click",$.bind(this, "__clickHandler"));
         }
         if(this._mopupBtn)
         {
            this._mopupBtn.removeEventListener("click",$.bind(this, "__mopupHandler"));
         }
         if(this.model)
         {
            this.model.removeEventListener("SELECTED_AREA_CHANGE",$.bind(this, "__selectedAreaChangeHandler"));
         }
         if(this._checkFallGoodsBtn)
         {
            this._checkFallGoodsBtn.removeEventListener("click",$.bind(this, "__checkFallGoodsHandler"));
         }
         if(this._closeBtn)
         {
            this._closeBtn.removeEventListener("click",$.bind(this, "__onCloseBtnClick"));
         }
         if(this._normalBtn)
         {
            this._normalBtn.removeEventListener("click",$.bind(this, "__normalBtnClick"));
         }
         if(this._heroBtn)
         {
            this._heroBtn.removeEventListener("click",$.bind(this, "__normalBtnClick"));
         }
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4192,$.bind(this, "__createFailHandler"));
      }
    __normalBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
      }
    __onCloseBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this.visible = false;
      }
    __createFailHandler(param1) {
      }
    __checkFallGoodsHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._goods.visible = !this._goods.visible;
      }
    clean() {
         this._buttonGroup.selectIndex = -1;
         this._optimizeProfile.setFrame(6);
         this._mapIcon.icon = null;
         this._mapNameIcon.icon = null;
         this._goods["data"] = "";
      }
    __selectedAreaChangeHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = false;
         this.clean();
         if(this.model.selectedArea == null)
         {
            return;
         }
         _loc2_ = this.model.selectedArea.getMapByDifficult(1);
         if($.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc2_.CampaignId] && $.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc2_.CampaignId].rank >= 5)
         {
            _loc3_ = true;
         }
         this._normalBtn.enable = !!this.model.normalMap;
         this._heroBtn.enable = !!this.model.heroMap && _loc3_;
         if(this._normalBtn.enable == false || this._normalBtn.selected == false)
         {
            this._normalBtn.alpha = 0.5;
         }
         if(this._heroBtn.enable == false || this._heroBtn.selected == false)
         {
            this._heroBtn.alpha = 0.5;
         }
         if(this.model.isNormalOpen() && Boolean(this.model.isHeroOpen()) && Boolean(this._heroBtn.enable))
         {
            this._buttonGroup.selectIndex = 1;
            this._heroBtn.alpha = 1;
         }
         else if(this.model.isNormalOpen())
         {
            this._buttonGroup.selectIndex = 0;
            this._normalBtn.alpha = 1;
         }
         if(this.model.taskCampaignTem)
         {
            this._buttonGroup.selectIndex = this.model.taskCampaignTem.DifficultyGrade - 1;
            this._buttonGroup.getSelectedItem().alpha = 1;
            this.model.taskCampaignTem = null;
         }
      }
    __clickHandler(param1) {
         if($.C("managers.FreedomTeamManager").instance.hasTeam)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("yishi.manager.WarlordsManager.str04"));
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = "";
         if(this.model.selectedArea == null)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("room.view.pve.instance.InstanceRightView.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if(this.model.selectCampaign == null)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("room.view.pve.instance.InstanceRightView.command02");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if(this.showThewAlert())
         {
            return;
         }
         $.C("net.SingWarSocketSendManager").sendStartCampaignScene(this.model.selectCampaign.CampaignId,1);
      }
    __mopupHandler(param1) {
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this.model.selectCampaign)
         {
            return;
         }
         if($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.weary < 20)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("selectcampaign.view.CampaignInfoView.noWeary");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("yishi.scene.SceneManager").instance.currentType == "OUTER_CITY_SCENE")
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.noMopupAlert"));
            return;
         }
         $.C("managers.MopupManager").instance.model.campaignId = this.model.selectCampaign.CampaignId;
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("mopup",1);
      }
    showThewAlert() {
         var _loc8_ = null;
         var _loc7_ = null;
         var _loc2_ = null;
         var _loc3_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.weary < 20;
         var _loc4_ = $.C("yishi.manager.SharedManager").instance.thewCheckDate;
         var _loc5_ = new Date();
         var _loc1_ = false;
         var _loc6_ = Boolean($.C("yishi.manager.SharedManager").instance.thewCheck);
         if(!_loc6_ || _loc4_.month <= _loc5_.month && _loc4_.date < _loc5_.date)
         {
            _loc1_ = true;
         }
         if(_loc3_ && _loc1_)
         {
            _loc8_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.CampaignNoWearyFrame");
            _loc8_.showNoWeary($.bind(this, "useWeary"));
            _loc8_.containerY = 18;
            if(this.model.selectCampaign.DifficultyGrade == 2)
            {
               _loc7_ = $.C("manager.LanguageMgr").GetTranslation("selectcampaign.view.CampaignInfoView.countContent");
            }
            else
            {
               _loc7_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.disclist04");
            }
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc2_,$.bind(this, "alerrBack"),null,"left",1,true);
         }
         return _loc3_ && _loc1_;
      }
    useWeary() {
         var _loc7_ = 0;
         var _loc4_ = 0;
         var _loc3_ = 0;
         var _loc2_ = null;
         var _loc5_ = 0;
         var _loc8_ = 0;
         var _loc6_ = false;
         var _loc1_ = [2030503,2030502,2030501,2030500];
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if($.C("yishi.manager.GoodsManager").instance.getGoodsNumByTempId(_loc1_[_loc4_]) > 0)
            {
               _loc6_ = true;
               _loc7_ = $.int(_loc1_[_loc4_]);
               break;
            }
            _loc4_++;
         }
         if(_loc6_)
         {
            _loc3_ = $.int($.C("yishi.manager.GoodsManager").instance.findPosById(_loc7_));
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc7_);
            if(_loc2_.Property1 == 5 && _loc2_.Property2 > 0)
            {
               _loc5_ = $.int(_loc2_.Property2);
               _loc8_ = 1;
               if(!this.checkWearyCanGet(_loc5_,_loc3_,_loc8_))
               {
                  return;
               }
               if(!this.checkWearyTodayCanGet(_loc5_,_loc3_,_loc8_))
               {
                  return;
               }
            }
            $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(_loc3_);
         }
         else
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("yishi.view.frame.TodayNotAlertFrame.noWearyPromptTips"));
         }
      }
    checkWearyCanGet(param1, param2, param3 = 1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc7_ = null;
         var _loc8_ = null;
         var _loc6_ = 200 - this.playerInfo.weary;
         if(param1 > _loc6_)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "wearyCanGetCallBack"),param1,param2,param3];
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command07",_loc6_);
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
    checkWearyTodayCanGet(param1, param2, param3 = 1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc7_ = null;
         var _loc8_ = null;
         var _loc6_ = 600 - this.playerInfo.wearyLimit;
         if(param1 > _loc6_)
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "wearyTodayCanGetCallBack"),param1,param2,param3,true];
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command06",600,_loc6_);
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
    wearyCanGetCallBack(param1, param2, param3, param4, param5 = 1) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if(param1)
         {
            if(this.checkWearyTodayCanGet(param3,param4,param5))
            {
               $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(param4,param5);
            }
         }
      }
    wearyTodayCanGetCallBack(param1, param2, param3, param4, param5 = 1, param6 = false) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if(param1)
         {
            $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(param4,param5);
         }
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    alerrBack(param1) {
         $.C("yishi.manager.SharedManager").instance.thewCheck = param1;
         $.C("yishi.manager.SharedManager").instance.thewCheckDate = new Date();
         $.C("yishi.manager.SharedManager").instance.saveThewCheck();
         $.C("net.SingWarSocketSendManager").sendStartCampaignScene(this.model.selectCampaign.CampaignId,1);
      }
    __selectedChangeHandler(param1) {
         var _loc2_ = null;
         if(!this._buttonGroup.getSelectedItem() || !this.model.selectedArea)
         {
            return;
         }
         if(this._buttonGroup.getSelectedItem() == this._normalBtn)
         {
            _loc2_ = this.model.selectedArea.getMapByDifficult(1);
            if(_loc2_)
            {
               this.model.selectCampaign = _loc2_;
            }
         }
         else if(this._buttonGroup.getSelectedItem() == this._heroBtn)
         {
            _loc2_ = this.model.selectedArea.getMapByDifficult(2);
            if(_loc2_)
            {
               this.model.selectCampaign = _loc2_;
            }
         }
         if(this._normalBtn.enable == false || this._normalBtn.selected == false)
         {
            this._normalBtn.alpha = 0.5;
            this._heroBtn.alpha = 1;
         }
         if(this._heroBtn.enable == false || this._heroBtn.selected == false)
         {
            this._normalBtn.alpha = 1;
            this._heroBtn.alpha = 0.5;
         }
         this.refreshMapView(_loc2_);
      }
    refreshMapView(param1) {
         this._mapIcon.icon = $.C("yishi.manager.PathManager").mapInstanceBigIconPath(param1.CampaignId);
         this._mapNameIcon.icon = $.C("yishi.manager.PathManager").mapInstanceRoomName(param1.CampaignId);
         if(param1.state == 1)
         {
            this._mopupBtn.visible = true;
         }
         else
         {
            this._mopupBtn.visible = false;
         }
         this._goods.data = param1.Item;
         for (var _loc2_ of $.values(this.rankInfoList))
         {
            if(_loc2_.campaignId == param1.CampaignId)
            {
               this._optimizeProfile.setFrame(_loc2_.rank);
            }
         }
      }
    get rankInfoList() {
         return $.C("yishi.manager.CampaignRankManager").instance.rankDic;
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.selectCampaignControler.model;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    get mopupBtn() {
         return this._mopupBtn;
      }
    get startBtn() {
         return this._startBtn;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._back1);
         this._back1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroBtn);
         this._heroBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._normalBtn);
         this._normalBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._startBtn);
         this._startBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goods);
         this._goods = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mapIcon);
         this._mapIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mapNameIcon);
         this._mapNameIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mapMask);
         this._mapMask = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._optimizeTxt);
         this._optimizeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._optimizeProfile);
         this._optimizeProfile = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buttonGroup);
         this._buttonGroup = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._checkFallGoodsBtn);
         this._checkFallGoodsBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._info9CornerBg);
         this._info9CornerBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._closeBtn);
         this._closeBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mopupBtn);
         this._mopupBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mopupBtnSprite);
         this._mopupBtnSprite = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerInfo(v) { super.playerInfo = v; }
    set rankInfoList(v) { super.rankInfoList = v; }
    set model(v) { super.model = v; }
    set thane(v) { super.thane = v; }
    set playerModel(v) { super.playerModel = v; }
    set mopupBtn(v) { super.mopupBtn = v; }
    set startBtn(v) { super.startBtn = v; }
  }
  $.meta(__CampaignInfoView, "selectcampaign.view.CampaignInfoView", ["Disposeable"]);
  return __CampaignInfoView;
}
deps["selectcampaign.view.CampaignInfoView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Bitmap", "flash.display.Sprite", "manager.LanguageMgr", "managers.FreedomTeamManager", "managers.MopupManager", "net.SingWarSocketSendManager", "selectcampaign.view.FallGoodsView", "yishi.manager.ArmyManager", "yishi.manager.CampaignRankManager", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.manager.SharedManager", "yishi.manager.TempleteManager", "yishi.scene.SceneManager", "yishi.service.managers.SocketManager", "yishi.service.managers.SocketSendManager", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["selectcampaign.view.CampaignPointView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CampaignPointView extends __Base {
    static $fields(self) {
    self._viewPoint = null;
    self._viewContent = null;
    self._effect = null;
    self._selected = false;
    self._data = null;
    self._state = null;
    self._hasTask = false;
    self._newIcon = null;
    self._taskIconMc = null;
    self._circle = null;
    self._profile = null;
    self._scaleBack = null;
    self._adjustColorFilter = null;
    self._glowFilter = null;
    self._tipsObject = null;
    self._areaNameTxt = null;
    self._recommendGrades = null;
    self._curUrl = null;
    }
    constructor(param1) {
         super();
         this._effect = param1;
         this.init();
         this.initEvent();
         this.mouseChildren = false;
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.selectCampaignControler.model;
      }
    init() {
         this._viewPoint = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selectCP.MapPoint");
         this._newIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.selectCP.NewIcon");
         this._taskIconMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCP.TaskIconMc");
         this._circle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.selectCP.Circle");
         this._profile = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selectCp.Profile");
         this._scaleBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCP.ScaleBack");
         this._areaNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("room.InstaneRight.recommendGrades");
         this._recommendGrades = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("room.InstaneRight.recommendGrades");
         this.addChild(this._viewPoint);
         this._taskIconMc.gotoAndStop(1);
         var _loc1_ = new ($.C("com.pickgliss.effect.AdjustColor"))();
         _loc1_.brightness = 17;
         _loc1_.contrast = 8;
         _loc1_.hue = 0;
         _loc1_.saturation = 0;
         this._adjustColorFilter = new ($.C("flash.filters.ColorMatrixFilter"))(_loc1_.CalculateFinalFlatArray());
         this._glowFilter = new ($.C("flash.filters.GlowFilter"))(16639897,1,10,10,1.3);
      }
    initEvent() {
         this.addEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.addEventListener("mouseOut",$.bind(this, "__outHandler"));
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this);
         this.addEventListener("interactive_double_click",$.bind(this, "__mouseDoubleClick"));
         this.addEventListener("interactive_click",$.bind(this, "__mouseClick"));
      }
    removeEvent() {
         this.removeEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.removeEventListener("mouseOut",$.bind(this, "__outHandler"));
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this);
         this.removeEventListener("interactive_double_click",$.bind(this, "__mouseDoubleClick"));
         this.removeEventListener("interactive_click",$.bind(this, "__mouseClick"));
      }
    showThewAlert() {
         var _loc8_ = null;
         var _loc7_ = null;
         var _loc2_ = null;
         var _loc3_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.weary < 20;
         var _loc4_ = $.C("yishi.manager.SharedManager").instance.thewCheckDate;
         var _loc5_ = new Date();
         var _loc1_ = false;
         var _loc6_ = Boolean($.C("yishi.manager.SharedManager").instance.thewCheck);
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc1_ = true;
         }
         if(_loc3_ && _loc1_)
         {
            _loc8_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.TodayNotAlertFrame");
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.disclist02");
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc2_,$.bind(this, "thewAlertBack"));
            _loc8_.containerY = 36;
         }
         return _loc3_ && _loc1_;
      }
    thewAlertBack(param1) {
         $.C("yishi.manager.SharedManager").instance.thewCheck = param1;
         $.C("yishi.manager.SharedManager").instance.thewCheckDate = new Date();
         $.C("yishi.manager.SharedManager").instance.saveThewCheck();
         this.enter();
      }
    enter() {
         var _loc1_ = null;
         var _loc2_ = false;
         _loc1_ = this._data.getMapByDifficult(1);
         if($.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc1_.CampaignId] && $.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc1_.CampaignId].rank >= 5)
         {
            _loc2_ = true;
         }
         var _loc3_ = this._data.getMapByDifficult(2) && _loc2_;
         var _loc4_ = $.int(_loc3_ ? this._data.getMapByDifficult(2).CampaignId : $.int(this._data.getMapByDifficult(1).CampaignId));
         $.C("net.SingWarSocketSendManager").sendStartCampaignScene(_loc4_,1);
      }
    alertBack(param1, param2) {
         if(param1)
         {
            if(this.showThewAlert())
            {
               return;
            }
            this.enter();
         }
      }
    get viewContent() {
         return this._viewContent;
      }
    get point() {
         var _loc1_ = new ($.C("flash.geom.Point"))();
         if(this._viewContent)
         {
            _loc1_ = new ($.C("flash.geom.Point"))(this._viewContent["namepos"].x,this._viewContent["namepos"].y);
         }
         return _loc1_;
      }
    __mouseClick(param1) {
         this.model.dispatchEvent(new ($.C("events.SelectCampaignEvent"))("SELECTED_AREA_CHANGE",this.point));
      }
    __mouseDoubleClick(param1) {
         var _loc4_ = null;
         var _loc5_ = false;
         this.model.point = this.point;
         this.model.selectedArea = this._data;
         _loc4_ = this._data.getMapByDifficult(1);
         if($.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc4_.CampaignId] && $.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc4_.CampaignId].rank >= 5)
         {
            _loc5_ = true;
         }
         var _loc6_ = !!this._data.getMapByDifficult(2) && _loc5_;
         var _loc7_ = $.C("manager.LanguageMgr").GetTranslation("selectcampaign.view.CampaignPointView.state01");
         var _loc8_ = $.C("manager.LanguageMgr").GetTranslation("selectcampaign.view.CampaignPointView.state02");
         var _loc9_ = _loc6_ ? _loc7_ : _loc8_;
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "alertBack")];
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc10_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
         var _loc11_ = $.C("manager.LanguageMgr").GetTranslation("selectcampaign.view.CampaignPointView.content",this._data.areaName + _loc9_);
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc10_,_loc11_,_loc2_,_loc3_,false,true,true);
      }
    __overHandler(param1) {
         if(this.selected || this._state == "default")
         {
            return;
         }
         if(this._viewContent)
         {
            this._viewContent["build_icon"].filters = [this._adjustColorFilter,this._glowFilter];
         }
      }
    __outHandler(param1) {
         if(this.selected || this._state == "default")
         {
            return;
         }
         if(this._viewContent)
         {
            this._viewContent["build_icon"].filters = null;
         }
      }
    ExistDiff() {
         var _loc1_ = null;
         var _loc2_ = false;
         if(this._data == null)
         {
            return false;
         }
         _loc1_ = this._data.getMapByDifficult(1);
         if($.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc1_.CampaignId] && $.C("yishi.manager.CampaignRankManager").instance.rankDic[_loc1_.CampaignId].rank >= 5)
         {
            _loc2_ = true;
         }
         return !!this._data.getMapByDifficult(2) && _loc2_;
      }
    refreshView() {
         var _loc3_ = null;
         this._hasTask = false;
         this._effect.gotoAndStop(1);
         if(!this._data)
         {
            this.visible = false;
            this.clearViewContent();
            return;
         }
         this.visible = true;
         this.mouseEnabled = true;
         this.buttonMode = true;
         var _loc1_ = this._data.getMapByDifficult(2);
         if(!_loc1_ || _loc1_.state != 0)
         {
            _loc1_ = this._data.getMapByDifficult(1);
         }
         if(_loc1_)
         {
            this._areaNameTxt.x = 15;
            this._areaNameTxt.text = _loc1_.CampaignName;
            this._areaNameTxt.width = this._areaNameTxt.textWidth + 10;
            this._recommendGrades.x = 45;
            this._recommendGrades.text = "Nv " + _loc1_.MinLevel + "-" + _loc1_.MaxLevel;
            this._recommendGrades.width = this._recommendGrades.textWidth + 10;
            if(_loc1_.state == 0)
            {
               this.mouseEnabled = false;
               this.buttonMode = false;
               this._state = "disable";
            }
            else if(_loc1_.state == 1)
            {
               this._state = "over";
               this.mouseEnabled = true;
            }
            else
            {
               this._state = "open";
               this.mouseEnabled = true;
               if(this._data.getMapByDifficult(1).MinLevel > this.thane.grades)
               {
                  this._state = "default";
                  this.mouseEnabled = false;
               }
            }
            if(this._state == "over" || this._state == "open" || this._state == "default")
            {
               _loc3_ = $.C("yishi.manager.TaskManage").instance.cate.mainTaskList;
               loop0:
               for (var _loc2_ of $.values(_loc3_))
               {
                  for (var _loc4_ of $.values(_loc2_.conditionList))
                  {
                     if(_loc4_.Para3 == _loc1_.CampaignId)
                     {
                        this._hasTask = true;
                        break loop0;
                     }
                  }
               }
            }
            this.startLoad();
         }
      }
    startLoad() {
         this.clearViewContent();
         var _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/singlecampaign1/" + this.model.selectedChapter.chapterId + "/" + this._data.areaId + ".swf";
         this._curUrl = _loc1_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,8,$.bind(this, "__onComplete"));
      }
    __onComplete(param1, param2) {
         if(this._curUrl != param1.url)
         {
            return;
         }
         if(!this._data)
         {
            return;
         }
         this.clearViewContent();
         if(param2)
         {
            this._viewContent = $.as(param2, $.C("flash.display.MovieClip"));
            this.updateState();
         }
         if(this._state != "default" && this._state != "disable")
         {
            this.selected = this._selected;
         }
         this._data.viewContentLoaded = true;
         this.dispatchEvent(new ($.C("events.SelectCampaignEvent"))("VIEW_CONTENT_LOADED"));
      }
    updateState() {
         var _loc1_ = null;
         this._viewContent.gotoAndStop(this._state);
         if(this._state == "open")
         {
            $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._viewContent["backContain"]);
            $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._viewContent["iconContain"]);
            this._viewContent["iconContain"].addChildAt(this._newIcon,0);
            this._viewContent["backContain"].addChildAt(this._scaleBack,0);
            this.updateInfoView();
         }
         else if(this._state == "over")
         {
            $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._viewContent["backContain"]);
            $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._viewContent["iconContain"]);
            this._viewContent["backContain"].addChild(this._profile);
            this._viewContent["backContain"].addChildAt(this._circle,0);
            this._viewContent["backContain"].addChildAt(this._scaleBack,0);
            this.updateInfoView();
            _loc1_ = $.C("yishi.manager.CampaignRankManager").instance.singleRankDic[this._data.areaId];
            this._profile.setFrame(_loc1_.rank);
         }
         else if(this._state == "default")
         {
            $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._viewContent["backContain"]);
            $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._viewContent["iconContain"]);
            this._viewContent["iconContain"].addChildAt(this._newIcon,0);
            this._viewContent["backContain"].addChildAt(this._scaleBack,0);
            this.updateInfoView();
         }
         if(this._hasTask)
         {
            this._viewContent["iconContain"].addChild(this._taskIconMc);
            this._taskIconMc.gotoAndPlay(1);
            if(this._tipsObject)
            {
               this._tipsObject.x = this.x + this._viewContent["iconContain"].x - this._tipsObject.width / 2;
               this._tipsObject.y = this.y + this._viewContent["iconContain"].y - this._tipsObject.height / 2;
               this._tipsObject.visible = true;
            }
         }
         this._viewPoint.addChild(this._viewContent);
      }
    setTips(param1) {
         this._tipsObject = param1;
      }
    updateInfoView() {
         if(this._viewContent["referencePoint"])
         {
            this._scaleBack.width = this._areaNameTxt.width + 30;
            this._viewContent["iconContain"].x = this._viewContent["backContain"].x = this._viewContent["build_icon"].x + (this._viewContent["build_icon"].width - this._viewContent["backContain"].width) / 2 - 30;
            this._viewContent["iconContain"].y = this._viewContent["backContain"].y - 10;
            this._viewContent["backContain"].addChild(this._areaNameTxt);
            this._viewContent["backContain"].addChild(this._recommendGrades);
            this._newIcon.x = this._areaNameTxt.width - 10;
            this._profile.x = this._areaNameTxt.width + 14;
            this._circle.x = this._areaNameTxt.width;
            this._recommendGrades.y = this._scaleBack.y + 25;
            this._areaNameTxt.y = this._scaleBack.y + 7;
         }
         else
         {
            this._viewContent["iconContain"].x = this._viewContent["backContain"].x;
            this._viewContent["iconContain"].y = this._viewContent["backContain"].y;
            this._viewContent["backContain"].addChild(this._areaNameTxt);
            this._viewContent["backContain"].addChild(this._recommendGrades);
            this._scaleBack.width = this._areaNameTxt.width + 30;
            this._scaleBack.x = -60;
            this._recommendGrades.y = this._scaleBack.y + 25;
            this._areaNameTxt.y = this._scaleBack.y + 7;
         }
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
      }
    get data() {
         return this._data;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    clearViewContent() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "__onComplete"));
         if(this._scaleBack && this._scaleBack.parent)
         {
            this._scaleBack.parent.removeChild(this._scaleBack);
         }
         if(this._profile && this._profile.parent)
         {
            this._profile.parent.removeChild(this._profile);
         }
         if(this._circle && this._circle.parent)
         {
            this._circle.parent.removeChild(this._circle);
         }
         if(this._taskIconMc)
         {
            this._taskIconMc.stop();
            if(this._taskIconMc.parent)
            {
               this._taskIconMc.parent.removeChild(this._taskIconMc);
            }
         }
         if(this._newIcon && this._newIcon.parent)
         {
            this._newIcon.parent.removeChild(this._newIcon);
         }
         if(this._viewContent && this._viewContent["build_icon"])
         {
            this._viewContent["build_icon"].filters = null;
         }
         if(this._viewContent && this._viewContent.parent)
         {
            this._viewContent.parent.removeChild(this._viewContent);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._viewContent);
         this._viewContent = null;
      }
    dispose() {
         this.removeEvent();
         this.clearViewContent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._viewPoint);
         this._viewPoint = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._effect);
         this._effect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._newIcon);
         this._newIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._taskIconMc);
         this._taskIconMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scaleBack);
         this._scaleBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._circle);
         this._circle = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profile);
         this._profile = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._adjustColorFilter);
         this._adjustColorFilter = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._glowFilter);
         this._glowFilter = null;
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._circle)
         {
            if(this._circle.bitmapData)
            {
               this._circle.bitmapData.dispose();
            }
            if(this._circle.parent)
            {
               this._circle.parent.removeChild(this._circle);
            }
            this._circle = null;
         }
         this._glowFilter = null;
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set autoSelect(param1) {
      }
    get selected() {
         return this._selected;
      }
    isSpecialArea() {
         if(this.data.areaId == 10701 || this.data.areaId == 10702)
         {
            return true;
         }
         return false;
      }
    set selected(param1) {
         var _loc2_ = null;
         this._selected = param1;
         if(!this._effect || !this._viewContent)
         {
            return;
         }
         if(this._selected)
         {
            _loc2_ = this._viewContent.localToGlobal(new ($.C("flash.geom.Point"))(this._viewContent["circle"].x,this._viewContent["circle"].y));
            _loc2_ = this.globalToLocal(_loc2_);
            if(this.isSpecialArea())
            {
               this._effect.x = _loc2_.x + 92;
               this._effect.y = _loc2_.y + 124;
            }
            else
            {
               this._effect.x = _loc2_.x - 28;
               this._effect.y = _loc2_.y - 15;
            }
            this.addChild(this._effect);
            this._effect.gotoAndPlay(1);
            this._viewContent["build_icon"].filters = [this._adjustColorFilter,this._glowFilter];
            this._viewContent.gotoAndStop(this._state);
         }
         else
         {
            this._viewContent["build_icon"].filters = null;
            this._viewContent.gotoAndStop(this._state);
         }
      }
    asDisplayObject() {
         return null;
      }
    set model(v) { super.model = v; }
    set viewContent(v) { super.viewContent = v; }
    set point(v) { super.point = v; }
    set thane(v) { super.thane = v; }
    get autoSelect() { return super.autoSelect; }
  }
  $.meta(__CampaignPointView, "selectcampaign.view.CampaignPointView", ["Disposeable", "ISelectable"]);
  return __CampaignPointView;
}
deps["selectcampaign.view.CampaignPointView"] = ["com.pickgliss.effect.AdjustColor", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.DoubleClickManager", "com.pickgliss.utils.ObjectUtils", "events.SelectCampaignEvent", "flash.display.MovieClip", "flash.display.Sprite", "flash.filters.ColorMatrixFilter", "flash.filters.GlowFilter", "flash.geom.Point", "manager.LanguageMgr", "net.SingWarSocketSendManager", "yishi.manager.ArmyManager", "yishi.manager.CampaignRankManager", "yishi.manager.FrameControllerManager", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.manager.SharedManager", "yishi.manager.TaskManage", "yishi.utils.SimpleAlertHelper"];

defs["selectcampaign.view.ChapterRewardView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChapterRewardView extends __Base {
    static $fields(self) {
    self.chapterRewardBox = null;
    self.chapterSSSBox = null;
    self.chapterTipAsset = null;
    self._bg = null;
    self._upBack = null;
    self._downBack = null;
    self._sssBack = null;
    self._lastBack = null;
    self._closeBtn = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvents();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.chapterRewardView.bg");
         this.chapterRewardBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.DistrictGoodsBox");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("chapterRewardView.CloseBtn");
         this._upBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.upBack");
         this._downBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.downBack");
         this._sssBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.selectCP.SSSBack");
         this._lastBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.selectCP.lastBack");
         this.chapterSSSBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.SSSGoodsBox");
         this.chapterTipAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selecteCP.chapterTipAsset");
         this.addChild(this._bg);
         this.addChild(this._upBack);
         this.addChild(this._downBack);
         this.addChild(this._sssBack);
         this.addChild(this._lastBack);
         this.addChild(this.chapterTipAsset);
         this.addChild(this.chapterRewardBox);
         this.addChild(this.chapterSSSBox);
         this.addChild(this._closeBtn);
         this.chapterTipAsset.text = $.C("manager.LanguageMgr").GetTranslation("selecteCP.chapterTipAsset");
         this.chapterTipAsset.visible = false;
      }
    initEvents() {
         this._closeBtn.addEventListener("click",$.bind(this, "__onCloseBtnClick"));
      }
    __onCloseBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this.visible = false;
      }
    removeEvent() {
         if(this._closeBtn)
         {
            this._closeBtn.removeEventListener("click",$.bind(this, "__onCloseBtnClick"));
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._closeBtn);
         this._closeBtn = null;
         for (var _loc1_ of $.values(this.chapterRewardBox))
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         if(this.chapterRewardBox)
         {
            this.chapterRewardBox.removeAllChild();
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.chapterRewardBox);
         this.chapterRewardBox = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ChapterRewardView, "selectcampaign.view.ChapterRewardView", ["Disposeable"]);
  return __ChapterRewardView;
}
deps["selectcampaign.view.ChapterRewardView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr"];

defs["selectcampaign.view.FallGoodsView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FallGoodsView extends __Base {
    static $fields(self) {
    self._data = null;
    self._bg = null;
    self._list = null;
    self._panel = null;
    self._itemList = null;
    self._isOVer = false;
    }
    constructor() {
         super();
         this.initView();
         this.initEvents();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.fallGoodsBG");
         this._list = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.fallGoodsList",[5]);
         this._panel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.fallGoodsPanel");
         this._panel.beginChanges();
         this._panel.setView(this._list);
         this._panel.commitChanges();
         this._panel.invalidateViewport();
         this.addChild(this._bg);
         this.addChild(this._panel);
         this._itemList = new $.Vector();
      }
    initEvents() {
      }
    removeEvents() {
      }
    _over(param1) {
         if(!this._data)
         {
            return;
         }
         this._isOVer = true;
         this.data = this._data;
      }
    _out(param1) {
         if(!this._data || param1.buttonDown)
         {
            return;
         }
         this._isOVer = false;
         this.data = this._data;
      }
    set data(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._data = param1;
         this.removeItems();
         if($.C("yishi.utils.StringHelper").isNullOrEmpty(param1))
         {
            return;
         }
         this.initList();
         this.setPanelHeight();
      }
    setPanelHeight() {
         this._panel.beginChanges();
         var _loc1_ = this._data.split(",");
         if(_loc1_.length > 5)
         {
            this._bg.height = 127;
            this._panel.height = 105;
         }
         else
         {
            this._bg.height = 75;
            this._panel.height = 50;
         }
         this._panel.commitChanges();
         this._panel.invalidateViewport();
         if(this._panel.vScrollbar.visible)
         {
            this._panel.x = 10;
         }
         else
         {
            this._panel.x = 4;
         }
      }
    initList() {
         var _loc3_ = 0;
         var _loc5_ = 0;
         var _loc2_ = null;
         var _loc6_ = null;
         var _loc1_ = this._data.split(",");
         var _loc4_ = $.int(_loc1_.length);
         if(_loc4_ > 5)
         {
            _loc3_ = _loc4_ > 10 ? 15 : 10;
         }
         else
         {
            _loc3_ = 5;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.fallGoods.BaseItemView");
            this._itemList.push(_loc2_);
            this._list.addChild(_loc2_);
            _loc6_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
            if(_loc5_ < _loc4_)
            {
               _loc6_.templateId = $.int(_loc1_[_loc5_]);
               this._itemList[_loc5_].data = _loc6_;
            }
            _loc5_++;
         }
      }
    removeItems() {
         var _loc1_ = null;
         while(this._itemList && this._itemList.length > 0)
         {
            _loc1_ = this._itemList.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         if(this._list)
         {
            this._list.refreshChildPos();
         }
         if(this._panel)
         {
            this._panel.invalidateViewport();
         }
      }
    dispose() {
         this.removeEvents();
         this.removeItems();
         this._itemList = null;
         if(this._bg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         }
         this._bg = null;
         if(this._list)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._list);
         }
         this._list = null;
         if(this._panel)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._panel);
         }
         this._panel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__FallGoodsView, "selectcampaign.view.FallGoodsView", ["Disposeable"]);
  return __FallGoodsView;
}
deps["selectcampaign.view.FallGoodsView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.datas.goods.GoodsInfo", "yishi.utils.StringHelper"];

defs["selectcampaign.view.SelectCpMapView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __SelectCpMapView extends __Base {
    static $fields(self) {
    self._map = null;
    self._mapShape = null;
    self._pointViewArr = null;
    self._pointArr = null;
    self._pointDataDic = null;
    self._buttonGroup = null;
    self._mapIcon = null;
    self._effect = null;
    self._tipsContainer = null;
    self._currentSelected = null;
    }
    constructor() {
         super();
         this.init();
         this.initEvent();
      }
    init() {
         this._map = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("selectCP.MapWorldIcon");
         this._mapShape = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.selectCP.MapShape");
         this.addChild(this._map);
         this._map.addChild(this._mapShape);
         this._mapShape.width = 930;
         this._effect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCP.PointEffect");
         this._tipsContainer = new ($.C("flash.display.Sprite"))();
         this.addChild(this._tipsContainer);
         this._pointViewArr = new $.Vector();
         this._pointArr = new $.Vector();
         this._pointDataDic = new ($.C("yishi.utils.SimpleDictionary"))(true);
         this._buttonGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
      }
    initEvent() {
         this.model.addEventListener("SELECTED_CHAPTER_CHANGE",$.bind(this, "__selectedChapterChangeHandler"));
         this._buttonGroup.addEventListener("change",$.bind(this, "__itemSelectedHandler"));
      }
    removeEvent() {
         this.model.removeEventListener("SELECTED_CHAPTER_CHANGE",$.bind(this, "__selectedChapterChangeHandler"));
         if(this._buttonGroup)
         {
            this._buttonGroup.removeEventListener("change",$.bind(this, "__itemSelectedHandler"));
         }
         for (var _loc1_ of $.values(this._pointViewArr))
         {
            _loc1_.removeEventListener("click",$.bind(this, "__itemSelectedHandler"));
         }
      }
    __itemSelectedHandler(param1) {
         param1 && $.C("com.pickgliss.utils.SoundManager").instance.play("018");
         this._currentSelected = $.as(this._buttonGroup.getSelectedItem(), $.C("selectcampaign.view.CampaignPointView"));
         if(this._currentSelected && this._currentSelected.viewContent == null)
         {
            this._currentSelected.addEventListener("VIEW_CONTENT_LOADED",$.bind(this, "__viewLoadedHandler"));
         }
         else if(this._currentSelected && this._currentSelected.data)
         {
            this.model.point = this._currentSelected.point;
            this.model.selectedArea = this._currentSelected.data;
         }
         else
         {
            this.model.selectedArea = null;
         }
      }
    __viewLoadedHandler(param1) {
         this._currentSelected.removeEventListener("VIEW_CONTENT_LOADED",$.bind(this, "__viewLoadedHandler"));
         if(this._currentSelected && this._currentSelected.data)
         {
            this.model.point = this._currentSelected.point;
            this.model.selectedArea = this._currentSelected.data;
         }
         else
         {
            this.model.selectedArea = null;
         }
      }
    __selectedChapterChangeHandler(param1) {
         this.refreshPointData();
         this.refreshPointView();
         this.refreshMap();
         this.defaultSelect();
      }
    defaultSelect() {
         var _loc1_ = null;
         this._buttonGroup.selectIndex = -1;
         if(this.model.taskCampaignTem)
         {
            _loc1_ = this.model.selectedChapter.getAreaByCampaignTem(this.model.taskCampaignTem);
         }
         else
         {
            _loc1_ = this.model.selectedChapter.getMaxSelectAewa();
         }
         if(_loc1_)
         {
            this._buttonGroup.selectIndex = _loc1_.areaId % 10 - 1;
         }
         else
         {
            this.__itemSelectedHandler(null);
         }
      }
    __onComplete(param1, param2) {
         if(!this._pointViewArr)
         {
            return;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mapIcon);
         this._mapIcon = null;
         if(param2)
         {
            this._mapIcon = $.as(param2, $.C("flash.display.MovieClip"));
            this._mapIcon.width = 930;
            this._map.addChildAt(this._mapIcon,0);
         }
         this.refreshLine();
      }
    refreshPointData() {
         var _loc2_ = 0;
         var _loc5_ = null;
         var _loc4_ = null;
         this.cleanPointData();
         this._pointArr.splice(0,this._pointArr.length);
         var _loc3_ = this.model.selectedChapter.areaDic.getList();
         _loc3_.sortOn("areaId");
         var _loc1_ = $.int(_loc3_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc5_ = $.as(_loc3_[_loc2_], $.C("mvc.module.selectcampaign.CampaignAreaInfo"));
            _loc4_ = new ($.C("flash.geom.Point"))();
            _loc4_.x = _loc5_.posX;
            _loc4_.y = _loc5_.posY;
            this._pointArr.push(_loc4_);
            this._pointDataDic.add(_loc4_.x + "_" + _loc4_.y,_loc5_);
            _loc2_++;
         }
      }
    cleanPointData() {
         this._buttonGroup.removeAllItem();
         this._pointDataDic.clear();
         for (var _loc1_ of $.values(this._pointViewArr))
         {
            _loc1_.data = null;
         }
      }
    refreshPointView() {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc1_ = null;
         var _loc4_ = 0;
         var _loc6_ = null;
         var _loc3_ = $.int(this._pointArr.length);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._tipsContainer);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._pointArr[_loc4_];
            if(_loc4_ < this._pointViewArr.length)
            {
               _loc2_ = $.as(this._pointViewArr[_loc4_], $.C("selectcampaign.view.CampaignPointView"));
            }
            else
            {
               _loc2_ = new ($.C("selectcampaign.view.CampaignPointView"))(this._effect);
               this._pointViewArr.push(_loc2_);
            }
            _loc1_ = $.as(this._pointDataDic[_loc5_.x + "_" + _loc5_.y], $.C("mvc.module.selectcampaign.CampaignAreaInfo"));
            _loc2_.x = _loc5_.x;
            _loc2_.y = _loc5_.y;
            if(_loc1_.getMapByDifficult(1).MinLevel <= this.thane.grades)
            {
               this._buttonGroup.addSelectItem(_loc2_);
            }
            _loc2_.data = _loc1_;
            _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("selectCP.TaskTip");
            _loc6_.x = _loc2_.x;
            _loc6_.y = _loc2_.y;
            _loc6_.addChild(this.createShape());
            _loc6_.tipData = $.C("manager.LanguageMgr").GetTranslation("selectcampaign.view.SelectCpMapView.TaskTipsText");
            _loc6_.visible = false;
            this._tipsContainer.addChild(_loc6_);
            _loc2_.setTips(_loc6_);
            this._map.addChild(_loc2_);
            _loc4_++;
         }
      }
    createShape(param1 = 36) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = new ($.C("flash.display.Shape"))();
         _loc2_.graphics.beginFill(16711680,0);
         _loc2_.graphics.drawRect(0,0,param1,param1);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
    refreshMap() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mapIcon);
         this._mapIcon = null;
         var _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/singlecampaign1/" + this.model.selectedChapter.chapterId + "/map/" + this.model.selectedChapter.chapterId + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,8,$.bind(this, "__onComplete"));
      }
    refreshLine() {
         var _loc2_ = 0;
         var _loc1_ = null;
         if(this._mapIcon)
         {
            _loc2_ = 0;
            for (var _loc3_ of $.values(this.model.selectedChapter.areaDic))
            {
               _loc1_ = _loc3_.getMapByDifficult(1);
               if(_loc1_ && _loc1_.state != 0)
               {
                  _loc2_ = _loc2_ > _loc1_.AreaId ? _loc2_ : $.int(_loc1_.AreaId);
               }
            }
            if(_loc2_ == 0)
            {
               _loc2_ = $.int(this.model.selectedChapter.chapterId + "01");
            }
            this._mapIcon.gotoAndStop(1);
         }
      }
    get pointViewArr() {
         return this._pointViewArr;
      }
    get model() {
         return this.control.model;
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.selectCampaignControler;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         var _loc1_ = null;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "__onComplete"));
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._map);
         this._map = null;
         while(this._pointViewArr && this._pointViewArr.length > 0)
         {
            _loc1_ = this._pointViewArr.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._pointViewArr = null;
         if(this._currentSelected)
         {
            this._currentSelected.dispose();
         }
         this._currentSelected = null;
         if(this._pointDataDic)
         {
            this._pointDataDic.clear();
         }
         this._pointDataDic = null;
         this._pointArr = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mapIcon);
         this._mapIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mapShape);
         this._mapShape = null;
         if(this._buttonGroup)
         {
            this._buttonGroup.dispose();
         }
         this._buttonGroup = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._effect);
         this._effect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    set pointViewArr(v) { super.pointViewArr = v; }
    set model(v) { super.model = v; }
    set control(v) { super.control = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__SelectCpMapView, "selectcampaign.view.SelectCpMapView", ["Disposeable"]);
  return __SelectCpMapView;
}
deps["selectcampaign.view.SelectCpMapView"] = ["com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.MovieClip", "flash.display.Shape", "flash.display.Sprite", "flash.geom.Point", "manager.LanguageMgr", "mvc.module.selectcampaign.CampaignAreaInfo", "selectcampaign.view.CampaignPointView", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.PathManager", "yishi.utils.SimpleDictionary"];

defs["worldboss.EnterBaseItemView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __EnterBaseItemView extends __Base {
    static $fields(self) {
    self.state = 0;
    }
    constructor() {
         super();
      }
    updateState() {
      }
    dispose() {
      }
  }
  $.meta(__EnterBaseItemView, "worldboss.EnterBaseItemView", ["Disposeable"]);
  return __EnterBaseItemView;
}
deps["worldboss.EnterBaseItemView"] = ["flash.display.Sprite"];

defs["worldboss.PvpSelectFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __PvpSelectFrame extends __Base {
    static $fields(self) {
    self._back = null;
    self._scrollPanel = null;
    self._help = null;
    self._vBox = null;
    self._txt = null;
    self._items = [];
    self._openType = 0;
    self._heroesBtn = null;
    self._vipOpenView = null;
    self._bufferView = null;
    self._openStepTimes = null;
    }
    constructor() {
         super();
         this.initView();
         this.initBufferView();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,480,320);
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PvpSelectFrame.FrameBack");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PvpSelectFrame.ScrollPanel");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.Vbox");
         this._txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PvpSelectFrame.Txt");
         this._heroesBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.pvp.warfight.HeroesButton");
         this._help = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.FriendList.help");
         this._vipOpenView = new ($.C("yishi.view.frame.NewVipOpenView"))(15);
         this.addToContent(this._back);
         this._back.y = 22;
         this.addToContent(this._scrollPanel);
         this.addToContent(this._txt);
         this._txt.y = 36;
         this.addToContent(this._vipOpenView);
         this._vipOpenView.x = 13;
         this._vipOpenView.y = 202;
         this.addToContent(this._help);
         this.addToContent(this._heroesBtn);
         this._scrollPanel.setView(this._vBox);
         this._help.tipData = $.C("manager.LanguageMgr").GetTranslation("worldboss.WorldBossFrame.helpTips02");
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("WarField_MaxCount");
         var _loc1_ = $.int(_loc4_ ? $.int(_loc4_.ConfigValue) : 2);
         var _loc2_ = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.warFieldCount);
         var _loc3_ = Math.max(_loc2_,0);
         this._txt.htmlText = $.C("manager.LanguageMgr").GetTranslation("PvpSelectFrame.countTxt") + this.toArialBold(_loc3_ + " / " + _loc1_);
         this._heroesBtn.visible = false;
      }
    initBufferView() {
         var _loc1_ = $.C("managers.MagicSpringManager").instance.model.checkIsExistBuffer(8);
         if(_loc1_)
         {
            this._bufferView = new ($.C("yishi.view.community.MagicSpringBufferAddView"))(_loc1_);
            this._bufferView.setDescText(_loc1_.tempInfo.Desc);
            this._bufferView.x = 235;
            this._bufferView.y = 205;
            this.addToContent(this._bufferView);
            this._back.height = 247;
            this.height = 355;
         }
         else
         {
            this._back.height = 227;
            this.height = 335;
         }
      }
    toArialBold(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
    initEvent() {
         if(this._heroesBtn)
         {
            this._heroesBtn.addEventListener("click",$.bind(this, "__openHerosFrame"));
         }
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         if(this._help)
         {
            this._help.addEventListener("click",$.bind(this, "__helpClick"));
         }
         this.playerInfo.addEventListener("WORLDBOSSSTATE",$.bind(this, "__updateStateListHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("UPDATE_WARFIGHT_STATE_LIST",$.bind(this, "__updateStateListHandler"));
      }
    removeEvent() {
         if(this._heroesBtn)
         {
            this._heroesBtn.removeEventListener("click",$.bind(this, "__openHerosFrame"));
         }
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._help)
         {
            this._help.removeEventListener("click",$.bind(this, "__helpClick"));
         }
         this.playerInfo.removeEventListener("WORLDBOSSSTATE",$.bind(this, "__updateStateListHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("UPDATE_WARFIGHT_STATE_LIST",$.bind(this, "__updateStateListHandler"));
      }
    __openHerosFrame(param1) {
         var e = param1;
         $.C("yishi.utils.CheckUIModuleUtil").instance.tryCall("sort",() =>
         {
            var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.createComponentGroupByStylename("worldboss.PvpHeroFrame");
            _loc1_.preFrame = "worldboss";
            _loc1_.show();
         });
      }
    __helpClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("003");
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.pvpHelperFrame");
         _loc2_.titleText = "worldboss.view.BaseHelpFrame.helpTitleText";
         _loc2_.helpHtmlStr = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.BaseHelpFrame.BattleHelpContent" + this.warType,this._openStepTimes);
         _loc2_.commitChanges();
         _loc2_.show();
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
    __updateStateListHandler(param1) {
         this.refreshList();
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    show(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._openType = param1;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("OPEN_CAMPAIGN_FRAME",null));
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("worldboss.WorldBossFrame.title02");
         this.refreshList();
         this.initEvent();
      }
    refreshList() {
         var _loc11_ = null;
         var _loc17_ = null;
         var _loc1_ = 0;
         var _loc20_ = null;
         var _loc7_ = 0;
         var _loc2_ = null;
         var _loc15_ = null;
         var _loc3_ = null;
         var _loc5_ = 0;
         var _loc16_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.sysCurtime;
         if(_loc16_.minutes >= 0 && _loc16_.minutes < 25)
         {
            _loc5_ = _loc16_.hours;
         }
         else
         {
            _loc5_ = _loc16_.hours + 1;
         }
         var _loc6_ = $.int($.C("ui.toptoolbar.TopBtnType").TIME_ACTIVE_BTNS.indexOf("rvr1"));
         var _loc12_ = $.C("ui.toptoolbar.view.TimeActiveBoxOpenTime").instance.getOpenTimeByIndex(_loc6_);
         var _loc14_ = $.int(_loc12_.length);
         var _loc18_ = 1;
         this._openStepTimes = "";
         var _loc13_ = Boolean($.C("managers.WorldBossManager").instance.pvpWarIsOpen);
         this._vBox.disposeAllChildren();
         this._items = [];
         var _loc9_ = null;
         var _loc8_ = null;
         var _loc10_ = null;
         var _loc4_ = null;
         var _loc21_ = 24;
         _loc7_ = 0;
         while(_loc7_ < _loc14_)
         {
            _loc20_ = _loc12_[_loc7_].split(",");
            if(_loc7_ == 0)
            {
               this._openStepTimes += _loc12_[_loc7_].replace(",","-");
            }
            else
            {
               this._openStepTimes += "," + _loc12_[_loc7_].replace(",","-");
            }
            _loc2_ = new ($.C("worldboss.pvp.WarFightItem"))();
            _loc11_ = _loc20_[0];
            _loc17_ = _loc20_[1];
            _loc1_ = $.int(_loc11_.split(":")[0]);
            _loc18_ = 1;
            if(_loc13_ && _loc5_ == _loc1_)
            {
               _loc18_ = 0;
            }
            if(this.warType == 1)
            {
               _loc2_.setDataTemp(this.warTemp.CampaignId,this.warTemp.CampaignName,_loc18_,_loc11_,_loc17_,this.warTemp.Description);
               this._items.push(_loc2_);
               if(_loc18_ == 0)
               {
                  _loc9_ = _loc2_;
               }
               else if(_loc1_ >= _loc5_ && _loc1_ < _loc21_)
               {
                  _loc10_ = _loc2_;
                  _loc21_ = _loc1_;
               }
            }
            else
            {
               _loc15_ = $.C("yishi.manager.TempleteManager").instance.pvpWarFightDic[4901];
               _loc2_.setDataTemp(_loc15_.CampaignId,_loc15_.CampaignName,_loc18_,_loc11_,_loc17_,_loc15_.Description);
               this._items.push(_loc2_);
               if(_loc18_ == 0)
               {
                  _loc9_ = _loc2_;
               }
               else if(_loc1_ >= _loc5_ && _loc1_ < _loc21_)
               {
                  _loc10_ = _loc2_;
                  _loc21_ = _loc1_;
               }
               _loc3_ = new ($.C("worldboss.pvp.WarFightItem"))();
               _loc15_ = $.C("yishi.manager.TempleteManager").instance.pvpWarFightDic[4101];
               _loc3_.setDataTemp(_loc15_.CampaignId,_loc15_.CampaignName,_loc18_,_loc11_,_loc17_,_loc15_.Description);
               this._items.push(_loc3_);
               if(_loc18_ == 0)
               {
                  _loc8_ = _loc3_;
               }
               else if(_loc10_ && _loc21_ == _loc1_)
               {
                  _loc4_ = _loc3_;
               }
            }
            _loc7_++;
         }
         if(_loc9_)
         {
            this._vBox.addChild(_loc9_);
            if(_loc8_)
            {
               this._vBox.addChild(_loc8_);
            }
         }
         if(_loc10_)
         {
            this._vBox.addChild(_loc10_);
            if(_loc4_)
            {
               this._vBox.addChild(_loc4_);
            }
         }
         for (var _loc19_ of $.values(this._items))
         {
            if(_loc19_ != _loc9_ && _loc19_ != _loc8_ && _loc19_ != _loc10_ && _loc19_ != _loc4_)
            {
               this._vBox.addChild(_loc19_);
            }
         }
         this._scrollPanel.invalidateViewport();
      }
    get warType() {
         if(this.thane.isAvenger)
         {
            return 3;
         }
         if(this.thane.isChangeJob)
         {
            return 2;
         }
         return 1;
      }
    get warTemp() {
         if(this.thane.isAvenger)
         {
            return $.C("yishi.manager.TempleteManager").instance.pvpWarFightDic[4901];
         }
         if(this.thane.isChangeJob)
         {
            return $.C("yishi.manager.TempleteManager").instance.pvpWarFightDic[4101];
         }
         return $.C("yishi.manager.TempleteManager").instance.pvpWarFightDic[4701];
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferView);
         this._bufferView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._txt);
         this._txt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroesBtn);
         this._heroesBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vipOpenView);
         this._vipOpenView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrollPanel);
         this._scrollPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set warType(v) { super.warType = v; }
    set warTemp(v) { super.warTemp = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__PvpSelectFrame, "worldboss.PvpSelectFrame", ["IManualSize"]);
  return __PvpSelectFrame;
}
deps["worldboss.PvpSelectFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.MagicSpringManager", "managers.WorldBossManager", "ui.toptoolbar.TopBtnType", "ui.toptoolbar.view.TimeActiveBoxOpenTime", "worldboss.pvp.WarFightItem", "yishi.events.NotificationEvent", "yishi.manager.ArmyManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.CheckUIModuleUtil", "yishi.view.community.MagicSpringBufferAddView", "yishi.view.frame.NewVipOpenView"];

defs["worldboss.WorldBossFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __WorldBossFrame extends __Base {
    static $fields(self) {
    self._back = null;
    self._scrollPanel = null;
    self._help = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.FriendList.help");
    self._vBox = null;
    self._items = [];
    }
    constructor() {
         super();
         this.initView();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,480,320);
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.FrameBack");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ScrollPanel");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.Vbox");
         this.addToContent(this._back);
         this.addToContent(this._scrollPanel);
         this._scrollPanel.setView(this._vBox);
         this._help.tipData = $.C("manager.LanguageMgr").GetTranslation("worldboss.WorldBossFrame.helpTips01");
         this._help.x = 392;
         this._help.y = 22;
      }
    addChildren() {
         super.addChildren();
         this.addChild(this._help);
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._help.addEventListener("click",$.bind(this, "__helpClick"));
         this.playerInfo.addEventListener("WORLDBOSSSTATE",$.bind(this, "__updateStateListHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("UPDATE_WARFIGHT_STATE_LIST",$.bind(this, "__updateStateListHandler"));
         this.stuntman.addEventListener("change",$.bind(this, "__updateStateListHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         this._help.removeEventListener("click",$.bind(this, "__helpClick"));
         this.playerInfo.removeEventListener("WORLDBOSSSTATE",$.bind(this, "__updateStateListHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("UPDATE_WARFIGHT_STATE_LIST",$.bind(this, "__updateStateListHandler"));
         this.stuntman.removeEventListener("change",$.bind(this, "__updateStateListHandler"));
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    __helpClick(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.worldbossHelperFrame");
         _loc2_["show"]();
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
    __updateStateListHandler(param1) {
         for (var _loc2_ of $.values(this._items))
         {
            _loc2_.updateState();
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         this.sornItems();
      }
    refreshList() {
         var _loc1_ = null;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.worldBossTemplateDict;
         for (var _loc3_ of $.values(_loc2_))
         {
            if(_loc3_.Types == 1)
            {
               _loc1_ = new ($.C("worldboss.view.WorldBossItem"))();
               _loc1_.worldBossTemplate = _loc3_;
               this._items.push(_loc1_);
            }
         }
         this.sornItems();
      }
    sornItems() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._items.sortOn("state",16);
         _loc2_ = 0;
         while(_loc2_ < this._items.length)
         {
            _loc1_ = $.as(this._items[_loc2_], $.C("worldboss.EnterBaseItemView"));
            this._vBox.addChild(_loc1_);
            _loc2_++;
         }
         this._scrollPanel.invalidateViewport();
      }
    get stuntman() {
         return $.C("managers.WorldBossManager").instance.stuntman;
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    show(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("OPEN_CAMPAIGN_FRAME",null));
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("worldboss.WorldBossFrame.title01");
         this.refreshList();
         this.initEvent();
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set stuntman(v) { super.stuntman = v; }
  }
  $.meta(__WorldBossFrame, "worldboss.WorldBossFrame", ["IManualSize"]);
  return __WorldBossFrame;
}
deps["worldboss.WorldBossFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.WorldBossManager", "worldboss.EnterBaseItemView", "worldboss.view.WorldBossItem", "yishi.events.NotificationEvent", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager"];

defs["worldboss.pvp.PvpHeroSortData"] = function define($) {
  const __Base = $.Object;
  class __PvpHeroSortData extends __Base {
    static $fields(self) {
    self.playerName = "";
    self.serverName = "";
    self.kill = "";
    self.honor = "";
    }
    constructor() {
         super();
      }
    getCellHeight() {
         return 33;
      }
  }
  $.meta(__PvpHeroSortData, "worldboss.pvp.PvpHeroSortData", ["INotSameHeightListCellData"]);
  return __PvpHeroSortData;
}
deps["worldboss.pvp.PvpHeroSortData"] = [];

defs["worldboss.pvp.WarFightItem"] = function define($) {
  const __Base = $.C("worldboss.EnterBaseItemView");
  class __WarFightItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._btn = null;
    self._icon = null;
    self._mapName = null;
    self._openTxt = null;
    self._openTimeTxt = null;
    self._descTxt = null;
    self._iconBack = null;
    self.campaignId = 0;
    }
    constructor() {
         super();
         this.state = 100000;
         this.init();
      }
    setDataTemp(param1, param2, param3, param4, param5, param6 = "") {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (param6 != null && typeof param6 !== "string") param6 = String(param6);
         this.campaignId = param1;
         this.state = param3;
         this.updateState();
         this._mapName.text = param2;
         this._openTxt.text = $.C("manager.LanguageMgr").GetTranslation("worldboss.pvp.WarFightItem.open");
         this._openTimeTxt.text = param4 + "-" + param5;
         this._descTxt.text = param6;
         this._icon.icon = $.C("yishi.utils.IconFactory").getPvpWarFight(this.campaignId);
      }
    updateState() {
         if(this.state == 0)
         {
            this._btn.visible = true;
            this._iconBack.visible = true;
            if(this._openTxt.parent)
            {
               this._openTxt.parent.removeChild(this._openTxt);
            }
            if(this._openTimeTxt.parent)
            {
               this._openTimeTxt.parent.removeChild(this._openTimeTxt);
            }
         }
         else
         {
            this._btn.visible = false;
            this._iconBack.visible = false;
            this.addChild(this._openTxt);
            this.addChild(this._openTimeTxt);
         }
      }
    init() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.worldboss.pvpwarfight.WarFightItemBgAsset");
         this.addChild(this._bg);
         this._iconBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemIconBack");
         this.addChild(this._iconBack);
         this._iconBack.visible = false;
         this._btn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.pvp.warfight.ItemButton");
         this.addChild(this._btn);
         this._btn.visible = false;
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("worldboss.ItemIcon");
         this.addChild(this._icon);
         this._mapName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.pvp.warfight.MapNameTxt");
         this.addChild(this._mapName);
         this._openTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.pvp.warfight.OpenTimeTxt");
         this.addChild(this._openTxt);
         this._openTimeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.pvp.warfight.OpenTimeValueTxt");
         this.addChild(this._openTimeTxt);
         this._descTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.pvp.warfight.DesTxt");
         this.addChild(this._descTxt);
         this._btn.addEventListener("click",$.bind(this, "__enterWarFightHandler"));
      }
    __enterWarFightHandler(param1) {
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("WarField_MaxCount");
         var _loc2_ = $.int(_loc4_ ? $.int(_loc4_.ConfigValue) : 2);
         var _loc3_ = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.warFieldCount);
         if(_loc3_ <= 0)
         {
            $.C("net.SingWarSocketSendManager").sendRequestPvpRemainNumber(this.campaignId);
            return;
         }
         $.C("net.SingWarSocketSendManager").enterWarfield(this.campaignId);
      }
    dispose() {
         if(this._btn)
         {
            this._btn.removeEventListener("click",$.bind(this, "__enterWarFightHandler"));
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iconBack);
         this._iconBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._btn);
         this._btn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mapName);
         this._mapName = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._openTxt);
         this._openTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._openTimeTxt);
         this._openTimeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._descTxt);
         this._descTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__WarFightItem, "worldboss.pvp.WarFightItem", []);
  return __WarFightItem;
}
deps["worldboss.pvp.WarFightItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "net.SingWarSocketSendManager", "worldboss.EnterBaseItemView", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["worldboss.view.BuyAvatarFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __BuyAvatarFrame extends __Base {
    static $fields(self) {
    self._pointBmp = null;
    self._selfTipTxt = null;
    self._submitButton = null;
    self._cancelButton = null;
    self._data = null;
    self.campaignId = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._pointBmp = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.PayType");
         this._selfTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.DescriptionTxt");
         this._submitButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.AlertButtonConfirm_2");
         this._cancelButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.AlertButtonCancel_1");
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("worldboss.BuyAvatarFrame.command01");
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance;
         var _loc3_ = 200;
         if(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price"))
         {
            _loc3_ = parseInt(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price").ConfigValue);
         }
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("worldboss.BuyAvatarFrame.command02",_loc3_);
         this._selfTipTxt.htmlText = _loc1_;
         var _loc2_ = this._selfTipTxt.getCharBoundaries(this._selfTipTxt.text.indexOf("$"));
         this._pointBmp.setFrame(1);
         this._pointBmp.y = this._selfTipTxt.y;
         this._pointBmp.x = _loc2_.x - 9;
         this._selfTipTxt.htmlText = _loc1_.replace("$","");
         this.addToContent(this._selfTipTxt);
         this.addToContent(this._pointBmp);
         this.addToContent(this._submitButton);
         this.addToContent(this._cancelButton);
         _loc4_ = null;
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResposeHandler"));
         this._submitButton.addEventListener("click",$.bind(this, "__onSubmitClick"));
         this._cancelButton.addEventListener("click",$.bind(this, "__onCancelClick"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResposeHandler"));
         this._submitButton.removeEventListener("click",$.bind(this, "__onSubmitClick"));
         this._cancelButton.removeEventListener("click",$.bind(this, "__onCancelClick"));
      }
    __onSubmitClick(param1 = null) {
         $.C("managers.WorldBossSocketOutManager").sendBuyStunmanFor(this.campaignId);
         $.C("managers.WorldBossManager").instance.stuntman.buyFor(this.campaignId);
         this.dispose();
      }
    __onCancelClick(param1) {
         this.dispose();
      }
    __frameResposeHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               this.dispose();
               break;
            case 2:
               this.__onSubmitClick();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,2);
      }
    dispose() {
         if(this.isDie)
         {
            return;
         }
         this.removeEvent();
         this._pointBmp = null;
         this._cancelButton = null;
         this._selfTipTxt = null;
         this._submitButton = null;
         super.dispose();
      }
  }
  $.meta(__BuyAvatarFrame, "worldboss.view.BuyAvatarFrame", []);
  return __BuyAvatarFrame;
}
deps["worldboss.view.BuyAvatarFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "manager.LanguageMgr", "managers.WorldBossManager", "managers.WorldBossSocketOutManager", "yishi.manager.TempleteManager"];

defs["worldboss.view.WorldBossHelp"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __WorldBossHelp extends __Base {
    static $fields(self) {
    self._back = null;
    self._desc = null;
    self._btn = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.worldbossHelperBack");
         this._desc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("worldboss.worldbossHelpertxt");
         this._btn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.worldbossHelperBtn");
         this.addToContent(this._back);
         this.addToContent(this._desc);
         this.addToContent(this._btn);
         this._btn.text = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.WorldBossHelp.title");
      }
    initEvent() {
         this._btn.addEventListener("click",$.bind(this, "__helpHandler"));
      }
    removeEvent() {
         this._btn.removeEventListener("click",$.bind(this, "__helpHandler"));
      }
    __helpHandler(param1) {
         this.dispose();
      }
    set closestyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._desc);
         this._desc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._btn);
         this._btn = null;
         super.dispose();
      }
    get closestyle() { return super.closestyle; }
  }
  $.meta(__WorldBossHelp, "worldboss.view.WorldBossHelp", []);
  return __WorldBossHelp;
}
deps["worldboss.view.WorldBossHelp"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.keyboard.KeyBoardRegister"];

defs["worldboss.view.WorldBossItem"] = function define($) {
  const __Base = $.C("worldboss.EnterBaseItemView");
  class __WorldBossItem extends __Base {
    static $fields(self) {
    self._back = null;
    self._iconBack = null;
    self._icon = null;
    self._name = null;
    self._level = null;
    self._time = null;
    self._desc = null;
    self._state = null;
    self._btnEff = null;
    self._worldBossTemplate = null;
    self._enterButton = null;
    self._buyAvatarButton = null;
    self._useState = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.worldboss.ItemBack");
         this._iconBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemIconBack");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("worldboss.ItemIcon");
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemName");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemLevel");
         this._time = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemTime");
         this._desc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemDesc");
         this._state = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemState");
         this._useState = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.UseState");
         this._enterButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.EnterButton");
         this._buyAvatarButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.buyAvatarTextButton");
         this._btnEff = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.ItemButtonMc");
         this._buyAvatarButton.text = $.C("manager.LanguageMgr").GetTranslation("WorldBossItem.shiyongtishen");
         this._buyAvatarButton.tipData = 30;
         this.addChild(this._back);
         this.addChild(this._iconBack);
         this.addChild(this._icon);
         this.addChild(this._name);
         this.addChild(this._level);
         this.addChild(this._time);
         this.addChild(this._desc);
         this.addChild(this._state);
         this.addChild(this._useState);
         this.addChild(this._enterButton);
         this.addChild(this._buyAvatarButton);
         this._enterButton.addChild(this._btnEff);
         this._btnEff.mouseChildren = this._btnEff.mouseChildren = false;
         this._enterButton.buttonMode = true;
         this._buyAvatarButton.buttonMode = true;
         this._buyAvatarButton.delayClickTime = 800;
         this._name.text = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.WorldBossItem.name");
         this._level.text = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.WorldBossItem.level");
         this._time.text = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.WorldBossItem.timetxt");
         this._desc.text = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.WorldBossItem.desc");
         this._state.text = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.WorldBossItem.state");
      }
    get worldBossTemplate() {
         return this._worldBossTemplate;
      }
    set worldBossTemplate(param1) {
         this._worldBossTemplate = param1;
         this.refreshView();
      }
    refreshView() {
         this._name.text = this._worldBossTemplate.CampaignName;
         this._level.text = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",this._worldBossTemplate.MinLevel);
         this._time.text = $.C("manager.LanguageMgr").GetTranslation("worldboss.view.WorldBossItem.time",this._worldBossTemplate.OpenTime,this._worldBossTemplate.StopTime);
         this._desc.text = this._worldBossTemplate.Description ? this._worldBossTemplate.Description : "";
         this._icon.icon = $.C("yishi.utils.IconFactory").getBossIcon(this._worldBossTemplate.CampaignId);
         this.updateState();
      }
    updateState() {
         this.state = this._worldBossTemplate.state;
         this._state.text = this._worldBossTemplate.stateValue;
         this._buyAvatarButton.visible = false;
         this._enterButton.visible = false;
         this._useState.visible = false;
         this._state.visible = false;
         this._enterButton.y = 10;
         if(this.state == 2)
         {
            this._state.visible = true;
         }
         else if(this.state == 1)
         {
            this._state.visible = true;
            this.updateBuyState();
         }
         else if(this.state == 0)
         {
            this._enterButton.visible = true;
            this._enterButton.y = 10;
         }
      }
    updateBuyState() {
         if(this.stuntman.hasBuyFor(this._worldBossTemplate.CampaignId))
         {
            this._buyAvatarButton.selected = true;
         }
         else
         {
            this._buyAvatarButton.selected = false;
         }
      }
    get stuntman() {
         return $.C("managers.WorldBossManager").instance.stuntman;
      }
    initEvent() {
         this._enterButton.addEventListener("click",$.bind(this, "__enterHander"));
         this._buyAvatarButton.addEventListener("click",$.bind(this, "__onBuyAvatarHandler"));
      }
    removeEvent() {
         this._enterButton.removeEventListener("click",$.bind(this, "__enterHander"));
         this._buyAvatarButton.removeEventListener("click",$.bind(this, "__onBuyAvatarHandler"));
      }
    __enterHander(param1) {
         var _loc2_ = null;
         if(this._worldBossTemplate.MinLevel > $.C("yishi.manager.ArmyManager").instance.thane.grades)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("activity.view.ActivityItem.command02");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
         }
         else if($.C("yishi.scene.SceneManager").instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("yishi.utils.WorldBossHelper").getCampaignTips());
         }
         else if(this.stuntman.hasBuyFor(this.worldBossTemplate.CampaignId))
         {
            this.alertWarning();
         }
         else
         {
            this.control.sendEnterBattle(this._worldBossTemplate);
         }
      }
    alertWarning() {
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "enter")];
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("worldboss.BuyAvatarFrame.command04");
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true);
      }
    enter(param1, param2) {
         if(param1)
         {
            this.control.sendEnterBattle(this._worldBossTemplate);
            this.control.sendCancelStunmanFor(this.worldBossTemplate.CampaignId);
            this.stuntman.cancelBuyFor(this.worldBossTemplate.CampaignId);
         }
      }
    __onBuyAvatarHandler(param1) {
         if($.C("managers.WorldBossManager").instance.stuntman.hasBuyFor(this._worldBossTemplate.CampaignId))
         {
            $.C("managers.WorldBossSocketOutManager").sendCancelStunmanFor(this._worldBossTemplate.CampaignId);
            $.C("managers.WorldBossManager").instance.stuntman.cancelBuyFor(this._worldBossTemplate.CampaignId);
         }
         else
         {
            $.C("managers.WorldBossSocketOutManager").sendBuyStunmanFor(this._worldBossTemplate.CampaignId);
            $.C("managers.WorldBossManager").instance.stuntman.buyFor(this._worldBossTemplate.CampaignId);
         }
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.worldBossControler;
      }
    dispose() {
         this.removeEvent();
         this._back = null;
         this._btnEff = null;
         this._buyAvatarButton = null;
         this._desc = null;
         this._enterButton = null;
         this._icon = null;
         this._iconBack = null;
         this._level = null;
         this._name = null;
         this._state = null;
         this._time = null;
         this._worldBossTemplate = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set stuntman(v) { super.stuntman = v; }
    set control(v) { super.control = v; }
  }
  $.meta(__WorldBossItem, "worldboss.view.WorldBossItem", []);
  return __WorldBossItem;
}
deps["worldboss.view.WorldBossItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.WorldBossManager", "managers.WorldBossSocketOutManager", "worldboss.EnterBaseItemView", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.scene.SceneManager", "yishi.utils.IconFactory", "yishi.utils.SimpleAlertHelper", "yishi.utils.WorldBossHelper", "yishi.view.tips.MessageTipManager"];
