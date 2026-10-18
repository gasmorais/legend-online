// @ts-nocheck
export const defs = {};
export const deps = {};
defs["buildings.BaseBuildFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __BaseBuildFrame extends __Base {
    static $fields(self) {
    self._describeBackground = null;
    self._lineBg = null;
    self._buildingBoxImg = null;
    self._recouceIcon = null;
    self._current = null;
    self._currentValue = null;
    self._next = null;
    self._nextValue = null;
    self._needResource = null;
    self._resourceValue = null;
    self._maxGrade = null;
    self._iconView = null;
    self._upgradeBtn = null;
    self._headContain = null;
    self._data$BaseBuildFrame = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    get groups() {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
    initView() {
         this._headContain = new ($.C("flash.display.Sprite"))();
         this._buildingBoxImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.castle.buildingBoxImg");
         this._lineBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.LineBg");
         this._describeBackground = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.DescribeBackground");
         this._recouceIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.castle.ResourceIcon");
         this._current = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.CurrentTxt");
         this._currentValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.CurrentValueTxt");
         this._next = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.NextTxt");
         this._nextValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.NextValueTxt");
         this._needResource = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.ResourceTxt");
         this._resourceValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.ResourceValueTxt");
         this._maxGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.MaxGrade");
         this._upgradeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.UpgradeBuildBtn");
         this._iconView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("castle.BuildIcon");
         this._headContain.addChild(this._buildingBoxImg);
         this._headContain.addChild(this._describeBackground);
         this._headContain.addChild(this._lineBg);
         this._headContain.addChild(this._current);
         this._current.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.current");
         this._headContain.addChild(this._currentValue);
         this._headContain.addChild(this._next);
         this._next.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.next");
         this._headContain.addChild(this._nextValue);
         this._headContain.addChild(this._needResource);
         this._needResource.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.needResource");
         this._headContain.addChild(this._resourceValue);
         this._headContain.addChild(this._maxGrade);
         this._maxGrade.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.maxGrade");
         this._maxGrade.visible = false;
         this._headContain.addChild(this._iconView);
         this.addToContent(this._headContain);
      }
    uninit() {
         this._data$BaseBuildFrame = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iconView);
         this._iconView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._maxGrade);
         this._maxGrade = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resourceValue);
         this._resourceValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needResource);
         this._needResource = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextValue);
         this._nextValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._next);
         this._next = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentValue);
         this._currentValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._current);
         this._current = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._recouceIcon);
         this._recouceIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buildingBoxImg);
         this._buildingBoxImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lineBg);
         this._lineBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describeBackground);
         this._describeBackground = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._upgradeBtn);
         this._upgradeBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._upgradeBtn.addEventListener("click",$.bind(this, "__upgradeClickHandler"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("BUILDING_UPGRADE_RECEIVE",$.bind(this, "__upgradeBuildingReceive"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._upgradeBtn)
         {
            this._upgradeBtn.removeEventListener("click",$.bind(this, "__upgradeClickHandler"));
         }
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("BUILDING_UPGRADE_RECEIVE",$.bind(this, "__upgradeBuildingReceive"));
      }
    __upgradeBuildingReceive(param1) {
         this.refreshView();
         var _loc2_ = param1.buildingInfo.templeteInfo;
         if(_loc2_.MasterType == 13 || _loc2_.MasterType == 14)
         {
            return;
         }
      }
    __upgradeClickHandler(param1) {
         if($.C("yishi.manager.BuildingManager").instance.isUpgradeAvaliable(this._data$BaseBuildFrame))
         {
            $.C("yishi.manager.BuildingManager").instance.upgradeBuildingByBuildingInfo(this._data$BaseBuildFrame);
         }
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
               this.dispose();
               break;
            case 1:
               this.dispose();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    refreshView() {
         this.titleText = this._data$BaseBuildFrame.templeteInfo.BuildingName + " " + $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06"," " + this._data$BaseBuildFrame.templeteInfo.BuildingGrade);
         var _loc2_ = this._data$BaseBuildFrame.templeteInfo;
         var _loc1_ = this._data$BaseBuildFrame.nextTemplateInfo;
         this._currentValue.htmlText = _loc2_.Activity + this.getMsAddValue(_loc2_);
         if(_loc1_)
         {
            this._recouceIcon.visible = true;
            this._next.visible = true;
            this._needResource.visible = true;
            this._nextValue.visible = true;
            this._resourceValue.visible = true;
            this._maxGrade.visible = false;
            this._nextValue.htmlText = _loc1_.Activity + this.getMsAddValue(_loc1_);
            this._resourceValue.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.needResource2",$.C("yishi.manager.ArmyManager").instance.thane.grades + 1);
         }
         else
         {
            this._maxGrade.visible = true;
            this._recouceIcon.visible = false;
            this._next.visible = false;
            this._needResource.visible = false;
            this._nextValue.visible = false;
            this._resourceValue.visible = false;
         }
         if($.C("yishi.manager.BuildingManager").instance.checkIsMaxLevel(this._data$BaseBuildFrame))
         {
            this._upgradeBtn.enable = false;
         }
      }
    getMsAddValue(param1) {
         var _loc4_ = 0;
         var _loc2_ = "";
         if(param1.SonType != 901)
         {
            return _loc2_;
         }
         var _loc3_ = $.C("managers.MagicSpringManager").instance.model.checkIsExistBuffer(1);
         if(_loc3_)
         {
            _loc4_ = Math.floor(_loc3_.tempInfo.AddValue * param1.Property1 / 100);
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("MagicSpringFrame.buffer.addText",_loc4_);
         }
         return _loc2_;
      }
    resetSize(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._describeBackground.width = param1 - 150;
         this._lineBg.width = param1;
         this._upgradeBtn.x = this._describeBackground.x + this._describeBackground.width + 23;
      }
    defaultView() {
         this._headContain.x = -7;
         this._headContain.y = 11;
         this._describeBackground.width = 402;
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         super.dispose();
      }
    get data() {
         return this._data$BaseBuildFrame;
      }
    set data(param1) {
         this._data$BaseBuildFrame = param1;
         this._iconView.icon = $.C("yishi.utils.IconFactory").getBuidIconByIcon(this._data$BaseBuildFrame.templeteInfo.Icon);
         this.refreshView();
      }
    get upgradeBtn() {
         return this._upgradeBtn;
      }
    get playerEffect() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerEffect;
      }
    set groups(v) { super.groups = v; }
    set upgradeBtn(v) { super.upgradeBtn = v; }
    set playerEffect(v) { super.playerEffect = v; }
  }
  $.meta(__BaseBuildFrame, "buildings.BaseBuildFrame", []);
  return __BaseBuildFrame;
}
deps["buildings.BaseBuildFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "managers.MagicSpringManager", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.PlayerManager", "yishi.utils.IconFactory"];

defs["buildings.casern.view.CasernFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __CasernFrame extends __Base {
    static $fields(self) {
    self._bg = null;
    self._pawnTileList = null;
    self._info = null;
    }
    constructor() {
         super();
         this.addEvent();
      }
    initView() {
         super.initView();
         this._headContain.x = -20;
         this._lineBg.x = 20;
         this._upgradeBtn.x = 538;
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("casern.ListBackground");
         this.addToContent(this._bg);
         this._pawnTileList = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("casern.PawnTileList");
         this.addToContent(this._pawnTileList);
         this.resetSize(this._bg.displayWidth);
      }
    addEvent() {
      }
    removeEvent() {
         super.removeEvent();
      }
    resetSize(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._describeBackground.width = 502;
         this._lineBg.width = param1;
      }
    refreshView() {
         super.refreshView();
         this._pawnTileList.refreshView();
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,620,460);
      }
    get pawnTileList() {
         return this._pawnTileList;
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.manager.FrameControllerManager").instance.armyController.autoAllocate();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pawnTileList);
         this._pawnTileList = null;
         this._info = null;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set pawnTileList(v) { super.pawnTileList = v; }
  }
  $.meta(__CasernFrame, "buildings.casern.view.CasernFrame", ["IManualSize"]);
  return __CasernFrame;
}
deps["buildings.casern.view.CasernFrame"] = ["buildings.BaseBuildFrame", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "flash.geom.Rectangle", "yishi.manager.FrameControllerManager"];

defs["buildings.crystal.view.CrystalFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __CrystalFrame extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.resetSize(630);
      }
    initView() {
         super.initView();
         if(this._lineBg.parent)
         {
            this._lineBg.parent.removeChild(this._lineBg);
         }
      }
  }
  $.meta(__CrystalFrame, "buildings.crystal.view.CrystalFrame", []);
  return __CrystalFrame;
}
deps["buildings.crystal.view.CrystalFrame"] = ["buildings.BaseBuildFrame"];

defs["buildings.depot.view.DepotFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __DepotFrame extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.resetSize(630);
      }
    initView() {
         super.initView();
         if(this._lineBg.parent)
         {
            this._lineBg.parent.removeChild(this._lineBg);
         }
      }
  }
  $.meta(__DepotFrame, "buildings.depot.view.DepotFrame", []);
  return __DepotFrame;
}
deps["buildings.depot.view.DepotFrame"] = ["buildings.BaseBuildFrame"];

defs["buildings.market.view.MarkertBuildFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __MarkertBuildFrame extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.defaultView();
      }
    initView() {
         super.initView();
         if(this._lineBg.parent)
         {
            this._lineBg.parent.removeChild(this._lineBg);
         }
      }
  }
  $.meta(__MarkertBuildFrame, "buildings.market.view.MarkertBuildFrame", []);
  return __MarkertBuildFrame;
}
deps["buildings.market.view.MarkertBuildFrame"] = ["buildings.BaseBuildFrame"];

defs["buildings.politics.data.FieldData"] = function define($) {
  const __Base = $.Object;
  class __FieldData extends __Base {
    static $fields(self) {
    self.mapId = 0;
    self.site = null;
    self.pos = null;
    self.fieldName = null;
    self.fieldGrade = 0;
    self.refreshTime = 0;
    self.createDate = null;
    self.yield = 0;
    }
    constructor() {
         super();
      }
  }
  $.meta(__FieldData, "buildings.politics.data.FieldData", []);
  return __FieldData;
}
deps["buildings.politics.data.FieldData"] = [];

defs["buildings.politics.view.FieldItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FieldItem extends __Base {
    static $fields(self) {
    self._background = null;
    self._nameText = null;
    self._posText = null;
    self._yieldText = null;
    self._timeDown = null;
    self._lookBtn = null;
    self._deleteBtn = null;
    self._data = null;
    }
    constructor() {
         super();
         this.init();
         this.initEvent();
      }
    init() {
         this._background = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.YieldItemBack");
         this._nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldNameValueText");
         this._posText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldPosValueText");
         this._yieldText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldYieldValueText");
         this._lookBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldLookButton");
         this._deleteBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldDeleteButton");
         this._timeDown = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.TimeDownView");
         this.addChild(this._background);
         this.addChild(this._nameText);
         this.addChild(this._posText);
         this.addChild(this._yieldText);
         this.addChild(this._timeDown);
         this.addChild(this._lookBtn);
         this.addChild(this._deleteBtn);
         this._background.setFrame(1);
         this._lookBtn.visible = false;
         this._lookBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.FieldItem.lookTipData");
         this._deleteBtn.visible = false;
         this._deleteBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.FieldItem.deleteTipData");
      }
    initEvent() {
         this._lookBtn.addEventListener("click",$.bind(this, "__lookHandler"));
         this._deleteBtn.addEventListener("click",$.bind(this, "__deleteHandler"));
      }
    removeEvent() {
         this._lookBtn.removeEventListener("click",$.bind(this, "__lookHandler"));
         this._deleteBtn.removeEventListener("click",$.bind(this, "__deleteHandler"));
      }
    __lookHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc4_ = new ($.C("map.internals.data.MapInitData"))();
         _loc4_.mapTempInfo = $.C("yishi.manager.TempleteManager").instance.mapTemplateCate.getTemplateByID(this._data.mapId);
         var _loc2_ = $.int($.C("map.internals.constant.MapGrid").getConvertWidth($.int(this._data.pos.split(",")[0])));
         var _loc3_ = $.int($.C("map.internals.constant.MapGrid").getConvertWidth($.int(this._data.pos.split(",")[1])));
         _loc4_.targetPoint = new ($.C("flash.geom.Point"))(_loc2_ * 50,_loc3_ * 50);
         $.C("yishi.scene.SceneManager").instance.setScene("OUTER_CITY_SCENE",_loc4_);
      }
    __deleteHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "giveUpField")];
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
         var _loc5_ = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.FieldItem.content");
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
    giveUpField(param1, param2) {
         if(param1)
         {
            if(this._data)
            {
               $.C("managers.BuildingSocketOutManager").unoccupy(this._data.pos);
            }
            else
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.FieldItem.content02"));
            }
         }
      }
    clean() {
         this._nameText.text = "";
         this._posText.text = "";
         this._yieldText.text = "";
         this._timeDown.pause();
         this._lookBtn.visible = false;
         this._deleteBtn.visible = false;
      }
    refreshView() {
         this.clean();
         if(!this._data)
         {
            return;
         }
         if($.C("yishi.manager.ArmyManager").instance.thane.grades > 8)
         {
            this._lookBtn.visible = true;
         }
         else
         {
            this._lookBtn.visible = false;
         }
         this._deleteBtn.visible = true;
         this._nameText.text = this._data.fieldName;
         this._posText.text = $.C("map.internals.constant.MapGrid").getPositionString(this._data.pos);
         this._yieldText.text = this._data.yield.toString();
         var _loc1_ = Number($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.sysCurTimeBySecond);
         var _loc2_ = Number(this._data.createDate.time);
         _loc2_ = _loc1_ * 1000 - _loc2_;
         var _loc3_ = Number(this._data.refreshTime);
         _loc3_ -= _loc2_ / 1000;
         _loc3_ = _loc3_ < 0 ? 0 : _loc3_;
         this._timeDown.timeCount = $.int(_loc3_);
         this._timeDown.start();
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._background);
         this._background = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameText);
         this._nameText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._posText);
         this._posText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._yieldText);
         this._yieldText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeDown);
         this._timeDown = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lookBtn);
         this._lookBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._deleteBtn);
         this._deleteBtn = null;
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__FieldItem, "buildings.politics.view.FieldItem", ["Disposeable"]);
  return __FieldItem;
}
deps["buildings.politics.view.FieldItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.geom.Point", "manager.LanguageMgr", "managers.BuildingSocketOutManager", "map.internals.constant.MapGrid", "map.internals.data.MapInitData", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.scene.SceneManager", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["buildings.politics.view.FildTitleItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FildTitleItem extends __Base {
    static $fields(self) {
    self._background = null;
    self._nameText = null;
    self._posText = null;
    self._yieldText = null;
    self._timeText = null;
    self._opText = null;
    }
    constructor() {
         super();
         this.init();
      }
    init() {
         this._background = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.TitleBack");
         this._nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldNameText");
         this._nameText.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.name");
         this._posText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldPosText");
         this._posText.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.pos");
         this._yieldText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldYieldText");
         this._yieldText.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.yield");
         this._timeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldTimeText");
         this._timeText.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.time");
         this._opText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.FieldOPText");
         this._opText.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.op");
         this.addChild(this._background);
         this.addChild(this._nameText);
         this.addChild(this._posText);
         this.addChild(this._yieldText);
         this.addChild(this._timeText);
         this.addChild(this._opText);
      }
    uninit() {
         this._background = null;
         this._nameText = null;
         this._posText = null;
         this._yieldText = null;
         this._timeText = null;
         this._opText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    dispose() {
         this.uninit();
      }
  }
  $.meta(__FildTitleItem, "buildings.politics.view.FildTitleItem", ["Disposeable"]);
  return __FildTitleItem;
}
deps["buildings.politics.view.FildTitleItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr"];

defs["buildings.politics.view.LevyQueueItem"] = function define($) {
  const __Base = $.C("ui.queuebar.view.QueueItem");
  class __LevyQueueItem extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this._back.width = 216;
         this._back.visible = true;
         this._back.x = 13;
         this._back.y = 2;
         this._button.visible = false;
         this._button.x = 204;
         this._button.y = 4;
         this._time.x = 146;
         this._title.y = 2;
         this._time.y = 4;
      }
    updateView() {
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.update");
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.update2");
         this.updateTxt(_loc1_,_loc2_);
         this.buttonMode = false;
         this._button.visible = this._data.remainTime > 0;
      }
    __overHandler(param1) {
      }
    __outHandler(param1) {
      }
  }
  $.meta(__LevyQueueItem, "buildings.politics.view.LevyQueueItem", []);
  return __LevyQueueItem;
}
deps["buildings.politics.view.LevyQueueItem"] = ["manager.LanguageMgr", "ui.queuebar.view.QueueItem"];

defs["buildings.politics.view.LevyView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __LevyView extends __Base {
    static $fields(self) {
    self._back = null;
    self._desTxt = null;
    self._levyTxt = null;
    self._levyValueTxt = null;
    self._levyGoldTxt = null;
    self._levyGoldValueTxt = null;
    self._levyBtn = null;
    self._levyBtnStrip = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
         this.refreshView();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.LevyBack");
         this._desTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.LevyDescTxt");
         this._levyTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.LevyTxt");
         this._levyValueTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.LevyValueTxt");
         this._levyGoldTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.LevyGoldTxt");
         this._levyGoldValueTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.LevyGoldValueTxt");
         this._levyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.LevyBtn");
         this._levyBtnStrip = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("politics.LevyBtnStrip");
         this.addChild(this._back);
         this.addChild(this._desTxt);
         this.addChild(this._levyTxt);
         this.addChild(this._levyValueTxt);
         this.addChild(this._levyGoldTxt);
         this.addChild(this._levyGoldValueTxt);
         this.addChild(this._levyBtn);
         this.addChild(this._levyBtnStrip);
         this._desTxt.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.LevyView.des");
         this._levyTxt.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.LevyView.levy");
         this._levyGoldTxt.text = $.C("manager.LanguageMgr").GetTranslation("buildings.politics.view.LevyView.levyGold");
         this._levyBtn.enable = false;
         this._levyBtnStrip.setTarget(this._levyBtn);
         this._levyBtnStrip.visible = this.thane.grades < 14;
         this._levyBtnStrip.tipData = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",14);
      }
    initEvent() {
         this._levyBtn.addEventListener("click",$.bind(this, "__levyHandler"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("COLL_ONE_ORDER",$.bind(this, "__orderChangeHandler"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("U_C_GOLD_IMPOSERESULT",$.bind(this, "__changeHandler"));
      }
    removeEvent() {
         this._levyBtn.removeEventListener("click",$.bind(this, "__levyHandler"));
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("COLL_ONE_ORDER",$.bind(this, "__orderChangeHandler"));
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("U_C_GOLD_IMPOSERESULT",$.bind(this, "__changeHandler"));
      }
    __levyHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.PlayerManager").instance.sendLevy();
      }
    __orderChangeHandler(param1) {
         this.refreshView();
      }
    __changeHandler(param1) {
         this.refreshView();
      }
    refreshView() {
         var _loc6_ = 0;
         var _loc5_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(901);
         if(_loc5_)
         {
            this._levyBtn.enable = _loc5_.property2 - _loc5_.property1 > 0 && this.thane.grades >= 14;
            this._levyValueTxt.text = _loc5_.property2 - _loc5_.property1 + " / " + _loc5_.property2;
         }
         var _loc1_ = _loc5_.templeteInfo.Property1 * 6;
         var _loc4_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(101);
         if(_loc4_)
         {
            _loc1_ += _loc4_.templeteInfo.Property1 * 3;
         }
         var _loc2_ = _loc1_ + "";
         var _loc3_ = $.C("managers.MagicSpringManager").instance.model.checkIsExistBuffer(1);
         if(_loc3_)
         {
            _loc6_ = Math.floor(_loc3_.tempInfo.AddValue * _loc1_ / 100);
            _loc2_ += $.C("manager.LanguageMgr").GetTranslation("MagicSpringFrame.buffer.addText",_loc6_);
         }
         if(this.thane.grades >= 14)
         {
            this._levyGoldValueTxt.htmlText = _loc2_;
         }
         else
         {
            this._levyGoldValueTxt.text = "0";
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get levyBtn() {
         return this._levyBtn;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._desTxt);
         this._desTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levyTxt);
         this._levyTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levyValueTxt);
         this._levyValueTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levyGoldTxt);
         this._levyGoldTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levyGoldValueTxt);
         this._levyGoldValueTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levyBtn);
         this._levyBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levyBtnStrip);
         this._levyBtnStrip = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    set thane(v) { super.thane = v; }
    set levyBtn(v) { super.levyBtn = v; }
  }
  $.meta(__LevyView, "buildings.politics.view.LevyView", ["Disposeable"]);
  return __LevyView;
}
deps["buildings.politics.view.LevyView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "manager.LanguageMgr", "managers.MagicSpringManager", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.PlayerManager"];

