package map.campaign.mediator.npcai
{
   import avatar.view.HumanAvatar;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.view.physics.GodsEveningArmyView;
   import map.campaign.view.physics.MineralArmyView;
   import map.campaign.view.physics.MineralCarView;
   import map.campaign.view.physics.NpcAvatarView;
   import map.campaign.view.physics.PvpWarFightArmyView;
   import map.internals.data.CampaignNode;
   import yishi.events.AiEvents;
   import yishi.interfaces.IMediator;
   import yishi.utils.WorldBossHelper;
   
   public class NpcStateMediator implements IMediator
   {
      
      private var _npc:NpcAvatarView;
      
      public function NpcStateMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _npc = param1 as NpcAvatarView;
         _npc.npcAiInfo.addEventListener("moveState",__moveStateHandler);
         __moveStateHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         _npc.npcAiInfo.removeEventListener("moveState",__moveStateHandler);
      }
      
      private function __moveStateHandler(param1:AiEvents) : void
      {
         var _loc4_:Object = null;
         var _loc13_:int = 0;
         var _loc10_:CampaignNode = null;
         var _loc11_:int = 0;
         var _loc8_:CampaignArmy = null;
         var _loc6_:CampaignNode = null;
         var _loc3_:int = 0;
         var _loc9_:CampaignArmy = null;
         var _loc12_:CampaignNode = null;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc7_:CampaignArmy = null;
         if(_npc.npcAiInfo.moveState == 6)
         {
            _npc.npcAiInfo.speed = 6;
            (_npc.avatarView as HumanAvatar).stepFrame = 2;
         }
         else if(_npc.npcAiInfo.moveState == 5)
         {
            _npc.npcAiInfo.speed = 4;
            (_npc.avatarView as HumanAvatar).stepFrame = 2;
         }
         else
         {
            if(_npc.npcAiInfo.moveState == 3)
            {
               _npc.npcAiInfo.nextPoint = new Point(_npc.x,_npc.y);
               (_npc.avatarView as HumanAvatar).stepFrame = 5;
               return;
            }
            if(_npc.npcAiInfo.moveState == 4)
            {
               _loc13_ = int(CampaignManager.instance.mapModel.mapId);
               if(WorldBossHelper.checkPvp(_loc13_))
               {
                  if(_npc.nodeInfo is CampaignNode)
                  {
                     _loc10_ = _npc.nodeInfo as CampaignNode;
                     _loc11_ = int(_loc10_.followTarget);
                     _loc8_ = CampaignManager.instance.mapModel.getUserArmyByArmyId(_loc11_);
                     _loc4_ = CampaignManager.instance.controller.getArmyView(_loc8_);
                     if(_loc8_ && _loc4_ && _loc4_ is PvpWarFightArmyView)
                     {
                        _loc4_.changeSpeedTo(0.5);
                        _npc.npcAiInfo.speed = _loc4_.info.speed;
                     }
                     else
                     {
                        _npc.npcAiInfo.speed = 4;
                     }
                  }
                  else
                  {
                     _npc.npcAiInfo.speed = 4;
                  }
               }
               else if(WorldBossHelper.checkMineral(_loc13_))
               {
                  if(_npc.nodeInfo is CampaignNode)
                  {
                     _loc6_ = _npc.nodeInfo as CampaignNode;
                     _loc3_ = int(_loc6_.followTarget);
                     _loc9_ = CampaignManager.instance.mapModel.getUserArmyByArmyId(_loc3_);
                     _loc4_ = CampaignManager.instance.controller.getArmyView(_loc9_);
                     if(inMineralAndHasMinerals)
                     {
                        _loc4_.changeSpeedTo(0.5);
                     }
                     _npc.npcAiInfo.speed = _loc4_.info.speed;
                  }
                  else
                  {
                     _npc.npcAiInfo.speed = 4;
                  }
               }
               else if(WorldBossHelper.checkGodsEvening(_loc13_))
               {
                  if(_npc.nodeInfo is CampaignNode)
                  {
                     _loc12_ = _npc.nodeInfo as CampaignNode;
                     _loc2_ = int(_loc12_.followTarget);
                     _loc5_ = _loc12_.followTargetServiceName;
                     _loc7_ = CampaignManager.instance.mapModel.getUserArmyByArmyId(_loc2_,_loc5_);
                     _loc4_ = CampaignManager.instance.controller.getArmyView(_loc7_);
                     if(_loc7_ && _loc4_ && _loc4_ is GodsEveningArmyView)
                     {
                        _loc4_.changeSpeedTo(0.5);
                        _npc.npcAiInfo.speed = _loc4_.info.speed;
                     }
                     else
                     {
                        _npc.npcAiInfo.speed = 4;
                     }
                  }
                  else
                  {
                     _npc.npcAiInfo.speed = 4;
                  }
               }
               (_npc.avatarView as HumanAvatar).stepFrame = 3;
            }
         }
      }
      
      private function get inMineralAndHasMinerals() : Boolean
      {
         var _loc1_:CampaignNode = _npc.nodeInfo as CampaignNode;
         var _loc2_:int = int(_loc1_.followTarget);
         var _loc4_:CampaignArmy = CampaignManager.instance.mapModel.getUserArmyByArmyId(_loc2_);
         var _loc3_:Object = CampaignManager.instance.controller.getArmyView(_loc4_);
         if(_npc is MineralCarView && _loc4_ && _loc3_ is MineralArmyView)
         {
            if((_npc as MineralCarView).cadInfo && (_npc as MineralCarView).cadInfo.minerals > 0)
            {
               return true;
            }
         }
         return false;
      }
   }
}

