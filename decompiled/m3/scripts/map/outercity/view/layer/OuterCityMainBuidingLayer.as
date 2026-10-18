package map.outercity.view.layer
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import map.internals.data.BaseCastle;
   import map.internals.data.MapInfo;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicInfo;
   import map.internals.data.WildLand;
   import map.internals.event.OuterCityEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.mediator.layer.OuterCityBuildingSelectMediator;
   import map.internals.view.displaye.PhysicsMenu;
   import map.internals.view.physics.MapPhysicsBase;
   import map.internals.view.physics.PhysicsStaticView;
   import map.outercity.OuterCityModel;
   import map.outercity.mediator.layer.OutercityNpcActivationMediator;
   import map.outercity.view.mapphysics.MapPhysicsCastle;
   import map.outercity.view.mapphysics.MapPhysicsField;
   import map.outercity.view.mapphysics.MapPhysicsTreasure;
   import map.outercity.view.mapphysics.OuterCityNpcView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class OuterCityMainBuidingLayer extends Sprite implements Disposeable
   {
      
      public static const NAME:String = "map.outercity.view.layer.OuterCityMainBuidingLayer";
      
      private var _mediatorKey:String = "";
      
      private var _model:OuterCityModel;
      
      private var _filter:SimpleBuildingFilter;
      
      private var _buildList:Dictionary = new Dictionary();
      
      public function OuterCityMainBuidingLayer()
      {
         super();
         _filter = new SimpleBuildingFilter();
         this.mouseEnabled = false;
         this.scrollRect = null;
         PhysicsMenu.getInstance().paretnContainer = this;
         initRegister();
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [OuterCityBuildingSelectMediator,OutercityNpcActivationMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.outercity.view.layer.OuterCityMainBuidingLayer");
      }
      
      public function set mapData(param1:MapInfo) : void
      {
         _model = param1 as OuterCityModel;
         _model.addEventListener("currentCastles",__initCurrentCastlesHandler);
         _model.addEventListener("currentWildLand",__initCurrentWildLandHandler);
         _model.addEventListener("currentConfigChange",__moviesHandler);
         _model.addEventListener("REMOVE_NODE_MOVIE",__removeNodeHandler);
         _model.addEventListener("REMOVE_CASTLE",__removeCastleHandler);
      }
      
      private function __moviesHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_ && _loc2_.hasOwnProperty("movies") && _loc2_.hasOwnProperty("tops"))
         {
            addMoviesByLayer(_loc2_.movies as Array,0);
            addMoviesByLayer(_loc2_.tops as Array,2);
         }
      }
      
      private function addMoviesByLayer(param1:Array, param2:int) : void
      {
         var _loc6_:WildLand = null;
         var _loc4_:MapPhysicsBase = null;
         var _loc5_:PhysicInfo = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:Dictionary = _model.staticMovies;
         for each(var _loc7_:Object in param1)
         {
            _loc6_ = _loc3_[_loc7_.x + "," + _loc7_.y] as WildLand;
            if(!(_loc6_ && _loc6_.nodeView && _loc6_.nodeView.parent))
            {
               if(!_loc6_)
               {
                  _loc6_ = new WildLand();
               }
               _loc4_ = _loc6_.nodeView as PhysicsStaticView;
               if(!_loc4_)
               {
                  _loc4_ = new PhysicsStaticView();
               }
               _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
               _loc4_.scrollRect = null;
               _loc6_.nodeView = _loc4_;
               _loc5_ = _loc6_.info;
               if(!_loc5_)
               {
                  _loc5_ = new PhysicInfo();
               }
               _loc5_.types = 201;
               _loc5_.state = 1;
               _loc5_.names = _loc7_.url;
               _loc5_.posX = _loc7_.x / 20;
               _loc5_.posY = _loc7_.y / 20;
               _loc6_.info = _loc5_;
               _loc4_.rotation = _loc7_.rotation;
               _loc4_.info = _loc6_;
               _loc4_.x = _loc7_.x;
               _loc4_.y = _loc7_.y;
               if(param2 == 0)
               {
                  addChildAt(_loc4_,0);
               }
               else if(param2 == 2)
               {
                  addChild(_loc4_);
               }
               _model.addStaticMovie(_loc6_,_loc7_.x + "," + _loc7_.y);
            }
         }
      }
      
      private function __initCurrentCastlesHandler(param1:OuterCityEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:BaseCastle = null;
         var _loc4_:MapPhysicsCastle = null;
         var _loc2_:Array = param1.data as Array;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_] as BaseCastle;
            _loc4_ = _loc3_.nodeView as MapPhysicsCastle;
            if(!_loc4_)
            {
               _loc4_ = new MapPhysicsCastle();
            }
            _loc3_.nodeView = _loc4_;
            _loc4_.info = _loc3_;
            _loc4_.filter = _filter;
            _loc4_.x = _loc3_.x;
            _loc4_.y = _loc3_.y;
            addChild(_loc4_);
            _buildList[_loc3_.info.id] = _loc4_;
            if(_loc3_.info.occupyPlayerId == playerInfo.userId)
            {
               NotificationManager.instance.dispatchEvent(new OuterCityEvent("OUTERCITY_ADD_DENSEFOG_BY_BUILD",_loc3_));
            }
            _loc5_++;
         }
         outSceneMovies();
      }
      
      private function __initCurrentWildLandHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         for each(var _loc3_:WildLand in _loc2_)
         {
            if(_loc3_.info.types != 21)
            {
               addWildLand(_loc3_);
            }
         }
         outSceneMovies();
      }
      
      private function __removeNodeHandler(param1:OuterCityEvent) : void
      {
         var _loc3_:MapPhysicsBase = null;
         var _loc2_:WildLand = param1.data as WildLand;
         if(_loc2_)
         {
            _loc3_ = _loc2_.nodeView as MapPhysicsBase;
            if(_loc3_)
            {
               if(_loc3_.parent)
               {
                  _loc3_.parent.removeChild(_loc3_);
               }
               _loc3_.dispose();
            }
            _loc3_ = null;
            delete _buildList[_loc2_.info.id];
         }
      }
      
      private function __removeCastleHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:MapPhysicsCastle = null;
         var _loc3_:BaseCastle = param1.data as BaseCastle;
         if(_loc3_)
         {
            _loc2_ = _loc3_.nodeView as MapPhysicsCastle;
            if(_loc2_)
            {
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               _loc2_.dispose();
            }
            _loc2_ = null;
            delete _buildList[_loc3_.info.id];
         }
      }
      
      private function addWildLand(param1:WildLand) : void
      {
         param1.loadTime = getTimer();
         var _loc2_:Boolean = true;
         if(param1.nodeView)
         {
            if(param1.nodeView is OuterCityNpcView)
            {
               (param1.nodeView as OuterCityNpcView).dispose();
               param1.nodeView = null;
            }
            else
            {
               param1.nodeView["info"] = param1;
               _loc2_ = false;
            }
         }
         if(_loc2_ && param1.info.state == 1 || param1.info.state == 4)
         {
            addNewWildland(param1);
         }
      }
      
      private function addNewWildland(param1:WildLand) : void
      {
         var _loc2_:MapPhysicsBase = param1.nodeView as MapPhysicsBase;
         if(_loc2_)
         {
            return;
         }
         switch(int(param1.info.types) - 20)
         {
            case 0:
               _loc2_ = new MapPhysicsField();
               _loc2_.info = param1;
               break;
            case 1:
               return;
            case 2:
               _loc2_ = new MapPhysicsTreasure();
               _loc2_.info = param1;
               break;
            default:
               throw new Error("sdfsd" + param1.info.types);
         }
         _loc2_.filter = _filter;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         param1.nodeView = _loc2_;
         addChild(_loc2_);
         _buildList[param1.info.id] = _loc2_;
      }
      
      public function outSceneMovies() : void
      {
         this.dispatchEvent(new OuterCityEvent("DRAG_SCENE_END",_model.allWildLand));
         this.dispatchEvent(new OuterCityEvent("DRAG_SCENE_END",_model.allCastles));
      }
      
      public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         if(_model)
         {
            _model.removeEventListener("currentWildLand",__initCurrentWildLandHandler);
            _model.removeEventListener("currentCastles",__initCurrentCastlesHandler);
            _model.removeEventListener("currentConfigChange",__moviesHandler);
            _model.removeEventListener("REMOVE_NODE_MOVIE",__removeNodeHandler);
            _model.removeEventListener("REMOVE_CASTLE",__removeCastleHandler);
            disposeNode(_model.allCastles);
            disposeNode(_model.allWildLand);
         }
         _filter = null;
         _model = null;
         for each(var _loc1_:MapPhysicsBase in _buildList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _buildList = null;
         PhysicsMenu.getInstance().dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function disposeNode(param1:Dictionary) : void
      {
         for each(var _loc2_:Dictionary in param1)
         {
            for each(var _loc3_:MapPhysics in _loc2_)
            {
               if(_loc3_ && _loc3_.nodeView)
               {
                  _loc3_.nodeView["dispose"]();
               }
               _loc3_ = null;
            }
         }
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_ is MapPhysicsBase)
         {
            return _loc2_.mouseClickHandler(param1);
         }
         var _loc3_:MapPhysicsBase = param1.target as MapPhysicsBase;
         if(_loc3_)
         {
            if(!_loc3_.mouseEnabled)
            {
               return false;
            }
            if(_loc3_.mouseClickHandler(param1))
            {
               return true;
            }
         }
         for each(_loc3_ in _buildList)
         {
            if(!_loc3_.mouseEnabled)
            {
               return false;
            }
            if(_loc3_.mouseClickHandler(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseOverHandler(param1);
         }
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseOutHandler(param1);
         }
         return false;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

