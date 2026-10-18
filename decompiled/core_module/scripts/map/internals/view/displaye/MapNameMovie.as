package map.internals.view.displaye
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.MovieImage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import yishi.manager.PathManager;
   import yishi.view.tools.SimpleMovie;
   
   public class MapNameMovie extends Sprite
   {
      
      private var _movie:MovieImage;
      
      private var _bitmap:Bitmap;
      
      private var _backCall:Function;
      
      private var mc:Sprite;
      
      private var rect:Rectangle;
      
      public function MapNameMovie(param1:Function = null)
      {
         super();
         _backCall = param1;
         _movie = ComponentFactory.Instance.creatComponentByStylename("map.mapNameMovieAsset") as MovieImage;
      }
      
      public function loadIcon(param1:int = 100) : void
      {
         var _loc2_:String = PathManager.mapNameMoviePath(param1 > 100000 ? 100 : param1);
         LoaderManagerII.instance.load(_loc2_,2,8,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         _bitmap = param2 as Bitmap;
         if(!_bitmap)
         {
            return;
         }
         rect = _movie.getBounds(_movie);
         _movie.movie["iconContainer"].addChild(_bitmap);
         _bitmap.x = rect.width / 2 - _bitmap.width / 2 - 130;
         mc = new SimpleMovie(_movie.movie,dispose);
         mc.x = (StageReferance.stageWidth - rect.width) / 2 - rect.x;
         mc.y = (StageReferance.stageHeight - rect.height) / 2 - rect.y - 70;
         LayerManager.Instance.addToLayer(mc,2,false,false);
         StageReferance.stage.addEventListener("resize",__onResize);
      }
      
      private function __onResize(param1:Event) : void
      {
         mc.x = (StageReferance.stageWidth - rect.width) / 2 - rect.x;
         mc.y = (StageReferance.stageHeight - rect.height) / 2 - rect.y - 70;
      }
      
      private function dispose() : void
      {
         StageReferance.stage.removeEventListener("resize",__onResize);
         if(_backCall != null)
         {
            _backCall();
         }
         _backCall = null;
         if(_movie)
         {
            if(_movie.parent)
            {
               _movie.parent.removeChild(_movie);
            }
            if(_movie.movie)
            {
               _movie.movie.stop();
            }
            _movie.dispose();
         }
         _movie = null;
         if(_bitmap)
         {
            if(_bitmap.bitmapData)
            {
               _bitmap.bitmapData.dispose();
            }
            if(_bitmap.parent)
            {
               _bitmap.parent.removeChild(_bitmap);
            }
         }
         _bitmap = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

