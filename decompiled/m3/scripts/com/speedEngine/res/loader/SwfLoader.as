package com.speedEngine.res.loader
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.res.BaseLoader;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   use namespace basegame_internal;
   
   public class SwfLoader extends BaseLoader
   {
      
      protected var _loader:Loader;
      
      protected var _urlLoader:URLLoader;
      
      public function SwfLoader(param1:String)
      {
         super();
         _path = param1;
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
      
      override basegame_internal function load() : void
      {
         _urlLoader = new URLLoader();
         _urlLoader.dataFormat = "binary";
         _urlLoader.load(new URLRequest(_path));
         _urlLoader.addEventListener("complete",onUrlComplete);
         _urlLoader.addEventListener("progress",__onProgress);
         _urlLoader.addEventListener("ioError",__onError);
      }
      
      protected function onUrlComplete(param1:Event) : void
      {
         var _loc3_:ByteArray = _urlLoader.data;
         var _loc2_:LoaderContext = new LoaderContext();
         _loc2_.applicationDomain = ApplicationDomain.currentDomain;
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__onComplete);
         try
         {
            _loc2_.allowLoadBytesCodeExecution = true;
         }
         catch(e:Error)
         {
         }
         _loader.loadBytes(_loc3_,_loc2_);
      }
      
      protected function __onComplete(param1:Event) : void
      {
         removeEvent();
         Director.instance.dispatchEventWith(this,"loadercomplete",this);
      }
      
      override protected function __onError(param1:IOErrorEvent) : void
      {
         removeEvent();
         super.__onError(param1);
      }
      
      override protected function destory() : void
      {
         removeEvent();
         if(_loader)
         {
            _loader.unloadAndStop();
         }
         _loader = null;
         super.destory();
      }
      
      public function get loader() : Loader
      {
         return _loader;
      }
   }
}

