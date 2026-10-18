package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import crisis.ui.PlaneCrisisRewardTipView;
   import events.GameHallEvent;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.gamehall.GameHallModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GameHallActiveRightView extends Sprite
   {
      
      private var _bg:Image;
      
      private var _showImg:ScaleFrameImage;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _helpBtn:TextButton;
      
      private var _dayTxt:FilterFrameText;
      
      private var _dayImg:Image;
      
      private var _dayContainer:Component;
      
      private var _dayBitmapData:BitmapData;
      
      private var _infoTxt:FilterFrameText;
      
      private var _rewardTitleBg:Image;
      
      private var _rewardTitleImg:Image;
      
      private var _rewardMagnifierImg:Image;
      
      private var _rewardShowAllTxt:FilterFrameText;
      
      private var _rewardView:GameHallActiveRewardView;
      
      private var _teamBtn:IconButton;
      
      private var _rewardCountTxt:FilterFrameText;
      
      private var _rankTxt:FilterFrameText;
      
      private var _planeCrisisRewardTipView:PlaneCrisisRewardTipView;
      
      private var _gameHallRegwardTipView:GameHallRewardTipView;
      
      private var _callBack:Function;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      public function GameHallActiveRightView(param1:Function = null)
      {
         _callBack = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.bg");
         _showImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.showImg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.titleImg");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.helpBtn");
         _dayTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.dayTxt");
         _dayImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.dayImg");
         _dayContainer = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.dayContainer");
         _dayBitmapData = ComponentFactory.Instance.creatBitmapData("asset.gamehall.dayNumberImg");
         _infoTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.infoTxt");
         _rewardTitleBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.rewardTitleBg");
         _rewardTitleImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.rewardTitleImg");
         _rewardMagnifierImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.rewardMagnifierImg");
         _rewardShowAllTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.rewardShowAllTxt");
         _rewardView = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveRightView.rewardView");
         _teamBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.teamBtn");
         _rewardCountTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.rewardCountTxt");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRightView.rankTxt");
         _rewardShowAllTxt.mouseEnabled = true;
         _rankTxt.mouseEnabled = true;
         _showImg.setFrame(1);
         _titleImg.setFrame(1);
         _helpBtn.text = LanguageMgr.GetTranslation("gamehall.GameHallActiveRightView.helpBtnTxt");
         _dayTxt.text = "";
         _infoTxt.text = "";
         _rewardShowAllTxt.htmlText = LanguageMgr.GetTranslation("gamehall.GameHallActiveRightView.rewardShowAllTxt");
         _rewardCountTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallActiveRightView.rewardCountTxt");
         _rankTxt.htmlText = LanguageMgr.GetTranslation("gamehall.GameHallActiveRightView.rankTxt");
         addChild(_bg);
         addChild(_showImg);
         addChild(_titleImg);
         addChild(_helpBtn);
         addChild(_dayTxt);
         addChild(_dayContainer);
         addChild(_infoTxt);
         addChild(_rewardTitleBg);
         addChild(_rewardTitleImg);
         addChild(_rewardMagnifierImg);
         addChild(_rewardShowAllTxt);
         addChild(_rewardView);
         addChild(_teamBtn);
         addChild(_rewardCountTxt);
         addChild(_rankTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_dayContainer);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_showImg);
         _showImg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_dayTxt);
         _dayTxt = null;
         ObjectUtils.disposeObject(_dayImg);
         _dayImg = null;
         ObjectUtils.disposeObject(_dayContainer);
         _dayContainer = null;
         ObjectUtils.disposeObject(_dayBitmapData);
         _dayBitmapData = null;
         ObjectUtils.disposeObject(_infoTxt);
         _infoTxt = null;
         ObjectUtils.disposeObject(_rewardTitleBg);
         _rewardTitleBg = null;
         ObjectUtils.disposeObject(_rewardTitleImg);
         _rewardTitleImg = null;
         ObjectUtils.disposeObject(_rewardMagnifierImg);
         _rewardMagnifierImg = null;
         ObjectUtils.disposeObject(_rewardShowAllTxt);
         _rewardShowAllTxt = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeObject(_teamBtn);
         _teamBtn = null;
         ObjectUtils.disposeObject(_rewardCountTxt);
         _rewardCountTxt = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_planeCrisisRewardTipView);
         _planeCrisisRewardTipView = null;
         ObjectUtils.disposeObject(_gameHallRegwardTipView);
         _gameHallRegwardTipView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _callBack = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _teamBtn.addEventListener("click",__teamBtnClickHandler);
         _rewardShowAllTxt.addEventListener("link",__rewardShowAllTxtClickHandler);
         _rankTxt.addEventListener("link",__rankTxtClickHandler);
         _model.addEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__updateExpHandler);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         _teamBtn.removeEventListener("click",__teamBtnClickHandler);
         _rewardShowAllTxt.removeEventListener("link",__rewardShowAllTxtClickHandler);
         _rankTxt.removeEventListener("link",__rankTxtClickHandler);
         _model.removeEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__updateExpHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         if(_model.selectedGameId == 1)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("gamehall.HelpFrame1");
         }
         else if(_model.selectedGameId == 2)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("gamehall.HelpFrame2");
         }
         else if(_model.selectedGameId == 3)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("gamehall.HelpFrame3");
         }
         if(_loc2_)
         {
            _loc2_.show();
         }
      }
      
      private function __teamBtnClickHandler(param1:MouseEvent) : void
      {
         _model.openEastView = false;
         if(_callBack != null)
         {
            _callBack();
         }
      }
      
      private function __rewardShowAllTxtClickHandler(param1:TextEvent) : void
      {
         if(_model.selectedGameId == 2)
         {
            openGameHallReward(param1);
         }
         else if(_model.selectedGameId == 3)
         {
            openPlaneCrisisReward(param1);
         }
      }
      
      private function __rankTxtClickHandler(param1:TextEvent) : void
      {
         if(_model.selectedGameId == 1)
         {
            openRapidRank();
         }
      }
      
      private function __gameInfoUpdateHandler(param1:GameHallEvent) : void
      {
         refresh();
      }
      
      private function __updateExpHandler(param1:NotificationEvent) : void
      {
         refresh();
      }
      
      private function refresh() : void
      {
         _showImg.setFrame(_model.selectedGameId);
         _titleImg.setFrame(_model.selectedGameId);
         _rewardMagnifierImg.visible = showRewardMore;
         _rewardShowAllTxt.visible = showRewardMore;
         _rankTxt.visible = showRank;
         var _loc4_:GameHallGameInfo = new GameHallGameInfo();
         _loc4_.gameId = _model.selectedGameId;
         var _loc5_:int = int(_loc4_.templateInfo.Count);
         var _loc6_:int = _loc5_ - _model.fixedGroupRewardCount;
         var _loc2_:Array = _loc4_.templateInfo.OpenDays.split(",");
         var _loc3_:String = _loc2_.join("");
         var _loc1_:int = int(_loc2_.length);
         NumberViewUtils.printNumber(int(_loc3_),_dayContainer,_dayBitmapData,"1234567",0);
         _rewardView.refreshView(_loc4_);
         _dayContainer.x = 423 + (308 - _loc1_ * 43) / 2;
         _infoTxt.text = _loc4_.templateInfo.Recommend;
         if(GameHallManager.instance.isOpenToday(_model.selectedGameId))
         {
            _teamBtn.enable = true;
            _rewardCountTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallActiveRightView.rewardCountTxt",_loc6_,_loc5_);
         }
         else
         {
            _teamBtn.enable = false;
            _rewardCountTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallActiveRightView.rewardCountTxt","-","-");
         }
         if(_loc4_.templateInfo.Group == 1)
         {
            _dayTxt.visible = false;
         }
         else
         {
            _dayTxt.visible = true;
         }
      }
      
      private function get showRewardMore() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_model.selectedGameId == 2)
         {
            _loc1_ = true;
         }
         else if(_model.selectedGameId == 3)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function get showRank() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_model.selectedGameId == 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function openGameHallReward(param1:TextEvent) : void
      {
         if(_gameHallRegwardTipView && !_gameHallRegwardTipView.isDie)
         {
            ObjectUtils.disposeObject(_gameHallRegwardTipView);
            _gameHallRegwardTipView = null;
            return;
         }
         _gameHallRegwardTipView = new GameHallRewardTipView();
         var _loc2_:Point = new Point();
         _loc2_ = _rewardShowAllTxt.localToGlobal(_loc2_);
         _gameHallRegwardTipView.x = _loc2_.x + _rewardShowAllTxt.width + 15;
         _gameHallRegwardTipView.y = _loc2_.y - _gameHallRegwardTipView.displayHeight * 0.5;
         if(_gameHallRegwardTipView.y < 0)
         {
            _gameHallRegwardTipView.y = 20;
         }
         _gameHallRegwardTipView.show();
         param1.stopPropagation();
      }
      
      private function openPlaneCrisisReward(param1:TextEvent) : void
      {
         if(_planeCrisisRewardTipView && !_planeCrisisRewardTipView.isDie)
         {
            ObjectUtils.disposeObject(_planeCrisisRewardTipView);
            _planeCrisisRewardTipView = null;
            return;
         }
         _planeCrisisRewardTipView = new PlaneCrisisRewardTipView();
         var _loc2_:Point = new Point();
         _loc2_ = _rewardShowAllTxt.localToGlobal(_loc2_);
         _planeCrisisRewardTipView.x = _loc2_.x + _rewardShowAllTxt.width + 15;
         _planeCrisisRewardTipView.y = _loc2_.y - _planeCrisisRewardTipView.displayHeight * 0.5;
         if(_planeCrisisRewardTipView.y < 0)
         {
            _planeCrisisRewardTipView.y = 20;
         }
         if(_planeCrisisRewardTipView.x + _planeCrisisRewardTipView.displayWidth > stage.stageWidth)
         {
            _planeCrisisRewardTipView.x = stage.stageWidth - _planeCrisisRewardTipView.displayWidth;
         }
         _planeCrisisRewardTipView.show();
         param1.stopPropagation();
      }
      
      private function openRapidRank() : void
      {
         if(ArmyManager.instance.thane.grades < 36)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DialogOptionItem.gloryroad.grade.text",36));
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("rapidthrough",1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

