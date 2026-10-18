package map.internals.view.frame
{
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import events.WorldBossEvent;
   import flash.display.Sprite;
   import map.campaign.CampaignManager;
   import mvc.module.worldboss.WorldBossModel;
   
   public class WorldBossRewardView extends Sprite
   {
      
      private var _worldBossModel:WorldBossModel;
      
      private var _hbox:HBox;
      
      public function WorldBossRewardView()
      {
         super();
         _worldBossModel = CampaignManager.instance.worldBossModel;
         init();
      }
      
      private function init() : void
      {
         if(!_worldBossModel.rewards)
         {
            _worldBossModel.addEventListener("REWARDS_INIT",onRewardsInit);
         }
         else
         {
            onRewardsInit(null);
         }
      }
      
      private function onRewardsInit(param1:WorldBossEvent) : void
      {
         var _loc2_:WorldBossRewardItem = null;
         var _loc3_:int = 0;
         if(_worldBossModel.rewards)
         {
            _hbox = new HBox();
            _hbox.spacing = 5;
            addChild(_hbox);
            _loc3_ = 0;
            while(_loc3_ < _worldBossModel.rewards.length)
            {
               _loc2_ = new WorldBossRewardItem(this);
               _loc2_.setData(_worldBossModel.rewards[_loc3_]);
               _hbox.addChild(_loc2_);
               _loc3_++;
            }
         }
      }
      
      public function dispose() : void
      {
         if(_worldBossModel)
         {
            _worldBossModel.removeEventListener("REWARDS_INIT",onRewardsInit);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_hbox);
      }
   }
}

