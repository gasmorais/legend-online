// @ts-nocheck
export const defs = {};
export const deps = {};
defs["datas.NewbieActionType"] = function define($) {
  const __Base = $.Object;
  class __NewbieActionType extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__NewbieActionType, "datas.NewbieActionType", []);
  $.statics(__NewbieActionType, () => {
    __NewbieActionType.a1 = "mediators.NewbieBaseActionMediator|showMask";
    __NewbieActionType.a2 = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
    __NewbieActionType.a3 = "mediators.NewbieBaseActionMediator|hideMask";
    __NewbieActionType.a4 = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
    __NewbieActionType.a5 = "mediators.NewbieBaseActionMediator|sendEnterScene";
    __NewbieActionType.a6 = "mediators.NewbieBaseActionMediator|emptyAction";
    __NewbieActionType.a7 = "mediators.NewbieBaseActionMediator|showDialog";
    __NewbieActionType.a8 = "mediators.NewbieBaseActionMediator|showMapName";
    __NewbieActionType.a9 = "mediators.NewbieBaseActionMediator|moveNPC";
    __NewbieActionType.a10 = "mediators.NewbieBaseActionMediator|taskTraceItemShine";
    __NewbieActionType.a11 = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
    __NewbieActionType.a12 = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
    __NewbieActionType.a13 = "mediators.NewbieBaseActionMediator|castleBuildShine";
    __NewbieActionType.a14 = "mediators.NewbieBaseActionMediator|createGuildFrame1";
    __NewbieActionType.a15 = "mediators.NewbieBaseActionMediator|createGuildFrame2";
    __NewbieActionType.a16 = "mediators.NewbieBaseActionMediator|createGuildFrame3";
    __NewbieActionType.a17 = "mediators.NewbieBaseActionMediator|createGuildFrame4";
    __NewbieActionType.a18 = "mediators.NewbieBaseActionMediator|tweenTarget";
    __NewbieActionType.a19 = "mediators.NewbieBaseActionMediator|controlBattleState";
    __NewbieActionType.a20 = "mediators.NewbieBaseActionMediator|createGuildArrow1";
    __NewbieActionType.a21 = "mediators.NewbieBaseActionMediator|cleanGuildArrow";
    __NewbieActionType.a22 = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
    __NewbieActionType.a23 = "mediators.NewbieBaseActionMediator|cleanAll";
    __NewbieActionType.a24 = "mediators.NewbieBaseActionMediator|setMainToolBarBtn";
    __NewbieActionType.a25 = "mediators.NewbieBaseActionMediator|copyTarget";
    __NewbieActionType.a26 = "mediators.NewbieBaseActionMediator|cleanCopyTarget";
    __NewbieActionType.a27 = "mediators.NewbieBaseActionMediator|sendSaveNode";
    __NewbieActionType.a28 = "mediators.NewbieBaseActionMediator|sendInitBuildAndQueue";
    __NewbieActionType.a29 = "mediators.NewbieBaseActionMediator|createSelectRoleView";
    __NewbieActionType.a30 = "mediators.NewbieBaseActionMediator|visitSpaceNPC";
    __NewbieActionType.a31 = "mediators.NewbieBaseActionMediator|sendCallInCampaign";
    __NewbieActionType.a34 = "mediators.NewbieBaseActionMediator|closeFrame";
    __NewbieActionType.a35 = "mediators.NewbieBaseActionMediator|createGuildTarget";
    __NewbieActionType.a36 = "mediators.NewbieBaseActionMediator|cleanCreateTarget";
    __NewbieActionType.a37 = "mediators.NewbieBaseActionMediator|setTargetPosAndScale";
    __NewbieActionType.a38 = "mediators.NewbieBaseActionMediator|sendSetSkillFastKey";
    __NewbieActionType.a39 = "mediators.NewbieBaseActionMediator|showNewSkillInBattle";
    __NewbieActionType.a40 = "mediators.NewbieBaseActionMediator|setTargetDisplayIndex";
    __NewbieActionType.a41 = "mediators.NewbieBaseActionMediator|openHelpFrame";
    __NewbieActionType.a42 = "mediators.NewbieSpecialActionMediator|weaponEquipGuild";
    __NewbieActionType.a43 = "mediators.NewbieSpecialActionMediator|pawnAllocateGuild";
    __NewbieActionType.a44 = "mediators.NewbieSpecialActionMediator|weaponIntensifyGuild";
    __NewbieActionType.a45 = "mediators.NewbieBaseActionMediator|moveNPCByTween";
    __NewbieActionType.a46 = "mediators.NewbieBaseActionMediator|sendEnterCollectionBattle";
    __NewbieActionType.a47 = "mediators.NewbieBaseActionMediator|setKeyboardState";
    __NewbieActionType.a48 = "mediators.NewbieBaseActionMediator|clearCurrentGameAction";
    __NewbieActionType.a49 = "mediators.NewbieBaseActionMediator|cleanGameLayer";
    __NewbieActionType.a50 = "mediators.NewbieBaseActionMediator|setNPC";
    __NewbieActionType.a51 = "mediators.NewbieSpecialActionMediator|enterSceneAfterPlayMovie";
    __NewbieActionType.a52 = "mediators.NewbieBaseActionMediator|sceneMove";
    __NewbieActionType.a53 = "mediators.NewbieBaseActionMediator|setStageBaffle";
    __NewbieActionType.a54 = "mediators.NewbieBaseActionMediator|sendNodeArrive";
    __NewbieActionType.a55 = "mediators.NewbieBaseActionMediator|showStartPlayView";
    __NewbieActionType.a56 = "mediators.NewbieBaseActionMediator|doTask";
    __NewbieActionType.a57 = "mediators.NewbieBaseActionMediator|newModuleOpen";
    __NewbieActionType.a91 = "mediators.NewbieBaseActionMediator|moveOuterCityMap";
    __NewbieActionType.a92 = "mediators.NewbieSpecialActionMediator|getWorldMapMovie";
    __NewbieActionType.a93 = "mediators.NewbieBaseActionMediator|lockCampaignScene";
  });
  return __NewbieActionType;
}
deps["datas.NewbieActionType"] = [];

defs["datas.NewbieConditionType"] = function define($) {
  const __Base = $.Object;
  class __NewbieConditionType extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__NewbieConditionType, "datas.NewbieConditionType", []);
  $.statics(__NewbieConditionType, () => {
    __NewbieConditionType.c1 = "mediators.NewbieBaseConditionMediator|checkPlayerGrade";
    __NewbieConditionType.c2 = "mediators.NewbieBaseConditionMediator|checkInScene";
    __NewbieConditionType.c3 = "mediators.NewbieBaseConditionMediator|checkCastleBuild";
    __NewbieConditionType.c4 = "mediators.NewbieBaseConditionMediator|checkTaskIsComplete";
    __NewbieConditionType.c5 = "mediators.NewbieBaseConditionMediator|checkSkillInfo";
    __NewbieConditionType.c6 = "mediators.NewbieBaseConditionMediator|checkFrame";
    __NewbieConditionType.c7 = "mediators.NewbieBaseConditionMediator|checkCampaignNodeState";
    __NewbieConditionType.c8 = "mediators.NewbieBaseConditionMediator|checkNotInScene";
    __NewbieConditionType.c9 = "mediators.NewbieBaseConditionMediator|checkConditionCommon";
    __NewbieConditionType.c10 = "mediators.NewbieBaseConditionMediator|checkCampaignNodeView";
    __NewbieConditionType.c11 = "mediators.NewbieBaseConditionMediator|checkGoodsNum";
    __NewbieConditionType.c12 = "mediators.NewbieBaseConditionMediator|checkTaskHasCompleted";
    __NewbieConditionType.c13 = "mediators.NewbieBaseConditionMediator|checkPlayerBagItemIsExistData";
    __NewbieConditionType.c14 = "mediators.NewbieBaseConditionMediator|checkEquipBagItemIsExistData";
    __NewbieConditionType.c15 = "mediators.NewbieBaseConditionMediator|checkHavePawn";
    __NewbieConditionType.c16 = "mediators.NewbieBaseConditionMediator|checkTaskIsCompleteOrCompleted";
    __NewbieConditionType.c17 = "mediators.NewbieBaseConditionMediator|checkInCastleOrSpace";
    __NewbieConditionType.c18 = "mediators.NewbieBaseConditionMediator|checkRolesNumInBattle";
    __NewbieConditionType.c19 = "mediators.NewbieBaseConditionMediator|checkSkillInBattle";
    __NewbieConditionType.c20 = "mediators.NewbieBaseConditionMediator|checkCampaignNodeAvatarState";
    __NewbieConditionType.c91 = "mediators.NewbieBaseConditionMediator|checkNodeIsOccupy";
    __NewbieConditionType.c92 = "mediators.NewbieBaseConditionMediator|checkTaskProcess";
    __NewbieConditionType.c93 = "mediators.NewbieBaseConditionMediator|checkOuterFrameExist";
    __NewbieConditionType.c94 = "mediators.NewbieBaseConditionMediator|checkIsInNewbieMap";
  });
  return __NewbieConditionType;
}
deps["datas.NewbieConditionType"] = [];

defs["event.NewbieEvent"] = function define($) {
  const __Base = $.C("flash.events.Event");
  class __NewbieEvent extends __Base {
    static $fields(self) {
    self._args = null;
    }
    constructor(param1, ... rest) {
         $.pre(new.target, (__s) => {
         __s._args = rest;
         });
         super(param1);
         $.preFlush(this, new.target);
      }
    get args() {
         return this._args;
      }
    set args(v) { super.args = v; }
  }
  $.meta(__NewbieEvent, "event.NewbieEvent", []);
  $.statics(__NewbieEvent, () => {
    __NewbieEvent.NODE_COMPLETE = "nodeComplete";
    __NewbieEvent.TUTORIAL_COMPLETE = "tutorialComplete";
    __NewbieEvent.DIALOG_START = "dialogStart";
    __NewbieEvent.DIALOG_COMPLETE = "dialogComplete";
    __NewbieEvent.MAINTOOLBTN_COMPLETE = "maintoolbtnComplete";
    __NewbieEvent.NODE_LEVEUPDATE = "node_leveupdate";
    __NewbieEvent.SKIPNOVICE_COMPLETE = "skip_NoviceComplete";
    __NewbieEvent.SHOW_PHYSICS_MENU = "showPhysicsMenu";
    __NewbieEvent.BATTLE_EFFECT_COMPLETE = "battle_efffct_complete";
    __NewbieEvent.BATTLE_START = "battle_start";
    __NewbieEvent.NEW_NPC_OPEN_EVENT = "new_npc_open_event";
  });
  return __NewbieEvent;
}
deps["event.NewbieEvent"] = ["flash.events.Event"];

