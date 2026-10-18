package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.RiverView;
   import yishi.interfaces.IMediator;
   
   public class ConsortiaDemonReviveMediator implements IMediator
   {
      
      private var _revive:RiverView;
      
      private var _autoEnterFight:Boolean = false;
      
      public function ConsortiaDemonReviveMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _revive = new RiverView(2);
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         selfMemberData.addEventListener("IS_DIE",__isDieHandler);
         __stageResizeHandler(null);
         __isDieHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         selfMemberData.removeEventListener("IS_DIE",__isDieHandler);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         if(_revive)
         {
            _revive.dispose();
         }
         _revive = null;
      }
      
      private function __isDieHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:int = 0;
         if(selfMemberData.isDie == 1)
         {
            _loc2_ = getTimer();
            _loc2_ -= selfMemberData.riverStartTime;
            if(_loc2_ < 20000 && _loc2_ > 0)
            {
               _loc2_ = selfMemberData.riverTime - _loc2_;
            }
            else
            {
               _loc2_ = int(selfMemberData.riverTime);
            }
            _revive.count = Math.ceil(_loc2_ / 1000);
            LayerManager.Instance.addToLayer(_revive,4);
         }
         else if(_revive && _revive.parent)
         {
            _revive.parent.removeChild(_revive);
         }
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(StageReferance.stageWidth < 1100)
         {
            _revive.x = (StageReferance.stageWidth - _revive.width >> 1) + 50;
         }
         else
         {
            _revive.x = StageReferance.stageWidth - _revive.width >> 1;
         }
         _revive.y = (StageReferance.stageHeight << 0) - 143;
      }
      
      private function get selfMemberData() : CampaignArmy
      {
         return CampaignManager.instance.mapModel.selfMemberData;
      }
   }
}

