package map.outercity.mediator.mapview
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.internals.event.OuterCityEvent;
   import map.outercity.helper.mapview.MapViewHelper;
   import map.outercity.manager.OuterCityManager;
   import yishi.interfaces.IMediator;
   import yishi.utils.TweenDrag;
   
   public class OuterCityDragMediator implements IMediator
   {
      
      private var _target:DisplayObject;
      
      private var _dragObj:TweenDrag;
      
      private var _dragTimeId:int;
      
      private var _dispatchStartEvent:Boolean;
      
      private var _startPoint:Point = new Point();
      
      public function OuterCityDragMediator()
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
         OuterCityManager.instance.mapView.moveEnd();
         _target.dispatchEvent(new OuterCityEvent("DRAG_SCENE_END",_target));
      }
      
      private function dragingCallBack() : void
      {
         var _loc1_:Point = MapViewHelper.mapMoveCheck(new Point(_target.x,_target.y));
         _target.x = _loc1_.x;
         _target.y = _loc1_.y;
         if(!_dispatchStartEvent && Point.distance(_loc1_,_startPoint) > 20)
         {
            dragSceneImp();
         }
         _loc1_ = null;
         OuterCityManager.instance.mapView.onDraging();
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
         _target.dispatchEvent(new OuterCityEvent("DRAG_SCENE_START",_target));
      }
   }
}

