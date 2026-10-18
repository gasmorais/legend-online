package unrealshooting.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import map.campaign.data.UnrealShootingModel;
   import map.campaign.event.UnrealShootingEvent;
   import mvc.controler.UnrealShootingController;
   import ui.resourcebar.ResourcesBar;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingRoomView extends Sprite implements Disposeable
   {
      
      private var _backView:UnrealShootingRoomBackView;
      
      private var _topView:UnrealShootingRoomTopView;
      
      private var _leftView:UnrealShootingRoomLeftView;
      
      private var _rightView:UnrealShootingRoomRightView;
      
      private var _bottomView:UnrealShootingRoomBottomView;
      
      private var _controller:UnrealShootingController;
      
      private var _model:UnrealShootingModel;
      
      public function UnrealShootingRoomView()
      {
         super();
         _controller = FrameControllerManager.instance.unrealShootingController;
         _model = _controller.model;
         initView();
         refresh();
         addEvent();
         __stageResizeHandler(null);
         ResourcesBar.instance.armyBtnEnable(false);
      }
      
      private function initView() : void
      {
         _backView = new UnrealShootingRoomBackView();
         _topView = new UnrealShootingRoomTopView();
         _leftView = new UnrealShootingRoomLeftView();
         _rightView = new UnrealShootingRoomRightView();
         _bottomView = new UnrealShootingRoomBottomView();
         if(_backView)
         {
            addChild(_backView);
         }
         if(_leftView)
         {
            addChild(_leftView);
         }
         if(_rightView)
         {
            addChild(_rightView);
         }
         if(_topView)
         {
            addChild(_topView);
         }
         if(_bottomView)
         {
            addChild(_bottomView);
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_backView);
         _backView = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         _model.addEventListener("UNREAL_SHOOTING_PLAYER_LIST_CHANGE",__playerListChangeHandler);
         _model.addEventListener("UNREAL_SHOOTING_TEMPLATE_ID_CHANGE",__templateIdChangeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         _model.removeEventListener("UNREAL_SHOOTING_PLAYER_LIST_CHANGE",__playerListChangeHandler);
         _model.removeEventListener("UNREAL_SHOOTING_TEMPLATE_ID_CHANGE",__templateIdChangeHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(_backView)
         {
            _backView.x = (StageReferance.stageWidth - _backView.width) / 2;
            _backView.y = StageReferance.stageHeight - _backView.height;
         }
         if(_topView)
         {
            _topView.x = (StageReferance.stageWidth - _topView.width) / 2;
            _topView.y = 0;
         }
         if(_leftView)
         {
            _leftView.x = 0;
            _leftView.y = 7;
         }
         if(_rightView)
         {
            _rightView.x = StageReferance.stageWidth - _rightView.width;
            _rightView.y = 100;
         }
         if(_bottomView)
         {
            _bottomView.x = (StageReferance.stageWidth - _bottomView.width) / 2;
            _bottomView.y = StageReferance.stageHeight - _bottomView.height - 120;
         }
      }
      
      private function __playerListChangeHandler(param1:UnrealShootingEvent) : void
      {
         refresh();
      }
      
      private function __templateIdChangeHandler(param1:UnrealShootingEvent) : void
      {
         refresh();
      }
      
      public function refresh() : void
      {
         if(_backView)
         {
            _backView.refreshView();
         }
         if(_leftView)
         {
            _leftView.refreshView();
         }
         if(_rightView)
         {
            _rightView.refreshView();
         }
         if(_topView)
         {
            _topView.refreshView();
         }
         if(_bottomView)
         {
            _bottomView.refreshView();
         }
      }
      
      public function dispose() : void
      {
         ResourcesBar.instance.armyBtnEnable(true);
         removeEvent();
         uninitView();
      }
   }
}

