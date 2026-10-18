package stage3drender
{
   import flash.utils.Dictionary;
   import map.internals.data.PhysicInfo;
   import map.internals.data.SpaceNode;
   import map.internals.event.OuterCityEvent;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import stage3drender.nodes.MapNodeRender;
   import stage3drender.nodes.SpacePhysicsNode;
   import stage3drender.nodes.SpaceStaticNode;
   import starling.display.Sprite;
   
   public class BuildLayer extends Sprite
   {
      
      private var _bottom:Sprite;
      
      private var _center:Sprite;
      
      private var _top:Sprite;
      
      private var _model:SpaceModel;
      
      private var _items:Dictionary;
      
      private var _buildList:Array = [];
      
      public function BuildLayer()
      {
         super();
         _model = SpaceManager.instance.model;
         _items = new Dictionary(true);
         _buildList = [];
         _bottom = new Sprite();
         _center = new Sprite();
         _top = new Sprite();
         addChild(_bottom);
         _bottom.touchable = false;
         addChild(_center);
         addChild(_top);
         _top.touchable = false;
         initNpcView(_model.mapNodesData);
         addMoviesByLayer(_model.currentSceneMovies,0);
         addMoviesByLayer(_model.currentSceneTops,2);
         initEvent();
      }
      
      public function get center() : Object
      {
         return _center;
      }
      
      public function get bottom() : Object
      {
         return _bottom;
      }
      
      public function get top() : Object
      {
         return _top;
      }
      
      private function initEvent() : void
      {
         _model.addEventListener("currentNpcPos",__curNpcHandler);
         _model.addEventListener("currentConfigChange",__moviesHandler);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("currentNpcPos",__curNpcHandler);
         _model.removeEventListener("currentConfigChange",__moviesHandler);
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
      
      private function initNpcView(param1:Array) : void
      {
         var _loc3_:MapNodeRender = null;
         for each(var _loc2_:SpaceNode in param1)
         {
            if(_loc2_.resource != 1)
            {
               if(_loc2_.info.types != 40)
               {
                  _loc3_ = _items[_loc2_.info.id] as MapNodeRender;
                  if(!_loc3_)
                  {
                     _loc3_ = createNodeView(_loc2_);
                  }
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
                  _center.addChild(_loc3_);
                  _buildList.push(_loc3_);
                  SpaceManager.instance.controller.addBuild(_loc3_);
                  _loc3_.info = _loc2_;
               }
            }
         }
      }
      
      private function addMoviesByLayer(param1:Array, param2:int) : void
      {
         var _loc3_:SpaceStaticNode = null;
         var _loc5_:SpaceNode = null;
         var _loc4_:PhysicInfo = null;
         if(!param1)
         {
            return;
         }
         var _loc6_:int = 0;
         for each(var _loc7_:Object in param1)
         {
            _loc3_ = new SpaceStaticNode();
            _loc5_ = new SpaceNode();
            _loc4_ = new PhysicInfo();
            _loc4_.types = 201;
            _loc4_.state = 1;
            _loc4_.names = _loc7_.url;
            _loc4_.posX = _loc7_.x / 20;
            _loc4_.posY = _loc7_.y / 20;
            _loc5_.info = _loc4_;
            _loc3_.rotation = _loc7_.rotation;
            _loc3_.info = _loc5_;
            _loc3_.x = _loc7_.x;
            _loc3_.y = _loc7_.y;
            _loc3_.scaleX = _loc7_.scaleX;
            _loc3_.scaleY = _loc7_.scaleY;
            _loc5_.layer = param2;
            _items[_loc3_.x + "," + _loc3_.y] = _loc3_;
            _model.staticMovies.push(_loc5_);
            SpaceManager.instance.controller.addBuild(_loc3_);
            if(param2 == 0)
            {
               _bottom.addChild(_loc3_);
            }
            else if(param2 == 2)
            {
               _top.addChild(_loc3_);
            }
         }
      }
      
      private function createNodeView(param1:SpaceNode) : MapNodeRender
      {
         return new SpacePhysicsNode();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _model = null;
         _buildList = null;
         _items = null;
         for each(var _loc1_:MapNodeRender in SpaceManager.instance.controller.buildList)
         {
            _loc1_.dispose();
         }
         SpaceManager.instance.controller.buildList.length = 0;
         super.dispose();
      }
   }
}