defs["mediators.NewbieBaseActionMediator"] = function define($) {
  const __Base = $.Object;
  class __NewbieBaseActionMediator extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static emptyAction() {
      }
    static sendEnterScene(param1, param2 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = $.C("yishi.scene.SceneType").getSceneTypeById(param1);
         if(_loc3_ == $.C("yishi.scene.SceneManager").instance.currentType)
         {
            return;
         }
         switch(_loc3_)
         {
            case "CASTLE_SCENE":
               $.C("yishi.scene.SceneManager").instance.setScene(_loc3_);
               break;
            case "SPACE_SCENE":
               $.C("yishi.SwitchPageHelp").enterToSpace();
               break;
            case "CAMPAIGN_MAP_SCENE":
               $.C("dialog.utils.NewbieSocketOutManager").sendEnterCampaign(param2);
               break;
            default:
               throw new Error("无此类型场景，type{invalid_utf8=239}{invalid_utf8=188}?" + _loc3_);
         }
      }
    static showMask(param1 = 0.6, param2 = 0) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = null;
         __NewbieBaseActionMediator.setKeyboardState(null,null,"0",0);
         $.C("com.pickgliss.ui.ShowTipManager").Instance.removeAllTip();
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("ui.events.UIBarEvent"))("HIDE_TASK_TRACE"));
         if(!__NewbieBaseActionMediator.$$_mask)
         {
            _loc3_ = new ($.C("flash.display.Shape"))();
            _loc3_.graphics.beginFill(0,1);
            _loc3_.graphics.drawRect(-200,-200,$.C("com.pickgliss.toplevel.StageReferance").stage.stageWidth + 400,$.C("com.pickgliss.toplevel.StageReferance").stage.stageHeight + 400);
            _loc3_.graphics.endFill();
            __NewbieBaseActionMediator.$$_mask = new ($.C("flash.display.Sprite"))();
            __NewbieBaseActionMediator.$$_mask.blendMode = "layer";
            __NewbieBaseActionMediator.$$_mask.addChild(_loc3_);
         }
         __NewbieBaseActionMediator.$$_mask.alpha = param1;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(__NewbieBaseActionMediator.$$_mask,param2,false,false);
         $.C("yishi.manager.PlayerManager").instance.isExistNewbieMask = true;
      }
    static drawTargetOnMask(param1, param2, param3, param4, param5 = -1, param6 = 0, param7 = 0, param8 = null, param9 = null) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         if (typeof param7 !== "number" || (param7 | 0) !== param7) param7 = $.int(param7);
         if (param8 != null && typeof param8 !== "string") param8 = String(param8);
         var _loc11_ = null;
         var _loc14_ = null;
         var _loc10_ = null;
         if(!__NewbieBaseActionMediator.$$_mask)
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
            return;
         }
         if(param9)
         {
            _loc11_ = param9;
         }
         else
         {
            _loc11_ = __NewbieBaseActionMediator.getGuildTarget(param3);
         }
         if(!_loc11_)
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
            return;
         }
         if(!__NewbieBaseActionMediator._drawContainer)
         {
            __NewbieBaseActionMediator._drawContainer = new ($.C("flash.display.Sprite"))();
            __NewbieBaseActionMediator._drawContainer.buttonMode = true;
            __NewbieBaseActionMediator._drawContainer.mouseChildren = false;
            __NewbieBaseActionMediator._drawContainer.blendMode = "erase";
         }
         else
         {
            __NewbieBaseActionMediator._drawContainer.removeEventListener("rollOver",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.removeEventListener("rollOut",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.removeEventListener("mouseOver",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.removeEventListener("mouseOut",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.removeEventListener("mouseDown",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.removeEventListener("click",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawClickEventArgs = null;
            __NewbieBaseActionMediator.cleanDrawContainer();
         }
         switch(param5)
         {
            case 0:
               $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(__NewbieBaseActionMediator._drawContainer,0);
               break;
            default:
               if(!__NewbieBaseActionMediator._drawContainer.parent || __NewbieBaseActionMediator._drawContainer.parent != __NewbieBaseActionMediator.$$_mask)
               {
                  __NewbieBaseActionMediator.$$_mask.addChild(__NewbieBaseActionMediator._drawContainer);
               }
         }
         var _loc12_ = param4 == "1";
         var _loc13_ = __NewbieBaseActionMediator.getTargetObjSize(_loc11_);
         if(_loc13_.w <= 0 && _loc13_.h <= 0)
         {
            _loc13_.w = 100;
            _loc13_.h = 100;
         }
         _loc14_ = new ($.C("flash.display.BitmapData"))(_loc13_.w,_loc13_.h,true,0);
         _loc14_.draw(_loc11_);
         __NewbieBaseActionMediator._drawContainer.addChild(new ($.C("flash.display.Bitmap"))(_loc14_));
         if(param6 == 0 && param7 == 0)
         {
            $.C("utils.DisObjResizeUtils").addTarget(__NewbieBaseActionMediator._drawContainer,_loc11_);
         }
         else
         {
            $.C("utils.DisObjResizeUtils").addTarget(__NewbieBaseActionMediator._drawContainer,_loc11_,new ($.C("flash.geom.Point"))(param6,param7));
         }
         if(_loc12_)
         {
            if(param8 != null && param8 != "")
            {
               _loc10_ = __NewbieBaseActionMediator.getGuildTarget(param8);
               __NewbieBaseActionMediator._drawClickEventArgs = [_loc10_,param1,param2];
            }
            else
            {
               __NewbieBaseActionMediator._drawClickEventArgs = [_loc11_,param1,param2];
            }
            __NewbieBaseActionMediator._drawContainer.addEventListener("rollOver",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.addEventListener("rollOut",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.addEventListener("mouseOver",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.addEventListener("mouseOut",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.addEventListener("mouseDown",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            __NewbieBaseActionMediator._drawContainer.addEventListener("click",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
         }
         else
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
         }
      }
    static __onDrawTargetMouseEvent(param1) {
         if(!param1)
         {
            return;
         }
         var _loc2_ = param1.type;
         if("click" !== _loc2_)
         {
            if(__NewbieBaseActionMediator._drawClickEventArgs)
            {
               __NewbieBaseActionMediator.dispatchAllChildEvent(__NewbieBaseActionMediator._drawClickEventArgs[0],param1);
            }
         }
         else
         {
            if($.C("com.pickgliss.loader.LoaderManagerII").instance.hasPrority(10))
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("public.resourceLoading"));
               return;
            }
            if(__NewbieBaseActionMediator._drawContainer)
            {
               __NewbieBaseActionMediator._drawContainer.removeEventListener("click",__NewbieBaseActionMediator.__onDrawTargetMouseEvent);
            }
            if(__NewbieBaseActionMediator._drawClickEventArgs)
            {
               __NewbieBaseActionMediator.dispatchAllChildEvent(__NewbieBaseActionMediator._drawClickEventArgs[0],param1);
               $.C("utils.NewbieUtils").execFunc(__NewbieBaseActionMediator._drawClickEventArgs[1],__NewbieBaseActionMediator._drawClickEventArgs[2]);
               __NewbieBaseActionMediator._drawClickEventArgs = null;
            }
         }
      }
    static dispatchAllChildEvent(param1, param2) {
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc5_ = 0;
         if(param1 == null)
         {
            return;
         }
         if($.is(param1, $.C("map.internals.interfaces.IBaseMouseEvent")))
         {
            if(param2.type == "click")
            {
               ($.as(param1, $.C("map.internals.interfaces.IBaseMouseEvent"))).mouseClickHandler(param2);
            }
            if(param1.hasEventListener(param2.type))
            {
               param1.dispatchEvent(param2);
            }
            return;
         }
         if(param1.hasEventListener(param2.type))
         {
            param1.dispatchEvent(param2);
            return;
         }
         if($.is(param1, $.C("flash.display.DisplayObjectContainer")))
         {
            _loc3_ = $.as(param1, $.C("flash.display.DisplayObjectContainer"));
            _loc4_ = _loc3_.numChildren;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               __NewbieBaseActionMediator.dispatchAllChildEvent(_loc3_.getChildAt(_loc5_),param2);
               _loc5_++;
            }
         }
      }
    static hideMask() {
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("ui.events.UIBarEvent"))("SHOW_TASK_TRACE"));
         __NewbieBaseActionMediator.setKeyboardState(null,null,"1",0);
         if(__NewbieBaseActionMediator.$$_mask && __NewbieBaseActionMediator.$$_mask.parent)
         {
            __NewbieBaseActionMediator.$$_mask.parent.removeChild(__NewbieBaseActionMediator.$$_mask);
         }
         __NewbieBaseActionMediator.$$_mask = null;
         $.C("yishi.manager.PlayerManager").instance.isExistNewbieMask = false;
      }
    static cleanDrawContainer() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(__NewbieBaseActionMediator._drawContainer);
      }
    static showDialog(param1, param2, param3, param4 = "1") {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         $.C("dialog.DialogManager").showDialog(param1,param3,$.C("com.pickgliss.toplevel.StageReferance").stage,param4 == "1");
      }
    static showMapName(param1, param2) {
         var _loc3_ = $.C("map.campaign.CampaignManager").instance.mapModel ? $.C("map.campaign.CampaignManager").instance.mapModel.mapTempInfo : null;
         if(_loc3_)
         {
            new ($.C("map.internals.view.displaye.MapNameMovie"))(param1).loadIcon(_loc3_.MapFileId);
         }
      }
    static moveNPC(param1, param2, param3, param4, param5, param6, param7, param8 = "0") {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         if (typeof param7 !== "number" || (param7 | 0) !== param7) param7 = $.int(param7);
         if (param8 != null && typeof param8 !== "string") param8 = String(param8);
         var _loc12_ = null;
         var _loc14_ = null;
         var _loc10_ = $.C("map.campaign.CampaignManager").instance.mapModel;
         if(!_loc10_)
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
            return;
         }
         if(param3 <= 0)
         {
            _loc12_ = $.C("map.campaign.CampaignManager").instance.controller.getArmyView(_loc10_.selfMemberData);
         }
         else
         {
            _loc12_ = _loc10_.getNodeByNodeId(param3);
         }
         if(!_loc12_)
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
            return;
         }
         var _loc13_ = $.int(param4 == -1 ? _loc12_.x / 20 : param4);
         var _loc11_ = $.int(param5 == -1 ? _loc12_.y / 20 : param5);
         if(param6 == -1 && param7 == -1)
         {
            _loc14_ = null;
         }
         else
         {
            _loc14_ = $.C("map.campaign.CampaignManager").instance.controller.findPath.find(new ($.C("flash.geom.Point"))(_loc13_,_loc11_),new ($.C("flash.geom.Point"))(param6,param7));
         }
         var _loc9_ = param8 == "1";
         if(_loc9_)
         {
            __NewbieBaseActionMediator._moveEventArgs = [param1,param2];
            _loc12_.addEventListener("walkOver",__NewbieBaseActionMediator.__armyWalkOverHandler);
            _loc12_["info"].pathInfo = _loc14_;
         }
         else
         {
            _loc12_["info"].pathInfo = _loc14_;
            $.C("utils.NewbieUtils").execFunc(param1,param2);
         }
      }
    static __armyWalkOverHandler(param1) {
         if(param1.currentTarget)
         {
            ($.as(param1.currentTarget, $.C("flash.display.Sprite"))).removeEventListener("walkOver",__NewbieBaseActionMediator.__armyWalkOverHandler);
         }
         if(__NewbieBaseActionMediator._moveEventArgs)
         {
            $.C("utils.NewbieUtils").execFunc(__NewbieBaseActionMediator._moveEventArgs[0],__NewbieBaseActionMediator._moveEventArgs[1]);
            __NewbieBaseActionMediator._moveEventArgs = null;
         }
      }
    static taskTraceItemShine(param1, param2) {
         var _loc4_ = $.C("ui.tasktracebar.TaskTraceBar").instance.taskTraceView;
         if(!_loc4_)
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
            return;
         }
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.novice.shineTask");
         _loc3_.x = -58;
         _loc3_.y = -8;
         _loc4_.addChild(_loc3_);
         $.C("com.greensock.TweenMax").to(_loc3_,0.5,{
            "alpha":0,
            "yoyo":true,
            "repeat":2,
            "onComplete":__NewbieBaseActionMediator.tweenCompleteCall,
            "onCompleteParams":[_loc3_,true,param1,param2,true]
         });
         _loc4_["novicShine"]();
      }
    static setTaskArrowGuild(param1, param2 = 0, param3 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = __NewbieBaseActionMediator.getContentByValue(param2);
         $.C("yishi.manager.NotificationManager").instance.sendNotification("NOVICE_ARROW_STATE",{
            "type":param1,
            "tip":_loc4_
         });
         if(param3 > 0 && $.C("ui.tasktracebar.TaskTraceBar").instance.taskTraceView)
         {
            $.C("ui.tasktracebar.TaskTraceBar").instance.taskTraceView["scrollToItemByTaskTempId"](param3);
            $.C("ui.tasktracebar.TaskTraceBar").instance.taskTraceView["setArrowPosByTaskTempId"](param3);
         }
      }
    static moveFocusToCastleBuild(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(param3);
         var _loc5_ = $.C("yishi.manager.BuildingManager").instance.castleMap["buildingsDic"][_loc4_.buildingId];
         $.C("yishi.manager.BuildingManager").instance.castleMap["moveFocus2"](_loc5_,param1);
      }
    static castleBuildShine(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         __NewbieBaseActionMediator._colorEventArgs = [param1,param2];
         var _loc4_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(param3);
         var _loc5_ = $.C("yishi.manager.BuildingManager").instance.castleMap["buildingsDic"][_loc4_.buildingId];
         if(__NewbieBaseActionMediator._colorEffect)
         {
            __NewbieBaseActionMediator._colorEffect.removeEventListener("complete",__NewbieBaseActionMediator.__colorEffectCompleteHandler);
            __NewbieBaseActionMediator._colorEffect = null;
         }
         __NewbieBaseActionMediator._colorEffect = new ($.C("yishi.utils.ColorManager"))(_loc5_["curView"]["effect_area"],1,0);
         __NewbieBaseActionMediator._colorEffect.addEventListener("complete",__NewbieBaseActionMediator.__colorEffectCompleteHandler);
      }
    static __colorEffectCompleteHandler(param1) {
         if(__NewbieBaseActionMediator._colorEffect)
         {
            __NewbieBaseActionMediator._colorEffect.removeEventListener("complete",__NewbieBaseActionMediator.__colorEffectCompleteHandler);
            __NewbieBaseActionMediator._colorEffect = null;
         }
         if(__NewbieBaseActionMediator._colorEventArgs)
         {
            $.C("utils.NewbieUtils").execFunc(__NewbieBaseActionMediator._colorEventArgs[0],__NewbieBaseActionMediator._colorEventArgs[1]);
            __NewbieBaseActionMediator._colorEventArgs = null;
         }
      }
    static createGuildFrame1(param1, param2, param3, param4 = 0, param5 = "1", param6 = 0, param7 = 0, param8 = 0, param9 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         if (typeof param7 !== "number" || (param7 | 0) !== param7) param7 = $.int(param7);
         if (typeof param8 !== "number" || (param8 | 0) !== param8) param8 = $.int(param8);
         var _loc10_ = null;
         var _loc11_ = __NewbieBaseActionMediator.getContentByValue(param4);
         if(param9)
         {
            _loc10_ = param9;
         }
         else
         {
            _loc10_ = __NewbieBaseActionMediator.getGuildTarget(param1);
         }
         var _loc12_ = new ($.C("views.NoviceFrame1"))();
         if(_loc10_ && param5 == "1")
         {
            _loc12_.btnEffect(_loc10_);
         }
         _loc12_.setContent(__NewbieBaseActionMediator.getReplacedText(_loc11_),param6,_loc10_,param7,param8);
         __NewbieBaseActionMediator.addToGuildFrameList(_loc12_);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc12_,0);
         _loc12_.show();
      }
    static createGuildFrame2(param1, param2, param3, param4 = 0, param5 = "0", param6 = 0) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         var _loc7_ = __NewbieBaseActionMediator.getGuildTarget(param1);
         var _loc9_ = new ($.C("views.NoviceFameCampaign"))();
         var _loc8_ = __NewbieBaseActionMediator.getContentByValue(param4);
         _loc9_.setText(__NewbieBaseActionMediator.getReplacedText(_loc8_),param6);
         __NewbieBaseActionMediator.addToGuildFrameList(_loc9_);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc9_,0);
         $.C("utils.DisObjResizeUtils").addTarget(_loc9_,_loc7_,new ($.C("flash.geom.Point"))(param2,param3));
         _loc9_.showTween();
      }
    static createGuildFrame3(param1, param2, param3, param4, param5, param6) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if (param6 != null && typeof param6 !== "string") param6 = String(param6);
         var _loc7_ = __NewbieBaseActionMediator.getGuildTarget(param3);
         var _loc8_ = new ($.C("yishi.view.guild.QteGuideFrame"))(param6,new ($.C("flash.geom.Point"))(param4,param5),param1,_loc7_);
         __NewbieBaseActionMediator.addToGuildFrameList(_loc8_);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc8_,0);
      }
    static createGuildFrame4(param1, param2, param3, param4, param5) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         var _loc6_ = new ($.C("views.NoviceFrame4"))(param5,new ($.C("flash.geom.Point"))(param3,param4),param1);
         __NewbieBaseActionMediator.addToGuildFrameList(_loc6_);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc6_,0);
      }
    static createGuildArrow(param1, param2, param3, param4, param5 = 0, param6 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         var _loc7_ = null;
         var _loc9_ = __NewbieBaseActionMediator.getContentByValue(param5);
         if(param6)
         {
            _loc7_ = param6;
         }
         else
         {
            _loc7_ = __NewbieBaseActionMediator.getGuildTarget(param1);
         }
         var _loc8_ = new ($.C("yishi.view.guild.NoviceArrowView"))(param4,_loc9_,true,null);
         __NewbieBaseActionMediator.addToGuildArrowList(_loc8_);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc8_,0);
         $.C("utils.DisObjResizeUtils").addTarget(_loc8_,_loc7_,new ($.C("flash.geom.Point"))(param2,param3));
         _loc8_.showTween();
      }
    static cleanAll() {
         __NewbieBaseActionMediator.cleanCreateTarget();
         __NewbieBaseActionMediator.cleanCopyTarget();
         __NewbieBaseActionMediator.cleanDrawContainer();
         __NewbieBaseActionMediator.cleanGuildArrow();
         __NewbieBaseActionMediator.cleanGuildFrame();
         __NewbieBaseActionMediator.hideMask();
      }
    static cleanGuildArrow() {
         for (var _loc1_ of $.values(__NewbieBaseActionMediator._guildArrowList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         if(__NewbieBaseActionMediator._guildArrowList)
         {
            __NewbieBaseActionMediator._guildArrowList.length = 0;
         }
      }
    static cleanGuildFrame() {
         for (var _loc1_ of $.values(__NewbieBaseActionMediator._guildFrameList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         if(__NewbieBaseActionMediator._guildFrameList)
         {
            __NewbieBaseActionMediator._guildFrameList.length = 0;
         }
      }
    static addToGuildFrameList(param1) {
         if(!__NewbieBaseActionMediator._guildFrameList)
         {
            __NewbieBaseActionMediator._guildFrameList = [];
         }
         __NewbieBaseActionMediator._guildFrameList.push(param1);
      }
    static addToGuildArrowList(param1) {
         if(!__NewbieBaseActionMediator._guildArrowList)
         {
            __NewbieBaseActionMediator._guildArrowList = [];
         }
         __NewbieBaseActionMediator._guildArrowList.push(param1);
      }
    static tweenTarget(param1, param2, param3, param4, param5, param6 = "0", param7 = "", param8 = 0, param9 = 0, param10 = "1") {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number") param4 = Number(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (param6 != null && typeof param6 !== "string") param6 = String(param6);
         if (param7 != null && typeof param7 !== "string") param7 = String(param7);
         if (typeof param8 !== "number" || (param8 | 0) !== param8) param8 = $.int(param8);
         if (typeof param9 !== "number" || (param9 | 0) !== param9) param9 = $.int(param9);
         if (param10 != null && typeof param10 !== "string") param10 = String(param10);
         var _loc13_ = null;
         var _loc14_ = param10 == "1";
         var _loc12_ = __NewbieBaseActionMediator.getGuildTarget(param3);
         var _loc11_ = __NewbieBaseActionMediator.getGuildTarget(param7);
         var _loc15_ = $.C("utils.NewbieUtils").stringToObject(param5);
         _loc15_["onComplete"] = __NewbieBaseActionMediator.tweenCompleteCall;
         _loc15_["onCompleteParams"] = [_loc12_,false,param1,param2,_loc14_];
         if(_loc11_ && _loc11_.parent)
         {
            _loc13_ = _loc11_.parent.localToGlobal(new ($.C("flash.geom.Point"))(_loc11_.x,_loc11_.y));
            _loc13_ = _loc12_.parent.globalToLocal(_loc13_);
            if(_loc15_.x)
            {
               _loc15_.x = _loc13_.x + param8;
            }
            if(_loc15_.y)
            {
               _loc15_.y = _loc13_.y + param9;
            }
         }
         if(param6 == "1")
         {
            $.C("com.greensock.TweenMax").from(_loc12_,param4,_loc15_);
         }
         else
         {
            $.C("com.greensock.TweenMax").to(_loc12_,param4,_loc15_);
         }
         if(!_loc14_)
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
         }
      }
    static tweenCompleteCall(param1, param2, param3, param4, param5) {
         $.C("com.greensock.TweenMax").killTweensOf(param1);
         if(param2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(param1);
            param1 = null;
         }
         if(param5)
         {
            $.C("utils.NewbieUtils").execFunc(param3,param4);
         }
      }
    static controlBattleState(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = param1 == "1";
         if(_loc2_)
         {
            $.C("dialog.utils.NewbieSocketOutManager").sendBattlePause();
         }
         else
         {
            $.C("dialog.utils.NewbieSocketOutManager").sendBattleContinue();
         }
      }
    static setMainToolBarBtn(param1, param2, param3 = 0, param4 = "0") {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         var _loc9_ = null;
         var _loc6_ = 0;
         var _loc8_ = 0;
         var _loc5_ = false;
         var _loc7_ = 14;
         _loc6_ = 1;
         while(_loc6_ <= _loc7_)
         {
            if(_loc6_ != 10)
            {
               _loc9_ = $.C("ui.maintoolbar.MainToolBar").instance.getButtnByType(_loc6_);
               if(_loc9_ && _loc9_.isVisible)
               {
                  _loc9_.enable = _loc9_.isVisible;
               }
            }
            _loc6_++;
         }
         $.C("ui.maintoolbar.MainToolBar").instance.doMove();
         if(param3 > 0)
         {
            _loc9_ = $.C("ui.maintoolbar.MainToolBar").instance.getButtnByType(param3);
            _loc5_ = param4 == "1";
            if(_loc5_)
            {
               $.C("ui.maintoolbar.MainToolBar").instance.doMove(_loc9_,true,__NewbieBaseActionMediator.playBtnEffect,[_loc9_,param1]);
            }
            else
            {
               __NewbieBaseActionMediator.playBtnEffect([_loc9_,param1]);
            }
         }
         else
         {
            $.C("utils.NewbieUtils").execFunc(param1,param2);
         }
      }
    static playBtnEffect(param1) {
         $.C("yishi.utils.MaskUtils").instance.addShowMovie(param1[0],param1[1]);
      }
    static copyTarget(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         __NewbieBaseActionMediator.cleanCopyTarget();
         var _loc3_ = __NewbieBaseActionMediator.getGuildTarget(param1);
         var _loc2_ = __NewbieBaseActionMediator.getTargetObjSize(_loc3_);
         var _loc4_ = new ($.C("flash.display.BitmapData"))(_loc2_.w,_loc2_.h,true,0);
         _loc4_.draw(_loc3_);
         __NewbieBaseActionMediator._copyTarget = new ($.C("flash.display.Bitmap"))(_loc4_);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(__NewbieBaseActionMediator._copyTarget,0);
      }
    static cleanCopyTarget() {
         $.C("com.greensock.TweenMax").killTweensOf(__NewbieBaseActionMediator._copyTarget);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(__NewbieBaseActionMediator._copyTarget);
         __NewbieBaseActionMediator._copyTarget = null;
      }
    static sendSaveNode(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("dialog.utils.NewbieSocketOutManager").sendSaveProcess(param1);
      }
    static sendInitBuildAndQueue() {
         $.C("dialog.utils.NewbieSocketOutManager").sendInitBuildAndQueue();
      }
    static moveOuterCityMap(param1, param2, param3 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc4_ = undefined;
         $.C("map.outercity.manager.OuterCityManager").instance.mapView.novimotionTo(new ($.C("flash.geom.Point"))(param1 - $.C("com.pickgliss.toplevel.StageReferance").stageWidth / 2,param2 - $.C("com.pickgliss.toplevel.StageReferance").stageHeight / 2));
         if($.C("map.outercity.manager.OuterCityManager").instance.mapView)
         {
            _loc6_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.mapNodeInfo;
            _loc4_ = $.C("map.outercity.manager.OuterCityManager").instance.model.getPhysicsByXY(param1,param2);
            if(param3 == 1)
            {
               _loc5_ = new ($.C("views.NoviceFogView"))($.C("map.outercity.manager.OuterCityManager").instance.mapView.width,$.C("map.outercity.manager.OuterCityManager").instance.mapView.height);
               $.C("map.outercity.manager.OuterCityManager").instance.mapView.addChild(_loc5_);
               _loc5_.updatePos(_loc4_.x,_loc4_.y,3);
               _loc5_.updatePos(_loc6_.x,_loc6_.y,3);
            }
         }
      }
    static createSelectRoleView(param1, param2) {
         $.C("yishi.utils.CheckUIModuleUtil").instance.tryCall("rename",__NewbieBaseActionMediator.openNameCall,[param1]);
      }
    static openNameCall(param1) {
         var _loc2_ = new ($.C("yishi.view.guild.NameView"))(param1[0]);
         _loc2_.show();
      }
    static visitSpaceNPC(param1, param2, param3, param4 = "1") {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         var _loc5_ = param4 == "1";
         $.C("map.space.SpaceManager").instance.visitSpaceNPC(param3,_loc5_,param1);
      }
    static sendCallInCampaign(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         $.C("dialog.utils.NewbieSocketOutManager").sendCallInCampaign(param1,param2,param3);
      }
    static closeFrame(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance[param1]["frame"];
         if(_loc2_)
         {
            _loc2_.closeButton.dispatchEvent(new ($.C("flash.events.MouseEvent"))("click"));
         }
      }
    static createGuildTarget(param1, param2, param3) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         var _loc7_ = null;
         var _loc6_ = null;
         var _loc5_ = null;
         __NewbieBaseActionMediator.cleanCreateTarget();
         var _loc8_;
         var _loc4_;
         switch((_loc8_ = (_loc4_ = param3.split("_")).shift()) - 1)
         {
            case 0:
               _loc7_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoByJobAndIdx($.C("yishi.manager.ArmyManager").instance.thane.templateInfo.Job,$.int(_loc4_[0]));
               __NewbieBaseActionMediator._createTarget = _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("novice.battle.SkillItemView");
               _loc6_.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc7_.Icons);
               _loc6_.tipData = _loc7_;
               _loc6_.x = -400;
               _loc6_.y = -400;
               $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc6_,0);
               $.C("utils.NewbieUtils").execFunc(param1,param2);
               break;
            case 1:
               __NewbieBaseActionMediator._createTarget = _loc5_ = new ($.C("views.NewModuleOpenPopView"))();
               _loc5_.callback = param1;
               _loc5_.callArgs = param2;
               _loc5_.icon = _loc4_[0];
               _loc5_.btnText = _loc4_[1];
               _loc5_.show();
         }
      }
    static cleanCreateTarget() {
         $.C("com.greensock.TweenMax").killTweensOf(__NewbieBaseActionMediator._createTarget);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(__NewbieBaseActionMediator._createTarget);
         __NewbieBaseActionMediator._createTarget = null;
      }
    static setTargetPosAndScale(param1, param2 = "0", param3 = "0", param4 = "1", param5 = "1", param6 = "") {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (param6 != null && typeof param6 !== "string") param6 = String(param6);
         var _loc7_ = null;
         var _loc10_ = __NewbieBaseActionMediator.getGuildTarget(param1);
         var _loc8_ = __NewbieBaseActionMediator.getTargetObjSize(_loc10_);
         var _loc9_ = __NewbieBaseActionMediator.getGuildTarget(param6);
         if((param2 == "reference" || param3 == "reference") && _loc9_ && _loc9_.parent)
         {
            _loc7_ = _loc9_.parent.localToGlobal(new ($.C("flash.geom.Point"))(_loc9_.x,_loc9_.y));
            _loc7_ = _loc10_.parent.globalToLocal(_loc7_);
            _loc10_.x = _loc7_.x;
            _loc10_.y = _loc7_.y;
         }
         var _loc11_ = param2;
         if("middle" !== _loc11_)
         {
            _loc10_.x = $.int(param2);
         }
         else
         {
            _loc10_.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - _loc8_.w) / 2;
         }
         _loc11_ = param3;
         if("middle" !== _loc11_)
         {
            _loc10_.y = $.int(param3);
         }
         else
         {
            _loc10_.y = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - _loc8_.h) / 2;
         }
         _loc11_ = param4;
         if("reference" !== _loc11_)
         {
            _loc10_.scaleX = Number(param4);
         }
         else if(_loc9_)
         {
            _loc10_.scaleX = _loc9_.scaleX;
         }
         _loc11_ = param5;
         if("reference" !== _loc11_)
         {
            _loc10_.scaleY = Number(param5);
         }
         else if(_loc9_)
         {
            _loc10_.scaleY = _loc9_.scaleY;
         }
      }
    static sendSetSkillFastKey(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = param1.split("_");
         var _loc4_ = "";
         for (var _loc3_ of $.values(_loc2_))
         {
            _loc4_ += _loc3_ + ",";
         }
         $.C("yishi.manager.FrameControllerManager").instance.armyController.sendSetFastKey(_loc4_);
      }
    static showNewSkillInBattle(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = null;
         var _loc3_ = $.C("battle.BattleManager").getInstance().battleUIView.getBottomBar().getSkillList().skillItemViews[param1];
         if(param2 == -1)
         {
            _loc3_.data = null;
         }
         else
         {
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoByJobAndIdx($.C("yishi.manager.ArmyManager").instance.thane.templateInfo.Job,param2);
            _loc3_.data = _loc4_;
            _loc3_.buttonSkiner.enable = true;
         }
      }
    static setTargetDisplayIndex(param1, param2 = -1, param3 = -1, param4 = "0", param5 = "0", param6 = 0) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         var _loc7_ = __NewbieBaseActionMediator.getGuildTarget(param1);
         if(param3 > -1 && _loc7_)
         {
            $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc7_,param3,param4 == "1",param5 == "1",param6);
         }
         if(param2 > -1 && _loc7_ && _loc7_.parent)
         {
            if(_loc7_.parent.numChildren < param2 + 1)
            {
               param2 = _loc7_.parent.numChildren - 1;
            }
            _loc7_.parent.setChildIndex(_loc7_,param2);
         }
      }
    static openHelpFrame(param1, param2, param3, param4 = 0) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param3);
         _loc5_.callback = param1;
         _loc5_.show(param4);
      }
    static moveNPCByTween(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 = "0", param11 = 0) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         if (typeof param7 !== "number" || (param7 | 0) !== param7) param7 = $.int(param7);
         if (typeof param8 !== "number" || (param8 | 0) !== param8) param8 = $.int(param8);
         if (typeof param9 !== "number" || (param9 | 0) !== param9) param9 = $.int(param9);
         if (param10 != null && typeof param10 !== "string") param10 = String(param10);
         if (typeof param11 !== "number" || (param11 | 0) !== param11) param11 = $.int(param11);
         var npcView;
         var completeWhenWalkOver;
         var callback = param1;
         var callArgs = param2;
         var $npcId = param3;
         var $beginX = param4;
         var $beginY = param5;
         var $endX = param6;
         var $endY = param7;
         var $angle = param8;
         var $moveTime = param9;
         var $completeWhenWalkOver = param10;
         var $stepFrame = param11;
         var moveByTweenCompleteCall = () =>
         {
            $.C("com.greensock.TweenMax").killTweensOf(npcView);
            if(npcView["avatarView"])
            {
               if($stepFrame > 0)
               {
                  npcView["avatarView"]["isLockStepFrame"] = false;
               }
               npcView["avatarView"]["state"] = 3;
            }
            if(completeWhenWalkOver)
            {
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
            }
         };
         var mapModel = $.C("map.campaign.CampaignManager").instance.mapModel;
         if(!mapModel)
         {
            $.C("utils.NewbieUtils").execFunc(callback,callArgs);
            return;
         }
         if($npcId <= 0)
         {
            npcView = $.C("map.campaign.CampaignManager").instance.controller.getArmyView(mapModel.selfMemberData);
         }
         else
         {
            npcView = mapModel.getNodeByNodeId($npcId);
         }
         if(!npcView)
         {
            $.C("utils.NewbieUtils").execFunc(callback,callArgs);
            return;
         }
         completeWhenWalkOver = $completeWhenWalkOver == "1";
         if($beginX != -1)
         {
            npcView.x = $beginX;
         }
         if($beginY != -1)
         {
            npcView.y = $beginY;
         }
         npcView["avatarView"]["angle"] = $angle;
         npcView["avatarView"]["state"] = 4;
         if($stepFrame > 0)
         {
            npcView["avatarView"]["stepFrame"] = $stepFrame;
            npcView["avatarView"]["isLockStepFrame"] = true;
         }
         $.C("com.greensock.TweenMax").to(npcView,$moveTime,{
            "x":$endX,
            "y":$endY,
            "onComplete":moveByTweenCompleteCall,
            "ease":$.C("com.greensock.easing.Linear").easeNone
         });
         if(!completeWhenWalkOver)
         {
            $.C("utils.NewbieUtils").execFunc(callback,callArgs);
         }
      }
    static sendEnterCollectionBattle() {
         $.C("dialog.utils.NewbieSocketOutManager").sendEnterCollectionBattle();
      }
    static setKeyboardState(param1, param2, param3 = "0", param4 = 0) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         switch(param4 - 1)
         {
            case 0:
               __NewbieBaseActionMediator._canEnableKeyboard = false;
               break;
            case 1:
               __NewbieBaseActionMediator._canEnableKeyboard = true;
         }
         if(__NewbieBaseActionMediator.canEnableKeyboard)
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("keyDown",__NewbieBaseActionMediator.__keyDownHandler,false,100);
         }
         $.C("utils.NewbieUtils").execFunc(param1,param2);
      }
    static __keyDownHandler(param1) {
         var _loc4_ = $.int($.C("yishi.manager.PlayerManager").instance.newbieProcess);
         var _loc2_ = _loc4_ == 11500 && (param1.keyCode == 49 || param1.keyCode == 97);
         var _loc3_ = _loc4_ == 12500 && (param1.keyCode == 50 || param1.keyCode == 98);
         if(__NewbieBaseActionMediator._drawClickEventArgs && (_loc2_ || _loc3_))
         {
            $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("keyDown",__NewbieBaseActionMediator.__keyDownHandler,false);
            $.C("utils.NewbieUtils").execFunc(__NewbieBaseActionMediator._drawClickEventArgs[1],__NewbieBaseActionMediator._drawClickEventArgs[2]);
            return;
         }
      }
    static clearCurrentGameAction() {
         var _loc1_ = $.C("yishi.manager.GameBaseQueueManager").instance.current;
         if(_loc1_)
         {
            if($.is(_loc1_, $.C("yishi.actions.map.MapBaseAction")))
            {
               ($.as(_loc1_, $.C("yishi.actions.map.MapBaseAction"))).finished = true;
            }
            _loc1_.dispose();
         }
      }
    static cleanGameLayer(param1 = 3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("com.pickgliss.ui.LayerManager").Instance.cleanLayerByType(param1);
      }
    static setNPC(param1, param2, param3, param4) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var _loc6_ = null;
         var _loc7_ = undefined;
         var _loc5_ = $.C("map.campaign.CampaignManager").instance.mapModel;
         if(!_loc5_)
         {
            return;
         }
         if(param1 <= 0)
         {
            _loc7_ = $.C("map.campaign.CampaignManager").instance.controller;
            _loc6_ = _loc7_ ? _loc7_.getArmyView(_loc5_.selfMemberData) : null;
         }
         else
         {
            _loc6_ = _loc5_.getNodeByNodeId(param1);
         }
         if(!_loc6_)
         {
            return;
         }
         if(param2 != -1)
         {
            _loc6_.x = param2;
         }
         if(param3 != -1)
         {
            _loc6_.y = param3;
         }
         if(param4 != -1)
         {
            _loc6_["avatarView"]["angle"] = param4;
         }
      }
    static sceneMove(param1, param2, param3, param4) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         $.C("map.campaign.CampaignManager").instance.controller.sceneMove(param3,param4,param1);
      }
    static lockCampaignScene(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         $.C("map.campaign.CampaignManager").instance.mapView.isLockMove = param1 == "1" ? true : false;
      }
    static setStageBaffle(param1) {
         if(param1)
         {
            $.C("utils.BaffleHelper").show();
         }
         else
         {
            $.C("utils.BaffleHelper").hide();
         }
      }
    static sendNodeArrive(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("map.campaign.CampaignManager").instance.controller.sendCampaignArrive($.C("yishi.manager.ArmyManager").instance.army.id,param1);
      }
    static showStartPlayView(param1, param2) {
         var _loc3_ = new ($.C("views.GameStartPlayView"))();
         _loc3_.callback = param1;
         _loc3_.show();
      }
    static doTask(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         if(param1 > 0)
         {
            _loc2_ = $.C("yishi.manager.TaskManage").instance.getTaskByID(param1);
         }
         else
         {
            _loc2_ = $.C("yishi.manager.TaskManage").instance.cate.mainTaskList ? $.C("yishi.manager.TaskManage").instance.cate.mainTaskList[0] : null;
         }
         if(!_loc2_)
         {
            return;
         }
         $.C("yishi.SwitchPageHelp").skipPageByTaskCondictionType(_loc2_,null);
      }
    static newModuleOpen(param1, param2, param3, param4 = 0, param5 = 1, param6 = "", param7 = 0, param8 = 0, param9 = 0) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number") param5 = Number(param5);
         if (param6 != null && typeof param6 !== "string") param6 = String(param6);
         if (typeof param7 !== "number" || (param7 | 0) !== param7) param7 = $.int(param7);
         if (typeof param8 !== "number" || (param8 | 0) !== param8) param8 = $.int(param8);
         if (typeof param9 !== "number" || (param9 | 0) !== param9) param9 = $.int(param9);
         var tweenArgs;
         var callback = param1;
         var callArgs = param2;
         var icon = param3;
         var value = param4;
         var flyDuration = param5;
         var flyReferTargetArgs = param6;
         var flyRelativeX = param7;
         var flyRelativeY = param8;
         var addShowBtn = param9;
         var cleanCreateAndComplete = () =>
         {
            __NewbieBaseActionMediator.cleanCreateTarget();
            $.C("utils.NewbieUtils").execFunc(callback,callArgs);
         };
         var text = __NewbieBaseActionMediator.getContentByValue(value);
         var setBtnArgs = [cleanCreateAndComplete,null,addShowBtn,"1"];
         if(addShowBtn > 0)
         {
            tweenArgs = [__NewbieBaseActionMediator.setMainToolBarBtn,setBtnArgs,"32",flyDuration,"{x:\'reference\'_y:\'reference\'_scaleX:0_scaleY:0}","0",flyReferTargetArgs,flyRelativeX,flyRelativeY,"0"];
         }
         else
         {
            tweenArgs = [cleanCreateAndComplete,null,"32",flyDuration,"{x:\'reference\'_y:\'reference\'_scaleX:0_scaleY:0}","0",flyReferTargetArgs,flyRelativeX,flyRelativeY,"0"];
         }
         __NewbieBaseActionMediator.createGuildTarget(__NewbieBaseActionMediator.tweenTarget,tweenArgs,"2_" + icon + "_" + text);
      }
    static getReplacedText(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc4_ = null;
         if(!param1)
         {
            return null;
         }
         var _loc6_ = param1.indexOf("{");
         var _loc5_ = param1.indexOf("}");
         if(_loc6_ < 0 || _loc5_ < 0 || _loc6_ > _loc5_)
         {
            return param1;
         }
         var _loc2_ = param1.slice(_loc6_,_loc5_ + 1);
         var _loc3_ = _loc2_.slice(1,_loc2_.length - 1).split("~");
         switch($.int(_loc3_[0]) - 1)
         {
            case 0:
               _loc4_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoByJobAndIdx($.C("yishi.manager.ArmyManager").instance.thane.templateInfo.Job,$.int(_loc3_[1])).TemplateName;
         }
         if(!_loc4_)
         {
            _loc4_ = "";
         }
         return param1.replace(_loc2_,_loc4_);
      }
    static getTargetObjSize(param1) {
         var _loc3_ = NaN;
         var _loc2_ = NaN;
         if($.is(param1, $.C("com.pickgliss.ui.core.Component")))
         {
            _loc3_ = Number(param1["displayWidth"]);
            _loc2_ = Number(param1["displayHeight"]);
         }
         else
         {
            _loc3_ = param1.width;
            _loc2_ = param1.height;
         }
         return {
            "w":_loc3_,
            "h":_loc2_
         };
      }
    static getGuildTarget(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc2_ = param1.split("_");
         var _loc6_;
         switch(_loc6_ = _loc2_.shift())
         {
            case 1:
               return __NewbieBaseActionMediator._copyTarget;
            case 2:
               return $.C("ui.maintoolbar.MainToolBar").instance.getButtnByType($.int(_loc2_[0]));
            case 3:
               _loc4_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType($.int(_loc2_[0]));
               return $.C("yishi.manager.BuildingManager").instance.castleMap["buildingsDic"][_loc4_.buildingId];
            case 4:
               return $.C("map.campaign.CampaignManager").instance.mapView["getLandItem"]($.int(_loc2_[0]));
            case 5:
               if(_loc2_.length >= 2)
               {
                  return $.C("battle.BattleManager").getInstance().battleUIView.getBottomBar().getSkillList().skillItemViews[$.int(_loc2_[0])][_loc2_[1]];
               }
               return $.C("battle.BattleManager").getInstance().battleUIView.getBottomBar().getSkillList().skillItemViews[$.int(_loc2_[0])];
               break;
            case 6:
               return $.C("yishi.manager.FrameControllerManager").instance.armyController.frame["equipView"].getItemViewByPos($.int(_loc2_[0]));
            case 7:
               return $.C("yishi.manager.FrameControllerManager").instance.armyController.frame["equipBag"].getBaseBagItemByPos($.int(_loc2_[0]));
            case 8:
               return $.C("yishi.manager.FrameControllerManager").instance.buildingController.frame["upgradeBtn"];
            case 9:
               return $.C("yishi.manager.FrameControllerManager").instance.buildingController.frame["pawnTileList"]["getRecruitPawnBtn"]($.int(_loc2_[0]));
            case 10:
               return $.C("yishi.manager.FrameControllerManager").instance.armyController.frame["getSkillItemByIndex"]($.int(_loc2_[0]));
            case 11:
               return $.C("mainBar.SmallMapBar").instance.getButtonByType($.int(_loc2_[0]));
            case 12:
               return $.C("ui.queuebar.QueueBar").instance.getQueueItemByType($.int(_loc2_[0]));
            case 13:
               return $.C("yishi.scene.SceneManager").instance.currentScene.sceneView["middleView"]["getItemByIdx"]($.int(_loc2_[0]));
            case 14:
               return $.C("ui.maintoolbar.MainToolBar").instance.recommendBtn;
            case 15:
               return $.C("yishi.manager.FrameControllerManager").instance.friendControler.frame["getAddBtnByIndex"]($.int(_loc2_[0]));
            case 16:
               return $.C("yishi.manager.FrameControllerManager").instance.buildingController.frame["levyView"]["levyBtn"];
            case 17:
               return $.C("yishi.manager.FrameControllerManager").instance.storeController.frame[_loc2_[0]];
            case 18:
               return $.C("yishi.manager.FrameControllerManager").instance.offerRewardController.frame["getOfferTaskItemByIndex"]($.int(_loc2_[0]))["acceptBtn"];
            case 19:
               return $.C("yishi.manager.FrameControllerManager").instance.buildingController.frame["getTechItemByIndex"]($.int(_loc2_[0])).upgradeBtn;
            case 20:
               return $.C("yishi.manager.FrameControllerManager").instance.pveRoomListControler.frame["getCreateBtn"]();
            case 21:
               return $.C("yishi.scene.SceneManager").instance.currentScene.sceneView["getSelectInstanceBtn"]();
            case 22:
               return $.C("managers.RoomManager").instance.controller.multiCampaignSelectFrame["getInstanceItemByIndex"]($.int(_loc2_[0]));
            case 23:
               return $.C("managers.RoomManager").instance.controller.multiCampaignSelectFrame["rightView"]["okBtn"];
            case 24:
               return $.C("yishi.manager.FrameControllerManager").instance.mazeControler.frame["startBtn"];
            case 25:
               return $.C("yishi.manager.FrameControllerManager").instance.starController.frame["getCrystalByIndex"]($.int(_loc2_[0]));
            case 26:
               return $.C("yishi.manager.FrameControllerManager").instance.spaceController.frame["getDialogItemByIndex"]($.int(_loc2_[0]));
            case 27:
               return $.C("yishi.manager.GameBaseQueueManager").instance.current["taskTip"]["commitText"];
            case 28:
               return $.C("yishi.manager.FrameControllerManager").instance.selectCampaignControler.frame["areaView"]["cpInfoView"][_loc2_[0]];
            case 29:
               _loc3_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType($.int(_loc2_[0]));
               return $.C("yishi.manager.BuildingManager").instance.castleMap["buildingsDic"][_loc3_.buildingId]["curView"]["effect_area"];
            case 30:
               switch($.int(_loc2_.length) - 2)
               {
                  case 0:
                     return $.C("map.campaign.CampaignManager").instance.mapModel.getNodeByNodeId($.int(_loc2_[0]))[_loc2_[1]];
                  case 1:
                     return $.C("map.campaign.CampaignManager").instance.mapModel.getNodeByNodeId($.int(_loc2_[0]))[_loc2_[1]][_loc2_[2]];
                  default:
                     return $.C("map.campaign.CampaignManager").instance.mapModel.getNodeByNodeId($.int(_loc2_[0]));
               }
               break;
            case 31:
               return $.C("ui.tasktracebar.TaskTraceBar").instance.taskTraceView["getTraceItemByTaskTempId"]($.int(_loc2_[0]));
            case 32:
               return __NewbieBaseActionMediator._createTarget;
            case 33:
               return $.C("yishi.manager.FrameControllerManager").instance.pvpControler.frame["singleView"]["starBtn"];
            case 34:
               switch($.int(_loc2_.length) - 2)
               {
                  case 0:
                     _loc5_ = $.C("yishi.manager.FrameControllerManager").instance.spaceController.frame["getMapNodeItemByNodeId"]($.int(_loc2_[0]))[_loc2_[1]];
                     if(_loc2_[1] == "selectedBg")
                     {
                        _loc5_.visible = true;
                     }
                     return _loc5_;
                  default:
                     return $.C("yishi.manager.FrameControllerManager").instance.spaceController.frame["getMapNodeItemByNodeId"]($.int(_loc2_[0]));
               }
               break;
            case 35:
               return $.C("yishi.manager.FrameControllerManager").instance.hookControler.frame["getRoomItem"]($.int(_loc2_[0]));
            case 36:
               return $.C("yishi.manager.FrameControllerManager").instance.supermarketController.frame["auctionShopView"]["enterBtn"];
            case 37:
               return $.C("ui.tasktracebar.TaskTraceBar").instance.spaceMapButtonView.getMapBtn();
            case 38:
               break;
            case 39:
               switch($.int(_loc2_.length) - 1)
               {
                  case 0:
                     return $.C("yishi.manager.FrameControllerManager").instance.armyController.frame[_loc2_[0]];
                  default:
                     return $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
               }
               break;
            case 40:
               return $.C("battle.BattleManager").getInstance().battleUIView.getBottomBar().activeAwakenFigure;
            case 41:
               return $.C("battle.BattleManager").getInstance().battleUIView.autoFightBtn;
            case 70:
               return $.C("yishi.manager.FrameControllerManager").instance.armyController.frame["equipView"]["magicCardBtn"];
            case 71:
               return $.C("yishi.manager.FrameControllerManager").instance.magicCardControler.frame["magicCardSlotView"]["treasureBtn"];
            case 80:
               switch($.int(_loc2_[0]) - 1)
               {
                  case 0:
                     return $.C("map.outercity.manager.OuterCityManager").instance.model.getPhysicsByXY(320,680);
                  case 1:
                     return $.C("map.outercity.manager.OuterCityManager").instance.model.getPhysicsByXY(720,680);
                  case 2:
                     return $.C("map.outercity.manager.OuterCityManager").instance.model.getPhysicsByXY(880,440);
                  default:
                     return null;
               }
               break;
            case 81:
               return $.C("yishi.manager.FrameControllerManager").instance.buildingController.frame["mapButton"];
            case 82:
               return $.C("yishi.manager.FrameControllerManager").instance.worldMapController.frame["mapAreaContainer"].movie["map1"];
            case 83:
               return $.C("map.outercity.manager.OuterCityManager").instance.controler.outerFrameManager.getFrameById(2).attackBtn;
            case 84:
               return $.C("yishi.manager.FrameControllerManager").instance.armyController.frame["vpLockBtn"];
         }
         return null;
      }
    static getTargetUnderPoint(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         var _loc6_ = null;
         var _loc4_ = null;
         var _loc7_ = null;
         var _loc10_ = 0;
         var _loc9_ = param1;
         var _loc8_ = param2;
         var _loc11_ = $.C("com.pickgliss.toplevel.StageReferance").stage.getObjectsUnderPoint(new ($.C("flash.geom.Point"))(_loc9_,_loc8_));
         var _loc5_ = $.int(_loc11_.length);
         _loc10_ = _loc5_ - 1;
         while(_loc10_ >= 0)
         {
            _loc4_ = _loc11_[_loc10_];
            _loc7_ = $.C("flash.utils.getQualifiedClassName")(_loc4_);
            if(_loc7_.indexOf("::") > -1)
            {
               _loc7_ = _loc7_.split("::")[1];
            }
            if(_loc7_ == param3)
            {
               _loc6_ = _loc4_;
               break;
            }
            _loc10_--;
         }
         return _loc6_;
      }
    static getContentByValue(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = "newbieXml.node.action.content" + param1;
         if(param1 != 0)
         {
            return $.C("manager.LanguageMgr").GetTranslation(_loc2_);
         }
         return "";
      }
  }
  $.meta(__NewbieBaseActionMediator, "mediators.NewbieBaseActionMediator", []);
  $.statics(__NewbieBaseActionMediator, () => {
    __NewbieBaseActionMediator.$$_mask = null;
    __NewbieBaseActionMediator._drawContainer = null;
    __NewbieBaseActionMediator._drawClickEventArgs = null;
    __NewbieBaseActionMediator._moveEventArgs = null;
    __NewbieBaseActionMediator._colorEffect = null;
    __NewbieBaseActionMediator._colorEventArgs = null;
    __NewbieBaseActionMediator._guildFrameList = null;
    __NewbieBaseActionMediator._guildArrowList = null;
    __NewbieBaseActionMediator._copyTarget = null;
    __NewbieBaseActionMediator._createTarget = null;
    __NewbieBaseActionMediator._canEnableKeyboard = true;
    __NewbieBaseActionMediator.canEnableKeyboard = false;
  });
  return __NewbieBaseActionMediator;
}
deps["mediators.NewbieBaseActionMediator"] = ["battle.BattleManager", "com.greensock.TweenMax", "com.greensock.easing.Linear", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.ShowTipManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "dialog.DialogManager", "dialog.utils.NewbieSocketOutManager", "flash.display.Bitmap", "flash.display.BitmapData", "flash.display.DisplayObjectContainer", "flash.display.Shape", "flash.display.Sprite", "flash.events.MouseEvent", "flash.geom.Point", "flash.utils.getQualifiedClassName", "mainBar.SmallMapBar", "manager.LanguageMgr", "managers.RoomManager", "map.campaign.CampaignManager", "map.internals.interfaces.IBaseMouseEvent", "map.internals.view.displaye.MapNameMovie", "map.outercity.manager.OuterCityManager", "map.space.SpaceManager", "ui.events.UIBarEvent", "ui.maintoolbar.MainToolBar", "ui.queuebar.QueueBar", "ui.tasktracebar.TaskTraceBar", "utils.BaffleHelper", "utils.DisObjResizeUtils", "utils.NewbieUtils", "views.GameStartPlayView", "views.NewModuleOpenPopView", "views.NoviceFameCampaign", "views.NoviceFogView", "views.NoviceFrame1", "views.NoviceFrame4", "yishi.SwitchPageHelp", "yishi.actions.map.MapBaseAction", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager", "yishi.manager.GameBaseQueueManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.TaskManage", "yishi.manager.TempleteManager", "yishi.scene.SceneManager", "yishi.scene.SceneType", "yishi.utils.CheckUIModuleUtil", "yishi.utils.ColorManager", "yishi.utils.IconFactory", "yishi.utils.MaskUtils", "yishi.view.guild.NameView", "yishi.view.guild.NoviceArrowView", "yishi.view.guild.QteGuideFrame", "yishi.view.tips.MessageTipManager"];

defs["mediators.NewbieBaseConditionMediator"] = function define($) {
  const __Base = $.Object;
  class __NewbieBaseConditionMediator extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static checkPlayerGrade(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.C("yishi.manager.ArmyManager").instance.thane.grades >= param1;
      }
    static checkInScene(param1, param2 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = null;
         var _loc4_ = $.C("yishi.scene.SceneManager").instance.currentType;
         if(_loc4_ == $.C("yishi.scene.SceneType").getSceneTypeById(param1))
         {
            if(param2 > 0 && _loc4_ == "CAMPAIGN_MAP_SCENE")
            {
               _loc3_ = $.C("map.campaign.CampaignManager").instance.mapModel;
               return _loc3_ && _loc3_.mapId == param2;
            }
            return true;
         }
         return false;
      }
    static checkNotInScene(param1, param2 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = null;
         var _loc4_ = $.C("yishi.scene.SceneManager").instance.currentType;
         if(_loc4_ != $.C("yishi.scene.SceneType").getSceneTypeById(param1))
         {
            return true;
         }
         if(param2 > 0 && _loc4_ == "CAMPAIGN_MAP_SCENE")
         {
            _loc3_ = $.C("map.campaign.CampaignManager").instance.mapModel;
            return !_loc3_ || _loc3_.mapId != param2;
         }
         return false;
      }
    static checkCastleBuild(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc2_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(param1);
         var _loc4_ = $.C("yishi.manager.BuildingManager").instance.castleMap;
         if(_loc2_ && _loc4_)
         {
            _loc3_ = _loc4_["buildingsDic"][_loc2_.buildingId];
            return _loc3_ && _loc3_["curView"] && _loc3_["curView"]["effect_area"];
         }
         return false;
      }
    static checkTaskIsComplete(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = $.C("yishi.manager.TaskManage").instance.getTaskByID(param1);
         return _loc2_ && _loc2_.isCompleted;
      }
    static checkSkillInfo(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return Boolean($.C("yishi.manager.ArmyManager").instance.thane.getSkillBySontype(param1));
      }
    static checkTaskHasCompleted(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.C("yishi.manager.TaskManage").instance.IsTaskFinish(param1);
      }
    static checkFrame(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc4_ = $.C("yishi.manager.FrameControllerManager").instance[param1]["frame"];
         var _loc3_ = "[object " + param2 + "]";
         return _loc4_ && _loc4_.toString() == _loc3_ && _loc4_.stage && _loc4_.visible;
      }
    static checkCampaignNodeState(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = null;
         var _loc3_ = $.C("map.campaign.CampaignManager").instance.mapModel;
         if(_loc3_)
         {
            _loc4_ = _loc3_.getMapNodeByNodeId(param1);
            return _loc4_ && _loc4_.info.state == param2;
         }
         return false;
      }
    static checkCampaignNodeView(param1, param2 = -1, param3 = -1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc5_ = null;
         var _loc4_ = $.C("map.campaign.CampaignManager").instance.mapModel;
         if(_loc4_)
         {
            _loc5_ = _loc4_.getNodeByNodeId(param1);
            return _loc5_ && _loc5_.stage && _loc5_.visible && _loc5_["displayWidth"] >= param2 && _loc5_["displayHeight"] >= param3;
         }
         return false;
      }
    static checkGoodsNum(param1, param2 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return $.C("yishi.manager.GoodsManager").instance.getGoodsNumByTempId(param1) >= param2;
      }
    static checkPlayerBagItemIsExistData(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame["equipBag"].getBaseBagItemByPos(param1);
         return _loc2_ && _loc2_.data;
      }
    static checkEquipBagItemIsExistData(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame["equipView"].getItemViewByPos(param1);
         return _loc2_ && _loc2_.data;
      }
    static checkHavePawn(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return $.C("yishi.manager.ArmyManager").instance.getTotalPawnsNumberBySonType(param1) >= param2;
      }
    static checkInCastleOrSpace() {
         return __NewbieBaseConditionMediator.checkInScene(1) || __NewbieBaseConditionMediator.checkInScene(10);
      }
    static checkRolesNumInBattle(param1, param2 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = $.C("battle.BattleManager").getInstance().battleModel;
         if(!_loc4_)
         {
            return false;
         }
         var _loc5_ = 0;
         for (var _loc3_ of $.values(_loc4_.roleList))
         {
            if(param2 == 0 || param2 == _loc3_.side)
            {
               _loc5_++;
            }
         }
         return _loc5_ < param1;
      }
    static checkNodeIsOccupy(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = $.C("map.outercity.manager.OuterCityManager").instance.model.getPhysicsByXY(param1,param2);
         if(_loc3_.info.info.occupyPlayerId == $.C("yishi.manager.ArmyManager").instance.thane.userId)
         {
            return true;
         }
         return false;
      }
    static checkTaskProcess(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         for (var _loc3_ of $.values($.C("yishi.manager.TaskManage").instance.cate.acceptedList))
         {
            if(_loc3_.TemplateId == 60)
            {
               if(param2 == 1 && _loc3_.getProgress()[0] == "(1 / 2)")
               {
                  return true;
               }
               return false;
            }
         }
         return false;
      }
    static checkOuterFrameExist(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(param1 == 1 && $.C("map.outercity.manager.OuterCityManager").instance.controler.outerFrameManager.getFrameById(2).parent)
         {
            return true;
         }
         return false;
      }
    static checkIsInNewbieMap() {
         var _loc1_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.mapNodeInfo;
         if(_loc1_ && _loc1_.info.mapId >= 100000000)
         {
            return false;
         }
         return true;
      }
    static checkCampaignNodeAvatarState(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = null;
         var _loc3_ = $.C("map.campaign.CampaignManager").instance.mapModel;
         if(_loc3_)
         {
            _loc4_ = param1 == -1 ? $.C("map.campaign.CampaignManager").instance.controller.getArmyVIew(_loc3_.selfMemberData) : _loc3_.getNodeByNodeId(param1);
            return _loc4_ && _loc4_["avatarView"] && _loc4_["avatarView"]["state"] == param2;
         }
         return false;
      }
    static checkTaskIsCompleteOrCompleted(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return __NewbieBaseConditionMediator.checkTaskIsComplete(param1) || __NewbieBaseConditionMediator.checkTaskHasCompleted(param1);
      }
    static checkSkillInBattle(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc4_ = null;
         var _loc2_ = $.C("battle.BattleManager").getInstance().battleUIView;
         var _loc3_ = _loc2_ && _loc2_.getBottomBar() && _loc2_.getBottomBar().getSkillList() && _loc2_.getBottomBar().getSkillList().skillItemViews;
         if(_loc3_)
         {
            _loc4_ = _loc2_.getBottomBar().getSkillList().skillItemViews[param1];
            return _loc4_ && _loc4_.data;
         }
         return false;
      }
    static checkConditionCommon(param1, param2 = null, param3 = null, param4 = null) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         var _loc19_ = null;
         var _loc12_ = null;
         var _loc7_ = null;
         var _loc5_ = false;
         var _loc8_ = 0;
         var _loc10_ = null;
         var _loc14_ = null;
         var _loc11_ = null;
         var _loc15_ = null;
         var _loc9_ = null;
         var _loc13_ = null;
         var _loc17_ = null;
         var _loc18_ = null;
         var _loc6_ = null;
         var _loc20_ = null;
         var _loc16_ = null;
         switch(param1)
         {
            case 1:
               _loc19_ = $.C("managers.RoomManager").instance.controller ? $.C("managers.RoomManager").instance.controller.multiCampaignSelectFrame : null;
               return _loc19_ && _loc19_.stage && _loc19_.visible;
            case 2:
               _loc12_ = $.C("yishi.manager.GameBaseQueueManager").instance.current;
               return _loc12_ && $.is(_loc12_, $.C("yishi.actions.task.CompleteTaskAction")) && _loc12_["taskTip"] && _loc12_["taskTip"].stage && _loc12_["taskTip"].visible;
            case 3:
               _loc7_ = $.C("ui.tasktracebar.TaskTraceBar").instance;
               _loc5_ = _loc7_.stage && _loc7_.visible;
               _loc8_ = $.int(param2);
               if(_loc8_ > 0)
               {
                  return _loc5_ && _loc7_.taskTraceView && _loc7_.taskTraceView["getTraceItemByTaskTempId"](_loc8_);
               }
               return _loc5_;
               break;
            case 4:
               _loc10_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.casernRecruitFrame;
               return _loc10_ && _loc10_.stage && _loc10_.visible;
            case 5:
               return $.C("ui.maintoolbar.MainToolBar").instance.recommendBtnIsExist();
            case 6:
               _loc14_ = $.C("yishi.manager.GameBaseQueueManager").instance.current;
               return _loc14_ && $.is(_loc14_, $.C("yishi.actions.hero.HeroLeveUpdateAction")) && !_loc14_.finished && _loc14_["view"] && _loc14_["view"].stage && _loc14_["view"].visible;
            case 7:
               return $.C("yishi.manager.GoodsManager").instance.getCountBySontypeAndBagType($.int(param2),$.int(param3)) >= $.int(param4);
            case 8:
               return $.C("yishi.manager.ArmyManager").instance.thane.templateId == 100;
            case 9:
               return $.C("yishi.manager.ArmyManager").instance.army.countAllArmyPawnNmber() >= $.int(param2);
            case 10:
               _loc11_ = $.C("battle.BattleManager").getInstance().battleModel;
               return _loc11_ && _loc11_.selfHero && _loc11_.selfHero.canMorph();
            case 11:
               return $.C("ui.maintoolbar.MainToolBar").ISINIT;
            case 12:
               _loc15_ = $.C("yishi.scene.SceneManager").instance.currentType;
               return _loc15_ && _loc15_ != "" && _loc15_ != "EMPTY_SCENE";
            case 13:
               _loc9_ = $.C("yishi.manager.FrameControllerManager").instance.selectCampaignControler.frame;
               if(_loc9_ && _loc9_["areaView"] && _loc9_["areaView"]["cpInfoView"])
               {
                  _loc13_ = _loc9_["areaView"]["cpInfoView"];
                  _loc17_ = _loc13_[param2];
                  return _loc13_.parent && _loc13_.visible && _loc17_ && _loc17_.parent && _loc17_.visible && _loc17_.enable;
               }
               return false;
               break;
            case 14:
               return $.C("yishi.manager.FriendManager").getInstance().countFriend >= $.int(param2);
            case 15:
               _loc18_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
               return _loc18_ && _loc18_.towerInfo && _loc18_.towerInfo.towerIndex > 0;
            case 16:
               _loc6_ = $.C("battle.BattleManager").getInstance().battleUIView ? $.C("battle.BattleManager").getInstance().battleUIView.autoFightBtn : null;
               return _loc6_ && _loc6_.parent && _loc6_.visible && _loc6_.enable && _loc6_.selected;
            case 70:
               _loc20_ = $.C("yishi.manager.ConfigManager").info;
               return _loc20_ && _loc20_[param2];
            case 80:
               return $.C("com.pickgliss.ui.controls.Frame").hasOpenFrame;
            case 84:
               _loc16_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
               return _loc16_["vpLockBtn"] != null;
            default:
               return false;
         }
      }
  }
  $.meta(__NewbieBaseConditionMediator, "mediators.NewbieBaseConditionMediator", []);
  return __NewbieBaseConditionMediator;
}
deps["mediators.NewbieBaseConditionMediator"] = ["battle.BattleManager", "com.pickgliss.ui.controls.Frame", "managers.RoomManager", "map.campaign.CampaignManager", "map.outercity.manager.OuterCityManager", "ui.maintoolbar.MainToolBar", "ui.tasktracebar.TaskTraceBar", "yishi.actions.hero.HeroLeveUpdateAction", "yishi.actions.task.CompleteTaskAction", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.ConfigManager", "yishi.manager.FrameControllerManager", "yishi.manager.FriendManager", "yishi.manager.GameBaseQueueManager", "yishi.manager.GoodsManager", "yishi.manager.PlayerManager", "yishi.manager.TaskManage", "yishi.scene.SceneManager", "yishi.scene.SceneType"];

defs["mediators.NewbieSpecialActionMediator"] = function define($) {
  const __Base = $.Object;
  class __NewbieSpecialActionMediator extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static tweenCompleteCall(param1, param2, param3, param4) {
         $.C("com.greensock.TweenMax").killTweensOf(param1);
         if(param2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(param1);
            param1 = null;
         }
         $.C("utils.NewbieUtils").execFunc(param3,param4);
      }
    static getWorldMapMovie(param1, param2) {
         var _loc3_ = null;
         var _loc4_ = $.C("yishi.manager.FrameControllerManager").instance.worldMapController.frame;
         var _loc5_ = _loc4_["mapAreaContainer"].movie["map1"];
         _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("novice.NoviceWorld");
         _loc3_.x = 298;
         _loc3_.y = 438;
         _loc4_["addChild"](_loc3_);
         $.C("utils.NewbieUtils").execFunc(param1,param2);
      }
    static weaponEquipGuild(param1, param2) {
         var flag;
         var weaponItem;
         var itemView;
         var callback = param1;
         var callArgs = param2;
         var gotoGoodsItem = () =>
         {
            flag = 1;
            itemView = bagFrame["equipBag"].getBaseBagItemByType(101);
            if(!itemView)
            {
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
               return;
            }
            bagFrame["equipBag"].addChild(itemView);
            $.C("mediators.NewbieBaseActionMediator").cleanAll();
            $.C("mediators.NewbieBaseActionMediator").showMask();
            $.C("mediators.NewbieBaseActionMediator").createGuildFrame1("",-144,7,4201,"1",4,0,0,itemView);
            $.C("mediators.NewbieBaseActionMediator").drawTargetOnMask(null,null,"","1",-1,0,0,null,itemView);
            $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("enterFrame",pawnEnterFrame);
         };
         var gotoPlayItem = () =>
         {
            flag = 2;
            if(bagFrame)
            {
               bagFrame.escEnable = false;
            }
            $.C("mediators.NewbieBaseActionMediator").cleanAll();
            $.C("mediators.NewbieBaseActionMediator").createGuildFrame1("",-155,5,4202,"0",4,0,0,weaponItem);
         };
         var pawnEnterFrame = (param1) =>
         {
            if(weaponItem.data)
            {
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",pawnEnterFrame);
               $.C("mediators.NewbieBaseActionMediator").cleanAll();
               $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("enterFrame",closeBagFrame);
               return;
            }
            if($.C("yishi.manager.DragManager").getInstance().isDraging && flag == 1)
            {
               gotoPlayItem();
            }
            else if($.C("yishi.manager.DragManager").getInstance().isDraging == false && flag == 1)
            {
               if(!itemView.data)
               {
                  $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",pawnEnterFrame);
                  gotoGoodsItem();
               }
            }
            else if($.C("yishi.manager.DragManager").getInstance().isDraging == false && flag == 2)
            {
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",pawnEnterFrame);
               gotoGoodsItem();
            }
         };
         var closeBagFrame = (param1) =>
         {
            if(!bagFrame || !bagFrame["closeButton"])
            {
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",closeBagFrame);
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("mediators.NewbieBaseActionMediator").cleanAll();
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
            }
         };
         var bagFrame = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         bagFrame["equipBag"].showEffectBySontype(292);
         flag = 0;
         weaponItem = bagFrame["heroEquip"].weapon;
         itemView = bagFrame["equipBag"].getBaseBagItemByType(101);
         if(!itemView)
         {
            $.C("utils.NewbieUtils").execFunc(callback,callArgs);
            return;
         }
         $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"0",1);
         gotoGoodsItem();
      }
    static pawnAllocateGuild(param1, param2) {
         var gongPawnCell;
         var soldierPawnCell;
         var callback = param1;
         var callArgs = param2;
         var iconFrame = (param1) =>
         {
            if(allocateFrame == null || allocateFrame["allocateView"] == null)
            {
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
               return;
            }
            if(allocateFrame["allocateView"].getPawnDragCellByMasterType(1) == null || allocateFrame["allocateView"].getPawnDragCellByMasterType(1)["icon"] == null)
            {
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
               return;
            }
            gongPawnCell = allocateFrame["allocateView"].getPawnDragCellByMasterType(1)["icon"];
            if(gongPawnCell.displayWidth > 50 && gongPawnCell.stage)
            {
               soldierPawnCell = allocateFrame["allocateView"].SoldierPawn;
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",iconFrame);
               pawnBtnClick();
            }
         };
         var pawnBtnClick = () =>
         {
            flag = 1;
            $.C("mediators.NewbieBaseActionMediator").cleanAll();
            $.C("mediators.NewbieBaseActionMediator").showMask();
            $.C("mediators.NewbieBaseActionMediator").createGuildFrame1("",-171,20,4301,"1",4,0,0,gongPawnCell);
            $.C("mediators.NewbieBaseActionMediator").drawTargetOnMask(null,null,"","1",-1,0,0,null,gongPawnCell);
            $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("enterFrame",pawnEnterFrame);
         };
         var gotoSoldierPawn = () =>
         {
            flag = 2;
            if(allocateFrame)
            {
               allocateFrame.escEnable = false;
            }
            $.C("mediators.NewbieBaseActionMediator").cleanAll();
            $.C("mediators.NewbieBaseActionMediator").createGuildFrame1("",-135,60,4302,"1",4,0,0,soldierPawnCell);
         };
         var pawnEnterFrame = (param1) =>
         {
            var _loc2_ = $.int($.C("yishi.manager.ArmyManager").instance.army.countAllArmyPawnNmber());
            if(_loc2_ > 0)
            {
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",pawnEnterFrame);
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("mediators.NewbieBaseActionMediator").cleanAll();
               allocateFrame.dispose();
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
               return;
            }
            if($.C("yishi.manager.DragManager").getInstance().isDraging && flag == 1)
            {
               gotoSoldierPawn();
            }
            else if($.C("yishi.manager.DragManager").getInstance().isDraging == false && flag == 2)
            {
               if(!$.C("yishi.manager.FrameControllerManager").instance.armyController.isAdjustPawn)
               {
                  $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",pawnEnterFrame);
                  if(!gongPawnCell || !gongPawnCell.stage)
                  {
                     $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
                     $.C("mediators.NewbieBaseActionMediator").cleanAll();
                     allocateFrame.dispose();
                     $.C("utils.NewbieUtils").execFunc(callback,callArgs);
                     return;
                  }
                  pawnBtnClick();
               }
               else
               {
                  $.C("mediators.NewbieBaseActionMediator").cleanAll();
               }
            }
         };
         var flag = 0;
         var allocateFrame = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         var prevNumber = $.int($.C("yishi.manager.ArmyManager").instance.army.countAllArmyPawnNmber());
         if(prevNumber > 0)
         {
            allocateFrame.dispose();
            $.C("utils.NewbieUtils").execFunc(callback,callArgs);
            return;
         }
         $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"0",1);
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("enterFrame",iconFrame);
      }
    static weaponIntensifyGuild(param1, param2) {
         var flag;
         var callback = param1;
         var callArgs = param2;
         var __storeFrame = (param1) =>
         {
            if(!storeFrame || !storeFrame["intensifyView"])
            {
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",__storeFrame);
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
               return;
            }
            if(flag == 0)
            {
               setFlag(1);
            }
            if($.C("yishi.manager.DragManager").getInstance().isDraging == true && flag == 1)
            {
               setFlag(2);
            }
            if($.C("yishi.manager.DragManager").getInstance().isDraging == false && flag == 2 && !storeFrame["intensifyView"].equip1.data)
            {
               setFlag(1);
            }
            if(storeFrame["intensifyView"].equip1.data)
            {
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",__storeFrame);
               setFlag(3);
            }
         };
         var gotoOneItem = (param1, param2) =>
         {
            if(param1.data.strengthenGrade > 1)
            {
               $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",__storeFrame);
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("mediators.NewbieBaseActionMediator").cleanAll();
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
               return;
            }
            storeFrame["storeBag"].addChild(param1);
            if(param1.y % 48 == 0)
            {
               param1.y += 2;
            }
            $.C("mediators.NewbieBaseActionMediator").cleanAll();
            $.C("mediators.NewbieBaseActionMediator").showMask();
            $.C("mediators.NewbieBaseActionMediator").createGuildFrame1("",-186,6,param2,"1",4,0,0,param1);
            $.C("mediators.NewbieBaseActionMediator").drawTargetOnMask(null,null,"","1",-1,0,0,null,param1);
         };
         var gotoEquip = () =>
         {
            if(storeFrame)
            {
               storeFrame["escEnable"] = false;
            }
            var _loc1_ = storeFrame["intensifyView"].equip1;
            $.C("mediators.NewbieBaseActionMediator").cleanAll();
            $.C("mediators.NewbieBaseActionMediator").createGuildFrame1("",-156,40,4401,"0",4,0,0,_loc1_);
         };
         var gotoIntenBtn = () =>
         {
            var btnClick = (param1) =>
            {
               btn.removeEventListener("click",btnClick);
               storeFrame = null;
               $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
               $.C("mediators.NewbieBaseActionMediator").cleanAll();
               $.C("utils.NewbieUtils").execFunc(callback,callArgs);
            };
            var btn = storeFrame["intensifyView"].intensifyBtn;
            btn.addEventListener("click",btnClick);
            $.C("mediators.NewbieBaseActionMediator").cleanAll();
            $.C("mediators.NewbieBaseActionMediator").showMask();
            $.C("mediators.NewbieBaseActionMediator").createGuildFrame1("",-405,-112,4402,"1",1,0,0,btn);
            $.C("mediators.NewbieBaseActionMediator").drawTargetOnMask(null,null,"","1",-1,0,0,null,btn);
         };
         var setFlag = (param1) =>
         {
            var _loc2_ = null;
            if(flag == param1)
            {
               return;
            }
            flag = param1;
            switch(flag - 1)
            {
               case 0:
                  _loc2_ = getWeaponItem(storeFrame["storeBag"].itemList);
                  if(_loc2_ == null)
                  {
                     flag = 0;
                     $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("enterFrame",__storeFrame);
                     $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"1",2);
                     $.C("mediators.NewbieBaseActionMediator").cleanAll();
                     $.C("utils.NewbieUtils").execFunc(callback,callArgs);
                     return;
                  }
                  gotoOneItem(_loc2_,4403);
                  break;
               case 1:
                  gotoEquip();
                  break;
               case 2:
                  gotoIntenBtn();
            }
         };
         var getWeaponItem = (param1) =>
         {
            for (var _loc2_ of $.values(param1))
            {
               if(_loc2_.data && _loc2_.data.templateInfo.SonType == 101)
               {
                  return _loc2_;
               }
            }
            return null;
         };
         var storeFrame = $.C("yishi.manager.FrameControllerManager").instance.storeController.frame;
         setFlag(1);
         $.C("mediators.NewbieBaseActionMediator").setKeyboardState(null,null,"0",1);
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("enterFrame",__storeFrame);
      }
    static enterSceneAfterPlayMovie(param1, param2, param3, param4 = 2, param5 = 0, param6 = 0) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(param3))
         {
            switch(param3)
            {
               case "jump":
                  __NewbieSpecialActionMediator.playJump(param1,param2,param3,param4);
                  break;
               case "flytovillage":
                  __NewbieSpecialActionMediator.playFlyToVillage(param1,param2,param3,param4);
                  break;
               case "flytocastle":
                  __NewbieSpecialActionMediator.playFlyToCastle(param1,param2,param3,param4);
                  break;
               default:
                  __NewbieSpecialActionMediator.playNormal(param1,param2,param3,param4,param5,param6);
            }
         }
         else
         {
            __NewbieSpecialActionMediator.enterSceneCall(param1,param2,param5,param6);
         }
      }
    static enterSceneCall(param1, param2, param3 = 0, param4 = 0) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if(param3 > 0)
         {
            switch(param3 - 102)
            {
               case 0:
                  $.C("mediators.NewbieBaseActionMediator").sendNodeArrive(1000211);
                  break;
               case 1:
                  $.C("mediators.NewbieBaseActionMediator").sendNodeArrive(1000211);
                  $.C("map.campaign.CampaignSocketOutManager").instance.sendReturnCampaignRoom(0);
                  break;
               default:
                  $.C("mediators.NewbieBaseActionMediator").sendEnterScene(param3,param4);
            }
         }
         $.C("utils.NewbieUtils").execFunc(param1,param2);
      }
    static playNormal(param1, param2, param3, param4 = 2, param5 = 0, param6 = 0) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         var _loc7_ = $.C("map.campaign.CampaignManager").instance.mapView;
         var _loc8_ = new ($.C("yishi.view.tools.BaseMovie"))($.C("yishi.manager.PathManager").getNewbieMovieByJob(param3,$.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.job),__NewbieSpecialActionMediator.enterSceneCall,[param1,param2,param5,param6]);
         if(_loc7_)
         {
            if(_loc7_["walkLayer"])
            {
               _loc7_["walkLayer"].visible = false;
            }
            _loc7_.addChild(_loc8_);
         }
      }
    static playJump(param1, param2, param3, param4 = 2) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var callback = param1;
         var callArgs = param2;
         var path = param3;
         var showLayer = param4;
         var onMoviePlayOver = () =>
         {
            if(mapView)
            {
               mapView["isLockMove"] = true;
               $.C("mediators.NewbieBaseActionMediator").setNPC(0,1370,1390,270);
               mapView["isLockMove"] = false;
               __NewbieSpecialActionMediator.setSelfArmyViewVisible(true);
            }
            __NewbieSpecialActionMediator.enterSceneCall(callback,callArgs);
         };
         var onMoviePlaying = () =>
         {
            if(mov.content && mov.content.currentFrame == 1)
            {
               __NewbieSpecialActionMediator.setSelfArmyViewVisible(false);
            }
            if(mapView && mov.content && mov.content["map"])
            {
               mapView.x = mov.content["map"].x;
               mapView.y = mov.content["map"].y;
               mapView.scaleX = mov.content["map"].scaleX;
               mapView.scaleY = mov.content["map"].scaleY;
            }
         };
         var mapView = $.C("map.campaign.CampaignManager").instance.mapView;
         var mov = new ($.C("yishi.view.tools.BaseMovie"))($.C("yishi.manager.PathManager").getNewbieMovieByJob(path,$.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.job),onMoviePlayOver,null,onMoviePlaying);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(mov,showLayer,false,false);
      }
    static playFlyToVillage(param1, param2, param3, param4 = 2) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var mapView;
         var mov;
         var callback = param1;
         var callArgs = param2;
         var path = param3;
         var showLayer = param4;
         var onMoviePlayOver = () =>
         {
            var onMoveOver = () =>
            {
               $.C("mediators.NewbieBaseActionMediator").setNPC(0,-1,-1,270);
               $.C("mediators.NewbieBaseActionMediator").hideMask();
               $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("UI_ENTER_SCENE"));
               __NewbieSpecialActionMediator.enterSceneCall(callback,callArgs);
            };
            if(mapView)
            {
               if(mapView["walkLayer"])
               {
                  mapView["walkLayer"].visible = true;
               }
               mapView["isLockMove"] = true;
               $.C("mediators.NewbieBaseActionMediator").setNPC(0,1010,750,350);
               mapView["isLockMove"] = false;
            }
            $.C("mediators.NewbieBaseActionMediator").showMask(0);
            $.C("mediators.NewbieBaseActionMediator").moveNPC(onMoveOver,null,0,-1,-1,101,60,"1");
         };
         var onMoviePlaying = () =>
         {
            if(mov.content && mov.content.currentFrame == 1)
            {
               $.C("mediators.NewbieBaseActionMediator").showMask(0);
            }
            if(mapView && mov.content && mov.content["map"])
            {
               mapView.x = mov.content["map"].x;
               mapView.y = mov.content["map"].y;
               mapView.scaleX = mov.content["map"].scaleX;
               mapView.scaleY = mov.content["map"].scaleY;
            }
         };
         $.C("mediators.NewbieBaseActionMediator").showMask(1,2);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("UI_OUT_SCENE"));
         mapView = $.as($.C("map.campaign.CampaignManager").instance.mapView, $.C("flash.display.Sprite"));
         if(mapView["walkLayer"])
         {
            mapView["walkLayer"].visible = false;
         }
         mov = new ($.C("yishi.view.tools.BaseMovie"))($.C("yishi.manager.PathManager").getNewbieMovieByJob(path,$.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.job),onMoviePlayOver,null,onMoviePlaying);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(mov,showLayer,false,false);
      }
    static playFlyToCastle(param1, param2, param3, param4 = 2) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var mapView;
         var mov;
         var callback = param1;
         var callArgs = param2;
         var path = param3;
         var showLayer = param4;
         var onMoviePlayOver = () =>
         {
            $.C("mediators.NewbieBaseActionMediator").sendEnterCollectionBattle();
            $.C("mediators.NewbieBaseActionMediator").hideMask();
            $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("UI_ENTER_SCENE"));
            __NewbieSpecialActionMediator.enterSceneCall(callback,callArgs);
         };
         var onDialogOver = () =>
         {
            if(mov)
            {
               mov.dispose();
            }
            else
            {
               onMoviePlayOver();
            }
         };
         var onMoviePlaying = () =>
         {
            if(mov.content)
            {
               if(mov.content.currentFrame == 1)
               {
                  $.C("mediators.NewbieBaseActionMediator").showMask(0);
               }
               if(mov.content.currentFrame == 190)
               {
                  mov.stop();
                  $.C("mediators.NewbieBaseActionMediator").showDialog(onDialogOver,null,"16");
               }
            }
            if(mapView && mov.content && mov.content["map"])
            {
               mapView.x = mov.content["map"].x;
               mapView.y = mov.content["map"].y;
               mapView.scaleX = mov.content["map"].scaleX;
               mapView.scaleY = mov.content["map"].scaleY;
            }
         };
         $.C("mediators.NewbieBaseActionMediator").showMask(1,2);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("yishi.events.NotificationEvent"))("UI_OUT_SCENE"));
         mapView = $.as($.C("yishi.manager.BuildingManager").instance.castleMap, $.C("flash.display.Sprite"));
         mov = new ($.C("yishi.view.tools.BaseMovie"))($.C("yishi.manager.PathManager").getNewbieMovieByJob(path,$.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.job),onMoviePlayOver,null,onMoviePlaying);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(mov,showLayer,false,false);
      }
    static setSelfArmyViewVisible(param1) {
         var _loc2_ = null;
         if($.C("map.campaign.CampaignManager").instance.controller && $.C("map.campaign.CampaignManager").instance.mapModel)
         {
            _loc2_ = $.as($.C("map.campaign.CampaignManager").instance.controller.getArmyView($.C("map.campaign.CampaignManager").instance.mapModel.selfMemberData), $.C("flash.display.DisplayObject"));
         }
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
  }
  $.meta(__NewbieSpecialActionMediator, "mediators.NewbieSpecialActionMediator", []);
  return __NewbieSpecialActionMediator;
}
deps["mediators.NewbieSpecialActionMediator"] = ["com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "flash.display.DisplayObject", "flash.display.Sprite", "map.campaign.CampaignManager", "map.campaign.CampaignSocketOutManager", "mediators.NewbieBaseActionMediator", "utils.NewbieUtils", "yishi.events.NotificationEvent", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.DragManager", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.utils.StringHelper", "yishi.view.tools.BaseMovie"];

defs["nodes.NoviceNode_10"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_10 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask_1();
               break;
            case 1:
               this.moveFocusToCastleBuild();
               break;
            case 2:
               this.drawTargetOnMask_1();
               break;
            case 3:
               this.castleBuildShine();
               break;
            case 4:
               this.createGuildFrame4();
               break;
            case 5:
               this.cleanDrawContainer();
               break;
            case 6:
               this.cleanGuildFrame();
               break;
            case 7:
               this.showMask_2();
               break;
            case 8:
               this.createGuildFrame1();
               break;
            case 9:
               this.drawTargetOnMask_2();
               break;
            case 10:
               this.cleanAll();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(12) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(1))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.5";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveFocusToCastleBuild() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCastleBuild(1509))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            this.actionParams = "1509";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    drawTargetOnMask_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "3_1509,0";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    castleBuildShine() {
         this.actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         this.actionParams = "1509";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    createGuildFrame4() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         this.actionParams = "50,-150,toCastle_4000";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanDrawContainer() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    cleanGuildFrame() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showMask_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|showMask";
         this.actionParams = "0.5";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    createGuildFrame1() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "29_1509,-400,90,1423,1,1";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "3_1509,1";
         this.needWaitForComplete = true;
         $.C("farm.FarmManager").instance.model.showHomeFarmValue = 1;
         this.excuteAction();
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    get canDisplay() {
         if($.C("yishi.scene.SceneManager").instance.currentType == "CASTLE_SCENE")
         {
            return true;
         }
         return false;
      }
    set canDisplay(v) { super.canDisplay = v; }
  }
  $.meta(__NoviceNode_10, "nodes.NoviceNode_10", []);
  return __NoviceNode_10;
}
deps["nodes.NoviceNode_10"] = ["dialog.utils.NewbieNodeBase", "farm.FarmManager", "mediators.NewbieBaseConditionMediator", "yishi.scene.SceneManager"];

