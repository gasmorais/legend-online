package managers
{
   import com.road.yishi.proto.campaign.OprateReplacemntMsg;
   import com.road.yishi.proto.campaign.ReplacementMsg;
   import com.road.yishi.proto.campaign.WorldBossInfoStateMsg;
   import com.road.yishi.proto.campaign.WorldBossStateMsg;
   import com.road.yishi.proto.campaign.WorldBossWoundRewardListMsg;
   import com.road.yishi.proto.campaign.WorldBossWoundRewardMsg;
   import events.WorldBossEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import mvc.module.worldboss.WorldBossStuntmanInfo;
   import mvc.module.worldboss.WorldRewardVO;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldBossManager
   {
      
      public static const RVR_TEMPLATE_ID_1:int = 4701;
      
      public static const RVR_TEMPLATE_ID_2:int = 4101;
      
      public static const RVR_TEMPLATE_ID_3:int = 4901;
      
      private static var _instance:WorldBossManager;
      
      private var _stuntman:WorldBossStuntmanInfo;
      
      public var pvpWarIsOpen:Boolean = false;
      
      public function WorldBossManager()
      {
         super();
         _stuntman = new WorldBossStuntmanInfo();
      }
      
      public static function get instance() : WorldBossManager
      {
         if(!_instance)
         {
            _instance = new WorldBossManager();
         }
         return _instance;
      }
      
      public function get stuntman() : WorldBossStuntmanInfo
      {
         return _stuntman;
      }
      
      public function setup() : void
      {
         reqWorldBossStates();
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4182,__updateWorldsBossStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4248,__updateWarFightStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4369,__updateRewardStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4424,__buyStuntmanResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4423,__initStuntmanInfoHanlder);
      }
      
      private function __buyStuntmanResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:OprateReplacemntMsg = new OprateReplacemntMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as OprateReplacemntMsg;
         if(_loc2_.op == 1)
         {
            if(_loc2_.result == 1)
            {
               this.stuntman.buyFor(_loc2_.campaignId);
            }
            else
            {
               this.stuntman.buyFor(_loc2_.campaignId,0);
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("worldboss.BuyAvatarFrame.command05"));
            }
         }
         else if(_loc2_.op == 2)
         {
            this.stuntman.cancelBuyFor(_loc2_.campaignId);
         }
      }
      
      private function __initStuntmanInfoHanlder(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ReplacementMsg = new ReplacementMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ReplacementMsg;
         this.stuntman.parseFromString(_loc2_.stateStr);
      }
      
      private function __updateWorldsBossStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:CampaignTemplate = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossStateMsg = new WorldBossStateMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as WorldBossStateMsg;
         var _loc3_:Boolean = false;
         for each(var _loc5_:WorldBossInfoStateMsg in _loc2_.worldBossInfo)
         {
            _loc7_ = TempleteManager.instance.worldBossTemplateDict[_loc5_.campaignId];
            _loc7_.state = _loc5_.state;
         }
         var _loc8_:Dictionary = TempleteManager.instance.worldBossTemplateDict;
         for each(var _loc4_:CampaignTemplate in _loc8_)
         {
            if(_loc4_.state == 0 && WorldBossHelper.checkWorldBoss(_loc4_.CampaignId))
            {
               _loc3_ = true;
            }
         }
         playerInfo.beginChanges();
         playerInfo.worldbossState = _loc3_;
         playerInfo.commit();
      }
      
      private function __updateWarFightStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossStateMsg = new WorldBossStateMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as WorldBossStateMsg;
         for each(var _loc3_:WorldBossInfoStateMsg in _loc2_.worldBossInfo)
         {
            pvpWarIsOpen = _loc3_.state == 0;
         }
         NotificationManager.instance.dispatchEvent(new WorldBossEvent("UPDATE_WARFIGHT_STATE_LIST",{"open":pvpWarIsOpen}));
      }
      
      private function __updateRewardStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:WorldBossWoundRewardMsg = null;
         var _loc6_:WorldRewardVO = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossWoundRewardListMsg = new WorldBossWoundRewardListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as WorldBossWoundRewardListMsg;
         if(CampaignManager.instance.worldBossModel)
         {
            if(!CampaignManager.instance.worldBossModel.rewards)
            {
               CampaignManager.instance.worldBossModel.rewards = [];
               _loc4_ = true;
            }
            if(_loc4_)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_.rewardinfo.length)
               {
                  _loc3_ = _loc2_.rewardinfo[_loc5_];
                  _loc6_ = new WorldRewardVO();
                  _loc6_.campaignId = _loc3_.campaignId;
                  _loc6_.rewardid = _loc3_.rewardid;
                  _loc6_.rewardmsg = _loc3_.rewardmsg;
                  _loc6_.state = _loc3_.state;
                  _loc6_.woundmsg = _loc3_.woundmsg;
                  if(_loc6_.state == 1)
                  {
                     _loc6_.needEffect = false;
                  }
                  CampaignManager.instance.worldBossModel.rewards.push(_loc6_);
                  _loc5_++;
               }
               NotificationManager.instance.dispatchEvent(new WorldBossEvent("REWARDS_INIT",null));
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_.rewardinfo.length)
               {
                  _loc3_ = _loc2_.rewardinfo[_loc5_];
                  for each(_loc6_ in CampaignManager.instance.worldBossModel.rewards)
                  {
                     if(_loc6_.rewardid == _loc3_.rewardid)
                     {
                        _loc6_.state = _loc3_.state;
                     }
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      private function reqWorldBossStates() : void
      {
         WorldBossSocketOutManager.reqWorldBossStates();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

