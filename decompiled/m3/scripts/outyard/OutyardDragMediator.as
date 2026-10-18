package outyard
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mvc.module.outyard.OutyardEvent;
   import yishi.interfaces.IMediator;
   import yishi.utils.TweenDrag;
   
   public class OutyardDragMediator implements IMediator
   {
      
      private var _target:DisplayObject;
      
      private var _dragObj:TweenDrag;
      
      private var _dragTimeId:int;
      
      private var _dispatchStartEvent:Boolean;
      
      private var _startPoint:Point = new Point();
      
      private var startY:int = 0;
      
      private var startX:int = 0;
      
      private var mapWidth:int = 2800;
      
      private var mapHeight:int = 1600;
      
      public function OutyardDragMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as DisplayObject;
         _dragObj = new TweenDrag(_target,_target as InteractiveObject);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.onTweening = dragingCallBack;
         _dragObj.onTweenEnd = onTweenEnd;
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_dragObj)
         {
            _dragObj.dispose();
         }
         _dragObj = null;
         _target = null;
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         dragingCallBack();
         dropCallBack();
      }
      
      private function dropCallBack() : void
      {
         if(_dragTimeId > 0)
         {
            clearInterval(_dragTimeId);
         }
         _dragTimeId = 0;
         _target.dispatchEvent(new OutyardEvent("DRAG_SCENE_END",_target));
      }
      
      private function dragingCallBack() : void
      {
         var _loc1_:Point = mapMoveCheck(new Point(_target.x,_target.y));
         _target.x = _loc1_.x;
         _target.y = _loc1_.y;
         if(!_dispatchStartEvent && Point.distance(_loc1_,_startPoint) > 20)
         {
            dragSceneImp();
         }
         _loc1_ = null;
      }
      
      private function onTweenEnd() : void
      {
         dropCallBack();
      }
      
      private function dragStartCallBack() : void
      {
         _dispatchStartEvent = false;
         if(_dragTimeId > 0)
         {
            clearInterval(_dragTimeId);
         }
         _dragTimeId = 0;
         _dragTimeId = setInterval(dragSceneImp,300);
         _startPoint.x = _target.x;
         _startPoint.y = _target.y;
      }
      
      private function dragSceneImp() : void
      {
         TweenLite.killTweensOf(_target);
         _target["isMove"] = false;
         _dispatchStartEvent = true;
         if(_dragTimeId > 0)
         {
            clearInterval(_dragTimeId);
         }
         _dragTimeId = 0;
         _target.dispatchEvent(new OutyardEvent("DRAG_SCENE_START",_target));
      }
      
      public function mapMoveCheck(param1:Point) : Point
      {
         if(param1.x > startX)
         {
            param1.x = startX;
         }
         else if(param1.x < StageReferance.stageWidth - mapWidth)
         {
            param1.x = StageReferance.stageWidth - mapWidth;
         }
         if(param1.y > startY)
         {
            param1.y = startY;
         }
         else if(param1.y < StageReferance.stageHeight - mapHeight)
         {
            param1.y = StageReferance.stageHeight - mapHeight;
         }
         return param1;
      }
   }
}

