package sevenyear.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.SevenYearEvent;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.battleflag.SevenYearAnswerView;
   import sevenyear.view.battleflag.SevenYearGameView;
   import sevenyear.view.battleflag.SevenYearGradeView;
   import sevenyear.view.battleflag.SevenYearRankView;
   import sevenyear.view.battleflag.SevenYearRewardView;
   import sevenyear.view.battleflag.SevenYearSelfChessView;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class SevenYearBattleFlagView extends Component
   {
      
      private var _gradeView:SevenYearGradeView;
      
      private var _snowView:SevenYearSelfChessView;
      
      private var _gameView:SevenYearGameView;
      
      private var _rankView:SevenYearRankView;
      
      private var _answerView:SevenYearAnswerView;
      
      private var _rewardView:SevenYearRewardView;
      
      public function SevenYearBattleFlagView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _gradeView = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.gradeView");
         _snowView = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.selfchessView");
         _gameView = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.gameView");
         _rankView = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.rankView");
         _answerView = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.answerView");
         _rewardView = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.rewardView");
         addChild(_gradeView);
         addChild(_snowView);
         addChild(_gameView);
         addChild(_rankView);
         addChild(_answerView);
         _answerView.visible = false;
         addChild(_rewardView);
      }
      
      private function initEvent() : void
      {
         model.addEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
         model.addEventListener("UPDATE_ORDER_INFO",__updateOrderInfoHandler);
         model.addEventListener("UPDATE_QUESTION_INFO",__updateQuestionInfoHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_MINUTE",__updateTimeHandler);
         MsgMan.addObserver("UPDATE_SNOW_TEAM_COUNT",this,__updateMatchingHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
         model.removeEventListener("UPDATE_ORDER_INFO",__updateOrderInfoHandler);
         model.removeEventListener("UPDATE_QUESTION_INFO",__updateQuestionInfoHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_MINUTE",__updateTimeHandler);
         MsgMan.removeObserver("UPDATE_SNOW_TEAM_COUNT",this,__updateMatchingHandler);
      }
      
      private function __updateMatchingHandler(param1:String, param2:Object) : void
      {
         if(_answerView)
         {
            _answerView.visible = model.snowTeamNum > 0;
         }
      }
      
      private function __updateTimeHandler(param1:PlayerEvent) : void
      {
         _snowView.updateTime();
      }
      
      private function __updateQuestionInfoHandler(param1:SevenYearEvent) : void
      {
         _answerView.refreshView();
         _answerView.visible = model.snowTeamNum > 0;
      }
      
      private function __updateOrderInfoHandler(param1:SevenYearEvent) : void
      {
         _rankView.refreshView();
      }
      
      private function __updateUserInfoHandler(param1:SevenYearEvent) : void
      {
         _gradeView.refreshView();
         _snowView.refreshView();
         _answerView.refreshScore();
         _rewardView.refreshView();
      }
      
      public function refreshView() : void
      {
         _gradeView.refreshView();
         _snowView.refreshView();
         _answerView.refreshView();
         _rewardView.refreshView();
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_gradeView);
         _gradeView = null;
         ObjectUtils.disposeObject(_snowView);
         _snowView = null;
         ObjectUtils.disposeObject(_gameView);
         _gameView = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_answerView);
         _answerView = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         super.dispose();
      }
   }
}

