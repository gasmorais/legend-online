package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.ui.RiverView;
   import map.campaign.view.ui.WorldBossRebirthView;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.utils.WorldBossHelper;
   
   public class WorldBossRiverMediator implements IMediator
   {
      
      private var _river:Sprite;
      
      private var _army:CampaignArmy;
      
      private var _autoEnterFight:Boolean = false;
      
      public function WorldBossRiverMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _army = CampaignManager.instance.mapModel.selfMemberData;
         if(_army)
         {
            if(WorldBossHelper.checkInPetBossFloor(CampaignManager.instance.mapId))
            {
               _river = new RiverView(0);
            }
            else
            {
               _river = new WorldBossRebirthView(param1);
            }
            param1.addEventListener("mouseDown",__cancelAutoHandler);
            if(_river)
            {
               _river.addEventListener("change",__changeHandler);
            }
            StageReferance.stage.addEventListener("resize",__stageResizeHandler);
            _army.addEventListener("IS_DIE",__isDieHandler);
            __stageResizeHandler(null);
            __isDieHandler(null);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_army)
         {
            param1.removeEventListener("mouseDown",__cancelAutoHandler);
            if(_river)
            {
               _river.removeEventListener("change",__changeHandler);
            }
            _army.removeEventListener("IS_DIE",__isDieHandler);
            StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
            if(_river)
            {
               _river["dispose"]();
            }
            _river = null;
         }
         _army = null;
      }
      
      private function __isDieHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:int = 0;
         if(_army.isDie == 1)
         {
            _loc2_ = getTimer();
            _loc2_ -= _army.riverStartTime;
            if(_loc2_ < 20000 && _loc2_ > 0)
            {
               _loc2_ = _army.riverTime - _loc2_;
            }
            else
            {
               _loc2_ = int(_army.riverTime);
            }
            _river["count"] = Math.ceil(_loc2_ / 1000);
            LayerManager.Instance.addToLayer(_river,4);
         }
         else if(_river && _river.parent)
         {
            _river.parent.removeChild(_river);
         }
      }
      
      protected function __cancelAutoHandler(param1:MouseEvent) : void
      {
         if(_river)
         {
            _river["setAutoState"](false);
         }
      }
      
      protected function __changeHandler(param1:Event = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = Boolean(_river["state"]);
         if(_loc3_)
         {
            workNextNode();
         }
         else if(_army)
         {
            _loc2_ = CampaignManager.instance.controller.getArmyView(_army);
            if(_loc2_)
            {
               CampaignArmyView(_loc2_).aiInfo.pathInfo = [];
            }
         }
      }
      
      private function workNextNode(param1:Event = null) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("WORK_NEXT_NODE",null));
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
         _river.y = (StageReferance.stageHeight << 0) - 180;
      }
   }
}

