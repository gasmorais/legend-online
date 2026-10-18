package gamehall.room
{
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
   import flash.utils.getTimer;
   import gamehall.room.mediator.GameHallWalkDepthMediator;
   import managers.GameHallManager;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.hero.AvatarBaseView;
   import map.internals.view.hero.HeroAvatarView;
   import mvc.module.gamehall.GameHallArmy;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   
   public class GameHallSceneWalkView extends Sprite implements IEnterFrame
   {
      
      public static const RENDER_TICK:int = 500;
      
      public static const NAME:String = "gamehall.room.GameHallSceneWalkView";
      
      private var _mediatorKey:String;
      
      private var _walkTarget:MovieClip;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _armys:Dictionary;
      
      private var _items:Dictionary;
      
      private var _userQueue:Array;
      
      private var _lastTime:int;
      
      private var _renderTime:int;
      
      private const MIN_Y:int = 31;
      
      private const MAX_Y:int = 50;
      
      public function GameHallSceneWalkView()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _armys = new Dictionary(true);
         _items = new Dictionary(true);
         _userQueue = [];
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [GameHallWalkDepthMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"gamehall.room.GameHallSceneWalkView");
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         GameHallManager.instance.model.addEventListener("addGarrison",__addSpaceArmyHandler);
         GameHallManager.instance.model.addEventListener("REMOVE_ARMY",__removeSpaceArmyHandler);
         GameHallManager.instance.model.addEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         GameHallManager.instance.model.removeEventListener("addGarrison",__addSpaceArmyHandler);
         GameHallManager.instance.model.removeEventListener("REMOVE_ARMY",__removeSpaceArmyHandler);
         GameHallManager.instance.model.removeEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
      }
      
      private function __addSpaceArmyHandler(param1:OuterCityEvent) : void
      {
         addToRenderQueue((param1.data as GameHallArmy).userId);
      }
      
      private function __removeSpaceArmyHandler(param1:OuterCityEvent) : void
      {
         removeArmy(param1.data as GameHallArmy);
      }
      
      private function __armyPosBroadHandler(param1:CampaignMapEvent) : void
      {
         var _loc11_:GameHallArmy = null;
         var _loc6_:GameHallArmyView = null;
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
            _loc11_ = GameHallManager.instance.model.getUserArmyByUserId(_loc8_.playerId);
            if(_loc11_)
            {
               _loc6_ = _armys[_loc11_.key] as GameHallArmyView;
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
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc4_:Array = null;
         var _loc7_:Point = new Point(this.mouseX,this.mouseY);
         var _loc2_:GameHallArmy = GameHallManager.instance.model.selfArmy;
         if(!_loc2_)
         {
            return false;
         }
         var _loc5_:Object = getArmyView(_loc2_);
         var _loc3_:Point = new Point(_loc5_.x,_loc5_.y);
         var _loc6_:Point = new Point(_loc5_.x,_loc5_.y);
         if(_loc7_.y < 31 * 20)
         {
            _loc7_.y = 31 * 20;
         }
         else if(_loc7_.y > 50 * 20)
         {
            _loc7_.y = 50 * 20;
         }
         if(_loc7_)
         {
            _loc4_ = [new Point(int(_loc6_.x / 20),int(_loc6_.y / 20)),new Point(int(_loc7_.x / 20),int(_loc7_.y / 20))];
            if(_loc4_)
            {
               _loc5_.aiInfo.pathInfo = _loc4_;
               return true;
            }
         }
         return false;
      }
      
      private function getArmyView(param1:GameHallArmy) : GameHallArmyView
      {
         return _armys[param1.key];
      }
      
      public function addToStage(param1:Event) : void
      {
         initSelf();
         initRegister();
         initPlayers();
      }
      
      protected function initSelf() : void
      {
         var _loc1_:GameHallArmy = GameHallManager.instance.model.selfArmy;
         if(_loc1_)
         {
            addArmy(_loc1_);
         }
      }
      
      protected function initPlayers() : void
      {
         var _loc2_:* = null;
         var _loc1_:Dictionary = GameHallManager.instance.model.allArmyDict;
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
      
      protected function addArmys() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GameHallArmy = null;
         var _loc1_:GameHallArmyView = null;
         _renderTime = getTimer();
         if(_renderTime - _lastTime >= 500)
         {
            if(_userQueue.length > 0)
            {
               _loc2_ = _userQueue.pop();
               _loc3_ = GameHallManager.instance.model.getUserArmyByUserId(_loc2_);
               if(_loc3_)
               {
                  _loc1_ = addArmy(_loc3_);
               }
            }
            _lastTime = _renderTime;
         }
      }
      
      private function addArmy(param1:GameHallArmy) : GameHallArmyView
      {
         if(!_armys || !param1)
         {
            return null;
         }
         if(_armys[param1.key])
         {
            return null;
         }
         if(!param1.baseHero || !param1.baseHero.templateInfo)
         {
            return null;
         }
         var _loc2_:GameHallArmyView = createArmy(param1);
         _loc2_.isPlaying = true;
         addItem(_loc2_,param1.userId);
         _armys[param1.key] = _loc2_;
         _loc2_.x = param1.curPosX * 20;
         _loc2_.y = param1.curPosY * 20;
         return _loc2_;
      }
      
      private function removeArmy(param1:GameHallArmy) : void
      {
         if(!_armys)
         {
            return;
         }
         var _loc2_:GameHallArmyView = _armys[param1.key] as GameHallArmyView;
         if(_loc2_)
         {
            removeItem(_loc2_);
            _loc2_.dispose();
         }
         delete _armys[param1.key];
         ObjectUtils.disposeViolentMc(_loc2_);
         _loc2_ = null;
      }
      
      private function addItem(param1:AvatarBaseView, param2:int) : void
      {
         if(!_items)
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
      
      protected function createArmy(param1:GameHallArmy) : GameHallArmyView
      {
         var _loc2_:GameHallArmyView = new GameHallArmyView();
         var _loc3_:AIBaseInfo = new BaseArmyAiInfo();
         _loc3_.speed = ArmySpeedUtils.getMoveSpeed(param1);
         _loc2_.info = _loc3_;
         _loc2_.data = param1;
         _loc2_.filter = _filter;
         _loc2_.mouseChildren = false;
         _loc2_.mouseEnabled = true;
         return _loc2_;
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
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         for each(var _loc1_:AvatarBaseView in _items)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _items = null;
         for each(var _loc2_:AvatarBaseView in _armys)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         _armys = null;
         _filter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

