package yishi.utils
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class TweenDrag
   {
      
      public var onDraging:Function;
      
      public var onDragStart:Function;
      
      public var onDragDrop:Function;
      
      public var onTweening:Function;
      
      public var onTweenEnd:Function;
      
      public var upNoMove:Boolean;
      
      public var afterTime:int = 0;
      
      private var _countTime:Number = 0;
      
      private var _target:DisplayObject;
      
      private var _eventTarget:InteractiveObject;
      
      private var preMousePostion:Point;
      
      private var mouseDownPoint:Point = new Point();
      
      private var forceVector:Point = new Point();
      
      private var _isTweening:Boolean = false;
      
      private var _enable:Boolean = true;
      
      private var maxForce:int = 60;
      
      public function TweenDrag(param1:DisplayObject = null, param2:InteractiveObject = null)
      {
         super();
         this.target = param1;
         this.eventTarget = param2;
      }
      
      public function set eventTarget(param1:InteractiveObject) : void
      {
         if(_eventTarget == param1)
         {
            return;
         }
         removeEvent();
         _eventTarget = param1;
         if(enable)
         {
            addEvent();
         }
      }
      
      public function get eventTarget() : InteractiveObject
      {
         return _eventTarget;
      }
      
      private function addEvent() : void
      {
         if(_eventTarget == null)
         {
            return;
         }
         _eventTarget.addEventListener("mouseDown",__mouseDown);
      }
      
      private function __mouseDown(param1:MouseEvent) : void
      {
         if(afterTime > 0)
         {
            _countTime = getTimer();
         }
         StageReferance.stage.addEventListener("mouseUp",__mouseUp,false,0,true);
         StageReferance.stage.addEventListener("mouseLeave",__mouseUp,false,0,true);
         _target.addEventListener("enterFrame",__mouseMove);
         _target.removeEventListener("enterFrame",__enterFrame);
         preMousePostion = new Point(param1.stageX,param1.stageY);
         mouseDownPoint.x = param1.stageX;
         mouseDownPoint.y = param1.stageY;
         _isTweening = false;
         if(onDragStart != null)
         {
            onDragStart();
         }
      }
      
      private function __mouseMove(param1:Event) : void
      {
         if(afterTime > 0 && getTimer() - _countTime <= afterTime)
         {
            return;
         }
         forceVector.x = target.stage.mouseX - preMousePostion.x;
         forceVector.y = target.stage.mouseY - preMousePostion.y;
         preMousePostion.x = target.stage.mouseX;
         preMousePostion.y = target.stage.mouseY;
         target.x += forceVector.x;
         target.y += forceVector.y;
         var _loc3_:int = 2;
         var _loc4_:int = 2;
         var _loc2_:int = mouseDownPoint.x - target.stage.mouseX;
         if(_loc2_ > 1)
         {
            _loc3_ = -2;
         }
         else if(_loc2_ < -1)
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 0;
         }
         _loc2_ = mouseDownPoint.y - target.stage.mouseY;
         if(_loc2_ > 1)
         {
            _loc4_ = -2;
         }
         else if(_loc2_ < -1)
         {
            _loc4_ = 2;
         }
         else
         {
            _loc2_ = 0;
         }
         forceVector.x += _loc3_;
         forceVector.y += _loc4_;
         if(onDraging != null)
         {
            onDraging();
         }
      }
      
      private function __mouseUp(param1:Event) : void
      {
         _target.removeEventListener("enterFrame",__mouseMove);
         StageReferance.stage.removeEventListener("mouseUp",__mouseUp);
         StageReferance.stage.removeEventListener("mouseLeave",__mouseUp);
         if(!upNoMove)
         {
            startTween();
         }
         if(onDragDrop != null)
         {
            onDragDrop();
         }
      }
      
      private function startTween() : void
      {
         if(forceVector.x != 0 && forceVector.y != 0)
         {
            setForcVectorMaxValue();
            _target.addEventListener("enterFrame",__enterFrame);
            _isTweening = true;
         }
      }
      
      private function setForcVectorMaxValue() : void
      {
         forceVector.x = forceVector.x > maxForce ? maxForce : forceVector.x;
         forceVector.x = forceVector.x < -maxForce ? -maxForce : forceVector.x;
         forceVector.y = forceVector.y > maxForce ? maxForce : forceVector.y;
         forceVector.y = forceVector.y < -maxForce ? -maxForce : forceVector.y;
      }
      
      private function __enterFrame(param1:Event) : void
      {
         target.x += int(forceVector.x);
         target.y += int(forceVector.y);
         forceVector.x *= 0.8;
         forceVector.y *= 0.8;
         if(Math.abs(forceVector.x) < 1 && Math.abs(forceVector.y) < 1)
         {
            target.removeEventListener("enterFrame",__enterFrame);
            _isTweening = false;
            if(onTweenEnd != null)
            {
               onTweenEnd();
            }
         }
         if(onTweening != null)
         {
            onTweening();
         }
      }
      
      private function removeEvent() : void
      {
         _isTweening = false;
         if(_eventTarget == null)
         {
            return;
         }
         _eventTarget.removeEventListener("mouseDown",__mouseDown);
         StageReferance.stage.removeEventListener("mouseUp",__mouseUp);
         _target.removeEventListener("enterFrame",__mouseMove);
         _target.removeEventListener("enterFrame",__enterFrame);
         StageReferance.stage.removeEventListener("mouseLeave",__mouseUp);
      }
      
      public function get isTweening() : Boolean
      {
         return _isTweening;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         if(param1)
         {
            addEvent();
         }
         else
         {
            removeEvent();
         }
         _enable = param1;
      }
      
      public function get target() : DisplayObject
      {
         return _target;
      }
      
      public function set target(param1:DisplayObject) : void
      {
         if(_target == param1)
         {
            return;
         }
         if(_target != null)
         {
            _target.removeEventListener("enterFrame",__mouseMove);
            _target.removeEventListener("enterFrame",__enterFrame);
         }
         _target = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _target = null;
         _eventTarget = null;
         onDraging = null;
         onDragStart = null;
         onDragDrop = null;
         onTweening = null;
         onTweenEnd = null;
      }
   }
}

