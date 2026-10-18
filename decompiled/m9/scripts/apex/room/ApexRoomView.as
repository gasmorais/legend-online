package apex.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import managers.RoomManager;
   
   public class ApexRoomView extends Component
   {
      
      private var _backView:ApexRoomBackView;
      
      private var _rightView:ApexRoomRightView;
      
      private var _topView:ApexRoomTopView;
      
      public function ApexRoomView()
      {
         super();
         initView();
         addEvent();
         __stageResizeHandler(null);
      }
      
      private function initView() : void
      {
         _backView = new ApexRoomBackView(RoomManager.instance.roomInfo);
         _topView = new ApexRoomTopView();
         _rightView = new ApexRoomRightView();
         if(_backView)
         {
            addChild(_backView);
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
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(_backView)
         {
            _backView.resize(StageReferance.stageWidth,StageReferance.stageHeight);
         }
         if(_rightView)
         {
            if(StageReferance.stageWidth >= _backView.back.width)
            {
               _rightView.x = _backView.back.x + _backView.back.width - 238;
            }
            else
            {
               _rightView.x = StageReferance.stageWidth - 238;
            }
            _rightView.y = (StageReferance.stageHeight - 420) / 2;
         }
         if(_topView)
         {
            _topView.x = (StageReferance.stageWidth - 320) / 2;
            if(StageReferance.stageHeight >= _backView.back.height)
            {
               _topView.y = _backView.back.y;
            }
            else
            {
               _topView.y = 0;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