defs["nodes.NoviceNode_20"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_20 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask();
               break;
            case 1:
               this.newModuleOpen();
               break;
            case 2:
               this.cleanAll();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(13) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    newModuleOpen() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(13) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            this.actionParams = "guild,5706,1,2_8,0,0,8";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceNode_20, "nodes.NoviceNode_20", []);
  return __NoviceNode_20;
}
deps["nodes.NoviceNode_20"] = ["dialog.utils.NewbieNodeBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceNode_30"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_30 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask_1();
               break;
            case 1:
               this.moveFocusToCastleBuild();
               break;
            case 2:
               this.drawTargetOnMask_1();
               break;
            case 3:
               this.castleBuildShine();
               break;
            case 4:
               this.createGuildFrame4();
               break;
            case 5:
               this.showMask_2();
               break;
            case 6:
               this.createGuildFrame1_1();
               break;
            case 7:
               this.drawTargetOnMask_2();
               break;
            case 8:
               this.cleanDrawContainer();
               break;
            case 9:
               this.cleanGuildFrame();
               break;
            case 10:
               this.emptyAction();
               break;
            case 11:
               this.createGuildFrame1_2();
               break;
            case 12:
               this.drawTargetOnMask_3();
               break;
            case 13:
               this.cleanAll();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(15) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(1))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.5";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveFocusToCastleBuild() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCastleBuild(1511))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            this.actionParams = "1511";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    drawTargetOnMask_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "3_1511,0";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    castleBuildShine() {
         this.actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         this.actionParams = "1511";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    createGuildFrame4() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         this.actionParams = "-250,50,toCastle_3800";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    showMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","TransferBuildFrame"))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|showMask";
         this.actionParams = "0.5";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    createGuildFrame1_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","TransferBuildFrame"))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "29_1511,-200,0,1419,1,4";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","TransferBuildFrame"))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "3_1511,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanDrawContainer() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    cleanGuildFrame() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    emptyAction() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","TransferBuildFrame"))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame1_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "81,-300,-50,1420,1,1";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_3() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "81,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    get canDisplay() {
         if($.C("yishi.scene.SceneManager").instance.currentType == "CASTLE_SCENE")
         {
            return true;
         }
         return false;
      }
    set canDisplay(v) { super.canDisplay = v; }
  }
  $.meta(__NoviceNode_30, "nodes.NoviceNode_30", []);
  return __NoviceNode_30;
}
deps["nodes.NoviceNode_30"] = ["dialog.utils.NewbieNodeBase", "mediators.NewbieBaseConditionMediator", "yishi.scene.SceneManager"];

