package map.campaign.view.ui
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignEvent;
   import map.internals.data.CampaignNode;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   
   public class MazeAutoFightHelper
   {
      
      private static const PROTAL_START:int = 2301;
      
      private var _timer:Timer;
      
      public function MazeAutoFightHelper()
      {
         super();
         _timer = new Timer(2000);
         _timer.addEventListener("timer",onTimer);
         _timer.stop();
      }
      
      public function start() : void
      {
         _timer.start();
         NotificationManager.instance.addEventListener("CAMPAIGN_OVER",__campaignOverHandler);
      }
      
      public function stop() : void
      {
         _timer.stop();
         NotificationManager.instance.removeEventListener("CAMPAIGN_OVER",__campaignOverHandler);
      }
      
      private function __campaignOverHandler(param1:CampaignEvent) : void
      {
         dispose();
      }
      
      public function onTimer(param1:TimerEvent = null) : void
      {
         var _loc4_:CampaignNode = null;
         var _loc2_:CampaignNode = null;
         var _loc5_:CampaignNode = null;
         if(WorldBossHelper.checkInAnyMaze(CampaignManager.instance.mapId) && SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            for each(var _loc3_:CampaignNode in mapModel.mapNodesData)
            {
               if(_loc3_.info.types == 42 && _loc3_.info.state == 1)
               {
                  _loc4_ = _loc3_;
               }
               else if(_loc3_.info.types == 61 && _loc3_.info.state == 1)
               {
                  _loc2_ = _loc3_;
               }
               else if(_loc3_.info.types == 62 && _loc3_.sonType != 2301)
               {
                  _loc5_ = _loc3_;
               }
            }
            if(_loc4_)
            {
               CampaignManager.instance.controller.moveArmyByPos(_loc4_.x,_loc4_.y,true);
            }
            else if(_loc2_)
            {
               CampaignManager.instance.controller.moveArmyByPos(_loc2_.x,_loc2_.y,true);
            }
            else if(_loc5_)
            {
               CampaignManager.instance.controller.moveArmyByPos(_loc5_.x,_loc5_.y,true);
            }
            return;
         }
         dispose();
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimer);
            _timer = null;
         }
      }
   }
}

