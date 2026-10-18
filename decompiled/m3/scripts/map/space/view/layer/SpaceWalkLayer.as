package map.space.view.layer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMsg;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import managers.FreedomTeamManager;
   import managers.MarryManager;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.hero.AvatarBaseView;
   import map.internals.view.hero.HeroAvatarView;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.mediator.layer.SpaceWalkDepthMediator;
   import map.space.mediator.layer.SpaceWalkTargetMediator;
   import map.space.view.physics.SpaceArmyView;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.SpaceTemplateManager;
   
   public class SpaceWalkLayer extends Sprite implements IEnterFrame
   {
      
      public static const RENDER_MAX:int = 30;
      
      public static const ROBOT_MAX:int = 10;
      
      public static const RENDER_TICK:int = 500;
      
      public static const NAME:String = "map.space.view.layer.SpaceWalkLayer";
      
      private var _mediatorKey:String;
      
      private var _walkTarget:MovieClip;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _armyCount:int = 0;
      
      private var _armys:Dictionary;
      
      private var _items:Dictionary;
      
      private var _userQueue:Array;
      
      private var _robotQueue:Array;
      
      private var _lastTime:int;
      
      private var _renderTime:int;
      
      private var _initPlayersTimeId:int;
      
      private var _initPlayersFlag:Boolean = false;
      
      public function SpaceWalkLayer()
      {
         super();
         init();
         addEvent();
      }
      
      public function get needRobotCount() : int
      {
         if(_initPlayersFlag)
         {
            return 10 - _armyCount - _userQueue.length - _robotQueue.length;
         }
         return 0;
      }
      
      private function init() : void
      {
         _armys = new Dictionary(true);
         _items = new Dictionary(true);
         _userQueue = [];
         _robotQueue = [];
         _walkTarget = ComponentFactory.Instance.creatCustomObject("asset.outercity.WalkTargetEffectAsset");
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         SpaceManager.instance.controller.walkTarget = _walkTarget;
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [SpaceWalkTargetMediator,SpaceWalkDepthMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.space.view.layer.SpaceWalkLayer");
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         SpaceManager.instance.model.addEventListener("addGarrison",__addSpaceArmyHandler);
         SpaceManager.instance.model.addEventListener("REMOVE_ARMY",__removeSpaceArmyHandler);
         SpaceManager.instance.model.addEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
         SpaceManager.instance.model.addEventListener("MOVE_TO_VISIBLE",__armyMoveToVisibleHandler);
         SpaceManager.instance.model.addEventListener("MOVE_TO_UNVISIBLE",__armyMoveToUnVisibleHandler);
         NotificationManager.instance.addEventListener("HIDE_OTHERS",__hideOthersHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         SpaceManager.instance.model.removeEventListener("addGarrison",__addSpaceArmyHandler);
         SpaceManager.instance.model.removeEventListener("REMOVE_ARMY",__removeSpaceArmyHandler);
         SpaceManager.instance.model.removeEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
         SpaceManager.instance.model.removeEventListener("MOVE_TO_VISIBLE",__armyMoveToVisibleHandler);
         SpaceManager.instance.model.removeEventListener("MOVE_TO_UNVISIBLE",__armyMoveToUnVisibleHandler);
         NotificationManager.instance.removeEventListener("HIDE_OTHERS",__hideOthersHandler);
      }
      
      private function __hideOthersHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:SpaceArmyView in _armys)
         {
            _loc2_.isPlaying = isPlaying(_loc2_.data.userId);
         }
      }
      
      private function __armyMoveToVisibleHandler(param1:CampaignMapEvent) : void
      {
         addToRobotRenderQueue((param1.data as SpaceArmy).userId);
      }
      
      private function __armyMoveToUnVisibleHandler(param1:CampaignMapEvent) : void
      {
         removeArmy(param1.data as SpaceArmy);
      }
      
      private function __addSpaceArmyHandler(param1:OuterCityEvent) : void
      {
         addToRenderQueue((param1.data as SpaceArmy).userId);
      }
      
      private function __removeSpaceArmyHandler(param1:OuterCityEvent) : void
      {
         removeArmy(param1.data as SpaceArmy);
      }
      
      public function get armys() : Dictionary
      {
         return _armys;
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
      
      private function addArmy(param1:SpaceArmy) : SpaceArmyView
      {
         if(!_armys || !param1)
         {
            return null;
         }
         if(param1.isRobot)
         {
            if(_armyCount >= 10)
            {
               return null;
            }
            param1.isAdded = true;
         }
         else if(!(FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.inMyTeam(param1.userId))))
         {
            if(_armyCount >= 30)
            {
               return null;
            }
         }
         if(_armys[param1.key])
         {
            return null;
         }
         if(!param1.baseHero || !param1.baseHero.templateInfo)
         {
            return null;
         }
         var _loc2_:SpaceArmyView = createArmy(param1);
         _loc2_.isPlaying = isPlaying(param1.userId);
         addItem(_loc2_,param1.userId);
         _armys[param1.key] = _loc2_;
         _loc2_.x = param1.curPosX * 20;
         _loc2_.y = param1.curPosY * 20;
         _armyCount = _armyCount + 1;
         return _loc2_;
      }
      
      private function removeArmy(param1:SpaceArmy) : void
      {
         if(!_armys)
         {
            return;
         }
         if(param1.isRobot)
         {
            param1.isAdded = false;
         }
         var _loc2_:SpaceArmyView = _armys[param1.key] as SpaceArmyView;
         if(_loc2_)
         {
            removeItem(_loc2_);
            _loc2_.dispose();
            _armyCount = _armyCount - 1;
         }
         if(PlayerManager.instance.currentPlayerModel.selectTarget == param1)
         {
            PlayerManager.instance.currentPlayerModel.selectTarget = null;
         }
         delete _armys[param1.key];
         ObjectUtils.disposeViolentMc(_loc2_);
         _loc2_ = null;
      }
      
      private function __armyPosBroadHandler(param1:CampaignMapEvent) : void
      {
         var _loc11_:SpaceArmy = null;
         var _loc6_:SpaceArmyView = null;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:Point = null;
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc10_:int = 0;
         var _loc9_:Point = null;
         var _loc2_:SpacePlayerMoveMsg = param1.data as SpacePlayerMoveMsg;
         for each(var _loc8_:SpacePlayerMsg in _loc2_.players)
         {
            _loc11_ = SpaceManager.instance.model.getUserArmyByUserId(_loc8_.playerId);
            if(_loc11_)
            {
               _loc6_ = _armys[_loc11_.key] as SpaceArmyView;
               if(_loc6_)
               {
                  _loc12_ = [];
                  _loc13_ = int(_loc8_.path.length);
                  _loc7_ = 0;
                  while(_loc7_ < _loc13_)
                  {
                     _loc12_.push(new Point(int(_loc8_.path[_loc7_].x),int(_loc8_.path[_loc7_].y)));
                     _loc7_++;
                  }
                  _loc4_ = new Point(_loc12_[0].x * 20,_loc12_[0].y * 20);
                  _loc3_ = Point.distance(_loc4_,new Point(_loc6_.x,_loc6_.y));
                  if(_loc3_ > 250)
                  {
                     _loc6_.x = _loc4_.x;
                     _loc6_.y = _loc4_.y;
                  }
                  else
                  {
                     _loc10_ = int(_loc6_.info.nextIndex);
                     if(_loc6_.info.pathInfo && _loc6_.info.pathInfo.length >= _loc10_)
                     {
                        _loc5_ = _loc6_.info.pathInfo.slice(_loc10_);
                     }
                  }
                  if(_loc5_)
                  {
                     _loc12_ = _loc5_.concat(_loc12_);
                  }
                  _loc9_ = _loc6_.getTilePos();
                  if(!_loc9_.equals(_loc12_[0]))
                  {
                     _loc12_.unshift(_loc9_);
                  }
                  _loc12_ = PathPointUtils.optimizePath(_loc12_);
                  _loc6_.info.pathInfo = _loc12_;
               }
            }
         }
      }
      
      public function addToStage(param1:Event) : void
      {
         initSelf();
         initRegister();
         _initPlayersTimeId = setTimeout(clearInitPlayersTimeId,5000);
      }
      
      private function clearInitPlayersTimeId() : void
      {
         if(_initPlayersTimeId > 0)
         {
            clearTimeout(_initPlayersTimeId);
         }
         _initPlayersTimeId = 0;
         _initPlayersFlag = true;
         initPlayers();
      }
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         if(param1)
         {
            if(param1.target is SpaceArmyView)
            {
               if((param1.target as SpaceArmyView).mouseClickHandler(param1))
               {
                  return true;
               }
            }
         }
         SpaceManager.instance.model.selectNode = null;
         PlayerManager.instance.currentPlayerModel.reinforce = null;
         return SpaceManager.instance.controller.moveArmyByPos(this.mouseX,this.mouseY,true);
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
            addToRenderQueue(_loc2_.userId);
         }
      }
      
      protected function addToRenderQueue(param1:int) : void
      {
         if(_userQueue.indexOf(param1) == -1)
         {
            _userQueue.push(param1);
         }
      }
      
      protected function addToRobotRenderQueue(param1:int) : void
      {
         if(_robotQueue.indexOf(param1) == -1)
         {
            _robotQueue.push(param1);
         }
      }
      
      protected function addArmys() : void
      {
         var _loc2_:int = 0;
         var _loc3_:SpaceArmy = null;
         var _loc1_:SpaceArmyView = null;
         _renderTime = getTimer();
         if(_renderTime - _lastTime >= 500)
         {
            if(_userQueue.length > 0)
            {
               _loc2_ = _userQueue.pop();
               _loc3_ = SpaceManager.instance.model.getUserArmyByUserId(_loc2_);
               if(_loc3_)
               {
                  _loc1_ = addArmy(_loc3_);
               }
            }
            else if(_robotQueue.length > 0)
            {
               _loc2_ = _robotQueue.pop();
               _loc3_ = SpaceTemplateManager.instance.getRobotArmyInfoByUserId(_loc2_);
               if(_loc3_)
               {
                  _loc1_ = addArmy(_loc3_);
               }
            }
            _lastTime = _renderTime;
         }
      }
      
      protected function createArmy(param1:SpaceArmy) : SpaceArmyView
      {
         var _loc2_:SpaceArmyView = new SpaceArmyView();
         var _loc3_:AIBaseInfo = new BaseArmyAiInfo();
         _loc3_.speed = ArmySpeedUtils.getMoveSpeed(param1);
         _loc2_.info = _loc3_;
         _loc2_.data = param1;
         _loc2_.filter = _filter;
         _loc2_.mouseChildren = false;
         _loc2_.mouseEnabled = true;
         SpaceManager.instance.controller.addArmyView(_loc2_);
         return _loc2_;
      }
      
      public function removeItem(param1:AvatarBaseView) : void
      {
         _items[param1] = null;
         delete _items[param1];
         var _loc2_:DisplayObject = param1 as DisplayObject;
         if(_loc2_)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
      }
      
      private function addItem(param1:AvatarBaseView, param2:int) : void
      {
         if(!_items)
         {
            return;
         }
         if(!MarryManager.instance.model)
         {
            return;
         }
         if(!MarryManager.instance.model.carUserIdDic)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         addChild(param1);
         _items[param1] = param1;
      }
      
      public function enterFrame() : void
      {
         if(!_items)
         {
            return;
         }
         for each(var _loc1_:AvatarBaseView in _items)
         {
            _loc1_.execute();
            if(!_loc1_.isLiving)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
               _loc1_ = null;
            }
         }
         addArmys();
      }
      
      public function stop() : void
      {
         if(!_items)
         {
            return;
         }
         for each(var _loc1_:HeroAvatarView in _items)
         {
            if(_loc1_)
            {
               _loc1_.avatarView.stop();
            }
         }
      }
      
      public function dispose() : void
      {
         if(_initPlayersTimeId > 0)
         {
            clearTimeout(_initPlayersTimeId);
         }
         _initPlayersTimeId = 0;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         for each(var _loc2_:AvatarBaseView in _items)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
         _items = null;
         for each(var _loc1_:AvatarBaseView in _armys)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            _loc1_ = null;
         }
         _armys = null;
         ObjectUtils.disposeViolentMc(_walkTarget);
         SpaceManager.instance.controller.walkTarget = null;
         _walkTarget = null;
         _userQueue = null;
         _robotQueue = null;
         _filter = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

