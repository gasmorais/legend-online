package map.space.view.layer
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import map.internals.data.PhysicInfo;
   import map.internals.data.SpaceNode;
   import map.internals.event.OuterCityEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.view.physics.MapPhysicsBase;
   import map.internals.view.physics.PhysicsStaticView;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.view.physics.SpacePhysicsView;
   import yishi.events.NotificationEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class SpaceBuildingLayer extends Sprite
   {
      
      public static const NAME:String = "map.space.view.layer.SpaceBuildingLayer";
      
      private var _mediatorKey:String;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _items:Dictionary;
      
      private var _buttomLayer:Sprite;
      
      private var _centerLayer:Sprite;
      
      private var _topLayer:Sprite;
      
      private var _scene:BaseSceneView;
      
      private var _model:SpaceModel;
      
      private var _buildList:Array = [];
      
      public function SpaceBuildingLayer()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _model = SpaceManager.instance.model;
         _buttomLayer = new Sprite();
         _centerLayer = new Sprite();
         _topLayer = new Sprite();
         addChild(_buttomLayer);
         addChild(_centerLayer);
         addChild(_topLayer);
         _centerLayer.mouseEnabled = false;
         _topLayer.mouseChildren = _topLayer.mouseEnabled = false;
         _buttomLayer.mouseChildren = _buttomLayer.mouseEnabled = false;
         _items = new Dictionary(true);
         initNpcView(_model.mapNodesData);
      }
      
      private function initNpcView(param1:Array) : void
      {
         var _loc3_:MapPhysicsBase = null;
         for each(var _loc2_:SpaceNode in param1)
         {
            if(_loc2_.resource != 1)
            {
               _loc3_ = _items[_loc2_.info.id] as MapPhysicsBase;
               if(!_loc3_)
               {
                  _loc3_ = createNodeView(_loc2_);
               }
               _loc3_.filter = _filter;
               if(_loc2_.fixX != 0 && _loc2_.fixY != 0)
               {
                  _loc3_.x = _loc2_.fixX;
                  _loc3_.y = _loc2_.fixY;
               }
               else
               {
                  _loc3_.x = _loc2_.info.posX * 20;
                  _loc3_.y = _loc2_.info.posY * 20;
               }
               _items[_loc2_.info.id] = _loc3_;
               _loc2_.nodeView = _loc3_;
               if(_loc2_.info.names)
               {
                  _loc3_.tipData = createItemTips(_loc2_.info,_loc2_);
               }
               _centerLayer.addChild(_loc3_);
               _buildList.push(_loc3_);
               SpaceManager.instance.controller.addBuild(_loc3_);
               _loc3_.info = _loc2_;
            }
         }
         __refreshNpcVisibleHandler(null);
      }
      
      private function createNodeView(param1:SpaceNode) : MapPhysicsBase
      {
         return new SpacePhysicsView();
      }
      
      private function createItemTips(param1:PhysicInfo, param2:SpaceNode) : MultipleDictionaryInfo
      {
         var _loc3_:String = null;
         var _loc4_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         _loc4_.addItem(param1.names,null);
         if(param1.types == 42 || param1.types == 41)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.playerLevel");
            _loc4_.addItem(_loc3_,param1.grade.toString());
         }
         return _loc4_;
      }
      
      private function addMoviesByLayer(param1:Array, param2:int) : void
      {
         var _loc3_:PhysicsStaticView = null;
         var _loc5_:SpaceNode = null;
         var _loc4_:PhysicInfo = null;
         if(!param1)
         {
            return;
         }
         for each(var _loc6_:Object in param1)
         {
            _loc3_ = new PhysicsStaticView();
            _loc5_ = new SpaceNode();
            _loc4_ = new PhysicInfo();
            _loc4_.types = 201;
            _loc4_.state = 1;
            _loc4_.names = _loc6_.url;
            _loc4_.posX = _loc6_.x / 20;
            _loc4_.posY = _loc6_.y / 20;
            _loc5_.info = _loc4_;
            _loc3_.rotation = _loc6_.rotation;
            _loc3_.info = _loc5_;
            _loc3_.x = _loc6_.x;
            _loc3_.y = _loc6_.y;
            if(_loc6_.hasOwnProperty("scaleX"))
            {
               _loc3_.scaleX = _loc6_.scaleX;
            }
            if(_loc6_.hasOwnProperty("scaleY"))
            {
               _loc3_.scaleY = _loc6_.scaleY;
            }
            _items[_loc3_.x + "," + _loc3_.y] = _loc3_;
            _loc5_.nodeView = _loc3_;
            _loc5_.layer = param2;
            _model.staticMovies.push(_loc5_);
            if(param2 == 0)
            {
               _buttomLayer.addChild(_loc3_);
            }
            else if(param2 == 2)
            {
               _topLayer.addChild(_loc3_);
            }
         }
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.space.view.layer.SpaceBuildingLayer");
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("currentNpcPos",__curNpcHandler);
         _model.addEventListener("currentConfigChange",__moviesHandler);
         this.addEventListener("addedToStage",__addToStageHandler);
         NotificationManager.instance.addEventListener("SPACE_NPC_VISIBLE",__refreshNpcVisibleHandler);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("currentNpcPos",__curNpcHandler);
         _model.removeEventListener("currentConfigChange",__moviesHandler);
         this.removeEventListener("addedToStage",__addToStageHandler);
         NotificationManager.instance.removeEventListener("SPACE_NPC_VISIBLE",__refreshNpcVisibleHandler);
      }
      
      private function __refreshNpcVisibleHandler(param1:NotificationEvent = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:SpaceNode = null;
         var _loc2_:SpacePhysicsView = null;
         var _loc7_:Array = BaseManager.instance.checkIsNeedShow();
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc6_ = int((_loc7_[_loc5_] as Array)[0]);
            _loc3_ = Boolean((_loc7_[_loc5_] as Array)[1]);
            _loc4_ = model.getMapNodeById(_loc6_);
            if(_loc4_)
            {
               _loc2_ = SpaceManager.instance.controller.getBuildView(_loc4_) as SpacePhysicsView;
               if(_loc2_)
               {
                  _loc2_.visible = _loc3_;
               }
            }
            _loc5_++;
         }
      }
      
      private function __curNpcHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         initNpcView(_loc2_);
      }
      
      private function __moviesHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_)
         {
            addMoviesByLayer(_loc2_.movies as Array,0);
            addMoviesByLayer(_loc2_.tops as Array,2);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         initRegister();
      }
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_ is SpacePhysicsView)
         {
            return _loc2_.mouseClickHandler(param1);
         }
         var _loc3_:SpacePhysicsView = param1.target as SpacePhysicsView;
         if(_loc3_)
         {
            if(!_loc3_ || !_loc3_.parent)
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
            if(!(!_loc3_ || !_loc3_.parent))
            {
               if(_loc3_.mouseClickHandler(param1))
               {
                  return true;
               }
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
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:SpacePhysicsView = param1.target as SpacePhysicsView;
         if(_loc2_)
         {
            if(!_loc2_ || !_loc2_.parent)
            {
               return false;
            }
            if(_loc2_.mouseMoveHandler(param1))
            {
               return true;
            }
         }
         for each(_loc2_ in _buildList)
         {
            if(!(!_loc2_ || !_loc2_.parent))
            {
               if(_loc2_.mouseMoveHandler(param1))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get buildList() : Array
      {
         return _buildList;
      }
      
      public function dispose() : void
      {
         var _loc1_:MapPhysicsBase = null;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         SpaceManager.instance.controller.buildList.length = 0;
         _buildList = null;
         for(var _loc2_:String in _items)
         {
            _loc1_ = _items[_loc2_];
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            _loc1_ = null;
            delete _items[_loc2_];
         }
         _items = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get center() : Sprite
      {
         return _centerLayer;
      }
      
      public function get buttom() : Sprite
      {
         return _buttomLayer;
      }
      
      public function get top() : Sprite
      {
         return _topLayer;
      }
      
      private function get model() : SpaceModel
      {
         return SpaceManager.instance.model;
      }
   }
}

