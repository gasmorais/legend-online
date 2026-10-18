package gloryGame
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import managers.RoomManager;
   
   public class GloryGameRoomView extends Component
   {
      
      private var _backView:GloryGameRoomBackView;
      
      private var _topView:GloryGameRoomTopView;
      
      private var _rightView:GloryGameRoomRightView;
      
      public function GloryGameRoomView()
      {
         super();
         initView();
         addEvent();
         __stageResizeHandler(null);
      }
      
      private function initView() : void
      {
         _backView = new GloryGameRoomBackView(RoomManager.instance.roomInfo);
         _topView = new GloryGameRoomTopView();
         _rightView = new GloryGameRoomRightView();
         if(_backView)
         {
            addChild(_backView);
         }
         if(_topView)
         {
            addChild(_topView);
         }
         if(_rightView)
         {
            addChild(_rightView);
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _backView = null;
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
         if(_topView)
         {
            _topView.x = (StageReferance.stageWidth - 320) / 2;
            if(StageReferance.stageHeight >= _backView.back.height)
            {
               _topView.y = _backView.back.y + 30;
            }
            else
            {
               _topView.y = 30;
            }
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
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

