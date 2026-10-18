package map.outercity.view.layer
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import managers.FreedomTeamManager;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.outercity.OuterCityModel;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.mediator.layer.OutercityNpcActivationMediator;
   import map.outercity.mediator.layer.WalkMouseEventMediator;
   import map.outercity.path.PathMapHitTester;
   import map.outercity.path.SceneScene;
   import map.outercity.view.mapphysics.ArmyView;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.UserArmy;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   
   public class WorldWalkLayer extends Sprite implements IEnterFrame
   {
      
      public static const RENDER_MAX:int = 50;
      
      public static const NAME:String = "map.outercity.view.layer.WorldWalkLayer";
      
      private static const _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _model:OuterCityModel;
      
      private var _pathScene:SceneScene;
      
      private var _walkTarget:MovieClip;
      
      private var _mediatorKey:String;
      
      private var _armyCount:int = 0;
      
      public function WorldWalkLayer()
      {
         super();
         _model = OuterCityManager.instance.model;
         _pathScene = new SceneScene();
         _pathScene.setHitTester(new PathMapHitTester(null));
         _walkTarget = ComponentFactory.Instance.creatCustomObject("asset.outercity.WalkTargetEffectAsset");
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         addChild(_walkTarget);
         EnterFrameManager.instance.registeEnterFrame(this);
         this.addEventListener("addedToStage",__addToStageHandler);
         _model.addEventListener("layMapArmy",__layMapArmyHandler);
         _model.addEventListener("REMOVE_ARMY",__removeArmyHandler);
         this.mouseEnabled = false;
         this.scrollRect = null;
      }
      
      public function get walkTarget() : MovieClip
      {
         return _walkTarget;
      }
      
      public function get pathScene() : SceneScene
      {
         return _pathScene;
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         var _loc2_:Array = [WalkMouseEventMediator,OutercityNpcActivationMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc2_,this,"map.outercity.view.layer.WorldWalkLayer");
      }
      
      private function __removeArmyHandler(param1:OuterCityEvent) : void
      {
         var _loc3_:ArmyView = null;
         var _loc2_:UserArmy = param1.data as UserArmy;
         if(_loc2_)
         {
            _loc3_ = _loc2_.armyView as ArmyView;
            _loc3_ && _loc3_.dispose();
         }
         _loc2_ = null;
      }
      
      private function getArmyById(param1:int) : ArmyView
      {
         var _loc2_:BaseArmy = OuterCityManager.instance.model.getWorldArmyById(param1);
         if(_loc2_)
         {
            return _loc2_.armyView as ArmyView;
         }
         return null;
      }
      
      private function __layMapArmyHandler(param1:OuterCityEvent) : void
      {
         layMapArmy(param1.data as Array);
      }
      
      private function layMapArmy(param1:Array) : void
      {
         var _loc5_:ArmyView = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         for each(var _loc4_:UserArmy in param1)
         {
            if(_loc4_.baseHero.templateInfo)
            {
               _loc5_ = createMapArmy(_loc4_);
               if(_loc5_)
               {
                  addChild(_loc5_);
                  _loc2_ = new Point(_loc5_.x,_loc5_.y);
                  _loc3_ = new Point(_loc4_.curPosX * 20,_loc4_.curPosY * 20);
                  if(_loc5_.x + _loc5_.y == 0 || Point.distance(_loc2_,_loc3_) > 150 && _loc4_.id != ArmyManager.instance.army.id)
                  {
                     _loc5_.x = _loc4_.curPosX * 20;
                     _loc5_.y = _loc4_.curPosY * 20;
                  }
               }
            }
         }
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Dictionary = OuterCityManager.instance.model.allArmyDict;
         for each(var _loc1_:BaseArmy in _loc2_)
         {
            if(_loc1_.armyView is ArmyView)
            {
               (_loc1_.armyView as ArmyView).execute();
            }
         }
      }
      
      public function mouseClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",new Point(this.mouseX,this.mouseY)));
      }
      
      protected function createMapArmy(param1:UserArmy) : ArmyView
      {
         if(!param1 || !OuterCityManager.instance.model.allArmyDict)
         {
            return null;
         }
         if(!(FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.inMyTeam(param1.userId))))
         {
            if(_armyCount >= 50)
            {
               return null;
            }
         }
         var _loc2_:ArmyView = getArmyById(param1.id);
         if(!_loc2_)
         {
            _loc2_ = new ArmyView();
            _loc2_.info = new BaseArmyAiInfo();
         }
         _loc2_.info.speed = ArmySpeedUtils.getMoveSpeed(param1);
         param1.armyView = _loc2_;
         _loc2_.filter = _filter;
         _loc2_.armyInfo = param1;
         _loc2_.mouseChildren = false;
         _loc2_.mouseEnabled = true;
         return _loc2_;
      }
      
      public function dispose() : void
      {
         this.removeEventListener("addedToStage",__addToStageHandler);
         _model.removeEventListener("layMapArmy",__layMapArmyHandler);
         _model.removeEventListener("REMOVE_ARMY",__removeArmyHandler);
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         if(_walkTarget)
         {
            _walkTarget.stop();
            if(_walkTarget.parent)
            {
               _walkTarget.parent.removeChild(_walkTarget);
            }
         }
         _walkTarget = null;
         disposeAllArmyView();
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function disposeAllArmyView() : void
      {
         var _loc2_:ArmyView = null;
         var _loc3_:Dictionary = OuterCityManager.instance.model.allArmyDict;
         for each(var _loc1_:BaseArmy in _loc3_)
         {
            if(_loc1_)
            {
               _loc2_ = _loc1_.armyView as ArmyView;
               _loc2_ && _loc2_.dispose();
            }
         }
         _loc3_ = null;
      }
      
      public function outSceneMovies() : void
      {
         if(!OuterCityManager.instance.model)
         {
            return;
         }
         var _loc3_:Dictionary = OuterCityManager.instance.model.allArmyDict;
         var _loc1_:Dictionary = new Dictionary(true);
         for each(var _loc2_:BaseArmy in _loc3_)
         {
            if(_loc2_.armyView)
            {
               _loc1_[_loc2_.id] = _loc2_.armyView;
            }
         }
         this.dispatchEvent(new OuterCityEvent("DRAG_SCENE_END",[_loc1_]));
      }
   }
}

