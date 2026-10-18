package gamehall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import gamehall.view.GameHallActiveView;
   import gamehall.view.GameHallTeamView;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.ComponentGroupType;
   
   public class GameHallFrame extends Frame implements IManualSize
   {
      
      private var _activeView:GameHallActiveView;
      
      private var _teamView:GameHallTeamView;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      private var _flag:Boolean;
      
      public function GameHallFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,975,645);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("gamehall.GameHallFrame.titleTxt");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_activeView);
         _activeView = null;
         ObjectUtils.disposeObject(_teamView);
         _teamView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function showActive() : void
      {
         if(_activeView)
         {
            _activeView.defaultView();
            _activeView.visible = true;
            if(_model.openEastView || _model.selfTeam && _model.selfTeam.gameId == 4)
            {
               _activeView.refreshActiveEasLeftView();
            }
         }
         if(_teamView)
         {
            _teamView.visible = false;
         }
      }
      
      private function showTeam() : void
      {
         if(_activeView)
         {
            _activeView.visible = false;
         }
         if(_teamView)
         {
            if(_model.openEastView || _model.selfTeam && _model.selfTeam.gameId == 4)
            {
               _teamView.refreshTeamEasLeftView();
               _teamView.visible = true;
            }
            else
            {
               _teamView.defaultView();
               _teamView.visible = true;
            }
         }
      }
      
      public function set isTeamViewState(param1:Boolean) : void
      {
         if(param1)
         {
            _model.selectedGameId = _model.gameId;
            _model.selectedDifficulty = _model.difficulty;
            _model.updateSelectedGameInfo();
            if(!_teamView)
            {
               _teamView = new GameHallTeamView(showActive);
               addToContent(_teamView);
            }
            if(_teamView)
            {
               _teamView.teamViewState = param1;
            }
            showTeam();
            LayerManager.Instance.addToLayer(this,3,true,true,2);
         }
      }
      
      public function show() : void
      {
         _activeView = new GameHallActiveView(showTeam);
         _teamView = new GameHallTeamView(showActive);
         showActive();
         addToContent(_activeView);
         addToContent(_teamView);
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         _model.inited = false;
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

