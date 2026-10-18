package map.campaign.mediator.npcai
{
   import flash.display.Bitmap;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.constant.NpcEffectiveState;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicsEvent;
   import yishi.events.AiEvents;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class NpcAttackIIMediator implements IMediator, IEnterFrame
   {
      
      private var _attackArmy:Object;
      
      private var _npc:NpcAvatarView;
      
      private var _alertIcon:Bitmap;
      
      private var _handlerRange:int;
      
      private var _mapModel:CampaignMapModel;
      
      private var _hasAttacked:Boolean = false;
      
      public function NpcAttackIIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _npc = param1 as NpcAvatarView;
         _mapModel = CampaignManager.instance.mapModel;
         var _loc2_:int = int(_mapModel.mapId);
         _npc.nodeInfo.info.addEventListener("UP_STATE",__stateHandler);
         _npc.npcAiInfo.addEventListener("moveState",__aiMoveStateHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _npc.nodeInfo.info.removeEventListener("UP_STATE",__stateHandler);
         _npc.npcAiInfo.removeEventListener("moveState",__aiMoveStateHandler);
         _mapModel = null;
      }
      
      private function __stateHandler(param1:PhysicsEvent) : void
      {
         if(_npc.nodeInfo.info.state != 1)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
      
      private function __aiMoveStateHandler(param1:AiEvents) : void
      {
         if(_hasAttacked)
         {
            _hasAttacked = false;
            return;
         }
         if(_npc.nodeInfo.info.state != 1)
         {
            return;
         }
         if(_npc.npcAiInfo.moveState == 5 || _npc.npcAiInfo.moveState == 3)
         {
            _handlerRange = ((_npc.nodeInfo as CampaignNode).handlerRange + 1) * 20;
            _handlerRange = _handlerRange > 20 ? _handlerRange : int(NpcEffectiveState.BATTLE_RADIUS);
            _attackArmy = getArmyView(selfArmyId);
            if(_attackArmy)
            {
               EnterFrameManager.instance.registeEnterFrame(this);
            }
         }
         else
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
      
      public function enterFrame() : void
      {
         var _loc3_:int = 0;
         if(!_mapModel || Boolean(_mapModel.exit))
         {
            return;
         }
         var _loc2_:Point = new Point(_attackArmy.x,_attackArmy.y);
         var _loc1_:int = Point.distance(new Point(_npc.x,_npc.y),_loc2_);
         var _loc4_:int = int((_npc.nodeInfo as CampaignNode).nodeId);
         if(_attackArmy.data.state == 2)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            _npc.nodeInfo.chatData = null;
            _attackArmy.aiInfo.pathInfo = [];
            return;
         }
         if(_loc1_ < _handlerRange && _attackArmy.data.isDie == 0)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            _attackArmy.aiInfo.pathInfo = [];
            _npc.aiInfo.pathInfo = [];
            _loc3_ = int(_mapModel.mapId);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("sendCampaignArrive",null));
            CampaignManager.instance.controller.sendCampaignArrive(selfId,(_npc.nodeInfo as CampaignNode).nodeId);
            _hasAttacked = true;
            return;
         }
      }
      
      private function getArmyView(param1:int) : Object
      {
         var _loc3_:CampaignArmy = getArmyViewByArmyId(param1);
         var _loc2_:Object = CampaignManager.instance.controller.getArmyView(_loc3_);
         if(_loc3_)
         {
            return _loc2_;
         }
         return null;
      }
      
      private function getArmyViewByArmyId(param1:int) : CampaignArmy
      {
         var _loc2_:String = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         return _mapModel.getUserArmyByArmyId(param1,_loc2_);
      }
      
      private function get selfArmyId() : int
      {
         return ArmyManager.instance.army.id;
      }
      
      private function get selfId() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
   }
}

