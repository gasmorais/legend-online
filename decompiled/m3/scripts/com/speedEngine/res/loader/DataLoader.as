package com.speedEngine.res.loader
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.res.BaseLoader;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   use namespace basegame_internal;
   
   public class DataLoader extends BaseLoader
   {
      
      protected var _loader:URLLoader;
      
      protected var _isText:Boolean;
      
      internal var inData:*;
      
      public function DataLoader(param1:String, param2:Boolean)
      {
         super();
         _path = param1;
         _isText = param2;
      }
      
      public function get data() : *
      {
         if(inData != null)
         {
            return inData;
         }
         if(globalLink[_path] != null)
         {
            return globalLink[_path].inData;
         }
         return null;
      }
      
      override basegame_internal function load() : void
      {
         _loader = new URLLoader();
         _loader.dataFormat = _isText ? "text" : "binary";
         _loader.addEventListener("complete",__onComplete);
         _loader.addEventListener("ioError",__onError);
         _loader.addEventListener("progress",__onProgress);
         _loader.load(new URLRequest(_path));
      }
      
      protected function removeEvent() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("progress",__onProgress);
            _loader.removeEventListener("ioError",__onError);
            _loader.removeEventListener("complete",__onComplete);
         }
      }
      
      protected function __onComplete(param1:Event) : void
      {
         inData = _loader.data;
         _loader.close();
         removeEvent();
         _loader = null;
         Director.instance.dispatchEventWith(this,"loadercomplete",this);
      }
      
      public function close() : void
      {
         if(_loader)
         {
            try
            {
               _loader.close();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      override protected function destory() : void
      {
         if(inData)
         {
            if(inData is ByteArray)
            {
               inData.clear();
            }
            inData = null;
         }
         else if(globalLink[_path])
         {
            if(globalLink[_path].inData is ByteArray)
            {
               globalLink[_path].inData.clear();
            }
            globalLink[_path].inData = null;
            globalLink[_path] = null;
         }
         removeEvent();
         close();
         super.destory();
      }
   }
}

