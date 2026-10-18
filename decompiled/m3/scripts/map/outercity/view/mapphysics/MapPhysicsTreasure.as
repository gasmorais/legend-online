package map.outercity.view.mapphysics
{
   import flash.events.MouseEvent;
   import map.internals.event.OuterCityEvent;
   import map.internals.view.physics.PhysicsTreasureView;
   import yishi.manager.NotificationManager;
   
   public class MapPhysicsTreasure extends PhysicsTreasureView
   {
      
      public function MapPhysicsTreasure()
      {
         super();
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",nodeInfo));
         return true;
      }
   }
}