defs["nodes.NoviceNode_40"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_40 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask();
               break;
            case 1:
               this.newModuleOpen();
               break;
            case 2:
               this.cleanAll();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(16) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    newModuleOpen() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(16) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            this.actionParams = "horse,5708,1,2_13,0,0,13";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceNode_40, "nodes.NoviceNode_40", []);
  return __NoviceNode_40;
}
deps["nodes.NoviceNode_40"] = ["dialog.utils.NewbieNodeBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceNode_50"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_50 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask();
               break;
            case 1:
               this.newModuleOpen();
               break;
            case 2:
               this.cleanAll();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(18) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    newModuleOpen() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(18) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            this.actionParams = "star,5710,1,2_5,0,0,5";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceNode_50, "nodes.NoviceNode_50", []);
  return __NoviceNode_50;
}
deps["nodes.NoviceNode_50"] = ["dialog.utils.NewbieNodeBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceNode_60"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_60 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask();
               break;
            case 1:
               this.newModuleOpen();
               break;
            case 2:
               this.cleanAll();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(50) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    newModuleOpen() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(50) && !$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(6))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            this.actionParams = "pet,5719,1,2_14,0,0,14";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceNode_60, "nodes.NoviceNode_60", []);
  return __NoviceNode_60;
}
deps["nodes.NoviceNode_60"] = ["dialog.utils.NewbieNodeBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceNode_70"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_70 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.setMainToolBarBtn();
               break;
            case 1:
               this.cleanAll_1();
         }
      }
    setMainToolBarBtn() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(70) && $.C("mediators.NewbieBaseConditionMediator").checkNotInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|setMainToolBarBtn";
            this.actionParams = "6,1";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceNode_70, "nodes.NoviceNode_70", []);
  return __NoviceNode_70;
}
deps["nodes.NoviceNode_70"] = ["dialog.utils.NewbieNodeBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceNode_80"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieNodeBase");
  class __NoviceNode_80 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask();
               break;
            case 1:
               this.newModuleOpen1();
               break;
            case 2:
               this.newModuleOpen2();
               break;
            case 3:
               this.cleanAll_1();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskIsCompleteOrCompleted(1912))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    newModuleOpen1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskIsCompleteOrCompleted(1912))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            this.actionParams = "pethallows,5722,1,2_14,0,0,14";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    newModuleOpen2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskIsCompleteOrCompleted(1912))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            this.actionParams = "childnursingspirit,5723,1,2_6,0,0,6";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceNode_80, "nodes.NoviceNode_80", []);
  return __NoviceNode_80;
}
deps["nodes.NoviceNode_80"] = ["dialog.utils.NewbieNodeBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_10"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_10 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showStartPlayView();
         }
      }
    showStartPlayView() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showStartPlayView";
            this.actionParams = "";
            this.needWaitForComplete = true;
            this.actionComplete = true;
            this.excuteAction();
         }
      }
  }
  $.meta(__NoviceTutorial_10, "nodes.NoviceTutorial_10", []);
  return __NoviceTutorial_10;
}
deps["nodes.NoviceTutorial_10"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_100"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_100 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.setTaskArrowGuild();
         }
      }
    setTaskArrowGuild() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1826))
         {
            this.skipNode();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003) && $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1826))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
            this.actionParams = "1,1106";
            this.needWaitForComplete = false;
            this.actionComplete = true;
            this.excuteAction();
         }
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_100, "nodes.NoviceTutorial_100", []);
  return __NoviceTutorial_100;
}
deps["nodes.NoviceTutorial_100"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_110"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_110 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.moveNPC();
               break;
            case 1:
               this.emptyAction();
               break;
            case 2:
               this.showMask_2();
               break;
            case 3:
               this.newModuleOpen();
               break;
            case 4:
               this.cleanAll_1();
         }
      }
    moveNPC() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(7) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003) && $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1826))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|moveNPC";
            this.actionParams = "0,-1,-1,-1,-1,0";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    emptyAction() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(7) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003) && $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1826))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|showMask";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    newModuleOpen() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
         this.actionParams = "skill,5703,1,2_4,0,0,4";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_110, "nodes.NoviceTutorial_110", []);
  return __NoviceTutorial_110;
}
deps["nodes.NoviceTutorial_110"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_120"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_120 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.emptyAction();
               break;
            case 1:
               this.doTask();
               break;
            case 2:
               this.showMask_1();
               break;
            case 3:
               this.newModuleOpen();
               break;
            case 4:
               this.cleanAll_1();
         }
      }
    emptyAction() {
         if(!$.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    doTask() {
         this.actionType = "mediators.NewbieBaseActionMediator|doTask";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(7) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003) && $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1827))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    newModuleOpen() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(7) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003) && $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1827))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            this.actionParams = "smith,5704,1,2_3,0,0,3";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_120, "nodes.NoviceTutorial_120", []);
  return __NoviceTutorial_120;
}
deps["nodes.NoviceTutorial_120"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_130"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_130 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.moveNPC();
               break;
            case 1:
               this.setMainToolBarBtn();
               break;
            case 2:
               this.cleanAll_1();
         }
      }
    moveNPC() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(10) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|moveNPC";
            this.actionParams = "0,-1,-1,-1,-1,0";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    setMainToolBarBtn() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(10) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|setMainToolBarBtn";
            this.actionParams = "1,1";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceTutorial_130, "nodes.NoviceTutorial_130", []);
  return __NoviceTutorial_130;
}
deps["nodes.NoviceTutorial_130"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_140"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_140 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.moveNPC();
               break;
            case 1:
               this.emptyAction_1();
               break;
            case 2:
               this.showMask();
               break;
            case 3:
               this.createGuildFrame1_1();
               break;
            case 4:
               this.drawTargetOnMask_1();
               break;
            case 5:
               this.cleanDrawContainer();
               break;
            case 6:
               this.cleanGuildFrame();
               break;
            case 7:
               this.emptyAction_2();
               break;
            case 8:
               this.createGuildFrame1_2();
               break;
            case 9:
               this.drawTargetOnMask_2();
               break;
            case 10:
               this.cleanAll();
         }
      }
    moveNPC() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(10) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|moveNPC";
            this.actionParams = "0,-1,-1,-1,-1,0";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    emptyAction_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkPlayerGrade(10) && $.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|showMask";
         this.actionParams = "0.5";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    createGuildFrame1_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "2_4,-550,-120,1413,1,1";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "2_4,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanDrawContainer() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    cleanGuildFrame() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    emptyAction_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame1_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "10_10,-153,-225,1414,1,2";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "10_10,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_140, "nodes.NoviceTutorial_140", []);
  return __NoviceTutorial_140;
}
deps["nodes.NoviceTutorial_140"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_150"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_150 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.emptyAction();
               break;
            case 1:
               this.doTask();
               break;
            case 2:
               this.showMask();
               break;
            case 3:
               this.moveNPC();
               break;
            case 4:
               this.enterSceneAfterPlayMovie();
               break;
            case 5:
               this.cleanAll();
         }
      }
    emptyAction() {
         if(!$.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","SkillFrame"))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    doTask() {
         this.actionType = "mediators.NewbieBaseActionMediator|doTask";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003) && $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1831))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveNPC() {
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPC";
         this.actionParams = "0,-1,-1,50,41,1";
         this.needWaitForComplete = true;
         $.C("dialog.utils.NewbieSocketOutManager").sendSaveProcess(19000);
         this.excuteAction();
      }
    enterSceneAfterPlayMovie() {
         this.actionType = "mediators.NewbieSpecialActionMediator|enterSceneAfterPlayMovie";
         this.actionParams = "leavevillage,2,103";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceTutorial_150, "nodes.NoviceTutorial_150", []);
  return __NoviceTutorial_150;
}
deps["nodes.NoviceTutorial_150"] = ["dialog.utils.NewbieSocketOutManager", "dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_160"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_160 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.enterSceneAfterPlayMovie();
               break;
            case 1:
               this.cleanAll();
         }
      }
    enterSceneAfterPlayMovie() {
         this.actionType = "mediators.NewbieSpecialActionMediator|enterSceneAfterPlayMovie";
         this.actionParams = "flytocastle,0";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.actionComplete = true;
            this.excuteAction();
         }
      }
  }
  $.meta(__NoviceTutorial_160, "nodes.NoviceTutorial_160", []);
  return __NoviceTutorial_160;
}
deps["nodes.NoviceTutorial_160"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_170"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_170 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.sendInitBuildAndQueue();
               break;
            case 1:
               this.showMask();
               break;
            case 2:
               this.taskTraceItemShine();
               break;
            case 3:
               this.setTaskArrowGuild();
               break;
            case 4:
               this.drawTargetOnMask();
               break;
            case 5:
               this.cleanAll();
               break;
            case 6:
               this.showDialog();
         }
      }
    sendInitBuildAndQueue() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(1))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|sendInitBuildAndQueue";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1832))
         {
            this.completeNode();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskIsComplete(1832) && $.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(3,"1832"))
         {
            $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    taskTraceItemShine() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1832))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|taskTraceItemShine";
         this.actionParams = "";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    setTaskArrowGuild() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1832))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
         this.actionParams = "1,1101,1832";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1832))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "31_1832,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showDialog() {
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "9";
         this.needWaitForComplete = true;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceTutorial_170, "nodes.NoviceTutorial_170", []);
  return __NoviceTutorial_170;
}
deps["nodes.NoviceTutorial_170"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator", "yishi.keyboard.KeyBoardRegister"];

defs["nodes.NoviceTutorial_180"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_180 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask_1();
               break;
            case 1:
               this.moveFocusToCastleBuild();
               break;
            case 2:
               this.drawTargetOnMask_1();
               break;
            case 3:
               this.castleBuildShine();
               break;
            case 4:
               this.createGuildFrame4();
               break;
            case 5:
               this.cleanAll_2();
               break;
            case 6:
               this.showDialog();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(1))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.5";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveFocusToCastleBuild() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCastleBuild(901))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            this.actionParams = "901";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    drawTargetOnMask_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "3_901,0";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    castleBuildShine() {
         this.actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         this.actionParams = "901";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    createGuildFrame4() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         this.actionParams = "-350,-150,toCastle_1130";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showDialog() {
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "10";
         this.needWaitForComplete = true;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceTutorial_180, "nodes.NoviceTutorial_180", []);
  return __NoviceTutorial_180;
}
deps["nodes.NoviceTutorial_180"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_190"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_190 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask_1();
               break;
            case 1:
               this.moveFocusToCastleBuild();
               break;
            case 2:
               this.drawTargetOnMask_1();
               break;
            case 3:
               this.castleBuildShine();
               break;
            case 4:
               this.createGuildFrame4();
               break;
            case 5:
               this.setKeyboardState_1();
               break;
            case 6:
               this.showMask_2();
               break;
            case 7:
               this.createGuildFrame1_1();
               break;
            case 8:
               this.drawTargetOnMask_2();
               break;
            case 9:
               this.cleanAll_1();
               break;
            case 10:
               this.showMask_3();
               break;
            case 11:
               this.createGuildFrame1_2();
               break;
            case 12:
               this.drawTargetOnMask_3();
               break;
            case 13:
               this.cleanAll_2();
               break;
            case 14:
               this.emptyAction_1();
               break;
            case 15:
               this.emptyAction_2();
               break;
            case 16:
               this.setKeyboardState_2();
               break;
            case 17:
               this.cleanGameLayer();
               break;
            case 18:
               this.cleanAll_3();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(1))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.5";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveFocusToCastleBuild() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkCastleBuild(402))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            this.actionParams = "402";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    drawTargetOnMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "3_402,0";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    castleBuildShine() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         this.actionParams = "402";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    createGuildFrame4() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         this.actionParams = "-300,-130,toCastle_1160";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    setKeyboardState_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         this.actionParams = "0,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    showMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","CasernFrame") || $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|showMask";
         this.actionParams = "0.5";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    createGuildFrame1_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","CasernFrame") || $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "29_402,-100,-190,1405,1,2";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","CasernFrame") || $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "3_402,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showMask_3() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","CasernFrame"))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.5";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame1_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "9_101,-182,-230,1406,1,2";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_3() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "9_101,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    emptyAction_1() {
         if(!$.C("mediators.NewbieBaseConditionMediator").checkFrame("buildingController","CasernFrame") || $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    emptyAction_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1834))
         {
            this.completeNode();
            return;
         }
         if(!$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(4))
         {
            if(!$.C("mediators.NewbieBaseConditionMediator").checkHavePawn(101,200))
            {
               this._step = 11;
               this.showMask_3();
               return;
            }
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    setKeyboardState_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         this.actionParams = "1,2";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanGameLayer() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanGameLayer";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    cleanAll_3() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceTutorial_190, "nodes.NoviceTutorial_190", []);
  return __NoviceTutorial_190;
}
deps["nodes.NoviceTutorial_190"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_20"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_20 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask();
               break;
            case 1:
               this.lockCampaignScene1();
               break;
            case 2:
               this.moveNPCByTween1();
               break;
            case 3:
               this.moveNPCByTween2();
               break;
            case 4:
               this.lockCampaignScene2();
               break;
            case 5:
               this.setNPC();
               break;
            case 6:
               this.showDialog();
               break;
            case 7:
               this.cleanAll();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    lockCampaignScene1() {
         this.actionType = "mediators.NewbieBaseActionMediator|lockCampaignScene";
         this.actionParams = "1";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    moveNPCByTween1() {
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         this.actionParams = "0,1600,1600,1285,1045,240,2,0,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    moveNPCByTween2() {
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         this.actionParams = "1000206,1700,1700,1350,1270,260,2,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    lockCampaignScene2() {
         this.actionType = "mediators.NewbieBaseActionMediator|lockCampaignScene";
         this.actionParams = "0";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    setNPC() {
         this.actionType = "mediators.NewbieBaseActionMediator|setNPC";
         this.actionParams = "0,-1,-1,20";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showDialog() {
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_20, "nodes.NoviceTutorial_20", []);
  return __NoviceTutorial_20;
}
deps["nodes.NoviceTutorial_20"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_200"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_200 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showDialog();
               break;
            case 1:
               this.setKeyboardState_1();
               break;
            case 2:
               this.setTaskArrowGuild();
               break;
            case 3:
               this.showMask_1();
               break;
            case 4:
               this.createGuildFrame1_1();
               break;
            case 5:
               this.drawTargetOnMask_1();
               break;
            case 6:
               this.cleanAll_1();
               break;
            case 7:
               this.showMask_2();
               break;
            case 8:
               this.createGuildFrame1_2();
               break;
            case 9:
               this.drawTargetOnMask_2();
               break;
            case 10:
               this.cleanAll_2();
               break;
            case 11:
               this.setKeyboardState_2();
               break;
            case 12:
               this.cleanGameLayer_1();
         }
      }
    showDialog() {
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "11";
         this.needWaitForComplete = true;
         $.C("dialog.utils.NewbieSocketOutManager").sendSaveProcess(25000);
         this.excuteAction();
      }
    setKeyboardState_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         this.actionParams = "0,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    setTaskArrowGuild() {
         $.C("ui.maintoolbar.MainToolBar").instance.buttonsStageByScene($.C("yishi.scene.SceneManager").instance.currentType);
         if($.C("mediators.NewbieBaseConditionMediator").checkTaskIsComplete(1834) && $.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(3,"1834"))
         {
            $.C("managers.TaskSocketManager").sendGetTaskReward(1834,0,true);
         }
         this.actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
         this.actionParams = "0";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("selectCampaignControler","SelectCampaignFrame"))
         {
            this.completeNode();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(1))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.1";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame1_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("selectCampaignControler","SelectCampaignFrame"))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "2_10,-510,-240,1411,1,1,0,-80";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("selectCampaignControler","SelectCampaignFrame"))
         {
            this.completeNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "2_10,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    showMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("selectCampaignControler","SelectCampaignFrame") && $.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(13,"startBtn"))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.1";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame1_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "28_startBtn,-160,0,1412,1,4";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "28_startBtn,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    setKeyboardState_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         this.actionParams = "1,2";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanGameLayer_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanGameLayer";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceTutorial_200, "nodes.NoviceTutorial_200", []);
  return __NoviceTutorial_200;
}
deps["nodes.NoviceTutorial_200"] = ["dialog.utils.NewbieSocketOutManager", "dialog.utils.NewbieTutorialBase", "managers.TaskSocketManager", "mediators.NewbieBaseConditionMediator", "ui.maintoolbar.MainToolBar", "yishi.scene.SceneManager"];