defs["buildings.politics.view.PoliticsFieldView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PoliticsFieldView extends __Base {
    static $fields(self) {
    self._fieldTitleItem = null;
    self._contain = null;
    self._defaltVBox = null;
    self._contentVBox = null;
    self._scrollpanel = null;
    self._data = null;
    self.CAPACITY = 4;
    }
    constructor() {
         super();
         this.init();
         this.initView();
         this.initEvent();
         this.__dataUpdateHandler(null);
      }
    init() {
         this._defaltVBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._defaltVBox.spacing = -2;
         this._contain = new ($.C("flash.display.Sprite"))();
         this._contentVBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._contentVBox.spacing = -2;
         this._contain.addChild(this._defaltVBox);
         this._fieldTitleItem = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("politics.FieldTitleItem");
         this.addChild(this._fieldTitleItem);
         this._scrollpanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("politics.ScrollPanel");
         this._scrollpanel.setView(this._contain);
         this.addChild(this._scrollpanel);
      }
    initView() {
         var _loc2_ = null;
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.CAPACITY)
         {
            _loc2_ = new ($.C("buildings.politics.view.FieldItem"))();
            this._defaltVBox.addChild(_loc2_);
            _loc1_++;
         }
         this._scrollpanel.invalidateViewport();
      }
    initEvent() {
         $.C("yishi.manager.BuildingManager").instance.addEventListener("U_SECURITY_INFO_UPDATE",$.bind(this, "__dataUpdateHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("U_SECURITY_INFO_UPDATE",$.bind(this, "__dataUpdateHandler"));
      }
    __dataUpdateHandler(param1) {
         this.refreshView($.C("yishi.manager.BuildingManager").instance.model.fieldDic);
      }
    refreshView(param1) {
         var _loc6_ = null;
         var _loc5_ = 0;
         var _loc7_ = null;
         this.clean();
         var _loc4_ = 0;
         var _loc2_ = param1.getList();
         _loc2_.sort($.bind(this, "sortOnTime"));
         var _loc3_ = $.int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc7_ = $.as(_loc2_[_loc5_], $.C("mvc.module.buildings.FieldData"));
            if(_loc7_.refreshTime > 0)
            {
               if(_loc4_ < this._defaltVBox.numChildren)
               {
                  _loc6_ = $.as(this._defaltVBox.getChildAt(_loc4_), $.C("buildings.politics.view.FieldItem"));
                  _loc6_.data = _loc7_;
               }
               else
               {
                  _loc6_ = new ($.C("buildings.politics.view.FieldItem"))();
                  _loc6_.data = _loc7_;
                  this._contentVBox.addChild(_loc6_);
               }
               _loc4_++;
            }
            _loc5_++;
         }
         this._contentVBox.y = this._defaltVBox.y + this._defaltVBox.height;
         this._contain.addChild(this._contentVBox);
         this._scrollpanel.invalidateViewport();
      }
    sortOnTime(param1, param2) {
         var _loc3_ = Number(param1.refreshTime);
         var _loc4_ = Number(param2.refreshTime);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
    clean() {
         var _loc2_ = null;
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.CAPACITY)
         {
            _loc2_ = $.as(this._defaltVBox.getChildAt(_loc1_), $.C("buildings.politics.view.FieldItem"));
            _loc2_.data = null;
            _loc1_++;
         }
         this._contentVBox.disposeAllChildren();
         this._contentVBox.refreshChildPos();
         this._scrollpanel.invalidateViewport();
      }
    set data(param1) {
         this._data = $.as(param1, "XML");
         this.refreshView(this._data.$descendants("wildLand").$descendants("building"));
      }
    dispose() {
         this.removeEvent();
         this._scrollpanel = null;
         this._data = null;
         this._contentVBox = null;
         this._fieldTitleItem = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__PoliticsFieldView, "buildings.politics.view.PoliticsFieldView", ["Disposeable"]);
  return __PoliticsFieldView;
}
deps["buildings.politics.view.PoliticsFieldView"] = ["buildings.politics.view.FieldItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "mvc.module.buildings.FieldData", "yishi.manager.BuildingManager"];

defs["buildings.politics.view.PoliticsFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __PoliticsFrame extends __Base {
    static $fields(self) {
    self._background = null;
    self._fieldList = null;
    self._levyView = null;
    self._data$PoliticsFrame = null;
    }
    constructor() {
         super();
         this.addEvent();
      }
    initView() {
         super.initView();
         this.resetSize(630);
         this._headContain.x = -20;
         this._lineBg.x = 20;
         this._upgradeBtn.x = 521;
         this._levyView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("politics.LevyView");
         this.addToContent(this._levyView);
      }
    addEvent() {
      }
    removeEvent() {
         super.removeEvent();
      }
    refreshView() {
         super.refreshView();
         this._levyView.refreshView();
      }
    uninit() {
         super.uninit();
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._background);
         this._background = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fieldList);
         this._fieldList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levyView);
         this._levyView = null;
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    get levyView() {
         return this._levyView;
      }
    set levyView(v) { super.levyView = v; }
  }
  $.meta(__PoliticsFrame, "buildings.politics.view.PoliticsFrame", []);
  return __PoliticsFrame;
}
deps["buildings.politics.view.PoliticsFrame"] = ["buildings.BaseBuildFrame", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils"];

defs["buildings.residence.view.ResidenceFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __ResidenceFrame extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.resetSize(630);
      }
    initView() {
         super.initView();
         if(this._lineBg.parent)
         {
            this._lineBg.parent.removeChild(this._lineBg);
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
  }
  $.meta(__ResidenceFrame, "buildings.residence.view.ResidenceFrame", []);
  return __ResidenceFrame;
}
deps["buildings.residence.view.ResidenceFrame"] = ["buildings.BaseBuildFrame", "com.pickgliss.ui.LayerManager"];

defs["buildings.seminary.event.TechnologyItemEvent"] = function define($) {
  const __Base = $.C("flash.events.Event");
  class __TechnologyItemEvent extends __Base {
    static $fields(self) {
    self.data = null;
    }
    constructor(param1, param2 = null, param3 = false, param4 = false) {
         super(param1,param3,param4);
         this.data = param2;
      }
  }
  $.meta(__TechnologyItemEvent, "buildings.seminary.event.TechnologyItemEvent", []);
  $.statics(__TechnologyItemEvent, () => {
    __TechnologyItemEvent.ITEM_CLICK = "ITEM_CLICK";
    __TechnologyItemEvent.CREATE = "CREATE";
    __TechnologyItemEvent.UPDATA = "UPDATA";
    __TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OVER = "technology_item_roll_over";
    __TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OUT = "technology_item_roll_out";
  });
  return __TechnologyItemEvent;
}
deps["buildings.seminary.event.TechnologyItemEvent"] = ["flash.events.Event"];

defs["buildings.seminary.view.InternalTechnologyList"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __InternalTechnologyList extends __Base {
    static $fields(self) {
    self._firstBuild = null;
    self._activeList$InternalTechnologyList = null;
    self._itemList$InternalTechnologyList = null;
    self._length$InternalTechnologyList = 0;
    self._row$InternalTechnologyList = 0;
    self._column$InternalTechnologyList = 0;
    }
    constructor() {
         super();
         if(!__InternalTechnologyList.itemGroup)
         {
            __InternalTechnologyList.itemGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         }
         this.init();
      }
    init() {
         var _loc3_ = 0;
         var _loc2_ = null;
         var _loc4_ = null;
         this._itemList$InternalTechnologyList = new ($.C("flash.utils.Dictionary"))();
         this._activeList$InternalTechnologyList = $.C("yishi.manager.BuildingManager").instance.model.buildingListByID;
         var _loc1_ = this._activeList$InternalTechnologyList.getList();
         _loc1_.sortOn("sonType");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = $.as(_loc1_[_loc3_], $.C("mvc.module.buildings.BuildInfo"));
            _loc4_ = _loc2_.templeteInfo;
            if(_loc4_.MasterType == 13)
            {
               this.addInterTecItem(_loc2_);
            }
            _loc3_++;
         }
         _loc1_ = null;
      }
    addInterTecItem(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.TechnologyItem");
         _loc2_.data = param1;
         this._row$InternalTechnologyList = this._length$InternalTechnologyList / 4;
         this._column$InternalTechnologyList = this._length$InternalTechnologyList % 4;
         _loc2_.x = this._column$InternalTechnologyList * 87 + 21;
         _loc2_.y = this._row$InternalTechnologyList * 105 + 8;
         this.addChild(_loc2_);
         __InternalTechnologyList.itemGroup.addSelectItem(_loc2_);
         this._itemList$InternalTechnologyList[param1.sonType] = _loc2_;
         this._length$InternalTechnologyList = this._length$InternalTechnologyList + 1;
         if(!this._firstBuild)
         {
            this._firstBuild = param1;
         }
      }
    unit() {
         for (var _loc1_ of $.values(this._itemList$InternalTechnologyList))
         {
            _loc1_.dispose();
         }
         if(__InternalTechnologyList.itemGroup)
         {
            __InternalTechnologyList.itemGroup.dispose();
            __InternalTechnologyList.itemGroup = null;
         }
         this._itemList$InternalTechnologyList = null;
         this._activeList$InternalTechnologyList = null;
      }
    dispose() {
         this.unit();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    getTechnologyTemplates() {
         return $.C("yishi.manager.TempleteManager").instance.buildTemplateCate.getInternalTechnologyTemplates();
      }
    get itemList() {
         return this._itemList$InternalTechnologyList;
      }
    get firstBuild() {
         return this._firstBuild;
      }
    set itemList(v) { super.itemList = v; }
    set firstBuild(v) { super.firstBuild = v; }
  }
  $.meta(__InternalTechnologyList, "buildings.seminary.view.InternalTechnologyList", ["Disposeable"]);
  $.statics(__InternalTechnologyList, () => {
    __InternalTechnologyList.itemGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
  });
  return __InternalTechnologyList;
}
deps["buildings.seminary.view.InternalTechnologyList"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.SelectedButtonGroup", "flash.display.Sprite", "flash.utils.Dictionary", "mvc.module.buildings.BuildInfo", "yishi.manager.BuildingManager", "yishi.manager.TempleteManager"];

defs["buildings.seminary.view.MilitaryTechnologyList"] = function define($) {
  const __Base = $.C("buildings.seminary.view.InternalTechnologyList");
  class __MilitaryTechnologyList extends __Base {
    static $fields(self) {
    self._activeList$MilitaryTechnologyList = null;
    self._itemList$MilitaryTechnologyList = null;
    self._length$MilitaryTechnologyList = 0;
    self._row$MilitaryTechnologyList = 0;
    self._column$MilitaryTechnologyList = 0;
    self._seminaryFrameBottomView = null;
    }
    constructor() {
         super();
      }
    init() {
         var _loc5_ = 0;
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc3_ = null;
         var _loc6_ = null;
         this._itemList$MilitaryTechnologyList = [];
         _loc5_ = 0;
         while(_loc5_ < 12)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.TechnologyItem");
            this.setItemPos(_loc2_);
            _loc2_.addEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OVER,$.bind(this, "_itemRollOverHandler"));
            _loc2_.addEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OUT,$.bind(this, "_itemRollOutHandler"));
            _loc2_.data = null;
            _loc2_.tipData = null;
            $.C("buildings.seminary.view.InternalTechnologyList").itemGroup.addSelectItem(_loc2_);
            this._itemList$MilitaryTechnologyList.push(_loc2_);
            this.addChild(_loc2_);
            _loc5_++;
         }
         this._activeList$MilitaryTechnologyList = $.C("yishi.manager.BuildingManager").instance.model.buildingListByID;
         var _loc1_ = this._activeList$MilitaryTechnologyList.getList();
         _loc1_.sortOn("sonType");
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = $.as(_loc1_[_loc4_], $.C("mvc.module.buildings.BuildInfo"));
            _loc6_ = _loc3_.templeteInfo;
            if(_loc6_.MasterType == 13 || _loc6_.MasterType == 14)
            {
               this.addMilitaryTecItem(_loc3_);
            }
            _loc4_++;
         }
         _loc1_ = null;
      }
    addMilitaryTecItem(param1) {
         if(!this._firstBuild)
         {
            this._firstBuild = param1;
         }
         for (var _loc2_ of $.values(this._itemList$MilitaryTechnologyList))
         {
            if(!_loc2_.data)
            {
               _loc2_.data = param1;
               _loc2_.tipData = param1;
               return;
            }
         }
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.TechnologyItem");
         this.setItemPos(_loc3_);
         _loc3_.data = param1;
         _loc3_.tipData = param1;
         $.C("buildings.seminary.view.InternalTechnologyList").itemGroup.addSelectItem(_loc3_);
         this._itemList$MilitaryTechnologyList.push(_loc3_);
         this.addChild(_loc3_);
      }
    setItemPos(param1) {
         this._row$MilitaryTechnologyList = this._length$MilitaryTechnologyList / 4;
         this._column$MilitaryTechnologyList = this._length$MilitaryTechnologyList % 4;
         param1.x = this._column$MilitaryTechnologyList * 181 + 8;
         param1.y = this._row$MilitaryTechnologyList * 90 + 8;
         this._length$MilitaryTechnologyList = this._length$MilitaryTechnologyList + 1;
      }
    set seminaryFrameBottomView(param1) {
         this._seminaryFrameBottomView = param1;
      }
    _itemRollOverHandler(param1) {
         if(this._seminaryFrameBottomView)
         {
            this._seminaryFrameBottomView.changeRed();
         }
      }
    _itemRollOutHandler(param1) {
         if(this._seminaryFrameBottomView)
         {
            this._seminaryFrameBottomView.revertColor();
         }
      }
    getTechItemByIndex(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this._itemList$MilitaryTechnologyList[param1];
      }
    dispose() {
         var _loc1_ = null;
         var _loc3_ = 0;
         if(!this._itemList$MilitaryTechnologyList)
         {
            return;
         }
         var _loc2_ = $.int(this._itemList$MilitaryTechnologyList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = $.as(this._itemList$MilitaryTechnologyList[_loc3_], $.C("buildings.seminary.view.TechnologyItem"));
            if(_loc1_.hasEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OVER))
            {
               _loc1_.removeEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OVER,$.bind(this, "_itemRollOverHandler"));
               _loc1_.removeEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OUT,$.bind(this, "_itemRollOutHandler"));
            }
            _loc3_++;
         }
         this._itemList$MilitaryTechnologyList = null;
         super.dispose();
      }
    get seminaryFrameBottomView() { return super.seminaryFrameBottomView; }
  }
  $.meta(__MilitaryTechnologyList, "buildings.seminary.view.MilitaryTechnologyList", ["Disposeable"]);
  return __MilitaryTechnologyList;
}
deps["buildings.seminary.view.MilitaryTechnologyList"] = ["buildings.seminary.event.TechnologyItemEvent", "buildings.seminary.view.InternalTechnologyList", "buildings.seminary.view.TechnologyItem", "com.pickgliss.ui.ComponentFactory", "mvc.module.buildings.BuildInfo", "yishi.manager.BuildingManager"];

defs["buildings.seminary.view.SeminaryFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __SeminaryFrame extends __Base {
    static $fields(self) {
    self._back1 = null;
    self._contain = null;
    self._bottomView = null;
    self._helpBtn = null;
    self._blessBtn = null;
    self._strip = null;
    self._prePage = null;
    self._nextPage = null;
    self._pageBack = null;
    self._pageTxt = null;
    self.itemGroup = null;
    self._itemList = null;
    self._firstBuild = null;
    self._currentPage = 1;
    self._totalPage = 1;
    }
    constructor() {
         super();
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
    initView() {
         super.initView();
         this._back1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.Back1");
         this._helpBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.HelpBtn");
         this._blessBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.BlessBtn");
         this._blessBtn.stopEffect();
         this._strip = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.BlessBtnTip");
         this._contain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.MilitaryTechnologyList");
         this._prePage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.PrePageBtn");
         this._nextPage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.NextPageBtn");
         this._pageBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.PageBack");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.PageTxt");
         this.addToContent(this._back1);
         this.addToContent(this._contain);
         this._helpBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrame.HelpBtn.Tipdata");
         this.showImp();
         this.refreshTec();
      }
    showImp() {
         var _loc4_ = 0;
         var _loc1_ = null;
         this._itemList = [];
         this.itemGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.TechnologyItem");
            _loc1_.x = _loc4_ % 4 * 181;
            _loc1_.y = $.int(_loc4_ / 4) * 90;
            _loc1_.addEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OVER,$.bind(this, "_itemRollOverHandler"));
            _loc1_.addEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OUT,$.bind(this, "_itemRollOutHandler"));
            _loc1_.data = null;
            _loc1_.tipData = null;
            this.itemGroup.addSelectItem(_loc1_);
            this._itemList.push(_loc1_);
            this._contain.addChild(_loc1_);
            _loc4_++;
         }
         this._bottomView = new ($.C("buildings.seminary.view.SeminaryFrameBottomView"))();
         this._bottomView.x = 3;
         this._bottomView.y = 376;
         this.addToContent(this._bottomView);
         this.resetSize(741);
         var _loc3_ = false;
         var _loc2_ = $.int($.C("yishi.manager.ArmyManager").instance.thane.grades);
         if(_loc3_)
         {
            this._describeBackground.width = 345;
            this.addToContent(this._strip);
            if(_loc2_ >= 41)
            {
               this._blessBtn.enable = true;
               if($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.isFirstSeminary)
               {
                  this._blessBtn.playEffect();
               }
               this._strip.tipData = "";
            }
            else
            {
               this._blessBtn.enable = false;
               this._strip.tipData = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrame.BlessAlert");
            }
         }
         this.addToContent(this._prePage);
         this.addToContent(this._nextPage);
         this.addToContent(this._pageBack);
         this.addToContent(this._pageTxt);
      }
    resetSize(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._describeBackground.width = 592;
         this._lineBg.width = param1;
         this._upgradeBtn.x = this._describeBackground.x + this._describeBackground.width + 10;
      }
    _itemRollOverHandler(param1) {
         if(this._bottomView)
         {
            this._bottomView.changeRed();
         }
      }
    _itemRollOutHandler(param1) {
         if(this._bottomView)
         {
            this._bottomView.revertColor();
         }
      }
    refreshTec() {
         var _loc5_ = null;
         var _loc7_ = null;
         var _loc2_ = null;
         var _loc6_ = 0;
         var _loc1_ = $.C("yishi.manager.BuildingManager").instance.model.buildingListByID.getList();
         _loc1_.sortOn("sonType");
         var _loc3_ = [];
         for (_loc5_ of $.values(_loc1_))
         {
            _loc7_ = _loc5_.templeteInfo;
            if(_loc7_.MasterType == 13 || _loc7_.MasterType == 14)
            {
               _loc3_.push(_loc5_);
            }
         }
         var _loc4_ = $.int(_loc3_.length);
         this._totalPage = Math.ceil(_loc4_ / 12);
         _loc6_ = 0;
         while(_loc6_ < this._itemList.length)
         {
            _loc2_ = $.as(this._itemList[_loc6_], $.C("buildings.seminary.view.TechnologyItem"));
            _loc2_.data = null;
            _loc2_.tipData = null;
            _loc5_ = $.as(_loc3_[_loc6_ + (this._currentPage - 1) * 12], $.C("mvc.module.buildings.BuildInfo"));
            if(!this._firstBuild)
            {
               this._firstBuild = _loc5_;
            }
            _loc2_.data = _loc5_;
            _loc2_.tipData = _loc5_;
            _loc6_++;
         }
         this._pageTxt.htmlText = "<font size=\'16\'>" + this._currentPage + "/" + this._totalPage + "</font>";
         this._prePage.enable = this._currentPage != 1;
         this._nextPage.enable = this._totalPage != this._currentPage;
      }
    uninit() {
         super.uninit();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back1);
         this._back1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contain);
         this._contain = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bottomView);
         this._bottomView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._helpBtn);
         this._helpBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blessBtn);
         this._blessBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._strip);
         this._strip = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    initEvent() {
         super.initEvent();
         $.C("yishi.manager.BuildingManager").instance.addEventListener("BUILDING_UPGRADE_RECEIVE",$.bind(this, "__technologyUpdateHandler"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("CREATE_NEW_BUILDING",$.bind(this, "__createNewTechItemHandler"));
         this._helpBtn.addEventListener("click",$.bind(this, "__onHelpClick"));
         this._blessBtn.addEventListener("click",$.bind(this, "__blessHandler"));
         this._prePage.addEventListener("click",$.bind(this, "__preClickHandler"));
         this._nextPage.addEventListener("click",$.bind(this, "__nextPageHandler"));
      }
    removeEvent() {
         var _loc2_ = 0;
         var _loc1_ = null;
         super.removeEvent();
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("BUILDING_UPGRADE_RECEIVE",$.bind(this, "__technologyUpdateHandler"));
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("CREATE_NEW_BUILDING",$.bind(this, "__createNewTechItemHandler"));
         this._helpBtn.removeEventListener("click",$.bind(this, "__onHelpClick"));
         this._blessBtn.removeEventListener("click",$.bind(this, "__blessHandler"));
         this._prePage.removeEventListener("click",$.bind(this, "__preClickHandler"));
         this._nextPage.removeEventListener("click",$.bind(this, "__nextPageHandler"));
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = $.as(this._itemList[_loc2_], $.C("buildings.seminary.view.TechnologyItem"));
            if(_loc1_)
            {
               _loc1_.removeEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OVER,$.bind(this, "_itemRollOverHandler"));
            }
            if(_loc1_)
            {
               _loc1_.removeEventListener($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OUT,$.bind(this, "_itemRollOutHandler"));
            }
            _loc2_++;
         }
      }
    __preClickHandler(param1) {
         if(this._currentPage > 1)
         {
            this._currentPage = this._currentPage - 1;
         }
         if(this._currentPage == 1)
         {
            this._prePage.enable = false;
         }
         this.refreshTec();
      }
    __nextPageHandler(param1) {
         if(this._currentPage < this._totalPage)
         {
            this._currentPage = this._currentPage + 1;
         }
         if(this._currentPage == this._totalPage)
         {
            this._nextPage.enable = false;
         }
         this.refreshTec();
      }
    __onHelpClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.SeminaryHelpFrame");
         _loc2_.show();
      }
    __blessHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.isFirstSeminary = false;
         this._blessBtn.stopEffect();
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("seminarybless");
         this.dispose();
      }
    __technologyUpdateHandler(param1) {
         var _loc2_ = param1.buildingInfo;
         var _loc3_ = _loc2_.templeteInfo;
         if(_loc3_.MasterType == 13 || _loc3_.MasterType == 14)
         {
            $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("buildings.seminary.event.TechnologyItemEvent"))($.C("buildings.seminary.event.TechnologyItemEvent").UPDATA,_loc2_));
         }
      }
    __createNewTechItemHandler(param1) {
         this.refreshTec();
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    getTechItemByIndex(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this._itemList[param1];
      }
    dispose() {
         super.dispose();
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
  }
  $.meta(__SeminaryFrame, "buildings.seminary.view.SeminaryFrame", []);
  return __SeminaryFrame;
}
deps["buildings.seminary.view.SeminaryFrame"] = ["buildings.BaseBuildFrame", "buildings.seminary.event.TechnologyItemEvent", "buildings.seminary.view.SeminaryFrameBottomView", "buildings.seminary.view.TechnologyItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "manager.LanguageMgr", "mvc.module.buildings.BuildInfo", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager"];

defs["buildings.seminary.view.SeminaryFrameBottomView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __SeminaryFrameBottomView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._ownCrystalNumText = null;
    self._resourcesTip = null;
    self._quickFrame = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.bg2Img");
         this._ownCrystalNumText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.ownCrystalNumText");
         this.onCrystalUpdate(null);
         this._resourcesTip = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.ResourcesTip");
         this._resourcesTip.setHitArea(0,0,190,47);
         this._resourcesTip.tipData = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.resourcesTip");
         this.addChild(this._bg);
         this.addChild(this._ownCrystalNumText);
         this.addChild(this._resourcesTip);
      }
    initEvent() {
         $.C("yishi.manager.BuildingManager").instance.addEventListener("COLL_ONE_ORDER",$.bind(this, "__coolSuccessHandler"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("USE_ONE_ORDER",$.bind(this, "__useOneOrderHandler"));
         $.C("yishi.manager.ResourceManager").instance.waterCrystal.addEventListener($.C("yishi.events.ResourceEvent").RESOURCE_UPDATE,$.bind(this, "onCrystalUpdate"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("TEC_UPGRADE_CLICK",$.bind(this, "__tecUpgradeHandler"));
      }
    onCrystalUpdate(param1) {
         if(this._ownCrystalNumText)
         {
            this._ownCrystalNumText.text = $.C("yishi.manager.ResourceManager").instance.waterCrystal.count + "";
         }
      }
    changeRed() {
         this._ownCrystalNumText.setFrame(2);
      }
    revertColor() {
         this._ownCrystalNumText.setFrame(1);
      }
    removeEvent() {
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("COLL_ONE_ORDER",$.bind(this, "__coolSuccessHandler"));
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("USE_ONE_ORDER",$.bind(this, "__useOneOrderHandler"));
         $.C("yishi.manager.ResourceManager").instance.waterCrystal.removeEventListener($.C("yishi.events.ResourceEvent").RESOURCE_UPDATE,$.bind(this, "onCrystalUpdate"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("TEC_UPGRADE_CLICK",$.bind(this, "__tecUpgradeHandler"));
      }
    __tecUpgradeHandler(param1) {
         var _loc2_ = false;
         var _loc4_ = null;
         var _loc3_ = $.as(param1.data, $.C("mvc.module.buildings.BuildInfo"));
         if(_loc3_)
         {
            _loc2_ = false;
            if(_loc3_.buildingId != 0)
            {
               _loc2_ = Boolean($.C("yishi.manager.BuildingManager").instance.model.isMaxLevel(_loc3_.buildingId));
               if(_loc2_)
               {
                  _loc4_ = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.isMaxLevelTip");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc4_);
                  return;
               }
               if($.C("yishi.manager.BuildingManager").instance.isUpgradeAvaliable(_loc3_))
               {
                  $.C("yishi.manager.BuildingManager").instance.upgradeBuildingByBuildingInfo(_loc3_);
               }
            }
            else
            {
               $.C("yishi.manager.BuildingManager").instance.creatBuilding(this.getTemp(_loc3_).SonType);
            }
         }
      }
    getTemp(param1) {
         var _loc2_ = null;
         if(param1.templateId != 0)
         {
            _loc2_ = param1.templeteInfo;
         }
         else
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.buildTemplateCate.getMinGradeBuildingTemplete(param1.sonType);
         }
         return _loc2_;
      }
    allCoolBack(param1, param2 = 0, param3 = 0, param4 = true) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         $.C("yishi.manager.BuildingManager").instance.allCoolBack(param1,param2,param3,param4);
         this._quickFrame = null;
      }
    __coolSuccessHandler(param1) {
      }
    __useOneOrderHandler(param1) {
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._ownCrystalNumText);
         this._ownCrystalNumText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resourcesTip);
         this._resourcesTip = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._quickFrame);
         this._quickFrame = null;
         if(this._resourcesTip)
         {
            this._resourcesTip.dispose();
         }
         this._resourcesTip = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__SeminaryFrameBottomView, "buildings.seminary.view.SeminaryFrameBottomView", ["Disposeable"]);
  return __SeminaryFrameBottomView;
}
deps["buildings.seminary.view.SeminaryFrameBottomView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.buildings.BuildInfo", "yishi.events.ResourceEvent", "yishi.manager.BuildingManager", "yishi.manager.NotificationManager", "yishi.manager.ResourceManager", "yishi.manager.TempleteManager", "yishi.view.tips.MessageTipManager"];

