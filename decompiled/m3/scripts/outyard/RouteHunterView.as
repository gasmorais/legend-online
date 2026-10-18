package outyard
{
   import treasurehunt.HeroHunterView;
   import yishi.datas.templates.MountTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class RouteHunterView extends HeroHunterView
   {
      
      public function RouteHunterView()
      {
         super();
      }
      
      override protected function getMountTemplate() : MountTemplate
      {
         return null;
      }
      
      override protected function walkOverExecute() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("AREA_WALK_OVER"));
      }
      
      public function updateAngle(param1:Number) : void
      {
         if(_avatar)
         {
            _avatar.angle = param1;
         }
      }
   }
}

