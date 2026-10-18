package room.view.pve
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.RoomEvent;
   import flash.display.Sprite;
   import managers.RoomManager;
   import room.view.RoomReadyTopView;
   import room.view.anteroom.AnteroomView;
   import room.view.invite.RoomInviteFrame;
   import yishi.view.component.MovieButtonII;
   
   public class RoomView extends Sprite implements Disposeable
   {
      
      private var _rightView:RoomRightView;
      
      private var _anteroom:AnteroomView;
      
      private var _topView:RoomReadyTopView;
      
      private var _blackGound:Sprite;
      
      public function RoomView()
      {
         super();
         initView();
         initData();
         initEvents();
         RoomInviteFrame;
      }
      
      private function initView() : void
      {
         _rightView = ComponentFactory.Instance.creatCustomObject("room.roomRightView");
         _anteroom = ComponentFactory.Instance.creatCustomObject("room.AnteroomView",[RoomManager.instance.roomInfo]);
         _topView = ComponentFactory.Instance.creatCustomObject("room.RoomReadyTopView");
         _blackGound = new Sprite();
         addChild(_blackGound);
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
      
      private function __updateRoomMap(param1:RoomEvent) : void
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
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,1);
         _blackGound.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
         _blackGound.graphics.endFill();
      }
      
      public function initData() : void
      {
         _rightView.model = RoomManager.instance.roomInfo;
      }
      
      public function getSelectInstanceBtn() : BaseButton
      {
         return _rightView.selectInstanceBtn;
      }
      
      public function getStartBtn() : MovieButtonII
      {
         return _rightView.startBtn;
      }
      
      public function dispose() : void
      {
         removeEvents();
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
         if(_blackGound)
         {
            ObjectUtils.disposeObject(_blackGound);
         }
         _blackGound = null;
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

