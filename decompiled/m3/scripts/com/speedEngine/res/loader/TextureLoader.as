package com.speedEngine.res.loader
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.res.BaseLoader;
   import com.speedEngine.speedBones.textures.AtfData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   use namespace basegame_internal;
   
   public class TextureLoader extends BaseLoader
   {
      
      private var _loader:*;
      
      internal var _atfData:AtfData;
      
      public function TextureLoader(param1:String)
      {
         super();
         _path = param1;
      }
      
      public function get atfData() : AtfData
      {
         if(_atfData != null)
         {
            return _atfData;
         }
         if(globalLink[_path] != null)
         {
            return globalLink[_path].inTexture;
         }
         return null;
      }
      
      override basegame_internal function load() : void
      {
         if(_path.indexOf(".atf") != -1)
         {
            _loader = new URLLoader();
            _loader.dataFormat = "binary";
            _loader.addEventListener("complete",__onComplete);
            _loader.addEventListener("ioError",__onError);
            _loader.addEventListener("progress",__onProgress);
            _loader.load(new URLRequest(_path));
            return;
         }
         throw new Error("纹理格式不支持{invalid_utf8=227}??");
      }
      
      protected function __onComplete(param1:Event) : void
      {
         _atfData = new AtfData(_loader.data as ByteArray,3,path);
         __onUploadComplete();
         _loader.close();
         _loader = null;
      }
      
      protected function __onUploadComplete() : void
      {
         removeEvent();
         Director.instance.dispatchEventWith(this,"loadercomplete",this);
      }
      
      protected function removeEvent() : void
      {
         if(!_loader)
         {
            return;
         }
         if(_loader is Loader)
         {
            _loader.contentLoaderInfo.removeEventListener("progress",__onProgress);
            _loader.contentLoaderInfo.removeEventListener("ioError",__onError);
            _loader.contentLoaderInfo.removeEventListener("complete",__onComplete);
         }
         else
         {
            _loader.removeEventListener("progress",__onProgress);
            _loader.removeEventListener("ioError",__onError);
            _loader.removeEventListener("complete",__onComplete);
         }
      }
      
      override protected function destory() : void
      {
         if(_atfData)
         {
            _atfData = null;
         }
         removeEvent();
         if(_loader)
         {
            try
            {
               if(_loader is URLLoader)
               {
                  (_loader as URLLoader).close();
               }
               else if(_loader is Loader)
               {
                  (_loader as Loader).unloadAndStop();
               }
            }
            catch(e:Error)
            {
            }
         }
         super.destory();
      }
   }
}