defs["buildings.seminary.view.TechnologyItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __TechnologyItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._overImg = null;
    self._level = null;
    self._name = null;
    self._upgradeBtn = null;
    self._levelBg = null;
    self._data = null;
    self._iconView = null;
    self._newIcon = null;
    self._temp = null;
    self._selected = false;
    self._isShowNewIcon = true;
    self._isShowName = false;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.technologyItemBg");
         this._bg.setFrame(1);
         this.addChild(this._bg);
         this._overImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.seminary.glowBgImg");
         this.addChild(this._overImg);
         this._overImg.visible = false;
         this._iconView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("seminary.technologyItem");
         this.addChild(this._iconView);
         this._levelBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.technologyItemLevelBg");
         this.addChild(this._levelBg);
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.technologyItemLevel");
         this._level.text = "";
         this.addChild(this._level);
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.technologyItemName");
         this._name.text = "";
         this._name.mouseEnabled = false;
         this.addChild(this._name);
         this._upgradeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("seminary.technologyItemUpgradeBtn");
         this._upgradeBtn.text = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.TechnologyItem.upgradeBtn.text");
         this.addChild(this._upgradeBtn);
      }
    uninit() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this._upgradeBtn = null;
         this._name = null;
         this._level = null;
         this._iconView = null;
         this._levelBg = null;
         this._bg = null;
      }
    initEvent() {
         this.addEventListener("rollOver",$.bind(this, "__itemOverHandler"));
         this.addEventListener("rollOut",$.bind(this, "__itemOutHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener($.C("buildings.seminary.event.TechnologyItemEvent").UPDATA,$.bind(this, "__onDataUpdateHandler"));
         this._upgradeBtn.addEventListener("click",$.bind(this, "__onUpgradeClick"));
      }
    removeEvent() {
         this.removeEventListener("rollOver",$.bind(this, "__itemOverHandler"));
         this.removeEventListener("rollOut",$.bind(this, "__itemOutHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener($.C("buildings.seminary.event.TechnologyItemEvent").UPDATA,$.bind(this, "__onDataUpdateHandler"));
         this._upgradeBtn.removeEventListener("click",$.bind(this, "__onUpgradeClick"));
      }
    __itemOverHandler(param1) {
         this._overImg.visible = true;
         this.checkCrystalsEnough();
      }
    __itemOutHandler(param1) {
         this._overImg.visible = false;
         this.dispatchEvent(new ($.C("buildings.seminary.event.TechnologyItemEvent"))($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OUT));
      }
    __onUpgradeClick(param1) {
         if(this._data)
         {
            $.C("com.pickgliss.utils.SoundManager").instance.play("022");
            $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("TEC_UPGRADE_CLICK",this._data));
         }
      }
    __onDataUpdateHandler(param1) {
         var _loc2_ = param1.data;
         if(_loc2_ && this._data && _loc2_.sonType == this._data.sonType)
         {
            this.data = _loc2_;
            this.onPropertiesChanged("tipData");
            this.checkCrystalsEnough();
         }
      }
    checkCrystalsEnough() {
         if(this._data)
         {
            if(this.getNextGrade(this._temp) && ($.as(this._data.getNextNeedResource(this.getNextGrade(this._temp)), $.C("flash.utils.Dictionary")))["CrystalsConsume"] > $.C("yishi.manager.ResourceManager").instance.waterCrystal.count)
            {
               this.dispatchEvent(new ($.C("buildings.seminary.event.TechnologyItemEvent"))($.C("buildings.seminary.event.TechnologyItemEvent").TECHNOLOGY_ITEM_ROLL_OVER));
            }
         }
      }
    get upgradeBtn() {
         return this._upgradeBtn;
      }
    getTipContent(param1) {
         return null;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         if(!this._data)
         {
            this._iconView.icon = null;
            this.isShowName = false;
            this.isShowNewIcon = false;
            this._bg.setFrame(1);
            return;
         }
         this.isShowName = true;
         this._temp = this.getTemp(this._data);
         this._iconView.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(this._temp.Icon);
         if(this._temp.TemplateId > 200000)
         {
            this._bg.setFrame(2);
         }
         else
         {
            this._bg.setFrame(1);
         }
         if(this._data.templeteInfo.BuildingGrade == 0)
         {
            this._newIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.seminary.newIconImg");
            this.addChild(this._newIcon);
            this.isShowNewIcon = true;
            this._newIcon.visible = this.isShowNewIcon;
            this._level.visible = false;
            this._levelBg.visible = false;
         }
         else if(this._newIcon)
         {
            if(this._newIcon.parent)
            {
               this._newIcon.parent.removeChild(this._newIcon);
            }
            this._newIcon = null;
         }
         if(this.isShowName)
         {
            if(this._temp.BuildingGrade)
            {
               this._level.text = String(this._temp.BuildingGrade);
            }
            this._name.text = this._temp.BuildingName;
         }
      }
    set isShowNewIcon(param1) {
         this._isShowNewIcon = param1;
         if(this._newIcon)
         {
            this._newIcon.visible = this._isShowNewIcon;
         }
      }
    get isShowNewIcon() {
         return this._isShowNewIcon;
      }
    set isShowName(param1) {
         this._level.visible = param1;
         this._levelBg.visible = param1;
         this._name.visible = param1;
         this._upgradeBtn.visible = param1;
         this._isShowName = param1;
      }
    get isShowName() {
         return this._isShowName;
      }
    getTemp(param1) {
         var _loc2_ = null;
         if(param1.templateId != 0)
         {
            _loc2_ = param1.templeteInfo;
         }
         else
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.buildTemplateCate.getMinGradeBuildingTemplete(param1.sonType);
         }
         return _loc2_;
      }
    set autoSelect(param1) {
      }
    get selected() {
         return this._selected;
      }
    set selected(param1) {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         if(this._selected)
         {
            $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("buildings.seminary.event.TechnologyItemEvent"))($.C("buildings.seminary.event.TechnologyItemEvent").ITEM_CLICK,this._data));
         }
      }
    getNextGrade(param1) {
         if(param1.NextGradeTemplateId != 0)
         {
            return $.C("yishi.manager.TempleteManager").instance.buildTemplateCate.getTemplateByID($.int(param1.NextGradeTemplateId));
         }
         return null;
      }
    asDisplayObject() {
         return this;
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         super.dispose();
      }
    set upgradeBtn(v) { super.upgradeBtn = v; }
    get autoSelect() { return super.autoSelect; }
  }
  $.meta(__TechnologyItem, "buildings.seminary.view.TechnologyItem", ["ISelectable"]);
  return __TechnologyItem;
}
deps["buildings.seminary.view.TechnologyItem"] = ["buildings.seminary.event.TechnologyItemEvent", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.utils.Dictionary", "manager.LanguageMgr", "yishi.events.NotificationEvent", "yishi.manager.NotificationManager", "yishi.manager.ResourceManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["buildings.seminary.view.TechnologyOrderItemView"] = function define($) {
  const __Base = $.C("ui.queuebar.view.QueueItem");
  class __TechnologyOrderItemView extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this._back.width -= 23;
         this._back.visible = true;
         this._button.x = 165;
         this._button.y = 3;
         this._time.x = 112;
         this._time.y = 3;
      }
    updateView() {
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.TechnologyOrderItemView.content");
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("buildings.seminary.view.TechnologyOrderItemView.content2");
         this.updateTxt(_loc1_,_loc2_);
         this.buttonMode = false;
      }
    __overHandler(param1) {
      }
    __outHandler(param1) {
      }
    set backVisible(param1) {
         if(this._back)
         {
            this._back.visible = param1;
         }
      }
    get backVisible() { return super.backVisible; }
  }
  $.meta(__TechnologyOrderItemView, "buildings.seminary.view.TechnologyOrderItemView", []);
  return __TechnologyOrderItemView;
}
deps["buildings.seminary.view.TechnologyOrderItemView"] = ["manager.LanguageMgr", "ui.queuebar.view.QueueItem"];

defs["buildings.titan.view.TitanFrame"] = function define($) {
  const __Base = $.C("buildings.BaseBuildFrame");
  class __TitanFrame extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.defaultView();
      }
    initView() {
         super.initView();
         if(this._lineBg.parent)
         {
            this._lineBg.parent.removeChild(this._lineBg);
         }
      }
  }
  $.meta(__TitanFrame, "buildings.titan.view.TitanFrame", []);
  return __TitanFrame;
}
deps["buildings.titan.view.TitanFrame"] = ["buildings.BaseBuildFrame"];

defs["buildings.transferbuilding.view.PlanesItemView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PlanesItemView extends __Base {
    static $fields(self) {
    self.back = null;
    self.planesName = null;
    self.precent = null;
    self._remainTimeText = null;
    self.giveupBtn = null;
    self.addLifeBtn = null;
    self.transferBtn = null;
    self._incomeImage = null;
    self.lifeContiner = null;
    self._data = null;
    self.planesMapTempInfo = null;
    self.addLifeItemTempId = 0;
    self.addLifeItemTempName = null;
    self.addLifeTime = 0;
    self._planesTypeList = null;
    self.bInfo = null;
    self.warpConstInfo = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,493,52);
      }
    initView() {
         this.back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.back");
         this.planesName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.planesName");
         this.precent = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.precent");
         this._remainTimeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.remainTimeText");
         this.lifeContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("planesItemView.lifeContiner");
         this.giveupBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.giveupBtn");
         this.addLifeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.addLifeBtn");
         this.transferBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.transferBtn");
         this._incomeImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesListView.IncomImage");
         this._incomeImage.visible = false;
         this.addChild(this.back);
         this.addChild(this.planesName);
         this.addChild(this.precent);
         this.lifeContiner.addChild(this._remainTimeText);
         this.addChild(this.lifeContiner);
         this.addChild(this.giveupBtn);
         this.addChild(this.addLifeBtn);
         this.addChild(this.transferBtn);
         this.addChild(this._incomeImage);
         this.giveupBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("planesItemView.giveupBtn.tipText");
         this.addLifeBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("planesItemView.addLifeBtn.tipText");
         this.bInfo = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(1511);
         this.warpConstInfo = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("planes_warp_energy");
         this.refreshView();
      }
    addEvent() {
         this.giveupBtn.addEventListener("click",$.bind(this, "__giveupClickHandler"));
         this.addLifeBtn.addEventListener("click",$.bind(this, "__addLifeClickHandler"));
         this.transferBtn.addEventListener("click",$.bind(this, "__transferClickHandler"));
      }
    removeEvent() {
         if(this.giveupBtn)
         {
            this.giveupBtn.removeEventListener("click",$.bind(this, "__giveupClickHandler"));
         }
         if(this.addLifeBtn)
         {
            this.addLifeBtn.removeEventListener("click",$.bind(this, "__addLifeClickHandler"));
         }
         if(this.transferBtn)
         {
            this.transferBtn.removeEventListener("click",$.bind(this, "__transferClickHandler"));
         }
      }
    __giveupClickHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         if($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.hasVicePassword == 1 && !$.C("yishi.GlobalConfig").isConfirmPassword)
         {
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("vicepassword",3);
         }
         else
         {
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "giveupResponse")];
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc5_ = $.C("manager.LanguageMgr").GetTranslation("planesItemView.giveup.alertTip");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
         }
      }
    __transferClickHandler(param1) {
         if(this.bInfo.property1 < parseInt(this.warpConstInfo.ConfigValue))
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("planesItemView.transfer.alertTip"));
            return;
         }
         $.C("yishi.manager.PlanesWarManager").instance.sendPlanesOpMsg(15,[this._data.planesId]);
      }
    giveupResponse(param1, param2) {
         if(param1)
         {
            $.C("yishi.manager.PlanesWarManager").instance.sendPlanesOpMsg(18,[this._data.planesId]);
         }
      }
    __addLifeClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getGoodsTemplatesBySonType(605);
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this.planesMapTempInfo.AddLifeItem);
         if(_loc2_)
         {
            this.addLifeItemTempId = this.planesMapTempInfo.AddLifeItem;
            this.addLifeItemTempName = _loc2_.TemplateName;
            this.addLifeTime = _loc2_.Property1;
         }
         if(this.todayNeedAlertForBuy($.C("yishi.manager.SharedManager").instance.planesBuyLifeAlertDate))
         {
            this.showBuyLifeTips();
         }
         else
         {
            $.C("yishi.manager.PlanesWarManager").instance.sendPlanesOpMsg(17,[this._data.planesId,this.addLifeItemTempId]);
         }
      }
    showBuyLifeTips() {
         var _loc4_ = null;
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("planesItemView.addLife.alertTip",this.addLifeItemTempName,this.addLifeTime);
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc2_ = true;
         _loc2_ = this.todayNeedAlertForBuy($.C("yishi.manager.SharedManager").instance.planesBuyLifeAlertDate);
         if(_loc2_)
         {
            _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc4_.show(_loc3_,_loc1_,$.bind(this, "__showBuyLifeTipResult"),null,"center",2,true);
            return;
         }
      }
    __showBuyLifeTipResult(param1) {
         if(param1)
         {
            $.C("yishi.manager.SharedManager").instance.planesBuyLifeAlertDate = new Date();
            $.C("yishi.manager.SharedManager").instance.saveBuyLifeAlertDate();
         }
         $.C("yishi.manager.PlanesWarManager").instance.sendPlanesOpMsg(17,[this._data.planesId,this.addLifeItemTempId]);
      }
    todayNeedAlertForBuy(param1) {
         var _loc2_ = null;
         var _loc3_ = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
      }
    refreshView() {
         var _loc1_ = null;
         this.cleanData();
         if(!this._data)
         {
            return;
         }
         this.giveupBtn.visible = this.transferBtn.visible = this.addLifeBtn.visible = this.lifeContiner.visible = true;
         this.lifeContiner.visible = true;
         this.planesMapTempInfo = $.C("yishi.manager.TempleteManager").instance.planesTemplateCate.getTemplateByID(this._data.planesTemId);
         this.planesName.text = this.planesMapTempInfo.PlanesName;
         this.planesName.y = 16 - (this.planesName.numLines - 1) * 6;
         this.precent.text = this._data.planesProcess + "%";
         this._remainTimeText.text = (this._data.lifePoint / this.planesMapTempInfo.LifePoint * 100).toFixed(2) + "%";
         var _loc3_ = this._data.lifeReduce / this.planesMapTempInfo.LifePoint;
         this.lifeContiner.tipData = $.C("manager.LanguageMgr").GetTranslation("planesItemView.life.alertTipText",(_loc3_ * 100).toFixed(2));
         this.transferBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("planesItemView.transferBtn.tipText",this.warpConstInfo.ConfigValue);
         var _loc4_ = $.C("yishi.manager.PlanesWarManager").instance.model.getSinglePlanesRewardsById(this._data.planesId);
         var _loc5_ = false;
         for (var _loc2_ of $.values(_loc4_))
         {
            if(_loc2_ > 0)
            {
               _loc5_ = true;
               break;
            }
         }
         this._incomeImage.visible = _loc5_;
         if(_loc5_)
         {
            _loc1_ = new ($.C("yishi.utils.SimpleDictionary"))();
            _loc1_[this._data.planesId] = _loc4_;
            this._incomeImage.tipStyle = "yishi.view.tips.PlanesRewardTip";
            this._incomeImage.tipData = {"dic":_loc1_};
         }
      }
    cleanData() {
         this.planesName.text = "";
         this.precent.text = "";
         this._remainTimeText.text = "";
         this.giveupBtn.visible = this.transferBtn.visible = this.addLifeBtn.visible = false;
         this.lifeContiner.visible = false;
         this._incomeImage.visible = false;
      }
    get planesWarModel() {
         return $.C("yishi.manager.PlanesWarManager").instance.model;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    dispose() {
         this.removeEvent();
         this._planesTypeList = null;
         if(this.back)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.back);
         }
         this.back = null;
         if(this.planesName)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.planesName);
         }
         this.planesName = null;
         if(this.addLifeBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.addLifeBtn);
         }
         this.addLifeBtn = null;
         if(this.precent)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.precent);
         }
         this.precent = null;
         if(this.lifeContiner)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.lifeContiner);
         }
         this.lifeContiner = null;
         if(this._remainTimeText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._remainTimeText);
         }
         this._remainTimeText = null;
         if(this.giveupBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.giveupBtn);
         }
         this.giveupBtn = null;
         if(this.transferBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.transferBtn);
         }
         this.transferBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    get data() { return super.data; }
    set planesWarModel(v) { super.planesWarModel = v; }
    set playerModel(v) { super.playerModel = v; }
  }
  $.meta(__PlanesItemView, "buildings.transferbuilding.view.PlanesItemView", ["Disposeable", "IManualSize"]);
  return __PlanesItemView;
}
deps["buildings.transferbuilding.view.PlanesItemView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.GlobalConfig", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager", "yishi.manager.PlanesWarManager", "yishi.manager.PlayerManager", "yishi.manager.SharedManager", "yishi.manager.TempleteManager", "yishi.utils.SimpleAlertHelper", "yishi.utils.SimpleDictionary", "yishi.view.tips.MessageTipManager"];

defs["buildings.transferbuilding.view.PlanesListView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PlanesListView extends __Base {
    static $fields(self) {
    self._titleBg = null;
    self._splitterBar = null;
    self._planesImage = null;
    self._incomeTextImage = null;
    self._rightBack = null;
    self._planesCount = null;
    self._energyCount = null;
    self._resiText = null;
    self.addEnergyBtn = null;
    self.getRewardBtn = null;
    self.sacrificeBtn = null;
    self.planesBagBtn = null;
    self.itemVBox = null;
    self.rewardsGoodsHbox = null;
    self.planesList = null;
    self.itemObj = {};
    self.rewardObj = {};
    self.energyLimitInfo = null;
    self.energyCostInfo = null;
    self.totalRewardDic = null;
    self.totalPlanesRewardDic = null;
    self.infoTipsView = null;
    self._limitInfo = null;
    self._needGoodsInfo = null;
    }
    constructor() {
         super();
         this.totalRewardDic = new ($.C("yishi.utils.SimpleDictionary"))();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._titleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.planesListView.titleImage");
         this._splitterBar = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesListView.splitterBarImage");
         this._planesImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesListView.planesTextImage");
         this._incomeTextImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.planesItemView.IncomeTxt");
         this._rightBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesListView.rightBack");
         this._planesCount = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.planesCount");
         this._energyCount = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.energyCount");
         this._resiText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.resiText");
         this.addEnergyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.addEnergyBtn");
         this.getRewardBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.getRewardBtn");
         this.sacrificeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesItemView.sacrificeBtn");
         this.planesBagBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesListView.planesBagBtn");
         this.infoTipsView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.InfoTipsMc");
         this.infoTipsView.mouseChildren = this.infoTipsView.mouseEnabled = false;
         this.sacrificeBtn.addChild(this.infoTipsView);
         this._limitInfo = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("sacrifice_max_times");
         this._needGoodsInfo = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("sacrifice_items_reward");
         this.itemVBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesListView.itemVBox");
         this.rewardsGoodsHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesListView.rewardsGoodsHbox");
         this.addChild(this._rightBack);
         this.addChild(this._titleBg);
         this.addChild(this._splitterBar);
         this.addChild(this._planesImage);
         this.addChild(this._incomeTextImage);
         this.addChild(this._planesCount);
         this.addChild(this._energyCount);
         this.addChild(this.planesBagBtn);
         this.addChild(this.addEnergyBtn);
         this.addChild(this.getRewardBtn);
         this.addChild(this.sacrificeBtn);
         this.addChild(this.itemVBox);
         this.addChild(this._resiText);
         this.addChild(this.rewardsGoodsHbox);
         this.energyLimitInfo = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("planes_buy_energy_limit");
         this.energyCostInfo = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("planes_buy_energy");
         this._planesImage.tipData = $.C("manager.LanguageMgr").GetTranslation("planeswar.planesListView.planesTiptext");
         this.initItemVbox();
         this.refreshView(null);
         this.updateInfoTips(null);
      }
    updateInfoTips(param1 = null) {
         var _loc5_ = 0;
         var _loc4_ = 0;
         var _loc2_ = 0;
         var _loc6_ = $.int(this._limitInfo.ConfigValue) - $.C("yishi.manager.InfoTipsManager").instance.getValueByKey(24);
         var _loc7_ = 0;
         var _loc3_ = this._needGoodsInfo.ConfigValue.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = $.int(String(_loc3_[_loc5_]).split("&")[1]);
            _loc2_ = $.int($.C("yishi.manager.GoodsManager").instance.getGoodsNumByTempId(_loc4_));
            _loc7_ += _loc2_;
            _loc5_++;
         }
         if(_loc7_ < _loc6_)
         {
            _loc6_ = _loc7_;
         }
         this.infoTipsView.visible = false;
         if(_loc6_ > 0)
         {
            this.infoTipsView.visible = true;
            this.infoTipsView.txt.text = _loc6_;
         }
      }
    addEvent() {
         $.C("yishi.manager.PlanesWarManager").instance.addEventListener("PLANES_INFO_UPDATE",$.bind(this, "refreshView"));
         this.addEnergyBtn.addEventListener("click",$.bind(this, "__addEnergyClickHandler"));
         this.getRewardBtn.addEventListener("click",$.bind(this, "__getRewardClickHandler"));
         this.sacrificeBtn.addEventListener("click",$.bind(this, "__sacrificeBtnClickHandler"));
         this.planesBagBtn.addEventListener("click",$.bind(this, "__planesBagClickHanlder"));
      }
    removeEvent() {
         $.C("yishi.manager.PlanesWarManager").instance.removeEventListener("PLANES_INFO_UPDATE",$.bind(this, "refreshView"));
         if(this.addEnergyBtn)
         {
            this.addEnergyBtn.removeEventListener("click",$.bind(this, "__addEnergyClickHandler"));
         }
         if(this.getRewardBtn)
         {
            this.getRewardBtn.removeEventListener("click",$.bind(this, "__getRewardClickHandler"));
         }
         if(this.sacrificeBtn)
         {
            this.sacrificeBtn.removeEventListener("click",$.bind(this, "__sacrificeBtnClickHandler"));
         }
         if(this.planesBagBtn)
         {
            this.planesBagBtn.removeEventListener("click",$.bind(this, "__planesBagClickHanlder"));
         }
      }
    __sacrificeBtnClickHandler(param1) {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("sacrifice");
      }
    __planesBagClickHanlder(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planeswar.planesListView.planesBagFrame");
         _loc2_.show();
      }
    __addEnergyClickHandler(param1) {
         var _loc2_ = 0;
         if(this.model.hasBuyEnergyCount > $.int(this.energyLimitInfo.ConfigValue))
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("planes.buyEnergy.hasEnough"));
            return;
         }
         var _loc3_ = this.energyCostInfo.ConfigValue.split(",");
         if($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.allPoint < _loc3_[0])
         {
            $.C("yishi.manager.RechargeAlertMannager").show();
            return;
         }
         if(this.todayNeedAlertForBuy($.C("yishi.manager.SharedManager").instance.planesAddEnergyAlertDate))
         {
            this.showAddEnergyTips();
         }
         else
         {
            _loc2_ = 1;
            if($.C("yishi.manager.SharedManager").instance.planesAddEnergyUseBind)
            {
               _loc2_ = 2;
            }
            $.C("yishi.manager.PlanesWarManager").instance.sendPlanesOpMsg(20,[_loc2_]);
         }
      }
    showAddEnergyTips() {
         var _loc5_ = null;
         var _loc3_ = this.energyCostInfo.ConfigValue.split(",");
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("planesWar.planesListView.AddEnergyTips",_loc3_[0],_loc3_[1]);
         var _loc2_ = true;
         _loc2_ = this.todayNeedAlertForBuy($.C("yishi.manager.SharedManager").instance.planesAddEnergyAlertDate);
         if(_loc2_)
         {
            _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc5_.show(_loc4_,_loc1_,$.bind(this, "__showAddEnergyTipResult"),null,"center",2,true);
            return;
         }
      }
    __showAddEnergyTipResult(param1, param2) {
         if(param1)
         {
            $.C("yishi.manager.SharedManager").instance.planesAddEnergyAlertDate = new Date();
            $.C("yishi.manager.SharedManager").instance.saveAddEnergyAlertDate();
         }
         $.C("yishi.manager.SharedManager").instance.planesAddEnergyUseBind = param2;
         $.C("yishi.manager.SharedManager").instance.saveAddEnergyUseBind();
         var _loc3_ = 1;
         if($.C("yishi.manager.SharedManager").instance.planesAddEnergyUseBind)
         {
            _loc3_ = 2;
         }
         $.C("yishi.manager.PlanesWarManager").instance.sendPlanesOpMsg(20,[_loc3_]);
      }
    todayNeedAlertForBuy(param1) {
         var _loc2_ = null;
         var _loc3_ = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
    __getRewardClickHandler(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesListView.PlanesResourceFrame");
         _loc2_.show();
      }
    initItemVbox() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new ($.C("buildings.transferbuilding.view.PlanesItemView"))();
            this.itemVBox.addChild(_loc1_);
            this.itemObj[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
    refreshView(param1) {
         var _loc6_ = 0;
         var _loc2_ = null;
         var _loc12_ = null;
         var _loc4_ = null;
         var _loc7_ = null;
         var _loc8_ = 0;
         this.planesList = this.model.planesInfoList;
         this.rewardsGoodsHbox.removeAllChild();
         var _loc9_ = $.C("manager.LanguageMgr").GetTranslation("PlanesLeftView.layerInfoText.resiText");
         this._planesCount.text = this.model.planesInfoList.length + "/" + this.model.maxPlanesCount;
         this._energyCount.text = this.model.energyLeft.toString();
         var _loc10_ = $.int(this.energyLimitInfo.ConfigValue) - this.model.hasBuyEnergyCount;
         this.addEnergyBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("planeswar.planesListView.addEnergyBtnTiptext",_loc10_);
         this.totalPlanesRewardDic = new ($.C("yishi.utils.SimpleDictionary"))();
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc2_ = this.itemObj[_loc6_];
            _loc12_ = this.planesList[_loc6_];
            if(!_loc2_)
            {
               _loc2_ = new ($.C("buildings.transferbuilding.view.PlanesItemView"))();
               this.itemObj[_loc6_] = _loc2_;
            }
            if(_loc6_ < this.planesList.length)
            {
               _loc2_.data = _loc12_;
               if(!this.model.checkDicIsEmpty(this.model.getSinglePlanesRewardsById(_loc12_.planesId)))
               {
                  this.totalPlanesRewardDic[_loc12_.planesId] = this.model.getSinglePlanesRewardsById(_loc12_.planesId);
               }
            }
            else
            {
               _loc2_.data = null;
            }
            _loc6_++;
         }
         var _loc3_ = {};
         _loc3_.dic = this.totalPlanesRewardDic;
         this.totalRewardDic = this.model.getTotalRewards();
         for(var _loc11_ in this.totalRewardDic)
         {
            if(_loc11_)
            {
               if(parseInt(_loc11_) >= 1 && parseInt(_loc11_) <= 7)
               {
                  if(this.totalRewardDic[_loc11_] != 0)
                  {
                     _loc9_ += $.C("manager.LanguageMgr").GetTranslation("PlanesLeftView.layerInfoText.resiText" + _loc11_,this.totalRewardDic[_loc11_]) + "  ";
                  }
               }
               else
               {
                  _loc4_ = this.rewardObj[_loc11_];
                  if(!_loc4_)
                  {
                     _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("planesListView.BaseItemView");
                     this.rewardObj[_loc11_] = _loc4_;
                  }
                  _loc7_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                  _loc7_.templateId = parseInt(_loc11_);
                  _loc7_.count = this.totalRewardDic[_loc11_];
                  _loc4_.data = _loc7_;
                  this.rewardsGoodsHbox.addChild(_loc4_);
               }
            }
         }
         var _loc5_ = false;
         _loc8_ = 1;
         while(_loc8_ < 8)
         {
            if(this.totalRewardDic[_loc8_] && this.totalRewardDic[_loc8_] != 0)
            {
               _loc5_ = true;
               break;
            }
            _loc8_++;
         }
         if(!_loc5_)
         {
            this._resiText.htmlText = "";
         }
         else
         {
            this._resiText.htmlText = _loc9_;
         }
      }
    get model() {
         return $.C("yishi.manager.PlanesWarManager").instance.model;
      }
    dispose() {
         this.removeEvent();
         this.model.planesInfoList = [];
         if(this.itemObj)
         {
            for(var _loc2_ in this.itemObj)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.itemObj[_loc2_]);
               this.itemObj[_loc2_] = null;
            }
            this.itemObj = null;
         }
         if(this.rewardObj)
         {
            for(var _loc1_ in this.rewardObj)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.rewardObj[_loc1_]);
               this.rewardObj[_loc1_] = null;
            }
            this.rewardObj = null;
         }
         if(this._titleBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleBg);
         }
         this._titleBg = null;
         if(this._splitterBar)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._splitterBar);
         }
         this._splitterBar = null;
         if(this._planesImage)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._planesImage);
         }
         this._planesImage = null;
         if(this._incomeTextImage)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._incomeTextImage);
         }
         this._incomeTextImage = null;
         if(this._rightBack)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightBack);
         }
         this._rightBack = null;
         if(this._planesCount)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._planesCount);
         }
         this._planesCount = null;
         if(this._energyCount)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._energyCount);
         }
         this._energyCount = null;
         if(this._resiText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resiText);
         }
         this._resiText = null;
         if(this.addEnergyBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.addEnergyBtn);
         }
         this.addEnergyBtn = null;
         if(this.getRewardBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.getRewardBtn);
         }
         this.getRewardBtn = null;
         if(this.itemVBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.itemVBox);
         }
         this.itemVBox = null;
         if(this.rewardsGoodsHbox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.rewardsGoodsHbox);
         }
         this.rewardsGoodsHbox = null;
         if(this.planesBagBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.planesBagBtn);
         }
         this.planesBagBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.infoTipsView);
         this.infoTipsView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set model(v) { super.model = v; }
  }
  $.meta(__PlanesListView, "buildings.transferbuilding.view.PlanesListView", ["Disposeable"]);
  return __PlanesListView;
}
deps["buildings.transferbuilding.view.PlanesListView"] = ["buildings.transferbuilding.view.PlanesItemView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.manager.InfoTipsManager", "yishi.manager.PlanesWarManager", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.manager.SharedManager", "yishi.manager.TempleteManager", "yishi.utils.SimpleDictionary", "yishi.view.tips.MessageTipManager"];

defs["buildings.transferbuilding.view.TransferBuildFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __TransferBuildFrame extends __Base {
    static $fields(self) {
    self._back = null;
    self._iconBack = null;
    self._iconView = null;
    self._powerTxt = null;
    self._powerItem = null;
    self.planesAlertImage = null;
    self._powerButton = null;
    self._mapButton = null;
    self._describeText = null;
    self._planesDescText = null;
    self._bottomBg = null;
    self._planesNotOpenBg = null;
    self._listView = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,820,555);
      }
    get groups() {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.back");
         this._planesNotOpenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.planesNotOpenBg");
         this._bottomBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.bottomBg");
         this._iconBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.castle.buildingBoxImg");
         this._iconView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("castle.BuildIcon");
         this._powerTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.transferbuilding.PowerAsset");
         this._powerItem = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("transferbuilding.PowerItem");
         this._describeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.DescribeText");
         this._powerButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.PowerButton");
         this._mapButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.MapButton");
         this._listView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("transferbuilding.planesListView");
         this._planesDescText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.planesDescText");
         this.planesAlertImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferbuilding.planesListView.isOpenAlert");
         this.addToContent(this._back);
         if($.C("yishi.datas.VersionSwitch").PLANES_WAR && $.C("yishi.manager.ArmyManager").instance.thane.grades >= 55)
         {
            this.addToContent(this._listView);
            $.C("yishi.manager.PlanesWarManager").instance.sendPlanesOpMsg(1);
         }
         else
         {
            this.addToContent(this._planesNotOpenBg);
            this.addToContent(this.planesAlertImage);
            if(!$.C("yishi.datas.VersionSwitch").PLANES_WAR)
            {
               this.planesAlertImage.setFrame(1);
            }
            else
            {
               this.planesAlertImage.setFrame(2);
               this.addToContent(this._planesDescText);
            }
         }
         this.addToContent(this._bottomBg);
         this.addToContent(this._iconBack);
         this._iconBack.x = 31;
         this._iconBack.y = 353;
         this.addToContent(this._iconView);
         this._iconView.x = 36;
         this._iconView.y = 362;
         this.addToContent(this._powerTxt);
         this.addToContent(this._powerItem);
         this.addToContent(this._describeText);
         this.addToContent(this._powerButton);
         this.addToContent(this._mapButton);
         this._describeText.text = $.C("manager.LanguageMgr").GetTranslation("buildings.transferbuilding.view.TransferBuildFrame.describe");
         this._planesDescText.htmlText = $.C("manager.LanguageMgr").GetTranslation("transferbuilding.view.TransferBuildFrame.planesDescText");
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._powerButton.addEventListener("click",$.bind(this, "__powerHandler"));
         this._mapButton.addEventListener("click",$.bind(this, "__onMapClick"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("TRANSFER_POWER_SUCCESS",$.bind(this, "addPowerSuccess"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         this._powerButton.removeEventListener("click",$.bind(this, "__powerHandler"));
         this._mapButton.removeEventListener("click",$.bind(this, "__onMapClick"));
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("TRANSFER_POWER_SUCCESS",$.bind(this, "addPowerSuccess"));
      }
    __powerHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc7_ = null;
         var _loc4_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("transport_charge_cost");
         var _loc6_ = parseInt(_loc5_.ConfigValue);
         if(_loc6_ > 0)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("buildings.transferbuilding.view.TransferBuildFrame.content",_loc6_);
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "addPowerBack"),_loc6_];
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc7_,_loc4_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
    addPowerBack(param1, param2, param3 = 0, param4 = 2) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if(param1)
         {
            if(!param2)
            {
               if(param3 > $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.point)
               {
                  $.C("yishi.manager.RechargeAlertMannager").show();
                  return;
               }
               param4 = 1;
            }
            else if(param3 > $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.allPoint)
            {
               $.C("yishi.manager.RechargeAlertMannager").show();
               return;
            }
            $.C("managers.BuildingSocketOutManager").sendAddTransferPower(param4);
         }
      }
    __onMapClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("worldmap");
      }
    addPowerSuccess(param1) {
         this.refreshView();
      }
    __onHelperBtnClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("transferBuildFrame.HelperFrame");
         _loc2_.show();
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
      }
    refreshView() {
         this._iconView.icon = $.C("yishi.utils.IconFactory").getBuidIconByIcon(this._data.templeteInfo.Icon);
         this._powerItem.max = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerEffect.getTransferPowerLimitAddition(this.data.templeteInfo.Property2);
         this._powerItem.current = this.data.property1;
         this._powerButton.enable = this.data.property1 != $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerEffect.getTransferPowerLimitAddition(this.data.templeteInfo.Property2);
      }
    get mapButton() {
         return this._mapButton;
      }
    show() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("buildings.transferbuilding.view.TransferBuildFrame.title");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.manager.PlanesWarManager").instance.model.planesInfoList = [];
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iconBack);
         this._iconBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iconView);
         this._iconView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._powerTxt);
         this._powerTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._powerItem);
         this._powerItem = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describeText);
         this._describeText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._powerButton);
         this._powerButton = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mapButton);
         this._mapButton = null;
         if(this._planesNotOpenBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._planesNotOpenBg);
         }
         this._planesNotOpenBg = null;
         if(this.planesAlertImage)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.planesAlertImage);
         }
         this.planesAlertImage = null;
         if(this._planesDescText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._planesDescText);
         }
         this._planesDescText = null;
         if(this._listView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._listView);
            this._listView = null;
         }
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set mapButton(v) { super.mapButton = v; }
  }
  $.meta(__TransferBuildFrame, "buildings.transferbuilding.view.TransferBuildFrame", ["IManualSize"]);
  return __TransferBuildFrame;
}
deps["buildings.transferbuilding.view.TransferBuildFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.BuildingSocketOutManager", "yishi.datas.VersionSwitch", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager", "yishi.manager.PlanesWarManager", "yishi.manager.PlayerManager", "yishi.manager.RechargeAlertMannager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.SimpleAlertHelper"];

defs["buildings.transferbuilding.view.planesbag.PlanesBagCell"] = function define($) {
  const __Base = $.C("cell.view.bag.BaseBagCell");
  class __PlanesBagCell extends __Base {
    static $fields(self) {
    self._mediatorKey = null;
    self._registed = false;
    }
    constructor() {
         super();
      }
    set data(param1) {
         if(this.data != param1)
         {
            this.setNormalFilter();
         }
         super.data = param1;
         this.mouseEnabled = true;
         this.mouseChildren = true;
         if(!this._registed)
         {
            this.registerMediator();
         }
      }
    registerMediator() {
         this._registed = true;
         var _loc1_ = [$.C("buildings.transferbuilding.view.planesbag.PlanesBagCellClickMediator")];
         this._mediatorKey = $.C("yishi.manager.MediatorMananger").instance.registerMediatorList(_loc1_,this,"buildings.transferbuilding.view.planesbag.");
      }
    unregisterMediator() {
         $.C("yishi.manager.MediatorMananger").instance.unregisterMediatorList(this._mediatorKey,this);
      }
    dispose() {
         this.unregisterMediator();
         super.dispose();
      }
    get data() { return super.data; }
  }
  $.meta(__PlanesBagCell, "buildings.transferbuilding.view.planesbag.PlanesBagCell", []);
  $.statics(__PlanesBagCell, () => {
    __PlanesBagCell.NAME = "buildings.transferbuilding.view.planesbag.";
  });
  return __PlanesBagCell;
}
deps["buildings.transferbuilding.view.planesbag.PlanesBagCell"] = ["buildings.transferbuilding.view.planesbag.PlanesBagCellClickMediator", "cell.view.bag.BaseBagCell", "yishi.manager.MediatorMananger"];

defs["buildings.transferbuilding.view.planesbag.PlanesBagCellClickMediator"] = function define($) {
  const __Base = $.C("cell.mediator.DoubleClickMediator");
  class __PlanesBagCellClickMediator extends __Base {
    static $fields(self) {
    self._menu = null;
    }
    constructor() {
         super();
      }
    __mouseClickByClicker(param1) {
         if(this._cell.data.templateInfo.SonType != 606)
         {
            return;
         }
         var _loc2_ = this._cell.parent.localToGlobal(new ($.C("flash.geom.Point"))(this._cell.x,this._cell.y));
         this._menu = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("PlanesBagCell.GoodsItemMenu",[this._cell]);
         this._menu.x = _loc2_.x + this._cell.icon.iconWidth;
         this._menu.y = _loc2_.y + this._cell.icon.iconHeight;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._menu,7);
      }
    __mouseDoubleClick(param1) {
         if(this._cell.data.templateInfo.SonType != 606)
         {
            return;
         }
         $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(this._cell.data.pos);
      }
  }
  $.meta(__PlanesBagCellClickMediator, "buildings.transferbuilding.view.planesbag.PlanesBagCellClickMediator", []);
  return __PlanesBagCellClickMediator;
}
deps["buildings.transferbuilding.view.planesbag.PlanesBagCellClickMediator"] = ["cell.mediator.DoubleClickMediator", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "flash.geom.Point", "yishi.service.managers.SocketSendManager"];

