package stage3drender
{
   import com.pickgliss.toplevel.StageReferance;
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMsg;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import managers.FreedomTeamManager;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.SpaceNode;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.SpaceSceneController;
   import map.space.data.SpaceArmy;
   import map.space.mediator.layer.SpaceWalkDepthMediator;
   import map.space.mediator.layer.SpaceWalkTargetMediator;
   import stage3drender.avatar.SpaceAvatar;
   import stage3drender.avatar.SpaceNpc;
   import stage3drender.nodes.Stage3dMoviel;
   import starling.animation.IAnimatable;
   import starling.core.AutoSkip;
   import starling.display.Sprite;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.ai.NpcAiInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   
   public class WalkLayer extends Sprite implements IAnimatable
   {
      
      public static const NAME:String = "map.space.view.layer.SpaceWalkLayer";
      
      public static const RENDER_MAX:int = 100;
      
      public static const ROBOT_MAX:int = 100;
      
      private var _mediatorKey:String;
      
      private var _armyCount:int = 0;
      
      private var _model:SpaceModel;
      
      private var _controlder:SpaceSceneController;
      
      private var _walkTarget:Stage3dMoviel;
      
      private var _time:Number = 0;
      
      private var _walk:Boolean = false;
      
      public var frameSkipOption:AutoSkip;
      
      public function WalkLayer()
      {
         super();
         SpaceManager.instance.controller.walkLayer = this;
         _model = SpaceManager.instance.model;
         _controlder = SpaceManager.instance.controller;
         _walkTarget = new Stage3dMoviel();
         _walkTarget.setFrameTextures(Global.avatarTextureDic["WalkTargetEffectAsset"],"WalkTargetEffectAsset");
         SpaceManager.instance.controller.walkTarget = _walkTarget;
         initEvent();
         initSelf();
         initNpc(_model.mapNodesData);
         initPlayers();
         frameSkipOption = new AutoSkip(StageReferance.stage);
      }
      
      private function initNpc(param1:Array) : void
      {
         var _loc2_:SpaceNpc = null;
         var _loc4_:NpcAiInfo = null;
         for each(var _loc3_:SpaceNode in param1)
         {
            if(_loc3_.resource == 1)
            {
               if(_loc3_.info.types != 40)
               {
                  if(_loc3_.info.types != 191)
                  {
                     _loc2_ = new SpaceNpc();
                     _loc2_.x = _loc3_.curPosX * 20;
                     _loc2_.y = _loc3_.curPosY * 20;
                     _loc4_ = new NpcAiInfo();
                     _loc4_.isLiving = true;
                     _loc4_.moveState = 3;
                     _loc4_.centerPoint = new Point(_loc3_.x,_loc3_.y);
                     if(_loc3_.info.types == 1 && _loc3_.patrolPos)
                     {
                        initPathInfo(_loc3_,_loc2_,_loc4_);
                     }
                     _loc2_.info = _loc4_;
                     _controlder.addNpcView(_loc2_);
                     _loc2_.nodeInfo = _loc3_;
                     addChild(_loc2_);
                  }
               }
            }
         }
      }
      
      protected function initSelf() : void
      {
         var _loc1_:SpaceArmy = SpaceManager.instance.model.selfArmy;
         if(_loc1_)
         {
            addArmy(_loc1_);
         }
      }
      
      protected function initPlayers() : void
      {
         var _loc2_:* = null;
         var _loc1_:Dictionary = SpaceManager.instance.model.allArmyDict;
         for each(_loc2_ in _loc1_)
         {
            addArmy(_loc2_);
         }
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("HIDE_OTHERS",__hideOthersHandler);
         SpaceManager.instance.model.addEventListener("addGarrison",__addSpaceArmyHandler);
         SpaceManager.instance.model.addEventListener("REMOVE_ARMY",__removeSpaceArmyHandler);
         SpaceManager.instance.model.addEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
         SpaceManager.instance.model.addEventListener("MOVE_TO_VISIBLE",__armyMoveToVisibleHandler);
         SpaceManager.instance.model.addEventListener("MOVE_TO_UNVISIBLE",__armyMoveToUnVisibleHandler);
         var _loc1_:Array = [SpaceWalkTargetMediator,SpaceWalkDepthMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.space.view.layer.SpaceWalkLayer");
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("HIDE_OTHERS",__hideOthersHandler);
         SpaceManager.instance.model.removeEventListener("addGarrison",__addSpaceArmyHandler);
         SpaceManager.instance.model.removeEventListener("REMOVE_ARMY",__removeSpaceArmyHandler);
         SpaceManager.instance.model.removeEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
         SpaceManager.instance.model.removeEventListener("MOVE_TO_VISIBLE",__armyMoveToVisibleHandler);
         SpaceManager.instance.model.removeEventListener("MOVE_TO_UNVISIBLE",__armyMoveToUnVisibleHandler);
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      private function __hideOthersHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:SpaceAvatar in _controlder.armyViews)
         {
            _loc2_.isPlaying = isPlaying(_loc2_.data.userId);
         }
      }
      
      private function __addSpaceArmyHandler(param1:OuterCityEvent) : void
      {
         addArmy(param1.data as SpaceArmy);
      }
      
      private function __removeSpaceArmyHandler(param1:OuterCityEvent) : void
      {
         removeArmy(param1.data as SpaceArmy);
      }
      
      private function __armyMoveToVisibleHandler(param1:CampaignMapEvent) : void
      {
         addArmy(param1.data as SpaceArmy);
      }
      
      private function __armyMoveToUnVisibleHandler(param1:CampaignMapEvent) : void
      {
         removeArmy(param1.data as SpaceArmy);
      }
      
      private function __armyPosBroadHandler(param1:CampaignMapEvent) : void
      {
         var _loc10_:SpaceArmy = null;
         var _loc6_:SpaceAvatar = null;
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Point = null;
         var _loc3_:int = 0;
         var _loc2_:SpacePlayerMoveMsg = param1.data as SpacePlayerMoveMsg;
         for each(var _loc9_:SpacePlayerMsg in _loc2_.players)
         {
            _loc10_ = SpaceManager.instance.model.getUserArmyByUserId(_loc9_.playerId);
            if(_loc10_)
            {
               _loc5_ = [];
               _loc7_ = int(_loc9_.path.length);
               _loc8_ = 0;
               while(_loc8_ < _loc7_)
               {
                  _loc5_.push(new Point(int(_loc9_.path[_loc8_].x),int(_loc9_.path[_loc8_].y)));
                  _loc8_++;
               }
               _loc6_ = _controlder.armyViews[_loc10_.key] as SpaceAvatar;
               if(_loc6_)
               {
                  _loc4_ = new Point(_loc5_[0].x * 20,_loc5_[0].y * 20);
                  _loc3_ = Point.distance(_loc4_,new Point(_loc6_.x,_loc6_.y));
                  if(_loc3_ > 100)
                  {
                     _loc6_.x = _loc4_.x;
                     _loc6_.y = _loc4_.y;
                  }
                  _loc6_.aiInfo.pathInfo = _loc5_;
               }
            }
         }
      }
      
      private function addArmy(param1:SpaceArmy) : SpaceAvatar
      {
         if(!_controlder.armyViews)
         {
            return null;
         }
         if(param1.isRobot)
         {
            if(_armyCount >= 100)
            {
               return null;
            }
            param1.isAdded = true;
         }
         else if(_armyCount >= 100)
         {
            return null;
         }
         if(_controlder.armyViews[param1.key])
         {
            return null;
         }
         if(!param1.baseHero || !param1.baseHero.templateInfo)
         {
            return null;
         }
         var _loc2_:SpaceAvatar = createArmy(param1);
         _loc2_.isPlaying = isPlaying(_loc2_.data.userId);
         SpaceManager.instance.controller.addArmyView(_loc2_);
         _controlder.armyViews[param1.key] = _loc2_;
         _loc2_.x = param1.curPosX * 20;
         _loc2_.y = param1.curPosY * 20;
         addChild(_loc2_);
         _armyCount = _armyCount + 1;
         return _loc2_;
      }
      
      private function removeArmy(param1:SpaceArmy) : void
      {
         if(!_controlder.armyViews)
         {
            return;
         }
         if(param1.isRobot)
         {
            param1.isAdded = false;
         }
         var _loc2_:SpaceAvatar = _controlder.armyViews[param1.key] as SpaceAvatar;
         if(_loc2_)
         {
            _loc2_.dispose();
            _armyCount = _armyCount - 1;
         }
         if(PlayerManager.instance.currentPlayerModel.selectTarget == param1)
         {
            PlayerManager.instance.currentPlayerModel.selectTarget = null;
         }
         SpaceManager.instance.controller.removeArmyView(_loc2_);
         delete _controlder.armyViews[param1.key];
         _loc2_ = null;
      }
      
      private function createArmy(param1:SpaceArmy) : SpaceAvatar
      {
         var _loc2_:SpaceAvatar = new SpaceAvatar();
         var _loc3_:AIBaseInfo = new BaseArmyAiInfo();
         _loc3_.speed = ArmySpeedUtils.getMoveSpeed(param1);
         _loc2_.info = _loc3_;
         _loc2_.data = param1;
         return _loc2_;
      }
      
      private function initPathInfo(param1:SpaceNode, param2:SpaceNpc, param3:NpcAiInfo) : void
      {
         var _loc4_:Array = null;
         var _loc7_:Point = null;
         var _loc5_:int = 0;
         param2.pathCache = [];
         param3.pathInfo = [];
         var _loc6_:Array = param1.patrolPos.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = _loc6_[_loc5_].split(",");
            _loc7_ = new Point();
            _loc7_.x = _loc4_[0];
            _loc7_.y = _loc4_[1];
            param2.pathCache.push(_loc7_);
            param3.pathInfo.push(_loc7_);
            _loc5_++;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(this.frameSkipOption)
         {
            if(this.frameSkipOption.requestFrameSkip())
            {
               return;
            }
         }
         for each(var _loc3_:SpaceAvatar in _controlder.armyViews)
         {
            _loc3_.advanceTime(param1);
         }
         for each(var _loc2_:SpaceNpc in _controlder.npcList)
         {
            _loc2_.advanceTime(param1);
         }
      }
      
      private function randomAtoB(param1:int, param2:int) : int
      {
         return Math.random() * (param2 - param1) + param1;
      }
      
      private function isPlaying(param1:int) : Boolean
      {
         if(param1 != SpaceManager.instance.model.selfArmy.userId)
         {
            if(FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.inMyTeam(param1)))
            {
               return true;
            }
            return !SharedManager.instance.hideOthers;
         }
         return true;
      }
      
      override public function dispose() : void
      {
         var _loc1_:SpaceAvatar = null;
         removeEvent();
         for(var _loc3_:String in _controlder.armyViews)
         {
            _loc1_ = _controlder.armyViews[_loc3_] as SpaceAvatar;
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            delete _controlder.armyViews[_loc3_];
         }
         for each(var _loc2_:SpaceNpc in _controlder.npcList)
         {
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
         _controlder.npcList.length = 0;
         _controlder.armyList.length = 0;
         _walkTarget.dispose();
         _walkTarget = null;
         SpaceManager.instance.controller.walkTarget = null;
         _model = null;
         _controlder = null;
      }
   }
}

