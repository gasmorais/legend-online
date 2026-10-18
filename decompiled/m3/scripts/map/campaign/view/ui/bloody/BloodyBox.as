package map.campaign.view.ui.bloody
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import yishi.manager.PathManager;
   
   public class BloodyBox extends Component
   {
      
      private var _index:int;
      
      public var type:int;
      
      private var _url:String;
      
      protected var _movie:MovieClip;
      
      protected var _isDispose:Boolean;
      
      public function BloodyBox(param1:int, param2:int = 2201)
      {
         _index = param1;
         type = param2;
         super();
         addBox();
         this.buttonMode = true;
      }
      
      public function get indexBox() : int
      {
         return _index;
      }
      
      private function get resourcesPath() : String
      {
         return PathManager.solveMapPhysicsBySonType(type);
      }
      
      private function addBox() : void
      {
         var _loc1_:String = resourcesPath;
         if(!_loc1_)
         {
            _url = _loc1_;
            addNetMovieClip(null,null);
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
         addChild(_movie);
         if(_movie.pos)
         {
            startPoint = new Point(_movie.pos.x - _movie.width / 4,_movie.pos.y);
         }
      }
      
      private function removeNetMovieClip() : void
      {
         if(_movie)
         {
            ObjectUtils.disposeViolentMc(_movie);
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
         }
         _movie = null;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