defs["buildings.transferbuilding.view.planesbag.PlanesBagFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __PlanesBagFrame extends __Base {
    static $fields(self) {
    self.back = null;
    self.bagList = null;
    self.bagScroll = null;
    self.itemList = null;
    self.itemDic = new ($.C("yishi.utils.SimpleDictionary"))(true);
    self.realRowNum = 5;
    self.defaultCount = 0;
    self.showGoodsArr = null;
    }
    constructor() {
         super();
         this.defaultCount = 5 * 6;
         this.initView();
         this.addEvent();
         this.initList();
         this.refreshData();
         this.refreshView();
      }
    initView() {
         this.back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesBagFrame.back");
         this.bagList = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("PlanesBagFrame.SimpleTileList",[6]);
         this.bagScroll = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesBagFrame.bagScroll");
         this.bagScroll.vUnitIncrement = 8;
         this.bagScroll.setView(this.bagList);
         this.addToContent(this.back);
         this.addToContent(this.bagScroll);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         $.C("yishi.manager.GoodsManager").instance.addEventListener("UPDATE_BAG",$.bind(this, "__bagItemUpdateHandler"));
         $.C("yishi.manager.GoodsManager").instance.addEventListener("DELETE_BAG",$.bind(this, "__bagItemDeleteHandler"));
      }
    initList() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this.itemList = new $.Vector();
         this.bagList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < this.defaultCount)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("PlanesBagFrame.BagCell");
            _loc1_.pos = -1;
            this.bagList.addChild(_loc1_);
            this.itemList.push(_loc1_);
            _loc2_++;
         }
         this.bagList.commitChanges();
         this.bagScroll.invalidateViewport();
      }
    refreshData() {
         var _loc3_ = null;
         var _loc2_ = 0;
         this.showGoodsArr = [];
         var _loc1_ = $.C("yishi.manager.GoodsManager").instance.getGeneralBagGoodsBySonType(606);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = $.as(_loc1_[_loc2_], $.C("yishi.datas.goods.GoodsInfo"));
            if(this.isPlanesGoods(_loc3_))
            {
               this.showGoodsArr.push(_loc3_);
            }
            _loc2_++;
         }
         this.showGoodsArr.sort($.bind(this, "sortByTempId"));
      }
    sortByTempId(param1, param2) {
         if(param1.templateInfo.TemplateId > param2.templateInfo.TemplateId)
         {
            return -1;
         }
         if(param1.templateInfo.TemplateId < param2.templateInfo.TemplateId)
         {
            return 1;
         }
         return 0;
      }
    refreshView() {
         var _loc1_ = 0;
         var _loc2_ = null;
         this.clearGoods();
         this.refreshBag();
         _loc1_ = 0;
         while(_loc1_ < this.showGoodsArr.length)
         {
            _loc2_ = $.as(this.showGoodsArr[_loc1_], $.C("yishi.datas.goods.GoodsInfo"));
            this.itemList[_loc1_].bagType = _loc2_.bagType;
            this.itemList[_loc1_].pos = _loc2_.pos;
            this.itemList[_loc1_].data = _loc2_;
            this.itemDic.add(_loc2_.pos + "_" + _loc2_.objectId + "_" + _loc2_.bagType,this.itemList[_loc1_]);
            _loc1_++;
         }
      }
    clearGoods() {
         for (var _loc1_ of $.values(this.itemList))
         {
            _loc1_.data = null;
         }
         for (var _loc2_ of $.values(this.itemDic))
         {
            _loc2_.data = null;
            _loc2_.pos = -1;
         }
         this.itemDic.clear();
      }
    refreshBag() {
         var _loc2_ = 0;
         var _loc3_ = 0;
         this.realRowNum = Math.ceil(this.showGoodsArr.length / 6);
         var _loc4_ = 6 * this.realRowNum;
         var _loc1_ = _loc4_ < this.defaultCount ? this.defaultCount : _loc4_;
         if(this.itemList.length < _loc1_)
         {
            this.addItems(_loc1_ - this.itemList.length);
         }
         else if(this.itemList.length > _loc1_ && this.itemList.length > this.defaultCount)
         {
            this.removeItems(this.itemList.length - _loc1_);
         }
      }
    removeItems(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc2_ = null;
         this.bagList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = this.itemList.pop();
            this.bagList.removeChild(_loc2_);
            _loc2_.dispose();
            _loc3_++;
         }
         this.bagList.commitChanges();
         this.bagScroll.invalidateViewport();
      }
    addItems(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc2_ = null;
         this.bagList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("PlanesBagFrame.BagCell");
            _loc2_.pos = -1;
            this.bagList.addChild(_loc2_);
            this.itemList.push(_loc2_);
            _loc3_++;
         }
         this.bagList.commitChanges();
         this.bagScroll.invalidateViewport();
      }
    addItem(param1) {
         var _loc2_ = null;
         if(this.isPlanesGoods(param1) && this.showGoodsArr)
         {
            _loc2_ = this.findBagEmputyItem(this.showGoodsArr.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            this.itemDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
    isPlanesGoods(param1) {
         if(param1.templateInfo.SonType == 606)
         {
            return true;
         }
         return false;
      }
    findBagEmputyItem(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc3_ = param1;
         _loc3_;
         while(_loc3_ < this.itemList.length)
         {
            if(!this.itemList[_loc3_].data)
            {
               return this.itemList[_loc3_];
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("PlanesBagFrame.BagCell");
            this.bagList.addChild(_loc2_);
            this.itemList.push(_loc2_);
            _loc4_++;
         }
         this.bagList.commitChanges();
         this.bagScroll.invalidateViewport();
         return this.findBagEmputyItem(_loc3_);
      }
    __bagItemDeleteHandler(param1) {
         var _loc3_ = param1.info;
         var _loc2_ = this.itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
    __bagItemUpdateHandler(param1) {
         var _loc3_ = param1.info;
         if(_loc3_.bagType == 0)
         {
            return;
         }
         if(!this.isPlanesGoods(_loc3_))
         {
            return;
         }
         var _loc2_ = this.itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
         else
         {
            this.addItem(_loc3_);
         }
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         $.C("yishi.manager.GoodsManager").instance.removeEventListener("UPDATE_BAG",$.bind(this, "__bagItemUpdateHandler"));
         $.C("yishi.manager.GoodsManager").instance.removeEventListener("DELETE_BAG",$.bind(this, "__bagItemDeleteHandler"));
      }
    show() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("PlanesBagFrame.title.text");
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         if(this.realRowNum > 5)
         {
            this.back.height = 291 + (this.realRowNum - 5) * 50;
            this.height = 390 + (this.realRowNum - 5) * 50;
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
    dispose() {
         this.removeEvent();
         if(this.back)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.back);
         }
         this.back = null;
         if(this.bagList)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this.bagList);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.bagList);
            this.bagList = null;
         }
         if(this.bagScroll)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this.bagScroll);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.bagScroll);
            this.bagScroll = null;
         }
         for (var _loc1_ of $.values(this.itemDic))
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.itemDic.clear();
         this.itemList = null;
         this.showGoodsArr = null;
         super.dispose();
      }
  }
  $.meta(__PlanesBagFrame, "buildings.transferbuilding.view.planesbag.PlanesBagFrame", []);
  $.statics(__PlanesBagFrame, () => {
    __PlanesBagFrame.rowCount = 5;
    __PlanesBagFrame.columnCount = 6;
  });
  return __PlanesBagFrame;
}
deps["buildings.transferbuilding.view.planesbag.PlanesBagFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.GoodsManager", "yishi.utils.SimpleDictionary"];

