package landmine.mediator
{
   import events.LandMineEvent;
   import flash.events.MouseEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.CursorManagerII;
   import yishi.manager.LandMineManager;
   
   public class LandMineCursorMediator implements IMediator
   {
      
      private var _target:Object;
      
      public function LandMineCursorMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         _target.addEventListener("DRAG_MAP_START",__dragStartHandler);
         _target.addEventListener("DRAG_MAP_END",__dragEndHandler);
         _target.addEventListener("mouseMove",__mouseMoveHandler);
         _target.addEventListener("rollOut",__mouseOutHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         _target.removeEventListener("DRAG_MAP_START",__dragStartHandler);
         _target.removeEventListener("DRAG_MAP_END",__dragEndHandler);
         _target.removeEventListener("mouseMove",__mouseMoveHandler);
         _target.removeEventListener("rollOut",__mouseOutHandler);
         CursorManagerII.instance.resetCursor();
         _target = null;
      }
      
      private function __dragEndHandler(param1:LandMineEvent) : void
      {
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __dragStartHandler(param1:LandMineEvent) : void
      {
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(LandMineManager.instance.model.isDraging)
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         if(LandMineManager.instance.model.isDraging)
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
      }
   }
}

