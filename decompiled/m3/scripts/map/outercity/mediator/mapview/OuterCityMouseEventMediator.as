package map.outercity.mediator.mapview
{
   import bag.helper.BagHelper;
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.OuterCityMap;
   import map.outercity.view.mapphysics.MapPhysicsCastle;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   
   public class OuterCityMouseEventMediator implements IMediator
   {
      
      private var _downPos:Point = new Point();
      
      private var _upPos:Point = new Point();
      
      public function OuterCityMouseEventMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         param1.addEventListener("click",__onClickHandler);
         param1.addEventListener("mouseOut",__mouseOutHandler);
         param1.addEventListener("mouseOver",__mouseOverHandler);
         param1.addEventListener("mouseMove",__mouseMoveHandler);
         param1.addEventListener("mouseDown",__mouseDownHandler);
         param1.addEventListener("mouseUp",__mouseUpHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         param1.removeEventListener("click",__onClickHandler);
         param1.removeEventListener("mouseOut",__mouseOutHandler);
         param1.removeEventListener("mouseOver",__mouseOverHandler);
         param1.removeEventListener("mouseMove",__mouseMoveHandler);
         param1.removeEventListener("mouseDown",__mouseDownHandler);
         param1.removeEventListener("mouseUp",__mouseUpHandler);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         _downPos.x = StageReferance.stage.mouseX;
         _downPos.y = StageReferance.stage.mouseY;
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(TransmitHandler.Instance.mouseCursor)
         {
            return;
         }
         if(CursorManagerII.instance.currentState == "PVP_ATTACT_CURSOR")
         {
            return;
         }
         _upPos.x = StageReferance.stage.mouseX;
         _upPos.y = StageReferance.stage.mouseY;
         var _loc2_:int = Point.distance(_downPos,_upPos);
         if(_loc2_ < 3)
         {
            if(mapView.mainBuidingLayer && mapView.mainBuidingLayer.mouseClickHandler(param1))
            {
               return;
            }
            if(param1.target is IBaseMouseEvent && Boolean((param1.target as IBaseMouseEvent).mouseClickHandler(param1)))
            {
               return;
            }
            mapView.worldWalkLayer.mouseClickHandler(param1);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_MAP",param1.target));
         }
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc3_:IBaseMouseEvent = null;
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(TransmitHandler.Instance.mouseCursor)
         {
            return;
         }
         if(CursorManagerII.instance.currentState == "PVP_ATTACT_CURSOR")
         {
            return;
         }
         var _loc2_:Boolean = mapView.npcLayer.mouseMoveHandler(param1);
         if(_loc2_)
         {
            CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
         }
         else
         {
            _loc3_ = param1.target as IBaseMouseEvent;
            if(_loc3_)
            {
               if(_loc3_["parent"] == mapView.mainBuidingLayer)
               {
                  if(_loc3_ is MapPhysicsCastle)
                  {
                     if((_loc3_ as MapPhysicsCastle).info.info.occupyPlayerId > 0)
                     {
                        if(!_loc3_["isSelfCastle"] && CursorManagerII.instance.currentState != "SELL_CIRSOR")
                        {
                           CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                        }
                        else
                        {
                           resetCursor();
                        }
                     }
                     else
                     {
                        resetCursor();
                     }
                  }
                  else if(CursorManagerII.instance.currentState != "SELL_CIRSOR")
                  {
                     CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                  }
               }
               else
               {
                  resetCursor();
               }
            }
            else
            {
               resetCursor();
            }
         }
      }
      
      private function resetCursor() : void
      {
         var _loc1_:String = CursorManagerII.instance.currentState;
         if(_loc1_ != "DRAG_CURSOR" && _loc1_ != "SELL_CIRSOR")
         {
            if(!TransmitHandler.Instance.mouseCursor)
            {
               CursorManagerII.instance.resetCursor();
            }
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(TransmitHandler.Instance.mouseCursor)
         {
            return;
         }
         _upPos.x = StageReferance.stage.mouseX;
         _upPos.y = StageReferance.stage.mouseY;
         var _loc2_:int = Point.distance(_downPos,_upPos);
         if(_loc2_ < 3)
         {
            mapView.mainBuidingLayer.mouseClickHandler(param1);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_MAP",param1.target));
         }
         if(CursorManagerII.instance.currentState == "PVP_ATTACT_CURSOR")
         {
            resetCursor();
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         mapView.mainBuidingLayer.mouseOverHandler(param1);
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         mapView.mainBuidingLayer.mouseOutHandler(param1);
         if(CursorManagerII.instance.currentState == "PVP_ATTACT_CURSOR")
         {
            return;
         }
         resetCursor();
      }
      
      private function get mapView() : OuterCityMap
      {
         return OuterCityManager.instance.mapView;
      }
   }
}

