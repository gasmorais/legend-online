package stage3drender.nodes
{
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.geom.Point;
   import map.internals.data.MapPhysics;
   import map.internals.event.OuterCityEvent;
   import starling.display.Sprite;
   
   public class MapNodeRender extends Sprite
   {
      
      protected var _info:MapPhysics;
      
      protected var _url:String;
      
      protected var _isDispose:Boolean;
      
      protected var _movieContainer:Sprite;
      
      public var isPlaying:Boolean = true;
      
      public function MapNodeRender()
      {
         super();
         _movieContainer = new Sprite();
         addChild(_movieContainer);
         initContainer();
      }
      
      protected function initContainer() : void
      {
      }
      
      public function get getMovie() : Object
      {
         return _movieContainer;
      }
      
      public function get info() : MapPhysics
      {
         return _info;
      }
      
      public function set info(param1:MapPhysics) : void
      {
         if(_info)
         {
            _info.removeEventListener("UPDATA_MAP_PHYSICS",__updateMapPhysicsHandler);
         }
         _info = param1;
         initView();
         if(_info)
         {
            _info.addEventListener("UPDATA_MAP_PHYSICS",__updateMapPhysicsHandler);
         }
      }
      
      private function __updateMapPhysicsHandler(param1:OuterCityEvent) : void
      {
         initView();
      }
      
      protected function initView() : void
      {
         var _loc1_:int = int(_info.info.state);
         if(_loc1_ == 1 || _loc1_ == 16 || _loc1_ == 17)
         {
            updateView();
            setNomalView();
         }
         else if(_loc1_ == 4)
         {
            updateView();
            setFireView();
         }
         else if(_loc1_ == 0)
         {
            setClearView();
         }
      }
      
      protected function updateView() : void
      {
      }
      
      protected function setFireView() : void
      {
         setSwf();
      }
      
      protected function setNomalView() : void
      {
         setSwf();
      }
      
      protected function setClearView() : void
      {
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function setSwf() : void
      {
      }
      
      protected function addNetMovieClip(param1:LoaderInfo, param2:Object) : void
      {
      }
      
      protected function get resourcesPath() : String
      {
         throw new Error("override resourcesPath()");
      }
      
      public function getPointIsHitable(param1:Point) : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         _isDispose = true;
         super.dispose();
      }
   }
}

