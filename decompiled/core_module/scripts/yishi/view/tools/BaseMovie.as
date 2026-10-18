package yishi.view.tools
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BaseMovie extends Sprite implements Disposeable
   {
      
      private var _movie:SimpleMovie;
      
      private var _path:String;
      
      private var _frameUpdateCallback:Function;
      
      private var _callback:Function;
      
      private var _callArgs:Array;
      
      public function BaseMovie(param1:String, param2:Function = null, param3:Array = null, param4:Function = null)
      {
         super();
         mouseEnabled = mouseChildren = false;
         _path = param1;
         _frameUpdateCallback = param4;
         _callback = param2;
         _callArgs = param3;
         LoaderManagerII.instance.load(_path,2,8,__loadCompleteHandler,null,__loadErrorHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:MovieClip = param2 as MovieClip;
         if(!_loc3_)
         {
            dispose();
            return;
         }
         _movie = new SimpleMovie(_loc3_,dispose,1,1,_frameUpdateCallback);
         addChild(_movie);
      }
      
      private function __loadErrorHandler(param1:LoaderInfo, param2:Object) : void
      {
         dispose();
      }
      
      public function play() : void
      {
         if(_movie)
         {
            _movie.play();
         }
      }
      
      public function stop() : void
      {
         if(_movie)
         {
            _movie.stop();
         }
      }
      
      public function get content() : MovieClip
      {
         return _movie ? _movie.movie : null;
      }
      
      public function dispose() : void
      {
         _movie = null;
         _path = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_callback != null)
         {
            _callback.apply(null,_callArgs);
         }
         _callback = null;
         _callArgs = null;
         _frameUpdateCallback = null;
      }
   }
}

