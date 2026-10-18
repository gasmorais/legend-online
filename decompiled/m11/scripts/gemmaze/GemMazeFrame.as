package gemmaze
{
   import avmplus.getQualifiedClassName;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GemMazeEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gemmaze.view.GemMazeBagView;
   import gemmaze.view.GemMazeBoxView;
   import gemmaze.view.GemMazeSortFrame;
   import gemmaze.view.GemMazeView;
   import mainBar.SmallMapBar;
   import mainBar.StripView;
   import mainBar.TimeBoxView;
   import manager.LanguageMgr;
   import map.space.SpaceManager;
   import mvc.controler.GemMazeControler;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.gemmaze.GemMazeModel;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GemMazeManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class GemMazeFrame extends Frame
   {
      
      private var _helpBtn:BaseButton;
      
      private var _gemMazeBagView:GemMazeBagView;
      
      private var _gemMazeBoxView:GemMazeBoxView;
      
      private var _gemMazeView:GemMazeView;
      
      private var _gemMazeFrameBg:Bitmap;
      
      private var _levelTxtMc:MovieClip;
      
      private var _levelNumBitmapData:BitmapData;
      
      private var _stripView:StripView;
      
      private var _gemLevelMc:MovieClip;
      
      private var _gemExpTxt:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _sortLinkTxt:FilterFrameText;
      
      private var _buyTimesBtn:IconButton;
      
      private var _buyTimesLeftContent:Sprite;
      
      private var _buyTimesNumBitmapData:BitmapData;
      
      private var _integralLabel:Bitmap;
      
      private var _luckStarBtn:IconButton;
      
      private var _titleBitmap:Bitmap;
      
      private var frameIndex:int;
      
      private var _sprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _contorller:GemMazeControler;
      
      private var _containerView:Sprite;
      
      private var _grainMc:MovieClip;
      
      private var _numText1:FilterFrameText;
      
      private var _numText2:FilterFrameText;
      
      private var _numText3:FilterFrameText;
      
      private var _numText4:FilterFrameText;
      
      private var _numText5:FilterFrameText;
      
      private var _blackGound:Sprite;
      
      private var bombPos:Point = new Point(190,440);
      
      private var refuseInvite:Boolean;
      
      private var refuseTeamInvite:Boolean;
      
      public function GemMazeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get model() : GemMazeModel
      {
         return GemMazeManager.Instance.model;
      }
      
      private function initView() : void
      {
         _contorller = FrameControllerManager.instance.gemMazeController;
         _titleText = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.title");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("GemMaze.BottleHelpBtn");
         _gemMazeFrameBg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.GemMazeFrame.bg");
         _levelTxtMc = ComponentFactory.Instance.creatCustomObject("GemMaze.LevelTxtMc");
         _levelNumBitmapData = ComponentFactory.Instance.creatBitmapData("asset.GemMaze.LevelNum").clone();
         _integralLabel = ComponentFactory.Instance.creatBitmap("asset.GemMaze.GemMazeFrame.IntegralLabel");
         _stripView = ComponentFactory.Instance.creatCustomObject("gemMaze.levelView");
         _gemLevelMc = ComponentFactory.Instance.creatCustomObject("gemMaze.GemLevelMc");
         _gemExpTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.gemExpTxt");
         _countText = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.countText");
         _sortLinkTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.SortLinkTxt");
         _sortLinkTxt.htmlText = "<a href =\'event: \'><u>" + LanguageMgr.GetTranslation("gemMaze.GemMazeSort.Titls") + "</u></a>";
         _sortLinkTxt.mouseEnabled = true;
         _levelTxtMc.gotoAndStop(1);
         _buyTimesBtn = ComponentFactory.Instance.creatComponentByStylename("gemMaze.BuyTimesButton");
         _buyTimesLeftContent = new Sprite();
         _buyTimesLeftContent.x = 692;
         _buyTimesLeftContent.y = 425;
         _buyTimesLeftContent.mouseChildren = _buyTimesLeftContent.mouseEnabled = false;
         _buyTimesNumBitmapData = ComponentFactory.Instance.creatBitmapData("asset.GemMaze.LevelNum").clone();
         _luckStarBtn = ComponentFactory.Instance.creatComponentByStylename("gemMaze.LuckStarButton");
         _titleBitmap = ComponentFactory.Instance.creatBitmap("asset.GemMaze.GemMazeFrameTitle");
         _gemMazeBagView = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeBagView");
         _gemMazeBoxView = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeBoxView");
         _gemMazeView = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeView");
         _bg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.bg");
         _grainMc = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeViewGrain");
         _numText1 = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.numText1");
         _numText2 = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.numText2");
         _numText3 = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.numText3");
         _numText4 = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.numText4");
         _numText5 = ComponentFactory.Instance.creatComponentByStylename("gemMaze.GemMazeFrame.numText5");
         _grainMc.stop();
         _sprite = new Sprite();
         _containerView = new Sprite();
         _blackGound = new Sprite();
         addToContent(_blackGound);
         addToContent(_sprite);
         addToContent(_containerView);
         _sprite.addChild(_bg);
         _containerView.addChild(_gemMazeFrameBg);
         _containerView.addChild(_helpBtn);
         _gemLevelMc["halo"].visible = false;
         _gemLevelMc.gotoAndStop(1);
         _containerView.addChild(_buyTimesBtn);
         _containerView.addChild(_buyTimesLeftContent);
         _containerView.addChild(_luckStarBtn);
         _containerView.addChild(_gemMazeBoxView);
         _containerView.addChild(_gemMazeView);
         _containerView.addChild(_titleBitmap);
         _containerView.addChild(_numText1);
         _containerView.addChild(_numText2);
         _containerView.addChild(_numText3);
         _containerView.addChild(_numText4);
         _containerView.addChild(_numText5);
         _containerView.x = (_bg.width - 930) / 2;
         _containerView.y = (_bg.height - 510) / 2;
         _helpBtn.tipData = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.helpTips");
         GemMazeManager.Instance.getInitInfo();
         _contorller.isEnterGemMaze = true;
      }
      
      override public function get groups() : Array
      {
         return ["FULL_SCREEN_FRAME","BAG_GROUP"];
      }
      
      public function show() : void
      {
         var _loc1_:* = undefined;
         try
         {
            _loc1_ = SpaceManager.instance.controller.getArmyView(SpaceManager.instance.model.selfArmy as BaseArmy);
            _loc1_.stopWalkByOut();
         }
         catch(e:Error)
         {
         }
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,6,true,true);
         __resizeHanlder(null);
         hideTool();
         updateView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1500,900);
      }
      
      public function hideTool() : void
      {
         TopToolsBar.instance.hide();
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         SmallMapBar.instance.hide();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         TimeBoxView.instance.hide();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",true));
         NotificationManager.instance.dispatchEvent(new NotificationEvent(NotificationEvent.HIDE_MOPUPING,true));
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
         NotificationManager.instance.dispatchEvent(new NotificationEvent(NotificationEvent.HIDE_MOPUPING,false));
      }
      
      private function __openHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("gemMaze.gemMazeHelpFrame");
         _loc2_.show();
      }
      
      public function updateView(param1:GemMazeEvent = null) : void
      {
         NumberViewUtils.refreshValue(model.gemMazeInfo.gemLevel,_levelTxtMc["content"],_levelNumBitmapData,16,20,15,16,"0123456789");
         NumberViewUtils.refreshValue(model.gemMazeInfo.timesLeft,_buyTimesLeftContent,_buyTimesNumBitmapData,16,20,15,16,"0123456789");
         _buyTimesLeftContent.x = 692;
         if(model.gemMazeInfo.timesLeft >= 10)
         {
            _buyTimesLeftContent.x = 684;
         }
         _gemExpTxt.text = model.gemMazeInfo.curExp + "/" + model.gemMazeInfo.maxExp;
         _countText.text = model.gemMazeInfo.score.toString();
         _numText1.text = "" + model.scoreArr[0];
         _numText2.text = "" + model.scoreArr[1];
         _numText3.text = "" + model.scoreArr[2];
         _numText4.text = "" + model.scoreArr[3];
         _numText5.text = "" + model.scoreArr[4];
         frameIndex = Math.max(1,Math.min(100,int(model.gemMazeInfo.curExp * 100 / model.gemMazeInfo.maxExp)));
         _gemLevelMc.gotoAndStop(frameIndex);
         if(model.gemMazeInfo.curExp != 0)
         {
            _gemLevelMc["halo"].visible = true;
         }
         if(model.gemMazeInfo.gemLevel >= 40)
         {
            _gemExpTxt.text = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.LvMax");
            _gemLevelMc.gotoAndStop(100);
            _gemLevelMc["halo"].visible = false;
         }
         bombPos.y = 440 + _gemMazeBoxView.maskTopPos;
         _gemMazeBoxView.updateView();
      }
      
      private function __onInvideHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.gemMazeController.openInvideFrame();
      }
      
      private function __onBuyTimesHandler(param1:MouseEvent) : void
      {
         if(GemMazeManager.Instance.model.gemMazeInfo.timesLeft >= 90)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gemMaze.gemMazeFrame.BuTimesTips"));
            return;
         }
         var _loc3_:String = TempleteManager.instance.getConfigInfoByConfigName("Gem_Maze_BuyInfo").ConfigValue;
         var _loc4_:int = 10;
         var _loc2_:int = 50;
         if(_loc3_ && _loc3_.length > 0)
         {
            try
            {
               _loc4_ = parseInt(_loc3_.split(",")[0]);
               _loc2_ = parseInt(_loc3_.split(",")[1]);
            }
            catch(e:Error)
            {
            }
         }
         if(GemMazeManager.Instance.model.gemMazeInfo.buyTimesLeft < _loc4_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gemMaze.gemMazeFrame.BuyTimesFullTips"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         showBuyTimesTips(_loc4_,_loc2_);
      }
      
      private function showBuyTimesTips(param1:int, param2:int) : void
      {
         var _loc5_:TodayNotAlertFrame = null;
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.buyTimesTips",param2,param1,model.gemMazeInfo.buyTimesLeft);
         _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
         _loc5_.checkStyle = "";
         _loc5_.usebindPointStyle = "worldBoss.gemBuyTimesBtn";
         _loc5_.show(_loc4_,_loc3_,__showTipResult,null,"center",2,true);
      }
      
      private function __showTipResult(param1:Boolean, param2:Boolean) : void
      {
         SharedManager.instance.buyGemMazeTimesUseBind = param2;
         SharedManager.instance.saveBuyGemMazeTimesUseBind();
         var _loc3_:int = 1;
         if(param2)
         {
            _loc3_ = 2;
         }
         GemMazeManager.Instance.buyTimes(_loc3_);
      }
      
      private function get todayNeedAlertForOpenKingContract() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.buyGemMazeTimesAlertDate;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function __GemMazeSortHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.gemMazeController.loadGemMazeOrderData();
      }
      
      private function onPlayerGrain(param1:GemMazeEvent) : void
      {
         createBombEffect();
      }
      
      private function createBombEffect() : void
      {
         if(!_containerView)
         {
            return;
         }
         if(!_containerView.parent)
         {
            return;
         }
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.GemMaze.SmallBomB");
         var _loc2_:SimpleMovie = new SimpleMovie(_loc1_);
         _loc2_.x = bombPos.x;
         _loc2_.y = bombPos.y;
         _containerView.addChild(_loc2_);
      }
      
      private function onGrainPlayerComplete(param1:Event) : void
      {
         _grainMc.removeEventListener("GrainPlayerComplete",onGrainPlayerComplete);
         if(_grainMc.parent == null)
         {
            _containerView.removeChild(_grainMc);
         }
         _grainMc.stop();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         _helpBtn.addEventListener("click",__openHelpHandler);
         _luckStarBtn.addEventListener("click",__onInvideHandler);
         _buyTimesBtn.addEventListener("click",__onBuyTimesHandler);
         _sortLinkTxt.addEventListener("click",__GemMazeSortHandler);
         GemMazeManager.Instance.addEventListener("GEMMAZE_GET_INIT_INFO",onGetInitInfo);
         NotificationManager.instance.addEventListener(NotificationEvent.CLOSE_GEMMAZEFRAME,closeFrame);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",closeFrame);
         GemMazeManager.Instance.addEventListener("GEMMAZE_GEM_UPDATE_FRAME",updateView);
         model.addEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         this.addEventListener("click",onClick);
         GemMazeManager.Instance.addEventListener("GEMMAZE_PLAYER_GRAIN",onPlayerGrain);
         NotificationManager.instance.addEventListener(NotificationEvent.ARMYFRAMEII_OPEN_FOR_GEMMAZE,onBagOpen);
         NotificationManager.instance.addEventListener(NotificationEvent.ARMYFRAMEII_CLOSE_FOR_GEMMAZE,onBagClose);
         sendRefuseInvite();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         _helpBtn.removeEventListener("click",__openHelpHandler);
         _luckStarBtn.removeEventListener("click",__onInvideHandler);
         _buyTimesBtn.removeEventListener("click",__onBuyTimesHandler);
         _sortLinkTxt.removeEventListener("click",__GemMazeSortHandler);
         GemMazeManager.Instance.removeEventListener("GEMMAZE_GET_INIT_INFO",onGetInitInfo);
         NotificationManager.instance.removeEventListener(NotificationEvent.CLOSE_GEMMAZEFRAME,closeFrame);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",closeFrame);
         GemMazeManager.Instance.removeEventListener("GEMMAZE_GEM_UPDATE_FRAME",updateView);
         model.removeEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         this.removeEventListener("click",onClick);
         GemMazeManager.Instance.removeEventListener("GEMMAZE_PLAYER_GRAIN",onPlayerGrain);
         NotificationManager.instance.removeEventListener(NotificationEvent.ARMYFRAMEII_OPEN_FOR_GEMMAZE,onBagOpen);
         NotificationManager.instance.removeEventListener(NotificationEvent.ARMYFRAMEII_CLOSE_FOR_GEMMAZE,onBagClose);
         removeRefuseInvite();
      }
      
      private function onBagOpen(param1:NotificationEvent) : void
      {
         this._gemMazeBagView.visible = false;
      }
      
      private function onBagClose(param1:NotificationEvent) : void
      {
         this._gemMazeBagView.visible = true;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:String = getQualifiedClassName(param1.target.parent);
         if(_loc2_.indexOf("GemAction") == -1)
         {
            _gemMazeView.removeSelected();
         }
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         x = (StageReferance.stageWidth - _bg.width) * 0.5;
         y = (StageReferance.stageHeight - _bg.height) * 0.5;
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,1);
         _blackGound.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
         _blackGound.graphics.endFill();
      }
      
      private function onGetInitInfo(param1:GemMazeEvent) : void
      {
         updateView();
         bombPos.y = 440 + _gemMazeBoxView.maskTopPos;
         _gemMazeBoxView.updateView();
      }
      
      private function closeFrame(param1:Event) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function __orderDataLoadCompleteHandler(param1:GemMazeEvent) : void
      {
         var _loc2_:GemMazeSortFrame = ComponentFactory.Instance.creatComponentByStylename("gemmaze.GemMazeSortFrame");
         _loc2_.show();
      }
      
      private function callBackResponse(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         GemMazeManager.Instance.claerData();
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _contorller.isEnterGemMaze = false;
         showToolView();
         _contorller = null;
         ObjectUtils.disposeObject(_gemMazeBagView);
         _gemMazeBagView = null;
         ObjectUtils.disposeObject(_gemMazeBoxView);
         _gemMazeBoxView = null;
         ObjectUtils.disposeObject(_gemMazeView);
         _gemMazeView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_levelTxtMc);
         _levelTxtMc = null;
         ObjectUtils.disposeObject(_gemLevelMc);
         _gemLevelMc = null;
         ObjectUtils.disposeObject(_gemMazeFrameBg);
         _gemMazeFrameBg = null;
         ObjectUtils.disposeObject(_levelNumBitmapData);
         _levelNumBitmapData = null;
         ObjectUtils.disposeObject(_integralLabel);
         _integralLabel = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_gemExpTxt);
         _gemExpTxt = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_sortLinkTxt);
         _sortLinkTxt = null;
         ObjectUtils.disposeObject(_buyTimesBtn);
         _buyTimesBtn = null;
         ObjectUtils.disposeObject(_buyTimesLeftContent);
         _buyTimesLeftContent = null;
         ObjectUtils.disposeObject(_buyTimesNumBitmapData);
         _buyTimesNumBitmapData = null;
         ObjectUtils.disposeObject(_luckStarBtn);
         _luckStarBtn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_containerView);
         _containerView = null;
         ObjectUtils.disposeObject(_titleBitmap);
         _titleBitmap = null;
         ObjectUtils.disposeObject(_numText1);
         _numText1 = null;
         ObjectUtils.disposeObject(_numText2);
         _numText2 = null;
         ObjectUtils.disposeObject(_numText3);
         _numText3 = null;
         ObjectUtils.disposeObject(_numText4);
         _numText4 = null;
         ObjectUtils.disposeObject(_numText5);
         _numText5 = null;
         ObjectUtils.disposeObject(_grainMc);
         _grainMc = null;
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         GemMazeManager.Instance.model.updateAllUpdateData();
      }
      
      private function sendRefuseInvite() : void
      {
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
            refuseInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite;
         }
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
            refuseTeamInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite;
         }
      }
      
      private function removeRefuseInvite() : void
      {
         if(!refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      override public function dispose() : void
      {
         SimpleAlertHelper.instance.data = [callBackResponse];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("gemMaze.gemMazeFrame.ExitTips");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,false,true);
      }
   }
}

