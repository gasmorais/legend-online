package map.campaign.mediator.npcai
{
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.constant.NpcEffectiveState;
   import map.internals.data.CampaignNode;
   import map.net.MapSocketOuterManager;
   import yishi.events.AiEvents;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class NpcAlertMediator implements IEnterFrame, IMediator
   {
      
      private var _npc:NpcAvatarView;
      
      private var _mapModel:CampaignMapModel;
      
      private var _npcPoint:Point = new Point();
      
      private var _armyPoint:Point = new Point();
      
      public function NpcAlertMediator()
      {
         super();
      }
      
      public function enterFrame() : void
      {
         var _loc3_:int = 0;
         if(!_mapModel || Boolean(_mapModel.exit))
         {
            return;
         }
         if(!_mapModel.selfMemberData)
         {
            return;
         }
         var _loc2_:Object = CampaignManager.instance.controller.getArmyView(_mapModel.selfMemberData);
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.data.state == 4)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            return;
         }
         _npcPoint.x = _npc.x;
         _npcPoint.y = _npc.y;
         _armyPoint.x = _loc2_.x;
         _armyPoint.y = _loc2_.y;
         var _loc4_:int = Point.distance(_npc.npcAiInfo.centerPoint,_armyPoint);
         if(_loc4_ > NpcEffectiveState.ATTACK_RADIUS - 20)
         {
            return;
         }
         var _loc1_:int = Point.distance(_npcPoint,_armyPoint);
         if(_loc1_ > NpcEffectiveState.BATTLE_RADIUS && _loc1_ < NpcEffectiveState.ALERT_RADIUS)
         {
            _loc3_ = int((_npc.nodeInfo as CampaignNode).nodeId);
            _npc.aiInfo.pathInfo = [];
            MapSocketOuterManager.sendAlertState(_loc3_,true);
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
      
      public function register(param1:Object) : void
      {
         _mapModel = CampaignManager.instance.mapModel;
         _npc = param1 as NpcAvatarView;
         if(_npc && (_npc.nodeInfo as CampaignNode).attackTypes == 1)
         {
            _npc.npcAiInfo.addEventListener("moveState",__moveStateHandler);
            __moveStateHandler(null);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         _npc.npcAiInfo.removeEventListener("moveState",__moveStateHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _mapModel = null;
      }
      
      private function __moveStateHandler(param1:AiEvents) : void
      {
         if(_npc.nodeInfo.info.state != 1)
         {
            return;
         }
         if(_npc.npcAiInfo.moveState == 6)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
         else if(_npc.npcAiInfo.moveState == 5)
         {
            if(_mapModel.chckeNpcFriendState(_npc.nodeInfo as CampaignNode))
            {
               return;
            }
            EnterFrameManager.instance.registeEnterFrame(this);
         }
         else if(_npc.npcAiInfo.moveState == 3)
         {
            if(_mapModel.chckeNpcFriendState(_npc.nodeInfo as CampaignNode))
            {
               return;
            }
            EnterFrameManager.instance.registeEnterFrame(this);
         }
         else
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
   }
}

