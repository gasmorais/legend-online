package map.campaign.mediator.QuizActivity
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.answerquestion.AnswerQuestionPlayerMsg;
   import com.road.yishi.proto.answerquestion.AnswerQuestionRankListMsg;
   import events.ObjectsEvent;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.ui.QuizActivity.QuizTopTenView;
   import map.campaign.view.ui.QuizActivity.QuizView;
   import ui.toptoolbar.TopToolsBar;
   import yishi.interfaces.IMediator;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class QuizActivityMediator implements IMediator
   {
      
      private var _topTenView:QuizTopTenView;
      
      private var _quizView:QuizView;
      
      private var _selfArmyView:CampaignArmyView;
      
      private var _selectedSide:int = 0;
      
      public function QuizActivityMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         initUI();
         addEvent();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel)
         {
            _selfArmyView = CampaignManager.instance.controller.getArmyView(CampaignManager.instance.mapModel.selfMemberData);
            _selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
            __walkNextHandler(null);
         }
         MsgMan.addObserver("yishi.datas.consant.GET_RANK_MY_INFO_EVENT",this,updateRankMyInfo);
         MsgMan.addObserver("yishi.datas.consant.UPDATE_RANK_INFO_EVENT",this,updateAllRankInfo);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_selfArmyView)
         {
            _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         MsgMan.removeObserver("yishi.datas.consant.GET_RANK_MY_INFO_EVENT",this,updateRankMyInfo);
         MsgMan.removeObserver("yishi.datas.consant.UPDATE_RANK_INFO_EVENT",this,updateAllRankInfo);
      }
      
      private function updateRankMyInfo(param1:String, param2:AnswerQuestionPlayerMsg) : void
      {
         _topTenView.updateMyInfoTips(param2);
      }
      
      private function updateAllRankInfo(param1:String, param2:AnswerQuestionRankListMsg) : void
      {
         _topTenView.topTenChange(param2.answerQuestionRank);
      }
      
      private function __walkNextHandler(param1:ObjectsEvent) : void
      {
         var _loc3_:int = CampaignManager.instance.mapModel.selfMemberData.curPosX * 20;
         var _loc2_:int = CampaignManager.instance.mapModel.mapTempInfo.Width * 0.5;
         if(_loc3_ <= _loc2_)
         {
            _quizView.selecteChanged(1);
         }
         else
         {
            _quizView.selecteChanged(2);
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_topTenView)
         {
            _topTenView.stageResizeHandler();
         }
      }
      
      private function initUI() : void
      {
         _topTenView = new QuizTopTenView();
         _topTenView.show();
         _quizView = new QuizView();
         _quizView.show();
         PlayerManager.instance.synchronizedSystime();
      }
      
      public function unregister(param1:Object) : void
      {
         TopToolsBar.instance.show();
         removeEvent();
         ObjectUtils.disposeObject(_topTenView);
         _topTenView = null;
         ObjectUtils.disposeObject(_quizView);
         _quizView = null;
      }
   }
}

