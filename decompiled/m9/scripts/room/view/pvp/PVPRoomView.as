package room.view.pvp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.RoomManager;
   import room.view.RoomReadyTopView;
   import room.view.anteroom.PVPAnteroomView;
   
   public class PVPRoomView extends Sprite implements Disposeable
   {
      
      private var _rightView:PVPRoomRightView;
      
      private var _anteroom:PVPAnteroomView;
      
      private var _topView:RoomReadyTopView;
      
      public function PVPRoomView()
      {
         super();
         initView();
         initData();
         initEvents();
      }
      
      private function initView() : void
      {
         _rightView = ComponentFactory.Instance.creatCustomObject("roomPVP.PVPRoomRightView");
         _anteroom = ComponentFactory.Instance.creatCustomObject("roomPVP.AnteroomView",[RoomManager.instance.roomInfo]);
         _topView = ComponentFactory.Instance.creatCustomObject("roomPVP.RoomReadyTopView");
         addChild(_anteroom);
         addChild(_rightView);
         addChild(_topView);
      }
      
      private function initEvents() : void
      {
      }
      
      private function removeEvents() : void
      {
      }
      
      public function resize(param1:int, param2:int) : void
      {
         _rightView.x = param1 - 300;
         if(param2 > 600)
         {
            if(param2 >= 900)
            {
               _rightView.y = 152;
            }
            else
            {
               _rightView.y = 10 + (param2 - 600) * 142 / 300;
            }
         }
         else
         {
            _rightView.y = 10;
         }
         _anteroom.resize(param1,param2);
         _topView.x = param1 / 2 - 160;
         _topView.y = 50;
      }
      
      public function initData() : void
      {
         _rightView.model = RoomManager.instance.roomInfo;
      }
      
      public function dispose() : void
      {
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
         if(_anteroom)
         {
            ObjectUtils.disposeObject(_anteroom);
         }
         _anteroom = null;
         if(_topView)
         {
            ObjectUtils.disposeObject(_topView);
         }
         _topView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

