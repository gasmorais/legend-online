package gamehall.room.mediator
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import gamehall.room.GameHallSceneMapView;
   import yishi.interfaces.IMediator;
   
   public class GameHallMouseEventMediator implements IMediator
   {
      
      private var _target:GameHallSceneMapView;
      
      private var _mouseDownTimeId:int;
      
      private var _isDown:Boolean;
      
      private var _mouseDownPoint:Point;
      
      public function GameHallMouseEventMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as GameHallSceneMapView;
         _target.addEventListener("rollOut",__rollOutHandler);
         _target.addEventListener("mouseOut",__mouseOutHandler);
         _target.addEventListener("mouseMove",__mouseMoveHandler);
         _target.addEventListener("mouseOver",__mouseOverHandler);
         _target.addEventListener("click",__onClickHandler);
         _target.addEventListener("mouseDown",__mouseDownHandler);
         _target.addEventListener("mouseUp",__mouseUpHandler);
         _target.addEventListener("deactivate",__deactiveteHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         _target.removeEventListener("rollOut",__rollOutHandler);
         _target.removeEventListener("mouseOut",__mouseOutHandler);
         _target.removeEventListener("mouseMove",__mouseMoveHandler);
         _target.removeEventListener("mouseOver",__mouseOverHandler);
         _target.removeEventListener("click",__onClickHandler);
         _target.removeEventListener("mouseDown",__mouseDownHandler);
         _target.removeEventListener("mouseUp",__mouseUpHandler);
         _target.removeEventListener("deactivate",__deactiveteHandler);
         _target = null;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _mouseDownPoint = null;
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         if(_loc2_)
         {
            return;
         }
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         if(_loc2_)
         {
            return;
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function __deactiveteHandler(param1:Event) : void
      {
         _isDown = false;
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
      }
      
      private function __mouseParentOutHandler(param1:Event) : void
      {
         if(param1.currentTarget == _target.parent)
         {
            __deactiveteHandler(param1);
         }
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         if(_loc2_)
         {
            return;
         }
         if(_target)
         {
            _target.onClickHandler(param1);
         }
         TweenLite.killTweensOf(_target,false);
         _mouseDownPoint = new Point(param1.stageX,param1.stageY);
         _isDown = true;
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         _mouseDownTimeId = setInterval(clickWalk,500);
      }
      
      private function clickWalk() : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         if(!_target || !(_target as Sprite).mouseEnabled)
         {
            return;
         }
         if(_isDown)
         {
            _mouseDownTimeId = setInterval(clickWalk,500);
            if(_target)
            {
               _target.onClickHandler(null);
            }
         }
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         _isDown = false;
         if(!_mouseDownPoint)
         {
            return;
         }
         _mouseDownPoint = null;
      }
   }
}

