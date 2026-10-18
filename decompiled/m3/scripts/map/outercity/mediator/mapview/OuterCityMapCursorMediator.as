package map.outercity.mediator.mapview
{
   import map.internals.event.OuterCityEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.CursorManagerII;
   
   public class OuterCityMapCursorMediator implements IMediator
   {
      
      public function OuterCityMapCursorMediator()
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
      
      private function __dragEndHandler(param1:OuterCityEvent) : void
      {
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __dragStartHandler(param1:OuterCityEvent) : void
      {
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
   }
}

