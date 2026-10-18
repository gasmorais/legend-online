package outyard
{
   import mvc.module.outyard.OutyardEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.CursorManagerII;
   
   public class OutyardMapCursorMediator implements IMediator
   {
      
      public function OutyardMapCursorMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         param1.addEventListener("DRAG_SCENE_END",__dragEndHandler);
         param1.addEventListener("DRAG_SCENE_START",__dragStartHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         param1.removeEventListener("DRAG_SCENE_END",__dragEndHandler);
         param1.removeEventListener("DRAG_SCENE_START",__dragStartHandler);
      }
      
      private function __dragEndHandler(param1:OutyardEvent) : void
      {
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __dragStartHandler(param1:OutyardEvent) : void
      {
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
   }
}

