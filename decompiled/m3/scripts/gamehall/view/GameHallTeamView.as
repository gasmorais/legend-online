package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.gamehall.GameHallModel;
   
   public class GameHallTeamView extends Sprite
   {
      
      private var _border:Scale9CornerImage;
      
      private var _leftView:GameHallTeamLeftView;
      
      private var _rightView:GameHallTeamRightView;
      
      private var _eastLeftView:GameHallTeamEastLeftView;
      
      private var _teamViewState:Boolean = false;
      
      private var _callBack:Function;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      public function GameHallTeamView(param1:Function = null)
      {
         _callBack = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamView.border");
         _leftView = new GameHallTeamLeftView(_callBack);
         _rightView = new GameHallTeamRightView();
         _rightView.x = 220;
         _rightView.y = 3;
         addChild(_border);
         addChild(_leftView);
         addChild(_rightView);
         if(_model.groupHasValidGame(2))
         {
            _eastLeftView = new GameHallTeamEastLeftView(_callBack);
            addChild(_eastLeftView);
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_eastLeftView);
         _eastLeftView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _callBack = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set teamViewState(param1:Boolean) : void
      {
         _teamViewState = param1;
         if(_leftView)
         {
            _leftView.teamViewState = _teamViewState;
         }
         if(_rightView)
         {
            _rightView.teamViewState = _teamViewState;
         }
         if(_eastLeftView)
         {
            _eastLeftView.teamViewState = _teamViewState;
         }
      }
      
      public function defaultView() : void
      {
         var _loc3_:GameHallGameInfo = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:GameHallGameInfo = null;
         var _loc4_:int = 0;
         _leftView.visible = true;
         if(_eastLeftView)
         {
            _eastLeftView.visible = false;
         }
         if(!_model.inited)
         {
            _loc3_ = new GameHallGameInfo();
            _loc2_ = 0;
            _loc3_.gameId = 1;
            if(_loc3_.templateInfo.hasDiffSelect)
            {
               _loc2_ = 1;
            }
            _model.selectedGameId = 1;
            _model.selectedDifficulty = _loc2_;
            _model.updateSelectedGameInfo();
            _model.inited = true;
         }
         if(!GameHallManager.instance.isOpenToday(_model.selectedGameId))
         {
            _loc5_ = 1;
            while(_loc5_ <= 3)
            {
               if(GameHallManager.instance.isOpenToday(_loc5_))
               {
                  _loc1_ = new GameHallGameInfo();
                  _loc4_ = 0;
                  _loc1_.gameId = _loc5_;
                  if(_loc1_.templateInfo.hasDiffSelect)
                  {
                     _loc4_ = 1;
                  }
                  _model.selectedGameId = _loc5_;
                  _model.selectedDifficulty = _loc4_;
                  _model.updateSelectedGameInfo();
                  break;
               }
               _loc5_++;
            }
         }
      }
      
      public function refreshTeamEasLeftView() : void
      {
         if(_eastLeftView)
         {
            _eastLeftView.visible = true;
         }
         if(_eastLeftView)
         {
            _eastLeftView.refreshView();
         }
         _leftView.visible = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