defs["nodes.NoviceTutorial_30"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_30 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask();
               break;
            case 1:
               this.moveNPCByTween();
               break;
            case 2:
               this.showDialog();
         }
      }
    showMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveNPCByTween() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         this.actionParams = "0,-1,-1,1320,860,260,1,1,2";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    showDialog() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.skipNode();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "2";
         this.needWaitForComplete = true;
         this.actionComplete = true;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_30, "nodes.NoviceTutorial_30", []);
  return __NoviceTutorial_30;
}
deps["nodes.NoviceTutorial_30"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_40"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_40 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask1();
               break;
            case 1:
               this.moveNPCByTween1();
               break;
            case 2:
               this.setNPC();
               break;
            case 3:
               this.sendNodeArrive();
               break;
            case 4:
               this.cleanAll1();
               break;
            case 5:
               this.showNewSkillInBattle();
               break;
            case 6:
               this.controlBattleState1();
               break;
            case 7:
               this.showMask2();
               break;
            case 8:
               this.createGuildFrame2();
               break;
            case 9:
               this.setKeyboardState();
               break;
            case 10:
               this.drawTargetOnMask();
               break;
            case 11:
               this.controlBattleState2();
               break;
            case 12:
               this.cleanAll2();
               break;
            case 13:
               this.emptyAction();
         }
      }
    showMask1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,4) && $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveNPCByTween1() {
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         this.actionParams = "1000206,1350,1270,1340,940,260,1,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    setNPC() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|setNPC";
         this.actionParams = "0,-1,-1,90";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    sendNodeArrive() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|sendNodeArrive";
         this.actionParams = "1000206";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    cleanAll1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showNewSkillInBattle() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4) && $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showNewSkillInBattle";
            this.actionParams = "1,-1";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    controlBattleState1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|controlBattleState";
            this.actionParams = "1";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showMask2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            this.actionParams = "5_0_icon,-177,-152,1501,1,2";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    setKeyboardState() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            $.C("mediators.NewbieBaseActionMediator").canEnableKeyboard = true;
            this.actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
            this.actionParams = "1";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    drawTargetOnMask() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
            this.actionParams = "5_0,1,-1,0,0,5_0_icon";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    controlBattleState2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|controlBattleState";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    cleanAll2() {
         $.C("mediators.NewbieBaseActionMediator").canEnableKeyboard = false;
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    emptyAction() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000206,8))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.actionComplete = true;
            this.excuteAction();
         }
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_40, "nodes.NoviceTutorial_40", []);
  return __NoviceTutorial_40;
}
deps["nodes.NoviceTutorial_40"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseActionMediator", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_50"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_50 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch(this._step)
         {
            case 1:
               this.showMask_1();
               break;
            case 2:
               this.setNPC();
               break;
            case 3:
               this.moveNPCByTween();
               break;
            case 4:
               this.showDialog_1();
               break;
            case 5:
               this.moveNPC();
               break;
            case 6:
               this.showDialog_2();
               break;
            case 7:
               this.sendNodeArrive();
               break;
            case 8:
               this.cleanAll_1();
               break;
            case 9:
               this.showNewSkillInBattle_1();
               break;
            case 10:
               this.controlBattleState_1();
               break;
            case 11:
               this.showMask_2();
               break;
            case 12:
               this.showDialog_3();
               break;
            case 13:
               this.createGuildTarget();
               break;
            case 14:
               this.setTargetPosAndScale();
               break;
            case 15:
               this.tweenTarget_1();
               break;
            case 16:
               this.createGuildFrame2_1();
               break;
            case 17:
               this.setTargetDisplayIndex();
               break;
            case 18:
               this.createGuildArrow();
               break;
            case 19:
               this.drawTargetOnMask_1();
               break;
            case 20:
               this.cleanDrawContainer();
               break;
            case 21:
               this.cleanGuildArrow();
               break;
            case 22:
               this.cleanGuildFrame();
               break;
            case 23:
               this.tweenTarget_2();
               break;
            case 24:
               this.cleanCreateTarget();
               break;
            case 25:
               this.showNewSkillInBattle();
               break;
            case 26:
               this.createGuildFrame2_2();
               break;
            case 27:
               this.setKeyboardState();
               break;
            case 28:
               this.drawTargetOnMask_2();
               break;
            case 29:
               this.controlBattleState_2();
               break;
            case 30:
               this.cleanAll_2();
               break;
            case 31:
               this.emptyAction();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    setNPC() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|setNPC";
         this.actionParams = "1000202,1485,1365,260";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    moveNPCByTween() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         this.actionParams = "1000202,-1,-1,1290,1120,260,1,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    showDialog_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "17";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    moveNPC() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPC";
         this.actionParams = "0,-1,-1,67,35,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    showDialog_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "4";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    sendNodeArrive() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4) || $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         this.actionType = "mediators.NewbieBaseActionMediator|sendNodeArrive";
         this.actionParams = "1000208";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    cleanAll_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showNewSkillInBattle_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4) && $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showNewSkillInBattle";
            this.actionParams = "1,-1";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    controlBattleState_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4) && $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,4) && !$.C("mediators.NewbieBaseConditionMediator").checkRolesNumInBattle(2,1))
         {
            $.C("mediators.NewbieBaseActionMediator").canEnableKeyboard = true;
            this.actionType = "mediators.NewbieBaseActionMediator|controlBattleState";
            this.actionParams = "1";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showDialog_3() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
            this.actionParams = "6";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    createGuildTarget() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|createGuildTarget";
            this.actionParams = "1_9";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    setTargetPosAndScale() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|setTargetPosAndScale";
            this.actionParams = "32,middle,middle";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    tweenTarget_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|tweenTarget";
            this.actionParams = "32,0.5,{scaleX:1.5_scaleY:1.5_yoyo:true_repeat:2},1";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    createGuildFrame2_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            this.actionParams = "32,-226,-11,1502,1";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    setTargetDisplayIndex() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|setTargetDisplayIndex";
            this.actionParams = "32,3";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildArrow() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|createGuildArrow";
            this.actionParams = "32,-38,-128,2,2001";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    drawTargetOnMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
            this.actionParams = "32,1,0";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanDrawContainer() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    cleanGuildArrow() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanGuildArrow";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    cleanGuildFrame() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    tweenTarget_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|tweenTarget";
            this.actionParams = "32,1,{x:\'reference\'_y:\'reference\'_scaleX:0.8_scaleY:0.8},0,5_1,-5,0";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanCreateTarget() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanCreateTarget";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showNewSkillInBattle() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showNewSkillInBattle";
            this.actionParams = "1,9";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame2_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            this.actionParams = "5_1_icon,-177,-153,1503,1,2";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    setKeyboardState() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
            this.actionParams = "1";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    drawTargetOnMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
            this.actionParams = "5_1,1,-1,0,0,5_1_icon";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    controlBattleState_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|controlBattleState";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    cleanAll_2() {
         $.C("mediators.NewbieBaseActionMediator").canEnableKeyboard = false;
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = $.C("com.pickgliss.toplevel.StageReferance").stage;
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(4))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    emptyAction() {
         if($.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.actionComplete = true;
            this.excuteAction();
         }
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_50, "nodes.NoviceTutorial_50", []);
  return __NoviceTutorial_50;
}
deps["nodes.NoviceTutorial_50"] = ["com.pickgliss.toplevel.StageReferance", "dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseActionMediator", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_50500"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_50500 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask_1();
               break;
            case 1:
               this.createGuildFrame2_1();
               break;
            case 2:
               this.drawTargetOnMask_2_1();
               break;
            case 3:
               this.cleanAll_1();
               break;
            case 4:
               this.showMask_2();
               break;
            case 5:
               this.createGuildFrame2_2();
               break;
            case 6:
               this.drawTargetOnMask_2_2();
               break;
            case 7:
               this.cleanAll_1();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(11) && $.C("mediators.NewbieBaseConditionMediator").checkInCastleOrSpace())
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.5";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showMask_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","ArmyFrameII") && $.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(84))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0.5";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    createGuildFrame2_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
         this.actionParams = "2_2,-177,-152,50501,1,2";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    createGuildFrame2_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
         this.actionParams = "84,-187,-152,50502,1,2";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_2_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "2_2,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    drawTargetOnMask_2_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "84,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_50500, "nodes.NoviceTutorial_50500", []);
  return __NoviceTutorial_50500;
}
deps["nodes.NoviceTutorial_50500"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_50501"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_50501 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    clearDynamic() {
      }
    next() {
         switch($.int(this._step) - -1)
         {
            case 0:
               this.cleanAll_1();
               break;
            case 2:
               this.createGuildFrame2_2();
         }
         if(!$.C("dialog.utils.NewbieManager").instance.isPlayingLockWeek)
         {
            this._step = -1;
            this.actionComplete = true;
         }
      }
    createGuildFrame2_2() {
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","ArmyFrameII") && $.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(84))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            this.actionParams = "84,-187,-152,50502,1,2";
            this.needWaitForComplete = false;
            this.excuteAction();
            this._step = Number(this._step) + 1;
         }
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    addStep() {
      }
    complete() {
         this.dispose();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_50501, "nodes.NoviceTutorial_50501", []);
  return __NoviceTutorial_50501;
}
deps["nodes.NoviceTutorial_50501"] = ["dialog.utils.NewbieManager", "dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_60"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_60 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask_1();
               break;
            case 1:
               this.showDialog_1();
               break;
            case 2:
               this.moveNPC();
               break;
            case 3:
               this.enterSceneAfterPlayMovie();
               break;
            case 4:
               this.cleanAll_1();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3) && $.C("mediators.NewbieBaseConditionMediator").checkCampaignNodeState(1000208,8))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    showDialog_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|showDialog";
         this.actionParams = "7";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    moveNPC() {
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPC";
         this.actionParams = "0,-1,-1,65,17,1";
         this.needWaitForComplete = true;
         $.C("dialog.utils.NewbieSocketOutManager").sendSaveProcess(19000);
         this.excuteAction();
      }
    enterSceneAfterPlayMovie() {
         this.actionType = "mediators.NewbieSpecialActionMediator|enterSceneAfterPlayMovie";
         this.actionParams = "leavecampaign,2,103";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_60, "nodes.NoviceTutorial_60", []);
  return __NoviceTutorial_60;
}
deps["nodes.NoviceTutorial_60"] = ["dialog.utils.NewbieSocketOutManager", "dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_70"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_70 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.setTaskArrowGuild();
         }
      }
    setTaskArrowGuild() {
         this.actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
         this.actionParams = "1,1105";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_70, "nodes.NoviceTutorial_70", []);
  return __NoviceTutorial_70;
}
deps["nodes.NoviceTutorial_70"] = ["dialog.utils.NewbieTutorialBase"];

