package matelords.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.MatelordsEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import managers.RoomManager;
   import mvc.module.matelords.MatelordsModel;
   import yishi.manager.MatelordsManager;
   
   public class MatelordsRoomView extends Sprite implements Disposeable
   {
      
      private var _backView:DisplayObject;
      
      private var _rightView:DisplayObject;
      
      private var _topView:DisplayObject;
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      public function MatelordsRoomView()
      {
         super();
         initView();
         refresh();
         addEvent();
         __stageResizeHandler(null);
      }
      
      private function initView() : void
      {
         _backView = new MatelordsRoomBackView(RoomManager.instance.roomInfo);
         _topView = new MatelordsRoomTopView();
         _rightView = new MatelordsRoomRightView();
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
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         _model.addEventListener("INFO_UPDATE",__warlordsInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         _model.removeEventListener("INFO_UPDATE",__warlordsInfoUpdateHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(_backView)
         {
            _backView["resize"](StageReferance.stageWidth,StageReferance.stageHeight);
         }
         if(_rightView)
         {
            _rightView.x = StageReferance.stageWidth - _rightView.width;
            _rightView.y = 160;
         }
         if(_topView)
         {
            _topView.x = (StageReferance.stageWidth - _topView.width) / 2;
         }
      }
      
      private function __warlordsInfoUpdateHandler(param1:MatelordsEvent) : void
      {
         refresh();
      }
      
      public function refresh() : void
      {
         if(_rightView)
         {
            _rightView["setTabByGroup"]();
         }
         if(_topView)
         {
            _topView["refresh"]();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