defs["buildings.transferbuilding.view.planesbag.PlanesGoodsItemMenu"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PlanesGoodsItemMenu extends __Base {
    static $fields(self) {
    self._useBtn = null;
    self._currentCell = null;
    }
    constructor(param1) {
         super();
         this._currentCell = param1;
         this.initView();
         this.initEvent();
      }
    initView() {
         this._useBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.UseButton");
         this._useBtn.text = $.C("manager.LanguageMgr").GetTranslation("cell.view.GoodsItemMenu.use");
         this.addChild(this._useBtn);
      }
    initEvent() {
         this._useBtn.addEventListener("click",$.bind(this, "__userHandler"));
      }
    removeEvent() {
         if(this._useBtn)
         {
            this._useBtn.removeEventListener("click",$.bind(this, "__userHandler"));
         }
      }
    __userHandler(param1) {
         if(this._currentCell.data.templateInfo.SonType != 606)
         {
            return;
         }
         $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(this._currentCell.data.pos);
         this.dispose();
      }
    dispose() {
         this.removeEvent();
         this._currentCell = null;
         if(this._useBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._useBtn);
         }
         this._useBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PlanesGoodsItemMenu, "buildings.transferbuilding.view.planesbag.PlanesGoodsItemMenu", ["Disposeable"]);
  return __PlanesGoodsItemMenu;
}
deps["buildings.transferbuilding.view.planesbag.PlanesGoodsItemMenu"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.service.managers.SocketSendManager"];

defs["castle.CastleSceneView"] = function define($) {
  const __Base = $.C("yishi.scene.BaseSceneView");
  class __CastleSceneView extends __Base {
    static $fields(self) {
    self._castleMap = null;
    self._nameLayer = null;
    self._preSceneData = null;
    }
    constructor() {
         super();
      }
    preLoadingStart(param1 = null) {
         super.preLoadingStart(param1);
      }
    enter(param1, param2 = null) {
         this._preSceneData = param2;
         this._nameLayer = new ($.C("castle.view.layer.CastleNameLayer"))();
         this._nameLayer.x = -130;
         this._nameLayer.y = -180;
         this._nameLayer.mouseChildren = this._nameLayer.mouseEnabled = false;
         this._castleMap = new ($.C("castle.view.CastleMapViewII"))(this._nameLayer);
         this._castleMap.dragingCallBack();
         this.addChild(this._castleMap);
         this.addChild(this._nameLayer);
         $.C("yishi.manager.BuildingManager").instance.castleMap = this._castleMap;
         $.C("mainBar.SmallMapBar").instance.switchSmallMapState(4);
         $.C("com.pickgliss.utils.SoundManager").instance.playMusic("castle",0);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.SceneViewEvent"))("addToStage","CASTLE_SCENE"));
      }
    enterOver() {
         var timeId;
         var bossReward;
         var consortiaId;
         var consortiaId2;
         var mapId;
         var tempAreaId;
         var tempDiff;
         var shadowLandCallBack;
         var state;
         var tipData;
         super.enterOver();
         $.C("ui.toptoolbar.TopToolsBar").instance.show();
         $.C("ui.maintoolbar.MainToolBar").instance.show();
         $.C("mainBar.TipsBar").instance.show();
         $.C("mainBar.FullBar").instance.show();
         $.C("ui.queuebar.QueueBar").instance.show();
         $.C("mainBar.ChatBar").instance.show();
         $.C("ui.tasktracebar.TaskTraceBar").instance.show();
         $.C("mainBar.SmallMapBar").instance.show();
         $.C("ui.resourcebar.ResourcesBar").instance.show();
         $.C("chat.view.ChatTopBugleView").instance.setPos();
         if(this._preSceneData)
         {
            if(this._preSceneData.isOpenColosseum)
            {
               $.C("managers.ChallengeManager").instance.enterScene = $.C("yishi.scene.SceneManager").instance.currentType;
               $.C("yishi.scene.SceneManager").instance.setScene("CHANLLENGE_ROOM_SCENE");
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("colosseum");
            }
            else if(this._preSceneData.isOpenPveRoomList)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("pveroomlist");
            }
            else if(this._preSceneData.isOpenPvpRoomList)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("pvproomlist");
            }
            else if(this._preSceneData.isOpenVehicle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("vehicledaimon");
            }
            else if(this._preSceneData.isOpenPetChallenge)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("petchallenge",2);
            }
            else if(this._preSceneData.isOpenPetMaze2)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("maze",2);
            }
            else if(this._preSceneData.isOpenRemotePet)
            {
               $.C("yishi.manager.FrameControllerManager").instance.remotePetController.startFrameByType(2);
            }
            else if(this._preSceneData.isOpenChildPve)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("childpve");
            }
            else if(this._preSceneData.isOpenChildArena)
            {
               $.C("yishi.SwitchPageHelp").gotoChildArenaFrame();
            }
            else if(this._preSceneData.isGloryRoadBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("gloryroad");
            }
            else if(this._preSceneData.isOpenPerkinLab)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("perkinlab",1);
            }
            else if(this._preSceneData.isOutyardBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("outyard",3);
               timeId = $.int($.C("flash.utils.setTimeout")(() =>
               {
                  $.C("flash.utils.clearTimeout")(timeId);
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("outyard");
               },1000));
            }
            else if(this._preSceneData.isOutyardExploreBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("outyard",3);
            }
            else if(this._preSceneData.isCrossBraveBattle && $.C("yishi.manager.BraveLegManager").instance.model.teamInfo)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("braveleg",{
                  "tab":1,
                  "refresh":true
               },$.C("yishi.manager.BraveLegManager").instance.model.teamInfo);
            }
            else if(this._preSceneData.isAbysmBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("abysm",7);
            }
            else if(this._preSceneData.isLordTrial)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("lordtrial",0);
            }
            else if(this._preSceneData.isDragonTalker)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("timevortex",0);
            }
            else if(this._preSceneData.isOpenTimeVortex)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("timevortex",1);
            }
            else if(this._preSceneData.isTitanTempleBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("outyard",9);
            }
            else if(this._preSceneData.isShuttleBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("outyard",10);
            }
            else if(this._preSceneData.isOpenEclipticPalace)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("eclipticpalace","MAIN_FRAME");
            }
            else if(this._preSceneData.isOpenDemonLand)
            {
               $.C("yishi.manager.DemonLandManager").instance.battleOverHandlerView();
            }
            else if(this._preSceneData.isOpenGameHall)
            {
               $.C("yishi.scene.SceneManager").instance.setScene("GAME_HALL_SCENE");
            }
            else if(this._preSceneData.isMonsterExplore)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("monsterexplore");
               bossReward = $.C("yishi.manager.MonsterExploreManager").instance.model.bossWinReward;
               if(bossReward != null)
               {
                  timeId = $.int($.C("flash.utils.setTimeout")(() =>
                  {
                     $.C("flash.utils.clearTimeout")(timeId);
                     $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("monsterexplore","WIN_REWARD_FRAME");
                  },1000));
               }
            }
            else if(this._preSceneData.isOpenDreamArena)
            {
               if($.C("managers.DreamArenaManager").instance.model.reportData != null)
               {
                  timeId = $.int($.C("flash.utils.setTimeout")(() =>
                  {
                     $.C("flash.utils.clearTimeout")(timeId);
                     $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("dreamarena","REPORT_FRAME");
                  },1000));
               }
               else
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("dreamarena");
               }
            }
            else if(this._preSceneData.isMinosMap)
            {
               consortiaId = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.consortiaID);
               if(consortiaId > 0)
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("minos","Map",$.C("managers.MinosManager").ins.model.currBattleLv);
                  $.C("yishi.manager.FrameControllerManager").instance.minousCrl.setPreFrame("minos");
               }
            }
            else if(this._preSceneData.chesspvp)
            {
               consortiaId2 = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.consortiaID);
               if(consortiaId2 > 0)
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("chesspvp",1);
               }
            }
            else if(this._preSceneData.isOpenRevengeRoad)
            {
               $.C("yishi.manager.RevengeRoadManager").Ins.battleOverHandlerView();
            }
            else if(this._preSceneData.isOpenRedemptionRoad)
            {
               if($.C("managers.RedemptionRoadManager").instance.model.isClearance || Boolean($.C("managers.RedemptionRoadManager").instance.model.isCding))
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("redemptionroad");
               }
               else
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("redemptionroad","CHAPTER_FRAME");
               }
            }
            else if(this._preSceneData.isSecretwarResult)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("secretwar",2);
            }
            else if(this._preSceneData.isOpenStararea)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("sevenyear",1);
            }
            else if(this._preSceneData.isExpeditionBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("spiritexpedition");
               mapId = $.int($.C("managers.SpiritExpeditionManager").instance.model.tempMapId);
               timeId = $.int($.C("flash.utils.setTimeout")(() =>
               {
                  $.C("flash.utils.clearTimeout")(timeId);
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("spiritexpedition",2,mapId);
               },1000));
            }
            else if(this._preSceneData.isYLExpidtionBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("ylexpedition");
            }
            else if(this._preSceneData.isSecretAdventure)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("secretadventure");
            }
            else if(this._preSceneData.isShadowLandBattle)
            {
               tempAreaId = $.int($.C("yishi.manager.ShadowLandManager").instance.model.tempAreaId);
               tempDiff = $.int($.C("yishi.manager.ShadowLandManager").instance.model.tempDiff);
               shadowLandCallBack = () =>
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("shadowland",2,[tempAreaId,tempDiff]);
               };
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("shadowland",null,null);
            }
            else if(this._preSceneData.isRemainsExploreBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("remainsexplore");
               if($.C("yishi.manager.RemainsExploreManager").instance.model.tempAreaId > 0)
               {
                  timeId = $.int($.C("flash.utils.setTimeout")(() =>
                  {
                     $.C("flash.utils.clearTimeout")(timeId);
                     $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("remainsexplore",2);
                  },1000));
               }
            }
            else if(this._preSceneData.isConsortiaNewBossBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortianewboss",1);
            }
            else if(this._preSceneData.isRoyaltyBossBattle)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("royaltyboss");
            }
            else if(this._preSceneData.isWarSoulTowerBattle)
            {
               if($.C("yishi.manager.WarSoulTowerManager").instance.model.overLevel > 0)
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("warsoultower",1);
               }
            }
            else if(this._preSceneData.isFinalRoadBattle)
            {
               if(!$.C("yishi.manager.FinalRoadManager").instance.model.isOpen)
               {
                  return;
               }
               state = $.int($.C("yishi.manager.FinalRoadManager").instance.model.groupInfo.state);
               if(state == 2)
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("finalroad");
               }
               else
               {
                  $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("finalroad",1);
               }
            }
            else if(this._preSceneData.thesetower)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("thesstower","ThessTowerFrame");
            }
            else if(this._preSceneData.thessbox)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("thessbox","ThessBoxMainFrame");
            }
            else if(this._preSceneData.dungeonexplo)
            {
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("dungenexplo",1);
            }
         }
         $.C("farm.FarmManager").instance.showGatherCropTip();
         $.C("managers.ChildPatrolManager").instance.showChildPatrolTaskAlertTip();
         $.C("managers.TaskTraceTipManager").instance.showBetterGoodsAlertTip();
         if($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.showVersion && this.thane.grades >= 55)
         {
            tipData = new ($.C("tasktracetip.data.TipMessageData"))();
            tipData.title = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            tipData.type = 31;
            tipData.content = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.FateGuardOpenview.content");
            $.C("managers.TaskTraceTipManager").instance.showView(tipData);
         }
         if(this.thane.grades > 6)
         {
            $.C("yishi.manager.TempleteSaveManager").instance.startSave();
         }
         if($.C("yishi.manager.HeroRoadManager").instance.popTaskInfo && $.C("yishi.manager.HeroRoadManager").instance.count == 0)
         {
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("heroroad",2,$.C("yishi.manager.HeroRoadManager").instance.popTaskInfo);
            $.C("yishi.manager.HeroRoadManager").instance.count++;
         }
      }
    get SceneName() {
         return "CASTLE_SCENE";
      }
    leaving() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._castleMap);
         this._castleMap = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameLayer);
         this._nameLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("mainBar.FullBar").instance.hide();
         $.C("ui.maintoolbar.MainToolBar").instance.hide();
         $.C("ui.toptoolbar.TopToolsBar").instance.hide();
         $.C("mainBar.TipsBar").instance.hide();
         $.C("ui.resourcebar.ResourcesBar").instance.hide();
         $.C("mainBar.ChatBar").instance.hide();
         $.C("ui.queuebar.QueueBar").instance.hide();
         $.C("mainBar.SmallMapBar").instance.hide();
         $.C("ui.tasktracebar.TaskTraceBar").instance.hide();
         $.C("bag.helper.BagHelper").instance.stopSelling();
         $.C("com.pickgliss.ui.ShowTipManager").Instance.removeCurrentTip();
         $.C("yishi.manager.BuildingManager").instance.castleMap = null;
         $.C("managers.TaskTraceTipManager").instance.cleanByType(19);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(14);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(41);
      }
    onScale() {
         if(this._castleMap)
         {
            this._castleMap.onStageScale();
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    set SceneName(v) { super.SceneName = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__CastleSceneView, "castle.CastleSceneView", []);
  return __CastleSceneView;
}
deps["castle.CastleSceneView"] = ["bag.helper.BagHelper", "castle.view.CastleMapViewII", "castle.view.layer.CastleNameLayer", "chat.view.ChatTopBugleView", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "farm.FarmManager", "flash.utils.clearTimeout", "flash.utils.setTimeout", "mainBar.ChatBar", "mainBar.FullBar", "mainBar.SmallMapBar", "mainBar.TipsBar", "manager.LanguageMgr", "managers.ChallengeManager", "managers.ChildPatrolManager", "managers.DreamArenaManager", "managers.MinosManager", "managers.RedemptionRoadManager", "managers.SpiritExpeditionManager", "managers.TaskTraceTipManager", "tasktracetip.data.TipMessageData", "ui.maintoolbar.MainToolBar", "ui.queuebar.QueueBar", "ui.resourcebar.ResourcesBar", "ui.tasktracebar.TaskTraceBar", "ui.toptoolbar.TopToolsBar", "yishi.SwitchPageHelp", "yishi.events.SceneViewEvent", "yishi.manager.ArmyManager", "yishi.manager.BraveLegManager", "yishi.manager.BuildingManager", "yishi.manager.DemonLandManager", "yishi.manager.FinalRoadManager", "yishi.manager.FrameControllerManager", "yishi.manager.HeroRoadManager", "yishi.manager.MonsterExploreManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.RemainsExploreManager", "yishi.manager.RevengeRoadManager", "yishi.manager.ShadowLandManager", "yishi.manager.TempleteSaveManager", "yishi.manager.WarSoulTowerManager", "yishi.scene.BaseSceneView", "yishi.scene.SceneManager"];

defs["castle.layer.BattleLayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BattleLayer extends __Base {
    static $fields(self) {
    self._asset = null;
    self._layerX = 0;
    self._layerY = 0;
    }
    constructor(param1) {
         super();
         this._asset = param1;
         if(this._asset)
         {
            this.addChild(param1);
         }
      }
    get asset() {
         return this._asset;
      }
    dispose() {
         if(this._asset && this._asset.parent)
         {
            this.removeChild(this._asset);
         }
         this._asset = null;
      }
    set asset(v) { super.asset = v; }
  }
  $.meta(__BattleLayer, "castle.layer.BattleLayer", []);
  return __BattleLayer;
}
deps["castle.layer.BattleLayer"] = ["flash.display.Sprite"];

defs["castle.loader.CastleBuildingLoader"] = function define($) {
  const __Base = $.Object;
  class __CastleBuildingLoader extends __Base {
    static $fields(self) {
    self._info = null;
    self._callback = null;
    self._pathArray = null;
    }
    constructor(param1, param2) {
         super();
         this._info = param1;
         this._callback = param2;
         this._pathArray = this._info.templeteInfo.PicPath.split("|");
         var _loc3_ = $.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + this._pathArray[0];
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc3_,3,8,$.bind(this, "__onComplete"));
      }
    __onComplete(param1, param2) {
         var _loc3_ = null;
         if(!this._info)
         {
            return;
         }
         if(this._pathArray.length > 1 && this._pathArray[1] && $.C("com.pickgliss.loader.ModuleLoader").hasDefinition(this._pathArray[1]))
         {
            _loc3_ = $.C("com.pickgliss.loader.ModuleLoader").getDefinition(this._pathArray[1]);
            this._info.templeteInfo.view = $.as(new _loc3_(), $.C("flash.display.DisplayObject"));
         }
         if(this._pathArray.length > 2 && this._pathArray[2] && $.C("com.pickgliss.loader.ModuleLoader").hasDefinition(this._pathArray[2]))
         {
            _loc3_ = $.C("com.pickgliss.loader.ModuleLoader").getDefinition(this._pathArray[2]);
            this._info.templeteInfo.effect = $.as(new _loc3_(), $.C("flash.display.DisplayObject"));
         }
         this._callback(this._info.templateId);
         this._callback = null;
         this._info = null;
      }
  }
  $.meta(__CastleBuildingLoader, "castle.loader.CastleBuildingLoader", []);
  return __CastleBuildingLoader;
}
deps["castle.loader.CastleBuildingLoader"] = ["com.pickgliss.loader.LoaderManagerII", "com.pickgliss.loader.ModuleLoader", "com.pickgliss.ui.ComponentSetting", "flash.display.DisplayObject"];

defs["castle.view.BuildingBase"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __BuildingBase extends __Base {
    static $fields(self) {
    self._curViewContainer = null;
    self._curView = null;
    self._effectView = null;
    self._buildingInfo = null;
    self._nameContain = null;
    self._nameBack = null;
    self._nameTxt = null;
    self._levelTxt = null;
    self._nameLayer = null;
    }
    constructor(param1) {
         super();
         this._nameLayer = param1;
         this._curViewContainer = new ($.C("com.pickgliss.ui.core.Component"))();
         this._curViewContainer.mouseChildren = false;
         this._curViewContainer.mouseEnabled = false;
         this.addChild(this._curViewContainer);
         this._nameContain = new ($.C("flash.display.Sprite"))();
         this._nameContain.mouseEnabled = false;
         this._nameContain.mouseChildren = false;
         this.addEvent();
         this.tipDirctions = "4,6,5,7";
         this.isFollowMouse = false;
         this.tipGapV = this.tipGapH = 0;
      }
    initTipStyle() {
         this.tipStyle = "yishi.view.tips.BuildTip";
      }
    get height() {
         if(this._curView)
         {
            return this._curView["effect_area"].height;
         }
         return 0;
      }
    get width() {
         if(this._curView)
         {
            return this._curView["effect_area"].width;
         }
         return 0;
      }
    addEvent() {
         $.C("yishi.manager.BuildingManager").instance.addEventListener("building_name_show_hide",$.bind(this, "_changeBuildName"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("STOP_EFFECT",$.bind(this, "__notificationHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("building_name_show_hide",$.bind(this, "_changeBuildName"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("STOP_EFFECT",$.bind(this, "__notificationHandler"));
      }
    __notificationHandler(param1) {
         if(param1.data)
         {
            this.startEffet();
         }
         else
         {
            this.stopEffect();
         }
      }
    stopEffect() {
         if(this._effectView)
         {
            ($.as(this._effectView, $.C("flash.display.MovieClip"))).stop();
         }
      }
    startEffet() {
         if(this._effectView)
         {
            ($.as(this._effectView, $.C("flash.display.MovieClip"))).play();
         }
      }
    _changeBuildName(param1) {
         this.showName = $.C("yishi.manager.BuildingManager").instance.isShowBuildingName;
      }
    addChildByScale(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._nameContain.x = $.int(this._buildingInfo.templeteInfo.TitleX * param1);
         this._nameContain.y = $.int(this._buildingInfo.templeteInfo.TitleY * param1);
         this._nameContain.scaleX = this._nameContain.scaleY = 1 / param1;
         this.addChildAt(this._nameContain,this.numChildren);
      }
    removeName() {
         if(this._nameContain.parent)
         {
            this._nameContain.parent.removeChild(this._nameContain);
         }
      }
    clean() {
      }
    refreshView() {
         if(!this._buildingInfo || this._buildingInfo.templateId < 0)
         {
            return;
         }
         this._nameContain.x = this._buildingInfo.templeteInfo.TitleX;
         this._nameContain.y = this._buildingInfo.templeteInfo.TitleY;
         this.addChild(this._nameContain);
         if(!this._nameBack)
         {
            if(this._buildingInfo.templeteInfo.SonType >= 1501)
            {
               this._nameBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.NameBack2");
               this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.BuildNameTxt2");
               this._nameTxt.text = this._buildingInfo.templeteInfo.BuildingName;
               this._nameContain.addChild(this._nameBack);
               this._nameContain.addChild(this._nameTxt);
               this._nameBack.width = this._nameTxt.textWidth + 12;
            }
            else
            {
               this._nameBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.NameBack1");
               this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.BuildNameTxt1");
               this._levelTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.BuildLevelTxt");
               this._nameContain.addChild(this._nameBack);
               this._nameContain.addChild(this._nameTxt);
               this._nameContain.addChild(this._levelTxt);
               this._nameTxt.text = this._buildingInfo.templeteInfo.BuildingName;
               this._levelTxt.text = this._buildingInfo.templeteInfo.BuildingGrade.toString();
               this._nameBack.width = this._nameTxt.textWidth + 27;
            }
         }
         else if(this._buildingInfo.templeteInfo.SonType < 1501)
         {
            this._nameTxt.text = this._buildingInfo.templeteInfo.BuildingName;
            this._levelTxt.text = this._buildingInfo.templeteInfo.BuildingGrade.toString();
         }
         this.showName = $.C("yishi.manager.BuildingManager").instance.isShowBuildingName;
      }
    initTipData() {
      }
    set buildingInfo(param1) {
         if(param1 == null)
         {
            return;
         }
         this._buildingInfo = param1;
         this.initTipStyle();
         this.initTipData();
         this.refreshView();
      }
    get buildingInfo() {
         return this._buildingInfo;
      }
    set showName(param1) {
         if(this._nameContain && this._buildingInfo.templateId > 0)
         {
            this._nameContain.visible = param1;
         }
      }
    dispose() {
         this.removeEvent();
         if(this._curView && this._curView.parent)
         {
            this._curView.parent.removeChild(this._curView);
         }
         this._curView = null;
         if(this._effectView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._effectView);
            this._effectView = null;
         }
         this._buildingInfo = null;
         if(this._nameBack)
         {
            if(this._nameBack.parent)
            {
               this._nameBack.parent.removeChild(this._nameBack);
            }
            this._nameBack.dispose();
         }
         this._nameBack = null;
         if(this._nameTxt)
         {
            if(this._nameTxt.parent)
            {
               this._nameTxt.parent.removeChild(this._nameTxt);
            }
            this._nameTxt.dispose();
         }
         this._nameTxt = null;
         if(this._levelTxt)
         {
            if(this._levelTxt.parent)
            {
               this._levelTxt.parent.removeChild(this._levelTxt);
            }
            this._levelTxt.dispose();
         }
         this._levelTxt = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    mouseClickHandler(param1) {
         return false;
      }
    mouseOutHandler(param1) {
         return false;
      }
    mouseOverHandler(param1) {
         return false;
      }
    mouseMoveHandler(param1) {
         return false;
      }
    set height(v) { super.height = v; }
    set width(v) { super.width = v; }
    get showName() { return super.showName; }
  }
  $.meta(__BuildingBase, "castle.view.BuildingBase", ["IBaseMouseEvent", "IStopEffect"]);
  return __BuildingBase;
}
deps["castle.view.BuildingBase"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "yishi.manager.BuildingManager", "yishi.manager.NotificationManager"];

defs["castle.view.CastleBuildingView"] = function define($) {
  const __Base = $.C("castle.view.BuildingBase");
  class __CastleBuildingView extends __Base {
    static $fields(self) {
    self._rect = new ($.C("flash.geom.Rectangle"))(0,0,0,0);
    self._buildingFilter = null;
    self._colorManager = null;
    self._effect = null;
    self._newBuilding = false;
    self.isLoaded = false;
    self.isShowed = false;
    self._isUpgrade = false;
    self.$$_scale = NaN;
    }
    constructor(param1, param2 = null) {
         $.pre(new.target, (__s) => {
         __s._buildingFilter = param1;
         });
         super(param2);
         $.preFlush(this, new.target);
      }
    get checkRect() {
         return this._rect;
      }
    get isAdornment() {
         switch($.int(this._buildingInfo.templeteInfo.SonType) - 1501)
         {
            case 0:
            case 1:
            case 2:
            case 5:
            case 7:
            case 9:
               return true;
            default:
               return false;
         }
      }
    initTipStyle() {
         if(this.isAdornment)
         {
            return;
         }
         switch(this._buildingInfo.templeteInfo.SonType)
         {
            case 1501:
            case 1503:
            case 1502:
            case 1504:
            case 1505:
            case 1506:
            case 1507:
            case 1509:
            case 1510:
            case 1511:
            case 101:
            case 1201:
            case 301:
            case 1801:
            case 1601:
            case 1701:
               this.tipStyle = "yishi.view.tips.WaterTreeTip";
               break;
            default:
               this.tipStyle = "yishi.view.tips.BuildTip";
         }
      }
    initTipData() {
         var _loc1_ = null;
         var _loc2_ = null;
         if(this.isAdornment)
         {
            return;
         }
         switch(this._buildingInfo.templeteInfo.SonType)
         {
            case 1501:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command01");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command02");
               this.tipData = _loc1_;
               break;
            case 1503:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command03");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command04");
               this.tipData = _loc1_;
               break;
            case 1502:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command05");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command06");
               this.tipData = _loc1_;
               break;
            case 1509:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command071");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command081");
               this.tipData = _loc1_;
               break;
            case 1504:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command09");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command10");
               this.tipData = _loc1_;
               break;
            case 1507:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command11");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command12");
               this.tipData = _loc1_;
               break;
            case 1510:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command13");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command14");
               this.tipData = _loc1_;
               break;
            case 1511:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command15");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command16");
               this.tipData = _loc1_;
               break;
            case 1506:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command24");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command25");
               this.tipData = _loc1_;
               break;
            case 1505:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.vehicleTitle");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.vehicleContent");
               this.tipData = _loc1_;
               break;
            case 1801:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command26");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command27");
               this.tipData = _loc1_;
               break;
            case 1601:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command28");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command29");
               this.tipData = _loc1_;
               break;
            case 1701:
               _loc1_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
               _loc1_.title = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command30");
               _loc1_.content = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command31");
               this.tipData = _loc1_;
               break;
            case 1508:
               break;
            default:
               this.tipData = this._buildingInfo;
         }
         if(this.isNotOpen())
         {
            _loc2_ = "";
            switch(this._buildingInfo.templeteInfo.SonType)
            {
               case 1511:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",15);
                  break;
               case 1507:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",12);
                  break;
               case 1509:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",12);
                  break;
               case 1801:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",25);
                  break;
               case 1601:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",32);
                  break;
               case 1701:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command38");
            }
            if(_loc1_)
            {
               _loc1_.content = _loc2_;
            }
            this.buttonMode = false;
         }
         else
         {
            this.buttonMode = true;
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get curView() {
         return this._curView;
      }
    mouseOverHandler(param1) {
         if(this.isAdornment)
         {
            return true;
         }
         if(this._curView && !this.isNotOpen())
         {
            this._buildingFilter.setBuildingOverFilter(this._curView["effect_area"]);
         }
         return true;
      }
    mouseOutHandler(param1) {
         if(this.isAdornment)
         {
            return true;
         }
         if(this._curView && !this.isNotOpen())
         {
            this._buildingFilter.setBuildingOutFilter(this._curView["effect_area"]);
         }
         return true;
      }
    mouseClickHandler(param1) {
         if(this.isAdornment)
         {
            return true;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("011",true);
         var _loc2_ = "";
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return false;
         }
         switch(this._buildingInfo.templeteInfo.SonType)
         {
            case 1501:
               if(this.thane.grades < 7)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command17");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.storeController.startFrameByType("STORE_PANEL_INTENSIFY");
               break;
            case 1503:
               if(this.thane.grades < 16)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command18");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.SwitchPageHelp").goSpaceAndFind(6);
               break;
            case 1502:
               if(this.thane.grades < 20)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command19");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.SwitchPageHelp").goSpaceAndFind(2);
               break;
            case 1510:
               $.C("yishi.SwitchPageHelp").goSpaceAndFind(1);
               break;
            case 1504:
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("hook");
               break;
            case 1507:
               if(this.thane.grades < 12)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command20");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("maze");
               break;
            case 1505:
               if(this.thane.grades < 35)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.noOpen");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("vehicledaimon");
               break;
            case 1509:
               if(this.thane.grades < 12)
               {
                  $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command37"));
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("farm","CastleBuildingView.FarmEnterNewFrame");
               break;
            case 1508:
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command21");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               break;
            case 1506:
               $.C("yishi.SwitchPageHelp").goSpaceAndFind(8);
               break;
            case 101:
            case 1201:
            case 301:
               break;
            case 1511:
               if(this.thane.grades < 15)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command36");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo($.C("mvc.controler.BuildingControler").getModelNameByInfo(this._buildingInfo),null,this._buildingInfo);
               break;
            case 1801:
               if(this.thane.grades < 25)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command32");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("minefield");
               break;
            case 1601:
               if(this.thane.grades < 32)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command33");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("magiccard");
               break;
            case 1701:
               if(this.thane.vocationGrades <= 0)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command34");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return false;
               }
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("perkinlab");
               break;
            default:
               $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo($.C("mvc.controler.BuildingControler").getModelNameByInfo(this._buildingInfo),null,this._buildingInfo);
         }
         return true;
      }
    clean() {
         this.isLoaded = false;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._curViewContainer);
         this._curView = null;
         if(this._effectView)
         {
            ($.as(this._effectView, $.C("flash.display.MovieClip"))).stop();
            this._effectView = null;
         }
      }
    refreshView() {
         if(!this._buildingInfo)
         {
            return;
         }
         super.refreshView();
         var _loc2_ = this._buildingInfo.templeteInfo;
         var _loc1_ = _loc2_.view;
         this.setCurView(_loc1_);
         if(_loc1_ == null && !this._curView)
         {
            if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc2_.PicPath) != false)
            {
               throw new Error($.C("manager.LanguageMgr").GetTranslation("castle.view.CastleBuildingView.command22"));
            }
            new ($.C("castle.loader.CastleBuildingLoader"))(this._buildingInfo,$.bind(this, "loadViewCallBack"));
         }
      }
    loadViewCallBack(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this._buildingInfo || this._buildingInfo.templateId != param1)
         {
            return;
         }
         var _loc3_ = this._buildingInfo.templeteInfo;
         var _loc2_ = _loc3_.view;
         if(_loc2_ != null)
         {
            if(this._newBuilding)
            {
               this.newBuildingFocus();
            }
            else
            {
               this.setCurView(_loc2_);
            }
         }
         this.isLoaded = true;
         $.C("yishi.manager.BuildingManager").instance.dispatchEvent(new ($.C("events.BuildingEvent"))("BUILDING_LOAD_COMPLETE",this._buildingInfo));
         if(this.isAdornment)
         {
            this.showName = false;
            this.buttonMode = false;
            this.removeEvent();
         }
         if(this._curView && this.isNotOpen())
         {
            this._buildingFilter.setGrayFilter(this._curView);
         }
      }
    isNotOpen() {
         return this._buildingInfo.templeteInfo.SonType == 1511 && this.thane.grades < 15 || this._buildingInfo.templeteInfo.SonType == 1507 && this.thane.grades < 12 || this._buildingInfo.templeteInfo.SonType == 1509 && this.thane.grades < 12 || this._buildingInfo.templeteInfo.SonType == 1801 && this.thane.grades < 25 || this._buildingInfo.templeteInfo.SonType == 1601 && this.thane.grades < 32 || this._buildingInfo.templeteInfo.SonType == 1701 && this.thane.vocationGrades <= 0;
      }
    updateShowFilter() {
         if(this._curView && !this.isNotOpen() && !this.isShowed)
         {
            this.initTipData();
            this._buildingFilter.setNormalFilter(this._curView);
            this.isShowed = true;
         }
      }
    setCurView(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         if(this._isUpgrade)
         {
            this.setBuildingFinishView();
            this.addChildByScale(this.$$_scale);
         }
         if(param1 == null || this._curView)
         {
            return;
         }
         this._curView = param1;
         this.startPoint = new ($.C("flash.geom.Point"))(this._curView.x,this._curView.y);
         this._rect.x = this._buildingInfo.templeteInfo.PosX + this._curView["line"].x;
         this._rect.y = this._buildingInfo.templeteInfo.PosY + this._curView["line"].y;
         this._curViewContainer.addChild(this._curView);
         this._effectView = this._buildingInfo.templeteInfo.effect;
         if(this._effectView)
         {
            ($.as(this._effectView, $.C("flash.display.MovieClip"))).play();
            this._curViewContainer.addChild(this._effectView);
         }
         this.tipGapV = -this._curView.height / 3;
         this.tipGapH = -this._curView.width / 3;
         if(this._curView["effect_area"])
         {
            _loc2_ = new ($.C("flash.display.BitmapData"))(this._curView["effect_area"].width,this._curView["effect_area"].height,true,0);
            _loc2_.draw(this._curView["effect_area"]);
            _loc3_ = $.C("com.pickgliss.utils.DisplayUtils").getHitArea(_loc2_,5);
            this.hitArea = _loc3_;
            this._curViewContainer.addChild(_loc3_);
         }
         else
         {
            this.mouseEnabled = this.mouseChildren = false;
         }
      }
    set newBuilding(param1) {
         this._newBuilding = param1;
         this.newBuildingFocus();
      }
    newBuildingFocus() {
         this._newBuilding = false;
         this._curView = this._buildingInfo.templeteInfo.view;
         if(this._curView)
         {
            this._curViewContainer.addChild(this._curView);
            this._colorManager = new ($.C("yishi.utils.ColorManager"))(this._curView["effect_area"]);
            this._colorManager.addEventListener("complete",$.bind(this, "__onFinish"));
         }
         else
         {
            this.refreshView();
         }
      }
    __onFinish(param1) {
         if(this._colorManager)
         {
            this._colorManager.removeEventListener("complete",$.bind(this, "__onFinish"));
            this._colorManager = null;
         }
         this.refreshView();
      }
    buildingLevelUpdated(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._isUpgrade = true;
         this.$$_scale = param1;
      }
    setBuildingFinishView() {
         if(!this._curView || !this._curView["effect_area"])
         {
            return;
         }
         this.buttonMode = true;
         this._isUpgrade = false;
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("castle.BuildLevelUpEffectMC");
         this._effect = new ($.C("yishi.view.tools.SimpleMovie"))(_loc2_);
         this._effect.addEventListener("complete",$.bind(this, "__effectComplete"));
         var _loc1_ = this._curView["effect_area"].width / this._effect.width + 0.4;
         this._effect.width *= _loc1_;
         this._effect.height *= _loc1_;
         this._effect.mouseChildren = false;
         this._effect.mouseEnabled = false;
         this._effect.x = this._curView["effect_area"].width / 2 * this._curView["effect_area"].scaleX;
         this._effect.y = this._curView["effect_area"].height * this._curView["effect_area"].scaleY;
         this.addChild(this._effect);
      }
    __effectComplete(param1) {
         if(this._effect)
         {
            this._effect.removeEventListener("complete",$.bind(this, "__effectComplete"));
         }
         this._effect = null;
      }
    dispose() {
         this.clean();
         this._buildingFilter = null;
         this._colorManager = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._curViewContainer);
         this._curViewContainer = null;
         this._buildingInfo = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._effect);
         this._effect = null;
         $.C("com.pickgliss.ui.ShowTipManager").Instance.removeTip(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    set checkRect(v) { super.checkRect = v; }
    set isAdornment(v) { super.isAdornment = v; }
    set thane(v) { super.thane = v; }
    set curView(v) { super.curView = v; }
    get newBuilding() { return super.newBuilding; }
  }
  $.meta(__CastleBuildingView, "castle.view.CastleBuildingView", ["ICheck"]);
  return __CastleBuildingView;
}
deps["castle.view.CastleBuildingView"] = ["castle.loader.CastleBuildingLoader", "castle.view.BuildingBase", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.utils.DisplayUtils", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "events.BuildingEvent", "flash.display.BitmapData", "flash.display.MovieClip", "flash.geom.Point", "flash.geom.Rectangle", "manager.LanguageMgr", "managers.MopupManager", "mvc.controler.BuildingControler", "yishi.SwitchPageHelp", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager", "yishi.utils.ColorManager", "yishi.utils.StringHelper", "yishi.view.tips.MessageTipManager", "yishi.view.tips.WaterTreeTipInfo", "yishi.view.tools.SimpleMovie"];