defs["nodes.NoviceTutorial_80"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_80 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.showMask_1();
               break;
            case 1:
               this.moveNPC();
               break;
            case 2:
               this.newModuleOpen();
               break;
            case 3:
               this.createGuildFrame1();
               break;
            case 4:
               this.drawTargetOnMask_2();
               break;
            case 5:
               this.cleanDrawContainer();
               break;
            case 6:
               this.cleanGuildFrame();
               break;
            case 7:
               this.weaponEquipGuild();
               break;
            case 8:
               this.cleanAll_1();
               break;
            case 9:
               this.doTask();
         }
      }
    showMask_1() {
         if($.C("mediators.NewbieBaseConditionMediator").checkInScene(3,10003) && $.C("mediators.NewbieBaseConditionMediator").checkTaskHasCompleted(1823))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|showMask";
            this.actionParams = "0";
            this.needWaitForComplete = false;
            this.excuteAction();
         }
      }
    moveNPC() {
         this.actionType = "mediators.NewbieBaseActionMediator|moveNPC";
         this.actionParams = "0,-1,-1,-1,-1,0";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    newModuleOpen() {
         this.actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
         this.actionParams = "bag,5701,1,2_2,0,0,2";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    createGuildFrame1() {
         this.actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         this.actionParams = "2_2,-510,-130,1402,1,1";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    drawTargetOnMask_2() {
         this.actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         this.actionParams = "2_2,1";
         this.needWaitForComplete = true;
         this.excuteAction();
      }
    cleanDrawContainer() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    cleanGuildFrame() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    weaponEquipGuild() {
         if(!$.C("mediators.NewbieBaseConditionMediator").checkConditionCommon(7,"101","1","1"))
         {
            this.complete();
            return;
         }
         if($.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","ArmyFrameII"))
         {
            this.actionType = "mediators.NewbieSpecialActionMediator|weaponEquipGuild";
            this.actionParams = "";
            this.needWaitForComplete = true;
            this.excuteAction();
         }
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.excuteAction();
      }
    doTask() {
         if(!$.C("mediators.NewbieBaseConditionMediator").checkFrame("armyController","ArmyFrameII"))
         {
            this.actionType = "mediators.NewbieBaseActionMediator|doTask";
            this.actionParams = "";
            this.needWaitForComplete = false;
            this.actionComplete = true;
            this.excuteAction();
         }
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__NoviceTutorial_80, "nodes.NoviceTutorial_80", []);
  return __NoviceTutorial_80;
}
deps["nodes.NoviceTutorial_80"] = ["dialog.utils.NewbieTutorialBase", "mediators.NewbieBaseConditionMediator"];

defs["nodes.NoviceTutorial_90"] = function define($) {
  const __Base = $.C("dialog.utils.NewbieTutorialBase");
  class __NoviceTutorial_90 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    next() {
         switch($.int(this._step) - 1)
         {
            case 0:
               this.cleanAll_1();
         }
      }
    cleanAll_1() {
         this.actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         this.actionParams = "";
         this.needWaitForComplete = false;
         this.actionComplete = true;
         this.excuteAction();
      }
  }
  $.meta(__NoviceTutorial_90, "nodes.NoviceTutorial_90", []);
  return __NoviceTutorial_90;
}
deps["nodes.NoviceTutorial_90"] = ["dialog.utils.NewbieTutorialBase"];

defs["preload.BasePreLoad"] = function define($) {
  const __Base = $.Object;
  class __BasePreLoad extends __Base {
    static $fields(self) {
    self._isOver = false;
    }
    constructor() {
         super();
      }
    get preNode() {
         return -1;
      }
    get nextNode() {
         return -1;
      }
    load() {
      }
    get isOver() {
         return this._isOver;
      }
    set preNode(v) { super.preNode = v; }
    set nextNode(v) { super.nextNode = v; }
    set isOver(v) { super.isOver = v; }
  }
  $.meta(__BasePreLoad, "preload.BasePreLoad", []);
  return __BasePreLoad;
}
deps["preload.BasePreLoad"] = [];

defs["preload.NewbiePreload"] = function define($) {
  const __Base = $.Object;
  class __NewbiePreload extends __Base {
    static $fields(self) {
    self._prePath = null;
    self._tempArr = null;
    self._tempStr = null;
    }
    constructor() {
         super();
         this._prePath = $.C("com.pickgliss.loader.DisplayLoader").isDebug ? "" : $.C("yishi.manager.PathManager").resourcePath;
      }
    load(param1) {
         var _loc7_ = null;
         var _loc13_ = null;
         var _loc9_ = null;
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc11_ = null;
         var _loc12_ = 0;
         var _loc5_ = null;
         for (var _loc6_ of $.values(param1))
         {
            if(_loc6_ == "")
            {
               continue;
            }
            this._tempArr = _loc6_.split(",");
            if(!this._tempArr || this._tempArr.length <= 0)
            {
               continue;
            }
            switch($.int(this._tempArr[0]))
            {
               case 0:
                  $.C("com.pickgliss.loader.LoaderManagerII").instance.load(this._prePath + this._tempArr[1],1,1,null);
                  break;
               case 1:
                  new ($.C("preload.PreloadDefaultAvatar"))().load();
                  break;
               case 2:
                  _loc7_ = ($.as(this._tempArr[1], "String")).split("_");
                  _loc13_ = ($.as(this._tempArr[2], "String")).split("_");
                  _loc9_ = $.C("battle.BattleResPreloadManager").getPaths(_loc7_,_loc13_,$.int(this._tempArr[3]));
                  for (var _loc8_ of $.values(_loc9_))
                  {
                     $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc8_,1,1,null);
                  }
                  break;
               case 3:
                  _loc4_ = $.C("battle.BattleResPreloadManager").loadSelfSkill(false);
                  for (var _loc2_ of $.values(_loc4_))
                  {
                     $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,1,1,null);
                  }
                  break;
               case 4:
                  new ($.C("preload.PreloadBody023Avatar"))().load();
                  break;
               case 5:
                  if($.C("com.pickgliss.loader.DisplayLoader").isDebug)
                  {
                     $.C("com.pickgliss.loader.LoaderManagerII").instance.load($.C("com.pickgliss.ui.ComponentSetting").NamesLibPath,7,1,null);
                  }
                  else
                  {
                     $.C("com.pickgliss.loader.LoaderManagerII").instance.load($.C("com.pickgliss.ui.ComponentSetting").NamesLibPath,5,1,null);
                  }
                  break;
               case 6:
                  _loc3_ = new ($.C("map.campaign.preload.PreLoadFloorData"))(null).getMapFloorData({
                     "row":$.int(this._tempArr[2]),
                     "column":$.int(this._tempArr[3])
                  },$.int(this._tempArr[1]));
                  for(var _loc10_ in _loc3_)
                  {
                     $.C("com.pickgliss.loader.LoaderManagerII").instance.load($.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + _loc10_,1,1,null);
                  }
                  break;
               case 7:
                  _loc11_ = $.C("yishi.manager.PathManager").resourcePath + "equip/" + $.C("com.road.pb.helper.army.ThaneInfoHelper").getSelfJobStr() + this._tempArr[1] + $.C("yishi.manager.ArmyManager").instance.thane.templateInfo.Sexs + ".swf";
                  $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc11_,1,1,null);
                  break;
               case 8:
                  _loc12_ = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.job);
                  _loc5_ = $.C("yishi.manager.PathManager").getNewbieMovieByJob(this._tempArr[1],_loc12_);
                  $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc5_,2,1,null);
                  break;
               case 9:
                  $.C("yishi.utils.BackUpLoaderStartupUtil").addUIModule();
            }
         }
      }
    dispose() {
         this._prePath = null;
         if(this._tempArr)
         {
            this._tempArr.length = 0;
         }
         this._tempArr = null;
         this._tempStr = null;
      }
  }
  $.meta(__NewbiePreload, "preload.NewbiePreload", []);
  return __NewbiePreload;
}
deps["preload.NewbiePreload"] = ["battle.BattleResPreloadManager", "com.pickgliss.loader.DisplayLoader", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentSetting", "com.road.pb.helper.army.ThaneInfoHelper", "map.campaign.preload.PreLoadFloorData", "preload.PreloadBody023Avatar", "preload.PreloadDefaultAvatar", "yishi.manager.ArmyManager", "yishi.manager.PathManager", "yishi.manager.PlayerManager", "yishi.utils.BackUpLoaderStartupUtil"];

defs["preload.PreLoad150_OpenBag"] = function define($) {
  const __Base = $.C("preload.BasePreLoad");
  class __PreLoad150_OpenBag extends __Base {
    static $fields(self) {
    self._defaultDic = null;
    self._count = 0;
    }
    constructor() {
         super();
         this._defaultDic = new ($.C("flash.utils.Dictionary"))();
         this._defaultDic[2] = "equip_show/hunter_default";
         this._defaultDic[3] = "equip_show/wizard_default";
         this._defaultDic[1] = "equip_show/warrior_default";
      }
    load() {
         var _loc1_ = null;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + this._defaultDic[this.thane.templateInfo.Job] + "_hair/front/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + this._defaultDic[this.thane.templateInfo.Job] + "_body_cloak/front/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + this._defaultDic[this.thane.templateInfo.Job] + "_body/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + this._defaultDic[this.thane.templateInfo.Job] + "_arms/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + this._defaultDic[this.thane.templateInfo.Job] + "_hair/back/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + this._defaultDic[this.thane.templateInfo.Job] + "_body_cloak/back/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         var _loc2_ = $.int("101" + this.thane.templateInfo.Job + "002");
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc2_).Avata;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip_show" + _loc3_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/avatar" + _loc3_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         this._count = this._count + 1;
         _loc1_ = $.C("yishi.manager.PathManager").solveHeroAvatarPath(_loc3_,this.thane.templateInfo.Sexs);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    onLoadComplete(param1, param2) {
         this._count = this._count - 1;
         if(this._count == 0)
         {
            this._isOver = true;
         }
      }
    set thane(v) { super.thane = v; }
  }
  $.meta(__PreLoad150_OpenBag, "preload.PreLoad150_OpenBag", []);
  return __PreLoad150_OpenBag;
}
deps["preload.PreLoad150_OpenBag"] = ["com.pickgliss.loader.LoaderManagerII", "flash.utils.Dictionary", "preload.BasePreLoad", "yishi.manager.ArmyManager", "yishi.manager.PathManager", "yishi.manager.TempleteManager"];

defs["preload.PreLoad170_EquiAndBust"] = function define($) {
  const __Base = $.C("preload.BasePreLoad");
  class __PreLoad170_EquiAndBust extends __Base {
    static $fields(self) {
    self.fun = null;
    self._url = null;
    }
    constructor() {
         super();
      }
    load() {
         var _loc2_ = $.int("104" + this.thane.templateInfo.Job + "002");
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc2_).Avata;
         var _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip_show" + _loc4_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip_show" + _loc4_ + "_cloak/back/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,null);
         var _loc3_ = new ($.C("com.road.mapengine.bitmap.load.ResourceLoaderInfo"))();
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/avatar" + _loc4_ + "/" + this.thane.templateInfo.Sexs + ".bswf";
         _loc3_.url = _loc1_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,4,7,$.bind(this, "__loaderCompleteHandler"),null,null,_loc3_);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/avatar" + _loc4_ + "_cloak/" + this.thane.templateInfo.Sexs + ".bswf";
         _loc3_.url = _loc1_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,4,7,$.bind(this, "__loaderCompleteHandler"),null,null,_loc3_);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip" + _loc4_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip" + _loc4_ + "_cloak/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").solveHeadPath(14);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,2,7,$.bind(this, "onLoadComplete"));
         _loc1_ = $.C("yishi.manager.PathManager").solveHeroAvatarPath(_loc4_,this.thane.templateInfo.Sexs);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,$.bind(this, "onLoadComplete"));
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    onLoadComplete(param1) {
         var _loc3_ = $.int("104" + this.thane.templateInfo.Job + "002");
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc3_).Avata;
         var _loc4_ = $.int($.C("yishi.manager.ArmyManager").instance.thane.templateInfo.Sexs);
         this.loadResourceByKey(_loc2_,_loc4_,$.bind(this, "loadComplete"));
      }
    loadComplete(param1 = "", param2 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._isOver = true;
      }
    loadResourceByKey(param1, param2, param3) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._url = this.getResourcepath(param1,param2);
         var _loc4_ = new ($.C("com.road.mapengine.bitmap.load.ResourceLoaderInfo"))();
         _loc4_.url = this._url;
         _loc4_.call = param3;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(this._url,4,7,$.bind(this, "__loaderCompleteHandler"),null,null,_loc4_);
      }
    __loaderCompleteHandler(param1, param2) {
         var _loc3_ = null;
         if(param1.args)
         {
            _loc3_ = param1.args.call;
            if(_loc3_ != null)
            {
               _loc3_();
            }
            _loc3_ = null;
         }
      }
    getResourcepath(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return $.C("yishi.manager.PathManager").avatarResourcePath(param1,param2);
      }
    set thane(v) { super.thane = v; }
  }
  $.meta(__PreLoad170_EquiAndBust, "preload.PreLoad170_EquiAndBust", []);
  return __PreLoad170_EquiAndBust;
}
deps["preload.PreLoad170_EquiAndBust"] = ["com.pickgliss.loader.LoaderManagerII", "com.road.mapengine.bitmap.load.ResourceLoaderInfo", "preload.BasePreLoad", "yishi.manager.ArmyManager", "yishi.manager.PathManager", "yishi.manager.TempleteManager"];

