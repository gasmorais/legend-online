package map.internals.view.physics
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import map.internals.constant.MapGlobal;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import map.internals.event.OuterCityEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.interfaces.ISelectMovie;
   import map.internals.utils.QTree;
   import yishi.interfaces.IBuildingFilter;
   
   public class MapPhysicsBase extends Component implements IBaseMouseEvent, IManualTipTargetSize, ISelectMovie
   {
      
      private static const randomFrame:String = "randomFrame";
      
      protected var _info:MapPhysics;
      
      private var _filter:IBuildingFilter;
      
      private var _url:String;
      
      private var _movieContainer:Sprite;
      
      protected var _movie:MovieClip;
      
      protected var _isDispose:Boolean;
      
      private var _frame:Object;
      
      public var gotoAndPlayCall:Function;
      
      protected var _isPlaying:Boolean = true;
      
      private var _color:ColorTransform;
      
      public var qtree:QTree;
      
      public function MapPhysicsBase()
      {
         super();
         _movieContainer = new Sprite();
         addChild(_movieContainer);
         gotoAndPlayCall = $gotoAndPlay;
         mouseChildren = false;
         scrollRect = null;
         _isDispose = false;
         addEvent();
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      protected function initView() : void
      {
      }
      
      public function set filter(param1:IBuildingFilter) : void
      {
         _filter = param1;
      }
      
      public function get filter() : IBuildingFilter
      {
         return _filter;
      }
      
      public function set info(param1:MapPhysics) : void
      {
         if(_info)
         {
            _info.removeEventListener("UPDATA_MAP_PHYSICS",__updateMapPhysicsHandler);
            _info.removeEventListener("DANNAY",__onDannayHandler);
         }
         _info = param1;
         updateView();
         if(_info)
         {
            _info.addEventListener("UPDATA_MAP_PHYSICS",__updateMapPhysicsHandler);
            _info.addEventListener("DANNAY",__onDannayHandler);
         }
      }
      
      private function __updateMapPhysicsHandler(param1:OuterCityEvent) : void
      {
         updateView();
      }
      
      protected function __onDannayHandler(param1:PhysicsEvent) : void
      {
      }
      
      protected function updateView() : void
      {
         var _loc1_:int = int(_info.info.state);
         if(_loc1_ == 1 || _loc1_ == 16 || _loc1_ == 17)
         {
            initView();
            setNomalView();
         }
         else if(_loc1_ == 4)
         {
            initView();
            setFireView();
         }
         else if(_loc1_ == 0)
         {
            setClearView();
         }
         else if(_loc1_ == 8 || _loc1_ == 9)
         {
            setHideView();
         }
      }
      
      protected function setHideView() : void
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
         var _loc1_:String = resourcesPath;
         if(!_loc1_)
         {
            _url = _loc1_;
            addNetMovieClip(null,null);
            layouCallBack();
            return;
         }
         if(_loc1_ == _url)
         {
            _url = _loc1_;
            addNetMovieClip(null,_movie);
            return;
         }
         _url = _loc1_;
         LoaderManagerII.instance.load(_loc1_,2,5,addNetMovieClip);
      }
      
      protected function get resourcesPath() : String
      {
         throw new Error("override resourcesPath()");
      }
      
      protected function addNetMovieClip(param1:LoaderInfo, param2:Object) : void
      {
         if(_isDispose)
         {
            ObjectUtils.disposeObject(param2);
            return;
         }
         if(param2 != _movie)
         {
            removeNetMovieClip();
         }
         if(!param2)
         {
            return;
         }
         _movie = param2 as MovieClip;
         if(gotoAndPlayCall != null)
         {
            if(_frame)
            {
               gotoAndPlayCall(_frame);
            }
            else
            {
               gotoAndPlayCall("randomFrame");
            }
         }
         _movieContainer.addChild(_movie);
         if(_movie.pos)
         {
            startPoint = new Point(_movie.pos.x - _movie.width / 4,_movie.pos.y);
         }
         if(!_isPlaying)
         {
            isPlaying = false;
         }
         layouCallBack();
      }
      
      public function get movie() : Sprite
      {
         return _movieContainer;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         _isPlaying = param1;
         if(_movie)
         {
            if(param1)
            {
               _movie.play();
               _loc9_ = _loc5_ = _movie.numChildren - 1;
               while(_loc9_ >= 0)
               {
                  _loc2_ = _movie.getChildAt(_loc9_) as MovieClip;
                  if(_loc2_)
                  {
                     _loc2_.play();
                  }
                  _loc9_--;
               }
               _movieContainer.addChild(_movie);
               _loc6_ = 0;
               while(_loc6_ < this.numChildren)
               {
                  _loc3_ = this.getChildAt(_loc6_);
                  if(_loc3_ is MovieClip)
                  {
                     _loc3_.play();
                  }
                  _loc6_++;
               }
            }
            else
            {
               _movie.stop();
               _loc4_ = _loc5_ = _movie.numChildren - 1;
               while(_loc4_ >= 0)
               {
                  _loc2_ = _movie.getChildAt(_loc4_) as MovieClip;
                  if(_loc2_)
                  {
                     _loc2_.stop();
                  }
                  _loc4_--;
               }
               if(_movie.parent)
               {
                  _movie.parent.removeChild(_movie);
               }
               _loc7_ = 0;
               while(_loc7_ < this.numChildren)
               {
                  _loc8_ = this.getChildAt(_loc7_);
                  if(_loc8_ is MovieClip)
                  {
                     _loc8_.stop();
                  }
                  _loc7_++;
               }
            }
         }
      }
      
      public function $gotoAndPlay(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         _frame = param1;
         if(_movie)
         {
            _loc2_ = _movie.currentLabels;
            if(param1 is int)
            {
               _movie.gotoAndPlay(param1);
               return;
            }
            if(param1 == "randomFrame")
            {
               if(_loc2_.length > 1)
               {
                  _movie.gotoAndPlay(1);
               }
               else
               {
                  _loc3_ = Math.random() * _movie.totalFrames;
                  _movie.gotoAndPlay(_loc3_);
               }
               return;
            }
            if(param1 is String && (param1 as String).indexOf("state") != -1)
            {
               for each(var _loc4_:FrameLabel in _loc2_)
               {
                  if(_loc4_.name == param1)
                  {
                     _movie.gotoAndPlay(param1);
                     break;
                  }
               }
            }
            else
            {
               _movie.gotoAndPlay(1);
            }
         }
      }
      
      protected function layouCallBack() : void
      {
         if(isRemoveStage)
         {
            return;
         }
      }
      
      public function get moviePos() : MovieClip
      {
         if(!_movie)
         {
            return null;
         }
         return _movie.pos;
      }
      
      public function get hitPoint() : Point
      {
         var _loc1_:Point = new Point();
         if(_movie)
         {
            if(_movie.hit)
            {
               _loc1_.x = _movie.hit.x;
               _loc1_.y = _movie.hit.y;
            }
            else
            {
               _loc1_.x = 0;
               _loc1_.y = -movie.height / 2;
            }
         }
         return _loc1_;
      }
      
      public function get info() : MapPhysics
      {
         return _info;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         if(_movie && _filter != null)
         {
            _filter.setLightFilter(_movie);
         }
         return true;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(_movie && _filter != null)
         {
            _filter.setNormalFilter(_movie);
         }
         return true;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      protected function get isRemoveStage() : Boolean
      {
         if(!moviePos || _isDispose)
         {
            return true;
         }
         return false;
      }
      
      private function removeNetMovieClip() : void
      {
         if(_movie)
         {
            _movie.stop();
            if(_movie.parent)
            {
               _movie.parent.removeChild(_movie);
            }
            if(_movie.loaderInfo)
            {
               _movie.loaderInfo.loader.unload();
               _movie.loaderInfo.loader.unloadAndStop(true);
            }
            ObjectUtils.disposeViolentMc(_movie);
         }
         _movie = null;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(addNetMovieClip);
         resetSelectMovie();
         if(_movieContainer)
         {
            _movieContainer.filters = null;
         }
         super.dispose();
         if(_info)
         {
            _info.removeEventListener("UPDATA_MAP_PHYSICS",__updateMapPhysicsHandler);
            _info.removeEventListener("DANNAY",__onDannayHandler);
            _info.nodeView = null;
            if(info is CampaignNode)
            {
               info["preParent"] = null;
            }
         }
         _isDispose = true;
         removeEvent();
         removeNetMovieClip();
         _filter = null;
         _info = null;
         gotoAndPlayCall = null;
         ObjectUtils.disposeAllChildren(_movieContainer);
         ObjectUtils.disposeObject(_movieContainer);
         _movieContainer = null;
         if(this.parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get manualHeight() : Number
      {
         return 90;
      }
      
      public function get manualWidth() : Number
      {
         return 60;
      }
      
      public function get selectMovie() : DisplayObject
      {
         return _movieContainer;
      }
      
      public function beginSelectMovie() : void
      {
         _color = _movieContainer.transform.colorTransform;
      }
      
      public function resetSelectMovie() : void
      {
         if(_movieContainer)
         {
            _movieContainer.filters = null;
         }
         if(_color && _movieContainer)
         {
            _movieContainer.transform.colorTransform = _color;
         }
      }
      
      public function get getMovie() : MovieClip
      {
         return _movie;
      }
      
      public function showName(param1:Boolean) : void
      {
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         updateQTree();
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         updateQTree();
      }
      
      private function updateQTree() : void
      {
         if(!MapGlobal.qtree)
         {
            return;
         }
         if(!qtree)
         {
            qtree = MapGlobal.qtree.add(this,this.x,this.y);
         }
         else
         {
            qtree = qtree.readd(this,this.x,this.y);
         }
      }
   }
}