defs["castle.view.CastleDialogView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CastleDialogView extends __Base {
    static $fields(self) {
    self._back = null;
    self._arror = null;
    self._iocnBack = null;
    self._icon = null;
    self._name = null;
    self._content = null;
    self._closeBtn = null;
    self._type = 0;
    self._callBack = null;
    self._iconMask = null;
    self._canvas = null;
    self._container = null;
    self._viewRectangle = new ($.C("flash.geom.Rectangle"))(0,0,628,290);
    }
    constructor(param1, param2) {
         super();
         this._type = param1;
         this._callBack = param2;
         this.initView();
         this.initEvent();
         this.mouseEnabled = false;
         this._iconMask.mouseEnabled = this._iconMask.mouseChildren = false;
      }
    get viewRectangle() {
         return this._viewRectangle;
      }
    initView() {
         this._container = new ($.C("flash.display.Sprite"))();
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.DialogIconBack");
         this._arror = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.RoleDialogArror");
         this._iocnBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.castle.DialogIconBack");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.castle.DialogIcon_" + this._type);
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.DialogName");
         this._content = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.DialogContent");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.DialogBtn");
         this._iconMask = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("castle.DialogIconMask");
         this._container.addChild(this._iocnBack);
         this._container.addChild(this._back);
         this._container.addChild(this._icon);
         this._container.addChild(this._arror);
         this._container.addChild(this._name);
         this._container.addChild(this._content);
         this._icon.mask = this._iconMask;
         this._container.addChild(this._iconMask);
      }
    initEvent() {
         this._closeBtn.addEventListener("click",$.bind(this, "__closeHandler"));
      }
    removeEvent() {
         this._closeBtn.removeEventListener("click",$.bind(this, "__closeHandler"));
      }
    __closeHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this.dispose();
      }
    setContent(param1, param2, param3) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         this._name.text = this.getNameByType();
         this._content.text = param1;
         this.x = param2;
         this.y = param3;
         var _loc4_ = new ($.C("flash.display.BitmapData"))(this.viewRectangle.width,this.viewRectangle.height,true,0);
         _loc4_.draw(this._container);
         this._canvas = new ($.C("flash.display.Bitmap"))(_loc4_);
         this.addChild(this._canvas);
         this.addChild(this._closeBtn);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,7);
      }
    getNameByType() {
         switch(this._type - 1)
         {
            case 0:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.FLOWER_WOMEN");
            case 1:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.FLAMAN");
            case 2:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.WARRIOR_WOMEN");
            case 3:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.SOLDIER");
            case 4:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.BUSSINESSMAN");
            case 5:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.BINLUO");
            case 6:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.SOLDIER_LEADER");
            case 7:
               return $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleDialogView.DRUDGERY");
            default:
               return "";
         }
      }
    dispose() {
         this.removeEvent();
         if(this._callBack != null)
         {
            this._callBack();
         }
         this._callBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iocnBack);
         this._iocnBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         this._name = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._content);
         this._content = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._closeBtn);
         this._closeBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iconMask);
         this._iconMask = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._canvas);
         this._canvas = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._container);
         this._container = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__CastleDialogView, "castle.view.CastleDialogView", ["Disposeable", "IManualSize"]);
  return __CastleDialogView;
}
deps["castle.view.CastleDialogView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Bitmap", "flash.display.BitmapData", "flash.display.Sprite", "flash.geom.Rectangle", "manager.LanguageMgr"];

defs["castle.view.CastleMapViewII"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CastleMapViewII extends __Base {
    static $fields(self) {
    self._backgroundLayer = null;
    self._animalLayer = null;
    self._walkLayer = null;
    self._airLayer = null;
    self._nameLayer = null;
    self._borderLayer = null;
    self._dragObj = null;
    self._mouseTime = 0;
    self._timeId = 0;
    self._mouseDown = false;
    self._minScale = NaN;
    }
    constructor(param1) {
         super();
         this._nameLayer = param1;
         this.initBackgroundLayer();
         this.initWalklayer();
         this.initAirLayer();
         this.initBorderLayer();
         this.initEvent();
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    initBackgroundLayer() {
         this._backgroundLayer = new ($.C("castle.view.layer.CastleBackgroundLayer"))();
         this.addChild(this._backgroundLayer);
      }
    initAnimalLayer() {
         this._animalLayer = new ($.C("castle.view.layer.CastleAnimalLayer"))();
         this.addChild(this._animalLayer);
      }
    initWalklayer() {
         this._walkLayer = new ($.C("castle.view.layer.CastleWalkLayer"))(this._nameLayer);
         this.addChild(this._walkLayer);
      }
    initAirLayer() {
         this._airLayer = new ($.C("castle.view.layer.CastleAirlayer"))();
         this.addChild(this._airLayer);
      }
    initBorderLayer() {
         this._borderLayer = new ($.C("castle.view.layer.FogBorderLayer"))(this._backgroundLayer.resWidth,this._backgroundLayer.resHeight);
         this.addChild(this._borderLayer);
      }
    initEvent() {
         this.addEventListener("mouseDown",$.bind(this, "__onMouseDownHandler"));
         this.addEventListener("mouseUp",$.bind(this, "__onMouseUpHandler"));
         this.addEventListener("mouseWheel",$.bind(this, "__onMouseWheel"));
         this.addEventListener("mouseOver",$.bind(this, "__onMouseOver"));
         this.addEventListener("mouseOut",$.bind(this, "__onMouseOut"));
         $.C("yishi.keyboard.KeyBoardRegister").instance.registerMapKey($.bind(this, "__leftMove"),$.bind(this, "__rightMove"),$.bind(this, "__topMove"),$.bind(this, "__downMove"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("CREATE_NEW_BUILDING",$.bind(this, "__createNewBuildHandler"));
         $.C("yishi.manager.BuildingManager").instance.addEventListener("BUILDING_UPGRADE_RECEIVE",$.bind(this, "__buildUpgradeHandler"));
         this._dragObj = new ($.C("yishi.utils.TweenDrag"))(this,this);
         this._dragObj.onDraging = $.bind(this, "dragingCallBack");
         this._dragObj.onDragDrop = $.bind(this, "dropCallBack");
         this._dragObj.onTweening = $.bind(this, "dragingCallBack");
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__resizeHandler"));
      }
    removeEvent() {
         this.removeEventListener("mouseDown",$.bind(this, "__onMouseDownHandler"));
         this.removeEventListener("mouseUp",$.bind(this, "__onMouseUpHandler"));
         this.removeEventListener("mouseWheel",$.bind(this, "__onMouseWheel"));
         this.removeEventListener("mouseOver",$.bind(this, "__onMouseOver"));
         this.removeEventListener("mouseOut",$.bind(this, "__onMouseOut"));
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("CREATE_NEW_BUILDING",$.bind(this, "__createNewBuildHandler"));
         $.C("yishi.manager.BuildingManager").instance.removeEventListener("BUILDING_UPGRADE_RECEIVE",$.bind(this, "__buildUpgradeHandler"));
         this._dragObj.enable = false;
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__resizeHandler"));
      }
    __resizeHandler(param1) {
         this.scaleX = this.scaleY = 1;
         this.dragingCallBack();
         this.dropCallBack();
         this.addName(this.scaleX);
      }
    __leftMove() {
         this.x += 50;
         this.dragingCallBack();
         this.dropCallBack();
      }
    __rightMove() {
         this.x -= 50;
         this.dragingCallBack();
         this.dropCallBack();
      }
    __topMove() {
         this.y += 50;
         this.dragingCallBack();
         this.dropCallBack();
      }
    __downMove() {
         this.y -= 50;
         this.dragingCallBack();
         this.dropCallBack();
      }
    __onMouseOver(param1) {
         param1.stopPropagation();
         var _loc2_ = $.as(param1.target, $.C("castle.view.CastleBuildingView"));
         if(!_loc2_)
         {
            return;
         }
         for (var _loc3_ of $.values(this._walkLayer.buildingsDic))
         {
            if(_loc2_.buildingInfo.sonType == _loc3_.buildingInfo.sonType)
            {
               _loc3_.mouseOverHandler(param1);
            }
         }
      }
    __onMouseOut(param1) {
         param1.stopPropagation();
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
         }
         var _loc2_ = $.as(param1.target, $.C("castle.view.CastleBuildingView"));
         if(!_loc2_)
         {
            return;
         }
         for (var _loc3_ of $.values(this._walkLayer.buildingsDic))
         {
            if(_loc2_.buildingInfo.sonType == _loc3_.buildingInfo.sonType)
            {
               _loc3_.mouseOutHandler(param1);
            }
         }
      }
    __onMouseDownHandler(param1) {
         this._mouseDown = true;
         this._mouseTime = $.C("flash.utils.getTimer")();
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
         }
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "dragStart"),300);
      }
    __onMouseUpHandler(param1) {
         var _loc2_ = $.C("flash.utils.getTimer")() - this._mouseTime;
         this._mouseDown = false;
         if(_loc2_ < 300)
         {
            this.castleMapClick(param1);
         }
      }
    castleMapClick(param1) {
         if($.as(param1.target, $.C("castle.view.BuildingBase")))
         {
            ($.as(param1.target, $.C("castle.view.BuildingBase"))).mouseClickHandler(param1);
         }
         this.dropCallBack();
      }
    removeName() {
         for (var _loc1_ of $.values(this._walkLayer.buildingsDic))
         {
            _loc1_.removeName();
         }
      }
    addName(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         for (var _loc2_ of $.values(this._walkLayer.buildingsDic))
         {
            _loc2_.addChildByScale(param1);
         }
      }
    __onMouseWheel(param1) {
      }
    __buildUpgradeHandler(param1) {
         if(param1.buildingInfo.templeteInfo.MasterType == 13 || param1.buildingInfo.templeteInfo.MasterType == 14)
         {
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("010",true);
         this._walkLayer.updateBuildingView(param1.buildingInfo);
      }
    __createNewBuildHandler(param1) {
         var _loc4_ = param1.buildingInfo.templeteInfo;
         if(_loc4_.MasterType == 13 || _loc4_.MasterType == 14)
         {
            return;
         }
         this._walkLayer.updateBuildingView(param1.buildingInfo);
         var _loc3_ = param1.buildingInfo.templeteInfo;
         var _loc2_ = $.as(this.buildingsDic[param1.buildingInfo.buildingId], $.C("castle.view.CastleBuildingView"));
         var _loc5_ = this.getTopoint(_loc2_);
         if($.C("yishi.manager.PlayerManager").instance.newbieProcess >= 21000)
         {
            $.C("yishi.utils.DelayActionsUtils").instance.addAction(new ($.C("yishi.actions.castle.NewBuildAction"))(this,param1.buildingInfo,_loc5_.x,_loc5_.y,$.bind(this, "newBuildingFocus")));
         }
      }
    newBuildingFocus(param1) {
         var _loc2_ = $.as(this.buildingsDic[param1.buildingId], $.C("castle.view.CastleBuildingView"));
         _loc2_.newBuilding = true;
      }
    moveFocus(param1, param2) {
         if(this.beyondScreen())
         {
            if(param2 != null)
            {
               param1 ? param2(param1) : param2();
            }
            param2 = null;
            param1 = null;
            return;
         }
         var _loc3_ = $.as(this.buildingsDic[param1.buildingId], $.C("castle.view.CastleBuildingView"));
         var _loc4_ = this.getTopoint(_loc3_);
         $.C("yishi.utils.DelayActionsUtils").instance.addAction(new ($.C("yishi.actions.castle.NewBuildAction"))(this,param1,_loc4_.x,_loc4_.y,param2));
      }
    moveFocus2(param1, param2) {
         if(this.beyondScreen())
         {
            if(param2 != null)
            {
               param2();
            }
            param2 = null;
            return;
         }
         var _loc3_ = this.getTopoint(param1);
         $.C("yishi.utils.DelayActionsUtils").instance.addAction(new ($.C("yishi.actions.castle.NewBuildAction"))(this,null,_loc3_.x,_loc3_.y,param2));
      }
    getTopoint(param1) {
         var _loc3_ = new ($.C("flash.geom.Point"))();
         var _loc2_ = $.C("com.pickgliss.toplevel.StageReferance").stageWidth / 2 - param1.x - param1.width / 2;
         var _loc4_ = $.C("com.pickgliss.toplevel.StageReferance").stageHeight / 2 - param1.y - param1.height / 2;
         if(_loc2_ < $.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._backgroundLayer.resWidth * this.scaleX)
         {
            _loc2_ = $.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._backgroundLayer.resWidth * this.scaleX;
         }
         else if(_loc2_ > 0)
         {
            _loc2_ = 0;
         }
         if(_loc4_ < $.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._backgroundLayer.resHeight * this.scaleY)
         {
            _loc4_ = $.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._backgroundLayer.resHeight * this.scaleY;
         }
         else if(_loc4_ > 0)
         {
            _loc4_ = 0;
         }
         _loc3_.x = _loc2_;
         _loc3_.y = _loc4_;
         return _loc3_;
      }
    moveMapToPoint(param1, param2) {
         $.C("com.greensock.TweenMax").to(this,1,{
            "x":this.stage.stageWidth / 2 - param1.x,
            "y":this.stage.stageHeight / 2 - param1.y,
            "onComplete":param2
         });
      }
    moveMapToPointII(param1, param2) {
         $.C("com.greensock.TweenMax").to(this,1,{
            "x":this.stage.stageWidth / 2 - param1.x,
            "y":this.stage.stageHeight / 2 - param1.y,
            "onUpdate":$.bind(this, "dragingCallBack"),
            "onComplete":param2
         });
      }
    dragStart() {
         $.C("flash.utils.clearTimeout")(this._timeId);
         this._timeId = 0;
         if(this._mouseDown)
         {
            this.dragStartCallBack();
         }
      }
    dragStartCallBack() {
         $.C("com.greensock.TweenMax").killTweensOf(this);
         if($.C("yishi.manager.PlayerManager").instance.newbieProcess <= 25000)
         {
            return;
         }
         $.C("yishi.manager.CursorManagerII").instance.showCursorByType("DRAG_CURSOR");
      }
    dropCallBack() {
         $.C("yishi.manager.CursorManagerII").instance.resetCursor();
      }
    onStageScale() {
         this.scaleX = 1;
         this.scaleY = 1;
         this._nameLayer.refreshChild(1);
         this.dragingCallBack();
         this.addName(1);
      }
    dragingCallBack() {
         if(this._backgroundLayer.resWidth * this.scaleX < $.C("com.pickgliss.toplevel.StageReferance").stageWidth)
         {
            this.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._backgroundLayer.resWidth * this.scaleX) * 0.5;
         }
         else if(this.x < $.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._backgroundLayer.resWidth * this.scaleX)
         {
            this.x = $.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._backgroundLayer.resWidth * this.scaleX;
         }
         else if(this.x > 0)
         {
            this.x = 0;
         }
         if(this._backgroundLayer.resHeight * this.scaleY < $.C("com.pickgliss.toplevel.StageReferance").stageHeight)
         {
            this.y = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._backgroundLayer.resHeight * this.scaleY) * 0.5;
         }
         else if(this.y < $.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._backgroundLayer.resHeight * this.scaleY)
         {
            this.y = $.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._backgroundLayer.resHeight * this.scaleY;
         }
         else if(this.y > 0)
         {
            this.y = 0;
         }
      }
    beyondScreen() {
         if(this._backgroundLayer.resWidth * this.scaleX < $.C("com.pickgliss.toplevel.StageReferance").stageWidth)
         {
            return true;
         }
         if(this._backgroundLayer.resHeight * this.scaleY < $.C("com.pickgliss.toplevel.StageReferance").stageHeight)
         {
            return true;
         }
         return false;
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.x = param1;
         this._nameLayer.x = param1;
      }
    set y(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.y = param1;
         this._nameLayer.y = param1;
      }
    get buildingsDic() {
         return this._walkLayer.buildingsDic;
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.keyboard.KeyBoardRegister").instance.removeMapKey($.bind(this, "__leftMove"),$.bind(this, "__rightMove"),$.bind(this, "__topMove"),$.bind(this, "__downMove"));
         $.C("com.greensock.TweenMax").killTweensOf(this);
         this._dragObj.dispose();
         this._dragObj = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._backgroundLayer);
         this._backgroundLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._animalLayer);
         this._animalLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._walkLayer);
         this._walkLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._airLayer);
         this._airLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._borderLayer);
         this._borderLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameLayer);
         this._nameLayer = null;
         this._backgroundLayer = null;
         this._animalLayer = null;
         this._walkLayer = null;
         this._airLayer = null;
         this._nameLayer = null;
         this._borderLayer = null;
      }
    set thane(v) { super.thane = v; }
    get x() { return super.x; }
    get y() { return super.y; }
    set buildingsDic(v) { super.buildingsDic = v; }
  }
  $.meta(__CastleMapViewII, "castle.view.CastleMapViewII", ["Disposeable"]);
  return __CastleMapViewII;
}
deps["castle.view.CastleMapViewII"] = ["castle.view.BuildingBase", "castle.view.CastleBuildingView", "castle.view.layer.CastleAirlayer", "castle.view.layer.CastleAnimalLayer", "castle.view.layer.CastleBackgroundLayer", "castle.view.layer.CastleWalkLayer", "castle.view.layer.FogBorderLayer", "com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.geom.Point", "flash.utils.clearTimeout", "flash.utils.getTimer", "flash.utils.setTimeout", "yishi.actions.castle.NewBuildAction", "yishi.keyboard.KeyBoardRegister", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.CursorManagerII", "yishi.manager.PlayerManager", "yishi.utils.DelayActionsUtils", "yishi.utils.TweenDrag"];

defs["castle.view.CastleNPCView"] = function define($) {
  const __Base = $.C("yishi.ai.AIPhysicsFourDirection");
  class __CastleNPCView extends __Base {
    static $fields(self) {
    self._specialFront = null;
    self._standPos = null;
    self._special = false;
    self._specialTotal = 0;
    self._specialCurrent = 0;
    self._specialCountList = [75,125];
    self._stand = false;
    self._standCount = 50;
    self._standCurrent = 0;
    self._dialogDic = null;
    self._currentDiagIndex = 0;
    self.depth = 0;
    self.type = 0;
    self.specialPoint = null;
    self._dialogView = null;
    self._filter = null;
    self._forceStand = false;
    }
    constructor(param1, param2, param3, param4, param5) {
         super(param1,param2,param3,param4);
         this._specialFront = param5;
         this._standPos = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.StandShadowAsset");
         this._standPos.x = -16;
         this._standPos.y = -16;
         this._standPos.scaleX = this._standPos.scaleY = 0.4;
         this._standPos.alpha = 0.8;
         this.initData();
         this.initEvent();
         this._filter = new ($.C("yishi.filter.SimpleBuildingFilter"))();
         this.buttonMode = true;
      }
    get checkRect() {
         return new ($.C("flash.geom.Rectangle"))(this.x,this.y,24,50);
      }
    initData() {
         this._dialogDic = new ($.C("flash.utils.Dictionary"))(true);
         var _loc18_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen1");
         var _loc20_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen2");
         var _loc15_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen3");
         var _loc17_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlowerWomen4");
         this._dialogDic[1] = [_loc18_,_loc20_,_loc15_,_loc17_];
         var _loc28_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlaman1");
         var _loc26_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlaman2");
         var _loc31_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlaman3");
         var _loc30_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicFlaman4");
         this._dialogDic[2] = [_loc28_,_loc26_,_loc31_,_loc30_];
         var _loc22_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen1");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen2");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen3");
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicWarriorWomen4");
         this._dialogDic[3] = [_loc22_,_loc4_,_loc3_,_loc1_];
         var _loc16_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldier1");
         var _loc21_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldier2");
         var _loc19_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldier3");
         var _loc32_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldier4");
         this._dialogDic[4] = [_loc16_,_loc21_,_loc19_,_loc32_];
         var _loc7_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman1");
         var _loc8_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman2");
         var _loc27_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman3");
         var _loc29_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicBussinessman4");
         this._dialogDic[5] = [_loc7_,_loc8_,_loc27_,_loc29_];
         var _loc13_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDinluo1");
         var _loc11_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDinluo2");
         var _loc6_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDinluo3");
         var _loc5_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDinluo4");
         this._dialogDic[6] = [_loc13_,_loc11_,_loc6_,_loc5_];
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey1");
         var _loc24_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey2");
         var _loc25_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey3");
         var _loc23_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicDrudgrey4");
         this._dialogDic[8] = [_loc2_,_loc24_,_loc25_,_loc23_];
         var _loc12_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader1");
         var _loc14_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader2");
         var _loc9_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader3");
         var _loc10_ = $.C("manager.LanguageMgr").GetTranslation("castle.view.CastleNPCView.dialogDicSoldierLeader4");
         this._dialogDic[7] = [_loc12_,_loc14_,_loc9_,_loc10_];
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
    __overHandler(param1) {
         this._filter.setLightFilter(this);
         this._forceStand = true;
         this.stand = true;
      }
    __outHandler(param1) {
         this._filter.setNormalFilter(this);
         this._forceStand = false;
         this.stand = true;
      }
    __clickHandler(param1) {
         var _loc5_ = null;
         var _loc4_ = 0;
         var _loc3_ = 0;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._filter.setNormalFilter(this);
         var _loc2_ = $.as(this._dialogDic[this.type][this._currentDiagIndex], "String");
         this._currentDiagIndex = this._currentDiagIndex + 1;
         if(this._currentDiagIndex == this._dialogDic[this.type].length)
         {
            this._currentDiagIndex = 0;
         }
         if(this._dialogView)
         {
            this._dialogView.dispose();
            this._dialogView = null;
            this.stand = true;
            return;
         }
         this._dialogView = new ($.C("castle.view.CastleDialogView"))(this.type,$.bind(this, "callBack"));
         if(this._dialogView)
         {
            _loc5_ = this.parent.localToGlobal(new ($.C("flash.geom.Point"))(this.x,this.y - this.displayHeight));
            this._dialogView.scaleX = this._dialogView.scaleY = 0.2;
            this._dialogView.setContent(_loc2_,_loc5_.x,_loc5_.y);
            _loc4_ = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._dialogView.viewRectangle.width) / 2;
            _loc3_ = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._dialogView.viewRectangle.height) / 2 - 80;
            $.C("com.greensock.TweenMax").to(this._dialogView,0.5,{
               "scaleX":1,
               "scaleY":1,
               "x":_loc4_,
               "y":_loc3_
            });
            this.stand = true;
         }
      }
    callBack() {
         this._dialogView = null;
         this.stand = true;
      }
    set info(param1) {
         super.info = param1;
         if(param1.pathInfo.length == 1)
         {
            this._stand = true;
         }
      }
    set stand(param1) {
         this._stand = param1;
         if(!this._stand)
         {
            return;
         }
         this._standCurrent = 0;
      }
    set special(param1) {
         var _loc2_ = 0;
         this._special = param1;
         if(!this._special)
         {
            return;
         }
         this.stand = param1;
         this._specialCurrent = 0;
         if(this._info.pathInfo.length == 1)
         {
            _loc2_ = $.int(Math.random() * 10) / 5;
            this._specialTotal = this._specialCountList[_loc2_];
         }
      }
    execute() {
         if(this._info.pathInfo.length == 1 && this._special)
         {
            this.playSpecial();
            return;
         }
         if(this._stand)
         {
            this.playStand();
            return;
         }
         if(this._special)
         {
            this.playSpecial();
            return;
         }
         this.playWalk();
      }
    playStand() {
         if(this._info.pathInfo.length == 1)
         {
            this.checkStandDirection(null);
            this._info.currentFrame++;
            if(this._info.currentFrame % 48 == 0 && !this._special)
            {
               this._info.currentFrame = 0;
               this.special = $.int(Math.random() * 10) < 1;
            }
            return;
         }
         if(this._standCurrent < this._standCount)
         {
            if(this._standCurrent == 0)
            {
               this.checkStandDirection(this._info.pathInfo[this._info.nextIndex]);
            }
            this._standCurrent = this._standCurrent + 1;
            if(this._dialogView || this._forceStand)
            {
               this._standCurrent = 0;
            }
         }
         else
         {
            if(!this._special)
            {
               this.checkDirection(this._info.pathInfo[this.info.nextIndex]);
            }
            this._stand = false;
         }
      }
    playSpecial() {
         if(this._specialTotal == 0)
         {
            this.checkSpecialDirection(this._info.pathInfo[this._info.nextIndex]);
            this._specialTotal = ($.as(this.movieClip, $.C("flash.display.MovieClip"))).totalFrames;
         }
         if(this._specialCurrent < this._specialTotal)
         {
            if(this._info.pathInfo.length == 1 && this._specialCurrent == 0)
            {
               this.checkSpecialDirection(null);
            }
            else if(this._specialCurrent == 0)
            {
               this.checkSpecialDirection(this._info.pathInfo[this._info.nextIndex]);
            }
            this._specialCurrent = this._specialCurrent + 1;
         }
         else
         {
            if(this._info.pathInfo.length == 1)
            {
               this.checkStandDirection(null);
            }
            else if(!this._special)
            {
               this.checkDirection(this._info.pathInfo[this.info.nextIndex]);
            }
            this._special = false;
            this.stand = true;
         }
      }
    playWalk() {
         var _loc1_ = null;
         if(this._info.pathInfo.length > this._info.walkIndex)
         {
            if(this.info.currentFrame >= this.info.totalFrame)
            {
               _loc1_ = $.as(this._info.pathInfo[this.info.walkIndexToNext], $.C("flash.geom.Point"));
               this.nextWalk(_loc1_);
            }
            else
            {
               this.info.currentFrame++;
               this.playMovie();
               if(this.walkRandomAction())
               {
                  return;
               }
            }
         }
         else if(this.info)
         {
            if(this.info.currentFrame < this.info.totalFrame - 1)
            {
               this.info.currentFrame++;
               this.playMovie();
               return;
            }
            if(this.info.currentFrame == this.info.totalFrame - 1)
            {
               this.info.currentFrame++;
               this.playMovie();
            }
            this._info.pathInfo.reverse();
            this._info.pathInfo = this._info.pathInfo;
         }
      }
    walkRandomAction() {
         var _loc1_ = false;
         if(!this._special && this.specialPoint[this.x + "_" + this.y])
         {
            _loc1_ = $.int(Math.random() * 10) < 10;
            if(this.checkWalkDirection(this._info.pathInfo[this._info.nextIndex]))
            {
               this.special = _loc1_;
            }
            else
            {
               this.stand = _loc1_;
            }
            if(_loc1_)
            {
               return true;
            }
            this.checkDirection(this._info.pathInfo[this.info.nextIndex]);
         }
         return false;
      }
    checkWalkDirection(param1) {
         return $.int(this.y) < $.int(param1.y);
      }
    checkDirection(param1, param2 = 1) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if($.int(this.y) < $.int(param1.y))
         {
            this.movieClip = this._walkFontAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         else
         {
            this.movieClip = this._walkBackAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         this.addChildAt(this._standPos,0);
         return 0;
      }
    checkSpecialDirection(param1) {
         this.movieClip = this._specialFront;
         this.addChildAt(this._standPos,0);
         if(!param1)
         {
            return false;
         }
         if($.int(this.y) < $.int(param1.y))
         {
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
            return true;
         }
         if(this.x < param1.x)
         {
            this.scaleX = 1;
         }
         else
         {
            this.scaleX = -1;
         }
         return false;
      }
    checkStandDirection(param1) {
         this.movieClip = this._standFrontAsset;
         this.addChildAt(this._standPos,0);
         if(!param1)
         {
            return;
         }
         if($.int(this.y) < $.int(param1.y))
         {
            this.movieClip = this._standFrontAsset;
            this.addChildAt(this._standPos,0);
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         else
         {
            this.movieClip = this._standBackAsset;
            this.addChildAt(this._standPos,0);
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
      }
    dispose() {
         if(this._filter)
         {
            this._filter.setNormalFilter(this);
         }
         this._filter = null;
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._specialFront);
         this._specialFront = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._standPos);
         this._standPos = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dialogView);
         this._dialogView = null;
         this._dialogDic = null;
         super.dispose();
      }
    set checkRect(v) { super.checkRect = v; }
    get info() { return super.info; }
    get stand() { return super.stand; }
    get special() { return super.special; }
  }
  $.meta(__CastleNPCView, "castle.view.CastleNPCView", ["ICheck"]);
  return __CastleNPCView;
}
deps["castle.view.CastleNPCView"] = ["castle.view.CastleDialogView", "com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.MovieClip", "flash.geom.Point", "flash.geom.Rectangle", "flash.utils.Dictionary", "manager.LanguageMgr", "yishi.ai.AIPhysicsFourDirection", "yishi.filter.SimpleBuildingFilter"];

