package gamehall.room
{
   import com.pickgliss.utils.ObjectUtils;
   import events.GameHallEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import ui.maintoolbar.MainToolBar;
   
   public class GameHallSceneView extends Sprite
   {
      
      private var _mapView:GameHallSceneMapView;
      
      private var _bottomView:GameHallSceneBottomView;
      
      private var _eastBlessView:GameHallSceneEastBlessView;
      
      private var _eastAutoTopView:GameHallEastTopAutoView;
      
      private var _model:GameHallModel;
      
      public function GameHallSceneView()
      {
         super();
         _model = GameHallManager.instance.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _mapView = new GameHallSceneMapView();
         _bottomView = new GameHallSceneBottomView();
         _eastBlessView = new GameHallSceneEastBlessView();
         addChild(_mapView);
         addChild(_bottomView);
         addChild(_eastBlessView);
         if(_model.gameId == 4)
         {
            _eastBlessView.visible = true;
            _eastAutoTopView = new GameHallEastTopAutoView();
            _eastAutoTopView.show();
         }
         else
         {
            _eastBlessView.visible = false;
         }
         _bottomView.refreshBottomItemVisible();
         _bottomView.buyBuffBtn = _eastBlessView.buffBtn;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_eastAutoTopView);
         _eastAutoTopView = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         ObjectUtils.disposeObject(_eastBlessView);
         _eastBlessView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         if(_model)
         {
            _model.addEventListener("GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         }
      }
      
      private function __gameInfoUpdateHandler(param1:GameHallEvent) : void
      {
         if(_model.gameId == 4)
         {
            _eastBlessView.visible = true;
            _eastBlessView.refreshView();
            _bottomView.refreshBottomItemVisible();
         }
         else
         {
            _eastBlessView.visible = false;
            _bottomView.refreshBottomItemVisible();
         }
      }
      
      public function addToStage(param1:Event) : void
      {
         if(_mapView)
         {
            _mapView.addToStage(param1);
         }
      }
      
      public function resize(param1:int, param2:int) : void
      {
         if(_mapView)
         {
            _mapView.resize(param1,param2);
         }
         _bottomView.x = 335;
         if(MainToolBar.instance.x + MainToolBar.instance.warningPosX < 830)
         {
            _bottomView.y = param2 - 150;
         }
         else
         {
            _bottomView.y = param2 - 80;
         }
         _eastBlessView.x = param1 - 222;
         _eastBlessView.y = _bottomView.y - 525;
         if(_eastAutoTopView)
         {
            _eastAutoTopView.resize(param1,param2);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

