package sevenyear.view.battleflag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import events.SevenYearEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GloryGameManager;
   import managers.SevenYearManager;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.gloryGame.GloryGameModel;
   import mvc.module.gloryGame.GloryGameScheduleInfo;
   import mvc.module.gloryGame.event.GloryGameEvent;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.event.StarareaEvent;
   import sevenyear.view.gloryGame.SevenYearGloryGameDailyItem;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   
   public class SevenYearGameView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _gameTime:FilterFrameText;
      
      private var _gameIconBtn:IconButton;
      
      private var _gameTxt:FilterFrameText;
      
      private var _gameBtn:TextButton;
      
      private var _gameIconTxt:FilterFrameText;
      
      private var _honorWarIconTxt:FilterFrameText;
      
      private var _honorWarTime:FilterFrameText;
      
      private var _honorWarBtn:TextButton;
      
      private var _groupLookBtn:TextButton;
      
      private var _tipIcon:Image;
      
      private var gloryGameFlag:int = 0;
      
      private var gloryDailyContainer:Sprite;
      
      private var _scrollPanel:ScrollPanel;
      
      private var nextGloryGameDate:Date;
      
      public function SevenYearGameView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.bg");
         _gameTime = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.gameTime");
         _gameIconBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.gameIconBtn");
         _gameTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.gameTxt");
         _gameBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.gameBtn");
         _gameIconTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.gameIconTxt");
         _honorWarIconTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.honorWarIconTxt");
         _honorWarTime = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.honorWarTime");
         _honorWarBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.honorWarBtn");
         _groupLookBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearGameView.GroupLookBtn");
         _tipIcon = ComponentFactory.Instance.creatComponentByStylename("SevenYear.icontip");
         _tipIcon.x = 70;
         _tipIcon.y = 110;
         addChild(_bg);
         addChild(_gameTime);
         addChild(_gameIconBtn);
         addChild(_gameTxt);
         addChild(_gameBtn);
         addChild(_gameIconTxt);
         addChild(_honorWarIconTxt);
         addChild(_honorWarTime);
         addChild(_honorWarBtn);
         addChild(_groupLookBtn);
         addChild(_tipIcon);
         _tipIcon.tipData = LanguageMgr.GetTranslation("SevenYearGradeView.icon.tip");
         _gameTxt.text = LanguageMgr.GetTranslation("SevenYearGameView.gameTxt.text");
         _gameBtn.text = LanguageMgr.GetTranslation("SevenYearGameView.gameBtn.text");
         _honorWarIconTxt.text = LanguageMgr.GetTranslation("SevenYearGameView.honorWarIconTxt.text");
         _honorWarBtn.text = LanguageMgr.GetTranslation("SevenYearGameView.honorWarBtn.text");
         _groupLookBtn.text = LanguageMgr.GetTranslation("SevenYearGameView.groupLookBtn.text");
         _gameIconTxt.text = ConfigInfoManager.instance.getSevenYearGameScore().toString();
         gloryDailyContainer = new Sprite();
         addChild(gloryDailyContainer);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("sevenyear.gloryGame.daily.ScrollPanel");
         __updateUserInfoHandler();
         DisplayUtils.handleDisplay(false,_scrollPanel,_honorWarIconTxt,_honorWarTime,_honorWarBtn,_groupLookBtn);
         GloryGameManager.instance.sendOpenView();
         GloryGameManager.instance.sendOpenBet();
      }
      
      private function initEvent() : void
      {
         _gameBtn.addEventListener("click",__gameBtnClickHandler);
         _gameIconBtn.addEventListener("click",__gameIconBtnClickHandler);
         _honorWarBtn.addEventListener("click",__honorWarBtnClickHandler);
         _groupLookBtn.addEventListener("click",__groupLookBtnClickHandler);
         StarareaManager.instance.addEventListener("GAME_PASS",miniGamePass);
         SevenYearManager.instance.model.addEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
         GloryGameManager.instance.addEventListener("VIEW_OPENED",onGetGloryGameData);
         GloryGameManager.instance.addEventListener("SCHEDULE_INFO_UPDATE",onGetGloryGameData);
         TimerUtils.addSecendTimer("SevenYearGameView",1,2147483647,tick);
      }
      
      private function removeEvent() : void
      {
         if(_gameBtn)
         {
            _gameBtn.removeEventListener("click",__gameBtnClickHandler);
         }
         if(_gameIconBtn)
         {
            _gameIconBtn.removeEventListener("click",__gameIconBtnClickHandler);
         }
         if(_honorWarBtn)
         {
            _honorWarBtn.removeEventListener("click",__honorWarBtnClickHandler);
         }
         if(_groupLookBtn)
         {
            _groupLookBtn.removeEventListener("click",__groupLookBtnClickHandler);
         }
         StarareaManager.instance.removeEventListener("GAME_PASS",miniGamePass);
         SevenYearManager.instance.model.removeEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
         GloryGameManager.instance.removeEventListener("VIEW_OPENED",onGetGloryGameData);
         GloryGameManager.instance.removeEventListener("SCHEDULE_INFO_UPDATE",onGetGloryGameData);
         TimerUtils.removeSecendTimer("SevenYearGameView");
      }
      
      private function __updateUserInfoHandler(param1:SevenYearEvent = null) : void
      {
         if(SevenYearManager.instance.model.isGamePassed && SevenYearManager.instance.model.gameCount == 0)
         {
            _gameBtn.enable = true;
         }
         else if(SevenYearManager.instance.model.gameCount == 1)
         {
            _gameBtn.enable = false;
            _gameBtn.text = LanguageMgr.GetTranslation("SevenYearGameView.gameBtn.text2");
         }
         else
         {
            _gameBtn.enable = false;
         }
      }
      
      private function onGetGloryGameData(param1:GloryGameEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:SevenYearGloryGameDailyItem = null;
         var _loc6_:GloryGameScheduleInfo = null;
         var _loc5_:int = 0;
         gloryGameFlag = gloryGameFlag + 1;
         if(gloryGameFlag == 2)
         {
            _loc2_ = int(GloryGameManager.instance.model.currentRound);
            if(model.currentState >= 5)
            {
               _loc2_++;
            }
            nextGloryGameDate = GloryGameManager.instance.getBattleTimeByRoundAndGroup(_loc2_);
            DisplayUtils.handleDisplay(false,_honorWarTime);
            _loc4_ = GloryGameManager.instance.getSchedulesByRound(_loc2_);
            while(gloryDailyContainer.numChildren > 0)
            {
               (gloryDailyContainer.getChildAt(0) as SevenYearGloryGameDailyItem).dispose();
            }
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_];
               _loc3_ = new SevenYearGloryGameDailyItem(_loc6_);
               gloryDailyContainer.addChild(_loc3_);
               _loc3_.y = _loc5_ * 60;
               _loc5_++;
            }
            _scrollPanel.beginChanges();
            _scrollPanel.setView(gloryDailyContainer);
            _scrollPanel.invalidateViewport();
            addChild(_scrollPanel);
            tick();
         }
         else if(gloryGameFlag == 1)
         {
            DisplayUtils.handleDisplay(true,_honorWarTime);
            if(GloryGameManager.instance.model.currentState <= 1)
            {
               _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str1");
            }
            else if(GloryGameManager.instance.model.currentState == 3 || GloryGameManager.instance.model.currentState == 4)
            {
               _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str2");
            }
            else if(GloryGameManager.instance.model.currentState == 5)
            {
               _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str3");
            }
         }
         if(!GloryGameManager.instance.model.isOpen)
         {
            TimerUtils.removeSecendTimer("SevenYearGameView");
            DisplayUtils.handleDisplay(false,_scrollPanel,_honorWarIconTxt,_honorWarTime,_honorWarBtn,_groupLookBtn);
            DisplayUtils.handleDisplay(true,_honorWarTime);
            _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str9");
         }
      }
      
      private function tick() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(nextGloryGameDate)
         {
            _loc1_ = int(GloryGameManager.instance.model.currentRound);
            _loc2_ = int(GloryGameManager.instance.model.currentState);
            if(nextGloryGameDate.date == PlayerManager.instance.currentPlayerModel.sysCurtime.date)
            {
               if(_loc1_ == 2)
               {
                  DisplayUtils.handleDisplay(true,_groupLookBtn,_honorWarTime);
                  if(GloryGameManager.instance.model.currentState == 4)
                  {
                     _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str4");
                  }
                  else if(GloryGameManager.instance.model.currentState == 5)
                  {
                     _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str5");
                  }
                  else if(GloryGameManager.instance.model.currentState == 2)
                  {
                     _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str6");
                  }
                  else if(GloryGameManager.instance.model.currentState == 3)
                  {
                     _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str6");
                  }
               }
               else
               {
                  DisplayUtils.handleDisplay(true,_scrollPanel);
               }
            }
            else if(_loc1_ == 5 && _loc2_ >= 5)
            {
               DisplayUtils.handleDisplay(true,_honorWarTime);
               _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str8");
            }
            else if(_loc1_ == 6)
            {
               DisplayUtils.handleDisplay(true,_honorWarTime);
               _honorWarTime.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str8");
            }
            else
            {
               DisplayUtils.handleDisplay(true,_honorWarIconTxt,_honorWarTime,_honorWarBtn);
               _loc3_ = (nextGloryGameDate.time - PlayerManager.instance.currentPlayerModel.sysCurtime.time) / 1000;
               _honorWarTime.text = DateFormatter.getStopDateString(_loc3_);
            }
         }
      }
      
      private function __groupLookBtnClickHandler(param1:MouseEvent) : void
      {
         GloryGameManager.instance.sendEvent("JUMP_TO_SCHEDULE");
      }
      
      private function __honorWarBtnClickHandler(param1:MouseEvent) : void
      {
         GloryGameManager.instance.sendEvent("JUMP_TO_BET");
      }
      
      private function miniGamePass(param1:StarareaEvent) : void
      {
         if(SevenYearManager.instance.model.isGamePassed)
         {
            return;
         }
         SevenYearManager.instance.model.isGamePassed = true;
         if(SevenYearManager.instance.model.gameCount == 0)
         {
            _gameBtn.enable = true;
         }
      }
      
      private function __gameIconBtnClickHandler(param1:MouseEvent) : void
      {
         if(SevenYearManager.instance.model.snowTeamNum > 0)
         {
            SelfChessManager.Ins.sendMatch(2);
         }
         StarareaManager.instance.model.gameRoadId = -1;
         StarareaManager.instance.startMiniGame();
      }
      
      public function get model() : GloryGameModel
      {
         return GloryGameManager.instance.model;
      }
      
      private function __gameBtnClickHandler(param1:MouseEvent) : void
      {
         _gameBtn.enable = false;
         _gameBtn.text = LanguageMgr.GetTranslation("SevenYearGameView.gameBtn.text2");
         SevenYearManager.instance.sendOp(5);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_gameTime);
         _gameTime = null;
         ObjectUtils.disposeObject(_gameIconBtn);
         _gameIconBtn = null;
         ObjectUtils.disposeObject(_gameTxt);
         _gameTxt = null;
         ObjectUtils.disposeObject(_gameBtn);
         _gameBtn = null;
         ObjectUtils.disposeObject(_gameIconTxt);
         _gameIconTxt = null;
         ObjectUtils.disposeObject(_honorWarIconTxt);
         _honorWarIconTxt = null;
         ObjectUtils.disposeObject(_honorWarTime);
         _honorWarTime = null;
         ObjectUtils.disposeObject(_honorWarBtn);
         _honorWarBtn = null;
         ObjectUtils.disposeObject(_groupLookBtn);
         _groupLookBtn = null;
         ObjectUtils.disposeObject(_tipIcon);
         _tipIcon = null;
         ObjectUtils.disposeObject(gloryDailyContainer);
         gloryDailyContainer = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         super.dispose();
      }
   }
}

