package map.space.mediator.mapview
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.space.SpaceManager;
   import map.space.view.layer.SpaceBuildingLayer;
   import map.space.view.layer.SpaceNpcLayer;
   import map.space.view.layer.SpaceWalkLayer;
   import yishi.interfaces.IMediator;
   
   public class SpaceMouseEventMediator implements IMediator
   {
      
      private var _target:Object;
      
      private var _controller:*;
      
      private var _mouseDownTimeId:int;
      
      private var _isDown:Boolean;
      
      private var _mouseDownPoint:Point;
      
      public function SpaceMouseEventMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         _controller = SpaceManager.instance.controller;
         _target.addEventListener("rollOut",__rollOutHandler);
         _target.addEventListener("mouseOut",__mouseOutHandler);
         _target.addEventListener("mouseMove",__mouseMoveHandler);
         _target.addEventListener("mouseOver",__mouseOverHandler);
         _target.addEventListener("click",__onClickHandler);
         _target.addEventListener("mouseDown",__mouseDownHandler);
         _target.addEventListener("mouseUp",__mouseUpHandler);
         _target.addEventListener("deactivate",__deactiveteHandler);
         _controller.addEventListener("rollOut",__mouseParentOutHandler);
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
         _controller.removeEventListener("rollOut",__mouseParentOutHandler);
         _target = null;
         _controller = null;
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
         SpaceManager.instance.model.glowTarget = null;
         if(buildingLayer)
         {
            buildingLayer.mouseOutHandler(param1);
         }
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         if(_loc2_)
         {
            return;
         }
         SpaceManager.instance.model.glowTarget = null;
         if(npcLayer)
         {
            npcLayer.mouseMoveHandler(param1);
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(buildingLayer)
         {
            buildingLayer.mouseOverHandler(param1);
         }
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
         if(buildingLayer && !buildingLayer.onClickHandler(param1))
         {
            if(npcLayer && !npcLayer.onClickHandler(param1))
            {
               if(walkLayer)
               {
                  walkLayer.onClickHandler(param1);
               }
            }
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
            if(walkLayer)
            {
               walkLayer.onClickHandler(null);
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
      
      private function get npcLayer() : SpaceNpcLayer
      {
         return SpaceManager.instance.mapView.npcLayer;
      }
      
      private function get buildingLayer() : SpaceBuildingLayer
      {
         return SpaceManager.instance.mapView.buildingLayer;
      }
      
      private function get walkLayer() : SpaceWalkLayer
      {
         return SpaceManager.instance.mapView.walkLayer;
      }
   }
}

