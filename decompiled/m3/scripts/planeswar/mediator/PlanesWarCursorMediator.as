package planeswar.mediator
{
   import events.PlanesWarEvent;
   import flash.events.MouseEvent;
   import mvc.module.planeswar.info.PlanesGridInfo;
   import planeswar.view.PlanesArmyView;
   import planeswar.view.PlanesGridIconView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.CursorManagerII;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class PlanesWarCursorMediator implements IMediator
   {
      
      private var _target:Object;
      
      public function PlanesWarCursorMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         param1.addEventListener("DRAG_MAP_START",__dragStartHandler);
         param1.addEventListener("DRAG_MAP_END",__dragEndHandler);
         param1.addEventListener("mouseMove",__mouseMoveHandler);
         param1.addEventListener("rollOut",__mouseOutHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         param1.removeEventListener("DRAG_MAP_START",__dragStartHandler);
         param1.removeEventListener("DRAG_MAP_END",__dragEndHandler);
         param1.removeEventListener("mouseMove",__mouseMoveHandler);
         param1.removeEventListener("rollOut",__mouseOutHandler);
         CursorManagerII.instance.resetCursor();
         _target = null;
      }
      
      private function __dragEndHandler(param1:PlanesWarEvent) : void
      {
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __dragStartHandler(param1:PlanesWarEvent) : void
      {
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(PlanesWarManager.instance.model.isDraging)
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(PlanesWarManager.instance.model.isDraging)
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

