package outyard.scene
{
   import battle.utils.Int64Utils;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleFieldMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleUserMsg;
   import com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import manager.LanguageMgr;
   import mvc.module.outyard.LandPoint;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.OutyardBorderLayer;
   import yishi.view.component.MovieButton;
   
   public class OutyardMapFrame extends Frame
   {
      
      private var _shapeSprite1:Sprite;
      
      private var _shapeSprite2:Component;
      
      private var _shapeSprite3:Sprite;
      
      private var _shapeSprite4:Component;
      
      private var _worldBg:Image;
      
      private var _mapNoteBmp:Bitmap;
      
      private var _landNode:ScaleFrameImage;
      
      private var _activityBtn:BaseButton;
      
      private var _mapFrameBmp:Bitmap;
      
      private var _mapBtn1:IconButton;
      
      private var _mapBtn2:IconButton;
      
      private var _mapBtn3:IconButton;
      
      private var _mapBtn4:IconButton;
      
      private var _mapBtn5:IconButton;
      
      private var _borderLayer:OutyardBorderLayer;
      
      private var _topView:OutyardInfoTopView;
      
      private var _returnBtn:IconButton;
      
      private var _crystalBtn:MovieButton;
      
      private var _outyardBtn:MovieButton;
      
      private var _iconCrystal:Image;
      
      private var _iconOutyard:Image;
      
      private var _landView:OutyardLandView;
      
      private var _infoView:OutyardInfoView;
      
      private var _routeView:OutyardRouteView;
      
      private var _areaView:*;
      
      private var _smallBar:*;
      
      private var _diceView:*;
      
      private var _mapNum:int = 5;
      
      public const AREA_CLASS_PATH:String = "outyard.OutyardAreaView";
      
      public const SMALL_BAR_PATH:String = "outyard.OutyardAreaSmallBar";
      
      public const DICE_VIEW_PATH:String = "outyard.OutyardAreaDiceView";
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _timer:Timer;
      
      public function OutyardMapFrame()
      {
         super();
         initView();
         initEvent();
         OutyardManager.instance.OperateMapOutyard(1);
         FrameControllerManager.instance.outyardControler.isOutyardMapApply = true;
         checkOpenView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         ComponentGroupManager.Instance.disposeAllOpenFrame();
         _worldBg = ComponentFactory.Instance.creatComponentByStylename("outyard.worldBg");
         _mapFrameBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.mapFrameBmp");
         _mapBtn1 = ComponentFactory.Instance.creatComponentByStylename("outyard.mapBtn1");
         _mapBtn2 = ComponentFactory.Instance.creatComponentByStylename("outyard.mapBtn2");
         _mapBtn3 = ComponentFactory.Instance.creatComponentByStylename("outyard.mapBtn3");
         _mapBtn4 = ComponentFactory.Instance.creatComponentByStylename("outyard.mapBtn4");
         _mapBtn5 = ComponentFactory.Instance.creatComponentByStylename("outyard.mapBtn5");
         _topView = ComponentFactory.Instance.creatCustomObject("outyard.scene.OutyardInfoTopView");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.returnBtn");
         _crystalBtn = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.topBtn");
         _outyardBtn = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.topBtn");
         _iconCrystal = ComponentFactory.Instance.creatComponentByStylename("outyard.iconCrystal");
         _iconOutyard = ComponentFactory.Instance.creatComponentByStylename("outyard.iconOutyard");
         _mapNoteBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.mapTxtNoteBmp");
         _landNode = ComponentFactory.Instance.creatComponentByStylename("outyard.landNodeImage");
         _activityBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.activityBtn");
         _borderLayer = new OutyardBorderLayer(_worldBg.width,_worldBg.height);
         _shapeSprite1 = new Sprite();
         _shapeSprite1.graphics.clear();
         _shapeSprite1.graphics.beginFill(0,1);
         _shapeSprite1.graphics.drawRect(0,0,4200,2400);
         _shapeSprite1.graphics.endFill();
         _shapeSprite2 = new Component();
         _shapeSprite2.x = 1400;
         _shapeSprite2.y = 800;
         _shapeSprite3 = new Sprite();
         _shapeSprite3.graphics.clear();
         _shapeSprite3.graphics.beginFill(0,0.4);
         _shapeSprite3.graphics.drawRect(0,0,4200,2400);
         _shapeSprite3.graphics.endFill();
         _shapeSprite4 = new Component();
         _shapeSprite4.x = 1400;
         _shapeSprite4.y = 800;
         addToContent(_shapeSprite1);
         _shapeSprite1.addChild(_shapeSprite2);
         _shapeSprite3.addChild(_shapeSprite4);
         _shapeSprite2.addChild(_worldBg);
         _shapeSprite2.addChild(_borderLayer);
         _shapeSprite2.addChild(_mapFrameBmp);
         _shapeSprite2.addChild(_mapBtn1);
         _shapeSprite2.addChild(_mapBtn2);
         _shapeSprite2.addChild(_mapBtn3);
         _shapeSprite2.addChild(_mapBtn4);
         _shapeSprite2.addChild(_mapBtn5);
         _shapeSprite2.addChild(_mapNoteBmp);
         _shapeSprite2.addChild(_landNode);
         _shapeSprite2.addChild(_activityBtn);
         _landNode.x = 1203;
         _landNode.y = 15;
         _timer = new Timer(30000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         addEventListener("response",_frameResponse);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         _returnBtn.addEventListener("click",__returnClickHandler);
         _activityBtn.addEventListener("click",__activityClickHandler);
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            this["_mapBtn" + _loc1_].addEventListener("click",__mapClickHandler);
            this["_mapBtn" + _loc1_].addEventListener("rollOver",__mapOverHandler);
            this["_mapBtn" + _loc1_].addEventListener("rollOut",__mapOutHandler);
            _loc1_++;
         }
         NotificationManager.instance.addEventListener("GET_LAND_NODE",__getLandNodes);
         NotificationManager.instance.addEventListener("CLOSE_OUTYARD_FRAME",closeFrame);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchScene);
         NotificationManager.instance.addEventListener("CLICK_LAND_NODE",__clickNodeHandler);
         NotificationManager.instance.addEventListener("CLICK_AREA_VIEW",__areaClickHandler);
         NotificationManager.instance.addEventListener("OUTYARD_ROUTE_VIEW",__routeClickHandler);
         NotificationManager.instance.addEventListener("OUTYARD_STATE_INFO",__stateInfoHandler);
         __getLandNodes(null);
         __resizeHanlder(null);
         __stateInfoHandler(null);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         removeEventListener("response",_frameResponse);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         _returnBtn.removeEventListener("click",__returnClickHandler);
         _activityBtn.removeEventListener("click",__activityClickHandler);
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            this["_mapBtn" + _loc1_].removeEventListener("click",__mapClickHandler);
            this["_mapBtn" + _loc1_].removeEventListener("rollOver",__mapOverHandler);
            this["_mapBtn" + _loc1_].removeEventListener("rollOut",__mapOutHandler);
            _loc1_++;
         }
         NotificationManager.instance.removeEventListener("GET_LAND_NODE",__getLandNodes);
         NotificationManager.instance.removeEventListener("CLOSE_OUTYARD_FRAME",closeFrame);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchScene);
         NotificationManager.instance.removeEventListener("CLICK_LAND_NODE",__clickNodeHandler);
         NotificationManager.instance.removeEventListener("CLICK_AREA_VIEW",__areaClickHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_ROUTE_VIEW",__routeClickHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_STATE_INFO",__stateInfoHandler);
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
         _timer = null;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         OutyardManager.instance.OperateMapOutyard(2);
      }
      
      private function __getLandNodes(param1:NotificationEvent) : void
      {
         if(!OutyardManager.instance.model.signInMsg)
         {
            return;
         }
         var _loc2_:int = int(OutyardManager.instance.model.myForcePos);
         var _loc3_:int = _loc2_ + 4;
         _landNode.setFrame(_loc3_);
      }
      
      protected function __mapClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _shapeSprite1.addChild(_shapeSprite3);
         _landView = ComponentFactory.Instance.creatCustomObject("outyard.scene.OutyardLandView");
         _shapeSprite4.addChild(_landView);
         var _loc3_:String = param1.currentTarget.stylename;
         var _loc2_:int = int(_loc3_.substr(14,1));
         _landView.setMapId(_loc2_,param1);
         _topView.setMapId(_loc2_);
         _crystalBtn.addChild(_iconCrystal);
         _outyardBtn.addChild(_iconOutyard);
         _crystalBtn.x = 1041;
         _crystalBtn.y = 628;
         _crystalBtn.buttonMode = false;
         _outyardBtn.x = 1133;
         _outyardBtn.y = 629;
         _outyardBtn.buttonMode = false;
         _shapeSprite4.addChild(_topView);
         _shapeSprite4.addChild(_returnBtn);
         _shapeSprite4.addChild(_crystalBtn);
         _shapeSprite4.addChild(_outyardBtn);
      }
      
      protected function __areaClickHandler(param1:NotificationEvent) : void
      {
         clearViews();
         _shapeSprite1.addChild(_shapeSprite3);
         var _loc3_:Class = DisplayLoader.Context.applicationDomain.getDefinition("outyard.OutyardAreaView") as Class;
         _areaView = new _loc3_();
         var _loc4_:Class = DisplayLoader.Context.applicationDomain.getDefinition("outyard.OutyardAreaSmallBar") as Class;
         _smallBar = new _loc4_();
         var _loc2_:Class = DisplayLoader.Context.applicationDomain.getDefinition("outyard.OutyardAreaDiceView") as Class;
         _diceView = new _loc2_();
         addToContent(_areaView);
         addToContent(_smallBar);
         addToContent(_diceView);
         __resizeHanlder(null);
      }
      
      protected function __routeClickHandler(param1:NotificationEvent) : void
      {
         var _loc3_:HugeHeadNodeBattleFieldMsg = OutyardManager.instance.model.battleNodeMsg;
         var _loc2_:HugeHeadNodeBattleUserMsg = OutyardManager.instance.model.battleSelfMsg;
         if(!_loc3_ || !_loc2_)
         {
            return;
         }
         if(_loc2_.op == 1)
         {
            clearViews();
            _shapeSprite1.addChild(_shapeSprite3);
            _routeView = ComponentFactory.Instance.creatCustomObject("outyard.scene.OutyardRouteView");
            _shapeSprite4.addChild(_routeView);
         }
         else if(_loc2_.op == 3)
         {
            clearViews();
         }
      }
      
      private function __clickNodeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:LandPoint = param1.data as LandPoint;
         if(_loc4_)
         {
            if(_loc4_.nodeType == 4)
            {
               if(OutyardManager.instance.areaModel.exploreNum >= ConfigInfoManager.instance.getHugeHeadExploreEnterCost())
               {
                  SimpleAlertHelper.instance.data = [__enterAreaHandler,_loc4_];
                  _loc2_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc3_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc5_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc6_ = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.useExplore",ConfigInfoManager.instance.getHugeHeadExploreEnterCost());
                  SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true);
               }
               else
               {
                  showRefreshAlertAlert();
               }
               return;
            }
            if(!_infoView)
            {
               _infoView = ComponentFactory.Instance.creatCustomObject("outyard.scene.OutyardInfoView");
               _shapeSprite4.addChild(_infoView);
            }
            _infoView.info = _loc4_;
         }
         else
         {
            ObjectUtils.disposeObject(_infoView);
            _infoView = null;
         }
      }
      
      private function showRefreshAlertAlert() : void
      {
         var _loc3_:Array = ConfigInfoManager.instance.hugeHeadExploreChargePoint();
         var _loc4_:int = int(_loc3_[0]);
         SimpleAlertHelper.instance.data = [showRefreshAlertAlertBack,_loc4_];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("outyard.OutyardFrame.addExploreTxt",_loc4_,_loc3_[1]);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc1_,_loc2_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showRefreshAlertAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc5_ = 0;
            if(param2)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc5_ < param3)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc4_ = param2 ? 0 : 1;
               OutyardManager.instance.OperateArea(4,0,null,_loc4_);
            }
         }
      }
      
      private function __enterAreaHandler(param1:Boolean, param2:Boolean, param3:LandPoint) : void
      {
         if(param1)
         {
            OutyardManager.instance.areaModel.enterLandId = param3.id;
            OutyardManager.instance.OperateArea(0,param3.id);
            clearViews();
         }
      }
      
      private function __returnClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         clearViews();
      }
      
      private function __activityClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("outyard",4);
      }
      
      private function __mapOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:IconButton = param1.target as IconButton;
         _filter.setGlowFilter(_loc2_);
      }
      
      private function __mapOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:IconButton = param1.target as IconButton;
         _filter.setNormalFilter(_loc2_);
      }
      
      private function __stateInfoHandler(param1:NotificationEvent) : void
      {
         _crystalBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         _outyardBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         if(_loc2_ && _loc2_.stackHeadState == 3)
         {
            _crystalBtn.movie.movie["effect"]["effect_01"].play();
         }
         if(_loc2_ && _loc2_.hugeHeadState == 3)
         {
            _outyardBtn.movie.movie["effect"]["effect_01"].play();
         }
         setTips();
      }
      
      private function checkOpenView() : void
      {
         var battleFieldMsg:HugeHeadNodeBattleFieldMsg;
         var battleSelfMsg:HugeHeadNodeBattleUserMsg;
         var _mapBtn6:Object;
         var timeId:int;
         if(OutyardManager.instance.model.curPos)
         {
            OutyardManager.instance.OperateRoute(2);
            battleFieldMsg = OutyardManager.instance.model.battleNodeMsg;
            battleSelfMsg = OutyardManager.instance.model.battleSelfMsg;
            battleFieldMsg.op = 1;
            battleSelfMsg.op = 1;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_ROUTE_VIEW"));
            return;
         }
         if(OutyardManager.instance.areaModel.enterLandId)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_AREA_VIEW"));
            return;
         }
         if(FrameControllerManager.instance.outyardControler.openOutyardMap6)
         {
            _mapBtn6 = this["_mapBtn6"];
            timeId = int(setTimeout(function():void
            {
               clearTimeout(timeId);
               _mapBtn6.dispatchEvent(new MouseEvent("click"));
               _mapBtn6 = null;
            },500));
            return;
         }
      }
      
      private function clearViews() : void
      {
         if(_shapeSprite3.parent)
         {
            _shapeSprite3.parent.removeChild(_shapeSprite3);
         }
         if(_topView.parent)
         {
            _topView.parent.removeChild(_topView);
         }
         if(_returnBtn.parent)
         {
            _returnBtn.parent.removeChild(_returnBtn);
         }
         if(_crystalBtn.parent)
         {
            _crystalBtn.parent.removeChild(_crystalBtn);
         }
         if(_outyardBtn.parent)
         {
            _outyardBtn.parent.removeChild(_outyardBtn);
         }
         ObjectUtils.disposeObject(_infoView);
         _infoView = null;
         ObjectUtils.disposeObject(_landView);
         _landView = null;
         ObjectUtils.disposeObject(_routeView);
         _routeView = null;
         ObjectUtils.disposeObject(_areaView);
         _areaView = null;
         ObjectUtils.disposeObject(_smallBar);
         _smallBar = null;
         ObjectUtils.disposeObject(_diceView);
         _diceView = null;
      }
      
      private function setTips() : void
      {
         var _loc12_:Number = NaN;
         var _loc11_:Array = null;
         var _loc3_:HugeHeadOpenTimeMsg = null;
         var _loc7_:String = null;
         var _loc10_:String = null;
         var _loc4_:Date = null;
         var _loc8_:Date = null;
         var _loc5_:int = 0;
         var _loc1_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         var _loc9_:String = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.iconOutyard");
         if(_loc1_.hugeHeadState == 0 || _loc1_.hugeHeadState == 5)
         {
            _loc12_ = Number(_loc1_.hugeHeadNextOpenTime[0] ? Int64Utils.int64ToNumber(_loc1_.hugeHeadNextOpenTime[0].startTime) : 0);
            _loc11_ = _loc1_.hugeHeadNextOpenTime;
         }
         else
         {
            _loc12_ = Number(_loc1_.hugeHeadOpenTime[0] ? Int64Utils.int64ToNumber(_loc1_.hugeHeadOpenTime[0].startTime) : 0);
            _loc11_ = _loc1_.hugeHeadOpenTime;
         }
         var _loc2_:Date = new Date(_loc12_);
         var _loc6_:String = DateFormatter.timeFormat3(_loc2_);
         _loc9_ += "\n" + _loc6_ + "\n";
         _loc5_ = 0;
         while(_loc5_ < _loc11_.length)
         {
            _loc3_ = _loc11_[_loc5_] as HugeHeadOpenTimeMsg;
            _loc4_ = new Date(Int64Utils.int64ToNumber(_loc3_.startTime));
            _loc8_ = new Date(Int64Utils.int64ToNumber(_loc3_.endTime));
            _loc7_ = getIntStrAtLength(_loc4_.getHours(),2) + ":" + getIntStrAtLength(_loc4_.getMinutes(),2);
            _loc10_ = getIntStrAtLength(_loc8_.getHours(),2) + ":" + getIntStrAtLength(_loc8_.getMinutes(),2);
            _loc9_ += _loc7_ + " ~ " + _loc10_ + "\n";
            _loc5_++;
         }
         _iconOutyard.tipData = _loc9_;
         _loc9_ = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.iconCrystal");
         if(_loc1_.stackHeadState == 0 || _loc1_.stackHeadState == 5)
         {
            _loc12_ = Number(_loc1_.stackHeadNextOpenTime[0] ? Int64Utils.int64ToNumber(_loc1_.stackHeadNextOpenTime[0].startTime) : 0);
            _loc11_ = _loc1_.stackHeadNextOpenTime;
         }
         else
         {
            _loc12_ = Number(_loc1_.stackHeadOpenTime[0] ? Int64Utils.int64ToNumber(_loc1_.stackHeadOpenTime[0].startTime) : 0);
            _loc11_ = _loc1_.stackHeadOpenTime;
         }
         _loc2_ = new Date(_loc12_);
         _loc6_ = DateFormatter.timeFormat3(_loc2_);
         _loc9_ += "\n" + _loc6_ + "\n";
         _loc5_ = 0;
         while(_loc5_ < _loc11_.length)
         {
            _loc3_ = _loc11_[_loc5_] as HugeHeadOpenTimeMsg;
            _loc4_ = new Date(Int64Utils.int64ToNumber(_loc3_.startTime));
            _loc8_ = new Date(Int64Utils.int64ToNumber(_loc3_.endTime));
            _loc7_ = getIntStrAtLength(_loc4_.getHours(),2) + ":" + getIntStrAtLength(_loc4_.getMinutes(),2);
            _loc10_ = getIntStrAtLength(_loc8_.getHours(),2) + ":" + getIntStrAtLength(_loc8_.getMinutes(),2);
            _loc9_ += _loc7_ + " ~ " + _loc10_ + "\n";
            _loc5_++;
         }
         _iconCrystal.tipData = _loc9_;
      }
      
      public function getIntStrAtLength(param1:uint, param2:uint) : String
      {
         return DateFormatter.getIntStrAtLength(param1,param2);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         x = 0;
         y = 0;
         width = _loc2_;
         height = _loc3_;
         _shapeSprite1.width = MC_WIDTH;
         _shapeSprite1.height = MC_HEIGHT;
         _shapeSprite1.x = (_loc2_ - MC_WIDTH) / 2;
         _shapeSprite1.y = (_loc3_ - MC_HEIGHT) / 2;
         if(_smallBar)
         {
            _smallBar.x = _loc2_ - 200;
            _smallBar.y = 0;
         }
         if(_diceView)
         {
            _diceView.x = (_loc2_ - 300) / 2;
            _diceView.y = (_loc3_ - 800) / 2;
            _diceView.adjustPos(_loc2_,_loc3_);
         }
      }
      
      private function closeFrame(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         if(_areaView)
         {
            SimpleAlertHelper.instance.data = [__leaveAreaHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc8_ = LanguageMgr.GetTranslation("public.prompt");
            _loc9_ = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.leaveArea");
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc2_,_loc3_,true);
            return;
         }
         if(_routeView)
         {
            SimpleAlertHelper.instance.data = [__leaveRouteHandler];
            _loc5_ = LanguageMgr.GetTranslation("public.confirm");
            _loc6_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.leaveRoute");
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc4_,_loc5_,_loc6_,true);
            return;
         }
         dispose();
      }
      
      private function __leaveAreaHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateArea(3);
            clearViews();
            __resizeHanlder(null);
         }
      }
      
      private function __leaveRouteHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateRoute(3);
            clearViews();
            __resizeHanlder(null);
         }
      }
      
      private function __switchScene(param1:Event) : void
      {
         dispose();
      }
      
      private function get MC_WIDTH() : Number
      {
         if(StageReferance.gameStageWidth > 1000)
         {
            return 4200;
         }
         return StageReferance.gameStageWidth + 1400 + 1400;
      }
      
      private function get MC_HEIGHT() : Number
      {
         if(StageReferance.gameStageHeight > 600)
         {
            return 2400;
         }
         return StageReferance.gameStageHeight + 800 + 800;
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,6,true,true);
         KeyBoardRegister.instance.keyEnable = false;
         __resizeHanlder(null);
         hideTool();
      }
      
      public function hideTool() : void
      {
         TopToolsBar.instance.hide();
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         SmallMapBar.instance.hide();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         TimeBoxView.instance.hide();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",true));
      }
      
      public function showToolView() : void
      {
         TopToolsBar.instance.show();
         TaskTraceBar.instance.show();
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            QueueBar.instance.show();
         }
         SmallMapBar.instance.show();
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         MainToolBar.instance.recommendBtnIsExist(null);
         TimeBoxView.instance.show();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",false));
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         FrameControllerManager.instance.outyardControler.isOutyardMapApply = false;
         FrameControllerManager.instance.outyardControler.openOutyardMap6 = false;
         removeEvent();
         showToolView();
         ObjectUtils.disposeObject(_shapeSprite1);
         _shapeSprite1 = null;
         ObjectUtils.disposeObject(_shapeSprite2);
         _shapeSprite2 = null;
         ObjectUtils.disposeObject(_shapeSprite3);
         _shapeSprite3 = null;
         ObjectUtils.disposeObject(_worldBg);
         _worldBg = null;
         ObjectUtils.disposeObject(_borderLayer);
         _borderLayer = null;
         ObjectUtils.disposeObject(_mapFrameBmp);
         _mapFrameBmp = null;
         ObjectUtils.disposeObject(_mapBtn1);
         _mapBtn1 = null;
         ObjectUtils.disposeObject(_mapBtn2);
         _mapBtn2 = null;
         ObjectUtils.disposeObject(_mapBtn3);
         _mapBtn3 = null;
         ObjectUtils.disposeObject(_mapBtn4);
         _mapBtn4 = null;
         ObjectUtils.disposeObject(_mapBtn5);
         _mapBtn5 = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_iconCrystal);
         _iconCrystal = null;
         ObjectUtils.disposeObject(_iconOutyard);
         _iconOutyard = null;
         ObjectUtils.disposeObject(_crystalBtn);
         _crystalBtn = null;
         ObjectUtils.disposeObject(_outyardBtn);
         _outyardBtn = null;
         ObjectUtils.disposeObject(_landView);
         _landView = null;
         ObjectUtils.disposeObject(_infoView);
         _infoView = null;
         ObjectUtils.disposeObject(_routeView);
         _routeView = null;
         ObjectUtils.disposeObject(_areaView);
         _areaView = null;
         ObjectUtils.disposeObject(_smallBar);
         _smallBar = null;
         ObjectUtils.disposeObject(_diceView);
         _diceView = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_shapeSprite4);
         _shapeSprite4 = null;
         ObjectUtils.disposeObject(_mapNoteBmp);
         _mapNoteBmp = null;
         ObjectUtils.disposeObject(_landNode);
         _landNode = null;
         ObjectUtils.disposeObject(_activityBtn);
         _activityBtn = null;
         super.dispose();
      }
   }
}

