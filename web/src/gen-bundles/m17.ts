// @ts-nocheck
export const defs = {};
export const deps = {};
defs["com.map.vehicle.SkillEffectFactory"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __SkillEffectFactory extends __Base {
    static $fields(self) {
    self._setup = false;
    self._objectPool = null;
    self._resDomain = null;
    }
    constructor() {
         super();
      }
    static get instance() {
         if(!__SkillEffectFactory._instance)
         {
            __SkillEffectFactory._instance = new (__SkillEffectFactory)();
         }
         return __SkillEffectFactory._instance;
      }
    setup() {
         if(this._setup)
         {
            return;
         }
         this._setup = true;
         this._resDomain = new ($.C("com.pickgliss.loader.ResourceDomain"))();
         this._objectPool = new ($.C("flash.utils.Dictionary"))();
         this.startLoadSkillResource();
      }
    startLoadSkillResource() {
         var _loc1_ = null;
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplates();
         for (var _loc2_ of $.values(_loc3_))
         {
            _loc1_ = $.C("yishi.manager.PathManager").getVehicleSkillPath(String(_loc2_.ActionId));
            this._resDomain.load(_loc1_);
         }
      }
    createStartEffect(param1) {
         var _loc4_ = $.int(param1.skillTemplate.ActionId);
         var _loc3_ = "asset.vehicle.start" + _loc4_;
         return this.getSkillMovie(_loc3_);
      }
    createEndEffect(param1) {
         var _loc2_ = null;
         var _loc5_ = $.int(param1.skillTemplate.ActionId);
         var _loc4_ = "asset.vehicle.end" + _loc5_;
         var _loc3_ = this.getSkillMovie(_loc4_);
         if(!_loc3_)
         {
            _loc2_ = $.C("yishi.manager.PathManager").getVehicleSkillPath(String(_loc5_));
            this._resDomain.load(_loc2_);
         }
         return _loc3_;
      }
    getInstanceOfClass(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = null;
         if(this.domain.hasDefinition(param1))
         {
            _loc2_ = $.as(this.domain.createInstane(param1), $.C("flash.display.MovieClip"));
         }
         return _loc2_;
      }
    recycle(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = this._objectPool[param1];
         if(!_loc3_)
         {
            _loc3_ = [];
            this._objectPool[param1] = _loc3_;
         }
         _loc3_.push(param2);
      }
    getSkillMovie(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc2_ = this._objectPool[param1];
         if(!_loc2_)
         {
            _loc2_ = [];
            this._objectPool[param1] = _loc2_;
         }
         if(_loc2_.length > 0)
         {
            _loc4_ = _loc2_.pop();
         }
         else
         {
            _loc3_ = this.getInstanceOfClass(param1);
            if(_loc3_)
            {
               _loc4_ = new ($.C("com.map.vehicle.view.VehicleSkillMovie"))(param1,_loc3_);
            }
         }
         return _loc4_;
      }
    getFlyClassArray(param1) {
         var _loc4_ = 0;
         var _loc3_ = null;
         var _loc2_ = [];
         var _loc5_ = $.int(param1.skillTemplate.ActionId);
         var _loc6_ = "asset.vehicle.fly" + _loc5_;
         _loc4_ = 1;
         while(_loc4_ < 11)
         {
            _loc3_ = _loc6_ + ".fx" + _loc4_;
            if(this.domain.hasDefinition(_loc3_))
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
    createBuffEffect(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc2_ = $.C("com.map.vehicle.utils.VehicleUtil").getBuffTemplate(param1);
         if(!_loc2_)
         {
            return null;
         }
         if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc2_.LastEffect))
         {
            return null;
         }
         var _loc4_ = "asset.vehicle." + _loc2_.LastEffect;
         if(this.domain.hasDefinition(_loc4_))
         {
            _loc3_ = $.as(this.domain.createInstane(_loc4_), $.C("flash.display.MovieClip"));
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
         }
         return _loc3_;
      }
    slicePath(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = param1.indexOf("?");
         return _loc2_ > -1 ? param1.slice(0,_loc2_) : param1;
      }
    get domain() {
         return this._resDomain;
      }
    dispose() {
         for (var _loc1_ of $.values(this._objectPool))
         {
            for (var _loc2_ of $.values(_loc1_))
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc2_);
            }
         }
         this._objectPool = null;
         __SkillEffectFactory._instance = null;
         this._setup = false;
      }
    static set instance(v) { super.instance = v; }
    set domain(v) { super.domain = v; }
  }
  $.meta(__SkillEffectFactory, "com.map.vehicle.SkillEffectFactory", []);
  $.statics(__SkillEffectFactory, () => {
    __SkillEffectFactory._instance = null;
  });
  return __SkillEffectFactory;
}
deps["com.map.vehicle.SkillEffectFactory"] = ["com.map.vehicle.utils.VehicleUtil", "com.map.vehicle.view.VehicleSkillMovie", "com.pickgliss.loader.ResourceDomain", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.events.EventDispatcher", "flash.utils.Dictionary", "yishi.manager.PathManager", "yishi.manager.TempleteManager", "yishi.utils.StringHelper"];

defs["com.map.vehicle.VehicleCharacterController"] = function define($) {
  const __Base = $.Object;
  class __VehicleCharacterController extends __Base {
    static $fields(self) {
    self.isSelection = false;
    self.scale = 1;
    self._currentSkill = null;
    self._currentSkillInfo = null;
    self._listnerSetuped = false;
    self._logicWrold = null;
    self._model = null;
    self._vehicleinfo = null;
    }
    constructor(param1, param2) {
         super();
         this._logicWrold = param1;
         this._model = param2;
         if(!this._model.selfVehicleInfo)
         {
            this._model.addEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         }
         else
         {
            this._vehicleinfo = this._model.selfVehicleInfo;
            this.addEvent();
         }
      }
    cancel() {
         this._currentSkill = null;
         this.isSelection = false;
      }
    dispose() {
         this.removeEvent();
         this._model = null;
         this._logicWrold = null;
      }
    keyDownHandler(param1) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc9_ = null;
         var _loc5_ = null;
         var _loc2_ = $.C("flash.utils.getTimer")();
         $.C("yishi.manager.CursorManagerII").instance.resetCursor();
         var _loc8_ = this._model.skillBag.getSkillByKey(param1);
         if(!_loc8_)
         {
            return;
         }
         if(!_loc8_.tempalte)
         {
            return;
         }
         if(!this._vehicleinfo)
         {
            return;
         }
         if(this._vehicleinfo.isStun)
         {
            return;
         }
         if(_loc2_ - _loc8_.lastTime < _loc8_.tempalte.CoolDown)
         {
            return;
         }
         if(this._model.remainsTime <= 0)
         {
            return;
         }
         if(_loc8_.tempalte.Maximum > 0 && _loc8_.count <= 0)
         {
            return;
         }
         if(this._vehicleinfo.hp <= 0)
         {
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.noattack");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
            return;
         }
         if(this._vehicleinfo.isCasting)
         {
            return;
         }
         this._currentSkill = null;
         var _loc4_ = _loc8_.tempalte;
         var _loc7_ = new ($.C("com.map.vehicle.data.SkillCastInfo"))();
         if(_loc4_.InjuryEffect == 1)
         {
            _loc9_ = this._logicWrold.getClicker();
            if($.is(_loc9_, $.C("com.map.vehicle.objects.VehicleBoxView")))
            {
               return;
            }
            if(_loc9_)
            {
               if(_loc8_.tempalte.IFF == 1)
               {
                  if($.is(_loc9_, $.C("com.map.vehicle.objects.TankAvatarView")))
                  {
                     _loc6_ = $.as(_loc9_, $.C("com.map.vehicle.objects.TankAvatarView"));
                     if(_loc6_.isFriend)
                     {
                        return;
                     }
                     if(_loc6_.data.hp <= 0)
                     {
                        _loc3_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.attackTipDie");
                        $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
                        this._logicWrold.selectedLogic = null;
                        return;
                     }
                     if(_loc6_.data.checkBuff(4))
                     {
                        return;
                     }
                  }
               }
               else if(_loc8_.tempalte.IFF == 2)
               {
                  if(!($.is(_loc9_, $.C("com.map.vehicle.objects.TankAvatarView"))))
                  {
                     return;
                  }
                  _loc6_ = $.as(_loc9_, $.C("com.map.vehicle.objects.TankAvatarView"));
                  if(!_loc6_.isFriend)
                  {
                     return;
                  }
               }
               _loc7_.skillid = _loc4_.TemplateId;
               _loc7_.target = _loc9_;
               _loc7_.castPos = null;
               this._vehicleinfo.cast(_loc7_);
            }
            else
            {
               if(_loc4_.InjuryEffect != 0)
               {
                  if(_loc8_.tempalte.IFF == 1)
                  {
                     _loc5_ = $.C("com.map.vehicle.data.VGlobal").logicWorld.findNearEnemy();
                     if(_loc5_)
                     {
                        _loc7_.skillid = _loc4_.TemplateId;
                        _loc7_.target = _loc5_;
                        _loc7_.castPos = null;
                        this._vehicleinfo.cast(_loc7_);
                        $.C("com.map.vehicle.data.VGlobal").logicWorld.selectedLogic = _loc5_;
                     }
                  }
                  return;
               }
               _loc7_.skillid = _loc4_.TemplateId;
               _loc7_.target = this._vehicleinfo.logicView;
               _loc7_.castPos = null;
               this._vehicleinfo.cast(_loc7_);
            }
         }
         else if(_loc4_.InjuryEffect == 2 || _loc4_.InjuryEffect == 4)
         {
            this._currentSkill = _loc4_;
            $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("mouseUp",$.bind(this, "__mouseDownHandler"));
            this.isSelection = true;
            this.scale = _loc4_.DamageCoverage * 2 / 500;
         }
         this._currentSkillInfo = _loc8_;
      }
    __addPlayerHandler(param1) {
         if(param1.data == this._model.selfVehicleInfo)
         {
            this._vehicleinfo = this._model.selfVehicleInfo;
            this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
            this.addEvent();
         }
      }
    __changeSkillHandler(param1) {
         if(this._currentSkill)
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("mouseUp",$.bind(this, "__mouseDownHandler"));
            if(this._currentSkill.TemplateId != ($.as(param1.data, $.C("com.map.vehicle.data.VehicleSkillInfo"))).templateId)
            {
               this._currentSkill = null;
               this.isSelection = false;
               this.scale = 1;
            }
         }
      }
    __selfDieHandler(param1) {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("mouseUp",$.bind(this, "__mouseDownHandler"));
         this.isSelection = false;
         this._currentSkill = null;
         this.scale = 1;
      }
    __mouseDownHandler(param1) {
         var _loc2_ = $.C("flash.utils.getTimer")();
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("mouseUp",$.bind(this, "__mouseDownHandler"));
         this.isSelection = false;
         if(!this._currentSkill)
         {
            return;
         }
         if(!this._currentSkillInfo)
         {
            return;
         }
         if(!this._currentSkillInfo.tempalte)
         {
            return;
         }
         if(_loc2_ - this._currentSkillInfo.lastTime < this._currentSkillInfo.tempalte.CoolDown)
         {
            return;
         }
         $.C("yishi.manager.CursorManagerII").instance.resetCursor();
         var _loc3_ = new ($.C("com.map.vehicle.data.SkillCastInfo"))();
         _loc3_.skillid = this._currentSkill.TemplateId;
         _loc3_.target = null;
         _loc3_.castPos = this._logicWrold.getMouesPos();
         this._vehicleinfo.cast(_loc3_);
         this._currentSkill = null;
      }
    __onClick(param1) {
      }
    __onKeyDown(param1) {
         var _loc2_ = 0;
         switch(param1.keyCode)
         {
            case 49:
            case 50:
            case 81:
               if(this.isSelection)
               {
                  return;
               }
               this.keyDownHandler(param1.keyCode);
               break;
            case 27:
               this.cancel();
               break;
            default:
               return;
         }
      }
    __onKeyUp(param1) {
      }
    addEvent() {
         if(this._listnerSetuped)
         {
            return;
         }
         var _loc1_ = $.C("com.pickgliss.toplevel.StageReferance").stage;
         _loc1_.addEventListener("keyDown",$.bind(this, "__onKeyDown"));
         _loc1_.addEventListener("keyUp",$.bind(this, "__onKeyUp"));
         _loc1_.addEventListener("click",$.bind(this, "__onClick"));
         this._model.skillBag.addEventListener("CHANGE_SKILL",$.bind(this, "__changeSkillHandler"));
         this._vehicleinfo.addEventListener("DIE",$.bind(this, "__selfDieHandler"));
         this._listnerSetuped = true;
      }
    removeEvent() {
         var _loc1_ = $.C("com.pickgliss.toplevel.StageReferance").stage;
         _loc1_.removeEventListener("keyDown",$.bind(this, "__onKeyDown"));
         _loc1_.removeEventListener("keyUp",$.bind(this, "__onKeyUp"));
         _loc1_.removeEventListener("click",$.bind(this, "__onClick"));
         if(this._model && this._model.skillBag)
         {
            this._model.skillBag.removeEventListener("CHANGE_SKILL",$.bind(this, "__changeSkillHandler"));
         }
         if(this._vehicleinfo)
         {
            this._vehicleinfo.removeEventListener("DIE",$.bind(this, "__selfDieHandler"));
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("mouseUp",$.bind(this, "__mouseDownHandler"));
         this._listnerSetuped = false;
      }
  }
  $.meta(__VehicleCharacterController, "com.map.vehicle.VehicleCharacterController", []);
  return __VehicleCharacterController;
}
deps["com.map.vehicle.VehicleCharacterController"] = ["com.map.vehicle.data.SkillCastInfo", "com.map.vehicle.data.VGlobal", "com.map.vehicle.data.VehicleSkillInfo", "com.map.vehicle.objects.TankAvatarView", "com.map.vehicle.objects.VehicleBoxView", "com.pickgliss.toplevel.StageReferance", "flash.utils.getTimer", "manager.LanguageMgr", "yishi.manager.CursorManagerII", "yishi.view.tips.MessageTipManager"];

defs["com.map.vehicle.VehicleModel"] = function define($) {
  const __Base = $.C("map.internals.data.MapInfo");
  class __VehicleModel extends __Base {
    static $fields(self) {
    self.blueScore = 0;
    self.bossTempId = 2191;
    self.createType = 0;
    self.isWin = false;
    self.myScore = 0;
    self.redScore = 0;
    self._remainsTime = 0;
    self.reward1 = 0;
    self.reward2 = 0;
    self.rewardExp = 0;
    self.bossRefreshed = false;
    self._campaignId = 0;
    self._nodeList = null;
    self._playerList = null;
    self._selfVehicleInfo = null;
    self._skillBag = null;
    self.playerInfo = null;
    self.startDate = new Date();
    self.endDate = new Date();
    self.campaiganStartTime = new Date();
    }
    constructor(param1) {
         $.pre(new.target, (__s) => {
         __s.playerInfo = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
         });
         super();
         $.preFlush(this, new.target);
         this._campaignId = param1;
         this.mapId = param1;
         this._playerList = new ($.C("yishi.utils.SimpleDictionary"))(true);
         this._nodeList = new $.Vector();
         this._skillBag = new ($.C("com.map.vehicle.data.VehicleSkillbag"))();
         this.initStartEndDate();
      }
    addNode(param1) {
         if(param1.state == 1)
         {
            this.removeNode(param1);
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("REMOVE_NODE",param1));
            return;
         }
         if(!this.hasNode(param1))
         {
            this._nodeList.push(param1);
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("addNode",param1));
         }
         else
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("updateNode",param1));
         }
      }
    addPlayer(param1) {
         if(param1.playerId == this.playerInfo.userId)
         {
            if(!this._selfVehicleInfo)
            {
               this._selfVehicleInfo = param1;
               this._skillBag.init(this._selfVehicleInfo);
            }
         }
         if(this._playerList[param1.playerId])
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("update_player",param1));
         }
         else
         {
            this._playerList.add(param1.playerId,param1);
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("addPlayer",param1));
         }
      }
    bossAttackNotice(param1) {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("ATTACK_NOTICE",param1));
      }
    get campaignId() {
         return this._campaignId;
      }
    get currentChanelPlayerList() {
         var _loc1_ = [];
         for (var _loc2_ of $.values(this._playerList))
         {
            _loc1_.push(_loc2_.playerId);
         }
         return _loc1_;
      }
    getBoss() {
         for (var _loc1_ of $.values(this.nodeList))
         {
            if(_loc1_.isBoss())
            {
               return _loc1_;
            }
         }
         return null;
      }
    getHandlerNode(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = 0;
         var _loc5_ = NaN;
         var _loc7_ = new ($.C("flash.geom.Point"))(param1,param2);
         var _loc6_ = new ($.C("flash.geom.Point"))();
         for (var _loc3_ of $.values(this._nodeList))
         {
            _loc4_ = 2;
            _loc4_ = $.int(_loc4_ < _loc3_.handlerRange ? _loc3_.handlerRange : 2);
            _loc6_.x = _loc3_.posX;
            _loc6_.y = _loc3_.posY;
            _loc5_ = $.C("flash.geom.Point").distance(_loc7_,_loc6_);
            if(_loc5_ <= _loc4_ + 2 && !this.isPassedNode(_loc3_))
            {
               return _loc3_;
            }
         }
         return null;
      }
    getNeighborII(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = 0;
         var _loc3_ = null;
         _loc4_ = 1;
         while(_loc4_ < 10)
         {
            _loc3_ = this.find(_loc4_,param1,param2);
            if(_loc3_)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
    getNodeByNodeId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         for (var _loc2_ of $.values(this.nodeList))
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
    getPlayerInfo(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this._playerList[param1];
      }
    getPointValue(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = $.int(this.mapTielsData[param1 + "_" + param2]);
         return _loc3_ > 0 && _loc3_ != 2 ? true : false;
      }
    getTeamMembers() {
         var _loc1_ = [];
         if(!this._selfVehicleInfo)
         {
            return _loc1_;
         }
         for (var _loc2_ of $.values(this._playerList))
         {
            if(_loc2_.team == this._selfVehicleInfo.team && _loc2_.playerId != this._selfVehicleInfo.playerId)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("id",0x10 | 2);
         return _loc1_;
      }
    getWalkable(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = $.int(this.mapTielsData[param1 + "_" + param2]);
         return _loc3_ > 0 && _loc3_ != 2 ? true : false;
      }
    hasNode(param1) {
         for (var _loc2_ of $.values(this._nodeList))
         {
            if(_loc2_.nodeId == param1.nodeId)
            {
               return true;
            }
         }
         return false;
      }
    isFriend(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this.selfVehicleInfo)
         {
            return false;
         }
         return this.selfVehicleInfo.team == param1;
      }
    get nodeList() {
         return this._nodeList;
      }
    get playerList() {
         return this._playerList;
      }
    removeNode(param1) {
         var _loc2_ = this._nodeList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this._nodeList.splice(_loc2_,1);
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("REMOVE_NODE",param1));
         }
      }
    removePlayer(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = this._playerList[param1];
         if(_loc2_)
         {
            this._playerList.del(param1);
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("remove_player",_loc2_));
         }
         return _loc2_;
      }
    get selfVehicleInfo() {
         return this._selfVehicleInfo;
      }
    get skillBag() {
         return this._skillBag;
      }
    startCountTime() {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("START_COUNTTIME",this));
      }
    syncPlayerInfo() {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("PLAYE_LIST_UPDATE",this));
      }
    syncScore() {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SCORE_CHANGE",this));
      }
    get teamChanelPlayerList() {
         var _loc1_ = [];
         for (var _loc2_ of $.values(this._playerList))
         {
            if(_loc2_.team == this.selfVehicleInfo.team)
            {
               _loc1_.push(_loc2_.playerId);
            }
         }
         return _loc1_;
      }
    find(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = 0;
         _loc4_ = -param1;
         while(_loc4_ < param1)
         {
            if(this.getPointValue(param2 + _loc4_,param3 + param1))
            {
               return new ($.C("flash.geom.Point"))(param2 + _loc4_,param3 + param1);
            }
            if(this.getPointValue(param2 + _loc4_,param3 - param1))
            {
               return new ($.C("flash.geom.Point"))(param2 + _loc4_,param3 - param1);
            }
            if(this.getPointValue(param2 + param1,param3 + _loc4_))
            {
               return new ($.C("flash.geom.Point"))(param2 + param1,param3 + _loc4_);
            }
            if(this.getPointValue(param2 - param1,param3 + _loc4_))
            {
               return new ($.C("flash.geom.Point"))(param2 - param1,param3 + _loc4_);
            }
            _loc4_++;
         }
         return null;
      }
    isPassedNode(param1) {
         switch(param1.state - 1)
         {
            case 0:
               return true;
            default:
               return false;
         }
      }
    get remainsTime() {
         var _loc1_ = 0;
         var _loc2_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.sysCurtime;
         if(this.startDate.time <= _loc2_.time && _loc2_.time < this.endDate.time)
         {
            _loc1_ = this._remainsTime - (_loc2_.time - this.campaiganStartTime.time) / 1000;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
         }
         return _loc1_;
      }
    initStartEndDate() {
         var _loc9_ = null;
         var _loc1_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc2_ = null;
         var _loc7_ = null;
         var _loc3_ = null;
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("MatchOfVehicleTime");
         if(_loc4_)
         {
            _loc9_ = _loc4_.ConfigValue.split("|");
            for (var _loc8_ of $.values(_loc9_))
            {
               _loc1_ = _loc8_.split(",");
               _loc5_ = _loc1_[0];
               _loc6_ = _loc5_.split(":");
               this.startDate.time = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.sysCurTimeBySecond * 1000;
               this.startDate.hours = parseInt(_loc6_[0]);
               this.startDate.minutes = parseInt(_loc6_[1]);
               this.startDate.seconds = 0;
               _loc2_ = _loc1_[1];
               _loc7_ = _loc2_.split(":");
               this.endDate.time = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.sysCurTimeBySecond * 1000;
               this.endDate.hours = parseInt(_loc7_[0]);
               this.endDate.minutes = parseInt(_loc7_[1]);
               this.endDate.seconds = 0;
               _loc3_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.sysCurtime;
               if(this.startDate.time <= _loc3_.time && _loc3_.time < this.endDate.time)
               {
                  return;
               }
            }
         }
      }
    set remainsTime(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._remainsTime = param1;
         this.campaiganStartTime.time = this.endDate.time - param1 * 1000;
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("CAMPAIGN_TIME",this));
      }
    get riverTimeConst() {
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("revivalTime");
         var _loc1_ = 30;
         if(_loc2_)
         {
            _loc1_ = parseInt(_loc2_.ConfigValue);
         }
         return _loc1_;
      }
    set campaignId(v) { super.campaignId = v; }
    set currentChanelPlayerList(v) { super.currentChanelPlayerList = v; }
    set nodeList(v) { super.nodeList = v; }
    set playerList(v) { super.playerList = v; }
    set selfVehicleInfo(v) { super.selfVehicleInfo = v; }
    set skillBag(v) { super.skillBag = v; }
    set teamChanelPlayerList(v) { super.teamChanelPlayerList = v; }
    set riverTimeConst(v) { super.riverTimeConst = v; }
  }
  $.meta(__VehicleModel, "com.map.vehicle.VehicleModel", ["ISceneChat"]);
  return __VehicleModel;
}
deps["com.map.vehicle.VehicleModel"] = ["com.map.vehicle.data.VehicleSkillbag", "com.map.vehicle.events.VehicleEvent", "flash.geom.Point", "map.internals.data.MapInfo", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.SimpleDictionary"];

defs["com.map.vehicle.VehicleSceneController"] = function define($) {
  const __Base = $.C("yishi.scene.BaseSceneView");
  class __VehicleSceneController extends __Base {
    static $fields(self) {
    self._campaignSendTimeId = 0;
    self._logicWorld = null;
    self._model = null;
    self._preLoad = null;
    self._preLoadingOver = false;
    self._rectScanUtils = null;
    self.key = null;
    }
    constructor() {
         super();
         $.C("com.map.vehicle.data.VGlobal").scene = this;
      }
    get SceneName() {
         return "VEHICLE";
      }
    enter(param1, param2 = null) {
         $.C("com.road.mapengine.ai.astar.AIManager").instance.data = this._model;
         $.C("chat.ChatSocketOutManager").sceneChat = this._model;
         var _loc3_ = [$.C("com.map.vehicle.mediator.MapCameraMediator"),$.C("com.map.vehicle.mediator.VehicleWalkTargetMediator"),$.C("com.map.vehicle.mediator.VehicleUIMediator")];
         this.key = $.C("yishi.manager.MediatorMananger").instance.registerMediatorList(_loc3_,this,"aaaa");
         this._logicWorld = new ($.C("com.map.vehicle.VehicleView"))(this);
         $.C("com.map.vehicle.data.VGlobal").logicWorld = this._logicWorld;
         this._logicWorld.model = this._model;
         $.C("com.road.mapengine.bitmap.EngineManager").instance.setup(this._logicWorld);
         this._rectScanUtils = new ($.C("com.map.vehicle.utils.WalkRectScanUtils"))();
         $.C("yishi.keyboard.KeyBoardRegister").instance.vehicleFlag = true;
         $.C("yishi.manager.NotificationManager").instance.sendNotification("INPUT_CHANNEL_CHANGE",6);
      }
    enterOver() {
         $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonVisible = false;
         $.C("ui.maintoolbar.MainToolBar").instance.hide();
         $.C("ui.toptoolbar.TopToolsBar").instance.hide();
         $.C("ui.tasktracebar.TaskTraceBar").instance.hide();
         $.C("com.map.vehicle.VehicleChatController").getInstance().start();
      }
    getWalkable(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return this._model.getPointValue(param1,param2);
      }
    leaving() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.vehicleFlag = false;
         $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonVisible = true;
         $.C("yishi.manager.MediatorMananger").instance.unregisterMediatorList(this.key,this);
         $.C("com.road.mapengine.bitmap.EngineManager").instance.dispose();
         this._logicWorld.dispose();
         $.C("com.map.vehicle.VehicleChatController").getInstance().dispose();
         $.C("com.map.vehicle.SkillEffectFactory").instance.dispose();
         $.C("com.map.vehicle.net.VehicleSocketManager").instance.dispose();
         $.C("map.internals.library.MapElmsLibrary").instance.unLock();
         this._model = null;
         this._logicWorld = null;
         this._rectScanUtils = null;
         $.C("com.map.vehicle.data.VGlobal").logicWorld = null;
         $.C("com.map.vehicle.data.VGlobal").model = null;
         $.C("com.map.vehicle.data.VGlobal").scene = null;
         this._preLoad = null;
         $.C("chat.ChatSocketOutManager").sceneChat = null;
      }
    moveVehicleToPos(param1, param2) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if (typeof param2 !== "number") param2 = Number(param2);
         if(!this._model.selfVehicleInfo)
         {
            return;
         }
         if(this._model.selfVehicleInfo.isStun)
         {
            return;
         }
         var _loc6_ = $.as(this._model.selfVehicleInfo.logicView, $.C("com.map.vehicle.objects.TankAvatarView"));
         if(!_loc6_)
         {
            return;
         }
         var _loc4_ = new ($.C("flash.geom.Point"))(_loc6_.x,_loc6_.y);
         var _loc8_ = new ($.C("flash.geom.Point"))(param1,param2);
         var _loc7_ = this.getStartPoint(_loc6_.x,_loc6_.y,_loc8_);
         var _loc5_ = new ($.C("flash.geom.Point"))($.int(_loc7_.x / 20),$.int(_loc7_.y / 20));
         this.initRectScan();
         var _loc9_ = this._rectScanUtils.walkRectScan(_loc8_,_loc5_,_loc4_);
         _loc9_ = new ($.C("flash.geom.Point"))($.int(_loc9_.x / 20),$.int(_loc9_.y / 20));
         var _loc3_ = $.C("com.road.mapengine.ai.astar.AIManager").instance.find(_loc5_,_loc9_);
         if(_loc3_)
         {
            if(_loc3_.length > 0)
            {
               _loc3_.shift();
            }
            _loc6_.path = _loc3_;
         }
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("UPDATE_WALK_TARGET",new ($.C("flash.geom.Point"))(_loc9_.x * 20,_loc9_.y * 20)));
      }
    preLoadingStart(param1 = null) {
         $.C("com.map.vehicle.net.VehicleSocketManager").instance.setup(true);
         $.C("com.map.vehicle.net.VehicleSocketManager").instance.controller = this;
         this._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
         $.C("map.internals.library.MapElmsLibrary").instance.lock();
         $.C("com.map.vehicle.SkillEffectFactory").instance.setup();
         if($.C("map.internals.MapData").mapId == this._model.mapTempInfo.Id && $.C("map.internals.MapData").mapBitmap && this._model.mapTielsData)
         {
            this.preLoadingOver();
         }
         else
         {
            if(this._model.createType == 3)
            {
               this._preLoadingOver = false;
               this._campaignSendTimeId = $.C("flash.utils.setInterval")($.bind(this, "showLoading"),1500);
            }
            this._preLoad = new ($.C("map.campaign.preload.PreCampaignData"))(this._model);
            this._preLoad.syncBackCall($.bind(this, "preLoadingOver"));
         }
      }
    get vehicleWorld() {
         return this._logicWorld;
      }
    preLoadingOver() {
         this._preLoadingOver = true;
         super.preLoadingOver();
      }
    getStartPoint(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(this.getWalkable(param1 / 20,param2 / 20))
         {
            return new ($.C("flash.geom.Point"))(param1,param2);
         }
         var _loc4_ = this._model.getNeighborII(param1 / 20,param2 / 20);
         _loc4_.x *= 20;
         _loc4_.y *= 20;
         return _loc4_;
      }
    initRectScan() {
         this._rectScanUtils.outWidth = this._model.mapTempInfo.Width / 20;
         this._rectScanUtils.outHeight = this._model.mapTempInfo.Height / 20;
         this._rectScanUtils.getWalkable = $.bind(this, "getWalkable");
      }
    preLoadFunction() {
      }
    showLoading() {
         if(this._campaignSendTimeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._campaignSendTimeId);
         }
         this._campaignSendTimeId = 0;
         if(!this._preLoadingOver)
         {
            $.C("yishi.view.community.LoadingSceneView").instance.show();
         }
      }
    set SceneName(v) { super.SceneName = v; }
    set vehicleWorld(v) { super.vehicleWorld = v; }
  }
  $.meta(__VehicleSceneController, "com.map.vehicle.VehicleSceneController", []);
  return __VehicleSceneController;
}
deps["com.map.vehicle.VehicleSceneController"] = ["chat.ChatSocketOutManager", "com.map.vehicle.SkillEffectFactory", "com.map.vehicle.VehicleChatController", "com.map.vehicle.VehicleView", "com.map.vehicle.data.VGlobal", "com.map.vehicle.events.VehicleEvent", "com.map.vehicle.mediator.MapCameraMediator", "com.map.vehicle.mediator.VehicleUIMediator", "com.map.vehicle.mediator.VehicleWalkTargetMediator", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.objects.TankAvatarView", "com.map.vehicle.utils.WalkRectScanUtils", "com.road.mapengine.ai.astar.AIManager", "com.road.mapengine.bitmap.EngineManager", "flash.geom.Point", "flash.utils.clearInterval", "flash.utils.setInterval", "map.campaign.preload.PreCampaignData", "map.internals.MapData", "map.internals.library.MapElmsLibrary", "ui.maintoolbar.MainToolBar", "ui.tasktracebar.TaskTraceBar", "ui.toptoolbar.TopToolsBar", "yishi.keyboard.KeyBoardRegister", "yishi.manager.MediatorMananger", "yishi.manager.NotificationManager", "yishi.scene.BaseSceneView", "yishi.view.community.LoadingSceneView"];

defs["com.map.vehicle.VehicleView"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.BaseMapScene");
  class __VehicleView extends __Base {
    static $fields(self) {
    self._objectLayer = null;
    self._nameLayer = null;
    self._backMapModel = null;
    self._backMapView = null;
    self._bossAttackNoticeMc = null;
    self._characterController = null;
    self._count = 0;
    self._cursorMc = null;
    self._isDown = false;
    self._mapController = null;
    self._model = null;
    self._mouseDownTimeId = 0;
    self._selectedEffect = null;
    self._selectedLogic = null;
    self._selfArmy = null;
    self._tempArr = [];
    self._timeId = 0;
    self._topLayer = null;
    self._walkLayer = null;
    self._staticLayer = null;
    self._self = null;
    }
    constructor(param1) {
         super(param1);
      }
    get topLayer() {
         return this._topLayer;
      }
    get nameLayer() {
         return this._nameLayer;
      }
    init() {
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc1_ = null;
         this._objectLayer = new ($.C("flash.display.Sprite"))();
         this._nameLayer = new ($.C("flash.display.Sprite"))();
         this._nameLayer.mouseChildren = this._nameLayer.mouseEnabled = false;
         this._backMapModel = new ($.C("com.road.mapengine.bitmap.map.BaseMapsData"))();
         this._backMapModel.elmsData = $.C("map.internals.library.MapElmsLibrary").instance;
         this._backMapModel.mapWidth = this._model.mapTempInfo.Width;
         this._backMapModel.mapHeight = this._model.mapTempInfo.Height;
         this._backMapModel.mapData = this._model.floorData;
         this._backMapView = new ($.C("com.road.mapengine.bitmap.map.BaseMapsView"))();
         this._backMapView.data = this._backMapModel;
         this._mapController = $.as(this.parent, $.C("com.map.vehicle.VehicleSceneController"));
         this._staticLayer = new ($.C("flash.display.Sprite"))();
         this._walkLayer = new ($.C("flash.display.Sprite"))();
         this._topLayer = new ($.C("flash.display.Sprite"))();
         this._objectLayer.addChild(this._backMapView);
         this._objectLayer.addChild(this._staticLayer);
         this._objectLayer.addChild(this._walkLayer);
         this._objectLayer.addChild(this._topLayer);
         this.parent.addChild(this._objectLayer);
         this.parent.addChild(this._nameLayer);
         this._cursorMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.SkillCursor");
         this._cursorMc.mouseChildren = false;
         this._selectedEffect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.SelectedEffect");
         this._selectedEffect.gotoAndStop(1);
         this._selectedEffect.mouseEnabled = this._selectedEffect.mouseChildren = false;
         this._bossAttackNoticeMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.BossSkillCursor");
         this._bossAttackNoticeMc.gotoAndStop(1);
         this._bossAttackNoticeMc.mouseEnabled = this._bossAttackNoticeMc.mouseChildren = false;
         for (var _loc5_ of $.values(this._model.playerList.getList()))
         {
            _loc4_ = new ($.C("com.map.vehicle.objects.TankAvatarView"))(this);
            _loc4_.angle = 36;
            _loc4_.data = _loc5_;
            _loc4_.x = _loc5_.x * 20;
            _loc4_.y = _loc5_.y * 20;
            _loc4_.state = 3;
            this.addLogic(_loc4_);
            this.addToWalkLayer(_loc4_.container);
         }
         for (var _loc2_ of $.values(this._model.nodeList))
         {
            if(_loc2_.resource != 1)
            {
               _loc3_ = new ($.C("com.map.vehicle.objects.VehicleBoxView"))(this);
               _loc3_.data = _loc2_;
               _loc3_.x = _loc2_.posX * 20;
               _loc3_.y = _loc2_.posY * 20;
               this.addLogic(_loc3_);
               this.addToStaticLayer(_loc3_.container);
            }
            else
            {
               _loc1_ = new ($.C("com.map.vehicle.objects.VehicleNpcAvatarView"))(this);
               _loc1_.data = _loc2_;
               _loc1_.x = _loc2_.posX * 20;
               _loc1_.y = _loc2_.posY * 20;
               _loc1_.state = 3;
               this.addLogic(_loc1_);
               this.addToStaticLayer(_loc1_.container);
            }
         }
         if(this._model.selfVehicleInfo && this._model.selfVehicleInfo.logicView)
         {
            this._mapController.dispatchEvent(new ($.C("map.campaign.event.CampaignMapEvent"))("LOOK_AT_ROLE",this._model.selfVehicleInfo.logicView));
         }
      }
    get self() {
         return this._self;
      }
    set self(param1) {
         this.removeSelfEvent();
         this._self = param1;
         this.addSelfEvent();
      }
    addEvent() {
         this.addEventListener("mouseDown",$.bind(this, "__mouseClickHandler"));
         this.addEventListener("mouseUp",$.bind(this, "__mouseUpHandler"));
         this.addEventListener("mouseOut",$.bind(this, "__mouseOutHandler"));
         this.addEventListener("mouseOver",$.bind(this, "__mouseOverHandler"));
         this.addEventListener("mouseMove",$.bind(this, "__mouseMoveHandler"));
         this.addEventListener("deactivate",$.bind(this, "__deactiveteHandler"));
         this._model.addEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         this._model.addEventListener("remove_player",$.bind(this, "__removePlayerHandler"));
         this._model.addEventListener("addNode",$.bind(this, "__addNodeHandler"));
         this._model.addEventListener("updateNode",$.bind(this, "__updateNodeHandler"));
         this._model.addEventListener("REMOVE_NODE",$.bind(this, "__updateNodeHandler"));
         this._model.addEventListener("ATTACK_NOTICE",$.bind(this, "__attackNoticeHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("EARTHQUAKE",$.bind(this, "__earthQuakeHandler"));
         if(this._model.selfVehicleInfo)
         {
            this.self = this._model.selfVehicleInfo;
         }
      }
    removeEvent() {
         this.removeEventListener("mouseDown",$.bind(this, "__mouseClickHandler"));
         this.removeEventListener("mouseUp",$.bind(this, "__mouseUpHandler"));
         this.removeEventListener("mouseOut",$.bind(this, "__mouseOutHandler"));
         this.removeEventListener("mouseOver",$.bind(this, "__mouseOverHandler"));
         this.removeEventListener("mouseMove",$.bind(this, "__mouseMoveHandler"));
         this.removeEventListener("deactivate",$.bind(this, "__deactiveteHandler"));
         this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         this._model.removeEventListener("remove_player",$.bind(this, "__removePlayerHandler"));
         this._model.removeEventListener("addNode",$.bind(this, "__addNodeHandler"));
         this._model.removeEventListener("updateNode",$.bind(this, "__updateNodeHandler"));
         this._model.removeEventListener("REMOVE_NODE",$.bind(this, "__updateNodeHandler"));
         this._model.removeEventListener("ATTACK_NOTICE",$.bind(this, "__attackNoticeHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("EARTHQUAKE",$.bind(this, "__earthQuakeHandler"));
      }
    addSelfEvent() {
         if(this._self)
         {
            this._self.addEventListener("SKILL_SHOOT_OVER",$.bind(this, "__earthQuakeHandler"));
            this._self.addEventListener("SKILL_HURT",$.bind(this, "__earthQuakeHandler"));
            this._self.addEventListener("DIE",$.bind(this, "__selfDieHandler"));
            this._self.addEventListener("REVIER",$.bind(this, "__selfRevierHandler"));
         }
      }
    removeSelfEvent() {
         if(this._self)
         {
            this._self.removeEventListener("SKILL_SHOOT_OVER",$.bind(this, "__earthQuakeHandler"));
            this._self.removeEventListener("SKILL_HURT",$.bind(this, "__earthQuakeHandler"));
            this._self.removeEventListener("DIE",$.bind(this, "__selfDieHandler"));
            this._self.removeEventListener("REVIER",$.bind(this, "__selfRevierHandler"));
         }
      }
    __earthQuakeHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc4_ = null;
         if($.is(param1.data, $.C("com.map.vehicle.data.UseSkillInfo")))
         {
            _loc3_ = $.as(param1.data, $.C("com.map.vehicle.data.UseSkillInfo"));
            _loc2_ = [13,5,6];
            if(_loc2_.indexOf(_loc3_.skillId) >= 0)
            {
               $.C("map.internals.effect.Earthquake").go(this.parent,10,0.2);
            }
         }
         else if($.is(param1.data, $.C("com.map.vehicle.data.HurtData")))
         {
            _loc4_ = $.as(param1.data, $.C("com.map.vehicle.data.HurtData"));
            if(_loc4_.attackType == 1)
            {
               $.C("map.internals.effect.Earthquake").go(this.parent,10,0.2);
            }
         }
      }
    __selfDieHandler(param1) {
      }
    __selfRevierHandler(param1) {
      }
    addToStaticLayer(param1) {
         return this._staticLayer.addChild(param1);
      }
    addToWalkLayer(param1) {
         return this._walkLayer.addChild(param1);
      }
    get characterController() {
         return this._characterController;
      }
    enterFrame() {
         if(this._characterController.isSelection)
         {
            if(!this._cursorMc.parent)
            {
               this._staticLayer.addChild(this._cursorMc);
               this._cursorMc.scaleX = this._characterController.scale;
               this._cursorMc.scaleY = this._characterController.scale;
            }
            this._cursorMc.x = this._topLayer.mouseX;
            this._cursorMc.y = this._topLayer.mouseY;
         }
         else if(this._cursorMc.parent)
         {
            this._cursorMc.parent.removeChild(this._cursorMc);
         }
         super.enterFrame();
         this.updateWalkDepth();
         this.checkFoucs();
      }
    findNearEnemy() {
         var _loc5_ = null;
         var _loc2_ = null;
         var _loc4_ = 0;
         if(!this._model.selfVehicleInfo)
         {
            return null;
         }
         if(!this._model.selfVehicleInfo.logicView)
         {
            return null;
         }
         var _loc6_ = 800;
         var _loc1_ = new ($.C("flash.geom.Point"))(this._model.selfVehicleInfo.logicView.x,this._model.selfVehicleInfo.logicView.y);
         var _loc3_ = 800;
         for (var _loc7_ of $.values(this._model.playerList))
         {
            if(_loc7_ != this._model.selfVehicleInfo)
            {
               if(!this._model.isFriend(_loc7_.team))
               {
                  if(_loc7_.logicView)
                  {
                     _loc2_ = new ($.C("flash.geom.Point"))(_loc7_.logicView.x,_loc7_.logicView.y);
                     _loc4_ = $.C("flash.geom.Point").distance(_loc1_,_loc2_);
                     if(_loc4_ < _loc6_ && _loc4_ < _loc3_ && _loc7_.hp > 0)
                     {
                        _loc3_ = _loc4_;
                        _loc5_ = _loc7_.logicView;
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
    getClicker() {
         return this.selectedLogic;
      }
    getMouesPos() {
         return new ($.C("flash.geom.Point"))(this._mapController.mouseX,this._mapController.mouseY);
      }
    set model(param1) {
         this._model = param1;
         this._characterController = new ($.C("com.map.vehicle.VehicleCharacterController"))(this,this._model);
         this.init();
         this.addEvent();
      }
    moveMeToPos(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._mapController.moveVehicleToPos(param1,param2);
      }
    get selectedLogic() {
         return this._selectedLogic;
      }
    set selectedLogic(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         if(this._selectedLogic)
         {
            this._selectedLogic.unSelect();
            this._selectedLogic = null;
         }
         if(this._model.selfVehicleInfo.isDie)
         {
            return;
         }
         if(this._selectedEffect.parent)
         {
            this._selectedEffect.parent.removeChild(this._selectedEffect);
            this._selectedEffect.hitArea = null;
         }
         if($.is(param1, $.C("com.map.vehicle.objects.TankAvatarView")))
         {
            _loc3_ = $.as(param1, $.C("com.map.vehicle.objects.TankAvatarView"));
            if(!_loc3_.data.isDie)
            {
               this._selectedLogic = param1;
               this._selectedLogic.select(this._selectedEffect);
               this._selectedEffect.play();
            }
         }
         else if($.is(param1, $.C("com.map.vehicle.objects.VehicleNpcAvatarView")))
         {
            _loc2_ = $.as(param1, $.C("com.map.vehicle.objects.VehicleNpcAvatarView"));
            if(!_loc2_.isDie)
            {
               this._selectedLogic = param1;
               this._selectedLogic.select(this._selectedEffect);
               this._selectedEffect.play();
            }
         }
         else
         {
            this._selectedEffect.gotoAndStop(1);
         }
      }
    updateWalkDepth() {
         var _loc2_ = 0;
         var _loc1_ = null;
         var _loc3_ = 0;
         this._count = this._count + 1;
         if(this._count % 20 != 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this._walkLayer.numChildren)
         {
            _loc1_ = this._walkLayer.getChildAt(_loc2_);
            this._tempArr.push({
               "obj":_loc1_,
               "x":_loc1_.x,
               "y":_loc1_.y,
               "index":_loc2_
            });
            _loc2_++;
         }
         this._tempArr = this._tempArr.sort($.bind(this, "checkDepth"));
         _loc3_ = 0;
         while(_loc3_ < this._tempArr.length)
         {
            if(this._tempArr[_loc3_].index != _loc3_)
            {
               if(this._walkLayer.numChildren > _loc3_)
               {
                  this._walkLayer.addChildAt($.as(this._tempArr[_loc3_].obj, $.C("flash.display.DisplayObject")),_loc3_);
               }
               else
               {
                  this._walkLayer.addChild($.as(this._tempArr[_loc3_].obj, $.C("flash.display.DisplayObject")));
               }
            }
            _loc3_++;
         }
         while(this._tempArr.length > 0)
         {
            this._tempArr.pop();
         }
      }
    __addNodeHandler(param1) {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc3_ = $.as(param1.data, $.C("com.map.vehicle.data.VehicleNode"));
         if(_loc3_.resource != 1)
         {
            _loc4_ = new ($.C("com.map.vehicle.objects.VehicleBoxView"))(this);
            _loc4_.data = _loc3_;
            _loc4_.x = _loc3_.posX * 20;
            _loc4_.y = _loc3_.posY * 20;
            this.addLogic(_loc4_);
            this.addToStaticLayer(_loc4_.container);
         }
         else
         {
            _loc2_ = new ($.C("com.map.vehicle.objects.VehicleNpcAvatarView"))(this);
            _loc2_.data = _loc3_;
            _loc2_.x = _loc3_.posX * 20;
            _loc2_.y = _loc3_.posY * 20;
            this.addLogic(_loc2_);
            this.addToStaticLayer(_loc2_.container);
         }
      }
    __addPlayerHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = $.as(param1.data, $.C("com.map.vehicle.data.PlayerVehicleInfo"));
         if(_loc3_)
         {
            _loc2_ = new ($.C("com.map.vehicle.objects.TankAvatarView"))(this);
            _loc2_.angle = 36;
            _loc2_.data = _loc3_;
            _loc2_.x = _loc3_.x * 20;
            _loc2_.y = _loc3_.y * 20;
            this.addLogic(_loc2_);
            this.addToWalkLayer(_loc2_.container);
            if(this._model.selfVehicleInfo == _loc3_)
            {
               this.self = this._model.selfVehicleInfo;
               this._mapController.dispatchEvent(new ($.C("map.campaign.event.CampaignMapEvent"))("LOOK_AT_ROLE",this._model.selfVehicleInfo.logicView));
            }
         }
      }
    __attackNoticeHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("flash.geom.Point"));
         this._staticLayer.addChildAt(this._bossAttackNoticeMc,0);
         this._bossAttackNoticeMc.x = _loc2_.x;
         this._bossAttackNoticeMc.y = _loc2_.y;
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
            this._timeId = 0;
         }
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "noticeEnd"),2000);
      }
    __deactiveteHandler(param1) {
         if(this._mouseDownTimeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._mouseDownTimeId);
         }
         this._mouseDownTimeId = 0;
         this._isDown = false;
      }
    __mouseClickHandler(param1) {
         var _loc3_ = null;
         if(this._mouseDownTimeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._mouseDownTimeId);
         }
         this._mouseDownTimeId = 0;
         if($.is(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite")))
         {
            _loc3_ = ($.as(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite"))).logic;
            if(_loc3_.mouseClickEvent(param1))
            {
               this.selectedLogic = _loc3_;
               return;
            }
         }
         if(this._characterController.isSelection)
         {
            return;
         }
         var _loc2_ = this.getMouesPos();
         this.moveMeToPos(_loc2_.x,_loc2_.y);
         this._isDown = true;
         this._mouseDownTimeId = $.C("flash.utils.setInterval")($.bind(this, "clickWalk"),500);
      }
    __mouseMoveHandler(param1) {
         var _loc2_ = null;
         if($.is(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite")))
         {
            _loc2_ = ($.as(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite"))).logic;
            if(_loc2_.mouseMoveEvent(param1))
            {
               return;
            }
         }
      }
    __mouseOutHandler(param1) {
         var _loc2_ = null;
         if($.is(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite")))
         {
            _loc2_ = ($.as(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite"))).logic;
            if(_loc2_.mouseOutEvent(param1))
            {
               return;
            }
         }
      }
    __mouseOverHandler(param1) {
         var _loc2_ = null;
         if($.is(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite")))
         {
            _loc2_ = ($.as(param1.target, $.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite"))).logic;
            if(_loc2_.mouseOverEvent(param1))
            {
               return;
            }
         }
      }
    __mouseUpHandler(param1) {
         if(this._mouseDownTimeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._mouseDownTimeId);
         }
         this._mouseDownTimeId = 0;
         this._isDown = false;
      }
    __removePlayerHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = $.as(param1.data, $.C("com.map.vehicle.data.PlayerVehicleInfo"));
         if(_loc3_)
         {
            _loc2_ = _loc3_.logicView;
            if(_loc2_)
            {
               _loc2_.dispose();
               this.removeLogic(_loc2_);
            }
            if(_loc2_ == this.selectedLogic)
            {
               this.selectedLogic = null;
            }
         }
      }
    __updateNodeHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.VehicleNode"));
         if(_loc2_)
         {
            _loc3_ = _loc2_.logicView;
            if(_loc2_.state == 1)
            {
               if(_loc3_ == this.selectedLogic)
               {
                  this.selectedLogic = null;
               }
               if(_loc3_)
               {
                  _loc3_.dispose();
                  this.removeLogic(_loc3_);
               }
            }
         }
      }
    checkDepth(param1, param2) {
         if(param1.y > param2.y)
         {
            return 1;
         }
         if(param1.y == param2.y)
         {
            if(param1.x < param2.x)
            {
               return -1;
            }
            if(param1.x > param2.x)
            {
               return 1;
            }
            return param1.index > param2.index ? 1 : -1;
         }
         return -1;
      }
    checkFoucs() {
         if(!this.selectedLogic)
         {
            return;
         }
         if(!this._model.selfVehicleInfo)
         {
            return;
         }
         if(!this._model.selfVehicleInfo.logicView)
         {
            return;
         }
         var _loc1_ = new ($.C("flash.geom.Point"))(this._model.selfVehicleInfo.logicView.x,this._model.selfVehicleInfo.logicView.y);
         var _loc3_ = new ($.C("flash.geom.Point"))(this.selectedLogic.x,this.selectedLogic.y);
         var _loc2_ = $.C("flash.geom.Point").distance(_loc1_,_loc3_);
         if(_loc2_ > 800)
         {
            this.selectedLogic = null;
         }
      }
    clickWalk() {
         var _loc1_ = null;
         if(this._mouseDownTimeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._mouseDownTimeId);
         }
         this._mouseDownTimeId = 0;
         if(this._isDown)
         {
            this._mouseDownTimeId = $.C("flash.utils.setInterval")($.bind(this, "clickWalk"),500);
            _loc1_ = this.getMouesPos();
            this.moveMeToPos(_loc1_.x,_loc1_.y);
         }
      }
    getLogicsUnderPoint(param1) {
         var _loc2_ = [];
         for (var _loc3_ of $.values(this._list))
         {
            if(_loc3_.hitRect.containsPoint(param1))
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("instanceId",2);
         return _loc2_;
      }
    noticeEnd() {
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
            this._timeId = 0;
         }
         if(this._bossAttackNoticeMc && this._bossAttackNoticeMc.parent)
         {
            this._bossAttackNoticeMc.parent.removeChild(this._bossAttackNoticeMc);
         }
      }
    dispose() {
         this.removeEvent();
         if(this._mouseDownTimeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._mouseDownTimeId);
            this._mouseDownTimeId = 0;
         }
         if(this._characterController)
         {
            this._characterController.dispose();
            this._characterController = null;
         }
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
            this._timeId = 0;
         }
         if(this._selectedEffect)
         {
            this._selectedEffect.gotoAndStop(1);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectedEffect);
         }
         if(this._cursorMc)
         {
            this._cursorMc.gotoAndStop(1);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._cursorMc);
         }
         if(this._bossAttackNoticeMc)
         {
            this._bossAttackNoticeMc.gotoAndStop(1);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bossAttackNoticeMc);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._staticLayer);
         this._staticLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._walkLayer);
         this._walkLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._topLayer);
         this._topLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._objectLayer);
         this._objectLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._nameLayer);
         this._nameLayer = null;
         if(this._backMapModel)
         {
            this._backMapModel.elmsData = null;
            this._backMapModel.mapData = null;
            this._backMapModel = null;
         }
         if(this._backMapView)
         {
            this._backMapView.dispose();
            this._backMapView = null;
         }
         this.self = null;
         this._selectedLogic = null;
         super.dispose();
      }
    set topLayer(v) { super.topLayer = v; }
    set nameLayer(v) { super.nameLayer = v; }
    set characterController(v) { super.characterController = v; }
    get model() { return super.model; }
  }
  $.meta(__VehicleView, "com.map.vehicle.VehicleView", []);
  return __VehicleView;
}
deps["com.map.vehicle.VehicleView"] = ["com.map.vehicle.VehicleCharacterController", "com.map.vehicle.VehicleSceneController", "com.map.vehicle.data.HurtData", "com.map.vehicle.data.PlayerVehicleInfo", "com.map.vehicle.data.UseSkillInfo", "com.map.vehicle.data.VehicleNode", "com.map.vehicle.objects.TankAvatarView", "com.map.vehicle.objects.VehicleBoxView", "com.map.vehicle.objects.VehicleNpcAvatarView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.road.mapengine.bitmap.BaseMapScene", "com.road.mapengine.bitmap.logic.VehicleBaseSprite", "com.road.mapengine.bitmap.map.BaseMapsData", "com.road.mapengine.bitmap.map.BaseMapsView", "flash.display.DisplayObject", "flash.display.Sprite", "flash.geom.Point", "flash.utils.clearInterval", "flash.utils.clearTimeout", "flash.utils.setInterval", "flash.utils.setTimeout", "map.campaign.event.CampaignMapEvent", "map.internals.effect.Earthquake", "map.internals.library.MapElmsLibrary", "yishi.manager.NotificationManager"];

defs["com.map.vehicle.action.AccountAction"] = function define($) {
  const __Base = $.Object;
  class __AccountAction extends __Base {
    static $fields(self) {
    self._data = null;
    self._createTime = $.C("flash.utils.getTimer")();
    self._returnScene = null;
    }
    constructor(param1) {
         if($.C("yishi.scene.SceneManager").instance.currentType == "VEHICLE")
         {
            $.C("yishi.SwitchPageHelp").returnToSpace();
         }
         $.pre(new.target, (__s) => {
         __s._data = param1;
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(__s);
         __s._returnScene = $.C("yishi.SwitchPageHelp").returnScene;
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SWITCH_SCENE",$.bind(__s, "__showHandler"));
         });
         super();
         $.preFlush(this, new.target);
      }
    __showHandler(param1) {
         var _loc2_ = null;
         if($.C("yishi.scene.SceneManager").instance.currentType == this._returnScene)
         {
            $.C("yishi.manager.NotificationManager").instance.removeEventListener("SWITCH_SCENE",$.bind(this, "__showHandler"));
            $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.createComponentGroupByStylename("vehicle.VehicleAccountFrame");
            _loc2_.show(this._data);
            this._data = null;
         }
         else if($.C("yishi.scene.SceneManager").instance.currentType == "VEHICLE")
         {
            $.C("yishi.SwitchPageHelp").returnToSpace();
         }
      }
    enterFrame() {
         if($.C("flash.utils.getTimer")() - this._createTime > 200000)
         {
            $.C("yishi.manager.NotificationManager").instance.removeEventListener("SWITCH_SCENE",$.bind(this, "__showHandler"));
            $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
            this._data = null;
            return;
         }
      }
  }
  $.meta(__AccountAction, "com.map.vehicle.action.AccountAction", ["IEnterFrame"]);
  return __AccountAction;
}
deps["com.map.vehicle.action.AccountAction"] = ["com.pickgliss.ui.ComponentFactory", "flash.utils.getTimer", "yishi.SwitchPageHelp", "yishi.manager.EnterFrameManager", "yishi.manager.NotificationManager", "yishi.scene.SceneManager"];

defs["com.map.vehicle.action.BaseVehicleAction"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __BaseVehicleAction extends __Base {
    static $fields(self) {
    self._finished = false;
    }
    constructor() {
         super();
      }
    synchronization() {
      }
    get finished() {
         return this._finished;
      }
    replace(param1) {
         return false;
      }
    prepare() {
      }
    filter(param1) {
         return false;
      }
    update() {
      }
    cancel() {
      }
    get priority() {
         return 0;
      }
    dispose() {
         this._finished = true;
      }
    getCode() {
         return 0;
      }
    ready(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return false;
      }
    get type() {
         return null;
      }
    pause() {
      }
    resume() {
      }
    get canCancel() {
         return false;
      }
    set priority(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         throw new Error("not implemented!!!");
      }
    get canDisplay() {
         throw new Error("not implemented!!!");
      }
    get isAlone() {
         throw new Error("not implemented!!!");
      }
    get delayFrameCount() {
         throw new Error("not implemented!!!");
      }
    set delayFrameCount(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         throw new Error("not implemented!!!");
      }
    get timePriority() {
         throw new Error("not implemented!!!");
      }
    set timePriority(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         throw new Error("not implemented!!!");
      }
    set finished(v) { super.finished = v; }
    set type(v) { super.type = v; }
    set canCancel(v) { super.canCancel = v; }
    set canDisplay(v) { super.canDisplay = v; }
    set isAlone(v) { super.isAlone = v; }
  }
  $.meta(__BaseVehicleAction, "com.map.vehicle.action.BaseVehicleAction", ["IAction"]);
  return __BaseVehicleAction;
}
deps["com.map.vehicle.action.BaseVehicleAction"] = ["flash.events.EventDispatcher"];

defs["com.map.vehicle.action.CastAction"] = function define($) {
  const __Base = $.C("com.map.vehicle.action.BaseVehicleAction");
  class __CastAction extends __Base {
    static $fields(self) {
    self._castMc = null;
    self._tween = null;
    self._stage = null;
    self._skillId = 0;
    self._skillTemp = null;
    self._distance = 100;
    self._model = null;
    self._world = null;
    self._state = 0;
    self._targetLogic = null;
    self._targetPoint = null;
    self._shooter = null;
    self.shootPoint = null;
    self._sendCastTime = NaN;
    self._castMcStarTime = NaN;
    self._isSend = false;
    self._count = 0;
    }
    constructor(param1, param2) {
         super();
         this._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
         this._world = $.C("com.map.vehicle.net.VehicleSocketManager").instance.controller.vehicleWorld;
         this._shooter = param1;
         this._skillId = param2;
         this._skillTemp = $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(this._skillId);
         this._distance = this._skillTemp.AttackRange;
         this._stage = $.C("com.pickgliss.toplevel.StageReferance").stage;
         $.C("yishi.keyboard.KeyBoardRegister").instance.battleFlag = true;
      }
    get type() {
         return this._skillId.toString();
      }
    filter(param1) {
         if($.is(param1, __CastAction))
         {
            return true;
         }
         return false;
      }
    prepare() {
         var _loc1_ = NaN;
         if(this._targetPoint != null)
         {
            this.shootPoint = this._targetPoint.clone();
         }
         else
         {
            if(this._targetLogic == null)
            {
               this.cancel();
               this.dispose();
               return;
            }
            this.shootPoint = new ($.C("flash.geom.Point"))(this._targetLogic.x,this._targetLogic.y);
         }
         _loc1_ = $.C("flash.geom.Point").distance(new ($.C("flash.geom.Point"))(this._shooter.x,this._shooter.y),this.shootPoint);
         if(_loc1_ <= this._distance)
         {
            this.startCast();
         }
         else
         {
            this.startMove(this.shootPoint);
         }
         if(this._stage)
         {
            this._stage.addEventListener("click",$.bind(this, "__onStageClickHandler"));
         }
      }
    __onStageClickHandler(param1) {
         if(this._state == 2)
         {
            this.dispose();
            return;
         }
      }
    startCast() {
         this._state = 1;
         if(this._shooter && this._shooter.data)
         {
            this._shooter.stop();
            this._shooter.data.isCasting = true;
            $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendCampaignArmyMove(this._shooter.data.playerId,[this._shooter.getTilePoint()]);
         }
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("UPDATE_WALK_TARGET",null));
         this._castMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.core.CollectionAsset");
         if(this._castMc["stateMc"])
         {
            ($.as(this._castMc["stateMc"], $.C("flash.display.MovieClip"))).gotoAndStop(4);
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._castMc,3,false);
         this._sendCastTime = this._skillTemp.CastTime * 0.5;
         var _loc1_ = this._skillTemp.CastTime / 1000;
         if(_loc1_ > 0)
         {
            this.__stageResizeHandler();
            this._shooter.changeDirectionTo(this.shootPoint.x,this.shootPoint.y);
            this._castMcStarTime = $.C("flash.utils.getTimer")();
            this._isSend = false;
            this._tween = $.C("com.greensock.TweenMax").to(this._castMc,_loc1_,{
               "frame":this._castMc.totalFrames,
               "onUpdate":$.bind(this, "send"),
               "onComplete":$.bind(this, "__tweenComplete")
            });
            if(this._stage)
            {
               this._stage.addEventListener("resize",$.bind(this, "__stageResizeHandler"));
            }
            if(this._shooter.data)
            {
               this._shooter.data.addEventListener("SKILL_CAST_OVER",$.bind(this, "__castOverHandler"));
            }
            return;
         }
         this.__onCastCompleteHandler();
         this.dispose();
      }
    send() {
         if(this._isSend)
         {
            return;
         }
         var _loc1_ = $.C("flash.utils.getTimer")();
         if(_loc1_ - this._castMcStarTime > this._sendCastTime)
         {
            this._isSend = true;
            this.__onCastCompleteHandler();
         }
      }
    __tweenComplete() {
         this.dispose();
      }
    __castOverHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.UseSkillInfo"));
         if(_loc2_.skillId == this._skillId)
         {
            this.dispose();
         }
      }
    startMove(param1) {
         this._state = 2;
         var _loc2_ = this.findPath(Math.floor(this._shooter.x),Math.floor(this._shooter.y),Math.floor(param1.x),Math.floor(param1.y));
         if(_loc2_ && _loc2_.length > 2)
         {
            _loc2_.shift();
            this._shooter.path = _loc2_;
         }
      }
    findPath(param1, param2, param3, param4) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var _loc6_ = this._model.getAroundWalkPoint(param1,param2);
         if(!_loc6_)
         {
            return null;
         }
         var _loc7_ = this._model.getAroundWalkPoint(param3,param4);
         if(!_loc7_)
         {
            return null;
         }
         var _loc5_ = $.C("com.road.mapengine.ai.astar.AIManager").instance.find(_loc6_,_loc7_);
         if(_loc5_)
         {
            if(_loc5_.length > 2)
            {
               _loc5_.shift();
            }
         }
         return _loc5_;
      }
    __onCastCompleteHandler() {
         if($.C("yishi.scene.SceneManager").instance.currentType != "VEHICLE")
         {
            this._finished = true;
            return;
         }
         this.sendUseSkill();
         this.finishCast();
         this._state = 0;
      }
    sendUseSkill() {
         var _loc6_ = null;
         var _loc7_ = null;
         var _loc2_ = new ($.C("flash.geom.Point"))(this._shooter.x,this._shooter.y);
         if(this._targetLogic)
         {
            _loc6_ = new ($.C("flash.geom.Point"))(this._targetLogic.x,this._targetLogic.y);
         }
         else
         {
            if(!this._targetPoint)
            {
               return;
            }
            _loc6_ = this._targetPoint.clone();
         }
         _loc2_.x = Math.floor(_loc2_.x / 20);
         _loc2_.y = Math.floor(_loc2_.y / 20);
         _loc6_.x = Math.floor(_loc6_.x / 20);
         _loc6_.y = Math.floor(_loc6_.y / 20);
         var _loc3_ = _loc6_;
         var _loc5_ = false;
         if(this._skillTemp.InjuryEffect == 1)
         {
            _loc7_ = this.findPoints(_loc2_,_loc6_);
            for (var _loc1_ of $.values(_loc7_))
            {
               if(this._model.isBarrier(_loc1_.x,_loc1_.y))
               {
                  _loc3_ = _loc1_;
                  _loc5_ = true;
                  break;
               }
            }
         }
         var _loc8_ = [];
         var _loc4_ = [];
         if(!_loc5_)
         {
            if(this._targetLogic)
            {
               if($.is(this._targetLogic, $.C("com.map.vehicle.objects.TankAvatarView")))
               {
                  _loc8_.push(($.as(this._targetLogic, $.C("com.map.vehicle.objects.TankAvatarView"))).data.playerId);
               }
               else if($.is(this._targetLogic, $.C("com.map.vehicle.objects.VehicleNpcAvatarView")))
               {
                  _loc4_.push(($.as(this._targetLogic, $.C("com.map.vehicle.objects.VehicleNpcAvatarView"))).data.nodeId);
               }
            }
            else if(this._targetPoint)
            {
               _loc8_ = this.findNearPlayers(this._targetPoint,this._skillTemp.DamageCoverage);
               _loc4_ = this.findNearNpcs(this._targetPoint,this._skillTemp.DamageCoverage);
            }
         }
         $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendCastSkill(this._skillId,_loc8_,_loc4_,_loc3_.x,_loc3_.y);
      }
    finishCast() {
         this._model.skillBag.skillStartCD(this._skillId);
         this._model.skillBag.reduceSkillCount(this._skillId);
      }
    findPoints(param1, param2) {
         var _loc7_ = 0;
         var _loc6_ = 0;
         var _loc5_ = 0;
         var _loc4_ = 0;
         var _loc9_ = NaN;
         var _loc8_ = 0;
         var _loc3_ = [];
         if(param1.x == param2.x)
         {
            _loc5_ = Math.max(param1.y,param2.y);
            _loc7_ = _loc4_ = Math.min(param1.y,param2.y);
            while(_loc7_ < _loc5_)
            {
               _loc3_.push(new ($.C("flash.geom.Point"))(param1.x,_loc7_));
               _loc7_++;
            }
         }
         else
         {
            _loc9_ = (param2.y - param1.y) / (param2.x - param1.x);
            _loc8_ = param2.x > param1.x ? 1 : -1;
            _loc6_ = param1.x;
            while(_loc6_ != param2.x)
            {
               _loc7_ = (_loc6_ - param1.x) * _loc9_ + param1.y;
               _loc3_.push(new ($.C("flash.geom.Point"))(_loc6_,_loc7_));
               _loc6_ += _loc8_;
            }
         }
         return _loc3_;
      }
    findNearPlayers(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc8_ = null;
         var _loc3_ = [];
         var _loc4_ = this._world.getAllLogic();
         var _loc5_ = new ($.C("flash.geom.Point"))();
         var _loc6_ = 0;
         for (var _loc7_ of $.values(_loc4_))
         {
            if($.is(_loc7_, $.C("com.map.vehicle.objects.TankAvatarView")))
            {
               _loc5_.x = _loc7_.x;
               _loc5_.y = _loc7_.y;
               _loc6_ = $.C("flash.geom.Point").distance(param1,_loc5_);
               if(_loc6_ < param2)
               {
                  _loc8_ = ($.as(_loc7_, $.C("com.map.vehicle.objects.TankAvatarView"))).data;
                  if(_loc8_)
                  {
                     if(this._skillTemp.IFF == 1 && !this._model.isFriend(_loc8_.team))
                     {
                        _loc3_.push(_loc8_.playerId);
                     }
                     else if(this._skillTemp.IFF == 2 && this._model.isFriend(_loc8_.team))
                     {
                        _loc3_.push(_loc8_.playerId);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
    findNearNpcs(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = [];
         var _loc4_ = this._world.getAllLogic();
         var _loc5_ = new ($.C("flash.geom.Point"))();
         var _loc6_ = 0;
         for (var _loc7_ of $.values(_loc4_))
         {
            if($.is(_loc7_, $.C("com.map.vehicle.objects.VehicleNpcAvatarView")))
            {
               _loc5_.x = _loc7_.x;
               _loc5_.y = _loc7_.y;
               _loc6_ = $.C("flash.geom.Point").distance(param1,_loc5_);
               if(_loc6_ < param2)
               {
                  _loc3_.push(($.as(_loc7_, $.C("com.map.vehicle.objects.VehicleNpcAvatarView"))).data.nodeId);
               }
            }
         }
         return _loc3_;
      }
    update() {
         var _loc3_ = null;
         var _loc1_ = null;
         var _loc2_ = NaN;
         var _loc4_ = null;
         if(this._shooter.data.isDie)
         {
            this._finished = true;
            return;
         }
         if(this._targetLogic)
         {
            if($.is(this._targetLogic, $.C("com.map.vehicle.objects.TankAvatarView")))
            {
               _loc3_ = $.as(this._targetLogic, $.C("com.map.vehicle.objects.TankAvatarView"));
               if(_loc3_.data.isDie)
               {
                  this._finished = true;
                  return;
               }
            }
            if($.is(this._targetLogic, $.C("com.map.vehicle.objects.VehicleNpcAvatarView")))
            {
               _loc1_ = $.as(this._targetLogic, $.C("com.map.vehicle.objects.VehicleNpcAvatarView"));
               if(_loc1_.data.isDie)
               {
                  this._finished = true;
                  return;
               }
            }
         }
         this._count = this._count + 1;
         if(this._state == 2)
         {
            if(this._targetLogic != null)
            {
               _loc4_ = new ($.C("flash.geom.Point"))(this._targetLogic.x,this._targetLogic.y);
            }
            else
            {
               if(this._targetPoint == null)
               {
                  this._finished = true;
                  return;
               }
               _loc4_ = this._targetPoint.clone();
            }
            _loc2_ = $.C("flash.geom.Point").distance(new ($.C("flash.geom.Point"))(this._shooter.x,this._shooter.y),_loc4_);
            if(_loc2_ < this._distance + 40)
            {
               this.startCast();
            }
            else if(this._count % 80 == 0)
            {
               this.startMove(_loc4_);
            }
         }
         else if(this._state == 1)
         {
            if(this._shooter.path && this._shooter.path.length > 0)
            {
               this._finished = true;
               return;
            }
            if($.C("com.map.vehicle.data.TankState").isStrongControl(this._shooter.data.state))
            {
               this._finished = true;
               return;
            }
         }
      }
    __stageResizeHandler(param1 = null) {
         if(this._castMc)
         {
            this._castMc.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._castMc.width) / 2 - 29;
            this._castMc.y = $.C("com.pickgliss.toplevel.StageReferance").stageHeight - 200;
         }
      }
    get targetLogic() {
         return this._targetLogic;
      }
    set targetLogic(param1) {
         if(this.targetPoint)
         {
            return;
         }
         if($.is(param1, $.C("com.map.vehicle.objects.TankAvatarView")) || $.is(param1, $.C("com.map.vehicle.objects.VehicleNpcAvatarView")))
         {
            this._targetLogic = param1;
         }
      }
    get targetPoint() {
         return this._targetPoint;
      }
    set targetPoint(param1) {
         if(this.targetLogic)
         {
            return;
         }
         this._targetPoint = param1;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.battleFlag = false;
         if(this._shooter && this._shooter.data)
         {
            this._shooter.data.isCasting = false;
            this._shooter.data.removeEventListener("SKILL_CAST_OVER",$.bind(this, "__castOverHandler"));
            this._shooter = null;
         }
         if(this._stage)
         {
            this._stage.removeEventListener("resize",$.bind(this, "__stageResizeHandler"));
            this._stage.removeEventListener("click",$.bind(this, "__onStageClickHandler"));
            this._stage = null;
         }
         if(this._tween)
         {
            this._tween.kill();
            this._tween = null;
         }
         if(this._castMc)
         {
            $.C("com.greensock.TweenMax").killTweensOf(this._castMc);
            this._castMc.gotoAndStop(1);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._castMc);
            this._castMc = null;
         }
         this._model = null;
         this._world = null;
         super.dispose();
      }
    set type(v) { super.type = v; }
  }
  $.meta(__CastAction, "com.map.vehicle.action.CastAction", []);
  return __CastAction;
}
deps["com.map.vehicle.action.CastAction"] = ["com.greensock.TweenMax", "com.map.vehicle.action.BaseVehicleAction", "com.map.vehicle.data.TankState", "com.map.vehicle.data.UseSkillInfo", "com.map.vehicle.events.VehicleEvent", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.net.VehicleSocketOutManager", "com.map.vehicle.objects.TankAvatarView", "com.map.vehicle.objects.VehicleNpcAvatarView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.road.mapengine.ai.astar.AIManager", "flash.display.MovieClip", "flash.geom.Point", "flash.utils.getTimer", "yishi.keyboard.KeyBoardRegister", "yishi.manager.NotificationManager", "yishi.manager.TempleteManager", "yishi.scene.SceneManager"];

defs["com.map.vehicle.action.HurtNumberAction"] = function define($) {
  const __Base = $.C("com.map.vehicle.action.BaseVehicleAction");
  class __HurtNumberAction extends __Base {
    static $fields(self) {
    self._hurtData = null;
    self._target = null;
    self._container = new ($.C("flash.display.Sprite"))();
    self._numberAsset = null;
    self._posY = 0;
    }
    constructor(param1, param2, param3 = -120) {
         $.pre(new.target, (__s) => {
         __s._target = param1;
         __s._hurtData = param2;
         __s._posY = param3;
         if(__s._hurtData.effectType == 1)
         {
            __s._numberAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.vehiclemap.AddNumber");
         }
         else
         {
            __s._numberAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.vehiclemap.HurtNumber");
         }
         });
         super();
         $.preFlush(this, new.target);
      }
    dispose() {
         super.dispose();
      }
    prepare() {
         var _loc3_ = 0;
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.HurtEffect");
         var _loc2_ = _loc1_["effectValue"]["number_mc"];
         var _loc5_ = _loc1_["effectValue"]["effectType"];
         if(this._hurtData.effectValue == -1)
         {
            _loc2_.gotoAndStop(2);
            _loc5_.gotoAndStop(3);
         }
         else if(this._hurtData.effectValue == -2)
         {
            _loc2_.gotoAndStop(3);
            _loc5_.gotoAndStop(3);
         }
         else if(this._hurtData.effectValue == -3)
         {
            _loc2_.gotoAndStop(4);
            _loc5_.gotoAndStop(3);
         }
         else
         {
            _loc3_ = Math.abs(this._hurtData.effectValue);
            $.C("yishi.utils.NumberViewUtils").getNumberView(_loc3_,this._container,this._numberAsset,21,21,15,21,"1234567890");
            _loc2_.addChild(this._container);
            _loc2_.gotoAndStop(1);
            _loc5_.gotoAndStop(1);
         }
         if(this._hurtData.effectType == 1)
         {
            _loc5_.gotoAndStop(2);
         }
         var _loc4_ = new ($.C("yishi.view.tools.SimpleMovie"))(_loc1_);
         _loc4_.y = this._posY;
         if($.is(this._target, $.C("com.map.vehicle.objects.TankAvatarView")))
         {
            ($.as(this._target, $.C("com.map.vehicle.objects.TankAvatarView"))).addHurtMovie(_loc4_);
         }
         else if($.is(this._target, $.C("com.map.vehicle.objects.VehicleNpcAvatarView")))
         {
            ($.as(this._target, $.C("com.map.vehicle.objects.VehicleNpcAvatarView"))).addHurtMovie(_loc4_);
         }
         this._finished = true;
         this._numberAsset.dispose();
         this._numberAsset = null;
      }
    update() {
      }
  }
  $.meta(__HurtNumberAction, "com.map.vehicle.action.HurtNumberAction", []);
  return __HurtNumberAction;
}
deps["com.map.vehicle.action.HurtNumberAction"] = ["com.map.vehicle.action.BaseVehicleAction", "com.map.vehicle.objects.TankAvatarView", "com.map.vehicle.objects.VehicleNpcAvatarView", "com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "yishi.utils.NumberViewUtils", "yishi.view.tools.SimpleMovie"];

defs["com.map.vehicle.action.PickupAction"] = function define($) {
  const __Base = $.C("com.map.vehicle.action.BaseVehicleAction");
  class __PickupAction extends __Base {
    static $fields(self) {
    self._pickMc = null;
    self._pickuper = null;
    self._target = null;
    self._stage = null;
    self._tween = null;
    self._pickupStartTime = 0;
    self._isPickuped = false;
    }
    constructor(param1, param2) {
         super();
         this._pickuper = $.as(param1, $.C("com.map.vehicle.objects.TankAvatarView"));
         this._target = $.as(param2, $.C("com.map.vehicle.objects.VehicleBoxView"));
         this._stage = $.C("com.pickgliss.toplevel.StageReferance").stage;
         $.C("yishi.keyboard.KeyBoardRegister").instance.battleFlag = false;
      }
    cancel() {
      }
    prepare() {
         this.startPickup();
      }
    __stageResizeHandler(param1 = null) {
         if(this._pickMc)
         {
            this._pickMc.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._pickMc.width) / 2;
            this._pickMc.y = $.C("com.pickgliss.toplevel.StageReferance").stageHeight - 200;
         }
      }
    startPickup() {
         var _loc1_ = null;
         if(this._pickuper && this._pickuper.data)
         {
            this._pickuper.data.isPickup = true;
            this._pickuper.stop();
            $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendCampaignArmyMove(this._pickuper.data.playerId,[this._pickuper.getTilePoint()]);
         }
         if(this._pickuper.data.hp <= 0)
         {
            _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.waitRiver");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_);
            this.dispose();
            return;
         }
         this._pickMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.core.CollectionAsset");
         if(this._pickMc["stateMc"])
         {
            ($.as(this._pickMc["stateMc"], $.C("flash.display.MovieClip"))).gotoAndStop(5);
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._pickMc,3,false);
         this._pickupStartTime = $.C("flash.utils.getTimer")();
         this._tween = $.C("com.greensock.TweenMax").to(this._pickMc,1.5,{
            "frame":this._pickMc.totalFrames,
            "onUpdate":$.bind(this, "__tweenUpdate"),
            "onComplete":$.bind(this, "__successHandler")
         });
         this.__stageResizeHandler();
         if(this._stage)
         {
            this._stage.addEventListener("resize",$.bind(this, "__stageResizeHandler"));
         }
         if(this._pickuper && this._pickuper.data)
         {
            this._pickuper.data.addEventListener("BREAK_PICKUP",$.bind(this, "__onBreakHandler"));
         }
      }
    __tweenUpdate() {
         if(!this._isPickuped && $.C("flash.utils.getTimer")() - this._pickupStartTime >= 800)
         {
            if(this._target)
            {
               $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendPickup(this._target.data.nodeId);
               this._isPickuped = true;
               if(this._pickuper && this._pickuper.isSelf && this._target.data.type == 2)
               {
                  $.C("com.pickgliss.utils.SoundManager").instance.play("010");
               }
            }
         }
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.battleFlag = false;
         if(this._pickuper && this._pickuper.data)
         {
            this._pickuper.data.isPickup = false;
            this._pickuper.data.removeEventListener("BREAK_PICKUP",$.bind(this, "__onBreakHandler"));
         }
         if(this._stage)
         {
            this._stage.removeEventListener("resize",$.bind(this, "__stageResizeHandler"));
         }
         if(this._tween)
         {
            this._tween.kill();
         }
         if(this._pickMc)
         {
            this._pickMc.stop();
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pickMc);
            $.C("com.greensock.TweenMax").killTweensOf(this._pickMc);
         }
         this._pickMc = null;
         this._tween = null;
         this._pickuper = null;
         this._stage = null;
         this._target = null;
         super.dispose();
      }
    __onBreakHandler(param1) {
         this.dispose();
      }
    __successHandler() {
         this.dispose();
      }
    update() {
         var _loc1_ = null;
         if(this._finished)
         {
            return;
         }
         if(this._isPickuped)
         {
            return;
         }
         if(!this._target)
         {
            this.dispose();
            this.beBreak();
            return;
         }
         if(!this._isPickuped && this._target.data.state == 1)
         {
            _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.noTarget");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_);
            this.dispose();
            return;
         }
         if(this._pickuper.data.isStun || this._pickuper.path && this._pickuper.path.length > 0)
         {
            this.beBreak();
            this.dispose();
            return;
         }
      }
    beBreak() {
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.pickupBreak");
         $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_);
      }
  }
  $.meta(__PickupAction, "com.map.vehicle.action.PickupAction", []);
  return __PickupAction;
}
deps["com.map.vehicle.action.PickupAction"] = ["com.greensock.TweenMax", "com.map.vehicle.action.BaseVehicleAction", "com.map.vehicle.net.VehicleSocketOutManager", "com.map.vehicle.objects.TankAvatarView", "com.map.vehicle.objects.VehicleBoxView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.MovieClip", "flash.utils.getTimer", "manager.LanguageMgr", "yishi.keyboard.KeyBoardRegister", "yishi.view.tips.MessageTipManager"];

defs["com.map.vehicle.action.ShootAction"] = function define($) {
  const __Base = $.C("com.map.vehicle.action.BaseVehicleAction");
  class __ShootAction extends __Base {
    static $fields(self) {
    self._useSkillInfo = null;
    self._shooter = null;
    self._skillTemplate = null;
    self._skillFlyLayer = null;
    self._model = null;
    self._targetX = 0;
    self._targetY = 0;
    self.speed = 1300;
    self.frame = 0;
    self.shootPoint = new ($.C("flash.geom.Point"))();
    self._playSound = false;
    self._classList = null;
    self.$$_angle = NaN;
    self._index = 0;
    self._lastPoint = null;
    }
    constructor(param1, param2) {
         super();
         this._shooter = param1;
         this._useSkillInfo = param2;
         this._skillTemplate = $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(this._useSkillInfo.skillId);
         this._skillFlyLayer = $.C("com.map.vehicle.data.VGlobal").logicWorld.topLayer;
         this._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
         for (var _loc3_ of $.values(this._useSkillInfo.playerHurt))
         {
            if(_loc3_.effectId == $.C("com.map.vehicle.data.VGlobal").playerInfo.userId)
            {
               this._playSound = true;
            }
         }
         if(this._useSkillInfo.casterId == $.C("com.map.vehicle.data.VGlobal").playerInfo.userId)
         {
            this._playSound = true;
         }
         if(!$.C("com.pickgliss.utils.SoundManager").instance.allowSound)
         {
            this._playSound = false;
         }
      }
    dispose() {
         super.dispose();
         this._model = null;
         this._shooter = null;
         this._skillFlyLayer = null;
         this._skillTemplate = null;
         this._useSkillInfo = null;
      }
    prepare() {
         var _loc6_ = null;
         var _loc1_ = null;
         var _loc8_ = 0;
         var _loc4_ = null;
         var _loc7_ = 0;
         var _loc2_ = null;
         this._targetX = this._useSkillInfo.effectX;
         this._targetY = this._useSkillInfo.effectY;
         if(!this._skillTemplate)
         {
            this.dispose();
            return;
         }
         if(this._skillTemplate.InjuryEffect == 4)
         {
            this.flyOver();
            return;
         }
         if(this._skillTemplate.InjuryEffect == 1)
         {
            if(this._useSkillInfo.playerHurt.length > 0)
            {
               _loc8_ = this._useSkillInfo.playerHurt[0].effectId;
               _loc4_ = this._model.getPlayerInfo(_loc8_);
               if(!_loc4_)
               {
                  this._finished = true;
                  return;
               }
               _loc6_ = _loc4_.logicView;
               if(_loc6_)
               {
                  _loc1_ = _loc6_.hitRect;
                  this._targetX = _loc1_.x + _loc1_.width / 2;
                  this._targetY = _loc1_.y + _loc1_.height / 2;
               }
            }
            else if(this._useSkillInfo.npcHurt.length > 0)
            {
               _loc7_ = this._useSkillInfo.npcHurt[0].effectId;
               _loc2_ = this._model.getNodeByNodeId(_loc7_);
               if(!_loc2_)
               {
                  this._finished = true;
                  return;
               }
               _loc6_ = _loc2_.logicView;
               if(_loc6_)
               {
                  _loc1_ = _loc6_.hitRect;
                  this._targetX = _loc1_.x + _loc1_.width / 2;
                  this._targetY = _loc1_.y + _loc1_.height / 2;
               }
            }
         }
         this._shooter.changeDirectionTo(this._targetX,this._targetY);
         var _loc5_ = new ($.C("flash.geom.Point"))(this._targetX,this._targetY);
         this._shooter.playBombSmoke(null);
         this.shootPoint = this._shooter.getShootPoint();
         this.$$_angle = this.calulateAngle(this.shootPoint.x,this.shootPoint.y,this._targetX,this._targetY);
         this.startFly();
         var _loc3_ = $.C("com.map.vehicle.SkillEffectFactory").instance.createStartEffect(this._useSkillInfo);
         if(_loc3_)
         {
            _loc3_.x = this.shootPoint.x;
            _loc3_.y = this.shootPoint.y;
            _loc3_.rotation = this.$$_angle;
            this._skillFlyLayer.addChild(_loc3_);
            if(!this._playSound)
            {
               _loc3_.setSoundTransform($.C("com.map.vehicle.data.VGlobal").volume0);
            }
            else
            {
               _loc3_.setSoundTransform($.C("com.map.vehicle.data.VGlobal").volume1);
            }
         }
      }
    startFly() {
         var _loc2_ = null;
         this._classList = $.C("com.map.vehicle.SkillEffectFactory").instance.getFlyClassArray(this._useSkillInfo);
         var _loc1_ = $.int(this._classList.length);
         var _loc4_ = $.C("flash.geom.Point").distance(this.shootPoint,new ($.C("flash.geom.Point"))(this._targetX,this._targetY));
         var _loc3_ = _loc4_ / this.speed;
         if(_loc1_ == 1)
         {
            _loc2_ = $.C("com.map.vehicle.SkillEffectFactory").instance.getSkillMovie(this._classList[0]);
            ($.as(_loc2_, $.C("com.map.vehicle.view.VehicleSkillMovie"))).autoDispose = false;
            this._skillFlyLayer.addChild($.as(_loc2_, $.C("com.map.vehicle.view.VehicleSkillMovie")));
         }
         else
         {
            _loc2_ = {};
         }
         this._lastPoint = this.shootPoint.clone();
         _loc2_.rotation = this.$$_angle;
         _loc2_.x = this.shootPoint.x;
         _loc2_.y = this.shootPoint.y;
         if(_loc2_.hasOwnProperty("type") && _loc2_["type"] == 1)
         {
            _loc2_.rotation = this.$$_angle - 180;
            ($.as(_loc2_, $.C("com.map.vehicle.view.VehicleSkillMovie"))).setSkillWidth(_loc4_ + 50);
            ($.as(_loc2_, $.C("com.map.vehicle.view.VehicleSkillMovie"))).autoDispose = true;
            this.flyOver();
         }
         else
         {
            $.C("com.greensock.TweenMax").to(_loc2_,_loc3_,{
               "ease":$.C("com.greensock.easing.Linear").easeNone,
               "x":this._targetX,
               "y":this._targetY,
               "onUpdate":$.bind(this, "updateFlyMc"),
               "onUpdateParams":[_loc2_],
               "onComplete":$.bind(this, "flyOver"),
               "onCompleteParams":[_loc2_]
            });
         }
      }
    updateFlyMc(param1) {
         var _loc7_ = 0;
         var _loc6_ = null;
         var _loc8_ = null;
         if(this._classList.length <= 1)
         {
            return;
         }
         var _loc2_ = new ($.C("flash.geom.Point"))(param1.x,param1.y);
         var _loc9_ = $.C("flash.geom.Point").distance(_loc2_,this._lastPoint);
         var _loc5_ = Math.ceil(_loc9_ / 25);
         var _loc3_ = (_loc2_.x - this._lastPoint.x) / _loc5_;
         var _loc4_ = (_loc2_.y - this._lastPoint.y) / _loc5_;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            if(this._index == this._classList.length)
            {
               this._index = 0;
            }
            _loc6_ = this._classList[this._index];
            _loc8_ = $.C("com.map.vehicle.SkillEffectFactory").instance.getSkillMovie(_loc6_);
            _loc8_.x = this._lastPoint.x + _loc3_ * (_loc7_ + 1);
            _loc8_.y = this._lastPoint.y + _loc4_ * (_loc7_ + 1);
            this._skillFlyLayer.addChild(_loc8_);
            this._index = this._index + 1;
            _loc7_++;
         }
         this._lastPoint = _loc2_;
      }
    update() {
      }
    calulateAngle(param1, param2, param3, param4) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if (typeof param2 !== "number") param2 = Number(param2);
         if (typeof param3 !== "number") param3 = Number(param3);
         if (typeof param4 !== "number") param4 = Number(param4);
         var _loc5_ = param3 - param1;
         var _loc6_ = param4 - param2;
         var _loc8_ = Math.atan2(_loc6_,_loc5_);
         var _loc7_ = _loc8_ * 180 / 3.141592653589793;
         return (_loc7_ < 0 ? _loc7_ + 360 : _loc7_) + 180;
      }
    flyOver(param1 = null) {
         var _loc2_ = null;
         if($.C("yishi.scene.SceneManager").instance.currentType != "VEHICLE")
         {
            this._finished = true;
            return;
         }
         if(param1)
         {
            _loc2_ = new ($.C("flash.geom.Point"))(param1.x,param1.y);
            $.C("com.greensock.TweenMax").killTweensOf(param1);
            if($.is(param1, $.C("com.map.vehicle.view.VehicleSkillMovie")))
            {
               ($.as(param1, $.C("com.map.vehicle.view.VehicleSkillMovie"))).end();
            }
         }
         else
         {
            _loc2_ = new ($.C("flash.geom.Point"))(this._targetX,this._targetY);
         }
         var _loc3_ = $.C("com.map.vehicle.SkillEffectFactory").instance.createEndEffect(this._useSkillInfo);
         if(_loc3_)
         {
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            if(!this._playSound)
            {
               _loc3_.setSoundTransform($.C("com.map.vehicle.data.VGlobal").volume0);
            }
            else
            {
               _loc3_.setSoundTransform($.C("com.map.vehicle.data.VGlobal").volume1);
            }
            this._skillFlyLayer.addChild(_loc3_);
         }
         this.hurt();
         this._finished = true;
      }
    hurt() {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc1_ = null;
         if(this._useSkillInfo.casterId == $.C("com.map.vehicle.data.VGlobal").playerInfo.userId && this._model.selfVehicleInfo)
         {
            this._model.selfVehicleInfo.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_SHOOT_OVER",this._useSkillInfo));
         }
         for (_loc2_ of $.values(this._useSkillInfo.playerHurt))
         {
            _loc3_ = this._model.getPlayerInfo(_loc2_.effectId);
            if(_loc3_)
            {
               _loc3_.beAtk(_loc2_);
            }
         }
         for (_loc2_ of $.values(this._useSkillInfo.npcHurt))
         {
            _loc1_ = this._model.getNodeByNodeId(_loc2_.effectId);
            if(_loc1_)
            {
               _loc1_.beAtk(_loc2_);
            }
         }
      }
  }
  $.meta(__ShootAction, "com.map.vehicle.action.ShootAction", []);
  return __ShootAction;
}
deps["com.map.vehicle.action.ShootAction"] = ["com.greensock.TweenMax", "com.greensock.easing.Linear", "com.map.vehicle.SkillEffectFactory", "com.map.vehicle.action.BaseVehicleAction", "com.map.vehicle.data.VGlobal", "com.map.vehicle.events.VehicleEvent", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.view.VehicleSkillMovie", "com.pickgliss.utils.SoundManager", "flash.geom.Point", "yishi.manager.TempleteManager", "yishi.scene.SceneManager"];

defs["com.map.vehicle.data.HurtData"] = function define($) {
  const __Base = $.Object;
  class __HurtData extends __Base {
    static $fields(self) {
    self.effectId = 0;
    self.effectValue = 0;
    self.skillId = 0;
    self.effectType = 0;
    self.shootId = 0;
    self.attackType = 0;
    }
    constructor(param1 = 0) {
         super();
         this.skillId = param1;
      }
  }
  $.meta(__HurtData, "com.map.vehicle.data.HurtData", []);
  return __HurtData;
}
deps["com.map.vehicle.data.HurtData"] = [];

defs["com.map.vehicle.data.PlayerVehicleInfo"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __PlayerVehicleInfo extends __Base {
    static $fields(self) {
    self.name = null;
    self.consortiaName = "";
    self.id = 0;
    self.team = 0;
    self.isVip = false;
    self.vipType = 0;
    self.appellId = 0;
    self.vocationGrades = 0;
    self.vocationIndex = 0;
    self._hp = -1;
    self._rebornTime = 0;
    self.isCasting = false;
    self.isPickup = false;
    self.isStun = false;
    self._isDisPatchDieEvent = false;
    self._dieTimerId = 0;
    self.playerId = 0;
    self._templateId = 0;
    self.x = 0;
    self.y = 0;
    self.grade = 0;
    self.headId = 0;
    self.logicView = null;
    self._state = 0;
    self.speed = 7;
    self.bufferIds = [];
    self.buffList = new ($.C("flash.utils.Dictionary"))(true);
    self.score = 0;
    self._chatData = null;
    }
    constructor(param1 = null) {
         super(param1);
      }
    get vocationLevel() {
         var _loc1_ = (this.vocationGrades - 1) / 10 + 1;
         if(this.vocationIndex > 0)
         {
            return _loc1_ + 8;
         }
         return _loc1_;
      }
    get rebornTime() {
         return this._rebornTime;
      }
    set rebornTime(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._rebornTime = param1;
         if(this._rebornTime > 0)
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("DIE_COUNT",param1));
         }
      }
    get hp() {
         return this._hp;
      }
    get isDie() {
         return this.hp <= 0;
      }
    set hp(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = this._hp;
         this._hp = param1;
         if(this._hp <= 0)
         {
            this._hp = 0;
            this.clearBuff();
         }
         if(_loc2_ == param1)
         {
            return;
         }
         if(_loc2_ == 0 && this._hp > 0)
         {
            this._isDisPatchDieEvent = false;
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("REVIER",this));
         }
         else if(this._hp <= 0)
         {
            this._dieTimerId = $.C("flash.utils.setTimeout")($.bind(this, "disPatchDieEvent"),1200);
         }
         if(_loc2_ < this._hp)
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("HP_ADD",this._hp - _loc2_));
         }
         else if(_loc2_ > param1)
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("HP_CUT",this._hp - _loc2_));
         }
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("update_hp",this));
      }
    disPatchDieEvent() {
         if(this._dieTimerId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._dieTimerId);
            this._dieTimerId = 0;
         }
         if(this._isDisPatchDieEvent)
         {
            return;
         }
         this._isDisPatchDieEvent = true;
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("DIE",this));
      }
    get templateId() {
         return this._templateId;
      }
    set templateId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._templateId != param1)
         {
            this._templateId = param1;
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("VEHICLE_TEMPLATE_CHANGE",this));
         }
      }
    get template() {
         return $.C("yishi.manager.TempleteManager").instance.vehicleObjectTempInfoCate.getTemplateByIndex(this.templateId);
      }
    get talentSkillTemplate() {
         var _loc1_ = this.template;
         if(_loc1_)
         {
            return $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(_loc1_.GeniusSkill);
         }
         return null;
      }
    get normalSkillTemplate() {
         var _loc1_ = this.template;
         if(_loc1_)
         {
            return $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(_loc1_.NormalSkill);
         }
         return null;
      }
    cast(param1) {
         if(this.hp <= 0)
         {
            return;
         }
         if(this.isPickup)
         {
            return;
         }
         if(this.isStun)
         {
            return;
         }
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("cast",param1));
      }
    shoot(param1) {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_CAST_OVER",param1));
      }
    pickup(param1) {
         var _loc2_ = null;
         if(this.hp <= 0)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.waitRiver");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if(this.isCasting)
         {
            return;
         }
         if(this.isStun)
         {
            return;
         }
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("pickup",param1));
      }
    beAtk(param1) {
         if(param1.skillId != 0)
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_HURT",param1));
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("BREAK_PICKUP",this));
         }
         else
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("BUFF_HURT",param1));
         }
         if(this.hp <= 0)
         {
            this.disPatchDieEvent();
         }
      }
    get state() {
         return this._state;
      }
    set state(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._state != param1)
         {
            this._state = param1;
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("stateChange",param1));
         }
      }
    addBuffDamage(param1) {
         var _loc2_ = null;
         if(param1.buffTemplate && param1.buffTemplate.Duration <= 0)
         {
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("ADD_BUFF",param1));
            return;
         }
         if(param1.state == 0)
         {
            this.buffList[param1.id] = param1;
            param1.start();
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("ADD_BUFF",param1));
         }
         else if(param1.state == 1)
         {
            if(this.buffList[param1.id])
            {
               ($.as(this.buffList[param1.id], $.C("com.map.vehicle.data.VehicleBufferDamageInfo"))).stop();
            }
            this.buffList[param1.id] = null;
            delete this.buffList[param1.id];
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("REMOVE_BUFF",param1));
         }
         if(param1.damage < 0 && param1.buffTemplate && param1.buffTemplate.EffectType == $.C("com.map.vehicle.data.VehicleSkillEffectType").HP_CHANGE)
         {
            _loc2_ = new ($.C("com.map.vehicle.data.HurtData"))();
            _loc2_.effectValue = param1.damage;
            _loc2_.effectType = 0;
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("BUFF_HURT",_loc2_));
            if(this.hp <= 0)
            {
               this.disPatchDieEvent();
            }
         }
         this.updateDamage(param1);
      }
    clearBuff() {
         if(!this.template)
         {
            return;
         }
         this.isStun = false;
         this.speed = this.template.Speed;
         for(var _loc1_ in this.buffList)
         {
            delete this.buffList[_loc1_];
         }
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("CLEAR_BUFF",this));
      }
    updateDamage(param1) {
         if(param1.buffId == 0)
         {
            return;
         }
         switch(param1.buffTemplate.EffectType)
         {
            case $.C("com.map.vehicle.data.VehicleSkillEffectType").SPEED_CHANGE:
               this.checkSpeed();
               break;
            case $.C("com.map.vehicle.data.VehicleSkillEffectType").STUN:
               this.checkStunBuff();
         }
      }
    checkSpeed() {
         var _loc2_ = NaN;
         var _loc1_ = 0;
         var _loc3_ = 0;
         for (var _loc5_ of $.values(this.buffList))
         {
            if(_loc5_.buffTemplate.EffectType == $.C("com.map.vehicle.data.VehicleSkillEffectType").SPEED_CHANGE)
            {
               if(_loc5_.state != 1)
               {
                  _loc2_ = 0;
                  if(_loc5_.buffTemplate.EffectPercent != 0)
                  {
                     _loc2_ = this.template.Speed * _loc5_.buffTemplate.EffectPercent / 100;
                  }
                  else
                  {
                     _loc2_ = Number(_loc5_.buffTemplate.EffectValue);
                  }
                  if(_loc2_ > 0)
                  {
                     _loc1_ = $.int(_loc1_ > _loc2_ ? _loc1_ : _loc2_);
                  }
                  else
                  {
                     _loc3_ = $.int(_loc3_ > _loc2_ ? _loc2_ : _loc3_);
                  }
               }
            }
         }
         var _loc4_ = _loc1_ + _loc3_;
         this.updateSpeed(_loc4_);
      }
    updateSpeed(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this.speed = this.template.Speed + param1;
      }
    checkStunBuff() {
         for (var _loc1_ of $.values(this.buffList))
         {
            if(_loc1_.buffTemplate.EffectType == $.C("com.map.vehicle.data.VehicleSkillEffectType").STUN)
            {
               if(_loc1_.state != 1)
               {
                  this.isStun = true;
                  return;
               }
            }
         }
         this.isStun = false;
      }
    get totalHp() {
         return $.int(this.template.Hp + (this.grade - 1) * 100);
      }
    get appellTemplate() {
         return $.C("yishi.manager.TempleteManager").instance.appellInfoTemplateCate.getTemplateByID(this.appellId);
      }
    get chatData() {
         return this._chatData;
      }
    set chatData(param1) {
         this._chatData = param1;
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("CHAT_DATA",this._chatData));
      }
    commit() {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("playerInfoChange",this));
      }
    getBuffList() {
         var _loc1_ = new ($.C("flash.utils.Dictionary"))();
         for (var _loc2_ of $.values(this.buffList))
         {
            _loc1_[_loc2_.id] = _loc2_.buffId;
         }
         return _loc1_;
      }
    getBufferById(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this.buffList[param1];
      }
    checkBuff(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         for (var _loc2_ of $.values(this.buffList))
         {
            if(_loc2_.buffId == param1)
            {
               return true;
            }
         }
         return false;
      }
    changeHp(param1) {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_HURT",param1));
      }
    changeSpeed(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this.speed = this.template.Speed + param1;
      }
    setStun(param1) {
         this.isStun = param1;
      }
    changePercentSpeed(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this.speed = this.template.Speed * (1 + param1 / 100);
      }
    set vocationLevel(v) { super.vocationLevel = v; }
    set isDie(v) { super.isDie = v; }
    set template(v) { super.template = v; }
    set talentSkillTemplate(v) { super.talentSkillTemplate = v; }
    set normalSkillTemplate(v) { super.normalSkillTemplate = v; }
    set totalHp(v) { super.totalHp = v; }
    set appellTemplate(v) { super.appellTemplate = v; }
  }
  $.meta(__PlayerVehicleInfo, "com.map.vehicle.data.PlayerVehicleInfo", ["IBuffer"]);
  return __PlayerVehicleInfo;
}
deps["com.map.vehicle.data.PlayerVehicleInfo"] = ["com.map.vehicle.data.HurtData", "com.map.vehicle.data.VehicleBufferDamageInfo", "com.map.vehicle.data.VehicleSkillEffectType", "com.map.vehicle.events.VehicleEvent", "flash.events.EventDispatcher", "flash.utils.Dictionary", "flash.utils.clearTimeout", "flash.utils.setTimeout", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.view.tips.MessageTipManager"];

defs["com.map.vehicle.data.SkillCastInfo"] = function define($) {
  const __Base = $.Object;
  class __SkillCastInfo extends __Base {
    static $fields(self) {
    self.skillid = 0;
    self.target = null;
    self.castPos = null;
    }
    constructor() {
         super();
      }
  }
  $.meta(__SkillCastInfo, "com.map.vehicle.data.SkillCastInfo", []);
  return __SkillCastInfo;
}
deps["com.map.vehicle.data.SkillCastInfo"] = [];

defs["com.map.vehicle.data.TankState"] = function define($) {
  const __Base = $.Object;
  class __TankState extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static isStrongControl(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = false;
         var _loc3_ = param1;
         if(__TankState.Stun === _loc3_)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
  }
  $.meta(__TankState, "com.map.vehicle.data.TankState", []);
  $.statics(__TankState, () => {
    __TankState.Stop = 0;
    __TankState.Run = 1;
    __TankState.BeAtk = 2;
    __TankState.Die = 3;
    __TankState.Pickup = 4;
    __TankState.Casting = 5;
    __TankState.Stun = 6;
  });
  return __TankState;
}
deps["com.map.vehicle.data.TankState"] = [];

defs["com.map.vehicle.data.UseSkillInfo"] = function define($) {
  const __Base = $.Object;
  class __UseSkillInfo extends __Base {
    static $fields(self) {
    self.casterId = 0;
    self._skillId = 0;
    self.effectX = 0;
    self.effectY = 0;
    self.npcHurt = new $.Vector();
    self.playerHurt = new $.Vector();
    self.skillTemplate = null;
    }
    constructor() {
         super();
      }
    get skillId() {
         return this._skillId;
      }
    set skillId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._skillId = param1;
         this.skillTemplate = $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(this.skillId);
      }
  }
  $.meta(__UseSkillInfo, "com.map.vehicle.data.UseSkillInfo", []);
  return __UseSkillInfo;
}
deps["com.map.vehicle.data.UseSkillInfo"] = ["yishi.manager.TempleteManager"];

defs["com.map.vehicle.data.VGlobal"] = function define($) {
  const __Base = $.Object;
  class __VGlobal extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__VGlobal, "com.map.vehicle.data.VGlobal", []);
  $.statics(__VGlobal, () => {
    __VGlobal.logicWorld = null;
    __VGlobal.model = null;
    __VGlobal.scene = null;
    __VGlobal.InjuryEffect_SELF = 0;
    __VGlobal.InjuryEffect_MONOMER = 1;
    __VGlobal.InjuryEffect_GROUP = 2;
    __VGlobal.InjuryEffect_TRAP = 4;
    __VGlobal.InjuryEffect_PASSIVE = 3;
    __VGlobal.NodeResourceType_Image = 1;
    __VGlobal.NodeResourceType_Movie = 2;
    __VGlobal.uiFilter = new ($.C("yishi.filter.UIFilter"))();
    __VGlobal.buildfilter = new ($.C("yishi.filter.SimpleBuildingFilter"))();
    __VGlobal.volume0 = new ($.C("flash.media.SoundTransform"))(0);
    __VGlobal.volume1 = new ($.C("flash.media.SoundTransform"))(1);
    __VGlobal.playerInfo = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
  });
  return __VGlobal;
}
deps["com.map.vehicle.data.VGlobal"] = ["flash.media.SoundTransform", "yishi.filter.SimpleBuildingFilter", "yishi.filter.UIFilter", "yishi.manager.PlayerManager"];

defs["com.map.vehicle.data.VehicleAccountInfo"] = function define($) {
  const __Base = $.Object;
  class __VehicleAccountInfo extends __Base {
    static $fields(self) {
    self.playerList = null;
    self.isWin = false;
    self.reward1 = 0;
    self.reward2 = 0;
    self.reward3 = 0;
    self.myTeamId = 0;
    }
    constructor() {
         super();
      }
  }
  $.meta(__VehicleAccountInfo, "com.map.vehicle.data.VehicleAccountInfo", []);
  return __VehicleAccountInfo;
}
deps["com.map.vehicle.data.VehicleAccountInfo"] = [];

defs["com.map.vehicle.data.VehicleBufferDamageInfo"] = function define($) {
  const __Base = $.Object;
  class __VehicleBufferDamageInfo extends __Base {
    static $fields(self) {
    self.id = 0;
    self.isNew = false;
    self.attackId = 0;
    self.defanceId = 0;
    self.buffId = 0;
    self.damage = 0;
    self.type = 0;
    self.state = 0;
    self.isEffective = false;
    self._timer = null;
    self.leftTime = 0;
    }
    constructor() {
         super();
      }
    get buffTemplate() {
         return $.C("yishi.manager.TempleteManager").instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(this.buffId);
      }
    start() {
         if(!this.buffTemplate)
         {
            return;
         }
         this.leftTime = this.buffTemplate.Duration / 1000;
         this._timer = new ($.C("flash.utils.Timer"))(1000);
         this._timer.start();
         this._timer.addEventListener("timer",$.bind(this, "__onTimerHandler"));
      }
    __onTimerHandler(param1) {
         this.leftTime = this.leftTime - 1;
         if(this.leftTime <= 0)
         {
            this.leftTime = 0;
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
      }
    stop() {
         this.leftTime = 0;
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
      }
    set buffTemplate(v) { super.buffTemplate = v; }
  }
  $.meta(__VehicleBufferDamageInfo, "com.map.vehicle.data.VehicleBufferDamageInfo", []);
  return __VehicleBufferDamageInfo;
}
deps["com.map.vehicle.data.VehicleBufferDamageInfo"] = ["flash.utils.Timer", "yishi.manager.TempleteManager"];

defs["com.map.vehicle.data.VehicleNode"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __VehicleNode extends __Base {
    static $fields(self) {
    self.logicView = null;
    self.nodeId = 0;
    self.type = 0;
    self.posX = 0;
    self.posY = 0;
    self.state = 0;
    self.hp = 0;
    self.name = null;
    self.sonType = 0;
    self.handlerRange = 2;
    self.nameColor = 1;
    self.resource = 0;
    self.heroTempId = 0;
    self.resetPosX = 0;
    self.resetPosY = 0;
    self._teamId = 0;
    self.buffList = new ($.C("flash.utils.Dictionary"))(true);
    }
    constructor() {
         super();
      }
    get totalHp() {
         var _loc2_ = null;
         var _loc1_ = 0;
         if(this.type == 0)
         {
            _loc2_ = $.C("com.map.vehicle.utils.VehicleUtil").getVehicleObjectTemplate($.C("com.map.vehicle.data.VGlobal").model.bossTempId);
            if(_loc2_)
            {
               _loc1_ = $.int(_loc2_.Hp);
            }
         }
         return _loc1_;
      }
    isBoss() {
         return this.type == 0;
      }
    get teamId() {
         return this._teamId;
      }
    set teamId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._teamId = param1;
      }
    beAtk(param1) {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_HURT",param1));
      }
    shoot(param1) {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_CAST_OVER",param1));
      }
    addBuffDamage(param1) {
         var _loc2_ = null;
         if(param1.state == 0)
         {
            this.buffList[param1.id] = param1;
            param1.start();
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("ADD_BUFF",param1));
         }
         else if(param1.state == 1)
         {
            if(this.buffList[param1.id])
            {
               ($.as(this.buffList[param1.id], $.C("com.map.vehicle.data.VehicleBufferDamageInfo"))).stop();
            }
            this.buffList[param1.id] = null;
            delete this.buffList[param1.id];
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("REMOVE_BUFF",param1));
         }
         else if(param1.state == 2)
         {
            if(param1.damage != 0 && param1.buffTemplate && param1.buffTemplate.EffectType == $.C("com.map.vehicle.data.VehicleSkillEffectType").HP_CHANGE)
            {
               _loc2_ = new ($.C("com.map.vehicle.data.HurtData"))();
               _loc2_.effectValue = param1.damage;
               if(_loc2_.effectValue <= 0)
               {
                  _loc2_.effectType = 0;
               }
               else
               {
                  _loc2_.effectType = 1;
               }
               this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("BUFF_HURT",_loc2_));
            }
         }
      }
    changeHp(param1) {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_HURT",param1));
      }
    changePercentSpeed(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
      }
    changeSpeed(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
      }
    setStun(param1) {
      }
    get isDie() {
         return this.state == 1;
      }
    commit() {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("updateNode",this));
      }
    set totalHp(v) { super.totalHp = v; }
    set isDie(v) { super.isDie = v; }
  }
  $.meta(__VehicleNode, "com.map.vehicle.data.VehicleNode", ["IBuffer"]);
  return __VehicleNode;
}
deps["com.map.vehicle.data.VehicleNode"] = ["com.map.vehicle.data.HurtData", "com.map.vehicle.data.VGlobal", "com.map.vehicle.data.VehicleBufferDamageInfo", "com.map.vehicle.data.VehicleSkillEffectType", "com.map.vehicle.events.VehicleEvent", "com.map.vehicle.utils.VehicleUtil", "flash.events.EventDispatcher", "flash.utils.Dictionary"];

defs["com.map.vehicle.data.VehicleNodeState"] = function define($) {
  const __Base = $.Object;
  class __VehicleNodeState extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__VehicleNodeState, "com.map.vehicle.data.VehicleNodeState", []);
  $.statics(__VehicleNodeState, () => {
    __VehicleNodeState.Exist = 0;
    __VehicleNodeState.Dispose = 1;
  });
  return __VehicleNodeState;
}
deps["com.map.vehicle.data.VehicleNodeState"] = [];

defs["com.map.vehicle.data.VehicleNodeType"] = function define($) {
  const __Base = $.Object;
  class __VehicleNodeType extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__VehicleNodeType, "com.map.vehicle.data.VehicleNodeType", []);
  $.statics(__VehicleNodeType, () => {
    __VehicleNodeType.Boss = 0;
    __VehicleNodeType.Props = 2;
    __VehicleNodeType.Trap = 1;
  });
  return __VehicleNodeType;
}
deps["com.map.vehicle.data.VehicleNodeType"] = [];

defs["com.map.vehicle.data.VehicleSkillEffectType"] = function define($) {
  const __Base = $.Object;
  class __VehicleSkillEffectType extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__VehicleSkillEffectType, "com.map.vehicle.data.VehicleSkillEffectType", []);
  $.statics(__VehicleSkillEffectType, () => {
    __VehicleSkillEffectType.ADD_ATTACK = 1;
    __VehicleSkillEffectType.DEBUFF_AVOID = 2;
    __VehicleSkillEffectType.ATTACK_AVOID = 12;
    __VehicleSkillEffectType.STUN = 4;
    __VehicleSkillEffectType.STUN_AVOID = 5;
    __VehicleSkillEffectType.SPEED_CHANGE = 6;
    __VehicleSkillEffectType.SPEED_DOWN_AVOID = 7;
    __VehicleSkillEffectType.HP_CHANGE = 8;
    __VehicleSkillEffectType.STEAL_HP = 9;
    __VehicleSkillEffectType.ADD_DAMAGE = 10;
  });
  return __VehicleSkillEffectType;
}
deps["com.map.vehicle.data.VehicleSkillEffectType"] = [];

defs["com.map.vehicle.data.VehicleSkillInfo"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __VehicleSkillInfo extends __Base {
    static $fields(self) {
    self.state = 0;
    self.templateId = 0;
    self.count = 0;
    self.pos = 0;
    self.shortCutKey = 0;
    self.lastTime = NaN;
    }
    constructor() {
         super();
      }
    get icon() {
         if(this.tempalte)
         {
            return this.tempalte.Icons;
         }
         return "";
      }
    get tempalte() {
         return $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(this.templateId);
      }
    commit() {
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_INFO_CHANGE",this));
      }
    set icon(v) { super.icon = v; }
    set tempalte(v) { super.tempalte = v; }
  }
  $.meta(__VehicleSkillInfo, "com.map.vehicle.data.VehicleSkillInfo", []);
  $.statics(__VehicleSkillInfo, () => {
    __VehicleSkillInfo.LOCK = 0;
    __VehicleSkillInfo.UNLOCK = 1;
    __VehicleSkillInfo.USED = 2;
  });
  return __VehicleSkillInfo;
}
deps["com.map.vehicle.data.VehicleSkillInfo"] = ["com.map.vehicle.events.VehicleEvent", "flash.events.EventDispatcher", "yishi.manager.TempleteManager"];

defs["com.map.vehicle.data.VehicleSkillbag"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __VehicleSkillbag extends __Base {
    static $fields(self) {
    self._skillDict = new ($.C("flash.utils.Dictionary"))(true);
    self._dic = new ($.C("flash.utils.Dictionary"))(true);
    }
    constructor() {
         var _loc1_ = 0;
         super();
         _loc1_ = 1;
         while(_loc1_ < 4)
         {
            this._skillDict[_loc1_] = new ($.C("com.map.vehicle.data.VehicleSkillInfo"))();
            _loc1_++;
         }
         this._dic[49] = 1;
         this._dic[50] = 2;
         this._dic[81] = 3;
      }
    init(param1) {
         var _loc2_ = this.getSkillByPos(1);
         _loc2_.templateId = param1.template.NormalSkill;
         _loc2_.count = _loc2_.tempalte.Maximum;
         _loc2_ = this.getSkillByPos(2);
         _loc2_.templateId = param1.template.GeniusSkill;
         _loc2_.count = _loc2_.tempalte.Maximum;
      }
    getSkillByPos(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this._skillDict[param1];
      }
    getSkillByKey(param1) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         var _loc2_ = $.int(this._dic[param1]);
         return this.getSkillByPos(_loc2_);
      }
    getSkillInfoByTempId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         for (var _loc2_ of $.values(this._skillDict))
         {
            if(_loc2_.templateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
    updateSkill(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = this.getSkillInfoByTempId(param1);
         if(_loc4_)
         {
            _loc4_.count = param3;
            if(param2 == 1)
            {
               _loc4_.templateId = 0;
               _loc4_.count = 0;
            }
         }
         else
         {
            _loc4_ = this._skillDict[3];
            _loc4_.templateId = param1;
            _loc4_.count = param3;
            this._skillDict[3] = _loc4_;
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("CHANGE_SKILL",_loc4_));
         }
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_INFO_CHANGE",_loc4_));
      }
    reduceSkillCount(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = this.getSkillInfoByTempId(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.count--;
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("SKILL_INFO_CHANGE",_loc2_));
      }
    skillStartCD(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = this.getSkillInfoByTempId(param1);
         if(_loc2_)
         {
            _loc2_.lastTime = $.C("flash.utils.getTimer")();
            this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("START_CD",param1));
         }
      }
  }
  $.meta(__VehicleSkillbag, "com.map.vehicle.data.VehicleSkillbag", []);
  return __VehicleSkillbag;
}
deps["com.map.vehicle.data.VehicleSkillbag"] = ["com.map.vehicle.data.VehicleSkillInfo", "com.map.vehicle.events.VehicleEvent", "flash.events.EventDispatcher", "flash.utils.Dictionary", "flash.utils.getTimer"];

defs["com.map.vehicle.events.VehicleEvent"] = function define($) {
  const __Base = $.C("flash.events.Event");
  class __VehicleEvent extends __Base {
    static $fields(self) {
    self.data = undefined;
    }
    constructor(param1, param2, param3 = false, param4 = false) {
         $.pre(new.target, (__s) => {
         __s.data = param2;
         });
         super(param1,param3,param4);
         $.preFlush(this, new.target);
      }
  }
  $.meta(__VehicleEvent, "com.map.vehicle.events.VehicleEvent", []);
  $.statics(__VehicleEvent, () => {
    __VehicleEvent.ADD_PLAYER = "addPlayer";
    __VehicleEvent.REMOVE_PLAYER = "remove_player";
    __VehicleEvent.UPDATE_PLAYER = "update_player";
    __VehicleEvent.PLAYER_MOVE = "player_move";
    __VehicleEvent.ADD_NODE = "addNode";
    __VehicleEvent.UPDATE_NODE = "updateNode";
    __VehicleEvent.REMOVE_NODE = "REMOVE_NODE";
    __VehicleEvent.SKILL_CAST_OVER = "SKILL_CAST_OVER";
    __VehicleEvent.REFLSH_SKILL = "refresh_skill";
    __VehicleEvent.LEARN_SKILL = "learn_skill";
    __VehicleEvent.CLICK_SKILL = "click_skill";
    __VehicleEvent.ADD_VEHICLE_NPC = "addVehicleNpc";
    __VehicleEvent.RECEIVE_ATTACK = "receive_attack";
    __VehicleEvent.PLAY_SKILL = "play_skill";
    __VehicleEvent.UPDATE_WALK_TARGET = "UPDATE_WALK_TARGET";
    __VehicleEvent.SKILL_EFFECT = "SKILL_EFFECT";
    __VehicleEvent.CAST = "cast";
    __VehicleEvent.ADD_BUFF = "ADD_BUFF";
    __VehicleEvent.REMOVE_BUFF = "REMOVE_BUFF";
    __VehicleEvent.UPDATE_BUFF = "UPDATE_BUFF";
    __VehicleEvent.UPDATE_HP = "update_hp";
    __VehicleEvent.PICK_UP = "pickup";
    __VehicleEvent.STATE_CHANGE = "stateChange";
    __VehicleEvent.PLAYER_INFO_CHANGE = "playerInfoChange";
    __VehicleEvent.BUFF_HURT = "BUFF_HURT";
    __VehicleEvent.SKILL_INFO_CHANGE = "SKILL_INFO_CHANGE";
    __VehicleEvent.VEHICLE_TEMPLATE_CHANGE = "VEHICLE_TEMPLATE_CHANGE";
    __VehicleEvent.START_CD = "START_CD";
    __VehicleEvent.SCORE_CHANGE = "SCORE_CHANGE";
    __VehicleEvent.START_COUNTTIME = "START_COUNTTIME";
    __VehicleEvent.PLAYE_LIST_UPDATE = "PLAYE_LIST_UPDATE";
    __VehicleEvent.NEW_BUFF = "NEW_BUFF";
    __VehicleEvent.DIE = "DIE";
    __VehicleEvent.SKILL_HURT = "SKILL_HURT";
    __VehicleEvent.ATTACK_NOTICE = "ATTACK_NOTICE";
    __VehicleEvent.CHAT_DATA = "CHAT_DATA";
    __VehicleEvent.HP_ADD = "HP_ADD";
    __VehicleEvent.HP_CUT = "HP_CUT";
    __VehicleEvent.REVIER = "REVIER";
    __VehicleEvent.CHANGE_SKILL = "CHANGE_SKILL";
    __VehicleEvent.WALK_OVER = "WALK_OVER";
    __VehicleEvent.CLEAR_BUFF = "CLEAR_BUFF";
    __VehicleEvent.BREAK_PICKUP = "BREAK_PICKUP";
    __VehicleEvent.EARTHQUAKE = "EARTHQUAKE";
    __VehicleEvent.WARNING = "WARNING";
    __VehicleEvent.WARNING_CANCEL = "WARNING_CANCEL";
    __VehicleEvent.DIE_COUNT = "DIE_COUNT";
    __VehicleEvent.ADD_SLOW = "ADD_SLOW";
    __VehicleEvent.ADD_POISONING = "ADD_POISONING";
    __VehicleEvent.REMOVE_SLOW = "REMOVE_SLOW";
    __VehicleEvent.REMOVE_POISONING = "REMOVE_POISONING";
    __VehicleEvent.SKILL_SHOOT_OVER = "SKILL_SHOOT_OVER";
    __VehicleEvent.CAMPAIGN_TIME = "CAMPAIGN_TIME";
  });
  return __VehicleEvent;
}
deps["com.map.vehicle.events.VehicleEvent"] = ["flash.events.Event"];

defs["com.map.vehicle.interfaces.IBuffer"] = function define($) {
  return $.interface("com.map.vehicle.interfaces.IBuffer", []);
}

defs["com.map.vehicle.interfaces.ICaster"] = function define($) {
  return $.interface("com.map.vehicle.interfaces.ICaster", []);
}

defs["com.map.vehicle.mediator.InvincibilityMediator"] = function define($) {
  const __Base = $.Object;
  class __InvincibilityMediator extends __Base {
    static $fields(self) {
    self._map = null;
    self._timeId = 0;
    }
    constructor() {
         super();
      }
    register(param1) {
         this._map = param1;
         this._map.addEventListener("mouseDown",$.bind(this, "__cancelInvincibilityHandler"));
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "__cancelInvincibilityHandler"),10000);
      }
    unregister(param1) {
         this._map.removeEventListener("mouseDown",$.bind(this, "__cancelInvincibilityHandler"));
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
            this._timeId = 0;
         }
         this._map = null;
      }
    __cancelInvincibilityHandler(param1 = null) {
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
            this._timeId = 0;
         }
         this._map.removeEventListener("mouseDown",$.bind(this, "__cancelInvincibilityHandler"));
      }
  }
  $.meta(__InvincibilityMediator, "com.map.vehicle.mediator.InvincibilityMediator", ["IMediator"]);
  return __InvincibilityMediator;
}
deps["com.map.vehicle.mediator.InvincibilityMediator"] = ["flash.utils.clearTimeout", "flash.utils.setTimeout"];

defs["com.map.vehicle.mediator.MapCameraMediator"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MapCameraMediator extends __Base {
    static $fields(self) {
    self._role = undefined;
    self._target = null;
    self._isLocked = false;
    self._updatePoint = new ($.C("flash.geom.Point"))();
    self._xLimen = 20;
    self._yLimen = 20;
    self._yLimenOff = 0;
    self._bevelSpeed = 0;
    self._tweenValue = 0.2;
    self._unLockTime = 0;
    self._mapWidth = 0;
    self._mapHeight = 0;
    }
    constructor() {
         super();
         this.setMapSize();
      }
    setMapSize() {
         var _loc1_ = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
         var _loc2_ = $.int(_loc1_ ? _loc1_.mapTempInfo.Width : 100000);
         var _loc3_ = $.int(_loc1_ ? _loc1_.mapTempInfo.Height : 100000);
         this._mapWidth = this._xLimen + this.bevelSpeed + _loc2_;
         this._mapHeight = this._yLimen + this.bevelSpeed + _loc3_;
      }
    get bevelSpeed() {
         return 7;
      }
    register(param1) {
         this._target = param1;
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
         param1.addEventListener("render",$.bind(this, "__onScreenRend"));
         param1.addEventListener("LOOK_AT_ROLE",$.bind(this, "__lookAtRoleHandler"));
      }
    unregister(param1) {
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
         this._target.removeEventListener("render",$.bind(this, "__onScreenRend"));
         this._target.removeEventListener("LOOK_AT_ROLE",$.bind(this, "__lookAtRoleHandler"));
      }
    upDateNextRend() {
         if(this._target.stage)
         {
            this._target.stage.invalidate();
         }
      }
    __onScreenRend(param1) {
      }
    locked() {
         this._isLocked = true;
      }
    unLocked() {
         this._isLocked = false;
      }
    moveTweenEnd() {
         this.unLocked();
         if(this._unLockTime > 0)
         {
            $.C("flash.utils.clearInterval")(this._unLockTime);
         }
         this._unLockTime = 0;
         this._target.dispatchEvent(new ($.C("map.campaign.event.CampaignMapEvent"))("MOVE_SCENET_END",this._target));
      }
    __lookAtRoleHandler(param1) {
         this.setMapSize();
         this._role = param1.data;
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc3_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this._target.x = _loc2_ / 2 - this._role.x;
         this._target.y = _loc3_ / 2 - this._role.y;
      }
    enterFrame() {
         this.moveXY();
      }
    moveXY(param1 = false) {
         var _loc12_ = 0;
         var _loc17_ = 0;
         var _loc18_ = 0;
         if(this._isLocked || !this._role)
         {
            return;
         }
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc14_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         var _loc8_ = this._role.x - (_loc2_ >> 1);
         var _loc7_ = this._role.y - (_loc14_ >> 1) - this._yLimenOff;
         var _loc15_ = $.int(this._target.x);
         var _loc16_ = $.int(this._target.y);
         var _loc4_ = _loc2_ >> 1;
         var _loc3_ = _loc14_ >> 1;
         var _loc9_ = this._role.x + this._target.x;
         var _loc5_ = this._role.y + this._target.y;
         var _loc10_ = _loc9_ - _loc4_;
         var _loc13_ = _loc5_ - _loc3_;
         var _loc11_ = $.C("com.map.vehicle.data.VGlobal").model;
         var _loc6_ = $.int(_loc11_.mapTempInfo.Width);
         var _loc19_ = $.int(_loc11_.mapTempInfo.Height);
         if(Math.abs(_loc10_) >= this._xLimen || Math.abs(_loc13_) >= this._yLimen)
         {
            _loc12_ = 40;
            _loc17_ = _loc15_;
            _loc18_ = _loc16_;
            if(_loc10_ > _loc12_)
            {
               if(_loc2_ - this._target.x >= _loc6_)
               {
                  this._target.x = _loc2_ - _loc6_;
               }
               else
               {
                  _loc17_ -= (_loc10_ - _loc12_) * this._tweenValue;
                  this._target.x = _loc17_ + 0.5 >> 0;
               }
            }
            else if(this._target.x >= 0)
            {
               this._target.x = 0;
            }
            else if(_loc10_ < -_loc12_)
            {
               _loc17_ -= (_loc10_ + _loc12_) * this._tweenValue;
               this._target.x = _loc17_ + 0.5 >> 0;
            }
            if(_loc13_ > _loc12_)
            {
               if(_loc14_ - this._target.y >= _loc19_)
               {
                  this._target.y = _loc14_ - _loc19_;
               }
               else
               {
                  _loc18_ -= (_loc13_ - _loc12_) * this._tweenValue;
                  this._target.y = _loc18_ + 0.5 >> 0;
               }
            }
            else if(this._target.y >= 0)
            {
               this._target.y = 0;
            }
            else if(_loc13_ < -_loc12_)
            {
               _loc18_ -= (_loc13_ + _loc12_) * this._tweenValue;
               this._target.y = _loc18_ + 0.5 >> 0;
            }
         }
         if(_loc2_ - this._target.x >= _loc6_)
         {
            this._target.x = _loc2_ - _loc6_;
         }
         if(this._target.x >= 0)
         {
            this._target.x = 0;
         }
         if(_loc14_ - this._target.y >= _loc19_)
         {
            this._target.y = _loc14_ - _loc19_;
         }
         if(this._target.y >= 0)
         {
            this._target.y = 0;
         }
      }
    get mapWidth() {
         return this._mapWidth;
      }
    get mapHeight() {
         return this._mapHeight;
      }
    set bevelSpeed(v) { super.bevelSpeed = v; }
    set mapWidth(v) { super.mapWidth = v; }
    set mapHeight(v) { super.mapHeight = v; }
  }
  $.meta(__MapCameraMediator, "com.map.vehicle.mediator.MapCameraMediator", ["IEnterFrame", "IMediator"]);
  return __MapCameraMediator;
}
deps["com.map.vehicle.mediator.MapCameraMediator"] = ["com.map.vehicle.data.VGlobal", "com.map.vehicle.net.VehicleSocketManager", "com.pickgliss.toplevel.StageReferance", "flash.display.Sprite", "flash.geom.Point", "flash.utils.clearInterval", "map.campaign.event.CampaignMapEvent", "yishi.manager.EnterFrameManager"];

defs["com.map.vehicle.mediator.SkillPlayMediator"] = function define($) {
  const __Base = $.Object;
  class __SkillPlayMediator extends __Base {
    static $fields(self) {
    self._skillFlyLayer = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    }
    constructor() {
         super();
      }
    register(param1) {
         this._skillFlyLayer = $.as(param1, $.C("flash.display.Sprite"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("play_skill",$.bind(this, "__startSkillEffectHandler"));
      }
    unregister(param1) {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("play_skill",$.bind(this, "__startSkillEffectHandler"));
      }
    __startSkillEffectHandler(param1) {
         var _loc6_ = null;
         var _loc3_ = 0;
         var _loc5_ = $.as(param1.data, $.C("com.map.vehicle.data.UseSkillInfo"));
         var _loc2_ = this._model.getNodeByNodeId(_loc5_.casterId);
         if(_loc2_)
         {
            _loc6_ = $.as(_loc2_.logicView, $.C("com.map.vehicle.objects.VehicleNpcAvatarView"));
            if(_loc6_)
            {
               _loc2_.state = 2;
               _loc3_ = $.int($.C("flash.utils.setTimeout")($.bind(this, "attackEnd"),800,_loc6_,_loc3_));
            }
         }
         var _loc4_ = $.C("com.map.vehicle.SkillEffectFactory").instance.createEndEffect(_loc5_);
         _loc4_.x = _loc5_.effectX * 20;
         _loc4_.y = _loc5_.effectY * 20;
         this._skillFlyLayer.addChild(_loc4_);
         this.hurt(_loc5_);
      }
    attackEnd(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         $.C("flash.utils.clearTimeout")(param2);
         if(param1)
         {
            param1.state = 3;
         }
      }
    hurt(param1) {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc2_ = null;
         for (_loc3_ of $.values(param1.playerHurt))
         {
            _loc4_ = this._model.getPlayerInfo(_loc3_.effectId);
            _loc4_.beAtk(_loc3_);
         }
         for (_loc3_ of $.values(param1.npcHurt))
         {
            _loc2_ = this._model.getNodeByNodeId(_loc3_.effectId);
            _loc2_.beAtk(_loc3_);
         }
      }
  }
  $.meta(__SkillPlayMediator, "com.map.vehicle.mediator.SkillPlayMediator", ["IMediator"]);
  return __SkillPlayMediator;
}
deps["com.map.vehicle.mediator.SkillPlayMediator"] = ["com.map.vehicle.SkillEffectFactory", "com.map.vehicle.data.UseSkillInfo", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.objects.VehicleNpcAvatarView", "flash.display.Sprite", "flash.utils.clearTimeout", "flash.utils.setTimeout", "yishi.manager.NotificationManager"];

defs["com.map.vehicle.mediator.VehicleUIMediator"] = function define($) {
  const __Base = $.Object;
  class __VehicleUIMediator extends __Base {
    static $fields(self) {
    self._screenEffectView = null;
    self._bottomView = null;
    self._topView = null;
    self._teamView = null;
    self._rightView = null;
    self._bossDownTime = null;
    self._riverView = null;
    }
    constructor() {
         super();
      }
    register(param1) {
         this._screenEffectView = new ($.C("com.map.vehicle.view.VehicleScreenEffectLayer"))();
         this._bottomView = new ($.C("com.map.vehicle.view.VehicleBottomView"))();
         this._topView = new ($.C("com.map.vehicle.view.VehicleTopView"))();
         this._teamView = new ($.C("com.map.vehicle.view.VehicleTeamView"))();
         this._rightView = new ($.C("com.map.vehicle.view.VehicleRightView"))();
         this._bossDownTime = new ($.C("com.map.vehicle.view.VehicleBossDownTimeView"))();
         this._riverView = new ($.C("com.map.vehicle.view.VehicleReviveView"))();
         this._screenEffectView.show();
         this._rightView.show();
         this._teamView.show();
         this._topView.show();
         this._bottomView.show();
         this._bossDownTime.show();
         this.__resizeHandler();
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__resizeHandler"));
      }
    __resizeHandler(param1 = null) {
         this._screenEffectView.resize();
         this._bottomView.resize();
         this._topView.resize();
         this._teamView.resize();
         this._rightView.resize();
         this._riverView.resize();
         this._bossDownTime.resize();
      }
    unregister(param1) {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__resizeHandler"));
         this._screenEffectView.dispose();
         this._bottomView.dispose();
         this._topView.dispose();
         this._teamView.dispose();
         this._rightView.dispose();
         this._bossDownTime.dispose();
         this._riverView.dispose();
         this._bottomView = null;
         this._topView = null;
         this._teamView = null;
         this._rightView = null;
         this._screenEffectView = null;
         this._bossDownTime = null;
         this._riverView = null;
      }
  }
  $.meta(__VehicleUIMediator, "com.map.vehicle.mediator.VehicleUIMediator", ["IMediator"]);
  return __VehicleUIMediator;
}
deps["com.map.vehicle.mediator.VehicleUIMediator"] = ["com.map.vehicle.view.VehicleBossDownTimeView", "com.map.vehicle.view.VehicleBottomView", "com.map.vehicle.view.VehicleReviveView", "com.map.vehicle.view.VehicleRightView", "com.map.vehicle.view.VehicleScreenEffectLayer", "com.map.vehicle.view.VehicleTeamView", "com.map.vehicle.view.VehicleTopView", "com.pickgliss.toplevel.StageReferance"];

defs["com.map.vehicle.mediator.VehicleWalkTargetMediator"] = function define($) {
  const __Base = $.Object;
  class __VehicleWalkTargetMediator extends __Base {
    static $fields(self) {
    self._walkTarget = null;
    self._target = null;
    }
    constructor() {
         super();
         this._walkTarget = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.campaign.WalkTargetEffectAsset");
         this._walkTarget.mouseChildren = this._walkTarget.mouseEnabled = false;
         this._walkTarget.scrollRect = null;
         this._walkTarget.stop();
      }
    register(param1) {
         this._target = $.as(param1, $.C("flash.display.Sprite"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("UPDATE_WALK_TARGET",$.bind(this, "__updateWalkTargetHandler"));
      }
    unregister(param1) {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("UPDATE_WALK_TARGET",$.bind(this, "__updateWalkTargetHandler"));
      }
    __updateWalkTargetHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("flash.geom.Point"));
         if(_loc2_)
         {
            this._walkTarget.x = _loc2_.x;
            this._walkTarget.y = _loc2_.y;
            this._walkTarget.gotoAndPlay(1);
            this._walkTarget.visible = true;
            this._target.addChild(this._walkTarget);
         }
         else
         {
            this._walkTarget.visible = false;
            this._walkTarget.stop();
            if(this._walkTarget.parent)
            {
               this._walkTarget.parent.removeChild(this._walkTarget);
            }
         }
      }
  }
  $.meta(__VehicleWalkTargetMediator, "com.map.vehicle.mediator.VehicleWalkTargetMediator", ["IMediator"]);
  return __VehicleWalkTargetMediator;
}
deps["com.map.vehicle.mediator.VehicleWalkTargetMediator"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "flash.geom.Point", "yishi.manager.NotificationManager"];

defs["com.map.vehicle.net.VehicleSocketManager"] = function define($) {
  const __Base = $.Object;
  class __VehicleSocketManager extends __Base {
    static $fields(self) {
    self._model = null;
    self._isUse = false;
    self.controller = null;
    }
    constructor() {
         super();
      }
    static get instance() {
         if(!__VehicleSocketManager._instance)
         {
            __VehicleSocketManager._instance = new (__VehicleSocketManager)();
         }
         return __VehicleSocketManager._instance;
      }
    setup(param1 = false, param2 = null) {
         if(this._isUse)
         {
            return;
         }
         this._isUse = true;
         if(param2)
         {
            this.createMapModel(param2);
         }
         if(param1)
         {
            this.removeSocketEvent($.C("yishi.service.managers.SocketManager").instance);
            this.addSocketEvent($.C("proxy.SocketDataProxyManager").instance.model);
            $.C("proxy.SocketDataProxyManager").instance.model.addEventListener("READ_SOCKET_DATA_OVEW",$.bind(this, "__readOverHandler"));
            $.C("proxy.SocketDataProxyManager").instance.readSocketDataByType("VEHICLE");
         }
         else
         {
            this.addSocketEvent($.C("yishi.service.managers.SocketManager").instance);
            this.removeSocketEvent($.C("proxy.SocketDataProxyManager").instance.model);
         }
         this.addEvent();
      }
    __readOverHandler(param1) {
         if(param1.sceneType != "VEHICLE")
         {
            return;
         }
         this.addSocketEvent($.C("yishi.service.managers.SocketManager").instance);
         this.removeSocketEvent($.C("proxy.SocketDataProxyManager").instance.model);
         $.C("proxy.SocketDataProxyManager").instance.model.removeEventListener("READ_SOCKET_DATA_OVEW",$.bind(this, "__readOverHandler"));
      }
    addSocketEvent(param1) {
         param1.addEventListener("SLGSocketEvent" + 4517,$.bind(this, "__initPlayerListHandler"));
         param1.addEventListener("SLGSocketEvent" + 4513,$.bind(this, "__playerJoinHandler"));
         param1.addEventListener("SLGSocketEvent" + 4523,$.bind(this, "__playerExitHandler"));
         param1.addEventListener("SLGSocketEvent" + 4519,$.bind(this, "__playerMoveHandler"));
         param1.addEventListener("SLGSocketEvent" + 4522,$.bind(this, "__playerBuffHandler"));
         param1.addEventListener("SLGSocketEvent" + 4521,$.bind(this, "__playerSkillHandler"));
         param1.addEventListener("SLGSocketEvent" + 4520,$.bind(this, "__playerAttackHandler"));
         param1.addEventListener("SLGSocketEvent" + 4474,$.bind(this, "__nodeListHandler"));
         param1.addEventListener("SLGSocketEvent" + 4518,$.bind(this, "__campaignInfoHandler"));
         param1.addEventListener("SLGSocketEvent" + 125,$.bind(this, "__createVehicleHandler"));
         param1.addEventListener("SLGSocketEvent" + 4514,$.bind(this, "__campaignEndHandler"));
         param1.addEventListener("SLGSocketEvent" + 4524,$.bind(this, "__bossAttackNoticeHandler"));
      }
    removeSocketEvent(param1) {
         param1.removeEventListener("SLGSocketEvent" + 4517,$.bind(this, "__initPlayerListHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4513,$.bind(this, "__playerJoinHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4523,$.bind(this, "__playerExitHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4519,$.bind(this, "__playerMoveHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4522,$.bind(this, "__playerBuffHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4521,$.bind(this, "__playerSkillHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4520,$.bind(this, "__playerAttackHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4474,$.bind(this, "__nodeListHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4518,$.bind(this, "__campaignInfoHandler"));
         param1.removeEventListener("SLGSocketEvent" + 125,$.bind(this, "__createVehicleHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4514,$.bind(this, "__campaignEndHandler"));
         param1.removeEventListener("SLGSocketEvent" + 4524,$.bind(this, "__bossAttackNoticeHandler"));
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("UPDATE_CHAT_VIEW",$.bind(this, "__playerChatHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("UPDATE_CHAT_VIEW",$.bind(this, "__playerChatHandler"));
      }
    __createVehicleHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         this.createMapModel(_loc2_);
      }
    __initPlayerListHandler(param1) {
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc6_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.PlayerVehicleListMsg"))();
         _loc2_ = $.as(_loc6_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.PlayerVehicleListMsg"));
         for (var _loc5_ of $.values(_loc2_.vehicles))
         {
            if(!_loc5_.hasPlayerId)
            {
               _loc3_ = this._model.getBoss();
               if(_loc3_)
               {
                  _loc3_.hp = _loc5_.hp;
                  _loc3_.commit();
               }
            }
            else
            {
               _loc4_ = this._model.getPlayerInfo(_loc5_.playerId);
               if(!_loc4_)
               {
                  _loc4_ = new ($.C("com.map.vehicle.data.PlayerVehicleInfo"))();
                  _loc4_.playerId = _loc5_.playerId;
               }
               if(_loc5_.hasTemplateId)
               {
                  _loc4_.templateId = _loc5_.templateId;
               }
               if(_loc5_.hasTeam)
               {
                  _loc4_.team = _loc5_.team;
               }
               if(_loc5_.hasGrade)
               {
                  _loc4_.grade = _loc5_.grade;
               }
               if(_loc5_.hasTransGrade)
               {
                  _loc4_.vocationGrades = _loc5_.transGrade;
               }
               if(_loc5_.hasChangeBranch)
               {
                  _loc4_.vocationIndex = _loc5_.changeBranch;
               }
               if(_loc5_.hasHead)
               {
                  _loc4_.headId = _loc5_.head;
               }
               if(_loc5_.hasHp)
               {
                  _loc4_.hp = _loc5_.hp;
               }
               if(_loc5_.hasId)
               {
                  _loc4_.id = _loc5_.id;
               }
               if(_loc5_.hasName)
               {
                  _loc4_.name = _loc5_.name;
               }
               if(_loc5_.hasConsortia)
               {
                  _loc4_.consortiaName = _loc5_.consortia;
               }
               if(_loc5_.buffState)
               {
                  _loc4_.bufferIds = _loc5_.buffState.concat();
               }
               if(_loc5_.hasX)
               {
                  _loc4_.x = _loc5_.x;
               }
               if(_loc5_.hasY)
               {
                  _loc4_.y = _loc5_.y;
               }
               if(_loc5_.hasAppellId)
               {
                  _loc4_.appellId = _loc5_.appellId;
               }
               if(_loc5_.hasVip)
               {
                  _loc4_.isVip = _loc5_.vip != 0;
               }
               if(_loc5_.hasVipType)
               {
                  _loc4_.vipType = _loc5_.vipType;
               }
               if(_loc5_.hasRebornTime)
               {
                  _loc4_.rebornTime = _loc5_.rebornTime;
               }
               _loc4_.commit();
               this._model.addPlayer(_loc4_);
            }
         }
         this._model.syncPlayerInfo();
      }
    __playerJoinHandler(param1) {
         var _loc3_ = null;
         var _loc5_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.PlayerVehicleListMsg"))();
         _loc2_ = $.as(_loc5_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.PlayerVehicleListMsg"));
         for (var _loc4_ of $.values(_loc2_.vehicles))
         {
            if(_loc4_.hasPlayerId)
            {
               _loc3_ = this._model.getPlayerInfo(_loc4_.playerId);
               if(!_loc3_)
               {
                  _loc3_ = new ($.C("com.map.vehicle.data.PlayerVehicleInfo"))();
                  _loc3_.playerId = _loc4_.playerId;
               }
               if(_loc4_.hasTeam)
               {
                  _loc3_.team = _loc4_.team;
               }
               if(_loc4_.hasGrade)
               {
                  _loc3_.grade = _loc4_.grade;
               }
               if(_loc4_.hasHead)
               {
                  _loc3_.headId = _loc4_.head;
               }
               if(_loc4_.hasHp)
               {
                  _loc3_.hp = _loc4_.hp;
               }
               if(_loc4_.hasId)
               {
                  _loc3_.id = _loc4_.id;
               }
               if(_loc4_.hasName)
               {
                  _loc3_.name = _loc4_.name;
               }
               if(_loc4_.hasConsortia)
               {
                  _loc3_.consortiaName = _loc4_.consortia;
               }
               if(_loc4_.buffState)
               {
                  _loc3_.bufferIds = _loc4_.buffState.concat();
               }
               if(_loc4_.hasTemplateId)
               {
                  _loc3_.templateId = _loc4_.templateId;
               }
               if(_loc4_.hasX)
               {
                  _loc3_.x = _loc4_.x;
               }
               if(_loc4_.hasY)
               {
                  _loc3_.y = _loc4_.y;
               }
               if(_loc4_.hasAppellId)
               {
                  _loc3_.appellId = _loc4_.appellId;
               }
               if(_loc4_.hasVip)
               {
                  _loc3_.isVip = _loc4_.vip != 0;
               }
               if(_loc4_.hasVipType)
               {
                  _loc3_.vipType = _loc4_.vipType;
               }
               if(_loc4_.hasRebornTime)
               {
                  _loc3_.rebornTime = _loc4_.rebornTime;
               }
               _loc3_.commit();
               this._model.addPlayer(_loc3_);
            }
         }
         this._model.syncPlayerInfo();
      }
    __playerExitHandler(param1) {
         var _loc3_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehicleExitMsg"))();
         _loc2_ = $.as(_loc3_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.VehicleExitMsg"));
         if(this.playerInfo.userId == _loc2_.playerId)
         {
            this._model.exit = true;
            $.C("yishi.SwitchPageHelp").returnToSpace();
         }
         else
         {
            this._model.removePlayer(_loc2_.playerId);
         }
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    __playerMoveHandler(param1) {
         if(!this._model)
         {
            return;
         }
         if(this._model.exit)
         {
            return;
         }
         var _loc2_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         $.C("yishi.manager.SocketSceneBufferManager").instance.addPkgToBuffer(_loc2_,"VEHICLE",$.bind(this, "__playerMoveImp"));
      }
    __playerMoveImp(param1) {
         var _loc9_ = 0;
         if($.C("yishi.scene.SceneManager").instance.currentType != "VEHICLE")
         {
            return;
         }
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehicleMoveMsg"))();
         _loc2_ = $.as(param1.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.VehicleMoveMsg"));
         if(!this._model)
         {
            return;
         }
         if(this._model.exit)
         {
            return;
         }
         var _loc6_ = this._model.getPlayerInfo(_loc2_.playerId);
         if(!_loc6_)
         {
            return;
         }
         if(_loc6_ == this._model.selfVehicleInfo)
         {
            return;
         }
         if(!_loc6_.logicView)
         {
            _loc6_.x = _loc2_.path[0].x * 20;
            _loc6_.y = _loc2_.path[0].y * 20;
            return;
         }
         var _loc4_ = new ($.C("flash.geom.Point"))(_loc2_.path[0].x,_loc2_.path[0].y);
         var _loc5_ = _loc6_.logicView.getTilePoint();
         var _loc3_ = $.C("flash.geom.Point").distance(_loc4_,_loc5_);
         var _loc8_ = $.C("com.road.mapengine.ai.astar.AIManager").instance.find(_loc5_,_loc4_);
         var _loc7_ = [];
         _loc9_ = 0;
         while(_loc9_ < _loc2_.path.length)
         {
            _loc7_.push(new ($.C("flash.geom.Point"))($.int(_loc2_.path[_loc9_].x),$.int(_loc2_.path[_loc9_].y)));
            _loc9_++;
         }
         if(_loc8_)
         {
            _loc8_.shift();
            _loc7_.shift();
            _loc7_ = _loc8_.concat(_loc7_);
         }
         ($.as(_loc6_.logicView, $.C("com.map.vehicle.objects.TankAvatarView"))).path = _loc7_;
      }
    __playerBuffHandler(param1) {
         var _loc6_ = null;
         var _loc2_ = null;
         var _loc7_ = null;
         var _loc3_ = null;
         var _loc5_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc4_ = new ($.C("com.road.yishi.proto.room.VehicleBuffListMsg"))();
         _loc4_ = $.as(_loc5_.readBody(_loc4_), $.C("com.road.yishi.proto.room.VehicleBuffListMsg"));
         for (_loc2_ of $.values(_loc4_.playerBuffStates))
         {
            _loc7_ = this._model.getPlayerInfo(_loc2_.playerId);
            if(_loc7_)
            {
               _loc6_ = new ($.C("com.map.vehicle.data.VehicleBufferDamageInfo"))();
               _loc6_.id = _loc2_.id;
               _loc6_.buffId = _loc2_.buffId;
               _loc6_.defanceId = _loc2_.playerId;
               _loc6_.damage = _loc2_.effectValue;
               _loc6_.state = _loc2_.state;
               _loc7_.addBuffDamage(_loc6_);
               $.C("yzhkof.debug.log")({},"playerId:" + _loc2_.playerId + ", " + _loc2_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + $.C("flash.utils.getTimer")());
            }
         }
         for (_loc2_ of $.values(_loc4_.npcBuffStates))
         {
            _loc3_ = this._model.getNodeByNodeId(_loc2_.playerId);
            if(_loc3_)
            {
               _loc6_ = new ($.C("com.map.vehicle.data.VehicleBufferDamageInfo"))();
               _loc6_.id = _loc2_.id;
               _loc6_.buffId = _loc2_.buffId;
               _loc6_.defanceId = _loc2_.playerId;
               _loc6_.damage = _loc2_.effectValue;
               _loc6_.state = _loc2_.state;
               _loc3_.addBuffDamage(_loc6_);
               $.C("yzhkof.debug.log")({},"npc:" + _loc2_.playerId + ", " + _loc2_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + $.C("flash.utils.getTimer")());
            }
         }
      }
    __playerSkillHandler(param1) {
         var _loc3_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.room.VehicleSkillListMsg"))();
         _loc2_ = $.as(_loc3_.readBody(_loc2_), $.C("com.road.yishi.proto.room.VehicleSkillListMsg"));
         var _loc4_ = this._model.selfVehicleInfo;
         if(_loc4_)
         {
            this._model.skillBag.updateSkill(_loc2_.skillId,_loc2_.state,_loc2_.curSum);
         }
      }
    __playerAttackHandler(param1) {
         var _loc7_ = null;
         var _loc6_ = null;
         var _loc10_ = null;
         var _loc4_ = null;
         var _loc11_ = null;
         var _loc3_ = null;
         var _loc9_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehicleAttackRspMsg"))();
         _loc2_ = $.as(_loc9_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.VehicleAttackRspMsg"));
         if(!_loc2_.hasSkillId)
         {
            _loc7_ = _loc2_.playerHurtDataList[0];
            if(!_loc7_)
            {
               return;
            }
            _loc10_ = new ($.C("com.map.vehicle.data.HurtData"))();
            _loc10_.shootId = _loc2_.attackerId;
            _loc10_.effectType = 0;
            _loc10_.effectId = _loc7_.affecteId;
            _loc10_.effectValue = _loc7_.value;
            _loc4_ = this._model.getPlayerInfo(_loc10_.effectId);
            if(_loc4_)
            {
               _loc4_.beAtk(_loc10_);
            }
            return;
         }
         var _loc8_ = new ($.C("com.map.vehicle.data.UseSkillInfo"))();
         _loc8_.casterId = _loc2_.attackerId;
         _loc8_.skillId = _loc2_.skillId;
         _loc8_.effectX = _loc2_.effectX * 20;
         _loc8_.effectY = _loc2_.effectY * 20;
         var _loc5_ = 1;
         if(_loc2_.attackTyep == 1)
         {
            _loc5_ = 0;
         }
         for (_loc7_ of $.values(_loc2_.npcHurtDataList))
         {
            _loc6_ = new ($.C("com.map.vehicle.data.HurtData"))(_loc2_.skillId);
            _loc6_.shootId = _loc2_.attackerId;
            _loc6_.effectType = 0;
            _loc6_.effectId = _loc7_.affecteId;
            _loc6_.effectValue = _loc7_.value;
            _loc6_.attackType = _loc5_;
            _loc8_.npcHurt.push(_loc6_);
         }
         for (_loc7_ of $.values(_loc2_.playerHurtDataList))
         {
            _loc6_ = new ($.C("com.map.vehicle.data.HurtData"))(_loc2_.skillId);
            _loc6_.shootId = _loc2_.attackerId;
            _loc6_.effectType = 0;
            _loc6_.effectId = _loc7_.affecteId;
            _loc6_.effectValue = _loc7_.value;
            _loc6_.attackType = _loc5_;
            _loc8_.playerHurt.push(_loc6_);
         }
         if(_loc2_.attackTyep == 1)
         {
            _loc11_ = this._model.getPlayerInfo(_loc8_.casterId);
            if(_loc11_)
            {
               _loc11_.shoot(_loc8_);
            }
            else
            {
               $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("play_skill",_loc8_));
            }
         }
         else
         {
            _loc3_ = this._model.getNodeByNodeId(_loc8_.casterId);
            if(_loc3_)
            {
               _loc3_.shoot(_loc8_);
            }
            else
            {
               $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("play_skill",_loc8_));
            }
         }
      }
    __nodeListHandler(param1) {
         var _loc4_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehicleNpcNodeListMsg"))();
         _loc2_ = $.as(_loc4_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.VehicleNpcNodeListMsg"));
         for (var _loc3_ of $.values(_loc2_.vehicleNpcNode))
         {
            this.model.addNode(this.readNodeInfo(_loc3_));
         }
         _loc2_ = null;
         _loc4_ = null;
      }
    readNodeInfo(param1) {
         var _loc2_ = this._model.getNodeByNodeId(param1.nodeId);
         if(!_loc2_)
         {
            _loc2_ = new ($.C("com.map.vehicle.data.VehicleNode"))();
         }
         if(param1.hasNodeId)
         {
            _loc2_.nodeId = param1.nodeId;
         }
         if(param1.hasType)
         {
            _loc2_.type = param1.type;
         }
         if(param1.hasCurX)
         {
            _loc2_.posX = param1.curX;
         }
         if(param1.hasCurY)
         {
            _loc2_.posY = param1.curY;
         }
         if(param1.hasState)
         {
            _loc2_.state = param1.state;
         }
         if(param1.hasHp)
         {
            _loc2_.hp = param1.hp;
         }
         if(param1.hasName)
         {
            _loc2_.name = param1.name;
         }
         if(param1.hasSonType)
         {
            _loc2_.sonType = param1.sonType;
         }
         if(param1.hasHeroTempId)
         {
            _loc2_.heroTempId = param1.heroTempId;
         }
         if(param1.hasResource)
         {
            _loc2_.resource = param1.resource;
         }
         if(param1.hasNameColor)
         {
            _loc2_.nameColor = param1.nameColor;
         }
         if(param1.hasRestX)
         {
            _loc2_.resetPosX = param1.restX;
         }
         if(param1.hasRestY)
         {
            _loc2_.resetPosY = param1.restY;
         }
         _loc2_.commit();
         if(param1.hasType && _loc2_.type == 0)
         {
            this.model.bossRefreshed = true;
         }
         return _loc2_;
      }
    __campaignInfoHandler(param1) {
         var _loc5_ = null;
         var _loc4_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehicleCampaignDetailMsg"))();
         _loc2_ = $.as(_loc4_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.VehicleCampaignDetailMsg"));
         if(_loc2_.hasRedTeamScroe)
         {
            this._model.redScore = _loc2_.redTeamScroe;
         }
         if(_loc2_.hasBlueTeamScroe)
         {
            this._model.blueScore = _loc2_.blueTeamScroe;
         }
         if(_loc2_.hasMyScroe)
         {
            this._model.myScore = _loc2_.myScroe;
         }
         if(_loc2_.hasRemainsTiem)
         {
            this._model.remainsTime = _loc2_.remainsTiem;
         }
         for (var _loc3_ of $.values(_loc2_.scroeList))
         {
            _loc5_ = this._model.getPlayerInfo(_loc3_.playerId);
            if(_loc5_)
            {
               _loc5_.score = _loc3_.playerScroe;
            }
         }
         this._model.syncScore();
         this._model.startCountTime();
      }
    __campaignEndHandler(param1) {
         var _loc7_ = null;
         this.removeSocketEvent($.C("yishi.service.managers.SocketManager").instance);
         var _loc6_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehicleCampaignDetailMsg"))();
         _loc2_ = $.as(_loc6_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.VehicleCampaignDetailMsg"));
         this._model.exit = true;
         var _loc3_ = new ($.C("com.map.vehicle.data.VehicleAccountInfo"))();
         if(_loc2_.hasRedTeamScroe)
         {
            this._model.redScore = _loc2_.redTeamScroe;
         }
         if(_loc2_.hasBlueTeamScroe)
         {
            this._model.blueScore = _loc2_.blueTeamScroe;
         }
         if(_loc2_.hasMyScroe)
         {
            this._model.myScore = _loc2_.myScroe;
         }
         if(_loc2_.hasRemainsTiem)
         {
            this._model.remainsTime = _loc2_.remainsTiem;
         }
         for (var _loc5_ of $.values(_loc2_.scroeList))
         {
            _loc7_ = this._model.getPlayerInfo(_loc5_.playerId);
            if(_loc7_)
            {
               _loc7_.score = _loc5_.playerScroe;
               if(_loc7_ == this._model.selfVehicleInfo)
               {
                  _loc3_.reward1 = this._model.reward1 = _loc5_.awardSum;
                  _loc3_.reward2 = this._model.rewardExp = _loc5_.playerExp;
                  _loc3_.reward3 = this._model.reward2 = _loc5_.ladderSum;
               }
            }
         }
         if(this._model.selfVehicleInfo.team == _loc2_.winner || _loc2_.winner == 3)
         {
            this._model.isWin = true;
         }
         else
         {
            this._model.isWin = false;
         }
         _loc3_.isWin = this._model.isWin;
         _loc3_.myTeamId = this._model.selfVehicleInfo.team;
         _loc3_.playerList = [];
         for (_loc7_ of $.values(this._model.playerList))
         {
            _loc3_.playerList.push(_loc7_);
         }
         var _loc4_ = new ($.C("com.map.vehicle.action.AccountAction"))(_loc3_);
      }
    __bossAttackNoticeHandler(param1) {
         var _loc4_ = $.as(param1.data, $.C("yishi.comm.PackageIn"));
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehicleAttackRspMsg"))();
         _loc2_ = $.as(_loc4_.readBody(_loc2_), $.C("com.road.yishi.proto.vehicle.VehicleAttackRspMsg"));
         var _loc3_ = new ($.C("flash.geom.Point"))(_loc2_.effectX,_loc2_.effectY);
         _loc3_.x *= 20;
         _loc3_.y *= 20;
         this._model.bossAttackNotice(_loc3_);
      }
    __playerChatHandler(param1) {
         if($.C("yishi.scene.SceneManager").instance.currentType != "VEHICLE")
         {
            return;
         }
         var _loc3_ = $.as(param1.data, $.C("chat.datas.ChatData"));
         if(!this.model || !_loc3_)
         {
            return;
         }
         if(_loc3_.channel != 6 && _loc3_.channel != 8)
         {
            return;
         }
         var _loc2_ = this.model.getPlayerInfo(_loc3_.uid);
         if(_loc2_)
         {
            _loc2_.chatData = _loc3_;
         }
      }
    createMapModel(param1) {
         if(!param1)
         {
            return;
         }
         var _loc2_ = new ($.C("com.road.yishi.proto.room.RoomCreatedMsg"))();
         _loc2_ = $.as(param1.readBody(_loc2_), $.C("com.road.yishi.proto.room.RoomCreatedMsg"));
         this._model = new ($.C("com.map.vehicle.VehicleModel"))(3001);
         this._model.createType = _loc2_.createdType;
         _loc2_ = null;
         param1 = null;
         $.C("com.map.vehicle.data.VGlobal").model = this._model;
      }
    get model() {
         return this._model;
      }
    dispose() {
         if(!this._isUse)
         {
            return;
         }
         this._isUse = false;
         this.removeSocketEvent($.C("proxy.SocketDataProxyManager").instance);
         this.removeSocketEvent($.C("yishi.service.managers.SocketManager").instance);
         this.removeEvent();
         __VehicleSocketManager._instance = null;
         this.controller = null;
         this._model = null;
         $.C("managers.RoomManager").instance.dispose();
      }
    static set instance(v) { super.instance = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__VehicleSocketManager, "com.map.vehicle.net.VehicleSocketManager", ["Disposeable"]);
  $.statics(__VehicleSocketManager, () => {
    __VehicleSocketManager._instance = null;
  });
  return __VehicleSocketManager;
}
deps["com.map.vehicle.net.VehicleSocketManager"] = ["chat.datas.ChatData", "com.map.vehicle.VehicleModel", "com.map.vehicle.action.AccountAction", "com.map.vehicle.data.HurtData", "com.map.vehicle.data.PlayerVehicleInfo", "com.map.vehicle.data.UseSkillInfo", "com.map.vehicle.data.VGlobal", "com.map.vehicle.data.VehicleAccountInfo", "com.map.vehicle.data.VehicleBufferDamageInfo", "com.map.vehicle.data.VehicleNode", "com.map.vehicle.events.VehicleEvent", "com.map.vehicle.objects.TankAvatarView", "com.road.mapengine.ai.astar.AIManager", "com.road.yishi.proto.room.RoomCreatedMsg", "com.road.yishi.proto.room.VehicleBuffListMsg", "com.road.yishi.proto.room.VehicleSkillListMsg", "com.road.yishi.proto.vehicle.PlayerVehicleListMsg", "com.road.yishi.proto.vehicle.VehicleAttackRspMsg", "com.road.yishi.proto.vehicle.VehicleCampaignDetailMsg", "com.road.yishi.proto.vehicle.VehicleExitMsg", "com.road.yishi.proto.vehicle.VehicleMoveMsg", "com.road.yishi.proto.vehicle.VehicleNpcNodeListMsg", "flash.geom.Point", "flash.utils.getTimer", "managers.RoomManager", "proxy.SocketDataProxyManager", "yishi.SwitchPageHelp", "yishi.comm.PackageIn", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.SocketSceneBufferManager", "yishi.scene.SceneManager", "yishi.service.managers.SocketManager", "yzhkof.debug.log"];

defs["com.map.vehicle.net.VehicleSocketOutManager"] = function define($) {
  const __Base = $.Object;
  class __VehicleSocketOutManager extends __Base {
    static $fields(self) {
    self.socket = null;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s.socket = $.C("yishi.service.managers.SocketManager").instance.socket;
         });
         super();
         $.preFlush(this, new.target);
      }
    static get instance() {
         if(!__VehicleSocketOutManager._instance)
         {
            __VehicleSocketOutManager._instance = new (__VehicleSocketOutManager)();
         }
         return __VehicleSocketOutManager._instance;
      }
    sendCastSkill(param1, param2, param3, param4 = 0, param5 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         var _loc7_ = new ($.C("yishi.comm.PackageOut"))(8616);
         var _loc6_ = new ($.C("com.road.yishi.proto.vehicle.VehicleAttackReqMsg"))();
         _loc6_.skillId = param1;
         _loc6_.effectX = param4;
         _loc6_.effectY = param5;
         _loc6_.suffererId = param2;
         if(param3 && param3.length > 0)
         {
            _loc6_.suffererNpcId = param3[0];
         }
         $.C("yishi.manager.BaseManager").instance.sendVehicleByteCount++;
         this.socket.sendProtobuffer(_loc7_,_loc6_,$.C("yishi.manager.BaseManager").instance.sendVehicleByteCount);
      }
    sendCampaignArmyMove(param1, param2, param3 = 3001) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc6_ = 0;
         var _loc5_ = null;
         if(!$.C("com.map.vehicle.data.VGlobal").model)
         {
            return;
         }
         if(!$.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo)
         {
            return;
         }
         if($.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo.playerId != param1)
         {
            return;
         }
         var _loc8_ = new ($.C("yishi.comm.PackageOut"))(8615);
         var _loc4_ = new ($.C("com.road.yishi.proto.vehicle.VehicleMoveMsg"))();
         _loc4_.playerId = param1;
         var _loc7_ = [];
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_ = new ($.C("com.road.yishi.proto.vehicle.Position"))();
            _loc5_.x = param2[_loc6_].x;
            _loc5_.y = param2[_loc6_].y;
            _loc7_.push(_loc5_);
            _loc6_++;
         }
         _loc4_.path = _loc7_;
         $.C("yishi.manager.BaseManager").instance.sendVehicleByteCount++;
         this.socket.sendProtobuffer(_loc8_,_loc4_,$.C("yishi.manager.BaseManager").instance.sendVehicleByteCount);
      }
    sendPickup(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = new ($.C("yishi.comm.PackageOut"))(8617);
         var _loc2_ = new ($.C("com.road.yishi.proto.vehicle.VehiclePickPropMsg"))();
         _loc2_.propNodeId = param1;
         $.C("yishi.manager.BaseManager").instance.sendVehicleByteCount++;
         this.socket.sendProtobuffer(_loc3_,_loc2_,$.C("yishi.manager.BaseManager").instance.sendVehicleByteCount);
      }
    sendReturnCampaignRoom() {
         var _loc1_ = new ($.C("yishi.comm.PackageOut"))(8610);
         this.socket.send(_loc1_);
      }
    dispose() {
         __VehicleSocketOutManager._instance = null;
         this.socket = null;
      }
    static set instance(v) { super.instance = v; }
  }
  $.meta(__VehicleSocketOutManager, "com.map.vehicle.net.VehicleSocketOutManager", []);
  $.statics(__VehicleSocketOutManager, () => {
    __VehicleSocketOutManager._instance = null;
  });
  return __VehicleSocketOutManager;
}
deps["com.map.vehicle.net.VehicleSocketOutManager"] = ["com.map.vehicle.data.VGlobal", "com.road.yishi.proto.vehicle.Position", "com.road.yishi.proto.vehicle.VehicleAttackReqMsg", "com.road.yishi.proto.vehicle.VehicleMoveMsg", "com.road.yishi.proto.vehicle.VehiclePickPropMsg", "yishi.comm.PackageOut", "yishi.manager.BaseManager", "yishi.service.managers.SocketManager"];

defs["com.map.vehicle.objects.TankAvatarView"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapAvatarLogic");
  class __TankAvatarView extends __Base {
    static $fields(self) {
    self._skillQueue = null;
    self._asynActionMgr = null;
    self._pathLogic = null;
    self._data = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._barrel = null;
    self._soulMc = null;
    self._riverMc = null;
    self._barrelLayer = null;
    self._effectLayer = null;
    self._stuffView = null;
    self._standPos = null;
    self._chatPopView = null;
    self._showNamePosY = -125;
    self._hurtNumLayer = null;
    self.resDomain = null;
    self._angleCorrect = NaN;
    self._barrelPos = new ($.C("flash.geom.Point"))();
    self._follow = null;
    self._dieTimeId = 0;
    self._lastSoundTime = 0;
    self._curLabel = "Stand";
    }
    constructor(param1) {
         super(param1);
         this._skillQueue = new ($.C("yishi.manager.ActionQueueManager"))();
         this._asynActionMgr = new ($.C("com.map.vehicle.utils.AsynActionManager"))();
         this._pathLogic = new ($.C("com.road.mapengine.ai.astar.AvatarPathWalkAi"))();
         this._pathLogic.avatar = this;
         this._walkTotalFrameX = 5;
         this._walkTotalFrameY = 4;
         this._standTotalFrameX = 4;
         this._standTotalFrameY = 2;
         this._standPos = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.StandShadowAsset");
         this._standPos.width = 150;
         this._standPos.x = -70;
         this._standPos.y = -42;
         this._barrelLayer = new ($.C("flash.display.Sprite"))();
         this._effectLayer = new ($.C("com.map.vehicle.view.EffectsLayer"))();
         this._stuffView = new ($.C("com.map.vehicle.view.VehicleBloodStuffView"))();
         this._soulMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.DieEffect");
         this._soulMc.gotoAndStop(1);
         this._soulMc.y = -75;
         this._riverMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.RiverMC");
         this._riverMc.gotoAndStop(1);
         this._riverMc.y = -75;
         this._hurtNumLayer = new ($.C("flash.display.Sprite"))();
         this._soulMc.mouseEnabled = this._soulMc.mouseChildren = false;
         this._barrelLayer.mouseChildren = this._barrelLayer.mouseEnabled = false;
         this._effectLayer.mouseChildren = this._effectLayer.mouseEnabled = false;
         this._stuffView.mouseChildren = this._stuffView.mouseEnabled = false;
         this._riverMc.mouseChildren = this._riverMc.mouseEnabled = false;
         this._hurtNumLayer.mouseChildren = this._hurtNumLayer.mouseEnabled = false;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         if(this._data)
         {
            return;
         }
         this.resDomain = $.C("com.map.vehicle.SkillEffectFactory").instance.domain;
         this._data = param1;
         this._data.logicView = this;
         this.initView();
         this._container.mouseEnabled = this._container.mouseChildren = !this.isFriend;
         this.addEvent();
         this._effectLayer.data = param1;
         this._stuffView.data = this._data;
         this.loadResource();
         if(this._model.isFriend(this._data.team))
         {
            this._container.mouseChildren = this._container.mouseEnabled = false;
         }
         if(this._data.hp <= 0)
         {
            this.__onDieHandler();
         }
      }
    initView() {
         this._container.addChild(this._standPos);
         this._container.addChild(this._baseView);
         this._container.addChild(this._barrelLayer);
         $.C("com.map.vehicle.data.VGlobal").logicWorld.nameLayer.addChild(this._stuffView);
         $.C("com.map.vehicle.data.VGlobal").logicWorld.nameLayer.addChild(this._hurtNumLayer);
         this._container.addChild(this._effectLayer);
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.x = param1;
         if(this._stuffView)
         {
            this._stuffView.x = param1;
         }
         if(this._hurtNumLayer)
         {
            this._hurtNumLayer.x = this.x;
         }
      }
    set y(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.y = param1;
         if(this._stuffView)
         {
            this._stuffView.y = param1 + this._showNamePosY;
         }
         if(this._hurtNumLayer)
         {
            this._hurtNumLayer.y = this.y;
         }
      }
    set sizeType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         super.sizeType = param1;
         this._showNamePosY = this.getNamePosY();
         this.layout();
      }
    getNamePosY() {
         var _loc1_ = -125;
         switch(this.sizeType - 1)
         {
            case 0:
               _loc1_ = -125;
               break;
            case 1:
               _loc1_ = -150;
               break;
            case 2:
            case 9:
               _loc1_ = -165;
         }
         return _loc1_;
      }
    addEvent() {
         if(this._data)
         {
            this._data.addEventListener("SKILL_CAST_OVER",$.bind(this, "__useSkillHandler"));
            this._data.addEventListener("cast",$.bind(this, "__castHandler"));
            this._data.addEventListener("pickup",$.bind(this, "__onPickupHandler"));
            this._data.addEventListener("stateChange",$.bind(this, "__stateChangeHandler"));
            this._data.addEventListener("playerInfoChange",$.bind(this, "__updateHandler"));
            this._data.addEventListener("SKILL_HURT",$.bind(this, "__skillHurtHandler"));
            this._data.addEventListener("BUFF_HURT",$.bind(this, "__buffHurtHandler"));
            this._data.addEventListener("CHAT_DATA",$.bind(this, "__teamChatHandler"));
            this._data.addEventListener("HP_ADD",$.bind(this, "__addHpHandler"));
            this._data.addEventListener("DIE",$.bind(this, "__onDieHandler"));
            this._data.addEventListener("REVIER",$.bind(this, "__onRiverHandler"));
            this._pathLogic.addEventListener("WALK_OVER",$.bind(this, "__walkOverHandler"));
         }
         if(this.isSelf)
         {
            this.playerInfo.addEventListener("CONSORTIA_NAME_CHANGE",$.bind(this, "__consortiaChangeHandler"));
         }
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("SKILL_CAST_OVER",$.bind(this, "__useSkillHandler"));
            this._data.removeEventListener("cast",$.bind(this, "__castHandler"));
            this._data.removeEventListener("pickup",$.bind(this, "__onPickupHandler"));
            this._data.removeEventListener("stateChange",$.bind(this, "__stateChangeHandler"));
            this._data.removeEventListener("playerInfoChange",$.bind(this, "__updateHandler"));
            this._data.removeEventListener("SKILL_HURT",$.bind(this, "__skillHurtHandler"));
            this._data.removeEventListener("BUFF_HURT",$.bind(this, "__buffHurtHandler"));
            this._data.removeEventListener("CHAT_DATA",$.bind(this, "__teamChatHandler"));
            this._data.removeEventListener("HP_ADD",$.bind(this, "__addHpHandler"));
            this._data.removeEventListener("DIE",$.bind(this, "__onDieHandler"));
            this._data.removeEventListener("REVIER",$.bind(this, "__onRiverHandler"));
            this._pathLogic.removeEventListener("WALK_OVER",$.bind(this, "__walkOverHandler"));
         }
         if(this.isSelf)
         {
            this.playerInfo.removeEventListener("CONSORTIA_NAME_CHANGE",$.bind(this, "__consortiaChangeHandler"));
         }
      }
    get isFriend() {
         var _loc1_ = 0;
         if(this._model.selfVehicleInfo && this._data)
         {
            _loc1_ = this._model.selfVehicleInfo.team;
            return _loc1_ == this._data.team;
         }
         return true;
      }
    get isSelf() {
         if(this.data)
         {
            return this.data == this._model.selfVehicleInfo;
         }
         return false;
      }
    loadResource() {
         this.resDomain.removeCallBackFunction($.bind(this, "__onLoadedHandler"));
         var _loc1_ = $.C("yishi.manager.PathManager").getVehicleAvatarPath(String(this._data.template.Avatar));
         this.resDomain.load(_loc1_,false,$.bind(this, "__onLoadedHandler"));
      }
    __onLoadedHandler() {
         if(!this._skillQueue)
         {
            return;
         }
         if(this._barrel)
         {
            this._barrel.gotoAndStop(1);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._barrel);
         }
         var _loc3_ = this.data.template.Avatar.substr(1);
         var _loc2_ = "asset.avatar." + _loc3_;
         var _loc1_ = $.C("com.map.vehicle.SkillEffectFactory").instance.domain;
         if(_loc1_ && _loc1_.hasDefinition(_loc2_))
         {
            this._barrel = $.as(_loc1_.createInstane(_loc2_), $.C("flash.display.MovieClip"));
            this._barrelLayer.addChild(this._barrel);
            this._barrel.mouseChildren = this._barrel.mouseEnabled = false;
            this.keepAngleWithBody();
            this._effectLayer.tankBody = this._barrel;
         }
         this.layout();
         if(this._data.hp <= 0)
         {
            this.__onDieHandler();
         }
      }
    layout() {
         if(this._stuffView)
         {
            this._effectLayer.posA = this._showNamePosY - this._stuffView.getTextHeight() - 5;
         }
      }
    changeDirectionTo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(!this._barrel)
         {
            return;
         }
         var _loc3_ = param1 - this.x;
         var _loc4_ = param2 - this.y;
         var _loc5_ = Math.atan2(_loc4_,_loc3_);
         var _loc6_ = _loc5_ * 180 / 3.141592653589793;
         if(_loc6_ < 0)
         {
            _loc6_ += 360;
         }
         this.angle = _loc6_;
      }
    getShootPoint() {
         var _loc2_ = null;
         var _loc1_ = new ($.C("flash.geom.Point"))(this.x,this.y);
         if(this._barrel && this._barrel["bombpos"])
         {
            _loc2_ = $.as(this._barrel["bombpos"], $.C("flash.display.Sprite"));
            if(_loc2_)
            {
               _loc1_ = _loc2_.localToGlobal(new ($.C("flash.geom.Point"))(0,0));
               _loc1_ = this.mapScene.parent.globalToLocal(_loc1_);
            }
         }
         return _loc1_;
      }
    bombFlyOut() {
         if(!this._barrel)
         {
            return;
         }
      }
    playBombSmoke(param1) {
         if(this._barrel)
         {
            this._barrel.gotoAndPlay("Attack" + (this.frameY + 1));
         }
      }
    fineTuning(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         param1 = param1 < 0 ? param1 + 360 : param1;
         if(param1 >= 260 && param1 < 280)
         {
            this._barrelPos.x = 4;
            this._barrelPos.y = 1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            this._barrelPos.x = 3;
            this._barrelPos.y = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            this._barrelPos.x = 2;
            this._barrelPos.y = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            this._barrelPos.x = 1;
            this._barrelPos.y = 1;
         }
         else if(param1 >= 80 && param1 < 100)
         {
            this._barrelPos.x = 0;
            this._barrelPos.y = 1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            this._barrelPos.x = 1;
            this._barrelPos.y = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            this._barrelPos.x = 2;
            this._barrelPos.y = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            this._barrelPos.x = 3;
            this._barrelPos.y = -1;
         }
         return this._barrelPos;
      }
    get follow() {
         return this._follow;
      }
    set follow(param1) {
         this._follow = param1;
         if(this._follow)
         {
            this.changeDirectionTo(this._follow.x,this._follow.y);
         }
      }
    drawStand() {
      }
    darwWalk() {
      }
    __castHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = $.as(param1.data, $.C("com.map.vehicle.data.SkillCastInfo"));
         if(_loc3_)
         {
            _loc2_ = new ($.C("com.map.vehicle.action.CastAction"))(this,_loc3_.skillid);
            _loc2_.targetLogic = _loc3_.target;
            _loc2_.targetPoint = _loc3_.castPos;
            this._skillQueue.addAction(_loc2_);
         }
      }
    __onPickupHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = $.cast($.C("com.map.vehicle.data.VehicleNode"), param1.data);
         if(_loc2_ && _loc2_.logicView)
         {
            _loc3_ = new ($.C("com.map.vehicle.action.PickupAction"))(this,_loc2_.logicView);
            this._skillQueue.addAction(_loc3_);
            $.C("com.map.vehicle.net.VehicleSocketManager").instance.controller.vehicleWorld.characterController.cancel();
         }
      }
    __stateChangeHandler(param1) {
         if(this._data.state == $.C("com.map.vehicle.data.TankState").Stun)
         {
            this.stop();
         }
      }
    __updateHandler(param1) {
      }
    __skillHurtHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.HurtData"));
         var _loc3_ = new ($.C("com.map.vehicle.action.HurtNumberAction"))(this,_loc2_);
         this._asynActionMgr.addAction(_loc3_);
         if(_loc2_.skillId == 1 && this._model.selfVehicleInfo && _loc2_.shootId == this._model.selfVehicleInfo.playerId)
         {
            $.C("com.pickgliss.utils.SoundManager").instance.play("050");
         }
      }
    __buffHurtHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.HurtData"));
         var _loc3_ = new ($.C("com.map.vehicle.action.HurtNumberAction"))(this,_loc2_);
         this._asynActionMgr.addAction(_loc3_);
      }
    __useSkillHandler(param1) {
         var _loc2_ = param1.data;
         var _loc3_ = new ($.C("com.map.vehicle.action.ShootAction"))(this,_loc2_);
         this._skillQueue.addAction(_loc3_);
      }
    __teamChatHandler(param1) {
         if(this._chatPopView)
         {
            this._chatPopView.dispose();
         }
         this._chatPopView = null;
         if(!this._chatPopView)
         {
            this._chatPopView = new ($.C("com.map.vehicle.view.VehicleChatPopView"))();
            this._chatPopView.data = this._data.chatData;
            this._chatPopView.x = -this._chatPopView.displayWidth / 2;
            this._chatPopView.y = this._standPos.y - 100 - this._chatPopView.displayHeight;
            if(this._stuffView)
            {
               this._chatPopView.y = -13 - this._chatPopView.displayHeight;
               this._stuffView.addChild(this._chatPopView);
            }
            else
            {
               this.addChild(this._chatPopView);
            }
         }
      }
    __addHpHandler(param1) {
         var _loc4_ = param1.data;
         var _loc2_ = new ($.C("com.map.vehicle.data.HurtData"))();
         _loc2_.effectType = 1;
         _loc2_.effectValue = _loc4_;
         var _loc3_ = new ($.C("com.map.vehicle.action.HurtNumberAction"))(this,_loc2_);
         this._asynActionMgr.addAction(_loc3_);
      }
    __onDieHandler(param1 = null) {
         this.unSelect();
         this.container.mouseEnabled = this.container.mouseChildren = false;
         if(this._barrel && this._barrel.parent)
         {
            this._barrel.parent.removeChild(this._barrel);
         }
         if(this._soulMc)
         {
            this._barrelLayer.addChild(this._soulMc);
            this._soulMc.gotoAndPlay(1);
         }
         if(this._dieTimeId > 0)
         {
            $.C("flash.utils.clearTimeout")(this._dieTimeId);
         }
         this._dieTimeId = 0;
         var _loc2_ = (this._data.rebornTime - 1) * 1000;
         if(_loc2_ >= 0)
         {
            this._dieTimeId = $.C("flash.utils.setTimeout")($.bind(this, "playRiverMovie"),_loc2_);
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("047");
      }
    playRiverMovie() {
         if(this._dieTimeId > 0)
         {
            $.C("flash.utils.clearTimeout")(this._dieTimeId);
         }
         this._dieTimeId = 0;
         if(this._soulMc && this._soulMc.parent)
         {
            this._soulMc.gotoAndStop(1);
            this._soulMc.parent.removeChild(this._soulMc);
         }
         if(this._riverMc)
         {
            this._barrelLayer.addChild(this._riverMc);
            this._riverMc.gotoAndStop(1);
            $.C("com.greensock.TweenMax").to(this._riverMc,1,{
               "frame":this._riverMc.totalFrames,
               "onComplete":$.bind(this, "riverMcCompleteHandler")
            });
         }
      }
    riverMcCompleteHandler() {
         if(this._riverMc && this._riverMc.parent)
         {
            $.C("com.greensock.TweenMax").killTweensOf(this._riverMc);
            this._riverMc.parent.removeChild(this._riverMc);
         }
      }
    __onRiverHandler(param1 = null) {
         if(this.isSelf)
         {
            $.C("com.pickgliss.utils.SoundManager").instance.play("010");
         }
         this._container.mouseEnabled = this.container.mouseChildren = !this.isFriend;
         if(this._dieTimeId > 0)
         {
            $.C("flash.utils.clearTimeout")(this._dieTimeId);
         }
         this._dieTimeId = 0;
         this.riverMcCompleteHandler();
         if(this._soulMc && this._soulMc.parent)
         {
            this._soulMc.gotoAndStop(1);
            this._soulMc.parent.removeChild(this._soulMc);
         }
         if(this._barrel)
         {
            this._barrelLayer.addChild(this._barrel);
         }
      }
    __chatBackCall() {
      }
    keepAngleWithBody() {
         if(this._barrel)
         {
            this._barrel.scaleX = this.mirror;
            this._barrel.gotoAndPlay(this.curLabel + (this.frameY + 1));
         }
      }
    getAngle(param1, param2) {
         var _loc3_ = param2.x - param1.x;
         var _loc4_ = param2.y - param1.y;
         var _loc6_ = Math.atan2(_loc4_,_loc3_);
         var _loc5_ = _loc6_ * 180 / 3.141592653589793;
         if(_loc5_ < 0)
         {
            _loc5_ += 360;
         }
         return _loc5_;
      }
    set path(param1) {
         if(this._pathLogic)
         {
            this._pathLogic.paths = param1;
         }
      }
    get path() {
         if(this._pathLogic)
         {
            return this._pathLogic.paths;
         }
         return null;
      }
    beAttacted(param1) {
      }
    getResourcepath(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return $.C("yishi.manager.PathManager").getVehicleAvatarPath(param1);
      }
    update() {
         var _loc1_ = $.C("flash.utils.getTimer")();
         if(this._asynActionMgr)
         {
            this._asynActionMgr.update();
         }
         if(this._skillQueue)
         {
            this._skillQueue.update();
         }
         if(this._pathLogic)
         {
            this._pathLogic.execute();
         }
         if(this._stuffView)
         {
            this._stuffView.updateHoner();
         }
         super.update();
         if(this._data)
         {
            if(this._data.isStun)
            {
               this.stop();
            }
         }
      }
    get speed() {
         if(this._data)
         {
            return this._data.speed;
         }
         return 7;
      }
    get curResourceType() {
         return 6;
      }
    mouseClickEvent(param1) {
         if(this._data && this._data == this._model.selfVehicleInfo)
         {
            return false;
         }
         var _loc2_ = true;
         if(_loc2_)
         {
         }
         return _loc2_;
      }
    mouseMoveEvent(param1) {
         var _loc2_ = false;
         if(this._data && this._data == this._model.selfVehicleInfo)
         {
            return false;
         }
         if(this._barrel)
         {
            _loc2_ = Boolean(this._container.hitTestPoint($.C("com.pickgliss.toplevel.StageReferance").stage.mouseX,$.C("com.pickgliss.toplevel.StageReferance").stage.mouseY,true));
            if(_loc2_)
            {
               $.C("com.map.vehicle.data.VGlobal").buildfilter.setGlowFilter(this._barrel);
            }
            else
            {
               $.C("com.map.vehicle.data.VGlobal").buildfilter.setNormalFilter(this._barrel);
            }
         }
         return _loc2_;
      }
    mouseOutEvent(param1) {
         if(this._data && this._data == this._model.selfVehicleInfo)
         {
            return false;
         }
         if(this._barrel)
         {
            $.C("com.map.vehicle.data.VGlobal").buildfilter.setNormalFilter(this._barrel);
         }
         return true;
      }
    mouseOverEvent(param1) {
         return true;
      }
    drawJumpPrepare() {
      }
    drawAttackPrepare() {
      }
    darwWalkPrepare() {
      }
    get curLabel() {
         return this._curLabel;
      }
    set curLabel(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._curLabel == param1)
         {
            return;
         }
         this._curLabel = param1;
      }
    set angle(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.angle = param1;
         if(this._barrel)
         {
            this._barrel.scaleX = this.mirror;
            this.playBarrel();
         }
      }
    set state(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._state != param1)
         {
            this._state = param1;
            if(this.state == 3)
            {
               this.curLabel = "Stand";
            }
            else if(this.state == 4)
            {
               this.curLabel = "Walk";
            }
            else if(this.state == 2)
            {
               this.curLabel = "Attack";
            }
            this.playBarrel();
         }
      }
    playBarrel() {
         var _loc1_ = this.curLabel + (this.frameY + 1);
         if(!this._barrel)
         {
            return;
         }
         if(_loc1_ == this._barrel.currentLabel)
         {
            return;
         }
         this._barrel.gotoAndPlay(_loc1_);
      }
    stop() {
         super.stop();
         this.path = null;
      }
    __walkOverHandler(param1) {
         this._lastSoundTime = 0;
      }
    __consortiaChangeHandler(param1) {
         if(this._data)
         {
            this._data.consortiaName = this.playerInfo.consortiaName;
            if(this._stuffView)
            {
               this._stuffView.update();
            }
         }
      }
    select(param1) {
         if(param1)
         {
            super.select(param1);
            this.addChildAt(param1,0);
            param1.y = -25;
         }
      }
    addHurtMovie(param1) {
         if(this._hurtNumLayer)
         {
            this._hurtNumLayer.addChild(param1);
         }
         else
         {
            this.addChild(param1);
         }
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         if(this.resDomain)
         {
            this.resDomain.removeCallBackFunction($.bind(this, "__onLoadedHandler"));
         }
         this.resDomain = null;
         if(this._dieTimeId > 0)
         {
            $.C("flash.utils.clearTimeout")(this._dieTimeId);
         }
         this._dieTimeId = 0;
         this.removeEvent();
         if(this._skillQueue)
         {
            this._skillQueue.dispose();
         }
         this._skillQueue = null;
         if(this._asynActionMgr)
         {
            this._asynActionMgr.dispose();
         }
         this._asynActionMgr = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._soulMc);
         this._soulMc = null;
         if(this._effectLayer)
         {
            this._effectLayer.dispose();
         }
         this._effectLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._barrelLayer);
         this._barrelLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._standPos);
         this._standPos = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pathLogic);
         this._pathLogic = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stuffView);
         this._stuffView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hurtNumLayer);
         this._hurtNumLayer = null;
         if(this._riverMc)
         {
            $.C("com.greensock.TweenMax").killTweensOf(this._riverMc);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._riverMc);
            this._riverMc = null;
         }
         super.dispose();
      }
    get x() { return super.x; }
    get y() { return super.y; }
    get sizeType() { return super.sizeType; }
    set isFriend(v) { super.isFriend = v; }
    set isSelf(v) { super.isSelf = v; }
    set speed(v) { super.speed = v; }
    set curResourceType(v) { super.curResourceType = v; }
    get angle() { return super.angle; }
    get state() { return super.state; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__TankAvatarView, "com.map.vehicle.objects.TankAvatarView", ["ICaster"]);
  return __TankAvatarView;
}
deps["com.map.vehicle.objects.TankAvatarView"] = ["com.greensock.TweenMax", "com.map.vehicle.SkillEffectFactory", "com.map.vehicle.action.CastAction", "com.map.vehicle.action.HurtNumberAction", "com.map.vehicle.action.PickupAction", "com.map.vehicle.action.ShootAction", "com.map.vehicle.data.HurtData", "com.map.vehicle.data.SkillCastInfo", "com.map.vehicle.data.TankState", "com.map.vehicle.data.VGlobal", "com.map.vehicle.data.VehicleNode", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.utils.AsynActionManager", "com.map.vehicle.view.EffectsLayer", "com.map.vehicle.view.VehicleBloodStuffView", "com.map.vehicle.view.VehicleChatPopView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "com.road.mapengine.ai.astar.AvatarPathWalkAi", "com.road.mapengine.bitmap.logic.BitmapAvatarLogic", "flash.display.MovieClip", "flash.display.Sprite", "flash.geom.Point", "flash.utils.clearTimeout", "flash.utils.getTimer", "flash.utils.setTimeout", "yishi.manager.ActionQueueManager", "yishi.manager.PathManager", "yishi.manager.PlayerManager"];

defs["com.map.vehicle.objects.VehicleBoxView"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapSimpleLogic");
  class __VehicleBoxView extends __Base {
    static $fields(self) {
    self._data = null;
    self._mc = null;
    self._nameTxt = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._frame = 1;
    }
    constructor(param1) {
         super(param1);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         if(this._data)
         {
            this._data.logicView = this;
            this.initView();
            this.addEvent();
            this.loadResource();
         }
      }
    initView() {
         if(!this._nameTxt)
         {
            this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("campaign.map.NpcNameTxt");
         }
         if(this.data.name != "")
         {
            this._nameTxt.text = this.data.name;
         }
         this._nameTxt.selectable = this._nameTxt.mouseEnabled = this._nameTxt.mouseWheelEnabled = false;
         if(this._data.nameColor > 0)
         {
            this._nameTxt.setFrame(this._data.nameColor);
         }
         this._container.addChild(this._baseView);
         $.C("com.map.vehicle.data.VGlobal").logicWorld.nameLayer.addChild(this._nameTxt);
      }
    addEvent() {
         this._data.addEventListener("updateNode",$.bind(this, "__updateHandler"));
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("updateNode",$.bind(this, "__updateHandler"));
         }
      }
    __updateHandler(param1) {
      }
    loadResource() {
         var _loc1_ = $.C("yishi.manager.PathManager").solveMapPhysicsBySonType(this.data.sonType);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,8,$.bind(this, "__loaderCompleteHandler"));
      }
    __loaderCompleteHandler(param1, param2) {
         if(!this._model)
         {
            return;
         }
         this._mc = $.as(param2, $.C("flash.display.MovieClip"));
         if(!this._mc)
         {
            return;
         }
         this._container.addChildAt(this._mc,0);
         this._mc.mouseEnabled = this._mc.mouseChildren = false;
         this.x = this.x;
         this.y = this.y;
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc2_ = null;
         super.x = param1;
         if(this._mc && this._mc.pos)
         {
            _loc2_ = this._mc.pos;
            this._nameTxt.x = super.x + _loc2_.x - this._nameTxt.width / 2;
         }
      }
    set y(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc2_ = null;
         super.y = param1;
         if(this._mc && this._mc.pos)
         {
            _loc2_ = this._mc.pos;
            this._nameTxt.y = super.y + _loc2_.y - 15;
         }
      }
    update() {
         if(this._data && this._data.type == 1 && this._data.teamId != 0 && $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo != null)
         {
            this.container.visible = this._data.teamId == $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo.team;
         }
      }
    mouseClickEvent(param1) {
         var _loc3_ = null;
         var _loc2_ = false;
         if(param1 && param1.target == this._container)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = new ($.C("flash.geom.Point"))(this.x,this.y);
            if(this._data)
            {
               if(this._data.resetPosX != 0 && this._data.resetPosY != 0)
               {
                  _loc3_.x = this._data.resetPosX * 20;
                  _loc3_.y = this._data.resetPosY * 20;
               }
            }
            $.C("com.map.vehicle.data.VGlobal").logicWorld.moveMeToPos(_loc3_.x,_loc3_.y);
         }
         return _loc2_;
      }
    mouseMoveEvent(param1) {
         return false;
      }
    mouseOutEvent(param1) {
         if(this._mc)
         {
            $.C("com.map.vehicle.data.VGlobal").buildfilter.setNormalFilter(this._mc);
         }
         $.C("yishi.manager.CursorManagerII").instance.resetCursor();
         return true;
      }
    mouseOverEvent(param1) {
         if(this._mc)
         {
            $.C("com.map.vehicle.data.VGlobal").buildfilter.setLightFilter(this._mc);
            $.C("yishi.manager.CursorManagerII").instance.showCursorByType("COLLECT_CURSOR");
         }
         return true;
      }
    dispose() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "__loaderCompleteHandler"));
         if(this._mc)
         {
            this._mc.gotoAndStop(1);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mc);
         this._mc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         this.removeEvent();
         this._model = null;
         super.dispose();
      }
    get curResourceType() {
         return 8;
      }
    get x() { return super.x; }
    get y() { return super.y; }
    set curResourceType(v) { super.curResourceType = v; }
  }
  $.meta(__VehicleBoxView, "com.map.vehicle.objects.VehicleBoxView", []);
  return __VehicleBoxView;
}
deps["com.map.vehicle.objects.VehicleBoxView"] = ["com.map.vehicle.data.VGlobal", "com.map.vehicle.net.VehicleSocketManager", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.road.mapengine.bitmap.logic.BitmapSimpleLogic", "flash.display.MovieClip", "flash.geom.Point", "yishi.manager.CursorManagerII", "yishi.manager.PathManager"];

defs["com.map.vehicle.objects.VehicleNpcAvatarView"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapAvatarLogic");
  class __VehicleNpcAvatarView extends __Base {
    static $fields(self) {
    self._skillQueue = null;
    self._asynActionMgr = null;
    self._data = null;
    self._effectLayer = null;
    self._stuffView = null;
    self._showNamePosY = -125;
    self._defaultMovie = null;
    self._hurtNumLayer = null;
    self._delayTween = null;
    }
    constructor(param1, param2 = true) {
         super(param1,param2);
         this._walkTotalFrameX = 5;
         this._walkTotalFrameY = 4;
         this._standTotalFrameX = 4;
         this._standTotalFrameY = 2;
         this._attackTotalFrameX = 5;
         this._attackTotalFrameY = 4;
         this._skillQueue = new ($.C("yishi.manager.ActionQueueManager"))();
         this._asynActionMgr = new ($.C("com.map.vehicle.utils.AsynActionManager"))();
      }
    initView() {
         this._stuffView = new ($.C("com.map.vehicle.view.VehicleNpcBloodStuffView"))();
         this._effectLayer = new ($.C("com.map.vehicle.view.EffectsLayer"))();
         this._defaultMovie = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.avatar.DefaultAvatarMovieAsset");
         this._hurtNumLayer = new ($.C("flash.display.Sprite"))();
         this._hurtNumLayer.mouseChildren = this._hurtNumLayer.mouseEnabled = false;
         this._container.addChild(this._baseView);
         this.addChild(this._defaultMovie);
         this._container.addChild(this._effectLayer);
         $.C("com.map.vehicle.data.VGlobal").logicWorld.nameLayer.addChild(this._stuffView);
         $.C("com.map.vehicle.data.VGlobal").logicWorld.nameLayer.addChild(this._hurtNumLayer);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         this._data.logicView = this;
         this.initView();
         this._stuffView.data = this._data;
         this._effectLayer.data = this._data;
         this._effectLayer.tankBody = this._baseView;
         this.addEvent();
         this.loadResource();
      }
    addEvent() {
         if(this._data)
         {
            this._data.addEventListener("SKILL_CAST_OVER",$.bind(this, "__useSkillHandler"));
            this._data.addEventListener("SKILL_HURT",$.bind(this, "__skillHurtHandler"));
            this._data.addEventListener("BUFF_HURT",$.bind(this, "__buffHurtHandler"));
         }
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("SKILL_CAST_OVER",$.bind(this, "__useSkillHandler"));
            this._data.removeEventListener("SKILL_HURT",$.bind(this, "__skillHurtHandler"));
            this._data.removeEventListener("BUFF_HURT",$.bind(this, "__buffHurtHandler"));
         }
      }
    __useSkillHandler(param1) {
         var _loc2_ = param1.data;
         var _loc3_ = new ($.C("com.map.vehicle.action.ShootAction"))(this,_loc2_);
         this._skillQueue.addAction(_loc3_);
      }
    __skillHurtHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.HurtData"));
         var _loc3_ = new ($.C("com.map.vehicle.action.HurtNumberAction"))(this,_loc2_);
         this._asynActionMgr.addAction(_loc3_);
         if(_loc2_.skillId == 1 && $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo && _loc2_.shootId == $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo.playerId)
         {
            $.C("com.pickgliss.utils.SoundManager").instance.play("050");
         }
      }
    __buffHurtHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.HurtData"));
         var _loc3_ = new ($.C("com.map.vehicle.action.HurtNumberAction"))(this,_loc2_);
         this._asynActionMgr.addAction(_loc3_);
      }
    update() {
         if(this._skillQueue)
         {
            this._skillQueue.update();
         }
         if(this._asynActionMgr)
         {
            this._asynActionMgr.update();
         }
         super.update();
      }
    loadResource() {
         var _loc1_ = this.createLoaderInfo(String(this.data.sonType),"body",false);
         var _loc2_ = this.getResourcepath(String(this.data.sonType));
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc1_);
      }
    loaderResourceCall(param1, param2) {
         if(!this._skillQueue)
         {
            return;
         }
         if(this._defaultMovie)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._defaultMovie);
            this._defaultMovie = null;
         }
         super.loaderResourceCall(param1,param2);
         this.layout();
      }
    layout() {
         var _loc3_ = this.getResourcepath(String(this.data.sonType));
         var _loc2_ = $.C("com.pickgliss.loader.LoaderHeaderList").avatarShowNamePos[_loc3_];
         var _loc1_ = -160;
         if(_loc2_ && _loc2_.showNamePosY)
         {
            _loc1_ = $.int(_loc2_.showNamePosY);
         }
         this._stuffView.y = this.y + this._showNamePosY;
      }
    createLoaderInfo(param1, param2, param3) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc4_ = new ($.C("com.road.mapengine.bitmap.load.ResourceLoaderInfo"))();
         _loc4_.url = this.getResourcepath(param1);
         _loc4_.position = param2;
         _loc4_.resourceType = 5;
         _loc4_.queueLoader = param3;
         _loc4_.loaderType = 4;
         return _loc4_;
      }
    mouseClickEvent(param1) {
         var _loc3_ = 0;
         var _loc2_ = false;
         if(this._baseView)
         {
            _loc3_ = this._baseView.bitmapData.getPixel(this._baseView.mouseX,this._baseView.mouseY);
            if(_loc3_ > 50)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
    mouseMoveEvent(param1) {
         var _loc2_ = false;
         if(!this._baseView)
         {
            return false;
         }
         var _loc3_ = this._baseView.bitmapData.getPixel(this._baseView.mouseX,this._baseView.mouseY);
         if(_loc3_ > 50)
         {
            $.C("com.map.vehicle.data.VGlobal").buildfilter.setGlowFilter(this._baseView);
            _loc2_ = true;
         }
         else
         {
            this._baseView.filters = null;
         }
         return _loc2_;
      }
    mouseOutEvent(param1) {
         if(this._baseView)
         {
            this._baseView.filters = null;
         }
         return true;
      }
    getResourcepath(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return $.C("yishi.manager.PathManager").getVehicleNPCPath(param1);
      }
    get curResourceType() {
         return 5;
      }
    updateDepth() {
      }
    beAttacted(param1) {
      }
    bombFlyOut() {
      }
    changeDirectionTo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = param1 - this.x;
         var _loc4_ = param2 - this.y;
         var _loc5_ = Math.atan2(_loc4_,_loc3_);
         var _loc6_ = _loc5_ * 180 / 3.141592653589793;
         if(_loc6_ < 0)
         {
            _loc6_ += 360;
         }
         this.angle = _loc6_;
         if(this._delayTween)
         {
            this._delayTween.kill();
            this._delayTween = null;
         }
         this.state = 2;
         this._delayTween = $.C("com.greensock.TweenMax").delayedCall(0.7,$.bind(this, "attackOver"));
      }
    attackOver() {
         if(this._delayTween)
         {
            this._delayTween.kill();
            this._delayTween = null;
         }
         this.state = 3;
      }
    getShootPoint() {
         return new ($.C("flash.geom.Point"))(this.x,this.y - 80);
      }
    playBombSmoke(param1) {
      }
    select(param1) {
         if(param1)
         {
            this.addChildAt(param1,0);
            param1.y = 0;
         }
      }
    get isDie() {
         return this._data.hp <= 0;
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.x = param1;
         if(this._stuffView)
         {
            this._stuffView.x = super.x;
         }
         if(this._hurtNumLayer)
         {
            this._hurtNumLayer.x = this.x;
         }
      }
    set y(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.y = param1;
         if(this._stuffView)
         {
            this._stuffView.y = super.y + this._showNamePosY;
         }
         if(this._hurtNumLayer)
         {
            this._hurtNumLayer.y = this.y;
         }
      }
    set sizeType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         super.sizeType = param1;
         this._showNamePosY = -125;
      }
    addHurtMovie(param1) {
         if(this._hurtNumLayer)
         {
            this._hurtNumLayer.addChild(param1);
         }
         else
         {
            this.addChild(param1);
         }
      }
    dispose() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "loaderResourceCall"));
         this.removeEvent();
         if(this._skillQueue)
         {
            this._skillQueue.dispose();
         }
         this._skillQueue = null;
         if(this._asynActionMgr)
         {
            this._asynActionMgr.dispose();
         }
         this._asynActionMgr = null;
         if(this._stuffView)
         {
            this._stuffView.dispose();
         }
         this._stuffView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._effectLayer);
         this._effectLayer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hurtNumLayer);
         this._hurtNumLayer = null;
         if(this._defaultMovie)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._defaultMovie);
            this._defaultMovie = null;
         }
         super.dispose();
      }
    set curResourceType(v) { super.curResourceType = v; }
    set isDie(v) { super.isDie = v; }
    get x() { return super.x; }
    get y() { return super.y; }
    get sizeType() { return super.sizeType; }
  }
  $.meta(__VehicleNpcAvatarView, "com.map.vehicle.objects.VehicleNpcAvatarView", ["ICaster"]);
  return __VehicleNpcAvatarView;
}
deps["com.map.vehicle.objects.VehicleNpcAvatarView"] = ["com.greensock.TweenMax", "com.map.vehicle.action.HurtNumberAction", "com.map.vehicle.action.ShootAction", "com.map.vehicle.data.HurtData", "com.map.vehicle.data.VGlobal", "com.map.vehicle.utils.AsynActionManager", "com.map.vehicle.view.EffectsLayer", "com.map.vehicle.view.VehicleNpcBloodStuffView", "com.pickgliss.loader.LoaderHeaderList", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "com.road.mapengine.bitmap.load.ResourceLoaderInfo", "com.road.mapengine.bitmap.logic.BitmapAvatarLogic", "flash.display.Sprite", "flash.geom.Point", "yishi.manager.ActionQueueManager", "yishi.manager.PathManager"];

defs["com.map.vehicle.objects.VehicleTrapView"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapSimpleLogic");
  class __VehicleTrapView extends __Base {
    static $fields(self) {
    self._data = null;
    self._mc = null;
    self._skillTemplate = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._createrId = 0;
    self._playerInfo = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
    }
    constructor(param1) {
         super(param1);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         this._skillTemplate = $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(1234);
         this._createrId = 1;
      }
    loadResource() {
         var _loc1_ = new ($.C("com.road.mapengine.bitmap.load.ResourceLoaderInfo"))();
         _loc1_.resourceType = 5;
         _loc1_.loaderType = 2;
         var _loc2_ = $.C("yishi.manager.PathManager").solveMapPhysicsBySonType(this.data.sonType);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,2,4,$.bind(this, "loaderResourceCall"),null,null,_loc1_);
      }
    loaderResourceCall(param1, param2) {
         if(!this._container)
         {
            return;
         }
         this._mc = $.as(param2, $.C("flash.display.MovieClip"));
         if(this._baseView && this._baseView.bitmapData)
         {
            this._baseView.bitmapData.dispose();
         }
         var _loc4_ = new ($.C("flash.display.BitmapData"))(this._mc.width,this._mc.height,true,0);
         this._baseView.bitmapData = _loc4_;
         var _loc3_ = this._mc.pos;
         this._mc.gotoAndStop(1);
      }
    update() {
         if(this._data && this._createrId == this._playerInfo.userId)
         {
         }
      }
    dispose() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "loaderResourceCall"));
         super.dispose();
      }
  }
  $.meta(__VehicleTrapView, "com.map.vehicle.objects.VehicleTrapView", []);
  return __VehicleTrapView;
}
deps["com.map.vehicle.objects.VehicleTrapView"] = ["com.map.vehicle.net.VehicleSocketManager", "com.pickgliss.loader.LoaderManagerII", "com.road.mapengine.bitmap.load.ResourceLoaderInfo", "com.road.mapengine.bitmap.logic.BitmapSimpleLogic", "flash.display.BitmapData", "flash.display.MovieClip", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager"];

defs["com.map.vehicle.utils.AsynActionManager"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __AsynActionManager extends __Base {
    static $fields(self) {
    self._pool = [];
    }
    constructor() {
         super();
      }
    update() {
         var _loc2_ = null;
         var _loc1_ = [];
         for (_loc2_ of $.values(this._pool))
         {
            if(_loc2_.finished)
            {
               _loc2_.dispose();
               _loc1_.push(_loc2_);
            }
            else
            {
               _loc2_.update();
            }
         }
         for (_loc2_ of $.values(_loc1_))
         {
            this._pool.splice(this._pool.indexOf(_loc2_),1);
         }
         _loc1_ = null;
      }
    addAction(param1) {
         if(!this._pool)
         {
            return;
         }
         param1.prepare();
         this._pool.push(param1);
      }
    dispose() {
         for (var _loc1_ of $.values(this._pool))
         {
            _loc1_.dispose();
         }
         this._pool = null;
      }
  }
  $.meta(__AsynActionManager, "com.map.vehicle.utils.AsynActionManager", []);
  return __AsynActionManager;
}
deps["com.map.vehicle.utils.AsynActionManager"] = ["flash.events.EventDispatcher"];

defs["com.map.vehicle.utils.VehicleMapHelper"] = function define($) {
  const __Base = $.Object;
  class __VehicleMapHelper extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__VehicleMapHelper, "com.map.vehicle.utils.VehicleMapHelper", []);
  return __VehicleMapHelper;
}
deps["com.map.vehicle.utils.VehicleMapHelper"] = [];

defs["com.map.vehicle.utils.VehicleUtil"] = function define($) {
  const __Base = $.Object;
  class __VehicleUtil extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static getSkillTemplate(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.C("yishi.manager.TempleteManager").instance.vehicleSkillTempteCate.getTemplateByTid(param1);
      }
    static getVehicleObjectTemplate(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.C("yishi.manager.TempleteManager").instance.vehicleObjectTempInfoCate.getTemplateByIndex(param1);
      }
    static getBuffTemplate(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.C("yishi.manager.TempleteManager").instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(param1);
      }
  }
  $.meta(__VehicleUtil, "com.map.vehicle.utils.VehicleUtil", []);
  return __VehicleUtil;
}
deps["com.map.vehicle.utils.VehicleUtil"] = ["yishi.manager.TempleteManager"];

defs["com.map.vehicle.utils.WalkRectScanUtils"] = function define($) {
  const __Base = $.Object;
  class __WalkRectScanUtils extends __Base {
    static $fields(self) {
    self._outWidth = 0;
    self._outHeight = 0;
    self._getWalkable = null;
    self._preStartPoint = new ($.C("flash.geom.Point"))();
    self._findPathCount = 0;
    }
    constructor() {
         super();
      }
    set getWalkable(param1) {
         this._getWalkable = param1;
      }
    dispose() {
         this._getWalkable = null;
         this._preStartPoint = null;
      }
    set outHeight(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._outHeight = param1;
      }
    set outWidth(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._outWidth = param1;
      }
    walkRectScan(param1, param2, param3) {
         var _loc4_ = null;
         if(this._preStartPoint.equals(param1))
         {
            this._findPathCount = this._findPathCount + 1;
         }
         else
         {
            this._preStartPoint = new ($.C("flash.geom.Point"))(param1.x,param1.y);
            this._findPathCount = this._findPathCount + 1;
         }
         var _loc5_ = 0;
         while(!_loc4_ && _loc5_ < this._outWidth)
         {
            _loc4_ = this.walkRectScanImp(_loc5_,param1,param2,param3);
            _loc5_++;
         }
         return _loc4_;
      }
    walkRectScanImp(param1, param2, param3, param4) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc12_ = 0;
         var _loc13_ = 0;
         var _loc9_ = 0;
         var _loc10_ = 0;
         var _loc8_ = new ($.C("flash.geom.Point"))(param2.x,param2.y);
         var _loc11_ = false;
         var _loc5_ = [];
         _loc9_ = -param1;
         while(_loc9_ <= param1)
         {
            _loc8_.x = param2.x;
            _loc8_.x += _loc9_ * 20;
            if(_loc9_ == -param1 || _loc9_ == param1)
            {
               _loc10_ = -param1;
               while(_loc10_ <= param1)
               {
                  _loc8_.y = param2.y;
                  _loc8_.y += _loc10_ * 20;
                  if(this.outRect(_loc8_.x / 20,_loc8_.y / 20))
                  {
                     _loc5_.push(new ($.C("flash.geom.Point"))(_loc8_.x,_loc8_.y));
                  }
                  _loc10_++;
               }
            }
            else
            {
               _loc8_.y = param2.y;
               _loc8_.y += param1 * 20;
               if(this.outRect(_loc8_.x / 20,_loc8_.y / 20))
               {
                  _loc5_.push(new ($.C("flash.geom.Point"))(_loc8_.x,_loc8_.y));
               }
               _loc8_.y = param2.y;
               _loc8_.y -= param1 * 20;
               if(this.outRect(_loc8_.x / 20,_loc8_.y / 20))
               {
                  _loc5_.push(new ($.C("flash.geom.Point"))(_loc8_.x,_loc8_.y));
               }
            }
            _loc9_++;
         }
         _loc8_.x = param2.x;
         _loc8_.y = param2.y;
         var _loc6_ = this.getMinDistance(_loc5_,param3);
         if(!_loc6_)
         {
            return _loc6_;
         }
         var _loc7_ = $.C("flash.geom.Point").distance(param4,_loc6_);
         if(_loc7_ > 14)
         {
            return _loc6_;
         }
         if(this._findPathCount % 2 != 0)
         {
            if(_loc5_.length < 3)
            {
               return null;
            }
            return this.getMaxDistance(_loc5_,param3);
         }
         return null;
      }
    getMinDistance(param1, param2) {
         if(!param1 || param1.length == 0)
         {
            return null;
         }
         var _loc4_ = param1[0];
         for (var _loc3_ of $.values(param1))
         {
            if($.C("flash.geom.Point").distance(_loc4_,param2) > $.C("flash.geom.Point").distance(param2,_loc3_))
            {
               _loc4_ = _loc3_;
            }
         }
         return _loc4_;
      }
    getMaxDistance(param1, param2) {
         if(!param1 || param1.length == 0)
         {
            return null;
         }
         var _loc4_ = param1[0];
         for (var _loc3_ of $.values(param1))
         {
            if($.C("flash.geom.Point").distance(_loc4_,param2) < $.C("flash.geom.Point").distance(param2,_loc3_))
            {
               _loc4_ = _loc3_;
            }
         }
         return _loc4_;
      }
    outRect(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(param1 > this._outWidth || param2 > this._outHeight || param1 < 0 || param2 < 0)
         {
            return false;
         }
         return this._getWalkable(param1,param2);
      }
    get getWalkable() { return super.getWalkable; }
    get outHeight() { return super.outHeight; }
    get outWidth() { return super.outWidth; }
  }
  $.meta(__WalkRectScanUtils, "com.map.vehicle.utils.WalkRectScanUtils", ["Disposeable"]);
  return __WalkRectScanUtils;
}
deps["com.map.vehicle.utils.WalkRectScanUtils"] = ["flash.geom.Point"];

defs["com.map.vehicle.view.EffectsLayer"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __EffectsLayer extends __Base {
    static $fields(self) {
    self.posA = -160;
    self._data = null;
    self._buffA = null;
    self._buffB = null;
    self._tweenA = null;
    self._tweenB = null;
    self._tankBody = null;
    self._buffBIds = 0;
    self._colorDatas = {
         "normal":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":0,
            "bo":0,
            "ao":0
         },
         "slow":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":42,
            "bo":57,
            "ao":0
         },
         "poisoning":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":51,
            "bo":0,
            "ao":0
         }
      };
    }
    constructor() {
         super();
         this.mouseChildren = this.mouseEnabled = false;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this.removeEvent();
         this._data = param1;
         this.initView();
         this.addEvent();
      }
    initView() {
         this.drawBuffEffect();
         var _loc1_ = this._data["buffList"];
         if(_loc1_)
         {
            for (var _loc2_ of $.values(_loc1_))
            {
               this.addBuff(_loc2_);
            }
         }
      }
    addEvent() {
         if(this._data)
         {
            this._data.addEventListener("ADD_BUFF",$.bind(this, "__addBuffHandler"));
            this._data.addEventListener("REMOVE_BUFF",$.bind(this, "__removeBuffHandler"));
            this._data.addEventListener("CLEAR_BUFF",$.bind(this, "__clearBuffHandler"));
         }
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("ADD_BUFF",$.bind(this, "__addBuffHandler"));
            this._data.removeEventListener("REMOVE_BUFF",$.bind(this, "__removeBuffHandler"));
            this._data.removeEventListener("CLEAR_BUFF",$.bind(this, "__clearBuffHandler"));
         }
      }
    __addBuffHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.VehicleBufferDamageInfo"));
         this.addBuff(_loc2_);
      }
    addBuff(param1) {
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc2_ = param1.buffId;
         var _loc4_ = $.C("com.map.vehicle.utils.VehicleUtil").getBuffTemplate(_loc2_);
         this.drawBuffEffect(_loc4_);
         if(_loc4_ && _loc4_.LastEffect)
         {
            if(_loc4_.Duration <= 0)
            {
               _loc5_ = $.C("com.map.vehicle.SkillEffectFactory").instance.createBuffEffect(_loc2_);
               if(_loc5_)
               {
                  this.addChild(new ($.C("yishi.view.tools.SimpleMovie"))(_loc5_));
               }
            }
            else if($.C("com.pickgliss.utils.StringUtils").endsWith(_loc4_.LastEffect,"_a"))
            {
               this.clearTweenA();
               this.clearBuff(this._buffA);
               this._buffA = $.C("com.map.vehicle.SkillEffectFactory").instance.createBuffEffect(_loc2_);
               if(this._buffA)
               {
                  this.addChild(this._buffA);
                  this.setEffectY(this._buffA);
                  this._tweenA = $.C("com.greensock.TweenMax").delayedCall(param1.leftTime,$.bind(this, "clearBuff"),[this._buffA]);
               }
            }
            else if($.C("com.pickgliss.utils.StringUtils").endsWith(_loc4_.LastEffect,"_b"))
            {
               this.clearTweenB();
               this.clearBuff(this._buffB);
               this._buffB = $.C("com.map.vehicle.SkillEffectFactory").instance.createBuffEffect(_loc2_);
               if(this._buffB)
               {
                  this._buffBIds = param1.id;
                  this.addChild(this._buffB);
                  this._tweenB = $.C("com.greensock.TweenMax").delayedCall(param1.leftTime,$.bind(this, "clearBuff"),[this._buffB]);
               }
            }
         }
      }
    drawBuffEffect(param1 = null) {
         if(!this.tankBody)
         {
            return;
         }
         var _loc2_ = new ($.C("flash.geom.ColorTransform"))();
         if(!param1)
         {
            this.checkColor(_loc2_,"normal");
         }
         else if(param1.EffectType == $.C("com.map.vehicle.data.VehicleSkillEffectType").SPEED_CHANGE && (param1.EffectPercent < 0 || param1.EffectValue < 0))
         {
            this.checkColor(_loc2_,"slow");
         }
         else if(param1.EffectType == $.C("com.map.vehicle.data.VehicleSkillEffectType").HP_CHANGE && param1.Duration > 0)
         {
            this.checkColor(_loc2_,"poisoning");
         }
         this.tankBody.transform.colorTransform = _loc2_;
      }
    checkColor(param1, param2) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         param1.redMultiplier = this._colorDatas[param2].rm;
         param1.greenMultiplier = this._colorDatas[param2].gm;
         param1.blueMultiplier = this._colorDatas[param2].bm;
         param1.alphaMultiplier = this._colorDatas[param2].am;
         param1.redOffset = this._colorDatas[param2].ro;
         param1.greenOffset = this._colorDatas[param2].go;
         param1.blueOffset = this._colorDatas[param2].bo;
         param1.alphaOffset = this._colorDatas[param2].ao;
      }
    clearTweenA() {
         if(this._tweenA)
         {
            this._tweenA.kill();
            this._tweenA = null;
         }
      }
    clearTweenB() {
         if(this._tweenB)
         {
            this._tweenB.kill();
            this._tweenB = null;
         }
      }
    clearBuff(param1) {
         if(param1)
         {
            param1.gotoAndStop(1);
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
               param1 = null;
            }
         }
         this._buffBIds = 0;
      }
    __removeBuffHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.VehicleBufferDamageInfo"));
         if(_loc2_ && _loc2_.id == this._buffBIds)
         {
            this.clearTweenB();
            this.clearBuff(this._buffB);
            this._buffB = null;
         }
         this.drawBuffEffect();
         var _loc3_ = this._data["buffList"];
         if(_loc3_)
         {
            for (var _loc4_ of $.values(_loc3_))
            {
               this.addBuff(_loc4_);
            }
         }
      }
    __clearBuffHandler(param1) {
         this.clearTweenA();
         this.clearTweenB();
         this.clearBuff(this._buffA);
         this.clearBuff(this._buffB);
         this._buffA = null;
         this._buffB = null;
         this.drawBuffEffect();
      }
    setEffectY(param1) {
         var _loc3_ = this.posA;
         param1.gotoAndStop(1);
         var _loc4_ = new ($.C("flash.display.BitmapData"))($.int(param1.width / 2),$.int(param1.height / 2),true,0);
         _loc4_.draw(param1);
         var _loc2_ = _loc4_.getColorBoundsRect(4294967295,0,false);
         _loc3_ = _loc3_ - _loc2_.height - 5;
         _loc4_.dispose();
         param1.play();
         param1.y = _loc3_;
      }
    dispose() {
         this.clearTweenA();
         this.clearTweenB();
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         this._data = null;
         this._buffA = null;
         this._buffB = null;
      }
    get tankBody() {
         return this._tankBody;
      }
    set tankBody(param1) {
         this._tankBody = param1;
         if(!this._data)
         {
            return;
         }
         var _loc2_ = this._data["buffList"];
         if(_loc2_)
         {
            this.drawBuffEffect();
            for (var _loc3_ of $.values(_loc2_))
            {
               this.addBuff(_loc3_);
            }
         }
      }
  }
  $.meta(__EffectsLayer, "com.map.vehicle.view.EffectsLayer", []);
  return __EffectsLayer;
}
deps["com.map.vehicle.view.EffectsLayer"] = ["com.greensock.TweenMax", "com.map.vehicle.SkillEffectFactory", "com.map.vehicle.data.VehicleBufferDamageInfo", "com.map.vehicle.data.VehicleSkillEffectType", "com.map.vehicle.utils.VehicleUtil", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.StringUtils", "flash.display.BitmapData", "flash.geom.ColorTransform", "yishi.view.tools.SimpleMovie"];

defs["com.map.vehicle.view.VehicleAccountBottomView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleAccountBottomView extends __Base {
    static $fields(self) {
    self._back = null;
    self._bg = null;
    self._award1 = null;
    self._award2 = null;
    self._icon1 = null;
    self._icon2 = null;
    self._numberAsset = null;
    self._symbolBit1 = null;
    self._symbolBit2 = null;
    self._symbolBit3 = null;
    self._value1 = null;
    self._value2 = null;
    self._value3 = null;
    self._templateId1 = 2060067;
    self._templateId3 = 3020010;
    self._numStr = "0123456789.";
    self._spline = null;
    self._giftBox = null;
    self._vehicleInfo = null;
    }
    constructor(param1) {
         $.pre(new.target, (__s) => {
         __s._vehicleInfo = param1;
         });
         super();
         $.preFlush(this, new.target);
         $.C("yishi.utils.NumberViewUtils").getNumberView(param1.reward1,this._value1,this._numberAsset,20,23,13,20,this._numStr,1);
         $.C("yishi.utils.NumberViewUtils").getNumberView(param1.reward2,this._value2,this._numberAsset,20,23,13,20,this._numStr,1);
         $.C("yishi.utils.NumberViewUtils").getNumberView(param1.reward3,this._value3,this._numberAsset,20,23,13,20,this._numStr,1);
      }
    dispose() {
         if(this._numberAsset)
         {
            this._numberAsset.dispose();
            this._numberAsset = null;
         }
         super.dispose();
      }
    init() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.SortListBg");
         this._back.height = 81;
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.sortBg");
         this._bg.x = 4;
         this._bg.y = 5;
         this._award1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.Image1");
         this._award2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.Image2");
         this._icon1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.Image5");
         this._icon2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.Image4");
         this._giftBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.giftBoxImg");
         this._giftBox.setFrame(1);
         this._award1.x = 20;
         this._award1.y = -6;
         this._award2.x = 300;
         this._award2.y = -6;
         this._symbolBit1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         this._symbolBit2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         this._symbolBit3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         this._symbolBit1.x = 67;
         this._symbolBit1.y = 40;
         this._symbolBit2.x = 213;
         this._symbolBit2.y = 40;
         this._symbolBit3.x = 347;
         this._symbolBit3.y = 40;
         this._numberAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("worldboss.river.NumberAsset");
         this._value1 = new ($.C("flash.display.Sprite"))();
         this._value2 = new ($.C("flash.display.Sprite"))();
         this._value3 = new ($.C("flash.display.Sprite"))();
         this._value1.x = 82;
         this._value1.y = 38;
         this._value2.x = 227;
         this._value2.y = 38;
         this._value3.x = 363;
         this._value3.y = 38;
         this._spline = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.AccountViewSpline");
         this._spline.x = 280;
         this._spline.y = 5;
         this.addChild(this._back);
         this.addChild(this._bg);
         this.addChild(this._award1);
         this.addChild(this._award2);
         this.addChild(this._icon1);
         this.addChild(this._icon2);
         this.addChild(this._giftBox);
         this.addChild(this._symbolBit1);
         this.addChild(this._symbolBit2);
         this.addChild(this._symbolBit3);
         this.addChild(this._value1);
         this.addChild(this._value2);
         this.addChild(this._value3);
         this.addChild(this._spline);
         this._giftBox.setFrame(this.getRunking);
         if(this._vehicleInfo.isWin)
         {
            this._icon1.tipData = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.chest.success");
         }
         else
         {
            this._icon1.tipData = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.chest.fail");
         }
         this._icon2.tipData = $.C("manager.LanguageMgr").GetTranslation("vehicle.scoreTip2");
         this._giftBox.tipData = this.runkingTipText;
      }
    get runkingTipText() {
         var _loc1_ = null;
         switch(this.getRunking - 1)
         {
            case 0:
               _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.giftBox1");
               break;
            case 1:
               _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.giftBox2");
               break;
            case 2:
               _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.giftBox3");
               break;
            case 3:
               _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.giftBox4");
               break;
            case 4:
               _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.giftBox5");
               break;
            case 5:
            case 6:
            case 7:
               _loc1_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.AccountBottomView.rune");
         }
         return _loc1_;
      }
    get getRunking() {
         var _loc4_ = null;
         var _loc1_ = 0;
         var _loc2_ = 0;
         var _loc3_ = this._vehicleInfo.playerList;
         _loc3_.sortOn("score",0x10 | 2);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = $.as(_loc3_[_loc2_], $.C("com.map.vehicle.data.PlayerVehicleInfo"));
            if(this.playerSelfId == _loc4_.playerId)
            {
               if(_loc4_.score < 200)
               {
                  _loc1_ = 8;
                  break;
               }
               _loc1_ = _loc2_ + 1;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
    get playerSelfId() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.userInfo.userId;
      }
    set runkingTipText(v) { super.runkingTipText = v; }
    set getRunking(v) { super.getRunking = v; }
    set playerSelfId(v) { super.playerSelfId = v; }
  }
  $.meta(__VehicleAccountBottomView, "com.map.vehicle.view.VehicleAccountBottomView", []);
  $.statics(__VehicleAccountBottomView, () => {
    __VehicleAccountBottomView.MINRANK = 200;
  });
  return __VehicleAccountBottomView;
}
deps["com.map.vehicle.view.VehicleAccountBottomView"] = ["com.map.vehicle.data.PlayerVehicleInfo", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.PlayerManager", "yishi.utils.NumberViewUtils"];

defs["com.map.vehicle.view.VehicleAccountFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __VehicleAccountFrame extends __Base {
    static $fields(self) {
    self._topView = null;
    self._downView = null;
    self._info = null;
    }
    constructor() {
         super();
         this.addEvent();
      }
    initView() {
         this._topView = new ($.C("com.map.vehicle.view.VehicleAccountTopView"))(this._info);
         this._downView = new ($.C("com.map.vehicle.view.VehicleAccountBottomView"))(this._info);
         this._topView.x = -3;
         this._topView.y = 8;
         this._downView.x = -3;
         this._downView.y = 300;
         this.addToContent(this._topView);
         this.addToContent(this._downView);
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("vehicle.sortTitle");
      }
    uintView() {
         if(this._topView)
         {
            this._topView.dispose();
         }
         if(this._downView)
         {
            this._downView.dispose();
         }
         this._topView = null;
         this._downView = null;
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
      }
    show(param1) {
         if(this.isDie)
         {
            return;
         }
         this._info = param1;
         this.initView();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,2);
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
    dispose() {
         this.removeEvent();
         this.uintView();
         super.dispose();
         this._info = null;
      }
    set groups(v) { super.groups = v; }
  }
  $.meta(__VehicleAccountFrame, "com.map.vehicle.view.VehicleAccountFrame", []);
  return __VehicleAccountFrame;
}
deps["com.map.vehicle.view.VehicleAccountFrame"] = ["com.map.vehicle.view.VehicleAccountBottomView", "com.map.vehicle.view.VehicleAccountTopView", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "manager.LanguageMgr"];

defs["com.map.vehicle.view.VehicleAccountItemView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleAccountItemView extends __Base {
    static $fields(self) {
    self._sortIndexTxt = null;
    self._nickNameTxt = null;
    self._scoreTxt = null;
    self._flag = null;
    self._data = null;
    self._index = 0;
    self._info = null;
    self._menu = null;
    }
    constructor(param1, param2) {
         $.pre(new.target, (__s) => {
         __s._index = param1;
         __s._info = param2;
         __s.height = 32;
         });
         super();
         $.preFlush(this, new.target);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this.removeEvent();
         this._data = param1;
         if(this._data)
         {
            this._sortIndexTxt.text = String(this._index);
            this._scoreTxt.text = String(this._data.score);
            this._flag.visible = true;
            this._flag.setFrame(this._data.team);
            if(this._data.team == this._info.myTeamId)
            {
               this._nickNameTxt.setFrame(1);
            }
            else
            {
               this._nickNameTxt.setFrame(2);
            }
            this._nickNameTxt.htmlText = "<a href =\'event: \'><u> " + this._data.name + " </u></a>";
            this._nickNameTxt.mouseEnabled = true;
            this.addEvent();
         }
         else
         {
            this._sortIndexTxt.text = "";
            this._nickNameTxt.text = "";
            this._scoreTxt.text = "";
            this._flag.visible = false;
         }
      }
    addEvent() {
         this._nickNameTxt.addEventListener("link",$.bind(this, "__onLinkHandler"));
      }
    removeEvent() {
         this._nickNameTxt.removeEventListener("link",$.bind(this, "__onLinkHandler"));
      }
    __onLinkHandler(param1) {
         if(this._menu)
         {
            this._menu.dispose();
         }
         this._menu = null;
         if(!this._data)
         {
            return;
         }
         var _loc2_ = false;
         this._menu = new ($.C("chat.view.ChatItemMenu"))(this._data.name,this._data.playerId,_loc2_);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._menu,7);
         this._menu.x = $.C("com.pickgliss.toplevel.StageReferance").stage.mouseX;
         this._menu.y = $.C("com.pickgliss.toplevel.StageReferance").stage.mouseY + 7;
      }
    dispose() {
         this.removeEvent();
         if(this._menu)
         {
            this._menu.dispose();
         }
         this._menu = null;
         super.dispose();
      }
    init() {
         this._sortIndexTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.sortitem.IndexTxt");
         this._nickNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("pvpmap.sortitem.NickNameTxt");
         this._nickNameTxt.x = 106;
         this._nickNameTxt.y = 6;
         this._scoreTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.sortitem.ScoreTxt");
         this._flag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.teamFlag");
         this._flag.x = 82;
         this._flag.y = 2;
         this.addChild(this._sortIndexTxt);
         this.addChild(this._flag);
         this.addChild(this._nickNameTxt);
         this.addChild(this._scoreTxt);
      }
  }
  $.meta(__VehicleAccountItemView, "com.map.vehicle.view.VehicleAccountItemView", []);
  return __VehicleAccountItemView;
}
deps["com.map.vehicle.view.VehicleAccountItemView"] = ["chat.view.ChatItemMenu", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component"];

defs["com.map.vehicle.view.VehicleAccountTopView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleAccountTopView extends __Base {
    static $fields(self) {
    self._back = null;
    self._title = null;
    self._scrollPanel = null;
    self._vBox = null;
    self._bg = null;
    self._failedFlg = null;
    self._victoryFlg = null;
    self._itemList = [];
    self._data = null;
    }
    constructor(param1) {
         var _loc3_ = 0;
         var _loc2_ = null;
         $.pre(new.target, (__s) => {
         __s._data = param1;
         });
         super();
         $.preFlush(this, new.target);
         var _loc4_ = param1.playerList;
         _loc4_.sortOn("score",0x10 | 2);
         _loc3_ = 0;
         while(_loc3_ < this._itemList.length)
         {
            _loc2_ = this._itemList[_loc3_];
            _loc2_.data = _loc4_[_loc3_];
            _loc3_++;
         }
         if(param1.isWin)
         {
            this._victoryFlg.visible = true;
            this._failedFlg.visible = false;
         }
         else
         {
            this._failedFlg.visible = true;
            this._victoryFlg.visible = false;
         }
      }
    init() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.AccountTopBack");
         this._back.x = 2;
         this._back.y = 2;
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.SortListBg");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.SortListTitle");
         this.addChild(this._bg);
         this.addChild(this._back);
         this.addChild(this._title);
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.sortlist.ScrollPanel");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("pvpmap.sortlist.Vbox");
         this._vBox.spacing = 4;
         this.addChild(this._scrollPanel);
         this._scrollPanel.setView(this._vBox);
         this._scrollPanel.x = -3;
         this._scrollPanel.y = 36;
         this._failedFlg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.FailedBitmapAsset");
         this._victoryFlg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.VictoryBitmapAsset");
         this.addChild(this._failedFlg);
         this.addChild(this._victoryFlg);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ($.C("com.map.vehicle.view.VehicleAccountItemView"))(_loc2_ + 1,this._data);
            this._itemList.push(_loc1_);
            this._vBox.addChild(_loc1_);
            _loc2_++;
         }
      }
    dispose() {
         this._back = null;
         this._itemList = null;
         this._data = null;
         super.dispose();
      }
  }
  $.meta(__VehicleAccountTopView, "com.map.vehicle.view.VehicleAccountTopView", []);
  return __VehicleAccountTopView;
}
deps["com.map.vehicle.view.VehicleAccountTopView"] = ["com.map.vehicle.view.VehicleAccountItemView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component"];

defs["com.map.vehicle.view.VehicleBloodStuffView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleBloodStuffView extends __Base {
    static $fields(self) {
    self._npcNameTxt = null;
    self._consortNameTxt = null;
    self._vipIcon = null;
    self._honerTxt = null;
    self._honerView = null;
    self._data = null;
    self._appellId = 0;
    self._vocationIcon = null;
    self._mc = null;
    self._bloodMask = null;
    self._teamBlood = null;
    self._tween = null;
    self.lastPosY = 0;
    }
    constructor() {
         super();
         this.initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
    initView() {
         this._npcNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.NpcNameText");
         this._consortNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("map.campaign.ConsortiaText");
         this._vipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.vipIcon");
         this._vipIcon.visible = false;
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("army.VocationIcon");
         this._vocationIcon.visible = false;
         this._mc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.HeroBloodBar");
         this.addChild(this._mc);
         this.addChild(this._vipIcon);
         this.addChild(this._npcNameTxt);
         this.addChild(this._consortNameTxt);
         this.addChild(this._vocationIcon);
         this._mc.gotoAndStop(1);
         this._bloodMask = $.as(this._mc["bloodMask"], $.C("flash.display.MovieClip"));
         this._teamBlood = $.as(this._mc["teamBlood"], $.C("flash.display.MovieClip"));
         this._bloodMask.gotoAndStop(100);
         this._teamBlood.gotoAndStop(1);
      }
    updateHoner() {
         if(this._honerView)
         {
            this._honerView.draw();
         }
      }
    get isHoner() {
         if($.C("yishi.datas.VersionSwitch").APPELL)
         {
            return this._data.appellId != 0;
         }
         return false;
      }
    get honerName() {
         if($.C("yishi.datas.VersionSwitch").APPELL && this.data.appellTemplate)
         {
            return this.data.appellTemplate.Title;
         }
         return "";
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get honerStyle() {
         if(this.data && $.C("yishi.datas.VersionSwitch").APPELL && this.data.appellTemplate)
         {
            return "map.campaign.HonerText" + this.data.appellTemplate.Quality;
         }
         return "map.campaign.HonerText";
      }
    isFriend() {
         if($.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo && this._data)
         {
            return this._data.team == $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo.team;
         }
         return false;
      }
    refreshVocation() {
         if(this._data && this._data.vocationGrades > 0)
         {
            this._vocationIcon.setFrame(this._data.vocationLevel);
            this._vocationIcon.visible = true;
         }
         else
         {
            this._vocationIcon.visible = false;
         }
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         if(!this._data)
         {
            return;
         }
         if($.C("com.map.vehicle.data.VGlobal").model.isFriend(this._data.team))
         {
            this._teamBlood.gotoAndStop(1);
         }
         else
         {
            this._teamBlood.gotoAndStop(2);
         }
         this.update();
         this.initBlood();
         this.switchBloodBar();
         this.addEvent();
      }
    switchBloodBar() {
         this._mc.visible = this.data.hp > 0;
      }
    initBlood() {
         var _loc1_ = this.data.hp * 100 / this.data.totalHp;
         this._bloodMask.gotoAndStop(_loc1_);
      }
    addEvent() {
         this._data.addEventListener("HP_CUT",$.bind(this, "__cutHpHandler"));
         this._data.addEventListener("HP_ADD",$.bind(this, "__addHpHandler"));
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("HP_CUT",$.bind(this, "__cutHpHandler"));
            this._data.removeEventListener("HP_ADD",$.bind(this, "__addHpHandler"));
         }
      }
    __cutHpHandler(param1) {
         var _loc2_ = this.data.hp * 100 / this.data.totalHp;
         if(_loc2_ != this._bloodMask.currentFrame)
         {
            this.killTweens();
            this._tween = $.C("com.greensock.TweenMax").to(this._bloodMask,0.7,{
               "delay":0.3,
               "frame":_loc2_,
               "onComplete":$.bind(this, "killTweens")
            });
         }
         this.switchBloodBar();
      }
    __addHpHandler(param1) {
         var _loc2_ = this.data.hp * 100 / this.data.totalHp;
         this.killTweens();
         this._bloodMask.gotoAndStop(_loc2_);
         this.switchBloodBar();
      }
    update() {
         this.showNameInfo();
      }
    showNameInfo() {
         var _loc3_ = NaN;
         var _loc2_ = NaN;
         var _loc4_ = -15;
         this._mc.y = _loc4_;
         this._npcNameTxt.y = _loc4_ - 15;
         this._consortNameTxt.y = this._npcNameTxt.y - 20;
         this._vipIcon.y = this._npcNameTxt.y;
         this._data.vipType == 2 ? this._vipIcon.setFrame(1) : this._vipIcon.setFrame(2);
         this._npcNameTxt.text = this.data.name;
         var _loc1_ = this.isFriend() ? 1 : 5;
         this._npcNameTxt.setFrame(_loc1_);
         this.setHonerName();
         if(this.data.consortiaName)
         {
            this._consortNameTxt.text = $.C("yishi.utils.StringHelper").format("<{0}>",this.data.consortiaName);
            if(this._honerTxt)
            {
               this._honerTxt.y = this._consortNameTxt.y - 20;
            }
            if(this._honerView)
            {
               this._honerView.y = this._consortNameTxt.y - this._data.appellTemplate.ImgHeight;
            }
         }
         else
         {
            this._consortNameTxt.text = "";
            if(this._honerTxt)
            {
               this._honerTxt.y = this._npcNameTxt.y - 20;
            }
            if(this._honerView)
            {
               this._honerView.y = this._npcNameTxt.y - this._data.appellTemplate.ImgHeight;
            }
         }
         if(this._data.isVip)
         {
            this._vipIcon.visible = true;
            _loc3_ = this._vipIcon.width + this._npcNameTxt.textWidth + 10;
            _loc2_ = this._npcNameTxt.width - this._npcNameTxt.textWidth >> 1;
            this._vipIcon.x = -_loc3_ >> 1;
            this._npcNameTxt.x = this._vipIcon.x + this._vipIcon.width - _loc2_ + 1;
         }
         else
         {
            this._vipIcon.visible = false;
            this._npcNameTxt.x = -(this._npcNameTxt.width >> 1);
         }
         if(this._consortNameTxt)
         {
            this._consortNameTxt.x = -(this._consortNameTxt.width >> 1);
         }
         if(this._honerTxt)
         {
            this._honerTxt.x = -(this._honerTxt.width >> 1);
         }
         if(this._honerView)
         {
            this._honerView.x = -(this._honerView.appellWidth >> 1);
         }
         if(this._vocationIcon != null)
         {
            if(this._vipIcon && this._vipIcon.visible)
            {
               this._vocationIcon.y = this._vipIcon.y - 4;
               this._vocationIcon.x = this._vipIcon.x - this._vocationIcon.width;
            }
            else
            {
               this._vocationIcon.y = this._npcNameTxt.y - 4;
               this._vocationIcon.x = this._npcNameTxt.x - this._vocationIcon.width;
            }
         }
         this.refreshVocation();
      }
    setHonerName() {
         if(this._appellId == this._data.appellId && (this._honerView && this._honerView.parent || this._honerTxt && this._honerTxt.parent))
         {
            return;
         }
         this._appellId = this._data.appellId;
         if(this._honerTxt && this._honerTxt.parent)
         {
            this._honerTxt.parent.removeChild(this._honerTxt);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._honerTxt);
         this._honerTxt = null;
         if(this._honerView && this._honerView.parent)
         {
            this._honerView.parent.removeChild(this._honerView);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._honerView);
         this._honerView = null;
         if(this.isHoner)
         {
            this._honerTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(this.honerStyle);
            this._honerTxt.text = this.honerName;
            this._honerView = new ($.C("avatar.view.AppellView"))(this._data.appellTemplate);
            this.showHoner();
         }
      }
    showHoner() {
         if($.C("yishi.datas.VersionSwitch").APPELL)
         {
            if(this._honerTxt && this._honerTxt.parent)
            {
               this._honerTxt.parent.removeChild(this._honerTxt);
            }
            if(this._honerView)
            {
               this.addChild(this._honerView);
            }
         }
         else
         {
            if(this._honerTxt)
            {
               this.addChild(this._honerTxt);
            }
            if(this._honerView && this._honerView.parent)
            {
               this._honerView.parent.removeChild(this._honerView);
            }
         }
      }
    getHonerHeight() {
         if($.C("yishi.datas.VersionSwitch").APPELL)
         {
            if(this._honerView)
            {
               return this._honerView.appellHeight;
            }
            return 0;
         }
         if(this._honerTxt)
         {
            return this._honerTxt.textField.textHeight;
         }
         return 0;
      }
    killTweens() {
         if(this._tween)
         {
            this._tween.kill();
            this._tween = null;
         }
      }
    getTextHeight() {
         var _loc1_ = 0;
         _loc1_ += this._mc.height;
         _loc1_ += this._npcNameTxt.textHeight;
         _loc1_ += this._consortNameTxt.textHeight;
         _loc1_ += this.getHonerHeight();
         return _loc1_ - 15;
      }
    dispose() {
         this.killTweens();
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._honerTxt);
         this._honerTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._honerView);
         this._honerView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vocationIcon);
         this._vocationIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
    set isHoner(v) { super.isHoner = v; }
    set honerName(v) { super.honerName = v; }
    set thane(v) { super.thane = v; }
    set honerStyle(v) { super.honerStyle = v; }
  }
  $.meta(__VehicleBloodStuffView, "com.map.vehicle.view.VehicleBloodStuffView", []);
  return __VehicleBloodStuffView;
}
deps["com.map.vehicle.view.VehicleBloodStuffView"] = ["avatar.view.AppellView", "com.greensock.TweenMax", "com.map.vehicle.data.VGlobal", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "yishi.datas.VersionSwitch", "yishi.manager.ArmyManager", "yishi.utils.StringHelper"];

defs["com.map.vehicle.view.VehicleBossDownTimeView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleBossDownTimeView extends __Base {
    static $fields(self) {
    self._back = null;
    self._text = null;
    self._valueTxt = null;
    self._model = null;
    self._bossTime = 0;
    self._skillTime = 0;
    self._riverTime = 0;
    self._currentTime = 0;
    self._riverTimeConst = 30;
    self._last = 0;
    }
    constructor() {
         super();
         this._model = $.C("com.map.vehicle.data.VGlobal").model;
         this._riverTimeConst = this._model.riverTimeConst;
         this._currentTime = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.nowDate - this._model.campaiganStartTime.time;
         this.initView();
         this.addEvent();
         this.updateTime(2000);
         this._last = $.C("flash.utils.getTimer")();
         this.mouseEnabled = this.mouseChildren = false;
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("VehicleBossDownTimeView.back");
         this._text = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("VehicleBossDownTimeView.downTimeTxt");
         this._valueTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("VehicleBossDownTimeView.downTimeTxt");
         this._valueTxt.x = 170;
         this._valueTxt.y = 8;
         this.addChild(this._back);
         this.addChild(this._text);
         this.addChild(this._valueTxt);
         this._text.htmlText = $.C("manager.LanguageMgr").GetTranslation("vehicle.bossDownTime");
         this._valueTxt.htmlText = "--:--:--<br/>--:--:--<br/>--:--:--";
      }
    enterFrame() {
         var _loc2_ = $.C("flash.utils.getTimer")();
         var _loc1_ = _loc2_ - this._last;
         if(_loc1_ >= 1000)
         {
            this.updateTime(_loc1_);
            this._last = _loc2_;
         }
      }
    addEvent() {
         this._model.addEventListener("CAMPAIGN_TIME",$.bind(this, "__startCountHandler"));
      }
    removeEvent() {
         if(this._model)
         {
            this._model.removeEventListener("CAMPAIGN_TIME",$.bind(this, "__startCountHandler"));
         }
      }
    __startCountHandler(param1) {
         this._currentTime = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.nowDate - this._model.campaiganStartTime.time;
      }
    updateTime(param1 = 1000) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc3_ = null;
         var _loc4_ = null;
         this._currentTime += param1;
         var _loc2_ = Math.ceil(this._currentTime / 1000);
         this._bossTime = 300 - _loc2_;
         this._skillTime = 180 - _loc2_ % 180;
         this._riverTime = this._riverTimeConst - _loc2_ % this._riverTimeConst;
         if(this._bossTime <= 0 || this._model.bossRefreshed)
         {
            this._bossTime = 0;
            _loc3_ = "--:--:--";
         }
         else
         {
            _loc3_ = $.C("yishi.utils.DateFormatter").getCountDate(this._bossTime);
         }
         if(this._skillTime <= 0)
         {
            this._skillTime = 180;
         }
         if(this._riverTime <= 0)
         {
            this._riverTime = this._model.riverTimeConst;
         }
         if(this._model.remainsTime > 0)
         {
            _loc4_ = $.C("yishi.utils.DateFormatter").getCountDate(this._skillTime);
            _loc4_ = _loc4_ + "<br/>" + $.C("yishi.utils.DateFormatter").getCountDate(this._riverTime);
         }
         else
         {
            _loc4_ = "--:--:--<br/>--:--:--";
         }
         if(this._valueTxt)
         {
            this._valueTxt.htmlText = _loc3_ + "<br/>" + _loc4_;
         }
      }
    show() {
         this.resize();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4,false,false,0,1);
      }
    resize() {
         var _loc1_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this.x = _loc1_ - this._back.width - 5;
         this.y = 0;
      }
    dispose() {
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._text);
         this._text = null;
         this._model = null;
         super.dispose();
      }
  }
  $.meta(__VehicleBossDownTimeView, "com.map.vehicle.view.VehicleBossDownTimeView", ["IEnterFrame"]);
  return __VehicleBossDownTimeView;
}
deps["com.map.vehicle.view.VehicleBossDownTimeView"] = ["com.map.vehicle.data.VGlobal", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.utils.getTimer", "manager.LanguageMgr", "yishi.manager.EnterFrameManager", "yishi.manager.PlayerManager", "yishi.utils.DateFormatter"];

defs["com.map.vehicle.view.VehicleBottomView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleBottomView extends __Base {
    static $fields(self) {
    self._back = null;
    self._scoreTxt = null;
    self._gradeBack = null;
    self._gradeTxt = null;
    self._scoreValueTxt = null;
    self._hpTxt = null;
    self._hpComponent = null;
    self._numTxt = null;
    self._bloodmc = null;
    self._head = null;
    self._icon01 = null;
    self._icon02 = null;
    self._icon03 = null;
    self._iconList = null;
    self._flag = null;
    self._settingBtn = null;
    self._chatMessageBtn = null;
    self._consortiaChatBtn = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._buffBar = null;
    self._headMask = null;
    }
    constructor() {
         super();
         this.width = 620;
         this.height = 85;
         this.initView();
         this.addEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.BottomBack");
         this._scoreTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.ScoreTxt");
         this._gradeBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.GradeBack");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.gradeTxt");
         this._scoreValueTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.scoreValueTxt");
         this._hpTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.hpTxt");
         this._hpComponent = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("vehiclemap.hpComponent");
         this._numTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.numTxt");
         this._bloodmc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.BloodBar");
         this._bloodmc.gotoAndStop(80);
         this._bloodmc.x = 159;
         this._bloodmc.y = 63;
         this._head = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("vehiclemap.headView");
         this._icon01 = new ($.C("com.map.vehicle.view.VehicleSkillIcon"))("1");
         this._icon02 = new ($.C("com.map.vehicle.view.VehicleSkillIcon"))("2");
         this._icon03 = new ($.C("com.map.vehicle.view.VehicleSkillIcon"))("Q");
         this._iconList = [this._icon01,this._icon02,this._icon03];
         this._icon01.x = 340;
         this._icon01.y = 38;
         this._icon02.x = 396;
         this._icon02.y = 38;
         this._icon03.x = 472;
         this._icon03.y = 26;
         this._buffBar = new ($.C("com.map.vehicle.view.VehicleBufferBar"))();
         this._buffBar.x = 180;
         this._buffBar.y = -3;
         this._settingBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("battle.settingBtn");
         this._settingBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("setting.SettingFrame.title");
         this._settingBtn.x = 434;
         this._settingBtn.y = 8;
         this._chatMessageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("battle.chatMessageBtn");
         this._consortiaChatBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("maintoolbar.ConsortiaChatBtn");
         this._chatMessageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.ui.BattleUIView.msgBoxTip");
         this._consortiaChatBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
         this._chatMessageBtn.x = 405;
         this._chatMessageBtn.stopEffect();
         this._flag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.teamFlag");
         this._flag.x = 80;
         this._flag.y = 5;
         this._headMask = new ($.C("flash.display.Shape"))();
         this._head.mask = this._headMask;
         this._headMask.graphics.beginFill(0);
         this._headMask.graphics.drawRect(0,0,62,62);
         this._headMask.graphics.endFill();
         this._headMask.x = 95;
         this._headMask.y = 20;
         this.addChild(this._back);
         this.addChild(this._head);
         this.addChild(this._headMask);
         this.addChild(this._flag);
         this.addChild(this._gradeBack);
         this.addChild(this._scoreTxt);
         this.addChild(this._bloodmc);
         this.addChild(this._gradeTxt);
         this.addChild(this._scoreValueTxt);
         this.addChild(this._hpComponent);
         this._hpComponent.addChild(this._hpTxt);
         this.addChild(this._numTxt);
         this.addChild(this._icon01);
         this.addChild(this._icon02);
         this.addChild(this._icon03);
         this.addChild(this._buffBar);
         this.addChild(this._settingBtn);
         if($.C("yishi.manager.ArmyManager").instance.thane.grades >= 6)
         {
            this.addChild(this._chatMessageBtn);
         }
         if($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            this.addChild(this._consortiaChatBtn);
         }
         this.setMsgBtnShining();
         this.setConsortiaChatBtnShining();
         this._hpComponent.tipData = $.C("manager.LanguageMgr").GetTranslation("battle.view.bottomSelfBloodView.tip");
      }
    uintView() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scoreTxt);
         this._scoreTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeBack);
         this._gradeBack = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeTxt);
         this._gradeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scoreValueTxt);
         this._scoreValueTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hpTxt);
         this._hpTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hpComponent);
         this._hpComponent = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._numTxt);
         this._numTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bloodmc);
         this._bloodmc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head);
         this._head = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon01);
         this._icon01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon02);
         this._icon02 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon03);
         this._icon03 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._flag);
         this._flag = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._settingBtn);
         this._settingBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatMessageBtn);
         this._chatMessageBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consortiaChatBtn);
         this._consortiaChatBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buffBar);
         this._buffBar = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headMask);
         this._headMask = null;
         if(this._iconList)
         {
            this._iconList.length = 0;
         }
         this._iconList = null;
         this._model = null;
      }
    addEvent() {
         if(!this._model.selfVehicleInfo)
         {
            this._model.addEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         }
         else
         {
            this._buffBar.playerVehicleInfo = this._model.selfVehicleInfo;
            this.__updateHpHandler();
            this.__refreshHander();
            this.__scoreChangeHandler(null);
            this._model.selfVehicleInfo.addEventListener("playerInfoChange",$.bind(this, "__refreshHander"));
            this._model.selfVehicleInfo.addEventListener("update_hp",$.bind(this, "__updateHpHandler"));
            this._model.addEventListener("SCORE_CHANGE",$.bind(this, "__scoreChangeHandler"));
            this._model.skillBag.addEventListener("SKILL_INFO_CHANGE",$.bind(this, "__refreshHander"));
            this._model.skillBag.addEventListener("START_CD",$.bind(this, "__startCdHandler"));
            this._chatMessageBtn.addEventListener("rollOut",$.bind(this, "__onMsgBtnRollOut"));
            this._chatMessageBtn.addEventListener("rollOver",$.bind(this, "__onMsgBtnRollOver"));
            this._chatMessageBtn.addEventListener("click",$.bind(this, "__mouseClickHandler"));
            this._consortiaChatBtn.addEventListener("click",$.bind(this, "__consortiaChatClickHandler"));
            $.C("yishi.manager.NotificationManager").instance.addEventListener("CHAT_FROM_CONSORTIA",$.bind(this, "__receiveGroupChatHandler"));
            $.C("managers.IMManager").instance.addEventListener("MSGBOX_SHINING_UPDATE",$.bind(this, "__chatMsgbtnShineHandler"));
         }
         this._settingBtn.addEventListener("click",$.bind(this, "__openSettingFrameHandler"));
      }
    removeEvent() {
         if(this._model)
         {
            this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
            this._model.removeEventListener("SCORE_CHANGE",$.bind(this, "__scoreChangeHandler"));
            if(this._model.selfVehicleInfo)
            {
               this._model.selfVehicleInfo.removeEventListener("update_hp",$.bind(this, "__updateHpHandler"));
               this._model.selfVehicleInfo.removeEventListener("playerInfoChange",$.bind(this, "__refreshHander"));
            }
            if(this._model.skillBag)
            {
               this._model.skillBag.removeEventListener("SKILL_INFO_CHANGE",$.bind(this, "__refreshHander"));
               this._model.skillBag.removeEventListener("START_CD",$.bind(this, "__startCdHandler"));
            }
         }
         this._chatMessageBtn.removeEventListener("rollOut",$.bind(this, "__onMsgBtnRollOut"));
         this._chatMessageBtn.removeEventListener("rollOver",$.bind(this, "__onMsgBtnRollOver"));
         this._chatMessageBtn.removeEventListener("click",$.bind(this, "__mouseClickHandler"));
         this._consortiaChatBtn.removeEventListener("click",$.bind(this, "__consortiaChatClickHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("CHAT_FROM_CONSORTIA",$.bind(this, "__receiveGroupChatHandler"));
         $.C("managers.IMManager").instance.removeEventListener("MSGBOX_SHINING_UPDATE",$.bind(this, "__chatMsgbtnShineHandler"));
         if(this._settingBtn)
         {
            this._settingBtn.removeEventListener("click",$.bind(this, "__openSettingFrameHandler"));
         }
      }
    __updateHpHandler(param1 = null) {
         var _loc2_ = this._model.selfVehicleInfo;
         this._hpTxt.text = _loc2_.hp + " / " + _loc2_.totalHp;
         var _loc3_ = _loc2_.hp * 100 / _loc2_.totalHp;
         this._bloodmc.gotoAndStop(_loc3_);
      }
    __addPlayerHandler(param1) {
         if(this._model.selfVehicleInfo)
         {
            this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
            this.addEvent();
         }
      }
    __scoreChangeHandler(param1) {
         this._scoreValueTxt.text = String(this._model.selfVehicleInfo.score);
      }
    __refreshHander(param1 = null) {
         var _loc2_ = null;
         var _loc4_ = this._model.selfVehicleInfo;
         if(!_loc4_)
         {
            return;
         }
         this._gradeTxt.text = String(_loc4_.grade);
         if(_loc4_.team > 0)
         {
            this._flag.setFrame(_loc4_.team);
         }
         this._model.skillBag.init(this._model.selfVehicleInfo);
         this._icon01.data = this._model.skillBag.getSkillByKey(49);
         this._icon02.data = this._model.skillBag.getSkillByKey(50);
         var _loc3_ = this._model.skillBag.getSkillByKey(81);
         if(_loc3_.tempalte && _loc3_.tempalte.Maximum == -1)
         {
            this._icon03.data = this._model.skillBag.getSkillByKey(81);
            this._numTxt.text = "--";
         }
         else if(_loc3_.count <= 0)
         {
            this._icon03.data = null;
            this._numTxt.text = "--";
         }
         else
         {
            this._icon03.data = _loc3_;
            this._numTxt.text = String(_loc3_.count);
         }
         _loc2_ = $.C("yishi.manager.PathManager").getVehicleShowAvatarPath(_loc4_.template.Avatar);
         if(_loc2_ != String(this._head.icon))
         {
            this._head.icon = _loc2_;
         }
      }
    __startCdHandler(param1) {
         var _loc2_ = param1.data;
         for (var _loc3_ of $.values(this._iconList))
         {
            if(_loc3_.data && _loc3_.data.templateId == _loc2_)
            {
               _loc3_.startCD();
               break;
            }
         }
      }
    __onMsgBtnRollOut(param1) {
         $.C("managers.IMManager").instance.model.removeMsgBoxTimeOut = $.g("flash", this).utils.setTimeout($.bind(this, "removeIMMsgBox"),300);
      }
    removeIMMsgBox() {
         $.C("flash.utils.clearTimeout")($.C("managers.IMManager").instance.model.removeMsgBoxTimeOut);
         $.C("managers.IMManager").instance.removeIMMsgBox();
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
    __consortiaChatClickHandler(param1) {
         if(!$.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.isVisible())
         {
            this.setConsortiaChatBtnShining(false);
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortiagroupchat");
         }
      }
    __receiveGroupChatHandler(param1) {
         this.setConsortiaChatBtnShining();
      }
    __chatMsgbtnShineHandler(param1) {
         this.setMsgBtnShining();
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
    __openSettingFrameHandler(param1) {
         $.C("yishi.utils.TimerUtils").setTimeout($.bind(this, "openFrame"),10);
      }
    openFrame() {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("setting");
      }
    __exitHandler(param1) {
         $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendReturnCampaignRoom();
         $.C("yishi.SwitchPageHelp").returnToSpace();
      }
    show() {
         this.resize();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4,false,false,0,2);
      }
    resize() {
         var _loc1_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this.x = (_loc1_ - this.width) / 2;
         this.y = _loc2_ - this.height;
      }
    dispose() {
         this.removeEvent();
         this.uintView();
         super.dispose();
      }
  }
  $.meta(__VehicleBottomView, "com.map.vehicle.view.VehicleBottomView", []);
  return __VehicleBottomView;
}
deps["com.map.vehicle.view.VehicleBottomView"] = ["com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.net.VehicleSocketOutManager", "com.map.vehicle.view.VehicleBufferBar", "com.map.vehicle.view.VehicleSkillIcon", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Shape", "flash.events.KeyboardEvent", "flash.geom.Point", "flash.utils.clearTimeout", "manager.LanguageMgr", "managers.IMManager", "yishi.SwitchPageHelp", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.utils.TimerUtils"];

defs["com.map.vehicle.view.VehicleBufferBar"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleBufferBar extends __Base {
    static $fields(self) {
    self._dic = new ($.C("flash.utils.Dictionary"))(true);
    self._iconDic = new ($.C("flash.utils.Dictionary"))(true);
    self._hBox = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._playerVehicleInfo = null;
    self._timer = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.mouseEnabled = false;
         this._hBox.mouseEnabled = false;
      }
    initView() {
         this._hBox = new ($.C("com.pickgliss.ui.controls.container.HBox"))();
         this._hBox.spacing = 1;
         this.addChild(this._hBox);
      }
    addEvent() {
         if(this._playerVehicleInfo)
         {
            this._playerVehicleInfo.addEventListener("ADD_BUFF",$.bind(this, "__addBuffHandler"));
            this._playerVehicleInfo.addEventListener("REMOVE_BUFF",$.bind(this, "__removeBuffHandler"));
            this._playerVehicleInfo.addEventListener("CLEAR_BUFF",$.bind(this, "__clearBuffHandler"));
         }
         if(!this._timer)
         {
            this._timer = new ($.C("flash.utils.Timer"))(1000);
            this._timer.start();
            this._timer.addEventListener("timer",$.bind(this, "__onTimerHandler"));
         }
      }
    __addBuffHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.VehicleBufferDamageInfo"));
         this.addBuff(_loc2_);
      }
    addBuff(param1) {
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc4_ = null;
         var _loc7_ = null;
         var _loc2_ = param1.buffId;
         var _loc6_ = param1.id;
         if(this._dic[_loc6_] && this._iconDic[_loc6_])
         {
            _loc3_ = $.as(this._iconDic[_loc6_], $.C("yishi.view.community.BaseIconView"));
            _loc3_.tipData = param1;
         }
         else
         {
            _loc4_ = $.C("com.map.vehicle.utils.VehicleUtil").getBuffTemplate(_loc2_);
            if(_loc4_ && _loc4_.Duration != 0)
            {
               _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.CdIcon");
               _loc5_.gotoAndStop(1);
               _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("vehiclemap.buffIcon");
               _loc3_.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(_loc4_.Icon);
               _loc3_.tipData = param1;
               _loc5_.gotoAndStop(1);
               _loc5_["icon"].addChild(_loc3_);
               _loc7_ = $.as(_loc5_["iconMask"], $.C("flash.display.MovieClip"));
               _loc7_.gotoAndStop(1);
               if(_loc7_.parent)
               {
                  _loc7_.parent.removeChild(_loc7_);
               }
               this._dic[_loc6_] = _loc5_;
               this._iconDic[_loc6_] = _loc3_;
               this._hBox.addChild(_loc5_);
            }
         }
      }
    __clearBuffHandler(param1) {
         this.clear();
      }
    get playerVehicleInfo() {
         return this._playerVehicleInfo;
      }
    set playerVehicleInfo(param1) {
         if(this._playerVehicleInfo != param1)
         {
            this.removeEvent();
            this._playerVehicleInfo = param1;
            this.initBuff();
            this.addEvent();
         }
      }
    __onTimerHandler(param1) {
         var _loc3_ = null;
         if(this.isDie)
         {
            return;
         }
         for (var _loc2_ of $.values(this._iconDic))
         {
            if(_loc2_.tipData && $.is(_loc2_.tipData, $.C("com.map.vehicle.data.VehicleBufferDamageInfo")))
            {
               _loc3_ = $.as(_loc2_.tipData, $.C("com.map.vehicle.data.VehicleBufferDamageInfo"));
               if(_loc3_.leftTime <= 1)
               {
                  this.startRemoveMovie(_loc3_.id);
               }
            }
         }
      }
    __removeBuffHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("com.map.vehicle.data.VehicleBufferDamageInfo"));
         if(this._dic[_loc2_.id])
         {
            this.startRemoveMovie(_loc2_.id);
         }
      }
    clear() {
         var _loc3_ = null;
         var _loc2_ = null;
         for (var _loc1_ of $.values(this._dic))
         {
            _loc3_ = _loc1_["iconMask"];
            if(_loc3_)
            {
               $.C("com.greensock.TweenMax").killTweensOf(_loc3_);
            }
            $.C("com.greensock.TweenMax").killTweensOf(_loc1_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         for(_loc2_ in this._dic)
         {
            delete this._dic[_loc2_];
            delete this._iconDic[_loc2_];
         }
      }
    createPassiveBuff() {
         var _loc2_ = null;
         var _loc1_ = this._model.skillBag.getSkillByPos(2).tempalte;
         if(_loc1_ && _loc1_.InjuryEffect == 3)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("vehiclemap.buffIcon");
            _loc2_.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(_loc1_.Icons);
            _loc2_.tipData = _loc1_;
            this._hBox.addChild(_loc2_);
            return _loc2_;
         }
         return null;
      }
    initBuff() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._hBox);
         this.createPassiveBuff();
         var _loc1_ = this.playerVehicleInfo.buffList;
         for (var _loc2_ of $.values(_loc1_))
         {
            this.addBuff(_loc2_);
         }
      }
    removeEvent() {
         if(this._playerVehicleInfo)
         {
            this._playerVehicleInfo.removeEventListener("ADD_BUFF",$.bind(this, "__addBuffHandler"));
            this._playerVehicleInfo.removeEventListener("REMOVE_BUFF",$.bind(this, "__removeBuffHandler"));
            this._playerVehicleInfo.removeEventListener("CLEAR_BUFF",$.bind(this, "__clearBuffHandler"));
            this._playerVehicleInfo = null;
         }
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
      }
    startRemoveMovie(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc2_ = this._dic[param1];
         if(_loc2_)
         {
            _loc3_ = $.as(_loc2_["iconMask"], $.C("flash.display.MovieClip"));
            _loc2_.addChild(_loc3_);
            $.C("com.greensock.TweenMax").to(_loc3_,0.8,{
               "frame":_loc3_.totalFrames,
               "onComplete":$.bind(this, "__maskComplete"),
               "onCompleteParams":[_loc2_]
            });
            delete this._dic[param1];
            delete this._iconDic[param1];
         }
      }
    __maskComplete(param1) {
         var _loc2_ = $.as(param1["iconMask"], $.C("flash.display.MovieClip"));
         if(_loc2_)
         {
            $.C("com.greensock.TweenMax").killTweensOf(_loc2_);
            _loc2_.stop();
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         $.C("com.greensock.TweenMax").to(param1,0.2,{
            "frame":param1.totalFrames,
            "onComplete":$.bind(this, "__mcComplete"),
            "onCompleteParams":[param1]
         });
      }
    __mcComplete(param1) {
         $.C("com.greensock.TweenMax").killTweensOf(param1);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(param1);
      }
    uintView() {
         this.clear();
         this._dic = null;
         this._hBox = null;
         this._dic = null;
         this._iconDic = null;
         this._model = null;
      }
    dispose() {
         this.removeEvent();
         this.uintView();
         super.dispose();
      }
  }
  $.meta(__VehicleBufferBar, "com.map.vehicle.view.VehicleBufferBar", []);
  return __VehicleBufferBar;
}
deps["com.map.vehicle.view.VehicleBufferBar"] = ["com.greensock.TweenMax", "com.map.vehicle.data.VehicleBufferDamageInfo", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.utils.VehicleUtil", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.HBox", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.utils.Dictionary", "flash.utils.Timer", "yishi.utils.IconFactory", "yishi.view.community.BaseIconView"];

defs["com.map.vehicle.view.VehicleChatPopView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleChatPopView extends __Base {
    static $fields(self) {
    self._back = null;
    self._chatTxt = null;
    self._timeId = 0;
    }
    constructor() {
         super();
      }
    init() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.ChatPopBottom");
         this._back.width = 360;
         this._back.height = 70;
         this._chatTxt = new ($.C("chat.view.ExpressionChatNotic"))();
         this._chatTxt.x = 9;
         this._chatTxt.y = 9;
         this._chatTxt.lineWidth = 340;
         this.addChild(this._back);
         this.addChild(this._chatTxt);
         this.mouseChildren = this.mouseEnabled = false;
      }
    set data(param1) {
         if(!param1)
         {
            return;
         }
         var _loc3_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("chat.datas.ChatData")), $.C("chat.datas.ChatData"));
         $.C("com.pickgliss.utils.ObjectUtils").copyProperties(_loc3_,param1,true);
         var _loc2_ = $.int($.C("yishi.utils.StringHelper").checkStringLength(_loc3_.getNormalMsg()));
         if(_loc2_ <= 20)
         {
            this._chatTxt.x = (this._back.width - _loc2_ * 7.5) / 2;
            this._chatTxt.lineWidth = _loc2_ * 8;
         }
         _loc3_.msg = $.C("chat.ChatManager").instance.analyzeExpressionAfterNormal(_loc3_.msg);
         _loc3_.channel = 8;
         _loc3_.chatItemData.cellVector = $.C("chat.utils.ChatFormat").getContentCellData(_loc3_);
         this._chatTxt.needFilters = false;
         this._chatTxt.data = _loc3_;
         this._chatTxt.y = 10 + (50 - this._chatTxt.height) / 2;
         if(this._timeId > 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
         }
         this._timeId = 0;
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "close"),3000);
      }
    close() {
         this.dispose();
      }
    dispose() {
         if(this._timeId > 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
         }
         this._timeId = 0;
         this._back = null;
         this._chatTxt = null;
         super.dispose();
      }
    get data() { return super.data; }
  }
  $.meta(__VehicleChatPopView, "com.map.vehicle.view.VehicleChatPopView", []);
  return __VehicleChatPopView;
}
deps["com.map.vehicle.view.VehicleChatPopView"] = ["chat.ChatManager", "chat.datas.ChatData", "chat.utils.ChatFormat", "chat.view.ExpressionChatNotic", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "flash.utils.clearTimeout", "flash.utils.setTimeout", "yishi.utils.StringHelper"];

defs["com.map.vehicle.view.VehicleDownTimeView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleDownTimeView extends __Base {
    static $fields(self) {
    self._count = 0;
    self._time = null;
    self._numberAsset = null;
    self._hourContainer = null;
    self._minuteContainer = null;
    self._secondContainer = null;
    self.fontWidth = 20;
    self.fontHeight = 23;
    self.bitWidth = 13;
    self.resLink = "worldboss.river.NumberAsset";
    self.equal = 20;
    self.type = 1;
    }
    constructor(param1 = 1) {
         $.pre(new.target, (__s) => {
         __s.type = param1;
         if(__s.type == 2)
         {
            __s.fontWidth = 30;
            __s.fontHeight = 34;
            __s.bitWidth = 22;
            __s.equal = 28;
            __s.resLink = "asset.vehiclemap.TeamCountNum";
         }
         });
         super();
         $.preFlush(this, new.target);
      }
    init() {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc2_ = 30;
         var _loc1_ = 27;
         if(this.type == 1)
         {
            this._numberAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData(this.resLink);
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("worldboss.river.RiverSymbolAsset");
            _loc4_ = new ($.C("flash.display.Bitmap"))(_loc3_.bitmapData);
            this.addChild(_loc3_);
            _loc3_.x = _loc1_ + 25;
            _loc3_.y = _loc2_ + 3;
            this.addChild(_loc4_);
            _loc4_.x = _loc1_ + 55;
            _loc4_.y = _loc2_ + 3;
            this._hourContainer = new ($.C("flash.display.Sprite"))();
            this.addChild(this._hourContainer);
            this._hourContainer.y = _loc2_;
            this._hourContainer.x = _loc1_;
            $.C("yishi.utils.NumberViewUtils").getNumberView(0,this._hourContainer,this._numberAsset,this.fontWidth,this.fontHeight,this.bitWidth);
            this._minuteContainer = new ($.C("flash.display.Sprite"))();
            $.C("yishi.utils.NumberViewUtils").getNumberView(0,this._minuteContainer,this._numberAsset,this.fontWidth,this.fontHeight,this.bitWidth);
            this.addChild(this._minuteContainer);
            this._minuteContainer.x = _loc1_ + 29;
            this._minuteContainer.y = _loc2_;
            this._secondContainer = new ($.C("flash.display.Sprite"))();
            this.addChild(this._secondContainer);
            this._secondContainer.x = _loc1_ + 59;
            this._secondContainer.y = _loc2_;
            $.C("yishi.utils.NumberViewUtils").getNumberView(0,this._secondContainer,this._numberAsset,this.fontWidth,this.fontHeight,this.bitWidth);
         }
         else
         {
            this._numberAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData(this.resLink);
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.TeamCountColon");
            _loc4_ = new ($.C("flash.display.Bitmap"))(_loc3_.bitmapData);
            this.addChild(_loc3_);
            _loc3_.x = 71;
            _loc3_.y = 36;
            this.addChild(_loc4_);
            _loc4_.x = 122;
            _loc4_.y = 36;
            this._hourContainer = new ($.C("flash.display.Sprite"))();
            this.addChild(this._hourContainer);
            this._hourContainer.y = 32;
            this._hourContainer.x = 27;
            $.C("yishi.utils.NumberViewUtils").getNumberView(0,this._hourContainer,this._numberAsset,this.fontWidth,this.fontHeight,this.bitWidth);
            this._minuteContainer = new ($.C("flash.display.Sprite"))();
            $.C("yishi.utils.NumberViewUtils").getNumberView(0,this._minuteContainer,this._numberAsset,this.fontWidth,this.fontHeight,this.bitWidth);
            this.addChild(this._minuteContainer);
            this._minuteContainer.x = 79;
            this._minuteContainer.y = 32;
            this._secondContainer = new ($.C("flash.display.Sprite"))();
            this.addChild(this._secondContainer);
            this._secondContainer.x = 129;
            this._secondContainer.y = 32;
            $.C("yishi.utils.NumberViewUtils").getNumberView(0,this._secondContainer,this._numberAsset,this.fontWidth,this.fontHeight,this.bitWidth);
         }
      }
    set count(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._count = param1;
         this.time = this._count;
         if(!this._time)
         {
            this._time = new ($.C("flash.utils.Timer"))(1000,param1);
            this._time.addEventListener("timer",$.bind(this, "__timeHandler"));
            this._time.addEventListener("timerComplete",$.bind(this, "__timeCompleteHandler"));
         }
         this._time.reset();
         this._time.repeatCount = param1;
         this._time.start();
      }
    __timeHandler(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._count = this._count - 1;
         this.time = this._count;
      }
    updateTime(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         $.C("yishi.utils.NumberViewUtils").getNumberView(param2,param1,this._numberAsset,this.fontWidth,this.fontHeight,this.bitWidth,this.equal);
      }
    __timeCompleteHandler(param1) {
         this.dispatchEvent(new ($.C("flash.events.Event"))("complete"));
      }
    stop() {
         if(this._time)
         {
            this._time.stop();
         }
      }
    set time(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(param1 >= 3600)
         {
            _loc2_ = param1 / 3600;
            this.updateTime(this._hourContainer,_loc2_);
         }
         else
         {
            this.updateTime(this._hourContainer,0);
         }
         if(param1 >= 60)
         {
            _loc2_ = param1 / 60;
            this.updateTime(this._minuteContainer,$.int(_loc2_ % 60));
         }
         else
         {
            this.updateTime(this._minuteContainer,0);
         }
         _loc2_ = param1 % 60;
         _loc2_ = $.int(_loc2_ > 0 ? _loc2_ : 0);
         this.updateTime(this._secondContainer,_loc2_);
      }
    dispose() {
         if(this._time)
         {
            this._time.removeEventListener("timer",$.bind(this, "__timeHandler"));
            this._time.removeEventListener("timerComplete",$.bind(this, "__timeCompleteHandler"));
            this._time.stop();
         }
         this._time = null;
         if(this._numberAsset)
         {
            this._numberAsset.dispose();
         }
         this._numberAsset = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._hourContainer);
         this._hourContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._minuteContainer);
         this._minuteContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._secondContainer);
         this._secondContainer = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    get count() { return super.count; }
    get time() { return super.time; }
  }
  $.meta(__VehicleDownTimeView, "com.map.vehicle.view.VehicleDownTimeView", []);
  return __VehicleDownTimeView;
}
deps["com.map.vehicle.view.VehicleDownTimeView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.Sprite", "flash.events.Event", "flash.utils.Timer", "yishi.utils.NumberViewUtils"];

defs["com.map.vehicle.view.VehicleNpcBloodStuffView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleNpcBloodStuffView extends __Base {
    static $fields(self) {
    self._nameTxt = null;
    self._mc = null;
    self._bloodMc = null;
    self._data = null;
    self._tween = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._mc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.campaign.map.BloodAsset");
         this._mc.mouseChildren = this._mc.mouseEnabled = false;
         this._bloodMc = $.as(this._mc["bloodMc"], $.C("flash.display.MovieClip"));
         this._bloodMc.gotoAndStop(100);
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.NpcNameText");
         this._nameTxt.selectable = this._nameTxt.mouseEnabled = this._nameTxt.mouseWheelEnabled = false;
         this.addChild(this._mc);
         this.addChild(this._nameTxt);
      }
    layout() {
         this._mc.y = -this._mc.height;
         this._nameTxt.x = -this._nameTxt.width / 2;
         this._nameTxt.y = -this._mc.height - this._nameTxt.textHeight;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         this._nameTxt.text = this._data.name;
         if(this.data.nameColor > 0)
         {
            this._nameTxt.setFrame(this.data.nameColor);
         }
         this.layout();
         this.addEvent();
         this.__updateBloodHandler();
      }
    addEvent() {
         this._data.addEventListener("updateNode",$.bind(this, "__updateBloodHandler"));
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("updateNode",$.bind(this, "__updateBloodHandler"));
         }
      }
    __updateBloodHandler(param1 = null) {
         var _loc2_ = 0;
         if(this._bloodMc)
         {
            this.killTweens();
            _loc2_ = this.data.hp * 100 / this.data.totalHp;
            if(_loc2_ != this._bloodMc.currentFrame)
            {
               this._tween = $.C("com.greensock.TweenMax").to(this._bloodMc,0.7,{
                  "delay":0.7,
                  "frame":_loc2_,
                  "onComplete":$.bind(this, "killTweens")
               });
            }
         }
      }
    killTweens() {
         if(this._tween)
         {
            this._tween.kill();
            this._tween = null;
         }
      }
    dispose() {
         this.killTweens();
         this.removeEvent();
         this._bloodMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mc);
         this._mc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         super.dispose();
      }
  }
  $.meta(__VehicleNpcBloodStuffView, "com.map.vehicle.view.VehicleNpcBloodStuffView", []);
  return __VehicleNpcBloodStuffView;
}
deps["com.map.vehicle.view.VehicleNpcBloodStuffView"] = ["com.greensock.TweenMax", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip"];

defs["com.map.vehicle.view.VehicleReviveView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleReviveView extends __Base {
    static $fields(self) {
    self._back = null;
    self._text = null;
    self._countTime = null;
    self._data = null;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s.visible = false;
         });
         super();
         $.preFlush(this, new.target);
         this.mouseEnabled = this.mouseChildren = false;
      }
    init() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.RevierBack");
         this._text = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.RevierTxt");
         this._text.x = -5;
         this._text.y = 8;
         this._countTime = new ($.C("com.map.vehicle.view.VehicleDownTimeView"))();
         this._countTime.x = 155;
         this._countTime.y = -22;
         this.addChild(this._back);
         this.addChild(this._text);
         this.addChild(this._countTime);
         if($.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo)
         {
            this.data = $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo;
         }
         else
         {
            $.C("com.map.vehicle.data.VGlobal").model.addEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         }
      }
    __addPlayerHandler(param1) {
         if($.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo)
         {
            $.C("com.map.vehicle.data.VGlobal").model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
            this.data = $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo;
         }
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         if(!this._data)
         {
            this._data = param1;
            this.addEvent();
            if(this._data.rebornTime > 0)
            {
               this.show();
            }
         }
      }
    addEvent() {
         if(this._data)
         {
            this._data.addEventListener("DIE_COUNT",$.bind(this, "__startCountHandler"));
            this._data.addEventListener("REVIER",$.bind(this, "__countCompleteHandler"));
         }
         if(this._countTime)
         {
            this._countTime.addEventListener("complete",$.bind(this, "__countCompleteHandler"));
         }
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("DIE_COUNT",$.bind(this, "__startCountHandler"));
            this._data.removeEventListener("REVIER",$.bind(this, "__countCompleteHandler"));
         }
         if(this._countTime)
         {
            this._countTime.removeEventListener("complete",$.bind(this, "__countCompleteHandler"));
         }
      }
    __countCompleteHandler(param1) {
         this.hide();
      }
    __startCountHandler(param1) {
         if(this._data.rebornTime > 0)
         {
            this.show();
         }
      }
    show() {
         if(this.visible)
         {
            return;
         }
         this.visible = true;
         this._countTime.count = this._data.rebornTime;
         this.resize();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4,false,false,0,0);
      }
    hide() {
         this.visible = false;
         if(this._data)
         {
            this._data.rebornTime = 0;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    resize() {
         var _loc1_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this.x = (_loc1_ - 278) / 2;
         this.y = 140;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
      }
  }
  $.meta(__VehicleReviveView, "com.map.vehicle.view.VehicleReviveView", []);
  return __VehicleReviveView;
}
deps["com.map.vehicle.view.VehicleReviveView"] = ["com.map.vehicle.data.VGlobal", "com.map.vehicle.view.VehicleDownTimeView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component"];

defs["com.map.vehicle.view.VehicleRightView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleRightView extends __Base {
    static $fields(self) {
    self._returnBtn = null;
    self._sortBtn = null;
    self._closeBtn = null;
    self._back = null;
    self._mysortLabel = null;
    self._myScoreTxt = null;
    self._vBox = null;
    self._itemList = null;
    self._hide = true;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._returnTimerId = 0;
    }
    constructor() {
         super();
         this.width = 200;
         this.initView();
         this.addEvent();
      }
    initView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._returnBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.returnBtn");
         this._returnBtn.text = $.C("manager.LanguageMgr").GetTranslation("vehicle.return");
         this._sortBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.sortBtn");
         this._sortBtn.text = $.C("manager.LanguageMgr").GetTranslation("vehicle.scoresort");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("goldOvertop.CloseBtn");
         this._closeBtn.x = 179;
         this._closeBtn.y = 98;
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.back");
         this._mysortLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.mysort");
         this._myScoreTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.myscore");
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.spacing = 4;
         this._vBox.x = 11;
         this._vBox.y = 156;
         this._itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ($.C("com.map.vehicle.view.VehicleSortItemView"))(_loc2_ + 1);
            this._vBox.addChild(_loc1_);
            this._itemList.push(_loc1_);
            _loc2_++;
         }
         this.addChild(this._back);
         this.addChild(this._returnBtn);
         this.addChild(this._sortBtn);
         this.addChild(this._closeBtn);
         this.addChild(this._mysortLabel);
         this.addChild(this._myScoreTxt);
         this.addChild(this._vBox);
         this._back.mouseChildren = this._back.mouseEnabled = false;
         this._mysortLabel.mouseEnabled = this._myScoreTxt.mouseEnabled = false;
         this._vBox.mouseChildren = this._vBox.mouseEnabled = false;
         this._mysortLabel.text = $.C("manager.LanguageMgr").GetTranslation("vehicle.score");
         this._myScoreTxt.text = "";
         this.update();
         this._closeBtn.visible = false;
         this._back.visible = false;
         this._myScoreTxt.visible = false;
         this._mysortLabel.visible = false;
         this._vBox.visible = false;
      }
    uintView() {
         this._returnBtn = null;
         this._sortBtn = null;
         this._closeBtn = null;
         this._back = null;
         this._mysortLabel = null;
         this._myScoreTxt = null;
         this._vBox = null;
         this._itemList = null;
      }
    addEvent() {
         this._returnBtn.addEventListener("click",$.bind(this, "__returnHandler"));
         this._sortBtn.addEventListener("click",$.bind(this, "__showHandler"));
         this._closeBtn.addEventListener("click",$.bind(this, "__hideHandler"));
         $.C("com.map.vehicle.data.VGlobal").model.addEventListener("SCORE_CHANGE",$.bind(this, "__refreshHandler"));
      }
    removeEvent() {
         this._returnBtn.removeEventListener("click",$.bind(this, "__returnHandler"));
         this._sortBtn.removeEventListener("click",$.bind(this, "__showHandler"));
         this._closeBtn.removeEventListener("click",$.bind(this, "__hideHandler"));
         $.C("com.map.vehicle.data.VGlobal").model.removeEventListener("SCORE_CHANGE",$.bind(this, "__refreshHandler"));
      }
    __returnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "__returnCampaignHandler")];
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc5_ = $.C("manager.LanguageMgr").GetTranslation("mainBar.MainToolBar.prompt");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("vehicle.returnTip");
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
      }
    __returnCampaignHandler(param1, param2) {
         var b = param1;
         var flag = param2;
         if(this.isDie)
         {
            return;
         }
         if(b)
         {
            $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendReturnCampaignRoom();
            if(this._returnTimerId != 0)
            {
               $.C("flash.utils.clearTimeout")(this._returnTimerId);
            }
            this._returnTimerId = $.C("flash.utils.setTimeout")(() =>
            {
               if($.C("yishi.scene.SceneManager").instance.currentType == "VEHICLE")
               {
                  if(this._model)
                  {
                     this._model.exit = true;
                  }
                  $.C("yishi.SwitchPageHelp").returnToSpace();
               }
            },500);
         }
      }
    __showHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._closeBtn.visible = this._hide;
         this._back.visible = this._hide;
         this._myScoreTxt.visible = this._hide;
         this._mysortLabel.visible = this._hide;
         this._vBox.visible = this._hide;
         this._hide = !this._hide;
      }
    __hideHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this._closeBtn.visible = this._hide;
         this._back.visible = this._hide;
         this._myScoreTxt.visible = this._hide;
         this._mysortLabel.visible = this._hide;
         this._vBox.visible = this._hide;
         this._hide = true;
      }
    __refreshHandler(param1) {
         this.update();
      }
    update() {
         var _loc3_ = 0;
         var _loc2_ = null;
         var _loc4_ = null;
         if($.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo)
         {
            this._myScoreTxt.text = String($.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo.score);
         }
         var _loc1_ = $.C("com.map.vehicle.data.VGlobal").model.playerList.getList();
         _loc1_.sortOn("score",0x10 | 2);
         _loc3_ = 0;
         while(_loc3_ < this._itemList.length)
         {
            _loc2_ = this._itemList[_loc3_];
            _loc4_ = _loc1_[_loc3_];
            _loc2_.data = _loc4_;
            _loc3_++;
         }
      }
    show() {
         this.resize();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4,false,false,0,1);
      }
    resize() {
         var _loc1_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this.x = _loc1_ - this.width - 5;
         this.y = 25;
      }
    dispose() {
         if(this.isDie)
         {
            return;
         }
         if(this._returnTimerId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._returnTimerId);
            this._returnTimerId = 0;
         }
         this.removeEvent();
         this.uintView();
         this._model = null;
         super.dispose();
      }
  }
  $.meta(__VehicleRightView, "com.map.vehicle.view.VehicleRightView", []);
  return __VehicleRightView;
}
deps["com.map.vehicle.view.VehicleRightView"] = ["com.map.vehicle.data.VGlobal", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.net.VehicleSocketOutManager", "com.map.vehicle.view.VehicleSortItemView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.SoundManager", "flash.utils.clearTimeout", "flash.utils.setTimeout", "manager.LanguageMgr", "yishi.SwitchPageHelp", "yishi.scene.SceneManager", "yishi.utils.SimpleAlertHelper"];

defs["com.map.vehicle.view.VehicleScreenEffectLayer"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleScreenEffectLayer extends __Base {
    static $fields(self) {
    self._redScreen = new ($.C("map.internals.effect.RedScreen"))();
    self._model = $.C("com.map.vehicle.data.VGlobal").model;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s.mouseChildren = __s.mouseEnabled = false;
         });
         super();
         $.preFlush(this, new.target);
         if(this._model.selfVehicleInfo)
         {
            this.addEvent();
         }
         else
         {
            this._model.addEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         }
      }
    __addPlayerHandler(param1) {
         if(this._model.selfVehicleInfo)
         {
            this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
            this.addEvent();
         }
      }
    addEvent() {
         if(this._model.selfVehicleInfo)
         {
            this.__checkRedScreenHandler();
            this._model.selfVehicleInfo.addEventListener("update_hp",$.bind(this, "__checkRedScreenHandler"));
         }
      }
    removeEvent() {
         if(this._model)
         {
            this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
            if(this._model.selfVehicleInfo)
            {
               this._model.selfVehicleInfo.removeEventListener("update_hp",$.bind(this, "__checkRedScreenHandler"));
            }
         }
      }
    __checkRedScreenHandler(param1 = null) {
         if(!this._model.selfVehicleInfo)
         {
            return;
         }
         if(this._model.selfVehicleInfo.hp <= this._model.selfVehicleInfo.totalHp * 0.2 && this._model.selfVehicleInfo.hp > 0)
         {
            if(!this._redScreen.parent)
            {
               this.addChild(this._redScreen);
               this._redScreen.play();
            }
         }
         else if(this._redScreen.parent)
         {
            this.removeChild(this._redScreen);
            this._redScreen.stop();
         }
      }
    show() {
         this.resize();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4);
      }
    resize() {
         var _loc1_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         if(this._redScreen)
         {
            this._redScreen.resize(_loc1_,_loc2_);
         }
      }
    dispose() {
         this.removeEvent();
         if(this._redScreen)
         {
            this._redScreen.dispose();
            this._redScreen = null;
         }
         super.dispose();
      }
  }
  $.meta(__VehicleScreenEffectLayer, "com.map.vehicle.view.VehicleScreenEffectLayer", []);
  return __VehicleScreenEffectLayer;
}
deps["com.map.vehicle.view.VehicleScreenEffectLayer"] = ["com.map.vehicle.data.VGlobal", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "map.internals.effect.RedScreen"];

defs["com.map.vehicle.view.VehicleSkillCDEffect"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __VehicleSkillCDEffect extends __Base {
    static $fields(self) {
    self.$$_mask = null;
    self._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehicle.SkillItemCDAsset");
    self._time = NaN;
    self._callback = null;
    self._update = null;
    self.currentAngle = 0;
    self._w = 44;
    self._cding = false;
    self._waitInv = 0;
    self._templeteTime = 0;
    self._currentTime = 0;
    self._timer = null;
    }
    constructor(param1, param2, param3) {
         $.pre(new.target, (__s) => {
         __s._time = param1;
         __s._templeteTime = param1;
         __s._currentTime = __s._templeteTime * 0.001;
         __s._callback = param2;
         __s._update = param3;
         __s.mouseChildren = __s.mouseEnabled = false;
         __s.addChild(__s._back);
         __s.$$_mask = new ($.C("flash.display.Sprite"))();
         __s.$$_mask.rotation = -90;
         __s.$$_mask.x = __s.$$_mask.y = __s._w * 0.5;
         __s.addChild(__s.$$_mask);
         __s._back.mask = __s.$$_mask;
         __s._timer = new ($.C("flash.utils.Timer"))(1000,__s._currentTime);
         });
         super();
         $.preFlush(this, new.target);
      }
    start(param1 = 0, param2 = -1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(this._cding)
         {
            return;
         }
         this._cding = true;
         if(param2 == -1)
         {
            this._time = this._templeteTime;
         }
         else
         {
            this._time = param2;
         }
         if(param1 > 0)
         {
            if(this._waitInv > 0)
            {
               $.C("flash.utils.clearTimeout")(this._waitInv);
            }
            this._waitInv = 0;
            this._waitInv = $.C("flash.utils.setTimeout")($.bind(this, "startRotate"),param1);
         }
         else
         {
            this.startRotate();
         }
      }
    startRotate() {
         this.currentAngle = 360;
         $.C("yishi.utils.GraphicsUtils").changeSectorAngle(this.$$_mask,0,0,50,0,360);
         $.C("com.greensock.TweenLite").to(this,this._time * 0.001,{
            "currentAngle":0,
            "onUpdate":$.bind(this, "updateMask"),
            "onComplete":$.bind(this, "cdComplete"),
            "ease":$.C("com.greensock.easing.Linear").easeNone
         });
         this._timer.addEventListener("timer",$.bind(this, "__timerHandler"));
         this._timer.start();
      }
    __timerHandler(param1) {
         if(this._currentTime > 0)
         {
            this._currentTime = this._currentTime - 1;
         }
      }
    cdComplete() {
         this._timer.removeEventListener("timer",$.bind(this, "__timerHandler"));
         this._timer.reset();
         this._currentTime = this._templeteTime * 0.001;
         this._cding = false;
         this._callback();
      }
    get isCding() {
         return this._cding;
      }
    updateMask() {
         this._update();
         $.C("yishi.utils.GraphicsUtils").changeSectorAngle(this.$$_mask,0,0,50,0,this.currentAngle);
      }
    getLeftTime() {
         return this._currentTime;
      }
    dispose() {
         if(this._waitInv > 0)
         {
            $.C("flash.utils.clearTimeout")(this._waitInv);
         }
         this._waitInv = 0;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this.$$_mask);
         this.$$_mask = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._back);
         this._back = null;
         $.C("com.greensock.TweenLite").killTweensOf(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._timer)
         {
            this._timer.removeEventListener("timer",$.bind(this, "__timerHandler"));
            this._timer.stop();
         }
         this._timer = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set isCding(v) { super.isCding = v; }
  }
  $.meta(__VehicleSkillCDEffect, "com.map.vehicle.view.VehicleSkillCDEffect", ["Disposeable"]);
  return __VehicleSkillCDEffect;
}
deps["com.map.vehicle.view.VehicleSkillCDEffect"] = ["com.greensock.TweenLite", "com.greensock.easing.Linear", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Timer", "flash.utils.clearTimeout", "flash.utils.setTimeout", "yishi.utils.GraphicsUtils"];

defs["com.map.vehicle.view.VehicleSkillCDNumView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __VehicleSkillCDNumView extends __Base {
    static $fields(self) {
    self._numContainer = null;
    }
    constructor() {
         var _loc1_ = null;
         super();
         if(!__VehicleSkillCDNumView._redNumBmd)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehicle.SkillCDNumRed");
            __VehicleSkillCDNumView._redNumBmd = _loc1_.bitmapData;
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehicle.SkillCDNumYellow");
            if(__VehicleSkillCDNumView._yellowNumBmd)
            {
               __VehicleSkillCDNumView._yellowNumBmd.dispose();
            }
            __VehicleSkillCDNumView._yellowNumBmd = null;
            __VehicleSkillCDNumView._yellowNumBmd = _loc1_.bitmapData;
            _loc1_ = null;
         }
         this._numContainer = new ($.C("flash.display.Sprite"))();
         this.addChild(this._numContainer);
      }
    dispose() {
         if(__VehicleSkillCDNumView._yellowNumBmd)
         {
            __VehicleSkillCDNumView._yellowNumBmd.dispose();
         }
         __VehicleSkillCDNumView._yellowNumBmd = null;
         if(__VehicleSkillCDNumView._redNumBmd)
         {
            __VehicleSkillCDNumView._redNumBmd.dispose();
         }
         __VehicleSkillCDNumView._redNumBmd = null;
         while(this._numContainer.numChildren > 0)
         {
            this._numContainer.removeChildAt(0);
         }
         if(this._numContainer && this._numContainer.parent)
         {
            this.removeChild(this._numContainer);
         }
         this._numContainer = null;
      }
    setNum(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         while(this._numContainer.numChildren > 0)
         {
            this._numContainer.removeChildAt(0);
         }
         var _loc2_ = __VehicleSkillCDNumView._yellowNumBmd;
         if(param1 < 10)
         {
            _loc2_ = __VehicleSkillCDNumView._redNumBmd;
         }
         $.C("yishi.utils.NumberViewUtils").getNumberView(param1,this._numContainer,_loc2_,22,28,22,22,"0123456789.",1);
         this._numContainer.x = (44 - this._numContainer.width) * 0.5;
         this._numContainer.y = (44 - this._numContainer.height) * 0.5;
      }
  }
  $.meta(__VehicleSkillCDNumView, "com.map.vehicle.view.VehicleSkillCDNumView", ["Disposeable"]);
  $.statics(__VehicleSkillCDNumView, () => {
    __VehicleSkillCDNumView._redNumBmd = null;
    __VehicleSkillCDNumView._yellowNumBmd = null;
  });
  return __VehicleSkillCDNumView;
}
deps["com.map.vehicle.view.VehicleSkillCDNumView"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "yishi.utils.NumberViewUtils"];

defs["com.map.vehicle.view.VehicleSkillIcon"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __VehicleSkillIcon extends __Base {
    static $fields(self) {
    self._asset = null;
    self._buttonSkiner = null;
    self._cdEffect = null;
    self._cdNumView = null;
    self._closeImage = null;
    self._data = null;
    self._frameFilter = null;
    self._glowMc = null;
    self._icon = null;
    self._iconContainer = null;
    self._key = null;
    self._mouseEventMc = null;
    self._state = 0;
    self.skillTempId = 0;
    }
    constructor(param1) {
         $.pre(new.target, (__s) => {
         __s._key = param1;
         });
         super();
         $.preFlush(this, new.target);
         this.init();
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this.mouseEnabled = this.mouseChildren = true;
         if(param1)
         {
            if(param1.tempalte)
            {
               if(this.key == "2" && param1.tempalte.InjuryEffect == 3)
               {
                  this.removeEvent();
                  this.mouseEnabled = this.mouseChildren = false;
                  if(this._icon.icon != this._closeImage)
                  {
                     this._icon.icon = this._closeImage;
                  }
                  this.hideCD();
               }
               else if(!this._data || this._data && param1.tempalte.TemplateId != this.skillTempId)
               {
                  if(this._cdEffect)
                  {
                     this._cdEffect.dispose();
                  }
                  this._cdEffect = new ($.C("com.map.vehicle.view.VehicleSkillCDEffect"))(param1.tempalte.CoolDown,$.bind(this, "cdCompleteHandler"),$.bind(this, "updateCD"));
                  this._cdEffect.visible = false;
                  this._asset.icon_pos.addChild(this._cdEffect);
                  this.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(param1.tempalte.Icons);
                  this._icon.tipData = param1.tempalte;
                  this.skillTempId = param1.templateId;
                  this.hideCD();
               }
            }
            else
            {
               this.icon = null;
               this.hideCD();
            }
         }
         else
         {
            this.icon = null;
            this.hideCD();
            if(this._cdEffect)
            {
               this._cdEffect.dispose();
            }
         }
         this._data = param1;
         this.addEvent();
      }
    dispose() {
         this.removeEvent();
         if(this._buttonSkiner)
         {
            this._buttonSkiner.dispose();
         }
         this._buttonSkiner = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._closeImage);
         this._closeImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    hideCD() {
         if(this._cdNumView && this._cdNumView.parent)
         {
            this._cdNumView.parent.removeChild(this._cdNumView);
         }
      }
    get icon() {
         if(this._icon)
         {
            return String(this._icon.icon);
         }
         return null;
      }
    set icon(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._icon)
         {
            if(this.icon != param1)
            {
               this._icon.icon = param1;
            }
         }
      }
    get isCding() {
         if(this._cdEffect)
         {
            return this._cdEffect.isCding;
         }
         return false;
      }
    get key() {
         return this._key;
      }
    showCD() {
         if(this._cdNumView && !this._cdNumView.parent)
         {
            this._asset.icon_pos.addChild(this._cdNumView);
         }
      }
    startCD(param1 = 0, param2 = -1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(!this._data)
         {
            return;
         }
         if(this._cdEffect)
         {
            this._cdEffect.start(param1,param2);
            this._cdEffect.visible = true;
            this.showCD();
         }
      }
    get state() {
         return this._state;
      }
    set state(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._state = param1;
      }
    updateCD() {
         if(this._cdNumView)
         {
            this._cdNumView.setNum(this._cdEffect.getLeftTime());
         }
      }
    __disable() {
      }
    __enable() {
      }
    __iconClick(param1) {
         var _loc2_ = 0;
         if(this.isCding)
         {
            return;
         }
         switch(this._key)
         {
            case "1":
               _loc2_ = 49;
               break;
            case "2":
               _loc2_ = 50;
               break;
            case "Q":
               _loc2_ = 81;
         }
         $.C("com.map.vehicle.net.VehicleSocketManager").instance.controller.vehicleWorld.characterController.keyDownHandler(_loc2_);
      }
    __mouseDown() {
      }
    __normal(param1) {
         this._icon.filters = this._frameFilter[0];
      }
    __onMouseOver(param1) {
         this._icon.filters = this._frameFilter[1];
      }
    __skillInfoChangeHandler(param1) {
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "__iconClick"));
         if(!this._buttonSkiner)
         {
            this._buttonSkiner = new ($.C("yishi.utils.ButtonSkiner"))(this._icon);
            this._buttonSkiner.onDownView = $.bind(this, "__mouseDown");
            this._buttonSkiner.onNormalView = $.bind(this, "__normal");
            this._buttonSkiner.onOverView = $.bind(this, "__onMouseOver");
            this._buttonSkiner.onDisableView = $.bind(this, "__disable");
            this._buttonSkiner.onEnableView = $.bind(this, "__enable");
         }
      }
    cdCompleteHandler() {
         this._cdEffect.visible = false;
         this._iconContainer.gotoAndPlay(2);
         this.hideCD();
      }
    clean() {
         if(this._icon && this._icon.parent)
         {
            this._icon.parent.removeChild(this._icon);
         }
      }
    init() {
         this._asset = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.vehicle.BattleSkillItemAsset");
         this._asset.countTxt.selectable = false;
         $.cast($.C("flash.text.TextField"), this._asset.countTxt).defaultTextFormat = new ($.C("flash.text.TextFormat"))(null,13,16777215,true);
         this.addChild(this._asset);
         this._asset.y = -5;
         this._iconContainer = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehicle.SkillItemCDFlashAsset");
         this._asset.icon_pos.addChild(this._iconContainer);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("vehicle.SkillItemView");
         this._iconContainer.container.addChild(this._icon);
         this._icon.buttonMode = true;
         this._asset.flash_effect.visible = false;
         this._asset.flash_effect.mouseChildren = this._asset.flash_effect.mouseEnabled = false;
         this._glowMc = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.vehicle.GlowMc");
         this._glowMc.mouseEnabled = this._glowMc.mouseChildren = false;
         this._glowMc.gotoAndStop(1);
         this.addChild(this._glowMc);
         this._mouseEventMc = $.C("com.pickgliss.utils.ClassUtils").CreatInstance("asset.vehicle.OverMc");
         this._mouseEventMc.mouseEnabled = this._mouseEventMc.mouseChildren = false;
         this._mouseEventMc.gotoAndStop(1);
         this._mouseEventMc.x = -1;
         this._mouseEventMc.y = -1;
         this._asset.icon_pos.addChild(this._mouseEventMc);
         this._cdNumView = new ($.C("com.map.vehicle.view.VehicleSkillCDNumView"))();
         this._cdNumView.mouseChildren = this._cdNumView.mouseEnabled = false;
         this._asset.countMc.visible = true;
         this._asset.countTxt.text = this._key;
         this._frameFilter = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatFrameFilters("core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter");
         this._closeImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehicle.SkillItemClose");
      }
    onKeyDown(param1) {
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__iconClick"));
      }
    set isCding(v) { super.isCding = v; }
    set key(v) { super.key = v; }
  }
  $.meta(__VehicleSkillIcon, "com.map.vehicle.view.VehicleSkillIcon", ["Disposeable"]);
  return __VehicleSkillIcon;
}
deps["com.map.vehicle.view.VehicleSkillIcon"] = ["com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.view.VehicleSkillCDEffect", "com.map.vehicle.view.VehicleSkillCDNumView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ClassUtils", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.text.TextField", "flash.text.TextFormat", "yishi.utils.ButtonSkiner", "yishi.utils.IconFactory"];

defs["com.map.vehicle.view.VehicleSkillMovie"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __VehicleSkillMovie extends __Base {
    static $fields(self) {
    self._mc = null;
    self._totalFrame = 1;
    self._currentFrame = 1;
    self._className = null;
    self._count = 0;
    self._curCount = 0;
    self.type = 0;
    }
    constructor(param1, param2, param3 = 1) {
         super();
         this._className = param1;
         this._mc = param2;
         this._count = param3;
         this._mc.gotoAndStop(1);
         if(this._mc.hasOwnProperty("type"))
         {
            this.type = this._mc["type"];
         }
         if(this.stage)
         {
            this.init();
         }
         else
         {
            this.addEventListener("addedToStage",$.bind(this, "__onStage"));
         }
         this.mouseChildren = this.mouseEnabled = false;
      }
    __onStage(param1) {
         this.init();
      }
    init() {
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
         this._mc.gotoAndStop(1);
         this._currentFrame = 1;
         this._totalFrame = this._mc.totalFrames;
         this._curCount = 0;
         this.addChild(this._mc);
      }
    enterFrame() {
         if(this._currentFrame > this._totalFrame)
         {
            this._curCount = this._curCount + 1;
            if(this._count > 0 && this._curCount >= this._count)
            {
               this.end();
               return;
            }
            this._currentFrame = 1;
         }
         this._mc.gotoAndStop(this._currentFrame);
         this._currentFrame = this._currentFrame + 1;
      }
    end() {
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
         if($.C("yishi.scene.SceneManager").instance.currentType == "VEHICLE")
         {
            $.C("com.map.vehicle.SkillEffectFactory").instance.recycle(this._className,this);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this._mc)
         {
            this._mc.gotoAndStop(1);
            this._totalFrame = this._mc.totalFrames;
         }
         this._currentFrame = 1;
         this._curCount = 0;
         this.setSoundTransform($.C("com.map.vehicle.data.VGlobal").volume0);
      }
    set autoDispose(param1) {
         if(param1)
         {
            this._count = 1;
         }
         else
         {
            this._count = -1;
         }
      }
    addMask() {
      }
    setSkillWidth(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if(this._mc)
         {
            this._mc.width = param1;
         }
      }
    setSoundTransform(param1) {
         if(this._mc)
         {
            this._mc.soundTransform = param1;
         }
         else
         {
            this.soundTransform = param1;
         }
      }
    dispose() {
         this.removeEventListener("addedToStage",$.bind(this, "__onStage"));
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._mc);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get autoDispose() { return super.autoDispose; }
  }
  $.meta(__VehicleSkillMovie, "com.map.vehicle.view.VehicleSkillMovie", ["Disposeable", "IEnterFrame"]);
  return __VehicleSkillMovie;
}
deps["com.map.vehicle.view.VehicleSkillMovie"] = ["com.map.vehicle.SkillEffectFactory", "com.map.vehicle.data.VGlobal", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.EnterFrameManager", "yishi.scene.SceneManager"];

defs["com.map.vehicle.view.VehicleSortItemView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleSortItemView extends __Base {
    static $fields(self) {
    self._data = null;
    self._flag = null;
    self._index = 0;
    self._nameTxt = null;
    self._numTxt = null;
    self._scoreTxt = null;
    }
    constructor(param1) {
         super();
         this._index = param1;
         this.height = 25;
         this.mouseChildren = this.mouseEnabled = false;
         this.initView();
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         if(this._data && this._data.name)
         {
            this._numTxt.text = String(this._index) + ".";
            this._nameTxt.text = this._data.name;
            this._scoreTxt.text = String(this._data.score);
            this._flag.visible = true;
            this._flag.setFrame(this._data.team);
            if(this._index >= 4)
            {
               this._numTxt.setFrame(4);
               this._nameTxt.setFrame(4);
               this._scoreTxt.setFrame(4);
            }
            else
            {
               this._numTxt.setFrame(this._index);
               this._nameTxt.setFrame(this._index);
               this._scoreTxt.setFrame(this._index);
            }
         }
         else
         {
            this._numTxt.text = "";
            this._nameTxt.text = "";
            this._scoreTxt.text = "";
            this._flag.visible = false;
         }
      }
    dispose() {
         this.uintView();
         super.dispose();
      }
    initView() {
         this._numTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.numTxt");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.nameTxt");
         this._scoreTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap_right.scoreTxt");
         this._flag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.teamFlag");
         this._flag.width = this._flag.height = 20;
         this._flag.x = 7;
         this._flag.y = 0;
         this.addChild(this._numTxt);
         this.addChild(this._flag);
         this.addChild(this._nameTxt);
         this.addChild(this._scoreTxt);
      }
    uintView() {
         this._numTxt = null;
         this._nameTxt = null;
         this._scoreTxt = null;
      }
  }
  $.meta(__VehicleSortItemView, "com.map.vehicle.view.VehicleSortItemView", []);
  return __VehicleSortItemView;
}
deps["com.map.vehicle.view.VehicleSortItemView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component"];

defs["com.map.vehicle.view.VehicleTeamChatPopView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleTeamChatPopView extends __Base {
    static $fields(self) {
    self._back = null;
    self._chatTxt = null;
    }
    constructor() {
         super();
      }
    init() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehicle.ChatPopLeft");
         this._chatTxt = new ($.C("chat.view.ExpressionChatNotic"))();
         this._chatTxt.x = 29;
         this._chatTxt.y = 9;
         this._chatTxt.lineWidth = 340;
         this.addChild(this._back);
         this.addChild(this._chatTxt);
         this.mouseChildren = this.mouseEnabled = false;
      }
    setChatData(param1) {
         if(!param1)
         {
            return;
         }
         var _loc3_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("chat.datas.ChatData")), $.C("chat.datas.ChatData"));
         $.C("com.pickgliss.utils.ObjectUtils").copyProperties(_loc3_,param1,true);
         var _loc2_ = $.int($.C("yishi.utils.StringHelper").checkStringLength(_loc3_.getNormalMsg()));
         if(_loc2_ <= 20)
         {
            this._chatTxt.x = (this._back.width - _loc2_ * 7.5) / 2;
            this._chatTxt.lineWidth = _loc2_ * 8;
         }
         _loc3_.msg = $.C("chat.ChatManager").instance.analyzeExpressionAfterNormal(_loc3_.msg);
         _loc3_.channel = 8;
         _loc3_.chatItemData.cellVector = $.C("chat.utils.ChatFormat").getContentCellData(_loc3_);
         this._chatTxt.needFilters = false;
         this._chatTxt.data = _loc3_;
         this._chatTxt.y = 10 + (50 - this._chatTxt.height) / 2;
      }
    dispose() {
         this._back = null;
         this._chatTxt = null;
         super.dispose();
      }
  }
  $.meta(__VehicleTeamChatPopView, "com.map.vehicle.view.VehicleTeamChatPopView", []);
  return __VehicleTeamChatPopView;
}
deps["com.map.vehicle.view.VehicleTeamChatPopView"] = ["chat.ChatManager", "chat.datas.ChatData", "chat.utils.ChatFormat", "chat.view.ExpressionChatNotic", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "yishi.utils.StringHelper"];

defs["com.map.vehicle.view.VehicleTeamItemView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleTeamItemView extends __Base {
    static $fields(self) {
    self._bloodBack = null;
    self._bloodMc = null;
    self._data = null;
    self._gradeTxt = null;
    self._head = null;
    self._nameTxt = null;
    self._rect = new ($.C("flash.geom.Rectangle"))(0,0,88,70);
    self._chatPopView = null;
    self._timeId = 0;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s.width = 88;
         __s.height = 70;
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
         this.addEvent();
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this.removeEvent();
         this._data = param1;
         this.update();
         this.addEvent();
      }
    dispose() {
         if(this._chatPopView)
         {
            this._chatPopView.dispose();
            this._chatPopView = null;
         }
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
         }
         this._timeId = 0;
         this.removeEvent();
         this.uintView();
         super.dispose();
      }
    update() {
         var _loc1_ = null;
         var _loc2_ = 0;
         this._head.visible = false;
         if(this._data)
         {
            this.visible = true;
            this._nameTxt.text = this._data.name;
            this._gradeTxt.text = String(this._data.grade);
            _loc1_ = $.C("yishi.utils.IconFactory").getVehicleHeadIcon(this._data.templateId);
            if(_loc1_ != this._head.icon)
            {
               this._head.icon = _loc1_;
            }
            this._head.visible = true;
            _loc2_ = this._data.hp * 100 / this._data.totalHp;
            this._bloodMc.gotoAndStop(_loc2_);
         }
         else
         {
            this.visible = false;
            this._nameTxt.text = "";
            this._gradeTxt.text = "";
            this._head.icon = null;
            this._bloodMc.gotoAndStop(0);
         }
      }
    get viewRectangle() {
         return this._rect;
      }
    addEvent() {
         if(this._data)
         {
            this._data.addEventListener("CHAT_DATA",$.bind(this, "__showChatPopHandler"));
         }
      }
    removeEvent() {
         if(this._data)
         {
            this._data.removeEventListener("CHAT_DATA",$.bind(this, "__showChatPopHandler"));
         }
      }
    __showChatPopHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("chat.datas.ChatData"));
         if(this._chatPopView)
         {
            this._chatPopView.dispose();
            this._chatPopView = null;
         }
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
         }
         this._chatPopView = new ($.C("com.map.vehicle.view.VehicleTeamChatPopView"))();
         this._chatPopView.x = 83;
         this._chatPopView.y = 0;
         this._chatPopView.setChatData(_loc2_);
         this.addChild(this._chatPopView);
         this._timeId = $.C("flash.utils.setTimeout")($.bind(this, "closePopView"),3000);
      }
    closePopView() {
         if(this._timeId != 0)
         {
            $.C("flash.utils.clearTimeout")(this._timeId);
         }
         this._timeId = 0;
         if(this._chatPopView)
         {
            this._chatPopView.dispose();
            this._chatPopView = null;
         }
      }
    initView() {
         var _loc1_ = 0;
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.teamGrade");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.teamNameTxt");
         this._head = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("vehiclemap.teamHead");
         this._bloodBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.TeamBloodBack");
         this._bloodMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.vehiclemap.TeamBlood");
         this._bloodMc.gotoAndStop(80);
         this._bloodMc.x = 14;
         this._bloodMc.y = 43;
         this.addChild(this._bloodBack);
         this.addChild(this._bloodMc);
         this.addChild(this._gradeTxt);
         this.addChild(this._nameTxt);
         this.addChild(this._head);
         if($.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo)
         {
            _loc1_ = $.C("com.map.vehicle.data.VGlobal").model.selfVehicleInfo.team;
         }
      }
    uintView() {
      }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__VehicleTeamItemView, "com.map.vehicle.view.VehicleTeamItemView", ["IManualSize"]);
  return __VehicleTeamItemView;
}
deps["com.map.vehicle.view.VehicleTeamItemView"] = ["chat.datas.ChatData", "com.map.vehicle.data.VGlobal", "com.map.vehicle.view.VehicleTeamChatPopView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "flash.geom.Rectangle", "flash.utils.clearTimeout", "flash.utils.setTimeout", "yishi.utils.IconFactory"];

defs["com.map.vehicle.view.VehicleTeamView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleTeamView extends __Base {
    static $fields(self) {
    self._back = null;
    self._flag = null;
    self._hideBtn = null;
    self._isHide = false;
    self._itemList = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._rect = null;
    self._sprite = null;
    self._teamTxt = null;
    self._tween = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.update();
      }
    dispose() {
         if(this._tween)
         {
            this._tween.kill();
            this._tween = null;
         }
         this.removeEvent();
         this.uintView();
         super.dispose();
         this._model = null;
      }
    resize() {
         var _loc1_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this.x = 0;
         this.y = 300;
      }
    show() {
         this.resize();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4,false,false,0,3);
      }
    __addPlayerHandler(param1) {
         if(this._model.selfVehicleInfo)
         {
            this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
            if(this._flag)
            {
               this._flag.setFrame(this._model.selfVehicleInfo.team);
            }
         }
      }
    __hideClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._tween)
         {
            this._tween.kill();
            this._tween = null;
         }
         if(this._isHide)
         {
            this._isHide = false;
            this._hideBtn.scaleX = -1;
            this._hideBtn.x = 6 + this._hideBtn.displayWidth;
            this._tween = $.C("com.greensock.TweenMax").to(this._rect,0.3,{
               "height":203,
               "width":87,
               "onUpdate":$.bind(this, "onTween"),
               "onComplete":$.bind(this, "onCompleteHander")
            });
            this._sprite.y = 32;
         }
         else
         {
            this._isHide = true;
            this._hideBtn.scaleX = 1;
            this._hideBtn.x = 6;
            this._tween = $.C("com.greensock.TweenMax").to(this._rect,0.3,{
               "height":0,
               "width":0,
               "onUpdate":$.bind(this, "onTween")
            });
         }
      }
    onTween() {
         this._sprite.mask = this._rect;
      }
    onCompleteHander() {
         this._sprite.mask = null;
      }
    __removePlayerHandler(param1) {
         for (var _loc2_ of $.values(this._itemList))
         {
            if(_loc2_.data == param1.data)
            {
               _loc2_.data = null;
            }
         }
         this.update();
      }
    __updateListHandler(param1) {
         this.update();
      }
    addEvent() {
         this._model.addEventListener("PLAYE_LIST_UPDATE",$.bind(this, "__updateListHandler"));
         this._model.addEventListener("remove_player",$.bind(this, "__removePlayerHandler"));
         this._hideBtn.addEventListener("click",$.bind(this, "__hideClickHandler"));
      }
    initView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.TeamBack");
         this._teamTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.TeamText");
         this._hideBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.HideBtn");
         this._flag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.teamFlag");
         this._flag.x = 78;
         this._flag.y = 2;
         this._sprite = new ($.C("flash.display.Sprite"))();
         this._sprite.x = 4;
         this._sprite.y = 32;
         this.addChild(this._back);
         this.addChild(this._teamTxt);
         this.addChild(this._hideBtn);
         this.addChild(this._flag);
         this.addChild(this._sprite);
         this._itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new ($.C("com.map.vehicle.view.VehicleTeamItemView"))();
            this._sprite.addChild(_loc1_);
            _loc1_.y = _loc2_ * 67;
            this._itemList.push(_loc1_);
            _loc2_++;
         }
         this._rect = new ($.C("flash.display.Shape"))();
         this._rect.graphics.beginFill(0,0);
         this._rect.graphics.drawRect(0,0,87,203);
         this._rect.graphics.endFill();
         this._rect.x = 4;
         this._rect.y = 32;
         this.addChild(this._rect);
         this._hideBtn.scaleX = -1;
         this._hideBtn.x = 6 + this._hideBtn.displayWidth;
         if(this._model.selfVehicleInfo)
         {
            this._flag.setFrame(this._model.selfVehicleInfo.team);
         }
         else
         {
            this._model.addEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         }
      }
    removeEvent() {
         if(this._model)
         {
            this._model.removeEventListener("PLAYE_LIST_UPDATE",$.bind(this, "__updateListHandler"));
            this._model.removeEventListener("remove_player",$.bind(this, "__removePlayerHandler"));
            this._model.removeEventListener("addPlayer",$.bind(this, "__addPlayerHandler"));
         }
         if(this._hideBtn)
         {
            this._hideBtn.removeEventListener("click",$.bind(this, "__hideClickHandler"));
         }
      }
    uintView() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._flag);
         this._flag = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._sprite);
         this._sprite = null;
         this._itemList = null;
         this._teamTxt = null;
         this._back = null;
      }
    update() {
         var _loc3_ = 0;
         var _loc2_ = null;
         var _loc1_ = this._model.getTeamMembers();
         _loc3_ = 0;
         while(_loc3_ < this._itemList.length)
         {
            _loc2_ = this._itemList[_loc3_];
            _loc2_.data = _loc1_[_loc3_];
            _loc3_++;
         }
      }
  }
  $.meta(__VehicleTeamView, "com.map.vehicle.view.VehicleTeamView", []);
  return __VehicleTeamView;
}
deps["com.map.vehicle.view.VehicleTeamView"] = ["com.greensock.TweenMax", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.view.VehicleTeamItemView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Shape", "flash.display.Sprite"];

defs["com.map.vehicle.view.VehicleTopView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleTopView extends __Base {
    static $fields(self) {
    self._back = null;
    self._blueFlag = null;
    self._blueTxt = null;
    self._countTime = null;
    self._countTimeBg = null;
    self._model = $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
    self._redFlag = null;
    self._redTxt = null;
    self._started = false;
    }
    constructor() {
         super();
         this.width = 342;
         this.height = 35;
         this.initView();
         this.addEvent();
         this.mouseChildren = this.mouseEnabled = false;
      }
    dispose() {
         this.removeEvent();
         this.uintView();
         if(this._countTime)
         {
            this._countTime.dispose();
         }
         this._countTime = null;
         super.dispose();
      }
    resize() {
         var _loc1_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc2_ = $.int($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this.x = (_loc1_ - this.width) / 2;
         this.y = 0;
      }
    show() {
         this.resize();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4,false,false,0,0);
      }
    __completeHandler(param1) {
         this._countTime.removeEventListener("complete",$.bind(this, "__completeHandler"));
         this._model.remainsTime = 0;
      }
    __scoreChangeHandler(param1) {
         this.update();
      }
    addEvent() {
         if(this._model)
         {
            this._model.addEventListener("SCORE_CHANGE",$.bind(this, "__scoreChangeHandler"));
         }
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.TopBack");
         this._redFlag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.RedFlag");
         this._blueFlag = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.BlueFlag");
         this._redTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.redScoreTxt");
         this._blueTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vehiclemap.blueScoreTxt");
         this._countTimeBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.vehiclemap.TeamCountBack");
         this._countTime = new ($.C("com.map.vehicle.view.VehicleDownTimeView"))(2);
         this._countTime.x = 70;
         this._countTime.y = 10;
         this.addChild(this._back);
         this.addChild(this._redFlag);
         this.addChild(this._blueFlag);
         this.addChild(this._redTxt);
         this.addChild(this._blueTxt);
         this.addChild(this._countTimeBg);
         this.addChild(this._countTime);
         this._countTimeBg.x = -7;
         this._redFlag.x = 70;
         this._blueFlag.x = 174;
         this._countTimeBg.visible = false;
         this._countTime.visible = false;
         this.update();
      }
    removeEvent() {
         if(this._model)
         {
            this._model.removeEventListener("SCORE_CHANGE",$.bind(this, "__scoreChangeHandler"));
         }
         if(this._countTime)
         {
            this._countTime.removeEventListener("complete",$.bind(this, "__completeHandler"));
         }
      }
    uintView() {
         this._back = null;
         this._redFlag = null;
         this._blueFlag = null;
         this._redTxt = null;
         this._blueTxt = null;
      }
    update() {
         this._redTxt.text = String(this._model.redScore);
         this._blueTxt.text = String(this._model.blueScore);
         if(this._model.remainsTime > 0)
         {
            if(!this._started)
            {
               this._started = true;
               this._countTime.visible = true;
               this._countTimeBg.visible = true;
               this._countTime.count = this._model.remainsTime;
               this._countTime.addEventListener("complete",$.bind(this, "__completeHandler"));
            }
         }
      }
  }
  $.meta(__VehicleTopView, "com.map.vehicle.view.VehicleTopView", []);
  return __VehicleTopView;
}
deps["com.map.vehicle.view.VehicleTopView"] = ["com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.view.VehicleDownTimeView", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component"];

defs["com.map.vehicle.view.tips.VehicleBuffTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __VehicleBuffTip extends __Base {
    static $fields(self) {
    self._nameSprite = null;
    self._totalBox = null;
    self._injuryTxt = null;
    self._nameTxt = null;
    self._castTime = null;
    self._coolDown = null;
    self._descTxt = null;
    self._timer = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.totalVBox");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt1");
         this._injuryTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt2");
         this._injuryTxt.x = -30;
         this._castTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._coolDown = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._descTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.DescTxt");
         this._nameSprite = new ($.C("flash.display.Sprite"))();
         this._bg.width = 195;
         this.addChild(this._totalBox);
      }
    $$updateTransform() {
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc1_ = null;
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
         this._totalBox.removeAllChild();
         super.$$updateTransform();
         if(this.tipData)
         {
            if($.is(this.tipData, $.C("yishi.datas.templates.VehicleSkillTempInfo")))
            {
               _loc3_ = $.as(this.tipData, $.C("yishi.datas.templates.VehicleSkillTempInfo"));
               this._nameTxt.text = _loc3_.TemplateName;
               this._injuryTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.DaimonSkillTip.injuryTxt" + _loc3_.InjuryEffect);
               this._castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.castTime",_loc3_.CastTime / 1000);
               this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown / 1000);
               this._descTxt.htmlText = _loc3_.Description;
               this._nameSprite.addChild(this._nameTxt);
               this._nameSprite.addChild(this._injuryTxt);
               this._totalBox.addChild(this._nameSprite);
               if(_loc3_.InjuryEffect == 3)
               {
                  this._totalBox.addChild(this._descTxt);
               }
               else
               {
                  this._totalBox.addChild(this._castTime);
                  this._totalBox.addChild(this._coolDown);
                  this._totalBox.addChild(this._descTxt);
               }
            }
            else if($.is(this.tipData, $.C("com.map.vehicle.data.VehicleBufferDamageInfo")))
            {
               _loc2_ = $.as(this.tipData, $.C("com.map.vehicle.data.VehicleBufferDamageInfo"));
               _loc1_ = _loc2_.buffTemplate;
               this._nameTxt.text = _loc1_.Name;
               this._descTxt.htmlText = _loc1_.Description;
               this._castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",$.int(_loc1_.Duration / 1000));
               this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",_loc2_.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
               this._timer = new ($.C("flash.utils.Timer"))(1000);
               this._timer.start();
               this._timer.addEventListener("timer",$.bind(this, "__onTimerHandler"));
               this._totalBox.addChild(this._nameTxt);
               this._totalBox.addChild(this._castTime);
               this._totalBox.addChild(this._coolDown);
               this._totalBox.addChild(this._descTxt);
            }
            this._totalBox.refreshChildPos();
            this._bg.height = this._descTxt.y + this._descTxt.textHeight + 20;
            this._bg.width = this._totalBox.width + 10;
         }
      }
    __onTimerHandler(param1) {
         var _loc2_ = null;
         if(this.tipData)
         {
            _loc2_ = $.as(this.tipData, $.C("com.map.vehicle.data.VehicleBufferDamageInfo"));
            if(this._coolDown)
            {
               this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",_loc2_.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
            }
         }
      }
    dispose() {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._nameTxt = null;
         this._descTxt = null;
         this._injuryTxt = null;
         this._nameSprite = null;
         this._castTime = null;
         this._coolDown = null;
         super.dispose();
      }
  }
  $.meta(__VehicleBuffTip, "com.map.vehicle.view.tips.VehicleBuffTip", []);
  return __VehicleBuffTip;
}
deps["com.map.vehicle.view.tips.VehicleBuffTip"] = ["com.map.vehicle.data.VehicleBufferDamageInfo", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Timer", "manager.LanguageMgr", "yishi.datas.templates.VehicleSkillTempInfo", "yishi.view.tips.BaseTip"];

defs["com.road.mapengine.ai.astar.AIManager"] = function define($) {
  const __Base = $.Object;
  class __AIManager extends __Base {
    static $fields(self) {
    self._finPath = null;
    self._algUtils = null;
    self._neterFrameCount = 0;
    }
    constructor() {
         super();
      }
    static get instance() {
         if(!__AIManager._instance)
         {
            __AIManager._instance = new (__AIManager)();
         }
         return __AIManager._instance;
      }
    set data(param1) {
         var _loc2_ = param1.mapTempInfo.Width / 20;
         var _loc3_ = param1.mapTempInfo.Height / 20;
         this._finPath = new ($.C("map.internals.findPath.FindPath8"))(_loc2_,_loc3_,param1.mapTielsData,true);
         this._algUtils = new ($.C("map.internals.findPath.AcorrsLineGrid"))(this._finPath,param1);
      }
    find(param1, param2) {
         var _loc3_ = this._finPath.find(param1,param2);
         return this._algUtils.getPsnode2(_loc3_);
      }
    enterFrame() {
         this._neterFrameCount = this._neterFrameCount + 1;
         if(this._neterFrameCount % 20 == 0)
         {
            this.lockNpc();
            this.sendNpcsPoint();
         }
      }
    sendNpcsPoint() {
      }
    lockNpc() {
      }
    static set instance(v) { super.instance = v; }
    get data() { return super.data; }
  }
  $.meta(__AIManager, "com.road.mapengine.ai.astar.AIManager", []);
  $.statics(__AIManager, () => {
    __AIManager._instance = null;
  });
  return __AIManager;
}
deps["com.road.mapengine.ai.astar.AIManager"] = ["map.internals.findPath.AcorrsLineGrid", "map.internals.findPath.FindPath8"];

defs["com.road.mapengine.ai.astar.AvatarPathWalkAi"] = function define($) {
  const __Base = $.C("com.road.mapengine.ai.astar.BasePathWalkAi");
  class __AvatarPathWalkAi extends __Base {
    static $fields(self) {
    self._avatar = null;
    self._moveAngel = NaN;
    self._moveX = NaN;
    self._moveY = NaN;
    self._tempNextPoint = new ($.C("flash.geom.Point"))();
    self._notePaths = [];
    self._walkStep = 0;
    }
    constructor(param1 = null) {
         super(param1);
      }
    get moveAngel() {
         var _loc1_ = this._moveAngel / 3.141592653589793 * 180;
         return _loc1_ < 0 ? _loc1_ + 360 : _loc1_;
      }
    get avatar() {
         return this._avatar;
      }
    set avatar(param1) {
         this._avatar = param1;
      }
    nextFrame() {
         super.nextFrame();
         this._avatar.x += this._moveX;
         this._avatar.y += this._moveY;
      }
    nextPoint(param1) {
         this._tempNextPoint.x = param1.x * 20 + 10;
         this._tempNextPoint.y = param1.y * 20 + 10;
         super.nextPoint(this._tempNextPoint);
         var _loc3_ = this._tempNextPoint.x - this._avatar.x;
         var _loc4_ = this._tempNextPoint.y - this._avatar.y;
         this._moveAngel = Math.atan2(_loc4_,_loc3_);
         this._moveX = this._avatar.speed * Math.cos(this._moveAngel);
         this._moveY = this._avatar.speed * Math.sin(this._moveAngel);
         this._avatar.angle = this.moveAngel;
         var _loc2_ = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
         this._totalFrame = Math.ceil(_loc2_ / this._avatar.speed);
         this.nextFrame();
         this.nodePaths(param1);
      }
    nodePaths(param1) {
         var _loc3_ = 0;
         var _loc2_ = null;
         var _loc4_ = 0;
         if(($.as(this._avatar, $.C("com.map.vehicle.objects.TankAvatarView"))).data.playerId != $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         if(this._walkStep == 0)
         {
            _loc3_ = this._index + 3;
            if(_loc3_ > this._paths.length)
            {
               _loc3_ = $.int(this._paths.length);
            }
            _loc2_ = this.paths.slice(this._index,_loc3_);
            _loc4_ = ($.as(this._avatar, $.C("com.map.vehicle.objects.TankAvatarView"))).data.playerId;
            $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendCampaignArmyMove(_loc4_,_loc2_);
         }
         this._walkStep = this._walkStep + 1;
         if(this._walkStep >= 2)
         {
            this._walkStep = 0;
         }
      }
    walkOver() {
         super.walkOver();
         this._avatar.state = 3;
         var _loc3_ = ($.as(this._avatar, $.C("com.map.vehicle.objects.TankAvatarView"))).data.playerId;
         if(_loc3_ != $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         this._walkStep = 0;
         this.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("WALK_OVER",null));
         var _loc1_ = new ($.C("flash.geom.Point"))($.int(this._avatar.x / 20),$.int(this._avatar.y / 20));
         $.C("com.map.vehicle.net.VehicleSocketOutManager").instance.sendCampaignArmyMove(_loc3_,[_loc1_]);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("UPDATE_WALK_TARGET",null));
         if(!this.mapModel)
         {
            return;
         }
         var _loc2_ = this.mapModel.getHandlerNode(this._avatar.x / 20,this._avatar.y / 20);
         if(!_loc2_)
         {
            _loc2_ = this.goSelectPoint(this._avatar);
         }
         if(!_loc2_)
         {
            return;
         }
         _loc1_ = this.getResetPoint(_loc2_,this._avatar,new ($.C("flash.geom.Point"))($.int(this._avatar.x / 20),$.int(this._avatar.y / 20)));
         this.sendMessage(_loc1_,_loc2_);
      }
    goSelectPoint(param1) {
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc6_ = 0;
         var _loc2_ = $.C("com.map.vehicle.data.VGlobal").logicWorld.selectedLogic;
         if(_loc2_)
         {
            if($.is(_loc2_, $.C("com.map.vehicle.objects.VehicleBoxView")))
            {
               _loc5_ = ($.as(_loc2_, $.C("com.map.vehicle.objects.VehicleBoxView"))).data;
               if(_loc5_)
               {
                  if(_loc5_.state != 1)
                  {
                     _loc3_ = new ($.C("flash.geom.Point"))(param1.x,param1.y);
                     _loc4_ = new ($.C("flash.geom.Point"))(_loc5_.logicView.x,_loc5_.logicView.y);
                     _loc6_ = $.C("flash.geom.Point").distance(_loc3_,_loc4_);
                     if(_loc6_ < (_loc5_.handlerRange + 1) * 20)
                     {
                        return _loc5_;
                     }
                  }
               }
            }
         }
         return null;
      }
    getResetPoint(param1, param2, param3) {
         var _loc4_ = null;
         if(param1.resetPosX > 0 && param1.resetPosY > 0)
         {
            _loc4_ = new ($.C("flash.geom.Point"))(param1.resetPosX,param1.resetPosY);
         }
         else
         {
            _loc4_ = new ($.C("flash.geom.Point"))($.int(param2.x / 20),$.int(param2.y / 20));
         }
         return _loc4_;
      }
    sendMessage(param1, param2) {
         var _loc3_ = ($.as(this._avatar, $.C("com.map.vehicle.objects.TankAvatarView"))).data.playerId;
         if(param2.type != 0)
         {
            ($.as(this._avatar, $.C("com.map.vehicle.objects.TankAvatarView"))).data.pickup(param2);
         }
      }
    get mapModel() {
         return $.C("com.map.vehicle.net.VehicleSocketManager").instance.model;
      }
    set paths(param1) {
         super.paths = param1;
         if(this.paths && this.paths.length > 0)
         {
            this._avatar.state = 4;
         }
         else
         {
            $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("com.map.vehicle.events.VehicleEvent"))("UPDATE_WALK_TARGET",null));
            this._avatar.state = 3;
         }
      }
    set moveAngel(v) { super.moveAngel = v; }
    set mapModel(v) { super.mapModel = v; }
    get paths() { return super.paths; }
  }
  $.meta(__AvatarPathWalkAi, "com.road.mapengine.ai.astar.AvatarPathWalkAi", []);
  return __AvatarPathWalkAi;
}
deps["com.road.mapengine.ai.astar.AvatarPathWalkAi"] = ["com.map.vehicle.data.VGlobal", "com.map.vehicle.events.VehicleEvent", "com.map.vehicle.net.VehicleSocketManager", "com.map.vehicle.net.VehicleSocketOutManager", "com.map.vehicle.objects.TankAvatarView", "com.map.vehicle.objects.VehicleBoxView", "com.road.mapengine.ai.astar.BasePathWalkAi", "flash.geom.Point", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager"];

defs["com.road.mapengine.ai.astar.BasePathWalkAi"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __BasePathWalkAi extends __Base {
    static $fields(self) {
    self._paths = null;
    self._index = -1;
    self._curFrame = 0;
    self._totalFrame = 0;
    self._id = $.C("map.internals.utils.MapUtisl").instanceId;
    }
    constructor(param1 = null) {
         super(param1);
      }
    get id() {
         return this._id;
      }
    execute() {
         if(!this._paths)
         {
            return;
         }
         if(this._paths.length == 0)
         {
            this.walkOver();
            return;
         }
         if(this._paths.length > this._index)
         {
            if(this._curFrame < this._totalFrame)
            {
               this.nextFrame();
            }
            else
            {
               this._index = this._index + 1;
               if(this._index < this._paths.length)
               {
                  this.nextPoint(this._paths[this._index]);
               }
               else
               {
                  this.walkOver();
               }
            }
         }
         else
         {
            this.walkOver();
         }
      }
    nextFrame() {
         this._curFrame = this._curFrame + 1;
      }
    nextPoint(param1) {
         this._curFrame = 0;
      }
    walkOver() {
         this._index = -1;
         this._curFrame = 0;
         this._totalFrame = 0;
         this._paths = null;
      }
    get paths() {
         return this._paths;
      }
    set paths(param1) {
         this._index = -1;
         this._curFrame = 0;
         this._totalFrame = 0;
         this._paths = param1;
      }
    set id(v) { super.id = v; }
  }
  $.meta(__BasePathWalkAi, "com.road.mapengine.ai.astar.BasePathWalkAi", []);
  return __BasePathWalkAi;
}
deps["com.road.mapengine.ai.astar.BasePathWalkAi"] = ["flash.events.EventDispatcher", "map.internals.utils.MapUtisl"];

defs["com.road.mapengine.ai.vehicle.CircleBarrier"] = function define($) {
  const __Base = $.C("com.road.mapengine.ai.vehicle.Vehicle");
  class __CircleBarrier extends __Base {
    static $fields(self) {
    self._radius = NaN;
    }
    constructor() {
         super();
      }
    get radius() {
         return this._radius;
      }
    set radius(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._radius = param1;
      }
  }
  $.meta(__CircleBarrier, "com.road.mapengine.ai.vehicle.CircleBarrier", []);
  return __CircleBarrier;
}
deps["com.road.mapengine.ai.vehicle.CircleBarrier"] = ["com.road.mapengine.ai.vehicle.Vehicle"];

defs["com.road.mapengine.ai.vehicle.Vector2D"] = function define($) {
  const __Base = $.Object;
  class __Vector2D extends __Base {
    static $fields(self) {
    self.$$_x = NaN;
    self.$$_y = NaN;
    }
    constructor(param1 = 0, param2 = 0) {
         super();
         this.$$_x = param1;
         this.$$_y = param2;
      }
    static angleBetween(param1, param2) {
         if(!param1.isNormalized())
         {
            param1 = param1.clone().normalize();
         }
         if(!param2.isNormalized())
         {
            param2 = param2.clone().normalize();
         }
         return Math.acos(param1.dotProd(param2));
      }
    clone() {
         return new (__Vector2D)(this.x,this.y);
      }
    zero() {
         this.$$_x = 0;
         this.$$_y = 0;
         return this;
      }
    isZero() {
         return this.$$_x == 0 && this.$$_y == 0;
      }
    set length(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc2_ = this.angle;
         this.$$_x = Math.cos(_loc2_) * param1;
         this.$$_y = Math.sin(_loc2_) * param1;
      }
    get length() {
         return Math.sqrt(this.lengthSQ);
      }
    get lengthSQ() {
         return this.$$_x * this.$$_x + this.$$_y * this.$$_y;
      }
    set angle(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc2_ = this.length;
         this.$$_x = Math.cos(param1) * _loc2_;
         this.$$_y = Math.sin(param1) * _loc2_;
      }
    get angle() {
         return Math.atan2(this.$$_y,this.$$_x);
      }
    normalize() {
         if(this.length == 0)
         {
            this.$$_x = 1;
            return this;
         }
         var _loc1_ = this.length;
         this.$$_x /= _loc1_;
         this.$$_y /= _loc1_;
         return this;
      }
    truncate(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.length = Math.min(param1,this.length);
         return this;
      }
    reverse() {
         this.$$_x = -this.$$_x;
         this.$$_y = -this.$$_y;
         return this;
      }
    isNormalized() {
         return this.length == 1;
      }
    dotProd(param1) {
         return this.$$_x * param1.x + this.$$_y * param1.y;
      }
    crossProd(param1) {
         return this.$$_x * param1.y - this.$$_y * param1.x;
      }
    sign(param1) {
         return this.perp.dotProd(param1) < 0 ? -1 : 1;
      }
    get perp() {
         return new (__Vector2D)(-this.y,this.x);
      }
    dist(param1) {
         return Math.sqrt(this.distSQ(param1));
      }
    distSQ(param1) {
         var _loc2_ = param1.x - this.x;
         var _loc3_ = param1.y - this.y;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
    add(param1) {
         return new (__Vector2D)(this.$$_x + param1.x,this.$$_y + param1.y);
      }
    subtract(param1) {
         return new (__Vector2D)(this.$$_x - param1.x,this.$$_y - param1.y);
      }
    multiply(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         return new (__Vector2D)(this.$$_x * param1,this.$$_y * param1);
      }
    divide(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         return new (__Vector2D)(this.$$_x / param1,this.$$_y / param1);
      }
    equals(param1) {
         return this.$$_x == param1.x && this.$$_y == param1.y;
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_x = param1;
      }
    get x() {
         return this.$$_x;
      }
    set y(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_y = param1;
      }
    get y() {
         return this.$$_y;
      }
    toString() {
         return "[Vector2D (x:" + this.$$_x + ", y:" + this.$$_y + ")]";
      }
    set lengthSQ(v) { super.lengthSQ = v; }
    set perp(v) { super.perp = v; }
  }
  $.meta(__Vector2D, "com.road.mapengine.ai.vehicle.Vector2D", []);
  return __Vector2D;
}
deps["com.road.mapengine.ai.vehicle.Vector2D"] = [];

defs["com.road.mapengine.ai.vehicle.Vehicle"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __Vehicle extends __Base {
    static $fields(self) {
    self._edgeBehavior = "wrap";
    self._mass = 1;
    self._maxSpeed = 10;
    self.$$_position = new ($.C("com.road.mapengine.ai.vehicle.Vector2D"))();
    self._velocity = new ($.C("com.road.mapengine.ai.vehicle.Vector2D"))();
    self._view = null;
    self.$$_x = NaN;
    self.$$_y = NaN;
    self.$$_rotation = NaN;
    self.stage = null;
    }
    constructor(param1 = null) {
         super(param1);
      }
    get view() {
         return this._view;
      }
    set view(param1) {
         this._view = param1;
         if(this._view)
         {
            this._view.x = this.x;
            this._view.y = this.y;
            this._view.angle = this.rotation;
         }
      }
    update() {
         this._velocity.truncate(this._maxSpeed);
         this.$$_position = this.$$_position.add(this._velocity);
         if(this._edgeBehavior == "wrap")
         {
            this.wrap();
         }
         else if(this._edgeBehavior == "bounce")
         {
            this.bounce();
         }
         this.x = this.position.x;
         this.y = this.position.y;
         this.rotation = this._velocity.angle * 180 / 3.141592653589793;
      }
    wrap() {
         if(this.stage != null)
         {
            if(this.position.x > this.stage.stageWidth)
            {
               this.position.x = 0;
            }
            if(this.position.x < 0)
            {
               this.position.x = this.stage.stageWidth;
            }
            if(this.position.y > this.stage.stageHeight)
            {
               this.position.y = 0;
            }
            if(this.position.y < 0)
            {
               this.position.y = this.stage.stageHeight;
            }
         }
      }
    bounce() {
         if(this.stage != null)
         {
            if(this.position.x > this.stage.stageWidth)
            {
               this.position.x = this.stage.stageWidth;
               this.velocity.x *= -1;
            }
            else if(this.position.x < 0)
            {
               this.position.x = 0;
               this.velocity.x *= -1;
            }
            if(this.position.y > this.stage.stageHeight)
            {
               this.position.y = this.stage.stageHeight;
               this.velocity.y *= -1;
            }
            else if(this.position.y < 0)
            {
               this.position.y = 0;
               this.velocity.y *= -1;
            }
         }
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_x = param1;
         this.$$_position.x = param1;
         if(this._view)
         {
            this._view.x = param1;
         }
      }
    get x() {
         return this.$$_x;
      }
    get y() {
         return this.$$_y;
      }
    set y(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_y = param1;
         this.$$_position.y = param1;
         if(this._view)
         {
            this._view.y = param1;
         }
      }
    get rotation() {
         return this.$$_rotation;
      }
    set rotation(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_rotation = param1;
         if(this._view)
         {
            this._view.angle = param1;
         }
      }
    get position() {
         return this.$$_position;
      }
    set position(param1) {
         this.$$_position = param1;
         this.x = this.$$_position.x;
         this.y = this.$$_position.y;
      }
    get velocity() {
         return this._velocity;
      }
    set velocity(param1) {
         this._velocity = param1;
      }
    get maxSpeed() {
         return this._maxSpeed;
      }
    set maxSpeed(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._maxSpeed = param1;
      }
    get mass() {
         return this._mass;
      }
    set mass(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._mass = param1;
      }
    get edgeBehavior() {
         return this._edgeBehavior;
      }
    set edgeBehavior(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._edgeBehavior = param1;
      }
  }
  $.meta(__Vehicle, "com.road.mapengine.ai.vehicle.Vehicle", []);
  $.statics(__Vehicle, () => {
    __Vehicle.WRAP = "wrap";
    __Vehicle.BOUNCE = "bounce";
  });
  return __Vehicle;
}
deps["com.road.mapengine.ai.vehicle.Vehicle"] = ["com.road.mapengine.ai.vehicle.Vector2D", "flash.events.EventDispatcher"];

defs["com.road.mapengine.ai.vehicle.VehicleAi"] = function define($) {
  const __Base = $.C("com.road.mapengine.ai.vehicle.Vehicle");
  class __VehicleAi extends __Base {
    static $fields(self) {
    self._maxForce = 1;
    self._steeringForce = new ($.C("com.road.mapengine.ai.vehicle.Vector2D"))();
    self._arrivalThreshold = 100;
    self._wanderAngle = 0;
    self._wanderDistance = 10;
    self._wanderRadius = 5;
    self._wanderRange = 1;
    self._pathIndex = 0;
    self._pathThreshold = 20;
    self._avoidDistance = 300;
    self._avoidBuffer = 20;
    self._inSightDist = 200;
    self._tooCloseDist = 260;
    }
    constructor() {
         super();
      }
    set maxForce(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._maxForce = param1;
      }
    get maxForce() {
         return this._maxForce;
      }
    set arriveThreshold(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._arrivalThreshold = param1;
      }
    get arriveThreshold() {
         return this._arrivalThreshold;
      }
    set wanderDistance(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._wanderDistance = param1;
      }
    get wanderDistance() {
         return this._wanderDistance;
      }
    set wanderRadius(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._wanderRadius = param1;
      }
    get wanderRadius() {
         return this._wanderRadius;
      }
    set wanderRange(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._wanderRange = param1;
      }
    get wanderRange() {
         return this._wanderRange;
      }
    set pathIndex(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._pathIndex = param1;
      }
    get pathIndex() {
         return this._pathIndex;
      }
    set pathThreshold(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._pathThreshold = param1;
      }
    get pathThreshold() {
         return this._pathThreshold;
      }
    set avoidDistance(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._avoidDistance = param1;
      }
    get avoidDistance() {
         return this._avoidDistance;
      }
    set avoidBuffer(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._avoidBuffer = param1;
      }
    get avoidBuffer() {
         return this._avoidBuffer;
      }
    set inSightDist(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._inSightDist = param1;
      }
    get inSightDist() {
         return this._inSightDist;
      }
    set tooCloseDist(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._tooCloseDist = param1;
      }
    get tooCloseDist() {
         return this._tooCloseDist;
      }
    update() {
         this._steeringForce.truncate(this._maxForce);
         this._steeringForce = this._steeringForce.divide(this._mass);
         this._velocity = this._velocity.add(this._steeringForce);
         this._steeringForce = new ($.C("com.road.mapengine.ai.vehicle.Vector2D"))();
         super.update();
      }
    seek(param1) {
         var _loc3_ = param1.subtract(this.$$_position);
         _loc3_.normalize();
         _loc3_ = _loc3_.multiply(this._maxSpeed);
         var _loc2_ = _loc3_.subtract(this._velocity);
         this._steeringForce = this._steeringForce.add(_loc2_);
      }
    flee(param1) {
         var _loc3_ = param1.subtract(this.$$_position);
         _loc3_.normalize();
         _loc3_ = _loc3_.multiply(this._maxSpeed);
         var _loc2_ = _loc3_.subtract(this._velocity);
         this._steeringForce = this._steeringForce.subtract(_loc2_);
      }
    arrive(param1) {
         var _loc4_ = param1.subtract(this.$$_position);
         _loc4_.normalize();
         var _loc2_ = this.$$_position.dist(param1);
         if(_loc2_ > this._arrivalThreshold)
         {
            _loc4_ = _loc4_.multiply(this._maxSpeed);
         }
         else
         {
            _loc4_ = _loc4_.multiply(this._maxSpeed * _loc2_ / this._arrivalThreshold);
         }
         var _loc3_ = _loc4_.subtract(this._velocity);
         this._steeringForce = this._steeringForce.add(_loc3_);
      }
    pursue(param1) {
         var _loc3_ = this.position.dist(param1.position) / this._maxSpeed;
         var _loc2_ = param1.position.add(param1.velocity.multiply(_loc3_));
         this.seek(_loc2_);
      }
    evade(param1) {
         var _loc3_ = this.position.dist(param1.position) / this._maxSpeed;
         var _loc2_ = param1.position.subtract(param1.velocity.multiply(_loc3_));
         this.flee(_loc2_);
      }
    wander() {
         var _loc2_ = this.velocity.clone().normalize().multiply(this._wanderDistance);
         var _loc1_ = new ($.C("com.road.mapengine.ai.vehicle.Vector2D"))(0);
         _loc1_.length = this._wanderRadius;
         _loc1_.angle = this._wanderAngle;
         this._wanderAngle += Math.random() * this._wanderRange - this._wanderRange * 0.5;
         var _loc3_ = _loc2_.add(_loc1_);
         this._steeringForce = this._steeringForce.add(_loc3_);
      }
    followPath(param1, param2 = false) {
         var _loc3_ = param1[this._pathIndex];
         if(_loc3_ == null)
         {
            return;
         }
         if(this.$$_position.dist(_loc3_) < this._pathThreshold)
         {
            if(this._pathIndex >= param1.length - 1)
            {
               if(param2)
               {
                  this._pathIndex = 0;
               }
            }
            else
            {
               this._pathIndex = this._pathIndex + 1;
            }
         }
         if(this._pathIndex >= param1.length - 1 && !param2)
         {
            this.arrive(_loc3_);
         }
         else
         {
            this.seek(_loc3_);
         }
      }
    flock(param1) {
         var _loc2_ = 0;
         var _loc6_ = null;
         var _loc3_ = this._velocity.clone();
         var _loc4_ = new ($.C("com.road.mapengine.ai.vehicle.Vector2D"))();
         var _loc5_ = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc6_ = $.as(param1[_loc2_], $.C("com.road.mapengine.ai.vehicle.Vehicle"));
            if(_loc6_ != this && this.inSight(_loc6_))
            {
               _loc3_ = _loc3_.add(_loc6_.velocity);
               _loc4_ = _loc4_.add(_loc6_.position);
               if(this.tooClose(_loc6_))
               {
                  this.flee(_loc6_.position);
               }
               _loc5_++;
            }
            _loc2_++;
         }
         if(_loc5_ > 0)
         {
            _loc3_ = _loc3_.divide(_loc5_);
            _loc4_ = _loc4_.divide(_loc5_);
            this.seek(_loc4_);
            this._steeringForce.add(_loc3_.subtract(this._velocity));
         }
      }
    inSight(param1) {
         if(this.$$_position.dist(param1.position) > this._inSightDist)
         {
            return false;
         }
         var _loc3_ = this._velocity.clone().normalize();
         var _loc4_ = param1.position.subtract(this.$$_position);
         var _loc2_ = _loc4_.dotProd(_loc3_);
         if(_loc2_ < 0)
         {
            return false;
         }
         return true;
      }
    tooClose(param1) {
         return this.$$_position.dist(param1.position) < this._tooCloseDist;
      }
  }
  $.meta(__VehicleAi, "com.road.mapengine.ai.vehicle.VehicleAi", []);
  return __VehicleAi;
}
deps["com.road.mapengine.ai.vehicle.VehicleAi"] = ["com.road.mapengine.ai.vehicle.Vector2D", "com.road.mapengine.ai.vehicle.Vehicle"];

defs["com.road.mapengine.bitmap.BaseMapScene"] = function define($) {
  const __Base = $.Object;
  class __BaseMapScene extends __Base {
    static $fields(self) {
    self._list = null;
    self.$$_parent = null;
    }
    constructor(param1) {
         super();
         this.$$_parent = param1;
         this._list = new ($.C("yishi.utils.SimpleDictionary"))(true);
      }
    addChild(param1) {
         this.$$_parent.addChild(param1);
         return param1;
      }
    removeChild(param1) {
         if(param1)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
         return param1;
      }
    addChildAt(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this.$$_parent.addChildAt(param1,param2);
         return param1;
      }
    dispatchEvent(param1) {
         return this.$$_parent.dispatchEvent(param1);
      }
    addEventListener(param1, param2, param3 = false, param4 = 0, param5 = false) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         this.$$_parent.addEventListener(param1,param2,param3,param4,param5);
      }
    removeEventListener(param1, param2, param3 = false) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.$$_parent.removeEventListener(param1,param2,param3);
      }
    get mouseX() {
         return this.$$_parent.mouseX;
      }
    get mouseY() {
         return this.$$_parent.mouseY;
      }
    addSkill(param1) {
         this.$$_parent.addChild(param1);
      }
    enterFrame() {
         for (var _loc1_ of $.values(this._list))
         {
            _loc1_.update();
         }
      }
    addLogic(param1) {
         this._list.add(param1.instanceId,param1);
      }
    removeLogic(param1) {
         this._list.del(param1.instanceId);
      }
    getAllLogic() {
         return this._list.getList();
      }
    dispose() {
         for (var _loc1_ of $.values(this._list))
         {
            _loc1_.dispose();
         }
         for(var _loc2_ in this._list)
         {
            delete this._list[_loc2_];
         }
         this._list = null;
         this.$$_parent = null;
      }
    get parent() {
         return this.$$_parent;
      }
    set mouseX(v) { super.mouseX = v; }
    set mouseY(v) { super.mouseY = v; }
    set parent(v) { super.parent = v; }
  }
  $.meta(__BaseMapScene, "com.road.mapengine.bitmap.BaseMapScene", ["Disposeable"]);
  return __BaseMapScene;
}
deps["com.road.mapengine.bitmap.BaseMapScene"] = ["yishi.utils.SimpleDictionary"];

defs["com.road.mapengine.bitmap.EngineManager"] = function define($) {
  const __Base = $.Object;
  class __EngineManager extends __Base {
    static $fields(self) {
    self._map = null;
    self._tick = 0;
    }
    constructor() {
         super();
      }
    static get instance() {
         if(!__EngineManager._instance)
         {
            __EngineManager._instance = new (__EngineManager)();
         }
         return __EngineManager._instance;
      }
    setup(param1) {
         this._map = param1;
         this._tick = 1000 / $.C("com.pickgliss.toplevel.StageReferance").stage.frameRate;
         this.addEvent();
      }
    addEvent() {
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
      }
    removeEvent() {
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
      }
    enterFrame() {
         this.run();
      }
    run() {
         if(this._map)
         {
            $.C("com.road.mapengine.ai.astar.AIManager").instance.enterFrame();
            this._map.enterFrame();
         }
      }
    dispose() {
         this.removeEvent();
         this._map = null;
      }
    static set instance(v) { super.instance = v; }
  }
  $.meta(__EngineManager, "com.road.mapengine.bitmap.EngineManager", ["IEnterFrame"]);
  $.statics(__EngineManager, () => {
    __EngineManager._instance = null;
  });
  return __EngineManager;
}
deps["com.road.mapengine.bitmap.EngineManager"] = ["com.pickgliss.toplevel.StageReferance", "com.road.mapengine.ai.astar.AIManager", "yishi.manager.EnterFrameManager"];

defs["com.road.mapengine.bitmap.IMouseEvent"] = function define($) {
  return $.interface("com.road.mapengine.bitmap.IMouseEvent", []);
}

defs["com.road.mapengine.bitmap.data.DisplayMode"] = function define($) {
  const __Base = $.Object;
  class __DisplayMode extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__DisplayMode, "com.road.mapengine.bitmap.data.DisplayMode", []);
  $.statics(__DisplayMode, () => {
    __DisplayMode.ALONE_BITMAP = 1;
    __DisplayMode.MERGER_BITMAP = 2;
  });
  return __DisplayMode;
}
deps["com.road.mapengine.bitmap.data.DisplayMode"] = [];

defs["com.road.mapengine.bitmap.lib.BitmapTempLib"] = function define($) {
  const __Base = $.Object;
  class __BitmapTempLib extends __Base {
    static $fields(self) {
    self._lib = null;
    self._ids = null;
    self._count = null;
    }
    constructor() {
         super();
         this._lib = new ($.C("flash.utils.Dictionary"))(true);
         this._ids = new ($.C("flash.utils.Dictionary"))(true);
         this._count = new ($.C("flash.utils.Dictionary"))(true);
      }
    static get instance() {
         if(!__BitmapTempLib._instance)
         {
            __BitmapTempLib._instance = new (__BitmapTempLib)();
         }
         return __BitmapTempLib._instance;
      }
    addBitmapdata(param1, param2) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if(this._lib[param2])
         {
            var _loc3_ = param2;
            var _loc4_ = this._count[_loc3_] + 1;
            this._count[_loc3_] = _loc4_;
         }
         else
         {
            this._ids[param1] = param2;
            this._lib[param2] = param1;
            this._count[param2] = 1;
         }
      }
    createBitmapdata(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = undefined;
         var _loc2_ = null;
         if(this.hasBitmap(param1))
         {
            var _loc4_ = param1;
            var _loc5_ = this._count[_loc4_] + 1;
            this._count[_loc4_] = _loc5_;
            return $.as(this._lib[param1], $.C("flash.display.BitmapData"));
         }
         if($.C("com.pickgliss.loader.DomainResourceLoad").loaderContext.applicationDomain.hasDefinition(param1))
         {
            _loc3_ = $.C("com.pickgliss.loader.DomainResourceLoad").loaderContext.applicationDomain.getDefinition(param1);
            _loc2_ = $.as(new _loc3_(), $.C("flash.display.BitmapData"));
            this.addBitmapdata(_loc2_,param1);
            return _loc2_;
         }
         return null;
      }
    removeBitmapdataByCName(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._count[param1] > 0)
         {
            var _loc2_ = param1;
            var _loc3_ = this._count[_loc2_] - 1;
            this._count[_loc2_] = _loc3_;
         }
         else
         {
            this.disposeByKey(param1);
         }
      }
    removeBitmapdata(param1) {
         if(!param1)
         {
            return;
         }
         var _loc2_ = this._ids[param1];
         if(_loc2_)
         {
            this.removeBitmapdataByCName(_loc2_);
            return;
         }
         throw new Error("removeBitmapdata");
      }
    disposeByKey(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = $.as(this._lib[param1], $.C("flash.display.BitmapData"));
         if(_loc2_)
         {
            _loc2_.dispose();
         }
         _loc2_ = null;
         delete this._lib[param1];
      }
    hasBitmap(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return this._lib[param1] != null;
      }
    dispose() {
         for(var _loc1_ in this._count)
         {
            this.disposeByKey(_loc1_);
            delete this._count[_loc1_];
         }
      }
    static set instance(v) { super.instance = v; }
  }
  $.meta(__BitmapTempLib, "com.road.mapengine.bitmap.lib.BitmapTempLib", []);
  $.statics(__BitmapTempLib, () => {
    __BitmapTempLib._instance = null;
  });
  return __BitmapTempLib;
}
deps["com.road.mapengine.bitmap.lib.BitmapTempLib"] = ["com.pickgliss.loader.DomainResourceLoad", "flash.display.BitmapData", "flash.utils.Dictionary"];

defs["com.road.mapengine.bitmap.load.ResourceAvatarInfo"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.load.ResourceInfo");
  class __ResourceAvatarInfo extends __Base {
    static $fields(self) {
    self.sornBaseNum = null;
    self.curBaseNum = 0;
    self.position = null;
    self.layouPara = null;
    self.walkLayouPara = null;
    self.attackLayouPara = null;
    }
    constructor() {
         super();
      }
    getAvatarStandCellByFrame(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = this.packageName + "S_" + param1 + "_" + param2;
         this.nextBitmapData = $.C("com.road.mapengine.bitmap.lib.BitmapTempLib").instance.createBitmapdata(_loc3_);
      }
    getAvatarWalksCellByFrame(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = this.packageName + "W_" + param1 + "_" + param2;
         this.nextBitmapData = $.C("com.road.mapengine.bitmap.lib.BitmapTempLib").instance.createBitmapdata(_loc3_);
      }
    getAvatarAttackCellByFrame(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = this.packageName + "A_" + param1 + "_" + param2;
         this.nextBitmapData = $.C("com.road.mapengine.bitmap.lib.BitmapTempLib").instance.createBitmapdata(_loc3_);
      }
  }
  $.meta(__ResourceAvatarInfo, "com.road.mapengine.bitmap.load.ResourceAvatarInfo", []);
  return __ResourceAvatarInfo;
}
deps["com.road.mapengine.bitmap.load.ResourceAvatarInfo"] = ["com.road.mapengine.bitmap.lib.BitmapTempLib", "com.road.mapengine.bitmap.load.ResourceInfo"];

defs["com.road.mapengine.bitmap.load.ResourceInfo"] = function define($) {
  const __Base = $.Object;
  class __ResourceInfo extends __Base {
    static $fields(self) {
    self.packageName = null;
    self.visible = false;
    self.loadOver = false;
    self.sizeType = 0;
    self._nextBitmapData = null;
    self._currBitmapData = null;
    self._cacheCurrBitmapData = false;
    }
    constructor() {
         super();
      }
    get cacheCurrBitmapData() {
         return this._cacheCurrBitmapData;
      }
    set cacheCurrBitmapData(param1) {
         this._cacheCurrBitmapData = param1;
         if(!param1)
         {
            this.currBitmapData = null;
         }
      }
    get currBitmapData() {
         return this._currBitmapData;
      }
    set currBitmapData(param1) {
         this._currBitmapData = param1;
      }
    get nextBitmapData() {
         return this._nextBitmapData;
      }
    set nextBitmapData(param1) {
         if(this._cacheCurrBitmapData)
         {
            this.currBitmapData = this._nextBitmapData;
         }
         else
         {
            this._nextBitmapData = null;
         }
         this._nextBitmapData = param1;
      }
  }
  $.meta(__ResourceInfo, "com.road.mapengine.bitmap.load.ResourceInfo", []);
  return __ResourceInfo;
}
deps["com.road.mapengine.bitmap.load.ResourceInfo"] = [];

defs["com.road.mapengine.bitmap.load.ResourceType"] = function define($) {
  const __Base = $.Object;
  class __ResourceType extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static checkResource(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         switch(param1 - 1)
         {
            case 0:
               return "X方向资源";
            case 1:
               return "XY方向资源";
            case 2:
               return "AVATAR资源";
            case 3:
               return "Player资源";
            case 4:
               return "NPC资源";
            case 5:
               return "tank资源";
            case 6:
               return "载具中的npc";
            default:
               return "";
         }
      }
  }
  $.meta(__ResourceType, "com.road.mapengine.bitmap.load.ResourceType", []);
  $.statics(__ResourceType, () => {
    __ResourceType.RESOURCE_X = 1;
    __ResourceType.RESOURCE_XY = 2;
    __ResourceType.RESOURCE_AVATA = 3;
    __ResourceType.RESOURCE_PLAYER = 4;
    __ResourceType.RESOURCE_NPC = 5;
    __ResourceType.RESOURCE_TANK = 6;
    __ResourceType.RESOURCE_VEHICLE_NPC = 7;
    __ResourceType.RESOURCE_NODE = 8;
    __ResourceType.RESOURCE_X_NAME = "X方向资源";
    __ResourceType.RESOURCE_XY_NAME = "XY方向资源";
    __ResourceType.RESOURCE_AVATA_NAME = "AVATAR资源";
    __ResourceType.RESOURCE_PLAYER_NAME = "Player资源";
    __ResourceType.RESOURCE_NPC_NAME = "NPC资源";
    __ResourceType.RESOURCE_TANK_NAME = "tank资源";
    __ResourceType.RESOURCE_VEHICLE_NPC_NAME = "载具中的npc";
  });
  return __ResourceType;
}
deps["com.road.mapengine.bitmap.load.ResourceType"] = [];

defs["com.road.mapengine.bitmap.load.ResourceXInfo"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.load.ResourceInfo");
  class __ResourceXInfo extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    getBitmapXByFrame(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = undefined;
         var _loc2_ = this.packageName + "" + param1 + "_0";
         if($.C("com.pickgliss.loader.DomainResourceLoad").loaderContext && $.C("com.pickgliss.loader.DomainResourceLoad").loaderContext.applicationDomain.hasDefinition(_loc2_))
         {
            _loc3_ = $.C("com.pickgliss.loader.DomainResourceLoad").loaderContext.applicationDomain.getDefinition(_loc2_);
            this.nextBitmapData = $.as(new _loc3_(), $.C("flash.display.BitmapData"));
         }
      }
  }
  $.meta(__ResourceXInfo, "com.road.mapengine.bitmap.load.ResourceXInfo", []);
  return __ResourceXInfo;
}
deps["com.road.mapengine.bitmap.load.ResourceXInfo"] = ["com.pickgliss.loader.DomainResourceLoad", "com.road.mapengine.bitmap.load.ResourceInfo", "flash.display.BitmapData"];

defs["com.road.mapengine.bitmap.load.ResourceXYInfo"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.load.ResourceInfo");
  class __ResourceXYInfo extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    getBitmapXYByFrame(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = undefined;
         var _loc3_ = this.packageName + "" + param1 + "_" + param2;
         if($.C("com.pickgliss.loader.DomainResourceLoad").loaderContext && $.C("com.pickgliss.loader.DomainResourceLoad").loaderContext.applicationDomain.hasDefinition(_loc3_))
         {
            _loc4_ = $.C("com.pickgliss.loader.DomainResourceLoad").loaderContext.applicationDomain.getDefinition(_loc3_);
            this.nextBitmapData = $.as(new _loc4_(), $.C("flash.display.BitmapData"));
         }
      }
  }
  $.meta(__ResourceXYInfo, "com.road.mapengine.bitmap.load.ResourceXYInfo", []);
  return __ResourceXYInfo;
}
deps["com.road.mapengine.bitmap.load.ResourceXYInfo"] = ["com.pickgliss.loader.DomainResourceLoad", "com.road.mapengine.bitmap.load.ResourceInfo", "flash.display.BitmapData"];

defs["com.road.mapengine.bitmap.logic.AvatarNpcLogic"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapAvatarLogic");
  class __AvatarNpcLogic extends __Base {
    static $fields(self) {
    self._data = null;
    self._ai = null;
    }
    constructor(param1) {
         super(param1);
         this._walkTotalFrameX = 6;
         this._walkTotalFrameY = 5;
         this._standTotalFrameX = 5;
         this._standTotalFrameY = 3;
         this._ai = new ($.C("com.road.mapengine.ai.vehicle.VehicleAi"))();
         this._ai.view = this;
         this._ai.maxSpeed = 3;
         this.play();
      }
    loaderResourceCall(param1, param2) {
         super.loaderResourceCall(param1,param2);
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         this.showAvatar();
      }
    showAvatar() {
         var _loc2_ = this.createLoaderInfo(this._data.sonType.toString(),"body",false);
         var _loc1_ = this.getResourcepath(this._data.sonType.toString());
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc2_);
      }
    update() {
         this._ai.seek(new ($.C("com.road.mapengine.ai.vehicle.Vector2D"))($.C("com.pickgliss.toplevel.StageReferance").stage.mouseX,$.C("com.pickgliss.toplevel.StageReferance").stage.mouseY));
         this._ai.update();
         super.update();
      }
    createLoaderInfo(param1, param2, param3) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc4_ = new ($.C("com.road.mapengine.bitmap.load.ResourceLoaderInfo"))();
         _loc4_.url = this.getResourcepath(param1);
         _loc4_.stand = $.C("avatar.data.AvatarStaticData").getBaseNumByType("Stand",param2);
         _loc4_.walk = $.C("avatar.data.AvatarStaticData").getBaseNumByType("Walk",param2);
         _loc4_.position = param2;
         _loc4_.resourceType = 5;
         _loc4_.queueLoader = param3;
         return _loc4_;
      }
    getResourcepath(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return $.C("yishi.manager.PathManager").NpcAvatarResourcePath(param1);
      }
    get curResourceType() {
         return 5;
      }
    dispose() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "loaderResourceCall"));
         super.dispose();
      }
    set curResourceType(v) { super.curResourceType = v; }
  }
  $.meta(__AvatarNpcLogic, "com.road.mapengine.bitmap.logic.AvatarNpcLogic", []);
  return __AvatarNpcLogic;
}
deps["com.road.mapengine.bitmap.logic.AvatarNpcLogic"] = ["avatar.data.AvatarStaticData", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.toplevel.StageReferance", "com.road.mapengine.ai.vehicle.Vector2D", "com.road.mapengine.ai.vehicle.VehicleAi", "com.road.mapengine.bitmap.load.ResourceLoaderInfo", "com.road.mapengine.bitmap.logic.BitmapAvatarLogic", "yishi.manager.PathManager"];

defs["com.road.mapengine.bitmap.logic.AvatarPlayerLogic"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapAvatarLogic");
  class __AvatarPlayerLogic extends __Base {
    static $fields(self) {
    self._sex = 0;
    self._data = null;
    self._isMounting = false;
    self._pathLogic = null;
    }
    constructor(param1, param2) {
         super(param2,true);
         this._sex = param1;
         this._pathLogic = new ($.C("com.road.mapengine.ai.astar.AvatarPathWalkAi"))();
         this._pathLogic.avatar = this;
         this._walkTotalFrameX = 8;
         this._walkTotalFrameY = 5;
         this._standTotalFrameX = 4;
         this._standTotalFrameY = 3;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._isMounting = false;
         this._data = param1;
         var _loc6_ = $.C("managers.RoomManager").instance.roomInfo.getPlayerByUserId(param1.baseHero.userId);
         if(_loc6_ == null || _loc6_.baseHero == null)
         {
            _loc6_ = param1;
         }
         var _loc11_ = $.int(_loc6_.baseHero.changeShapeId);
         var _loc3_ = $.int(_loc6_.baseHero.templateInfo.Sexs);
         var _loc13_ = $.int(_loc6_.baseHero.templateInfo.Job);
         var _loc7_ = _loc6_.baseHero.bodyAvata == "" ? $.C("yishi.datas.consant.JobType").getDefaultBodyEquipNameByJob(_loc13_) : _loc6_.baseHero.bodyAvata;
         var _loc2_ = _loc6_.baseHero.armsAvata == "" ? $.C("yishi.datas.consant.JobType").getDefaultArmysEquipNameByJob(_loc13_) : _loc6_.baseHero.armsAvata;
         var _loc10_ = $.C("yishi.datas.consant.JobType").getDefaultHairUpByJob(_loc13_);
         var _loc5_ = $.C("yishi.datas.consant.JobType").getDefaultHairDownByJob(_loc13_);
         var _loc9_ = _loc7_ + "_cloak";
         var _loc4_ = _loc6_.baseHero.wingAvata;
         var _loc12_ = _loc6_.mountTemplate ? _loc6_.mountTemplate.AvatarPath : "";
         var _loc8_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.userId == this.data.userId;
         if(_loc11_ > 0)
         {
            return;
         }
         if(_loc6_.mountTemplate)
         {
            this._isMounting = true;
            _loc7_ = $.C("yishi.datas.consant.JobType").getMapMountEquipment(_loc7_);
            _loc2_ = $.C("yishi.datas.consant.JobType").getMapMountEquipment(_loc2_);
            _loc10_ = $.C("yishi.datas.consant.JobType").getMapMountEquipment(_loc10_);
            _loc5_ = $.C("yishi.datas.consant.JobType").getMapMountEquipment(_loc5_);
            _loc9_ = $.C("yishi.datas.consant.JobType").getMapMountEquipment(_loc9_);
            _loc4_ = $.C("yishi.datas.consant.JobType").getMapMountEquipment(_loc4_);
            if(!_loc12_)
            {
               _loc12_ = $.C("yishi.datas.consant.JobType").getDefaultMount();
            }
         }
         this.showAvatarWithPath(_loc7_,_loc2_,_loc10_,_loc5_,_loc9_,this._isMounting,!_loc8_,_loc4_,_loc12_);
      }
    get sex() {
         return this._sex;
      }
    update() {
         this._pathLogic.execute();
         super.update();
      }
    set path(param1) {
         this._pathLogic.paths = param1;
      }
    showAvatarWithPath(param1, param2, param3, param4, param5, param6, param7, param8 = "", param9 = "") {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (param8 != null && typeof param8 !== "string") param8 = String(param8);
         if (param9 != null && typeof param9 !== "string") param9 = String(param9);
         var _loc11_ = null;
         var _loc10_ = "";
         _loc11_ = this.createLoaderInfo(param1,"body",param6,param7);
         _loc10_ = this.getResourcepath(param1);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc10_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc11_);
         _loc11_ = this.createLoaderInfo(param2,"army",param6,param7);
         _loc10_ = this.getResourcepath(param2);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc10_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc11_);
         _loc11_ = this.createLoaderInfo(param3,"hairUp",param6,param7);
         _loc10_ = this.getResourcepath(param3);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc10_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc11_);
         _loc11_ = this.createLoaderInfo(param4,"hairDown",param6,param7);
         _loc10_ = this.getResourcepath(param4);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc10_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc11_);
         if(param8)
         {
            _loc11_ = this.createLoaderInfo(param8,"wing",param6,param7);
            _loc10_ = this.getResourcepath(param8);
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc10_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc11_);
         }
         else
         {
            _loc11_ = this.createLoaderInfo(param5,"cloak",param6,param7);
            _loc10_ = this.getResourcepath(param5);
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc10_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc11_);
         }
         if(param9)
         {
            _loc11_ = this.createLoaderInfo(param9,"mount",param6,param7);
            _loc10_ = this.getResourcepath(param9);
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc10_,4,4,$.bind(this, "loaderResourceCall"),null,null,_loc11_);
         }
      }
    createLoaderInfo(param1, param2, param3, param4) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc5_ = new ($.C("com.road.mapengine.bitmap.load.ResourceLoaderInfo"))();
         _loc5_.url = this.getResourcepath(param1);
         _loc5_.stand = $.C("avatar.data.AvatarStaticData").getBaseNumByType("Stand",param2,param3);
         _loc5_.walk = $.C("avatar.data.AvatarStaticData").getBaseNumByType("Walk",param2,param3);
         _loc5_.position = param2;
         _loc5_.resourceType = 4;
         _loc5_.queueLoader = param4;
         return _loc5_;
      }
    get curResourceType() {
         return 4;
      }
    getResourcepath(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return $.C("yishi.manager.PathManager").avatarResourcePath(param1,this._sex);
      }
    dispose() {
         $.C("com.pickgliss.loader.LoaderManagerII").instance.clearLoaderInfoByCompleteFunction($.bind(this, "loaderResourceCall"));
         super.dispose();
      }
    set sex(v) { super.sex = v; }
    get path() { return super.path; }
    set curResourceType(v) { super.curResourceType = v; }
  }
  $.meta(__AvatarPlayerLogic, "com.road.mapengine.bitmap.logic.AvatarPlayerLogic", []);
  return __AvatarPlayerLogic;
}
deps["com.road.mapengine.bitmap.logic.AvatarPlayerLogic"] = ["avatar.data.AvatarStaticData", "com.pickgliss.loader.LoaderManagerII", "com.road.mapengine.ai.astar.AvatarPathWalkAi", "com.road.mapengine.bitmap.load.ResourceLoaderInfo", "com.road.mapengine.bitmap.logic.BitmapAvatarLogic", "managers.RoomManager", "yishi.datas.consant.JobType", "yishi.manager.PathManager", "yishi.manager.PlayerManager"];

defs["com.road.mapengine.bitmap.logic.BaseSprite"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BaseSprite extends __Base {
    static $fields(self) {
    self._data = null;
    }
    constructor(param1) {
         super();
         this._data = param1;
      }
    get data() {
         return this._data;
      }
    set width(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         super.width = param1;
      }
    addChild(param1) {
         return super.addChild(param1);
      }
    set data(v) { super.data = v; }
    get width() { return super.width; }
  }
  $.meta(__BaseSprite, "com.road.mapengine.bitmap.logic.BaseSprite", []);
  return __BaseSprite;
}
deps["com.road.mapengine.bitmap.logic.BaseSprite"] = ["flash.display.Sprite"];

defs["com.road.mapengine.bitmap.logic.BitmapAvatarLogic"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapXYLogic");
  class __BitmapAvatarLogic extends __Base {
    static $fields(self) {
    self._walkTotalFrameX = 0;
    self._walkTotalFrameY = 0;
    self._standTotalFrameX = 0;
    self._standTotalFrameY = 0;
    self._jumpTotalFrameX = 0;
    self._jumpTotalFrameY = 0;
    self._attackTotalFrameX = 0;
    self._attackTotalFrameY = 0;
    self._state = 3;
    self._face = false;
    self._sizeType = 0;
    self._offRect = null;
    self._shape = new ($.C("flash.display.Shape"))();
    }
    constructor(param1, param2 = true) {
         super(param1);
         if(param2)
         {
            this.sizeType = 1;
         }
         this.play();
      }
    get speed() {
         return 7;
      }
    loaderResourceCall(param1, param2) {
         if(!this._container)
         {
            return;
         }
         var _loc3_ = new ($.C("com.road.mapengine.bitmap.load.ResourceAvatarInfo"))();
         _loc3_.loadOver = true;
         _loc3_.packageName = $.C("map.internals.utils.MapUtisl").getPackageName(param1.url);
         _loc3_.position = _loc3_.position;
         var _loc5_ = $.C("com.pickgliss.loader.LoaderHeaderList").avatarShowNamePos[param1.url];
         var _loc4_ = $.int(_loc5_ ? _loc5_.sizeType : 1);
         _loc3_.layouPara = new ($.C("avatar.data.AvatarLayouData"))(_loc5_.standsPara);
         _loc3_.walkLayouPara = new ($.C("avatar.data.AvatarLayouData"))(_loc5_.walksPara);
         if(_loc5_.attackPara)
         {
            _loc3_.attackLayouPara = new ($.C("avatar.data.AvatarLayouData"))(_loc5_.attackPara);
         }
         _loc3_.sizeType = _loc4_;
         _loc3_.sornBaseNum = param1.args.stand;
         this.addResourceInfo(_loc3_);
         this.sizeType = this.maxSize;
         _loc3_.visible = true;
         this.updateStart();
      }
    set sizeType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         if(this._sizeType == param1)
         {
            return;
         }
         this._sizeType = param1;
         var _loc2_ = $.C("map.internals.utils.MapUtisl").sizeMax[this.sizeType];
         _loc2_ = $.C("map.internals.utils.MapUtisl").sizeMax[1];
         _loc2_ || (_loc2_);
         this._drawRect = new ($.C("flash.geom.Rectangle"))(0,0,_loc2_.width,_loc2_.height);
         if(!this._offRect)
         {
            this._offRect = new ($.C("flash.geom.Rectangle"))();
         }
         this._offRect.x = _loc2_.x;
         this._offRect.y = _loc2_.y;
         if(this.displayMode == 1)
         {
            _loc3_ = new ($.C("flash.display.BitmapData"))(_loc2_.width,_loc2_.height,true,0);
            if(this._baseView && this._baseView.bitmapData)
            {
               this._baseView.bitmapData.dispose();
            }
            this._baseView.bitmapData = _loc3_;
            this._baseView.x = this._offRect.x;
            this._baseView.y = this._offRect.y;
            this._hitRect.x = this.x + this._offRect.x;
            this._hitRect.y = this.y + this._offRect.y;
            this._hitRect.width = _loc2_.width;
            this._hitRect.height = _loc2_.height;
         }
      }
    get hitRect() {
         this._hitRect.x = this.x + this._offRect.x;
         this._hitRect.y = this.y + this._offRect.y;
         return this._hitRect;
      }
    get maxSize() {
         var _loc1_ = null;
         var _loc2_ = 1;
         for (var _loc3_ of $.values(this.resourceList))
         {
            _loc1_ = $.C("map.internals.utils.MapUtisl").sizeMax[_loc3_.sizeType];
            if(_loc1_.size > $.C("map.internals.utils.MapUtisl").sizeMax[_loc2_].size)
            {
               _loc2_ = _loc3_.sizeType;
            }
         }
         return _loc2_;
      }
    get sizeType() {
         return this._sizeType;
      }
    get state() {
         return this._state;
      }
    set state(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._state != param1)
         {
            this._state = param1;
            this.updateDepth();
            this.nextFrameX();
         }
      }
    isReverse() {
         return this._face;
      }
    updateOver() {
         switch(this._state - 1)
         {
            case 0:
               this.drawJump();
               break;
            case 1:
               this.drawAttack();
               break;
            case 2:
               this.drawStand();
               break;
            case 3:
               this.darwWalk();
         }
         super.updateOver();
      }
    updateStart() {
         this.play();
         switch(this._state - 1)
         {
            case 0:
               this.drawJumpPrepare();
               break;
            case 1:
               this.drawAttackPrepare();
               break;
            case 2:
               this.drawStandPrepare();
               break;
            case 3:
               this.darwWalkPrepare();
         }
      }
    darwWalkPrepare() {
         for (var _loc1_ of $.values(this.resourceList))
         {
            if(_loc1_.loadOver)
            {
               _loc1_.getAvatarWalksCellByFrame(this.frameX,this.frameY);
               _loc1_.visible = true;
            }
         }
      }
    drawStandPrepare() {
         var _loc1_ = 0;
         for (var _loc2_ of $.values(this.resourceList))
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               _loc1_ = this.getStandStateFrameY(this.frameY);
               _loc2_.getAvatarStandCellByFrame(this.frameX,_loc1_);
            }
         }
      }
    drawJumpPrepare() {
      }
    drawAttackPrepare() {
         for (var _loc1_ of $.values(this.resourceList))
         {
            if(!(!_loc1_.visible || !_loc1_.loadOver))
            {
               _loc1_.getAvatarAttackCellByFrame(this.frameX,this.frameY);
            }
         }
      }
    getStandStateFrameY(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 2;
         if(this.sizeType != 10)
         {
            if(param1 == 1 || param1 == 0)
            {
               _loc2_ = 0;
            }
            else if(param1 == 3 || param1 == 2)
            {
               _loc2_ = 1;
            }
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
    drawStand() {
         var _loc1_ = null;
         var _loc4_ = null;
         if(!this._baseView)
         {
            return;
         }
         var _loc2_ = this.getStandStateFrameY(this.frameY);
         this._baseView.bitmapData.lock();
         this._baseView.bitmapData.fillRect(new ($.C("flash.geom.Rectangle"))(0,0,this._baseView.width,this._baseView.height),0);
         for (var _loc3_ of $.values(this.resourceList))
         {
            if(!(!_loc3_.visible || !_loc3_.loadOver))
            {
               _loc1_ = $.C("map.internals.utils.MapUtisl").sizeMax[_loc3_.sizeType];
               _loc4_ = _loc3_.layouPara.getCellByKey(this.frameX,_loc2_);
               if(_loc1_ && _loc3_.nextBitmapData)
               {
                  this._drawRect.x = this._drawRect.y = 0;
                  this._drawRect.width = _loc3_.nextBitmapData.width;
                  this._drawRect.height = _loc3_.nextBitmapData.height;
                  this._destPoint.x = _loc1_.x + $.int(_loc4_["x"]) - this._offRect.x;
                  this._destPoint.y = _loc1_.y + $.int(_loc4_["y"]) - this._offRect.y;
                  this._baseView.bitmapData.copyPixels(_loc3_.nextBitmapData,this._drawRect,this._destPoint,null,null,true);
               }
            }
         }
         this._baseView.bitmapData.unlock();
         this._baseView.scaleX = this.mirror;
         if(this._baseView.scaleX == 1)
         {
            this._baseView.x = -(this._baseView.width >> 1);
         }
         else
         {
            this._baseView.x = this._baseView.width >> 1;
         }
      }
    darwWalk() {
         var _loc1_ = null;
         var _loc3_ = null;
         if(!this._baseView)
         {
            return;
         }
         this._baseView.bitmapData.lock();
         this._baseView.bitmapData.fillRect(new ($.C("flash.geom.Rectangle"))(0,0,this._baseView.width,this._baseView.height),0);
         for (var _loc2_ of $.values(this.resourceList))
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               _loc1_ = $.C("map.internals.utils.MapUtisl").sizeMax[_loc2_.sizeType];
               _loc3_ = _loc2_.walkLayouPara.getCellByKey(this.frameX,this.frameY);
               if(_loc1_)
               {
                  this._drawRect.x = this._drawRect.y = 0;
                  this._drawRect.width = _loc2_.nextBitmapData.width;
                  this._drawRect.height = _loc2_.nextBitmapData.height;
                  this._destPoint.x = _loc1_.x + $.int(_loc3_["x"]) - this._offRect.x;
                  this._destPoint.y = _loc1_.y + $.int(_loc3_["y"]) - this._offRect.y;
                  this._baseView.bitmapData.copyPixels(_loc2_.nextBitmapData,this._drawRect,this._destPoint,null,null,true);
               }
            }
         }
         this._baseView.bitmapData.unlock();
         this._baseView.scaleX = this.mirror;
         if(this._baseView.scaleX == 1)
         {
            this._baseView.x = -(this._baseView.width >> 1);
         }
         else
         {
            this._baseView.x = this._baseView.width >> 1;
         }
      }
    drawJump() {
         throw new Error("JUMP状{invalid_utf8=230}?{invalid_utf8=129}下未实现画操作");
      }
    drawAttack() {
         var _loc1_ = null;
         var _loc3_ = null;
         if(!this._baseView)
         {
            return;
         }
         this._baseView.bitmapData.lock();
         this._baseView.bitmapData.fillRect(new ($.C("flash.geom.Rectangle"))(0,0,this._baseView.width,this._baseView.height),0);
         for (var _loc2_ of $.values(this.resourceList))
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               _loc1_ = $.C("map.internals.utils.MapUtisl").sizeMax[_loc2_.sizeType];
               _loc3_ = _loc2_.attackLayouPara.getCellByKey(this.frameX,this.frameY);
               if(_loc1_ && _loc2_.nextBitmapData)
               {
                  this._drawRect.x = this._drawRect.y = 0;
                  this._drawRect.width = _loc2_.nextBitmapData.width;
                  this._drawRect.height = _loc2_.nextBitmapData.height;
                  this._destPoint.x = _loc1_.x + $.int(_loc3_["x"]) - this._offRect.x;
                  this._destPoint.y = _loc1_.y + $.int(_loc3_["y"]) - this._offRect.y;
                  this._baseView.bitmapData.copyPixels(_loc2_.nextBitmapData,this._drawRect,this._destPoint,null,null,true);
               }
            }
         }
         this._baseView.bitmapData.unlock();
         this._baseView.scaleX = this.mirror;
         if(this._baseView.scaleX == 1)
         {
            this._baseView.x = -(this._baseView.width >> 1);
         }
         else
         {
            this._baseView.x = this._baseView.width >> 1;
         }
      }
    nextFrameX() {
         this.frameX = this.frameX + 1;
         switch(this._state - 1)
         {
            case 0:
               if(this.frameX >= this._jumpTotalFrameX)
               {
                  this.frameX = 0;
               }
               break;
            case 1:
               if(this.frameX >= this._attackTotalFrameX)
               {
                  this.frameX = 0;
               }
               break;
            case 2:
               if(this.frameX >= this._standTotalFrameX)
               {
                  this.frameX = 0;
               }
               break;
            case 3:
               if(this.frameX >= this._walkTotalFrameX)
               {
                  this.frameX = 0;
               }
         }
      }
    updateDepth() {
         var _loc2_ = null;
         var _loc1_ = 0;
         switch(this.state - 1)
         {
            case 0:
               throw new Error("JUMP\t状{invalid_utf8=230}?{invalid_utf8=129}下未实现深度切{invalid_utf8=230}{invalid_utf8=141}?");
            case 1:
               _loc1_ = this.frameY;
               break;
            case 2:
               _loc1_ = this.getStandStateFrameY(this.frameY);
               break;
            case 3:
               _loc1_ = this.frameY;
         }
         for (_loc2_ of $.values(this.resourceList))
         {
            _loc2_.curBaseNum = _loc2_.sornBaseNum[_loc1_];
         }
         this.resourceList.sortOn("curBaseNum",0x10 | 2);
      }
    set frameY(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this.frameY != param1)
         {
            super.frameY = param1;
            this.updateDepth();
            this.updateStart();
         }
      }
    dispose() {
         super.dispose();
      }
    get curResourceType() {
         return 3;
      }
    set speed(v) { super.speed = v; }
    set hitRect(v) { super.hitRect = v; }
    set maxSize(v) { super.maxSize = v; }
    get frameY() { return super.frameY; }
    set curResourceType(v) { super.curResourceType = v; }
  }
  $.meta(__BitmapAvatarLogic, "com.road.mapengine.bitmap.logic.BitmapAvatarLogic", []);
  $.statics(__BitmapAvatarLogic, () => {
    __BitmapAvatarLogic.WALK = 4;
    __BitmapAvatarLogic.JUMP = 1;
    __BitmapAvatarLogic.ATTACK = 2;
    __BitmapAvatarLogic.STAND = 3;
  });
  return __BitmapAvatarLogic;
}
deps["com.road.mapengine.bitmap.logic.BitmapAvatarLogic"] = ["avatar.data.AvatarLayouData", "com.pickgliss.loader.LoaderHeaderList", "com.road.mapengine.bitmap.load.ResourceAvatarInfo", "com.road.mapengine.bitmap.logic.BitmapXYLogic", "flash.display.BitmapData", "flash.display.Shape", "flash.geom.Rectangle", "map.internals.utils.MapUtisl"];

defs["com.road.mapengine.bitmap.logic.BitmapSimpleLogic"] = function define($) {
  const __Base = $.Object;
  class __BitmapSimpleLogic extends __Base {
    static $fields(self) {
    self.$$_x = NaN;
    self.$$_y = NaN;
    self.$$_rotation = NaN;
    self._mouseEnabled = false;
    self._enable = false;
    self._resourceList = null;
    self._curStepFrame = 0;
    self._cycleStepFrame = 3;
    self._displayMode = 0;
    self._baseView = null;
    self._container = null;
    self._mapScene = null;
    self._areaKeyX = 0;
    self._areaKeyY = 0;
    self._hitRect = null;
    self._instanceId = 0;
    self._filer = new ($.C("yishi.filter.UIFilter"))();
    self._slelecMc = null;
    }
    constructor(param1) {
         super();
         this._instanceId = $.C("map.internals.utils.MapUtisl").instanceId;
         this._mapScene = param1;
         this._displayMode = 1;
         this._resourceList = [];
         this._container = new ($.C("com.road.mapengine.bitmap.logic.VehicleBaseSprite"))(this);
         this._hitRect = new ($.C("com.road.mapengine.bitmap.logic.LogicRectangle"))(this);
         this._baseView = new ($.C("flash.display.Bitmap"))();
      }
    get mapScene() {
         return this._mapScene;
      }
    get instanceId() {
         return this._instanceId;
      }
    get hitRect() {
         var _loc1_ = null;
         this._hitRect.x = this.x;
         this._hitRect.y = this.y;
         this._hitRect.width = 1;
         this._hitRect.height = 1;
         if(this._baseView && this._mapScene.parent)
         {
            _loc1_ = this._baseView.getBounds(this._mapScene.parent);
            this._hitRect.x = _loc1_.x;
            this._hitRect.y = _loc1_.y;
            this._hitRect.width = _loc1_.width;
            this._hitRect.height = _loc1_.height;
         }
         return this._hitRect;
      }
    hitGlobalPoint(param1) {
         var _loc2_ = param1.x - this.x - this._baseView.x;
         var _loc3_ = param1.y - this.y - this._baseView.y;
         var _loc4_ = $.int(this._baseView.bitmapData.getPixel(_loc2_,_loc3_));
         return _loc4_ > 50 ? true : false;
      }
    setFilter() {
         this._container.transform.colorTransform = new ($.C("flash.geom.ColorTransform"))(1,0.2,0.2);
      }
    get displayMode() {
         return this._displayMode;
      }
    addChild(param1) {
         if(param1 == this._container)
         {
            return null;
         }
         this._container.addChild(param1);
         return param1;
      }
    removeChild(param1) {
         if(param1)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
         return param1;
      }
    addChildAt(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._container.addChildAt(param1,param2);
         return param1;
      }
    update() {
         if(this._curStepFrame == this._cycleStepFrame - 1)
         {
            this.updateStart();
            this._curStepFrame = this._curStepFrame + 1;
         }
         else if(this._curStepFrame >= this._cycleStepFrame)
         {
            this._curStepFrame = 0;
            this.updateOver();
         }
         else
         {
            this.updateWait(this._curStepFrame);
            this._curStepFrame = this._curStepFrame + 1;
         }
      }
    updateStart() {
      }
    updateWait(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
      }
    updateOver() {
      }
    over() {
      }
    throwResourceTypeError(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
      }
    loaderResourceCall(param1, param2) {
      }
    get curResourceType() {
         return 0;
      }
    get resourceList() {
         return this._resourceList;
      }
    addResourceInfo(param1) {
         this._resourceList.push(param1);
      }
    get rotation() {
         return this.$$_rotation;
      }
    set rotation(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_rotation = param1;
      }
    get y() {
         return this.$$_y;
      }
    set y(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_y = param1;
         this._container.y = param1;
         this._areaKeyY = this.$$_y >> 20;
      }
    get x() {
         return this.$$_x;
      }
    set x(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.$$_x = param1;
         this._container.x = param1;
         this._areaKeyX = this.$$_x >> 20;
      }
    get AreaKey() {
         return this._areaKeyX + "_" + this._areaKeyY;
      }
    get enable() {
         return this._enable;
      }
    set enable(param1) {
         this._enable = param1;
      }
    getResourcepath(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         throw new Error("重载该方{invalid_utf8=230}{invalid_utf8=179}?");
      }
    get mouseEnabled() {
         return this._mouseEnabled;
      }
    set mouseEnabled(param1) {
         this._mouseEnabled = param1;
      }
    getMousePixelsValue() {
         return 0;
      }
    mouseClickEvent(param1) {
         return false;
      }
    mouseDownEvent(param1) {
         return false;
      }
    mouseUpEvent(param1) {
         return false;
      }
    mouseOverEvent(param1) {
         return false;
      }
    mouseOutEvent(param1) {
         return false;
      }
    mouseMoveEvent(param1) {
         return false;
      }
    dispose() {
         if(this._container && this._container.parent)
         {
            this._container.parent.removeChild(this._container);
         }
         if(this._hitRect)
         {
            this._hitRect.dispose();
         }
         this._hitRect = null;
         if(this._baseView && this._baseView.bitmapData)
         {
            this._baseView.bitmapData.dispose();
         }
         this._baseView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._container);
      }
    get container() {
         return this._container;
      }
    getTilePoint() {
         return new ($.C("flash.geom.Point"))($.int(Math.floor(this.x / 20)),$.int(Math.floor(this.y / 20)));
      }
    select(param1) {
         this._slelecMc = param1;
         this._slelecMc.hitArea = this._container;
      }
    unSelect() {
         if(this._slelecMc && this._slelecMc.parent)
         {
            this._slelecMc.parent.removeChild(this._slelecMc);
            this._slelecMc.hitArea = null;
         }
         this._slelecMc = null;
      }
    set mapScene(v) { super.mapScene = v; }
    set instanceId(v) { super.instanceId = v; }
    set hitRect(v) { super.hitRect = v; }
    set displayMode(v) { super.displayMode = v; }
    set curResourceType(v) { super.curResourceType = v; }
    set resourceList(v) { super.resourceList = v; }
    set AreaKey(v) { super.AreaKey = v; }
    set container(v) { super.container = v; }
  }
  $.meta(__BitmapSimpleLogic, "com.road.mapengine.bitmap.logic.BitmapSimpleLogic", ["Disposeable", "IMouseEvent"]);
  return __BitmapSimpleLogic;
}
deps["com.road.mapengine.bitmap.logic.BitmapSimpleLogic"] = ["com.pickgliss.utils.ObjectUtils", "com.road.mapengine.bitmap.logic.LogicRectangle", "com.road.mapengine.bitmap.logic.VehicleBaseSprite", "flash.display.Bitmap", "flash.geom.ColorTransform", "flash.geom.Point", "map.internals.utils.MapUtisl", "yishi.filter.UIFilter"];

defs["com.road.mapengine.bitmap.logic.BitmapXLogic"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapSimpleLogic");
  class __BitmapXLogic extends __Base {
    static $fields(self) {
    self._frameX = 0;
    self._isStop = false;
    self._drawRect = null;
    self._destPoint = null;
    self.totalFrameX = 6;
    self.curTotalFrameX = 6;
    }
    constructor(param1) {
         super(param1);
         this.stop();
         this._drawRect = new ($.C("flash.geom.Rectangle"))();
         this._destPoint = new ($.C("flash.geom.Point"))();
      }
    get curResourceType() {
         return 1;
      }
    loaderResourceCall(param1, param2) {
      }
    updateOver() {
         if(this.isStop)
         {
            return;
         }
         this.nextFrameX();
      }
    get isStop() {
         return this._isStop;
      }
    nextFrameX() {
         this.frameX = this.frameX + 1;
         if(this.frameX >= this.totalFrameX)
         {
            this.frameX = 0;
         }
      }
    get frameX() {
         return this._frameX;
      }
    set frameX(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._frameX = param1;
      }
    stop() {
         this._isStop = true;
      }
    play() {
         this._isStop = false;
      }
    dispose() {
         super.dispose();
      }
    set curResourceType(v) { super.curResourceType = v; }
    set isStop(v) { super.isStop = v; }
  }
  $.meta(__BitmapXLogic, "com.road.mapengine.bitmap.logic.BitmapXLogic", []);
  return __BitmapXLogic;
}
deps["com.road.mapengine.bitmap.logic.BitmapXLogic"] = ["com.road.mapengine.bitmap.logic.BitmapSimpleLogic", "flash.geom.Point", "flash.geom.Rectangle"];

defs["com.road.mapengine.bitmap.logic.BitmapXYLogic"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapXLogic");
  class __BitmapXYLogic extends __Base {
    static $fields(self) {
    self._frameY = 0;
    self._mirror = 1;
    self.$$_angle = NaN;
    }
    constructor(param1) {
         super(param1);
      }
    get mirror() {
         return this._mirror;
      }
    set mirror(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._mirror != param1)
         {
            this._mirror = param1;
            this.x = this.x;
         }
      }
    get angle() {
         return this.$$_angle;
      }
    set angle(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if(this.angle == param1)
         {
            return;
         }
         var _loc2_ = this.frameY;
         this.$$_angle = param1;
         if(param1 >= 260 && param1 < 280)
         {
            this.frameY = 4;
            this.mirror = 1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            this.frameY = 3;
            this.mirror = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            this.frameY = 2;
            this.mirror = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            this.frameY = 1;
            this.mirror = 1;
         }
         else if(param1 >= 80 && param1 < 100)
         {
            this.frameY = 0;
            this.mirror = 1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            this.frameY = 1;
            this.mirror = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            this.frameY = 2;
            this.mirror = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            this.frameY = 3;
            this.mirror = -1;
         }
         this.play();
      }
    get frameY() {
         return this._frameY;
      }
    set frameY(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._frameY = param1;
      }
    get curResourceType() {
         return 2;
      }
    loaderResourceCall(param1, param2) {
      }
    set curResourceType(v) { super.curResourceType = v; }
  }
  $.meta(__BitmapXYLogic, "com.road.mapengine.bitmap.logic.BitmapXYLogic", []);
  return __BitmapXYLogic;
}
deps["com.road.mapengine.bitmap.logic.BitmapXYLogic"] = ["com.road.mapengine.bitmap.logic.BitmapXLogic"];

defs["com.road.mapengine.bitmap.logic.LogicRectangle"] = function define($) {
  const __Base = $.C("flash.geom.Rectangle");
  class __LogicRectangle extends __Base {
    static $fields(self) {
    self._logic = null;
    }
    constructor(param1, param2 = 0, param3 = 0, param4 = 0, param5 = 0) {
         $.pre(new.target, (__s) => {
         __s._logic = param1;
         });
         super(param2,param3,param4,param5);
         $.preFlush(this, new.target);
      }
    get logic() {
         return this._logic;
      }
    dispose() {
         this._logic = null;
      }
    set logic(v) { super.logic = v; }
  }
  $.meta(__LogicRectangle, "com.road.mapengine.bitmap.logic.LogicRectangle", []);
  return __LogicRectangle;
}
deps["com.road.mapengine.bitmap.logic.LogicRectangle"] = ["flash.geom.Rectangle"];

defs["com.road.mapengine.bitmap.logic.SimpleSkillLogic"] = function define($) {
  const __Base = $.C("com.road.mapengine.bitmap.logic.BitmapXLogic");
  class __SimpleSkillLogic extends __Base {
    static $fields(self) {
    }
    constructor() {
         super(null);
      }
  }
  $.meta(__SimpleSkillLogic, "com.road.mapengine.bitmap.logic.SimpleSkillLogic", []);
  return __SimpleSkillLogic;
}
deps["com.road.mapengine.bitmap.logic.SimpleSkillLogic"] = ["com.road.mapengine.bitmap.logic.BitmapXLogic"];

defs["com.road.mapengine.bitmap.logic.VehicleBaseSprite"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __VehicleBaseSprite extends __Base {
    static $fields(self) {
    self._logic = null;
    }
    constructor(param1) {
         super();
         this._logic = param1;
         this.mouseChildren = false;
      }
    get logic() {
         return this._logic;
      }
    set logic(v) { super.logic = v; }
  }
  $.meta(__VehicleBaseSprite, "com.road.mapengine.bitmap.logic.VehicleBaseSprite", []);
  return __VehicleBaseSprite;
}
deps["com.road.mapengine.bitmap.logic.VehicleBaseSprite"] = ["com.pickgliss.ui.core.Component"];

defs["com.road.mapengine.bitmap.map.BaseMapsData"] = function define($) {
  const __Base = $.Object;
  class __BaseMapsData extends __Base {
    static $fields(self) {
    self._elmsData = null;
    self._indexArray = null;
    self._backUrl = null;
    self._mapData = null;
    self._mapWidth = 0;
    self._mapHeight = 0;
    }
    constructor() {
         super();
      }
    get backUrl() {
         return this._backUrl;
      }
    get mapHeight() {
         return this._mapHeight;
      }
    set mapHeight(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._mapHeight = param1;
      }
    get mapWidth() {
         return this._mapWidth;
      }
    set mapWidth(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._mapWidth = param1;
      }
    set elmsData(param1) {
         this._elmsData = param1;
      }
    set mapData(param1) {
         this._mapData = param1;
         this.findBackUrl();
         this.sortOnBaseNum();
      }
    sortOnBaseNum() {
         var _loc5_ = 0;
         this._indexArray = [];
         for (var _loc3_ of $.values(this._mapData))
         {
            for (var _loc1_ of $.values(_loc3_))
            {
               this._indexArray = this._indexArray.concat(_loc1_);
            }
         }
         this._indexArray = this._indexArray.sortOn("baseNum",16);
         var _loc4_ = $.int(this._indexArray.length);
         var _loc2_ = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(this._indexArray[_loc5_].baseNum > 101)
            {
               _loc2_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         this._indexArray.splice(0,_loc2_);
      }
    findBackUrl() {
         var _loc3_ = null;
         var _loc1_ = false;
         loop0:
         for (var _loc4_ of $.values(this._mapData))
         {
            for (var _loc2_ of $.values(_loc4_))
            {
               for (var _loc5_ of $.values(_loc2_))
               {
                  if(_loc5_["baseNum"] == 101)
                  {
                     this._backUrl = _loc5_["url"];
                     _loc3_ = $.as(this.getBitmapDataById(this._backUrl), $.C("flash.display.BitmapData"));
                     if(_loc3_ && _loc3_.width == _loc3_.height && _loc3_.width == 100)
                     {
                        break loop0;
                     }
                  }
               }
            }
         }
         return this._backUrl;
      }
    getBitmapDataById(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return $.as(this._elmsData.getElementByPath($.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + param1), $.C("flash.display.BitmapData"));
      }
    get indexArray() {
         return this._indexArray;
      }
    set backUrl(v) { super.backUrl = v; }
    get elmsData() { return super.elmsData; }
    get mapData() { return super.mapData; }
    set indexArray(v) { super.indexArray = v; }
  }
  $.meta(__BaseMapsData, "com.road.mapengine.bitmap.map.BaseMapsData", []);
  return __BaseMapsData;
}
deps["com.road.mapengine.bitmap.map.BaseMapsData"] = ["com.pickgliss.ui.ComponentSetting", "flash.display.BitmapData"];

defs["com.road.mapengine.bitmap.map.BaseMapsView"] = function define($) {
  const __Base = $.C("flash.display.Bitmap");
  class __BaseMapsView extends __Base {
    static $fields(self) {
    self._data = null;
    }
    constructor(param1 = "auto", param2 = false) {
         super(new ($.C("flash.display.BitmapData"))(1,1),param1,param2);
      }
    set data(param1) {
         this._data = param1;
         var _loc2_ = new ($.C("flash.display.BitmapData"))(this._data.mapWidth,this._data.mapHeight);
         this.bitmapData = _loc2_;
         this.render();
      }
    render() {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc1_ = new ($.C("flash.geom.Rectangle"))();
         var _loc4_ = new ($.C("flash.geom.Point"))();
         var _loc3_ = this._data.indexArray;
         this.bitmapData.lock();
         this.drawBack();
         for (_loc2_ of $.values(_loc3_))
         {
            if(_loc2_["baseNum"] <= 101)
            {
               throw new Error(_loc2_.baseNum);
            }
            _loc5_ = this._data.getBitmapDataById(_loc2_.url);
            if(_loc5_)
            {
               _loc4_.x = _loc2_.x;
               _loc4_.y = _loc2_.y;
               _loc1_.width = _loc5_.width;
               _loc1_.height = _loc5_.height;
               this.bitmapData.copyPixels(_loc5_,_loc1_,_loc4_,null,null,true);
            }
         }
         this.bitmapData.unlock();
         this.cacheAsBitmap = false;
      }
    drawBack() {
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc1_ = this._data.getBitmapDataById(this._data.backUrl);
         var _loc3_ = _loc1_.width;
         var _loc9_ = _loc1_.height;
         var _loc8_ = Math.ceil(this.width / _loc3_);
         var _loc2_ = Math.ceil(this.height / _loc9_);
         var _loc4_ = new ($.C("flash.geom.Rectangle"))(0,0,_loc3_,_loc9_);
         var _loc7_ = new ($.C("flash.geom.Point"))();
         if(_loc1_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc2_)
               {
                  _loc7_.x = _loc5_ * _loc3_;
                  _loc7_.y = _loc6_ * _loc9_;
                  this.bitmapData.copyPixels(_loc1_,_loc4_,_loc7_);
                  _loc6_++;
               }
               _loc5_++;
            }
         }
      }
    dispose() {
         this._data = null;
         this.bitmapData.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__BaseMapsView, "com.road.mapengine.bitmap.map.BaseMapsView", ["Disposeable"]);
  return __BaseMapsView;
}
deps["com.road.mapengine.bitmap.map.BaseMapsView"] = ["flash.display.Bitmap", "flash.display.BitmapData", "flash.geom.Point", "flash.geom.Rectangle"];

defs["com.road.mapengine.data.skill.BassSkillInfo"] = function define($) {
  const __Base = $.C("flash.events.EventDispatcher");
  class __BassSkillInfo extends __Base {
    static $fields(self) {
    }
    constructor(param1 = null) {
         super(param1);
      }
  }
  $.meta(__BassSkillInfo, "com.road.mapengine.data.skill.BassSkillInfo", []);
  return __BassSkillInfo;
}
deps["com.road.mapengine.data.skill.BassSkillInfo"] = ["flash.events.EventDispatcher"];

defs["ipOleNsZk"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ipOleNsZk extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__ipOleNsZk, "ipOleNsZk", []);
  return __ipOleNsZk;
}
deps["ipOleNsZk"] = ["flash.display.Sprite"];
