package map.campaign.mediator.npcai
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.helper.SearchPathHelper;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.constant.NpcEffectiveState;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicsEvent;
   import map.net.MapSocketOuterManager;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.events.AiEvents;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.LocalConnectionManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tools.SimpleMovie;
   
   public class NpcAttackAndChaseMediator implements IMediator, IEnterFrame
   {
      
      private var _npc:NpcAvatarView;
      
      private var _attackArmy:Object;
      
      private var _aiInfo:BaseArmyAiInfo;
      
      private var _alertIcon:MovieClip;
      
      private var _attackView:MovieClip;
      
      private var _isFirst:Boolean = true;
      
      private var _count:int;
      
      private var _preDis:int;
      
      public function NpcAttackAndChaseMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _npc = param1 as NpcAvatarView;
         _npc.nodeInfo.info.addEventListener("UP_STATE",__stateHandler);
         _npc.npcAiInfo.addEventListener("moveState",__aiMoveStateHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         removeAlertIcon();
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _npc.nodeInfo.info.removeEventListener("UP_STATE",__stateHandler);
         _npc.npcAiInfo.removeEventListener("moveState",__aiMoveStateHandler);
      }
      
      private function __stateHandler(param1:PhysicsEvent) : void
      {
         if(_npc.nodeInfo.info.state != 1)
         {
            if(_attackArmy)
            {
               _attackArmy.aiInfo.removeEventListener("updatePaths",__updatePathHandler);
            }
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
      
      private function __aiMoveStateHandler(param1:AiEvents) : void
      {
         if(!_npc || !_npc.nodeInfo.info || _npc.nodeInfo.info.state != 1)
         {
            return;
         }
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.chckeNpcFriendState(_npc.nodeInfo as CampaignNode))
         {
            return;
         }
         if(_npc.npcAiInfo.moveState == 6)
         {
            _attackArmy = getArmyView(_npc.npcAiInfo.attackArmyId,_npc.npcAiInfo.attackArmyServerName);
            if(!_attackArmy)
            {
               return;
            }
            _aiInfo = _attackArmy.aiInfo;
            _aiInfo.addEventListener("updatePaths",__updatePathHandler);
            _preDis = 10000;
            removeAlertIcon();
            _alertIcon = ComponentFactory.Instance.creatCustomObject("asset.campaign.attack.AlerMovieAsset");
            _alertIcon.y = -100;
            -_alertIcon.height;
            if(_isFirst)
            {
               SoundManager.instance.play("036");
               _isFirst = false;
            }
            _npc.addChild(_alertIcon);
            EnterFrameManager.instance.registeEnterFrame(this);
         }
         else
         {
            removeAlertIcon();
            if(_aiInfo)
            {
               _aiInfo.removeEventListener("updatePaths",__updatePathHandler);
            }
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
      
      private function removeAlertIcon() : void
      {
         if(_alertIcon)
         {
            _alertIcon.stop();
            if(_alertIcon.parent)
            {
               _alertIcon.parent.removeChild(_alertIcon);
            }
         }
         _alertIcon = null;
      }
      
      private function __updatePathHandler(param1:AiEvents) : void
      {
         searchPath();
         _count = 1;
      }
      
      private function searchPath() : void
      {
         var _loc3_:Array = null;
         var _loc1_:Array = null;
         var _loc2_:Point = CampaignManager.instance.mapModel.getAroundWalkPoint(_npc.x,_npc.y);
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:Point = CampaignManager.instance.mapModel.getAroundWalkPoint(_attackArmy.x,_attackArmy.y);
         if(!_loc4_)
         {
            return;
         }
         if(ExternalInterface.available && Boolean(LocalConnectionManager.instance.isUse))
         {
            _loc3_ = [_npc.x,_npc.y,_attackArmy.x,_attackArmy.y];
            LocalConnectionManager.instance.Call("searchPathAngle",_loc3_,searchPathSyc,null);
         }
         else
         {
            _loc1_ = SearchPathHelper.searchPath(new Point(_npc.x,_npc.y),new Point(_loc4_.x * 20,_loc4_.y * 20));
            if(!_loc1_)
            {
               return;
            }
            if(_loc1_.length > 2)
            {
               _loc1_.shift();
            }
            _npc.aiInfo.pathInfo = _loc1_;
         }
      }
      
      private function searchPathSyc(param1:Array, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(!param1 && !_npc && !_npc.aiInfo)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            param1[_loc3_] = new Point(param1[_loc3_].x,param1[_loc3_].y);
            _loc3_++;
         }
         if(param1.length > 2)
         {
            param1.shift();
         }
         _npc.aiInfo.pathInfo = param1;
      }
      
      public function enterFrame() : void
      {
         var _loc3_:Point = new Point(_attackArmy.x,_attackArmy.y);
         var _loc6_:int = Point.distance(_npc.npcAiInfo.centerPoint,_loc3_);
         var _loc2_:int = Point.distance(new Point(_npc.x,_npc.y),_loc3_);
         var _loc4_:int = int((_npc.nodeInfo as CampaignNode).nodeId);
         var _loc1_:CampaignArmy = getArmyViewByArmyId(_npc.npcAiInfo.attackArmyId,_npc.npcAiInfo.attackArmyServerName);
         if(!_loc1_)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            return;
         }
         var _loc5_:Boolean = selfId == _loc1_.userId ? true : false;
         if(_attackArmy.data.state == 2)
         {
            _npc.nodeInfo.chatData = null;
            _aiInfo.pathInfo = [];
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            MapSocketOuterManager.sendAlertState(_loc4_,false);
            return;
         }
         if(_loc2_ < NpcEffectiveState.BATTLE_RADIUS && _loc5_)
         {
            _aiInfo.pathInfo = [];
            _npc.aiInfo.pathInfo = [];
            startAttack();
            NotificationManager.instance.dispatchEvent(new NotificationEvent("sendCampaignArrive",null));
            CampaignManager.instance.controller.sendCampaignArrive(selfId,(_npc.nodeInfo as CampaignNode).nodeId);
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            return;
         }
         _count = _count + 1;
         if((_loc6_ > NpcEffectiveState.ATTACK_RADIUS || _loc2_ > NpcEffectiveState.ALERT_RADIUS + 10) && _loc5_)
         {
            _npc.nodeInfo.chatData = null;
            MapSocketOuterManager.sendAlertState(_loc4_,false);
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            return;
         }
         if(_loc2_ > NpcEffectiveState.BATTLE_RADIUS && (_count % 5 == 0 && _preDis < _loc6_ || _count % 20 == 0))
         {
            searchPath();
         }
         _preDis = _loc6_;
      }
      
      private function getArmyView(param1:int, param2:String = "") : Object
      {
         var _loc4_:CampaignArmy = getArmyViewByArmyId(param1,param2);
         var _loc3_:Object = CampaignManager.instance.controller.getArmyView(_loc4_);
         if(_loc4_)
         {
            return _loc3_;
         }
         return null;
      }
      
      private function getArmyViewByArmyId(param1:int, param2:String = "") : CampaignArmy
      {
         return CampaignManager.instance.mapModel.getUserArmyByArmyId(param1,param2);
      }
      
      private function get selfId() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      private function startAttack() : void
      {
         if(!_attackView)
         {
            _attackView = ComponentFactory.Instance.creatCustomObject("asset.campaign.attack.AttackMovieAsset");
         }
         var _loc1_:SimpleMovie = new SimpleMovie(_attackView,__call);
         _attackView.y = -100;
         _npc.addChild(_loc1_);
      }
      
      private function __call() : void
      {
         if(_attackView)
         {
            if(_attackView.parent)
            {
               _attackView.parent.removeChild(_attackView);
            }
            _attackView.stop();
         }
         _attackView = null;
      }
   }
}