defs["preload.PreloadBody023Avatar"] = function define($) {
  const __Base = $.Object;
  class __PreloadBody023Avatar extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    load() {
         var _loc3_ = $.int("104" + this.thane.templateInfo.Job + "002");
         var _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc3_).Avata;
         var _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip_show" + _loc6_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip_show" + _loc6_ + "_cloak/back/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         var _loc4_ = new ($.C("com.road.mapengine.bitmap.load.ResourceLoaderInfo"))();
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/avatar" + _loc6_ + "/" + this.thane.templateInfo.Sexs + ".bswf";
         _loc4_.url = _loc1_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null,null,null,_loc4_);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/avatar" + _loc6_ + "_cloak/" + this.thane.templateInfo.Sexs + ".bswf";
         _loc4_.url = _loc1_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null,null,null,_loc4_);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip" + _loc6_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip" + _loc6_ + "_cloak/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").solveHeadPath(14);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").solveHeroAvatarPath(_loc6_,this.thane.templateInfo.Sexs);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         _loc3_ = $.int("104" + this.thane.templateInfo.Job + "002");
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc3_).Avata;
         var _loc5_ = $.int($.C("yishi.manager.ArmyManager").instance.thane.templateInfo.Sexs);
         _loc1_ = $.C("yishi.manager.PathManager").avatarResourcePath(_loc2_,_loc5_);
         _loc4_.url = _loc1_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null,null,null,_loc4_);
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    set thane(v) { super.thane = v; }
  }
  $.meta(__PreloadBody023Avatar, "preload.PreloadBody023Avatar", []);
  return __PreloadBody023Avatar;
}
deps["preload.PreloadBody023Avatar"] = ["com.pickgliss.loader.LoaderManagerII", "com.road.mapengine.bitmap.load.ResourceLoaderInfo", "yishi.manager.ArmyManager", "yishi.manager.PathManager", "yishi.manager.TempleteManager"];

defs["preload.PreloadDefaultAvatar"] = function define($) {
  const __Base = $.Object;
  class __PreloadDefaultAvatar extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    load() {
         var _loc1_ = null;
         var _loc4_ = new ($.C("flash.utils.Dictionary"))();
         _loc4_[2] = "equip_show/hunter_default";
         _loc4_[3] = "equip_show/wizard_default";
         _loc4_[1] = "equip_show/warrior_default";
         var _loc2_ = $.int("101" + this.thane.templateInfo.Job + "003");
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc2_).Avata;
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "equip_show" + _loc3_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").resourcePath + "swf/avatar" + _loc3_ + "/" + this.thane.templateInfo.Sexs + ".swf";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
         _loc1_ = $.C("yishi.manager.PathManager").solveHeroAvatarPath(_loc3_,this.thane.templateInfo.Sexs);
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,1,7,null);
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    set thane(v) { super.thane = v; }
  }
  $.meta(__PreloadDefaultAvatar, "preload.PreloadDefaultAvatar", []);
  return __PreloadDefaultAvatar;
}
deps["preload.PreloadDefaultAvatar"] = ["com.pickgliss.loader.LoaderManagerII", "flash.utils.Dictionary", "yishi.manager.ArmyManager", "yishi.manager.PathManager", "yishi.manager.TempleteManager"];

defs["utils.DisObjResizeUtils"] = function define($) {
  const __Base = $.Object;
  class __DisObjResizeUtils extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static addTarget(param1, param2, param3 = null, param4 = true) {
         if(__DisObjResizeUtils.getListLen(__DisObjResizeUtils._autoRemoveList) == 0 && __DisObjResizeUtils.getListLen(__DisObjResizeUtils._manualRemoveList) == 0)
         {
            if(!__DisObjResizeUtils._timer)
            {
               __DisObjResizeUtils._timer = new ($.C("flash.utils.Timer"))(200);
            }
            __DisObjResizeUtils._timer.addEventListener("timer",__DisObjResizeUtils.__timerUpdateHandler);
            __DisObjResizeUtils._timer.start();
         }
         if(!__DisObjResizeUtils._autoRemoveList)
         {
            __DisObjResizeUtils._autoRemoveList = new ($.C("flash.utils.Dictionary"))();
         }
         if(!__DisObjResizeUtils._manualRemoveList)
         {
            __DisObjResizeUtils._manualRemoveList = new ($.C("flash.utils.Dictionary"))();
         }
         if(!__DisObjResizeUtils._offsetList)
         {
            __DisObjResizeUtils._offsetList = new ($.C("flash.utils.Dictionary"))();
         }
         if(param4)
         {
            __DisObjResizeUtils._autoRemoveList[param1] = param2;
         }
         else
         {
            __DisObjResizeUtils._manualRemoveList[param1] = param2;
         }
         if(param3)
         {
            __DisObjResizeUtils._offsetList[param1] = param3;
         }
         else
         {
            __DisObjResizeUtils._offsetList[param1] = null;
            delete __DisObjResizeUtils._offsetList[param1];
         }
         __DisObjResizeUtils.__timerUpdateHandler(null);
      }
    static removeTarget(param1) {
         if(__DisObjResizeUtils._autoRemoveList)
         {
            __DisObjResizeUtils._autoRemoveList[param1] = null;
            delete __DisObjResizeUtils._autoRemoveList[param1];
         }
         if(__DisObjResizeUtils._manualRemoveList)
         {
            __DisObjResizeUtils._manualRemoveList[param1] = null;
            delete __DisObjResizeUtils._manualRemoveList[param1];
         }
         if(__DisObjResizeUtils._offsetList)
         {
            __DisObjResizeUtils._offsetList[param1] = null;
            delete __DisObjResizeUtils._offsetList[param1];
         }
      }
    static clear() {
         if(__DisObjResizeUtils._timer)
         {
            __DisObjResizeUtils._timer.removeEventListener("timer",__DisObjResizeUtils.__timerUpdateHandler);
            __DisObjResizeUtils._timer.stop();
            __DisObjResizeUtils._timer = null;
         }
         __DisObjResizeUtils._autoRemoveList = null;
         __DisObjResizeUtils._manualRemoveList = null;
         __DisObjResizeUtils._offsetList = null;
         __DisObjResizeUtils._tempDisObj01 = null;
         __DisObjResizeUtils._tempDisObj02 = null;
         __DisObjResizeUtils._tempP = null;
         __DisObjResizeUtils._tempOffsetPoint = null;
      }
    static __timerUpdateHandler(param1) {
         var _loc2_ = 0;
         if(!__DisObjResizeUtils._tempP)
         {
            __DisObjResizeUtils._tempP = new ($.C("flash.geom.Point"))();
         }
         for(__DisObjResizeUtils._tempDisObj01 in __DisObjResizeUtils._autoRemoveList)
         {
            _loc2_++;
            __DisObjResizeUtils._tempDisObj02 = __DisObjResizeUtils._autoRemoveList[__DisObjResizeUtils._tempDisObj01];
            if(__DisObjResizeUtils._tempDisObj01 && __DisObjResizeUtils._tempDisObj01.stage && __DisObjResizeUtils._tempDisObj02 && __DisObjResizeUtils._tempDisObj02.stage)
            {
               __DisObjResizeUtils._tempP.x = __DisObjResizeUtils._tempDisObj02.x;
               __DisObjResizeUtils._tempP.y = __DisObjResizeUtils._tempDisObj02.y;
               __DisObjResizeUtils._tempP = __DisObjResizeUtils._tempDisObj02.parent.localToGlobal(__DisObjResizeUtils._tempP);
               __DisObjResizeUtils._tempP = __DisObjResizeUtils._tempDisObj01.parent.globalToLocal(__DisObjResizeUtils._tempP);
               __DisObjResizeUtils._tempOffsetPoint = __DisObjResizeUtils._offsetList[__DisObjResizeUtils._tempDisObj01];
               if(__DisObjResizeUtils._tempOffsetPoint)
               {
                  __DisObjResizeUtils._tempDisObj01.x = __DisObjResizeUtils._tempP.x + __DisObjResizeUtils._tempOffsetPoint.x;
                  __DisObjResizeUtils._tempDisObj01.y = __DisObjResizeUtils._tempP.y + __DisObjResizeUtils._tempOffsetPoint.y;
               }
               else
               {
                  __DisObjResizeUtils._tempDisObj01.x = __DisObjResizeUtils._tempP.x;
                  __DisObjResizeUtils._tempDisObj01.y = __DisObjResizeUtils._tempP.y;
               }
            }
            else
            {
               __DisObjResizeUtils._autoRemoveList[__DisObjResizeUtils._tempDisObj01] = null;
               delete __DisObjResizeUtils._autoRemoveList[__DisObjResizeUtils._tempDisObj01];
               __DisObjResizeUtils._offsetList[__DisObjResizeUtils._tempDisObj01] = null;
               delete __DisObjResizeUtils._offsetList[__DisObjResizeUtils._tempDisObj01];
            }
         }
         for(__DisObjResizeUtils._tempDisObj01 in __DisObjResizeUtils._manualRemoveList)
         {
            _loc2_++;
            __DisObjResizeUtils._tempDisObj02 = __DisObjResizeUtils._manualRemoveList[__DisObjResizeUtils._tempDisObj01];
            if(__DisObjResizeUtils._tempDisObj01 && __DisObjResizeUtils._tempDisObj01.stage && __DisObjResizeUtils._tempDisObj02 && __DisObjResizeUtils._tempDisObj02.stage)
            {
               __DisObjResizeUtils._tempP.x = __DisObjResizeUtils._tempDisObj02.x;
               __DisObjResizeUtils._tempP.y = __DisObjResizeUtils._tempDisObj02.y;
               __DisObjResizeUtils._tempP = __DisObjResizeUtils._tempDisObj02.parent.localToGlobal(__DisObjResizeUtils._tempP);
               __DisObjResizeUtils._tempP = __DisObjResizeUtils._tempDisObj01.parent.globalToLocal(__DisObjResizeUtils._tempP);
               __DisObjResizeUtils._tempOffsetPoint = __DisObjResizeUtils._offsetList[__DisObjResizeUtils._tempDisObj01];
               if(__DisObjResizeUtils._tempOffsetPoint)
               {
                  __DisObjResizeUtils._tempDisObj01.x = __DisObjResizeUtils._tempP.x + __DisObjResizeUtils._tempOffsetPoint.x;
                  __DisObjResizeUtils._tempDisObj01.y = __DisObjResizeUtils._tempP.y + __DisObjResizeUtils._tempOffsetPoint.y;
               }
               else
               {
                  __DisObjResizeUtils._tempDisObj01.x = __DisObjResizeUtils._tempP.x;
                  __DisObjResizeUtils._tempDisObj01.y = __DisObjResizeUtils._tempP.y;
               }
            }
         }
         if(_loc2_ == 0)
         {
            __DisObjResizeUtils.clear();
         }
      }
    static getListLen(param1) {
         var _loc3_ = 0;
         for(var _loc2_ in param1)
         {
            _loc3_++;
         }
         return _loc3_;
      }
  }
  $.meta(__DisObjResizeUtils, "utils.DisObjResizeUtils", []);
  $.statics(__DisObjResizeUtils, () => {
    __DisObjResizeUtils.INTERVAL_TIME = 200;
    __DisObjResizeUtils._timer = null;
    __DisObjResizeUtils._autoRemoveList = null;
    __DisObjResizeUtils._manualRemoveList = null;
    __DisObjResizeUtils._offsetList = null;
    __DisObjResizeUtils._tempDisObj01 = null;
    __DisObjResizeUtils._tempDisObj02 = null;
    __DisObjResizeUtils._tempP = null;
    __DisObjResizeUtils._tempOffsetPoint = null;
  });
  return __DisObjResizeUtils;
}
deps["utils.DisObjResizeUtils"] = ["flash.geom.Point", "flash.utils.Dictionary", "flash.utils.Timer"];

defs["utils.NewbieUtils"] = function define($) {
  const __Base = $.Object;
  class __NewbieUtils extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static execFunc(param1, param2 = null, param3 = null, param4 = null) {
         var _loc6_ = false;
         var _loc5_ = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc7_ = param3 != null;
         if(param2)
         {
            switch(_loc5_ = $.int(param2.length))
            {
               case 0:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4)) : Boolean(param1());
                  break;
               case 1:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0])) : Boolean(param1(param2[0]));
                  break;
               case 2:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1])) : Boolean(param1(param2[0],param2[1]));
                  break;
               case 3:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2])) : Boolean(param1(param2[0],param2[1],param2[2]));
                  break;
               case 4:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3]));
                  break;
               case 5:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4]));
                  break;
               case 6:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]));
                  break;
               case 7:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]));
                  break;
               case 8:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]));
                  break;
               case 9:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]));
                  break;
               case 10:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]));
                  break;
               default:
                  throw new Error("目前限制{invalid_utf8=230}{invalid_utf8=156}?多支{invalid_utf8=230}{invalid_utf8=140}?10个参数，可增{invalid_utf8=229}{invalid_utf8=138}?");
            }
         }
         else
         {
            _loc6_ = _loc7_ ? Boolean(param1(param3,param4)) : Boolean(param1());
         }
         return _loc6_;
      }
    static execFuncSimple(param1, param2 = null) {
         var _loc3_ = 0;
         if(param1 == null)
         {
            return null;
         }
         if(!param2)
         {
            return param1();
         }
         _loc3_ = $.int(param2.length);
         switch(_loc3_)
         {
            case 0:
               return param1();
            case 1:
               return param1(param2[0]);
            case 2:
               return param1(param2[0],param2[1]);
            case 3:
               return param1(param2[0],param2[1],param2[2]);
            case 4:
               return param1(param2[0],param2[1],param2[2],param2[3]);
            case 5:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
            case 6:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
            case 7:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
            case 8:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
            case 9:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
            case 10:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
            default:
               throw new Error("目前限制{invalid_utf8=230}{invalid_utf8=156}?多支{invalid_utf8=230}{invalid_utf8=140}?10个参数，可增{invalid_utf8=229}{invalid_utf8=138}?");
         }
      }
    static stringToObject(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc6_ = null;
         var _loc8_ = null;
         var _loc7_ = null;
         var _loc4_ = {};
         var _loc2_ = param1.slice(1,param1.length - 1);
         var _loc3_ = _loc2_.split("_");
         for (var _loc5_ of $.values(_loc3_))
         {
            _loc6_ = _loc5_.split(":");
            _loc8_ = _loc6_[0];
            _loc7_ = _loc6_[1];
            if(_loc7_ == "true")
            {
               _loc4_[_loc8_] = true;
            }
            else if(_loc7_ == "false")
            {
               _loc4_[_loc8_] = false;
            }
            else if(_loc7_.indexOf("\'") == -1)
            {
               _loc4_[_loc8_] = Number(_loc7_);
            }
            else
            {
               _loc4_[_loc8_] = _loc7_;
            }
         }
         return _loc4_;
      }
  }
  $.meta(__NewbieUtils, "utils.NewbieUtils", []);
  return __NewbieUtils;
}
deps["utils.NewbieUtils"] = [];

defs["views.GameStartPlayView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __GameStartPlayView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._startBtn = null;
    self._callback = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    set callback(param1) {
         this._callback = param1;
      }
    initView() {
         if($.C("com.pickgliss.ui.ComponentSetting").isZhanQu)
         {
            this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.StartPlayBg3");
         }
         else if($.C("com.pickgliss.ui.ComponentSetting").is7road)
         {
            this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.StartPlayBg1");
         }
         else
         {
            this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.StartPlayBg2");
         }
         this._startBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.StartPlayStartBtn");
         this.addChild(this._bg);
         this.addChild(this._startBtn);
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "__onStartPlayClick"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__onStartPlayClick"));
      }
    __onStartPlayClick(param1) {
         this.dispose();
      }
    show() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,0,true,true,1);
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._startBtn);
         this._startBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this._callback != null)
         {
            this._callback();
         }
         this._callback = null;
      }
    get callback() { return super.callback; }
  }
  $.meta(__GameStartPlayView, "views.GameStartPlayView", ["Disposeable"]);
  return __GameStartPlayView;
}
deps["views.GameStartPlayView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.keyboard.KeyBoardRegister"];

