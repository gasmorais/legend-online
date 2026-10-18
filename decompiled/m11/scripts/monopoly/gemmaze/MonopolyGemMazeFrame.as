package monopoly.gemmaze
{
   import avmplus.getQualifiedClassName;
   import battle.view.animation.AddSpAnimation;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GemMazeEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import manager.LanguageMgr;
   import managers.MonopolyGemMazeManager;
   import managers.MonopolySocketOutManager;
   import monopoly.gemmaze.view.MonopolyGemMazeView;
   import mvc.module.gemmaze.GemMazeModel;
   import mvc.module.stararea.StarareaManager;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class MonopolyGemMazeFrame extends Frame implements IManualSize
   {
      
      private var _gemMazeView:MonopolyGemMazeView;
      
      private var _gemMazeFrameBg:Bitmap;
      
      private var _countText:FilterFrameText;
      
      private var _buyTimesBtn:IconButton;
      
      private var _buyTimesLeftContent:Sprite;
      
      private var _buyTimesNumBitmapData:BitmapData;
      
      private var _containerView:Sprite;
      
      private var _grainMc:MovieClip;
      
      private var animation:AddSpAnimation;
      
      private var bombPos:Point = new Point(500,175);
      
      public function MonopolyGemMazeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,495,600);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get model() : GemMazeModel
      {
         return MonopolyGemMazeManager.Instance.model;
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.title");
         _gemMazeFrameBg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.monopoly.GemMazeFrame.bg");
         _countText = ComponentFactory.Instance.creatComponentByStylename("monopoly.gameMazeCountTxt");
         _buyTimesBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.BuyTimesButton");
         _buyTimesLeftContent = new Sprite();
         _buyTimesLeftContent.x = 710;
         _buyTimesLeftContent.y = 55;
         _buyTimesLeftContent.mouseChildren = _buyTimesLeftContent.mouseEnabled = false;
         _buyTimesNumBitmapData = ComponentFactory.Instance.creatBitmapData("asset.GameMaze.mpnopoly.GameMazeNum").clone();
         _gemMazeView = ComponentFactory.Instance.creatCustomObject("GemMaze.MonopolyGemMazeView");
         _grainMc = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeViewGrain");
         _buyTimesLeftContent.x = 521;
         _buyTimesLeftContent.y = 447;
         _gemMazeView.x = 57;
         _grainMc.stop();
         _containerView = new Sprite();
         addToContent(_containerView);
         _containerView.addChild(_gemMazeFrameBg);
         _containerView.addChild(_countText);
         _containerView.addChild(_buyTimesBtn);
         _containerView.addChild(_buyTimesLeftContent);
         _containerView.addChild(_gemMazeView);
         MonopolyGemMazeManager.Instance.getInitInfo();
         if(StarareaManager.instance.isStarareaGame)
         {
            _buyTimesBtn.visible = false;
            _buyTimesLeftContent.visible = false;
         }
      }
      
      public function show() : void
      {
         closeButton.visible = false;
         KeyBoardRegister.instance.keyEnable = false;
         __resizeHanlder(null);
         if(StarareaManager.instance.isStarareaGame)
         {
            LayerManager.Instance.addToLayer(this,3,true,true);
         }
         else
         {
            LayerManager.Instance.addToLayer(this,3,true,true);
         }
         updateView();
         hideTool();
      }
      
      public function hideTool() : void
      {
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
         NotificationManager.instance.dispatchEvent(new NotificationEvent(NotificationEvent.HIDE_MOPUPING,false));
      }
      
      public function updateView(param1:GemMazeEvent = null) : void
      {
         NumberViewUtils.printNumber(model.gemMazeInfo.timesLeft,_buyTimesLeftContent,_buyTimesNumBitmapData,"0123456789");
         _buyTimesLeftContent.x = 137 + (85 - _buyTimesLeftContent.width) / 2;
         _countText.text = LanguageMgr.GetTranslation("monopoly.gemmaze.MonopolyGemMazeFrame.countText.text") + model.gemMazeInfo.score + "/" + 300;
      }
      
      private function __onBuyTimesHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(MonopolyGemMazeManager.Instance.model.gemMazeInfo.timesLeft >= 90)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gemMaze.gemMazeFrame.BuTimesTips"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < 50)
         {
            RechargeAlertMannager.show();
            return;
         }
         if(todayNeedAlertForOpenKingContract)
         {
            showBuyTimesTips();
         }
         else
         {
            _loc2_ = 1;
            if(SharedManager.instance.buyGemMazeTimesUseBind)
            {
               _loc2_ = 2;
            }
            MonopolyGemMazeManager.Instance.buyTimes(_loc2_);
         }
      }
      
      private function showBuyTimesTips() : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.buyTimesTips");
         var _loc2_:Boolean = true;
         _loc2_ = todayNeedAlertForOpenKingContract;
         if(_loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc4_.show(_loc3_,_loc1_,__showTipResult,null,"center",2,true);
            return;
         }
      }
      
      private function __showTipResult(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.buyGemMazeTimesAlertDate = new Date();
            SharedManager.instance.saveBuyGemMazeTimesAlertDate();
         }
         SharedManager.instance.buyGemMazeTimesUseBind = param2;
         SharedManager.instance.saveBuyGemMazeTimesUseBind();
         var _loc3_:int = 1;
         if(param2)
         {
            _loc3_ = 2;
         }
         MonopolyGemMazeManager.Instance.buyTimes(_loc3_);
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
      
      private function onPlayerGrain(param1:GemMazeEvent) : void
      {
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
         _buyTimesBtn.addEventListener("click",__onBuyTimesHandler);
         MonopolyGemMazeManager.Instance.addEventListener("GEMMAZE_GET_INIT_INFO",onGetInitInfo);
         NotificationManager.instance.addEventListener(NotificationEvent.CLOSE_GEMMAZEFRAME,closeFrame);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",closeFrame);
         MonopolyGemMazeManager.Instance.addEventListener("GEMMAZE_GEM_UPDATE_FRAME",updateView);
         this.addEventListener("click",onClick);
         MonopolyGemMazeManager.Instance.addEventListener("GEMMAZE_PLAYER_GRAIN",onPlayerGrain);
         MonopolyGemMazeManager.Instance.addEventListener("GEMMAZE_ADD_INTERGAL",onUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         _buyTimesBtn.removeEventListener("click",__onBuyTimesHandler);
         MonopolyGemMazeManager.Instance.removeEventListener("GEMMAZE_GET_INIT_INFO",onGetInitInfo);
         NotificationManager.instance.removeEventListener(NotificationEvent.CLOSE_GEMMAZEFRAME,closeFrame);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",closeFrame);
         MonopolyGemMazeManager.Instance.removeEventListener("GEMMAZE_GEM_UPDATE_FRAME",updateView);
         this.removeEventListener("click",onClick);
         MonopolyGemMazeManager.Instance.removeEventListener("GEMMAZE_PLAYER_GRAIN",onPlayerGrain);
         MonopolyGemMazeManager.Instance.removeEventListener("GEMMAZE_ADD_INTERGAL",onUpdate);
      }
      
      private function onUpdate(param1:GemMazeEvent) : void
      {
         if(model.gemMazeInfo.score >= 300)
         {
            if(StarareaManager.instance.isStarareaGame)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonopolyManager.GameTip02"));
               StarareaManager.instance.sendEvent("GAME_PASS");
            }
            else
            {
               MonopolySocketOutManager.sendTriggerConfirm();
            }
            dispose();
            StarareaManager.instance.isStarareaGame = false;
         }
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
         _containerView.x = -7;
         _containerView.y = -1;
      }
      
      private function onGetInitInfo(param1:GemMazeEvent) : void
      {
         updateView();
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
      
      override public function dispose() : void
      {
         if(animation)
         {
            animation.dispose();
         }
         animation = null;
         MonopolyGemMazeManager.Instance.claerData();
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(!StarareaManager.instance.isStarareaGame)
         {
            showToolView();
         }
         ObjectUtils.disposeObject(_gemMazeView);
         _gemMazeView = null;
         ObjectUtils.disposeObject(_gemMazeFrameBg);
         _gemMazeFrameBg = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_buyTimesBtn);
         _buyTimesBtn = null;
         ObjectUtils.disposeAllChildren(_buyTimesLeftContent);
         _buyTimesLeftContent = null;
         ObjectUtils.disposeObject(_buyTimesNumBitmapData);
         _buyTimesNumBitmapData = null;
         ObjectUtils.disposeObject(_containerView);
         _containerView = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         MonopolyGemMazeManager.Instance.model.updateAllUpdateData();
      }
   }
}

