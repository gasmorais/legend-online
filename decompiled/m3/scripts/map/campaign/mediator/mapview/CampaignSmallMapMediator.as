package map.campaign.mediator.mapview
{
   import mainBar.SmallMapBar;
   import map.campaign.CampaignManager;
   import map.internals.data.template.MapTemplate;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.utils.WorldBossHelper;
   
   public class CampaignSmallMapMediator implements IMediator
   {
      
      public function CampaignSmallMapMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         var _loc2_:MapTemplate = CampaignManager.instance.mapModel.mapTempInfo;
         var _loc3_:int = int(CampaignManager.instance.mapModel.mapId);
         SmallMapBar.instance.show();
         SmallMapBar.instance.initData(_loc2_,guideBackCall);
         if(WorldBossHelper.checkConsortiaSecretLand(_loc3_) || Boolean(WorldBossHelper.checkDuskArea(_loc3_)) || Boolean(WorldBossHelper.checkIceFireTemple(_loc3_)))
         {
            SmallMapBar.instance.switchSmallMapState(3);
         }
         else
         {
            SmallMapBar.instance.switchSmallMapState(2);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         SmallMapBar.instance.initData(null);
      }
      
      private function guideBackCall() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("campaignGuide",null));
      }
   }
}

