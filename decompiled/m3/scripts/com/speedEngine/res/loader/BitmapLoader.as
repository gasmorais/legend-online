package com.speedEngine.res.loader
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.res.BaseLoader;
   import com.speedEngine.res.ResourcesManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   use namespace basegame_internal;
   
   public class BitmapLoader extends BaseLoader
   {
      
      protected var _loader:Loader;
      
      private var _bytes:ByteArray;
      
      internal var inBitmapData:BitmapData;
      
      public function BitmapLoader(param1:String)
      {
         super();
         _path = param1;
      }
      
      public function get bitmapData() : BitmapData
      {
         if(inBitmapData != null)
         {
            return inBitmapData;
         }
         if(globalLink[_path] != null && globalLink[_path].complete)
         {
            return globalLink[_path].bitmapData;
         }
         return null;
      }
      
      public function loadBytes(param1:ByteArray, param2:String) : void
      {
         _path = param2;
         _bytes = param1;
      }
      
      override basegame_internal function load() : void
      {
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__onComplete);
         _loader.contentLoaderInfo.addEventListener("ioError",__onError);
         _loader.contentLoaderInfo.addEventListener("progress",__onProgress);
         if(_path != null && _bytes == null)
         {
            _loader.load(new URLRequest(_path));
         }
         else
         {
            _loader.loadBytes(_bytes);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("progress",__onProgress);
            _loader.contentLoaderInfo.removeEventListener("ioError",__onError);
            _loader.contentLoaderInfo.removeEventListener("complete",__onComplete);
         }
      }
      
      protected function __onComplete(param1:Event) : void
      {
         if(_loader && _loader.content as Bitmap)
         {
            inBitmapData = Bitmap(_loader.content).bitmapData;
            removeEvent();
            _loader.unloadAndStop();
         }
         Director.instance.dispatchEventWith(this,"loadercomplete",this);
      }
      
      override protected function destory() : void
      {
         removeEvent();
         if(inBitmapData == null && globalLink && globalLink[_path])
         {
            if(globalLink[_path].inBitmapData)
            {
               inBitmapData = globalLink[_path].inBitmapData;
            }
            globalLink[_path].inBitmapData = null;
         }
         ResourcesManager.instance.disposeBitmapData(inBitmapData);
         if(_loader)
         {
            try
            {
               _loader.unloadAndStop();
            }
            catch(e:Error)
            {
            }
         }
         _loader = null;
         super.destory();
      }
   }
}