defs["castle.view.layer.CastleAirlayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CastleAirlayer extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__CastleAirlayer, "castle.view.layer.CastleAirlayer", ["Disposeable"]);
  return __CastleAirlayer;
}
deps["castle.view.layer.CastleAirlayer"] = ["com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["castle.view.layer.CastleAnimalLayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CastleAnimalLayer extends __Base {
    static $fields(self) {
    self._animal = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._animal = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("castle.BgAnimal");
         this._animal.mouseEnabled = this._animal.mouseChildren = false;
         this.addChild(this._animal);
      }
    initEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("STOP_EFFECT",$.bind(this, "__notificationHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("STOP_EFFECT",$.bind(this, "__notificationHandler"));
      }
    __notificationHandler(param1) {
         if(param1.data)
         {
            this.startEffet();
         }
         else
         {
            this.stopEffect();
         }
      }
    stopEffect() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < this._animal.numChildren)
         {
            _loc1_ = this._animal.getChildAt(_loc2_);
            if($.is(_loc1_, $.C("flash.display.MovieClip")))
            {
               _loc1_["stop"]();
            }
            _loc2_++;
         }
      }
    startEffet() {
         this._animal.gotoAndPlay(1);
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._animal);
         this._animal = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__CastleAnimalLayer, "castle.view.layer.CastleAnimalLayer", ["Disposeable", "IStopEffect"]);
  return __CastleAnimalLayer;
}
deps["castle.view.layer.CastleAnimalLayer"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "yishi.manager.NotificationManager"];

defs["castle.view.layer.CastleBackgroundLayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CastleBackgroundLayer extends __Base {
    static $fields(self) {
    self._back = null;
    self._blackGound = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         if(this._back)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
            if(this._back.parent)
            {
               this._back.parent.removeChild(this._back);
            }
            this._back = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blackGound);
            this._blackGound = null;
         }
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.InnerCityBg1");
         this._back.cacheAsBitmap = true;
         this._back.mouseChildren = this._back.mouseEnabled = false;
         this._blackGound = new ($.C("flash.display.Sprite"))();
         this._blackGound.graphics.beginFill(0,1);
         this._blackGound.graphics.drawRect(-this._back.width,-this._back.height,this._back.width * 3,this._back.height * 3);
         this._blackGound.graphics.endFill();
         this.addChild(this._blackGound);
         this.addChild(this._back);
      }
    get resWidth() {
         return this._back.width;
      }
    get resHeight() {
         return this._back.height;
      }
    initEvent() {
         this.thane.addEventListener("THANE_LEVEL_UPDATE",$.bind(this, "__upgradeHandler"));
      }
    removeEvent() {
         this.thane.removeEventListener("THANE_LEVEL_UPDATE",$.bind(this, "__upgradeHandler"));
      }
    __upgradeHandler(param1) {
         this.initView();
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blackGound);
         this._blackGound = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set resWidth(v) { super.resWidth = v; }
    set resHeight(v) { super.resHeight = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__CastleBackgroundLayer, "castle.view.layer.CastleBackgroundLayer", ["Disposeable"]);
  return __CastleBackgroundLayer;
}
deps["castle.view.layer.CastleBackgroundLayer"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.ArmyManager"];

defs["castle.view.layer.CastleNameLayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CastleNameLayer extends __Base {
    static $fields(self) {
    self._nameDic = null;
    }
    constructor() {
         super();
         this._nameDic = new ($.C("flash.utils.Dictionary"))();
      }
    addChildByIndex(param1, param2) {
         this.addChild(param1);
         this._nameDic[param1] = param2;
      }
    refreshChild(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc2_ = this.numChildren;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = $.as(this.getChildAt(_loc4_), $.C("flash.display.DisplayObject"));
            _loc3_.x = $.int(this._nameDic[_loc3_].x * param1);
            _loc3_.y = $.int(this._nameDic[_loc3_].y * param1);
            _loc4_++;
         }
      }
    dispose() {
         for (var _loc1_ of $.values(this._nameDic))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this._nameDic = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__CastleNameLayer, "castle.view.layer.CastleNameLayer", ["Disposeable"]);
  return __CastleNameLayer;
}
deps["castle.view.layer.CastleNameLayer"] = ["com.pickgliss.utils.ObjectUtils", "flash.display.DisplayObject", "flash.display.Sprite", "flash.utils.Dictionary"];

