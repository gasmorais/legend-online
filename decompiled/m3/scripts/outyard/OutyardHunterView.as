package outyard
{
   import treasurehunt.HeroHunterView;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class OutyardHunterView extends HeroHunterView
   {
      
      public function OutyardHunterView()
      {
         super();
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
      
      public function get personAngle() : Number
      {
         if(_avatar)
         {
            return _avatar.angle;
         }
         return 2;
      }
   }
}

