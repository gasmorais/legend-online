// @ts-nocheck
export const defs = {};
export const deps = {};
defs["battle.BattleSceneView"] = function define($) {
  const __Base = $.C("yishi.scene.BaseSceneView");
  class __BattleSceneView extends __Base {
    static $fields(self) {
    self._backGround = null;
    self._view = null;
    self._model = null;
    self._enterFrameManager = null;
    self._unusualCount = 0;
    self.tfTimer = 0;
    }
    constructor() {
         super();
         this._enterFrameManager = $.C("yishi.manager.EnterFrameManager").instance;
      }
    preLoadingStart(param1 = null) {
         super.preLoadingStart(param1);
      }
    enter(param1, param2 = null) {
         var preScene = param1;
         var data = param2;
         var validView = () =>
         {
            $.C("flash.utils.clearTimeout")(timeId);
            timeId = 0;
            this.mouseChildren = this.mouseEnabled = true;
         };
         this.mouseChildren = this.mouseEnabled = false;
         var timeId = $.int($.C("flash.utils.setTimeout")(validView,1000));
         $.C("com.pickgliss.ui.ShowTipManager").Instance.removeAllTip();
         $.C("com.pickgliss.ui.LayerManager").Instance.clearnStageDynamic();
         $.C("com.pickgliss.ui.LayerManager").Instance.clearGameMenuLayer();
         $.C("yishi.manager.IMEManager").disable();
         $.C("battle.skillsys.helper.BloodHelper").setup();
         $.C("battle.BattleManager").getInstance().initBattle(this);
         this._model = $.C("battle.BattleManager").getInstance().battleModel;
         this._backGround = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.BattleBackGround");
         this.addChild(this._backGround);
         this._view = new ($.C("battle.view.BattleView"))(this._model);
         this._view.init();
         this.addChild(this._view);
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
         this.addEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
         $.C("mainBar.ChatBar").inBattleFlag = true;
         $.C("ui.tasktracebar.TaskTraceBar").instance.hide();
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("battle.events.BattleEvent"))("enterbattlescene",null));
         this._view.addEventListener("click",$.bind(this, "onBattleViewClick"));
      }
    onBattleViewClick(param1) {
         if(!($.is(param1.target, $.C("flash.text.TextField"))) || $.cast($.C("flash.text.TextField"), param1.target).type != "input")
         {
            $.C("yishi.manager.IMEManager").disable();
         }
      }
    enterOver() {
         super.enterOver();
         this.addBattleVectoryAndFailedRes();
         if($.C("mainBar.ChatBar").inBattleFlag)
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = $.C("com.pickgliss.toplevel.StageReferance").stage;
         }
      }
    addBattleVectoryAndFailedRes() {
         var _loc1_ = $.C("com.pickgliss.ui.ComponentSetting").getUISourcePath("battle2");
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,3,7,null);
         if(this._model.battleType == 293)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentSetting").getUISourcePath("clearance");
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,3,7,null);
         }
      }
    __addToStageHandler(param1) {
         this.layout();
         this.stage.addEventListener("resize",$.bind(this, "__sesizeHandler"));
      }
    __sesizeHandler(param1) {
         this.layout();
      }
    layout() {
         if(this.stage.stageWidth < 1500)
         {
            this._view.x = 0;
         }
         else
         {
            this._view.x = this.stage.stageWidth / 2 - 750;
         }
         if(this.stage.stageHeight < 900)
         {
            this._view.y = 0;
         }
         else
         {
            this._view.y = this.stage.stageHeight / 2 - 450;
         }
         this._backGround.x = this._view.x + (this._view.sceneWidth >> 1);
         this._backGround.y = this._view.y + (this._view.sceneHeight >> 1);
      }
    leaving() {
         $.C("battle.BattleManager").loginToBattleFlag = false;
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
         this.removeEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
         if(this.stage)
         {
            this.stage.removeEventListener("resize",$.bind(this, "__sesizeHandler"));
         }
         $.C("battle.transaction.BattleTransactionManager").getInstance().dispose();
         $.C("battle.BattleManager").getInstance().started = false;
         $.C("mainBar.ChatBar").inBattleFlag = false;
         if(this._view)
         {
            this._view.removeEventListener("click",$.bind(this, "onBattleViewClick"));
         }
         $.C("battle.skillsys.loader.SkillResourceLoader").clearSkillLoader();
         $.C("battle.skillsys.ripple.RipplePreCreater").clear();
         $.C("com.pickgliss.ui.LayerManager").Instance.clearGameMenuLayer();
         if(this._view)
         {
            this._view.dispose();
         }
         $.C("yishi.view.shadow.ShadowEffectMaker").stopAll();
         $.C("battle.BattleManager").getInstance().disposeBattle();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._backGround);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._view);
         this._view = null;
         this._model = null;
         this._backGround = null;
      }
    get SceneName() {
         return "BATTLE_SCENE";
      }
    enterFrame() {
         this._view.update();
      }
    get view() {
         return this._view;
      }
    set SceneName(v) { super.SceneName = v; }
    set view(v) { super.view = v; }
  }
  $.meta(__BattleSceneView, "battle.BattleSceneView", ["IEnterFrame"]);
  return __BattleSceneView;
}
deps["battle.BattleSceneView"] = ["battle.BattleManager", "battle.events.BattleEvent", "battle.skillsys.helper.BloodHelper", "battle.skillsys.loader.SkillResourceLoader", "battle.skillsys.ripple.RipplePreCreater", "battle.transaction.BattleTransactionManager", "battle.view.BattleView", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.utils.ObjectUtils", "flash.text.TextField", "flash.utils.clearTimeout", "flash.utils.setTimeout", "mainBar.ChatBar", "ui.tasktracebar.TaskTraceBar", "yishi.manager.EnterFrameManager", "yishi.manager.IMEManager", "yishi.manager.NotificationManager", "yishi.scene.BaseSceneView", "yishi.view.shadow.ShadowEffectMaker"];

defs["battle.animation.AnimationBase"] = function define($) {
  const __Base = $.Object;
  class __AnimationBase extends __Base {
    static $fields(self) {
    self._isFinished = false;
    }
    constructor() {
         super();
      }
    get level() {
         return 0;
      }
    prepare(param1) {
      }
    replace(param1) {
         return false;
      }
    cannel() {
      }
    update(param1) {
      }
    isFinished() {
         return this._isFinished;
      }
    set level(v) { super.level = v; }
  }
  $.meta(__AnimationBase, "battle.animation.AnimationBase", ["IAnimation"]);
  return __AnimationBase;
}
deps["battle.animation.AnimationBase"] = [];

defs["battle.animation.AnimationManager"] = function define($) {
  const __Base = $.Object;
  class __AnimationManager extends __Base {
    static $fields(self) {
    self._current = null;
    self._movie = null;
    self._stageWidth = 0;
    self._stageHeight = 0;
    self._animations = null;
    }
    constructor(param1, param2, param3) {
         super();
         this._stageWidth = param2;
         this._stageHeight = param3;
         this._movie = param1;
         this._animations = new $.Vector();
      }
    get stageHeight() {
         return this._stageHeight;
      }
    get stageWidth() {
         return this._stageWidth;
      }
    getAnimateTarget() {
         return this._movie;
      }
    addAnimation(param1) {
         param1.prepare(this);
         for (var _loc2_ of $.values(this._animations))
         {
            if(_loc2_.level <= param1.level)
            {
               _loc2_.cannel();
            }
         }
         this._animations.push(param1);
      }
    update() {
         for (var _loc1_ of $.values(this._animations))
         {
            if(!_loc1_.isFinished())
            {
               _loc1_.update(this._movie);
            }
            else if(this._animations.indexOf(_loc1_) >= 0)
            {
               this._animations.splice(this._animations.indexOf(_loc1_),1);
            }
         }
      }
    set stageHeight(v) { super.stageHeight = v; }
    set stageWidth(v) { super.stageWidth = v; }
  }
  $.meta(__AnimationManager, "battle.animation.AnimationManager", ["ISetAnimation"]);
  return __AnimationManager;
}
deps["battle.animation.AnimationManager"] = [];

defs["battle.animation.IAnimation"] = function define($) {
  return $.interface("battle.animation.IAnimation", []);
}

defs["battle.animation.ISetAnimation"] = function define($) {
  return $.interface("battle.animation.ISetAnimation", []);
}

defs["battle.animation.SetAnimaion"] = function define($) {
  const __Base = $.Object;
  class __SetAnimaion extends __Base {
    static $fields(self) {
    self._current = null;
    self._movie = null;
    self._stageWidth = 0;
    self._stageHeight = 0;
    }
    constructor(param1, param2, param3) {
         super();
         this._stageWidth = param2;
         this._stageHeight = param3;
         this._movie = param1;
      }
    get stageHeight() {
         return this._stageHeight;
      }
    get stageWidth() {
         return this._stageWidth;
      }
    getAnimateTarget() {
         return this._movie;
      }
    addAnimation(param1) {
         if(this._current)
         {
            if(param1.replace(this._current))
            {
               return;
            }
            if(this._current.level <= param1.level)
            {
               this._current.cannel();
               this._current = param1;
               this._current.prepare(this);
            }
         }
         else
         {
            this._current = param1;
            this._current.prepare(this);
         }
      }
    update() {
         if(this._current)
         {
            if(!this._current.isFinished())
            {
               this._current.update(this._movie);
            }
            else
            {
               this._current = null;
            }
         }
      }
    set stageHeight(v) { super.stageHeight = v; }
    set stageWidth(v) { super.stageWidth = v; }
  }
  $.meta(__SetAnimaion, "battle.animation.SetAnimaion", ["ISetAnimation"]);
  return __SetAnimaion;
}
deps["battle.animation.SetAnimaion"] = [];

defs["battle.factorys.ChargeSkillEffectFactory"] = function define($) {
  const __Base = $.Object;
  class __ChargeSkillEffectFactory extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static createEffect(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = "slg.resource.effect.ChargeEffect1";
               break;
            case 1:
               _loc3_ = "slg.resource.effect.ChargeEffect1";
               break;
            case 2:
               _loc3_ = "slg.resource.effect.ChargeEffect3";
               break;
            default:
               return null;
         }
         var _loc2_ = $.as($.C("battle.BattleManager").getInstance().resourceModel.getOrCreateInstanse(_loc3_), $.C("flash.display.MovieClip"));
         _loc2_.x = 160;
         return new ($.C("battle.skillsys.effect.MovieClipEffect"))(_loc2_);
      }
    static createHitEffect(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         switch(param1 - 1)
         {
            case 0:
               return null;
            case 1:
               return null;
            case 2:
               _loc3_ = "slg.resource.effect.ChargeEffect3_SJ";
               var _loc2_ = new ($.C("battle.skillsys.effect.SkillEffect"))(_loc3_);
               var _loc4_ = $.C("battle.utils.BattleUtils").getRightTeamCenterPoint();
               _loc2_.getDisplayObject().x = _loc4_.x;
               _loc2_.getDisplayObject().y = _loc4_.y;
               return _loc2_;
            default:
               return null;
         }
      }
  }
  $.meta(__ChargeSkillEffectFactory, "battle.factorys.ChargeSkillEffectFactory", []);
  return __ChargeSkillEffectFactory;
}
deps["battle.factorys.ChargeSkillEffectFactory"] = ["battle.BattleManager", "battle.skillsys.effect.MovieClipEffect", "battle.skillsys.effect.SkillEffect", "battle.utils.BattleUtils", "flash.display.MovieClip"];

defs["battle.net.BattleSocketOuterManager"] = function define($) {
  const __Base = $.Object;
  class __BattleSocketOuterManager extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static sendQTE(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = new ($.C("yishi.comm.PackageOut"))(10015);
         var _loc2_ = new ($.C("com.road.yishi.proto.battle.QteMsg"))();
         _loc2_.serverName = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.serviceName;
         _loc2_.battleId = param1;
         __BattleSocketOuterManager.sendProtoBuffer(_loc3_,_loc2_);
      }
    static sendProtoBuffer(param1, param2) {
         $.C("yishi.service.managers.SocketManager").instance.socket.sendProtobuffer(param1,param2);
      }
    static sendFightMode(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = new ($.C("yishi.comm.PackageOut"))(10016);
         var _loc3_ = new ($.C("com.road.yishi.proto.battle.AttackModeMsg"))();
         _loc3_.serverName = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.serviceName;
         _loc3_.battleId = param1;
         _loc3_.mode = param2;
         __BattleSocketOuterManager.sendProtoBuffer(_loc4_,_loc3_);
      }
    static sendEndBattle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = new ($.C("yishi.comm.PackageOut"))(8727);
         var _loc2_ = new ($.C("com.road.yishi.proto.battle.BattleReqMsg"))();
         _loc2_.battleId = param1;
         __BattleSocketOuterManager.sendProtoBuffer(_loc3_,_loc2_);
      }
  }
  $.meta(__BattleSocketOuterManager, "battle.net.BattleSocketOuterManager", []);
  return __BattleSocketOuterManager;
}
deps["battle.net.BattleSocketOuterManager"] = ["com.road.yishi.proto.battle.AttackModeMsg", "com.road.yishi.proto.battle.BattleReqMsg", "com.road.yishi.proto.battle.QteMsg", "yishi.comm.PackageOut", "yishi.manager.PlayerManager", "yishi.service.managers.SocketManager"];

defs["battle.qte.QteTimeView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __QteTimeView extends __Base {
    static $fields(self) {
    self._timeCircle = null;
    self.$$_mask = null;
    self.currentAngle = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._timeCircle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("qte.QTETime");
         this.$$_mask = new ($.C("flash.display.Sprite"))();
         this.$$_mask.rotation = -90;
         this.addChild(this._timeCircle);
         this.addChild(this.$$_mask);
         this.$$_mask.scaleY = -1;
         this.$$_mask.x = 29;
         this.$$_mask.y = 29;
         this._timeCircle["time_mask"].mask = this.$$_mask;
      }
    set time(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         $.C("com.greensock.TweenLite").to(this,param1,{
            "currentAngle":360,
            "onUpdate":$.bind(this, "updateMask")
         });
      }
    updateMask() {
         $.C("yishi.utils.GraphicsUtils").changeSectorAngle(this.$$_mask,0,0,20,0,this.currentAngle);
      }
    uninit() {
         this._timeCircle.stop();
         this._timeCircle = null;
         $.C("com.greensock.TweenLite").killTweensOf(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    addEvent() {
      }
    removeEvent() {
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get time() { return super.time; }
  }
  $.meta(__QteTimeView, "battle.qte.QteTimeView", ["Disposeable"]);
  return __QteTimeView;
}
deps["battle.qte.QteTimeView"] = ["com.greensock.TweenLite", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.utils.GraphicsUtils"];

defs["battle.qte.QteView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __QteView extends __Base {
    static $fields(self) {
    self._timer = null;
    self._timeView = null;
    self._time = 0;
    self._arr = null;
    self._isRight = false;
    self._skillUseView = null;
    self._timeId = 0;
    self._timeId2 = 0;
    self._qteNum = 0;
    self._qteCom = null;
    }
    constructor(param1) {
         super();
         this._arr = param1;
         this.time = $.int(param1[1]);
         this._qteNum = this._time / 1500;
         this.initView();
      }
    get time() {
         return this._time;
      }
    set time(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._time = param1;
         this.start();
         if(this._timeId2 > 0)
         {
            $.C("flash.utils.clearInterval")(this._timeId2);
         }
         this._timeId2 = 0;
         this._timeId2 = $.C("flash.utils.setTimeout")($.bind(this, "showTimeView"),800);
      }
    showTimeView() {
         this._timeView.visible = true;
         this._timeView.time = (this._time - 800 - 300 - 100) / 1000;
      }
    start() {
         this._timer = new ($.C("flash.utils.Timer"))(this.time - 300 - 100);
         this._timer.addEventListener("timer",$.bind(this, "__time"));
         this._timer.start();
      }
    initView() {
         this._qteCom = new ($.C("simplegame.qte.QTEComponent"))(this._qteNum,$.bind(this, "qteComplete"));
         this._timeView = new ($.C("battle.qte.QteTimeView"))();
         this._timeView.y = -52;
         this._timeView.visible = false;
         this.addChild(this._timeView);
         this.mouseChildren = this.mouseEnabled = false;
         if(this._arr && this._arr.length > 0 && this._arr[0])
         {
            this._skillUseView = new ($.C("battle.view.ui.SkillUseItemCell"))();
            if(this._arr)
            {
               this._skillUseView.data = $.C("yishi.utils.IconFactory").getTecIconByIcon(this._arr[0].Icons);
            }
            this.addChild(this._skillUseView);
            this._skillUseView.flash();
         }
         this.addChild(this._qteCom);
         this._timeView.x = this._qteCom.getCenterPosX() - 30;
      }
    qteComplete() {
         this._isRight = true;
         this.setEffect(true);
      }
    removeEvent() {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__time"));
         }
      }
    setEffect(param1) {
         this._qteCom.setEffect(param1);
         if(this._skillUseView)
         {
            this._skillUseView.tweenEffect(param1);
         }
         if(this._timeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._timeId);
         }
         this._timeId = 0;
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "sent"),400);
      }
    sent() {
         this.removeEvent();
         if(this._isRight)
         {
            this.setUseSkillState();
            $.C("battle.net.BattleSocketOuterManager").sendQTE($.C("battle.BattleManager").getInstance().battleModel.battleId);
         }
         this.dispose();
      }
    setUseSkillState() {
         var _loc2_ = null;
         var _loc1_ = NaN;
         var _loc3_ = null;
         var _loc4_ = null;
         if(this._qteCom)
         {
            _loc2_ = $.cast($.C("battle.view.roles.RoleViewBase"), $.C("battle.BattleManager").getInstance().battleMap.rolesDict[$.C("battle.BattleManager").getInstance().battleModel.selfHero.livingId]);
            _loc1_ = Number(this._qteCom.width);
            _loc3_ = this.parent.localToGlobal(new ($.C("flash.geom.Point"))(this.x + _loc1_ * 0.5,this.y));
            _loc4_ = _loc2_.effectContainer.localToGlobal(new ($.C("flash.geom.Point"))(0,-65));
            _loc2_.showQteSuccessEffect(_loc3_,_loc4_);
         }
      }
    get width() {
         if(this._qteCom)
         {
            return this._qteCom.width;
         }
         return super.width;
      }
    dispose() {
         this.removeEvent();
         if(this._timeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._timeId);
         }
         this._timeId = 0;
         if(this._timeId2 > 0)
         {
            $.C("flash.utils.clearInterval")(this._timeId2);
         }
         this._timeId2 = 0;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillUseView);
         this._skillUseView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._qteCom);
         this._qteCom = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeView);
         this._timeView = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this._arr = null;
         this._timer = null;
      }
    __time(param1) {
         this.setEffect(false);
      }
    set width(v) { super.width = v; }
  }
  $.meta(__QteView, "battle.qte.QteView", ["Disposeable"]);
  $.statics(__QteView, () => {
    __QteView.QTE_NUM = 3;
    __QteView.QTE_EFFECT_BEGIN_TIME = 800;
    __QteView.QTE_EFFECT_END_TIME = 300;
  });
  return __QteView;
}
deps["battle.qte.QteView"] = ["battle.BattleManager", "battle.net.BattleSocketOuterManager", "battle.qte.QteTimeView", "battle.view.roles.RoleViewBase", "battle.view.ui.SkillUseItemCell", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Point", "flash.utils.Timer", "flash.utils.clearInterval", "flash.utils.setTimeout", "simplegame.qte.QTEComponent", "yishi.utils.IconFactory"];

defs["battle.view.BattleView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BattleView extends __Base {
    static $fields(self) {
    self._model = null;
    self._sceneWidth = $.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageWidth,1000,1500);
    self._sceneHeight = $.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageHeight,600,900);
    self._battleUI = null;
    self._chatPop = null;
    self._map = null;
    self._profoundLayer = null;
    self._bitmap_background = null;
    self._redScreenEffect = null;
    self._goddessMovieView = null;
    }
    constructor(param1) {
         $.pre(new.target, (__s) => {
         __s._model = param1;
         });
         super();
         $.preFlush(this, new.target);
      }
    init() {
         $.C("battle.BattleManager").getInstance().battleScene = this;
         this._bitmap_background = new ($.C("flash.display.Bitmap"))();
         this.addChild(this._bitmap_background);
         this._map = new ($.C("battle.view.map.BattleMapView"))(this._model);
         this.buildMap();
         this.addChild(this._map);
         this._profoundLayer = new ($.C("flash.display.Sprite"))();
         this._profoundLayer.mouseChildren = this._profoundLayer.mouseEnabled = false;
         this.addChild(this._profoundLayer);
         this._battleUI = new ($.C("battle.view.ui.BattleUIView"))();
         this.addChild(this._battleUI);
         $.C("battle.BattleManager").getInstance().battleUIView = this._battleUI;
         this._map.cameraY = __BattleView.CAMERA_Y;
         this._map.cameraX = 650;
         $.C("battle.BattleManager").getInstance().battleMap = this._map;
         this._redScreenEffect = new ($.C("battle.view.ui.RedScreenEffect"))();
         this.addChild(this._redScreenEffect);
         this.initRole();
         this.addEvent();
         $.C("com.pickgliss.ui.LayerManager").Instance.getLayerByType(4).visible = false;
         this.__onResize(null);
         $.C("battle.chat.BattleChatController").getInstance().start();
      }
    __onResize(param1) {
         this._sceneWidth = $.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageWidth,1000,1500);
         this._sceneHeight = $.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageHeight,600,900);
         this.scrollRect = new ($.C("flash.geom.Rectangle"))(0,0,this._sceneWidth,this._sceneHeight);
         this._map.sceneWidth = this._sceneWidth;
         this._map.sceneHeight = this._sceneHeight;
         __BattleView.CAMERA_Y = 900 - this._sceneHeight * 0.5;
         this._map.cameraY = __BattleView.CAMERA_Y;
         if(this._chatPop)
         {
            this._chatPop.x = 0;
            this._chatPop.y = this._sceneHeight - this._chatPop.displayHeight;
         }
         if(this._redScreenEffect)
         {
            this._redScreenEffect.resize(this._sceneWidth,this._sceneHeight);
         }
      }
    update() {
         if(this._map)
         {
            this._map.update();
         }
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("BattleModelNotic.ADD_ROLE",$.bind(this, "__modelAddRole"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("REFRESH_BACK_BITMAP",$.bind(this, "__refreshBackGroundBitmap"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("shakeMapComplete",$.bind(this, "onShakeMapComplete"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("UPDATE_CHAT_VIEW",$.bind(this, "__playerChatHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__onResize"),false,1);
         $.C("yishi.manager.NotificationManager").instance.addEventListener("GODDESS_GUARD_SKILL",$.bind(this, "__goddessSkillHandler"));
      }
    onShakeMapComplete(param1) {
         if(this._map.cameraY != __BattleView.CAMERA_Y)
         {
            this.__onResize(null);
         }
      }
    __playerChatHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = $.as(param1.data, $.C("chat.datas.ChatData"));
         if(_loc3_.channel != 6)
         {
            return;
         }
         var _loc5_ = $.int(_loc3_.uid);
         var _loc4_ = $.C("battle.BattleManager").getInstance().battleModel.getHeroRoleByUserId(_loc5_);
         if(_loc4_ && _loc4_.side == $.C("battle.BattleManager").getInstance().battleModel.selfHero.side)
         {
            _loc2_ = {};
            _loc2_["id"] = _loc4_.heroInfo.headId;
            _loc2_["data"] = _loc3_;
            if(this._chatPop)
            {
               this._chatPop.dispose();
               this._chatPop = null;
            }
            if(!this._chatPop && this.needShowChatPop)
            {
               this._chatPop = new ($.C("battle.chat.BattleChatPopView"))($.bind(this, "__chatBackCall"));
               this._chatPop.data = _loc2_;
               this._chatPop.x = 0;
               this._chatPop.y = this._sceneHeight - this._chatPop.displayHeight - 130;
               this.addChild(this._chatPop);
            }
         }
      }
    get needShowChatPop() {
         if($.C("map.campaign.CampaignManager").instance.mapModel)
         {
            return $.C("yishi.utils.WorldBossHelper").checkNeedShowChatPop($.C("map.campaign.CampaignManager").instance.mapModel.mapId);
         }
         return true;
      }
    __chatBackCall() {
         this._chatPop = null;
      }
    __modelAddRole(param1) {
         var _loc2_ = $.cast($.C("yishi.datas.objects.RoleInfo"), param1.data.oldInfo);
         if(_loc2_)
         {
            this._map.removeRole(_loc2_.livingId);
         }
         var _loc3_ = $.cast($.C("yishi.datas.objects.RoleInfo"), param1.data.newInfo);
         if(_loc3_)
         {
            this.addRole(_loc3_);
         }
      }
    buildMap() {
         var _loc1_ = 0;
         var _loc2_ = $.int($.C("battle.BattleManager").getInstance().battleModel.mapId);
         _loc1_ = $.int($.C("yishi.manager.TempleteManager").instance.mapTemplateCate.getTemplateByID(_loc2_).BattleGround);
         var _loc3_ = new ($.C("battle.data.BattleMapData"))();
         this._map.changeMap(_loc3_);
      }
    initRole() {
         var _loc1_ = null;
         _loc1_ = this._model.armyInfoLeft.getHeros;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoLeft.getPawns;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoLeft.getPets;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoLeft.getGoddess;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoLeft.getMonster;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoRight.getHeros;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoRight.getPawns;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoRight.getPets;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoRight.getGoddess;
         this.initRoles(_loc1_);
         _loc1_ = this._model.armyInfoRight.getMonster;
         this.initRoles(_loc1_);
      }
    initRoles(param1) {
         var _loc2_ = null;
         for (var _loc3_ of $.values(param1))
         {
            _loc2_ = $.C("battle.utils.BattleUtils").rolePointByPos(_loc3_.pos,_loc3_.face);
            _loc3_.initPos(_loc2_);
            this.addRole(_loc3_);
         }
      }
    addRole(param1) {
         var _loc2_ = null;
         if(param1.needShow)
         {
            return;
         }
         if($.C("battle.BattleManager").getInstance().battleModel.battleType == 295 || $.C("battle.BattleManager").getInstance().battleModel.battleType == 3898)
         {
            if(param1.bloodA <= 0)
            {
               return;
            }
         }
         _loc2_ = param1.view;
         param1.defaultAction = "Stand";
         this.addRoleView(_loc2_);
         if($.is(param1, $.C("yishi.datas.objects.HeroRoleInfo")) && ($.as(param1, $.C("yishi.datas.objects.HeroRoleInfo"))).type != 3 && this.checkBattleType())
         {
            this.addTeamStrip($.as(param1, $.C("yishi.datas.objects.HeroRoleInfo")));
         }
         if($.is(_loc2_, $.C("battle.view.roles.PawnRoleView")) && !param1.isLiving)
         {
            param1.isLiving = false;
         }
      }
    addTeamStrip(param1) {
         if(param1 == null || this._battleUI == null)
         {
            return;
         }
         this._battleUI.addTeamStrip(param1);
      }
    checkBattleType() {
         if(!this._model)
         {
            return false;
         }
         switch(this._model.battleType)
         {
            case 16:
            case 19:
            case 32:
            case 35:
            case 36:
            case 38:
            case 306:
            case 307:
               break;
            default:
               return true;
         }
         return false;
      }
    addRoleView(param1) {
         param1.info.map = this._map;
         this._map.addRole(param1);
      }
    playRedScreen() {
         this._redScreenEffect.play();
      }
    __refreshBackGroundBitmap(param1) {
         if($.C("battle.BattleManager").getInstance().mainViewContainer.view)
         {
            if(this._bitmap_background.bitmapData)
            {
               this._bitmap_background.bitmapData.dispose();
            }
            this._bitmap_background.bitmapData = this.drawDisplayObject($.C("battle.BattleManager").getInstance().mainViewContainer.view);
            this._bitmap_background.bitmapData.applyFilter(this._bitmap_background.bitmapData,new ($.C("flash.geom.Rectangle"))(0,0,this._bitmap_background.bitmapData.width,this._bitmap_background.bitmapData.height),new ($.C("flash.geom.Point"))(),new ($.C("flash.filters.BlurFilter"))(10,10,1));
            this._bitmap_background.x = -1;
            this._bitmap_background.y = -1;
         }
      }
    drawDisplayObject(param1 = null) {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc2_ = param1.getBounds(param1);
         if($.is(param1, $.C("flash.display.Stage")) || _loc2_.width != 0 && _loc2_.height != 0)
         {
            _loc3_ = new ($.C("flash.geom.Rectangle"))(0,0,Math.abs(_loc2_.width),Math.abs(_loc2_.height));
            _loc3_.width = _loc3_.width > 2880 ? 2880 : _loc3_.width;
            _loc3_.height = _loc3_.height > 2880 ? 2880 : _loc3_.height;
            _loc4_ = new ($.C("flash.display.BitmapData"))(_loc3_.width,_loc3_.height,true,0);
            _loc5_ = new ($.C("flash.geom.Matrix"))();
            _loc5_.translate(-_loc2_.x,-_loc2_.y);
            _loc4_.draw(param1,_loc5_);
            return _loc4_;
         }
         return null;
      }
    __goddessSkillHandler(param1) {
         if(!$.C("yishi.datas.VersionSwitch").GODDESS_OPEN)
         {
            return;
         }
         var _loc2_ = $.as(param1.data, "Array");
         if(_loc2_.length > 0)
         {
            if(!this._goddessMovieView)
            {
               this._goddessMovieView = new ($.C("battle.view.ui.BattleGoddessMovieView"))();
            }
            this._goddessMovieView.setViewData(_loc2_);
            this.addChild(this._goddessMovieView);
         }
      }
    get sceneWidth() {
         return this._sceneWidth;
      }
    get sceneHeight() {
         return this._sceneHeight;
      }
    getProfoundLayer() {
         return this._profoundLayer;
      }
    dispose() {
         $.C("battle.chat.BattleChatController").getInstance().dispose();
         $.C("com.pickgliss.ui.LayerManager").Instance.getLayerByType(4).visible = true;
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("BattleModelNotic.ADD_ROLE",$.bind(this, "__modelAddRole"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("REFRESH_BACK_BITMAP",$.bind(this, "__refreshBackGroundBitmap"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("shakeMapComplete",$.bind(this, "onShakeMapComplete"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("UPDATE_CHAT_VIEW",$.bind(this, "__playerChatHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__onResize"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("GODDESS_GUARD_SKILL",$.bind(this, "__goddessSkillHandler"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatPop);
         this._chatPop = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._redScreenEffect);
         this._redScreenEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._map);
         this._map = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._battleUI);
         this._battleUI = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessMovieView);
         this._goddessMovieView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._profoundLayer);
         this._model = null;
         $.C("battle.BattleManager").getInstance().battleMap = null;
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bitmap_background);
         $.C("battle.view.roles.CreateDamageNumViewHelper").ins().dispose();
      }
    set needShowChatPop(v) { super.needShowChatPop = v; }
    set sceneWidth(v) { super.sceneWidth = v; }
    set sceneHeight(v) { super.sceneHeight = v; }
  }
  $.meta(__BattleView, "battle.view.BattleView", ["Disposeable"]);
  $.statics(__BattleView, () => {
    __BattleView.CAMERA_Y = 480;
    __BattleView.CAMERA_X = 650;
  });
  return __BattleView;
}
deps["battle.view.BattleView"] = ["battle.BattleManager", "battle.chat.BattleChatController", "battle.chat.BattleChatPopView", "battle.data.BattleMapData", "battle.utils.BattleUtils", "battle.utils.Helpers", "battle.view.map.BattleMapView", "battle.view.roles.CreateDamageNumViewHelper", "battle.view.roles.PawnRoleView", "battle.view.ui.BattleGoddessMovieView", "battle.view.ui.BattleUIView", "battle.view.ui.RedScreenEffect", "chat.datas.ChatData", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.BitmapData", "flash.display.Sprite", "flash.display.Stage", "flash.filters.BlurFilter", "flash.geom.Matrix", "flash.geom.Point", "flash.geom.Rectangle", "map.campaign.CampaignManager", "yishi.datas.VersionSwitch", "yishi.datas.objects.HeroRoleInfo", "yishi.datas.objects.RoleInfo", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager", "yishi.utils.WorldBossHelper"];

defs["battle.view.animation.SpStripIncreaseAnimation"] = function define($) {
  const __Base = $.Object;
  class __SpStripIncreaseAnimation extends __Base {
    static $fields(self) {
    self._container = null;
    self._strip = null;
    self._timer = null;
    self._startX_1 = NaN;
    self._startX_2 = NaN;
    self._oldSp = 0;
    self._spStep = 0;
    self._count = 0;
    self._current = 0;
    self._interval = 0;
    self._isRunning = false;
    self._destValue = 0;
    }
    constructor(param1, param2) {
         super();
         this._container = param1;
         this._strip = param2;
      }
    start(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._oldSp = param1;
         this._destValue = param1 + param2;
         this._isRunning = true;
         this._startX_1 = this._strip.x + this._strip.maskWidth + -16;
         this._startX_2 = this._strip.x + this._strip.maskWidth + -58;
         this._count = Math.ceil(param2 / this._strip.maxValue * 275 / 10);
         this._interval = 300 / this._count;
         this._spStep = param2 / this._count;
         this.startTimer();
      }
    getDestCurrent() {
         return this._destValue;
      }
    startTimer() {
         this._timer = new ($.C("flash.utils.Timer"))(this._interval);
         this._timer.addEventListener("timer",$.bind(this, "onTimer"));
         this._timer.start();
      }
    onTimer(param1) {
         if(this._current < this._count)
         {
            this.addOnce();
         }
         else
         {
            this.dispose();
         }
      }
    removeTimer() {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "onTimer"));
            this._timer = null;
         }
      }
    addOnce() {
         var _loc1_ = this.createAsset1();
         var _loc2_ = this.createAsset2();
         _loc1_.x = this._startX_1 + this._current * 10;
         _loc1_.y = this._strip.y + -11;
         _loc2_.x = this._startX_2 + this._current * 10;
         _loc2_.y = this._strip.y + -8;
         this._container.addChild(_loc2_);
         this._container.addChild(_loc1_);
         var _loc3_ = this._oldSp + this._spStep * this._current;
         if(_loc3_ > 100)
         {
            _loc3_ = 100;
         }
         this._strip.currentValue = _loc3_;
         this._current = this._current + 1;
         if(this._current == this._count)
         {
            this.dispose();
         }
      }
    createAsset1() {
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.PowerIncrease1");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         return _loc1_;
      }
    createAsset2() {
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.PowerIncrease2");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         return _loc1_;
      }
    isRunning() {
         return this._isRunning;
      }
    dispose() {
         if(this._strip && $.C("battle.BattleManager").getInstance().battleModel)
         {
            this._strip.currentValue = $.C("battle.BattleManager").getInstance().battleModel.selfHero.sp;
         }
         this.removeTimer();
         this._isRunning = false;
         this._container = null;
         this._strip = null;
      }
  }
  $.meta(__SpStripIncreaseAnimation, "battle.view.animation.SpStripIncreaseAnimation", []);
  $.statics(__SpStripIncreaseAnimation, () => {
    __SpStripIncreaseAnimation.X_OFFSET_1 = -16;
    __SpStripIncreaseAnimation.X_OFFSET_2 = -58;
    __SpStripIncreaseAnimation.Y_OFFSET_1 = -11;
    __SpStripIncreaseAnimation.Y_OFFSET_2 = -8;
    __SpStripIncreaseAnimation.PERSISTENT = 300;
    __SpStripIncreaseAnimation.GAP = 10;
  });
  return __SpStripIncreaseAnimation;
}
deps["battle.view.animation.SpStripIncreaseAnimation"] = ["battle.BattleManager", "com.pickgliss.ui.ComponentFactory", "flash.utils.Timer"];

defs["battle.view.bottom.BattleBeliefProgressView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __BattleBeliefProgressView extends __Base {
    static $fields(self) {
    self._progressMc = null;
    self._beliefContiner = null;
    self._numberBitmap = null;
    self.beliefMax = 0;
    self._preBelief = 999;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.__updateGoddessBeliefHandler(null,null);
      }
    initView() {
         this._progressMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("BattleBeliefProgressView.progressMc");
         this._numberBitmap = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.BattleBeliefProgressView.numberBitmap");
         this._beliefContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleBeliefProgressView.beliefContiner");
         this.addChild(this._progressMc);
         this.addChild(this._beliefContiner);
         this.beliefMax = $.C("yishi.datas.ConfigInfoManager").instance.getBattleGoddessMaxBelief();
         this._progressMc.gotoAndStop(1);
         this._progressMc["progress"].gotoAndStop(1);
         this._progressMc["fullMc1"].visible = false;
         this._progressMc["fullMc2"].visible = false;
         this._progressMc["fullMc1"].gotoAndStop(1);
         this._progressMc["fullMc2"].gotoAndStop(1);
         $.C("yishi.utils.NumberViewUtils").getNumberView(0,this._beliefContiner,this._numberBitmap.bitmapData,13,18,10,13,"0123456789",0);
      }
    addEvent() {
         $.C("yishi.utils.MsgMan").addObserver("GODDESS_BELIEF_CHANGE",this,$.bind(this, "__updateGoddessBeliefHandler"));
      }
    removeEvent() {
         $.C("yishi.utils.MsgMan").removeObserver("GODDESS_BELIEF_CHANGE",this,$.bind(this, "__updateGoddessBeliefHandler"));
      }
    __updateGoddessBeliefHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var beliefValue;
         var frame;
         var msg = param1;
         var obj = param2;
         if(!this.selfInfo.goddessRoleInfo || this._preBelief == this.selfInfo.goddessRoleInfo.belief)
         {
            return;
         }
         beliefValue = $.int(this.selfInfo.goddessRoleInfo.belief > this.beliefMax ? 120 : this.selfInfo.goddessRoleInfo.belief);
         frame = $.int($.int(beliefValue / 2) > 0 ? $.int(beliefValue / 2) : 1);
         $.C("yishi.utils.NumberViewUtils").getNumberView(this.selfInfo.goddessRoleInfo.belief,this._beliefContiner,this._numberBitmap.bitmapData,13,18,10,13,"0123456789",0);
         this._beliefContiner.x = this.selfInfo.goddessRoleInfo.belief < 10 ? 85 : 78;
         if(this.selfInfo.goddessRoleInfo.belief < this._preBelief)
         {
            this._progressMc["progress"].gotoAndStop(frame);
         }
         else
         {
            this._progressMc["progress"].addFrameScript(frame - 1,() =>
            {
               this._progressMc["progress"].stop();
               this._progressMc["progress"].addFrameScript(frame - 1,null);
            });
            this._progressMc.play();
            this._progressMc["progress"].play();
         }
         this._preBelief = this.selfInfo.goddessRoleInfo.belief;
         if(this.selfInfo.goddessRoleInfo.belief >= 100)
         {
            this._progressMc["fullMc1"].visible = true;
            this._progressMc["fullMc2"].visible = true;
            this._progressMc["fullMc1"].gotoAndPlay(1);
            this._progressMc["fullMc2"].gotoAndPlay(1);
         }
         else
         {
            this._progressMc["fullMc1"].visible = false;
            this._progressMc["fullMc2"].visible = false;
            this._progressMc["fullMc1"].gotoAndStop(1);
            this._progressMc["fullMc2"].gotoAndStop(1);
         }
      }
    get selfInfo() {
         return $.C("battle.BattleManager").getInstance().battleModel.selfHero;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._progressMc);
         this._progressMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._beliefContiner);
         this._beliefContiner = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._numberBitmap);
         this._numberBitmap = null;
         super.dispose();
      }
    set selfInfo(v) { super.selfInfo = v; }
  }
  $.meta(__BattleBeliefProgressView, "battle.view.bottom.BattleBeliefProgressView", []);
  return __BattleBeliefProgressView;
}
deps["battle.view.bottom.BattleBeliefProgressView"] = ["battle.BattleManager", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "yishi.datas.ConfigInfoManager", "yishi.utils.MsgMan", "yishi.utils.NumberViewUtils"];

defs["battle.view.bottom.BottomBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BottomBar extends __Base {
    static $fields(self) {
    self._back = null;
    self._skillList = null;
    self._warsoulSkill = null;
    self._selfBloodView = null;
    self._bufferContainer = null;
    self._selfSpView = null;
    self._avengerView = null;
    self._childAwakenView = null;
    self._ballRotate = false;
    self._settingBtn = null;
    self._leftAwakenFigure = null;
    self._selfHitPointView = null;
    self._beliefView = null;
    self._selfInfo = null;
    self._childInfo = null;
    self._battleModel = null;
    }
    constructor(param1 = true) {
         super();
         this._battleModel = $.C("battle.BattleManager").getInstance().battleModel;
         this._selfInfo = this._battleModel.selfHero;
         this._childInfo = this._battleModel.childHero;
         this._ballRotate = param1;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.BottomBack");
         this._back.smoothing = true;
         this._back.x = -this._back.width * 0.5;
         this._back.y = -this._back.height;
         this._back.gotoAndStop(1);
         this.addChild(this._back);
         this._childAwakenView = new ($.C("battle.view.bottom.ChildAwakenView"))(this);
         this._selfBloodView = new ($.C("battle.view.bottom.SelfBloodView"))(this);
         this._selfSpView = new ($.C("battle.view.bottom.SelfSpView"))(this,this._selfInfo.spMax);
         this._selfHitPointView = new ($.C("battle.view.bottom.SelfHitPointView"))();
         this._selfHitPointView.x = this._back.x + 150;
         this._selfHitPointView.y = this._back.y + 66;
         this._selfHitPointView.updateHeroHitPoint(this._selfInfo.hitPoint);
         this._back.gotoAndStop(1);
         if(this._selfInfo.heroInfo && this._selfInfo.heroInfo.dragonTalkerInfo.isDragonTalker)
         {
            this.addChild(this._selfHitPointView);
            this._back.gotoAndStop(3);
         }
         else
         {
            this._back.gotoAndStop(1);
         }
         if(this._selfInfo.heroInfo && this._selfInfo.heroInfo.isAvenger && this._selfInfo.avengerFightSkills.length > 0)
         {
            this._avengerView = new ($.C("battle.view.ui.AvengerBattleSkillView"))();
            this._avengerView.x = this._back.x - 110;
            this._avengerView.y = this._back.y + 100;
            this._avengerView.updateAvengerSp(this._selfInfo.avengerSp);
            this._avengerView.updateAvengerSkills();
            this.addChild(this._avengerView);
         }
         this.onHeroSpChanged(null);
         this.__childAwakenChangeHandler(null);
         if($.C("yishi.datas.VersionSwitch").WARSOUL)
         {
            this._warsoulSkill = new ($.C("battle.view.ui.SkillWarsoulView"))();
            this._warsoulSkill.x = -235;
            this._warsoulSkill.y = -116;
            this.addChild(this._warsoulSkill);
         }
         this._skillList = new ($.C("battle.view.ui.SkillItemListView"))();
         this._skillList.x = -235;
         this._skillList.y = -65;
         this.addChild(this._skillList);
         this.redrawBack();
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.BottomTextBack");
         _loc1_.x = this._back.x + 154;
         _loc1_.y = this._back.y + 178;
         this.addChild(_loc1_);
         _loc1_ = new ($.C("flash.display.Bitmap"))(_loc1_.bitmapData);
         _loc1_.x = this._back.x + 745;
         _loc1_.y = this._back.y + 178;
         this.addChild(_loc1_);
         this.addChild(this._selfSpView.heroSpNumContainer);
         this.addChild(this._selfBloodView.heroHpNumContainer);
         if($.C("managers.GodDessManager").instance.isOpen)
         {
            this._beliefView = new ($.C("battle.view.bottom.BattleBeliefProgressView"))();
            this._beliefView.x = this._back.x + 830;
            this._beliefView.y = this._back.y + 60;
            this.addChild(this._beliefView);
         }
         this._bufferContainer = new ($.C("battle.view.ui.SelfBufferView"))();
         this._bufferContainer.x = -190;
         this._bufferContainer.y = -99;
         this.addChild(this._bufferContainer);
         if($.C("yishi.datas.VersionSwitch").WARSOUL)
         {
            this._bufferContainer.y = -144;
            this._bufferContainer.x = -165;
         }
         this._settingBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.settingBtn");
         this.addChild(this._settingBtn);
         this._settingBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.BottomBar.settingBtn.tipData");
         this.showVesselBall();
         this.switchSkills(this._selfInfo.isPetState);
      }
    addEvent() {
         if(this._settingBtn)
         {
            this._settingBtn.addEventListener("click",$.bind(this, "onSettingBtnClick"));
         }
         if(this._selfInfo)
         {
            this._selfInfo.addEventListener("sp",$.bind(this, "onHeroSpChanged"));
            this._selfInfo.addEventListener("MORPH",$.bind(this, "__morphHandler"));
            this._selfInfo.addEventListener("HIT_POINT",$.bind(this, "__hitPointChangeHandler"));
         }
         if(this._childInfo)
         {
            this._childInfo.addEventListener("AWAKEN",$.bind(this, "__childAwakenChangeHandler"));
         }
         $.C("org.aswing.KeyboardManager").getInstance().addEventListener("keyDown",$.bind(this, "onKeyDown"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
      }
    removeEvent() {
         if(this._settingBtn)
         {
            this._settingBtn.removeEventListener("click",$.bind(this, "onSettingBtnClick"));
         }
         if(this._selfInfo)
         {
            this._selfInfo.removeEventListener("sp",$.bind(this, "onHeroSpChanged"));
            this._selfInfo.removeEventListener("MORPH",$.bind(this, "__morphHandler"));
            this._selfInfo.removeEventListener("HIT_POINT",$.bind(this, "__hitPointChangeHandler"));
         }
         if(this._childInfo)
         {
            this._childInfo.removeEventListener("AWAKEN",$.bind(this, "__childAwakenChangeHandler"));
         }
         $.C("org.aswing.KeyboardManager").getInstance().removeEventListener("keyDown",$.bind(this, "onKeyDown"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
      }
    __hitPointChangeHandler(param1) {
         var _loc2_ = $.int(this._selfInfo.hitPoint);
         if(this._selfHitPointView && this._selfHitPointView.parent)
         {
            this._selfHitPointView.updateHeroHitPoint(this._selfInfo.hitPoint);
         }
      }
    onKeyDown(param1) {
         if(param1.keyCode != 32)
         {
            return;
         }
         if(this._leftAwakenFigure)
         {
            this._leftAwakenFigure.onKeyDown(param1);
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    redrawBack() {
         var _loc1_ = $.int(this._selfInfo.heroInfo ? this._selfInfo.heroInfo.templateInfo.Job : $.int(this.thane.templateInfo.Job));
         if(_loc1_ == 100)
         {
            _loc1_ = 1;
         }
         this._leftAwakenFigure = new ($.C("battle.view.bottom.SelfAwakenView"))(_loc1_);
         this._leftAwakenFigure.direction = 1;
         this.addChild(this._leftAwakenFigure);
         if(this._selfInfo)
         {
            this._leftAwakenFigure.updateTo(this._selfInfo.awaken);
         }
         if(_loc1_ == 1)
         {
            this._leftAwakenFigure.x = -357;
            this._leftAwakenFigure.y = -119;
         }
         else if(_loc1_ == 2)
         {
            this._leftAwakenFigure.x = -367;
            this._leftAwakenFigure.y = -119;
         }
         else
         {
            this._leftAwakenFigure.x = -362;
            this._leftAwakenFigure.y = -118;
         }
      }
    onSceneEffecCloseHandler(param1) {
         this.setBallRotation(false);
      }
    setBallRotation(param1) {
         if(this._selfBloodView)
         {
            this._selfBloodView.setRotation(param1);
         }
         if(this._selfSpView)
         {
            this._selfSpView.setRotation(param1);
         }
      }
    showVesselBall() {
         this._selfBloodView.showBall(this._ballRotate);
         this._selfSpView.showBall(this._ballRotate);
      }
    onHeroSpChanged(param1) {
         var _loc2_ = $.int(this._selfInfo.sp);
         this._selfSpView.updateHeroSp(_loc2_);
      }
    __childAwakenChangeHandler(param1) {
         var _loc2_ = 0;
         if(this._childInfo)
         {
            _loc2_ = $.int(this._childInfo.awaken);
            this._childAwakenView.updateChildAwaken(_loc2_);
         }
      }
    __morphHandler(param1) {
         if(!this._selfInfo)
         {
            return;
         }
         this.switchSkills(this._selfInfo.isPetState);
         this._skillList.startAppearCd();
      }
    switchSkills(param1) {
         this._skillList.switchSkills(param1);
      }
    getSpGlobalPos() {
         return this.localToGlobal(new ($.C("flash.geom.Point"))(280,-73));
      }
    getHitPointGlobalPos() {
         return this.localToGlobal(new ($.C("flash.geom.Point"))(-330,-110));
      }
    getSkillList() {
         return this._skillList;
      }
    getSelfBloodView() {
         return this._selfBloodView;
      }
    get activeAwakenFigure() {
         return this._leftAwakenFigure;
      }
    onSettingBtnClick(param1) {
         $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "openFrame"),10);
      }
    openFrame() {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("setting");
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._settingBtn);
         this._settingBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfBloodView);
         this._selfBloodView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfSpView);
         this._selfSpView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childAwakenView);
         this._childAwakenView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftAwakenFigure);
         this._leftAwakenFigure = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillList);
         this._skillList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferContainer);
         this._bufferContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._warsoulSkill);
         this._warsoulSkill = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._beliefView);
         this._beliefView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfHitPointView);
         this._selfHitPointView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._avengerView);
         this._avengerView = null;
         this._selfInfo = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set thane(v) { super.thane = v; }
    set activeAwakenFigure(v) { super.activeAwakenFigure = v; }
  }
  $.meta(__BottomBar, "battle.view.bottom.BottomBar", []);
  return __BottomBar;
}
deps["battle.view.bottom.BottomBar"] = ["battle.BattleManager", "battle.view.bottom.BattleBeliefProgressView", "battle.view.bottom.ChildAwakenView", "battle.view.bottom.SelfAwakenView", "battle.view.bottom.SelfBloodView", "battle.view.bottom.SelfHitPointView", "battle.view.bottom.SelfSpView", "battle.view.ui.AvengerBattleSkillView", "battle.view.ui.SelfBufferView", "battle.view.ui.SkillItemListView", "battle.view.ui.SkillWarsoulView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.Sprite", "flash.geom.Point", "manager.LanguageMgr", "managers.GodDessManager", "org.aswing.KeyboardManager", "yishi.datas.VersionSwitch", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.utils.TimerUtils"];

defs["battle.view.bottom.ChildAwakenView"] = function define($) {
  const __Base = $.Object;
  class __ChildAwakenView extends __Base {
    static $fields(self) {
    self._container = null;
    self._awakenMax = 0;
    self._childAwakenNumContainer = null;
    self._childAwakenNumBmd = null;
    self._childAwakenNumRect = null;
    self._childAwakenValue = -1;
    self._awakenMovie = null;
    self._tipView = null;
    }
    constructor(param1, param2 = 100) {
         super();
         this._container = param1;
         this._awakenMax = param2;
         this._childAwakenNumRect = new ($.C("flash.geom.Rectangle"))(190,-95,88,18);
         this.initView();
         this.updateChildAwaken(0);
      }
    initView() {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.SelfHpNumAsset");
         this._childAwakenNumBmd = _loc2_.bitmapData;
         this._childAwakenNumContainer = new ($.C("flash.display.Sprite"))();
         this._awakenMovie = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.battle.ChildAwakenMC");
         this._awakenMovie.x = 214;
         this._awakenMovie.y = -152;
         this._container.addChildAt(this._awakenMovie,0);
         this._tipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.ChildAwakenTip");
         var _loc1_ = 75;
         this._tipView.graphics.beginFill(0,0);
         this._tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         this._tipView.graphics.endFill();
         this._tipView.x = this._awakenMovie.x;
         this._tipView.y = this._awakenMovie.y;
         this._tipView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.ChildAwakenView.tipView.tipData01") + " " + $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.ChildAwakenView.tipView.tipData02");
         this._container.addChild(this._tipView);
      }
    updateChildAwaken(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._childAwakenValue == param1)
         {
            return;
         }
         this._childAwakenValue = param1;
         $.C("yishi.utils.NumberViewUtils").getNumberView(this._childAwakenValue,this._childAwakenNumContainer,this._childAwakenNumBmd,15,16,10,15,"0123456789.",1);
         this.layoutHeroHpNum();
         var _loc2_ = Math.ceil(this._childAwakenValue * 100 / this._awakenMax);
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         this.gotoAndStop(_loc2_);
         if(this._childAwakenValue >= this._awakenMax)
         {
            this.effectVisible = true;
         }
         else
         {
            this.effectVisible = false;
         }
      }
    gotoAndStop(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._awakenMovie)
         {
            this._awakenMovie.gotoAndStop(param1);
            this._awakenMovie["content"]["bg"].gotoAndStop(param1);
         }
      }
    set effectVisible(param1) {
         if(this._awakenMovie)
         {
            this._awakenMovie["effect"].visible = param1;
         }
      }
    layoutHeroHpNum() {
         this._childAwakenNumContainer.x = this._childAwakenNumRect.x + (this._childAwakenNumRect.width - this._childAwakenNumContainer.width) * 0.5;
         this._childAwakenNumContainer.y = this._childAwakenNumRect.y - 5;
      }
    get childAwakenNumContainer() {
         return this._childAwakenNumContainer;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childAwakenNumBmd);
         this._childAwakenNumBmd = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipView);
         this._tipView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childAwakenNumContainer);
         this._childAwakenNumContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._awakenMovie);
         this._awakenMovie = null;
      }
    get effectVisible() { return super.effectVisible; }
    set childAwakenNumContainer(v) { super.childAwakenNumContainer = v; }
  }
  $.meta(__ChildAwakenView, "battle.view.bottom.ChildAwakenView", []);
  $.statics(__ChildAwakenView, () => {
    __ChildAwakenView.BALL_WIDTH = 150;
  });
  return __ChildAwakenView;
}
deps["battle.view.bottom.ChildAwakenView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.utils.NumberViewUtils"];

defs["battle.view.bottom.ChildCommonBottomBar"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __ChildCommonBottomBar extends __Base {
    static $fields(self) {
    self._back = null;
    self._hpTxt = null;
    self._spTxt = null;
    self._skillList = null;
    self._selfBloodView = null;
    self._selfSpView = null;
    self._leftAwakenFigure = null;
    self._ballRotate = false;
    self._childNswarHbox = null;
    self._childNswarAddList = null;
    }
    constructor(param1 = true) {
         super();
         this._ballRotate = param1;
         this.initView();
         this.addEvent();
      }
    initView() {
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc1_ = this.battleModel.battleType == 3911;
         var _loc2_ = 54;
         this._hpTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.AbysmHpValueText");
         this._spTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.AbysmMpValueText");
         this._skillList = new ($.C("battle.view.ui.ChildCommonSkillItemListView"))();
         this._leftAwakenFigure = new ($.C("battle.view.bottom.ChildSelfChangeView"))();
         if(_loc1_)
         {
            this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarBg");
            this._selfBloodView = new ($.C("battle.view.bottom.ChildSelfBloodView"))(this,-238 - _loc2_,-91);
            this._selfSpView = new ($.C("battle.view.bottom.SelfSpView"))(this,100,145 + _loc2_,-90);
            this._skillList.x = -135 - _loc2_;
            this._skillList.y = -65;
            this._leftAwakenFigure.x = -272 - _loc2_;
            this._leftAwakenFigure.y = -159;
            this._hpTxt.x -= _loc2_;
            this._spTxt.x += _loc2_;
            this._childNswarHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.childnswar.bottom.HBox");
            this._childNswarHbox.beginChanges();
            this._childNswarAddList = new $.Vector();
            _loc4_ = 0;
            while(_loc4_ < 2)
            {
               _loc3_ = new ($.C("battle.view.bottom.ChildNswarCallIcon"))(_loc4_ + 3);
               this._childNswarAddList[_loc4_] = _loc3_;
               this._childNswarHbox.addChild(_loc3_);
               _loc4_++;
            }
            this._childNswarHbox.commitChanges();
            this.nswarBattleHandler();
         }
         else
         {
            this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.AbysmBattleBack");
            this._selfBloodView = new ($.C("battle.view.bottom.ChildSelfBloodView"))(this,-238,-91);
            this._selfSpView = new ($.C("battle.view.bottom.SelfSpView"))(this,100,145,-90);
            this._skillList.x = -135;
            this._skillList.y = -65;
            this._leftAwakenFigure.x = -272;
            this._leftAwakenFigure.y = -159;
         }
         this.addChild(this._back);
         this._back.x = -this._back.width * 0.5;
         this._back.y = -this._back.height;
         this.addChild(this._hpTxt);
         this.addChild(this._spTxt);
         this.addChild(this._skillList);
         if(this._childNswarHbox != null)
         {
            this.addChild(this._childNswarHbox);
         }
         this.addChild(this._leftAwakenFigure);
         this._leftAwakenFigure.direction = 1;
         if(this.selfInfo)
         {
            this._leftAwakenFigure.updateTo(this.selfInfo.changeValue);
         }
         this.showVesselBall();
         this.onHeroSpChanged(null);
      }
    addEvent() {
         this.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
         if(this.selfInfo)
         {
            this.selfInfo.addEventListener("AWAKEN",$.bind(this, "onHeroSpChanged"));
         }
         $.C("org.aswing.KeyboardManager").getInstance().addEventListener("keyDown",$.bind(this, "__onKeyDownHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("childNswar.Event.Battle",$.bind(this, "nswarBattleHandler"));
      }
    nswarBattleHandler(param1 = null) {
         var _loc5_ = null;
         var _loc2_ = null;
         if(!this._childNswarAddList)
         {
            return;
         }
         var _loc3_ = 0;
         var _loc4_ = $.C("managers.ChildNswarManager").Instance.model.battleInfo.battleRoleList;
         var _loc6_ = $.int($.C("battle.BattleManager").getInstance().battleModel.selfSide);
         _loc3_ = 3;
         while(_loc3_ < 5)
         {
            _loc5_ = _loc6_ + "_" + _loc3_;
            _loc2_ = this._childNswarAddList[_loc3_ - 3];
            _loc2_.updateView(_loc4_[_loc5_]);
            _loc3_++;
         }
      }
    __onKeyDownHandler(param1) {
         if(param1.keyCode != 32)
         {
            return;
         }
         if(this._leftAwakenFigure)
         {
            this._leftAwakenFigure.onKeyDown(param1);
         }
      }
    onSceneEffecCloseHandler(param1) {
         this.setBallRotation(false);
      }
    setBallRotation(param1) {
         if(this._selfBloodView)
         {
            this._selfBloodView.setRotation(param1);
         }
         if(this._selfSpView)
         {
            this._selfSpView.setRotation(param1);
         }
      }
    showVesselBall() {
         this._selfBloodView.showBall(this._ballRotate);
         this._selfSpView.showBall(this._ballRotate);
      }
    onHeroSpChanged(param1) {
         var _loc2_ = $.int(this.selfInfo.awaken);
         this._selfSpView.updateHeroSp(_loc2_);
         this._spTxt.text = String(_loc2_);
      }
    __enterFrame(param1) {
         if(!this.selfInfo)
         {
            return;
         }
         var _loc2_ = Number(this.selfInfo.bloodA);
         this._selfBloodView.updateHeroHp(_loc2_);
         this._hpTxt.text = String(_loc2_);
         if(_loc2_ <= 0)
         {
            $.C("battle.BattleManager").getInstance().battleModel.isOver = true;
            $.C("yishi.manager.NotificationManager").instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
    removeEvent() {
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
         if(this.selfInfo)
         {
            this.selfInfo.removeEventListener("AWAKEN",$.bind(this, "onHeroSpChanged"));
         }
         $.C("org.aswing.KeyboardManager").getInstance().removeEventListener("keyDown",$.bind(this, "__onKeyDownHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("childNswar.Event.Battle",$.bind(this, "nswarBattleHandler"));
      }
    get selfInfo() {
         return this.battleModel.selfChildHeroInfo;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hpTxt);
         this._hpTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._spTxt);
         this._spTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillList);
         this._skillList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfSpView);
         this._selfSpView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfBloodView);
         this._selfBloodView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftAwakenFigure);
         this._leftAwakenFigure = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childNswarHbox);
         this._childNswarHbox = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this._childNswarAddList);
         this._childNswarAddList = null;
         super.dispose();
      }
    set selfInfo(v) { super.selfInfo = v; }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__ChildCommonBottomBar, "battle.view.bottom.ChildCommonBottomBar", []);
  return __ChildCommonBottomBar;
}
deps["battle.view.bottom.ChildCommonBottomBar"] = ["battle.BattleManager", "battle.view.bottom.ChildNswarCallIcon", "battle.view.bottom.ChildSelfBloodView", "battle.view.bottom.ChildSelfChangeView", "battle.view.bottom.SelfSpView", "battle.view.ui.ChildCommonSkillItemListView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "managers.ChildNswarManager", "org.aswing.KeyboardManager", "utils.LogicUtils", "yishi.manager.NotificationManager"];

defs["battle.view.bottom.ChildNswarCallIcon"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChildNswarCallIcon extends __Base {
    static $fields(self) {
    self._icon = null;
    self._mShape = null;
    self._dieImg = null;
    self._fightIng = null;
    self._bg = null;
    self._idx = 0;
    }
    constructor(param1) {
         super();
         this._idx = param1;
         this.initView();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarCicleBg");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("childnswar.battle.childIcon");
         this._dieImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarDie");
         this._fightIng = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarCicle");
         this._mShape = new ($.C("flash.display.Shape"))();
         this._mShape.graphics.beginFill(16711680);
         this._mShape.graphics.drawCircle(0,0,22);
         this._mShape.graphics.endFill();
         this._mShape.x = 27.5;
         this._mShape.y = 31;
         this.addChild(this._bg);
         this.addChild(this._icon);
         this.addChild(this._mShape);
         this.addChild(this._fightIng);
         this.addChild(this._dieImg);
         this._icon.mask = this._mShape;
         this._dieImg.visible = false;
         this._fightIng.visible = false;
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "clickHandler"));
         this.buttonMode = true;
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "clickHandler"));
         this.buttonMode = false;
      }
    clickHandler(param1) {
         $.C("yishi.manager.NotificationManager").instance.sendNotification("childnswar.battle.UseAdd",this._idx);
      }
    updateView(param1) {
         var _loc2_ = null;
         if(param1)
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.childTemplateCate.getTemplateByJobAndGrades(param1.jobType,1);
            this._icon.icon = $.C("yishi.manager.PathManager").info.ResourcePath + "icon" + _loc2_.Icon;
            this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("childnswar.click.addRole");
            this._dieImg.visible = false;
            this._fightIng.visible = false;
            switch($.int(param1.state))
            {
               case 0:
                  this.removeEvent();
                  this.addEvent();
                  break;
               case 1:
                  this._fightIng.visible = true;
                  this.removeEvent();
                  break;
               case 2:
                  this._dieImg.visible = true;
                  this.removeEvent();
            }
         }
         else
         {
            this._dieImg.visible = false;
            this._fightIng.visible = false;
            this.removeEvent();
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightIng);
         this._fightIng = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dieImg);
         this._dieImg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ChildNswarCallIcon, "battle.view.bottom.ChildNswarCallIcon", []);
  return __ChildNswarCallIcon;
}
deps["battle.view.bottom.ChildNswarCallIcon"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Shape", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.NotificationManager", "yishi.manager.PathManager", "yishi.manager.TempleteManager"];

defs["battle.view.bottom.ChildSelfBloodView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __ChildSelfBloodView extends __Base {
    static $fields(self) {
    self._container = null;
    self._heroHpNumContainer = null;
    self._heroHpNumBmd = null;
    self._heroHpNumRect = null;
    self._heroHpValue = 0;
    self._bloodPool = null;
    self._tipView = null;
    self.$$_x = 0;
    self.$$_y = 0;
    }
    constructor(param1, param2 = -338, param3 = -116, param4 = 0) {
         super();
         this._container = param1;
         this.$$_x = param2;
         this.$$_y = param3;
         if(param4 == 1)
         {
            this._heroHpNumRect = new ($.C("flash.geom.Rectangle"))(-239,-12,93,18);
         }
         else
         {
            this._heroHpNumRect = new ($.C("flash.geom.Rectangle"))(-340,-14,88,18);
         }
         this.initView();
      }
    initView() {
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.SelfHpNumAsset");
         this._heroHpNumBmd = _loc4_.bitmapData;
         this._heroHpNumContainer = new ($.C("flash.display.Sprite"))();
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.VesselPoolLineMC");
         _loc3_.alpha = 0.6;
         var _loc2_ = new ($.C("flash.geom.ColorTransform"))(0.7,0,0);
         _loc3_.transform.colorTransform = _loc2_;
         this._bloodPool = new ($.C("battle.view.bottom.VesselBallComp"))(this.selfInfo.totalBloodA,this.selfInfo.bloodA,_loc3_);
         this._bloodPool.getView().x = this.$$_x;
         this._bloodPool.getView().y = this.$$_y;
         this._container.addChildAt(this._bloodPool.getView(),0);
         this._tipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.VesselBallTip");
         var _loc1_ = 46.5;
         this._tipView.graphics.beginFill(0,0);
         this._tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         this._tipView.graphics.endFill();
         this._tipView.x = this._bloodPool.getView().x;
         this._tipView.y = this._bloodPool.getView().y;
         this._tipView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottomSelfBloodView.tip");
         this._container.addChild(this._tipView);
      }
    setRotation(param1) {
         if(this._bloodPool)
         {
            this._bloodPool.setRotation(param1);
         }
      }
    showBall(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.BloodPoolBallMC");
         var _loc3_ = new ($.C("yishi.view.tools.SimpleBitmapMovieClip"))($.cast($.C("flash.display.MovieClip"), _loc2_),"asset.battle.BloodPoolBallMC");
         this._bloodPool.showBall(_loc3_,param1);
      }
    updateHeroHp(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._heroHpValue == param1)
         {
            return;
         }
         this._heroHpValue = param1;
         this._bloodPool.max = this.selfInfo.totalBloodA;
         $.C("yishi.utils.NumberViewUtils").getNumberView(this._heroHpValue,this._heroHpNumContainer,this._heroHpNumBmd,15,16,10,15,"0123456789.",1);
         this.layoutHeroHpNum();
         this._bloodPool.update(this._heroHpValue);
      }
    layoutHeroHpNum() {
         this._heroHpNumContainer.x = this._heroHpNumRect.x + (this._heroHpNumRect.width - this._heroHpNumContainer.width) * 0.5;
         this._heroHpNumContainer.y = this._heroHpNumRect.y - 5;
      }
    get selfInfo() {
         return this.battleModel.selfChildHeroInfo;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    get heroHpNumContainer() {
         return this._heroHpNumContainer;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroHpNumBmd);
         this._heroHpNumBmd = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._heroHpNumContainer);
         if(this._tipView)
         {
            if(this._tipView.parent)
            {
               this._tipView.parent.removeChild(this._tipView);
            }
            this._tipView.dispose();
            this._tipView = null;
         }
         if(this._bloodPool)
         {
            if(this._bloodPool.getView() && this._bloodPool.getView().parent)
            {
               this._bloodPool.getView().parent.removeChild(this._bloodPool.getView());
            }
            this._bloodPool.dispose();
            this._bloodPool = null;
         }
         super.dispose();
      }
    set selfInfo(v) { super.selfInfo = v; }
    set battleModel(v) { super.battleModel = v; }
    set heroHpNumContainer(v) { super.heroHpNumContainer = v; }
  }
  $.meta(__ChildSelfBloodView, "battle.view.bottom.ChildSelfBloodView", []);
  return __ChildSelfBloodView;
}
deps["battle.view.bottom.ChildSelfBloodView"] = ["battle.BattleManager", "battle.view.bottom.VesselBallComp", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.geom.ColorTransform", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.utils.NumberViewUtils", "yishi.view.tools.SimpleBitmapMovieClip"];

defs["battle.view.bottom.ChildSelfChangeView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __ChildSelfChangeView extends __Base {
    static $fields(self) {
    self._figureMc = null;
    self._figureContainer = null;
    self._poolLine = null;
    self._tween = null;
    self._currentAwaken = 0;
    self._awakenBgMc = null;
    self._awakenTxtMc = null;
    self._hero = null;
    self.$$_mask = null;
    self._battleModel = $.C("battle.BattleManager").getInstance().battleModel;
    self._darkColor = new ($.C("flash.geom.ColorTransform"))(0.75,0.75,0.75);
    self._normalColor = new ($.C("flash.geom.ColorTransform"))();
    self._uifilter = new ($.C("yishi.filter.SimpleBuildingFilter"))();
    self.useChildChangeSkill = false;
    self._isMouseOver = false;
    self._skillEnable = false;
    self._lastClick = 0;
    self._direction = 1;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s._hero = __s._battleModel.selfChildHeroInfo;
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
         this.addEvent();
         this.mouseChildren = false;
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.tipDirctions = "0";
         this.tipGapH = 0;
         this.tipGapV = 5;
         this.isFollowMouse = false;
         this.enable();
         this.updateStateTxtView();
         this.updateTips();
      }
    initView() {
         this._figureContainer = new ($.C("flash.display.Sprite"))();
         this.addChild(this._figureContainer);
         if($.C("yishi.manager.ArmyManager").instance.thane.grades >= 70)
         {
            this._figureMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.ChildAwakenProgress");
            this._figureContainer.addChild(this._figureMc);
            this._figureMc.gotoAndStop(1);
            this._figureMc.x = -(this._figureMc.width >> 1);
            this._poolLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.ChildVesselPoolLineMC");
            this.$$_mask = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.ChildAwakenMask");
            this._awakenBgMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.PetAwakenEffect");
            this._awakenTxtMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.awakenImage");
            this._figureContainer.addChild(this._poolLine);
            this.addChild(this._awakenBgMc);
            this.addChild(this._awakenTxtMc);
            this._poolLine.mask = this.$$_mask;
            this._figureContainer.addChild(this.$$_mask);
            this._figureContainer.mouseChildren = this._figureContainer.mouseEnabled = false;
            this._awakenBgMc.gotoAndStop(1);
            this._awakenTxtMc.setFrame(1);
            this._awakenBgMc.visible = false;
            this._awakenTxtMc.visible = false;
            this._awakenTxtMc.x = -(this._awakenTxtMc.width >> 1);
            this.$$_mask.x = -53;
            this.$$_mask.y = 29;
            this._poolLine.x = -(this._poolLine.width >> 1) + 78;
            this._poolLine.alpha = 0.6;
         }
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "__rightFigureClickHandler"));
         this.addEventListener("mouseMove",$.bind(this, "__rightFigureOverHandler"));
         this.addEventListener("rollOut",$.bind(this, "__rightFigureOutHandler"));
         this.addEventListener("rollOver",$.bind(this, "__rollOverHandler"));
         this._hero.addEventListener("CHILD_CHANGE_VALUE",$.bind(this, "__onSelfAwakenChangedHandler"));
         this._hero.addEventListener("isLiving",$.bind(this, "__livingHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("battleComplete",$.bind(this, "__battleEndHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("skillCd",$.bind(this, "__skillEnabeleHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("USE_SKILL_RESULT",$.bind(this, "_skillResultHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("restrictChanged",$.bind(this, "__restrictChangeHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("ACTION_SKILL_BattleNotic",$.bind(this, "__skillUse"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__rightFigureClickHandler"));
         this.removeEventListener("mouseMove",$.bind(this, "__rightFigureOverHandler"));
         this.removeEventListener("rollOut",$.bind(this, "__rightFigureOutHandler"));
         this.removeEventListener("rollOver",$.bind(this, "__rollOverHandler"));
         if(this._hero)
         {
            this._hero.removeEventListener("CHILD_CHANGE_VALUE",$.bind(this, "__onSelfAwakenChangedHandler"));
            this._hero.removeEventListener("isLiving",$.bind(this, "__livingHandler"));
         }
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("battleComplete",$.bind(this, "__battleEndHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("skillCd",$.bind(this, "__skillEnabeleHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("USE_SKILL_RESULT",$.bind(this, "_skillResultHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("restrictChanged",$.bind(this, "__restrictChangeHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("ACTION_SKILL_BattleNotic",$.bind(this, "__skillUse"));
      }
    __skillEnable(param1) {
         if(param1 && param1.data == true)
         {
            $.C("yishi.manager.NotificationManager").instance.removeEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
            this._skillEnable = true;
         }
      }
    __skillUse(param1) {
         var _loc2_ = null;
         if($.is(param1.data, $.C("yishi.datas.templates.SkillTempInfo")))
         {
            _loc2_ = $.as(param1.data, $.C("yishi.datas.templates.SkillTempInfo"));
            if(_loc2_.TemplateId == 700003)
            {
               this.useChildChangeSkill = true;
               this.update();
            }
         }
      }
    __rightFigureClickHandler(param1 = null) {
         this.useSkillHandler();
      }
    onKeyDown(param1) {
         if(param1.keyCode != 32)
         {
            return;
         }
         this.useSkillHandler();
      }
    useSkillHandler() {
         var _loc1_ = null;
         if(!this._skillEnable)
         {
            return;
         }
         if(!this.isRight)
         {
            return;
         }
         if(this._battleModel.isOver)
         {
            return;
         }
         if(!this._hero)
         {
            return;
         }
         if(this._hero.restricted)
         {
            return;
         }
         if(this._hero.bloodA <= 0)
         {
            return;
         }
         if(!this.buttonMode)
         {
            return;
         }
         if(this.useChildChangeSkill)
         {
            return;
         }
         var _loc2_ = $.C("flash.utils.getTimer")();
         if(_loc2_ - this._lastClick < 3000)
         {
            return;
         }
         if(this._hero.childCanMorph())
         {
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(700003);
            $.C("yishi.manager.NotificationManager").instance.sendNotification("ACTION_SKILL_BattleNotic",_loc1_);
            this._lastClick = _loc2_;
            if($.C("battle.BattleManager").getInstance().battleModel.getAutoFightFlag() == 1)
            {
               $.C("battle.BattleManager").getInstance().battleModel.setAutoFight(2);
            }
         }
      }
    __rightFigureOverHandler(param1) {
         if(!this.isRight)
         {
            return;
         }
         if(param1)
         {
            this._isMouseOver = true;
         }
         $.C("flash.ui.Mouse").cursor = "auto";
         if(!this.buttonMode)
         {
            return;
         }
         if(this._isMouseOver)
         {
            this.mouseOver();
         }
      }
    __rightFigureOutHandler(param1) {
         if(!this.isRight)
         {
            return;
         }
         this._isMouseOver = false;
         this.mouseOut();
      }
    __rollOverHandler(param1) {
         if(!this.isRight)
         {
            return;
         }
         this.update();
      }
    mouseOver() {
         $.C("flash.ui.Mouse").cursor = "button";
         this._uifilter.setBuildingOverFilter(this);
      }
    mouseOut() {
         $.C("flash.ui.Mouse").cursor = "auto";
         if(this._hero && !this._hero.isLiving)
         {
            this.filters = [$.C("yishi.filter.UIFilter").getBlackFilter()];
         }
         else
         {
            this.filters = null;
         }
      }
    __onSelfAwakenChangedHandler(param1) {
         this.tweenTo(this._hero.changeValue);
      }
    __livingHandler(param1) {
         if(!this._hero.isLiving)
         {
            this.useChildChangeSkill = false;
            this.stopMc();
         }
         this.update();
      }
    __battleEndHandler(param1) {
         this.update();
      }
    __skillEnabeleHandler(param1) {
         var _loc2_ = $.int(param1.data.skillId);
         if(_loc2_ == 700003)
         {
            this.useChildChangeSkill = false;
            this.update();
         }
      }
    _skillResultHandler(param1) {
         var _loc2_ = $.int(param1.data.skillId);
         var _loc3_ = Boolean(param1.data.result);
         if(!_loc3_)
         {
            if(_loc2_ == 700003 && this.useChildChangeSkill)
            {
               this.useChildChangeSkill = false;
            }
         }
         this.update();
      }
    __restrictChangeHandler(param1) {
         this.update();
      }
    updateTo(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = Math.floor(param1 * 100 / 3000);
         this._currentAwaken = param1;
         this.tweenCompleted(param1);
      }
    tweenTo(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(param1 == this._currentAwaken)
         {
            return;
         }
         this._currentAwaken = param1;
         this.killTween();
         if(this._poolLine)
         {
            this._poolLine.visible = true;
         }
         if(this._figureMc)
         {
            _loc2_ = Math.floor(param1 * 100 / 3000);
            this._tween = $.C("com.greensock.TweenMax").to(this._figureMc,0.5,{
               "frame":_loc2_,
               "onUpdate":$.bind(this, "tweenUpdate"),
               "onComplete":$.bind(this, "tweenCompleted"),
               "onCompleteParams":[param1]
            });
         }
         if(param1 == 0)
         {
            this.update();
         }
      }
    killTween() {
         if(this._tween)
         {
            this._tween.kill();
            this._tween = null;
         }
      }
    tweenCompleted(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this.isDie)
         {
            return;
         }
         this.killTween();
         this.refreshMc();
         this.tweenUpdate();
         this.update();
         this.updateTips();
      }
    refreshMc() {
         if(this.isDie)
         {
            return;
         }
         var _loc5_ = Math.floor(this._currentAwaken * 100 / 3000);
         this._figureMc.gotoAndStop(_loc5_);
         var _loc3_ = this._currentAwaken >= 3000;
         var _loc2_ = $.as(this._figureMc["bg"], $.C("flash.display.MovieClip"));
         var _loc1_ = $.as(this._figureMc["eye"], $.C("flash.display.MovieClip"));
         _loc2_.visible = _loc3_;
         if(_loc3_)
         {
            _loc2_.play();
            _loc1_.play();
         }
         else
         {
            _loc2_.gotoAndStop(1);
            _loc1_.gotoAndStop(1);
         }
         var _loc4_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
         if(_loc4_)
         {
            _loc4_.play();
         }
         if(this._poolLine)
         {
            this._poolLine.play();
         }
         if(this._poolLine)
         {
            if(this._currentAwaken == 0)
            {
               this._poolLine.visible = false;
            }
            else
            {
               this._poolLine.visible = true;
            }
         }
      }
    playMc() {
      }
    updateTips() {
         var _loc1_ = null;
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("battle.awaken");
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.colon",_loc1_);
         _loc1_ += this.toArialBold(this._currentAwaken + " / " + 3000);
         if(this.isRight)
         {
            _loc1_ += "\n" + $.C("manager.LanguageMgr").GetTranslation("SelfAwakenView.spaceKey");
         }
         this.tipData = _loc1_;
      }
    toArialBold(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
    tweenUpdate() {
         if(this.isDie)
         {
            return;
         }
         if(this._figureMc && this._poolLine && this._figureMc["pos"])
         {
            this._poolLine.y = this._figureMc.y + this._figureMc["pos"].y;
         }
      }
    updateStateTxtView() {
         this.hideStateView();
         if(this.isRestrict)
         {
            return;
         }
         if(this._hero.childCanMorph() && !this.useChildChangeSkill)
         {
            this.showAwakenState();
         }
      }
    hideStateView() {
         if(this._awakenBgMc)
         {
            this._awakenBgMc.visible = false;
            this._awakenBgMc.stop();
         }
         if(this._awakenTxtMc)
         {
            this._awakenTxtMc.visible = false;
         }
      }
    showAwakenState() {
         if(!this.isRight)
         {
            return;
         }
         if(this._awakenBgMc)
         {
            this._awakenBgMc.visible = true;
            this._awakenBgMc.play();
         }
         if(this._awakenTxtMc)
         {
            this._awakenTxtMc.visible = true;
            this._awakenTxtMc.setFrame(1);
         }
      }
    enable() {
         this.buttonMode = false;
         this.dark();
         this.mouseOut();
         if(this.isRestrict)
         {
            return;
         }
         var _loc1_ = false;
         if(!this.useChildChangeSkill && Boolean(this._hero.childCanMorph()))
         {
            _loc1_ = true;
         }
         if(this.isRight && _loc1_)
         {
            this.buttonMode = true;
         }
         if(_loc1_)
         {
            this.light();
            if(this._isMouseOver)
            {
               this.mouseOver();
            }
         }
         if(!this._hero.isLiving)
         {
            this.stopMc();
         }
         else
         {
            this.refreshMc();
         }
      }
    get isRestrict() {
         if(!this._hero)
         {
            return true;
         }
         if(this._hero.restricted || !this._hero.isLiving)
         {
            return true;
         }
         return false;
      }
    get isRight() {
         return this.direction != -1;
      }
    dark() {
         var _loc1_ = this._poolLine;
         if(_loc1_)
         {
            _loc1_.transform.colorTransform = this._darkColor;
         }
         if(this._figureMc && this._figureMc["body"])
         {
            _loc1_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
            _loc1_.transform.colorTransform = this._darkColor;
         }
      }
    light() {
         var _loc1_ = this._poolLine;
         if(_loc1_)
         {
            _loc1_.transform.colorTransform = this._normalColor;
         }
         if(this._figureMc && this._figureMc["body"])
         {
            _loc1_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
            _loc1_.transform.colorTransform = this._normalColor;
         }
      }
    stopMc() {
         var _loc1_ = null;
         _loc1_ = $.as(this._figureMc["eye"], $.C("flash.display.MovieClip"));
         if(_loc1_)
         {
            _loc1_.stop();
         }
         _loc1_ = $.as(this._figureMc["bg"], $.C("flash.display.MovieClip"));
         if(_loc1_)
         {
            _loc1_.stop();
         }
         _loc1_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
         if(_loc1_)
         {
            _loc1_.stop();
         }
         if(this._poolLine)
         {
            this._poolLine.stop();
         }
         if(this._awakenBgMc)
         {
            this._awakenBgMc.stop();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true);
      }
    get direction() {
         return this._direction;
      }
    set direction(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._direction = param1;
         this._figureContainer.scaleX = param1;
         if(param1 == -1)
         {
            if(this._awakenBgMc)
            {
               this._awakenBgMc.stop();
               this._awakenBgMc.visible = false;
            }
            if(this._awakenTxtMc)
            {
               this._awakenTxtMc.visible = false;
            }
         }
      }
    update() {
         this.enable();
         this.updateStateTxtView();
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._figureMc);
         this._figureMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._figureContainer);
         this._figureContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._poolLine);
         this._poolLine = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._awakenBgMc);
         this._awakenBgMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._awakenTxtMc);
         this._awakenTxtMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this.$$_mask);
         this.$$_mask = null;
         this.killTween();
         this._uifilter = null;
         this._battleModel = null;
         this._hero = null;
         this._darkColor = null;
         this._normalColor = null;
         this._tween = null;
         super.dispose();
      }
    set isRestrict(v) { super.isRestrict = v; }
    set isRight(v) { super.isRight = v; }
  }
  $.meta(__ChildSelfChangeView, "battle.view.bottom.ChildSelfChangeView", []);
  return __ChildSelfChangeView;
}
deps["battle.view.bottom.ChildSelfChangeView"] = ["battle.BattleManager", "com.greensock.TweenMax", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.geom.ColorTransform", "flash.ui.Mouse", "flash.utils.getTimer", "manager.LanguageMgr", "yishi.datas.templates.SkillTempInfo", "yishi.filter.SimpleBuildingFilter", "yishi.filter.UIFilter", "yishi.manager.ArmyManager", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager"];

defs["battle.view.bottom.ChildpveBattleBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChildpveBattleBar extends __Base {
    static $fields(self) {
    self._back = null;
    self._skillList = null;
    self._battleModel = null;
    self._ballRotate = false;
    self._settingBtn = null;
    }
    constructor(param1 = true) {
         super();
         this._ballRotate = param1;
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.remotepetBack");
         this._back.x = -this._back.width * 0.5;
         this._back.y = -this._back.height;
         this.addChild(this._back);
         this._skillList = new ($.C("battle.view.ui.ChildPveSkillItemListView"))();
         this._skillList.x = -300;
         this._skillList.y = -68;
         this.addChild(this._skillList);
         this._settingBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.settingBtn");
         this.addChild(this._settingBtn);
         this._settingBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.BottomBar.settingBtn.tipData");
         this.addEvent();
      }
    addEvent() {
         if(this._settingBtn)
         {
            this._settingBtn.addEventListener("click",$.bind(this, "onSettingBtnClick"));
         }
      }
    getSkillList() {
         return this._skillList;
      }
    onSettingBtnClick(param1) {
         $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "openFrame"),10);
      }
    openFrame() {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("setting");
      }
    removeEvent() {
         if(this._settingBtn)
         {
            this._settingBtn.removeEventListener("click",$.bind(this, "onSettingBtnClick"));
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._settingBtn);
         this._settingBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillList);
         this._skillList = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ChildpveBattleBar, "battle.view.bottom.ChildpveBattleBar", []);
  return __ChildpveBattleBar;
}
deps["battle.view.bottom.ChildpveBattleBar"] = ["battle.view.ui.ChildPveSkillItemListView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.FrameControllerManager", "yishi.utils.TimerUtils"];

defs["battle.view.bottom.MonsterCommonBottomBar"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __MonsterCommonBottomBar extends __Base {
    static $fields(self) {
    self._back = null;
    self._hpTxt = null;
    self._skillList = null;
    self._selfBloodView = null;
    self._ballRotate = false;
    }
    constructor(param1 = true) {
         super();
         this._ballRotate = param1;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.AbysmBattleBack");
         this._hpTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.AbysmHpValueText");
         this._selfBloodView = new ($.C("battle.view.bottom.MonsterSelfBloodView"))(this,-238,-91);
         this._skillList = new ($.C("battle.view.ui.MonsterCommonSkillItemListView"))();
         this.addChild(this._back);
         this._back.x = -this._back.width * 0.5;
         this._back.y = -this._back.height;
         this.addChild(this._hpTxt);
         this.addChild(this._skillList);
         this._skillList.x = -135;
         this._skillList.y = -65;
         this.showVesselBall();
      }
    addEvent() {
         this.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
      }
    onSceneEffecCloseHandler(param1) {
         this.setBallRotation(false);
      }
    setBallRotation(param1) {
         if(this._selfBloodView)
         {
            this._selfBloodView.setRotation(param1);
         }
      }
    showVesselBall() {
         this._selfBloodView.showBall(this._ballRotate);
      }
    __enterFrame(param1) {
         if(!this.selfInfo)
         {
            return;
         }
         var _loc2_ = Number(this.selfInfo.bloodA);
         this._selfBloodView.updateHeroHp(_loc2_);
         this._hpTxt.text = String(_loc2_);
         if(_loc2_ <= 0)
         {
            $.C("battle.BattleManager").getInstance().battleModel.isOver = true;
            $.C("yishi.manager.NotificationManager").instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
    removeEvent() {
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
      }
    get selfInfo() {
         return this.battleModel.selfMonsterRoleInfo;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hpTxt);
         this._hpTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillList);
         this._skillList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfBloodView);
         this._selfBloodView = null;
         super.dispose();
      }
    set selfInfo(v) { super.selfInfo = v; }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__MonsterCommonBottomBar, "battle.view.bottom.MonsterCommonBottomBar", []);
  return __MonsterCommonBottomBar;
}
deps["battle.view.bottom.MonsterCommonBottomBar"] = ["battle.BattleManager", "battle.view.bottom.MonsterSelfBloodView", "battle.view.ui.MonsterCommonSkillItemListView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "yishi.manager.NotificationManager"];

defs["battle.view.bottom.MonsterSelfBloodView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __MonsterSelfBloodView extends __Base {
    static $fields(self) {
    self._container = null;
    self._heroHpNumContainer = null;
    self._heroHpNumBmd = null;
    self._heroHpNumRect = null;
    self._heroHpValue = 0;
    self._bloodPool = null;
    self._tipView = null;
    self.$$_x = 0;
    self.$$_y = 0;
    }
    constructor(param1, param2 = -338, param3 = -116, param4 = 0) {
         super();
         this._container = param1;
         this.$$_x = param2;
         this.$$_y = param3;
         if(param4 == 1)
         {
            this._heroHpNumRect = new ($.C("flash.geom.Rectangle"))(-239,-12,93,18);
         }
         else
         {
            this._heroHpNumRect = new ($.C("flash.geom.Rectangle"))(-340,-14,88,18);
         }
         this.initView();
      }
    initView() {
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.SelfHpNumAsset");
         this._heroHpNumBmd = _loc4_.bitmapData;
         this._heroHpNumContainer = new ($.C("flash.display.Sprite"))();
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.VesselPoolLineMC");
         _loc3_.alpha = 0.6;
         var _loc2_ = new ($.C("flash.geom.ColorTransform"))(0.7,0,0);
         _loc3_.transform.colorTransform = _loc2_;
         this._bloodPool = new ($.C("battle.view.bottom.VesselBallComp"))(this.selfInfo.totalBloodA,this.selfInfo.bloodA,_loc3_);
         this._bloodPool.getView().x = this.$$_x;
         this._bloodPool.getView().y = this.$$_y;
         this._container.addChildAt(this._bloodPool.getView(),0);
         this._tipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.VesselBallTip");
         var _loc1_ = 46.5;
         this._tipView.graphics.beginFill(0,0);
         this._tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         this._tipView.graphics.endFill();
         this._tipView.x = this._bloodPool.getView().x;
         this._tipView.y = this._bloodPool.getView().y;
         this._tipView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottomSelfBloodView.tip");
         this._container.addChild(this._tipView);
      }
    setRotation(param1) {
         if(this._bloodPool)
         {
            this._bloodPool.setRotation(param1);
         }
      }
    showBall(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.BloodPoolBallMC");
         var _loc3_ = new ($.C("yishi.view.tools.SimpleBitmapMovieClip"))($.cast($.C("flash.display.MovieClip"), _loc2_),"asset.battle.BloodPoolBallMC");
         this._bloodPool.showBall(_loc3_,param1);
      }
    updateHeroHp(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._heroHpValue == param1)
         {
            return;
         }
         this._heroHpValue = param1;
         this._bloodPool.max = this.selfInfo.totalBloodA;
         $.C("yishi.utils.NumberViewUtils").getNumberView(this._heroHpValue,this._heroHpNumContainer,this._heroHpNumBmd,15,16,10,15,"0123456789.",1);
         this.layoutHeroHpNum();
         this._bloodPool.update(this._heroHpValue);
      }
    layoutHeroHpNum() {
         this._heroHpNumContainer.x = this._heroHpNumRect.x + (this._heroHpNumRect.width - this._heroHpNumContainer.width) * 0.5;
         this._heroHpNumContainer.y = this._heroHpNumRect.y - 5;
      }
    get selfInfo() {
         return this.battleModel.selfMonsterRoleInfo;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    get heroHpNumContainer() {
         return this._heroHpNumContainer;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroHpNumBmd);
         this._heroHpNumBmd = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._heroHpNumContainer);
         if(this._tipView)
         {
            if(this._tipView.parent)
            {
               this._tipView.parent.removeChild(this._tipView);
            }
            this._tipView.dispose();
            this._tipView = null;
         }
         if(this._bloodPool)
         {
            if(this._bloodPool.getView() && this._bloodPool.getView().parent)
            {
               this._bloodPool.getView().parent.removeChild(this._bloodPool.getView());
            }
            this._bloodPool.dispose();
            this._bloodPool = null;
         }
         super.dispose();
      }
    set selfInfo(v) { super.selfInfo = v; }
    set battleModel(v) { super.battleModel = v; }
    set heroHpNumContainer(v) { super.heroHpNumContainer = v; }
  }
  $.meta(__MonsterSelfBloodView, "battle.view.bottom.MonsterSelfBloodView", []);
  return __MonsterSelfBloodView;
}
deps["battle.view.bottom.MonsterSelfBloodView"] = ["battle.BattleManager", "battle.view.bottom.VesselBallComp", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.geom.ColorTransform", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.utils.NumberViewUtils", "yishi.view.tools.SimpleBitmapMovieClip"];

defs["battle.view.bottom.PetBattleBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PetBattleBar extends __Base {
    static $fields(self) {
    self._back = null;
    self._skillList = null;
    self._battleModel = null;
    self._ballRotate = false;
    self._settingBtn = null;
    }
    constructor(param1 = true) {
         super();
         this._ballRotate = param1;
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.remotepetBack");
         this._back.x = -this._back.width * 0.5;
         this._back.y = -this._back.height;
         this.addChild(this._back);
         this._skillList = new ($.C("battle.view.ui.PetSkillItemListView"))();
         this._skillList.x = -300;
         this._skillList.y = -68;
         this.addChild(this._skillList);
         this._settingBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.settingBtn");
         this.addChild(this._settingBtn);
         this._settingBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.BottomBar.settingBtn.tipData");
         this.addEvent();
      }
    addEvent() {
         if(this._settingBtn)
         {
            this._settingBtn.addEventListener("click",$.bind(this, "onSettingBtnClick"));
         }
      }
    getSkillList() {
         return this._skillList;
      }
    onSettingBtnClick(param1) {
         $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "openFrame"),10);
      }
    openFrame() {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("setting");
      }
    removeEvent() {
         if(this._settingBtn)
         {
            this._settingBtn.removeEventListener("click",$.bind(this, "onSettingBtnClick"));
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._settingBtn);
         this._settingBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillList);
         this._skillList = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PetBattleBar, "battle.view.bottom.PetBattleBar", []);
  return __PetBattleBar;
}
deps["battle.view.bottom.PetBattleBar"] = ["battle.view.ui.PetSkillItemListView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.FrameControllerManager", "yishi.utils.TimerUtils"];

defs["battle.view.bottom.PetSacristyAwakenView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PetSacristyAwakenView extends __Base {
    static $fields(self) {
    self._awakenMax = 100;
    self._awakenMovie = null;
    self._childAwakenValue = -1;
    self._valueText = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._awakenMovie = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.battle.SacristyAwakenMC");
         this._awakenMovie.scaleX = 0.618;
         this._awakenMovie.scaleY = 0.618;
         this.addChild(this._awakenMovie);
         this._valueText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.SacristyAwakenValueText");
         this.addChild(this._valueText);
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("UPDATE_PET_POWER",$.bind(this, "__updatePetPower"));
         this.__updatePetPower(null);
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("UPDATE_PET_POWER",$.bind(this, "__updatePetPower"));
      }
    __updatePetPower(param1) {
         var _loc2_ = $.int($.C("managers.PetSacristyManager").instance.awake);
         this._valueText.text = String(_loc2_);
         this.updateChildAwaken(_loc2_);
      }
    updateChildAwaken(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._childAwakenValue == param1)
         {
            return;
         }
         this._childAwakenValue = param1;
         var _loc2_ = Math.ceil(this._childAwakenValue * 100 / this._awakenMax);
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         this.gotoAndStop(_loc2_);
         if(this._childAwakenValue >= this._awakenMax)
         {
            this.effectVisible = true;
         }
         else
         {
            this.effectVisible = false;
         }
      }
    gotoAndStop(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._awakenMovie)
         {
            this._awakenMovie.gotoAndStop(param1);
         }
      }
    set effectVisible(param1) {
         if(!this._awakenMovie)
         {
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._awakenMovie);
         this._awakenMovie = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._valueText);
         this._valueText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get effectVisible() { return super.effectVisible; }
  }
  $.meta(__PetSacristyAwakenView, "battle.view.bottom.PetSacristyAwakenView", []);
  return __PetSacristyAwakenView;
}
deps["battle.view.bottom.PetSacristyAwakenView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "managers.PetSacristyManager", "yishi.manager.NotificationManager"];

defs["battle.view.bottom.PetSacristyBar"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PetSacristyBar extends __Base {
    static $fields(self) {
    self._back = null;
    self._skillList = null;
    self._petAwakenView = null;
    self._bufferContainer = null;
    self._selfBloodView = null;
    self._battleModel = null;
    self._textBack = null;
    self._ballRotate = false;
    }
    constructor(param1 = true) {
         super();
         this._ballRotate = param1;
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.sacristy.skillBg");
         this._back.x = -this._back.width * 0.5;
         this._back.y = -this._back.height;
         this.addChild(this._back);
         this._petAwakenView = new ($.C("battle.view.bottom.PetSacristyAwakenView"))();
         this._petAwakenView.x = 116;
         this._petAwakenView.y = -142;
         this.addChild(this._petAwakenView);
         this._bufferContainer = new ($.C("battle.view.ui.SelfBufferView"))();
         this._bufferContainer.x = -132;
         this._bufferContainer.y = -104;
         this.addChild(this._bufferContainer);
         this._skillList = new ($.C("battle.view.ui.PetSacristyItemListView"))();
         this._skillList.x = -168;
         this._skillList.y = -68;
         this.addChild(this._skillList);
         this._textBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.sacristy.BottomTextBack");
         this.addChild(this._textBack);
         this._selfBloodView = new ($.C("battle.view.bottom.SelfBloodView"))(this,-238,-89,1);
         this.addChild(this._selfBloodView.heroHpNumContainer);
         this.showVesselBall();
         this.addEvent();
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
      }
    onSceneEffecCloseHandler(param1) {
         this.setBallRotation(false);
      }
    setBallRotation(param1) {
         if(this._selfBloodView)
         {
            this._selfBloodView.setRotation(param1);
         }
      }
    showVesselBall() {
         this._selfBloodView.showBall(this._ballRotate);
      }
    getSelfBloodView() {
         return this._selfBloodView;
      }
    getSkillList() {
         return this._skillList;
      }
    onSettingBtnClick(param1) {
         $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "openFrame"),10);
      }
    openFrame() {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("setting");
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfBloodView);
         this._selfBloodView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillList);
         this._skillList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._textBack);
         this._textBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petAwakenView);
         this._petAwakenView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferContainer);
         this._bufferContainer = null;
         this._battleModel = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PetSacristyBar, "battle.view.bottom.PetSacristyBar", []);
  return __PetSacristyBar;
}
deps["battle.view.bottom.PetSacristyBar"] = ["battle.view.bottom.PetSacristyAwakenView", "battle.view.bottom.SelfBloodView", "battle.view.ui.PetSacristyItemListView", "battle.view.ui.SelfBufferView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.utils.TimerUtils"];

defs["battle.view.bottom.SelfAwakenView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __SelfAwakenView extends __Base {
    static $fields(self) {
    self._figureMc = null;
    self._figureContainer = null;
    self._poolLine = null;
    self._tween = null;
    self._currentAwaken = 0;
    self._awakenBgMc = null;
    self._awakenTxtMc = null;
    self._job = 1;
    self._hero = null;
    self._hasPet = false;
    self.$$_mask = null;
    self._battleModel = $.C("battle.BattleManager").getInstance().battleModel;
    self._darkColor = new ($.C("flash.geom.ColorTransform"))(0.75,0.75,0.75);
    self._normalColor = new ($.C("flash.geom.ColorTransform"))();
    self._uifilter = new ($.C("yishi.filter.SimpleBuildingFilter"))();
    self.useSkill700001 = false;
    self.useSkill700002 = false;
    self._isMouseOver = false;
    self._skillEnable = false;
    self._lastClick = 0;
    self._direction = 1;
    }
    constructor(param1) {
         $.pre(new.target, (__s) => {
         __s._job = param1;
         if(__s._job == 100)
         {
            __s._job = 1;
         }
         if(__s._battleModel)
         {
            __s._hero = $.as(__s._battleModel.selfHero, $.C("yishi.datas.objects.HeroRoleInfo"));
         }
         if(__s._hero && __s._hero.petRoleInfo)
         {
            __s._hasPet = true;
         }
         if(!__s._hasPet)
         {
            __s.mouseEnabled = false;
         }
         if(__s._hero.heroInfo && __s._hero.heroInfo.dragonTalkerInfo.isDragonTalker)
         {
            __s._job = 4;
         }
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
         this.addEvent();
         this.mouseChildren = false;
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.tipDirctions = "0";
         this.tipGapH = 0;
         this.tipGapV = 5;
         this.isFollowMouse = false;
         this.enable();
         this.updateStateTxtView();
         this.updateTips();
      }
    initView() {
         this._figureContainer = new ($.C("flash.display.Sprite"))();
         this.addChild(this._figureContainer);
         if($.C("yishi.manager.ArmyManager").instance.thane.grades >= 50)
         {
            this._figureMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.AwakenProgress50" + this._job);
            this._figureContainer.addChild(this._figureMc);
            this._figureMc.gotoAndStop(1);
            this._figureMc.x = -(this._figureMc.width >> 1);
            this._poolLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.VesselPoolLineMC");
            this.$$_mask = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.AwakenMask" + this._job);
            this._awakenBgMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.PetAwakenEffect");
            this._awakenTxtMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.awakenImage");
            this._figureContainer.addChild(this._poolLine);
            this.addChild(this._awakenBgMc);
            this.addChild(this._awakenTxtMc);
            this._poolLine.mask = this.$$_mask;
            this._figureContainer.addChild(this.$$_mask);
            this._figureContainer.mouseChildren = this._figureContainer.mouseEnabled = false;
            this._awakenBgMc.gotoAndStop(1);
            this._awakenTxtMc.setFrame(1);
            this._awakenBgMc.visible = false;
            this._awakenTxtMc.visible = false;
            this._awakenTxtMc.x = -(this._awakenTxtMc.width >> 1);
            this.$$_mask.x = -(this.$$_mask.width >> 1);
            this._poolLine.x = -(this._poolLine.width >> 1) + 15;
            this._poolLine.alpha = 0.6;
            switch(this._job - 1)
            {
               case 0:
                  this._awakenBgMc.y = 26;
                  this._awakenTxtMc.y = -2;
                  this.$$_mask.y = 24;
                  this._poolLine.y = 117;
                  break;
               case 1:
                  this._awakenBgMc.y = 19;
                  this._awakenTxtMc.y = -10;
                  this.$$_mask.y = 12;
                  this.$$_mask.x = -60;
                  this._poolLine.y = 117;
                  break;
               case 2:
                  this._awakenBgMc.y = 20;
                  this._awakenTxtMc.y = -8;
                  this.$$_mask.y = 19;
                  this._poolLine.y = 117;
                  break;
               case 3:
                  this._awakenBgMc.y = 8;
                  this._awakenTxtMc.y = -20;
                  this.$$_mask.x = -70;
                  this.$$_mask.y = 0;
                  this._poolLine.x = -70;
                  this._poolLine.y = 117;
            }
         }
         else
         {
            this._figureMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.AwakenProgress" + this._job);
            this._figureContainer.addChild(this._figureMc);
            this._figureMc.gotoAndStop(1);
            this._figureMc.x = -(this._figureMc.width >> 1);
         }
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "__rightFigureClickHandler"));
         this.addEventListener("mouseMove",$.bind(this, "__rightFigureOverHandler"));
         this.addEventListener("rollOut",$.bind(this, "__rightFigureOutHandler"));
         this.addEventListener("rollOver",$.bind(this, "__rollOverHandler"));
         this._hero.addEventListener("AWAKEN",$.bind(this, "__onSelfAwakenChangedHandler"));
         this._hero.addEventListener("isLiving",$.bind(this, "__livingHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("battleComplete",$.bind(this, "__battleEndHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("skillCd",$.bind(this, "__skillEnabeleHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("USE_SKILL_RESULT",$.bind(this, "_skillResultHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("restrictChanged",$.bind(this, "__restrictChangeHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("ACTION_SKILL_BattleNotic",$.bind(this, "__skillUse"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__rightFigureClickHandler"));
         this.removeEventListener("mouseMove",$.bind(this, "__rightFigureOverHandler"));
         this.removeEventListener("rollOut",$.bind(this, "__rightFigureOutHandler"));
         this.removeEventListener("rollOver",$.bind(this, "__rollOverHandler"));
         if(this._hero)
         {
            this._hero.removeEventListener("AWAKEN",$.bind(this, "__onSelfAwakenChangedHandler"));
            this._hero.removeEventListener("isLiving",$.bind(this, "__livingHandler"));
         }
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("battleComplete",$.bind(this, "__battleEndHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("skillCd",$.bind(this, "__skillEnabeleHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("USE_SKILL_RESULT",$.bind(this, "_skillResultHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("restrictChanged",$.bind(this, "__restrictChangeHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("ACTION_SKILL_BattleNotic",$.bind(this, "__skillUse"));
      }
    __skillEnable(param1) {
         if(param1 && param1.data == true)
         {
            $.C("yishi.manager.NotificationManager").instance.removeEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
            this._skillEnable = true;
         }
      }
    __skillUse(param1) {
         var _loc2_ = null;
         if($.is(param1.data, $.C("yishi.datas.templates.SkillTempInfo")))
         {
            _loc2_ = $.as(param1.data, $.C("yishi.datas.templates.SkillTempInfo"));
            if(_loc2_.TemplateId == 700001)
            {
               this.useSkill700001 = true;
               this.update();
            }
            else if(_loc2_.TemplateId == 700002)
            {
               this.useSkill700002 = true;
               this.update();
            }
         }
      }
    __rightFigureClickHandler(param1 = null) {
         var _loc2_ = null;
         if(!this.isRight)
         {
            return;
         }
         if(this._battleModel.isOver)
         {
            return;
         }
         if(!this._hero)
         {
            return;
         }
         if(this._hero.restricted)
         {
            return;
         }
         if(this._hero.bloodA <= 0)
         {
            return;
         }
         if(!this.buttonMode)
         {
            return;
         }
         if(this.useSkill700001)
         {
            return;
         }
         var _loc3_ = $.C("flash.utils.getTimer")();
         if(_loc3_ - this._lastClick < 3000)
         {
            return;
         }
         if(this._hero.canMorph())
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(700001);
            $.C("yishi.manager.NotificationManager").instance.sendNotification("ACTION_SKILL_BattleNotic",_loc2_);
            $.C("yzhkof.debug.log")({},"skill:700001, time:" + $.C("flash.utils.getTimer")());
            this._lastClick = _loc3_;
         }
         else if(this._hero.canCancelMorph())
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(700002);
            $.C("yishi.manager.NotificationManager").instance.sendNotification("ACTION_SKILL_BattleNotic",_loc2_);
            $.C("yzhkof.debug.log")({},"skill:700002, time:" + $.C("flash.utils.getTimer")());
            this._lastClick = _loc3_;
         }
         if($.C("battle.BattleManager").getInstance().battleModel.getAutoFightFlag() == 1)
         {
            $.C("battle.BattleManager").getInstance().battleModel.setAutoFight(2);
         }
      }
    onKeyDown(param1) {
         var _loc2_ = null;
         if(param1.keyCode != 32)
         {
            return;
         }
         if(!this._skillEnable)
         {
            return;
         }
         if(!this.isRight)
         {
            return;
         }
         if(this._battleModel.isOver)
         {
            return;
         }
         if(!this._hero)
         {
            return;
         }
         if(this._hero.restricted)
         {
            return;
         }
         if(this._hero.bloodA <= 0)
         {
            return;
         }
         if(!this.buttonMode)
         {
            return;
         }
         if(this.useSkill700001)
         {
            return;
         }
         var _loc3_ = $.C("flash.utils.getTimer")();
         if(_loc3_ - this._lastClick < 3000)
         {
            return;
         }
         if(this._hero.canMorph())
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(700001);
            $.C("yishi.manager.NotificationManager").instance.sendNotification("ACTION_SKILL_BattleNotic",_loc2_);
            $.C("yzhkof.debug.log")({},"skill:700001, time:" + $.C("flash.utils.getTimer")());
            this._lastClick = _loc3_;
            if($.C("battle.BattleManager").getInstance().battleModel.getAutoFightFlag() == 1)
            {
               $.C("battle.BattleManager").getInstance().battleModel.setAutoFight(2);
            }
         }
      }
    __rightFigureOverHandler(param1) {
         if(!this.isRight)
         {
            return;
         }
         if(param1)
         {
            this._isMouseOver = true;
         }
         $.C("flash.ui.Mouse").cursor = "auto";
         if(!this.buttonMode)
         {
            return;
         }
         if(this._isMouseOver)
         {
            this.mouseOver();
         }
      }
    __rightFigureOutHandler(param1) {
         if(!this.isRight)
         {
            return;
         }
         this._isMouseOver = false;
         this.mouseOut();
      }
    __rollOverHandler(param1) {
         if(!this.isRight)
         {
            return;
         }
         this.update();
      }
    mouseOver() {
         $.C("flash.ui.Mouse").cursor = "button";
         this._uifilter.setBuildingOverFilter(this);
      }
    mouseOut() {
         $.C("flash.ui.Mouse").cursor = "auto";
         if(this._hero && !this._hero.isLiving)
         {
            this.filters = [$.C("yishi.filter.UIFilter").getBlackFilter()];
         }
         else
         {
            this.filters = null;
         }
      }
    __onSelfAwakenChangedHandler(param1) {
         this.tweenTo(this._hero.awaken);
      }
    __livingHandler(param1) {
         if(!this._hero.isLiving)
         {
            this.useSkill700001 = false;
            this.useSkill700002 = false;
            this.stopMc();
         }
         this.update();
      }
    __battleEndHandler(param1) {
         this.update();
      }
    __skillEnabeleHandler(param1) {
         var _loc2_ = $.int(param1.data.skillId);
         if(_loc2_ == 700001)
         {
            this.useSkill700001 = false;
            this.update();
         }
         else if(_loc2_ == 700002)
         {
            this.useSkill700002 = false;
            this.update();
         }
      }
    _skillResultHandler(param1) {
         var _loc2_ = $.int(param1.data.skillId);
         var _loc3_ = Boolean(param1.data.result);
         if(!_loc3_)
         {
            if(_loc2_ == 700001 && this.useSkill700001)
            {
               this.useSkill700001 = false;
            }
            else if(_loc2_ == 700002 && this.useSkill700002)
            {
               this.useSkill700002 = false;
            }
         }
         this.update();
      }
    __restrictChangeHandler(param1) {
         this.update();
      }
    updateTo(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = Math.floor(param1 * 100 / 3000);
         this._currentAwaken = param1;
         this.tweenCompleted(param1);
      }
    tweenTo(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(param1 == this._currentAwaken)
         {
            return;
         }
         this._currentAwaken = param1;
         this.killTween();
         if(this._poolLine)
         {
            this._poolLine.visible = true;
         }
         if(this._figureMc)
         {
            _loc2_ = Math.floor(param1 * 100 / 3000);
            this._tween = $.C("com.greensock.TweenMax").to(this._figureMc,0.5,{
               "frame":_loc2_,
               "onUpdate":$.bind(this, "tweenUpdate"),
               "onComplete":$.bind(this, "tweenCompleted"),
               "onCompleteParams":[param1]
            });
         }
         if(param1 == 0)
         {
            this.update();
         }
      }
    killTween() {
         if(this._tween)
         {
            this._tween.kill();
            this._tween = null;
         }
      }
    tweenCompleted(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this.isDie)
         {
            return;
         }
         this.killTween();
         this.refreshMc();
         this.tweenUpdate();
         this.update();
         this.updateTips();
      }
    refreshMc() {
         var _loc1_ = null;
         var _loc3_ = 0;
         if(this.isDie)
         {
            return;
         }
         var _loc6_ = Math.floor(this._currentAwaken * 100 / 3000);
         this._figureMc.gotoAndStop(_loc6_);
         var _loc4_ = this._currentAwaken >= 3000;
         var _loc2_ = $.as(this._figureMc["bg"], $.C("flash.display.MovieClip"));
         _loc2_.visible = _loc4_;
         if(_loc4_)
         {
            _loc2_.play();
         }
         else
         {
            _loc2_.gotoAndStop(1);
         }
         var _loc5_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
         if(_loc5_)
         {
            _loc5_.play();
         }
         if(this._poolLine)
         {
            this._poolLine.play();
         }
         _loc3_ = 1;
         while(_loc3_ < 5)
         {
            if(!this._figureMc["ball" + _loc3_])
            {
               break;
            }
            _loc1_ = $.as(this._figureMc["ball" + _loc3_], $.C("flash.display.MovieClip"));
            _loc1_.visible = _loc4_;
            if(_loc4_)
            {
               _loc1_.play();
            }
            else
            {
               _loc1_.gotoAndStop(1);
            }
            _loc3_++;
         }
         if(this._poolLine)
         {
            if(this._currentAwaken == 0)
            {
               this._poolLine.visible = false;
            }
            else
            {
               this._poolLine.visible = true;
            }
         }
      }
    playMc() {
      }
    updateTips() {
         var _loc1_ = null;
         if(!this._hero || !this._hero.petRoleInfo)
         {
            this.tipData = "";
            return;
         }
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("battle.awaken");
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.colon",_loc1_);
         _loc1_ += this.toArialBold(this._currentAwaken + " / " + 3000);
         if(this.isRight)
         {
            if(this._hero.canCancelMorph())
            {
               _loc1_ += "\n" + $.C("manager.LanguageMgr").GetTranslation("SelfAwakenView.spaceKey2");
            }
            else
            {
               _loc1_ += "\n" + $.C("manager.LanguageMgr").GetTranslation("SelfAwakenView.spaceKey");
            }
         }
         this.tipData = _loc1_;
      }
    toArialBold(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
    tweenUpdate() {
         if(this.isDie)
         {
            return;
         }
         if(this._figureMc && this._poolLine && this._figureMc["pos"])
         {
            this._poolLine.y = this._figureMc.y + this._figureMc["pos"].y;
         }
      }
    updateStateTxtView() {
         this.hideStateView();
         if(this.isRestrict)
         {
            return;
         }
         if(this._hero.canMorph() && !this.useSkill700001)
         {
            this.showAwakenState();
         }
         else if(this._hero.canCancelMorph() && !this.useSkill700002)
         {
            this.showUnAwakenState();
         }
      }
    hideStateView() {
         if(this._awakenBgMc)
         {
            this._awakenBgMc.visible = false;
            this._awakenBgMc.stop();
         }
         if(this._awakenTxtMc)
         {
            this._awakenTxtMc.visible = false;
         }
      }
    showAwakenState() {
         if(!this.isRight)
         {
            return;
         }
         if(this._awakenBgMc)
         {
            this._awakenBgMc.visible = true;
            this._awakenBgMc.play();
         }
         if(this._awakenTxtMc)
         {
            this._awakenTxtMc.visible = true;
            this._awakenTxtMc.setFrame(1);
         }
      }
    showUnAwakenState() {
         if(!this.isRight)
         {
            return;
         }
         if(this._awakenBgMc)
         {
            this._awakenBgMc.visible = false;
            this._awakenBgMc.stop();
         }
         if(this._awakenTxtMc)
         {
            this._awakenTxtMc.visible = true;
            this._awakenTxtMc.setFrame(2);
         }
      }
    enable() {
         this.buttonMode = false;
         this.dark();
         this.mouseOut();
         if(this.isRestrict)
         {
            return;
         }
         var _loc1_ = false;
         if(!this.useSkill700001 && !this.useSkill700002 && (this._hero.canMorph() || Boolean(this._hero.canCancelMorph())))
         {
            _loc1_ = true;
         }
         if(this.isRight && _loc1_)
         {
            this.buttonMode = true;
         }
         if(_loc1_)
         {
            this.light();
            if(this._isMouseOver)
            {
               this.mouseOver();
            }
         }
         if(!this._hero.isLiving)
         {
            this.stopMc();
         }
         else
         {
            this.refreshMc();
         }
      }
    get isRestrict() {
         if(!this._hero)
         {
            return true;
         }
         if(this._hero.restricted || !this._hero.isLiving)
         {
            return true;
         }
         return false;
      }
    get isRight() {
         return this.direction != -1;
      }
    dark() {
         var _loc1_ = this._poolLine;
         if(_loc1_)
         {
            _loc1_.transform.colorTransform = this._darkColor;
         }
         if(this._figureMc && this._figureMc["body"])
         {
            _loc1_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
            _loc1_.transform.colorTransform = this._darkColor;
         }
      }
    light() {
         var _loc1_ = this._poolLine;
         if(_loc1_)
         {
            _loc1_.transform.colorTransform = this._normalColor;
         }
         if(this._figureMc && this._figureMc["body"])
         {
            _loc1_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
            _loc1_.transform.colorTransform = this._normalColor;
         }
      }
    stopMc() {
         var _loc1_ = null;
         var _loc2_ = 0;
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            if(!this._figureMc["ball" + _loc2_])
            {
               break;
            }
            _loc1_ = $.as(this._figureMc["ball" + _loc2_], $.C("flash.display.MovieClip"));
            _loc1_.stop();
            _loc2_++;
         }
         _loc1_ = $.as(this._figureMc["bg"], $.C("flash.display.MovieClip"));
         if(_loc1_)
         {
            _loc1_.stop();
         }
         _loc1_ = $.as(this._figureMc["body"], $.C("flash.display.MovieClip"));
         if(_loc1_)
         {
            _loc1_.stop();
         }
         if(this._poolLine)
         {
            this._poolLine.stop();
         }
         if(this._awakenBgMc)
         {
            this._awakenBgMc.stop();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true);
      }
    get direction() {
         return this._direction;
      }
    set direction(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._direction = param1;
         this._figureContainer.scaleX = param1;
         if(param1 == -1)
         {
            if(this._awakenBgMc)
            {
               this._awakenBgMc.stop();
               this._awakenBgMc.visible = false;
            }
            if(this._awakenTxtMc)
            {
               this._awakenTxtMc.visible = false;
            }
         }
      }
    update() {
         this.enable();
         this.updateStateTxtView();
      }
    get isDragonTalker() {
         return $.C("managers.DragonTalkerManager").instance.model.isDragonTalker;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._figureMc);
         this._figureMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._figureContainer);
         this._figureContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._poolLine);
         this._poolLine = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._awakenBgMc);
         this._awakenBgMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._awakenTxtMc);
         this._awakenTxtMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this.$$_mask);
         this.$$_mask = null;
         this.killTween();
         this._uifilter = null;
         this._battleModel = null;
         this._hero = null;
         this._darkColor = null;
         this._normalColor = null;
         this._tween = null;
         super.dispose();
      }
    set isRestrict(v) { super.isRestrict = v; }
    set isRight(v) { super.isRight = v; }
    set isDragonTalker(v) { super.isDragonTalker = v; }
  }
  $.meta(__SelfAwakenView, "battle.view.bottom.SelfAwakenView", []);
  return __SelfAwakenView;
}
deps["battle.view.bottom.SelfAwakenView"] = ["battle.BattleManager", "com.greensock.TweenMax", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.geom.ColorTransform", "flash.ui.Mouse", "flash.utils.getTimer", "manager.LanguageMgr", "managers.DragonTalkerManager", "yishi.datas.objects.HeroRoleInfo", "yishi.datas.templates.SkillTempInfo", "yishi.filter.SimpleBuildingFilter", "yishi.filter.UIFilter", "yishi.manager.ArmyManager", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager", "yzhkof.debug.log"];

defs["battle.view.bottom.SelfBloodView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __SelfBloodView extends __Base {
    static $fields(self) {
    self._container = null;
    self._heroHpNumContainer = null;
    self._heroHpNumBmd = null;
    self._heroHpNumRect = null;
    self._heroHpValue = 0;
    self._bloodPool = null;
    self._tipView = null;
    self.$$_x = 0;
    self.$$_y = 0;
    }
    constructor(param1, param2 = -338, param3 = -116, param4 = 0) {
         super();
         this._container = param1;
         this.$$_x = param2;
         this.$$_y = param3;
         if(param4 == 1)
         {
            this._heroHpNumRect = new ($.C("flash.geom.Rectangle"))(-239,-12,93,18);
         }
         else
         {
            this._heroHpNumRect = new ($.C("flash.geom.Rectangle"))(-340,-14,88,18);
         }
         this.initView();
         this.addEvent();
      }
    initView() {
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.SelfHpNumAsset");
         this._heroHpNumBmd = _loc4_.bitmapData;
         this._heroHpNumContainer = new ($.C("flash.display.Sprite"))();
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.VesselPoolLineMC");
         _loc3_.alpha = 0.6;
         var _loc2_ = new ($.C("flash.geom.ColorTransform"))(0.7,0,0);
         _loc3_.transform.colorTransform = _loc2_;
         this._bloodPool = new ($.C("battle.view.bottom.VesselBallComp"))(this.battleModel.selfHero.totalBloodA,this.battleModel.selfHero.bloodA,_loc3_);
         this._bloodPool.getView().x = this.$$_x;
         this._bloodPool.getView().y = this.$$_y;
         this._container.addChildAt(this._bloodPool.getView(),0);
         this._tipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.VesselBallTip");
         var _loc1_ = 46.5;
         this._tipView.graphics.beginFill(0,0);
         this._tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         this._tipView.graphics.endFill();
         this._tipView.x = this._bloodPool.getView().x;
         this._tipView.y = this._bloodPool.getView().y;
         this._tipView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottomSelfBloodView.tip");
         this._container.addChild(this._tipView);
      }
    addEvent() {
         this.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
      }
    removeEvent() {
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
      }
    __enterFrame(param1) {
         if(this.battleModel.isChildBattle)
         {
            return;
         }
         var _loc2_ = Number(this.battleModel.getMyHeroLeftHp());
         this.updateHeroHp(_loc2_);
         if(_loc2_ <= 0)
         {
            $.C("battle.BattleManager").getInstance().battleModel.isOver = true;
            $.C("yishi.manager.NotificationManager").instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
    setRotation(param1) {
         if(this._bloodPool)
         {
            this._bloodPool.setRotation(param1);
         }
      }
    showBall(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.BloodPoolBallMC");
         var _loc3_ = new ($.C("yishi.view.tools.SimpleBitmapMovieClip"))($.cast($.C("flash.display.MovieClip"), _loc2_),"asset.battle.BloodPoolBallMC");
         this._bloodPool.showBall(_loc3_,param1);
      }
    updateHeroHp(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._heroHpValue == param1)
         {
            return;
         }
         this._heroHpValue = param1;
         this._bloodPool.max = this.battleModel.selfHero.totalBloodA;
         $.C("yishi.utils.NumberViewUtils").getNumberView(this._heroHpValue,this._heroHpNumContainer,this._heroHpNumBmd,15,16,10,15,"0123456789.",1);
         this.layoutHeroHpNum();
         this._bloodPool.update(this._heroHpValue);
      }
    layoutHeroHpNum() {
         this._heroHpNumContainer.x = this._heroHpNumRect.x + (this._heroHpNumRect.width - this._heroHpNumContainer.width) * 0.5;
         this._heroHpNumContainer.y = this._heroHpNumRect.y - 5;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    get heroHpNumContainer() {
         return this._heroHpNumContainer;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroHpNumBmd);
         this._heroHpNumBmd = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroHpNumContainer);
         this._heroHpNumContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipView);
         this._tipView = null;
         if(this._bloodPool)
         {
            if(this._bloodPool.getView() && this._bloodPool.getView().parent)
            {
               this._bloodPool.getView().parent.removeChild(this._bloodPool.getView());
            }
            this._bloodPool.dispose();
            this._bloodPool = null;
         }
      }
    set battleModel(v) { super.battleModel = v; }
    set heroHpNumContainer(v) { super.heroHpNumContainer = v; }
  }
  $.meta(__SelfBloodView, "battle.view.bottom.SelfBloodView", []);
  return __SelfBloodView;
}
deps["battle.view.bottom.SelfBloodView"] = ["battle.BattleManager", "battle.view.bottom.VesselBallComp", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.geom.ColorTransform", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.manager.NotificationManager", "yishi.utils.NumberViewUtils", "yishi.view.tools.SimpleBitmapMovieClip"];

defs["battle.view.bottom.SelfHitPointView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __SelfHitPointView extends __Base {
    static $fields(self) {
    self._hitPointMc = null;
    self._tipView = null;
    self._heroHitPointValue = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._hitPointMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.HitPointMC");
         this._tipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.HitPointTip");
         this._hitPointMc.gotoAndStop(1);
         this._tipView.graphics.beginFill(0,0);
         this._tipView.graphics.drawRect(0,-5,118,30);
         this._tipView.graphics.endFill();
         this._tipView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.SelfHitPointView.tipView.tipData01") + $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.SelfHitPointView.tipView.tipData02");
         this.addChild(this._hitPointMc);
         this.addChild(this._tipView);
      }
    uninitView() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._hitPointMc);
         this._hitPointMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    addEvent() {
      }
    removeEvent() {
      }
    updateHeroHitPoint(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._heroHitPointValue == param1)
         {
            return;
         }
         this._heroHitPointValue = param1;
         this._hitPointMc.gotoAndStop(this._heroHitPointValue + 1);
      }
    dispose() {
         this.removeEvent();
         this.uninitView();
         super.dispose();
      }
  }
  $.meta(__SelfHitPointView, "battle.view.bottom.SelfHitPointView", []);
  return __SelfHitPointView;
}
deps["battle.view.bottom.SelfHitPointView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr"];

defs["battle.view.bottom.SelfSpView"] = function define($) {
  const __Base = $.Object;
  class __SelfSpView extends __Base {
    static $fields(self) {
    self._container = null;
    self._spMax = 0;
    self._heroSpNumContainer = null;
    self._heroSpNumBmd = null;
    self._heroSpNumRect = null;
    self._heroSpValue = -1;
    self._spPool = null;
    self._tipView = null;
    self.$$_x = 0;
    self.$$_y = 0;
    self.$$_visible = false;
    }
    constructor(param1, param2 = 100, param3 = 246, param4 = -115) {
         super();
         this._container = param1;
         this._spMax = param2;
         this.$$_x = param3;
         this.$$_y = param4;
         this._heroSpNumRect = new ($.C("flash.geom.Rectangle"))(248,-14,88,18);
         this.initView();
      }
    initView() {
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.SelfHpNumAsset");
         this._heroSpNumBmd = _loc3_.bitmapData;
         this._heroSpNumContainer = new ($.C("flash.display.Sprite"))();
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.VesselPoolLineMC");
         _loc2_.alpha = 0.6;
         var _loc4_ = $.int(this.battleModel.selfHero.awaken);
         this._spPool = new ($.C("battle.view.bottom.VesselBallComp"))(this._spMax,_loc4_,_loc2_);
         this._spPool.getView().x = this.$$_x;
         this._spPool.getView().y = this.$$_y;
         this._container.addChildAt(this._spPool.getView(),0);
         this._tipView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.VesselBallTip");
         var _loc1_ = 46.5;
         this._tipView.graphics.beginFill(0,0);
         this._tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         this._tipView.graphics.endFill();
         this._tipView.x = this._spPool.getView().x;
         this._tipView.y = this._spPool.getView().y;
         this._tipView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.SelfSpView.tipView.tipData01") + $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.SelfSpView.tipView.tipData02");
         this._container.addChild(this._tipView);
      }
    setRotation(param1) {
         if(this._spPool)
         {
            this._spPool.setRotation(param1);
         }
      }
    showBall(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.AngerPoolBallMC");
         var _loc3_ = new ($.C("yishi.view.tools.SimpleBitmapMovieClip"))($.cast($.C("flash.display.MovieClip"), _loc2_),"asset.battle.AngerPoolBallMC");
         this._spPool.showBall(_loc3_,param1);
      }
    updateHeroSp(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._heroSpValue == param1)
         {
            return;
         }
         this._heroSpValue = param1;
         $.C("yishi.utils.NumberViewUtils").getNumberView(this._heroSpValue,this._heroSpNumContainer,this._heroSpNumBmd,15,16,10,15,"0123456789.",1);
         this.layoutHeroHpNum();
         this._spPool.update(this._heroSpValue);
      }
    layoutHeroHpNum() {
         this._heroSpNumContainer.x = this._heroSpNumRect.x + (this._heroSpNumRect.width - this._heroSpNumContainer.width) * 0.5;
         this._heroSpNumContainer.y = this._heroSpNumRect.y - 5;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    get visible() {
         return this.$$_visible;
      }
    set visible(param1) {
         this.$$_visible = param1;
         if(this._heroSpNumContainer)
         {
            this._heroSpNumContainer.visible = param1;
         }
         if(this._spPool && this._spPool.getView())
         {
            this._spPool.getView().visible = param1;
         }
         if(this._tipView)
         {
            this._tipView.visible = param1;
         }
      }
    get heroSpNumContainer() {
         return this._heroSpNumContainer;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroSpNumBmd);
         this._heroSpNumBmd = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._heroSpNumContainer);
         this._heroSpNumContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipView);
         this._tipView = null;
         if(this._spPool)
         {
            if(this._spPool.getView() && this._spPool.getView().parent)
            {
               this._spPool.getView().parent.removeChild(this._spPool.getView());
            }
            this._spPool.dispose();
            this._spPool = null;
         }
      }
    set battleModel(v) { super.battleModel = v; }
    set heroSpNumContainer(v) { super.heroSpNumContainer = v; }
  }
  $.meta(__SelfSpView, "battle.view.bottom.SelfSpView", []);
  return __SelfSpView;
}
deps["battle.view.bottom.SelfSpView"] = ["battle.BattleManager", "battle.view.bottom.VesselBallComp", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.utils.NumberViewUtils", "yishi.view.tools.SimpleBitmapMovieClip"];

defs["battle.view.bottom.VesselBallComp"] = function define($) {
  const __Base = $.Object;
  class __VesselBallComp extends __Base {
    static $fields(self) {
    self._max = 0;
    self._curr = 0;
    self._view = null;
    self._container = null;
    self._ball = null;
    self._ballMask = null;
    self._line = null;
    self.$$_mask = null;
    self._tweener = null;
    self._rotationFlag = false;
    }
    constructor(param1, param2, param3) {
         super();
         this._max = param1;
         this._curr = param2;
         this._line = param3;
         this.init();
      }
    init() {
         this._view = new ($.C("flash.display.Sprite"))();
         this._container = new ($.C("flash.display.Sprite"))();
         this._view.addChild(this._container);
         this.$$_mask = this.createMask();
         this._view.addChild(this.$$_mask);
         this._container.mask = this.$$_mask;
         this._container.addChild(this._line);
         this.initLinePos();
      }
    initLinePos() {
         this._line.y = this.calculateY();
         if(this._curr == 0)
         {
            this._line.visible = false;
         }
      }
    createMask() {
         var _loc1_ = 46.5;
         var _loc2_ = new ($.C("flash.display.Shape"))();
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
    update(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._curr == param1)
         {
            return;
         }
         this._curr = param1;
         if(this._curr > 0)
         {
            this._line.visible = true;
         }
         this._tweener = $.C("com.greensock.TweenLite").to(this._line,0.5,{
            "y":this.calculateY(),
            "onUpdate":$.bind(this, "updateBallMask"),
            "onComplete":$.bind(this, "onChangeComplete")
         });
      }
    onChangeComplete() {
         if(this._curr == 0)
         {
            this._line.visible = false;
         }
         if(this._line)
         {
            $.C("com.greensock.TweenLite").killTweensOf(this._line);
         }
      }
    calculateY() {
         var _loc2_ = (this._max - this._curr) / this._max;
         var _loc1_ = 93 * _loc2_;
         if(_loc1_ <= 0)
         {
            _loc1_ = -10;
         }
         if(_loc1_ > 93)
         {
            _loc1_ = 93;
         }
         return _loc1_;
      }
    showBall(param1, param2 = true) {
         if(this._ball)
         {
            this._ball.removeEventListener("enterFrame",$.bind(this, "onEnterFrame"));
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._ball);
         this._ball = null;
         this._ball = param1;
         this._ball.x = 93 * 0.5;
         this._ball.y = 93 * 0.5;
         this._container.addChildAt(this._ball,0);
         this._ballMask = new ($.C("flash.display.Shape"))();
         this._ballMask.graphics.beginFill(0);
         this._ballMask.graphics.drawRect(0,-93,93,93);
         this._ballMask.graphics.endFill();
         this._ballMask.y = 93;
         this._container.addChild(this._ballMask);
         this._ball.mask = this._ballMask;
         if(param2)
         {
            this._ball.addEventListener("enterFrame",$.bind(this, "onEnterFrame"));
         }
         this.updateBallMask();
      }
    setRotation(param1) {
         if(this._ball)
         {
            if(param1)
            {
               this._ball.addEventListener("enterFrame",$.bind(this, "onEnterFrame"));
            }
            else
            {
               this._ball.removeEventListener("enterFrame",$.bind(this, "onEnterFrame"));
            }
         }
      }
    onEnterFrame(param1) {
         this._ball.rotation += 1;
      }
    updateBallMask() {
         if(this._ballMask)
         {
            this._ballMask.height = 93 - this._line.y;
         }
      }
    getView() {
         return this._view;
      }
    set max(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._max = param1;
      }
    dispose() {
         if(this._line)
         {
            $.C("com.greensock.TweenLite").killTweensOf(this._line);
         }
         if(this._ball)
         {
            if($.is(this._ball, $.C("yishi.view.tools.SimpleBitmapMovieClip")))
            {
               $.cast($.C("yishi.view.tools.SimpleBitmapMovieClip"), this._ball).dispose();
            }
            this._ball.removeEventListener("enterFrame",$.bind(this, "onEnterFrame"));
            this._ball = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._ballMask);
         this._ballMask = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.$$_mask);
         this.$$_mask = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._container);
         this._container = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._view);
         this._view = null;
         if(this._tweener)
         {
            this._tweener.kill();
         }
         this._tweener = null;
      }
    get max() { return super.max; }
  }
  $.meta(__VesselBallComp, "battle.view.bottom.VesselBallComp", []);
  $.statics(__VesselBallComp, () => {
    __VesselBallComp.BALL_WIDTH = 93;
  });
  return __VesselBallComp;
}
deps["battle.view.bottom.VesselBallComp"] = ["com.greensock.TweenLite", "com.pickgliss.utils.ObjectUtils", "flash.display.Shape", "flash.display.Sprite", "yishi.view.tools.SimpleBitmapMovieClip"];

defs["battle.view.buffer.BossBufferContainer"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __BossBufferContainer extends __Base {
    static $fields(self) {
    self._immuneBuffer = null;
    self._buffers = null;
    self._permanentBufferList = new $.Vector();
    self._specialBuffers = null;
    self._buffData = null;
    self._bufferViews = [];
    self._direction = 0;
    self._boss = null;
    self._bossImmuneBuffs = [];
    }
    constructor(param1, param2 = -1) {
         super();
         this._buffData = new ($.C("flash.utils.Dictionary"))();
         this._direction = param2;
         this.initEvent(param1);
         this.resetBuffer();
         this.showBuffer();
      }
    initEvent(param1) {
         this._boss = param1;
         if(param1)
         {
            this.showActiveImmuneBuff();
         }
         if(this._boss)
         {
            this._boss.addEventListener("REFRESH_BUFFER",$.bind(this, "__reFreshBuffer"));
         }
         if(this._boss)
         {
            this._boss.addEventListener("isLiving",$.bind(this, "_isLivingHandler"));
         }
      }
    removeEvent() {
         if(this._boss)
         {
            this._boss.removeEventListener("REFRESH_BUFFER",$.bind(this, "__reFreshBuffer"));
         }
         if(this._boss)
         {
            this._boss.removeEventListener("isLiving",$.bind(this, "_isLivingHandler"));
         }
      }
    _isLivingHandler(param1) {
         if(this._boss && this._boss.isLiving == false)
         {
            this._boss.cleanBuffers(false);
         }
         this.reFreshBuffer(null);
      }
    __reFreshBuffer(param1) {
         this.reFreshBuffer($.as(param1.data, $.Vector));
      }
    reFreshBuffer(param1) {
         var _loc3_ = null;
         var _loc2_ = 0;
         this.resetBuffer();
         this._buffers = new $.Vector();
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_].currentTurn > 0)
               {
                  _loc3_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(param1[_loc2_].templateId);
                  if(_loc3_ && _loc3_.Icon && _loc3_.Icon.length > 0)
                  {
                     this._buffers.push(param1[_loc2_]);
                  }
               }
               _loc2_++;
            }
         }
         this.removeChildPreBuffer();
         if(this._boss == null || this._boss.isLiving == false)
         {
            return;
         }
         if(this._buffers && this._buffers.length > 0 || this._immuneBuffer && this._immuneBuffer.length > 0 || this._specialBuffers && this._specialBuffers.length > 0 || this._permanentBufferList && this._permanentBufferList.length > 0)
         {
            this.showBuffer();
         }
      }
    showBuffer() {
         var _loc2_ = null;
         this._bufferViews = [];
         var _loc3_ = 0;
         var _loc1_ = 0;
         if(this._buffers)
         {
            _loc3_ = 0;
            while(_loc3_ < this._buffers.length)
            {
               _loc2_ = this.getBufferViewByDamageData(this._buffers[_loc3_]);
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * this._direction;
               this.addChild(_loc2_);
               this._bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
         if(this._permanentBufferList)
         {
            _loc3_ = 0;
            while(_loc3_ < this._permanentBufferList.length)
            {
               _loc2_ = this.getBufferViewByDamageData(this._permanentBufferList[_loc3_]);
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * this._direction;
               this.addChild(_loc2_);
               this._bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
         if(this._specialBuffers)
         {
            _loc3_ = 0;
            while(_loc3_ < this._specialBuffers.length)
            {
               _loc2_ = this.getBufferViewByTempInfo(this._specialBuffers[_loc3_]);
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * this._direction;
               this.addChild(_loc2_);
               this._bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
         if(this._immuneBuffer)
         {
            _loc3_ = 0;
            while(_loc3_ < this._bossImmuneBuffs.length)
            {
               _loc2_ = $.as(this._bossImmuneBuffs[_loc3_], $.C("battle.view.buffer.BufferIconOnRole"));
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * this._direction;
               this.addChild(_loc2_);
               this._bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
      }
    showActiveImmuneBuff() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._bossImmuneBuffs = [];
         if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(this._boss.heroInfo.templateInfo.RejectType))
         {
            this._immuneBuffer = this._boss.heroInfo.templateInfo.RejectType.split(",");
            if(this._immuneBuffer)
            {
               _loc2_ = 0;
               while(_loc2_ < this._immuneBuffer.length)
               {
                  _loc1_ = this.getImmuneBufferView(this._immuneBuffer[_loc2_]);
                  if(_loc1_)
                  {
                     this._bossImmuneBuffs.push(_loc1_);
                  }
                  _loc2_++;
               }
            }
         }
      }
    removeChildPreBuffer() {
         var _loc1_ = 0;
         var _loc2_ = 0;
         if(this._bufferViews && this._bufferViews.length)
         {
            _loc1_ = $.int(this._bufferViews.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(this._bufferViews[_loc2_].parent)
               {
                  this._bufferViews[_loc2_].parent.removeChild(this._bufferViews[_loc2_]);
               }
               _loc2_++;
            }
         }
      }
    removeAllBuffer() {
         var _loc1_ = 0;
         var _loc2_ = 0;
         if(this._bufferViews && this._bufferViews.length)
         {
            _loc1_ = $.int(this._bufferViews.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bufferViews[_loc2_]);
               this._bufferViews[_loc2_] = null;
               _loc2_++;
            }
            this._bufferViews.length = 0;
         }
      }
    getBufferViewByDamageData(param1) {
         var _loc3_ = null;
         var _loc2_ = this._buffData[param1.bufferUser + "_" + param1.templateId];
         if(_loc2_ == null)
         {
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(param1.templateId);
            _loc2_ = new ($.C("battle.view.buffer.BufferIconOnRole"))(_loc3_.Icon,param1);
            this._buffData[param1.bufferUser + "_" + param1.templateId] = _loc2_;
         }
         _loc2_.buffer = param1;
         _loc2_.refreshTurn();
         return _loc2_;
      }
    getBufferViewByTempInfo(param1) {
         var _loc2_ = this._buffData[param1.Id];
         if(_loc2_ == null)
         {
            _loc2_ = new ($.C("battle.view.buffer.BufferIconOnRole"))(param1.Icon,param1);
            this._buffData[param1.Id] = _loc2_;
         }
         _loc2_.buffer = param1;
         _loc2_.refreshTurn();
         return _loc2_;
      }
    getImmuneBufferView(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc2_ = this._buffData[param1];
         if(_loc2_ == null)
         {
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(param1);
            if(!_loc3_)
            {
               return null;
            }
            _loc2_ = new ($.C("battle.view.buffer.BufferIconOnRole"))(_loc3_.Icon,_loc3_);
            this._buffData[param1] = _loc2_;
         }
         return _loc2_;
      }
    resetBuffer() {
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc1_ = null;
         var _loc2_ = 0;
         if(this._boss != null)
         {
            if($.C("battle.BattleManager").getInstance().battleModel.battleType == 3853)
            {
               _loc4_ = $.C("yishi.manager.BaseManager").instance.wasteBossBufferIdByBoss;
            }
            if(_loc4_ && _loc4_ != "")
            {
               this._specialBuffers = new $.Vector();
               _loc1_ = _loc4_.split(",");
               _loc2_ = 0;
               while(_loc2_ < _loc1_.length)
               {
                  _loc3_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(_loc1_[_loc2_]);
                  if(_loc3_ && _loc3_.Icon && _loc3_.Icon.length > 0)
                  {
                     this._specialBuffers.push(_loc3_);
                  }
                  _loc2_++;
               }
            }
            else
            {
               this._boss.pushPermanentBufferDamageDatas(this._permanentBufferList);
            }
         }
      }
    refreshTurn() {
         var _loc1_ = 0;
         if(this._bufferViews && this._bufferViews.length)
         {
            _loc1_ = 0;
            while(_loc1_ < this._bufferViews.length)
            {
               if(this.contains($.as(this._bufferViews[_loc1_], $.C("battle.view.buffer.BufferIconOnRole"))))
               {
                  ($.as(this._bufferViews[_loc1_], $.C("battle.view.buffer.BufferIconOnRole"))).refreshTurn();
               }
               _loc1_++;
            }
         }
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.x = param1;
      }
    disposeBossInfo(param1) {
         if(!param1 || !this._boss || param1.livingId == this._boss.livingId)
         {
            this.removeEvent();
            this.removeChildPreBuffer();
         }
      }
    dispose() {
         var _loc1_ = 0;
         var _loc2_ = 0;
         this.removeEvent();
         this.removeAllBuffer();
         if(this._buffData)
         {
            for (var _loc3_ of $.values(this._buffData))
            {
               delete this._buffData[_loc3_];
            }
            this._buffData = null;
         }
         this._immuneBuffer = null;
         this._permanentBufferList = null;
         this._specialBuffers = null;
         this._buffers = null;
         if(this._bossImmuneBuffs && this._bossImmuneBuffs.length)
         {
            _loc1_ = $.int(this._bossImmuneBuffs.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bossImmuneBuffs[_loc2_]);
               this._bossImmuneBuffs[_loc2_] = null;
               _loc2_++;
            }
            this._bossImmuneBuffs.length = 0;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    get x() { return super.x; }
  }
  $.meta(__BossBufferContainer, "battle.view.buffer.BossBufferContainer", []);
  return __BossBufferContainer;
}
deps["battle.view.buffer.BossBufferContainer"] = ["battle.BattleManager", "battle.view.buffer.BufferIconOnRole", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.utils.Dictionary", "yishi.manager.BaseManager", "yishi.manager.TempleteManager", "yishi.utils.StringHelper"];

defs["battle.view.buffer.BufferListItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BufferListItem extends __Base {
    static $fields(self) {
    self._data = null;
    self._icon = null;
    self._turnTxt = null;
    self.ITEM_W = 30;
    }
    constructor() {
         super();
         this._icon = new ($.C("yishi.view.community.BaseIconView"))($.bind(this, "loadComplete"));
         this._icon.tipStyle = "battle.view.buffer.BufferListItemTip";
         this.addChild(this._icon);
         this._icon.iconWidth = this.width;
         this._icon.iconHeight = this.height;
         this._turnTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.BufferTurnTxt");
         this.addChild(this._turnTxt);
         this._turnTxt.y = this.height - 20;
      }
    loadComplete(param1 = null) {
         this._icon.content.width = this.width;
         this._icon.content.height = this.height;
      }
    set data(param1) {
         this._data = param1;
         if(this._data)
         {
            this._icon.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(this._data.Icon);
            this.refreshTurn();
         }
      }
    refreshTurn() {
         var _loc1_ = 0;
         if(this._data)
         {
            _loc1_ = $.int(this._data.currentTurn);
            this._turnTxt.text = String(_loc1_);
            this._turnTxt.x = 30 - this._turnTxt.width;
            this._icon.tipData = this._data;
         }
      }
    get data() {
         return this._data;
      }
    get width() {
         return 30;
      }
    get height() {
         return 30;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._turnTxt);
         this._turnTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set width(v) { super.width = v; }
    set height(v) { super.height = v; }
  }
  $.meta(__BufferListItem, "battle.view.buffer.BufferListItem", []);
  return __BufferListItem;
}
deps["battle.view.buffer.BufferListItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.utils.IconFactory", "yishi.view.community.BaseIconView"];

defs["battle.view.buffer.BufferListView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BufferListView extends __Base {
    static $fields(self) {
    self._items = [];
    self._pool = [];
    }
    constructor() {
         super();
         this.addHandler();
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    addHandler() {
         this.battleModel.selfHero.addEventListener("REFRESH_BUFFER",$.bind(this, "__reFreshBuffer"));
      }
    __reFreshBuffer(param1) {
         var _loc2_ = null;
         var _loc4_ = new $.Vector();
         for (var _loc3_ of $.values(param1.data))
         {
            if(_loc3_.currentTurn > 0)
            {
               _loc4_.push(_loc3_);
            }
         }
         this.setData(_loc4_);
         this.refreshView();
      }
    removeBufferData(param1) {
         var _loc4_ = 0;
         var _loc7_ = 0;
         var _loc5_ = null;
         var _loc8_ = null;
         var _loc3_ = false;
         var _loc6_ = this._items.concat([]);
         var _loc2_ = $.int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            _loc3_ = true;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = param1[_loc7_];
               if(_loc5_ && _loc5_.data.templateId == _loc8_.templateId)
               {
                  _loc3_ = false;
                  break;
               }
               _loc7_++;
            }
            if(_loc3_)
            {
               this.removeItemByItem(_loc5_);
               _loc6_[_loc4_] = null;
            }
            _loc4_++;
         }
      }
    addBufferData(param1) {
         var _loc2_ = null;
         var _loc3_ = true;
         for (_loc2_ of $.values(this._items))
         {
            _loc3_ = true;
            if(param1.templateId == _loc2_.data.templateId)
            {
               _loc2_.data = param1;
               _loc3_ = false;
               break;
            }
         }
         if(_loc3_)
         {
            this.addItem(param1);
         }
      }
    __reFreshBufferTurn(param1 = null) {
         var _loc2_ = null;
         var _loc3_ = 0;
         _loc3_ = 0;
         while(_loc3_ < this._items.length)
         {
            _loc2_ = this._items[_loc3_];
            _loc2_.refreshTurn();
            _loc3_++;
         }
      }
    setData(param1) {
         var _loc4_ = 0;
         var _loc6_ = 0;
         var _loc3_ = null;
         this.removeTurnOutItems(param1);
         var _loc2_ = $.int(param1.length);
         var _loc5_ = this._items.concat([]);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               if(param1[_loc4_].templateId == _loc5_[_loc6_].data.templateId)
               {
                  _loc3_ = _loc5_[_loc6_];
                  break;
               }
               _loc6_++;
            }
            if(_loc3_)
            {
               _loc3_.data = param1[_loc4_];
            }
            else
            {
               this.addItem(param1[_loc4_]);
            }
            _loc3_ = null;
            _loc4_++;
         }
      }
    removeTurnOutItems(param1) {
         var _loc4_ = 0;
         var _loc7_ = 0;
         var _loc5_ = null;
         var _loc8_ = null;
         var _loc3_ = false;
         var _loc6_ = this._items.concat([]);
         var _loc2_ = $.int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            _loc3_ = true;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = param1[_loc7_];
               if(_loc5_ && _loc5_.data.templateId == _loc8_.templateId)
               {
                  _loc3_ = false;
                  break;
               }
               _loc7_++;
            }
            if(_loc3_)
            {
               this.removeItem(_loc5_.data);
               _loc6_[_loc4_] = null;
            }
            _loc4_++;
         }
      }
    addItem(param1) {
         var _loc2_ = this._pool.pop();
         if(!_loc2_)
         {
            _loc2_ = new ($.C("battle.view.buffer.BufferListItem"))();
         }
         _loc2_.data = param1;
         this._items.push(_loc2_);
         this.addChild(_loc2_);
      }
    removeItem(param1) {
         var _loc2_ = null;
         var _loc3_ = 0;
         _loc3_ = 0;
         while(_loc3_ < this._items.length)
         {
            _loc2_ = this._items[_loc3_];
            if(_loc2_.data == param1)
            {
               this._items.splice(_loc3_,1);
               this._pool.push(_loc2_);
               this.removeChild(_loc2_);
            }
            _loc3_++;
         }
      }
    removeItemByItem(param1) {
         var _loc2_ = this._items.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._items.splice(_loc2_,1);
            this._pool.push(param1);
            this.removeChild(param1);
         }
      }
    refreshView() {
         var _loc1_ = null;
         var _loc3_ = 0;
         var _loc2_ = 35;
         _loc3_ = 0;
         while(_loc3_ < this._items.length)
         {
            _loc1_ = this._items[_loc3_];
            _loc1_.x = _loc2_ * _loc3_;
            _loc3_++;
         }
      }
    clear() {
         var _loc1_ = null;
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this._items.length)
         {
            _loc1_ = this._items[_loc2_];
            this.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._pool.length)
         {
            _loc1_ = this._items[_loc2_];
            this.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_++;
         }
         this._pool = null;
         this._items = null;
      }
    dispose() {
         this.battleModel.selfHero.removeEventListener("REFRESH_BUFFER",$.bind(this, "__reFreshBuffer"));
         this.clear();
      }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__BufferListView, "battle.view.buffer.BufferListView", []);
  return __BufferListView;
}
deps["battle.view.buffer.BufferListView"] = ["battle.BattleManager", "battle.view.buffer.BufferListItem", "flash.display.Sprite"];

defs["battle.view.map.BattleCameraScene"] = function define($) {
  const __Base = $.C("yishi.view.component.DelayRendSprite");
  class __BattleCameraScene extends __Base {
    static $fields(self) {
    self._cameraX = 500;
    self._cameraY = 300;
    self._preCameraX = 0;
    self._zoom = 1;
    self.childLayerSettingMap = null;
    self._cameraScaleCenterPoint = new ($.C("flash.geom.Point"))(500,600);
    self._sceneWidth = 1000;
    self._sceneHeight = 600;
    }
    constructor() {
         super();
         this.childLayerSettingMap = new ($.C("flash.utils.Dictionary"))();
      }
    addLayerAt(param1, param2, param3 = 1) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number") param3 = Number(param3);
         this.addChildAt(param1,param2);
         this.childLayerSettingMap[param1] = {"moveCoefficient":param3};
      }
    addLayer(param1, param2 = 0) {
         if (typeof param2 !== "number") param2 = Number(param2);
         this.addLayerAt(param1,this.numChildren,param2);
      }
    removeLayer(param1) {
         this.removeChild(param1);
         delete this.childLayerSettingMap[param1];
      }
    get cameraY() {
         return this._cameraY;
      }
    set cameraY(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._cameraY == param1)
         {
            return;
         }
         this._cameraY = param1;
         this.upDateNextRend();
      }
    get cameraX() {
         return this._cameraX;
      }
    set cameraX(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._cameraX == param1)
         {
            return;
         }
         this._cameraX = param1;
         this.upDateNextRend();
      }
    get zoom() {
         return this._zoom;
      }
    set zoom(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if(this._zoom == param1)
         {
            return;
         }
         this._zoom = param1;
         this.upDateNextRend();
      }
    get cameraScaleCenterPoint() {
         return this._cameraScaleCenterPoint;
      }
    set cameraScaleCenterPoint(param1) {
         this._cameraScaleCenterPoint = param1;
         this.upDateNextRend();
      }
    onDraw() {
         var _loc2_ = NaN;
         this.updateCenterPoint();
         this._preCameraX = this.cameraX;
         for(var _loc3_ in this.childLayerSettingMap)
         {
            _loc2_ = Number(this.childLayerSettingMap[_loc3_].moveCoefficient);
            _loc3_.x = -(this._cameraX - this._cameraScaleCenterPoint.x) * _loc2_;
         }
         var _loc1_ = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this.width) / 2 >> 0;
         this.scaleX = this._zoom;
         this.scaleY = this._zoom;
         this.y = -(this._cameraY * this._zoom - this._cameraScaleCenterPoint.y * 0.5);
         this.x = -(750 - this._cameraScaleCenterPoint.x);
      }
    stopMovingAllMembers() {
         for(var _loc1_ in this.childLayerSettingMap)
         {
            this.childLayerSettingMap[_loc1_].moveCoefficient = 0;
            if($.is(_loc1_, $.C("battle.view.map.RepeatBackGroundLayer")))
            {
               $.cast($.C("battle.view.map.RepeatBackGroundLayer"), _loc1_).moveSpeed = 0;
            }
         }
      }
    playMovingAllMembers() {
         for(var _loc1_ in this.childLayerSettingMap)
         {
            if($.is(_loc1_, $.C("battle.view.map.RepeatBackGroundLayer")))
            {
               this.childLayerSettingMap[_loc1_].moveCoefficient = $.cast($.C("battle.view.map.RepeatBackGroundLayer"), _loc1_).getParaData().moveCoefficient;
               if($.is(_loc1_, $.C("battle.view.map.RepeatBackGroundLayer")))
               {
                  $.cast($.C("battle.view.map.RepeatBackGroundLayer"), _loc1_).moveSpeed = $.cast($.C("battle.view.map.RepeatBackGroundLayer"), _loc1_).getParaData().moveSpeed;
               }
            }
         }
      }
    get preCameraX() {
         return this._preCameraX;
      }
    get sceneWidth() {
         return this._sceneWidth;
      }
    set sceneWidth(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._sceneWidth == param1)
         {
            return;
         }
         this._sceneWidth = param1;
         this.upDateNextRend();
      }
    get sceneHeight() {
         return this._sceneHeight;
      }
    set sceneHeight(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._sceneHeight == param1)
         {
            return;
         }
         this._sceneHeight = param1;
         this.upDateNextRend();
      }
    updateCenterPoint() {
         this._cameraScaleCenterPoint.x = this._sceneWidth / 2;
         this._cameraScaleCenterPoint.y = this._sceneHeight;
      }
    dispose() {
         this.childLayerSettingMap = null;
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
    set preCameraX(v) { super.preCameraX = v; }
  }
  $.meta(__BattleCameraScene, "battle.view.map.BattleCameraScene", ["Disposeable"]);
  return __BattleCameraScene;
}
deps["battle.view.map.BattleCameraScene"] = ["battle.view.map.RepeatBackGroundLayer", "com.pickgliss.toplevel.StageReferance", "flash.geom.Point", "flash.utils.Dictionary", "yishi.view.component.DelayRendSprite"];

defs["battle.view.map.BattleMap"] = function define($) {
  const __Base = $.C("battle.view.map.BattleCameraScene");
  class __BattleMap extends __Base {
    static $fields(self) {
    self._animationManager = null;
    self._rolesContainer = null;
    self._roleBackContainer = null;
    self._profoundContainer = null;
    self._rolesDict = null;
    self._effectContainer = null;
    self._layerColorTransform = null;
    self._cameraTarget = null;
    self._offsetX = 0;
    self._offsetY = 0;
    self._moveCameraTween = null;
    self._revertTimeoutId = 0;
    self.shake = null;
    self._physics = new ($.C("flash.utils.Dictionary"))(true);
    }
    constructor() {
         super();
         this._rolesContainer = new ($.C("flash.display.Sprite"))();
         this._roleBackContainer = new ($.C("battle.skillsys.effect.EffectContainer"))();
         this._roleBackContainer.mouseChildren = this._roleBackContainer.mouseEnabled = false;
         this._effectContainer = new ($.C("battle.skillsys.effect.EffectContainer"))();
         this._effectContainer.mouseChildren = this._effectContainer.mouseEnabled = false;
         this._profoundContainer = new ($.C("flash.display.Sprite"))();
         this.addLayer(this._roleBackContainer);
         this.addLayer(this._profoundContainer);
         this.addLayer(this._rolesContainer);
         this.addLayer(this._effectContainer);
         this._rolesDict = new ($.C("flash.utils.Dictionary"))(true);
         this._layerColorTransform = new ($.C("flash.geom.ColorTransform"))();
         this._animationManager = new ($.C("battle.animation.AnimationManager"))(this,1000,600);
      }
    backGroundToColor(param1 = 0, param2 = 0.3, param3 = 0.5, param4 = false, param5 = false) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         if (typeof param2 !== "number") param2 = Number(param2);
         if (typeof param3 !== "number") param3 = Number(param3);
         var element;
         var color = param1;
         var easeInOutTime = param2;
         var stopTime = param3;
         var now = param4;
         var reversColor = param5;
         var tweenLayers = [];
         var a = reversColor ? -1 : 1;
         var rOff = ((color & 0xFF0000) >>> 16) * a;
         var gOff = ((color & 0xFF00) >>> 8) * a;
         var bOff = (color & 0xFF) * a;
         var updateFun = () =>
         {
            for (var _loc1_ of $.values(tweenLayers))
            {
               _loc1_.transform.colorTransform = this._layerColorTransform;
            }
         };
         for(element in this.childLayerSettingMap)
         {
            if(element != this._effectContainer && element != this._rolesContainer && element != this._profoundContainer)
            {
               tweenLayers.push(element);
            }
         }
         if(!now)
         {
            $.C("com.greensock.TweenLite").killTweensOf(this._layerColorTransform);
            $.C("com.greensock.TweenLite").to(this._layerColorTransform,easeInOutTime,{
               "redOffset":rOff,
               "greenOffset":gOff,
               "blueOffset":bOff,
               "onUpdate":updateFun
            });
            $.C("com.greensock.TweenLite").to(this._layerColorTransform,easeInOutTime,{
               "redOffset":0,
               "greenOffset":0,
               "blueOffset":0,
               "delay":easeInOutTime + stopTime,
               "overwrite":0,
               "onUpdate":updateFun
            });
         }
         else
         {
            this._layerColorTransform.redOffset = rOff;
            this._layerColorTransform.greenOffset = gOff;
            this._layerColorTransform.blueOffset = bOff;
            updateFun();
         }
      }
    backGroundToColorUseFrames(param1, param2, param3, param4, param5 = false) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var element;
         var updateFun;
         var a;
         var rOff;
         var gOff;
         var bOff;
         var color = param1;
         var easeInFrame = param2;
         var easeOutFrame = param3;
         var endFrame = param4;
         var reversColor = param5;
         var tweenLayers = [];
         for(element in this.childLayerSettingMap)
         {
            if(element != this._effectContainer && element != this._rolesContainer && element != this._profoundContainer)
            {
               tweenLayers.push(element);
            }
         }
         updateFun = () =>
         {
            for (var _loc1_ of $.values(tweenLayers))
            {
               _loc1_.transform.colorTransform = this._layerColorTransform;
            }
         };
         a = reversColor ? -1 : 1;
         rOff = ((color & 0xFF0000) >>> 16) * a;
         gOff = ((color & 0xFF00) >>> 8) * a;
         bOff = (color & 0xFF) * a;
         $.C("com.greensock.TweenLite").to(this._layerColorTransform,easeInFrame,{
            "useFrames":true,
            "redOffset":rOff,
            "greenOffset":gOff,
            "blueOffset":bOff,
            "onUpdate":updateFun
         });
         $.C("com.greensock.TweenLite").to(this._layerColorTransform,endFrame - easeOutFrame,{
            "useFrames":true,
            "delay":easeOutFrame,
            "redOffset":0,
            "greenOffset":0,
            "blueOffset":0,
            "overwrite":0,
            "onUpdate":updateFun
         });
      }
    backGroundToColor2(param1, param2) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = null;
         var _loc4_ = [];
         _loc4_ = _loc4_.concat([param1,0,0,0,0]);
         _loc4_ = _loc4_.concat([0,param1,0,0,0]);
         _loc4_ = _loc4_.concat([0,0,param1,0,0]);
         _loc4_ = _loc4_.concat([0,0,0,1,0]);
         _loc3_ = new ($.C("flash.filters.ColorMatrixFilter"))(_loc4_);
         for(var _loc5_ in this.childLayerSettingMap)
         {
            if(_loc5_ != this._effectContainer && _loc5_ != this._rolesContainer)
            {
               _loc5_.filters = [_loc3_];
            }
         }
         $.C("flash.utils.clearTimeout")(this._revertTimeoutId);
         $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "revertBackGroundColor"),param2);
      }
    revertBackGroundColor() {
         $.C("flash.utils.clearTimeout")(this._revertTimeoutId);
         for(var _loc1_ in this.childLayerSettingMap)
         {
            if(_loc1_ != this._effectContainer && _loc1_ != this._rolesContainer)
            {
               _loc1_.filters = null;
            }
         }
      }
    set cameraTarget(param1) {
         this._cameraTarget = param1;
      }
    get cameraTarget() {
         return this._cameraTarget;
      }
    get rolesDict() {
         return this._rolesDict;
      }
    get animationManager() {
         return this._animationManager;
      }
    addAnimation(param1) {
         this._animationManager.addAnimation(param1);
      }
    update() {
         if(this._animationManager)
         {
            this._animationManager.update();
         }
         if(this._cameraTarget == null)
         {
            return;
         }
         var _loc2_ = this._cameraTarget();
         var _loc3_ = _loc2_.x + this._offsetX;
         var _loc1_ = _loc3_ - this.cameraX;
         if(Math.abs(_loc1_) < 20)
         {
            this.cameraX = _loc3_;
         }
         else
         {
            this.cameraX += _loc1_ / Math.abs(_loc1_) * 20;
         }
      }
    addRole(param1) {
      }
    toScenePoint(param1) {
         return this.effectContainer.globalToLocal(param1.parent.localToGlobal(new ($.C("flash.geom.Point"))(param1.x,param1.y)));
      }
    removeRole(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
      }
    moveCamera(param1, param2 = 0.5, param3 = 0) {
         if (typeof param2 !== "number") param2 = Number(param2);
         if (typeof param3 !== "number") param3 = Number(param3);
         var _loc4_ = new ($.C("flash.geom.Point"))(this.cameraX + param1.x,this.cameraY + param1.y);
         return this.setCamera(_loc4_,param2,param3);
      }
    setCamera(param1, param2 = 0.5, param3 = 0) {
         if (typeof param2 !== "number") param2 = Number(param2);
         if (typeof param3 !== "number") param3 = Number(param3);
         this._moveCameraTween = $.C("com.greensock.TweenMax").to(this,param2,{
            "cameraX":param1.x,
            "cameraY":param1.y,
            "overwrite":2,
            "delay":param3
         });
         return this._moveCameraTween;
      }
    shakeScreen(param1 = 5, param2 = 7) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(this.shake)
         {
            this.shake.stop();
         }
         this.shake = new ($.C("yishi.utils.Shaker"))(this,param1,param2);
      }
    addPhysics(param1) {
         this._physics[param1] = param1;
      }
    removePhysics(param1) {
         delete this._physics[param1];
      }
    get effectContainer() {
         return this._effectContainer;
      }
    set effectContainer(param1) {
         this._effectContainer = param1;
      }
    get roleBackContainer() {
         return this._roleBackContainer;
      }
    getProfoundLayer() {
         return this._profoundContainer;
      }
    $$addEffect(param1, param2 = 1, param3 = 1) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if(!$.C("yishi.manager.SharedManager").instance.allowAttactedEffect)
         {
            return;
         }
         if(param3 == 1)
         {
            this._effectContainer.addEffect(param1,param2);
         }
         else
         {
            this._roleBackContainer.addEffect(param1,param2);
         }
      }
    get rolesContainer() {
         return this._rolesContainer;
      }
    addSkillAimFlag(param1) {
         var _loc3_ = null;
         for (var _loc2_ of $.values(param1))
         {
            _loc3_ = this.rolesDict[_loc2_];
            if(_loc3_)
            {
               _loc3_.addSkillAimFlag();
            }
         }
      }
    dispose() {
         for (var _loc1_ of $.values(this._rolesDict))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
            _loc1_ = null;
         }
         this._rolesDict = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rolesContainer);
         this._rolesContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._effectContainer);
         this._effectContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._roleBackContainer);
         this._roleBackContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profoundContainer);
         this._profoundContainer = null;
         this._animationManager = null;
         this._cameraTarget = null;
         super.dispose();
      }
    set rolesDict(v) { super.rolesDict = v; }
    set animationManager(v) { super.animationManager = v; }
    set roleBackContainer(v) { super.roleBackContainer = v; }
    set rolesContainer(v) { super.rolesContainer = v; }
  }
  $.meta(__BattleMap, "battle.view.map.BattleMap", []);
  return __BattleMap;
}
deps["battle.view.map.BattleMap"] = ["battle.animation.AnimationManager", "battle.skillsys.effect.EffectContainer", "battle.view.map.BattleCameraScene", "com.greensock.TweenLite", "com.greensock.TweenMax", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.filters.ColorMatrixFilter", "flash.geom.ColorTransform", "flash.geom.Point", "flash.utils.Dictionary", "flash.utils.clearTimeout", "yishi.manager.SharedManager", "yishi.utils.Shaker", "yishi.utils.TimerUtils"];

defs["battle.view.map.BattleMapView"] = function define($) {
  const __Base = $.C("battle.view.map.BattleMap");
  class __BattleMapView extends __Base {
    static $fields(self) {
    self._mapData = null;
    self._battleModel = null;
    self._gasEffectContainer = null;
    self._mapLayers = new $.Vector();
    self._sceneEffectLayers = new $.Vector();
    self.dieRoleInfoArr = null;
    }
    constructor(param1) {
         super();
         this._battleModel = param1;
         this._gasEffectContainer = new ($.C("battle.skillsys.effect.EffectContainer"))();
         this._gasEffectContainer.mouseChildren = this._gasEffectContainer.mouseEnabled = false;
         $.C("yishi.manager.NotificationManager").instance.addEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
         param1.addEventListener("BATTLE_OTHER_LIVING_VISIBLE",$.bind(this, "__otherLivingVisibleHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4680,$.bind(this, "clearDiedRole"));
      }
    onSceneEffecCloseHandler(param1) {
         if($.C("yishi.manager.SharedManager").instance.allowSceneEffect)
         {
            this.showSceneEffect();
         }
         else
         {
            this.removeSceneEffect();
         }
      }
    __otherLivingVisibleHandler(param1) {
         var _loc2_ = param1.data ? 1 : -1;
         for (var _loc3_ of $.values(this._rolesDict))
         {
            if(!this.ifSelfLiving(_loc3_.info))
            {
               if(!_loc3_.info.startload)
               {
                  _loc3_.info.load();
               }
               else
               {
                  _loc3_.displayMode(_loc2_);
               }
            }
         }
      }
    ifSelfLiving(param1) {
         var _loc2_ = $.int($.C("battle.BattleManager").getInstance().battleModel.selfHero.userId);
         if($.is(param1, $.C("yishi.datas.objects.HeroRoleInfo")))
         {
            if(($.as(param1, $.C("yishi.datas.objects.HeroRoleInfo"))).heroInfo.userId && param1.face == 2)
            {
               return false;
            }
            return _loc2_ == ($.as(param1, $.C("yishi.datas.objects.HeroRoleInfo"))).heroInfo.userId;
         }
         if($.is(param1, $.C("yishi.datas.objects.PawnRoleInfo")))
         {
            return 1 == ($.as(param1, $.C("yishi.datas.objects.PawnRoleInfo"))).face;
         }
         if($.is(param1, $.C("yishi.datas.objects.PetRoleInfo")))
         {
            if(_loc2_ == ($.as(param1, $.C("yishi.datas.objects.PetRoleInfo"))).userId && param1.face == 2)
            {
               return false;
            }
            return _loc2_ == ($.as(param1, $.C("yishi.datas.objects.PetRoleInfo"))).userId;
         }
         if($.is(param1, $.C("yishi.datas.objects.GoddessRoleInfo")))
         {
            return _loc2_ == ($.as(param1, $.C("yishi.datas.objects.GoddessRoleInfo"))).userId;
         }
         return false;
      }
    update() {
         super.update();
         if($.is($.C("com.pickgliss.toplevel.StageReferance").stage.focus, $.C("flash.text.TextField")) && $.cast($.C("flash.text.TextField"), $.C("com.pickgliss.toplevel.StageReferance").stage.focus).type == "input")
         {
            if(!$.C("flash.system.IME").enabled)
            {
               $.C("yishi.manager.IMEManager").enable();
            }
         }
         else if($.C("flash.system.IME").enabled)
         {
            $.C("yishi.manager.IMEManager").disable();
         }
         $.C("battle.utils.BattleUtils").ManagerDepth(this._rolesContainer);
         for (var _loc1_ of $.values(this._rolesDict))
         {
            _loc1_.updateShadowPos();
         }
         var _loc2_ = $.C("battle.BattleManager").getInstance().battleModel.roleList;
         for (var _loc3_ of $.values(_loc2_))
         {
            _loc3_.update();
         }
      }
    addRole(param1) {
         var _loc2_ = $.cast($.C("battle.view.roles.RoleViewBase"), param1).info;
         this.removeRole(_loc2_.livingId);
         this._rolesContainer.addChild(param1);
         this._rolesDict[_loc2_.livingId] = param1;
         _loc2_.addEventListener("die",$.bind(this, "onRoleDie"),false,0,true);
      }
    revierBoss(param1) {
         var _loc2_ = $.cast($.C("battle.view.roles.RoleViewBase"), param1).info;
         this._rolesContainer.addChild(param1);
         _loc2_.addEventListener("die",$.bind(this, "onRoleDie"),false,0,true);
      }
    onRoleDie(param1) {
         var _loc4_ = $.as(param1.target, $.C("yishi.datas.objects.RoleInfo"));
         _loc4_.removeEventListener("die",$.bind(this, "onRoleDie"));
         if(!this._rolesDict)
         {
            return;
         }
         var _loc2_ = this._rolesDict[_loc4_.livingId];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.clearEffectWhenDie();
         var _loc3_ = __BattleMapView.REVIVE_BATTLE_TYPE.indexOf($.C("battle.BattleManager").getInstance().battleModel.battleType) >= 0;
         if($.is(_loc4_, $.C("yishi.datas.objects.HeroRoleInfo")) && $.cast($.C("yishi.datas.objects.HeroRoleInfo"), _loc4_).type != 3 && $.cast($.C("yishi.datas.objects.HeroRoleInfo"), _loc4_).type != 7 && $.cast($.C("yishi.datas.objects.HeroRoleInfo"), _loc4_).type != 8)
         {
            _loc2_.setBloodStripVisible(false,true);
         }
         else if($.is(_loc4_, $.C("yishi.datas.objects.HeroRoleInfo")) && $.cast($.C("yishi.datas.objects.HeroRoleInfo"), _loc4_).type == 3 && _loc3_)
         {
            _loc4_.action("Die");
            _loc2_.setBloodStripVisible(false,false);
            _loc2_.parent.removeChild(_loc2_);
         }
         else if(!($.is(_loc4_, $.C("yishi.datas.objects.PetRoleInfo"))))
         {
            this.removeRole(_loc4_.livingId);
            $.C("battle.BattleManager").getInstance().battleModel.removeRole(_loc4_);
         }
      }
    clearDiedRole(param1) {
         var battleType;
         var pkg;
         var msg;
         var length;
         var userInfo;
         var i;
         var role;
         var event = param1;
         if($.C("battle.BattleManager").getInstance().battleModel == null)
         {
            return;
         }
         battleType = $.int($.C("battle.BattleManager").getInstance().battleModel.battleType);
         if(!(battleType == 295 || battleType == 3854 || battleType == 3911))
         {
            return;
         }
         pkg = $.as(event.data, $.C("yishi.comm.PackageIn"));
         msg = new ($.C("com.road.yishi.proto.battle.LivingCleanMsg"))();
         msg = $.as(pkg.readBody(msg), $.C("com.road.yishi.proto.battle.LivingCleanMsg"));
         length = $.int(msg.livingInfos.length);
         i = 0;
         while(i < length)
         {
            userInfo = msg.livingInfos[i];
            role = this._rolesDict[userInfo.living];
            if(role && $.is(role.info, $.C("yishi.datas.objects.HeroRoleInfo")))
            {
               if($.cast($.C("yishi.datas.objects.HeroRoleInfo"), role.info).userId == $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.userInfo.userId)
               {
                  if(battleType != 3911)
                  {
                     $.C("battle.BattleManager").selfDie = true;
                     $.C("yishi.utils.TimerUtils").setTimeout(() =>
                     {
                        if(!$.C("battle.BattleManager").isExitingBattle)
                        {
                           $.C("battle.BattleManager").onFightCanceled();
                        }
                     },1500);
                     break;
                  }
                  if(this.dieRoleInfoArr == null)
                  {
                     this.dieRoleInfoArr = new $.Vector();
                  }
                  this.dieRoleInfoArr.push($.cast($.C("yishi.datas.objects.HeroRoleInfo"), role.info));
               }
               else if(role && $.cast($.C("yishi.datas.objects.HeroRoleInfo"), role.info).userId != $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.userInfo.userId)
               {
                  if(this.dieRoleInfoArr == null)
                  {
                     this.dieRoleInfoArr = new $.Vector();
                  }
                  this.dieRoleInfoArr.push($.cast($.C("yishi.datas.objects.HeroRoleInfo"), role.info));
               }
            }
            else if(role && $.is(role.info, $.C("yishi.datas.objects.PetRoleInfo")))
            {
            }
            i = i + 1;
         }
         $.C("yishi.utils.TimerUtils").setTimeout(() =>
         {
            var _loc1_ = null;
            var _loc2_ = null;
            var _loc3_ = 0;
            while(this.dieRoleInfoArr && this.dieRoleInfoArr.length > 0)
            {
               if($.C("battle.BattleManager").selfDie)
               {
                  return;
               }
               _loc1_ = this.dieRoleInfoArr.pop();
               _loc3_ = $.int(_loc1_.petLivingId);
               $.C("battle.BattleManager").getInstance().battleMap.removeRole(_loc1_.livingId);
               $.C("battle.BattleManager").getInstance().battleModel.removeHeroAndPet(_loc1_.livingId);
               $.C("battle.BattleManager").getInstance().battleMap.removeRole(_loc3_);
               $.C("battle.BattleManager").getInstance().battleModel.removeHeroAndPet(_loc3_);
               _loc2_ = $.C("battle.BattleManager").getInstance().battleModel.getChildInfoByLivingId(_loc1_.livingId);
               if(_loc2_)
               {
                  $.C("battle.BattleManager").getInstance().battleMap.removeRole(_loc2_.livingId);
                  $.C("battle.BattleManager").getInstance().battleModel.removeHeroAndPet(_loc2_.livingId);
               }
               $.C("battle.BattleManager").getInstance().battleUIView.removeDieRole(_loc1_.userId);
            }
         },1500);
      }
    removeRole(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = $.as(this._rolesDict[param1], $.C("battle.view.roles.RoleViewBase"));
         if(_loc2_)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc2_.dispose();
         }
         delete this._rolesDict[param1];
      }
    addPhysics(param1) {
         this._physics[param1] = param1;
         if($.is(param1, $.C("flash.display.DisplayObject")))
         {
            this.effectContainer.addChild($.as(param1, $.C("flash.display.DisplayObject")));
         }
      }
    removePhysics(param1) {
         delete this._physics[param1];
         if($.is(param1, $.C("flash.display.DisplayObject")))
         {
            ($.as(param1, $.C("flash.display.DisplayObject"))).parent.removeChild($.as(param1, $.C("flash.display.DisplayObject")));
         }
         param1 = null;
      }
    changeMap(param1, param2 = "asset") {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc3_ = null;
         var _loc5_ = 0;
         var _loc7_ = null;
         var _loc6_ = null;
         var _loc4_ = null;
         this._mapData = param1;
         _loc5_ = 0;
         while(_loc5_ < param1.bg_back_arr.length)
         {
            _loc3_ = $.cast($.C("battle.data.BattleBackGroundData"), param1.bg_back_arr[_loc5_]);
            if(_loc3_.repeat)
            {
               _loc7_ = new ($.C("battle.view.map.RepeatBackGroundLayer"))(_loc3_[param2],_loc3_.normalAsset,_loc3_.transparent);
               _loc7_.moveSpeed = _loc3_.moveSpeed;
               _loc7_.mouseChildren = _loc7_.mouseEnabled = false;
               this.addLayerAt(_loc7_,_loc5_,_loc3_.moveCoefficient);
               _loc7_.setParaData(_loc3_);
               this._mapLayers.push(_loc7_);
            }
            else if($.C("yishi.manager.SharedManager").instance.allowSceneEffect)
            {
               _loc6_ = new ($.C("battle.view.map.RepeatBackGroundLayer"))(_loc3_[param2]);
               _loc6_.mouseChildren = _loc6_.mouseEnabled = false;
               this.addLayerAt(_loc6_,_loc5_,_loc3_.moveCoefficient);
               this._mapLayers.push(_loc6_);
               this._sceneEffectLayers.push(_loc6_);
               _loc6_.setParaData(_loc3_);
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.bg_front_arr.length)
         {
            _loc3_ = $.cast($.C("battle.data.BattleBackGroundData"), param1.bg_front_arr[_loc5_]);
            if(_loc3_.repeat)
            {
               _loc4_ = new ($.C("battle.view.map.RepeatBackGroundLayer"))(_loc3_[param2],_loc3_.normalAsset,_loc3_.transparent);
               _loc4_.mouseEnabled = _loc4_.mouseChildren = false;
               this.addLayer(_loc4_,_loc3_.moveCoefficient);
               this._mapLayers.push(_loc4_);
               _loc4_.setParaData(_loc3_);
            }
            else if($.C("yishi.manager.SharedManager").instance.allowSceneEffect)
            {
               _loc4_ = new ($.C("battle.view.map.RepeatBackGroundLayer"))(_loc3_[param2]);
               _loc4_.mouseEnabled = _loc4_.mouseChildren = false;
               this.addLayer(_loc4_,_loc3_.moveCoefficient);
               this._mapLayers.push(_loc4_);
               this._sceneEffectLayers.push(_loc4_);
               _loc4_.setParaData(_loc3_);
            }
            _loc5_++;
         }
         this.addLayer(this._gasEffectContainer);
         if(!$.C("yishi.manager.SharedManager").instance.allowSceneEffect)
         {
            this.stopMovingAllMembers();
         }
         this.draw();
      }
    removeSceneEffect() {
         var _loc1_ = 0;
         if(this._sceneEffectLayers)
         {
            for (var _loc2_ of $.values(this._sceneEffectLayers))
            {
               _loc2_.visible = false;
            }
         }
         this.stopMovingAllMembers();
      }
    showSceneEffect() {
         var _loc1_ = 0;
         if(this._sceneEffectLayers)
         {
            for (var _loc2_ of $.values(this._sceneEffectLayers))
            {
               _loc2_.visible = true;
            }
         }
         this.playMovingAllMembers();
      }
    addGasEffect(param1, param2 = 1) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var effect = param1;
         var repeat = param2;
         var gasEnd = () =>
         {
            this.blendMode = "normal";
            this._gasEffectContainer.blendMode = "normal";
         };
         if(!$.C("yishi.manager.SharedManager").instance.allowAttactedEffect)
         {
            return;
         }
         this.blendMode = "layer";
         this._gasEffectContainer.blendMode = "erase";
         $.C("yishi.manager.NotificationManager").instance.sendNotification("REFRESH_BACK_BITMAP");
         this._gasEffectContainer.addEffect(effect,repeat);
         effect.callBackComplete.addListener(gasEnd);
      }
    dispose() {
         if(this.dieRoleInfoArr != null)
         {
            this.dieRoleInfoArr = null;
         }
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("sceneEffectClose",$.bind(this, "onSceneEffecCloseHandler"));
         if(this._battleModel)
         {
            this._battleModel.removeEventListener("BATTLE_OTHER_LIVING_VISIBLE",$.bind(this, "__otherLivingVisibleHandler"));
         }
         this._battleModel = null;
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4680,$.bind(this, "clearDiedRole"));
         for (var _loc1_ of $.values(this._mapLayers))
         {
            if($.is(_loc1_, $.C("battle.view.map.RepeatBackGroundLayer")))
            {
               $.cast($.C("battle.view.map.RepeatBackGroundLayer"), _loc1_).dispose();
            }
         }
         if(this._mapLayers)
         {
            this._mapLayers.length = 0;
         }
         this._mapLayers = null;
         if(this._mapData)
         {
            this._mapData.dispose();
            this._mapData = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._gasEffectContainer);
         this._gasEffectContainer = null;
         while(this._sceneEffectLayers && this._sceneEffectLayers.length > 0)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sceneEffectLayers.pop());
         }
         this._sceneEffectLayers = null;
         super.dispose();
      }
  }
  $.meta(__BattleMapView, "battle.view.map.BattleMapView", []);
  $.statics(__BattleMapView, () => {
    __BattleMapView.REVIVE_BATTLE_TYPE = [310,311];
  });
  return __BattleMapView;
}
deps["battle.view.map.BattleMapView"] = ["battle.BattleManager", "battle.data.BattleBackGroundData", "battle.skillsys.effect.EffectContainer", "battle.utils.BattleUtils", "battle.view.map.BattleMap", "battle.view.map.RepeatBackGroundLayer", "battle.view.roles.RoleViewBase", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.utils.ObjectUtils", "com.road.yishi.proto.battle.LivingCleanMsg", "flash.display.DisplayObject", "flash.system.IME", "flash.text.TextField", "yishi.comm.PackageIn", "yishi.datas.objects.GoddessRoleInfo", "yishi.datas.objects.HeroRoleInfo", "yishi.datas.objects.PawnRoleInfo", "yishi.datas.objects.PetRoleInfo", "yishi.datas.objects.RoleInfo", "yishi.manager.IMEManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.SharedManager", "yishi.service.managers.SocketManager", "yishi.utils.TimerUtils"];

defs["battle.view.map.RepeatBackGroundLayer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RepeatBackGroundLayer extends __Base {
    static $fields(self) {
    self._bitmapdata = null;
    self.$$_x = 0;
    self._xOffset = 0;
    self._moveSpeed = 0;
    self._shape = null;
    self._matrix = null;
    self._bitmap = null;
    self._asset = null;
    self._inited = false;
    self._transparent = false;
    self.timeOutId = 0;
    self._groundData = null;
    }
    constructor(param1, param2 = null, param3 = true) {
         super();
         this._asset = param1;
         this._transparent = param3;
         this.addChild(this._asset);
      }
    init() {
         this._bitmapdata = this.drawBitmap();
         this._shape = new ($.C("flash.display.Shape"))();
         this._shape.y = this._asset.y;
         this.addChild(this._shape);
         this._matrix = new ($.C("flash.geom.Matrix"))();
         this.refreshView();
      }
    getBitmap() {
         return new ($.C("flash.display.Bitmap"))(this._bitmapdata,"auto",false);
      }
    drawBitmap() {
         if(!this._bitmapdata)
         {
            this._bitmapdata = new ($.C("flash.display.BitmapData"))(1500,this._asset.height,this._transparent,0);
            this._bitmapdata.draw(this._asset,new ($.C("flash.geom.Matrix"))(1,0,0,1,this._asset.x));
         }
         return this._bitmapdata;
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if(this.$$_x == param1)
         {
            return;
         }
         this.$$_x = param1;
         this.refreshView();
      }
    get x() {
         return this.$$_x;
      }
    refreshView() {
         if(!this._bitmapdata)
         {
            return;
         }
         var _loc1_ = (this.x + this._xOffset) % 1500;
         this._matrix.tx = _loc1_;
         this._shape.graphics.clear();
         this._shape.graphics.beginBitmapFill(this._bitmapdata,this._matrix);
         this._shape.graphics.drawRect(0,0,this._bitmapdata.width,this._bitmapdata.height);
         this._shape.graphics.endFill();
      }
    get moveSpeed() {
         return this._moveSpeed;
      }
    set moveSpeed(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._moveSpeed = param1;
         if(param1 != 0)
         {
            $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
            if(!this._inited)
            {
               this.timeOutId = $.C("flash.utils.setTimeout")($.bind(this, "delayInitBmd"),1750);
               this._inited = true;
            }
         }
         else
         {
            $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
         }
      }
    delayInitBmd() {
         $.C("flash.utils.clearTimeout")(this.timeOutId);
         this.timeOutId = 0;
         if(this._asset)
         {
            this.init();
            this.removeChild(this._asset);
            this._asset = null;
         }
      }
    setParaData(param1) {
         this._groundData = param1;
      }
    getParaData() {
         return this._groundData;
      }
    enterFrame() {
         if(!this._bitmapdata)
         {
            return;
         }
         this._xOffset += this.moveSpeed;
         this.refreshView();
      }
    __enterFrame(param1) {
         this._xOffset += this.moveSpeed;
         this.refreshView();
      }
    dispose() {
         this.moveSpeed = 0;
         if(this._bitmapdata)
         {
            this._bitmapdata.dispose();
            this._bitmapdata = null;
         }
         if(this._bitmap)
         {
            if(this._bitmap.parent)
            {
               this.removeChild(this._bitmap);
            }
            this._bitmap.bitmapData.dispose();
            this._bitmap = null;
         }
         if(this._shape)
         {
            if(this._shape.parent)
            {
               this._shape.parent.removeChild(this._shape);
            }
            this._shape.graphics.clear();
            this._shape = null;
         }
         if(this._asset)
         {
            if(this._asset.parent)
            {
               this._asset.parent.removeChild(this._asset);
            }
         }
         this._asset = null;
      }
  }
  $.meta(__RepeatBackGroundLayer, "battle.view.map.RepeatBackGroundLayer", ["IEnterFrame"]);
  return __RepeatBackGroundLayer;
}
deps["battle.view.map.RepeatBackGroundLayer"] = ["flash.display.Bitmap", "flash.display.BitmapData", "flash.display.Shape", "flash.display.Sprite", "flash.geom.Matrix", "flash.utils.clearTimeout", "flash.utils.setTimeout", "yishi.manager.EnterFrameManager"];

defs["battle.view.reinforce.ReinforceWaveBall"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __ReinforceWaveBall extends __Base {
    static $fields(self) {
    self._mc = null;
    self._removeFun = null;
    self._tipInfo = null;
    self._back = null;
    }
    constructor(param1, param2 = "", param3 = 0) {
         $.pre(new.target, (__s) => {
         __s._removeFun = param1;
         __s._tipInfo = param2;
         if(__s.battleModel.battleType == 3886)
         {
            __s._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.EastReinforceFlagBg");
            __s._mc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.EastReinforceMC" + param3);
            __s._back.x = -19;
            __s._back.y = -15;
         }
         else
         {
            __s._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.ReinforceFlagBg");
            __s._mc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.ReinforceMC");
            __s._back.x = -49;
            __s._back.y = -30;
         }
         __s.addChild(__s._back);
         __s._mc.addFrameScript(__s._mc.totalFrames - 1,$.bind(__s, "lastFrameFun"));
         __s.addChild(__s._mc);
         });
         super();
         $.preFlush(this, new.target);
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.tipData = this._tipInfo;
         this.isFollowMouse = false;
         this.tipDirctions = "3,6,7";
         this.tipGapV = 10;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    lastFrameFun() {
         this._mc.stop();
         if(this._mc.parent)
         {
            this._mc.parent.removeChild(this._mc);
         }
         if(this._back)
         {
            this._back.visible = false;
         }
      }
    exit() {
         this._mc.gotoAndPlay("exit");
      }
    dispose() {
         if(this._mc)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mc);
         }
         this._mc = null;
         if(this._back)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         }
         this._back = null;
         this._removeFun = null;
         super.dispose();
      }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__ReinforceWaveBall, "battle.view.reinforce.ReinforceWaveBall", []);
  return __ReinforceWaveBall;
}
deps["battle.view.reinforce.ReinforceWaveBall"] = ["battle.BattleManager", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils"];

defs["battle.view.reinforce.ReinforceWavePane"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __ReinforceWavePane extends __Base {
    static $fields(self) {
    self._totalWave = 0;
    self._currentWave = 0;
    self._top = 0;
    self._right = 0;
    self._balls = null;
    self._gap = 90;
    self._eastGap = 80;
    self._tf = $.as($.C("com.pickgliss.ui.ComponentFactory").Instance.creat("battle.WaveNumTxt"), $.C("com.pickgliss.ui.text.FilterFrameText"));
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s._tf.text = $.C("manager.LanguageMgr").GetTranslation("battle.view.reinforce.ReinforceWavePane.tf.text");
         __s.addChild(__s._tf);
         });
         super();
         $.preFlush(this, new.target);
      }
    setTotalWave(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._totalWave = param1;
         if(this.battleModel.battleType == 3886)
         {
            this.createEastBalls();
         }
         else
         {
            this.createBalls();
         }
      }
    createEastBalls() {
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc3_ = 0;
         this._balls = new $.Vector();
         _loc3_ = 1;
         while(_loc3_ < this._totalWave)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("battle.view.reinforce.ReinforceWavePane.tipInfo") + (_loc3_ + 1);
            _loc1_ = new ($.C("battle.view.reinforce.ReinforceWaveBall"))($.bind(this, "removeBallCallback"),_loc2_,_loc3_);
            _loc1_.x = (_loc3_ - 1) * this._eastGap;
            _loc1_.y = this._tf.y + this._tf.textHeight + 20;
            this.addChild(_loc1_);
            this._balls.push(_loc1_);
            _loc3_++;
         }
         if(this._balls.length > 0)
         {
            this._tf.x = this._balls[0].x;
         }
      }
    createBalls() {
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc3_ = 0;
         this._balls = new $.Vector();
         _loc3_ = 1;
         while(_loc3_ < this._totalWave)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("battle.view.reinforce.ReinforceWavePane.tipInfo") + (_loc3_ + 1);
            _loc1_ = new ($.C("battle.view.reinforce.ReinforceWaveBall"))($.bind(this, "removeBallCallback"),_loc2_);
            _loc1_.x = -(this._totalWave - _loc3_ - 1) * this._gap;
            this.addChild(_loc1_);
            this._balls.push(_loc1_);
            _loc3_++;
         }
         if(this._balls.length > 0)
         {
            this._tf.x = this._balls[0].x - this._tf.textWidth - 80;
         }
      }
    removeBallCallback(param1) {
         this.removeChild(param1);
         param1.dispose();
      }
    setCurrentWave(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc4_ = null;
         this._currentWave = param1;
         if(this._balls.length > 0 && this._currentWave > 1 && this._balls.length <= this._totalWave - this._currentWave)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("battle.view.reinforce.ReinforceWavePane.str");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("battle.view.reinforce.ReinforceWavePane.str2");
            $.C("logging.LoggerSys").info("@@@***" + _loc2_ + "=" + this._totalWave + _loc4_ + "=" + this._currentWave + ";*********@@@");
         }
         while(this._balls.length > 0 && this._balls.length > this._totalWave - this._currentWave)
         {
            _loc3_ = this._balls.shift();
            if(_loc3_)
            {
               _loc3_.exit();
               if(this.battleModel.battleType == 3886)
               {
                  this._tf.x += this._eastGap - 60;
               }
               else
               {
                  this._tf.x += this._gap;
               }
            }
         }
         if(this._totalWave < this._currentWave)
         {
            while(this._balls.length)
            {
               _loc3_ = this._balls.shift();
               if(_loc3_)
               {
                  _loc3_.exit();
               }
            }
         }
         if(this._balls.length == 0 || this._totalWave < this._currentWave)
         {
            if(this._tf)
            {
               this._tf.visible = false;
            }
         }
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    showNextWave() {
         this._currentWave = this._currentWave + 1;
         this.setCurrentWave(this._currentWave);
      }
    isLastBall() {
         if(this._totalWave - this._currentWave == 1)
         {
            return true;
         }
         return false;
      }
    set top(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._top = param1;
      }
    get top() {
         return this._top;
      }
    set right(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._right = param1;
      }
    get right() {
         return this._right;
      }
    dispose() {
         if(this._tf)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tf);
         }
         this._tf = null;
         for (var _loc1_ of $.values(this._balls))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
            _loc1_ = null;
         }
         this._balls.length = 0;
         this._balls = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__ReinforceWavePane, "battle.view.reinforce.ReinforceWavePane", []);
  return __ReinforceWavePane;
}
deps["battle.view.reinforce.ReinforceWavePane"] = ["battle.BattleManager", "battle.view.reinforce.ReinforceWaveBall", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.ui.text.FilterFrameText", "com.pickgliss.utils.ObjectUtils", "logging.LoggerSys", "manager.LanguageMgr"];

defs["battle.view.roles.QuickenHeroMovieClip"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __QuickenHeroMovieClip extends __Base {
    static $fields(self) {
    self._quickenHandler = null;
    }
    constructor(param1) {
         super();
         this._quickenHandler = new ($.C("yishi.view.tools.QuickenMovieClip"))(param1,false);
         if($.C("battle.BattleManager").getInstance().quickenControl)
         {
            $.C("battle.BattleManager").getInstance().quickenControl.register(this);
         }
         this.addChild(param1);
      }
    setSpeed(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._quickenHandler.step = param1;
      }
    getHeroMovieClip() {
         return $.as(this._quickenHandler.getMC(), $.C("yishi.view.tools.HeroMovieClip"));
      }
    play() {
         this._quickenHandler.play();
      }
    stop() {
         this._quickenHandler.stop();
      }
    gotoAndPlay(param1, param2 = null) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         this._quickenHandler.gotoAndPlay(param1);
      }
    gotoAndStop(param1, param2 = null) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         this._quickenHandler.gotoAndStop(param1);
      }
    get totalFrames() {
         return this._quickenHandler.totalFrames;
      }
    get currentFrame() {
         return this._quickenHandler.currentFrame;
      }
    get currentLabels() {
         return this.getHeroMovieClip().currentLabels;
      }
    get currentLabel() {
         return this.getHeroMovieClip().currentLabel;
      }
    get currentFrameLabel() {
         return this.getHeroMovieClip().currentFrameLabel;
      }
    addFrameScript(... rest) {
         this._quickenHandler.addFrameScript(rest[0] + 1,rest[1]);
      }
    dispose() {
         if($.C("battle.BattleManager").getInstance().quickenControl)
         {
            $.C("battle.BattleManager").getInstance().quickenControl.unregister(this);
         }
         this._quickenHandler.dispose();
         this._quickenHandler = null;
      }
    set totalFrames(v) { super.totalFrames = v; }
    set currentFrame(v) { super.currentFrame = v; }
    set currentLabels(v) { super.currentLabels = v; }
    set currentLabel(v) { super.currentLabel = v; }
    set currentFrameLabel(v) { super.currentFrameLabel = v; }
  }
  $.meta(__QuickenHeroMovieClip, "battle.view.roles.QuickenHeroMovieClip", ["IQuickenEffect"]);
  return __QuickenHeroMovieClip;
}
deps["battle.view.roles.QuickenHeroMovieClip"] = ["battle.BattleManager", "flash.display.MovieClip", "yishi.view.tools.HeroMovieClip", "yishi.view.tools.QuickenMovieClip"];

defs["battle.view.skillname.SkillNameContainer"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __SkillNameContainer extends __Base {
    static $fields(self) {
    self._currentView = null;
    self._removeId = 0;
    }
    constructor() {
         super();
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SHOW_SKILL_NAME_BattleNotic",$.bind(this, "showSkill"));
      }
    showSkill(param1) {
         if(this._currentView)
         {
            this.removeView();
         }
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(param1.data);
         if(_loc2_)
         {
            this._currentView = new ($.C("battle.view.skillname.SkillNameView"))(_loc2_.SonType);
            this._currentView.x = -this._currentView.width * 0.5;
            this.addChild(this._currentView);
         }
      }
    removeView() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentView);
         this._currentView = null;
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SHOW_SKILL_NAME_BattleNotic",$.bind(this, "showSkill"));
      }
    dispose() {
         this.removeEvent();
         this.removeView();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__SkillNameContainer, "battle.view.skillname.SkillNameContainer", []);
  return __SkillNameContainer;
}
deps["battle.view.skillname.SkillNameContainer"] = ["battle.view.skillname.SkillNameView", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager"];

defs["battle.view.skillname.SkillNameView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __SkillNameView extends __Base {
    static $fields(self) {
    self._back = null;
    self._name = null;
    self._pos = 49;
    self._nameMaxW = 294;
    self._bgMaxW = 390;
    self._skillNameMC = null;
    }
    constructor(param1) {
         var _loc2_ = null;
         $.pre(new.target, (__s) => {
         __s._name = $.C("battle.BattleManager").getInstance().resourceModel.getSkillName(param1);
         if(__s._name)
         {
            __s._name.x = (__s._nameMaxW - __s._name.width) * 0.5;
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.SkillNameBg");
            __s._back = new ($.C("org.bytearray.display.ScaleBitmap"))(_loc2_.bitmapData);
            __s._back.scale9Grid = new ($.C("flash.geom.Rectangle"))(40,10,80,10);
            __s._back.width = __s._name.width + __s._pos * 2;
            __s._back.x = (__s._bgMaxW - __s._back.width) * 0.5;
            __s._back.y = 8;
            __s._skillNameMC = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.SkillNameMC");
            __s._skillNameMC.owner = __s;
            __s._skillNameMC.addFrameScript(__s._skillNameMC.totalFrames - 1,$.bind(__s, "endFrameFun"));
            __s.addChild(__s._skillNameMC);
            _loc2_.bitmapData = null;
            _loc2_ = null;
         }
         });
         super();
         $.preFlush(this, new.target);
      }
    endFrameFun() {
         if(this._name)
         {
            if(this._name.parent)
            {
               this._name.parent.removeChild(this._name);
            }
            this._name = null;
         }
         if(this._skillNameMC)
         {
            this._skillNameMC.owner = null;
            this._skillNameMC.addFrameScript(this._skillNameMC.totalFrames - 1,null);
            this._skillNameMC.stop();
            if(this._skillNameMC.parent)
            {
               this._skillNameMC.parent.removeChild(this._skillNameMC);
            }
            this._skillNameMC = null;
         }
         if(this._back)
         {
            this._back.dispose();
            this._back = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    showBG(param1) {
         param1.addChild(this._back);
      }
    showName(param1) {
         param1.addChild(this._name);
      }
    get width() {
         return this._bgMaxW;
      }
    dispose() {
         this.endFrameFun();
      }
    set width(v) { super.width = v; }
  }
  $.meta(__SkillNameView, "battle.view.skillname.SkillNameView", []);
  return __SkillNameView;
}
deps["battle.view.skillname.SkillNameView"] = ["battle.BattleManager", "com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "flash.geom.Rectangle", "org.bytearray.display.ScaleBitmap"];

defs["battle.view.ui.AttackModeView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __AttackModeView extends __Base {
    static $fields(self) {
    self._attackBtn = null;
    self._defenseBtn = null;
    self._currentBtn = null;
    self._coolDownTxt = null;
    self._coldDownPic = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._attackBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.AttackBtn");
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.attack1");
         this._attackBtn.modeName = _loc1_;
         this._defenseBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.DefenseBtn");
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("battle.view.ui.AttackModeView.defenseBtnModeName");
         this._defenseBtn.modeName = _loc2_;
         this._coolDownTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.CoolDownTimeTxt");
         this._coldDownPic = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.ColdDownButton");
         this._attackBtn.setKeyValue("Z");
         this._attackBtn.tipData = [$.C("manager.LanguageMgr").GetTranslation("battle.view.ui.AttackModeView.attackBtn.tipData01") + $.C("manager.LanguageMgr").GetTranslation("public.parentheses2","Z"),$.C("manager.LanguageMgr").GetTranslation("battle.view.ui.AttackModeView.attackBtn.tipData02")];
         this._defenseBtn.setKeyValue("X");
         this._defenseBtn.tipData = [$.C("manager.LanguageMgr").GetTranslation("battle.view.ui.AttackModeView.defenseBtn.tipData01") + $.C("manager.LanguageMgr").GetTranslation("public.parentheses2","X"),$.C("manager.LanguageMgr").GetTranslation("battle.view.ui.AttackModeView.defenseBtn.tipData02")];
         this.addChild(this._attackBtn);
         this.addChild(this._defenseBtn);
         this.addChild(this._coolDownTxt);
         this.addChild(this._coldDownPic);
         this._coldDownPic.visible = false;
         this._coolDownTxt.visible = false;
         if(!this.visible || !this.battleModel.selfHero.isLiving)
         {
            this._attackBtn.enable = this._defenseBtn.enable = false;
         }
      }
    uninit() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._attackBtn);
         this._attackBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._defenseBtn);
         this._defenseBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._coolDownTxt);
         this._coolDownTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._coldDownPic);
         this._coldDownPic = null;
      }
    addEvent() {
         this._attackBtn.addEventListener("click",$.bind(this, "__onAttackModelChange"));
         this._defenseBtn.addEventListener("click",$.bind(this, "__onAttackModelChange"));
         this.battleModel.addEventListener("actionCountChange",$.bind(this, "onActionCountChange"));
         $.C("org.aswing.KeyboardManager").getInstance().addEventListener("keyDown",$.bind(this, "onKeyDown"));
         $.C("battle.BattleManager").getInstance().battleModel.selfHero.addEventListener("die",$.bind(this, "onHeroDieEvent"));
      }
    onHeroDieEvent(param1) {
         param1.target.removeEventListener("die",$.bind(this, "onHeroDieEvent"));
         this._attackBtn.enable = this._defenseBtn.enable = false;
      }
    onKeyDown(param1) {
         if(!this._attackBtn.enable)
         {
            return;
         }
         if(param1.charCode == 122)
         {
            this.setMode(2);
         }
         else if(param1.charCode == 120)
         {
            this.setMode(1);
         }
      }
    removeEvent() {
         this._attackBtn.removeEventListener("click",$.bind(this, "__onAttackModelChange"));
         this._defenseBtn.removeEventListener("click",$.bind(this, "__onAttackModelChange"));
         this.battleModel.removeEventListener("actionCountChange",$.bind(this, "onActionCountChange"));
         $.C("org.aswing.KeyboardManager").getInstance().removeEventListener("keyDown",$.bind(this, "onKeyDown"));
         $.C("battle.BattleManager").getInstance().battleModel.selfHero.removeEventListener("die",$.bind(this, "onHeroDieEvent"));
      }
    __onAttackModelChange(param1) {
         var _loc2_ = 0;
         if(this._currentBtn == param1.currentTarget)
         {
            return;
         }
         this._currentBtn = $.as(param1.currentTarget, $.C("battle.view.ui.attackmode.AttackModeButton"));
         switch(param1.currentTarget)
         {
            case this._attackBtn:
               _loc2_ = 2;
               break;
            case this._defenseBtn:
               _loc2_ = 1;
         }
         this.setMode(_loc2_);
      }
    setMode(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this.visible || !this.battleModel.selfHero.isLiving)
         {
            return;
         }
         if(this.battleModel.isAutoFight)
         {
            return;
         }
         this.battleModel.setAttackModelById(this.battleModel.selfHero.livingId,param1);
         var _loc2_ = this.battleModel.battleId;
         this.battleModel.actionCount = 0;
         this.battleModel.attackModeStart = true;
         this.updateCdValue(0);
         $.C("battle.net.BattleSocketOuterManager").sendFightMode(_loc2_,param1);
         this._defenseBtn.enable = false;
         this._attackBtn.enable = false;
         if(param1 == 2)
         {
            this._attackBtn.selected = true;
            this._defenseBtn.visible = false;
         }
         else
         {
            this._defenseBtn.selected = true;
            this._attackBtn.visible = false;
         }
         $.C("yishi.manager.NotificationManager").instance.sendNotification("battleModeChange",param1);
      }
    onActionCountChange(param1) {
         this.updateCdValue(this.battleModel.actionCount);
      }
    updateCdValue(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(param1 > 1 && param1 < 7)
         {
            this._defenseBtn.visible = this._attackBtn.visible = false;
            this._coldDownPic.visible = true;
            this._coolDownTxt.visible = true;
            this._coolDownTxt.text = $.C("manager.LanguageMgr").GetTranslation("battle.view.ui.AttackModeView.coolDownTxt.text") + (7 - param1);
         }
         else if(param1 < 2)
         {
            _loc2_ = 7 - 5 - param1;
            this._attackBtn.setTurnValue(_loc2_);
            this._defenseBtn.setTurnValue(_loc2_);
         }
         if(param1 == 7)
         {
            this.coolDownComplete();
         }
      }
    coolDownComplete() {
         this._defenseBtn.enable = this._defenseBtn.visible = true;
         this._attackBtn.enable = this._attackBtn.visible = true;
         this._defenseBtn.selected = false;
         this._attackBtn.selected = false;
         this._coldDownPic.visible = false;
         this._coolDownTxt.visible = false;
         this._currentBtn = null;
         this.battleModel.attackModeStart = false;
         this.battleModel.setAttackModelById(this.battleModel.selfHero.livingId,0);
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    getLeftPoint() {
         return new ($.C("flash.geom.Point"))(this._attackBtn.x,this._attackBtn.y);
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__AttackModeView, "battle.view.ui.AttackModeView", ["Disposeable"]);
  $.statics(__AttackModeView, () => {
    __AttackModeView.CD_TIME = 7;
  });
  return __AttackModeView;
}
deps["battle.view.ui.AttackModeView"] = ["battle.BattleManager", "battle.net.BattleSocketOuterManager", "battle.view.ui.attackmode.AttackModeButton", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Point", "manager.LanguageMgr", "org.aswing.KeyboardManager", "yishi.manager.NotificationManager"];

defs["battle.view.ui.BatterUIView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BatterUIView extends __Base {
    static $fields(self) {
    self.batterNum = null;
    self.damageNum = null;
    self._batterAsset = null;
    self._damageAsset = null;
    self._damageMatrix = null;
    self._shake = null;
    self._batterDestX = NaN;
    self._damageDestX = NaN;
    self._exiting = false;
    }
    constructor() {
         super();
         this.init();
         this.addEvent();
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SET_BATTER_COUNT_BattleNotic",$.bind(this, "setBatterCount"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SET_TOTAL_DAMAGE_BattleNotic",$.bind(this, "__setTotalDamage"));
      }
    __setTotalDamage(param1) {
         if(this._exiting)
         {
            return;
         }
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.TotalDamageNumberAssetSp");
         _loc2_["txt"].text = String(param1.data);
         _loc2_["txt"].width = _loc2_["txt"].textWidth + 50;
         this.damageNum.addChild(_loc2_);
         this.damageNum.x = -this.damageNum.width;
      }
    setBatterCount(param1) {
         if(this._exiting)
         {
            return;
         }
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.TotalDamageNumberAssetSp");
         _loc2_["txt"].text = String(param1.data);
         _loc2_["txt"].width = _loc2_["txt"].textWidth + 50;
         this.batterNum.addChild(_loc2_);
         this.batterNum.scaleY = this.batterNum.scaleX = 1;
         this.batterNum.x = -this.batterNum.width;
         this.batterNum.y = 0;
         $.C("com.greensock.TweenLite").from(this.batterNum,0.2,{
            "scaleX":2,
            "scaleY":2
         });
         this._shake.shake();
      }
    init() {
         this._damageAsset = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.battle.DamageUIAsset");
         this._damageDestX = this._damageAsset.x;
         this.addChild(this._damageAsset);
         this._batterAsset = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.battle.BatterUIAsset");
         this._batterDestX = this._batterAsset.x;
         this.addChild(this._batterAsset);
         this._damageAsset.y = this._batterAsset.height + 15;
         this.batterNum = new ($.C("flash.display.Sprite"))();
         this.batterNum.mouseChildren = this.batterNum.mouseEnabled = false;
         this.damageNum = new ($.C("flash.display.Sprite"))();
         this.damageNum.mouseChildren = this.damageNum.mouseEnabled = false;
         this._batterAsset.batter_num_pos.addChild(this.batterNum);
         this._damageAsset.total_num_pos.addChild(this.damageNum);
         this._damageMatrix = this._damageAsset.transform.matrix;
         this._shake = new ($.C("yishi.utils.ShakeCircle"))(this._batterAsset.batterMC,3,5);
      }
    show() {
         this.reset();
         this._damageAsset.transform.matrix = this._damageMatrix;
         this._damageAsset.alpha = 1;
         $.C("com.greensock.TweenLite").from(this._damageAsset,0.7,{
            "alpha":0,
            "x":"-100"
         });
         this._batterAsset.animate.gotoAndPlay(1);
      }
    reset() {
         this._batterAsset.alpha = 1;
         this._batterAsset.x = this._batterDestX;
         this._damageAsset.alpha = 1;
         this._damageAsset.x = this._damageDestX;
         $.C("com.greensock.TweenLite").killTweensOf(this._batterAsset);
         $.C("com.greensock.TweenLite").killTweensOf(this._damageAsset);
         this._exiting = false;
      }
    hide() {
         $.C("com.greensock.TweenLite").to(this._batterAsset,0.4,{
            "alpha":0,
            "x":this._batterDestX + 96,
            "onComplete":$.bind(this, "onExitComplete")
         });
         $.C("com.greensock.TweenLite").to(this._damageAsset,0.4,{
            "alpha":0,
            "x":this._damageDestX - 96
         });
         this._exiting = true;
      }
    onExitComplete() {
         this._exiting = false;
      }
    dispose() {
         this.removeEvent();
         if(this._damageAsset)
         {
            $.C("com.greensock.TweenLite").killTweensOf(this._damageAsset);
         }
         if(this._batterAsset)
         {
            $.C("com.greensock.TweenLite").killTweensOf(this._batterAsset);
         }
         if(this.batterNum)
         {
            $.C("com.greensock.TweenLite").killTweensOf(this.batterNum);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this.batterNum);
         this.batterNum = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this.damageNum);
         this.damageNum = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._batterAsset);
         this._batterAsset = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._damageAsset);
         this._damageAsset = null;
         if(this._shake)
         {
            this._shake.stop();
         }
         this._shake = null;
         this._damageMatrix = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SET_BATTER_COUNT_BattleNotic",$.bind(this, "setBatterCount"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SET_TOTAL_DAMAGE_BattleNotic",$.bind(this, "__setTotalDamage"));
      }
  }
  $.meta(__BatterUIView, "battle.view.ui.BatterUIView", []);
  $.statics(__BatterUIView, () => {
    __BatterUIView.EXIT_DISTANCE = 96;
  });
  return __BatterUIView;
}
deps["battle.view.ui.BatterUIView"] = ["com.greensock.TweenLite", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ClassUtils", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.NotificationManager", "yishi.utils.ShakeCircle"];

defs["battle.view.ui.BattleGoddessMovieView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __BattleGoddessMovieView extends __Base {
    static $fields(self) {
    self._leftContiner = null;
    self._rightContiner = null;
    self.leftMcList = null;
    self.rightMcList = null;
    self.preLeftTime = 0;
    self.preRightTime = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._leftContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleGoddessMovieView.leftContiner");
         this._rightContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleGoddessMovieView.rightContiner");
         this.addChild(this._leftContiner);
         this.addChild(this._rightContiner);
         this.mouseChildren = this.mouseEnabled = false;
         this._leftContiner.x = $.C("battle.utils.BattleUtils").rolePointByPos(4,1).x - 370;
         this._leftContiner.y = $.C("com.pickgliss.toplevel.StageReferance").stageHeight / 2 - 280;
         this._rightContiner.x = $.C("battle.utils.BattleUtils").rolePointByPos(4,2).x - 180;
         this._rightContiner.y = $.C("com.pickgliss.toplevel.StageReferance").stageHeight / 2 - 280;
      }
    addEvent() {
         if(this.battleModel)
         {
            this.battleModel.addEventListener("BATTLE_OTHER_LIVING_VISIBLE",$.bind(this, "__visibleChangeHandler"));
         }
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
      }
    removeEvent() {
         if(this.battleModel)
         {
            this.battleModel.removeEventListener("BATTLE_OTHER_LIVING_VISIBLE",$.bind(this, "__visibleChangeHandler"));
         }
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
      }
    __visibleChangeHandler(param1) {
         this.removeShowMc();
      }
    removeShowMc() {
         this.leftMcList = [];
         this.rightMcList = [];
         this.preLeftTime = 0;
         this.preRightTime = 0;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._leftContiner);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._rightContiner);
      }
    setViewData(param1) {
         var _loc2_ = null;
         this.removeShowMc();
         var _loc3_ = [];
         var _loc5_ = [];
         for (var _loc4_ of $.values(param1))
         {
            _loc2_ = $.as(this.battleModel.getRoleById(_loc4_.livingId), $.C("yishi.datas.objects.GoddessRoleInfo"));
            if(_loc2_)
            {
               if(!this.battleModel.isHideOtherInBattle(_loc2_))
               {
                  if(_loc2_.face == 1)
                  {
                     _loc3_.push(_loc2_);
                  }
                  else if(_loc2_.face == 2)
                  {
                     _loc5_.push(_loc2_);
                  }
               }
            }
         }
         _loc3_.sortOn("pos",16);
         _loc5_.sortOn("pos",16);
         if(_loc3_.length > 0)
         {
            this.refreshMcView(_loc3_,this.leftMcList);
         }
         if(_loc5_.length > 0)
         {
            this.refreshMcView(_loc5_,this.rightMcList);
         }
      }
    refreshMcView(param1, param2) {
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc3_ = null;
         if(!this.resourceModel)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            _loc3_ = $.as(this.resourceModel.getOrCreateInstanse("asset.goddess.skill" + _loc5_.template.Type), $.C("flash.display.MovieClip"));
            _loc3_.gotoAndStop(1);
            param2.push(_loc3_);
            _loc4_++;
         }
      }
    enterFrame() {
         this.enterFrameMc(this.leftMcList,this._leftContiner,true);
         this.enterFrameMc(this.rightMcList,this._rightContiner,false);
      }
    enterFrameMc(param1, param2, param3) {
         var goddessMc;
         var mcList = param1;
         var mcContiner = param2;
         var isLeft = param3;
         var curTime = isLeft ? this.preLeftTime : this.preRightTime;
         if(mcList.length > 0 && $.C("flash.utils.getTimer")() - curTime >= 800)
         {
            goddessMc = $.as(mcList.shift(), $.C("flash.display.MovieClip"));
            goddessMc.addFrameScript(goddessMc.totalFrames - 1,() =>
            {
               this.resourceModel.recyleInstanse(goddessMc);
            });
            mcContiner.addChild(goddessMc);
            goddessMc.gotoAndPlay(1);
            isLeft ? (this.preLeftTime = $.C("flash.utils.getTimer")()) : (this.preRightTime = $.C("flash.utils.getTimer")());
         }
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    get resourceModel() {
         return $.C("battle.BattleManager").getInstance().resourceModel;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftContiner);
         this._leftContiner = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightContiner);
         this._rightContiner = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.leftMcList);
         this.leftMcList = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.rightMcList);
         this.rightMcList = null;
         super.dispose();
      }
    set battleModel(v) { super.battleModel = v; }
    set resourceModel(v) { super.resourceModel = v; }
  }
  $.meta(__BattleGoddessMovieView, "battle.view.ui.BattleGoddessMovieView", ["IEnterFrame"]);
  return __BattleGoddessMovieView;
}
deps["battle.view.ui.BattleGoddessMovieView"] = ["battle.BattleManager", "battle.utils.BattleUtils", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.utils.getTimer", "utils.LogicUtils", "yishi.datas.objects.GoddessRoleInfo", "yishi.manager.EnterFrameManager"];

defs["battle.view.ui.BattleSpaceTimeBox"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BattleSpaceTimeBox extends __Base {
    static $fields(self) {
    self._mc = null;
    self._boxType = -1;
    self._currStar = -1;
    self._idx = 0;
    self._startTime = 0;
    self._endTime = 0;
    self._canUseTime = 0;
    self._boxCountText = null;
    }
    constructor() {
         super();
      }
    initConfig(param1, param2, param3, param4, param5) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         this._idx = param1;
         this._startTime = param2;
         this._endTime = param3;
         this._canUseTime = this._endTime - this._startTime;
         if(this._boxType == param4)
         {
            return;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mc);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._boxCountText);
         this._mc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.battle.spaceTimeBox" + param4);
         this._boxCountText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.spaceTimeBox.boxCountText");
         this._mc.gotoAndStop(1);
         this.addChild(this._mc);
         this.addChild(this._boxCountText);
         this._boxCountText.text = param5 + "";
         this._boxCountText.setFrame(1);
      }
    refreshTime(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc2_ = NaN;
         if(this._canUseTime == 0)
         {
            return;
         }
         if(param1 < this._endTime)
         {
            _loc3_ = param1 - this._startTime;
            _loc2_ = 0;
            _loc2_ = _loc3_ / this._canUseTime;
            if(_loc2_ <= 0.25)
            {
               this.$$star = 4;
            }
            else if(_loc2_ <= 0.5)
            {
               this.$$star = 3;
            }
            else if(_loc2_ <= 0.75)
            {
               this.$$star = 2;
            }
            else if(_loc2_ <= 1)
            {
               this.$$star = 1;
            }
         }
         else
         {
            this.$$star = 0;
         }
      }
    set $$star(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._currStar == param1 || this._mc == null)
         {
            return;
         }
         this._currStar = param1;
         this._boxCountText.setFrame(1);
         if(param1 == 0)
         {
            this._mc.gotoAndStop(40);
            this._boxCountText.setFrame(2);
         }
         else if(param1 == 1)
         {
            this._mc.gotoAndStop(30);
         }
         else if(param1 == 2)
         {
            this._mc.gotoAndStop(20);
         }
         else if(param1 == 3)
         {
            this._mc.gotoAndStop(10);
         }
         else if(param1 == 4)
         {
            this._mc.gotoAndStop(1);
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mc);
         this._mc = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get $$star() { return super.$$star; }
  }
  $.meta(__BattleSpaceTimeBox, "battle.view.ui.BattleSpaceTimeBox", []);
  return __BattleSpaceTimeBox;
}
deps["battle.view.ui.BattleSpaceTimeBox"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["battle.view.ui.BattleSpaceTimeView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BattleSpaceTimeView extends __Base {
    static $fields(self) {
    self._back = null;
    self._listBox = null;
    self._list = null;
    self._configBox = null;
    self._configCountBox = null;
    self._configList = null;
    self.MAX = 5;
    self._startTime = 0;
    self._passTime = 0;
    self._normalConfig = null;
    self._advaneceConfig = null;
    self._normalCountConfig = null;
    self._advaneceCountConfig = null;
    self._isFirst = false;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._normalConfig = $.C("yishi.manager.TempleteManager").instance.getSpaceTimeBoxConfigValue(1);
         this._advaneceConfig = $.C("yishi.manager.TempleteManager").instance.getSpaceTimeBoxConfigValue(2);
         this._normalCountConfig = $.C("yishi.manager.TempleteManager").instance.getSpaceTimeBoxCountConfigValue(1);
         this._advaneceCountConfig = $.C("yishi.manager.TempleteManager").instance.getSpaceTimeBoxCountConfigValue(2);
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.spaceTimeBoxBK");
         this._listBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("spacetimefalut.battle.RewardHbox");
         this.addChild(this._back);
         this.addChild(this._listBox);
         this.initBox();
         this.__layerChangeHandler(null);
      }
    initBox() {
         var _loc1_ = null;
         var _loc2_ = 0;
         this._list = new $.Vector();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new ($.C("battle.view.ui.BattleSpaceTimeBox"))();
            this._list[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
    refreshBoxData() {
         var _loc1_ = null;
         var _loc3_ = 0;
         if(this._configList == null)
         {
            return;
         }
         var _loc4_ = ($.C("flash.utils.getTimer")() - this._startTime) / 1000;
         if(this._passTime == _loc4_)
         {
            return;
         }
         this._passTime = _loc4_;
         var _loc2_ = $.int(this._listBox.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = $.as(this._listBox.getChildAt(_loc3_), $.C("battle.view.ui.BattleSpaceTimeBox"));
            _loc1_.refreshTime(this._passTime);
            _loc3_++;
         }
      }
    startConfigBox(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc9_ = null;
         var _loc10_ = null;
         var _loc3_ = null;
         var _loc7_ = 0;
         var _loc5_ = null;
         var _loc8_ = 0;
         if(this._configBox == param1 && this._configCountBox == param2 || param1 == "" || param1 == null)
         {
            return;
         }
         this._configBox = param1;
         this._configCountBox = param2;
         this._configList = this._configBox.split(",");
         var _loc6_ = $.int(this._configList.length);
         var _loc4_ = [];
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc5_ = this._list[_loc8_];
            _loc9_ = this._configList[_loc8_];
            _loc10_ = _loc9_.split(":");
            _loc3_ = param2.split(",");
            _loc5_.initConfig(_loc8_,_loc7_,$.int(_loc10_[1]),$.int(_loc10_[0]),_loc3_[_loc8_]);
            _loc7_ = $.int(_loc10_[1]);
            _loc4_.push(_loc5_);
            _loc8_++;
         }
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._listBox);
         this._listBox.beginChanges();
         _loc8_ = _loc6_ - 1;
         while(_loc8_ >= 0)
         {
            _loc5_ = _loc4_[_loc8_];
            this._listBox.addChild(_loc5_);
            _loc8_--;
         }
         this._listBox.commitChanges();
         this._listBox.x = (this._back.width - this._listBox.width) / 2;
      }
    initEvent() {
         this.model.addEventListener("TRAIL_LAYER_CHANGE",$.bind(this, "__layerChangeHandler"));
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
      }
    removeEvent() {
         if(this.model)
         {
            this.model.removeEventListener("TRAIL_LAYER_CHANGE",$.bind(this, "__layerChangeHandler"));
         }
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
      }
    enterFrame() {
         this.refreshBoxData();
      }
    __layerChangeHandler(param1 = null) {
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = 0;
         var _loc3_ = this.model.mapId == 9998 ? this._normalConfig : this._advaneceConfig;
         var _loc2_ = this.model.mapId == 9998 ? this._normalCountConfig : this._advaneceCountConfig;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.split("|");
            _loc5_ = _loc2_.split("|");
            _loc6_ = this.model.trialLayer - 1 < 0 ? 0 : this.model.trialLayer - 1;
            this.startConfigBox(_loc4_[_loc6_],_loc5_[_loc6_]);
            if(!this._isFirst)
            {
               this._isFirst = true;
               this._startTime = $.C("flash.utils.getTimer")() - this.beginToNowTime;
            }
            else
            {
               this._startTime = $.C("flash.utils.getTimer")();
            }
         }
      }
    get beginToNowTime() {
         var _loc1_ = null;
         var _loc5_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
         if(_loc5_.castle_offset == -1)
         {
            _loc1_ = _loc5_.sysCurtime;
         }
         else
         {
            _loc1_ = $.C("yishi.utils.DateFormatter").getTimezoneOffsetDate(_loc5_.castle_offset);
         }
         var _loc2_ = _loc1_.time;
         var _loc4_ = Number(_loc5_.playerInfo.spaceTimeBoxTimeBegin);
         return _loc2_ - _loc4_;
      }
    get model() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         for (var _loc1_ of $.values(this._list))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this._list = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._listBox);
         this._listBox = null;
         this._configList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set beginToNowTime(v) { super.beginToNowTime = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__BattleSpaceTimeView, "battle.view.ui.BattleSpaceTimeView", ["IEnterFrame"]);
  return __BattleSpaceTimeView;
}
deps["battle.view.ui.BattleSpaceTimeView"] = ["battle.BattleManager", "battle.view.ui.BattleSpaceTimeBox", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.getTimer", "yishi.manager.EnterFrameManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.DateFormatter"];

defs["battle.view.ui.BattleUIView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BattleUIView extends __Base {
    static $fields(self) {
    self._roleShowII = null;
    self._doubleBossShow = null;
    self._mutilRoleShowView = null;
    self._skillNameContainer = null;
    self._batterUIView = null;
    self._battleSpaceTimeView = null;
    self._resistUIView1 = null;
    self._resistUIView2 = null;
    self._sceneWidth = NaN;
    self._sceneHeight = NaN;
    self._delay = null;
    self._qteView = null;
    self._addSpBallLayer = null;
    self._preLockState = false;
    self._skillListOffsetX = 0;
    self._bottomBar = null;
    self._petBar = null;
    self._sacristyBar = null;
    self._childpveBar = null;
    self._childCommomBar = null;
    self._monsterCommomBar = null;
    self._outyardShowView = null;
    self._hurtUpView = null;
    self._trailCountView = null;
    self._autoFightBtn = null;
    self._autoFightFlag = null;
    self._autoFightStrip = null;
    self._chatMessageBtn = null;
    self._consortiaChatBtn = null;
    self._teamStripContainer1 = null;
    self._teamStripContainer2 = null;
    self._finishNowBtn = null;
    self._settingBtn = null;
    self._timer = null;
    self._countdownTxt = null;
    self._countdownTxt2 = null;
    self._countdownNumTxt = null;
    self._killSelfBtn = null;
    self._immediatelyWinBtn = null;
    self._hideOthersBg = null;
    self._hideOthersBtn = null;
    self._preSelected = false;
    self._nldlyiSynBloodRoleInfo = null;
    self._dragonTitanOfTeamMate = null;
    self._dragonTitanOfEnemies = null;
    self._selfGoddessTopView = null;
    self._vsGoddessTopView = null;
    self._raceAgainstTimeUpView = null;
    self._forbiddenBossUIView = null;
    self._warsoulEndBtn = null;
    self.container = null;
    self._isskilling = false;
    self._stripView = null;
    self._teamStripHashmap = null;
    self._preClickTime = NaN;
    }
    constructor() {
         super();
         this.init();
         this.layout();
         this.addEvent();
         var _loc1_ = $.C("managers.VIPManager").Instance.model.vipInfo;
         if((this.isPetChallenge || this.isMonopolyHelp) && Boolean(_loc1_.IsVipAndNoExpirt) && _loc1_.VipGrade >= 3)
         {
            this.showFinishBtn();
         }
         if(this.isBattleSign)
         {
            this.showFinishBtn();
         }
         if(this.battleModel.battleType == 3905)
         {
            this._warsoulEndBtn.visible = true;
         }
      }
    showFinishBtn() {
         var _loc2_ = 10;
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("Imm_over_battle");
         if(_loc1_)
         {
            _loc2_ = parseInt(_loc1_.ConfigValue) / 1000;
         }
         if(this._finishNowBtn.icon)
         {
            this._finishNowBtn.icon.visible = false;
         }
         if(this._countdownTxt)
         {
            this._countdownTxt.visible = true;
         }
         if(this._countdownTxt2)
         {
            this._countdownTxt2.visible = true;
         }
         if(this._countdownNumTxt)
         {
            this._countdownNumTxt.visible = true;
         }
         this._stripView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.petChallenge.countdownTxtTip",_loc2_);
         this._timer = new ($.C("flash.utils.Timer"))(1000,_loc2_);
         this._timer.addEventListener("timer",$.bind(this, "__onTimer"));
         this._timer.addEventListener("timerComplete",$.bind(this, "__onTimerComplete"));
         this._timer.start();
      }
    __onTimer(param1) {
         var _loc2_ = null;
         if(this._countdownNumTxt)
         {
            _loc2_ = this._timer.repeatCount - this._timer.currentCount + "";
            if(_loc2_.length == 1)
            {
               _loc2_ = "0" + _loc2_;
            }
            this._countdownNumTxt.text = _loc2_;
            if(this._stripView)
            {
               this._stripView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.petChallenge.countdownTxtTip",this._timer.repeatCount - this._timer.currentCount);
            }
         }
      }
    __onTimerComplete(param1) {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimer"));
            this._timer.removeEventListener("timerComplete",$.bind(this, "__onTimerComplete"));
            this._timer = null;
         }
         if(this._stripView)
         {
            this._stripView.tipData = $.C("manager.LanguageMgr").GetTranslation("BattleUIView.vip3use");
         }
         if(!this._finishNowBtn)
         {
            return;
         }
         var _loc2_ = $.C("managers.VIPManager").Instance.model.vipInfo;
         if(_loc2_.IsVipAndNoExpirt && _loc2_.VipGrade >= 3)
         {
            this._finishNowBtn.enable = true;
         }
         if(this.battleModel.battleType == 16)
         {
            this._finishNowBtn.enable = true;
         }
         if(this._finishNowBtn.icon)
         {
            this._finishNowBtn.icon.visible = true;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countdownNumTxt);
         this._countdownNumTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countdownTxt);
         this._countdownTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countdownTxt2);
         this._countdownTxt2 = null;
      }
    addEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__stageResize"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SET_BATTERUI_VISIBLE_BattleNotic",$.bind(this, "__batterUIVisible"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SET_RESIST_VISIBLE",$.bind(this, "__resistUIVisible"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SHOW_SKILL_USE_SUCCESS_BattleNotic",$.bind(this, "__skillUseSuccess"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("CHAT_FROM_CONSORTIA",$.bind(this, "__receiveGroupChatHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("BATTLE_REINFORCE_HANDLER",$.bind(this, "__refreshViewHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("BATTLE_STONETRIGGER",$.bind(this, "_showStoneTriggerSkill"));
         this._chatMessageBtn.addEventListener("rollOut",$.bind(this, "__onMsgBtnRollOut"));
         this._chatMessageBtn.addEventListener("rollOver",$.bind(this, "__onMsgBtnRollOver"));
         this._chatMessageBtn.addEventListener("click",$.bind(this, "__mouseClickHandler"));
         this._consortiaChatBtn.addEventListener("click",$.bind(this, "__consortiaChatClickHandler"));
         $.C("managers.IMManager").instance.addEventListener("MSGBOX_SHINING_UPDATE",$.bind(this, "__msgboxShiningUpdateHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("FORCE_SKILL_ENABLE",$.bind(this, "__forceSkillEnable"));
         if(this._finishNowBtn)
         {
            this._finishNowBtn.addEventListener("click",$.bind(this, "__finishNowBtnClickHandler"));
         }
         if(this._settingBtn)
         {
            this._settingBtn.addEventListener("click",$.bind(this, "__settingBtnClickHandler"));
         }
         if(this._warsoulEndBtn)
         {
            this._warsoulEndBtn.addEventListener("click",$.bind(this, "__warsoulEndBtnClickHandler"));
         }
      }
    removeEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__stageResize"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SHOW_SKILL_USE_SUCCESS_BattleNotic",$.bind(this, "__skillUseSuccess"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SET_BATTERUI_VISIBLE_BattleNotic",$.bind(this, "__batterUIVisible"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SET_RESIST_VISIBLE",$.bind(this, "__resistUIVisible"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SKILL_ENABLE",$.bind(this, "__skillEnable"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("CHAT_FROM_CONSORTIA",$.bind(this, "__receiveGroupChatHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("BATTLE_REINFORCE_HANDLER",$.bind(this, "__refreshViewHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("BATTLE_STONETRIGGER",$.bind(this, "_showStoneTriggerSkill"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("FORCE_SKILL_ENABLE",$.bind(this, "__forceSkillEnable"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4794,$.bind(this, "nldlyiOtherBossHPSyncHandler"));
         if(this._chatMessageBtn)
         {
            this._chatMessageBtn.removeEventListener("rollOut",$.bind(this, "__onMsgBtnRollOut"));
            this._chatMessageBtn.removeEventListener("rollOver",$.bind(this, "__onMsgBtnRollOver"));
            this._chatMessageBtn.removeEventListener("click",$.bind(this, "__mouseClickHandler"));
         }
         if(this._consortiaChatBtn)
         {
            this._consortiaChatBtn.removeEventListener("click",$.bind(this, "__consortiaChatClickHandler"));
         }
         if(this._autoFightBtn)
         {
            this._autoFightBtn.removeEventListener("click",$.bind(this, "onAutoFightClick"));
         }
         if(this._hideOthersBtn)
         {
            this._hideOthersBtn.removeEventListener("click",$.bind(this, "onHideOthersClick"));
         }
         $.C("managers.IMManager").instance.removeEventListener("MSGBOX_SHINING_UPDATE",$.bind(this, "__msgboxShiningUpdateHandler"));
         if(this._finishNowBtn)
         {
            this._finishNowBtn.removeEventListener("click",$.bind(this, "__finishNowBtnClickHandler"));
         }
         if(this._settingBtn)
         {
            this._settingBtn.removeEventListener("click",$.bind(this, "__settingBtnClickHandler"));
         }
         if(this._killSelfBtn)
         {
            this._killSelfBtn.removeEventListener("click",$.bind(this, "_onKillSelfClick"));
         }
         if(this._immediatelyWinBtn)
         {
            this._immediatelyWinBtn.removeEventListener("click",$.bind(this, "_onKillSelfClick"));
         }
         if(this._warsoulEndBtn)
         {
            this._warsoulEndBtn.removeEventListener("click",$.bind(this, "__warsoulEndBtnClickHandler"));
         }
      }
    __forceSkillEnable(param1) {
         if(this.container)
         {
            this.container.removeAllChildren();
            this.container.visible = false;
         }
      }
    testTriggerskill() {
         var _loc4_ = 0;
         var _loc2_ = null;
         var _loc1_ = new ($.C("battle.events.BattleEvent"))("sss",null);
         var _loc3_ = [];
         var _loc5_ = [5500101,5500204,5500405];
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = new ($.C("com.road.yishi.proto.battle.TriggerSkillMsg"))();
            _loc2_.templatedId = _loc5_[_loc4_];
            _loc3_.push(_loc2_);
            _loc4_++;
         }
         if(this._isskilling)
         {
            _loc3_ = [];
            this._isskilling = false;
         }
         else
         {
            this._isskilling = true;
         }
         _loc1_.data = _loc3_;
         this._showStoneTriggerSkill(_loc1_);
      }
    _showStoneTriggerSkill(param1) {
         var _loc2_ = null;
         var _loc7_ = null;
         var _loc6_ = 0;
         var _loc4_ = null;
         var _loc3_ = $.as(param1.data, "Array");
         if(!_loc3_)
         {
            return;
         }
         var _loc5_ = $.int(_loc3_.length);
         if(_loc5_ == 0)
         {
            this.container.removeAllChildren();
            this.container.visible = false;
         }
         else
         {
            this.container.removeAllChildren();
            this.container.visible = true;
            _loc7_ = null;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_ = new ($.C("battle.view.ui.BattleSkillItemII"))(5);
               _loc4_ = _loc3_[_loc6_];
               if(_loc4_)
               {
                  ($.as(_loc2_, $.C("battle.view.ui.BattleSkillItemII"))).setState(0);
                  _loc2_.addEventListener("SKILL_CLICK_BattleEvent",$.bind(this, "__skillClick"));
                  _loc7_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc4_.templatedId);
                  _loc2_["data"] = _loc7_;
                  if(_loc4_.coolDown)
                  {
                     _loc2_["data"].CoolDown = _loc4_.coolDown;
                     _loc2_.cdStart(_loc4_.appearCoolDown,_loc7_.CoolDown);
                  }
                  this.container.appendItem(_loc2_,{"width":44});
               }
               _loc6_++;
            }
         }
      }
    __skillClick(param1) {
         $.C("yishi.manager.NotificationManager").instance.sendNotification("ACTION_SKILL_BattleNotic",param1.data);
      }
    __refreshViewHandler(param1) {
         if(!this.isNoHeroBattleType())
         {
            if(this.hasTitanInThisBattle())
            {
               if($.C("battle.utils.BattleFunctionHelper").instance.hasHeroBySide(this.enemySide))
               {
                  if(!this._dragonTitanOfTeamMate)
                  {
                     this._dragonTitanOfTeamMate = new ($.C("battle.view.ui.DragonTitanTeamView"))(this.selfSide);
                     this._dragonTitanOfTeamMate.x = 0;
                     this._dragonTitanOfTeamMate.y = this._sceneHeight * 0.5 - 130;
                     this.addChild(this._dragonTitanOfTeamMate);
                  }
                  if(!this._dragonTitanOfEnemies && this.battleModel.battleType != 3870)
                  {
                     this._dragonTitanOfEnemies = new ($.C("battle.view.ui.DragonTitanTeamView"))(this.enemySide);
                     this._dragonTitanOfEnemies.x = this._sceneWidth - 120;
                     this._dragonTitanOfEnemies.y = this._sceneHeight * 0.5 - 130;
                     this.addChild(this._dragonTitanOfEnemies);
                  }
               }
               else if($.C("battle.utils.BattleFunctionHelper").instance.hasHeroBySide(this.selfSide))
               {
                  if(!this._dragonTitanOfTeamMate)
                  {
                     this._dragonTitanOfTeamMate = new ($.C("battle.view.ui.DragonTitanTeamView"))(this.selfSide);
                     this._dragonTitanOfTeamMate.x = 0;
                     this._dragonTitanOfTeamMate.y = this._sceneHeight * 0.5 - 130;
                     this.addChild(this._dragonTitanOfTeamMate);
                  }
               }
            }
         }
         var _loc2_ = $.C("battle.utils.BattleFunctionHelper").instance.showGoddessTopAry();
         if(_loc2_[0])
         {
            this._selfGoddessTopView = new ($.C("battle.view.ui.top.BattleGoddessTopView"))(this.selfSide);
            this._selfGoddessTopView.x = this._sceneWidth / 2 - 480;
            this._selfGoddessTopView.y = -20;
            this.addChild(this._selfGoddessTopView);
         }
         if(_loc2_[1])
         {
            this._vsGoddessTopView = new ($.C("battle.view.ui.top.BattleGoddessTopView"))(this.enemySide);
            this._vsGoddessTopView.x = this._sceneWidth / 2 + 40;
            this._vsGoddessTopView.y = -20;
            this.addChild(this._vsGoddessTopView);
         }
      }
    __finishNowBtnClickHandler(param1) {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this.battleModel.battleType == 16)
         {
            this.battleModel.isFinishNow = true;
            $.C("battle.net.BattleSocketOuterManager").sendEndBattle(this.battleModel.battleId);
         }
         else
         {
            _loc3_ = $.C("managers.VIPManager").Instance.model.vipInfo;
            if(_loc3_.IsVipAndNoExpirt && _loc3_.VipGrade >= 3)
            {
               this.battleModel.isFinishNow = true;
               $.C("battle.net.BattleSocketOuterManager").sendEndBattle(this.battleModel.battleId);
            }
            _loc4_ = "";
            _loc2_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("chat.datas.ChatData")), $.C("chat.datas.ChatData"));
            if(this.isMonopolyHelp)
            {
               _loc4_ = $.C("manager.LanguageMgr").GetTranslation("battle.view.ui.BattleUIView.finishNowBtnClickTips");
               if(_loc2_)
               {
                  _loc2_.channel = 3;
                  _loc2_.msg = _loc4_;
                  _loc2_.commit();
                  $.C("yishi.manager.NotificationManager").instance.sendNotification("ADD_CHAT",_loc2_);
               }
            }
         }
         this._finishNowBtn.enable = false;
      }
    __warsoulEndBtnClickHandler(param1) {
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "callBack")];
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
         var _loc5_ = $.C("manager.LanguageMgr").GetTranslation("battleUIView.warsoulTower.content.txt");
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
    callBack(param1, param2) {
         if(param1)
         {
            if(this.battleModel.battleType == 3905)
            {
               $.C("yishi.service.managers.SocketSendManager").instance.sendRemoveBattle();
            }
         }
      }
    __settingBtnClickHandler(param1) {
         $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "openFrame"),10);
      }
    openFrame() {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("setting");
      }
    __receiveGroupChatHandler(param1) {
         this.setConsortiaChatBtnShining();
      }
    __msgboxShiningUpdateHandler(param1) {
         this.setMsgBtnShining();
      }
    __onMsgBtnRollOver(param1) {
         var _loc2_ = null;
         var _loc3_ = $.C("managers.IMManager").instance.createIMMsgBox();
         if(_loc3_)
         {
            $.C("com.pickgliss.ui.ShowTipManager").Instance.removeCurrentTip();
            _loc2_ = new ($.C("flash.geom.Point"))(this._chatMessageBtn.x - (_loc3_.width - this._chatMessageBtn.width) / 2,this._chatMessageBtn.y - _loc3_.height);
            _loc2_ = this.localToGlobal(_loc2_);
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            _loc2_ = null;
            $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc3_,3);
         }
      }
    __mouseClickHandler(param1) {
         $.C("com.pickgliss.toplevel.StageReferance").stage.dispatchEvent(new ($.C("flash.events.KeyboardEvent"))("keyDown",true,false,0,13));
         param1.stopPropagation();
      }
    __onMsgBtnRollOut(param1) {
         $.C("managers.IMManager").instance.model.removeMsgBoxTimeOut = $.C("flash.utils.setTimeout")($.bind(this, "removeIMMsgBox"),300);
      }
    removeIMMsgBox() {
         $.C("flash.utils.clearTimeout")($.C("managers.IMManager").instance.model.removeMsgBoxTimeOut);
         $.C("managers.IMManager").instance.removeIMMsgBox();
      }
    __consortiaChatClickHandler(param1) {
         if(!$.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.isVisible())
         {
            this.setConsortiaChatBtnShining(false);
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortiagroupchat");
         }
      }
    setMsgBtnShining() {
         if($.C("managers.IMManager").instance.friendBtnShining)
         {
            this._chatMessageBtn.isPlaying = true;
            this._chatMessageBtn.playEffect();
         }
         else
         {
            this._chatMessageBtn.isPlaying = false;
            this._chatMessageBtn.stopEffect();
         }
      }
    setConsortiaChatBtnShining(param1 = true) {
         if(param1 && Boolean($.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.groupChatShining))
         {
            this._consortiaChatBtn.isPlaying = true;
            this._consortiaChatBtn.playEffect();
         }
         else
         {
            this._consortiaChatBtn.isPlaying = false;
            this._consortiaChatBtn.stopEffect();
         }
      }
    __batterUIVisible(param1) {
         var event = param1;
         if(event.data == true)
         {
            $.C("battle.BattleManager").getInstance().batterModel.lock = false;
            this._batterUIView.visible = event.data;
            if(this._delay)
            {
               this._delay.cancel();
            }
            this._batterUIView.show();
         }
         else
         {
            if(this._delay)
            {
               this._delay.cancel();
            }
            this._delay = $.C("battle.utils.Helpers").delayCall(() =>
            {
               this._batterUIView.hide();
               $.C("battle.BattleManager").getInstance().batterModel.lock = false;
            },25);
         }
      }
    __resistUIVisible(param1) {
         if(this.battleModel.battleType == 311 || this.battleModel.battleType == 312 || this.battleModel.battleType == 313)
         {
            return;
         }
         var _loc2_ = param1.data.side == 1 ? this._resistUIView1 : this._resistUIView2;
         if(param1.data.value == true)
         {
            _loc2_.visible = param1.data.value;
            _loc2_.show();
         }
      }
    __skillEnable(param1) {
         if(this.battleModel.isMultiPlayer() || !$.C("yishi.datas.BattleModel").allowAutoFight)
         {
            if(this._autoFightBtn)
            {
               this.battleAutoFightEnable = false;
            }
            return;
         }
         if(this.battleModel.isOver)
         {
            this.battleAutoFightEnable = false;
         }
         else if($.C("yishi.manager.ArmyManager").instance.thane.grades >= 15)
         {
            this.battleAutoFightEnable = true;
         }
      }
    set battleAutoFightEnable(param1) {
         if(this._autoFightBtn)
         {
            this._autoFightBtn.enable = param1;
         }
         if(this.battleModel.battleType == 3886)
         {
            if(!this.battleModel.isOver && $.C("yishi.manager.ArmyManager").instance.thane.grades >= 15)
            {
               this._autoFightBtn.enable = true;
            }
         }
      }
    __stageResize(param1) {
         this.layout();
      }
    layout() {
         var _loc1_ = NaN;
         var _loc5_ = NaN;
         var _loc4_ = NaN;
         var _loc6_ = NaN;
         var _loc10_ = NaN;
         this._sceneWidth = $.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageWidth,1000,1500);
         this._sceneHeight = $.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageHeight,600,900);
         var _loc8_ = this._sceneWidth / 1500;
         var _loc2_ = this._sceneWidth - this._skillListOffsetX;
         this._batterUIView.x = this._sceneWidth - 280;
         this._resistUIView1.x = 280;
         this._resistUIView2.x = this._sceneWidth - 280;
         this._skillNameContainer.x = this._sceneWidth * 0.5;
         this._skillNameContainer.y = 270 * _loc8_;
         this._teamStripContainer2.x = this._sceneWidth - 190;
         if(this._qteView)
         {
            this._qteView.x = (this._sceneWidth - this._qteView.width) / 2;
            this._qteView.y = this._sceneHeight - 280;
         }
         if(this.container)
         {
            this.container.x = this._sceneWidth / 2;
            this.container.y = this._sceneHeight / 2 + 100;
         }
         var _loc7_ = (this._sceneWidth - 1000) / 300;
         _loc7_ = 0.85 + _loc7_ * 0.15;
         var _loc3_ = this._sceneWidth * 0.5;
         var _loc9_ = 500 * _loc7_;
         if(this.isPetChallenge || this.isMonopolyHelp || this.isBattleSign || this.isSpiritExpedition || this.isYLExpedtion || this.isDarkMaze)
         {
            if(this._stripView)
            {
               this._stripView.x = this._sceneWidth * 0.5 - this._finishNowBtn.width * 0.5;
               this._stripView.y = this._sceneHeight - this._finishNowBtn.height + 5;
               if(this._hideOthersBg)
               {
                  this._hideOthersBg.x = this._stripView.x + this._finishNowBtn.width + 25;
                  this._hideOthersBg.y = this.isSpiritExpedition ? this._sceneHeight - this._finishNowBtn.height - 20 : this._sceneHeight - this._finishNowBtn.height + 15;
               }
               if(this._hideOthersBtn)
               {
                  this._hideOthersBtn.x = this._stripView.x + this._finishNowBtn.width + 30;
                  this._hideOthersBtn.y = this.isSpiritExpedition ? this._sceneHeight - this._finishNowBtn.height - 15 : this._sceneHeight - this._finishNowBtn.height + 20;
               }
               if(this._consortiaChatBtn)
               {
                  this._consortiaChatBtn.x = this._stripView.x + this._finishNowBtn.width * 0.5 - this._chatMessageBtn.width * 0.5 - 30;
                  this._consortiaChatBtn.y = this._sceneHeight - this._finishNowBtn.height - 8;
               }
               if(this._chatMessageBtn)
               {
                  this._chatMessageBtn.x = this._stripView.x + this._finishNowBtn.width * 0.5 - this._chatMessageBtn.width * 0.5;
                  this._chatMessageBtn.y = this._sceneHeight - this._finishNowBtn.height - 10;
               }
               if(this._settingBtn)
               {
                  this._settingBtn.x = this._stripView.x + this._finishNowBtn.width * 0.5 - this._chatMessageBtn.width * 0.5 + 30;
                  this._settingBtn.y = this._sceneHeight - this._finishNowBtn.height - 10;
               }
            }
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         else if(this.isSelfChess)
         {
            if(this._hideOthersBg)
            {
               this._hideOthersBg.x = _loc3_ + _loc9_ + 3;
               this._hideOthersBg.y = this._sceneHeight - 45;
            }
            if(this._hideOthersBtn)
            {
               this._hideOthersBtn.x = _loc3_ + _loc9_ + 8;
               this._hideOthersBtn.y = this._sceneHeight - 41;
            }
            this._autoFightBtn.visible = false;
            if(this._chatMessageBtn)
            {
               this._chatMessageBtn.visible = false;
            }
            if(this._consortiaChatBtn)
            {
               this._consortiaChatBtn.visible = false;
            }
            if(this._settingBtn)
            {
               this._settingBtn.visible = false;
            }
         }
         else if(this.isPetBatle)
         {
            if(this._petBar)
            {
               _loc1_ = (this._sceneWidth - 1000) / 300;
               _loc1_ = 0.85 + _loc1_ * 0.15;
               this._petBar.x = this._sceneWidth * 0.5;
               this._petBar.y = this._sceneHeight;
               this._petBar.scaleX = this._petBar.scaleY = _loc1_;
               if(this._hideOthersBg)
               {
                  this._hideOthersBg.x = this._petBar.x + 210 * _loc1_ + 145;
                  this._hideOthersBg.y = this._sceneHeight - 60 * _loc1_ - 5;
               }
               if(this._hideOthersBtn)
               {
                  this._hideOthersBtn.x = this._petBar.x + 210 * _loc1_ + 150;
                  this._hideOthersBtn.y = this._sceneHeight - 60 * _loc1_;
               }
               if(this._chatMessageBtn)
               {
                  this._chatMessageBtn.x = this._petBar.x + 210 * _loc1_ - 60 - 7;
                  this._chatMessageBtn.y = this._sceneHeight - 60 * _loc1_ - 35;
               }
               if(this._consortiaChatBtn)
               {
                  this._consortiaChatBtn.x = this._petBar.x + 210 * _loc1_ - 90 - 7;
                  this._consortiaChatBtn.y = this._sceneHeight - 60 * _loc1_ - 33;
               }
            }
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         else if(this.isSacristyBatle)
         {
            if(this._sacristyBar)
            {
               _loc5_ = (this._sceneWidth - 1000) / 300;
               _loc5_ = 0.85 + _loc5_ * 0.15;
               this._sacristyBar.x = this._sceneWidth * 0.5;
               this._sacristyBar.y = this._sceneHeight;
               this._sacristyBar.scaleX = this._sacristyBar.scaleY = _loc5_;
               if(this._autoFightBtn)
               {
                  this._autoFightBtn.x = this._sacristyBar.x + 210 * _loc5_ + 50 + 20;
                  this._autoFightBtn.y = this._sceneHeight - 63 - 18;
                  this._hideOthersBg.y = this._sceneHeight - 63;
                  this._autoFightStrip.y = this._sceneHeight - 63;
               }
               if(this._hideOthersBg)
               {
                  this._hideOthersBg.x = this._sacristyBar.x + 210 * _loc5_ + 145;
                  this._hideOthersBg.y = this._sceneHeight - 60 * _loc5_ - 5;
               }
               if(this._hideOthersBtn)
               {
                  this._hideOthersBtn.x = this._sacristyBar.x + 210 * _loc5_ + 150;
                  this._hideOthersBtn.y = this._sceneHeight - 60 * _loc5_;
               }
               if(this._chatMessageBtn)
               {
                  this._chatMessageBtn.x = this._sacristyBar.x + 210 * _loc5_ - 60 - 97;
                  this._chatMessageBtn.y = this._sceneHeight - 60 * _loc5_ - 35;
               }
               if(this._consortiaChatBtn)
               {
                  this._consortiaChatBtn.visible = false;
                  this._consortiaChatBtn.x = this._sacristyBar.x + 210 * _loc5_ - 90 - 7;
                  this._consortiaChatBtn.y = this._sceneHeight - 60 * _loc5_ - 33;
               }
            }
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         else if(this.isChildpveBatle)
         {
            if(this._childpveBar)
            {
               _loc4_ = (this._sceneWidth - 1000) / 300;
               _loc4_ = 0.85 + _loc4_ * 0.15;
               this._childpveBar.x = this._sceneWidth * 0.5;
               this._childpveBar.y = this._sceneHeight;
               this._childpveBar.scaleX = this._childpveBar.scaleY = _loc4_;
               if(this._hideOthersBg)
               {
                  this._hideOthersBg.x = this._childpveBar.x + 210 * _loc4_ + 145;
                  this._hideOthersBg.y = this._sceneHeight - 60 * _loc4_ - 5;
               }
               if(this._hideOthersBtn)
               {
                  this._hideOthersBtn.x = this._childpveBar.x + 210 * _loc4_ + 150;
                  this._hideOthersBtn.y = this._sceneHeight - 60 * _loc4_;
               }
               if(this._chatMessageBtn)
               {
                  this._chatMessageBtn.x = this._childpveBar.x + 210 * _loc4_ - 60 - 7;
                  this._chatMessageBtn.y = this._sceneHeight - 60 * _loc4_ - 35;
               }
               if(this._consortiaChatBtn)
               {
                  this._consortiaChatBtn.x = this._childpveBar.x + 210 * _loc4_ - 90 - 7;
                  this._consortiaChatBtn.y = this._sceneHeight - 60 * _loc4_ - 33;
               }
            }
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         else if(this.battleModel.isChildBattle)
         {
            if(this._childCommomBar)
            {
               _loc6_ = (this._sceneWidth - 1000) / 300;
               _loc6_ = 0.85 + _loc6_ * 0.15;
               this._childCommomBar.x = this._sceneWidth * 0.5;
               this._childCommomBar.y = this._sceneHeight;
               this._childCommomBar.scaleX = this._childCommomBar.scaleY = _loc6_;
               if(this._hideOthersBg)
               {
                  this._hideOthersBg.x = this._childCommomBar.x + 210 * _loc6_ + 35;
                  this._hideOthersBg.y = this._sceneHeight - 60 * _loc6_;
               }
               if(this._hideOthersBtn)
               {
                  this._hideOthersBtn.x = this._childCommomBar.x + 210 * _loc6_ + 40;
                  this._hideOthersBtn.y = this._sceneHeight - 60 * _loc6_ + 5;
               }
               if(this._chatMessageBtn)
               {
                  this._chatMessageBtn.x = this._childCommomBar.x + 150 * _loc6_ - 60 - 7;
                  this._chatMessageBtn.y = this._sceneHeight - 60 * _loc6_ - 35;
               }
               if(this._consortiaChatBtn)
               {
                  this._consortiaChatBtn.x = this._childCommomBar.x + 150 * _loc6_ - 90 - 7;
                  this._consortiaChatBtn.y = this._sceneHeight - 60 * _loc6_ - 33;
               }
               if(this.battleModel.battleType == 3911)
               {
                  this._chatMessageBtn.x = 948;
                  this._consortiaChatBtn.x = 918;
                  this._hideOthersBg.x = 1080;
                  this._hideOthersBtn.x = 1086;
               }
            }
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         else if(this.battleModel.isMonsterBattle)
         {
            if(this._monsterCommomBar)
            {
               _loc10_ = (this._sceneWidth - 1000) / 300;
               _loc10_ = 0.85 + _loc10_ * 0.15;
               this._monsterCommomBar.x = this._sceneWidth * 0.5;
               this._monsterCommomBar.y = this._sceneHeight;
               this._monsterCommomBar.scaleX = this._monsterCommomBar.scaleY = _loc10_;
               if(this._hideOthersBg)
               {
                  this._hideOthersBg.x = this._monsterCommomBar.x + 210 * _loc10_ + 35;
                  this._hideOthersBg.y = this._sceneHeight - 60 * _loc10_;
               }
               if(this._hideOthersBtn)
               {
                  this._hideOthersBtn.x = this._monsterCommomBar.x + 210 * _loc10_ + 40;
                  this._hideOthersBtn.y = this._sceneHeight - 60 * _loc10_ + 5;
               }
               if(this._chatMessageBtn)
               {
                  this._chatMessageBtn.x = this._monsterCommomBar.x + 150 * _loc10_ - 60 - 7;
                  this._chatMessageBtn.y = this._sceneHeight - 60 * _loc10_ - 35;
               }
               if(this._consortiaChatBtn)
               {
                  this._consortiaChatBtn.x = this._monsterCommomBar.x + 150 * _loc10_ - 90 - 7;
                  this._consortiaChatBtn.y = this._sceneHeight - 60 * _loc10_ - 33;
               }
            }
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         else if(this._bottomBar)
         {
            this._bottomBar.x = this._sceneWidth * 0.5;
            this._bottomBar.y = this._sceneHeight;
            this._bottomBar.scaleX = this._bottomBar.scaleY = _loc7_;
            if(this._autoFightBtn)
            {
               this._autoFightBtn.x = this._bottomBar.x + 500 * _loc7_ + 10;
               this._autoFightStrip.x = this._autoFightBtn.x;
               this._autoFightBtn.y = this._sceneHeight - 63;
               this._hideOthersBg.y = this._sceneHeight - 63;
               this._autoFightStrip.y = this._sceneHeight - 63;
            }
            if(this._hideOthersBg)
            {
               if(this._autoFightBtn)
               {
                  this._hideOthersBg.x = this._autoFightBtn.x + this._autoFightBtn.width;
               }
               else
               {
                  this._hideOthersBg.x = this._bottomBar.x + this._bottomBar.width * 0.5 + 17;
               }
               this._hideOthersBg.y = this._sceneHeight - 50;
            }
            if(this._hideOthersBtn)
            {
               if(this._autoFightBtn)
               {
                  this._hideOthersBtn.x = this._autoFightBtn.x + this._autoFightBtn.width + 12;
               }
               else
               {
                  this._hideOthersBtn.x = this._bottomBar.x + this._bottomBar.width * 0.5 + 22;
               }
               this._hideOthersBtn.y = this._sceneHeight - 45;
            }
            if(this._chatMessageBtn)
            {
               this._chatMessageBtn.x = this._bottomBar.x + 210 * _loc7_ - 60 - 7;
               this._chatMessageBtn.y = this._sceneHeight - 60 * _loc7_ - 35;
            }
            if(this._consortiaChatBtn)
            {
               this._consortiaChatBtn.x = this._bottomBar.x + 210 * _loc7_ - 90 - 7;
               this._consortiaChatBtn.y = this._sceneHeight - 60 * _loc7_ - 33;
            }
            if(this._warsoulEndBtn)
            {
               this._warsoulEndBtn.x = this._bottomBar.x + 500 * _loc7_ + 10;
               this._warsoulEndBtn.y = this._sceneHeight - 120;
            }
         }
         if(this._dragonTitanOfTeamMate)
         {
            this._dragonTitanOfTeamMate.x = 0;
            this._dragonTitanOfTeamMate.y = this._sceneHeight * 0.5 - 130;
         }
         if(this._dragonTitanOfEnemies)
         {
            this._dragonTitanOfEnemies.x = this._sceneWidth - 120;
            this._dragonTitanOfEnemies.y = this._sceneHeight * 0.5 - 130;
         }
         if(this._selfGoddessTopView)
         {
            this._selfGoddessTopView.x = this._sceneWidth / 2 - 480;
            this._selfGoddessTopView.y = -20;
         }
         if(this._vsGoddessTopView)
         {
            this._vsGoddessTopView.x = this._sceneWidth / 2 + 40;
            this._vsGoddessTopView.y = -20;
         }
         if(this._hurtUpView)
         {
            this._hurtUpView.x = this._sceneWidth * 0.5 - 30;
         }
         if(this._trailCountView)
         {
            this._trailCountView.x = this._sceneWidth - 123;
            this._trailCountView.y = 175;
         }
         if(this._battleSpaceTimeView)
         {
            this._battleSpaceTimeView.x = (this._sceneWidth - 187) / 2;
         }
         if(this._raceAgainstTimeUpView)
         {
            this._raceAgainstTimeUpView.x = (this._sceneWidth - this._raceAgainstTimeUpView.width) / 2 + 45;
            this._raceAgainstTimeUpView.y = 0;
         }
         if(this._forbiddenBossUIView)
         {
            this._forbiddenBossUIView.x = (this._sceneWidth - this._forbiddenBossUIView.width) / 2;
            this._forbiddenBossUIView.y = -6;
         }
         if($.C("battle.BattleManager").getInstance().battleModel.battleType == 295)
         {
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         if(this._killSelfBtn)
         {
            if(this._bottomBar)
            {
               this._killSelfBtn.x = this._bottomBar.x + this._bottomBar.width * 0.5 + 30;
               this._killSelfBtn.y = this._sceneHeight - 63 - 30;
            }
            else
            {
               this._killSelfBtn.x = this._sceneWidth - 200;
               this._killSelfBtn.y = this._sceneHeight - 63 - 30;
            }
            if(this._immediatelyWinBtn)
            {
               this._immediatelyWinBtn.x = this._killSelfBtn.x;
               this._immediatelyWinBtn.y = this._killSelfBtn.y - 30;
            }
         }
         if(this.hasGoddessUI && this._hurtUpView && this._hurtUpView.parent)
         {
            this._autoFightFlag.x = (this._sceneWidth - this._autoFightFlag.width) * 0.5;
            this._autoFightFlag.y = 137 * _loc8_ + 30;
         }
         else
         {
            this._autoFightFlag.x = (this._sceneWidth - this._autoFightFlag.width) * 0.5;
            this._autoFightFlag.y = 137 * _loc8_;
            if(this.battleModel.battleType == 3886)
            {
               this._autoFightFlag.y += 80;
            }
         }
      }
    init() {
         var _loc3_ = undefined;
         var _loc4_ = undefined;
         var _loc2_ = NaN;
         var _loc1_ = null;
         if(this.isPetBatle)
         {
            this._petBar = new ($.C("battle.view.bottom.PetBattleBar"))($.C("yishi.manager.SharedManager").instance.allowSceneEffect);
         }
         else if(this.isSacristyBatle)
         {
            this._sacristyBar = new ($.C("battle.view.bottom.PetSacristyBar"))($.C("yishi.manager.SharedManager").instance.allowSceneEffect);
         }
         else if(this.isChildpveBatle)
         {
            this._childpveBar = new ($.C("battle.view.bottom.ChildpveBattleBar"))($.C("yishi.manager.SharedManager").instance.allowSceneEffect);
         }
         else if(!(this.isSpiritExpedition || this.isDarkMaze))
         {
            if(this.battleModel.isChildBattle)
            {
               this._childCommomBar = new ($.C("battle.view.bottom.ChildCommonBottomBar"))($.C("yishi.manager.SharedManager").instance.allowSceneEffect);
            }
            else if(this.battleModel.isMonsterBattle)
            {
               this._monsterCommomBar = new ($.C("battle.view.bottom.MonsterCommonBottomBar"))($.C("yishi.manager.SharedManager").instance.allowSceneEffect);
            }
            else if(this.isSpaceTimeBattle)
            {
               this._battleSpaceTimeView = new ($.C("battle.view.ui.BattleSpaceTimeView"))();
               this._bottomBar = new ($.C("battle.view.bottom.BottomBar"))($.C("yishi.manager.SharedManager").instance.allowSceneEffect);
            }
            else if(!(this.isPetChallenge || this.isYLExpedtion || this.isSelfChess))
            {
               this._bottomBar = new ($.C("battle.view.bottom.BottomBar"))($.C("yishi.manager.SharedManager").instance.allowSceneEffect);
            }
         }
         if(!this.isNoHeroBattleType())
         {
            if(this.hasTitanInThisBattle() && Boolean($.C("yishi.manager.ConfigManager").version_info.TAITAN_LOCK))
            {
               if($.C("battle.utils.BattleFunctionHelper").instance.hasHeroBySide(this.enemySide))
               {
                  this._dragonTitanOfTeamMate = new ($.C("battle.view.ui.DragonTitanTeamView"))(this.selfSide);
                  this._dragonTitanOfEnemies = new ($.C("battle.view.ui.DragonTitanTeamView"))(this.enemySide);
               }
               else if($.C("battle.utils.BattleFunctionHelper").instance.hasHeroBySide(this.selfSide))
               {
                  this._dragonTitanOfTeamMate = new ($.C("battle.view.ui.DragonTitanTeamView"))(this.selfSide);
               }
            }
         }
         var _loc6_ = $.C("battle.utils.BattleFunctionHelper").instance.showGoddessTopAry();
         if(_loc6_[0])
         {
            this._selfGoddessTopView = new ($.C("battle.view.ui.top.BattleGoddessTopView"))(this.selfSide);
            this._selfGoddessTopView.x = this._sceneWidth / 2 - 480;
            this._selfGoddessTopView.y = -20;
            this.addChild(this._selfGoddessTopView);
         }
         if(_loc6_[1])
         {
            this._vsGoddessTopView = new ($.C("battle.view.ui.top.BattleGoddessTopView"))(this.enemySide);
            this._vsGoddessTopView.x = this._sceneWidth / 2 + 40;
            this._vsGoddessTopView.y = -20;
            this.addChild(this._vsGoddessTopView);
         }
         this.container = new ($.C("yishi.view.component.TileContainer"))();
         this.addChild(this.container);
         this._finishNowBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("battle.petChallenge.finishNowBtn");
         this._settingBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("battle.petChallenge.settingBtn");
         this._settingBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottom.BottomBar.settingBtn.tipData");
         this._stripView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.petChallenge.finishNowBtnTip");
         this._stripView.x = this._finishNowBtn.x;
         this._stripView.y = this._finishNowBtn.y;
         this._finishNowBtn.x = 0;
         this._finishNowBtn.y = 0;
         this._stripView.addChild(this._finishNowBtn);
         this._countdownTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.petChallenge.countdownTxt");
         this._countdownTxt2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.petChallenge.countdownTxt");
         this._countdownNumTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.petChallenge.countdownNumTxt");
         this._stripView.addChild(this._countdownTxt);
         this._stripView.addChild(this._countdownTxt2);
         this._stripView.addChild(this._countdownNumTxt);
         this._countdownTxt.text = $.C("manager.LanguageMgr").GetTranslation("battle.petChallenge.countdownTxt");
         this._countdownTxt2.text = $.C("manager.LanguageMgr").GetTranslation("task.view.TaskMobilePhoneView.Text1");
         this._countdownNumTxt.text = "10";
         this._countdownNumTxt.x = this._countdownTxt.x + this._countdownTxt.textWidth + 10;
         this._countdownTxt2.x = this._countdownNumTxt.x + this._countdownNumTxt.textWidth + 10;
         this._countdownNumTxt.visible = false;
         this._countdownTxt.visible = false;
         this._countdownTxt2.visible = false;
         this._warsoulEndBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("battle.petChallenge.warsoulEndBtn");
         this._warsoulEndBtn.visible = false;
         var _loc5_ = $.C("managers.VIPManager").Instance.model.vipInfo;
         if(!_loc5_.IsVipAndNoExpirt || _loc5_.VipGrade < 3)
         {
            this._stripView.tipData = $.C("manager.LanguageMgr").GetTranslation("BattleUIView.vip3");
         }
         else if(this.battleModel.battleType == 16)
         {
            this._stripView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.petChallenge.countdownTxtTip",10);
         }
         else
         {
            this._stripView.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.petChallenge.countdownTxtTip",10);
         }
         this._finishNowBtn.enable = false;
         if(this.battleModel.battleType == 3905)
         {
            this.addChild(this._warsoulEndBtn);
         }
         if(this.isPetChallenge || this.isMonopolyHelp || this.isBattleSign)
         {
            this.addChild(this._stripView);
            this.addChild(this._settingBtn);
         }
         else if(this.isPetBatle)
         {
            this.addChild(this._petBar);
         }
         else if(this.isSacristyBatle)
         {
            this.addChild(this._sacristyBar);
         }
         else if(this.isChildpveBatle)
         {
            this.addChild(this._childpveBar);
         }
         else if(this.isSpiritExpedition)
         {
            this.addChild(this._settingBtn);
         }
         else if(this.isYLExpedtion)
         {
            this.addChild(this._settingBtn);
         }
         else if(this.isDarkMaze)
         {
            this.addChild(this._settingBtn);
         }
         else if(this.battleModel.isChildBattle)
         {
            this.addChild(this._childCommomBar);
         }
         else if(this.battleModel.isMonsterBattle)
         {
            this.addChild(this._monsterCommomBar);
         }
         else if(this.isSpaceTimeBattle)
         {
            this.addChild(this._battleSpaceTimeView);
            this.addChild(this._bottomBar);
         }
         else if(!this.isSelfChess)
         {
            this.addChild(this._bottomBar);
         }
         if(!this.isNoHeroBattleType())
         {
            if(this._dragonTitanOfTeamMate)
            {
               this.addChild(this._dragonTitanOfTeamMate);
            }
            if(this._dragonTitanOfEnemies)
            {
               this.addChild(this._dragonTitanOfEnemies);
            }
         }
         if(this.battleModel.isPvP())
         {
            this._hurtUpView = new ($.C("battle.view.ui.HurtUpView"))(this.battleModel.getHurtMode());
            this.addChild(this._hurtUpView);
         }
         if(this.battleModel.isTrail() || this.isSpaceTimeBattle)
         {
            this._trailCountView = new ($.C("battle.view.ui.TrailCountView"))();
            this.addChild(this._trailCountView);
         }
         if(this.battleModel.isRaceAgainstTime())
         {
            this._trailCountView = new ($.C("battle.view.ui.TrailCountView"))();
            this.addChild(this._trailCountView);
            this._raceAgainstTimeUpView = new ($.C("battle.view.ui.RaceAgainstTimeUpView"))();
            this.addChild(this._raceAgainstTimeUpView);
         }
         if(this.battleModel.isForbiddenBoss())
         {
            this._forbiddenBossUIView = new ($.C("battle.view.ui.ForbiddenBossUIView"))();
            this.addChild(this._forbiddenBossUIView);
         }
         if(this.battleModel.isWarSoulTower())
         {
            this._trailCountView = new ($.C("battle.view.ui.TrailCountView"))();
            this.addChild(this._trailCountView);
         }
         this._batterUIView = new ($.C("battle.view.ui.BatterUIView"))();
         this._batterUIView.visible = false;
         this._batterUIView.y = 174;
         this._resistUIView1 = new ($.C("battle.view.ui.ResistUIView"))(1);
         this._resistUIView2 = new ($.C("battle.view.ui.ResistUIView"))(2);
         this._resistUIView1.visible = false;
         this._resistUIView2.visible = false;
         this._resistUIView1.y = 185;
         this._resistUIView2.y = 185;
         switch(this.battleModel.battleType)
         {
            case 310:
            case 3852:
               this._doubleBossShow = new ($.C("battle.view.ui.RoleShowViewIII"))();
               this._resistUIView1.y = 265;
               this._resistUIView2.y = 215;
               break;
            case 311:
            case 312:
               _loc3_ = ["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_0"];
               _loc4_ = [0,673];
               this._mutilRoleShowView = new ($.C("battle.view.ui.MutilBossShowView"))(_loc3_,_loc4_);
               break;
            case 313:
               _loc3_ = ["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_1","asset.battle.LiteBossBloodBar_1"];
               _loc4_ = [0,790,790];
               this._mutilRoleShowView = new ($.C("battle.view.ui.MutilBossShowView"))(_loc3_,_loc4_);
               break;
            case 295:
               this._roleShowII = new ($.C("battle.view.ui.RoleShowViewII"))();
               this._resistUIView1.y = 250;
               this._resistUIView2.y = 250;
               break;
            case 3855:
               this._outyardShowView = new ($.C("battle.view.ui.OutyardShowView"))();
               break;
            case 349:
            case 3867:
            case 3889:
               break;
            default:
               this._roleShowII = new ($.C("battle.view.ui.RoleShowViewII"))();
               this._resistUIView1.y = 265;
               this._resistUIView2.y = 215;
         }
         this._skillNameContainer = new ($.C("battle.view.skillname.SkillNameContainer"))();
         if(this._roleShowII)
         {
            this.addChild(this._roleShowII);
         }
         if(this._outyardShowView)
         {
            this.addChild(this._outyardShowView);
         }
         if(this._doubleBossShow)
         {
            this.addChild(this._doubleBossShow);
         }
         if(this._mutilRoleShowView)
         {
            this.addChild(this._mutilRoleShowView);
            this.updateMutilRoleShowView();
         }
         this.addChild(this._resistUIView1);
         this.addChild(this._resistUIView2);
         this.addChild(this._skillNameContainer);
         this._chatMessageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("battle.chatMessageBtn");
         this._consortiaChatBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("maintoolbar.ConsortiaChatBtn");
         this._chatMessageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.ui.BattleUIView.msgBoxTip");
         this._consortiaChatBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
         this.setMsgBtnShining();
         this.setConsortiaChatBtnShining();
         if($.C("yishi.manager.ArmyManager").instance.thane.grades >= 6)
         {
            this.addChild(this._chatMessageBtn);
         }
         if($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            this.addChild(this._consortiaChatBtn);
         }
         this._addSpBallLayer = new ($.C("flash.display.Sprite"))();
         this._addSpBallLayer.mouseChildren = this._addSpBallLayer.mouseEnabled = false;
         this.addChild(this._addSpBallLayer);
         this._autoFightFlag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.AutoFightFlagAsset");
         this._autoFightBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.AutoFightBtn2");
         this._autoFightStrip = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.autoFightStrip");
         this.updateAutoFightBtn(this.battleModel.getAutoFightFlag());
         this._autoFightBtn.addEventListener("click",$.bind(this, "onAutoFightClick"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("autoFightChanged",$.bind(this, "onAutoFightChanged"));
         this.addChild(this._autoFightBtn);
         this.addChild(this._autoFightStrip);
         this._autoFightStrip.setTarget(this._autoFightBtn);
         this._autoFightStrip.tipData = $.C("manager.LanguageMgr").GetTranslation("store.view.StoreFrame.command01",15);
         if($.C("yishi.manager.ArmyManager").instance.thane.grades >= 15)
         {
            this._autoFightStrip.visible = false;
         }
         else
         {
            this.battleAutoFightEnable = false;
            this._autoFightStrip.visible = true;
         }
         this._hideOthersBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.HideOthersBg");
         this._hideOthersBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.HideOthersBtn");
         this._hideOthersBtn.addEventListener("click",$.bind(this, "onHideOthersClick"));
         this._hideOthersBtn.selected = $.C("yishi.manager.SharedManager").instance.hideOthersInBattle;
         this._preSelected = $.C("yishi.manager.SharedManager").instance.hideOthersInBattle;
         this._hideOthersBtn.text = $.C("manager.LanguageMgr").GetTranslation("battle.view.ui.BattleUIView.hideOthersTip");
         if($.C("yishi.manager.ArmyManager").instance.thane.grades > 0)
         {
            this.addChild(this._hideOthersBg);
            this.addChild(this._hideOthersBtn);
         }
         $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.model.isOpenGroupChatTip = true;
         this._teamStripContainer1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.teamStripContainer1");
         this._teamStripContainer2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.teamStripContainer2");
         this.addChild(this._teamStripContainer1);
         this.addChild(this._teamStripContainer2);
         if($.C("battle.BattleManager").getInstance().battleModel.battleType == 295)
         {
            _loc1_ = new Date();
            $.C("battle.BattleManager").getInstance().battleModel.trialLayer = $.C("battle.BattleManager").molongLayer;
            this._trailCountView = new ($.C("battle.view.ui.TrailCountView"))();
            this.addChild(this._trailCountView);
         }
         if($.C("com.pickgliss.toplevel.StageReferance").isDebug)
         {
            this._killSelfBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.UseButton");
            this._killSelfBtn.addEventListener("click",$.bind(this, "_onKillSelfClick"));
            this._killSelfBtn.text = "自杀结束战斗";
            this.addChild(this._killSelfBtn);
            this._immediatelyWinBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.UseButton");
            this._immediatelyWinBtn.addEventListener("click",$.bind(this, "_onKillSelfClick"));
            this._immediatelyWinBtn.text = "胜利结束战斗";
            this.addChild(this._immediatelyWinBtn);
         }
      }
    get selfSide() {
         return this.battleModel.selfSide;
      }
    get enemySide() {
         return 3 - this.battleModel.selfSide;
      }
    hasTitanInThisBattle() {
         var _loc3_ = null;
         var _loc2_ = 0;
         var _loc1_ = false;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = this.battleModel.heroList[_loc2_ + "_" + this.selfSide];
            if(_loc3_ && _loc3_.titanId > 0)
            {
               return true;
            }
            _loc3_ = this.battleModel.heroList[_loc2_ + "_" + this.enemySide];
            if(_loc3_ && _loc3_.titanId > 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
    isNoHeroBattleType() {
         return this.battleModel.battleType == 3847 || this.battleModel.battleType == 3845 || this.battleModel.battleType == 3844 || this.battleModel.battleType == 35 || this.battleModel.battleType == 3867 || this.battleModel.battleType == 3889 || this.battleModel.battleType == 3895 || this.battleModel.battleType == 3868 || this.battleModel.battleType == 3898 || this.battleModel.battleType == 3907;
      }
    _onKillSelfClick(param1) {
         var _loc3_ = 2;
         if(param1.currentTarget == this._immediatelyWinBtn)
         {
            _loc3_ = 1;
         }
         var _loc4_ = new ($.C("yishi.comm.PackageOut"))(14002);
         var _loc2_ = new ($.C("com.road.yishi.proto.battle.BattleReqMsg"))();
         _loc2_.battleId = $.C("battle.BattleManager").getInstance().battleModel.battleId;
         _loc2_.otherObj = _loc3_;
         $.C("yishi.service.managers.SocketSendManager").instance.sendProtoBuffer(_loc4_,_loc2_);
      }
    updateMutilRoleShowView(... rest) {
         var _loc2_ = false;
         switch($.int(this.battleModel.battleType) - 311)
         {
            case 0:
            case 1:
            case 2:
               _loc2_ = Boolean(rest.length > 0 ? rest[0] : false);
               this.nldlyiUpdateMutilRoleShowView(_loc2_);
               return;
            default:
               return;
         }
      }
    nldlyiUpdateMutilRoleShowView(param1) {
         var _loc2_ = undefined;
         var _loc7_ = null;
         var _loc5_ = null;
         var _loc3_ = 0;
         var _loc8_ = 0;
         var _loc4_ = 0;
         var _loc6_ = this.battleModel.armyInfoRight.boss;
         if(param1)
         {
            this._mutilRoleShowView.resetRoleData(_loc6_);
         }
         else
         {
            _loc2_ = [_loc6_];
            _loc3_ = $.uint(this.battleModel._heroTempId.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc8_ = $.uint(this.battleModel._heroTempId[_loc4_]);
               if(_loc8_ != _loc6_.templateId)
               {
                  _loc7_ = new ($.C("yishi.datas.objects.HeroRoleInfo"))();
                  _loc7_.templateId = _loc8_;
                  _loc7_.heroInfo.templateId = _loc8_;
                  _loc5_ = $.C("yishi.manager.TempleteManager").instance.gameHeroTemplateCate.getTemplateByID(_loc8_);
                  _loc7_.heroInfo.nickName = _loc5_.TemplateName;
                  _loc7_.totalBloodA = _loc5_.Live;
                  _loc7_.bloodA = _loc4_ < this.battleModel._life.length ? $.C("battle.utils.Int64Utils").int64ToNumber(this.battleModel._life[_loc4_]) : Number(_loc7_.totalBloodA);
                  _loc2_.push(_loc7_);
               }
               _loc4_++;
            }
            this._mutilRoleShowView.setRoleData(_loc2_,_loc6_);
            if(this.battleModel.battleType == 313)
            {
               this._nldlyiSynBloodRoleInfo = _loc6_;
               this._mutilRoleShowView.worldBossRoleInfo = _loc6_;
            }
            else
            {
               this._nldlyiSynBloodRoleInfo = _loc7_;
               this._mutilRoleShowView.worldBossRoleInfo = null;
            }
            if(!$.C("yishi.service.managers.SocketManager").instance.hasEventListener("SLGSocketEvent" + 4794))
            {
               $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4794,$.bind(this, "nldlyiOtherBossHPSyncHandler"));
            }
         }
      }
    nldlyiOtherBossHPSyncHandler(param1) {
         var _loc4_ = false;
         var _loc6_ = NaN;
         var _loc5_ = 0;
         var _loc8_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.simple.WorldBossInfoMsg"))();
         _loc2_ = $.as(_loc8_.readBody(_loc2_), $.C("com.road.yishi.proto.simple.WorldBossInfoMsg"));
         var _loc7_ = Number($.C("battle.utils.Int64Utils").int64ToNumber(_loc2_.currentMillis));
         var _loc3_ = Number($.C("battle.utils.Int64Utils").int64ToNumber(_loc2_.curHp));
         if(this._nldlyiSynBloodRoleInfo != null)
         {
            if(this.battleModel.battleType == 313)
            {
               $.C("battle.BattleManager").getInstance().battleModel.updateWorldBossBlood(_loc3_,_loc7_);
            }
            else
            {
               _loc4_ = _loc3_ - this._nldlyiSynBloodRoleInfo.bloodA > this._nldlyiSynBloodRoleInfo.totalBloodA * 0.6;
               _loc6_ = this._nldlyiSynBloodRoleInfo.bloodA - _loc3_;
               this._nldlyiSynBloodRoleInfo.bloodA = _loc3_;
               if(_loc4_)
               {
                  this._mutilRoleShowView.resetRoleData(this._nldlyiSynBloodRoleInfo);
               }
               else
               {
                  this._mutilRoleShowView.playDamageNumEffect(this._nldlyiSynBloodRoleInfo.templateId,_loc6_);
               }
               this._nldlyiSynBloodRoleInfo.dispatchEvent(new ($.C("yishi.events.RoleEvent"))("bloodChange",this._nldlyiSynBloodRoleInfo));
            }
            _loc5_ = $.int(this.battleModel._heroTempId.indexOf(this._nldlyiSynBloodRoleInfo.templateId));
            if(_loc5_ >= 0 && _loc5_ < this.battleModel._life.length)
            {
               this.battleModel._life[_loc5_] = $.C("battle.utils.Int64Utils").numberToInt64(this._nldlyiSynBloodRoleInfo.bloodA);
            }
         }
      }
    addTeamStrip(param1) {
         var _loc2_ = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.isPetFake)
         {
            return;
         }
         if(param1.isChildFake)
         {
            return;
         }
         if($.is(param1, $.C("yishi.datas.objects.MonsterRoleInfo")))
         {
            return;
         }
         if($.is(param1, $.C("yishi.datas.objects.SelfChessRoleInfo")))
         {
            return;
         }
         if(this.battleModel.battleType == 3907)
         {
            return;
         }
         var _loc3_ = $.int(this.battleModel.selfSide);
         if(param1.side == _loc3_)
         {
            if(param1.heroInfo.userId != $.C("yishi.manager.ArmyManager").instance.thane.userId)
            {
               _loc2_ = new ($.C("battle.view.ui.TeamStrip"))(param1,1);
               this._teamStripContainer1.addChild(_loc2_);
               if(this._teamStripHashmap == null)
               {
                  this._teamStripHashmap = new ($.C("yishi.utils.HashMap"))();
               }
               this._teamStripHashmap.put(param1.userId,_loc2_);
            }
         }
         else
         {
            this._teamStripContainer2.addChild(new ($.C("battle.view.ui.TeamStrip"))(param1,2));
         }
      }
    removeDieRole(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this._teamStripHashmap)
         {
            return;
         }
         var _loc2_ = $.as(this._teamStripHashmap.getValue(param1), $.C("battle.view.ui.TeamStrip"));
         if(_loc2_ && this._teamStripContainer1.contains(_loc2_))
         {
            this._teamStripContainer1.removeChild(_loc2_);
            this._teamStripHashmap.remove(param1);
         }
      }
    onAutoFightChanged(param1) {
         if(this.battleModel && !this.battleModel.isOver)
         {
            this.updateAutoFightBtn(this.battleModel.getAutoFightFlag());
         }
      }
    updateAutoFightBtn(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(param1 == 1)
         {
            this._autoFightBtn.selected = false;
            if(!this._autoFightFlag.parent)
            {
               this.addChild(this._autoFightFlag);
            }
            this._skillListOffsetX = 0;
         }
         else
         {
            this._autoFightBtn.selected = true;
            if(this._autoFightFlag.parent)
            {
               this.removeChild(this._autoFightFlag);
            }
            this._skillListOffsetX = 320;
         }
         var _loc3_ = this.battleModel.isMultiPlayer() || !$.C("yishi.datas.BattleModel").allowAutoFight;
         if(this.battleModel.battleType == 3846)
         {
            this._autoFightBtn.visible = this._autoFightStrip.visible = false;
         }
         if(_loc3_)
         {
            if(this._autoFightBtn)
            {
               this.battleAutoFightEnable = false;
            }
         }
         var _loc2_ = $.int($.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageWidth,1000,1500));
      }
    onAutoFightClick(param1) {
         var _loc2_ = null;
         if(!this._autoFightBtn.enable)
         {
            return;
         }
         if(this.battleModel.isMultiPlayer() && this.battleModel.battleType != 3886)
         {
            this._autoFightBtn.selected = true;
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("battle.view.ui.BattleUIView.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_,true,null,true);
            return;
         }
         if(this.battleModel.getAutoFightFlag() == 1)
         {
            this.battleModel.setAutoFight(2);
         }
         else
         {
            this.battleModel.setAutoFight(1);
         }
      }
    get autoFightBtn() {
         return this._autoFightBtn;
      }
    onHideOthersClick(param1) {
         $.C("yishi.manager.SharedManager").instance.hideOthersInBattle = this._hideOthersBtn.selected;
         $.C("yishi.manager.SharedManager").instance.saveHideOthersInBattle();
         this._preSelected = this._hideOthersBtn.selected;
         this.battleModel.otherLivingVisible = !this._hideOthersBtn.selected;
      }
    getDragonTitanOfTeamMate() {
         return this._dragonTitanOfTeamMate;
      }
    getDragonTitanOfEnemies() {
         return this._dragonTitanOfEnemies;
      }
    getBottomBar() {
         if(this.isSacristyBatle)
         {
            return this._sacristyBar;
         }
         return this._bottomBar;
      }
    get hasGoddessUI() {
         if(this._selfGoddessTopView || this._vsGoddessTopView)
         {
            return true;
         }
         return false;
      }
    getHideBtn() {
         return this._hideOthersBtn;
      }
    showTopView() {
         if(this._outyardShowView)
         {
            this._outyardShowView.visible = true;
         }
         if(this._roleShowII)
         {
            this._roleShowII.visible = true;
         }
         if(this._doubleBossShow)
         {
            this._doubleBossShow.visible = true;
         }
         if(this._mutilRoleShowView)
         {
            this._mutilRoleShowView.visible = true;
         }
      }
    hideTopView() {
         if(this._outyardShowView)
         {
            this._outyardShowView.visible = false;
         }
         if(this._roleShowII)
         {
            this._roleShowII.visible = false;
         }
         if(this._doubleBossShow)
         {
            this._doubleBossShow.visible = false;
         }
         if(this._mutilRoleShowView)
         {
            this._mutilRoleShowView.visible = false;
         }
      }
    getAddSpBallLayer() {
         return this._addSpBallLayer;
      }
    getAddSpDestPoint() {
         var _loc1_ = this._bottomBar.getSpGlobalPos();
         return this._addSpBallLayer.globalToLocal(_loc1_);
      }
    getAddHitPointDestPoint() {
         var _loc1_ = this._bottomBar.getHitPointGlobalPos();
         return this._addSpBallLayer.globalToLocal(_loc1_);
      }
    __skillUseSuccess(param1) {
         if($.int(param1.data[1]) > 0 && this.battleModel && !this.battleModel.isControledByBoss())
         {
            if(this._qteView)
            {
               this._qteView.dispose();
            }
            this._qteView = null;
            this._qteView = new ($.C("battle.qte.QteView"))(param1.data);
            this.addChild(this._qteView);
            this._qteView.x = (this._sceneWidth - this._qteView.width) / 2;
            this._qteView.y = this._sceneHeight - 280;
         }
         if(!this.battleModel.isAutoFight)
         {
            $.C("battle.BattleManager").getInstance().battleMap.addSkillAimFlag(param1.data[3]);
         }
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    get isBattleSign() {
         var _loc1_ = false;
         if(this.battleModel.battleType == 16)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
    get isPetChallenge() {
         if(this.battleModel.battleType == 35)
         {
            return true;
         }
         return false;
      }
    get isYLExpedtion() {
         if(this.battleModel.battleType == 3896)
         {
            return true;
         }
         return false;
      }
    get isSpiritExpedition() {
         if(this.battleModel.battleType == 3895)
         {
            return true;
         }
         return false;
      }
    get isDarkMaze() {
         if(this.battleModel.battleType == 3898)
         {
            return true;
         }
         return false;
      }
    get isShadowLand() {
         if(this.battleModel.battleType == 3897)
         {
            return true;
         }
         return false;
      }
    get isPetBatle() {
         if(this.battleModel.battleType == 3844)
         {
            return true;
         }
         return false;
      }
    get isSacristyBatle() {
         if(this.battleModel.battleType == 3866 || this.battleModel.battleType == 3864)
         {
            return true;
         }
         return false;
      }
    get isSelfChess() {
         if(this.battleModel.battleType == 349)
         {
            return true;
         }
         return false;
      }
    get isSpaceTimeBattle() {
         if(this.battleModel.battleType == 3870)
         {
            return true;
         }
         return false;
      }
    get isChildpveBatle() {
         if(this.battleModel.battleType == 3845)
         {
            return true;
         }
         return false;
      }
    get isChildArenaBattle() {
         if(this.battleModel.battleType == 3847)
         {
            return true;
         }
         return false;
      }
    get isMonopolyHelp() {
         if(this.battleModel.battleType == 307)
         {
            return true;
         }
         return false;
      }
    reFreshBuffer(param1) {
         var _loc2_ = 0;
         var _loc3_ = new $.Vector();
         if(this._roleShowII && this._roleShowII.bossBufferContainer && param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(this._roleShowII.livingId == param1[_loc2_].target)
               {
                  _loc3_.push(param1[_loc2_]);
               }
               _loc2_++;
            }
            this._roleShowII.bossBufferContainer.reFreshBuffer(_loc3_);
         }
      }
    refreshTurn() {
         if(this._roleShowII && this._roleShowII.bossBufferContainer)
         {
            this._roleShowII.bossBufferContainer.refreshTurn();
         }
         if(this._doubleBossShow && this._doubleBossShow.bossBufferContainer1)
         {
            this._doubleBossShow.bossBufferContainer1.refreshTurn();
         }
         if(this._doubleBossShow && this._doubleBossShow.bossBufferContainer2)
         {
            this._doubleBossShow.bossBufferContainer2.refreshTurn();
         }
         if(this._mutilRoleShowView)
         {
            this._mutilRoleShowView.refreshTurn();
         }
      }
    bufferDispose(param1 = null) {
         if(this._roleShowII && this._roleShowII.bossBufferContainer)
         {
            this._roleShowII.bossBufferContainer.disposeBossInfo(param1);
         }
      }
    bossReinforce(param1) {
         if(this._roleShowII)
         {
            this._roleShowII.bossReinforce(param1);
         }
      }
    setReinforceWaveInfo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(this._roleShowII)
         {
            this._roleShowII.setReinforceWaveInfo(param1,param2);
         }
      }
    dispose() {
         if(this._teamStripHashmap)
         {
            this._teamStripHashmap.clear();
            this._teamStripHashmap = null;
         }
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimer"));
            this._timer.removeEventListener("timerComplete",$.bind(this, "__onTimerComplete"));
            this._timer = null;
         }
         this.removeEvent();
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("autoFightChanged",$.bind(this, "onAutoFightChanged"));
         $.C("managers.PetSacristyManager").instance.awake = 0;
         if($.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.isVisible() || Boolean($.C("ui.maintoolbar.MainToolBar").instance.poptipButtonVisible))
         {
            $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.model.isOpenGroupChatTip = false;
            $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.consortiaBtnShining = false;
            $.C("managers.IMManager").instance.friendBtnShining = false;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hurtUpView);
         this._hurtUpView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._trailCountView);
         this._trailCountView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._raceAgainstTimeUpView);
         this._raceAgainstTimeUpView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatMessageBtn);
         this._chatMessageBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consortiaChatBtn);
         this._consortiaChatBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._finishNowBtn);
         this._finishNowBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._settingBtn);
         this._settingBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stripView);
         this._stripView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countdownNumTxt);
         this._countdownNumTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countdownTxt);
         this._countdownTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countdownTxt2);
         this._countdownTxt2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._killSelfBtn);
         this._killSelfBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._immediatelyWinBtn);
         this._immediatelyWinBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hideOthersBg);
         this._hideOthersBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hideOthersBtn);
         this._hideOthersBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._autoFightStrip);
         this._autoFightStrip = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._autoFightBtn);
         this._autoFightBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bottomBar);
         this._bottomBar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTitanOfTeamMate);
         this._dragonTitanOfTeamMate = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dragonTitanOfEnemies);
         this._dragonTitanOfEnemies = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selfGoddessTopView);
         this._selfGoddessTopView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vsGoddessTopView);
         this._vsGoddessTopView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._petBar);
         this._petBar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sacristyBar);
         this._sacristyBar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childpveBar);
         this._childpveBar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillNameContainer);
         this._skillNameContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._forbiddenBossUIView);
         this._forbiddenBossUIView = null;
         if(this._outyardShowView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._outyardShowView);
         }
         this._outyardShowView = null;
         if(this._roleShowII)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._roleShowII);
         }
         this._roleShowII = null;
         if(this._doubleBossShow)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._doubleBossShow);
         }
         this._doubleBossShow = null;
         if(this._mutilRoleShowView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mutilRoleShowView);
         }
         this._mutilRoleShowView = null;
         if(this._qteView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._qteView);
         }
         this._qteView = null;
         if(this._batterUIView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._batterUIView);
         }
         this._batterUIView = null;
         if(this._battleSpaceTimeView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._battleSpaceTimeView);
         }
         this._battleSpaceTimeView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resistUIView1);
         this._resistUIView1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resistUIView2);
         this._resistUIView2 = null;
         if(this._delay)
         {
            this._delay.cancel();
         }
         this._delay = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._addSpBallLayer);
         this._addSpBallLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._autoFightFlag);
         this._autoFightFlag = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._teamStripContainer1);
         this._teamStripContainer1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._teamStripContainer2);
         this._teamStripContainer2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childCommomBar);
         this._childCommomBar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._monsterCommomBar);
         this._monsterCommomBar = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get battleAutoFightEnable() { return super.battleAutoFightEnable; }
    set selfSide(v) { super.selfSide = v; }
    set enemySide(v) { super.enemySide = v; }
    set autoFightBtn(v) { super.autoFightBtn = v; }
    set hasGoddessUI(v) { super.hasGoddessUI = v; }
    set battleModel(v) { super.battleModel = v; }
    set isBattleSign(v) { super.isBattleSign = v; }
    set isPetChallenge(v) { super.isPetChallenge = v; }
    set isYLExpedtion(v) { super.isYLExpedtion = v; }
    set isSpiritExpedition(v) { super.isSpiritExpedition = v; }
    set isDarkMaze(v) { super.isDarkMaze = v; }
    set isShadowLand(v) { super.isShadowLand = v; }
    set isPetBatle(v) { super.isPetBatle = v; }
    set isSacristyBatle(v) { super.isSacristyBatle = v; }
    set isSelfChess(v) { super.isSelfChess = v; }
    set isSpaceTimeBattle(v) { super.isSpaceTimeBattle = v; }
    set isChildpveBatle(v) { super.isChildpveBatle = v; }
    set isChildArenaBattle(v) { super.isChildArenaBattle = v; }
    set isMonopolyHelp(v) { super.isMonopolyHelp = v; }
  }
  $.meta(__BattleUIView, "battle.view.ui.BattleUIView", []);
  return __BattleUIView;
}
deps["battle.view.ui.BattleUIView"] = ["battle.BattleManager", "battle.events.BattleEvent", "battle.net.BattleSocketOuterManager", "battle.qte.QteView", "battle.utils.BattleFunctionHelper", "battle.utils.Helpers", "battle.utils.Int64Utils", "battle.view.bottom.BottomBar", "battle.view.bottom.ChildCommonBottomBar", "battle.view.bottom.ChildpveBattleBar", "battle.view.bottom.MonsterCommonBottomBar", "battle.view.bottom.PetBattleBar", "battle.view.bottom.PetSacristyBar", "battle.view.skillname.SkillNameContainer", "battle.view.ui.BatterUIView", "battle.view.ui.BattleSkillItemII", "battle.view.ui.BattleSpaceTimeView", "battle.view.ui.DragonTitanTeamView", "battle.view.ui.ForbiddenBossUIView", "battle.view.ui.HurtUpView", "battle.view.ui.MutilBossShowView", "battle.view.ui.OutyardShowView", "battle.view.ui.RaceAgainstTimeUpView", "battle.view.ui.ResistUIView", "battle.view.ui.RoleShowViewII", "battle.view.ui.RoleShowViewIII", "battle.view.ui.TeamStrip", "battle.view.ui.TrailCountView", "battle.view.ui.top.BattleGoddessTopView", "chat.datas.ChatData", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "com.road.yishi.proto.battle.BattleReqMsg", "com.road.yishi.proto.battle.TriggerSkillMsg", "com.road.yishi.proto.simple.WorldBossInfoMsg", "flash.display.Sprite", "flash.events.KeyboardEvent", "flash.geom.Point", "flash.utils.Timer", "flash.utils.clearTimeout", "flash.utils.setTimeout", "manager.LanguageMgr", "managers.IMManager", "managers.PetSacristyManager", "managers.VIPManager", "ui.maintoolbar.MainToolBar", "yishi.comm.PackageIn", "yishi.comm.PackageOut", "yishi.datas.BattleModel", "yishi.datas.objects.HeroRoleInfo", "yishi.datas.objects.MonsterRoleInfo", "yishi.datas.objects.SelfChessRoleInfo", "yishi.events.RoleEvent", "yishi.manager.ArmyManager", "yishi.manager.ConfigManager", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.SharedManager", "yishi.manager.TempleteManager", "yishi.service.managers.SocketManager", "yishi.service.managers.SocketSendManager", "yishi.utils.HashMap", "yishi.utils.SimpleAlertHelper", "yishi.utils.TimerUtils", "yishi.view.component.TileContainer", "yishi.view.tips.MessageTipManager"];

defs["battle.view.ui.ChildNswarBattleRoleIcon"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ChildNswarBattleRoleIcon extends __Base {
    static $fields(self) {
    self._icon = null;
    self._bg = null;
    self._idxBg = null;
    self._idxTxt = null;
    self._fightIng = null;
    self._dieImg = null;
    self._idx = 0;
    self._side = 0;
    self._mShape = null;
    }
    constructor(param1, param2) {
         super();
         this._idx = param1;
         this._side = param2;
         this.initView();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarIconBg");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("childnswar.battle.childIcon");
         this._dieImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarDie");
         if(this._side == 1)
         {
            this._idxBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.childnswar.IdxLeftImg");
            this._idxTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.childnswar.leftIdx");
            this._fightIng = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarLeft");
         }
         else
         {
            this._idxBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.childnswar.IdxRightImg");
            this._idxTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.childnswar.rightIdx");
            this._fightIng = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarRight");
         }
         this._mShape = new ($.C("flash.display.Shape"))();
         this._mShape.graphics.beginFill(16711680);
         this._mShape.graphics.drawCircle(0,0,20);
         this._mShape.graphics.endFill();
         this._mShape.x = 27.5;
         this._mShape.y = 30;
         this.addChild(this._bg);
         this.addChild(this._icon);
         this.addChild(this._mShape);
         this.addChild(this._idxBg);
         this.addChild(this._idxTxt);
         this.addChild(this._fightIng);
         this.addChild(this._dieImg);
         this._dieImg.visible = false;
         this._fightIng.visible = false;
         this._icon.mask = this._mShape;
         this._idxTxt.text = "" + this._idx;
      }
    updateView(param1) {
         var _loc2_ = null;
         if(param1)
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.childTemplateCate.getTemplateByJobAndGrades(param1.jobType,1);
            this._icon.icon = $.C("yishi.manager.PathManager").info.ResourcePath + "icon" + _loc2_.Icon;
            this._dieImg.visible = false;
            this._fightIng.visible = false;
            switch($.int(param1.state))
            {
               case 0:
                  break;
               case 1:
                  this._fightIng.visible = true;
                  break;
               case 2:
                  this._dieImg.visible = true;
            }
         }
         else
         {
            this._icon.icon = null;
            this._fightIng.visible = false;
            this._dieImg.visible = false;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._idxBg);
         this._idxBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._idxTxt);
         this._idxTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightIng);
         this._fightIng = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dieImg);
         this._dieImg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ChildNswarBattleRoleIcon, "battle.view.ui.ChildNswarBattleRoleIcon", []);
  return __ChildNswarBattleRoleIcon;
}
deps["battle.view.ui.ChildNswarBattleRoleIcon"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Shape", "flash.display.Sprite", "yishi.manager.PathManager", "yishi.manager.TempleteManager"];

defs["battle.view.ui.DragonTitanIconItemView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DragonTitanIconItemView extends __Base {
    static $fields(self) {
    self._data = null;
    self._titanId = 0;
    self._skillBg1 = null;
    self._icon = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._skillBg1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dragontitan.skillBg1");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("dragontitan.DragonTitanIconItemView.icon");
         this.addChild(this._skillBg1);
         this.addChild(this._icon);
      }
    set data(param1) {
         if(!param1)
         {
            return;
         }
         this._data = param1;
         this.tipData = this._data.livingId;
         this.tipStyle = "yishi.view.tips.DragonTitanFightingTips";
         this.isFollowMouse = false;
         this.tipDirctions = "2,1";
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.titanTemplateCate.getTemplateById(this._data.titanId);
         if(this._icon && _loc2_)
         {
            this._icon.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(_loc2_.AvatarPath);
         }
      }
    get width() {
         return 67;
      }
    get data() {
         return this._data;
      }
    unInitView() {
         if(this._skillBg1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillBg1);
         }
         this._skillBg1 = null;
         if(this._icon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         }
         this._icon = null;
      }
    initEvent() {
      }
    removeEvent() {
      }
    get model() {
         return $.C("managers.DragonTitanManager").instance.model;
      }
    dispose() {
         this.dispatchEvent(new ($.C("flash.events.MouseEvent"))("rollOut"));
         $.C("com.pickgliss.ui.ShowTipManager").Instance.hideTip(this);
         this.removeEvent();
         this.unInitView();
         super.dispose();
      }
    get titanId() {
         return this._titanId;
      }
    set titanId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._titanId = param1;
      }
    set width(v) { super.width = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DragonTitanIconItemView, "battle.view.ui.DragonTitanIconItemView", []);
  return __DragonTitanIconItemView;
}
deps["battle.view.ui.DragonTitanIconItemView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.events.MouseEvent", "managers.DragonTitanManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["battle.view.ui.DragonTitanTeamView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DragonTitanTeamView extends __Base {
    static $fields(self) {
    self.side = 1;
    self._isHide = false;
    self._titanList = null;
    self._fightBg = null;
    self._hidebtn = null;
    self._hideImgTxt = null;
    self._expandImgTxt = null;
    self._clickArea = null;
    self.isTweening = false;
    }
    constructor(param1 = 1) {
         $.pre(new.target, (__s) => {
         __s.side = param1;
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
         this.initEvent();
      }
    initView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._fightBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dragontitan.fightBg");
         this._hidebtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dragontitan.hidebtn");
         this._hideImgTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dragontitan.hideImgTxt");
         this._expandImgTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("dragontitan.expandImgTxt");
         this.addChild(this._fightBg);
         this._clickArea = new ($.C("flash.display.Sprite"))();
         this._clickArea.addChild(this._hidebtn);
         this._clickArea.addChild(this._hideImgTxt);
         this._clickArea.addChild(this._expandImgTxt);
         this.addChild(this._clickArea);
         if(this.isSingleBattle())
         {
            this._fightBg.visible = false;
            this._clickArea.visible = false;
         }
         this._titanList = new $.Vector();
         if(this.isSelfSide())
         {
            this._fightBg.scaleX *= -1;
            this._fightBg.x = 120;
            this._hidebtn.x = 100;
            this._hideImgTxt.x = 97;
            this._expandImgTxt.x = 97;
         }
         else
         {
            this._hidebtn.x = 11;
            this._hideImgTxt.x = 8;
            this._expandImgTxt.x = 8;
         }
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new ($.C("battle.view.ui.DragonTitanIconItemView"))();
            if(this.isSelfSide())
            {
               _loc1_.x = 13;
            }
            else
            {
               _loc1_.x = 40;
            }
            _loc1_.y = 13 + _loc2_ * 70;
            this.addChild(_loc1_);
            this._titanList.push(_loc1_);
            _loc2_++;
         }
         this.refreshView();
      }
    isSelfSide() {
         return $.C("battle.BattleManager").getInstance().battleModel.selfSide == this.side;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    refreshView() {
         if(this._isHide)
         {
            if(this.isSelfSide())
            {
               this._hidebtn.scaleX = 1;
               this._hidebtn.x = 100;
            }
            else
            {
               this._hidebtn.scaleX = -1;
               this._hidebtn.x = 21;
            }
            this._hideImgTxt.visible = false;
            this._expandImgTxt.visible = true;
         }
         else
         {
            if(this.isSelfSide())
            {
               this._hidebtn.scaleX = -1;
               this._hidebtn.x = 110;
            }
            else
            {
               this._hidebtn.scaleX = 1;
               this._hidebtn.x = 11;
            }
            this._hideImgTxt.visible = true;
            this._expandImgTxt.visible = false;
         }
         this.refreshData();
      }
    __refreshViewHandler(param1) {
         this.refreshView();
      }
    refreshData() {
         var _loc1_ = 0;
         this._titanList[0].data = this.getDataObj(this.battleModel.heroList["0_" + this.side]);
         this._titanList[1].data = this.getDataObj(this.battleModel.heroList["1_" + this.side]);
         this._titanList[2].data = this.getDataObj(this.battleModel.heroList["2_" + this.side]);
         this._titanList[3].data = this.getDataObj(this.battleModel.heroList["3_" + this.side]);
         if(this.isSingleBattle())
         {
            _loc1_ = 0;
            while(_loc1_ < this._titanList.length)
            {
               if(!this._titanList[_loc1_].data)
               {
                  this._titanList[_loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
    isSingleBattle() {
         switch($.int(this.battleModel.battleType) - 3842)
         {
            case 0:
            case 12:
               return false;
            default:
               if(this.battleModel.battleCapity == 1)
               {
                  return true;
               }
               switch(this.battleModel.battleType)
               {
                  case 18:
                  case 25:
                  case 3870:
                  case 13:
                  case 10:
                  case 290:
                  case 295:
                  case 310:
                  case 291:
                  case 3841:
                  case 3842:
                  case 314:
                  case 305:
                  case 3852:
                  case 3853:
                  case 3877:
                  case 3878:
                  case 3891:
                  case 3894:
                     break;
                  case 306:
                  case 307:
                  case 293:
                  case 3871:
                  case 3893:
                     return true;
                  default:
                     return this.getAttackerNum() == 1;
               }
               return false;
         }
      }
    getAttackerNum() {
         var _loc2_ = 0;
         var _loc1_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(this.battleModel.heroList[_loc2_ + "_" + this.side])
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
    getDataObj(param1) {
         if(!param1)
         {
            return null;
         }
         var _loc2_ = {};
         _loc2_.livingId = param1.livingId;
         _loc2_.titanId = param1.titanId;
         _loc2_.titanSkill = param1.titanSkill;
         return _loc2_;
      }
    initEvent() {
         if(this._clickArea)
         {
            this._clickArea.addEventListener("click",$.bind(this, "__clickHandler"));
         }
         $.C("yishi.manager.NotificationManager").instance.addEventListener("BATTLE_REINFORCE_HANDLER",$.bind(this, "__refreshViewHandler"));
      }
    __clickHandler(param1) {
         var toX;
         var _sceneWidth;
         var event = param1;
         if(this.isTweening)
         {
            return;
         }
         _sceneWidth = Number($.C("battle.utils.Helpers").limitRange($.C("com.pickgliss.toplevel.StageReferance").stage.stageWidth,1000,1500));
         if(this._isHide)
         {
            if(this.isSelfSide())
            {
               toX = 0;
            }
            else
            {
               toX = _sceneWidth - 120;
            }
         }
         else if(this.isSelfSide())
         {
            toX = -91;
         }
         else
         {
            toX = _sceneWidth - 29;
         }
         this._isHide = !this._isHide;
         this.refreshView();
         this.isTweening = true;
         $.C("com.greensock.TweenLite").to(this,0.4,{
            "x":toX,
            "onComplete":() =>
            {
               this.isTweening = false;
            }
         });
      }
    removeEvent() {
         if(this._clickArea)
         {
            this._clickArea.removeEventListener("click",$.bind(this, "__clickHandler"));
         }
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("BATTLE_REINFORCE_HANDLER",$.bind(this, "__refreshViewHandler"));
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightBg);
         this._fightBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hidebtn);
         this._hidebtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hideImgTxt);
         this._hideImgTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._expandImgTxt);
         this._expandImgTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._clickArea);
         this._clickArea = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this._titanList);
         this._titanList = null;
         super.dispose();
      }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__DragonTitanTeamView, "battle.view.ui.DragonTitanTeamView", []);
  return __DragonTitanTeamView;
}
deps["battle.view.ui.DragonTitanTeamView"] = ["battle.BattleManager", "battle.utils.Helpers", "battle.view.ui.DragonTitanIconItemView", "com.greensock.TweenLite", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "utils.LogicUtils", "yishi.manager.NotificationManager"];

defs["battle.view.ui.ForbiddenBossUIView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ForbiddenBossUIView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._nickNameTxt = null;
    self._consortiaNameTxt = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.refreshView();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("forbiddenBossUIView.bg");
         this._nickNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("forbiddenBossUIView.nickNameTxt");
         this._consortiaNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("forbiddenBossUIView.consortiaNameTxt");
         this.addChild(this._bg);
         this.addChild(this._nickNameTxt);
         this.addChild(this._consortiaNameTxt);
      }
    addEvent() {
         $.C("yishi.utils.MsgMan").addObserver("FORBIDDEN_BOSS_RANK_UPDATE",this,$.bind(this, "__updateRankHandler"));
      }
    removeEvent() {
         $.C("yishi.utils.MsgMan").removeObserver("FORBIDDEN_BOSS_RANK_UPDATE",this,$.bind(this, "__updateRankHandler"));
      }
    __updateRankHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshView();
      }
    refreshView() {
         var _loc1_ = null;
         var _loc2_ = $.C("yishi.manager.ForbiddenBossManager").instance.model;
         if(_loc2_.rankList.length > 0)
         {
            _loc1_ = _loc2_.rankList[0];
            this._nickNameTxt.text = _loc1_.nickName;
            if(_loc1_.consortiaName != "")
            {
               this._consortiaNameTxt.text = $.C("manager.LanguageMgr").GetTranslation("forbiddenBossRankItem.consortiaNameTxt.text",_loc1_.consortiaName);
            }
            else
            {
               this._consortiaNameTxt.text = "";
            }
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ForbiddenBossUIView, "battle.view.ui.ForbiddenBossUIView", ["Disposeable"]);
  return __ForbiddenBossUIView;
}
deps["battle.view.ui.ForbiddenBossUIView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.ForbiddenBossManager", "yishi.utils.MsgMan"];

defs["battle.view.ui.HurtUpView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __HurtUpView extends __Base {
    static $fields(self) {
    self._mode = null;
    self._tipBack = null;
    self._tipTxt = null;
    self._countDownBack = null;
    self._countDownWord = null;
    self._countDownValue = null;
    self._leftChidNsIconBox = null;
    self._leftChidNsIconList = null;
    self._rightChildNsIconBox = null;
    self._rightChildNsIconList = null;
    self._childNswarBuffBack = null;
    self._childNswarBuffTxt = null;
    self._childNswarTimeId = 0;
    self._lastBufferId = 0;
    }
    constructor(param1) {
         $.pre(new.target, (__s) => {
         __s._mode = param1;
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
         this.initEvent();
      }
    initEvent() {
         this._mode.addEventListener("change",$.bind(this, "onDataChanged"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("childNswar.Event.Battle",$.bind(this, "nswarBattleHandler"));
      }
    rmeoveEvent() {
         this._mode.removeEventListener("change",$.bind(this, "onDataChanged"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("childNswar.Event.Battle",$.bind(this, "nswarBattleHandler"));
      }
    nswarBattleHandler(param1 = null) {
         var _loc7_ = null;
         var _loc2_ = null;
         var _loc6_ = null;
         if(!this._leftChidNsIconList)
         {
            return;
         }
         var _loc4_ = 0;
         var _loc5_ = $.C("managers.ChildNswarManager").Instance.model.battleInfo.battleRoleList;
         var _loc8_ = $.int($.C("battle.BattleManager").getInstance().battleModel.selfSide);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc7_ = _loc8_ + "_" + _loc4_;
            _loc2_ = this._leftChidNsIconList[_loc4_];
            _loc2_.updateView(_loc5_[_loc7_]);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if(_loc8_ == 1)
            {
               _loc7_ = "2_" + _loc4_;
            }
            else
            {
               _loc7_ = "1_" + _loc4_;
            }
            _loc2_ = this._rightChildNsIconList[_loc4_];
            _loc2_.updateView(_loc5_[_loc7_]);
            _loc4_++;
         }
         var _loc3_ = $.int($.C("managers.ChildNswarManager").Instance.model.battleInfo.buffId);
         if(this._lastBufferId != _loc3_ && _loc3_ > 0)
         {
            this._lastBufferId = _loc3_;
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(this._lastBufferId);
            this._childNswarBuffTxt.text = _loc6_.Description;
            this._childNswarBuffTxt.height = this._childNswarBuffTxt.numLines * 20;
            this._childNswarBuffBack.height = this._childNswarBuffTxt.height + 25;
         }
      }
    initView() {
         var _loc1_ = null;
         var _loc2_ = 0;
         this._tipBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.battle.battle.BattleHurtUpTipBack");
         this.addChild(this._tipBack);
         this._tipBack.visible = false;
         this._tipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.HurtUpTipTxt");
         this.addChild(this._tipTxt);
         this._tipTxt.visible = false;
         this._countDownValue = new ($.C("yishi.view.base.NumberBitmap"))();
         this._countDownValue.initParams(null,"asset.core.number_img_09",15,19,15,15,"0123456789.",0,0,0,50);
         if($.C("battle.BattleManager").getInstance().battleModel.battleType == 3911)
         {
            this._countDownBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.nswarCdbg");
            this.addChild(this._countDownBack);
            this._leftChidNsIconBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.childnswarLeft.HBox");
            this._leftChidNsIconList = new $.Vector();
            _loc2_ = 0;
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc1_ = new ($.C("battle.view.ui.ChildNswarBattleRoleIcon"))(_loc2_ + 1,1);
               this._leftChidNsIconList[_loc2_] = _loc1_;
               _loc2_++;
            }
            this._leftChidNsIconBox.beginChanges();
            _loc2_ = 2;
            while(_loc2_ >= 0)
            {
               _loc1_ = this._leftChidNsIconList[_loc2_];
               this._leftChidNsIconBox.addChild(_loc1_);
               _loc2_--;
            }
            this._leftChidNsIconBox.commitChanges();
            this.addChild(this._leftChidNsIconBox);
            this._rightChildNsIconBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.childnswar.right.HBox");
            this._rightChildNsIconList = new $.Vector();
            this._rightChildNsIconBox.beginChanges();
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc1_ = new ($.C("battle.view.ui.ChildNswarBattleRoleIcon"))(_loc2_ + 1,2);
               this._rightChildNsIconList[_loc2_] = _loc1_;
               this._rightChildNsIconBox.addChild(_loc1_);
               _loc2_++;
            }
            this._rightChildNsIconBox.commitChanges();
            this.addChild(this._rightChildNsIconBox);
            this._childNswarBuffBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.battle.battle.BattleHurtUpTipBack2");
            this._childNswarBuffTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.HurtUpTipTxt2");
            this.addChild(this._childNswarBuffBack);
            this.addChild(this._childNswarBuffTxt);
            this._countDownValue.y = 14;
            this._countDownValue.x = 4;
            this.nswarBattleHandler();
            this._childNswarTimeId = $.C("flash.utils.setTimeout")($.bind(this, "hideBufferhandler"),10000);
         }
         else
         {
            this._countDownBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.CountDownBack");
            this._countDownWord = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.CountDownWords");
            this.addChild(this._countDownBack);
            this.addChild(this._countDownWord);
            this._countDownValue.y = 4;
            this._countDownValue.x = 36;
         }
         this.addChild(this._countDownValue);
         this.onDataChanged(null);
      }
    hideBufferhandler() {
         if(this._childNswarBuffBack)
         {
            this._childNswarBuffBack.visible = false;
            this._childNswarBuffTxt.visible = false;
         }
      }
    onDataChanged(param1) {
         if(this._mode.getDamageImprove() > 0)
         {
            this._tipTxt.visible = true;
            this._tipBack.visible = true;
            if(this._mode.battleType == 35 || this._mode.battleType == 307)
            {
               this._tipTxt.text = $.C("manager.LanguageMgr").GetTranslation("battle.hurtUpTip.text2") + " " + this._mode.getDamageImprove() + "%";
            }
            else
            {
               this._tipTxt.text = $.C("manager.LanguageMgr").GetTranslation("battle.hurtUpTip.text") + " " + this._mode.getDamageImprove() + "%";
            }
         }
         this.updateCountDown();
         if($.C("battle.BattleManager").getInstance().battleUIView != null && $.C("battle.BattleManager").getInstance().battleUIView.hasGoddessUI)
         {
            this._tipBack.y = 118;
            this._tipTxt.y = 132;
         }
         else
         {
            this._tipBack.y = 58;
            this._tipTxt.y = 72;
         }
      }
    updateCountDown() {
         var _loc1_ = $.int(this._mode.getTimeLeft());
         this._countDownValue.num = _loc1_;
      }
    get width() {
         return 318;
      }
    dispose() {
         this.rmeoveEvent();
         $.C("flash.utils.clearTimeout")(this._childNswarTimeId);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipBack);
         this._tipBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipTxt);
         this._tipTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countDownBack);
         this._countDownBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countDownWord);
         this._countDownWord = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._countDownValue);
         this._countDownValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftChidNsIconBox);
         this._leftChidNsIconBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rightChildNsIconBox);
         this._rightChildNsIconBox = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this._leftChidNsIconList);
         this._leftChidNsIconList = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this._rightChildNsIconList);
         this._rightChildNsIconList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childNswarBuffBack);
         this._childNswarBuffBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._childNswarBuffTxt);
         this._childNswarBuffTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set width(v) { super.width = v; }
  }
  $.meta(__HurtUpView, "battle.view.ui.HurtUpView", []);
  return __HurtUpView;
}
deps["battle.view.ui.HurtUpView"] = ["battle.BattleManager", "battle.view.ui.ChildNswarBattleRoleIcon", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.clearTimeout", "flash.utils.setTimeout", "manager.LanguageMgr", "managers.ChildNswarManager", "utils.LogicUtils", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager", "yishi.view.base.NumberBitmap"];

defs["battle.view.ui.MutilBossShowView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MutilBossShowView extends __Base {
    static $fields(self) {
    self._worldBossRoleInfo = null;
    self._offsetXList = null;
    self._isInitedData = false;
    self._roleInfoGroupViewList = null;
    self._roleTempIdToRoleInfoViewDic = null;
    self.VIEW_WIDTH = 966;
    self.HEIGHT_GAP = 10;
    }
    constructor(param1, param2 = null) {
         super();
         this._offsetXList = param2;
         this._roleInfoGroupViewList = new $.Vector();
         this._roleTempIdToRoleInfoViewDic = new ($.C("flash.utils.Dictionary"))();
         this.initView(param1);
         this.addEvent();
         this.doLayout();
      }
    initView(param1) {
         var _loc5_ = null;
         var _loc4_ = 0;
         var _loc3_ = param1.length;
         var _loc2_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new ($.C("battle.view.ui.MutilBossShowView$$RoleInfoGroupView"))(param1[_loc4_]);
            this._roleInfoGroupViewList.push(_loc5_);
            _loc5_.y = _loc2_ + 10 * _loc4_;
            _loc2_ += _loc5_.resourceWidthHeight[1];
            this.addChild(_loc5_);
            if(this._offsetXList != null)
            {
               _loc5_.x += this._offsetXList[_loc4_];
            }
            _loc4_++;
         }
      }
    addEvent() {
         this.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "stageResizeHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("BATTLE_RESULT",$.bind(this, "battleResultHandler"));
      }
    removeEvent() {
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "stageResizeHandler"));
         $.C("battle.BattleManager").getInstance().battleModel.removeEventListener("reduceWorldBossBlood",$.bind(this, "onReduceWorldBossBlood"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("BATTLE_RESULT",$.bind(this, "battleResultHandler"));
      }
    stageResizeHandler(param1) {
         this.doLayout();
      }
    doLayout() {
         var _loc1_ = null;
         var _loc2_ = NaN;
         if($.C("battle.BattleManager").getInstance().mainViewContainer != null && $.C("battle.BattleManager").getInstance().mainViewContainer.view != null)
         {
            _loc1_ = $.C("battle.BattleManager").getInstance().mainViewContainer.view;
            _loc2_ = _loc1_.sceneWidth / 1500;
            for (var _loc3_ of $.values(this._roleInfoGroupViewList))
            {
               this.scaleX = this.scaleY = _loc2_;
            }
            this.x = _loc1_.sceneWidth - 966 * _loc2_;
         }
      }
    __enterFrame(param1) {
         var _loc2_ = Number($.C("battle.BattleManager").getInstance().battleModel.armyInfoRight.getLeftHp());
         if(_loc2_ <= 0)
         {
            $.C("battle.BattleManager").getInstance().battleModel.isOver = true;
            $.C("yishi.manager.NotificationManager").instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
    getRoleInfoByTempId(param1) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         var _loc2_ = null;
         var _loc3_ = $.as(this._roleTempIdToRoleInfoViewDic[param1], $.C("battle.view.ui.MutilBossShowView$$RoleInfoGroupView"));
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.curRoleInfo;
         }
         return _loc2_;
      }
    playDamageNumEffect(param1, param2) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         if (typeof param2 !== "number") param2 = Number(param2);
         var _loc3_ = $.as(this._roleTempIdToRoleInfoViewDic[param1], $.C("battle.view.ui.MutilBossShowView$$RoleInfoGroupView"));
         if(_loc3_ != null)
         {
            _loc3_.playDamageEffect(param2);
         }
      }
    resetRoleData(... rest) {
         var _loc2_ = false;
         var _loc5_ = null;
         var _loc3_ = new $.Vector();
         for (var _loc4_ of $.values(rest))
         {
            if(_loc4_ != null)
            {
               _loc5_ = $.as(this._roleTempIdToRoleInfoViewDic[_loc4_.templateId], $.C("battle.view.ui.MutilBossShowView$$RoleInfoGroupView"));
               _loc5_.updateUIByHeroInfo(_loc4_,_loc5_.needShowBuff);
               _loc3_.push(_loc5_.curRoleInfo.templateId);
            }
         }
         this.playRefreshEffect(_loc3_);
      }
    setRoleData(param1, ... rest) {
         var _loc7_ = null;
         var _loc8_ = null;
         var _loc3_ = false;
         var _loc6_ = 0;
         if(!this._isInitedData)
         {
            this._isInitedData = true;
         }
         this.deleteHeroRole();
         var _loc4_ = this._roleInfoGroupViewList.length;
         var _loc5_ = new $.Vector();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = this._roleInfoGroupViewList[_loc6_];
            if(_loc6_ < param1.length && param1[_loc6_] != null)
            {
               _loc8_.visible = true;
               _loc7_ = param1[_loc6_];
               _loc3_ = rest.indexOf(_loc7_) >= 0;
               _loc8_.updateUIByHeroInfo(_loc7_,_loc3_);
               this._roleTempIdToRoleInfoViewDic[_loc7_.templateId] = _loc8_;
               _loc7_.addEventListener("bloodChange",$.bind(this, "roleBloodChangeHandler"));
               _loc5_.push(_loc7_.templateId);
            }
            else
            {
               _loc8_.visible = false;
            }
            _loc6_++;
         }
         if(this._isInitedData)
         {
            this.playRefreshEffect(_loc5_);
         }
      }
    deleteHeroRole() {
         var _loc1_ = null;
         var _loc2_ = null;
         for(var _loc3_ in this._roleTempIdToRoleInfoViewDic)
         {
            _loc2_ = $.as(this._roleTempIdToRoleInfoViewDic[_loc3_], $.C("battle.view.ui.MutilBossShowView$$RoleInfoGroupView"));
            _loc1_ = _loc2_.curRoleInfo;
            _loc1_.removeEventListener("bloodChange",$.bind(this, "roleBloodChangeHandler"));
            this._roleTempIdToRoleInfoViewDic[_loc3_] = null;
            delete this._roleTempIdToRoleInfoViewDic[_loc3_];
         }
      }
    playRefreshEffect(param1) {
         var _loc2_ = null;
         for (var _loc3_ of $.values(param1))
         {
            _loc2_ = this._roleTempIdToRoleInfoViewDic[_loc3_];
            if(_loc2_ != null)
            {
               _loc2_.playEnterEffect();
            }
         }
      }
    roleBloodChangeHandler(param1) {
         var _loc3_ = $.as(param1.target, $.C("yishi.datas.objects.HeroRoleInfo"));
         var _loc2_ = this._roleTempIdToRoleInfoViewDic[_loc3_.templateId];
         if(_loc2_ != null)
         {
            _loc2_.setCurBlood(_loc3_.bloodA);
         }
      }
    refreshTurn() {
         for (var _loc1_ of $.values(this._roleInfoGroupViewList))
         {
            _loc1_.refreshBuff();
         }
      }
    dispose() {
         this.removeEvent();
         this.deleteHeroRole();
         for (var _loc1_ of $.values(this._roleInfoGroupViewList))
         {
            _loc1_.dispose();
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._roleTempIdToRoleInfoViewDic = null;
         if(this._roleInfoGroupViewList)
         {
            this._roleInfoGroupViewList.length = 0;
         }
         this._roleInfoGroupViewList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set worldBossRoleInfo(param1) {
         this._worldBossRoleInfo = param1;
         var _loc2_ = $.C("battle.BattleManager").getInstance().battleModel;
         if(this._worldBossRoleInfo != null)
         {
            if(!_loc2_.hasEventListener("reduceWorldBossBlood"))
            {
               _loc2_.addEventListener("reduceWorldBossBlood",$.bind(this, "onReduceWorldBossBlood"));
            }
         }
         else
         {
            _loc2_.removeEventListener("reduceWorldBossBlood",$.bind(this, "onReduceWorldBossBlood"));
         }
      }
    onReduceWorldBossBlood(param1) {
         var _loc3_ = null;
         var _loc2_ = NaN;
         if(this._worldBossRoleInfo != null)
         {
            _loc3_ = $.as(this._roleTempIdToRoleInfoViewDic[this._worldBossRoleInfo.templateId], $.C("battle.view.ui.MutilBossShowView$$RoleInfoGroupView"));
            if(_loc3_ != null)
            {
               _loc2_ = Number(param1.data);
               _loc3_.addCurBlood(_loc2_);
               _loc3_.playDamageEffect(_loc2_);
            }
         }
      }
    battleResultHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = Boolean(param1.data);
         if(this._worldBossRoleInfo != null && _loc3_)
         {
            _loc2_ = $.as(this._roleTempIdToRoleInfoViewDic[this._worldBossRoleInfo.templateId], $.C("battle.view.ui.MutilBossShowView$$RoleInfoGroupView"));
            if(_loc2_ != null)
            {
               _loc2_.setCurBlood(0);
            }
         }
      }
    get worldBossRoleInfo() { return super.worldBossRoleInfo; }
  }
  $.meta(__MutilBossShowView, "battle.view.ui.MutilBossShowView", ["Disposeable"]);
  return __MutilBossShowView;
}
deps["battle.view.ui.MutilBossShowView"] = ["battle.BattleManager", "battle.view.ui.MutilBossShowView$$RoleInfoGroupView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Dictionary", "yishi.datas.objects.HeroRoleInfo", "yishi.manager.NotificationManager"];

defs["battle.view.ui.MutilBossShowView$$RoleInfoGroupView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MutilBossShowView__RoleInfoGroupView extends __Base {
    static $fields(self) {
    self._needShowBuff = false;
    self._bossInfoResourceMc = null;
    self._curRoleInfo = null;
    self._bossInfoView = null;
    self._bossBuffView = null;
    self._resourceWidthHeight = new $.Vector();
    }
    constructor(param1) {
      super();
      var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject(param1);
      this._resourceWidthHeight.push(_loc2_.width,_loc2_.height);
      this._bossInfoResourceMc = _loc2_;
      this._bossInfoView = new ($.C("battle.view.ui.top.BossInfoViewII"))(this._bossInfoResourceMc,param1);
      this._bossBuffView = new ($.C("battle.view.buffer.BossBufferContainer"))(null);
      this.addChild(this._bossInfoView);
      this.addChild(this._bossBuffView);
      this._bossBuffView.x = __MutilBossShowView__RoleInfoGroupView.BUFF_POS.x;
      this._bossBuffView.y = __MutilBossShowView__RoleInfoGroupView.BUFF_POS.y;
   }
    updateUIByHeroInfo(param1, param2) {
      this._needShowBuff = param2;
      this._curRoleInfo = param1;
      this._bossInfoView.updateUIByHeroInfo(param1,param1.totalBloodA,param1.bloodA);
      this._bossBuffView.removeEvent();
      if(param2)
      {
         this._bossBuffView.initEvent(param1);
      }
      this._bossBuffView.reFreshBuffer(null);
      this._bossBuffView.visible = param2;
   }
    playDamageEffect(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
      param1 = param1 < 0 ? -param1 : param1;
      this._bossInfoView.playDamageNumEffect(param1);
   }
    addCurBlood(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
      var _loc2_ = $.as(this._bossInfoView.hpView, $.C("battle.view.ui.IHpStrip"));
      _loc2_.currentValue += param1;
   }
    setCurBlood(param1) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
      ($.as(this._bossInfoView.hpView, $.C("battle.view.ui.IHpStrip"))).currentValue = param1;
   }
    refreshBuff() {
      this._bossBuffView.refreshTurn();
   }
    playEnterEffect() {
      this._bossInfoView.bossInfoViewResouce.gotoAndPlay(1);
   }
    dispose() {
      if(this._bossInfoView)
      {
         this._bossInfoView.dispose();
      }
      this._bossInfoView = null;
      if(this._bossBuffView)
      {
         this._bossBuffView.dispose();
      }
      this._bossBuffView = null;
      if(this._bossInfoResourceMc)
      {
         $.C("com.pickgliss.utils.ObjectUtils").stopAllSubClips(this._bossInfoResourceMc);
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._bossInfoResourceMc);
      }
      this._bossInfoResourceMc = null;
      if(this.parent)
      {
         this.parent.removeChild(this);
      }
   }
    get curRoleInfo() {
      return this._curRoleInfo;
   }
    get needShowBuff() {
      return this._needShowBuff;
   }
    get resourceWidthHeight() {
      return this._resourceWidthHeight;
   }
    set curRoleInfo(v) { super.curRoleInfo = v; }
    set needShowBuff(v) { super.needShowBuff = v; }
    set resourceWidthHeight(v) { super.resourceWidthHeight = v; }
  }
  $.meta(__MutilBossShowView__RoleInfoGroupView, "battle.view.ui.MutilBossShowView$$RoleInfoGroupView", []);
  $.statics(__MutilBossShowView__RoleInfoGroupView, () => {
    __MutilBossShowView__RoleInfoGroupView.BUFF_POS = new ($.C("flash.geom.Point"))(740,43);
  });
  return __MutilBossShowView__RoleInfoGroupView;
}
deps["battle.view.ui.MutilBossShowView$$RoleInfoGroupView"] = ["battle.view.buffer.BossBufferContainer", "battle.view.ui.IHpStrip", "battle.view.ui.top.BossInfoViewII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Point"];

defs["battle.view.ui.OutyardShowView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __OutyardShowView extends __Base {
    static $fields(self) {
    self._generalBmp1 = null;
    self._generalBmp2 = null;
    self._generalBmp3 = null;
    self._generalBmp4 = null;
    self._defenceBg = null;
    self._progressMc = null;
    self._leftArmyTxt = null;
    self._guildArmyTxt = null;
    self.$$_filters = null;
    self._colorManager1 = null;
    self._colorManager2 = null;
    self._colorManager3 = null;
    self._colorManager4 = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.layout();
      }
    initView() {
         this._generalBmp1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.generalBmp1");
         this._generalBmp2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.generalBmp2");
         this._generalBmp3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.generalBmp3");
         this._generalBmp4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.generalBmp4");
         this._defenceBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.defenceBg");
         this._progressMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.generalProgressMc");
         this._leftArmyTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outyard.OutyardShowView.leftArmyTxt");
         this._guildArmyTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("outyard.OutyardShowView.guildArmyTxt");
         this.addChild(this._generalBmp1);
         this.addChild(this._generalBmp2);
         this.addChild(this._generalBmp3);
         this.addChild(this._generalBmp4);
         this.addChild(this._defenceBg);
         this.addChild(this._progressMc);
         this.addChild(this._leftArmyTxt);
         this.addChild(this._guildArmyTxt);
         this.$$_filters = new ($.C("yishi.filter.UIFilter"))();
         this._colorManager1 = new ($.C("mainBar.effects.MainToolBtnGlowEffect"))(this._generalBmp1);
         this._colorManager2 = new ($.C("mainBar.effects.MainToolBtnGlowEffect"))(this._generalBmp2);
         this._colorManager3 = new ($.C("mainBar.effects.MainToolBtnGlowEffect"))(this._generalBmp3);
         this._colorManager4 = new ($.C("mainBar.effects.MainToolBtnGlowEffect"))(this._generalBmp4);
      }
    addEvent() {
         this.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__stageResize"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("OUTYARD_BATTLE_DEFENCE",$.bind(this, "__battleDefenceHandler"));
         this.__battleDefenceHandler(null);
      }
    removeEvent() {
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__stageResize"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("OUTYARD_BATTLE_DEFENCE",$.bind(this, "__battleDefenceHandler"));
      }
    __enterFrame(param1) {
         var _loc2_ = Number($.C("battle.BattleManager").getInstance().battleModel.armyInfoRight.getLeftHp());
         if(_loc2_ <= 0)
         {
            $.C("battle.BattleManager").getInstance().battleModel.isOver = true;
            $.C("yishi.manager.NotificationManager").instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
    __battleDefenceHandler(param1) {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc3_ = 0;
         var _loc4_ = $.C("yishi.manager.OutyardManager").instance.crystalModel.battleDefenceMsg;
         if(!_loc4_)
         {
            return;
         }
         var _loc6_ = (_loc4_.defenceArmyTotal - _loc4_.defenceArmyAlive) / _loc4_.defenceArmyTotal * 100;
         this._progressMc.gotoAndStop(_loc6_);
         this._leftArmyTxt.text = $.C("manager.LanguageMgr").GetTranslation("outyard.OutyardShowView.leftArmyTxt.text",_loc4_.defenceArmyAlive);
         this._guildArmyTxt.text = $.C("manager.LanguageMgr").GetTranslation("outyard.OutyardShowView.guildArmyTxt.text",100 - _loc4_.defenceProperty);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.defenceSeniorGeneral.length)
         {
            _loc2_ = $.as(_loc4_.defenceSeniorGeneral[_loc3_], $.C("com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg"));
            _loc5_ = this["_generalBmp" + _loc2_.index];
            this.$$_filters.setNormalFilter(_loc5_);
            if(_loc2_.alive)
            {
               if(_loc2_.inBattle)
               {
                  this["_colorManager" + _loc2_.index].play1();
               }
            }
            else
            {
               this.$$_filters.setGrayFilter(_loc5_);
            }
            _loc3_++;
         }
      }
    __stageResize(param1) {
         this.layout();
      }
    layout() {
         var _loc1_ = $.C("battle.BattleManager").getInstance().mainViewContainer.view;
         var _loc2_ = _loc1_.sceneWidth / 1500;
         this.x = _loc1_.sceneWidth - this.width - 300;
         this.y = 30;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._generalBmp1);
         this._generalBmp1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._generalBmp2);
         this._generalBmp2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._generalBmp3);
         this._generalBmp3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._generalBmp4);
         this._generalBmp4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._defenceBg);
         this._defenceBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._progressMc);
         this._progressMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._leftArmyTxt);
         this._leftArmyTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._guildArmyTxt);
         this._guildArmyTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.$$_filters);
         this.$$_filters = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._colorManager1);
         this._colorManager1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._colorManager2);
         this._colorManager2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._colorManager3);
         this._colorManager3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._colorManager4);
         this._colorManager4 = null;
         super.dispose();
      }
  }
  $.meta(__OutyardShowView, "battle.view.ui.OutyardShowView", []);
  return __OutyardShowView;
}
deps["battle.view.ui.OutyardShowView"] = ["battle.BattleManager", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg", "mainBar.effects.MainToolBtnGlowEffect", "manager.LanguageMgr", "yishi.filter.UIFilter", "yishi.manager.NotificationManager", "yishi.manager.OutyardManager"];

defs["battle.view.ui.PowerUIView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __PowerUIView extends __Base {
    static $fields(self) {
    self._asset = null;
    self._powerStripAsset = null;
    self._stripView = null;
    self._frontView = null;
    self._spIncreaseAnimation = null;
    }
    constructor() {
         super();
         $.C("battle.view.ui.SpTip");
         this.initView();
         this.addEvent();
         this.tipStyle = "battle.view.ui.SpTip";
         this.tipDirctions = "1";
         this.tipGapV = 0;
         this.isFollowMouse = false;
         this.onHeroSpChanged(null);
      }
    addEvent() {
         $.C("battle.BattleManager").getInstance().battleModel.selfHero.addEventListener("sp",$.bind(this, "onHeroSpChanged"));
      }
    onHeroSpChanged(param1) {
         var _loc6_ = 0;
         var _loc2_ = false;
         var _loc3_ = false;
         var _loc4_;
         var _loc5_ = _loc4_ = $.int($.C("battle.BattleManager").getInstance().battleModel.selfHero.sp);
         if(param1)
         {
            _loc2_ = Boolean(param1.data.increase);
            _loc3_ = Boolean(param1.data.showTip);
            _loc5_ = $.int(param1.data.sp);
         }
         if(!this._spIncreaseAnimation || !this._spIncreaseAnimation.isRunning())
         {
            _loc6_ = _loc4_ - this._stripView.currentValue;
            _loc5_ -= this._stripView.currentValue;
            this.spChangedHandler(this._stripView.currentValue,_loc6_,_loc2_,_loc3_,_loc5_);
         }
         else
         {
            _loc6_ = _loc4_ - this._spIncreaseAnimation.getDestCurrent();
            _loc5_ -= this._spIncreaseAnimation.getDestCurrent();
            this.spChangedHandler(this._spIncreaseAnimation.getDestCurrent(),_loc6_,_loc2_,_loc3_,_loc5_);
            this._spIncreaseAnimation.dispose();
            this._spIncreaseAnimation = null;
         }
      }
    initView() {
         this._asset = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.battle.PowerUIViewAsset");
         this.addChild(this._asset);
         this._powerStripAsset = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.battle.PowerStripAsset");
         var _loc1_ = $.int($.C("battle.BattleManager").getInstance().battleModel.selfHero.sp);
         this._stripView = new ($.C("battle.view.ui.StripUIView"))(this._powerStripAsset,100,_loc1_,0,true,true);
         this._stripView.currentValue = 0;
         this.addChild(this._stripView);
         this._frontView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.PowerUIFrontView");
         this._frontView.x = 66;
         this._frontView.y = 10;
         this.addChild(this._frontView);
         $.C("battle.utils.Helpers").setChildPos(this._stripView,this._asset.power_pos);
      }
    getStripCurrentX() {
         return this._stripView.maskWidth;
      }
    spChangedHandler(param1, param2, param3 = true, param4 = true, param5 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if(param2 > 0)
         {
            this.spIncrease(param1,param2,param3);
            if(param4)
            {
               this.addChild(new ($.C("battle.view.ui.PowerUIView$$AddSpNumAnimation"))(param5));
            }
         }
         else if(param2 < 0)
         {
            this._stripView.currentValue = $.C("battle.BattleManager").getInstance().battleModel.selfHero.sp;
         }
         this.tipData = $.C("battle.BattleManager").getInstance().battleModel.selfHero.sp + "";
      }
    spIncrease(param1, param2, param3 = true) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = 0;
         if(param1 + param2 > this._stripView.maxValue)
         {
            param2 = this._stripView.maxValue - param1;
         }
         if(param2 > 0)
         {
            if(param3)
            {
               this.addSnIncreaseAnimation(param1,param2);
            }
            else
            {
               _loc4_ = param1 + param2;
               if(_loc4_ > 100)
               {
                  _loc4_ = 100;
               }
               this._stripView.currentValue = _loc4_;
            }
         }
      }
    addSnIncreaseAnimation(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._spIncreaseAnimation = new ($.C("battle.view.animation.SpStripIncreaseAnimation"))(this,this._stripView);
         this._spIncreaseAnimation.start(param1,param2);
      }
    dispose() {
         $.C("battle.BattleManager").getInstance().battleModel.selfHero.removeEventListener("sp",$.bind(this, "onHeroSpChanged"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._asset);
         this._asset = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._powerStripAsset);
         this._powerStripAsset = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stripView);
         this._stripView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._frontView);
         this._frontView = null;
         this._spIncreaseAnimation.dispose();
         this._spIncreaseAnimation = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
  }
  $.meta(__PowerUIView, "battle.view.ui.PowerUIView", []);
  return __PowerUIView;
}
deps["battle.view.ui.PowerUIView"] = ["battle.BattleManager", "battle.utils.Helpers", "battle.view.animation.SpStripIncreaseAnimation", "battle.view.ui.PowerUIView$$AddSpNumAnimation", "battle.view.ui.SpTip", "battle.view.ui.StripUIView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ClassUtils", "com.pickgliss.utils.ObjectUtils"];

defs["battle.view.ui.PowerUIView$$AddSpNumAnimation"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PowerUIView__AddSpNumAnimation extends __Base {
    static $fields(self) {
    self._titleBm = null;
    self._numView = null;
    self._numBitmapData = null;
    self._num = 0;
    }
    constructor(param1) {
      super();
      this._num = param1;
      this.initView();
      this.tween();
   }
    initView() {
      this._titleBm = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.PowerUIAddSp");
      this.addChild(this._titleBm);
      if(!this._numBitmapData)
      {
         this._numBitmapData = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.core.number_img_01");
      }
      this._numView = new ($.C("flash.display.Sprite"))();
      $.C("yishi.utils.NumberViewUtils").refreshValue(this._num,this._numView,this._numBitmapData,13,17,14,13);
      this._numView.x = this._titleBm.width;
      this._numView.y = 2;
      this.addChild(this._numView);
      this.x = 230;
      this.y = -73;
      this.alpha = 0;
   }
    tween() {
      $.C("com.greensock.TweenLite").to(this,0.5,{
         "y":this.y - 43,
         "alpha":1,
         "onComplete":$.bind(this, "onTweenComplete")
      });
   }
    onTweenComplete() {
      $.C("com.greensock.TweenLite").killTweensOf(this);
      $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "removeView"),1000);
   }
    removeView() {
      $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._numBitmapData);
      this._numBitmapData = null;
      $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleBm);
      this._titleBm = null;
      $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._numView);
      this._numView = null;
      if(this.parent)
      {
         this.parent.removeChild(this);
      }
   }
  }
  $.meta(__PowerUIView__AddSpNumAnimation, "battle.view.ui.PowerUIView$$AddSpNumAnimation", []);
  return __PowerUIView__AddSpNumAnimation;
}
deps["battle.view.ui.PowerUIView$$AddSpNumAnimation"] = ["com.greensock.TweenLite", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.utils.NumberViewUtils", "yishi.utils.TimerUtils"];

defs["battle.view.ui.RaceAgainstTimeUpView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RaceAgainstTimeUpView extends __Base {
    static $fields(self) {
    self._back = null;
    self._txt = null;
    self._timeTxt = null;
    self._time = null;
    self._bm = null;
    self._begin = 0;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.raceAgainstTime.timeBack");
         this._txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("raceAgainstTimeUpView.txt");
         this._timeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("raceAgainstTimeUpView.timeTxt");
         this._bm = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.raceAgainstTime.num");
         this._time = new ($.C("flash.display.Sprite"))();
         this._time.x = 90;
         this._time.y = 48;
         this.addChild(this._back);
         this.addChild(this._txt);
         this.addChild(this._timeTxt);
         this.addChild(this._time);
         this._txt.text = $.C("manager.LanguageMgr").GetTranslation("RaceAgainstTimeUpView.txt");
         this._timeTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.utils.DateFormatter.timeStr.min");
         this._begin = this.playerInfo.raceAgainstTimeBegin;
         $.C("yishi.utils.TimerUtils").addSecendTimer("TIME",1,99999,$.bind(this, "refreshView"));
         this.refreshView();
      }
    refreshView() {
         this._begin = this._begin + 1;
         var _loc1_ = this._begin / 60;
         $.C("yishi.utils.NumberViewUtils").getNumberView(_loc1_,this._time,this._bm.bitmapData,21,29,19,21,"0123456789:");
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         $.C("yishi.utils.TimerUtils").removeSecendTimer("TIME");
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._txt);
         this._txt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeTxt);
         this._timeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bm);
         this._bm = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__RaceAgainstTimeUpView, "battle.view.ui.RaceAgainstTimeUpView", ["Disposeable"]);
  return __RaceAgainstTimeUpView;
}
deps["battle.view.ui.RaceAgainstTimeUpView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.PlayerManager", "yishi.utils.NumberViewUtils", "yishi.utils.TimerUtils"];

defs["battle.view.ui.RedScreenEffect"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RedScreenEffect extends __Base {
    static $fields(self) {
    self._redBm = null;
    self._timer = null;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s.mouseChildren = __s.mouseEnabled = false;
         });
         super();
         $.preFlush(this, new.target);
         this._redBm = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.RedScreenBMD");
         this._redBm.alpha = 0.5;
      }
    resize(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._redBm.width = param1;
         this._redBm.height = param2;
      }
    play() {
         this.addChild(this._redBm);
         this.removeTimer();
         this._timer = new ($.C("flash.utils.Timer"))(200,1);
         this._timer.addEventListener("timerComplete",$.bind(this, "onTimerComplete"));
         this._timer.start();
      }
    onTimerComplete(param1) {
         this.removeTimer();
         if(this._redBm && this._redBm.parent)
         {
            this._redBm.parent.removeChild(this._redBm);
         }
      }
    removeTimer() {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timerComplete",$.bind(this, "onTimerComplete"));
            this._timer = null;
         }
      }
    stop() {
         this.onTimerComplete(null);
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._redBm);
         this.stop();
      }
  }
  $.meta(__RedScreenEffect, "battle.view.ui.RedScreenEffect", []);
  return __RedScreenEffect;
}
deps["battle.view.ui.RedScreenEffect"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Timer"];

defs["battle.view.ui.ResistUIView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ResistUIView extends __Base {
    static $fields(self) {
    self._damageNum = null;
    self._damageDestX = NaN;
    self._damageMatrix = null;
    self._resistMc = null;
    self._signMc = null;
    self._percentMc = null;
    self._damageMc = null;
    self._exiting = false;
    self._delay = null;
    self._side = 0;
    self._frame = 0;
    self._totalDamageBitData = null;
    self._totalDamageBitData1 = null;
    self._totalDamageBitData2 = null;
    }
    constructor(param1) {
         super();
         this._side = param1;
         this.init();
         this.addEvent();
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SET_RESIST_TOTAL_DAMAGE",$.bind(this, "__setTotalDamage"));
      }
    init() {
         this._resistMc = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.battle.DamageUIAsset");
         this._signMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.ResistUIView.sign");
         this._percentMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.ResistUIView.percent");
         this._damageMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.ResistUIView.damage");
         this._damageDestX = this._resistMc.x;
         this.addChild(this._resistMc);
         this._damageNum = new ($.C("flash.display.Sprite"))();
         this._damageNum.mouseChildren = this._damageNum.mouseEnabled = false;
         this._resistMc.total_num_pos.addChild(this._damageNum);
         this._resistMc.sign_pos.addChild(this._signMc);
         this._resistMc.percent_pos.addChild(this._percentMc);
         this._resistMc.damage_pos.addChild(this._damageMc);
         this._damageMatrix = this._resistMc.transform.matrix;
         this._totalDamageBitData1 = ($.as($.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.numberRedLow"), $.C("flash.display.Bitmap"))).bitmapData;
         this._totalDamageBitData2 = ($.as($.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.battle.numberGreenLow"), $.C("flash.display.Bitmap"))).bitmapData;
      }
    __setTotalDamage(param1) {
         if(!this._resistMc)
         {
            return;
         }
         if(param1.data.side != this._side)
         {
            return;
         }
         if(param1.data.value > 0)
         {
            this._totalDamageBitData = this._totalDamageBitData2;
            this._frame = 2;
            this._signMc.setFrame(this._frame);
            this._percentMc.setFrame(this._frame);
            this._damageMc.setFrame(this._frame);
            $.C("yishi.utils.NumberViewUtils").getNumberView(param1.data.value,this._damageNum,this._totalDamageBitData,42,42,35,42,"0123456789.",1);
         }
         else
         {
            if(param1.data.value >= 0)
            {
               this.hide();
               return;
            }
            this._totalDamageBitData = this._totalDamageBitData1;
            this._frame = 1;
            this._signMc.setFrame(this._frame);
            this._percentMc.setFrame(this._frame);
            this._damageMc.setFrame(this._frame);
            $.C("yishi.utils.NumberViewUtils").getNumberView(Math.abs(param1.data.value),this._damageNum,this._totalDamageBitData,42,42,35,42,"0123456789.",1);
         }
         this._percentMc.x = this._damageNum.width - 18;
      }
    show() {
         this.reset();
         this._resistMc.transform.matrix = this._damageMatrix;
         this._resistMc.alpha = 1;
         $.C("com.greensock.TweenLite").from(this._resistMc,0.7,{
            "alpha":0,
            "x":"-100"
         });
         if(this._delay)
         {
            this._delay.cancel();
         }
         this._delay = $.C("battle.utils.Helpers").delayCall(() =>
         {
            this.hide();
         },60);
      }
    hide() {
         $.C("com.greensock.TweenLite").to(this._resistMc,0.4,{
            "alpha":0,
            "x":this._damageDestX - 96,
            "onComplete":$.bind(this, "onExitComplete")
         });
         this._exiting = true;
      }
    reset() {
         this._resistMc.alpha = 1;
         this._resistMc.x = this._damageDestX;
         $.C("com.greensock.TweenLite").killTweensOf(this._resistMc);
         this._exiting = false;
      }
    onExitComplete() {
         this._exiting = false;
      }
    dispose() {
         this.removeEvent();
         if(this._resistMc)
         {
            $.C("com.greensock.TweenLite").killTweensOf(this._resistMc);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._damageNum);
         this._damageNum = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._resistMc);
         this._resistMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._totalDamageBitData1);
         this._totalDamageBitData1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._totalDamageBitData2);
         this._totalDamageBitData2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._signMc);
         this._signMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._percentMc);
         this._percentMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._damageMc);
         this._damageMc = null;
         if(this._delay)
         {
            this._delay.cancel();
         }
         this._delay = null;
         this._totalDamageBitData = null;
         this._damageMatrix = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SET_RESIST_TOTAL_DAMAGE",$.bind(this, "__setTotalDamage"));
      }
  }
  $.meta(__ResistUIView, "battle.view.ui.ResistUIView", []);
  $.statics(__ResistUIView, () => {
    __ResistUIView.EXIT_DISTANCE = 96;
  });
  return __ResistUIView;
}
deps["battle.view.ui.ResistUIView"] = ["battle.utils.Helpers", "com.greensock.TweenLite", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ClassUtils", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.Sprite", "yishi.manager.NotificationManager", "yishi.utils.NumberViewUtils"];

defs["battle.view.ui.RoleShowViewII"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RoleShowViewII extends __Base {
    static $fields(self) {
    self._rightIsBoss = false;
    self._bossView = null;
    self._boss = null;
    self.bossBufferContainer = null;
    self._reinforceWavePane = null;
    self._gameHallAutoPane = null;
    self.preState = -1;
    self._nextWaveCame = true;
    }
    constructor() {
         super();
         this.init();
         this.addEvent();
         this.layout();
      }
    init() {
         this._rightIsBoss = this.isBoss(this.battleModel.armyInfoRight.getHeros);
         this.createRightView();
         if(this.battleModel.reinforceWave > 0)
         {
            this.setReinforceWaveInfo(this.battleModel.reinforceWave,this.battleModel.currentReinforceWave + 1);
         }
      }
    createRightView() {
         if(this._rightIsBoss)
         {
            this._bossView = new ($.C("battle.view.ui.top.BossInfoView"))();
            this._bossView.setInfo(this._boss);
            this._bossView.setTotalHp(this.battleModel.armyInfoRight.getBossesTotalHp());
            this._bossView.setCurrentHp(this.battleModel.armyInfoRight.getBossesLeftHp());
            this.addChild(this._bossView);
            this.bossBufferContainer = new ($.C("battle.view.buffer.BossBufferContainer"))(this.battleModel.armyInfoRight.boss);
            this.bossBufferContainer.x = 1080;
            this.bossBufferContainer.y = 25;
            this.addChild(this.bossBufferContainer);
         }
      }
    showReinforceWavePane() {
         this._reinforceWavePane = new ($.C("battle.view.reinforce.ReinforceWavePane"))();
         this._gameHallAutoPane = new ($.C("mvc.module.gamehall.GameHallAutoView"))();
         this.deployReinforceWavePane(this.isBoss(this.battleModel.armyInfoRight.getHeros));
         if($.C("yishi.manager.PlayerManager").instance.newbieProcess >= 19000)
         {
            this.addChild(this._reinforceWavePane);
            this.addChild(this._gameHallAutoPane);
         }
         var _loc1_ = $.C("battle.BattleManager").getInstance().mainViewContainer.view;
         var _loc2_ = _loc1_.sceneWidth / 1500;
         this.reinforceLayout(_loc2_);
      }
    deployReinforceWavePane(param1) {
         if(!this._reinforceWavePane)
         {
            return;
         }
         if(this.battleModel.battleType == 3886)
         {
            this._reinforceWavePane.top = 160;
            this._reinforceWavePane.right = 30;
         }
         else if(param1)
         {
            this._reinforceWavePane.top = 75;
            this._reinforceWavePane.right = 120;
         }
         else
         {
            this._reinforceWavePane.top = 30;
            this._reinforceWavePane.right = 53;
         }
      }
    setReinforceWaveInfo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(!this._reinforceWavePane)
         {
            this.showReinforceWavePane();
            this._reinforceWavePane.setTotalWave(param1);
            this._reinforceWavePane.setCurrentWave(param2);
         }
      }
    updateReinforceWave() {
         if(this._reinforceWavePane)
         {
            this._reinforceWavePane.showNextWave();
         }
      }
    bossReinforce(param1) {
         var _loc3_ = null;
         var _loc2_ = 0;
         var _loc5_ = 0;
         var _loc4_ = null;
         var _loc6_ = NaN;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(!_loc3_)
            {
               _loc3_ = param1[_loc5_];
            }
            _loc2_ += param1[_loc5_].totalBloodA;
            if(_loc3_ && _loc3_.heroInfo.grades <= param1[_loc5_].heroInfo.grades)
            {
               _loc3_ = param1[_loc5_];
            }
            _loc5_++;
         }
         this._boss = _loc3_;
         if(!this._rightIsBoss)
         {
            this._rightIsBoss = true;
            this.createRightView();
            this.deployReinforceWavePane(true);
            _loc4_ = $.C("battle.BattleManager").getInstance().mainViewContainer.view;
            _loc6_ = _loc4_.sceneWidth / 1500;
            this.layout();
         }
         this._bossView.setInfo(this._boss);
         this._bossView.setTotalHp(_loc2_);
         this._bossView.setCurrentHp(this.battleModel.armyInfoRight.getBossesLeftHp());
         this.bossBufferContainer.removeEvent();
         this.bossBufferContainer.initEvent(this._boss);
         this.bossBufferContainer.reFreshBuffer(null);
      }
    isBoss(param1) {
         var _loc2_ = null;
         for (var _loc3_ of $.values(param1))
         {
            if(_loc3_.type == 3)
            {
               if(!this._boss)
               {
                  this._boss = _loc3_;
               }
               if(this._boss && this._boss.heroInfo.grades < _loc3_.heroInfo.grades)
               {
                  this._boss = _loc3_;
               }
            }
         }
         return this._boss != null;
      }
    isNeedShowRightView() {
         if(this.battleModel.battleType == 4 || this.battleModel.battleType == 7 || this.battleModel.battleType == 5 || this.battleModel.battleType == 10 || this.battleModel.battleType == 8)
         {
            return true;
         }
         return false;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    addEvent() {
         this.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__stageResize"));
         $.C("battle.BattleManager").getInstance().battleModel.addEventListener("reduceWorldBossBlood",$.bind(this, "onReduceWorldBossBlood"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4174,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4462,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4435,$.bind(this, "__addBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4727,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4985,$.bind(this, "tailaHPSyncHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 360,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4889,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4285,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.addEventListener("SLGSocketEvent" + 4297,$.bind(this, "__syncBossHpHandler"));
      }
    tailaHPSyncHandler(param1) {
         var _loc3_ = null;
         var _loc6_ = this.battleModel.armyInfoRight.boss;
         var _loc5_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.simple.SyncRoomBossHPMsg"))();
         _loc2_ = $.as(_loc5_.readBody(_loc2_), $.C("com.road.yishi.proto.simple.SyncRoomBossHPMsg"));
         var _loc4_ = _loc2_.roomBossInfoList.roomBoss;
         if(_loc4_ && _loc4_.length > 0)
         {
            _loc3_ = $.as(_loc4_[0], $.C("com.road.yishi.proto.simple.RoomBossInfoMsg"));
         }
         if(_loc6_ != null)
         {
            if(this.battleModel.battleType == 3846)
            {
               _loc6_.bloodA = $.C("battle.utils.Int64Utils").int64ToNumber(_loc3_.curHp);
               this._bossView.setCurrentHp(Math.abs($.C("battle.utils.Int64Utils").int64ToNumber(_loc3_.curHp)));
            }
         }
      }
    __addBossHpHandler(param1) {
         var _loc4_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.battle.BossHpMsg"))();
         _loc2_ = $.as(_loc4_.readBody(_loc2_), $.C("com.road.yishi.proto.battle.BossHpMsg"));
         var _loc3_ = $.int(_loc2_.value);
         if(_loc2_.livingId && this._boss.livingId == _loc2_.livingId)
         {
            this._bossView.updateWorldBossHp(Math.abs(_loc3_));
         }
      }
    __syncBossHpHandler(param1) {
         var _loc7_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.simple.WorldBossInfoMsg"))();
         _loc2_ = $.as(_loc7_.readBody(_loc2_), $.C("com.road.yishi.proto.simple.WorldBossInfoMsg"));
         var _loc6_ = Number($.C("battle.utils.Int64Utils").int64ToNumber(_loc2_.currentMillis));
         var _loc3_ = Number($.C("battle.utils.Int64Utils").int64ToNumber(_loc2_.curHp));
         var _loc4_ = Number($.C("battle.utils.Int64Utils").int64ToNumber(_loc2_.totalHp));
         var _loc5_ = $.C("battle.BattleManager").getInstance().battleModel.getWorldBoss();
         if(this.preState == 0 && _loc2_.bossState == 1)
         {
            if(_loc5_)
            {
               _loc5_.totalBlood = _loc4_;
               _loc5_.initBloodA = _loc4_;
               _loc5_.bloodA = _loc4_;
               this._bossView.setTotalHp(_loc4_);
               this._bossView.setCurrentHp(this.battleModel.armyInfoRight.getBossesLeftHp());
            }
         }
         this.preState = _loc2_.bossState;
         $.C("battle.BattleManager").getInstance().battleModel.updateWorldBossBlood(_loc3_,_loc6_);
      }
    onReduceWorldBossBlood(param1) {
         this._bossView.updateWorldBossHp(Number(param1.data));
      }
    __stageResize(param1) {
         this.layout();
      }
    layout() {
         this.resizeHeadView();
      }
    resizeHeadView() {
         var _loc2_ = NaN;
         var _loc4_ = NaN;
         var _loc5_ = NaN;
         var _loc3_ = $.C("battle.BattleManager").getInstance().mainViewContainer.view;
         var _loc6_ = _loc3_.sceneWidth / 1500;
         if(this._rightIsBoss)
         {
            this._bossView.scaleX = this._bossView.scaleY = _loc6_;
            this._bossView.x = _loc3_.sceneWidth - this._bossView.width * _loc6_ + 25;
            this.bossBufferContainer.x = _loc3_.sceneWidth - 210 * _loc6_ - 40;
            if(_loc6_ < 1)
            {
               this.bossBufferContainer.y = 5;
            }
            else
            {
               this.bossBufferContainer.y = 25;
            }
            _loc2_ = 1 / _loc6_;
            if(this._bossView.nameTxt)
            {
               _loc4_ = Number(this._bossView.nameTxt.width);
               _loc5_ = Number(this._bossView.nameTxt.textHeight);
               this._bossView.nameTxt.scaleX = this._bossView.nameTxt.scaleY = _loc2_;
               this._bossView.nameTxt.x -= (this._bossView.nameTxt.width - _loc4_) / 2;
               this._bossView.nameTxt.y -= this._bossView.nameTxt.textHeight - _loc5_;
            }
            if(this._bossView.nameInfoTxt)
            {
               _loc4_ = Number(this._bossView.nameInfoTxt.width);
               _loc5_ = Number(this._bossView.nameInfoTxt.textHeight);
               this._bossView.nameInfoTxt.scaleX = this._bossView.nameInfoTxt.scaleY = _loc2_;
               this._bossView.nameInfoTxt.x -= (this._bossView.nameInfoTxt.width - _loc4_) / 2;
               this._bossView.nameInfoTxt.y -= this._bossView.nameInfoTxt.textHeight - _loc5_;
            }
         }
         if(this._reinforceWavePane)
         {
            this.reinforceLayout(_loc6_);
         }
         var _loc1_ = this.localToGlobal(new ($.C("flash.geom.Point"))(this.x,this.y));
         $.C("chat.view.ChatTopBugleView").instance.setPos((_loc1_.x + 170) * _loc6_,(_loc1_.y + 90) * _loc6_,true);
      }
    reinforceLayout(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc3_ = 0;
         var _loc2_ = $.C("battle.BattleManager").getInstance().mainViewContainer.view;
         if(this.battleModel.battleType == 3886)
         {
            _loc3_ = this.battleModel.reinforceWave - this.battleModel.currentReinforceWave - 1;
            this._reinforceWavePane.x = this._bossView.x - _loc3_ * 98 * param1 + 430 * param1;
            this._reinforceWavePane.y = 40;
            this._gameHallAutoPane.x = this._reinforceWavePane.x + (this._reinforceWavePane.displayWidth - this._gameHallAutoPane.displayWidth) / 2;
            this._gameHallAutoPane.y = 135;
         }
         else if(this._rightIsBoss)
         {
            this._reinforceWavePane.x = _loc2_.sceneWidth - this._reinforceWavePane.right * param1 - 200;
            this._reinforceWavePane.y = this._reinforceWavePane.top * param1 + 40;
         }
         else
         {
            this._reinforceWavePane.x = _loc2_.sceneWidth - this._reinforceWavePane.right * param1;
            this._reinforceWavePane.y = this._reinforceWavePane.top * param1 + 40;
         }
      }
    get livingId() {
         if(this._boss)
         {
            return this._boss.livingId;
         }
         return 0;
      }
    __enterFrame(param1) {
         var _loc3_ = NaN;
         var _loc2_ = Number(this.battleModel.armyInfoRight.getLeftHp());
         if(this._rightIsBoss)
         {
            _loc3_ = Number(this.battleModel.armyInfoRight.getBossesLeftHp());
            this._bossView.setCurrentHp(_loc3_);
         }
         if(_loc2_ <= 0)
         {
            $.C("battle.BattleManager").getInstance().battleModel.isOver = true;
            $.C("yishi.manager.NotificationManager").instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
         if(_loc2_ > 0)
         {
            this._nextWaveCame = true;
         }
         if(_loc2_ <= 0 && this._reinforceWavePane)
         {
            if(this._nextWaveCame)
            {
               this.updateReinforceWave();
               this._nextWaveCame = false;
            }
         }
      }
    removeEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__stageResize"));
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("battle.BattleManager").getInstance().battleModel.removeEventListener("reduceWorldBossBlood",$.bind(this, "onReduceWorldBossBlood"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4174,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4462,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4435,$.bind(this, "__addBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4727,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4985,$.bind(this, "tailaHPSyncHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 360,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4889,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4285,$.bind(this, "__syncBossHpHandler"));
         $.C("yishi.service.managers.SocketManager").instance.removeEventListener("SLGSocketEvent" + 4297,$.bind(this, "__syncBossHpHandler"));
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gameHallAutoPane);
         this._gameHallAutoPane = null;
         if(this._reinforceWavePane)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._reinforceWavePane);
         }
         this._reinforceWavePane = null;
         if(this._bossView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bossView);
         }
         this._bossView = null;
         if(this.bossBufferContainer)
         {
            this.bossBufferContainer.dispose();
         }
         this.bossBufferContainer = null;
         $.C("battle.utils.Helpers").removeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this._boss = null;
      }
    set battleModel(v) { super.battleModel = v; }
    set livingId(v) { super.livingId = v; }
  }
  $.meta(__RoleShowViewII, "battle.view.ui.RoleShowViewII", ["Disposeable"]);
  return __RoleShowViewII;
}
deps["battle.view.ui.RoleShowViewII"] = ["battle.BattleManager", "battle.utils.Helpers", "battle.utils.Int64Utils", "battle.view.buffer.BossBufferContainer", "battle.view.reinforce.ReinforceWavePane", "battle.view.ui.top.BossInfoView", "chat.view.ChatTopBugleView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.utils.ObjectUtils", "com.road.yishi.proto.battle.BossHpMsg", "com.road.yishi.proto.simple.RoomBossInfoMsg", "com.road.yishi.proto.simple.SyncRoomBossHPMsg", "com.road.yishi.proto.simple.WorldBossInfoMsg", "flash.display.Sprite", "flash.geom.Point", "mvc.module.gamehall.GameHallAutoView", "yishi.comm.PackageIn", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.service.managers.SocketManager"];

defs["battle.view.ui.RoleShowViewIII"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RoleShowViewIII extends __Base {
    static $fields(self) {
    self._bossView = null;
    self._boss1 = null;
    self._boss2 = null;
    self.bossBufferContainer1 = null;
    self.bossBufferContainer2 = null;
    }
    constructor() {
         super();
         this.init();
         this.addEvent();
         this.layout();
      }
    init() {
         this.setBossInfo(this.battleModel.armyInfoRight.getHeros);
         this.createRightView();
      }
    createRightView() {
         this._bossView = new ($.C("battle.view.ui.top.DoubleBossInfoView"))();
         if(this.needExchange)
         {
            this._bossView.setInfo(this._boss2,this._boss1);
            this._bossView.setTotalHp(this.battleModel.armyInfoRight.getBossesTotalHpByInfo(this._boss2),this.battleModel.armyInfoRight.getBossesTotalHpByInfo(this._boss1));
            this._bossView.setCurrentHp(this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss2),this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss1));
            this.bossBufferContainer1 = new ($.C("battle.view.buffer.BossBufferContainer"))(this._boss2,1);
            this.bossBufferContainer2 = new ($.C("battle.view.buffer.BossBufferContainer"))(this._boss1,1);
         }
         else
         {
            this._bossView.setInfo(this._boss1,this._boss2);
            this._bossView.setTotalHp(this.battleModel.armyInfoRight.getBossesTotalHpByInfo(this._boss1),this.battleModel.armyInfoRight.getBossesTotalHpByInfo(this._boss2));
            this._bossView.setCurrentHp(this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss1),this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss2));
            this.bossBufferContainer1 = new ($.C("battle.view.buffer.BossBufferContainer"))(this._boss1,1);
            this.bossBufferContainer2 = new ($.C("battle.view.buffer.BossBufferContainer"))(this._boss2,1);
         }
         this.addChild(this._bossView);
         this.bossBufferContainer1.x = 788;
         this.bossBufferContainer1.y = 61;
         this.addChild(this.bossBufferContainer1);
         this.bossBufferContainer2.x = 788;
         this.bossBufferContainer2.y = -8;
         this.addChild(this.bossBufferContainer2);
      }
    setBossInfo(param1) {
         var _loc2_ = null;
         for (var _loc3_ of $.values(param1))
         {
            if(_loc3_.type == 3)
            {
               if(!this._boss2)
               {
                  this._boss2 = _loc3_;
               }
               else if(!this._boss1)
               {
                  this._boss1 = _loc3_;
               }
            }
         }
      }
    isNeedShowRightView() {
         if(this.battleModel.battleType == 4 || this.battleModel.battleType == 7 || this.battleModel.battleType == 5 || this.battleModel.battleType == 10 || this.battleModel.battleType == 8)
         {
            return true;
         }
         return false;
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    addEvent() {
         this.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__stageResize"));
      }
    __stageResize(param1) {
         this.layout();
      }
    layout() {
         this.resizeHeadView();
      }
    resizeHeadView() {
         var _loc4_ = NaN;
         var _loc5_ = NaN;
         var _loc3_ = $.C("battle.BattleManager").getInstance().mainViewContainer.view;
         var _loc6_ = _loc3_.sceneWidth / 1500;
         this._bossView.scaleX = this._bossView.scaleY = _loc6_;
         this._bossView.x = _loc3_.sceneWidth - this._bossView.width * _loc6_;
         this.bossBufferContainer1.x = _loc3_.sceneWidth - 520 * _loc6_;
         this.bossBufferContainer2.x = _loc3_.sceneWidth - 520 * _loc6_;
         this.bossBufferContainer1.y = 75 * _loc6_ - 70;
         this.bossBufferContainer2.y = 160 * _loc6_ - 70;
         var _loc2_ = 1 / _loc6_;
         if(this._bossView.nameTxt1)
         {
            _loc4_ = Number(this._bossView.nameTxt1.width);
            _loc5_ = Number(this._bossView.nameTxt1.textHeight);
            this._bossView.nameTxt1.scaleX = this._bossView.nameTxt1.scaleY = _loc2_;
            this._bossView.nameTxt1.x += (this._bossView.nameTxt1.width - _loc4_) / 2;
            this._bossView.nameTxt1.y -= this._bossView.nameTxt1.textHeight - _loc5_;
         }
         if(this._bossView.nameTxt2)
         {
            _loc4_ = Number(this._bossView.nameTxt2.width);
            _loc5_ = Number(this._bossView.nameTxt2.textHeight);
            this._bossView.nameTxt2.scaleX = this._bossView.nameTxt2.scaleY = _loc2_;
            this._bossView.nameTxt2.x -= (this._bossView.nameTxt2.width - _loc4_) / 2;
            this._bossView.nameTxt2.y -= this._bossView.nameTxt2.textHeight - _loc5_;
         }
         var _loc1_ = this.localToGlobal(new ($.C("flash.geom.Point"))(this.x,this.y));
         $.C("chat.view.ChatTopBugleView").instance.setPos((_loc1_.x + 170) * _loc6_,(_loc1_.y + 90) * _loc6_,true);
      }
    __enterFrame(param1) {
         var _loc3_ = NaN;
         var _loc4_ = NaN;
         var _loc2_ = Number(this.battleModel.armyInfoRight.getLeftHp());
         if(this.needExchange)
         {
            _loc3_ = Number(this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss2));
            _loc4_ = Number(this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss1));
         }
         else
         {
            _loc3_ = Number(this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss1));
            _loc4_ = Number(this.battleModel.armyInfoRight.getBossesLeftHpByInfo(this._boss2));
         }
         this._bossView.setCurrentHp(_loc3_,_loc4_);
         if(_loc2_ <= 0)
         {
            $.C("battle.BattleManager").getInstance().battleModel.isOver = true;
            $.C("yishi.manager.NotificationManager").instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
    get needExchange() {
         return this._boss1 && this._boss2 && this._boss1.pos > this._boss2.pos;
      }
    dispose() {
         if(this._bossView)
         {
            this._bossView.dispose();
         }
         this._bossView = null;
         if(this.bossBufferContainer1)
         {
            this.bossBufferContainer1.dispose();
         }
         this.bossBufferContainer1 = null;
         if(this.bossBufferContainer2)
         {
            this.bossBufferContainer2.dispose();
         }
         this.bossBufferContainer2 = null;
         $.C("battle.utils.Helpers").removeAllChildren(this);
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__stageResize"));
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this._boss1 = null;
         this._boss2 = null;
      }
    set battleModel(v) { super.battleModel = v; }
    set needExchange(v) { super.needExchange = v; }
  }
  $.meta(__RoleShowViewIII, "battle.view.ui.RoleShowViewIII", []);
  return __RoleShowViewIII;
}
deps["battle.view.ui.RoleShowViewIII"] = ["battle.BattleManager", "battle.utils.Helpers", "battle.view.buffer.BossBufferContainer", "battle.view.ui.top.DoubleBossInfoView", "chat.view.ChatTopBugleView", "com.pickgliss.toplevel.StageReferance", "flash.display.Sprite", "flash.geom.Point", "yishi.manager.NotificationManager"];

defs["battle.view.ui.SelfBufferIcon"] = function define($) {
  const __Base = $.C("yishi.view.community.BaseIconView");
  class __SelfBufferIcon extends __Base {
    static $fields(self) {
    self._layerCount = null;
    self._buffer = null;
    }
    constructor() {
         super();
         this.initView();
         this.refreshView();
      }
    set buffer(param1) {
         if(this._buffer == param1)
         {
            return;
         }
         this._buffer = param1;
         this.refreshView();
      }
    initView() {
         this._layerCount = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.SelfBufferIcon.LayerCount");
         this._layerCount.filters = [];
      }
    addChildren() {
         if(this._iconContainer)
         {
            this.addChild(this._iconContainer);
         }
         if(this._loading)
         {
            this.addChild(this._loading);
            this._loading.mouseChildren = this._loading.mouseEnabled = false;
         }
         if(this._layerCount)
         {
            this.addChild(this._layerCount);
         }
      }
    refreshView() {
         if(!this._buffer)
         {
            return;
         }
         var _loc1_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(this._buffer.templateId);
         if(this._buffer.layerCount > 1 && _loc1_.PressCount > 0)
         {
            this._layerCount.text = this._buffer.layerCount + "";
         }
         else
         {
            this._layerCount.text = "";
         }
         this.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(_loc1_.Icon);
         this.tipData = this._buffer;
      }
    getBufferName(param1) {
         var _loc3_ = null;
         var _loc2_ = 0;
         if(param1)
         {
            _loc3_ = $.C("yishi.utils.StringHelper").getSubStrBetweenTwoChar("{","}",param1.BufferName);
            if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc3_))
            {
               return param1.BufferName;
            }
            _loc2_ = param1.hasOwnProperty(_loc3_) ? Math.abs(param1[_loc3_]) * this._buffer.layerCount : 0;
            return $.C("yishi.utils.StringHelper").replaceStr(param1.BufferName,"{" + _loc3_ + "}",String(_loc2_));
         }
         return "";
      }
    dispose() {
         $.C("com.pickgliss.ui.ShowTipManager").Instance.hideTip(this);
         $.C("com.pickgliss.ui.ShowTipManager").Instance.removeTip(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._layerCount);
         this._layerCount = null;
         this._buffer = null;
         super.dispose();
      }
    get buffer() { return super.buffer; }
  }
  $.meta(__SelfBufferIcon, "battle.view.ui.SelfBufferIcon", ["Disposeable"]);
  return __SelfBufferIcon;
}
deps["battle.view.ui.SelfBufferIcon"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.utils.ObjectUtils", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.StringHelper", "yishi.view.community.BaseIconView"];

defs["battle.view.ui.SelfBufferView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __SelfBufferView extends __Base {
    static $fields(self) {
    self._currentBufferCount = 0;
    self._bufferList = null;
    self._wasteBufferByHero = null;
    self.bufferIcons = new ($.C("yishi.utils.SimpleDictionary"))();
    }
    constructor() {
         super();
         this._wasteBufferByHero = $.C("yishi.manager.BaseManager").instance.wasteBossBufferIdByHero;
         this.initWasteBossBufferView();
         this.initConsortiaEmeDreamBufferView();
         this.initEvent();
      }
    initConsortiaEmeDreamBufferView() {
         var _loc1_ = null;
         var _loc6_ = null;
         var _loc4_ = undefined;
         var _loc2_ = null;
         var _loc5_ = 0;
         var _loc3_ = null;
         if($.C("battle.BattleManager").getInstance().battleModel.battleType == 309)
         {
            _loc1_ = $.C("yishi.manager.ConsortiaManager").instance.model.emeDreamInfo.BufferIds;
            if(_loc1_)
            {
               _loc4_ = new $.Vector();
               _loc2_ = _loc1_.split(",");
               _loc5_ = 2;
               while(_loc5_ < _loc2_.length)
               {
                  _loc6_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(_loc2_[_loc5_]);
                  if(_loc6_ && _loc6_.Icon && _loc6_.Icon.length > 0)
                  {
                     _loc3_ = new ($.C("battle.data.BufferDamageData"))();
                     _loc3_.templateId = _loc6_.Id;
                     _loc4_.push(_loc3_);
                  }
                  _loc5_++;
               }
               this.reFreshBuffer(_loc4_);
            }
         }
      }
    initWasteBossBufferView() {
         var _loc5_ = null;
         var _loc2_ = undefined;
         var _loc1_ = null;
         var _loc4_ = 0;
         var _loc3_ = null;
         if($.C("battle.BattleManager").getInstance().battleModel.battleType == 3853)
         {
            if(this._wasteBufferByHero)
            {
               _loc2_ = new $.Vector();
               _loc1_ = this._wasteBufferByHero.split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc1_.length)
               {
                  _loc5_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(_loc1_[_loc4_]);
                  if(_loc5_ && _loc5_.Icon && _loc5_.Icon.length > 0)
                  {
                     _loc3_ = new ($.C("battle.data.BufferDamageData"))();
                     _loc3_.templateId = _loc5_.Id;
                     _loc2_.push(_loc3_);
                  }
                  _loc4_++;
               }
               this.reFreshBuffer(_loc2_);
            }
         }
      }
    initEvent() {
         this.roleInfo.addEventListener("REFRESH_BUFFER",$.bind(this, "__reFreshBuffer"));
         this.roleInfo.addEventListener("REFRESH_BUFFER_TURN",$.bind(this, "refreshBufferTurn"));
      }
    refreshBufferTurn(param1 = null) {
         var _loc2_ = 0;
         if(!this._bufferList)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this._bufferList.length)
         {
            ($.as(this._bufferList[_loc2_], $.C("battle.view.ui.SelfBufferIcon"))).refreshView();
            _loc2_++;
         }
      }
    removeEvent() {
         this.roleInfo.removeEventListener("REFRESH_BUFFER",$.bind(this, "__reFreshBuffer"));
         this.roleInfo.removeEventListener("REFRESH_BUFFER_TURN",$.bind(this, "refreshBufferTurn"));
      }
    __reFreshBuffer(param1) {
         var _loc2_ = null;
         this.removeBuffer();
         this.initWasteBossBufferView();
         this.initConsortiaEmeDreamBufferView();
         var _loc4_ = new $.Vector();
         for (var _loc3_ of $.values(param1.data))
         {
            if(_loc3_.currentTurn > 0)
            {
               _loc2_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID(_loc3_.templateId);
               if(_loc2_ && _loc2_.Icon && _loc2_.Icon.length > 0)
               {
                  _loc4_.push(_loc3_);
               }
            }
         }
         this.reFreshBuffer(_loc4_);
      }
    reFreshBuffer(param1 = null) {
         var _loc2_ = null;
         for (var _loc3_ of $.values(param1))
         {
            _loc2_ = this.bufferIcons[_loc3_.id];
            if(!_loc2_)
            {
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("battle.SelfBufferIcon");
               this.bufferIcons.add(_loc3_.id,_loc2_);
            }
            _loc2_.buffer = _loc3_;
            this.layerOutBuffer(_loc2_);
         }
         this._bufferList = this.bufferIcons.getList();
      }
    layerOutBuffer(param1) {
         param1.y = $.int(this._currentBufferCount / 4) * (-param1.iconHeight - 4);
         param1.x = $.int(this._currentBufferCount % 4) * (param1.iconWidth + 4);
         if(!param1.parent)
         {
            this.addChild(param1);
         }
         this._currentBufferCount = this._currentBufferCount + 1;
      }
    removeBuffer() {
         var _loc1_ = null;
         var _loc3_ = 0;
         this._currentBufferCount = 0;
         if(!this._bufferList)
         {
            return;
         }
         var _loc2_ = $.int(this._bufferList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._bufferList[_loc3_];
            if(_loc1_.parent)
            {
               this.removeChild(_loc1_);
            }
            _loc3_++;
         }
      }
    removeAllBuffer() {
         var _loc1_ = null;
         this._currentBufferCount = 0;
         if(!this.bufferIcons)
         {
            return;
         }
         for (_loc1_ of $.values(this.bufferIcons))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
            _loc1_ = null;
         }
         this.bufferIcons.clear();
         this.bufferIcons = null;
         this._bufferList = null;
      }
    setScale(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         for (var _loc2_ of $.values(this._bufferList))
         {
            _loc2_.iconHeight *= param1;
            _loc2_.iconWidth *= param1;
         }
      }
    get roleInfo() {
         return $.C("battle.BattleManager").getInstance().battleModel.selfHero;
      }
    dispose() {
         this.removeEvent();
         this.removeAllBuffer();
      }
    set roleInfo(v) { super.roleInfo = v; }
  }
  $.meta(__SelfBufferView, "battle.view.ui.SelfBufferView", ["Disposeable"]);
  return __SelfBufferView;
}
deps["battle.view.ui.SelfBufferView"] = ["battle.BattleManager", "battle.data.BufferDamageData", "battle.view.ui.SelfBufferIcon", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.BaseManager", "yishi.manager.ConsortiaManager", "yishi.manager.TempleteManager", "yishi.utils.SimpleDictionary"];

defs["battle.view.ui.SpTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SpTip extends __Base {
    static $fields(self) {
    self._numBitmapData = null;
    self._titleBm = null;
    self._currentSpSprite = null;
    self._totalSpSprite = null;
    self._divisionSign = null;
    self._container = null;
    }
    constructor() {
         super();
      }
    init() {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._numBitmapData = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.core.number_img_01");
         this._container = new ($.C("flash.display.Sprite"))();
         this.addChild(this._container);
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.commonTipBg");
         this._container.addChild(this._bg);
         this._titleBm = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.PowerUISpTipTitle");
         this._container.addChild(this._titleBm);
         this._currentSpSprite = new ($.C("flash.display.Sprite"))();
         this._container.addChild(this._currentSpSprite);
         this._divisionSign = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.PowerUISpTipDivision");
         this._container.addChild(this._divisionSign);
         this._totalSpSprite = new ($.C("flash.display.Sprite"))();
         $.C("yishi.utils.NumberViewUtils").refreshValue(100,this._totalSpSprite,this._numBitmapData,13,17,14,13);
         this._container.addChild(this._totalSpSprite);
         this.refreshView();
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._numBitmapData);
         this._numBitmapData = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleBm);
         this._titleBm = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._divisionSign);
         this._divisionSign = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._totalSpSprite);
         this._totalSpSprite = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._currentSpSprite);
         this._currentSpSprite = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._container);
         this._container = null;
         super.dispose();
      }
    $$updateTransform() {
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._currentSpSprite);
         var _loc1_ = new ($.C("com.pickgliss.ui.core.Component"))();
         $.C("yishi.utils.NumberViewUtils").refreshValue($.int(this._data),_loc1_,this._numBitmapData,13,17,14,13);
         this._currentSpSprite.addChild(_loc1_);
         this.refreshView();
      }
    refreshView() {
         var _loc1_ = 3;
         var _loc2_ = 2;
         var _loc3_ = 2;
         this._titleBm.x = _loc1_;
         this._titleBm.y = _loc3_;
         this._currentSpSprite.x = this._titleBm.x + this._titleBm.width;
         this._currentSpSprite.y = _loc3_ + _loc2_;
         this._divisionSign.x = this._currentSpSprite.x + this._currentSpSprite.width;
         this._divisionSign.y = _loc3_;
         this._totalSpSprite.x = this._divisionSign.x + this._divisionSign.width - 2;
         this._totalSpSprite.y = _loc3_ + _loc2_;
         this._bg.width = this._totalSpSprite.x + this._totalSpSprite.width + _loc1_ + 3;
         this._bg.height = 25;
         this._container.x = 20;
         this._container.y = 19;
      }
  }
  $.meta(__SpTip, "battle.view.ui.SpTip", []);
  return __SpTip;
}
deps["battle.view.ui.SpTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.utils.NumberViewUtils", "yishi.view.tips.BaseTip"];

defs["battle.view.ui.TeamStrip"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __TeamStrip extends __Base {
    static $fields(self) {
    self._backTxt = null;
    self._iconTxt = null;
    self.$$_mask = null;
    self._info = null;
    self._side = 0;
    }
    constructor(param1, param2) {
         super();
         if(param1 == null)
         {
            return;
         }
         this._info = param1;
         this._side = param2;
         this.initView();
         this.initEvent();
      }
    initView() {
         if(this._side == 1)
         {
            this._backTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.teamStripText1");
            this._iconTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.teamStripText1");
         }
         else if(this._side == 2)
         {
            this._backTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.teamStripText2");
            this._iconTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.teamStripText2");
         }
         this._backTxt.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         this.addChild(this._backTxt);
         this.addChild(this._iconTxt);
         this._backTxt.text = this._info.heroInfo.nickName;
         this._iconTxt.text = this._info.heroInfo.nickName;
         this.initMask();
         this.refreshView();
      }
    initMask() {
         this.$$_mask = new ($.C("flash.display.Shape"))();
         this.$$_mask.graphics.beginFill(16777215,0);
         this.$$_mask.graphics.drawRect(0,0,this._iconTxt.textWidth,this._iconTxt.height);
         this.$$_mask.graphics.endFill();
         if(this._side == 1)
         {
            this.$$_mask.x = 2;
         }
         else if(this._side == 2)
         {
            this.$$_mask.x = this._iconTxt.width - this._iconTxt.textWidth - 3;
         }
         this._iconTxt.mask = this.$$_mask;
         this.addChild(this.$$_mask);
      }
    refreshView() {
         if(this.$$_mask == null || this._info == null || this._iconTxt == null)
         {
            return;
         }
         this.$$_mask.width = this._iconTxt.textWidth * (this._info.bloodA / this._info.totalBloodA);
      }
    initEvent() {
         this._info.addEventListener("bloodChange",$.bind(this, "__bloodChangeHandler"));
      }
    removeEvent() {
         if(this._info)
         {
            this._info.removeEventListener("bloodChange",$.bind(this, "__bloodChangeHandler"));
         }
      }
    __bloodChangeHandler(param1) {
         this.refreshView();
      }
    dispose() {
         this.removeEvent();
         if(this._backTxt)
         {
            this._backTxt.filters = null;
            this._backTxt.dispose();
         }
         this._backTxt = null;
         if(this._iconTxt)
         {
            this._iconTxt.mask = null;
            this._iconTxt.dispose();
         }
         this._iconTxt = null;
         if(this.$$_mask)
         {
            this.$$_mask.graphics.clear();
            if(this.$$_mask.parent)
            {
               this.$$_mask.parent.removeChild(this.$$_mask);
            }
         }
         this.$$_mask = null;
         if(this._info)
         {
            this._info.dispose();
         }
         this._info = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__TeamStrip, "battle.view.ui.TeamStrip", ["Disposeable"]);
  return __TeamStrip;
}
deps["battle.view.ui.TeamStrip"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Shape", "flash.display.Sprite", "yishi.filter.UIFilter"];

defs["battle.view.ui.TrailCountView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __TrailCountView extends __Base {
    static $fields(self) {
    self._back = null;
    self._countDownValue = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
         this.refreshView();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.battle.TrailLayerBack");
         this.addChild(this._back);
         this._back.y = 10;
         this._countDownValue = new ($.C("flash.display.Sprite"))();
         this._countDownValue.y = 21;
         this._countDownValue.x = 43;
         this.addChild(this._countDownValue);
      }
    initEvent() {
         this.model.addEventListener("TRAIL_LAYER_CHANGE",$.bind(this, "__layerChangeHandler"));
      }
    removeEvent() {
         if(this.model)
         {
            this.model.removeEventListener("TRAIL_LAYER_CHANGE",$.bind(this, "__layerChangeHandler"));
         }
      }
    __layerChangeHandler(param1) {
         this.refreshView();
      }
    refreshView() {
         var _loc1_ = null;
         _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.number_img_09");
         $.C("yishi.utils.NumberViewUtils").getNumberView(this.model.trialLayer,this._countDownValue,_loc1_.bitmapData,15,19,15,15,"0123456789.",1);
         this._countDownValue.x = 27 + (36 - this._countDownValue.width) / 2;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
      }
    get width() {
         return 123;
      }
    get model() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._countDownValue);
         this._countDownValue = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set width(v) { super.width = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__TrailCountView, "battle.view.ui.TrailCountView", ["Disposeable"]);
  return __TrailCountView;
}
deps["battle.view.ui.TrailCountView"] = ["battle.BattleManager", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.utils.NumberViewUtils"];

defs["battle.view.ui.top.BattleGoddessTopItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __BattleGoddessTopItem extends __Base {
    static $fields(self) {
    self._goddessHeadMc = null;
    self._goddessHead = null;
    self._data = null;
    self.mcBeliefMax = 100;
    self._preBelief = 999;
    self._preType = -1;
    }
    constructor() {
         super();
         this.initView();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,95,112);
      }
    initView() {
         this._goddessHeadMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("BattleGoddessTopItem.goddessHeadMc");
         this._goddessHead = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("BattleGoddessTopItem.goddessHead");
         this.addChild(this._goddessHeadMc);
         this._goddessHeadMc["icon"].addChild(this._goddessHead);
         this._goddessHeadMc.gotoAndStop(1);
         this._goddessHeadMc["progress"].gotoAndStop(1);
         this._goddessHeadMc["fullMc1"].visible = false;
         this._goddessHeadMc["fullMc2"].visible = false;
         this._goddessHeadMc["fullMc1"].gotoAndStop(1);
         this._goddessHeadMc["fullMc2"].gotoAndStop(1);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
      }
    refreshView() {
         var beliefValue;
         var frame;
         if(this.data && this.data.goddessRoleInfo)
         {
            if(this._preBelief == this.data.goddessRoleInfo.belief)
            {
               return;
            }
            beliefValue = this.data.goddessRoleInfo.belief > this.mcBeliefMax ? this.mcBeliefMax : $.int(this.data.goddessRoleInfo.belief);
            frame = $.int($.int(beliefValue / 2) > 0 ? $.int(beliefValue / 2) : 1);
            if(this.data.goddessRoleInfo.belief < this._preBelief)
            {
               this._goddessHeadMc["progress"].gotoAndStop(frame);
            }
            else
            {
               this._goddessHeadMc["progress"].addFrameScript(frame - 1,() =>
               {
                  this._goddessHeadMc["progress"].stop();
                  this._goddessHeadMc["progress"].addFrameScript(frame - 1,null);
               });
               this._goddessHeadMc.play();
               this._goddessHeadMc["progress"].play();
            }
            this._preBelief = this.data.goddessRoleInfo.belief;
            if(this.data.goddessRoleInfo.belief >= 100)
            {
               this._goddessHeadMc["fullMc1"].visible = true;
               this._goddessHeadMc["fullMc2"].visible = true;
               this._goddessHeadMc["fullMc1"].gotoAndPlay(1);
               this._goddessHeadMc["fullMc2"].gotoAndPlay(1);
            }
            else
            {
               this._goddessHeadMc["fullMc1"].visible = false;
               this._goddessHeadMc["fullMc2"].visible = false;
               this._goddessHeadMc["fullMc1"].gotoAndStop(1);
               this._goddessHeadMc["fullMc2"].gotoAndStop(1);
            }
            if(this.data.goddessRoleInfo && this.data.goddessRoleInfo.template.Type != this._preType)
            {
               this._goddessHead.icon = $.C("yishi.manager.PathManager").getBattleGoddessHeadPath(this.data.goddessRoleInfo.template.Type);
               this._preType = this.data.goddessRoleInfo.templateId;
            }
         }
         else
         {
            this._goddessHead.icon = null;
            this._goddessHeadMc.gotoAndStop(1);
            this._goddessHeadMc["progress"].gotoAndStop(1);
            this._goddessHeadMc["fullMc1"].visible = false;
            this._goddessHeadMc["fullMc2"].visible = false;
            this._goddessHeadMc["fullMc1"].gotoAndStop(1);
            this._goddessHeadMc["fullMc2"].gotoAndStop(1);
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goddessHead);
         this._goddessHead = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._goddessHeadMc);
         this._goddessHeadMc = null;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__BattleGoddessTopItem, "battle.view.ui.top.BattleGoddessTopItem", ["IManualSize"]);
  return __BattleGoddessTopItem;
}
deps["battle.view.ui.top.BattleGoddessTopItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.geom.Rectangle", "yishi.manager.PathManager"];

defs["battle.view.ui.top.BattleGoddessTopView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __BattleGoddessTopView extends __Base {
    static $fields(self) {
    self._hbox = null;
    self.itemList = null;
    self.side = 0;
    }
    constructor(param1) {
         super();
         this.side = param1;
         this.initView();
         this.initListView();
         this.addEvent();
         this.refreshView();
      }
    initView() {
         this._hbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleGoddessTopView.hbox");
         this.addChild(this._hbox);
         this.mouseChildren = this.mouseEnabled = false;
      }
    initListView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this.itemList = new $.Vector();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new ($.C("battle.view.ui.top.BattleGoddessTopItem"))();
            this._hbox.addChild(_loc1_);
            this.itemList.push(_loc1_);
            _loc2_++;
         }
      }
    addEvent() {
         $.C("yishi.utils.MsgMan").addObserver("GODDESS_BELIEF_CHANGE",this,$.bind(this, "__updateGoddessBeliefHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("BATTLE_REINFORCE_HANDLER",$.bind(this, "__refreshViewHandler"));
      }
    removeEvent() {
         $.C("yishi.utils.MsgMan").removeObserver("GODDESS_BELIEF_CHANGE",this,$.bind(this, "__updateGoddessBeliefHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("BATTLE_REINFORCE_HANDLER",$.bind(this, "__refreshViewHandler"));
      }
    __refreshViewHandler(param1) {
         this.refreshView();
      }
    __updateGoddessBeliefHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.refreshView();
      }
    refreshView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = this.itemList[_loc2_];
            _loc1_.data = this.battleModel.heroList[_loc2_ + "_" + this.side];
            _loc2_++;
         }
      }
    get battleModel() {
         return $.C("battle.BattleManager").getInstance().battleModel;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hbox);
         this._hbox = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this.itemList);
         this.itemList;
         super.dispose();
      }
    set battleModel(v) { super.battleModel = v; }
  }
  $.meta(__BattleGoddessTopView, "battle.view.ui.top.BattleGoddessTopView", []);
  return __BattleGoddessTopView;
}
deps["battle.view.ui.top.BattleGoddessTopView"] = ["battle.BattleManager", "battle.view.ui.top.BattleGoddessTopItem", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "utils.LogicUtils", "yishi.manager.NotificationManager", "yishi.utils.MsgMan"];

defs["yishi.utils.Shaker"] = function define($) {
  const __Base = $.C("yishi.utils.LogicObject");
  class __Shaker extends __Base {
    static $fields(self) {
    self.shakeCount = 0;
    self.shakeDegree = 3;
    self.currentShakeCount = 0;
    self.currentDegree = 0;
    self.currentDegreeY = 0;
    self.shakeFlag = 0;
    self._target = null;
    self._blurfilter = null;
    self.$$_x = NaN;
    self.$$_y = NaN;
    self._age = 0;
    }
    constructor(param1, param2 = 5, param3 = 15) {
         super();
         this._target = param1;
         this.shakeCount = param2;
         this.shakeDegree = param3;
         this.currentDegree = param3;
         this.currentShakeCount = 0;
         this.$$_x = this._target.cameraX;
         this.$$_y = this._target.cameraY;
         param1.addEventListener("enterFrame",$.bind(this, "__enterFrame"));
      }
    stop() {
         this._target.cameraX = this.$$_x;
         this._target.cameraY = this.$$_y;
         this._target.removeEventListener("enterFrame",$.bind(this, "__enterFrame"));
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("battle.events.BattleEvent"))("shakeMapComplete",null));
      }
    __enterFrame(param1) {
         this._age += 0.25;
         if(this._age < this.shakeCount)
         {
            this.currentDegree = -this.currentDegree * 0.95;
            this._target.cameraX = this.$$_x + this.currentDegree;
            this._target.cameraY = this.$$_y + this.currentDegree;
         }
         else
         {
            this.stop();
         }
      }
  }
  $.meta(__Shaker, "yishi.utils.Shaker", []);
  return __Shaker;
}
deps["yishi.utils.Shaker"] = ["battle.events.BattleEvent", "yishi.manager.NotificationManager", "yishi.utils.LogicObject"];
