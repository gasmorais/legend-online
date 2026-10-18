package map.campaign.data
{
   import flash.events.EventDispatcher;
   import map.campaign.CampaignManager;
   import map.campaign.event.CampaignEvent;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class ActiveVehicleModel extends EventDispatcher
   {
      
      public var campaiganStartTime:Date;
      
      private var startDate:Date;
      
      private var endDate:Date;
      
      private var _mapModel:CampaignMapModel;
      
      public function ActiveVehicleModel()
      {
         super();
         campaiganStartTime = new Date();
         startDate = new Date();
         endDate = new Date();
         initStartEndDate();
      }
      
      private function initStartEndDate() : void
      {
         var _loc1_:Array = ConfigInfoManager.instance.getSnowVehicleOpenTime();
         startDate = DateFormatter.parse(_loc1_[0],"YYYY-MM-DD hh:mm");
         endDate = DateFormatter.parse(_loc1_[1],"YYYY-MM-DD hh:mm");
      }
      
      public function get overTime() : int
      {
         if(!campaiganStartTime)
         {
            return 0;
         }
         var _loc1_:int = (playerModel.sysCurtime.time - campaiganStartTime.time) / 1000;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function getActiveTeamMembers() : Array
      {
         var _loc1_:Array = [];
         if(!mapModel || !mapModel.selfMemberData)
         {
            return _loc1_;
         }
         for each(var _loc2_:CampaignArmy in mapModel.allUserArmy)
         {
            if(_loc2_.activeTeamId == mapModel.selfMemberData.activeTeamId && _loc2_.userId != mapModel.selfMemberData.userId)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getActiveAllPlayers() : Array
      {
         var _loc1_:Array = [];
         if(!mapModel)
         {
            return _loc1_;
         }
         for each(var _loc2_:CampaignArmy in mapModel.allUserArmy)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function startCountTime() : void
      {
         this.dispatchEvent(new CampaignEvent("ACTIVEVEHICLE_COUNTTIME",this));
      }
      
      public function syncActivePlayerInfo() : void
      {
         this.dispatchEvent(new CampaignEvent("ACTIVEVEHICLE_PLAYERSUPDATE",this));
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

