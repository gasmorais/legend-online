package map.outercity.mediator.layer
{
   import flash.events.MouseEvent;
   import map.outercity.view.mapphysics.ArmyView;
   import yishi.interfaces.IMediator;
   
   public class WalkMouseEventMediator implements IMediator
   {
      
      public function WalkMouseEventMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         param1.addEventListener("mouseMove",__mouseMoveHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         param1.removeEventListener("mouseMove",__mouseMoveHandler);
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:ArmyView = param1.target as ArmyView;
         if(_loc2_)
         {
            _loc2_.mouseMoveHandler(param1);
         }
      }
   }
}

