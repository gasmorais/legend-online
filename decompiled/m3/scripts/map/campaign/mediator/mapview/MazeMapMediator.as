package map.campaign.mediator.mapview
{
   import com.pickgliss.ui.LayerManager;
   import map.campaign.view.ui.MazeView;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class MazeMapMediator implements IMediator
   {
      
      private var _view:MazeView;
      
      private var isDie:Boolean = false;
      
      public function MazeMapMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _view = new MazeView();
         _view.y = 35;
         LayerManager.Instance.addToLayer(_view,4,false,false,0,3);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            unregister(null);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(isDie)
         {
            return;
         }
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         _view && _view.dispose();
         _view = null;
         isDie = true;
      }
   }
}

