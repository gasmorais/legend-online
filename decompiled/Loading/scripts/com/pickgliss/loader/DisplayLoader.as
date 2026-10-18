package com.pickgliss.loader
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.loaderii.LoaderEventII;
   import flash.display.AVM1Movie;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class DisplayLoader extends EventDispatcher
   {
      
      private static var _isDebug:Boolean = false;
      
      private static var _isOldres:Boolean = false;
      
      public static var Context:LoaderContext;
      
      private static var _tempContext:LoaderContext;
      
      private static var _tempContainer:Sprite = new Sprite();
      
      protected var _displayLoader:Loader;
      
      protected var _info:LoaderInfo;
      
      private var _currDomain:ApplicationDomain;
      
      public function DisplayLoader()
      {
         super();
         _displayLoader = new Loader();
         _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
         _displayLoader.contentLoaderInfo.addEventListener("ioError",__ioErrorHandler);
      }
      
      public static function get isDebug() : Boolean
      {
         return _isDebug;
      }
      
      public static function set isDebug(param1:Boolean) : void
      {
         _isDebug = param1;
      }
      
      public static function get isOldres() : Boolean
      {
         return _isOldres;
      }
      
      public static function set isOldres(param1:Boolean) : void
      {
         _isOldres = param1;
      }
      
      public function get info() : LoaderInfo
      {
         return _info;
      }
      
      public function loadFromBytes(param1:ByteArray, param2:LoaderInfo) : void
      {
         _info = param2;
         param1.position = 0;
         _currDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         var _loc3_:LoaderContext = new LoaderContext(false,_currDomain);
         if(DisplayLoader.isDebug)
         {
            _loc3_.allowCodeImport = true;
         }
         _displayLoader.loadBytes(param1,_loc3_);
      }
      
      private function __ioErrorHandler(param1:IOErrorEvent) : void
      {
         dispatchEvent(new LoaderEventII("complete",info,null));
      }
      
      protected function __onContentLoadComplete(param1:Event) : void
      {
         var _loc2_:AVM1Movie = null;
         var _loc3_:DisplayObject = _displayLoader.content;
         if(_displayLoader.content is AVM1Movie)
         {
            _loc2_ = _displayLoader.content as AVM1Movie;
            if(_loc2_.parent)
            {
               _loc3_ = new MovieClip();
               MovieClip(_loc3_).addChild(_loc2_.parent);
            }
            else
            {
               _loc3_ = null;
            }
         }
         dispatchEvent(new LoaderEventII("complete",info,_loc3_));
      }
      
      public function get content() : *
      {
         if(_displayLoader.content is MovieClip)
         {
            _displayLoader.content["biaoji"] = info.url;
            return _displayLoader.content;
         }
         if(_displayLoader.content is Bitmap)
         {
            return (_displayLoader.content as Bitmap).bitmapData;
         }
      }
      
      public function dispose() : void
      {
         if(_displayLoader && _displayLoader.contentLoaderInfo)
         {
            _displayLoader.contentLoaderInfo.removeEventListener("complete",__onContentLoadComplete);
            _displayLoader.contentLoaderInfo.removeEventListener("ioError",__ioErrorHandler);
         }
         _displayLoader = null;
         _currDomain = null;
         _info = null;
      }
   }
}

