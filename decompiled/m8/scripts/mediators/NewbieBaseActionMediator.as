package mediators
{
   import battle.BattleManager;
   import battle.view.ui.BattleSkillItemII;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import dialog.DialogManager;
   import dialog.utils.NewbieSocketOutManager;
   import events.ObjectsEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   import mainBar.SmallMapBar;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.BaseCastle;
   import map.internals.data.template.MapTemplate;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.view.displaye.MapNameMovie;
   import map.outercity.manager.OuterCityManager;
   import map.space.SpaceManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.task.TaskTemplate;
   import ui.events.UIBarEvent;
   import ui.maintoolbar.MainToolBar;
   import ui.maintoolbar.view.MainToolButton;
   import ui.queuebar.QueueBar;
   import ui.tasktracebar.TaskTraceBar;
   import utils.BaffleHelper;
   import utils.DisObjResizeUtils;
   import utils.NewbieUtils;
   import views.GameStartPlayView;
   import views.NewModuleOpenPopView;
   import views.NoviceFameCampaign;
   import views.NoviceFogView;
   import views.NoviceFrame1;
   import views.NoviceFrame4;
   import yishi.SwitchPageHelp;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.interfaces.IAction;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.scene.SceneType;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.ColorManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MaskUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.guild.NameView;
   import yishi.view.guild.NoviceArrowView;
   import yishi.view.guild.QteGuideFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class NewbieBaseActionMediator
   {
      
      private static var _mask:Sprite;
      
      private static var _drawContainer:Sprite;
      
      private static var _drawClickEventArgs:Array;
      
      private static var _moveEventArgs:Array;
      
      private static var _colorEffect:ColorManager;
      
      private static var _colorEventArgs:Array;
      
      private static var _guildFrameList:Array;
      
      private static var _guildArrowList:Array;
      
      private static var _copyTarget:DisplayObject;
      
      private static var _createTarget:DisplayObject;
      
      private static var _canEnableKeyboard:Boolean = true;
      
      public static var canEnableKeyboard:Boolean = false;
      
      public function NewbieBaseActionMediator()
      {
         super();
      }
      
      public static function emptyAction() : void
      {
      }
      
      public static function sendEnterScene(param1:int, param2:int = 0) : void
      {
         var _loc3_:String = SceneType.getSceneTypeById(param1);
         if(_loc3_ == SceneManager.instance.currentType)
         {
            return;
         }
         switch(_loc3_)
         {
            case "CASTLE_SCENE":
               SceneManager.instance.setScene(_loc3_);
               break;
            case "SPACE_SCENE":
               SwitchPageHelp.enterToSpace();
               break;
            case "CAMPAIGN_MAP_SCENE":
               NewbieSocketOutManager.sendEnterCampaign(param2);
               break;
            default:
               throw new Error("无此类型场景，type{invalid_utf8=239}{invalid_utf8=188}?" + _loc3_);
         }
      }
      
      public static function showMask(param1:Number = 0.6, param2:int = 0) : void
      {
         var _loc3_:Shape = null;
         setKeyboardState(null,null,"0",0);
         ShowTipManager.Instance.removeAllTip();
         NotificationManager.instance.dispatchEvent(new UIBarEvent("HIDE_TASK_TRACE"));
         if(!_mask)
         {
            _loc3_ = new Shape();
            _loc3_.graphics.beginFill(0,1);
            _loc3_.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
            _loc3_.graphics.endFill();
            _mask = new Sprite();
            _mask.blendMode = "layer";
            _mask.addChild(_loc3_);
         }
         _mask.alpha = param1;
         LayerManager.Instance.addToLayer(_mask,param2,false,false);
         PlayerManager.instance.isExistNewbieMask = true;
      }
      
      public static function drawTargetOnMask(param1:Function, param2:Array, param3:String, param4:String, param5:int = -1, param6:int = 0, param7:int = 0, param8:String = null, param9:DisplayObject = null) : void
      {
         var _loc11_:DisplayObject = null;
         var _loc14_:BitmapData = null;
         var _loc10_:DisplayObject = null;
         if(!_mask)
         {
            NewbieUtils.execFunc(param1,param2);
            return;
         }
         if(param9)
         {
            _loc11_ = param9;
         }
         else
         {
            _loc11_ = getGuildTarget(param3);
         }
         if(!_loc11_)
         {
            NewbieUtils.execFunc(param1,param2);
            return;
         }
         if(!_drawContainer)
         {
            _drawContainer = new Sprite();
            _drawContainer.buttonMode = true;
            _drawContainer.mouseChildren = false;
            _drawContainer.blendMode = "erase";
         }
         else
         {
            _drawContainer.removeEventListener("rollOver",__onDrawTargetMouseEvent);
            _drawContainer.removeEventListener("rollOut",__onDrawTargetMouseEvent);
            _drawContainer.removeEventListener("mouseOver",__onDrawTargetMouseEvent);
            _drawContainer.removeEventListener("mouseOut",__onDrawTargetMouseEvent);
            _drawContainer.removeEventListener("mouseDown",__onDrawTargetMouseEvent);
            _drawContainer.removeEventListener("click",__onDrawTargetMouseEvent);
            _drawClickEventArgs = null;
            cleanDrawContainer();
         }
         switch(param5)
         {
            case 0:
               LayerManager.Instance.addToLayer(_drawContainer,0);
               break;
            default:
               if(!_drawContainer.parent || _drawContainer.parent != _mask)
               {
                  _mask.addChild(_drawContainer);
               }
         }
         var _loc12_:Boolean = param4 == "1";
         var _loc13_:Object = getTargetObjSize(_loc11_);
         if(_loc13_.w <= 0 && _loc13_.h <= 0)
         {
            _loc13_.w = 100;
            _loc13_.h = 100;
         }
         _loc14_ = new BitmapData(_loc13_.w,_loc13_.h,true,0);
         _loc14_.draw(_loc11_);
         _drawContainer.addChild(new Bitmap(_loc14_));
         if(param6 == 0 && param7 == 0)
         {
            DisObjResizeUtils.addTarget(_drawContainer,_loc11_);
         }
         else
         {
            DisObjResizeUtils.addTarget(_drawContainer,_loc11_,new Point(param6,param7));
         }
         if(_loc12_)
         {
            if(param8 != null && param8 != "")
            {
               _loc10_ = getGuildTarget(param8);
               _drawClickEventArgs = [_loc10_,param1,param2];
            }
            else
            {
               _drawClickEventArgs = [_loc11_,param1,param2];
            }
            _drawContainer.addEventListener("rollOver",__onDrawTargetMouseEvent);
            _drawContainer.addEventListener("rollOut",__onDrawTargetMouseEvent);
            _drawContainer.addEventListener("mouseOver",__onDrawTargetMouseEvent);
            _drawContainer.addEventListener("mouseOut",__onDrawTargetMouseEvent);
            _drawContainer.addEventListener("mouseDown",__onDrawTargetMouseEvent);
            _drawContainer.addEventListener("click",__onDrawTargetMouseEvent);
         }
         else
         {
            NewbieUtils.execFunc(param1,param2);
         }
      }
      
      private static function __onDrawTargetMouseEvent(param1:MouseEvent) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:String = param1.type;
         if("click" !== _loc2_)
         {
            if(_drawClickEventArgs)
            {
               dispatchAllChildEvent(_drawClickEventArgs[0],param1);
            }
         }
         else
         {
            if(LoaderManagerII.instance.hasPrority(10))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.resourceLoading"));
               return;
            }
            if(_drawContainer)
            {
               _drawContainer.removeEventListener("click",__onDrawTargetMouseEvent);
            }
            if(_drawClickEventArgs)
            {
               dispatchAllChildEvent(_drawClickEventArgs[0],param1);
               NewbieUtils.execFunc(_drawClickEventArgs[1],_drawClickEventArgs[2]);
               _drawClickEventArgs = null;
            }
         }
      }
      
      private static function dispatchAllChildEvent(param1:DisplayObject, param2:MouseEvent) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(param1 is IBaseMouseEvent)
         {
            if(param2.type == "click")
            {
               (param1 as IBaseMouseEvent).mouseClickHandler(param2);
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
         if(param1 is DisplayObjectContainer)
         {
            _loc3_ = param1 as DisplayObjectContainer;
            _loc4_ = _loc3_.numChildren;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               dispatchAllChildEvent(_loc3_.getChildAt(_loc5_),param2);
               _loc5_++;
            }
         }
      }
      
      public static function hideMask() : void
      {
         NotificationManager.instance.dispatchEvent(new UIBarEvent("SHOW_TASK_TRACE"));
         setKeyboardState(null,null,"1",0);
         if(_mask && _mask.parent)
         {
            _mask.parent.removeChild(_mask);
         }
         _mask = null;
         PlayerManager.instance.isExistNewbieMask = false;
      }
      
      public static function cleanDrawContainer() : void
      {
         ObjectUtils.disposeAllChildren(_drawContainer);
      }
      
      public static function showDialog(param1:Function, param2:Array, param3:String, param4:String = "1") : void
      {
         DialogManager.showDialog(param1,param3,StageReferance.stage,param4 == "1");
      }
      
      public static function showMapName(param1:Function, param2:Array) : void
      {
         var _loc3_:MapTemplate = CampaignManager.instance.mapModel ? CampaignManager.instance.mapModel.mapTempInfo : null;
         if(_loc3_)
         {
            new MapNameMovie(param1).loadIcon(_loc3_.MapFileId);
         }
      }
      
      public static function moveNPC(param1:Function, param2:Array, param3:int, param4:int, param5:int, param6:int, param7:int, param8:String = "0") : void
      {
         var _loc12_:Object = null;
         var _loc14_:Array = null;
         var _loc10_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(!_loc10_)
         {
            NewbieUtils.execFunc(param1,param2);
            return;
         }
         if(param3 <= 0)
         {
            _loc12_ = CampaignManager.instance.controller.getArmyView(_loc10_.selfMemberData);
         }
         else
         {
            _loc12_ = _loc10_.getNodeByNodeId(param3);
         }
         if(!_loc12_)
         {
            NewbieUtils.execFunc(param1,param2);
            return;
         }
         var _loc13_:int = int(param4 == -1 ? _loc12_.x / 20 : param4);
         var _loc11_:int = int(param5 == -1 ? _loc12_.y / 20 : param5);
         if(param6 == -1 && param7 == -1)
         {
            _loc14_ = null;
         }
         else
         {
            _loc14_ = CampaignManager.instance.controller.findPath.find(new Point(_loc13_,_loc11_),new Point(param6,param7));
         }
         var _loc9_:Boolean = param8 == "1";
         if(_loc9_)
         {
            _moveEventArgs = [param1,param2];
            _loc12_.addEventListener("walkOver",__armyWalkOverHandler);
            _loc12_["info"].pathInfo = _loc14_;
         }
         else
         {
            _loc12_["info"].pathInfo = _loc14_;
            NewbieUtils.execFunc(param1,param2);
         }
      }
      
      private static function __armyWalkOverHandler(param1:ObjectsEvent) : void
      {
         if(param1.currentTarget)
         {
            (param1.currentTarget as Sprite).removeEventListener("walkOver",__armyWalkOverHandler);
         }
         if(_moveEventArgs)
         {
            NewbieUtils.execFunc(_moveEventArgs[0],_moveEventArgs[1]);
            _moveEventArgs = null;
         }
      }
      
      public static function taskTraceItemShine(param1:Function, param2:Array) : void
      {
         var _loc4_:Sprite = TaskTraceBar.instance.taskTraceView;
         if(!_loc4_)
         {
            NewbieUtils.execFunc(param1,param2);
            return;
         }
         var _loc3_:DisplayObject = ComponentFactory.Instance.creatComponentByStylename("core.novice.shineTask");
         _loc3_.x = -58;
         _loc3_.y = -8;
         _loc4_.addChild(_loc3_);
         TweenMax.to(_loc3_,0.5,{
            "alpha":0,
            "yoyo":true,
            "repeat":2,
            "onComplete":tweenCompleteCall,
            "onCompleteParams":[_loc3_,true,param1,param2,true]
         });
         _loc4_["novicShine"]();
      }
      
      public static function setTaskArrowGuild(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:String = getContentByValue(param2);
         NotificationManager.instance.sendNotification("NOVICE_ARROW_STATE",{
            "type":param1,
            "tip":_loc4_
         });
         if(param3 > 0 && TaskTraceBar.instance.taskTraceView)
         {
            TaskTraceBar.instance.taskTraceView["scrollToItemByTaskTempId"](param3);
            TaskTraceBar.instance.taskTraceView["setArrowPosByTaskTempId"](param3);
         }
      }
      
      public static function moveFocusToCastleBuild(param1:Function, param2:Array, param3:int) : void
      {
         var _loc4_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(param3);
         var _loc5_:DisplayObject = BuildingManager.instance.castleMap["buildingsDic"][_loc4_.buildingId];
         BuildingManager.instance.castleMap["moveFocus2"](_loc5_,param1);
      }
      
      public static function castleBuildShine(param1:Function, param2:Array, param3:int) : void
      {
         _colorEventArgs = [param1,param2];
         var _loc4_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(param3);
         var _loc5_:DisplayObject = BuildingManager.instance.castleMap["buildingsDic"][_loc4_.buildingId];
         if(_colorEffect)
         {
            _colorEffect.removeEventListener("complete",__colorEffectCompleteHandler);
            _colorEffect = null;
         }
         _colorEffect = new ColorManager(_loc5_["curView"]["effect_area"],1,0);
         _colorEffect.addEventListener("complete",__colorEffectCompleteHandler);
      }
      
      private static function __colorEffectCompleteHandler(param1:Event) : void
      {
         if(_colorEffect)
         {
            _colorEffect.removeEventListener("complete",__colorEffectCompleteHandler);
            _colorEffect = null;
         }
         if(_colorEventArgs)
         {
            NewbieUtils.execFunc(_colorEventArgs[0],_colorEventArgs[1]);
            _colorEventArgs = null;
         }
      }
      
      public static function createGuildFrame1(param1:String, param2:int, param3:int, param4:int = 0, param5:String = "1", param6:int = 0, param7:int = 0, param8:int = 0, param9:DisplayObject = null) : void
      {
         var _loc10_:DisplayObject = null;
         var _loc11_:String = getContentByValue(param4);
         if(param9)
         {
            _loc10_ = param9;
         }
         else
         {
            _loc10_ = getGuildTarget(param1);
         }
         var _loc12_:NoviceFrame1 = new NoviceFrame1();
         if(_loc10_ && param5 == "1")
         {
            _loc12_.btnEffect(_loc10_);
         }
         _loc12_.setContent(getReplacedText(_loc11_),param6,_loc10_,param7,param8);
         addToGuildFrameList(_loc12_);
         LayerManager.Instance.addToLayer(_loc12_,0);
         _loc12_.show();
      }
      
      public static function createGuildFrame2(param1:String, param2:int, param3:int, param4:int = 0, param5:String = "0", param6:int = 0) : void
      {
         var _loc7_:DisplayObject = getGuildTarget(param1);
         var _loc9_:NoviceFameCampaign = new NoviceFameCampaign();
         var _loc8_:String = getContentByValue(param4);
         _loc9_.setText(getReplacedText(_loc8_),param6);
         addToGuildFrameList(_loc9_);
         LayerManager.Instance.addToLayer(_loc9_,0);
         DisObjResizeUtils.addTarget(_loc9_,_loc7_,new Point(param2,param3));
         _loc9_.showTween();
      }
      
      public static function createGuildFrame3(param1:Function, param2:Array, param3:String, param4:int, param5:int, param6:String) : void
      {
         var _loc7_:DisplayObject = getGuildTarget(param3);
         var _loc8_:QteGuideFrame = new QteGuideFrame(param6,new Point(param4,param5),param1,_loc7_);
         addToGuildFrameList(_loc8_);
         LayerManager.Instance.addToLayer(_loc8_,0);
      }
      
      public static function createGuildFrame4(param1:Function, param2:Array, param3:int, param4:int, param5:String) : void
      {
         var _loc6_:NoviceFrame4 = new NoviceFrame4(param5,new Point(param3,param4),param1);
         addToGuildFrameList(_loc6_);
         LayerManager.Instance.addToLayer(_loc6_,0);
      }
      
      public static function createGuildArrow(param1:String, param2:int, param3:int, param4:int, param5:int = 0, param6:DisplayObject = null) : void
      {
         var _loc7_:DisplayObject = null;
         var _loc9_:String = getContentByValue(param5);
         if(param6)
         {
            _loc7_ = param6;
         }
         else
         {
            _loc7_ = getGuildTarget(param1);
         }
         var _loc8_:NoviceArrowView = new NoviceArrowView(param4,_loc9_,true,null);
         addToGuildArrowList(_loc8_);
         LayerManager.Instance.addToLayer(_loc8_,0);
         DisObjResizeUtils.addTarget(_loc8_,_loc7_,new Point(param2,param3));
         _loc8_.showTween();
      }
      
      public static function cleanAll() : void
      {
         cleanCreateTarget();
         cleanCopyTarget();
         cleanDrawContainer();
         cleanGuildArrow();
         cleanGuildFrame();
         hideMask();
      }
      
      public static function cleanGuildArrow() : void
      {
         for each(var _loc1_:DisplayObject in _guildArrowList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         if(_guildArrowList)
         {
            _guildArrowList.length = 0;
         }
      }
      
      public static function cleanGuildFrame() : void
      {
         for each(var _loc1_:DisplayObject in _guildFrameList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         if(_guildFrameList)
         {
            _guildFrameList.length = 0;
         }
      }
      
      public static function addToGuildFrameList(param1:DisplayObject) : void
      {
         if(!_guildFrameList)
         {
            _guildFrameList = [];
         }
         _guildFrameList.push(param1);
      }
      
      private static function addToGuildArrowList(param1:DisplayObject) : void
      {
         if(!_guildArrowList)
         {
            _guildArrowList = [];
         }
         _guildArrowList.push(param1);
      }
      
      public static function tweenTarget(param1:Function, param2:Array, param3:String, param4:Number, param5:String, param6:String = "0", param7:String = "", param8:int = 0, param9:int = 0, param10:String = "1") : void
      {
         var _loc13_:Point = null;
         var _loc14_:Boolean = param10 == "1";
         var _loc12_:DisplayObject = getGuildTarget(param3);
         var _loc11_:DisplayObject = getGuildTarget(param7);
         var _loc15_:Object = NewbieUtils.stringToObject(param5);
         _loc15_["onComplete"] = tweenCompleteCall;
         _loc15_["onCompleteParams"] = [_loc12_,false,param1,param2,_loc14_];
         if(_loc11_ && _loc11_.parent)
         {
            _loc13_ = _loc11_.parent.localToGlobal(new Point(_loc11_.x,_loc11_.y));
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
            TweenMax.from(_loc12_,param4,_loc15_);
         }
         else
         {
            TweenMax.to(_loc12_,param4,_loc15_);
         }
         if(!_loc14_)
         {
            NewbieUtils.execFunc(param1,param2);
         }
      }
      
      private static function tweenCompleteCall(param1:Object, param2:Boolean, param3:Function, param4:Array, param5:Boolean) : void
      {
         TweenMax.killTweensOf(param1);
         if(param2)
         {
            ObjectUtils.disposeObject(param1);
            param1 = null;
         }
         if(param5)
         {
            NewbieUtils.execFunc(param3,param4);
         }
      }
      
      public static function controlBattleState(param1:String) : void
      {
         var _loc2_:Boolean = param1 == "1";
         if(_loc2_)
         {
            NewbieSocketOutManager.sendBattlePause();
         }
         else
         {
            NewbieSocketOutManager.sendBattleContinue();
         }
      }
      
      public static function setMainToolBarBtn(param1:Function, param2:Array, param3:int = 0, param4:String = "0") : void
      {
         var _loc9_:MainToolButton = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc7_:int = 14;
         _loc6_ = 1;
         while(_loc6_ <= _loc7_)
         {
            if(_loc6_ != 10)
            {
               _loc9_ = MainToolBar.instance.getButtnByType(_loc6_);
               if(_loc9_ && _loc9_.isVisible)
               {
                  _loc9_.enable = _loc9_.isVisible;
               }
            }
            _loc6_++;
         }
         MainToolBar.instance.doMove();
         if(param3 > 0)
         {
            _loc9_ = MainToolBar.instance.getButtnByType(param3);
            _loc5_ = param4 == "1";
            if(_loc5_)
            {
               MainToolBar.instance.doMove(_loc9_,true,playBtnEffect,[_loc9_,param1]);
            }
            else
            {
               playBtnEffect([_loc9_,param1]);
            }
         }
         else
         {
            NewbieUtils.execFunc(param1,param2);
         }
      }
      
      private static function playBtnEffect(param1:Array) : void
      {
         MaskUtils.instance.addShowMovie(param1[0],param1[1]);
      }
      
      public static function copyTarget(param1:String) : void
      {
         cleanCopyTarget();
         var _loc3_:DisplayObject = getGuildTarget(param1);
         var _loc2_:Object = getTargetObjSize(_loc3_);
         var _loc4_:BitmapData = new BitmapData(_loc2_.w,_loc2_.h,true,0);
         _loc4_.draw(_loc3_);
         _copyTarget = new Bitmap(_loc4_);
         LayerManager.Instance.addToLayer(_copyTarget,0);
      }
      
      public static function cleanCopyTarget() : void
      {
         TweenMax.killTweensOf(_copyTarget);
         ObjectUtils.disposeObject(_copyTarget);
         _copyTarget = null;
      }
      
      public static function sendSaveNode(param1:int) : void
      {
         NewbieSocketOutManager.sendSaveProcess(param1);
      }
      
      public static function sendInitBuildAndQueue() : void
      {
         NewbieSocketOutManager.sendInitBuildAndQueue();
      }
      
      public static function moveOuterCityMap(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc5_:NoviceFogView = null;
         var _loc6_:BaseCastle = null;
         var _loc4_:* = undefined;
         OuterCityManager.instance.mapView.novimotionTo(new Point(param1 - StageReferance.stageWidth / 2,param2 - StageReferance.stageHeight / 2));
         if(OuterCityManager.instance.mapView)
         {
            _loc6_ = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
            _loc4_ = OuterCityManager.instance.model.getPhysicsByXY(param1,param2);
            if(param3 == 1)
            {
               _loc5_ = new NoviceFogView(OuterCityManager.instance.mapView.width,OuterCityManager.instance.mapView.height);
               OuterCityManager.instance.mapView.addChild(_loc5_);
               _loc5_.updatePos(_loc4_.x,_loc4_.y,3);
               _loc5_.updatePos(_loc6_.x,_loc6_.y,3);
            }
         }
      }
      
      public static function createSelectRoleView(param1:Function, param2:Array) : void
      {
         CheckUIModuleUtil.instance.tryCall("rename",openNameCall,[param1]);
      }
      
      private static function openNameCall(param1:Array) : void
      {
         var _loc2_:NameView = new NameView(param1[0]);
         _loc2_.show();
      }
      
      public static function visitSpaceNPC(param1:Function, param2:Array, param3:int, param4:String = "1") : void
      {
         var _loc5_:Boolean = param4 == "1";
         SpaceManager.instance.visitSpaceNPC(param3,_loc5_,param1);
      }
      
      public static function sendCallInCampaign(param1:int, param2:int, param3:int) : void
      {
         NewbieSocketOutManager.sendCallInCampaign(param1,param2,param3);
      }
      
      public static function closeFrame(param1:String) : void
      {
         var _loc2_:Frame = FrameControllerManager.instance[param1]["frame"];
         if(_loc2_)
         {
            _loc2_.closeButton.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public static function createGuildTarget(param1:Function, param2:Array, param3:String) : void
      {
         var _loc7_:SkillTempInfo = null;
         var _loc6_:BaseIconView = null;
         var _loc5_:NewModuleOpenPopView = null;
         cleanCreateTarget();
         var _loc8_:int;
         var _loc4_:Array;
         switch((_loc8_ = (_loc4_ = param3.split("_")).shift()) - 1)
         {
            case 0:
               _loc7_ = TempleteManager.instance.getSkillTemplateInfoByJobAndIdx(ArmyManager.instance.thane.templateInfo.Job,int(_loc4_[0]));
               _createTarget = _loc6_ = ComponentFactory.Instance.creatCustomObject("novice.battle.SkillItemView");
               _loc6_.icon = IconFactory.getTecIconByIcon(_loc7_.Icons);
               _loc6_.tipData = _loc7_;
               _loc6_.x = -400;
               _loc6_.y = -400;
               LayerManager.Instance.addToLayer(_loc6_,0);
               NewbieUtils.execFunc(param1,param2);
               break;
            case 1:
               _createTarget = _loc5_ = new NewModuleOpenPopView();
               _loc5_.callback = param1;
               _loc5_.callArgs = param2;
               _loc5_.icon = _loc4_[0];
               _loc5_.btnText = _loc4_[1];
               _loc5_.show();
         }
      }
      
      public static function cleanCreateTarget() : void
      {
         TweenMax.killTweensOf(_createTarget);
         ObjectUtils.disposeObject(_createTarget);
         _createTarget = null;
      }
      
      public static function setTargetPosAndScale(param1:String, param2:String = "0", param3:String = "0", param4:String = "1", param5:String = "1", param6:String = "") : void
      {
         var _loc7_:Point = null;
         var _loc10_:DisplayObject = getGuildTarget(param1);
         var _loc8_:Object = getTargetObjSize(_loc10_);
         var _loc9_:DisplayObject = getGuildTarget(param6);
         if((param2 == "reference" || param3 == "reference") && _loc9_ && _loc9_.parent)
         {
            _loc7_ = _loc9_.parent.localToGlobal(new Point(_loc9_.x,_loc9_.y));
            _loc7_ = _loc10_.parent.globalToLocal(_loc7_);
            _loc10_.x = _loc7_.x;
            _loc10_.y = _loc7_.y;
         }
         var _loc11_:String = param2;
         if("middle" !== _loc11_)
         {
            _loc10_.x = int(param2);
         }
         else
         {
            _loc10_.x = (StageReferance.stageWidth - _loc8_.w) / 2;
         }
         _loc11_ = param3;
         if("middle" !== _loc11_)
         {
            _loc10_.y = int(param3);
         }
         else
         {
            _loc10_.y = (StageReferance.stageHeight - _loc8_.h) / 2;
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
      
      public static function sendSetSkillFastKey(param1:String) : void
      {
         var _loc2_:Array = param1.split("_");
         var _loc4_:String = "";
         for each(var _loc3_:String in _loc2_)
         {
            _loc4_ += _loc3_ + ",";
         }
         FrameControllerManager.instance.armyController.sendSetFastKey(_loc4_);
      }
      
      public static function showNewSkillInBattle(param1:int, param2:int) : void
      {
         var _loc4_:SkillTempInfo = null;
         var _loc3_:BattleSkillItemII = BattleManager.getInstance().battleUIView.getBottomBar().getSkillList().skillItemViews[param1];
         if(param2 == -1)
         {
            _loc3_.data = null;
         }
         else
         {
            _loc4_ = TempleteManager.instance.getSkillTemplateInfoByJobAndIdx(ArmyManager.instance.thane.templateInfo.Job,param2);
            _loc3_.data = _loc4_;
            _loc3_.buttonSkiner.enable = true;
         }
      }
      
      public static function setTargetDisplayIndex(param1:String, param2:int = -1, param3:int = -1, param4:String = "0", param5:String = "0", param6:int = 0) : void
      {
         var _loc7_:DisplayObject = getGuildTarget(param1);
         if(param3 > -1 && _loc7_)
         {
            LayerManager.Instance.addToLayer(_loc7_,param3,param4 == "1",param5 == "1",param6);
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
      
      public static function openHelpFrame(param1:Function, param2:Array, param3:String, param4:int = 0) : void
      {
         var _loc5_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename(param3);
         _loc5_.callback = param1;
         _loc5_.show(param4);
      }
      
      public static function moveNPCByTween(param1:Function, param2:Array, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:String = "0", param11:int = 0) : void
      {
         var npcView:DisplayObject;
         var completeWhenWalkOver:Boolean;
         var callback:Function = param1;
         var callArgs:Array = param2;
         var $npcId:int = param3;
         var $beginX:int = param4;
         var $beginY:int = param5;
         var $endX:int = param6;
         var $endY:int = param7;
         var $angle:int = param8;
         var $moveTime:int = param9;
         var $completeWhenWalkOver:String = param10;
         var $stepFrame:int = param11;
         var moveByTweenCompleteCall:* = function():void
         {
            TweenMax.killTweensOf(npcView);
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
               NewbieUtils.execFunc(callback,callArgs);
            }
         };
         var mapModel:CampaignMapModel = CampaignManager.instance.mapModel;
         if(!mapModel)
         {
            NewbieUtils.execFunc(callback,callArgs);
            return;
         }
         if($npcId <= 0)
         {
            npcView = CampaignManager.instance.controller.getArmyView(mapModel.selfMemberData);
         }
         else
         {
            npcView = mapModel.getNodeByNodeId($npcId);
         }
         if(!npcView)
         {
            NewbieUtils.execFunc(callback,callArgs);
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
         TweenMax.to(npcView,$moveTime,{
            "x":$endX,
            "y":$endY,
            "onComplete":moveByTweenCompleteCall,
            "ease":Linear.easeNone
         });
         if(!completeWhenWalkOver)
         {
            NewbieUtils.execFunc(callback,callArgs);
         }
      }
      
      public static function sendEnterCollectionBattle() : void
      {
         NewbieSocketOutManager.sendEnterCollectionBattle();
      }
      
      public static function setKeyboardState(param1:Function, param2:Array, param3:String = "0", param4:int = 0) : void
      {
         switch(param4 - 1)
         {
            case 0:
               _canEnableKeyboard = false;
               break;
            case 1:
               _canEnableKeyboard = true;
         }
         if(canEnableKeyboard)
         {
            StageReferance.stage.addEventListener("keyDown",__keyDownHandler,false,100);
         }
         NewbieUtils.execFunc(param1,param2);
      }
      
      private static function __keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc4_:int = int(PlayerManager.instance.newbieProcess);
         var _loc2_:Boolean = _loc4_ == 11500 && (param1.keyCode == 49 || param1.keyCode == 97);
         var _loc3_:Boolean = _loc4_ == 12500 && (param1.keyCode == 50 || param1.keyCode == 98);
         if(_drawClickEventArgs && (_loc2_ || _loc3_))
         {
            StageReferance.stage.removeEventListener("keyDown",__keyDownHandler,false);
            NewbieUtils.execFunc(_drawClickEventArgs[1],_drawClickEventArgs[2]);
            return;
         }
      }
      
      public static function clearCurrentGameAction() : void
      {
         var _loc1_:IAction = GameBaseQueueManager.instance.current;
         if(_loc1_)
         {
            if(_loc1_ is MapBaseAction)
            {
               (_loc1_ as MapBaseAction).finished = true;
            }
            _loc1_.dispose();
         }
      }
      
      public static function cleanGameLayer(param1:int = 3) : void
      {
         LayerManager.Instance.cleanLayerByType(param1);
      }
      
      public static function setNPC(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:DisplayObject = null;
         var _loc7_:* = undefined;
         var _loc5_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(!_loc5_)
         {
            return;
         }
         if(param1 <= 0)
         {
            _loc7_ = CampaignManager.instance.controller;
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
      
      public static function sceneMove(param1:Function, param2:Array, param3:int, param4:int) : void
      {
         CampaignManager.instance.controller.sceneMove(param3,param4,param1);
      }
      
      public static function lockCampaignScene(param1:String) : void
      {
         CampaignManager.instance.mapView.isLockMove = param1 == "1" ? true : false;
      }
      
      public static function setStageBaffle(param1:Boolean) : void
      {
         if(param1)
         {
            BaffleHelper.show();
         }
         else
         {
            BaffleHelper.hide();
         }
      }
      
      public static function sendNodeArrive(param1:int) : void
      {
         CampaignManager.instance.controller.sendCampaignArrive(ArmyManager.instance.army.id,param1);
      }
      
      public static function showStartPlayView(param1:Function, param2:Array) : void
      {
         var _loc3_:GameStartPlayView = new GameStartPlayView();
         _loc3_.callback = param1;
         _loc3_.show();
      }
      
      public static function doTask(param1:int = 0) : void
      {
         var _loc2_:TaskTemplate = null;
         if(param1 > 0)
         {
            _loc2_ = TaskManage.instance.getTaskByID(param1);
         }
         else
         {
            _loc2_ = TaskManage.instance.cate.mainTaskList ? TaskManage.instance.cate.mainTaskList[0] : null;
         }
         if(!_loc2_)
         {
            return;
         }
         SwitchPageHelp.skipPageByTaskCondictionType(_loc2_,null);
      }
      
      public static function newModuleOpen(param1:Function, param2:Array, param3:String, param4:int = 0, param5:Number = 1, param6:String = "", param7:int = 0, param8:int = 0, param9:int = 0) : void
      {
         var tweenArgs:Array;
         var callback:Function = param1;
         var callArgs:Array = param2;
         var icon:String = param3;
         var value:int = param4;
         var flyDuration:Number = param5;
         var flyReferTargetArgs:String = param6;
         var flyRelativeX:int = param7;
         var flyRelativeY:int = param8;
         var addShowBtn:int = param9;
         var cleanCreateAndComplete:* = function():void
         {
            cleanCreateTarget();
            NewbieUtils.execFunc(callback,callArgs);
         };
         var text:String = getContentByValue(value);
         var setBtnArgs:Array = [cleanCreateAndComplete,null,addShowBtn,"1"];
         if(addShowBtn > 0)
         {
            tweenArgs = [setMainToolBarBtn,setBtnArgs,"32",flyDuration,"{x:\'reference\'_y:\'reference\'_scaleX:0_scaleY:0}","0",flyReferTargetArgs,flyRelativeX,flyRelativeY,"0"];
         }
         else
         {
            tweenArgs = [cleanCreateAndComplete,null,"32",flyDuration,"{x:\'reference\'_y:\'reference\'_scaleX:0_scaleY:0}","0",flyReferTargetArgs,flyRelativeX,flyRelativeY,"0"];
         }
         createGuildTarget(tweenTarget,tweenArgs,"2_" + icon + "_" + text);
      }
      
      public static function getReplacedText(param1:String) : String
      {
         var _loc4_:String = null;
         if(!param1)
         {
            return null;
         }
         var _loc6_:int = param1.indexOf("{");
         var _loc5_:int = param1.indexOf("}");
         if(_loc6_ < 0 || _loc5_ < 0 || _loc6_ > _loc5_)
         {
            return param1;
         }
         var _loc2_:String = param1.slice(_loc6_,_loc5_ + 1);
         var _loc3_:Array = _loc2_.slice(1,_loc2_.length - 1).split("~");
         switch(int(_loc3_[0]) - 1)
         {
            case 0:
               _loc4_ = TempleteManager.instance.getSkillTemplateInfoByJobAndIdx(ArmyManager.instance.thane.templateInfo.Job,int(_loc3_[1])).TemplateName;
         }
         if(!_loc4_)
         {
            _loc4_ = "";
         }
         return param1.replace(_loc2_,_loc4_);
      }
      
      private static function getTargetObjSize(param1:DisplayObject) : Object
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(param1 is Component)
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
      
      private static function getGuildTarget(param1:String) : DisplayObject
      {
         var _loc4_:BuildInfo = null;
         var _loc3_:BuildInfo = null;
         var _loc5_:DisplayObject = null;
         var _loc2_:Array = param1.split("_");
         var _loc6_:int;
         switch(_loc6_ = _loc2_.shift())
         {
            case 1:
               return _copyTarget;
            case 2:
               return MainToolBar.instance.getButtnByType(int(_loc2_[0]));
            case 3:
               _loc4_ = BuildingManager.instance.getBuildingInfoBySonType(int(_loc2_[0]));
               return BuildingManager.instance.castleMap["buildingsDic"][_loc4_.buildingId];
            case 4:
               return CampaignManager.instance.mapView["getLandItem"](int(_loc2_[0]));
            case 5:
               if(_loc2_.length >= 2)
               {
                  return BattleManager.getInstance().battleUIView.getBottomBar().getSkillList().skillItemViews[int(_loc2_[0])][_loc2_[1]];
               }
               return BattleManager.getInstance().battleUIView.getBottomBar().getSkillList().skillItemViews[int(_loc2_[0])];
               break;
            case 6:
               return FrameControllerManager.instance.armyController.frame["equipView"].getItemViewByPos(int(_loc2_[0]));
            case 7:
               return FrameControllerManager.instance.armyController.frame["equipBag"].getBaseBagItemByPos(int(_loc2_[0]));
            case 8:
               return FrameControllerManager.instance.buildingController.frame["upgradeBtn"];
            case 9:
               return FrameControllerManager.instance.buildingController.frame["pawnTileList"]["getRecruitPawnBtn"](int(_loc2_[0]));
            case 10:
               return FrameControllerManager.instance.armyController.frame["getSkillItemByIndex"](int(_loc2_[0]));
            case 11:
               return SmallMapBar.instance.getButtonByType(int(_loc2_[0]));
            case 12:
               return QueueBar.instance.getQueueItemByType(int(_loc2_[0]));
            case 13:
               return SceneManager.instance.currentScene.sceneView["middleView"]["getItemByIdx"](int(_loc2_[0]));
            case 14:
               return MainToolBar.instance.recommendBtn;
            case 15:
               return FrameControllerManager.instance.friendControler.frame["getAddBtnByIndex"](int(_loc2_[0]));
            case 16:
               return FrameControllerManager.instance.buildingController.frame["levyView"]["levyBtn"];
            case 17:
               return FrameControllerManager.instance.storeController.frame[_loc2_[0]];
            case 18:
               return FrameControllerManager.instance.offerRewardController.frame["getOfferTaskItemByIndex"](int(_loc2_[0]))["acceptBtn"];
            case 19:
               return FrameControllerManager.instance.buildingController.frame["getTechItemByIndex"](int(_loc2_[0])).upgradeBtn;
            case 20:
               return FrameControllerManager.instance.pveRoomListControler.frame["getCreateBtn"]();
            case 21:
               return SceneManager.instance.currentScene.sceneView["getSelectInstanceBtn"]();
            case 22:
               return RoomManager.instance.controller.multiCampaignSelectFrame["getInstanceItemByIndex"](int(_loc2_[0]));
            case 23:
               return RoomManager.instance.controller.multiCampaignSelectFrame["rightView"]["okBtn"];
            case 24:
               return FrameControllerManager.instance.mazeControler.frame["startBtn"];
            case 25:
               return FrameControllerManager.instance.starController.frame["getCrystalByIndex"](int(_loc2_[0]));
            case 26:
               return FrameControllerManager.instance.spaceController.frame["getDialogItemByIndex"](int(_loc2_[0]));
            case 27:
               return GameBaseQueueManager.instance.current["taskTip"]["commitText"];
            case 28:
               return FrameControllerManager.instance.selectCampaignControler.frame["areaView"]["cpInfoView"][_loc2_[0]];
            case 29:
               _loc3_ = BuildingManager.instance.getBuildingInfoBySonType(int(_loc2_[0]));
               return BuildingManager.instance.castleMap["buildingsDic"][_loc3_.buildingId]["curView"]["effect_area"];
            case 30:
               switch(int(_loc2_.length) - 2)
               {
                  case 0:
                     return CampaignManager.instance.mapModel.getNodeByNodeId(int(_loc2_[0]))[_loc2_[1]];
                  case 1:
                     return CampaignManager.instance.mapModel.getNodeByNodeId(int(_loc2_[0]))[_loc2_[1]][_loc2_[2]];
                  default:
                     return CampaignManager.instance.mapModel.getNodeByNodeId(int(_loc2_[0]));
               }
               break;
            case 31:
               return TaskTraceBar.instance.taskTraceView["getTraceItemByTaskTempId"](int(_loc2_[0]));
            case 32:
               return _createTarget;
            case 33:
               return FrameControllerManager.instance.pvpControler.frame["singleView"]["starBtn"];
            case 34:
               switch(int(_loc2_.length) - 2)
               {
                  case 0:
                     _loc5_ = FrameControllerManager.instance.spaceController.frame["getMapNodeItemByNodeId"](int(_loc2_[0]))[_loc2_[1]];
                     if(_loc2_[1] == "selectedBg")
                     {
                        _loc5_.visible = true;
                     }
                     return _loc5_;
                  default:
                     return FrameControllerManager.instance.spaceController.frame["getMapNodeItemByNodeId"](int(_loc2_[0]));
               }
               break;
            case 35:
               return FrameControllerManager.instance.hookControler.frame["getRoomItem"](int(_loc2_[0]));
            case 36:
               return FrameControllerManager.instance.supermarketController.frame["auctionShopView"]["enterBtn"];
            case 37:
               return TaskTraceBar.instance.spaceMapButtonView.getMapBtn();
            case 38:
               break;
            case 39:
               switch(int(_loc2_.length) - 1)
               {
                  case 0:
                     return FrameControllerManager.instance.armyController.frame[_loc2_[0]];
                  default:
                     return FrameControllerManager.instance.armyController.frame;
               }
               break;
            case 40:
               return BattleManager.getInstance().battleUIView.getBottomBar().activeAwakenFigure;
            case 41:
               return BattleManager.getInstance().battleUIView.autoFightBtn;
            case 70:
               return FrameControllerManager.instance.armyController.frame["equipView"]["magicCardBtn"];
            case 71:
               return FrameControllerManager.instance.magicCardControler.frame["magicCardSlotView"]["treasureBtn"];
            case 80:
               switch(int(_loc2_[0]) - 1)
               {
                  case 0:
                     return OuterCityManager.instance.model.getPhysicsByXY(320,680);
                  case 1:
                     return OuterCityManager.instance.model.getPhysicsByXY(720,680);
                  case 2:
                     return OuterCityManager.instance.model.getPhysicsByXY(880,440);
                  default:
                     return null;
               }
               break;
            case 81:
               return FrameControllerManager.instance.buildingController.frame["mapButton"];
            case 82:
               return FrameControllerManager.instance.worldMapController.frame["mapAreaContainer"].movie["map1"];
            case 83:
               return OuterCityManager.instance.controler.outerFrameManager.getFrameById(2).attackBtn;
            case 84:
               return FrameControllerManager.instance.armyController.frame["vpLockBtn"];
         }
         return null;
      }
      
      private static function getTargetUnderPoint(param1:int, param2:int, param3:String) : DisplayObject
      {
         var _loc6_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         var _loc7_:String = null;
         var _loc10_:int = 0;
         var _loc9_:int = param1;
         var _loc8_:int = param2;
         var _loc11_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(_loc9_,_loc8_));
         var _loc5_:int = int(_loc11_.length);
         _loc10_ = _loc5_ - 1;
         while(_loc10_ >= 0)
         {
            _loc4_ = _loc11_[_loc10_];
            _loc7_ = getQualifiedClassName(_loc4_);
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
      
      public static function getContentByValue(param1:int = 0) : String
      {
         var _loc2_:String = "newbieXml.node.action.content" + param1;
         if(param1 != 0)
         {
            return LanguageMgr.GetTranslation(_loc2_);
         }
         return "";
      }
   }
}