defs["castle.view.layer.CastleWalkLayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __CastleWalkLayer extends __Base {
    static $fields(self) {
    self._buildingsDic = null;
    self._viewList = null;
    self._buildingFilter = null;
    self._config = null;
    self._mediatorKey = null;
    self._nameLayer = null;
    self._hasSeminary = false;
    self._seminaryStrip = null;
    self._filter = null;
    self._hasOperEffects = null;
    self._levyHasOperEffect = null;
    self._labGainsHasOperEffect = null;
    self._labRobGainsHasOperEffect = null;
    self._mazeHasOperEffect = null;
    self._exploreHasOperEffect = null;
    self._homeGainsHasOperEffect = null;
    self._catHouseGainsHasOperEffect = null;
    self._seminaryGainsHasOperEffect = null;
    self._npcDic = null;
    self.count = 0;
    }
    constructor(param1) {
         super();
         this._filter = new ($.C("yishi.filter.UIFilter"))();
         this._nameLayer = param1;
         this.initAIConfig();
         this.initBuild();
         this.initWalker();
         this.initView();
         this.initEvent();
      }
    initAIConfig() {
         this._config = new ($.C("yishi.ai.AiPlayerConfig"))();
         this._viewList = [];
         this._npcDic = new ($.C("flash.utils.Dictionary"))(true);
         this._buildingsDic = new ($.C("flash.utils.Dictionary"))(true);
         this._buildingFilter = new ($.C("yishi.filter.SimpleBuildingFilter"))();
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
      }
    initBuild() {
         var _loc1_ = null;
         var _loc2_ = $.C("yishi.manager.BuildingManager").instance.model.buildingListByID;
         for (_loc1_ of $.values(_loc2_))
         {
            if(!(_loc1_.templeteInfo.MasterType == 13 || _loc1_.templeteInfo.MasterType == 14))
            {
               this.updateBuildingView(_loc1_);
            }
         }
         this.initClientBuild();
      }
    updateBuildingView(param1) {
         var _loc3_ = param1.templeteInfo;
         var _loc2_ = $.as(this._buildingsDic[param1.buildingId], $.C("castle.view.CastleBuildingView"));
         if(param1.sonType == 1511)
         {
            return;
         }
         if(_loc2_)
         {
            _loc2_.x = param1.templeteInfo.PosX;
            _loc2_.y = param1.templeteInfo.PosY;
            _loc2_.buildingLevelUpdated(this.parent.scaleX);
            _loc2_.buildingInfo = param1;
         }
         else
         {
            if(_loc3_.SonType == 501)
            {
               this._hasSeminary = true;
               $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._seminaryStrip);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._seminaryStrip);
               this._seminaryStrip = null;
            }
            _loc2_ = new ($.C("castle.view.CastleBuildingView"))(this._buildingFilter,this._nameLayer);
            _loc2_.buttonMode = true;
            _loc2_.x = param1.templeteInfo.PosX;
            _loc2_.y = param1.templeteInfo.PosY;
            _loc2_.buildingInfo = param1;
            this._viewList.push(_loc2_);
            this._buildingsDic[param1.buildingId] = _loc2_;
         }
      }
    updateClientBuild(param1) {
         var _loc2_ = new ($.C("castle.view.CastleBuildingView"))(this._buildingFilter,this._nameLayer);
         _loc2_.buttonMode = true;
         _loc2_.x = param1.templeteInfo.PosX;
         _loc2_.y = param1.templeteInfo.PosY;
         _loc2_.buildingInfo = param1;
         this._viewList.push(_loc2_);
         this._buildingsDic[param1.buildingId] = _loc2_;
      }
    initClientBuild() {
         this.createSeminary();
         this.createTransferBuild();
         this.createTree();
         this.createMazeBuild();
         this.createMagicHotel();
         this.createPerkinLab();
      }
    createSeminary() {
         var _loc4_ = null;
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         if(this._hasSeminary)
         {
            return;
         }
         if(!this._seminaryStrip)
         {
            this._seminaryStrip = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("castle.SeminaryStripView");
            _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.castle.SeminaryAsset");
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.NameBack2");
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("castle.BuildNameTxt2");
            _loc2_.text = $.C("manager.LanguageMgr").GetTranslation("HigherGradeOpenTipView.content10");
            _loc1_.width = _loc2_.textWidth + 12;
            this._buildingFilter.setGrayFilter(_loc4_);
            this._seminaryStrip.addChild(_loc4_);
            this._seminaryStrip.addChild(_loc1_);
            _loc1_.x = 52;
            _loc1_.y = 310;
            this._seminaryStrip.addChild(_loc2_);
            _loc2_.x = 57;
            _loc2_.y = 314;
            this.addChild(this._seminaryStrip);
            _loc3_ = new ($.C("yishi.view.tips.WaterTreeTipInfo"))();
            _loc3_.title = $.C("manager.LanguageMgr").GetTranslation("HigherGradeOpenTipView.content10");
            _loc3_.content = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",18);
            this._seminaryStrip.tipData = _loc3_;
         }
      }
    createTransferBuild() {
         var _loc1_ = null;
         if(!this._buildingsDic[-11])
         {
            _loc1_ = $.C("yishi.manager.BuildingManager").instance.model.buildingListByID[-11];
            if(_loc1_)
            {
               this.updateClientBuild(_loc1_);
            }
         }
         else
         {
            $.cast($.C("castle.view.CastleBuildingView"), this._buildingsDic[-11]).updateShowFilter();
         }
      }
    createMagicHotel() {
         var _loc1_ = null;
         if(!this._buildingsDic[-28])
         {
            _loc1_ = new ($.C("mvc.module.buildings.BuildInfo"))();
            _loc1_.buildingId = -28;
            _loc1_.templateId = 160101;
            $.C("yishi.manager.BuildingManager").instance.model.addBuildInfo(_loc1_);
            this.updateClientBuild(_loc1_);
         }
         else
         {
            $.cast($.C("castle.view.CastleBuildingView"), this._buildingsDic[-28]).updateShowFilter();
         }
      }
    createPerkinLab() {
         var _loc1_ = null;
         if(!this._buildingsDic[-29])
         {
            _loc1_ = new ($.C("mvc.module.buildings.BuildInfo"))();
            _loc1_.buildingId = -29;
            _loc1_.templateId = 170101;
            $.C("yishi.manager.BuildingManager").instance.model.addBuildInfo(_loc1_);
            this.updateClientBuild(_loc1_);
         }
         else
         {
            $.cast($.C("castle.view.CastleBuildingView"), this._buildingsDic[-29]).updateShowFilter();
         }
      }
    createTree() {
         var _loc1_ = null;
         if(!this._buildingsDic[-9])
         {
            _loc1_ = new ($.C("mvc.module.buildings.BuildInfo"))();
            _loc1_.buildingId = -9;
            _loc1_.templateId = 150901;
            $.C("yishi.manager.BuildingManager").instance.model.addBuildInfo(_loc1_);
            this.updateClientBuild(_loc1_);
         }
         else
         {
            $.cast($.C("castle.view.CastleBuildingView"), this._buildingsDic[-9]).updateShowFilter();
         }
      }
    createMazeBuild() {
         var _loc1_ = null;
         if(!this._buildingsDic[-7])
         {
            _loc1_ = new ($.C("mvc.module.buildings.BuildInfo"))();
            _loc1_.buildingId = -7;
            _loc1_.templateId = 150701;
            $.C("yishi.manager.BuildingManager").instance.model.addBuildInfo(_loc1_);
            this.updateClientBuild(_loc1_);
         }
         else
         {
            $.cast($.C("castle.view.CastleBuildingView"), this._buildingsDic[-7]).updateShowFilter();
         }
      }
    initWalker() {
         var _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/castle/npc/castleNpc.swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,3,8,$.bind(this, "__onComplete"));
      }
    __onComplete(param1, param2) {
         if(!this._buildingsDic)
         {
            return;
         }
         this.createNPCByType(4);
      }
    createCampaignNpc() {
         if($.C("yishi.manager.CampaignRankManager").instance.rankDic[1001])
         {
            this.createNPCByType(2);
         }
         if($.C("yishi.manager.CampaignRankManager").instance.rankDic[1005])
         {
            this.createNPCByType(3);
         }
         if($.C("yishi.manager.CampaignRankManager").instance.rankDic[1106])
         {
            this.createNPCByType(1);
         }
      }
    createBuildNpc() {
         var _loc1_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(1506);
         if(_loc1_)
         {
            this.createNPCByType(5);
         }
         _loc1_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(1504);
         if(_loc1_)
         {
            this.createNPCByType(6);
         }
         _loc1_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(1510);
         if(_loc1_)
         {
            this.createNPCByType(7);
         }
         _loc1_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(101);
         if(_loc1_)
         {
            this.createNPCByType(8);
         }
      }
    createNPCByType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._npcDic[param1])
         {
            return;
         }
         var _loc4_ = this.getMovieByDirectionAndType(1,param1);
         var _loc5_ = this.getMovieByDirectionAndType(2,param1);
         var _loc6_ = this.getMovieByDirectionAndType(3,param1);
         var _loc3_ = this.getMovieByDirectionAndType(4,param1);
         var _loc2_ = this.getMovieByDirectionAndType(5,param1);
         var _loc7_ = new ($.C("castle.view.CastleNPCView"))(_loc4_,_loc5_,_loc6_,_loc3_,_loc2_);
         var _loc8_ = new ($.C("yishi.datas.ai.AIBaseInfo"))();
         _loc8_.speed = 0.7;
         _loc8_.pathInfo = this._config.getPathByType(param1);
         _loc7_.info = _loc8_;
         _loc7_.type = param1;
         _loc7_.specialPoint = this._config.getSpecialByType(param1);
         _loc7_.x = _loc8_.pathInfo[0].x;
         _loc7_.y = _loc8_.pathInfo[0].y;
         this._npcDic[param1] = _loc7_;
         this._viewList.push(_loc7_);
      }
    getMovieByDirectionAndType(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(param2 == 4 || param2 == 8 || param2 == 7)
         {
            if(param1 == 1 || param1 == 2 || param1 == 4)
            {
               return null;
            }
         }
         return $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.castle.Npc_" + param1 + "_" + param2);
      }
    initView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < this._viewList.length)
         {
            _loc1_ = $.as(this._viewList[_loc2_], $.C("flash.display.DisplayObject"));
            this.addChild(_loc1_);
            _loc2_++;
         }
         this.initBubbles();
      }
    initEvent() {
         $.C("yishi.manager.CampaignRankManager").instance.rankDic.addEventListener("addDictionary",$.bind(this, "__campaignRankAddHandler"));
         this.thane.addEventListener("THANE_LEVEL_UPDATE",$.bind(this, "__levelUpdateHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.CampaignRankManager").instance.rankDic.removeEventListener("addDictionary",$.bind(this, "__campaignRankAddHandler"));
         this.thane.removeEventListener("THANE_LEVEL_UPDATE",$.bind(this, "__levelUpdateHandler"));
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
      }
    __levelUpdateHandler(param1) {
         this.initClientBuild();
         this.refreshBubbles();
      }
    __campaignRankAddHandler(param1) {
      }
    upgradeDepth(param1) {
         var _loc3_ = 0;
         var _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = $.as(param1[_loc3_]["obj"], $.C("flash.display.DisplayObject"));
            if(!_loc2_.parent || this.getChildIndex(_loc2_) != _loc3_)
            {
               this.addChild(_loc2_);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._hasOperEffects.length)
         {
            this.addChild(this._hasOperEffects[_loc3_]);
            _loc3_++;
         }
         this.refreshBubbles();
      }
    enterFrame() {
         var _loc1_ = [];
         for (var _loc2_ of $.values(this._viewList))
         {
            _loc1_.push({
               "obj":_loc2_,
               "x":_loc2_.checkRect.x,
               "y":_loc2_.checkRect.y
            });
            if($.is(_loc2_, $.C("castle.view.CastleNPCView")))
            {
               ($.as(_loc2_, $.C("castle.view.CastleNPCView"))).execute();
            }
         }
         _loc1_ = _loc1_.sort($.bind(this, "checkDepth"));
         this.upgradeDepth(_loc1_);
         _loc1_.splice(0,_loc1_.length);
         _loc1_ = null;
      }
    checkDepth(param1, param2) {
         var _loc3_ = $.int(param1.y);
         var _loc4_ = $.int(param2.y);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return -1;
      }
    initBubbles() {
         this._hasOperEffects = new $.Vector();
         this._levyHasOperEffect = this.getEffectMcByImage("castle.gold",453,135);
         this._labRobGainsHasOperEffect = this.getEffectMcByImage("castle.rob",122,283);
         this._labGainsHasOperEffect = this.getEffectMcByImage("castle.dye",222,283);
         this._mazeHasOperEffect = this.getEffectMcByImage("castle.maze",390,440);
         this._exploreHasOperEffect = this.getEffectMcByImage("castle.magicHotel",614,442);
         this._homeGainsHasOperEffect = this.getEffectMcByImage("castle.pick",1130,190);
         this._catHouseGainsHasOperEffect = this.getEffectMcByImage("castle.catHouse",1130,190);
         this._seminaryGainsHasOperEffect = this.getEffectMcByImage("castle.seminary",790,145);
      }
    getEffectMcByImage(param1, param2, param3) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("castle.HasOperEffect");
         _loc4_["box"].addChild($.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param1));
         _loc4_.visible = false;
         _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
         _loc4_.x = param2;
         _loc4_.y = param3;
         this._hasOperEffects.push(_loc4_);
         return _loc4_;
      }
    refreshBubbles() {
         this.checkBubbleVisable(this._levyHasOperEffect,this.canLevy());
         this.checkBubbleVisable(this._labGainsHasOperEffect,this.canLabGains());
         this.checkBubbleVisable(this._labRobGainsHasOperEffect,this.canLabRob());
         this.checkBubbleVisable(this._mazeHasOperEffect,this.canMaze());
         this.checkBubbleVisable(this._exploreHasOperEffect,this.canExplore());
         this.checkBubbleVisable(this._homeGainsHasOperEffect,this.canHomeGains());
         this.checkBubbleVisable(this._catHouseGainsHasOperEffect,this.canCatHouseGains());
         this.checkBubbleVisable(this._seminaryGainsHasOperEffect,this.canSeminary());
      }
    checkBubbleVisable(param1, param2) {
         if(!param1 || !this._filter)
         {
            return;
         }
         if(param2)
         {
            this._filter.setNormalFilter(param1);
            param1.play();
            param1.visible = true;
         }
         else
         {
            param1.gotoAndStop(1);
            param1.visible = false;
         }
      }
    canLevy() {
         var _loc1_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(901);
         if(_loc1_ && _loc1_.property2 - _loc1_.property1 > 0 && this.thane.grades >= 14)
         {
            return _loc1_.property2 - _loc1_.property1 > 0;
         }
         return false;
      }
    canLabGains() {
         return this.thane.vocationGrades > 0 && Boolean($.C("managers.PerkinLabManager").instance.checkHasPick);
      }
    canLabRob() {
         if(this.thane.vocationGrades <= 0)
         {
            return false;
         }
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("perkin_lab_rob_count");
         var _loc2_ = $.int(_loc1_.ConfigValue) - $.C("managers.PerkinLabManager").instance.model.robCount;
         return _loc2_ > 0;
      }
    get selfCarInfo() {
         return $.C("map.campaign.CampaignManager").instance.mineralModel.selfCarInfo;
      }
    canMaze() {
         var _loc2_ = 0;
         var _loc1_ = 0;
         var _loc5_ = this.currentPlayerModel.towerInfo1.freeEnterCount - this.currentPlayerModel.towerInfo1.enterCount;
         var _loc3_ = this.currentPlayerModel.towerInfo2.maxEnterCount - this.currentPlayerModel.towerInfo2.freeEnterCount;
         if(this.currentPlayerModel.towerInfo2.enterCount >= this.currentPlayerModel.towerInfo2.freeEnterCount)
         {
            _loc2_ = this.currentPlayerModel.towerInfo2.maxEnterCount - this.currentPlayerModel.towerInfo2.enterCount;
         }
         else
         {
            _loc2_ = this.currentPlayerModel.towerInfo2.maxEnterCount - this.currentPlayerModel.towerInfo2.freeEnterCount;
         }
         var _loc4_ = this.currentPlayerModel.towerInfo3.maxEnterCount - this.currentPlayerModel.towerInfo3.freeEnterCount;
         if(this.currentPlayerModel.towerInfo3.enterCount >= this.currentPlayerModel.towerInfo3.freeEnterCount)
         {
            _loc1_ = this.currentPlayerModel.towerInfo3.maxEnterCount - this.currentPlayerModel.towerInfo3.enterCount;
         }
         else
         {
            _loc1_ = this.currentPlayerModel.towerInfo3.maxEnterCount - this.currentPlayerModel.towerInfo3.freeEnterCount;
         }
         return _loc5_ > 0 && _loc5_ <= this.currentPlayerModel.towerInfo1.freeEnterCount || _loc2_ > 0 && _loc2_ <= _loc3_ && this.currentPlayerModel.towerInfo2.campaignId >= 0 || _loc1_ > 0 && _loc1_ <= _loc4_ && this.currentPlayerModel.playerInfo.vocationGrades > 0;
      }
    canSeminary() {
         var _loc2_ = null;
         var _loc4_ = null;
         var _loc5_ = $.C("yishi.manager.BuildingManager").instance.model.buildingListByID.getList();
         var _loc1_ = 0;
         for (_loc2_ of $.values(_loc5_))
         {
            if(_loc2_.templeteInfo.MasterType == 5)
            {
               _loc1_ = $.int(_loc2_.templeteInfo.BuildingGrade);
               break;
            }
         }
         if(_loc1_ == 0)
         {
            return false;
         }
         var _loc3_ = $.int($.C("yishi.manager.ResourceManager").instance.waterCrystal.count);
         if(__CastleWalkLayer.jobFilter[this.thane.job])
         {
            for (_loc2_ of $.values(_loc5_))
            {
               if(__CastleWalkLayer.jobFilter[this.thane.job].indexOf(_loc2_.templeteInfo.SonType) != -1)
               {
                  _loc4_ = _loc2_.templeteInfo.nextTemp;
                  if(_loc4_)
                  {
                     if(_loc3_ >= _loc4_.CrystalsConsume)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
    getNextGrade(param1) {
         if(param1.NextGradeTemplateId != 0)
         {
            return $.C("yishi.manager.TempleteManager").instance.buildTemplateCate.getTemplateByID($.int(param1.NextGradeTemplateId));
         }
         return null;
      }
    get currentPlayerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    canExplore() {
         if(this.thane.grades < 32)
         {
            return false;
         }
         return $.C("yishi.manager.MagicPubManager").instance.canChatCount() > 0;
      }
    canHomeGains() {
         return $.C("farm.FarmManager").instance.checkHasPick > 0;
      }
    canCatHouseGains() {
         return $.C("managers.CatHouseManager").instance.getCattoysHarvestCount() > 0;
      }
    dispose() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "__onComplete"));
         this.removeEvent();
         for(var _loc2_ in this._npcDic)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._npcDic[_loc2_]);
            this._npcDic[_loc2_] = null;
            delete this._npcDic[_loc2_];
         }
         $.C("utils.LogicUtils").disposeDisplayCollection(this._buildingsDic);
         this._buildingsDic = null;
         for (var _loc1_ of $.values(this._viewList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this._viewList.length = 0;
         var _loc3_ = $.C("yishi.manager.BuildingManager").instance.model.buildingListByID;
         for (var _loc4_ of $.values(_loc3_))
         {
            if(_loc4_.templeteInfo)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc4_.templeteInfo.view);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc4_.templeteInfo.effect);
               _loc4_.templeteInfo.view = null;
               _loc4_.templeteInfo.effect = null;
            }
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._seminaryStrip);
         this._seminaryStrip = null;
         this._nameLayer = null;
         this._viewList = null;
         this._npcDic = null;
         this._config = null;
         this._filter = null;
         if(this._buildingFilter)
         {
            this._buildingFilter.dispose();
         }
         this._buildingFilter = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._levyHasOperEffect);
         this._levyHasOperEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._labGainsHasOperEffect);
         this._labGainsHasOperEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._labRobGainsHasOperEffect);
         this._labRobGainsHasOperEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mazeHasOperEffect);
         this._mazeHasOperEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._exploreHasOperEffect);
         this._exploreHasOperEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._homeGainsHasOperEffect);
         this._homeGainsHasOperEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._catHouseGainsHasOperEffect);
         this._catHouseGainsHasOperEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._seminaryGainsHasOperEffect);
         this._seminaryGainsHasOperEffect = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this._hasOperEffects);
         this._hasOperEffects = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get buildingsDic() {
         return this._buildingsDic;
      }
    set selfCarInfo(v) { super.selfCarInfo = v; }
    set currentPlayerModel(v) { super.currentPlayerModel = v; }
    set thane(v) { super.thane = v; }
    set buildingsDic(v) { super.buildingsDic = v; }
  }
  $.meta(__CastleWalkLayer, "castle.view.layer.CastleWalkLayer", ["Disposeable", "IEnterFrame"]);
  $.statics(__CastleWalkLayer, () => {
    __CastleWalkLayer.jobFilter = {
         "1":[1441,2441],
         "2":[1441,2441],
         "3":[1442,2442],
         "4":[1441,2441],
         "5":[1441,2441],
         "6":[1442,2442]
      };
  });
  return __CastleWalkLayer;
}
deps["castle.view.layer.CastleWalkLayer"] = ["castle.view.CastleBuildingView", "castle.view.CastleNPCView", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "farm.FarmManager", "flash.display.DisplayObject", "flash.display.Sprite", "flash.utils.Dictionary", "manager.LanguageMgr", "managers.CatHouseManager", "managers.PerkinLabManager", "map.campaign.CampaignManager", "mvc.module.buildings.BuildInfo", "utils.LogicUtils", "yishi.ai.AiPlayerConfig", "yishi.datas.ai.AIBaseInfo", "yishi.filter.SimpleBuildingFilter", "yishi.filter.UIFilter", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.CampaignRankManager", "yishi.manager.EnterFrameManager", "yishi.manager.MagicPubManager", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.manager.ResourceManager", "yishi.manager.TempleteManager", "yishi.view.tips.WaterTreeTipInfo"];

defs["castle.view.layer.FogBorderLayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FogBorderLayer extends __Base {
    static $fields(self) {
    self._borderVBitmapData = null;
    self._borderHBitmapData = null;
    self._horizontalBorder1 = null;
    self._horizontalBorder2 = null;
    self._verticalBorder1 = null;
    self._verticalBorder2 = null;
    self._resWidth = 0;
    self._resHeight = 0;
    }
    constructor(param1, param2) {
         super();
         this._resWidth = param1;
         this._resHeight = param2;
         this.init();
      }
    init() {
         this._borderVBitmapData = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.castle.BorderMaskVAsset");
         this._borderHBitmapData = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.castle.BorderMaskHAsset");
         this._verticalBorder1 = new ($.C("flash.display.Bitmap"))(this._borderVBitmapData);
         this._verticalBorder2 = new ($.C("flash.display.Bitmap"))(this._borderVBitmapData);
         this._horizontalBorder1 = new ($.C("flash.display.Bitmap"))(this._borderHBitmapData);
         this._horizontalBorder2 = new ($.C("flash.display.Bitmap"))(this._borderHBitmapData);
         $.C("com.pickgliss.toplevel.StageReferance").addEventListener("resize",$.bind(this, "__stageResizeHandler"));
         this.__stageResizeHandler(null);
      }
    __stageResizeHandler(param1) {
         this._horizontalBorder1.width = this._resWidth;
         this._horizontalBorder2.width = this._resWidth;
         this._verticalBorder1.height = this._resHeight;
         this._verticalBorder2.height = this._resHeight;
         this._verticalBorder1.scaleX = -0.5;
         this._verticalBorder2.scaleX = 0.5;
         this._horizontalBorder1.scaleY = -0.5;
         this._horizontalBorder2.scaleY = 0.5;
         this.update();
      }
    update() {
         if(this._resHeight * this.scaleY < $.C("com.pickgliss.toplevel.StageReferance").stageHeight)
         {
            this._horizontalBorder1.y = 88;
            this._horizontalBorder2.y = this._resHeight - 88;
            this.addChild(this._horizontalBorder1);
            this.addChild(this._horizontalBorder2);
         }
         else
         {
            if(this._horizontalBorder1.parent)
            {
               this._horizontalBorder1.parent.removeChild(this._horizontalBorder1);
            }
            if(this._horizontalBorder2.parent)
            {
               this._horizontalBorder2.parent.removeChild(this._horizontalBorder2);
            }
         }
         if(this._resWidth * this.scaleX < $.C("com.pickgliss.toplevel.StageReferance").stageWidth)
         {
            this._verticalBorder1.x = 88;
            this._verticalBorder2.x = this._resWidth - 88;
            this.addChild(this._verticalBorder1);
            this.addChild(this._verticalBorder2);
         }
         else
         {
            if(this._verticalBorder1.parent)
            {
               this._verticalBorder1.parent.removeChild(this._verticalBorder1);
            }
            if(this._verticalBorder2.parent)
            {
               this._verticalBorder2.parent.removeChild(this._verticalBorder2);
            }
         }
      }
    dispose() {
         $.C("com.pickgliss.toplevel.StageReferance").removeEventListener("resize",$.bind(this, "__stageResizeHandler"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._borderVBitmapData);
         this._borderVBitmapData = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._borderHBitmapData);
         this._borderHBitmapData = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._verticalBorder1);
         this._verticalBorder1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._verticalBorder2);
         this._verticalBorder2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._horizontalBorder1);
         this._horizontalBorder1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._horizontalBorder2);
         this._horizontalBorder2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeSelf(this);
      }
  }
  $.meta(__FogBorderLayer, "castle.view.layer.FogBorderLayer", ["Disposeable"]);
  return __FogBorderLayer;
}
deps["castle.view.layer.FogBorderLayer"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.Sprite"];

defs["yishi.ai.AIPhysicsFourDirection"] = function define($) {
  const __Base = $.C("yishi.datas.ai.AIPhysicsBase");
  class __AIPhysicsFourDirection extends __Base {
    static $fields(self) {
    self._nameTxt = null;
    self._walkFontAsset = null;
    self._walkBackAsset = null;
    self._standFrontAsset = null;
    self._standBackAsset = null;
    }
    constructor(param1, param2, param3, param4) {
         super();
         this._walkFontAsset = param1;
         this._walkBackAsset = param2;
         this._standFrontAsset = param3;
         this._standBackAsset = param4;
         this.initView();
      }
    initView() {
         this._nameTxt = new ($.C("flash.text.TextField"))();
         this._nameTxt.textColor = 16776960;
         this._nameTxt.height = 18;
      }
    checkDirection(param1, param2 = 1) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = 20;
         if($.int(this.y) < $.int(param1.y))
         {
            this.movieClip = this._walkFontAsset || this._standFrontAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         else
         {
            this.movieClip = this._walkBackAsset || this._standBackAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         return 0;
      }
    playMovie() {
         if(!this._prePoint)
         {
            return;
         }
         if(this.info.currentFrame >= this.info.totalFrame)
         {
            return;
         }
         var _loc1_ = $.C("flash.geom.Point").interpolate(this._nextPoint,this._prePoint,this.info.currentFrame / this.info.totalFrame);
         this.x = _loc1_.x;
         this.y = _loc1_.y;
      }
    nextWalk(param1) {
         this.checkDirection(param1);
         this._prePoint = new ($.C("flash.geom.Point"))(this.x,this.y);
         this._nextPoint = new ($.C("flash.geom.Point"))(param1.x,param1.y);
         var _loc2_ = $.C("flash.geom.Point").distance(this._prePoint,this._nextPoint);
         this.info.currentFrame = 0;
         this.info.totalFrame = _loc2_ / this._info.speed;
      }
    dispose() {
         if(this._walkBackAsset)
         {
            if(this._walkBackAsset.parent)
            {
               this._walkBackAsset.parent.removeChild(this._walkBackAsset);
            }
            this._walkBackAsset.stop();
            this._walkBackAsset = null;
         }
         if(this._walkFontAsset)
         {
            if(this._walkFontAsset.parent)
            {
               this._walkFontAsset.parent.removeChild(this._walkFontAsset);
            }
            this._walkFontAsset.stop();
            this._walkFontAsset = null;
         }
         if(this._nameTxt.parent != null && this._nameTxt.parent.contains(this._nameTxt))
         {
            this._nameTxt.parent.removeChild(this._nameTxt);
         }
         super.dispose();
      }
  }
  $.meta(__AIPhysicsFourDirection, "yishi.ai.AIPhysicsFourDirection", []);
  return __AIPhysicsFourDirection;
}
deps["yishi.ai.AIPhysicsFourDirection"] = ["flash.geom.Point", "flash.text.TextField", "yishi.datas.ai.AIPhysicsBase"];

defs["yishi.ai.AiPlayerConfig"] = function define($) {
  const __Base = $.Object;
  class __AiPlayerConfig extends __Base {
    static $fields(self) {
    self._pathDic = null;
    self._specialDic = null;
    self._allPath = null;
    }
    constructor() {
         super();
         this._specialDic = new ($.C("flash.utils.Dictionary"))();
         this._specialDic[1] = new ($.C("flash.utils.Dictionary"))();
         this._specialDic[3] = new ($.C("flash.utils.Dictionary"))();
         this._specialDic[2] = new ($.C("flash.utils.Dictionary"))();
         this._specialDic[6] = new ($.C("flash.utils.Dictionary"))();
         this._specialDic[7] = new ($.C("flash.utils.Dictionary"))();
         this._specialDic[5] = new ($.C("flash.utils.Dictionary"))();
         this._pathDic = new ($.C("flash.utils.Dictionary"))();
         this._pathDic[1] = [new ($.C("flash.geom.Point"))(522,722),new ($.C("flash.geom.Point"))(606,672),new ($.C("flash.geom.Point"))(671,633),new ($.C("flash.geom.Point"))(704,614),new ($.C("flash.geom.Point"))(753,643),new ($.C("flash.geom.Point"))(780,650)];
         this._pathDic[2] = [new ($.C("flash.geom.Point"))(578,325),new ($.C("flash.geom.Point"))(630,355),new ($.C("flash.geom.Point"))(690,390),new ($.C("flash.geom.Point"))(744,425),new ($.C("flash.geom.Point"))(676,474),new ($.C("flash.geom.Point"))(747,520),new ($.C("flash.geom.Point"))(825,568),new ($.C("flash.geom.Point"))(918,622),new ($.C("flash.geom.Point"))(977,655)];
         this._pathDic[3] = [new ($.C("flash.geom.Point"))(357,400),new ($.C("flash.geom.Point"))(407,428),new ($.C("flash.geom.Point"))(437,455),new ($.C("flash.geom.Point"))(508,498),new ($.C("flash.geom.Point"))(567,533),new ($.C("flash.geom.Point"))(530,557),new ($.C("flash.geom.Point"))(490,582),new ($.C("flash.geom.Point"))(437,615),new ($.C("flash.geom.Point"))(384,646),new ($.C("flash.geom.Point"))(340,624),new ($.C("flash.geom.Point"))(283,590),new ($.C("flash.geom.Point"))(248,568)];
         this._pathDic[6] = [new ($.C("flash.geom.Point"))(1080,578),new ($.C("flash.geom.Point"))(972,649),new ($.C("flash.geom.Point"))(917,609),new ($.C("flash.geom.Point"))(1030,540),new ($.C("flash.geom.Point"))(971,505)];
         this._pathDic[5] = [new ($.C("flash.geom.Point"))(729,602),new ($.C("flash.geom.Point"))(804,551),new ($.C("flash.geom.Point"))(780,533),new ($.C("flash.geom.Point"))(925,450)];
         this._pathDic[7] = [new ($.C("flash.geom.Point"))(620,407)];
         this._pathDic[4] = [new ($.C("flash.geom.Point"))(1136,770)];
         this._pathDic[8] = [new ($.C("flash.geom.Point"))(379,1002)];
         this._specialDic[5]["729_602"] = true;
         this._specialDic[5]["780_533"] = true;
         this._specialDic[5]["925_450"] = true;
         this._specialDic[6]["1030_540"] = true;
         this._specialDic[6]["971_505"] = true;
         this._specialDic[6]["974_573"] = true;
         this._specialDic[6]["1011_624"] = true;
         this._specialDic[6]["1080_578"] = true;
         this._specialDic[1]["606_672"] = true;
         this._specialDic[1]["671_633"] = true;
         this._specialDic[1]["753_643"] = true;
         this._specialDic[2]["630_355"] = true;
         this._specialDic[2]["690_390"] = true;
         this._specialDic[2]["825_568"] = true;
         this._specialDic[2]["918_622"] = true;
         this._specialDic[3]["508_498"] = true;
         this._specialDic[3]["530_557"] = true;
         this._specialDic[3]["490_582"] = true;
         this._specialDic[3]["437_615"] = true;
         this._specialDic[3]["340_624"] = true;
         this._specialDic[3]["283_590"] = true;
      }
    getPathByType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.as(this._pathDic[param1], "Array");
      }
    getSpecialByType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.as(this._specialDic[param1], $.C("flash.utils.Dictionary"));
      }
  }
  $.meta(__AiPlayerConfig, "yishi.ai.AiPlayerConfig", []);
  $.statics(__AiPlayerConfig, () => {
    __AiPlayerConfig.FLOWER_WOMEN = 1;
    __AiPlayerConfig.FLAMAN = 2;
    __AiPlayerConfig.WARRIOR_WOMEN = 3;
    __AiPlayerConfig.SOLDIER = 4;
    __AiPlayerConfig.BUSSINESSMAN = 5;
    __AiPlayerConfig.BINLUO = 6;
    __AiPlayerConfig.SOLDIER_LEADER = 7;
    __AiPlayerConfig.DRUDGERY = 8;
  });
  return __AiPlayerConfig;
}
deps["yishi.ai.AiPlayerConfig"] = ["flash.geom.Point", "flash.utils.Dictionary"];

defs["yishi.interfaces.ICheck"] = function define($) {
  return $.interface("yishi.interfaces.ICheck", []);
}

defs["yishi.interfaces.IStopEffect"] = function define($) {
  return $.interface("yishi.interfaces.IStopEffect", []);
}
