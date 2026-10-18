package landmine.mediator
{
   import com.greensock.TweenLite;
   import events.LandMineEvent;
   import flash.display.InteractiveObject;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import landmine.LandMineView;
   import yishi.interfaces.IMediator;
   import yishi.utils.TweenDrag;
   
   public class LandMineDragMediator implements IMediator
   {
      
      private var _target:LandMineView;
      
      private var _dragObj:TweenDrag;
      
      private var _dragTimeId:int;
      
      private var _dispatchStartEvent:Boolean;
      
      private var _startPoint:Point = new Point();
      
      public function LandMineDragMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as LandMineView;
         _dragObj = new TweenDrag(_target,_target as InteractiveObject);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.onTweening = dragingCallBack;
         _dragObj.onTweenEnd = onTweenEnd;
      }
      
      public function unregister(param1:Object) : void
      {
         if(_dragObj)
         {
            _dragObj.dispose();
         }
         _dragObj = null;
         _target = null;
      }
      
      private function dropCallBack() : void
      {
         if(_dragTimeId > 0)
         {
            clearInterval(_dragTimeId);
         }
         _dragTimeId = 0;
         _target.dragOver();
         if(_target)
         {
            _target.dispatchEvent(new LandMineEvent("DRAG_MAP_END",_target));
         }
      }
      
      private function dragingCallBack() : void
      {
         if(!_target)
         {
            return;
         }
         var _loc1_:Point = _target.dragMoveCheck(new Point(_target.x,_target.y));
         _target.x = _loc1_.x;
         _target.y = _loc1_.y;
         if(!_dispatchStartEvent && Point.distance(_loc1_,_startPoint) > 20)
         {
            dragSceneImp();
         }
         _loc1_ = null;
         _target.onDraging();
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
         _dragTimeId = setInterval(dragSceneImp,1000);
         _startPoint.x = _target.x;
         _startPoint.y = _target.y;
      }
      
      private function dragSceneImp() : void
      {
         TweenLite.killTweensOf(_target);
         _dispatchStartEvent = true;
         if(_dragTimeId > 0)
         {
            clearInterval(_dragTimeId);
         }
         _dragTimeId = 0;
         if(_target)
         {
            _target["isDraging"] = false;
            _target.dispatchEvent(new LandMineEvent("DRAG_MAP_START",_target));
         }
      }
   }
}