defs["views.NewModuleOpenPopView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __NewModuleOpenPopView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._icon = null;
    self._openBtn = null;
    self._callback = null;
    self._callArgs = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.NewOpenMultiBg");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("novice.NewOpenIcon");
         this._openBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.NewOpenBtn");
         this.addChild(this._bg);
         this.addChild(this._icon);
         this.addChild(this._openBtn);
      }
    addEvent() {
         this.addEventListener("click",$.bind(this, "__onOpenClick"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "__onOpenClick"));
      }
    __onOpenClick(param1) {
         this._openBtn.mouseEnabled = false;
         if(this._callback != null)
         {
            this._callback.apply(null,this._callArgs);
         }
         this._callback = null;
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,0,true,true);
      }
    set icon(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._icon.icon = $.C("yishi.utils.IconFactory").getModuleIcon(param1);
      }
    set btnText(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._openBtn.text = param1;
      }
    set callback(param1) {
         this._callback = param1;
      }
    set callArgs(param1) {
         this._callArgs = param1;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         this._icon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._openBtn);
         this._openBtn = null;
         this._callback = null;
         this._callArgs = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get icon() { return super.icon; }
    get btnText() { return super.btnText; }
    get callback() { return super.callback; }
    get callArgs() { return super.callArgs; }
  }
  $.meta(__NewModuleOpenPopView, "views.NewModuleOpenPopView", []);
  return __NewModuleOpenPopView;
}
deps["views.NewModuleOpenPopView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "yishi.utils.IconFactory"];

defs["views.NoviceFameCampaign"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __NoviceFameCampaign extends __Base {
    static $fields(self) {
    self._bg = null;
    self._arrow = null;
    self._contentText = null;
    self._callback = null;
    self._continueBtn = null;
    self._container = null;
    self._fixedW = NaN;
    self._fixedH = NaN;
    self._appointTxtPt = null;
    self._disEffect = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.mouseChildren = this.mouseEnabled = false;
         this._container = new ($.C("flash.display.Sprite"))();
         this.addChild(this._container);
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.FrameBack01");
         this._container.addChild(this._bg);
         this._arrow = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("novice.GuildFrameArrow");
         this._container.addChild(this._arrow);
         this._contentText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.novice.ContentText3");
         this._container.addChild(this._contentText);
         this._continueBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.novice.ContinueBtnMc");
         this._continueBtn.visible = false;
         this._container.addChild(this._continueBtn);
         this._fixedW = this._container.width;
         this._fixedH = this._bg.displayHeight;
         this.initState();
      }
    initState() {
         var _loc1_ = 0.1;
         this._bg.scaleX = this._bg.scaleY = _loc1_;
         this._bg.alpha = 0;
         this._contentText.alpha = 0;
         this._continueBtn.alpha = 0;
      }
    setText(param1, param2 = 0) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._contentText.text = "      " + param1;
         this._bg.height = $.int(this._contentText.textHeight) + 60;
         if(param2 <= 0)
         {
            this._arrow.visible = false;
            this._arrow.stop();
         }
         else
         {
            this._arrow.visible = true;
            this._arrow.play();
         }
         switch(param2 - 2)
         {
            case 0:
               this._arrow.x = this._bg.x + (this._bg.width + this._arrow.width) / 2;
               this._arrow.y = this._bg.y + this._bg.height + this._arrow.height - 4;
               break;
            case 2:
               this._arrow.scaleY = -1;
               this._arrow.x = this._bg.x + (this._bg.width + this._arrow.width) / 2;
               this._arrow.y = this._bg.y - this._arrow.height + 4;
               break;
            default:
               this._arrow.rotation = -90;
               this._arrow.x = this._bg.x + this._bg.width + 57;
               this._arrow.y = this._bg.y + (this._bg.height - this._arrow.height) / 2;
         }
      }
    btnEffect(param1) {
         this._disEffect = new ($.C("mainBar.effects.MainToolBtnGlowEffect"))(param1);
         this._disEffect.play();
      }
    set continueBoo(param1) {
         if(param1)
         {
            this._continueBtn.visible = true;
            this._continueBtn.x = this._bg.width - 130;
            this._continueBtn.y = this._bg.height - 45;
            $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("click",$.bind(this, "__onStageClick"));
         }
      }
    setTextFormat(param1 = "left", param2 = 10) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = new ($.C("flash.text.TextFormat"))();
         _loc3_.align = param1;
         _loc3_.leading = param2;
         this._contentText.setTextFormat(_loc3_);
      }
    removeEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("click",$.bind(this, "__onStageClick"));
      }
    set callback(param1) {
         this._callback = param1;
      }
    showTween(... rest) {
         if(rest.length > 0)
         {
            this.showObjs(rest[0]);
         }
         else
         {
            this.showObjs(0.3);
         }
      }
    showObjs(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         $.C("com.greensock.TweenMax").to(this._bg,param1,{
            "x":0,
            "y":0,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         $.C("com.greensock.TweenMax").to(this._contentText,param1,{
            "alpha":1,
            "delay":0.3
         });
         $.C("com.greensock.TweenMax").to(this._continueBtn,param1,{
            "alpha":1,
            "delay":0.3
         });
      }
    __onStageClick(param1) {
         if(this._callback != null)
         {
            this._callback();
            this._callback = null;
         }
      }
    dispose() {
         this.removeEvent();
         if(this._disEffect)
         {
            this._disEffect.dispose();
         }
         this._disEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._container);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._arrow);
         this._arrow = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentText);
         this._contentText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._continueBtn);
         this._continueBtn = null;
         this._callback = null;
         this._container = null;
      }
    get continueBoo() { return super.continueBoo; }
    get callback() { return super.callback; }
  }
  $.meta(__NoviceFameCampaign, "views.NoviceFameCampaign", []);
  return __NoviceFameCampaign;
}
deps["views.NoviceFameCampaign"] = ["com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.text.TextFormat", "mainBar.effects.MainToolBtnGlowEffect"];

defs["views.NoviceFogView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __NoviceFogView extends __Base {
    static $fields(self) {
    self._bitWidth = 0;
    self._bitHeight = 0;
    self._mapWidth = 0;
    self._mapHeight = 0;
    self._maskContainer = null;
    self._maskDict = new ($.C("flash.utils.Dictionary"))(true);
    self._maskBitmapData = null;
    self._bitmapContainer = null;
    self._displayRect = new ($.C("flash.geom.Rectangle"))();
    self._prePoint = new ($.C("flash.geom.Point"))();
    self._curPoint = new ($.C("flash.geom.Point"))();
    }
    constructor(param1, param2) {
         super();
         this.initBitmapContainer();
         this._maskBitmapData = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.campaign.FogMaskAsset");
         this.initMask(param1,param2);
         this.addEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__resizeHandler"));
         this.scrollRect = null;
      }
    __resizeHandler(param1) {
         this.upDateNextRend();
      }
    __addToStageHandler(param1) {
         this.upDateNextRend();
      }
    initBitmapContainer() {
         var _loc1_ = $.int($.C("map.outercity.manager.OuterCityManager").instance.mapView.width);
         var _loc2_ = $.int($.C("map.outercity.manager.OuterCityManager").instance.mapView.height);
         if(_loc1_ <= 0 || _loc2_ <= 0)
         {
            return;
         }
         this._bitmapContainer = new ($.C("flash.display.Bitmap"))(new ($.C("flash.display.BitmapData"))(_loc1_,_loc2_,true,0));
         this.addChild(this._bitmapContainer);
         this._bitmapContainer.scrollRect = null;
         this._bitmapContainer.filters = null;
         this.upDateNextRend();
      }
    upDateNextRend() {
         if(this.parent)
         {
            this.draw();
         }
      }
    draw() {
         var _loc6_ = 0;
         var _loc8_ = -$.C("map.outercity.manager.OuterCityManager").instance.mapView.x;
         var _loc10_ = -$.C("map.outercity.manager.OuterCityManager").instance.mapView.y;
         var _loc4_ = $.int($.C("map.outercity.manager.OuterCityManager").instance.model.mapTempInfo.Width);
         var _loc5_ = $.int($.C("map.outercity.manager.OuterCityManager").instance.model.mapTempInfo.Height);
         this._displayRect.x = _loc8_ - 110;
         this._displayRect.y = _loc10_ - 110;
         this._displayRect.width = _loc4_ + 110;
         this._displayRect.height = _loc5_ + 110;
         this._bitmapContainer.bitmapData.lock();
         this._bitmapContainer.bitmapData.fillRect(this._displayRect,0);
         this._displayRect.x = this._displayRect.y = 0;
         this._displayRect.width = this._maskBitmapData.width;
         this._displayRect.height = this._maskBitmapData.height;
         var _loc9_ = _loc8_ - this._displayRect.width;
         var _loc7_ = _loc10_ - this._displayRect.height;
         var _loc3_ = _loc8_ + $.C("com.pickgliss.toplevel.StageReferance").stageWidth + 110;
         var _loc2_ = _loc10_ + $.C("com.pickgliss.toplevel.StageReferance").stageHeight + 110;
         for (var _loc1_ of $.values(this._maskDict))
         {
            if(!(_loc1_.x < _loc9_ || _loc1_.y < _loc7_ || _loc1_.x > _loc3_ || _loc1_.y > _loc2_))
            {
               _loc6_++;
               this._bitmapContainer.bitmapData.copyPixels(this._maskBitmapData,this._displayRect,_loc1_,null,null,true);
            }
         }
         this._bitmapContainer.bitmapData.unlock();
      }
    initMask(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc3_ = null;
         _loc5_ = -110;
         while(_loc5_ < param1 + 110)
         {
            _loc4_ = 0;
            _loc6_ = -86;
            while(_loc6_ < param2 + 86)
            {
               _loc4_++;
               _loc3_ = new ($.C("flash.geom.Point"))();
               this._maskDict[_loc5_ + "_" + _loc6_] = _loc3_;
               if(_loc4_ % 2 == 0)
               {
                  _loc3_.x = _loc5_;
               }
               else
               {
                  _loc3_.x = _loc5_ + 110 / 2;
               }
               _loc3_.y = _loc6_;
               _loc3_.x -= this._maskBitmapData.width / 2;
               _loc3_.y -= this._maskBitmapData.height / 2;
               _loc6_ += 86;
            }
            _loc5_ += 110;
         }
         this.upDateNextRend();
      }
    updatePos(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = null;
         _loc4_ = new ($.C("flash.geom.Point"))(param1 + 55,param2 + 43);
         var _loc7_ = _loc4_.y % 86;
         var _loc5_ = (_loc4_.y - _loc7_) / 86 % 2;
         if(_loc5_ != 0)
         {
            _loc4_.x -= 110 / 2;
         }
         _loc4_.y -= _loc7_;
         var _loc6_ = _loc4_.x % 110;
         _loc4_.x -= _loc6_;
         this.updatePosImp(_loc4_,_loc5_,param3);
         this.upDateNextRend();
      }
    updatePosImp(param1, param2, param3) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y));
         if(param3 >= 2)
         {
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 2,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 2,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y - 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y - 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y - 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y + 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y + 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y + 86 * 2));
         }
         if(param3 >= 3)
         {
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 3,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 3,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y - 86 * 3));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y - 86 * 3));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y - 86 * 3));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y - 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y - 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y + 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y + 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y + 86 * 3));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y + 86 * 3));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y + 86 * 3));
         }
         if(param3 >= 4)
         {
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 4,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 4,param1.y));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y - 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y + 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y - 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y + 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y - 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y + 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 2,param1.y - 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 2,param1.y + 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 2,param1.y - 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 2,param1.y + 86 * 4));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 3,param1.y - 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 3,param1.y + 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 3,param1.y - 86 * 2));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 3,param1.y + 86 * 2));
         }
         if(param2 == 0)
         {
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y - 86));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y - 86));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y + 86));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y + 86));
            if(param3 >= 2)
            {
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 2,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110 * 2,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y + 86));
            }
            if(param3 >= 3)
            {
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y - 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 3 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 3 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y + 86 * 3));
            }
            if(param3 >= 4)
            {
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 4 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 4 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 3 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 3 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 3 * 110,param1.y - 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 3 * 110,param1.y + 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y - 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y + 86 * 3));
            }
         }
         else
         {
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y - 86));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y - 86));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x,param1.y + 86));
            this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110,param1.y + 86));
            if(param3 >= 2)
            {
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 2,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 110 * 2,param1.y + 86));
            }
            if(param3 >= 3)
            {
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y - 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 3 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 3 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 2 * 110,param1.y + 86 * 3));
            }
            if(param3 >= 4)
            {
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 3 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 3 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 4 * 110,param1.y - 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 4 * 110,param1.y + 86));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y - 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x - 2 * 110,param1.y + 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 3 * 110,param1.y - 86 * 3));
               this.removeByKey(new ($.C("flash.geom.Point"))(param1.x + 3 * 110,param1.y + 86 * 3));
            }
         }
      }
    removeByKey(param1) {
         var _loc2_ = param1.x + "_" + param1.y;
         var _loc3_ = $.as(this._maskDict[_loc2_], $.C("flash.geom.Point"));
         delete this._maskDict[_loc2_];
      }
    removeEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__resizeHandler"));
         this.removeEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
      }
    dispose() {
         this.removeEvent();
         if(this._maskBitmapData)
         {
            this._maskBitmapData.dispose();
         }
         this._maskBitmapData = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__NoviceFogView, "views.NoviceFogView", []);
  $.statics(__NoviceFogView, () => {
    __NoviceFogView.unitWidth = 110;
    __NoviceFogView.unitHeight = 86;
    __NoviceFogView.off = 110;
  });
  return __NoviceFogView;
}
deps["views.NoviceFogView"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "flash.display.Bitmap", "flash.display.BitmapData", "flash.display.Sprite", "flash.geom.Point", "flash.geom.Rectangle", "flash.utils.Dictionary", "map.outercity.manager.OuterCityManager"];

defs["views.NoviceFrame1"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __NoviceFrame1 extends __Base {
    static $fields(self) {
    self._headIcon = null;
    self._bg = null;
    self._arrow = null;
    self._contentText = null;
    self._disEffect = null;
    self._targetObject = null;
    self._arrowDirection = 0;
    self._offX = 0;
    self._offY = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this.mouseChildren = this.mouseEnabled = false;
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.FrameBack01");
         this._headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.novice.DialogIcon");
         this._arrow = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("novice.GuildFrameArrow");
         this._contentText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.novice.ContentText2");
         this.addChild(this._arrow);
         this.addChild(this._bg);
         this.addChild(this._headIcon);
         this.addChild(this._contentText);
      }
    addEvent() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__resizeEventHandler"));
      }
    __resizeEventHandler(param1) {
         this.refreshView();
      }
    setContent(param1, param2 = 0, param3 = null, param4 = 0, param5 = 0) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         this._targetObject = param3;
         this._arrowDirection = param2;
         this._offX = param4;
         this._offY = param5;
         this._contentText.text = "    " + param1;
         this._bg.width = $.int(this._contentText.textWidth + 205);
         this._bg.height = $.int(this._contentText.textHeight + 40);
         if(this._bg.width < 356)
         {
            this._bg.width = 356;
         }
         if(this._bg.height < 67)
         {
            this._bg.height = 67;
         }
         this._bg.x = 0;
         this._bg.y = this._headIcon.y + this._headIcon.height - this._bg.height;
         this._contentText.x = this._headIcon.x + this._headIcon.width - 14;
         this._contentText.y = this._bg.y + 21;
         if(param2 <= 0)
         {
            this._arrow.visible = false;
            this._arrow.stop();
         }
         else
         {
            this._arrow.visible = true;
            this._arrow.play();
         }
         this.refreshView();
      }
    refreshView() {
         var _loc3_ = null;
         var _loc1_ = NaN;
         var _loc2_ = NaN;
         if(this._targetObject)
         {
            _loc3_ = new ($.C("flash.geom.Point"))(this._targetObject.x,this._targetObject.y);
            _loc3_ = this._targetObject.parent.localToGlobal(_loc3_);
            if(this._targetObject.hasOwnProperty("displayWidth") && this._targetObject.hasOwnProperty("displayHeight"))
            {
               _loc1_ = Number(this._targetObject["displayWidth"]);
               _loc2_ = Number(this._targetObject["displayHeight"]);
            }
            else
            {
               _loc1_ = Number(this._targetObject["width"]);
               _loc2_ = Number(this._targetObject["height"]);
            }
            switch(this._arrowDirection - 2)
            {
               case 0:
                  this._arrow.x = this._bg.x + (this._bg.width + this._arrow.width) / 2;
                  this._arrow.y = this._bg.y + this._bg.height + this._arrow.height - 4;
                  this.x = _loc3_.x - (this._bg.width - _loc1_) / 2;
                  this.y = _loc3_.y - this.displayHeight;
                  break;
               case 2:
                  this._arrow.scaleY = -1;
                  this._arrow.x = this._bg.x + (this._bg.width + this._arrow.width) / 2;
                  this._arrow.y = this._bg.y - this._arrow.height + 4;
                  this.x = _loc3_.x - (this._bg.width - _loc1_) / 2;
                  this.y = _loc3_.y + _loc2_;
                  break;
               default:
                  this._arrow.rotation = -90;
                  this._arrow.x = this._bg.x + this._bg.width + 57;
                  this._arrow.y = this._bg.y + (this._bg.height - this._arrow.height) / 2;
                  this.x = _loc3_.x - this._bg.width - this._arrow.width;
                  this.y = _loc3_.y - this.displayHeight + _loc2_ / 2 + this._arrow.height / 2;
            }
            if(this.x + this._bg.width > $.C("com.pickgliss.toplevel.StageReferance").stageWidth)
            {
               this.x = $.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._bg.width;
               this._arrow.x = _loc3_.x - this.x + (this._arrow.width + _loc1_) / 2;
            }
            if(this._offX != 0 || this._offY != 0)
            {
               this.x += this._offX;
               this.y += this._offY;
            }
         }
      }
    btnEffect(param1) {
         if(!this._disEffect)
         {
            this._disEffect = new ($.C("mainBar.effects.MainToolBtnGlowEffect"))(param1);
         }
         this._disEffect.play();
      }
    show() {
         this.alpha = 0;
         this.scaleX = this.scaleY = 0.1;
         $.C("com.greensock.TweenLite").to(this,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         $.C("com.greensock.TweenLite").killTweensOf(this);
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__resizeEventHandler"));
         if(this._disEffect)
         {
            this._disEffect.dispose();
         }
         this._disEffect = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._arrow);
         this._arrow = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIcon);
         this._headIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentText);
         this._contentText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__NoviceFrame1, "views.NoviceFrame1", []);
  return __NoviceFrame1;
}
deps["views.NoviceFrame1"] = ["com.greensock.TweenLite", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.geom.Point", "mainBar.effects.MainToolBtnGlowEffect", "yishi.keyboard.KeyBoardRegister"];

defs["views.NoviceFrame4"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __NoviceFrame4 extends __Base {
    static $fields(self) {
    self._offset = null;
    self._bg = null;
    self._headIcon = null;
    self._contentMC = null;
    self._closeBtn = null;
    self._callback = null;
    }
    constructor(param1, param2, param3 = null) {
         super();
         this._callback = param3;
         this._offset = param2;
         this.initView(param1);
         this.initEvent();
      }
    initEvent() {
         this._closeBtn.addEventListener("click",$.bind(this, "__onClick"));
         this.addEventListener("added",$.bind(this, "__onAdded"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__onStageResize"),false,-10);
      }
    removeEvent() {
         if(this._closeBtn)
         {
            this._closeBtn.removeEventListener("click",$.bind(this, "__onClick"));
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__onStageResize"));
         this.removeEventListener("added",$.bind(this, "__onAdded"));
      }
    __onAdded(param1) {
         this.removeEventListener("added",$.bind(this, "__onAdded"));
         this.__onStageResize();
      }
    initView(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("novice.FrameBack01");
         this._headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.novice.DialogIcon");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("asset.novice.close");
         this._contentMC = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject(param1);
         this._bg.width = $.int(this._contentMC.width + 195);
         this._bg.height = $.int(this._contentMC.height + 75);
         if(this._bg.width < 356)
         {
            this._bg.width = 356;
         }
         if(this._bg.height < 67)
         {
            this._bg.height = 67;
         }
         this._bg.x = 0;
         this._bg.y = this._headIcon.y + this._headIcon.height - this._bg.height;
         this._contentMC.x = this._headIcon.x + this._headIcon.width - 14;
         this._contentMC.y = this._bg.y + 21;
         this._closeBtn.x = this._bg.x + (this._bg.width - this._closeBtn.width) / 2 + 39;
         this._closeBtn.y = this._contentMC.y + this._contentMC.height + 9;
         this.addChild(this._bg);
         this.addChild(this._contentMC);
         this.addChild(this._headIcon);
         this.addChild(this._closeBtn);
      }
    __onStageResize(param1 = null) {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         if(this.parent == null)
         {
            this.addEventListener("added",$.bind(this, "__onAdded"));
            return;
         }
         var _loc2_ = Number($.C("com.pickgliss.toplevel.StageReferance").stageWidth);
         var _loc3_ = Number($.C("com.pickgliss.toplevel.StageReferance").stageHeight);
         this.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this.width) * 0.5 + this._offset.x;
         this.y = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - this.height) * 0.5 + this._offset.y;
         if(this.x + this.width > _loc2_)
         {
            this.x = _loc2_ - this.width - 10;
         }
         if(this.y + this.height > _loc3_)
         {
            this.y = _loc3_ - this.height - 10;
         }
      }
    __onClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._callback != null)
         {
            this._callback();
         }
         this.dispose();
      }
    dispose() {
         this.removeEvent();
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._contentMC);
         this._contentMC = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIcon);
         this._headIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._closeBtn);
         this._closeBtn = null;
         this._offset = null;
         this._callback = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__NoviceFrame4, "views.NoviceFrame4", []);
  return __NoviceFrame4;
}
deps["views.NoviceFrame4"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "yishi.keyboard.KeyBoardRegister"];
