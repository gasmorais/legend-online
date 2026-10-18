package map.campaign.mediator.maze
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.MazeRiverView;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   
   public class MazeRiverMediator implements IMediator
   {
      
      private var _river:MazeRiverView;
      
      private var _rivarCount:int;
      
      private var _selfArmy:CampaignArmy;
      
      public function MazeRiverMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _river = new MazeRiverView();
         _selfArmy = selfMemberData;
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         NotificationManager.instance.addEventListener("MAZE_DIE",__mazeDieHandler);
         __stageResizeHandler(null);
         if(selfMemberData)
         {
            selfMemberData.addEventListener("IS_DIE",__isDieHandler);
            __isDieHandler(null);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__isDieHandler);
         }
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         NotificationManager.instance.removeEventListener("MAZE_DIE",__mazeDieHandler);
         if(_river)
         {
            _river.dispose();
         }
         _river = null;
         _selfArmy = null;
      }
      
      private function __isDieHandler(param1:CampaignMapEvent) : void
      {
         if(selfMemberData.isDie == 1)
         {
            if(!_river.parent)
            {
               MazeRiverView.addRiverCount();
            }
            LayerManager.Instance.addToLayer(_river,4);
         }
         else if(_river && _river.parent)
         {
            _river.parent.removeChild(_river);
         }
      }
      
      private function __mazeDieHandler(param1:CampaignMapEvent) : void
      {
         if(_river)
         {
            _river.cost = int(param1.data);
         }
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(StageReferance.stageWidth < 1100)
         {
            _river.x = (StageReferance.stageWidth - _river.width >> 1) + 50;
         }
         else
         {
            _river.x = StageReferance.stageWidth - _river.width >> 1;
         }
         _river.y = (StageReferance.stageHeight << 0) - 143;
      }
      
      private function get selfMemberData() : CampaignArmy
      {
         return CampaignManager.instance.mapModel.selfMemberData;
      }
   }
}

