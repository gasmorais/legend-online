package areslords.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.AresLordsEvent;
   import flash.events.Event;
   import managers.RoomManager;
   import mvc.module.areslords.AresLordsModel;
   import yishi.manager.AresLordsManager;
   
   public class AresLordsRoomView extends Component
   {
      
      private var _backView:AresLordsRoomBackView;
      
      private var _leftView:AresLordsRoomLeftView;
      
      private var _rightView:AresLordsRoomRightView;
      
      private var _topView:AresLordsRoomTopView;
      
      private var _model:AresLordsModel = AresLordsManager.instance.model;
      
      public function AresLordsRoomView()
      {
         super();
         initView();
         refresh();
         addEvent();
         __stageResizeHandler(null);
      }
      
      private function initView() : void
      {
         _backView = new AresLordsRoomBackView(RoomManager.instance.roomInfo);
         _topView = new AresLordsRoomTopView();
         _leftView = new AresLordsRoomLeftView();
         _rightView = new AresLordsRoomRightView();
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
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         _model.addEventListener("AresLordsEvent.INFO_UPDATE",__infoUpdateHandler);
         _model.addEventListener("AresLordsEvent.SKILL_INFO",__skillUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         _model.removeEventListener("AresLordsEvent.INFO_UPDATE",__infoUpdateHandler);
         _model.removeEventListener("AresLordsEvent.SKILL_INFO",__skillUpdateHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(_backView)
         {
            _backView.resize(StageReferance.stageWidth,StageReferance.stageHeight);
         }
         if(_leftView)
         {
            _leftView.x = 0;
            _leftView.y = 177;
         }
         if(_rightView)
         {
            _rightView.x = StageReferance.stageWidth - _rightView.width;
            _rightView.y = 184;
         }
         if(_topView)
         {
            _topView.x = (StageReferance.stageWidth - _topView.width) / 2;
         }
      }
      
      private function __infoUpdateHandler(param1:AresLordsEvent) : void
      {
         refresh();
      }
      
      private function __skillUpdateHandler(param1:AresLordsEvent) : void
      {
         if(_rightView)
         {
            _rightView.data = _model.roomInfo;
         }
      }
      
      public function refresh() : void
      {
         if(_leftView)
         {
            _leftView.data = _model.roomInfo;
         }
         if(_rightView)
         {
            _rightView.data = _model.roomInfo;
         }
         if(_topView)
         {
            _topView.data = _model.roomInfo;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         _model = null;
         super.dispose();
      }
   }
}

